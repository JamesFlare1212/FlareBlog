---
title: ECSE 1010 概念验证 - Alpha Lab03
subtitle:
date: 2024-12-18T01:07:47-05:00
lastmod: 2024-12-18T01:07:47-05:00
slug: ecse-1010-poc-lab03
draft: false
author:
  name: James
  link: https://www.jamesflare.com
  email:
  avatar: /site-logo.avif
description: 这篇博客文章概述了一系列涉及傅里叶分析、信号重建、滤波器设计和频率处理的实验和分析，使用MATLAB及其他工具。内容包括理论概念的讨论、模拟以及实际应用。
keywords: ["傅里叶分析", "信号处理", "滤波器设计"]
license:
comment: true
weight: 0
tags:
  - ECSE 1010
  - Lab
  - Electrical Engineering
  - RPI
categories:
  - Electrical Engineering
collections:
  - ECSE 1010
hiddenFromHomePage: false
hiddenFromSearch: false
hiddenFromRss: false
hiddenFromRelated: false
summary: 这篇博客文章概述了一系列涉及傅里叶分析、信号重建、滤波器设计和频率处理的实验和分析，使用MATLAB及其他工具。内容包括理论概念的讨论、模拟以及实际应用。
resources:
  - name: featured-image
    src: featured-image.jpg
  - name: featured-image-preview
    src: featured-image-preview.jpg
toc: true
math: true
lightgallery: true
password:
message:
repost:
  enable: false
  url:

# See details front matter: https://fixit.lruihao.cn/documentation/content-management/introduction/#front-matter
---

<!--more-->

## 0. 参考文档

<div style="width: 100%; max-width: 600px; margin: 0 auto; display: block;">
  <embed src="Lab03.pdf" type="application/pdf" width="100%" height="500px">
</div>

## 1. 在时域和频域证明三个正弦波叠加后的结果

### 描述

我们将对三种基本类型的正弦波进行求和，并检查其频谱。看看是否符合我们的预期。

### 分析

为了确定三个正弦波叠加后的时域信号和频率谱，我们可以利用正弦波在时域和频域的性质。

例如，250Hz、500Hz 和 750Hz 的正弦波求和后，在时域中应该如下所示：

{{< image src="P1-1-b.avif" caption="P1-1-b" width=600px >}}

在频域中应为

{{< image src="P1-1-c.avif" caption="P1-1-c" width=600px >}}

因为叠加波是由三个单一正弦波组成的。

### 模拟

{{< image src="P1-2-a.avif" caption="P1-2-a" width=600px >}}

{{< image src="P1-1-b.avif" caption="P1-1-b" width=600px >}}

{{< image src="P1-1-a.avif" caption="P1-1-a" width=600px >}}

### 讨论

我们的草图和频域模拟都有三个相同的正峰值，这证明了我们的分析。它们不完全匹配的原因是离散傅里叶变换。

在这个模拟中使用的正弦波是离散的正弦波。与正常的傅里叶变换不同，数据点的数量决定了通过多少频率。但分贝值非常低，所以没有区别。

## 2. 使用傅里叶分析确定创建神秘信号所用的基本类型信号

### 描述

我们将使用傅里叶分析来找出一个叠加信号中的两种基本类型的信号。为此，我们将在 MATLAB 中使用频谱仪的峰值查找器。

### 分析

我们可以选择频率谱中最强的信号作为两个基本类型的信号，它们组合形成了这个神秘信号。

### 模拟

让我们加载 [神秘信号音频文件](lab03_mystery_signal.wav)

{{< image src="P2-2-a.avif" caption="P2-2-a" width=600px >}}

时域看起来像

{{< image src="P2-1-a.avif" caption="P2-1-a" width=600px >}}

频域看起来像

{{< image src="P2-1-b.avif" caption="P2-1-b" width=600px >}}

### 讨论

使用峰值查找器，前两个正频率为

| 峰值编号 | 频率（Hz） | 幅度（dBm） |
|:---:|:---:|:---:|
| 1 | $101.5050$ | $25.2965$ |
| 2 | $749.5751$ | $19.6980$ |

因此，组合形成神秘信号的两个基本类型信号是

- 101.5050Hz 正弦波
- 749.5751Hz 正弦波

## 3. 使用傅里叶合成重构神秘信号的时间域表示

### 描述

在找出神秘信号内的前两种基本类型的波之后，我们将对其进行重建，并看看是否与原始信号匹配。我们可能需要使用超过前两个信号来获得更好的拟合。

### 分析

一个由频率为 $101.5050 Hz$ 和 $749.5751 Hz$ 的两个正弦波组成的信号可以数学表达如下：

$$
x(t) = \sin(2\pi \times 101.5050 \, t) + \sin(2\pi \times 749.5751 \, t)
$$

- **$t$**：表示时间（秒）。
- **$\sin$**：正弦函数，生成振荡波形。
- **$2\pi \times f \, t$**：将频率 $f$ 从赫兹（每秒周期数）转换为弧度/秒，这是正弦函数参数所必需的。

更一般的形式可以写成

$$
x(t) = A_1 \sin(2\pi f_1 t + \phi_1) + A_2 \sin(2\pi f_2 t + \phi_2)
$$

其中

- $A_1$ 和 $A_2$ 是正弦波的振幅。
- $f_1 = 101.5050 Hz$ 和 $f_2 = 749.5751 Hz$ 是频率。
- $\phi_1$ 和 $\phi_2$ 是相位偏移。

假设两个正弦波的幅度为 1，没有相位偏移，则表达式简化为：

$$
x(t) = \sin(2\pi \times 101.5050 \, t) + \sin(2\pi \times 749.5751 \, t)
$$

### 模拟与讨论

{{< image src="P3-2-a.avif" caption="P3-2-a" width=600px >}}

使用峰值查找器，前五个正频率为

| 峰值编号 | 频率（Hz） | 幅度（dBm） |
|:---:|:---:|:---:|
| 1 | $101.5$ | $25.2965$ |
| 2 | $749.6$ | $19.6980$ |
| 3 | $148.4$ | $-3.2694$ |
| 4 | $694.9$ | $-13.9588$ |
| 5 | $1350.8$ | $-14.5331$ |

然后，使用五个基本波形而不是两个来获得更好的结果

{{< image src="P3-2-b.avif" caption="P3-2-b" width=600px >}}

让我们检查一下结果

{{< image src="P3-2-c.avif" caption="P3-2-c" width=600px >}}

功率并不完全匹配，因为它们是手动调整的。但它们很接近，并且得到了一个时间域信号重构的结果如下：

{{< image src="P3-2-d.avif" caption="P3-2-d" width=600px >}}

将我们的重构信号与原始信号进行比较，它们具有相同的周期和形状。

{{< image src="P2-1-a.avif" caption="P2-1-a" width=600px >}}

细节上的不同可能是由于缺少更多基本类型的波形以及基本类型波形的功率差异造成的。

## 4. 使用电感器和电阻证明模拟高通滤波器的概念，并且我能否使用相同的组件制作低通滤波器？

### 电路图

对于低通滤波器

{{< image src="P4-1-a.avif" caption="P4-1-a" width=600px >}}

对于高通滤波器

{{< image src="P4-1-b.avif" caption="P4-1-b" width=600px >}}

### 描述

我们将使用电感器和电阻制作高频（HF）和低频（LF）滤波器，并使用 Analog Discovery 3 的网络分析仪功能检查频率响应结果。

### 分析

对于 LR 低通滤波器和 LR 高通滤波器，截止频率由以下公式给出：

$$
f_c = \frac{R}{2\pi L}
$$

其中

- **电阻（$R$）**：510 欧姆
- **电感（$L$）**：1 mH = 0.001 H

代入数值计算截止频率：

$$
\begin{align*}
f_c &= \frac{510}{2 \times \pi \times 0.001} \\
f_c &= \frac{510}{0.00628318} \approx 81,000 \text{ Hz}
\end{align*}
$$

### 模拟

对于低通滤波器

{{< image src="P4-3-a.avif" caption="P4-3-a" width=600px >}}

我们得到了一个大约为 82.37 kHz 的截止频率。

{{< image src="P4-3-a-b.avif" caption="P4-3-a-b" width=600px >}}

对于高通滤波器

{{< image src="P4-3-b.avif" caption="P4-3-b" width=600px >}}

我们得到了一个大约为 80.69 kHz 的截止频率。

{{< image src="P4-3-b-b.avif" caption="P4-3-b-b" width=600px >}}

### 测量

我使用网络分析仪绘制了频率响应图。对于低通滤波器，我们的设置如下：

{{< image src="P4-4-a-b.avif" caption="P4-4-a-b" width=600px >}}

我们得到了一个大约为 79.48 kHz 的截止频率。

{{< image src="P4-4-a.avif" caption="P4-4-a" width=600px >}}

对于高通滤波器

{{< image src="P4-4-a-b.avif" caption="P4-4-a-b" width=600px >}}

我们得到了一个大约为 80.98 kHz 的截止频率。

{{< image src="P4-4-b.avif" caption="P4-4-b" width=600px >}}

### 讨论

我们的模拟与分析结果一致。测量也与模拟和分析结果一致，它们的截止频率都在 80kHz 左右，并且标记为 -3dBm。

## 5. 使用傅里叶分析将音频信号的可听特征与其频谱中的特定频率范围关联起来的概念

### 描述

我们将找出给定信号的主要成分并尝试重构它。在重构之后，我们将比较一些关键特性与原始信号进行对比。

### 分析

{{< image src="P5-1-a.avif" caption="P5-1-a" width=600px >}}

{{< image src="P5-1-b.avif" caption="P5-1-b" width=600px >}}

我们使用高通和低通滤波器将信号中的两个频率分开。我们将这两个频率、原始信号以及它们的求和输入频谱分析仪，可以看到两个过滤后的频率之和与原始信号匹配。

然后，我们用 [splay](splay.zip) 指出了主要频率

{{< image src="P5-2-a.avif" caption="P5-2-a" width=600px >}}

它们是

- 440.5Hz
- 480.1Hz

### 模拟与讨论

然后，我们进行了重构。

{{< image src="P5-2-b.avif" caption="P5-2-b" width=600px >}}

它们具有相同的形状和频域表示。

{{< image src="P5-2-d.avif" caption="P5-2-d" width=600px >}}

## 6. 过滤或隔离信号中特定频率范围的概念

### 描述

我们将模拟低通滤波器，并使用 Simulink 创建一个带通滤波器。之后，我们将将其应用于一首歌曲并看看它会带来什么变化。

### 分析

我们模拟了一个低通滤波器。红色是原始信号，黑色是经过过滤的信号。如图所示，部分信号被移除。

{{< image src="P6-2-a.avif" caption="P6-2-a" width=600px >}}

根据公式

$$
F_{low} = \frac{1}{2 \pi RC}
$$

我们可以得到目标低通滤波器的电容值。

$$
\begin{align*}
300 &= \frac{1}{2 \pi \cdot 1K \cdot C} \\
C &= 5.6 \times 10^{-7}
\end{align*}
$$

### 模拟与讨论

我们的音频文件是《玛丽有只小羊羔》。我们希望听到一个更高音调的版本。

{{< image src="P6-1-a.avif" caption="P6-1-a" width=600px >}}

通过应用从 800Hz 到 1700Hz 的带通滤波器，我们可以移除部分信号并听到声音。我们隔离了一个特定的、更高音调范围的声音。
最终得到了一个更高音调版本的歌曲，并且伴随着一些高音刺耳声。更高的音调版本也更轻。

{{< image src="P6-1-b.avif" caption="P6-1-b" width=600px >}}

{{< image src="P6-1-c.avif" caption="P6-1-c" width=600px >}}
