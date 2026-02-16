---
title: 使用CreamInstaller解锁Steam版群星的DLC
subtitle:
date: 2026-02-15T17:40:35-05:00
lastmod: 2026-02-15T17:40:35-05:00
slug: stellaris-dlc-unlocker
draft: false
author:
  name: James
  link: https://www.jamesflare.com
  email:
  avatar: /site-logo.avif
description: 本篇文章我们会讲解如何使用CreamInstaller解锁Steam版群星的DLC，并且安装DLC文件。
keywords:
license:
comment: true
weight: 0
tags:
  - Stellaris
categories:
  - 教程
  - 资源分享
collections:
hiddenFromHomePage: false
hiddenFromSearch: false
hiddenFromRss: false
hiddenFromRelated: false
summary: 本篇文章我们会讲解如何使用CreamInstaller解锁Steam版群星的DLC，并且安装DLC文件。
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
  enable: false
  url:

# See details front matter: https://fixit.lruihao.cn/documentation/content-management/introduction/#front-matter
---

<!--more-->

## 前言

czp's blog在文章[用凝聚力购买 P 社游戏 DLC](https://www.hiczp.com/you-xi/yong-ning-ju-li-gou-mai-p-she-you-xi-dlc.html)中讲到使用CreamInstaller可以解锁Steam游戏的DLC，但是其中的信息有一些过期，我现在完善一下。

本文撰写时的群星版本：4.2+

## 全自动破解

{{< gh-repo-card repo="seuyh/stellaris-dlc-unlocker" >}}

无需多说，直接运行它给出的工具，就可以直接完成 CreamAPI 以及 DLC 文件下载的工作。

不过有个问题就是我已经在 Steam 上买过几个 DLC 了，这时候就有 Bug 了，启动器显示有 DLC，进游戏提示没有。

如果的你还没在 Steam 上买过群星 DLC，实测是可以一步到位的。

## 半自动破解

这个可以避免我上述讲到的问题，应该是通用的。首先获取

{{< gh-repo-card repo="FroggMaster/CreamInstaller" >}}

完成后运行 `CreamInstaller.exe`。扫描选中群星

{{< image src="creaminstaller-scan.avif" width="680px" caption="CreamInstaller - Scan" >}}

加载并勾选对应DLC，这里不建议勾选使用 SmokeAPI

{{< image src="creaminstaller-load.avif" width="680px" caption="CreamInstaller - Load" >}}

最后生成并安装

{{< image src="creaminstaller-generate.avif" width="680px" caption="CreamInstaller - Generate" >}}

### 安装DLC文件

下载并解压

{{< link href="https://minio-lv-a.jamesflare.com/public/solaris-4.2+.zip" content="solaris-4.2+.zip" title="Download solaris-4.2+.zip" download="solaris-4.2+.zip" card=true >}}

不出意外你会看见这样的一个结构

{{< file-tree >}}
- name: 1. launcher
  type: dir
- name: 2. game
  type: dir
- name: dlc
  type: dir
- name: README - Инструкция .txt
  type: file
{{< /file-tree >}}

把dlc文件夹完整地复制到你群星游戏文件所在的目录下即可（大概率长这样 `SteamLibrary\steamapps\common\Stellaris`）。

## 题外话

`solaris-4.2+.zip` 就是 `seuyh/stellaris-dlc-unlocker` 提供的，理论上你按照它 README 的指引安装，这和使用它给的自动安装器是等价的。这里我只是借用一下它的DLC文件。

SmokeAPI 曾经被 Steam 检测并封锁了，后来接手的作者进行了一些改进，所以可以“重新使用”SmokeAPI，不然就用 CreamAPI。介于还在测试阶段，不建议默认使用，可以当一个备选。
