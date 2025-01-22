---
title: ECSE 2610 Studio 0 - 给 Ubuntu 24.04.1 LTS (Linux) 安装Xilinx Vivado 16.2 Design Suite
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
description: 这篇博客文章提供了在 Ubuntu 24.04.1 LTS（Linux）上安装 Xilinx Vivado 16.2 Design Suite 的详细指南。它包括逐步说明、必要的依赖项、安装故障排除提示和验证步骤。
keywords: ["Xilinx Vivado","Ubuntu 24.04","安装指南"]
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
summary: 这篇博客文章提供了在 Ubuntu 24.04.1 LTS（Linux）上安装 Xilinx Vivado 16.2 Design Suite 的详细指南。它包括逐步说明、必要的依赖项、安装故障排除提示和验证步骤。
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

## 开始前

在 [ECSE 2610 - 计算机组件与操作](https://dylanrees.github.io/coco/) 中，我们被要求作为 Studio 0 作业的一部分安装 Xilinx Vivado 16.2 Design Suite。

由于没有官方指南说明如何为 Linux 用户安装 Vivado，我将展示我是如何安装的。

你需要

- 大约 30GB 的可用空间，在最后会占用其中的 7.43GB
- Ubuntu 24.04.1 LTS，其他 Linux 操作系统也可以使用但可能需要额外的工作

## 依赖项

> [!WARNING]
>
> 安装这些依赖项失败可能会导致安装过程中卡在“正在生成已安装设备清单”这一步。

要安装 `libncurses5`，我们需要添加 `deb http://security.ubuntu.com/ubuntu focal-security main universe` 到 APT。

```bash
sudo su
echo "deb http://security.ubuntu.com/ubuntu focal-security main universe" > /etc/apt/sources.list.d/ubuntu-focal-sources.list
```

或者使用软件和更新来添加这个源

{{< image src="apt-1-view.avif" caption="软件与更新 - 其他软件" width=640px >}}

点击 `Add`，并输入 `deb http://security.ubuntu.com/ubuntu focal-security main universe`。

{{< image src="apt-2-add-source.avif" caption="软件与更新 - 其他软件" width=640px >}}

然后，更新索引和安装依赖项

```bash
sudo apt update
sudo apt install -y libncurses5 libcanberra-gtk-module
```

检查依赖项是否正确安装

```bash
ldconfig -p | grep libncurses.so.5
```

你应该得到类似这样的结果

```console
libncurses.so.5 (libc6,x86-64) => /lib/x86_64-linux-gnu/libncurses.so.5
```

## 准备工作

> [!NOTE]
>
> Xilinx 现在是 AMD 的一部分，所以我们需要去 AMD 官网而不是课程材料中提到的网站。另外，2016.2 版本的 WebPACK 现在处于免费许可下，所以我忽略了许可证部分。

首先，你需要从 [AMD 官网](https://china.xilinx.com/support/download.html/content/xilinx/zh/downloadNav/vivado-design-tools/archive.html) 或者使用我下载好的文件。为此，请进入一个足够空闲的路径并运行

```bash
cd ~
sudo apt install -y wget
wget https://minio-lv-a.jamesflare.com/public/application/Xilinx_Vivado_SDK_2016.2_0605_1.tar.gz
```

检查文件的 MD5 校验值是否等于 `0e41f991e5d89410ad5ed6d30407f379`

```bash
md5sum Xilinx_Vivado_SDK_2016.2_0605_1.tar.gz
```

如果不是，文件可能被篡改或者损坏。然后，解压文件。

```bash
tar -xvzf Xilinx_Vivado_SDK_2016.2_0605_1.tar.gz
```

接着进入解压缩的文件夹

```bash
cd Xilinx_Vivado_SDK_2016.2_0605_1
```

这看起来像这样

```console
james@Desktop:~$ cd Xilinx_Vivado_SDK_2016.2_0605_1
james@Desktop:~/Xilinx_Vivado_SDK_2016.2_0605_1$ ls
bin   lib           msvcr110.dll  scripts  vccorlib110.dll  xsetup.exe
data  msvcp110.dll  payload       tps      xsetup
```

## 安装

`Xilinx_Vivado_SDK_2016.2_0605_1` 文件夹中的 `xsetup` 是 Linux 的安装程序。要运行它，可以在终端中执行

```bash
./xsetup
```

有时会出现问题，比如 `xsetup` 不可执行或权限被拒绝。尝试

```bash
chmod +x xsetup
```

> [!NOTE]
>
> 你可以不使用 `sudo` 执行，但是安装文件夹不能是 `/opt/Xilinx`，因为普通用户没有写入权限。我们稍后会解决这个问题。

{{< image src="xsetup-1-intro.avif" caption="Vivado 2016.2 安装程序 - 欢迎界面" width=640px >}}

点击 `Continue` 继续跳过新版本提示，然后进入欢迎界面，查看支持的操作系统信息。

{{< image src="xsetup-2-welcome.avif" caption="Vivado 2016.2 安装程序 - 欢迎界面" width=640px >}}

Ubuntu 24.04.1 不在列表中，但没关系。点击 `Next`。

{{< image src="xsetup-3-agree.avif" caption="Vivado 2016.2 安装程序 - 接受许可协议" width=640px >}}

通过勾选复选框同意所有条款，然后点击 `Next`。

{{< image src="xsetup-4-edition.avif" caption="Vivado 2016.2 安装程序 - 选择要安装的版本" width=640px >}}

Vivado HL 现在处于免费许可下。所以，只需选择 `Vivado HL WebPACK`。然后点击 `Next`。

> [!NOTE]
>
> HL WebPACK 不再需要 FLEX 许可证文件！
>
> [**Xilinx / AMD 下载**](https://china.xilinx.com/support/download.html/content/xilinx/zh/downloadNav/vivado-design-tools/archive.html)

{{< image src="xsetup-5-parts.avif" caption="Vivado 2016.2 安装程序 - Vivado HL WebPACK" width=640px >}}

选择你需要的项目部分。ECSE 2610 使用 [Basys 3 Artix-7 FPGA 培训板](https://digilent.com/shop/basys-3-artix-7-fpga-trainer-board-recommended-for-introductory-users/)，所以我只选择了 Artix-7。然后点击 `Next`。

{{< image src="xsetup-6-path.avif" caption="Vivado 2016.2 安装程序 - 选择目标目录" width=640px >}}

我们需要选择一个安装 Vivado 2016.2 的路径， `/opt/Xilinx` 显示红色是因为普通用户没有写入权限。你可以将其更改为你的用户主目录。我将使用 `/home/james/Xilinx`，其中 `james` 是我的用户名。

{{< image src="xsetup-7-create-path.avif" caption="Vivado 2016.2 安装程序 - 创建目标路径" width=640px >}}

根据提示创建路径。然后点击 `Next`。

{{< image src="xsetup-8-summary.avif" caption="Vivado 2016.2 安装程序 - 安装概要" width=640px >}}

检查安装概要并点击 `Next`。

{{< image src="xsetup-9-installing.avif" caption="Vivado 2016.2 安装程序 - 安装进度" width=640px >}}

安装过程将开始。有时会提示访问远程资源失败，这是由于 Xilinx 转向 AMD 导致的重定向问题。点击 `OK` 忽略警告。

{{< image src="xsetup-10-error-website.avif" caption="Vivado 2016.2 安装程序 - 安装进度" width=640px >}}

然后安装完成。

{{< image src="xsetup-11-complete.avif" caption="Vivado 2016.2 安装程序 - 完成界面" width=640px >}}

## 检查

你可以通过桌面快捷方式打开 Vivado 2016.2。

{{< image src="vivado-1-welcome.avif" caption="Vivado 2016.2 - 主页" width=640px >}}

## 卸载

如果你想卸载 Vivado 2016.2，可以使用内置的卸载快捷方式。或者删除安装目录。例如：

```bash
rm -rf /home/james/Xilinx
```

然后清理 `/home/james/.local/share/applications` 目录中的快捷方式。 `james` 是我的用户名，请替换为你的用户名。

## 故障排除

如果你遇到错误，可以检查安装路径下的日志文件，例如：

```bash
cat /home/james/.Xilinx/xinstall/xinstall_1736407656194.log
```

只要开始安装时使用了 `./xsetup`，日志路径就会显示。如果仍然无法解决问题，请在评论中附上日志文件供我检查。

### Vivado 安装卡住提示“正在生成已安装设备清单”

根据 [Vivado 安装卡住提示, "正在生成已安装设备清单"](https://adaptivesupport.amd.com/s/question/0D52E00006hpQNASA2/vivado-installation-got-stuck-says-generating-installed-devices-list?language=en_US) 的讨论和更多信息。这是由于缺少 `libncurses5` 包导致的。Ubuntu 24.04.1 不包含该包，因为它是一个旧版本。你需要手动安装它。

一种可能的解决方案：

```bash
sudo echo "deb http://security.ubuntu.com/ubuntu focal-security main universe" > /etc/apt/sources.list.d/ubuntu-focal-sources.list
sudo apt update
sudo apt install -y libncurses5
```
