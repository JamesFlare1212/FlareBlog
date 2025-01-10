---
title: ECSE 2610 Studio 0 - Xilinx Vivado 16.2 Design Suite Installation on Ubuntu 24.04.1 LTS (Linux)
subtitle:
date: 2025-01-09T00:42:05-05:00
lastmod: 2025-01-09T00:42:05-05:00
slug: studio-0-linux-2016-2
draft: false
author:
  name: James
  link: https://www.jamesflare.com
  email:
  avatar: /site-logo.avif
description: This blog post provides a detailed guide on installing Xilinx Vivado 16.2 Design Suite on Ubuntu 24.04.1 LTS (Linux). It includes step-by-step instructions, necessary dependencies, installation troubleshooting tips, and verification steps.
keywords: ["Xilinx Vivado","Ubuntu 24.04","Installation Guide"]
license:
comment: true
weight: 0
tags:
  - ECSE 2610
  - Lab
  - Electrical Engineering
  - RPI
  - FPGA
categories:
  - Electrical Engineering
collections:
  - ECSE 2610
hiddenFromHomePage: false
hiddenFromSearch: false
hiddenFromRss: false
hiddenFromRelated: false
summary: This blog post provides a detailed guide on installing Xilinx Vivado 16.2 Design Suite on Ubuntu 24.04.1 LTS (Linux). It includes step-by-step instructions, necessary dependencies, installation troubleshooting tips, and verification steps.
resources:
  - name: featured-image
    src: featured-image.jpg
  - name: featured-image-preview
    src: featured-image-preview.jpg
toc: true
math: false
lightgallery: true
password:
message:
repost:
  enable: false
  url:

# See details front matter: https://fixit.lruihao.cn/documentation/content-management/introduction/#front-matter
---

<!--more-->

## Before Start

In [ECSE 2610 - Computer Components and Operations](https://dylanrees.github.io/coco/), we had been asked to install Xilinx Vivado 16.2 Design Suite as a part of Studio 0 assignment.

As there are no official guides on how to install Vivado for Linux users, I am going to show you how I installed that.

You will need

- Around 30GB free space and 7.43GB of them will be taken at the end
- Ubuntu 24.04.1 LTS, Other Linux OS can be used but may need extra work

## Dependencies

> [!WARNING]
>
> Fail to install these dependencies may result stucking on "Generating installed device list" during installing.

To install `libncurses5` we need to add `deb http://security.ubuntu.com/ubuntu focal-security main universe` into APT.

```bash
sudo su
echo "deb http://security.ubuntu.com/ubuntu focal-security main universe" > /etc/apt/sources.list.d/ubuntu-focal-sources.list
```

or using Software & Update to add this source

{{< image src="apt-1-view.avif" caption="Software & Update - Other Software" width=640px >}}

click `Add`, and type in `deb http://security.ubuntu.com/ubuntu focal-security main universe`.

{{< image src="apt-2-add-source.avif" caption="Software & Update - Other Software" width=640px >}}

Then, update index and install dependencies

```bash
sudo apt update
sudo apt install -y libncurses5 libcanberra-gtk-module
```

Check if dependency installed correctly

```bash
ldconfig -p | grep libncurses.so.5
```

You should get something like this

```text
libncurses.so.5 (libc6,x86-64) => /lib/x86_64-linux-gnu/libncurses.so.5
```

## Preparing

> [!NOTE]
>
> Xilinx is now a part of AMD, so we go to the AMD site instead of what the course material said. Also, the 2016.2 version's WebPACK is now under free license, so I ignored the licensing part on the [Vivado Design Suite Installation (Windows)](Vivado%20Design%20Suite%20Installation%20%28Windows%29.pdf).

First, you need to get from the [AMD website](https://www.xilinx.com/support/download/index.html/content/xilinx/en/downloadNav/vivado-design-tools/archive.html) or use my downloaded achieve. To do that, go to a path that is free enough and run

```bash
cd ~
sudo apt install -y wget
wget https://minio-lv-a.jamesflare.com/public/application/Xilinx_Vivado_SDK_2016.2_0605_1.tar.gz
```

Then, unzip the achieve file.

```bash
tar -xvzf Xilinx_Vivado_SDK_2016.2_0605_1.tar.gz
```

Then, go into the decompressed folder

```bash
cd Xilinx_Vivado_SDK_2016.2_0605_1
```

This is how it look like

```text
james@Desktop:~$ cd Xilinx_Vivado_SDK_2016.2_0605_1
james@Desktop:~/Xilinx_Vivado_SDK_2016.2_0605_1$ ls
bin   lib           msvcr110.dll  scripts  vccorlib110.dll  xsetup.exe
data  msvcp110.dll  payload       tps      xsetup
```

## Installing

The `xsetup` in `Xilinx_Vivado_SDK_2016.2_0605_1` folder is the installer for Linux. To run it, we can execute it in terminal

```bash
./xsetup
```

Sometime, it went wrong. Like `xsetup` is not executable or permission denied. Try

```bash
chmod +x xsetup
```

> [!NOTE]
>
> You can execute without `sudo`, but the installing folder can not be `opt/Xilinx`, since non root user can not write there. We will cover this later.

{{< image src="xsetup-1-intro.avif" caption="Vivado 2016.2 Installer - Welcome" width=640px >}}

Click `Continue` to skip the newer version. And it will gives you a welcome page with supported system information.

{{< image src="xsetup-2-welcome.avif" caption="Vivado 2016.2 Installer - Welcome" width=640px >}}

Ubuntu 24.04.1 is not in the list but it's fine. Click `Next`.

{{< image src="xsetup-3-agree.avif" caption="Vivado 2016.2 Installer - Accept License Agreements" width=640px >}}

Agree all there argument by ticking check boxes, then click `Next`.

{{< image src="xsetup-4-edition.avif" caption="Vivado 2016.2 Installer - Select Edition to Install" width=640px >}}

Vivado HL is now under free liense. So, just pick `Vivado HL WebPACK`. Then, click `Next`.

> HL WebPACK no longer needs a FLEX license file!
>
> [**Xilinx / AMD Downloads**](https://www.xilinx.com/support/download/index.html/content/xilinx/en/downloadNav/vivado-design-tools/archive.html)

{{< image src="xsetup-5-parts.avif" caption="Vivado 2016.2 Installer - Vivado HL WebPACK" width=640px >}}

Select the parts you need for your project. ECSE 2610 uses [Basys 3 Artix-7 FPGA Trainer Board](https://digilent.com/shop/basys-3-artix-7-fpga-trainer-board-recommended-for-introductory-users/), so I just checked Artix-7. Then, click `Next`.

{{< image src="xsetup-6-path.avif" caption="Vivado 2016.2 Installer - Select Destination Directory" width=640px >}}

We need chose a path to install Vivado 2016.2, `/opt/Xilinx` shows red is because non root user can not write there. You can change it to your user home directory. I will use `/home/james/Xilinx` where `james` is my user name.

{{< image src="xsetup-7-create-path.avif" caption="Vivado 2016.2 Installer - Select Destination Directory" width=640px >}}

Create the path as it asked. Then, click `Next`.

{{< image src="xsetup-8-summary.avif" caption="Vivado 2016.2 Installer - Installation Summary" width=640px >}}

Check the summary and click `Next`.

{{< image src="xsetup-9-installing.avif" caption="Vivado 2016.2 Installer - Installation Progress" width=640px >}}

The installation progress will begin. Sometime, it will gives an error on accessing remote resources. This is due to redirection from Xilinx to AMD. Click `OK` to ignore the warning.

{{< image src="xsetup-10-error-website.avif" caption="Vivado 2016.2 Installer - Installation Progress" width=640px >}}

Then, we are done.

{{< image src="xsetup-11-complete.avif" caption="Vivado 2016.2 Installer - Installation Progress" width=640px >}}

## Checking

Then, you can open Vivado 2016.2 though desktop shortcuts.

{{< image src="vivado-1-welcome.avif" caption="Vivado 2016.2 - Home" width=640px >}}

## Uninstall

If you want uninstall Vivado 2016.2, you can use the builtin uninstalling shortcuts. Or removing the installing directory. For example

```bash
rm -rf /home/james/Xilinx
```

Then, clean the shortcuts in `/home/james/.local/share/applications`. `james` is my user name, change it to your own.

## Troubleshooting

If you got an error, you may check the log under the installing path, for example

```bash
cat /home/james/.Xilinx/xinstall/xinstall_1736407656194.log
```

The path of log will be shown as long as you started installing with `./xsetup`. If you still can't fix the issue, you can comment me with logs for a check.

### Vivado Installation Got Stuck Says, "Generating installed devices list"

Based on the discussing on [Vivado installation got stuck says, "Generating installed devices list"](https://adaptivesupport.amd.com/s/question/0D52E00006hpQNASA2/vivado-installation-got-stuck-says-generating-installed-devices-list?language=en_US) and some more information. It's due to lack of `libncurses5` package. And Ubuntu 24.04.1 doesn't contain it, since it's an old package. You need to install it manually.

One possible solution

```bash
sudo echo "deb http://security.ubuntu.com/ubuntu focal-security main universe" > /etc/apt/sources.list.d/ubuntu-focal-sources.list
sudo apt update
sudo apt install -y libncurses5
```
