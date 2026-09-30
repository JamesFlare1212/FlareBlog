---
title: 修改小米 AX9000 的风扇温控策略并实现自动调速
subtitle:
date: 2026-09-29T18:00:00-04:00
slug: ax9000-fan-control
draft: false
author:
  name: James
  link: https://www.jamesflare.com
  email:
  avatar: /site-logo.avif
description: 本文介绍小米 AX9000 原厂固件下的风扇调速原理，通过六路温度计算目标档位，并提供支持开机启动、动态配置和恢复原厂温控的一键脚本。
keywords: ["小米 AX9000", "风扇", "温控", "PWM", "SSH", "xmir-patcher"]
license:
comment: true
weight: 0
tags:
  - 小米
  - 路由器
  - Linux
categories:
  - 教程
collections:
hidden_from_home_page: false
hidden_from_search: false
hidden_from_feed: false
hidden_from_related: false
summary: 本文介绍小米 AX9000 原厂固件下的风扇调速原理，通过六路温度计算目标档位，并提供支持开机启动、动态配置和恢复原厂温控的一键脚本。
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

## 前言

小米 AX9000 自带一个散热风扇，原厂默认触发阈值为104度，不知道怎么想的，风扇几乎是不会工作的。如果想让风扇按照自己设定的温度调速，可以接管原厂的风扇控制，读取温度后直接写入 PWM 节点。

我已经在自己的 AX9000 上实测过本文使用的温控策略和硬件接口。这篇文章讲一下它的修改原理，再给出一个独立的一键安装脚本，方便调整温度阈值、查看运行状态和恢复原厂温控。

## 前置准备

首先需要获取路由器的 SSH 连接。我使用的是 [xmir-patcher](https://github.com/openwrt-xiaomi/xmir-patcher)，按照项目说明完成 SSH 开启，然后用 `root` 登录路由器。

{{< gh-repo-card repo="openwrt-xiaomi/xmir-patcher" >}}

```bash
ssh root@192.168.31.1
```

这里的 IP 要换成你自己的路由器地址。后面除上传文件外，所有命令都在路由器的 SSH 终端中执行。

本文针对 AX9000 的原厂固件，使用固件自带的 `thermaltool` 和 `procd`。先确认风扇节点存在：

```bash
ls /sys/devices/platform/soc/78ba000.i2c/i2c-1/1-002f/
```

我们需要其中的 `pwm1` 和 `fan1_input`。安装脚本会检查这两个节点、六路温度和服务管理接口，检查通过后才安装。刷入其它固件后，节点路径和温度工具可能不同，不能直接套用。

如果已经安装过其它温控脚本，先停用并恢复它修改过的原厂服务，再安装本文的服务，避免两个程序同时调速。安装脚本会检查 `mobile_accel` 中常见的自定义温控内容；它不会替你重建已经被其它脚本修改的文件。

## 修改原理

### 读取六路温度

这套策略使用三路 thermal zone 和三路无线接口的温度。配置文件中的顺序与下表一致。

| 配置行 | 温度来源 | 高温阈值 | 低温参考值 |
| --- | --- | --- | --- |
| 1 | `thermal_zone4/temp` | 52°C | 38°C |
| 2 | `thermal_zone5/temp` | 53°C | 39°C |
| 3 | `thermal_zone6/temp` | 53°C | 39°C |
| 4 | `thermaltool -i wifi0 -get` | 61°C | 47°C |
| 5 | `thermaltool -i wifi1 -get` | 61°C | 47°C |
| 6 | `thermaltool -i wifi2 -get` | 61°C | 47°C |

前三路的完整目录是 `/sys/devices/virtual/thermal/`。例如，可以这样查看第一路：

```bash
cat /sys/devices/virtual/thermal/thermal_zone4/temp
thermaltool -i wifi0 -get
```

脚本将读数统一为摄氏度整数。如果节点返回的是毫摄氏度，例如 `45000`，就先除以 `1000` 得到 `45`。无线温度沿用本文固件的输出格式，读取包含 `temp` 的行中的第三列，并去掉逗号。

这里按读取接口编号称呼各路温度，不把 `thermal_zone4` 到 `thermal_zone6` 直接当成某个芯片的名称；具体对应关系要看固件。

### 从温度计算风扇档位

风扇的逻辑档位范围是 `0` 到 `134`。`0` 表示停转，`134` 是这套策略使用的最高档。它不是 RPM，也不代表 PWM 接口的硬件最大值。

先把六路当前温度、高温阈值和低温参考值分别求和：

```text
T = 六路当前温度之和
H = 六路高温阈值之和
L = 六路低温参考值之和 - 6

斜率 = 134 / (H - L)，保留三位小数
目标档位 = 斜率 × (T - L)，取整数部分
```

计算结果会限制在 `0` 到 `134` 之间。默认配置下，`H = 341`，`L = 251`，斜率约为 `1.489`。如果六路温度依次是 `45、46、46、54、54、55`，总和为 `300`，目标档位就是 `72`。

除此之外，还有一个单路高温判断：**只要任意一路达到自己的高温阈值，就将目标档位设为 `134`**。这样，即使其余几路温度较低，也不会因为总和不高而忽略某一路的高温。

低温参考值用于确定调速曲线的起点，并不是每一路独立的停转温度。这套算法也不是高温开启、低温关闭的迟滞开关。例如，六路温度都恰好等于默认低温参考值时，总和是 `257`，目标档位仍然约为 `8`。

### 写入 PWM 并平滑调速

逻辑档位需要转换后才能写入 `pwm1`：

```text
档位 = 0：写入 PWM 0
档位 > 0：写入 PWM（档位 + 30）
```

例如，`72` 档对应 PWM `102`，`134` 档对应 PWM `164`。实际转速从 `fan1_input` 读取，两者不能当成同一个数值。

温控循环每秒执行一次。在自动模式下，当前档位每次只向目标档位靠近一档，减少温度波动引起的转速突变。单路达到高温阈值时，同样遵循这个过程：改变的是目标档位，当前档位仍逐步上升。从 `0` 升到 `134` 需要约 134 秒。

如果六路温度无法完整读取，脚本会直接写入 PWM `164`，并在日志中标记 `sensor-error`。这个异常处理不经过缓慢升档。

### 接管原厂温控

自定义程序和原厂温控同时写 `pwm1`，会导致转速互相覆盖。因此，安装时需要删除 root 定时任务中包含 `mitempcontrol` 的条目，并处理 `statisticsservice` 中与温控注册或 PWM 写入有关的 `echo` 行。

本文脚本只删除 `statisticsservice` 中同时包含 `echo` 和 `tempcontrol` 或 `pwm1` 的行，其余输出保留。服务每次启动时，还会结束进程列表中已有的原厂 `tempcontrol` 进程。这里针对的是本文的原厂服务布局；如果你的固件通过其它服务重新拉起温控，需要先确认那个启动入口。

新的温控程序放在 `/usr/sbin/ax9000-fan`，启动文件是 `/etc/init.d/ax9000-fan`。它通过 [procd 的 command 和 respawn 接口](https://github.com/openwrt/openwrt/blob/main/package/system/procd/files/procd.sh)运行和管理，开启自启动后，重启路由器也会启动温控循环。

## 一键安装

完整脚本可以在这里下载。它使用路由器的 `/bin/sh`，不需要安装 Bash 或 Python。

{{< link href="ax9000-fan.sh" content="ax9000-fan.sh" title="下载 AX9000 风扇温控一键脚本" download="ax9000-fan.sh" card=true >}}

在路由器的 SSH 终端中执行：

```bash
curl -fL https://www.jamesflare.com/zh-cn/ax9000-fan-control/ax9000-fan.sh -o /tmp/ax9000-fan.sh && sh /tmp/ax9000-fan.sh install
```

如果路由器没有 `curl`，也可以先在电脑上下载脚本，再从电脑上传：

```bash
scp -O ax9000-fan.sh root@192.168.31.1:/tmp/ax9000-fan.sh
```

`-O` 用来使用传统 SCP 协议，适合没有 SFTP 服务的路由器。上传后，回到路由器的 SSH 终端执行：

```bash
sh /tmp/ax9000-fan.sh install
```

安装脚本会保存首次安装前的 `statisticsservice` 和 root 定时任务到 `/etc/ax9000-fan-backup/`，创建默认配置，然后启用并启动温控服务。已有的非空 `/etc/temp.conf` 会保留，重复安装也不会覆盖最初的备份。

## 修改温控配置

配置保存在 `/etc/temp.conf`，默认内容如下：

```text
52 38
53 39
53 39
61 47
61 47
61 47
手动指定档位：0
```

前六行每行两个数，分别是该路的高温阈值和低温参考值，顺序就是前面的温度来源表。高温阈值必须大于低温参考值，两个数都是摄氏度整数。空值、非数字或无效的阈值组合会使用该行的默认值。

可以直接用 `vi` 编辑：

```bash
vi /etc/temp.conf
```

也可以一次写入整个文件：

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

脚本每秒重新读取配置，保存后下一轮循环就会使用新值，不需要重启服务。降低高温阈值，会让对应温度更早触发最高目标档位；修改低温参考值则会改变整个调速曲线。建议先用默认值观察日常负载，再逐步调整。

第七行中的 `0` 表示自动调速。正整数表示固定档位，例如：

```text
手动指定档位：60
```

这会直接设置为 `60` 档，对应 PWM `90`，超过 `134` 的值会限制为 `134`。保留中文全角冒号 `：`。

> [!WARNING]
>
> 手动档位会覆盖自动温控，包括单路达到高温阈值时的最高目标档位。它适合短时比较转速和噪声，使用完后将第七行改回 `手动指定档位：0`。这里的 `0` 表示自动模式，不能用它强制风扇停转。

## 查看运行状态

查看最近一轮的状态：

```bash
cat /tmp/fan.log
```

下面是一组自动调速达到目标后的示例数据：

```text
[ 2026-09-29 18:10:00 ]
mode=auto level=72 target=72 hot=0 rpm=1800
highest_level=72 highest_rpm=1800
temperatures: 45 46 46 54 54 55
thresholds (high low x6, manual): 52 38 53 39 53 39 61 47 61 47 61 47 0
```

其中 `level` 是当前档位，`target` 是温度计算出的目标档位，`hot=1` 表示至少一路达到高温阈值，`rpm` 是风扇转速。示例中的 RPM 仅用于展示日志格式，不代表 `72` 档一定达到这个转速。

`highest_level` 和 `highest_rpm` 是本次服务运行以来的最高值，重启服务后会重新统计。日志每秒覆盖一次，保存在 `/tmp`，不会持续向闪存追加记录。

查看实际 PWM 和转速也可以直接读取节点：

```bash
cat /sys/devices/platform/soc/78ba000.i2c/i2c-1/1-002f/pwm1
cat /sys/devices/platform/soc/78ba000.i2c/i2c-1/1-002f/fan1_input
```

如果日志长时间没有更新，查看服务和错误输出：

```bash
ubus call service list '{"name":"ax9000-fan"}'
logread | tail -n 50
```

服务管理命令如下：

```bash
/etc/init.d/ax9000-fan restart
/etc/init.d/ax9000-fan stop
/etc/init.d/ax9000-fan start
```

停止服务时会将 PWM 设置为 `164`，维持散热；停止自定义服务本身不会重新启动原厂温控。

## 恢复原厂温控

在路由器上执行：

```bash
sh /usr/sbin/ax9000-fan uninstall
reboot
```

卸载操作会停止自定义服务、关闭它的自启动，并恢复首次备份的 `statisticsservice`。root 定时任务只恢复备份中包含 `mitempcontrol` 的条目，其它当前任务会保留。重启后，原厂温控按原来的启动流程运行。

备份、配置和已经停用的自定义服务文件会保留，方便检查。如果安装后还修改过 `statisticsservice`，恢复前需要自行合并那些修改，因为这里会恢复整个备份文件。备份只能还原到首次安装本文脚本时的状态。

固件升级可能覆盖服务文件，也可能改变硬件节点。升级后先重新确认温度和风扇接口，原固件的备份不要直接用于新固件。
