---
title: MATH 2010 考试 2 复习题
subtitle:
date: 2026-03-08T10:02:10-04:00
lastmod: 2026-03-08T10:02:10-04:00
slug: math-2010-exam-2
draft: false
author:
  name: James
  link: https://www.jamesflare.com
  email:
  avatar: /site-logo.avif
description: MATH 2010 考试 2 复习题和解答
keywords:
license:
comment: true
weight: 0
tags:
  - RPI
  - 考试
  - MATH-2010
categories:
  - Electrical Engineering
collections:
  - MATH-2010
hiddenFromHomePage: false
hiddenFromSearch: false
hiddenFromRss: false
hiddenFromRelated: false
summary: MATH 2010 考试 2 复习题和解答
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

## 概述

考试 #2 将于 3 月 11 日星期三在 Test Block 进行，涵盖所有多元微积分内容。考试将更侧重于考试 1 之后讲授的材料（**15.1、15.2、15.3、15.4、16.1、16.2、16.3 和 17.1 节**），但你应准备好回答来自考试 1 所涵盖的任何章节的问题（14.3、14.4、14.5、14.6、14.7 和 14.8 节）。

如果你提交了带有考试便利条件的 ANSS 备忘录，将通过电子邮件与你联系，告知你考试的替代地点详情。只有在 3 月 9 日星期一晚上 5 点之前通过电子邮件向讲师发送了便利条件备忘录的学生才能在考试 2 中使用他们的考试便利条件。

你将有 70 分钟完成考试。学生必须准时到达并听取关于座位要求的指示。学生必须将所有物品（背包、夹克和手机）留在考试室前部的墙边。不要阻挡任何出口或阻碍任何通道。如果你在考试开始后到达，将不会给你额外时间完成考试。学生将被要求签到，并且会收集的考试将与签到表进行交叉检查。未签到的学生的考试将不予评分。

## 问题

### Q1. 二元积分

> 计算 $\iint_D xy \, dA$，其中 $D$ 是由曲线 $y=x$ 和 $y=\sqrt{x}$ 围成的区域。

{{< details summary="**本题答案**" >}}
要计算二重积分 $\iint_D xy \, dA$，我们首先需要确定积分区域 $D$ 并设置累次积分。

**1. 确定区域 $D$**

区域 $D$ 由曲线 $y = x$ 和 $y = \sqrt{x}$ 围成。为了找到这些曲线的交点，我们将方程设为相等：
$$
x = \sqrt{x}
$$
两边平方得：
$$
x^2 = x \implies x^2 - x = 0 \implies x(x - 1) = 0
$$
因此，交点出现在 $x = 0$ 和 $x = 1$ 处。对应的 $y$ 值为 $y=0$ 和 $y=1$，得到点 $(0,0)$ 和 $(1,1)$。

在区间 $0 < x < 1$ 上，我们有 $\sqrt{x} > x$。因此，区域 $D$ 可以描述为：
$$
D = \{ (x, y) \mid 0 \le x \le 1, \, x \le y \le \sqrt{x} \}
$$

**2. 设置积分**

我们可以将二重积分表示为关于 $y$ 先积分、然后关于 $x$ 积分的累次积分：
$$
\iint_D xy \, dA = \int_0^1 \int_x^{\sqrt{x}} xy \, dy \, dx
$$

**3. 计算内层积分**

首先，关于 $y$ 积分，将 $x$ 视为常数：
$$
\int_x^{\sqrt{x}} xy \, dy = x \left[ \frac{y^2}{2} \right]_{y=x}^{y=\sqrt{x}}
$$
代入积分限：
$$
= x \left( \frac{(\sqrt{x})^2}{2} - \frac{x^2}{2} \right) = x \left( \frac{x}{2} - \frac{x^2}{2} \right) = \frac{x^2}{2} - \frac{x^3}{2}
$$

**4. 计算外层积分**

现在，将结果从 $0$ 到 $1$ 关于 $x$ 积分：
$$
\int_0^1 \left( \frac{x^2}{2} - \frac{x^3}{2} \right) dx = \left[ \frac{x^3}{6} - \frac{x^4}{8} \right]_0^1
$$
在边界处求值：
$$
= \left( \frac{1^3}{6} - \frac{1^4}{8} \right) - (0 - 0) = \frac{1}{6} - \frac{1}{8}
$$
找到公分母：
$$
= \frac{4}{24} - \frac{3}{24} = \frac{1}{24}
$$

**最终答案**

$$
\iint_D xy \, dA = \frac{1}{24}
$$
{{< /details >}}

### Q2. 极坐标积分

> 使用极坐标计算积分 $\iint_D (x^2+y^2) \, dA$，其中 $D$ 是由圆 $x^2+y^2=4$、$x^2+y^2=9$ 以及 $x \ge 0, y \ge 0$ 围成的区域。

{{< details summary="**本题答案**" >}}
要使用极坐标计算积分 $\iint_D (x^2+y^2) \, dA$，我们按以下步骤进行。

**1. 坐标变换**
我们从笛卡尔坐标 $(x, y)$ 转换到极坐标 $(r, \theta)$，使用关系：
$$
x = r \cos \theta, \quad y = r \sin \theta
$$
因此，项 $x^2 + y^2$ 变为 $r^2$，面积元素 $dA$ 变为 $r \, dr \, d\theta$。

**2. 确定积分区域**
区域 $D$ 由圆 $x^2+y^2=4$ 和 $x^2+y^2=9$ 围成，约束条件为 $x \ge 0$ 和 $y \ge 0$。
- 圆的方程转换为 $r^2 = 4 \implies r = 2$ 和 $r^2 = 9 \implies r = 3$。因此，径向范围为 $2 \le r \le 3$。
- 约束 $x \ge 0$ 和 $y \ge 0$ 将区域限制在第一象限，对应于 $0 \le \theta \le \frac{\pi}{2}$。

因此，极坐标中的区域 $D$ 定义为：
$$
D = \left\{ (r, \theta) \mid 2 \le r \le 3, \, 0 \le \theta \le \frac{\pi}{2} \right\}
$$

**3. 设置积分**
将被积函数和微分元素代入二重积分：
$$
\iint_D (x^2+y^2) \, dA = \int_0^{\pi/2} \int_2^3 (r^2) \cdot r \, dr \, d\theta = \int_0^{\pi/2} \int_2^3 r^3 \, dr \, d\theta
$$

**4. 计算积分**
首先，计算关于 $r$ 的内层积分：
$$
\int_2^3 r^3 \, dr = \left[ \frac{r^4}{4} \right]_2^3 = \frac{3^4}{4} - \frac{2^4}{4} = \frac{81}{4} - \frac{16}{4} = \frac{65}{4}
$$
然后，计算关于 $\theta$ 的外层积分：
$$
\int_0^{\pi/2} \frac{65}{4} \, d\theta = \frac{65}{4} \Big[ \theta \Big]_0^{\pi/2} = \frac{65}{4} \left( \frac{\pi}{2} - 0 \right) = \frac{65\pi}{8}
$$

**最终答案**
$$
\iint_D (x^2+y^2) \, dA = \frac{65\pi}{8}
$$
{{< /details>}}

### Q3. 极坐标积分

> 通过转换为极坐标，计算 $f(x,y) = (x^2+y^2)^{-3/2}$ 在区域 $D$（由 $x^2+y^2 \le 16, x+y \ge 4$ 给出）上的积分。

{{< details summary="**本题答案**" >}}
要使用极坐标计算 $f(x,y) = (x^2+y^2)^{-3/2}$ 在区域 $D$ 上的积分，我们按以下步骤进行。

**1. 理解区域 $D$**

区域 $D$ 由两个条件定义：
- $x^2+y^2 \le 16$：这是以原点为中心、半径为 4 的圆盘。
- $x+y \ge 4$：这是直线 $x+y=4$ 上方的半平面。

区域 $D$ 是位于直线 $x+y=4$ 上方的圆盘部分。

**2. 找到交点**

为了找到直线 $x+y=4$ 与圆 $x^2+y^2=16$ 的交点，我们将 $y = 4-x$ 代入圆方程：
$$
x^2 + (4-x)^2 = 16
$$
$$
x^2 + 16 - 8x + x^2 = 16
$$
$$
2x^2 - 8x = 0 \implies 2x(x-4) = 0
$$
因此，$x = 0$ 或 $x = 4$。交点为 $(0, 4)$ 和 $(4, 0)$。

**3. 转换为极坐标**

使用极坐标：
- $x = r \cos \theta$
- $y = r \sin \theta$
- $x^2 + y^2 = r^2$
- $dA = r \, dr \, d\theta$

被积函数变为：
$$
(x^2+y^2)^{-3/2} = (r^2)^{-3/2} = r^{-3}
$$

**4. 确定边界**

- **径向边界：** 从直线 $x+y=4$，我们有 $r(\cos\theta + \sin\theta) = 4$，所以 $r = \frac{4}{\cos\theta + \sin\theta}$。从圆，$r = 4$。因此，$\frac{4}{\cos\theta + \sin\theta} \le r \le 4$。
- **角边界：** 交点 $(4, 0)$ 和 $(0, 4)$ 分别对应 $\theta = 0$ 和 $\theta = \frac{\pi}{2}$。因此，$0 \le \theta \le \frac{\pi}{2}$。

**5. 设置积分**

$$
\iint_D (x^2+y^2)^{-3/2} \, dA = \int_0^{\pi/2} \int_{\frac{4}{\cos\theta + \sin\theta}}^4 r^{-3} \cdot r \, dr \, d\theta
$$
$$
= \int_0^{\pi/2} \int_{\frac{4}{\cos\theta + \sin\theta}}^4 r^{-2} \, dr \, d\theta
$$

**6. 计算内层积分**

$$
\int_{\frac{4}{\cos\theta + \sin\theta}}^4 r^{-2} \, dr = \left[ -\frac{1}{r} \right]_{\frac{4}{\cos\theta + \sin\theta}}^4
$$
$$
= -\frac{1}{4} - \left( -\frac{\cos\theta + \sin\theta}{4} \right) = \frac{\cos\theta + \sin\theta - 1}{4}
$$

**7. 计算外层积分**

$$
\int_0^{\pi/2} \frac{\cos\theta + \sin\theta - 1}{4} \, d\theta = \frac{1}{4} \int_0^{\pi/2} (\cos\theta + \sin\theta - 1) \, d\theta
$$
$$
= \frac{1}{4} \left[ \sin\theta - \cos\theta - \theta \right]_0^{\pi/2}
$$
$$
= \frac{1}{4} \left[ \left( \sin\frac{\pi}{2} - \cos\frac{\pi}{2} - \frac{\pi}{2} \right) - \left( \sin 0 - \cos 0 - 0 \right) \right]
$$
$$
= \frac{1}{4} \left[ (1 - 0 - \frac{\pi}{2}) - (0 - 1 - 0) \right]
$$
$$
= \frac{1}{4} \left[ 1 - \frac{\pi}{2} + 1 \right] = \frac{1}{4} \left[ 2 - \frac{\pi}{2} \right]
$$
$$
= \frac{1}{2} - \frac{\pi}{8}
$$

**最终答案**

$$
\iint_D (x^2+y^2)^{-3/2} \, dA = \frac{1}{2} - \frac{\pi}{8}
$$
{{< /details>}}

### Q4. 三重积分

> 计算 $\iiint_B (xz + yz^2) \, dV$，其中 $B = [0,1] \times [2,4] \times [0,2]$。

{{< details summary="**本题答案**" >}}
要计算三重积分 $\iiint_B (xz + yz^2) \, dV$，其中 $B = [0,1] \times [2,4] \times [0,2]$，我们根据矩形盒 $B$ 的边界设置累次积分。

**1. 设置积分**

区域 $B$ 由以下不等式定义：
$$
0 \le x \le 1, \quad 2 \le y \le 4, \quad 0 \le z \le 2
$$
我们可以将三重积分写为累次积分。对于矩形盒，积分顺序不重要，但我们将按 $z$、然后 $y$、然后 $x$ 的顺序积分：
$$
\iiint_B (xz + yz^2) \, dV = \int_0^1 \int_2^4 \int_0^2 (xz + yz^2) \, dz \, dy \, dx
$$

**2. 计算内层积分（关于 $z$）**

首先，关于 $z$ 积分，将 $x$ 和 $y$ 视为常数：
$$
\int_0^2 (xz + yz^2) \, dz = \left[ x \frac{z^2}{2} + y \frac{z^3}{3} \right]_{z=0}^{z=2}
$$
代入极限 $z=2$ 和 $z=0$：
$$
= \left( x \frac{2^2}{2} + y \frac{2^3}{3} \right) - 0 = 2x + \frac{8y}{3}
$$

**3. 计算中层积分（关于 $y$）**

接下来，将结果从 $2$ 到 $4$ 关于 $y$ 积分，将 $x$ 视为常数：
$$
\int_2^4 \left( 2x + \frac{8y}{3} \right) \, dy = \left[ 2xy + \frac{8}{3} \cdot \frac{y^2}{2} \right]_{y=2}^{y=4}
$$
简化含 $y^2$ 的项：
$$
= \left[ 2xy + \frac{4y^2}{3} \right]_{y=2}^{y=4}
$$
在边界处求值：
$$
= \left( 2x(4) + \frac{4(4)^2}{3} \right) - \left( 2x(2) + \frac{4(2)^2}{3} \right)
$$
$$
= \left( 8x + \frac{64}{3} \right) - \left( 4x + \frac{16}{3} \right)
$$
$$
= 4x + \frac{48}{3} = 4x + 16
$$

**4. 计算外层积分（关于 $x$）**

最后，关于 $x$ 从 $0$ 到 $1$ 积分：
$$
\int_0^1 (4x + 16) \, dx = \left[ 2x^2 + 16x \right]_0^1
$$
在边界处求值：
$$
= (2(1)^2 + 16(1)) - 0 = 2 + 16 = 18
$$

**最终答案**

$$
\iiint_B (xz + yz^2) \, dV = 18
$$
{{< /details>}}

### Q5. 三重积分

> 计算 $\iiint_W 66z \, dV$，其中 $W: x^2 \le y \le 1, 0 \le x \le 1, x-y \le z \le x+y$

{{< details summary="**本题答案**" >}}
要计算区域 $W$ 上的三重积分 $\iiint_W 66z \, dV$，我们首先需要根据给定的不等式确定积分限。

**1. 确定积分区域**

区域 $W$ 定义为：
- $0 \le x \le 1$
- $x^2 \le y \le 1$
- $x-y \le z \le x+y$

我们可以按 $dz \, dy \, dx$ 的顺序设置累次积分：
$$
\iiint_W 66z \, dV = \int_0^1 \int_{x^2}^1 \int_{x-y}^{x+y} 66z \, dz \, dy \, dx
$$

**2. 计算内层积分（关于 $z$）**

首先，关于 $z$ 积分，将 $x$ 和 $y$ 视为常数：
$$
\int_{x-y}^{x+y} 66z \, dz = 66 \left[ \frac{z^2}{2} \right]_{x-y}^{x+y} = 33 \left[ z^2 \right]_{x-y}^{x+y}
$$
代入极限：
$$
= 33 \left( (x+y)^2 - (x-y)^2 \right)
$$
使用恒等式 $(a+b)^2 - (a-b)^2 = 4ab$，其中 $a=x$ 且 $b=y$：
$$
= 33 (4xy) = 132xy
$$

**3. 计算中层积分（关于 $y$）**

现在，将结果从 $x^2$ 到 $1$ 关于 $y$ 积分，将 $x$ 视为常数：
$$
\int_{x^2}^1 132xy \, dy = 132x \int_{x^2}^1 y \, dy
$$
$$
= 132x \left[ \frac{y^2}{2} \right]_{x^2}^1 = 132x \left( \frac{1^2}{2} - \frac{(x^2)^2}{2} \right)
$$
$$
= 132x \left( \frac{1}{2} - \frac{x^4}{2} \right) = 66x (1 - x^4) = 66x - 66x^5
$$

**4. 计算外层积分（关于 $x$）**

最后，关于 $x$ 从 $0$ 到 $1$ 积分：
$$
\int_0^1 (66x - 66x^5) \, dx = 66 \int_0^1 (x - x^5) \, dx
$$
$$
= 66 \left[ \frac{x^2}{2} - \frac{x^6}{6} \right]_0^1
$$
在边界处求值：
$$
= 66 \left( \left( \frac{1}{2} - \frac{1}{6} \right) - 0 \right)
$$
为分数找到公分母：
$$
= 66 \left( \frac{3}{6} - \frac{1}{6} \right) = 66 \left( \frac{2}{6} \right) = 66 \left( \frac{1}{3} \right) = 22
$$

**最终答案**

$$
\iiint_W 66z \, dV = 22
$$
{{< /details>}}

### Q6. 向量场

> 如果 $\vec{F} = \langle xy, e^{2y+3z}, x^2+z^2 \rangle$，求 $\text{div}(\vec{F})$ 和 $\text{curl}(\vec{F})$。

{{< details summary="**本题答案**" >}}
设向量场为 $\vec{F} = \langle P, Q, R \rangle$，其中：
$$
P = xy, \quad Q = e^{2y+3z}, \quad R = x^2+z^2
$$

**1. 计算散度**

$\vec{F}$ 的散度由 del 算子 $\nabla$ 与向量场 $\vec{F}$ 的点积给出：
$$
\text{div}(\vec{F}) = \nabla \cdot \vec{F} = \frac{\partial P}{\partial x} + \frac{\partial Q}{\partial y} + \frac{\partial R}{\partial z}
$$

我们计算偏导数：
$$
\frac{\partial P}{\partial x} = \frac{\partial}{\partial x}(xy) = y
$$
$$
\frac{\partial Q}{\partial y} = \frac{\partial}{\partial y}(e^{2y+3z}) = 2e^{2y+3z}
$$
$$
\frac{\partial R}{\partial z} = \frac{\partial}{\partial z}(x^2+z^2) = 2z
$$

将这些相加，我们得到：
$$
\text{div}(\vec{F}) = y + 2e^{2y+3z} + 2z
$$

**2. 计算旋度**

$\vec{F}$ 的旋度由 del 算子 $\nabla$ 与向量场 $\vec{F}$ 的叉积给出：
$$
\text{curl}(\vec{F}) = \nabla \times \vec{F} = \begin{vmatrix} \mathbf{i} & \mathbf{j} & \mathbf{k} \\ \frac{\partial}{\partial x} & \frac{\partial}{\partial y} & \frac{\partial}{\partial z} \\ P & Q & R \end{vmatrix}
$$
$$
= \left\langle \frac{\partial R}{\partial y} - \frac{\partial Q}{\partial z}, \frac{\partial P}{\partial z} - \frac{\partial R}{\partial x}, \frac{\partial Q}{\partial x} - \frac{\partial P}{\partial y} \right\rangle
$$

我们计算必要的偏导数：
- 对于 $\mathbf{i}$-分量：
  $$
  \frac{\partial R}{\partial y} = 0, \quad \frac{\partial Q}{\partial z} = 3e^{2y+3z} \implies 0 - 3e^{2y+3z} = -3e^{2y+3z}
  $$
- 对于 $\mathbf{j}$-分量：
  $$
  \frac{\partial P}{\partial z} = 0, \quad \frac{\partial R}{\partial x} = 2x \implies 0 - 2x = -2x
  $$
- 对于 $\mathbf{k}$-分量：
  $$
  \frac{\partial Q}{\partial x} = 0, \quad \frac{\partial P}{\partial y} = x \implies 0 - x = -x
  $$

因此，旋度为：
$$
\text{curl}(\vec{F}) = \langle -3e^{2y+3z}, -2x, -x \rangle
$$

**最终答案**

$$
\text{div}(\vec{F}) = y + 2e^{2y+3z} + 2z
$$
$$
\text{curl}(\vec{F}) = \langle -3e^{2y+3z}, -2x, -x \rangle
$$
{{< /details>}}

### Q7. 标量线积分

> 计算 $\int_C \sqrt{1+36xy} \, ds$，其中 $C$ 是从 $(0,0)$ 到 $(1,4)$ 的曲线 $y=4x^3$。

{{< details summary="**本题答案**" >}}
要计算线积分 $\int_C \sqrt{1+36xy} \, ds$，我们需要参数化曲线 $C$，确定弧长元素 $ds$，然后计算定积分。

**1. 参数化曲线 $C$**

曲线 $C$ 由函数 $y = 4x^3$ 给出，从点 $(0,0)$ 到 $(1,4)$。我们可以使用 $x$ 作为参数。
设 $x = t$。则 $y = 4t^3$。
$x$ 的范围从 $0$ 到 $1$，因此参数 $t$ 的范围从 $0$ 到 $1$。
$$
\vec{r}(t) = \langle t, 4t^3 \rangle, \quad 0 \le t \le 1
$$

**2. 计算弧长元素 $ds$**

微分弧长 $ds$ 由下式给出：
$$
ds = \sqrt{\left(\frac{dx}{dt}\right)^2 + \left(\frac{dy}{dt}\right)^2} \, dt
$$
首先，计算关于 $t$ 的导数：
$$
\frac{dx}{dt} = 1, \quad \frac{dy}{dt} = 12t^2
$$
将这些代入 $ds$ 的公式：
$$
ds = \sqrt{(1)^2 + (12t^2)^2} \, dt = \sqrt{1 + 144t^4} \, dt
$$

**3. 用 $t$ 表示被积函数**

被积函数是 $f(x,y) = \sqrt{1+36xy}$。代入 $x=t$ 和 $y=4t^3$：
$$
\sqrt{1+36(t)(4t^3)} = \sqrt{1 + 144t^4}
$$

**4. 设置并计算积分**

现在，将被积函数和 $ds$ 代入线积分：
$$
\int_C \sqrt{1+36xy} \, ds = \int_0^1 \sqrt{1 + 144t^4} \cdot \sqrt{1 + 144t^4} \, dt
$$
两个平方根项相乘形成根内的表达式：
$$
= \int_0^1 (1 + 144t^4) \, dt
$$
现在，计算定积分：
$$
= \left[ t + 144 \frac{t^5}{5} \right]_0^1
$$
$$
= \left( 1 + \frac{144}{5} \right) - (0 + 0)
$$
$$
= \frac{5}{5} + \frac{144}{5} = \frac{149}{5}
$$

**最终答案**

$$
\int_C \sqrt{1+36xy} \, ds = \frac{149}{5}
$$
{{< /details>}}

### Q8. 向量线积分

> 如果 $\vec{F} = \langle xy, 3, z^3 \rangle$ 且 $C$ 是由 $\vec{r}(t) = \langle \cos t, \sin t, t \rangle$ 参数化的曲线，$0 \le t \le \pi$，计算 $\int_C \vec{F} \cdot d\vec{r}$。
> 注意：$\vec{F}$ 不是保守场。你怎么知道？

{{< details summary="**本题答案**" >}}
首先处理注意部分，我们通过计算旋度来确定向量场 $\vec{F}$ 是否为保守场。

**1. $\vec{F}$ 是否为保守场？**

向量场 $\vec{F} = \langle P, Q, R \rangle$ 是保守场的充要条件是 $\text{curl}(\vec{F}) = \vec{0}$（假设定义域是单连通的）。
给定 $\vec{F} = \langle xy, 3, z^3 \rangle$，我们有 $P = xy$、$Q = 3$ 和 $R = z^3$。
旋度由下式给出：
$$
\text{curl}(\vec{F}) = \nabla \times \vec{F} = \left\langle \frac{\partial R}{\partial y} - \frac{\partial Q}{\partial z}, \frac{\partial P}{\partial z} - \frac{\partial R}{\partial x}, \frac{\partial Q}{\partial x} - \frac{\partial P}{\partial y} \right\rangle
$$
计算分量：
- $\frac{\partial R}{\partial y} - \frac{\partial Q}{\partial z} = 0 - 0 = 0$
- $\frac{\partial P}{\partial z} - \frac{\partial R}{\partial x} = 0 - 0 = 0$
- $\frac{\partial Q}{\partial x} - \frac{\partial P}{\partial y} = 0 - x = -x$

因此，
$$
\text{curl}(\vec{F}) = \langle 0, 0, -x \rangle
$$
由于 $\text{curl}(\vec{F}) \neq \vec{0}$（具体来说，$z$-分量为 $-x$，不恒为零），因此向量场**不是保守场**。这就是为什么我们不能使用线积分基本定理而必须直接计算积分的原因。

**2. 计算线积分**

我们使用参数化 $\vec{r}(t) = \langle \cos t, \sin t, t \rangle$（$0 \le t \le \pi$）来计算 $\int_C \vec{F} \cdot d\vec{r}$。

**步骤 1：求 $d\vec{r}$**
$$
\vec{r}'(t) = \frac{d}{dt}\langle \cos t, \sin t, t \rangle = \langle -\sin t, \cos t, 1 \rangle
$$
$$
d\vec{r} = \vec{r}'(t) \, dt = \langle -\sin t, \cos t, 1 \rangle \, dt
$$

**步骤 2：在曲线上计算 $\vec{F}$**
将 $x = \cos t$、$y = \sin t$ 和 $z = t$ 代入 $\vec{F}$：
$$
\vec{F}(\vec{r}(t)) = \langle (\cos t)(\sin t), 3, t^3 \rangle = \langle \cos t \sin t, 3, t^3 \rangle
$$

**步骤 3：计算点积 $\vec{F} \cdot d\vec{r}$**
$$
\vec{F}(\vec{r}(t)) \cdot \vec{r}'(t) = (\cos t \sin t)(-\sin t) + (3)(\cos t) + (t^3)(1)
$$
$$
= -\cos t \sin^2 t + 3 \cos t + t^3
$$

**步骤 4：关于 $t$ 积分**
$$
\int_C \vec{F} \cdot d\vec{r} = \int_0^{\pi} \left( -\cos t \sin^2 t + 3 \cos t + t^3 \right) \, dt
$$
我们可以将其分为三个积分：
$$
= \int_0^{\pi} -\cos t \sin^2 t \, dt + \int_0^{\pi} 3 \cos t \, dt + \int_0^{\pi} t^3 \, dt
$$

- **第一个积分：** 设 $u = \sin t$，则 $du = \cos t \, dt$。极限从 $0 \to 0$ 和 $\pi \to 0$ 变化。
  $$
  \int_0^{\pi} -\sin^2 t \cos t \, dt = \left[ -\frac{\sin^3 t}{3} \right]_0^{\pi} = 0 - 0 = 0
  $$

- **第二个积分：**
  $$
  \int_0^{\pi} 3 \cos t \, dt = 3 [\sin t]_0^{\pi} = 3(0 - 0) = 0
  $$

- **第三个积分：**
  $$
  \int_0^{\pi} t^3 \, dt = \left[ \frac{t^4}{4} \right]_0^{\pi} = \frac{\pi^4}{4} - 0 = \frac{\pi^4}{4}
  $$

将这些结果相加：
$$
0 + 0 + \frac{\pi^4}{4} = \frac{\pi^4}{4}
$$

**最终答案**

$$
\int_C \vec{F} \cdot d\vec{r} = \frac{\pi^4}{4}
$$
{{< /details>}}

### Q9. 标量/向量线积分

> 设 $C$ 为从点 $(-2, 1, 0)$ 到点 $(-1, 2, 1)$ 的线段。设置以下积分。简化被积函数。
> - (a)  $\int_C f(x,y,z) \, ds$，其中 $f(x,y,z) = yz - x^2$  
> - (b)  $\int_C \vec{F} \cdot d\vec{r}$，其中 $\vec{F} = \langle 2x-y, 2z, y-z \rangle$

{{< details summary="**本题答案**" >}}
要解决这些积分，我们首先需要参数化线段 $C$。

**1. 参数化曲线 $C$**

曲线 $C$ 是从 $P_0 = (-2, 1, 0)$ 到 $P_1 = (-1, 2, 1)$ 的线段。
方向向量为 $\vec{v} = P_1 - P_0 = \langle -1 - (-2), 2 - 1, 1 - 0 \rangle = \langle 1, 1, 1 \rangle$。
我们可以使用 $t$（其中 $0 \le t \le 1$）参数化曲线：
$$
\vec{r}(t) = P_0 + t\vec{v} = \langle -2, 1, 0 \rangle + t\langle 1, 1, 1 \rangle = \langle -2+t, 1+t, t \rangle
$$
因此，坐标为：
$$
x(t) = -2+t, \quad y(t) = 1+t, \quad z(t) = t
$$
位置向量的导数为：
$$
\vec{r}'(t) = \langle 1, 1, 1 \rangle
$$
导数的模为：
$$
\|\vec{r}'(t)\| = \sqrt{1^2 + 1^2 + 1^2} = \sqrt{3}
$$
因此，微分弧长为 $ds = \sqrt{3} \, dt$，微分向量为 $d\vec{r} = \langle 1, 1, 1 \rangle \, dt$。

---

**a. 标量线积分**

我们需要设置 $\int_C f(x,y,z) \, ds$，其中 $f(x,y,z) = yz - x^2$。

**步骤 1：将参数化代入 $f$**
$$
f(\vec{r}(t)) = y(t)z(t) - (x(t))^2 = (1+t)(t) - (-2+t)^2
$$
**步骤 2：简化被积函数**
$$
= (t + t^2) - (4 - 4t + t^2)
$$
$$
= t + t^2 - 4 + 4t - t^2
$$
$$
= 5t - 4
$$
**步骤 3：设置积分**
$$
\int_C f(x,y,z) \, ds = \int_0^1 (5t - 4) \sqrt{3} \, dt
$$
**步骤 4：计算**
$$
= \sqrt{3} \int_0^1 (5t - 4) \, dt = \sqrt{3} \left[ \frac{5t^2}{2} - 4t \right]_0^1
$$
$$
= \sqrt{3} \left( \frac{5}{2} - 4 \right) = \sqrt{3} \left( -\frac{3}{2} \right) = -\frac{3\sqrt{3}}{2}
$$

---

**b. 向量线积分**

我们需要设置 $\int_C \vec{F} \cdot d\vec{r}$，其中 $\vec{F} = \langle 2x-y, 2z, y-z \rangle$。

**步骤 1：将参数化代入 $\vec{F}$**
$$
\vec{F}(\vec{r}(t)) = \langle 2(-2+t) - (1+t), \, 2(t), \, (1+t) - t \rangle
$$
**步骤 2：简化 $\vec{F}$ 的分量**
- $x$-分量：$2(-2+t) - (1+t) = -4 + 2t - 1 - t = t - 5$
- $y$-分量：$2t$
- $z$-分量：$1 + t - t = 1$
所以，$\vec{F}(\vec{r}(t)) = \langle t - 5, 2t, 1 \rangle$。

**步骤 3：计算点积 $\vec{F} \cdot \vec{r}'(t)$**
$$
\vec{F}(\vec{r}(t)) \cdot \vec{r}'(t) = \langle t - 5, 2t, 1 \rangle \cdot \langle 1, 1, 1 \rangle
$$
$$
= (t - 5)(1) + (2t)(1) + (1)(1)
$$
$$
= t - 5 + 2t + 1 = 3t - 4
$$
**步骤 4：设置积分**
$$
\int_C \vec{F} \cdot d\vec{r} = \int_0^1 (3t - 4) \, dt
$$
**步骤 5：计算**
$$
= \left[ \frac{3t^2}{2} - 4t \right]_0^1
$$
$$
= \left( \frac{3}{2} - 4 \right) - 0 = \frac{3}{2} - \frac{8}{2} = -\frac{5}{2}
$$

**最终答案**

a. $\displaystyle \int_C (yz - x^2) \, ds = \int_0^1 \sqrt{3}(5t - 4) \, dt = -\frac{3\sqrt{3}}{2}$  
b. $\displaystyle \int_C \vec{F} \cdot d\vec{r} = \int_0^1 (3t - 4) \, dt = -\frac{5}{2}$
{{< /details>}}

### Q10. 保守向量场

> 设 $\vec{F} = \langle 3+2xy, x^2-3y^2 \rangle$。
> - (a) 证明 $\vec{F}$ 是保守场，然后求 $\vec{F}$ 的一个势函数。
> - (b) 计算 $\int_C \vec{F} \cdot d\vec{r}$，其中 $C$ 由 $\vec{r}(t) = \langle e^t \sin t, e^t \cos t \rangle$ 给出，$0 \le t \le \pi$。

{{< details summary="**本题答案**" >}}
**a. 证明 $\vec{F}$ 是保守场并求势函数**

设 $\vec{F} = \langle P, Q \rangle$，其中 $P = 3+2xy$ 且 $Q = x^2-3y^2$。
$\vec{F}$ 在单连通域（如 $\mathbb{R}^2$）上为保守场的条件是 $\frac{\partial P}{\partial y} = \frac{\partial Q}{\partial x}$ 成立。

计算偏导数：
$$
\frac{\partial P}{\partial y} = \frac{\partial}{\partial y}(3+2xy) = 2x
$$
$$
\frac{\partial Q}{\partial x} = \frac{\partial}{\partial x}(x^2-3y^2) = 2x
$$
由于 $\frac{\partial P}{\partial y} = \frac{\partial Q}{\partial x}$，向量场 $\vec{F}$ 是保守场。

为了找到势函数 $f(x,y)$，使得 $\nabla f = \vec{F}$，我们求解方程组：
1. $\frac{\partial f}{\partial x} = 3+2xy$
2. $\frac{\partial f}{\partial y} = x^2-3y^2$

关于 $x$ 积分第一个方程：
$$
f(x,y) = \int (3+2xy) \, dx = 3x + x^2y + g(y)
$$
其中 $g(y)$ 是 $y$ 的任意函数。

现在，将此表达式关于 $y$ 求导并设为等于 $Q$：
$$
\frac{\partial f}{\partial y} = \frac{\partial}{\partial y}(3x + x^2y + g(y)) = x^2 + g'(y)
$$
$$
x^2 + g'(y) = x^2 - 3y^2
$$
$$
g'(y) = -3y^2
$$
关于 $y$ 积分：
$$
g(y) = \int -3y^2 \, dy = -y^3 + C
$$
因此，势函数为：
$$
f(x,y) = 3x + x^2y - y^3 + C
$$
我们可以选择 $C=0$ 以简化。

---

**b. 计算 $\int_C \vec{F} \cdot d\vec{r}$**

由于 $\vec{F}$ 是保守场，我们可以使用线积分基本定理：
$$
\int_C \vec{F} \cdot d\vec{r} = f(\text{终点}) - f(\text{起点})
$$
曲线 $C$ 由 $\vec{r}(t) = \langle e^t \sin t, e^t \cos t \rangle$ 参数化，$0 \le t \le \pi$。

找到起点（$t=0$）：
$$
\vec{r}(0) = \langle e^0 \sin 0, e^0 \cos 0 \rangle = \langle 0, 1 \rangle
$$
找到终点（$t=\pi$）：
$$
\vec{r}(\pi) = \langle e^\pi \sin \pi, e^\pi \cos \pi \rangle = \langle 0, -e^\pi \rangle
$$

在这些点处计算势函数 $f(x,y) = 3x + x^2y - y^3$：
在起点 $(0, 1)$ 处：
$$
f(0, 1) = 3(0) + 0^2(1) - 1^3 = -1
$$
在终点 $(0, -e^\pi)$ 处：
$$
f(0, -e^\pi) = 3(0) + 0^2(-e^\pi) - (-e^\pi)^3 = -(-e^{3\pi}) = e^{3\pi}
$$

计算积分：
$$
\int_C \vec{F} \cdot d\vec{r} = f(0, -e^\pi) - f(0, 1) = e^{3\pi} - (-1) = e^{3\pi} + 1
$$

**最终答案**

a. $\vec{F}$ 是保守场，因为 $\frac{\partial P}{\partial y} = \frac{\partial Q}{\partial x} = 2x$。一个势函数是 $f(x,y) = 3x + x^2y - y^3$。
b. $\displaystyle \int_C \vec{F} \cdot d\vec{r} = e^{3\pi} + 1$
{{< /details>}}

### Q11. 保守向量场

> 向量场 $\vec{F} = \langle 2xy-z, x^2+2y, 1-x \rangle$ 是保守场。
> - (a) 求 $\vec{F}$ 的一个势函数。
> - (b) 使用 (a) 中的势函数计算 $\int_C \vec{F} \cdot d\vec{r}$，其中 $C$ 是从 $(1, 0, 2)$ 到 $(2, 1, 3)$ 的任意曲线。

{{< details summary="**本题答案**" >}}
**a. 求 $\vec{F}$ 的势函数**

由于 $\vec{F}$ 是保守场，存在势函数 $f(x, y, z)$ 使得 $\nabla f = \vec{F}$。这意味着：
$$
\frac{\partial f}{\partial x} = 2xy - z, \quad \frac{\partial f}{\partial y} = x^2 + 2y, \quad \frac{\partial f}{\partial z} = 1 - x
$$

1. **关于 $x$ 积分：**
   $$
   f(x, y, z) = \int (2xy - z) \, dx = x^2y - xz + g(y, z)
   $$
   其中 $g(y, z)$ 是 $y$ 和 $z$ 的任意函数。

2. **关于 $y$ 求导并比较：**
   $$
   \frac{\partial f}{\partial y} = \frac{\partial}{\partial y}(x^2y - xz + g(y, z)) = x^2 + \frac{\partial g}{\partial y}
   $$
   将其与给定分量 $\frac{\partial f}{\partial y} = x^2 + 2y$ 比较，我们得到：
   $$
   x^2 + \frac{\partial g}{\partial y} = x^2 + 2y \implies \frac{\partial g}{\partial y} = 2y
   $$

3. **关于 $y$ 积分：**
   $$
   g(y, z) = \int 2y \, dy = y^2 + h(z)
   $$
   其中 $h(z)$ 是 $z$ 的任意函数。将此代回 $f$：
   $$
   f(x, y, z) = x^2y - xz + y^2 + h(z)
   $$

4. **关于 $z$ 求导并比较：**
   $$
   \frac{\partial f}{\partial z} = \frac{\partial}{\partial z}(x^2y - xz + y^2 + h(z)) = -x + h'(z)
   $$
   将其与给定分量 $\frac{\partial f}{\partial z} = 1 - x$ 比较，我们得到：
   $$
   -x + h'(z) = 1 - x \implies h'(z) = 1
   $$

5. **关于 $z$ 积分：**
   $$
   h(z) = \int 1 \, dz = z + C
   $$
   合并所有部分，势函数为：
   $$
   f(x, y, z) = x^2y - xz + y^2 + z + C
   $$
   我们可以设 $C=0$ 以简化。

---

**b. 计算 $\int_C \vec{F} \cdot d\vec{r}$**

根据线积分基本定理，由于 $\vec{F} = \nabla f$：
$$
\int_C \vec{F} \cdot d\vec{r} = f(\text{终点}) - f(\text{起点})
$$
曲线 $C$ 从 $A = (1, 0, 2)$ 到 $B = (2, 1, 3)$。

在 $B(2, 1, 3)$ 处计算 $f$：
$$
f(2, 1, 3) = (2)^2(1) - (2)(3) + (1)^2 + 3 = 4 - 6 + 1 + 3 = 2
$$

在 $A(1, 0, 2)$ 处计算 $f$：
$$
f(1, 0, 2) = (1)^2(0) - (1)(2) + (0)^2 + 2 = 0 - 2 + 0 + 2 = 0
$$

计算差值：
$$
\int_C \vec{F} \cdot d\vec{r} = 2 - 0 = 2
$$

**最终答案**

a. 一个势函数是 $f(x, y, z) = x^2y - xz + y^2 + z$。
b. $\displaystyle \int_C \vec{F} \cdot d\vec{r} = 2$
{{< /details>}}

### Q12. 格林定理

> 使用格林定理计算积分 $\oint_C xy^3 \, dx + x^2y^2 \, dy$，其中 $C$ 是顶点为 $(0,0), (2,0), (2,3), (0,3)$ 且逆时针定向的矩形。

{{< details summary="**本题答案**" >}}
要使用格林定理计算线积分，我们按以下步骤进行。

**1. 陈述格林定理**

格林定理将围绕简单闭曲线 $C$ 的线积分与由 $C$ 围成的平面区域 $D$ 上的二重积分联系起来。对于正定向（逆时针）曲线 $C$：
$$
\oint_C P \, dx + Q \, dy = \iint_D \left( \frac{\partial Q}{\partial x} - \frac{\partial P}{\partial y} \right) \, dA
$$

**2. 识别 $P$ 和 $Q$**

从给定积分 $\oint_C xy^3 \, dx + x^2y^2 \, dy$，我们识别：
$$
P(x, y) = xy^3, \quad Q(x, y) = x^2y^2
$$

**3. 计算偏导数**

计算 $Q$ 关于 $x$ 的偏导数：
$$
\frac{\partial Q}{\partial x} = \frac{\partial}{\partial x}(x^2y^2) = 2xy^2
$$
计算 $P$ 关于 $y$ 的偏导数：
$$
\frac{\partial P}{\partial y} = \frac{\partial}{\partial y}(xy^3) = 3xy^2
$$

**4. 确定被积函数**

减去偏导数：
$$
\frac{\partial Q}{\partial x} - \frac{\partial P}{\partial y} = 2xy^2 - 3xy^2 = -xy^2
$$

**5. 定义区域 $D$**

区域 $D$ 是顶点为 $(0,0), (2,0), (2,3), (0,3)$ 的矩形。该区域可以用以下不等式描述：
$$
0 \le x \le 2, \quad 0 \le y \le 3
$$

**6. 设置并计算二重积分**

将被积函数和极限代入二重积分：
$$
\iint_D (-xy^2) \, dA = \int_0^3 \int_0^2 -xy^2 \, dx \, dy
$$
首先，计算关于 $x$ 的内层积分：
$$
\int_0^2 -xy^2 \, dx = -y^2 \left[ \frac{x^2}{2} \right]_0^2 = -y^2 \left( \frac{4}{2} - 0 \right) = -2y^2
$$
然后，计算关于 $y$ 的外层积分：
$$
\int_0^3 -2y^2 \, dy = -2 \left[ \frac{y^3}{3} \right]_0^3 = -2 \left( \frac{27}{3} - 0 \right) = -2(9) = -18
$$

**最终答案**

$$
\oint_C xy^3 \, dx + x^2y^2 \, dy = -18
$$
{{< /details>}}

### Q13. 格林定理

> 使用格林定理计算 $\oint_C (3y - e^{\sin x}) \, dx + (7x + \sqrt{y^4+1}) \, dy$，其中 $C$ 是逆时针定向的圆 $x^2+y^2=9$。

{{< details summary="**本题答案**" >}}
要使用格林定理计算线积分，我们按以下步骤进行。

**1. 陈述格林定理**

格林定理将围绕简单闭曲线 $C$ 的线积分与由 $C$ 围成的平面区域 $D$ 上的二重积分联系起来。对于正定向（逆时针）曲线 $C$：
$$
\oint_C P \, dx + Q \, dy = \iint_D \left( \frac{\partial Q}{\partial x} - \frac{\partial P}{\partial y} \right) \, dA
$$

**2. 识别 $P$ 和 $Q$**

从给定积分 $\oint_C (3y - e^{\sin x}) \, dx + (7x + \sqrt{y^4+1}) \, dy$，我们识别：
$$
P(x, y) = 3y - e^{\sin x}, \quad Q(x, y) = 7x + \sqrt{y^4+1}
$$

**3. 计算偏导数**

计算 $Q$ 关于 $x$ 的偏导数：
$$
\frac{\partial Q}{\partial x} = \frac{\partial}{\partial x}(7x + \sqrt{y^4+1}) = 7 + 0 = 7
$$
计算 $P$ 关于 $y$ 的偏导数：
$$
\frac{\partial P}{\partial y} = \frac{\partial}{\partial y}(3y - e^{\sin x}) = 3 - 0 = 3
$$
注意，复杂项 $e^{\sin x}$ 和 $\sqrt{y^4+1}$ 在求导时消失，因为它们只分别依赖于 $x$ 和 $y$，而不依赖于求导变量。

**4. 确定被积函数**

减去偏导数：
$$
\frac{\partial Q}{\partial x} - \frac{\partial P}{\partial y} = 7 - 3 = 4
$$

**5. 定义区域 $D$**

曲线 $C$ 是圆 $x^2+y^2=9$。这是一个以原点为中心、半径 $r = \sqrt{9} = 3$ 的圆。
区域 $D$ 是由该圆围成的圆盘。

**6. 设置并计算二重积分**

将被积函数和极限代入二重积分：
$$
\iint_D 4 \, dA = 4 \iint_D dA
$$
积分 $\iint_D dA$ 表示区域 $D$ 的面积。由于 $D$ 是半径 $r=3$ 的圆盘，其面积为：
$$
\text{Area}(D) = \pi r^2 = \pi (3)^2 = 9\pi
$$
因此，二重积分的值为：
$$
4 \times 9\pi = 36\pi
$$

**最终答案**

$$
\oint_C (3y - e^{\sin x}) \, dx + (7x + \sqrt{y^4+1}) \, dy = 36\pi
$$
{{< /details>}}

## 公式表

### 极坐标中的二重积分

对于域上的连续函数 $f$

$$D: \theta_1 \le \theta \le \theta_2, \quad r_1(\theta) \le r \le r_2(\theta)$$

$$\iint_D f(x,y) \, dA = \int_{\theta_1}^{\theta_2} \int_{r_1(\theta)}^{r_2(\theta)} f(r\cos\theta, r\sin\theta) \, r \, dr \, d\theta$$

这里，区域 $D$ 是**径向简单**的。

**注意：**
- 变换使用：$x = r\cos\theta$，$y = r\sin\theta$
- 被积函数中额外的因子 $r$ 来自极坐标变换的雅可比行列式
- 区域 $D$ 被描述为一个极坐标矩形，其中径向边界可能依赖于角度 $\theta$

### 向量场上的运算

设 $\vec{F} = \langle F_1, F_2, F_3 \rangle$ 为向量场。我们定义：

1. $\vec{F}$ 的**散度**

   $$\text{div}(\vec{F}) = \nabla \cdot \vec{F} = \left\langle \frac{\partial}{\partial x}, \frac{\partial}{\partial y}, \frac{\partial}{\partial z} \right\rangle \cdot \langle F_1, F_2, F_3 \rangle$$

   $$= \frac{\partial F_1}{\partial x} + \frac{\partial F_2}{\partial y} + \frac{\partial F_3}{\partial z}$$

2. $\vec{F}$ 的**旋度**

   $$\text{curl}(\vec{F}) = \nabla \times \vec{F} = \begin{vmatrix} \hat{i} & \hat{j} & \hat{k} \\ \frac{\partial}{\partial x} & \frac{\partial}{\partial y} & \frac{\partial}{\partial z} \\ F_1 & F_2 & F_3 \end{vmatrix}$$

   $$= \left(\frac{\partial F_3}{\partial y} - \frac{\partial F_2}{\partial z}\right)\hat{i} - \left(\frac{\partial F_3}{\partial x} - \frac{\partial F_1}{\partial z}\right)\hat{j} + \left(\frac{\partial F_2}{\partial x} - \frac{\partial F_1}{\partial y}\right)\hat{k}$$

   $$= \left\langle \frac{\partial F_3}{\partial y} - \frac{\partial F_2}{\partial z}, \ \frac{\partial F_1}{\partial z} - \frac{\partial F_3}{\partial x}, \ \frac{\partial F_2}{\partial x} - \frac{\partial F_1}{\partial y} \right\rangle$$

### 保守向量场的旋度

1. 在 $\mathbf{R}^2$ 中，如果向量场 $\mathbf{F} = \langle F_1, F_2 \rangle$ 是保守场，则

   $$\frac{\partial F_1}{\partial y} = \frac{\partial F_2}{\partial x}$$

2. 在 $\mathbf{R}^3$ 中，如果向量场 $\mathbf{F} = \langle F_1, F_2, F_3 \rangle$ 是保守场，则

   $$\text{curl}(\mathbf{F}) = \mathbf{0}, \quad \text{或等价地，} \quad \frac{\partial F_1}{\partial y} = \frac{\partial F_2}{\partial x}, \ \frac{\partial F_2}{\partial z} = \frac{\partial F_3}{\partial y}, \ \frac{\partial F_3}{\partial x} = \frac{\partial F_1}{\partial z}$$

### 计算标量线积分

设 $\vec{r}(t)$ 为直接遍历曲线 $C$（$a \le t \le b$）的参数化。如果 $f(x,y,z)$ 和 $\vec{r}(t)$ 连续，则

$$\int_C f(x,y,z) \, ds = \int_{t=a}^{t=b} f(\vec{r}(t)) \, \|\vec{r}'(t)\| \, dt \quad \text{（二维类似）}$$
$$\int_C f(x,y),ds=\int_a^b f(x(t),y(t)) \, \sqrt{\left(\frac{dx}{dt}\right)^2+\left(\frac{dy}{dt}\right)^2} \, dt$$

其中 $\vec{r}(t) = \langle x(t), y(t), z(t) \rangle$

- $ds = \|\vec{r}'(t)\| \, dt$ 称为**弧长微分**

- 标量线积分的值不依赖于 $C$ 的参数化，只要 $C$ 从 $t=a$ 到 $t=b$ 只遍历一次。

### 计算向量线积分

设 $\vec{F}$ 为在由 $\vec{r}(t)$（$a \le t \le b$）给出的光滑定向曲线 $C$ 上定义的连续向量场。则 **$\vec{F}$ 沿 $C$ 的线积分**为：

$$\int_C \vec{F} \cdot d\vec{r} = \int_a^b \vec{F}(\vec{r}(t)) \cdot \vec{r}'(t) \, dt = \int_C \vec{F} \cdot \frac{\vec{r}'(t)}{\|\vec{r}'(t)\|} \|\vec{r}'(t)\| \, dt = \int_C \vec{F} \cdot \vec{T} \, ds$$

其中 $\vec{T} = \frac{\vec{r}'(t)}{\|\vec{r}'(t)\|}$ 是单位切向量。

### 线积分基本定理

$$
\int_C \vec{F} \cdot d\vec{r} = f(\text{终点}) - f(\text{起点})
$$

### 格林定理

设 $D$ 为一个域，其边界 $\partial D$ 是平面上的**正定向**简单闭曲线。如果 $\vec{F} = \langle F_1, F_2 \rangle$，其中 $F_1$ 和 $F_2$ 具有连续偏导数，则

$$\oint_C \vec{F} \cdot d\vec{r} = \oint_{\partial D} F_1 \, dx + F_2 \, dy = \iint_D \left(\frac{\partial F_2}{\partial x} - \frac{\partial F_1}{\partial y}\right) \, dA$$

其中 $C = \partial D$

**向量线积分的符号：**
- $\oint_C \vec{F} \cdot d\vec{r}$ —— 符号 1
- $\oint_{\partial D} F_1 \, dx + F_2 \, dy$ —— 符号 2

### 非闭合曲线的格林定理

设 $C$ 为可以通过添加辅助曲线 $C_1$ 形成闭边界 $\partial D = C + C_1$ 的非闭合曲线，其中 $C_1$ 是闭合区域 $D$ 的辅助曲线。如果 $\vec{F} = \langle F_1, F_2 \rangle$ 在 $D$ 上具有连续偏导数，则根据格林定理：

$$\oint_{\partial D} \vec{F} \cdot d\vec{r} = \int_C \vec{F} \cdot d\vec{r} + \int_{C_1} \vec{F} \cdot d\vec{r} = \iint_D \left(\frac{\partial F_2}{\partial x} - \frac{\partial F_1}{\partial y}\right) dA$$

重新排列以求解非闭合曲线 $C$ 上的线积分：

$$\int_C \vec{F} \cdot d\vec{r} = \iint_D \left(\frac{\partial F_2}{\partial x} - \frac{\partial F_1}{\partial y}\right) dA - \int_{C_1} \vec{F} \cdot d\vec{r}$$

**注意：** $C$ 和 $C_1$ 的定向必须与闭边界 $\partial D$ 的正（逆时针）定向一致。

### 三角函数

$$
\begin{align*}
  \cos(\theta) &= x ,\: \sin(\theta) = y \\
  \tan(\theta) &= \frac{\sin(\theta)}{\cos(\theta)} = \frac{y}{x} \\
  \sec(\theta) &= \frac{1}{\cos(\theta)} = \frac{1}{x} \\
  \csc(\theta) &= \frac{1}{\sin(\theta)} = \frac{1}{y} \\
  \cot(\theta) &= \frac{\cos(\theta)}{\sin(\theta)} = \frac{x}{y} \\
  \sin(\theta) &= \frac{opp}{hyp} \\
  \cos(\theta) &= \frac{adj}{hyp} \\
  \tan(\theta) &= \frac{\sin(\theta)}{\cos(\theta)} = \frac{\frac{opp}{\cancel{hyp}}}{\frac{adj}{\cancel{hyp}}} \cdot \frac{\frac{\cancel{hyp}}{1}}{\frac{\cancel{hyp}}{1}} = \frac{opp}{adj}
\end{align*}
$$

|$a\;rad$|$0$|$\frac{\pi}{6}$|$\frac{\pi}{4}$|$\frac{\pi}{3}$|$\frac{\pi}{2}$|$\pi$|
|:-:|:-:|:-:|:-:|:-:|:-:|:-:|
|$\sin(a)$|$0$|$\frac{1}{2}$|$\frac{\sqrt{2}}{2}$|$\frac{\sqrt{3}}{2}$|$1$|$0$|
|$\cos(a)$|$1$|$\frac{\sqrt{3}}{2}$|$\frac{\sqrt{2}}{2}$|$\frac{1}{2}$|$0$|$-1$|
|$\tan(a)$|$0$|$\frac{1}{\sqrt{3}}$|$1$|$\sqrt{3}$|$-$|$0$|
