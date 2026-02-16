---
title: "Unlocking Stellaris DLC on Steam using CreamInstaller"
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
description: This article explains how to use CreamInstaller to unlock Stellaris DLC on Steam and install DLC files.
keywords:
license:
comment: true
weight: 0
tags:
  - Stellaris
categories:
  - Tutorials
  - Sharing
collections:
hiddenFromHomePage: false
hiddenFromSearch: false
hiddenFromRss: false
hiddenFromRelated: false
summary: This article explains how to use CreamInstaller to unlock Stellaris DLC on Steam and install DLC files.
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

## Introduction

czp's blog covered using CreamInstaller to unlock DLC for Steam games in their article "Using Cozy to Buy Paradox Games DLC", but some of the information has become outdated. I'm updating it here.

Version of Stellaris at the time of writing: 4.2+

## Automated Crack

{{< gh-repo-card-container >}}
  {{< gh-repo-card repo="seuyh/stellaris-dlc-unlocker" >}}
{{< /gh-repo-card-container >}}

No need to say more - just run the tool as provided, and it will complete the CreamAPI and DLC file download work for you.

However, there's a problem - I've already purchased several DLCs on Steam, and at this point there's a bug where the launcher shows the DLCs, but when entering the game it prompts that they're not installed.

If you haven't purchased Stellaris DLCs on Steam yet, testing shows it works in one step.

## Semi-Automated Crack

This can avoid the problem I mentioned above and should be general-purpose. First, obtain

{{< gh-repo-card-container >}}
  {{< gh-repo-card repo="FroggMaster/CreamInstaller" >}}
{{< /gh-repo-card-container >}}

Afterwards, run `CreamInstaller.exe`. Select Stellaris

{{< image src="creaminstaller-scan.avif" width="680px" caption="CreamInstaller - Scan" >}}

Load and check the corresponding DLCs; recommending against checking "Use SmokeAPI" here

{{< image src="creaminstaller-load.avif" width="680px" caption="CreamInstaller - Load" >}}

 Finally, generate and install

{{< image src="creaminstaller-generate.avif" width="680px" caption="CreamInstaller - Generate" >}}

### Installing DLC Files

Download and extract

{{< link href="https://minio-lv-a.jamesflare.com/public/solaris-4.2+.zip" content="solaris-4.2+.zip" title="Download solaris-4.2+.zip" download="solaris-4.2+.zip" card=true >}}

Expect to see the following structure

{{< file-tree >}}
- name: 1. launcher
  type: dir
- name: 2. game
  type: dir
- name: dlc
  type: dir
- name: README - Instructions .txt
  type: file
{{< /file-tree >}}

Simply copy the entire dlc folder to the directory where your Stellaris game files are located (most likely in the form `SteamLibrary\steamapps\common\Stellaris`).

## Additional Notes

`solaris-4.2+.zip` is provided by `seuyh/stellaris-dlc-unlocker`. Theoretically, following its README instructions for installation is equivalent to using its automated installer. I'm just borrowing its DLC files here.

SmokeAPI was previously detected and blocked by Steam, but the developer made improvements, so it can now be "reused"; otherwise, use CreamAPI. Since it's still in testing phase, it's not recommended to use by default, but it can serve as an alternative.
