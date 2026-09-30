---
title: Customize Xiaomi AX9000 Fan Control with Automatic Temperature-Based Speed Adjustment
subtitle:
date: 2026-09-29T18:00:00-04:00
slug: ax9000-fan-control
draft: false
author:
  name: James
  link: https://www.jamesflare.com
  email:
  avatar: /site-logo.avif
description: This guide explains fan control on the Xiaomi AX9000 with stock firmware, calculates fan levels from six temperature readings, and provides an installation script with startup support, live configuration, and stock control restoration.
keywords: ["Xiaomi AX9000", "Fan", "Temperature Control", "PWM", "SSH", "xmir-patcher"]
license:
comment: true
weight: 0
tags:
  - Xiaomi
  - Router
  - Linux
categories:
  - Tutorials
collections:
hidden_from_home_page: false
hidden_from_search: false
hidden_from_feed: false
hidden_from_related: false
summary: This guide explains fan control on the Xiaomi AX9000 with stock firmware, calculates fan levels from six temperature readings, and provides an installation script with startup support, live configuration, and stock control restoration.
toc: true
math: false
lightgallery: false
password:
message:
repost:
  enable: false
  url:
---

<!--more-->

## Introduction

The Xiaomi AX9000 has a cooling fan, but on my stock firmware its default activation threshold is 104°C. With a threshold that high, the fan barely gets a chance to run. To make it respond to your own temperature settings, you can take over fan control, read the temperatures, and write directly to the PWM node.

I have tested the control strategy and hardware interfaces described here on my own AX9000. This article explains how the adjustment works and provides a standalone installation script for changing thresholds, checking the running state, and restoring stock fan control.

## Prerequisites

First, enable SSH access to the router. I use [xmir-patcher](https://github.com/openwrt-xiaomi/xmir-patcher). Follow the project instructions to enable SSH, then connect as `root`:

{{< gh-repo-card repo="openwrt-xiaomi/xmir-patcher" >}}

```bash
ssh root@192.168.31.1
```

Replace the IP address with your router's address. Except for uploading the script, run all subsequent commands in the router's SSH session.

This guide targets the AX9000's stock firmware and uses its built-in `thermaltool` and `procd`. First, check that the fan nodes exist:

```bash
ls /sys/devices/platform/soc/78ba000.i2c/i2c-1/1-002f/
```

We need `pwm1` and `fan1_input` in that directory. Before installing, the script checks these nodes, all six temperature readings, and the service management interface. Other firmware may use different paths or temperature tools, so these commands cannot be applied directly to every installation.

If you already have another fan control script installed, disable it and restore the stock services it changed before installing this one. This avoids two programs adjusting the fan at the same time. The installer checks `mobile_accel` for common signs of a custom temperature controller; it does not reconstruct files modified by another script.

## How the Adjustment Works

### Reading Six Temperatures

This strategy reads three thermal zones and three wireless interfaces. Their order in the configuration file matches the table below.

| Configuration line | Temperature source | High threshold | Low reference |
| --- | --- | --- | --- |
| 1 | `thermal_zone4/temp` | 52°C | 38°C |
| 2 | `thermal_zone5/temp` | 53°C | 39°C |
| 3 | `thermal_zone6/temp` | 53°C | 39°C |
| 4 | `thermaltool -i wifi0 -get` | 61°C | 47°C |
| 5 | `thermaltool -i wifi1 -get` | 61°C | 47°C |
| 6 | `thermaltool -i wifi2 -get` | 61°C | 47°C |

The first three paths are under `/sys/devices/virtual/thermal/`. For example, you can inspect a thermal zone and a wireless temperature with:

```bash
cat /sys/devices/virtual/thermal/thermal_zone4/temp
thermaltool -i wifi0 -get
```

The script converts readings to whole degrees Celsius. If a node returns millidegrees, such as `45000`, it divides the value by `1000` to obtain `45`. For wireless temperatures, it uses the output format of the firmware covered here: the third field of the line containing `temp`, with commas removed.

These readings are identified by their interface numbers. The exact hardware represented by `thermal_zone4` through `thermal_zone6` depends on the firmware, so those names should not be assumed to identify particular chips.

### Calculating the Fan Level

The logical fan level ranges from `0` to `134`. Level `0` stops the fan, while `134` is the highest level used by this strategy. These levels are neither RPM values nor the hardware maximum of the PWM interface.

First, add up the six current temperatures, high thresholds, and low references:

```text
T = sum of the six current temperatures
H = sum of the six high thresholds
L = sum of the six low references - 6

Slope = 134 / (H - L), rounded to three decimal places
Target level = integer part of Slope × (T - L)
```

The result is limited to the range `0` to `134`. With the default configuration, `H = 341`, `L = 251`, and the slope is approximately `1.489`. For temperatures of `45, 46, 46, 54, 54, 55`, the sum is `300`, giving a target level of `72`.

There is also a check for each individual reading: **if any temperature reaches its own high threshold, the target level becomes `134`**. This prevents cooler readings elsewhere from masking a hot sensor in the total.

The low references define the starting point of the speed curve. They are not separate temperatures at which each sensor stops the fan, and this algorithm is not a hysteresis switch that turns on at one threshold and off at another. For example, if all six readings equal their default low references, their sum is `257`, and the target level is still approximately `8`.

### Writing PWM and Adjusting Speed Gradually

The logical level is converted before it is written to `pwm1`:

```text
Level = 0: write PWM 0
Level > 0: write PWM (Level + 30)
```

For example, level `72` corresponds to PWM `102`, and level `134` corresponds to PWM `164`. Actual fan speed is read from `fan1_input`; the PWM value and RPM are different measurements.

The control loop runs once per second. In automatic mode, the current level moves one step toward the target on each iteration. This reduces abrupt speed changes caused by fluctuating temperatures. The same rule applies when a sensor reaches its high threshold: the target changes immediately, while the current level increases gradually. Going from level `0` to `134` takes approximately 134 seconds.

If the script cannot read all six temperatures, it writes PWM `164` immediately and records `sensor-error` in the log. This error handling bypasses the gradual increase.

### Taking Over Stock Fan Control

If both the custom program and the stock controller write to `pwm1`, they will overwrite each other's settings. Installation therefore removes root cron entries containing `mitempcontrol` and handles the `echo` lines in `statisticsservice` related to temperature control registration or PWM writes.

The script removes only lines in `statisticsservice` that contain both `echo` and either `tempcontrol` or `pwm1`, preserving other output. Whenever the new service starts, it also terminates existing stock `tempcontrol` processes found in the process list. This targets the stock service layout covered here. If your firmware restarts its controller through another service, identify that startup entry first.

The new program is installed as `/usr/sbin/ax9000-fan`, with its service script at `/etc/init.d/ax9000-fan`. It uses [procd's command and respawn interfaces](https://github.com/openwrt/openwrt/blob/main/package/system/procd/files/procd.sh) to manage the process. Once enabled, the service starts the control loop when the router boots.

## One-Command Installation

Download the complete script below. It runs with the router's `/bin/sh` and does not require Bash or Python.

{{< link href="ax9000-fan.sh" content="ax9000-fan.sh" title="Download the AX9000 fan control installation script" download="ax9000-fan.sh" card=true >}}

Run this command in the router's SSH session:

```bash
curl -fL https://www.jamesflare.com/ax9000-fan-control/ax9000-fan.sh -o /tmp/ax9000-fan.sh && sh /tmp/ax9000-fan.sh install
```

If the router does not have `curl`, download the script on your computer and upload it from there:

```bash
scp -O ax9000-fan.sh root@192.168.31.1:/tmp/ax9000-fan.sh
```

The `-O` option uses the traditional SCP protocol, which works with routers that do not provide an SFTP service. After uploading, return to the router's SSH session and run:

```bash
sh /tmp/ax9000-fan.sh install
```

The installer saves the original `statisticsservice` and root crontab in `/etc/ax9000-fan-backup/`, creates the default configuration, and enables and starts the service. It preserves an existing nonempty `/etc/temp.conf`. Reinstalling also preserves the backup made during the first installation.

## Changing the Configuration

The configuration is stored in `/etc/temp.conf`. Its default contents are:

```text
52 38
53 39
53 39
61 47
61 47
61 47
手动指定档位：0
```

Each of the first six lines contains the high threshold followed by the low reference for one reading, in the order shown in the temperature table. Both values are whole degrees Celsius, and the high threshold must be greater than the low reference. Missing values, nonnumeric values, or invalid threshold pairs fall back to that line's defaults.

Edit the file with `vi`:

```bash
vi /etc/temp.conf
```

Alternatively, write the whole file at once:

```bash
cat > /etc/temp.conf <<'EOF'
52 38
53 39
53 39
61 47
61 47
61 47
手动指定档位：0
EOF
```

The script reads the configuration every second, so saved changes take effect on the next iteration without restarting the service. Lowering a high threshold makes that reading trigger the highest target level sooner. Changing the low references changes the overall speed curve. Start with the defaults, observe normal workloads, and adjust gradually.

On the seventh line, `0` selects automatic speed control. A positive integer selects a fixed level, for example:

```text
手动指定档位：60
```

This immediately sets level `60`, corresponding to PWM `90`. Values above `134` are limited to `134`. The Chinese label means “manually specified level”; keep the line as shown, including the full-width colon `：`, to use the same configuration format as the Chinese version.

> [!WARNING]
>
> A manual level overrides automatic temperature control, including the highest target level triggered by an individual hot sensor. Use it briefly to compare fan speed and noise, then change the seventh line back to `手动指定档位：0`. Here, `0` selects automatic mode; it cannot be used to force the fan to stop.

## Checking the Running State

View the latest iteration's status:

```bash
cat /tmp/fan.log
```

Here is an example after automatic control has reached its target:

```text
[ 2026-09-29 18:10:00 ]
mode=auto level=72 target=72 hot=0 rpm=1800
highest_level=72 highest_rpm=1800
temperatures: 45 46 46 54 54 55
thresholds (high low x6, manual): 52 38 53 39 53 39 61 47 61 47 61 47 0
```

`level` is the current level, `target` is the level calculated from the temperatures, `hot=1` means at least one reading has reached its high threshold, and `rpm` is the measured fan speed. The example RPM illustrates the log format; it does not mean level `72` always produces that speed.

`highest_level` and `highest_rpm` record the highest values since the service started. Restarting the service resets them. The log is overwritten every second in `/tmp`, rather than continuously appended to flash storage.

You can also read the actual PWM and fan speed directly:

```bash
cat /sys/devices/platform/soc/78ba000.i2c/i2c-1/1-002f/pwm1
cat /sys/devices/platform/soc/78ba000.i2c/i2c-1/1-002f/fan1_input
```

If the log stops updating, inspect the service and error output:

```bash
ubus call service list '{"name":"ax9000-fan"}'
logread | tail -n 50
```

Use these commands to manage the service:

```bash
/etc/init.d/ax9000-fan restart
/etc/init.d/ax9000-fan stop
/etc/init.d/ax9000-fan start
```

Stopping the service sets PWM to `164` to maintain airflow. Stopping the custom service alone does not restart stock fan control.

## Restoring Stock Fan Control

Run these commands on the router:

```bash
sh /usr/sbin/ax9000-fan uninstall
reboot
```

Uninstalling stops the custom service, disables its automatic startup, and restores the first backup of `statisticsservice`. For root's crontab, it restores only the backed-up entries containing `mitempcontrol`, preserving other current jobs. After rebooting, stock fan control runs through its original startup sequence.

The backup, configuration, and disabled custom service files are retained for inspection. If you modified `statisticsservice` after installation, merge those changes yourself before restoring it, because restoration replaces the entire file with the backup. The backup represents the state before the first installation of this script.

Firmware upgrades may overwrite service files or change hardware nodes. After upgrading, check the temperature and fan interfaces again, and do not restore an old firmware's backup directly onto a new firmware version.
