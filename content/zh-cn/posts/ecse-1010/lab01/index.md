---
title: ECSE 1010 概念验证 - Omega Lab01
subtitle:
date: 2024-11-19T06:05:36-05:00
lastmod: 2024-11-19T06:05:36-05:00
slug: ecse-1010-poc-lab01
draft: false
author:
  name: James
  link: https://www.jamesflare.com
  email:
  avatar: /site-logo.avif
description: 本文展示了ECSE 1010 Omega Lab01的综合概念验证，重点探讨了欧姆定律、基尔霍夫电流定律（KCL）、基尔霍夫电压定律（KVL）、分压器原理及电路中的电流流动等电气工程基础。内容涵盖详细的电路图设计、分析过程、仿真模拟以及实验测量数据，以验证理论知识的正确性。
keywords: ["欧姆定律", "基尔霍夫电流定律", "基尔霍夫电压定律", "分压器", "电流流动", "电气工程", "电路分析", "仿真", "测量"]
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
summary: 本文展示了ECSE 1010 Omega Lab01的综合概念验证，重点探讨了欧姆定律、基尔霍夫电流定律（KCL）、基尔霍夫电压定律（KVL）、分压器原理及电路中的电流流动等电气工程基础。内容涵盖详细的电路图设计、分析过程、仿真模拟以及实验测量数据，以验证理论知识的正确性。
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
  <embed src="Lab01.pdf" type="application/pdf" width="100%" height="500px">
</div>

## 1. 验证欧姆定律、KCL 和 KVL 在电路中的应用

### 电路图示

{{< image src="Proof%20of%20Concept%20-%20Omega%20Lab%2001%20-%201%20-%20Schematic.avif" caption="概念验证 - Omega 实验室 01 - 1 - 图纸" width=600px >}}

### 描述

- 根据欧姆定律，电压等于电流乘以电阻。因此，我们将用伏特表测量实际值并与理论值进行比较。
- 根据 KCL（基尔霍夫电流定律），流入节点的总电流等于流出该节点的总电流。所以我们要测量所有电流并相加来验证是否符合理论。
- 根据 KVL（基尔霍夫电压定律），在回路中的各个节点电压总和为零。因此，我们将测量整个回路的所有电压，并检查它们的总和。

### 分析

我们知道，欧姆定律、KCL 和 KVL 可以表示成以下公式：

$$
V = IR \\\
\sum I_{in} = \sum I_{out} \\\
\sum V_n = 0
$$

***

基于 $V = IR$，总电流应为

$$
\begin{align*}
    V &= IR \\\
    I &= \frac{V}{R} \\\
    I_{total} &= \frac{5}{10K + \cfrac{1}{\frac{1}{1K} + \frac{1}{1K}} + 10K} \\\
    I_{total} &= \frac{5}{10000 + 500 + 10000} \\\
    I_{total} &= 0.000243902439 \\\
\end{align*}
$$

并且 $I(R2) = I(R3)$ 应为

$$
\begin{align*}
     I(R2) = I(R3) &= I_{total} \times  \frac{R2}{R2 + R3} \\\
     I(R2) = I(R3) &= 0.000243902439 \times \frac{1000}{1000 + 1000} \\\
     I(R2) = I(R3) &= 0.0001219512195
\end{align*}
$$

***

为了找到 $V(R1)$、$V(R2)=V(R3)$ 和 $V(R4)$，我们可以使用以下公式：

$$
\begin{align*}
    V(R1) = V(R4) &= V_{total} \times \frac{R1}{R1 + R2 \Vert R3 + R4} \\\
    V(R1) = V(R4) &= 5 \times \frac{10000}{10000 + 500 + 10000} \\\
    V(R1) = V(R4) &= 2.4390244
\end{align*}
$$

$$
\begin{align*}
    V(R2) = V(R3) &= V_{total} - (V(R1) + V(R4)) \\\
    V(R2) = V(R3) &= 5 - 2.4390244 - 2.4390244 \\\
    V(R2) = V(R3) &= 0.1219512
\end{align*}
$$

***

根据 KCL，我们应看到 $I(R1) = I(R2) + I(R3)$，因为 $I(R1)$ 是流入节点 `n002` 的电流而 $I(R2) + I(R3)$ 是流出该节点的电流。

根据 KVL，在同一个回路中的电压总和为零。因此，我们应期望 $V(n001) - V(n002) - V(n003) = 0$。我们将检查实验结果是否符合这些预期。

### 模拟

{{< figure src="Proof%20of%20Concept%20-%20Omega%20Lab%2001%20-%201%20-%20Simulation.avif" caption="概念验证 - Omega 实验室 01 - 1 - 模拟结果" width=600px >}}

```text
       --- Operating Point ---

V(n001):     5     voltage
V(n002):     2.56098     voltage
V(n003):     2.43902     voltage
I(R1):     -0.000243902     device_current
I(R2):     0.000121951     device_current
I(R3):     0.000121951     device_current
I(R4):     0.000243902     device_current
I(V1):     -0.000243902     device_current
```

### 测量

{{< figure src="Proof%20of%20Concept%20-%20Omega%20Lab%2001%20-%201%20-%20Measurement.avif" caption="概念验证 - Omega 实验室 01 - 1 - 测量结果" width=600px >}}

$V(R1) = 2.4963V$

{{< figure src="Proof%20of%20Concept%20-%20Omega%20Lab%2001%20-%201%20-%20Measurement%20-%201.avif" caption="概念验证 - Omega 实验室 01 - 1 - 测量结果 - 1" width=600px >}}

$V(R2) = V(R3) = 166.5mV$

{{< figure src="Proof%20of%20Concept%20-%20Omega%20Lab%2001%20-%201%20-%20Measurement%20-%202.avif" caption="概念验证 - Omega 实验室 01 - 1 - 测量结果 - 2" width=600px >}}

$V(R4) = 2.4616V$

{{< figure src="Proof%20of%20Concept%20-%20Omega%20Lab%2001%20-%201%20-%20Measurement%20-%203.avif" caption="概念验证 - Omega 实验室 01 - 1 - 测量结果 - 3" width=600px >}}

### 讨论

首先，让我们比较理论值与实验测量值。

我们从 Analog Discovery 3 获取了以下实验读数：

```text
V(R1) = 2.4963V
V(R2) = V(R3) = 166.5mV
V(R4) = 2.4616V
```

为了找到 $V(R1)$、$V(R2)=V(R3)$ 和 $V(R4)$ 的理论值，我们需要做一些计算。

我们知道模拟输出为：

```text
V(n001):     5     voltage
V(n002):     2.56098     voltage
V(n003):     2.43902     voltage
```

电压是指两个点之间的电位差。基于这一点，我们可以计算 $V(R1)$、$V(R2)=V(R3)$ 和 $V(R4)$ 的理论值。

$$
\begin{align*}
    V(R1) &= V(n001) - V(n002) \\\
    V(R1) &= 5 - 2.56098 \\\
    V(R1) &= \boxed{2.43902}
\end{align*}
$$

$$
\begin{align*}
    V(R2) = V(R3) &= V(n002) - V(n003) \\\
    V(R2) = V(R3) &= 2.56098 - 2.43902 \\\
    V(R2) = V(R3) &= \boxed{0.12196}
\end{align*}
$$

$$
\begin{align*}
    V(R4) &= V(n003) - V(\text{GND}) \\\
    V(R4) &= 2.43902 - 0 \\\
    V(R4) &= \boxed{2.43902}
\end{align*}
$$

让我们做一个表格来比较结果：

|项目|分析值|模拟值|实验值|差值|误差百分比|
|:-:|:-:|:-:|:-:|:-:|-:|
|$V(R1)$|$2.4390V$|$2.4390V$|$2.4963V$|$57.28mV$|$2.3\%$|
|$V(R2)$|$0.1219V$|$0.1219V$|$0.1665V$|$44.54mV$|$26.8\%$|
|$V(R3)$|$0.1219V$|$0.1219V$|$0.1665V$|$44.54mV$|$26.8\%$|
|$V(R4)$|$2.4390V$|$2.4390V$|$2.4616V$|$22.58mV$|$0.9\%$|

我们可以看到 $V(R1)$ 和 $V(R4)$ 的准确性非常高。但 $V(R2)$ 和 $V(R3)$ 误差较大，可能的原因是存在背景噪声。

如果查看“测量”部分，通道 2 是空的，但它仍然有大约 $50mV$ 的读数。这很可能是背景噪声。如果我们从实验测量中去除这种噪声，则误差百分比将小于 $1\%$。考虑到电阻的容差为 $5\%$（来自四色环电阻代码），我们可以认为这是系统误差，而实验测量结果与模拟非常接近。

***

现在，让我们检查 KCL。

我们得到了以下模拟数据：

```text
I(R1):     -0.000243902     device_current
I(R2):     0.000121951     device_current
I(R3):     0.000121951     device_current
I(R4):     0.000243902     device_current
I(V1):     -0.000243902     device_current
```

根据分析结果，我们应看到 $I(R1) = I(R2) + I(R3)$。验证如下：

$$
\begin{align*}
    & \quad \thickspace I(R1) + I(R2) + I(R3) \\\
    &= -0.000243902 + 0.000121951 + 0.000121951 \\\
    &= \boxed{0}
\end{align*}
$$

KCL 很可能为真。

***

然后，让我们检查 KVL。

我们可以使用前面部分的结果：

$$
\begin{align*}
    V(R1) &= 2.43902 \\\
    V(R2) = V(R3) &= 0.12196 \\\
    V(R4) &= 2.43902
\end{align*}
$$

根据分析结果，我们应期望 $V(n001) - V(n002) - V(n003) = 0$。验证如下：

$$
\begin{align*}
    & \quad \thickspace V(n001) - V(n002) - V(n003) \\\
    &= 2.43902 - 0.12196 - 0.12196 \\\
    &= 0 \\\
    \boxed{\text{True}}
\end{align*}
$$

KVL 很可能为真。

***

最后，让我们检查欧姆定律。使用期望 $V = IR$ 和实验数据：

```text
R1 = 10K
R2 = R3 = 1K
R4 = 10K
V(R1) = 2.4963V
V(R2) = V(R3) = 166.5mV
V(R4) = 2.4616V
```

根据欧姆定律计算 $I$。

$$
\begin{align*}
    V &= IR \\\
    I &= \frac{V}{R} \\\
    I(R1) &= \frac{2.4963}{10000} = \boxed{0.00024963}
\end{align*}
$$

$$
\begin{align*}
    V &= IR \\\
    I &= \frac{V}{R} \\\
    I(R2) = I(R3) &= \frac{0.1665}{1000} = \boxed{0.0001665}
\end{align*}
$$

$$
\begin{align*}
    V &= IR \\\
    I &= \frac{V}{R} \\\
    I(R4) &= \frac{2.4616}{10000} = \boxed{0.00024616}
\end{align*}
$$

然后，我们可以将这些电流结果与模拟数据进行比较。

|项目|分析值|模拟值|实验值|差值|误差百分比|
|:-:|:-:|:-:|:-:|:-:|-:|
|$I(R1)$|$0.2439mA$|$0.2439mA$|$0.2496mA$|$0.005728mA$|$2.3\%$|
|$I(R2)$|$0.1665mA$|$0.1665mA$|$0.1219mA$|$0.044549mA$|$26.8\%$|
|$I(R3)$|$0.1665mA$|$0.1665mA$|$0.1219mA$|$0.044549mA$|$26.8\%$|
|$I(R4)$|$0.2439mA$|$0.2439mA$|$0.2461mA$|$0.002258mA$|$0.9\%$|

我们可以看到 $I(R1)$ 和 $I(R4)$ 的准确性非常高。但 $I(R2)$ 和 $I(R3)$ 误差较大，可能的原因是存在背景噪声。

如果查看“测量”部分，通道 2 是空的，但它仍然有大约 $50mV$ 的读数。这很可能是背景噪声。如果我们从实验测量中去除这种噪声，则误差百分比将小于 $1\%$。考虑到电阻的容差为 $5\%$（来自四色环电阻代码），我们可以认为这是系统误差，而实验测量结果与模拟非常接近。

此外，我们还可以检查整个电路中的总电流。根据分析中的期望 - $I_{total} = 0.000243902439$，这与模拟结果一致 - $0.000243902A$。

***

总之，模拟完全符合 KCL 和 KVL 的要求。实验数据接近于模拟值，并且如果去除背景噪声并考虑电阻的 $5\%$ 容差，则实验测量结果非常接近于模拟值。然后我们使用实验数据和欧姆定律来比较模拟结果，结果显示也非常接近。因此，我们在电路中验证了欧姆定律、KCL 和 KVL。

## 2. 验证串联电路中分压器的概念

### 电路图示

{{< figure src="Proof%20of%20Concept%20-%20Omega%20Lab%2001%20-%202%20-%20Schematic.avif" caption="概念验证 - Omega 实验室 01 - 2 - 图纸" width=600px >}}

### 描述

我将构建一个串联电路，其中包含两个电阻，并测量这些电阻上的电压以与理论值进行比较。

### 分析

分压器公式为：

$$
\frac{V_1}{V_2} = \frac{R_1}{R_2}
$$

如果电源电压为 $5V$ 且 $R1=R2=10K$，将这些值代入公式得到：

$$
\frac{V_1}{V_2} = \frac{10K}{10K} = \frac{1}{1}
$$

我们知道 $V_1 + V_2 = 5$ 并且 $1 \cdot V_1 = 1 \cdot V_2$。因此，我们期望 $V_1 = V_2 = 2.5$。

### 模拟

{{< figure src="Proof%20of%20Concept%20-%20Omega%20Lab%2001%20-%202%20-%20Simulation.avif" caption="概念验证 - Omega 实验室 01 - 2 - 模拟结果" width=600px >}}

```text
       --- Operating Point ---

V(n001):     5     voltage
V(n002):     2.5     voltage
I(R1):     -0.00025     device_current
I(R2):     -0.00025     device_current
I(V1):     -0.00025     device_current
```

### 测量

{{< figure src="Proof%20of%20Concept%20-%20Omega%20Lab%2001%20-%202%20-%20Measurement.avif" caption="概念验证 - Omega 实验室 01 - 2 - 测量结果" width=600px >}}

$V(R1) = 2.5539V$

{{< figure src="Proof%20of%20Concept%20-%20Omega%20Lab%2001%20-%202%20-%20Measurement%20-%201.avif" caption="概念验证 - Omega 实验室 01 - 2 - 测量结果 - 1" width=600px >}}

$V(R2) = 2.5204V$

{{< figure src="Proof%20of%20Concept%20-%20Omega%20Lab%2001%20-%202%20-%20Measurement%20-%202.avif" caption="概念验证 - Omega 实验室 01 - 2 - 测量结果 - 2" width=600px >}}

### 讨论

首先，让我们比较理论值与实验测量值。

我们从 Analog Discovery 3 获取了以下实验读数：

```text
V(R1) = 2.5539V
V(R2) = 2.5204V
```

电压是指两个点之间的电位差。基于这一点，我们可以计算 $V(R1)$ 和 $V(R2)$ 的理论值。

我们知道模拟输出为：

```text
V(n001):     5     voltage
V(n002):     2.5     voltage
```

$$
\begin{align*}
    V(R1) &= V(n001) - V(n002) \\\
    V(R1) &= 5 - 2.5 \\\
    V(R1) &= \boxed{2.5}
\end{align*}
$$

$$
\begin{align*}
    V(R2) &= V(n002) - \text{GND} \\\
    V(R2) &= 2.5 - 0 \\\
    V(R2) &= \boxed{2.5}
\end{align*}
$$

让我们做一个表格来比较结果：

|项目|分析值|模拟值|实验值|差值|误差百分比|
|:-:|:-:|:-:|:-:|:-:|-:|
|$V(R1)$|$2.5V$|$2.5V$|$2.5539V$|$0.0539V$|$2.1\%$|
|$V(R2)$|$2.5V$|$2.5V$|$2.5204V$|$0.0204V$|$0.8\%$|

我们可以看到 $V(R1)$ 和 $V(R2)$ 的准确性非常高。有一些误差，可能的原因是存在背景噪声。

如果查看“测量”部分，通道 2 是空的，但它仍然有大约 $40mV$ 的读数。这很可能是背景噪声。如果我们从实验测量中去除这种噪声，则误差百分比将小于 $1\%$。考虑到电阻的容差为 $5\%$（来自四色环电阻代码），我们可以认为这是系统误差，而实验测量结果与模拟非常接近。

总之，模拟完全符合分压器理论公式的要求。实验读数接近于理论值，并且如果去除背景噪声，则实验读数非常接近于理论值。因此，我们在串联电路中验证了分压器的概念。

## 3. 验证电流在串联电路中流动的概念

### 电路图示

{{< figure src="Proof%20of%20Concept%20-%20Omega%20Lab%2001%20-%202%20-%20Schematic.avif" caption="概念验证 - Omega 实验室 01 - 2 - 图纸" width=600px >}}

### 描述

我将使用欧姆定律来找出串联电路中每个电阻中的电流，并将其与理论值进行比较。

### 分析

串联电路的特点是：

- 只有一条路径供电流通过电路。
- 在电路的任何一点，电流都相同。

由于 Analog Discovery 3 不能直接测量电流而是测量电压。我们将使用欧姆定律来找出流过电阻的电流。

我们知道从欧姆定律的关系为：

$$
V = IR
$$

可以稍作变换得到：

$$
I = \frac{V}{R}
$$

另外，我们还知道 $R_1 = R_2 = 10K$，并且可以通过分压器公式找到电阻上的电压。即：

$$
\begin{align*}
    \frac{V_1}{V_2} &= \frac{R_1}{R_2} \\\
    \frac{V_1}{V_2} &= \frac{10K}{10K} = 1
\end{align*}
$$

我们知道 $V_1 + V_2 = 5$ 并且 $V_1 = V_2$。因此，我们期望 $V_1 = V_2 = 2.5$。

使用这些值，我们可以计算出 $I(R1)$ 和 $I(R2)$：

$$
\begin{align*}
    I(R1) = I(R2) &= \frac{V}{R} \\\
    I(R1) = I(R2) &= \frac{2.5}{10K} \\\
    I(R1) = I(R2) &= \boxed{0.00025}
\end{align*}
$$

我们期望 $I(R1)$ 和 $I(R2)$ 为 $0.00025A$。

### 模拟

{{< figure src="Proof%20of%20Concept%20-%20Omega%20Lab%2001%20-%202%20-%20Simulation.avif" caption="概念验证 - Omega 实验室 01 - 2 - 模拟结果" width=600px >}}

```text
       --- Operating Point ---

V(n001):     5     voltage
V(n002):     2.5     voltage
I(R1):     -0.00025     device_current
I(R2):     -0.00025     device_current
I(V1):     -0.00025     device_current
```

### 测量

{{< figure src="Proof%20of%20Concept%20-%20Omega%20Lab%2001%20-%202%20-%20Measurement.avif" caption="概念验证 - Omega 实验室 01 - 2 - 测量结果" width=600px >}}

$V(R1) = 2.5539V$

{{< figure src="Proof%20of%20Concept%20-%20Omega%20Lab%2001%20-%202%20-%20Measurement%20-%201.avif" caption="概念验证 - Omega 实验室 01 - 2 - 测量结果 - 1" width=600px >}}

$V(R2) = 2.5204V$

{{< figure src="Proof%20of%20Concept%20-%20Omega%20Lab%2001%20-%202%20-%20Measurement%20-%202.avif" caption="概念验证 - Omega 实验室 01 - 2 - 测量结果 - 2" width=600px >}}

### 讨论

从模拟结果中，

```text
I(R1):     -0.00025     device_current
I(R2):     -0.00025     device_current
```

这证明了 $I(R1) = I(R2)$，即：

- 只有一条路径供电流通过电路。
- 在电路的任何一点，电流都相同。

***

从测量结果中，我们得到了电阻 $R1$ 和 $R2$ 上的电压

$V(R1) = 2.5539V$
$V(R2) = 2.5204V$

基于欧姆定律 - 我们在分析中得到的关系 $I = \frac{V}{R}$，我们可以计算出 $I(R1)$ 和 $I(R2)$：

$$
\begin{align*}
    I(R1) &= \frac{V}{R} \\\
    I(R1) &= \frac{2.5539}{10K} \\\
    I(R1) &= 0.00025539
\end{align*}
$$

$$
\begin{align*}
    I(R2) &= \frac{V}{R} \\\
    I(R2) &= \frac{2.5204}{10K} \\\
    I(R2) &= 0.00025204
\end{align*}
$$

$R1$ 和 $R2$ 非常接近，可以认为 $R1 \approx R2$。考虑到电阻的容差为 $5\%$（来自四色环电阻代码），我们可以将其视为系统误差，实验测量结果与模拟非常接近。

***

总之，模拟完全符合串联电路中电流的特点。实验读数接近于理论值，并且如果考虑电阻的容差为 $5\%$（来自四色环电阻代码），则实验读数非常接近于理论值。因此，我们在串联电路中验证了电流流动的概念：

- 只有一条路径供电流通过电路。
- 在电路的任何一点，电流都相同。

## 4. 验证并联电路中电压的概念

### 电路图示

{{< figure src="Proof%20of%20Concept%20-%20Omega%20Lab%2001%20-%204%20-%20Schematic.avif" caption="概念验证 - Omega 实验室 01 - 4 - 图纸" width=600px >}}

### 描述

我将使用欧姆定律和节点特性来找出并联电路中每个电阻上的电压，并将其与理论值进行比较。

### 分析

并联电路的特点是：

- 存在多条路径供电流通过电路。
- 每个支路的电压相同，等于电源提供的电压。

$$
V_{total} = V_1 = V_2 = V_3 = \ldots = V_n
$$

我们知道同一节点上的电压相同（它们由导线连接）。因此，我们期望 $V(R1) = V(R2)$。

另外，电压是两个点之间的电位差。基于这一点，我们可以计算出 $V(R1)$ 和 $V(R2)$ 的理论值：

$$
\begin{align*}
    V(R1) = V(R2) &= 5 - 0 \\\
    V(R1) = V(R2) &= \boxed{5}
\end{align*}
$$

***

另外，我们还可以检查该电路中的电流。我们知道并联电路的总电流为：

$$
I_{total} = I_1 + I_2 + I_3 + \dots
$$

根据欧姆定律，我们知道：

$$
V = IR
$$

可以稍作变换得到：

$$
I = \frac{V}{R}
$$

并且，并联电阻的总阻值为：

$$
\frac{1}{R_{total}} = \frac{1}{R_1} + \frac{1}{R_2} + \frac{1}{R_3} + \ldots + \frac{1}{R_n}
$$

因此，

$$
R_{total} = \frac{1}{\frac{1}{R_1} + \frac{1}{R_2} + \frac{1}{R_3} + \ldots + \frac{1}{R_n}}
$$

结合以上公式，我们得到：

$$
I_{total} = \frac{V}{\cfrac{1}{\frac{1}{R_1} + \frac{1}{R_2} + \frac{1}{R_3} + \ldots + \frac{1}{R_n}}}
$$

将值代入公式：

$$
\begin{align*}
    I_{total} &= \frac{5}{\cfrac{1}{\frac{1}{10K} + \frac{1}{10K}}} \\\
    I_{total} &= \frac{5}{5K} \\\
    I_{total} &= \boxed{0.001}
\end{align*}
$$

我们可以检查这个结果以进一步确认。

### 模拟

{{< figure src="Proof%20of%20Concept%20-%20Omega%20Lab%2001%20-%204%20-%20Simulation.avif" caption="概念验证 - Omega 实验室 01 - 4 - 模拟结果" width=600px >}}

```text
       --- Operating Point ---

V(n001):     5     voltage
I(R2):     0.0005     device_current
I(R1):     0.0005     device_current
I(V1):     -0.001     device_current
```

### 测量

{{< figure src="Proof%20of%20Concept%20-%20Omega%20Lab%2001%20-%204%20-%20Measurement.avif" caption="概念验证 - Omega 实验室 01 - 4 - 测量结果" width=600px >}}

$V(R1)=V(R2)=5.0305V$

{{< figure src="Proof%20of%20Concept%20-%20Omega%20Lab%2001%20-%204%20-%20Measurement%20-%201.avif" caption="概念验证 - Omega 实验室 01 - 4 - 测量结果 - 1" width=600px >}}

### 讨论

首先，让我们比较理论值与实验测量值。

我们从 Analog Discovery 3 获取了以下实验读数：

```text
V(R1) = 5.0305V
V(R2) = 5.0305V
```

为了找到 $V(R1)$ 和 $V(R2)$ 的理论值，我们需要做一些计算。

我们知道模拟输出为：

```text
V(n001):     5     voltage
```

电压是两个点之间的电位差。基于这一点，我们可以计算出 $V(R1)$ 和 $V(R2)$ 的理论值：

$$
\begin{align*}
    V(R1) = V(R2) &= 5 - 0 \\\
    V(R1) = V(R2) &= \boxed{5}
\end{align*}
$$

让我们做一个表格来比较结果：

|项目|分析值|模拟值|实验值|差值|误差百分比|
|:-:|:-:|:-:|:-:|:-:|-:|
|$V(R1)$|$5V$|$5V$|$5.0305V$|$0.0305V$|$0.6\%$|
|$V(R2)$|$5V$|$5V$|$5.0305V$|$0.0305V$|$0.6\%$|

我们可以看到 $V(R1)$ 和 $V(R2)$ 的准确性非常高。有一些误差，可能的原因是存在背景噪声。

如果查看“测量”部分，通道 2 是空的，但它仍然有大约 $40mV$ 的读数。这很可能是背景噪声。如果我们从实验测量中去除这种噪声，则误差百分比将小于 $0.2\%$。考虑到电阻的容差为 $5\%$（来自四色环电阻代码），我们可以认为这是系统误差，而实验测量结果与模拟非常接近。

***

其次，我们可以通过检查总电流来进一步确认。

我们知道模拟输出为：

```text
I(R2):     0.0005     device_current
I(R1):     0.0005     device_current
```

根据分析，我们期望

$$
I_{total} = 0.001
$$

并联电路的总电流为：

$$
I_{total} = I_1 + I_2 + I_3 + \dots
$$

因此，

$$
\begin{align*}
    I_{total} &= I(R2) + I(R1) \\\
    I_{total} &= 0.0005 + 0.0005 \\\
    I_{total} &= 0.001 \\\
    & 0.001 = 0.001 \\; \boxed{\text{True}}
\end{align*}
$$

我们的分析与模拟结果一致。

***

此外，我们还可以检查实验数据。由于 Analog Discovery 3 不能直接测量电流，我们需要使用欧姆定律来计算电流。

我们得到：

```text
V(R1) = 5.0305V
V(R2) = 5.0305V
```

并且我们知道：

```text
R1 = 10K
R2 = 10K
```

因此，我们可以计算出 $I(R1)$ 和 $I(R2)$：

$$
\begin{align*}
    I &= \frac{V}{R} \\\
    I(R1) = I(R2) &= \frac{5.0305}{10000} \\\
    I(R1) = I(R2) &= \boxed{0.0005305}
\end{align*}
$$

$0.0005305 \approx 0.0005$，误差仅为 $0.6\%$（即使去除背景噪声后也小于 $0.2\%$）。我们的理论非常可能为真。考虑到电阻的容差为 $5\%$（来自四色环电阻代码），我们可以认为这是系统误差，而实验测量结果与模拟非常接近。

***

总之，我们验证了模拟完全符合分析预期。实验数据仅比理论值高出 $0.2\%$ 到 $0.6\%$。因此，我们在并联电路中验证了电压的概念：

- 存在多条路径供电流通过电路。
- 每个支路的电压相同，并等于电源提供的电压。

## 5. 验证并联电路中分流器的概念

### 电路图示

{{< figure src="Proof%20of%20Concept%20-%20Omega%20Lab%2001%20-%204%20-%20Schematic.avif" caption="概念验证 - Omega 实验室 01 - 4 - 图纸" width=600px >}}

### 描述

我将使用欧姆定律来找出并联电路中每个电阻上的电流，并将其总和与理论值进行比较。

### 分析

并联电路的特点是：

- 存在多条路径供电流通过电路。
- 每个支路的电压相同，等于电源提供的电压。
- 总电流进入并联电路后被分配到各个支路中。

$$
V_{total} = V_1 = V_2 = V_3 = \ldots = V_n
$$

我们知道同一节点上的电压相同（它们由导线连接）。因此，我们期望 $V(R1) = V(R2)$。

另外，电压是两个点之间的电位差。基于这一点，我们可以计算出 $V(R1)$ 和 $V(R2)$ 的理论值：

$$
\begin{align*}
    V(R1) = V(R2) &= 5 - 0 \\\
    V(R1) = V(R2) &= \boxed{5}
\end{align*}
$$

根据欧姆定律，我们知道：

$$
V = IR
$$

可以稍作变换得到：

$$
I = \frac{V}{R}
$$

因此，

$$
\begin{align*}
    I(R1) &= \frac{V(R1)}{R1} \\\
    I(R1) &= \frac{5}{10K} \\\
    I(R1) &= \boxed{0.0005}
\end{align*}
$$

$$
\begin{align*}
    I(R2) &= \frac{V(R2)}{R2} \\\
    I(R2) &= \frac{5}{10K} \\\
    I(R2) &= \boxed{0.0005}
\end{align*}
$$

$I(R1)$ 和 $I(R2)$ 的关系可以表示为：

$$
\begin{align*}
    \frac{I(R1)}{I(R2)} &= \cfrac{\cfrac{V(R1)}{R1}}{\cfrac{V(R2)}{R2}} \\\
    \because V(R1) &= V(R2) \\\
    \therefore \frac{I(R1)}{I(R2)} &= \cfrac{\cfrac{\cancel{V(R1)}}{R1} \times \cfrac{1}{\cancel{V(R1)}}}{\cfrac{\cancel{V(R2)}}{R2} \times \cfrac{1}{\cancel{V(R2)}}} \\\
    \frac{I(R1)}{I(R2)} &= \frac{\frac{1}{R1}}{\frac{1}{R2}} \\\
    &\boxed{\frac{I(R1)}{I(R2)} = \frac{R2}{R1}}
\end{align*}
$$

在我们的情况下，$1 \cdot R1 = 1 \cdot R2$，所以：

$$
\frac{I(R1)}{I(R2)} = \frac{R2}{R1} = \frac{1}{1}
$$

因此，我们可以得到 $I_{total}$ 为：

$$
\begin{align*}
    I_{total} &= \frac{V_{total}}{R_{total}} \\\
    I_{total} &= \frac{5}{\cfrac{1}{\cfrac{1}{10K} + \cfrac{1}{10K}}} \\\
    I_{total} &= \frac{5}{5K} \\\
    I_{total} &= 0.001
\end{align*}
$$

由于：

$$
\frac{I(R1)}{I(R2)} = \frac{1}{1}
$$

我们可以得到 $I(R1)$ 和 $I(R2)$ 为：

$$
\begin{align*}
    I(R1) = I(R2) &= I_{total} \times \frac {R1}{R1 + R2} \\\
    I(R1) = I(R2) &= 0.001 \times \frac {10K}{10K + 10K} \\\
    I(R1) = I(R2) &= \boxed{0.0005}
\end{align*}
$$

此时，我们的逻辑是一致的：

$$
\begin{align*}
    & \because R1 = R2 = 10K \\\
    & \because I(R1) = I(R2) = 0.0005 \\\
    & \because V(R1) = V(R2) = 5 \\\
    & \because I_{total} = I(R1) + I(R2) = 0.001 \\\
    & \because \frac{I(R1)}{I(R2)} = \frac{R2}{R1} \\\
    & \therefore I(R1) = I(R2) = I_{total} \times \frac {R1}{R1 + R2}
\end{align*}
$$

$I(R1) = I(R2) = 0.0005$ 的结果也通过 $I = \frac{V}{R}$ 进行了交叉验证。因此，我们非常有信心：

$$
\frac{I(R1)}{I(R2)} = \frac{R2}{R1}
$$

对于并联电路中任何电阻的电流（例如 $I(R1)$）

$$
I(R1) = I_{total} \times \frac {R1}{R1 + R2 + \cdots}
$$

### 模拟

{{< figure src="Proof%20of%20Concept%20-%20Omega%20Lab%2001%20-%204%20-%20Simulation.avif" caption="概念验证 - Omega 实验室 01 - 4 - 模拟结果" width=600px >}}

```text
       --- Operating Point ---

V(n001):     5     voltage
I(R2):     0.0005     device_current
I(R1):     0.0005     device_current
I(V1):     -0.001     device_current
```

### 测量

{{< figure src="Proof%20of%20Concept%20-%20Omega%20Lab%2001%20-%204%20-%20Measurement.avif" caption="概念验证 - Omega 实验室 01 - 4 - 测量结果" width=600px >}}

$V(R1)=V(R2)=5.0305V$

{{< figure src="Proof%20of%20Concept%20-%20Omega%20Lab%2001%20-%204%20-%20Measurement%20-%201.avif" caption="概念验证 - Omega 实验室 01 - 4 - 测量结果 - 1" width=600px >}}

### 讨论

首先，让我们比较理论值与实验测量值。

我们从 Analog Discovery 3 获取了以下实验读数：

```text
V(R1) = 5.0305V
V(R2) = 5.0305V
```

为了找到 $V(R1)$ 和 $V(R2)$ 的理论值，我们需要做一些计算。

我们知道模拟输出为：

```text
V(n001):     5     voltage
```

电压是两个点之间的电位差。基于这一点，我们可以计算出 $V(R1)$ 和 $V(R2)$ 的理论值：

$$
\begin{align*}
    V(R1) = V(R2) &= 5 - 0 \\\
    V(R1) = V(R2) &= \boxed{5}
\end{align*}
$$

让我们做一个表格来比较结果：

|项目|分析值|模拟值|实验值|差值|误差百分比|
|:-:|:-:|:-:|:-:|:-:|-:|
|$V(R1)$|$5V$|$5V$|$5.0305V$|$0.0305V$|$0.6\%$|
|$V(R2)$|$5V$|$5V$|$5.0305V$|$0.0305V$|$0.6\%$|

我们可以看到 $V(R1)$ 和 $V(R2)$ 的准确性非常高。有一些误差，可能的原因是存在背景噪声。

如果查看“测量”部分，通道 2 是空的，但它仍然有大约 $40mV$ 的读数。这很可能是背景噪声。如果我们从实验测量中去除这种噪声，则误差百分比将小于 $0.2\%$。考虑到电阻的容差为 $5\%$（来自四色环电阻代码），我们可以认为这是系统误差，而实验测量结果与模拟非常接近。

***

其次，让我们检查 $I(R1)$ 和 $I(R2)$ 的理论值。

由于 Analog Discovery 3 不能直接测量电流，我们需要使用欧姆定律来计算电流。

我们得到：

```text
V(R1) = 5.0305V
V(R2) = 5.0305V
```

并且我们知道：

```text
R1 = 10K
R2 = 10K
```

因此，我们可以计算出 $I(R1)$ 和 $I(R2)$：

$$
\begin{align*}
    I &= \frac{V}{R} \\\
    I(R1) = I(R2) &= \frac{5.0305}{10000} \\\
    I(R1) = I(R2) &= \boxed{0.0005305}
\end{align*}
$$

|项目|分析值|模拟值|实验值|差值|误差百分比|
|:-:|:-:|:-:|:-:|:-:|-:|
|$I(R1)$|$0.5mA$|$0.5mA$|$0.50305mA$|$0.00305mA$|$0.6\%$|
|$I(R2)$|$0.5mA$|$0.5mA$|$0.50305mA$|$0.00305mA$|$0.6\%$|

我们可以看到 $I(R1)$ 和 $I(R2)$ 的准确性非常高。有一些误差，可能的原因是存在背景噪声。

如果查看“测量”部分，通道 2 是空的，但它仍然有大约 $40mV$ 的读数。这很可能是背景噪声。如果我们从实验测量中去除这种噪声，则误差百分比将小于 $0.2\%$。考虑到电阻的容差为 $5\%$（来自四色环电阻代码），我们可以认为这是系统误差，而实验测量结果与模拟非常接近。

***

总之，我们验证了模拟完全符合分析预期。实验数据仅比理论值高出 $0.2\%$ 到 $0.6\%$。因此，我们在并联电路中验证了电流分流的概念：

- 存在多条路径供电流通过电路。
- 每个支路的电压相同，并等于电源提供的电压。
- 总电流进入并联电路后被分配到各个支路中。

## 6. 验证温度传感电路中的分压器概念

### 电路图示

{{< figure src="Proof%20of%20Concept%20-%20Omega%20Lab%2001%20-%206%20-%20Schematic.avif" caption="概念验证 - Omega 实验室 01 - 6 - 图纸" width=600px >}}

### 描述

我们将使用 NTC 100K 作为热敏电阻，并将其读数与温度计和模拟结果进行比较，以检查其可靠性。

### 分析

NTC 热敏电阻使用 Beta 公式来计算特定温度下的电阻。公式如下：

$$
\frac{1}{T_1} = \frac{1}{T_0} + \frac{1}{\beta} \ln\left(\frac{R_1}{R_0}\right) 
$$

可以将 $R_1$ 移到左边得到：

$$
R_1 = R_0 e^{\beta(T_1^{-1} - T_0^{-1})}
$$

由于我们想找出特定温度下的热敏电阻阻值。

***

所使用的热敏电阻是 NTC 100K，这意味着它在参考温度 $25 \degree C$ 下的阻值为 $100k \Omega$

$$
T_0 = 298.15K \\
R_0 = 100k \Omega
$$

制造商提供的 $\beta$ 值：

$$
\beta = 3950
$$

我们知道分压器公式为：

$$
\frac{V_1}{V_2} = \frac{R_1}{R_2}
$$

将它们组合起来，我们得到：

$$
\frac{V_1}{V_2} = \frac{R_0 e^{\beta(T_1^{-1} - T_0^{-1})}}{R_2}
$$

### 模拟

{{< figure src="Proof%20of%20Concept%20-%20Omega%20Lab%2001%20-%206%20-%20Simulation.avif" caption="概念验证 - Omega 实验室 01 - 6 - 模拟结果" width=600px >}}

我们得到了一个曲线，显示了温度在 $T = 0 \degree C$ 到 $T = 40 \degree C$ 范围内的关系。

对于 $T = 29.12 \degree C$，电压应为 $4.465V$

{{< figure src="Proof%20of%20Concept%20-%20Omega%20Lab%2001%20-%206%20-%20Simulation%20-%201.avif" caption="概念验证 - Omega 实验室 01 - 6 - 模拟结果 - 1" width=600px >}}

对于 $T = 27.3 \degree C$，电压应为 $4.501V$

{{< figure src="Proof%20of%20Concept%20-%20Omega%20Lab%2001%20-%206%20-%20Simulation%20-%202.avif" caption="概念验证 - Omega 实验室 01 - 6 - 模拟结果 - 2" width=600px >}}

对于 $T = 30.25 \degree C$，电压应为 $4.441V$

{{< figure src="Proof%20of%20Concept%20-%20Omega%20Lab%2001%20-%206%20-%20Simulation%20-%203.avif" caption="概念验证 - Omega 实验室 01 - 6 - 模拟结果 - 3" width=600px >}}

### 测量

{{< figure src="Proof%20of%20Concept%20-%20Omega%20Lab%2001%20-%206%20-%20Measurement.avif" caption="概念验证 - Omega 实验室 01 - 6 - 测量结果" width=600px >}}

我们使用了示波器中的数学函数：

```js
1/((1/298.15)+(1/3950)*log((((10000*C1)/(5-C1))/100000),2.71828)) - 273.15
```

来获取温度读数（单位为 $\degree C$）。这是从以下公式得出的：

$$
\frac{1}{T_1} = \frac{1}{T_0} + \frac{1}{\beta} \ln\left(\frac{R_1}{R_0}\right) 
$$

其中 $T_1$ 是我们想要读取的温度。

然后，我们在 $24 \degree C$ 下校准了热敏电阻。

{{< figure src="Proof%20of%20Concept%20-%20Omega%20Lab%2001%20-%206%20-%20Measurement%20-%202.avif" caption="概念验证 - Omega 实验室 01 - 6 - 测量结果 - 2" width=600px >}}

之后，我们进行了三次测量：

$V = 4.465V, T = 29.12 \degree C$

{{< figure src="Proof%20of%20Concept%20-%20Omega%20Lab%2001%20-%206%20-%20Measurement%20-%201.avif" caption="概念验证 - Omega 实验室 01 - 6 - 测量结果 - 1" width=600px >}}

$V = 4.502V, T = 27.3 \degree C$

{{< figure src="Proof%20of%20Concept%20-%20Omega%20Lab%2001%20-%206%20-%20Measurement%20-%203.avif" caption="概念验证 - Omega 实验室 01 - 6 - 测量结果 - 3" width=600px >}}

$V = 4.441V, T = 30.25 \degree C$

{{< figure src="Proof%20of%20Concept%20-%20Omega%20Lab%2001%20-%206%20-%20Measurement%20-%204.avif" caption="概念验证 - Omega 实验室 01 - 6 - 测量结果 - 4" width=600px >}}

### 讨论

|温度|分析值|模拟值|实验值|差值|误差百分比|
|:-:|:-:|:-:|:-:|:-|-:|
|$29.12 \degree C$|$4.465V$|$4.465V$|$4.465V$|$0V$|$0\%$|
|$27.3 \degree C$|$4.501V$|$4.501V$|$4.502V$|$1mV$|$0.1\%$|
|$30.25 \degree C$|$4.441V$|$4.441V$|$4.441V$|$0V$|$0\%$|

如我们所见，理论值与测量值之间的差异非常小。这可能是因为温度读数是通过电压计算得出的。

即使查看温度计的读数，两者都显示约为 $24 \degree C$。在最坏的情况下，误差为 $5\%$。因此，总体而言，我们的读数是可靠的。

***

惠斯通电桥比普通分压器更灵敏，因为它的输出电压受电阻比例变化的影响较小。当惠斯通电桥平衡时（即 $R1/R2 = R3/R4$），中心的电流表中的电流为零。此时，计算出的阻值不再受到导线、电阻和伏特计固有电阻的影响，从而使得测量结果更准确。

优点：

- 惠斯通电桥比分压器更准确
- 电压源不需要校准即可测量阻值

缺点：

- 分压器更容易且成本更低制作
- 功耗较低
