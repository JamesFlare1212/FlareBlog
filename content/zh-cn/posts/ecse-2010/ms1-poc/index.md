---
title: ECSE 2010 Omega 实验室 MS1 概念验证
subtitle:
date: 2026-03-12T15:53:47-04:00
lastmod: 2026-03-12T15:53:47-04:00
slug: ecse-2010-ms1-poc
draft: false
author:
  name: James
  link: https://www.jamesflare.com
  email:
  avatar: /site-logo.avif
description: 本博客文章展示了 ECSE 2010 Omega 实验室 MS1 的综合概念验证，重点关注电子工程原理，如分压器、运算放大器作为比较器和 LED 控制电路。它包括详细的电路图、数学分析、LTSpice 仿真和实验测量，以验证理论概念。
keywords: ["分压器", "运算放大器", "比较器", "OP37", "光敏电阻", "电子工程", "电路分析", "LTSpice", "仿真", "测量"]
license:
comment: true
weight: 0
tags:
  - ECSE 2010
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
summary: 本博客文章展示了 ECSE 2010 Omega 实验室 MS1 的综合概念验证，重点关注电子工程原理，如分压器、运算放大器作为比较器和 LED 控制电路。它包括详细的电路图、数学分析、LTSpice 仿真和实验测量，以验证理论概念。
resources:
  - name: featured-image
    src: featured-image.jpg
  - name: featured-image-preview
    src: featured-image-preview.jpg
toc: true
math: true
lightgallery: false
password:
message:
repost:
  enable: false
  url:

# See details front matter: https://fixit.lruihao.cn/documentation/content-management/introduction/#front-matter
---

<!--more-->

## 分压器电路

### 电路图

{{< image src="figure-1-1.png" caption="图 1.1 - 电路图" width=600px >}}

### 描述

我们设计了两个分压器电路。一个用于将 12V 电源转换为后续电压比较器的 6V 参考电压（$V_{ref}$）；另一个用于生成电压比较器的输入电压（$V_{in}$）。该输入电压通过分压器电路由光敏电阻（LDR）的电阻值决定。

### 分析

计算 $V_{ref}$，已知

- $V_{bus} = 12 \text{ V}$
- $R_1 = 1\text{ k} \Omega$
- $R_2 = 1\text{ k} \Omega$

#### 步骤 1：计算该支路的总串联电阻

$$
R_{total} = R_1 + R_2 = 1k + 1k = 2\text{ k}\Omega
$$

#### 步骤 2：支路电流（欧姆定律）

$$
I = \frac{V}{R_{total}} = \frac{12}{2000} = 0.006\text{ A} = 6\text{ mA}
$$

#### 步骤 3：中点电压（$V_{ref}$）

$V_{ref}$ 是 $R_2$ 两端的电压（因为它是从中点到地的电阻）：
$$
V_{ref} = I \cdot R_2 = (6\text{ mA})(1\text{ k}\Omega) = \boxed{6\text{ V}}
$$

或者：$V_{ref}=12\cdot \frac{R_2}{R_1+R_2}=12\cdot \frac{1}{2}=6\text{ V}$

---

计算 $V_{in}$，已知：

- $V_{bus} = 12\text{ V}$
- $R_3 = 1\text{ k}\Omega$
- $R_{LDR} = 2\text{ k}\Omega$

#### 步骤 1：计算该支路的总串联电阻

$$
R_{total} = R_3 + R_{LDR} = 1k + 2k = 3\text{ k}\Omega
$$

#### 步骤 2：支路电流

$$
I = \frac{12}{3000} = 0.004\text{ A} = 4\text{ mA}
$$

#### 步骤 3：中点电压（$V_{in}$）

$V_{in}$ 是底部电阻（LDR）两端的电压：
$$
V_{in} = I \cdot R_{LDR} = (4\text{ mA})(2\text{ k}\Omega) = \boxed{8\text{ V}}
$$

或者：$V_{in}=12\cdot \frac{R_{LDR}}{R_3+R_{LDR}}=12\cdot \frac{2}{3}=8\text{ V}$

### 仿真

使用以下配置运行 LTSpice

{{< image src="figure-1-1.png" caption="图 1.2 - 仿真" width=600px >}}

我们得到以下结果

```text
       --- Operating Point ---
V(vbus): 12      voltage
V(vref): 6       voltage
V(vin):  8       voltage
I(R1):   0.006   device_current
I(R2):   0.006   device_current
I(R3):   0.004   device_current
I(Ldr):  0.004   device_current
I(V1):   -0.01   device_current
```

### 实验

使用以下设置

{{< image src="figure-1-2.avif" caption="图 1.3 - 实验" width=600px >}}

我们按初始设计使用 12V 直流电源供电。

{{< image src="figure-1-3.avif" caption="图 1.4 - 实验" width=600px >}}

然后测量得到 $V_{ref} = 6.066 \text{ V}$

{{< image src="figure-1-4.avif" caption="图 1.5 - 实验" width=600px >}}

以及 $V_{in} = 7.967 \text{ V}$

{{< image src="figure-1-5.avif" caption="图 1.6 - 实验" width=600px >}}

### 讨论

以下是**手工计算**、**LTspice**和**台架测量**的对比，以及测量值与设计目标的**百分比误差**。

| 节点      | 设计值（计算） | LTspice 工作点 | 测量值 | 绝对误差（测量 − 设计） | % 误差 |
| --------- | ------------: | ---------------: | -------: | -------------------------: | ------: |
| $V_{ref}$ |       6.000 V |          6.000 V |  6.066 V |                   +0.066 V |  +1.10% |
| $V_{in}$  |       8.000 V |          8.000 V |  7.967 V |                   −0.033 V |  −0.41% |

两个测量电压都非常接近理想分压器预测值（约**±1.1%**以内）。LTspice 完全匹配，因为它使用理想元件值，除非添加公差。

为什么测量值与理想值不同（最可能的原因）

1. **电阻公差（$V_{ref}$ 的主要误差源）**
   使用两个"1 kΩ"电阻时，仅当 $R_1=R_2$ 时，$V_{ref}$ 才*恰好*为 6 V。
   如果 $V_{bus}=12\text{ V}$ 精确，我测量的 $V_{ref}=6.066\text{ V}$ 意味着比率略有偏差：
   $$
   \frac{R_2}{R_1}\approx 1.022
   $$
   $R_2$ 比 $R_1$ 大约 2.2%，对于常见的 5% 电阻（甚至 1% 电阻取决于配对）完全合理。

2. **LDR 不是固定的 2 kΩ（随光照和温度变化）**
   使用我测量的 $V_{in}=7.967\text{ V}$，$R_3=1k\Omega$，和 $V_{bus}=12\text{ V}$，推断的 LDR 值为：
   $$
   R_{LDR} = R_3\frac{V_{in}}{V_{bus}-V_{in}} \approx 1k\cdot\frac{7.967}{12-7.967}\approx 1.98k\Omega
   $$
   因此，测量时 LDR 的值基本上为**~1.98 kΩ**，这解释了为什么 $V_{in}$ 非常接近 8 V。

## 运算放大器作为比较器

### 电路图

{{< image src="figure-2-1.png" caption="图 2.1 - 电路图" width=600px >}}

### 描述

这部分是一个电压比较器。之前由分压器电路生成的 6V 参考电压与信号一起输入到 OP37 运算放大器。一旦包含 LDR 的分压器电路的信号输出超过 6V，最终输出变为高电平（点亮 LED），反之亦然。

### 分析

#### 步骤 1：使用分压器结果（运放的输入）

根据我之前的值（并假设理想运放输入不汲取电流，因此分压器不会被加载）：

- 来自 $R_1=1k$ 和 $R_2=1k$ 的 $V_{ref}$：
  $$
  V_{ref}=12\cdot \frac{1k}{1k+1k}=12\cdot\frac12=6\text{ V}
  $$

- 来自 $R_3=1k$ 和 $\text{LDR}=2k$ 的 $V_{in}$：
  $$
  V_{in}=12\cdot \frac{2k}{1k+2k}=12\cdot\frac{2}{3}=8\text{ V}
  $$

#### 步骤 2：比较运放输入极性

根据图中的连接：

- 顶部输入是"−"（反相端），连接到 $V_{ref}$
- 底部输入是"+"（同相端），连接到 $V_{in}$

因此：
$$
V_+ = V_{in} = 8\text{ V},\quad V_- = V_{ref} = 6\text{ V}
$$

#### 步骤 3：理想运放输出行为（开环比较器）

对于理想运放（无限开环增益）：

* 如果 $V_+ > V_-$ ⇒ 输出驱动到正电源轨
* 如果 $V_+ < V_-$ ⇒ 输出驱动到负电源轨

此处：
$$
V_+ - V_- = 8 - 6 = 2\text{ V} > 0
$$
因此输出变为高电平。

#### 步骤 4：输出电源轨值

运放供电为：

- $+V = V_{bus} = 12\text{ V}$
- $-V = 0\text{ V（地）}$

因此，仅基于理想运放：
$$
\boxed{V_{out} = 12\text{ V（高电平）}}
$$

*实际的 OP37 行为可能无法完全摆到电源轨。*

### 仿真

{{< image src="figure-2-1.png" caption="图 2.1 - 仿真" width=600px >}}

```text
         --- Operating Point ---
V(vbus):      12                 voltage
V(vref):      6.57209            voltage
V(vin):       7.23722            voltage
V(vout):      11.1378            voltage
I(R1):        0.00542791         device_current
I(R2):        0.00657209         device_current
I(R3):        0.00476279         device_current
I(Ldr):       0.00361861         device_current
I(V1):        -0.0127152         device_current
Ix(u1:1):     0.00114418         subckt_current
Ix(u1:2):     -0.00114418        subckt_current
Ix(u1:3):     0.00252446         subckt_current
Ix(u1:4):     -0.00253246        subckt_current
Ix(u1:5):     -1.02757e-11       subckt_current
````

### 实验

使用以下设置

{{< image src="figure-2-2.avif" caption="图 2.2 - 实验" width=600px >}}

我们按初始设计使用 12V 直流电源供电。

{{< image src="figure-1-3.avif" caption="图 2.3 - 实验" width=600px >}}

然后测量得到 $V_{out} = 11.454 \text{ V}$

{{< image src="figure-2-3.avif" caption="图 2.4 - 实验" width=600px >}}

### 讨论

以下是 OP37 用作比较器时的计算值与 LTspice 值与测量值对比，以及%误差。

#### 比较器节点电压（含误差%）

| 节点 | 理想值 | LTspice 工作点 | 测量值 | 绝对误差 | % 误差 | % 误差 |
| ---- | ----: | ---------------: | -------: | ---------: | ------: | ------: |
| $V_{ref}$ | 6.000 V  | 6.572 V  | — | — | — | — |
| $V_{in}$  | 8.000 V  | 7.237 V  | — | — | — | — |
| $V_{out}$ | 12.000 V | 11.138 V | 11.454 V | +0.316 V | +2.84% | −4.55% |

这说明：

- 我测量的输出非常接近 LTspice OP37 模型（仅比仿真高 2.84%）。
- 输出低于 12 V，因为 OP37 不是轨到轨输出，且输出摆幅取决于负载电流和裕度。

---

#### 为什么 LTspice 显示"奇怪"的 $V_{ref}$ 和 $V_{in}$（6.57 V 和 7.24 V）

在理想比较器假设下，输入汲取的电流约为 0，因此分压器保持在恰好 6 V 和 8 V。

但我的 LTspice 工作点报告显示：

- $I(R1)=5.4279 \text{ mA}$ 而 $I(R2)=6.5721 \text{ mA}$
- $I(R3)=4.7628 \text{ mA}$ 而 $I(LDR)=3.6186 \text{ mA}$

这些不匹配意味着分压器中点被加载，加载量为：

$$
I_{\text{load}} \approx 6.5721 - 5.4279 = 1.1442\ \text{mA}
$$
（另一个分压器上也出现相同的 1.1442 mA）

---

#### 输入钳位效应

OP37 在其输入之间具有背对背输入保护二极管，如果差分输入超过 ~0.7 V，这些二极管会导通，您必须限制电流。

理想差分应为：
$$
V_{in}-V_{ref} = 8-6 = 2\text{ V}
$$
这远高于 ~0.7 V，因此在实际器件（和许多宏模型）中，输入保护网络可以导通并有效地将两个输入节点相互拉近，这正是我的仿真显示的：

- LTspice 差分变为
  $$
  7.237 - 6.572 = 0.665\text{ V}
  $$
  正好在二极管钳位区域附近

由于我的分压器电阻仅为 1 kΩ，即使 ~mA 的钳位电流也会使节点电压移动数百 mV，解释了 $V_{ref}$ 和 $V_{in}$ 中约 $\pm 0.57\text{ V}$ 的移动。

---

#### 总结

- **比较器输出行为正确**：由于 $V_{in} > V_{ref}$，OP37 将 $V_{out}$ 驱动为高电平，我测量得到 $11.454\text{ V}$，接近仿真的 $11.138\text{ V}$（2.84% 误差）。
- **输出未达到 12 V**，因为 OP37 输出摆幅受限（非轨到轨），且取决于负载/裕度。
- **LTspice 显示输入节点移动**，因为在开环比较器使用中，输入差分可能超过内部保护二极管阈值；然后模型允许输入钳位电流（~1.14 mA），这加载了 1 kΩ分压器并使 $V_{ref}$ 上升、$V_{in}$ 下降。
