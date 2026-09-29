#!/bin/sh
# Xiaomi AX9000 stock firmware: temperature-based fan control.
# Usage: sh ax9000-fan.sh [install|run|uninstall]

CONFIG=/etc/temp.conf
FAN_DIR=/sys/devices/platform/soc/78ba000.i2c/i2c-1/1-002f
THERMAL_DIR=/sys/devices/virtual/thermal
PROGRAM=/usr/sbin/ax9000-fan
SERVICE=/etc/init.d/ax9000-fan
BACKUP=/etc/ax9000-fan-backup
MAX_LEVEL=134

die() { echo "$*" >&2; exit 1; }

read_temperatures() {
    # Accept degrees Celsius and millidegrees; reject missing/invalid data.
    for zone in 4 5 6; do
        cat "$THERMAL_DIR/thermal_zone$zone/temp" 2>/dev/null || return 1
    done
    for radio in wifi0 wifi1 wifi2; do
        thermaltool -i "$radio" -get 2>/dev/null |
            awk '/temp/ { gsub(/,/, "", $3); print $3; exit }'
    done
}

temperatures() {
    read_temperatures | awk '
        /^[0-9]+$/ {
            value = $0 + 0
            if (value >= 1000) value = int(value / 1000)
            if (value > 150) exit 1
            values[++count] = value
            next
        }
        { exit 1 }
        END {
            if (count != 6) exit 1
            for (i = 1; i <= 6; i++) printf "%d ", values[i]
            print ""
        }'
}

thresholds() {
    # The configuration is data, never shell code.
    awk '
        BEGIN {
            high[1] = 52; low[1] = 38
            high[2] = high[3] = 53; low[2] = low[3] = 39
            high[4] = high[5] = high[6] = 61
            low[4] = low[5] = low[6] = 47
            manual = 0
        }
        NR <= 6 && $1 ~ /^[0-9]+$/ && $2 ~ /^[0-9]+$/ {
            if ($1 <= 150 && $2 < $1 && length($1) <= 3 && length($2) <= 3) {
                high[NR] = $1 + 0; low[NR] = $2 + 0
            }
        }
        NR == 7 {
            split($0, parts, "：")
            gsub(/[[:space:]]/, "", parts[2])
            if (parts[2] ~ /^[0-9]+$/ && length(parts[2]) <= 3)
                manual = parts[2] + 0
        }
        END {
            for (i = 1; i <= 6; i++) printf "%d %d ", high[i], low[i]
            print manual
        }' "$CONFIG" 2>/dev/null
}

write_pwm() {
    if [ "$1" -gt 0 ]; then
        echo "$(($1 + 30))" > "$FAN_DIR/pwm1"
    else
        echo 0 > "$FAN_DIR/pwm1"
    fi
}

run_fan() {
    level=0
    highest_level=0
    highest_rpm=0
    # Keep airflow if the service is stopped or restarted.
    trap 'write_pwm "$MAX_LEVEL"; exit 0' TERM INT
    while :; do
        if samples=$(temperatures); then
            limits=$(thresholds)
            result=$(awk -v samples="$samples" -v limits="$limits" -v maximum="$MAX_LEVEL" '
                BEGIN {
                    split(samples, temp, " "); split(limits, config, " ")
                    sum = high_sum = low_sum = hot = 0
                    for (i = 1; i <= 6; i++) {
                        high = config[2*i-1]; low = config[2*i]
                        sum += temp[i]; high_sum += high; low_sum += low
                        if (temp[i] >= high) hot = 1
                    }
                    baseline = low_sum - 6
                    # Match the three-decimal slope used by this fan curve.
                    slope = sprintf("%.3f", maximum / (high_sum - baseline))
                    target = int(slope * (sum - baseline))
                    if (target < 0) target = 0
                    if (target > maximum || hot) target = maximum
                    manual = config[13]
                    if (manual > maximum) manual = maximum
                    print target, manual, hot
                }')
            set -- $result
            target=$1; manual=$2; hot=$3
            if [ "$level" -lt "$target" ]; then
                level=$((level + 1))
            elif [ "$level" -gt "$target" ]; then
                level=$((level - 1))
            fi
            # A positive manual setting overrides the automatic curve.
            [ "$manual" -gt 0 ] && level=$manual
            mode=auto
            [ "$manual" -gt 0 ] && mode=manual
        else
            # Missing sensors must not be treated as zero degrees.
            samples="unavailable"
            target=$MAX_LEVEL; level=$MAX_LEVEL; manual=0; hot=0
            mode=sensor-error
        fi
        write_pwm "$level" || die "Cannot write fan PWM."
        rpm=$(cat "$FAN_DIR/fan1_input" 2>/dev/null)
        case "$rpm" in ''|*[!0-9]*) rpm=0 ;; esac
        [ "$rpm" -gt "$highest_rpm" ] && highest_rpm=$rpm
        [ "$level" -gt "$highest_level" ] && highest_level=$level
        {
            printf '[ %s ]\n' "$(date '+%F %T')"
            printf 'mode=%s level=%s target=%s hot=%s rpm=%s\n' "$mode" "$level" "$target" "$hot" "$rpm"
            printf 'highest_level=%s highest_rpm=%s\n' "$highest_level" "$highest_rpm"
            printf 'temperatures: %s\n' "$samples"
            printf 'thresholds (high low x6, manual): %s\n' "$(thresholds)"
        } > /tmp/fan.log
        sleep 1
    done
}

install_fan() {
    set -e
    [ "$(id -u)" = 0 ] || die "Run as root."
    command -v thermaltool >/dev/null || die "thermaltool is missing."
    [ -r /etc/rc.common ] && [ -r /lib/functions/procd.sh ] || die "procd is missing."
    [ -w "$FAN_DIR/pwm1" ] && [ -r "$FAN_DIR/fan1_input" ] || die "AX9000 fan nodes are missing."
    temperatures >/dev/null || die "Cannot read all six temperature sensors."
    [ -f /etc/init.d/statisticsservice ] && [ -f /etc/crontabs/root ] || die "Stock service files are missing."
    # Do not install alongside an older controller hosted in mobile_accel.
    if grep -q 'base64\|/tmp/fan.log\|temp.conf' /etc/init.d/mobile_accel 2>/dev/null; then
        die "Restore mobile_accel from your stock backup before installing."
    fi
    mkdir -p "$BACKUP"
    if [ ! -f "$BACKUP/ready" ]; then
        cp -p /etc/init.d/statisticsservice "$BACKUP/statisticsservice"
        cp -p /etc/crontabs/root "$BACKUP/root.crontab"
        touch "$BACKUP/ready"
    fi
    if [ ! -s "$CONFIG" ]; then
        cat > "$CONFIG" <<'CONFIG_EOF'
52 38
53 39
53 39
61 47
61 47
61 47
手动指定档位：0
CONFIG_EOF
    fi
    if [ "$(readlink -f "$0")" != "$PROGRAM" ]; then
        cp "$0" "$PROGRAM"
    fi
    chmod 755 "$PROGRAM"
    cat > "$SERVICE" <<'SERVICE_EOF'
#!/bin/sh /etc/rc.common
START=99
STOP=99
USE_PROCD=1

start_service() {
    # Stop the stock controller at installation and on subsequent boots.
    for pid in $(ps | awk '/[t]empcontrol/ && !/[a]x9000-fan/ && !/[a]wk/ {print $1}'); do
        kill "$pid" 2>/dev/null || true
    done
    procd_open_instance
    procd_set_param command /bin/sh /usr/sbin/ax9000-fan run
    procd_set_param respawn 3600 5 0
    procd_set_param stderr 1
    procd_close_instance
}

stop_service() {
    echo 164 > /sys/devices/platform/soc/78ba000.i2c/i2c-1/1-002f/pwm1
}
SERVICE_EOF
    chmod 755 "$SERVICE"
    # Remove temperature-control registration/PWM writes, preserving other echoes.
    sed -i '/echo/ { /tempcontrol/d; /pwm1/d; }' /etc/init.d/statisticsservice
    sed -i '/mitempcontrol/d' /etc/crontabs/root
    /etc/init.d/cron restart
    "$SERVICE" enable
    "$SERVICE" restart
    echo "Installed. Edit $CONFIG; inspect /tmp/fan.log."
}

uninstall_fan() {
    set -e
    [ "$(id -u)" = 0 ] || die "Run as root."
    [ -f "$BACKUP/ready" ] || die "No stock backup found."
    "$SERVICE" stop
    "$SERVICE" disable
    cp -p "$BACKUP/statisticsservice" /etc/init.d/statisticsservice
    # Restore stock temperature jobs while preserving other current cron jobs.
    sed -i '/mitempcontrol/d' /etc/crontabs/root
    awk '/mitempcontrol/' "$BACKUP/root.crontab" >> /etc/crontabs/root
    /etc/init.d/cron restart
    echo "Stock files restored. Reboot to restart stock temperature control."
    echo "Configuration, backup and disabled service files have been kept."
}

case "${1:-install}" in
    install) install_fan ;;
    run) run_fan ;;
    uninstall) uninstall_fan ;;
    *) die "Usage: sh $0 [install|run|uninstall]" ;;
esac
