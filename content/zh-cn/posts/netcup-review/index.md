---
title: netcup vServer (ARM64) 基准测试和评测
subtitle:
date: 2024-03-09T22:33:19-05:00
slug: netcup-arm-review
draft: false
author:
  name: James
  link: https://www.jamesflare.com
  email:
  avatar: /site-logo.avif
description: 这篇博文评测了 netcup VPS 8000 ARM G11 服务器的性能表现。该服务器采用了基于 Ampere Altra Max 的 18 核 ARM64 CPU。文章包含了使用多种测试脚本得出的基准测试结果，并将 CPU 性能与市面上知名的处理器进行了对比。
keywords: ["netcup","VPS","ARM服务器","基准测试","Ampere Altra Max"]
license:
comment: true
weight: 0
tags:
  - VPS
  - 基准测试
  - netcup
  - ARM
categories:
  - VPS
  - 评测
hiddenFromHomePage: false
hiddenFromSearch: false
hiddenFromRss: false
hiddenFromRelated: false
summary: 这篇博文评测了 netcup VPS 8000 ARM G11 服务器的性能表现。该服务器采用了基于 Ampere Altra Max 的 18 核 ARM64 CPU。文章包含了使用多种测试脚本得出的基准测试结果，并将 CPU 性能与市面上知名的处理器进行了对比。
resources:
  - name: featured-image
    src: featured-image.jpg
  - name: featured-image-preview
    src: featured-image-preview.jpg
toc: true
math: false
lightgallery: false
password:
message:
repost:
  enable: true
  url:

# 更多 front matter 配置详见：https://fixit.lruihao.cn/documentation/content-management/introduction/#front-matter
---

<!--more-->

## 简介

[netcup GmbH](https://www.netcup.eu) 出售一些有趣的 ARM 服务器。我最近购买了 [VPS 8000 ARM G11](https://www.netcup.eu/vserver/arm-server) 版本。它配备了 18 核 ARM64 CPU，官网称其基于 Ampere Altra Max 处理器。

|产品|VPS 8000 ARM G11|
|---|---|
|虚拟化技术|KVM|
|处理器|18 核 ARM64|
|内存|64GB DDR4 ECC|
|存储空间|2048 GB SSD|
|网卡|2500 Mbit/s|
|流量|不限|

## 常规测试

[Teddysun](https://teddysun.com/444.html) 的测试脚本可以给出整体性能的概览：

```bash
wget -qO- bench.sh | bash
```

结果如下：

```text
-------------------- A Bench.sh Script By Teddysun -------------------
 Version            : v2023-10-15
 Usage              : wget -qO- bench.sh | bash
----------------------------------------------------------------------
 CPU Model          : CPU model not detected
 CPU Cores          : 18
 AES-NI             : ✓ Enabled
 VM-x/AMD-V         : ✗ Disabled
 Total Disk         : 2.0 TB (20.7 GB Used)
 Total Mem          : 62.7 GB (3.1 GB Used)
 System uptime      : 1 days, 14 hour 48 min
 Load average       : 0.25, 0.14, 0.10
 OS                 : Debian GNU/Linux 12
 Arch               : aarch64 (64 Bit)
 Kernel             : 6.6.8
 TCP CC             : bbr
 Virtualization     : KVM
 IPv4/IPv6          : ✓ Online / ✓ Online
 Organization       : AS197540 netcup GmbH
 Location           : Nürnberg / DE
 Region             : Bavaria
----------------------------------------------------------------------
 I/O Speed(1st run) : 470 MB/s
 I/O Speed(2nd run) : 673 MB/s
 I/O Speed(3rd run) : 676 MB/s
 I/O Speed(average) : 606.3 MB/s
----------------------------------------------------------------------
 Node Name        Upload Speed      Download Speed      Latency     
 Speedtest.net    174.35 Mbps       147.69 Mbps         0.29 ms     
 Los Angeles, US  626.82 Mbps       1950.34 Mbps        147.10 ms   
 Dallas, US       697.90 Mbps       2109.19 Mbps        133.37 ms   
 Montreal, CA     554.36 Mbps       904.78 Mbps         94.53 ms    
 Paris, FR        2108.91 Mbps      2321.03 Mbps        21.98 ms    
 Shanghai, CN     640.20 Mbps       1484.39 Mbps        255.22 ms   
 Hongkong, CN     5.00 Mbps         0.55 Mbps           301.56 ms   
 Mumbai, IN       1685.98 Mbps      2417.37 Mbps        116.27 ms   
 Singapore, SG    1592.12 Mbps      2572.71 Mbps        179.95 ms   
 Tokyo, JP        423.71 Mbps       1122.09 Mbps        217.83 ms   
----------------------------------------------------------------------
 Finished in        : 5 min 15 sec
 Timestamp          : 2023-12-30 03:55:03 CET
----------------------------------------------------------------------
```

## Yet-Another-Bench-Script

```bash
curl -sL yabs.sh | bash
```

结果非常详细和冗长，我把结果分成几个部分。首先，让我们看看脚本的基本信息：

```text
# ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## #
#              Yet-Another-Bench-Script              #
#                     v2023-11-30                    #
# https://github.com/masonr/yet-another-bench-script #
# ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## #

Sat Dec 30 04:16:48 AM CET 2023

ARM compatibility is considered *experimental*
```

然后是系统的基本信息：

```text
Basic System Information:
---------------------------------
Uptime     : 1 days, 15 hours, 15 minutes
Processor  : Neoverse-N1
BIOS virt-5.2  CPU @ 2.0GHz
CPU cores  : 18 @ ??? MHz
AES-NI     : ✔ Enabled
VM-x/AMD-V : ❌ Disabled
RAM        : 62.7 GiB
Swap       : 0.0 KiB
Disk       : 2.0 TiB
Distro     : Debian GNU/Linux 12 (bookworm)
Kernel     : 6.6.8
VM Type    : KVM
IPv4/IPv6  : ✔ Online / ✔ Online

IPv6 Network Information:
---------------------------------
ISP        : netcup GmbH
ASN        : AS197540 netcup GmbH
Host       : NETCUP-GMBH
Location   : Karlsruhe, Baden-Wurttemberg (BW)
Country    : Germany
```

接下来是磁盘 IO 性能测试：

```text
fio Disk Speed Tests (Mixed R/W 50/50) (Partition /dev/vda4):
---------------------------------
Block Size | 4k            (IOPS) | 64k           (IOPS)
  ------   | ---            ----  | ----           ---- 
Read       | 138.63 MB/s  (34.6k) | 261.70 MB/s   (4.0k)
Write      | 138.54 MB/s  (34.6k) | 269.48 MB/s   (4.2k)
Total      | 277.18 MB/s  (69.2k) | 531.19 MB/s   (8.2k)
           |                      |                     
Block Size | 512k          (IOPS) | 1m            (IOPS)
  ------   | ---            ----  | ----           ---- 
Read       | 298.21 MB/s    (582) | 442.51 MB/s    (432)
Write      | 323.72 MB/s    (632) | 493.71 MB/s    (482)
Total      | 621.93 MB/s   (1.2k) | 936.22 MB/s    (914)
```

然后是网络速度测试：

```text
iperf3 Network Speed Tests (IPv4):
---------------------------------
Provider        | Location (Link)           | Send Speed      | Recv Speed      | Ping           
-----           | -----                     | ----            | ----            | ----           
Clouvider       | London, UK (10G)          | 2.45 Gbits/sec  | 2.37 Gbits/sec  | 20.5 ms        
Scaleway        | Paris, FR (10G)           | 2.46 Gbits/sec  | busy            | 20.1 ms        
NovoServe       | North Holland, NL (40G)   | 2.47 Gbits/sec  | 2.38 Gbits/sec  | 9.96 ms        
Uztelecom       | Tashkent, UZ (10G)        | 1.99 Gbits/sec  | 996 Mbits/sec   | 84.2 ms        
Clouvider       | NYC, NY, US (10G)         | 2.00 Gbits/sec  | 542 Mbits/sec   | 91.6 ms        
Clouvider       | Dallas, TX, US (10G)      | 1.44 Gbits/sec  | 648 Mbits/sec   | 128 ms         
Clouvider       | Los Angeles, CA, US (10G) | 1.16 Gbits/sec  | 1.04 Gbits/sec  | 147 ms         

iperf3 Network Speed Tests (IPv6):
---------------------------------
Provider        | Location (Link)           | Send Speed      | Recv Speed      | Ping           
-----           | -----                     | ----            | ----            | ----           
Clouvider       | London, UK (10G)          | 2.44 Gbits/sec  | 2.33 Gbits/sec  | 20.5 ms        
Scaleway        | Paris, FR (10G)           | busy            | busy            | 32.2 ms        
NovoServe       | North Holland, NL (40G)   | 2.48 Gbits/sec  | 2.35 Gbits/sec  | 9.97 ms        
Uztelecom       | Tashkent, UZ (10G)        | 2.10 Gbits/sec  | 875 Mbits/sec   | 84.4 ms        
Clouvider       | NYC, NY, US (10G)         | 1.78 Gbits/sec  | 893 Mbits/sec   | 91.6 ms        
Clouvider       | Dallas, TX, US (10G)      | 1.39 Gbits/sec  | 852 Mbits/sec   | 128 ms         
Clouvider       | Los Angeles, CA, US (10G) | 1.16 Gbits/sec  | 549 Mbits/sec   | 147 ms
```

接下来是 Geekbench 6 的测试结果：

```text
Geekbench 6 Benchmark Test:
---------------------------------
Test            | Value                         
                |                               
Single Core     | 1072                          
Multi Core      | 8650                          
Full Test       | https://browser.geekbench.com/v6/cpu/4192622
```

最后，我只测试了 Geekbench 5，使用以下脚本：

```bash
curl -sL yabs.sh | bash -s -- -i -f  -n -5
```

以下是 Geekbench 5 的结果：

```text
Geekbench 5 Benchmark Test:
---------------------------------
Test            | Value                         
                |                               
Single Core     | 798                           
Multi Core      | 10975                         
Full Test       | https://browser.geekbench.com/v5/cpu/22091599
```

## 评测

现在，让我们来讨论一下测试结果。

### CPU 性能

VPS 8000 ARM G11 在 Geekbench 6 的多核得分大约为 8650 分。为了让你对这个分数有个概念，我选取了一些知名的 CPU 做对比。

|CPU|单核得分|多核得分|
|---|---|---|
|Intel Core i9-13900K|2970|20095|
|AMD Ryzen 9 7950X|2930|19224|
|Intel Core i9-12900K|2610|15428|
|AMD Ryzen 9 7940HS|2481|11741|
|AMD Ryzen 7 5800X3D|2085|10922|
|AMD Ryzen Z1 Extreme|2252|9689|
|AMD Ryzen 7 7840U|2099|8718|
|Intel Core i9-9900K|1664|7977|

我的 **Framework Laptop 13** 搭载了 **AMD Ryzen 7 7840U**，它的得分是

|CPU|单核得分|多核得分|
|---|---|---|
|AMD Ryzen 7 7840U|2256|12127|

这个差异是因为现代 CPU 有动态提升机制，可以超出基础时钟频率运行。

还有一点，我在 Geekbench 6 网站上看到了几条 [Ampere Altra Max 2800 MHz (96 核)](https://browser.geekbench.com/v6/cpu/1590435) 的记录。单核得分为 958，多核得分为 11149。

这很奇怪，我的 18 核服务器多核得分为 8650，而 Altra Max 2800 MHz (96 核) 只有 11149。我猜 Geekbench 6 网站上的 [Altra Max 2800 MHz (96 核)](https://browser.geekbench.com/v6/cpu/1590435) 记录性能表现得并不好，因为它是 ADLINK Ampere Altra 开发平台。它可能没有调教到最佳性能。