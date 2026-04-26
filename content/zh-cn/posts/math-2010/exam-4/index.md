---
title: MATH 2010 考试 4 复习题
subtitle:
date: 2026-04-23T04:05:09-04:00
lastmod: 2026-04-23T04:05:09-04:00
slug: math-2010-exam-4
draft: false
author:
  name: James
  link: https://www.jamesflare.com
  email:
  avatar: /site-logo.avif
description: MATH 2010 考试 4 复习题和解答
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
summary: MATH 2010 考试 4 复习题和解答
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

考试 #4 将于 4 月 24 日星期五在 LECTURE 进行，涵盖本学期讲授的所有矩阵代数内容（第 13-26 讲）。考试会更侧重于考试 3 之后讲授的材料（**3.3、3.4、3.5、3.6、4.1、4.2、4.4、4.5、4.6 和 4.7 节**），但你应准备好回答来自考试 3 所涵盖的任何章节的问题（1.1、1.2、1.3、1.5、1.6、1.7、1.9 和 3.2 节）。

如果你提交了带有考试便利条件的 ANSS 备忘录，将通过电子邮件与你联系，告知你考试的替代地点详情。只有在 4 月 22 日星期三下午 5 点之前通过电子邮件向讲师发送了便利条件备忘录的学生才能使用他们的考试便利条件。

你将有 70 分钟完成考试。学生必须准时到达并听取关于座位要求的指示。学生必须将所有背包留在考试室前部的墙边。不要阻挡任何出口或阻碍任何通道。如果你在考试开始后到达，将不会给你额外时间完成考试。学生将被要求签到，并且会收集的考试将与签到表进行交叉检查。未签到的学生的考试将不予评分。

## 问题

### Q1. 张成与线性组合

> 设 $\vec{v}_1 = \begin{bmatrix} 1 \\ 2 \\ 0 \end{bmatrix}$，$\vec{v}_2 = \begin{bmatrix} 0 \\ -1 \\ 1 \end{bmatrix}$。  
> 判断下列每个向量是否在 $Sp\{\vec{v}_1, \vec{v}_2\}$ 中。对于在 $Sp\{\vec{v}_1, \vec{v}_2\}$ 中的每个向量，将其写为 $\vec{v}_1$ 和 $\vec{v}_2$ 的线性组合。
>
> - (a) $\vec{v} = \begin{bmatrix} 1 \\ 1 \\ -1 \end{bmatrix}$
> - (b) $\vec{w} = \begin{bmatrix} 2 \\ 3 \\ 1 \end{bmatrix}$

{{< details summary="**本题答案**" >}}
我们检查每个向量是否可以写成 $c_1\vec{v}_1 + c_2\vec{v}_2$ 的形式。

**(a)** $\vec{v} = \begin{bmatrix} 1 \\ 1 \\ -1 \end{bmatrix}$

建立方程组 $c_1\begin{bmatrix} 1 \\ 2 \\ 0 \end{bmatrix} + c_2\begin{bmatrix} 0 \\ -1 \\ 1 \end{bmatrix} = \begin{bmatrix} 1 \\ 1 \\ -1 \end{bmatrix}$：

$$\begin{cases} c_1 = 1 \\ 2c_1 - c_2 = 1 \\ c_2 = -1 \end{cases}$$

由第一个方程：$c_1 = 1$。  
由第三个方程：$c_2 = -1$。  
代入第二个方程：$2(1) - (-1) = 3 \neq 1$。**矛盾。**

**答案 (a)：** $\vec{v} \notin Sp\{\vec{v}_1, \vec{v}_2\}$。

---

**(b)** $\vec{w} = \begin{bmatrix} 2 \\ 3 \\ 1 \end{bmatrix}$

建立方程组 $c_1\begin{bmatrix} 1 \\ 2 \\ 0 \end{bmatrix} + c_2\begin{bmatrix} 0 \\ -1 \\ 1 \end{bmatrix} = \begin{bmatrix} 2 \\ 3 \\ 1 \end{bmatrix}$：

$$\begin{cases} c_1 = 2 \\ 2c_1 - c_2 = 3 \\ c_2 = 1 \end{cases}$$

由第一个方程：$c_1 = 2$。  
由第三个方程：$c_2 = 1$。  
验证第二个方程：$2(2) - 1 = 3$。**相容** $\checkmark$

**答案 (b)：** $\vec{w} \in Sp\{\vec{v}_1, \vec{v}_2\}$ 且 $\vec{w} = 2\vec{v}_1 + \vec{v}_2$。

**最终答案**
- (a) $\vec{v} \notin Sp\{\vec{v}_1, \vec{v}_2\}$
- (b) $\vec{w} = 2\vec{v}_1 + \vec{v}_2$
{{< /details >}}

### Q2. 零空间

> 判断下列哪些向量在矩阵 $A = \begin{bmatrix} 2 & 2 \\ 3 & 3 \end{bmatrix}$ 的零空间中。
>
> - (a) $\vec{a} = \begin{bmatrix} 1 \\ -1 \end{bmatrix}$
> - (b) $\vec{b} = \begin{bmatrix} 2 \\ -3 \end{bmatrix}$
> - (c) $\vec{c} = \begin{bmatrix} -2 \\ 2 \end{bmatrix}$
> - (d) $\vec{d} = \begin{bmatrix} 1 \\ 0 \end{bmatrix}$
> - (e) $\vec{e} = \begin{bmatrix} 0 \\ 0 \end{bmatrix}$

{{< details summary="**本题答案**" >}}
向量 $\vec{x}$ 在 $A$ 的零空间中，当且仅当 $A\vec{x} = \vec{0}$。

**检查每个向量：**

**(a)** $A\vec{a} = \begin{bmatrix} 2 & 2 \\ 3 & 3 \end{bmatrix}\begin{bmatrix} 1 \\ -1 \end{bmatrix} = \begin{bmatrix} 2-2 \\ 3-3 \end{bmatrix} = \begin{bmatrix} 0 \\ 0 \end{bmatrix}$ ✅

**(b)** $A\vec{b} = \begin{bmatrix} 2 & 2 \\ 3 & 3 \end{bmatrix}\begin{bmatrix} 2 \\ -3 \end{bmatrix} = \begin{bmatrix} 4-6 \\ 6-9 \end{bmatrix} = \begin{bmatrix} -2 \\ -3 \end{bmatrix} \neq \vec{0}$ ❌

**(c)** $A\vec{c} = \begin{bmatrix} 2 & 2 \\ 3 & 3 \end{bmatrix}\begin{bmatrix} -2 \\ 2 \end{bmatrix} = \begin{bmatrix} -4+4 \\ -6+6 \end{bmatrix} = \begin{bmatrix} 0 \\ 0 \end{bmatrix}$ ✅

**(d)** $A\vec{d} = \begin{bmatrix} 2 & 2 \\ 3 & 3 \end{bmatrix}\begin{bmatrix} 1 \\ 0 \end{bmatrix} = \begin{bmatrix} 2 \\ 3 \end{bmatrix} \neq \vec{0}$ ❌

**(e)** $A\vec{e} = \begin{bmatrix} 2 & 2 \\ 3 & 3 \end{bmatrix}\begin{bmatrix} 0 \\ 0 \end{bmatrix} = \begin{bmatrix} 0 \\ 0 \end{bmatrix}$ ✅

**最终答案**
在 $N(A)$ 中：$\vec{a}, \vec{c}, \vec{e}$。不在 $N(A)$ 中：$\vec{b}, \vec{d}$。
{{< /details >}}

### Q3. 值域（列空间）

> 判断下列哪些向量在矩阵 $A = \begin{bmatrix} -1 & 3 \\ 2 & -6 \end{bmatrix}$ 的值域中（也称为 $A$ 的列空间）。如果向量在 $A$ 的值域中，将其写为 $A$ 的列向量的线性组合。
>
> - (a) $\vec{b}_1 = \begin{bmatrix} 1 \\ -3 \end{bmatrix}$
> - (b) $\vec{b}_2 = \begin{bmatrix} 4 \\ -8 \end{bmatrix}$

{{< details summary="**本题答案**" >}}
向量 $\vec{b}$ 在 $A$ 的值域（列空间）中，当且仅当 $A\vec{x} = \vec{b}$ 相容。等价地，如果 $\vec{b}$ 是 $A$ 的列向量的线性组合。

设 $A = \begin{bmatrix} -1 & 3 \\ 2 & -6 \end{bmatrix}$ 的列向量为 $\vec{a}_1 = \begin{bmatrix} -1 \\ 2 \end{bmatrix}$ 和 $\vec{a}_2 = \begin{bmatrix} 3 \\ -6 \end{bmatrix}$。

注意 $\vec{a}_2 = -3\vec{a}_1$，因此列空间是一维的：$col(A) = Sp\{\vec{a}_1\}$。

**(a)** $\vec{b}_1 = \begin{bmatrix} 1 \\ -3 \end{bmatrix}$

求解 $c_1\begin{bmatrix} -1 \\ 2 \end{bmatrix} + c_2\begin{bmatrix} 3 \\ -6 \end{bmatrix} = \begin{bmatrix} 1 \\ -3 \end{bmatrix}$：
$$\begin{cases} -c_1 + 3c_2 = 1 \\ 2c_1 - 6c_2 = -3 \end{cases}$$
第二个方程是第一个的 $-2$ 倍：$-2(1) = -2 \neq -3$。**不相容。**

**答案 (a)：** $\vec{b}_1 \notin col(A)$。

---

**(b)** $\vec{b}_2 = \begin{bmatrix} 4 \\ -8 \end{bmatrix}$

求解 $c_1\begin{bmatrix} -1 \\ 2 \end{bmatrix} + c_2\begin{bmatrix} 3 \\ -6 \end{bmatrix} = \begin{bmatrix} 4 \\ -8 \end{bmatrix}$：
$$\begin{cases} -c_1 + 3c_2 = 4 \\ 2c_1 - 6c_2 = -8 \end{cases}$$
第二个方程是第一个的 $-2$ 倍：$-2(4) = -8$。**相容。**

选择 $c_2 = 0$，则 $c_1 = -4$。因此 $\vec{b}_2 = -4\vec{a}_1 + 0\vec{a}_2$。

**答案 (b)：** $\vec{b}_2 \in col(A)$ 且 $\vec{b}_2 = -4\vec{a}_1 + 0\vec{a}_2$。

**最终答案**
- (a) $\vec{b}_1 \notin col(A)$
- (b) $\vec{b}_2 \in col(A)$，$\vec{b}_2 = -4\vec{a}_1 + 0\vec{a}_2$
{{< /details >}}

### Q4. 矩阵的子空间

> 设 $A = \begin{bmatrix} 1 & 0 & 1 & 1 \\ 2 & 0 & 0 & 1 \\ 1 & 0 & -1 & 0 \end{bmatrix}$。
>
> - (a) 将 $N(A)$ 写为线性无关向量集合的张成。
> - (b) 将 $col(A)$ 写为线性无关向量集合的张成。
> - (c) 将 $row(A)$ 写为线性无关向量集合的张成。

{{< details summary="**本题答案**" >}}
首先对 $A = \begin{bmatrix} 1 & 0 & 1 & 1 \\ 2 & 0 & 0 & 1 \\ 1 & 0 & -1 & 0 \end{bmatrix}$ 进行行化简：

$$\left[\begin{array}{cccc} 1 & 0 & 1 & 1 \\ 2 & 0 & 0 & 1 \\ 1 & 0 & -1 & 0 \end{array}\right] \xrightarrow{R_2 \to R_2-2R_1,\; R_3 \to R_3-R_1} \left[\begin{array}{cccc} 1 & 0 & 1 & 1 \\ 0 & 0 & -2 & -1 \\ 0 & 0 & -2 & -1 \end{array}\right]$$

$$\xrightarrow{R_3 \to R_3-R_2} \left[\begin{array}{cccc} 1 & 0 & 1 & 1 \\ 0 & 0 & -2 & -1 \\ 0 & 0 & 0 & 0 \end{array}\right] \xrightarrow{R_2 \to -\frac{1}{2}R_2} \left[\begin{array}{cccc} 1 & 0 & 1 & 1 \\ 0 & 0 & 1 & \frac{1}{2} \\ 0 & 0 & 0 & 0 \end{array}\right]$$

$$\xrightarrow{R_1 \to R_1-R_2} \left[\begin{array}{cccc} 1 & 0 & 0 & \frac{1}{2} \\ 0 & 0 & 1 & \frac{1}{2} \\ 0 & 0 & 0 & 0 \end{array}\right]$$

这就是 RREF。主元列：1, 3。自由变量：$x_2, x_4$。

**(a) 零空间 $N(A)$：**

由 RREF：$x_1 + \frac{1}{2}x_4 = 0$ 且 $x_3 + \frac{1}{2}x_4 = 0$。

$$\begin{cases} x_1 = -\frac{1}{2}x_4 \\ x_2 = x_2 \text{（自由）} \\ x_3 = -\frac{1}{2}x_4 \\ x_4 = x_4 \text{（自由）} \end{cases}$$

向量形式：
$$\vec{x} = x_2\begin{bmatrix} 0 \\ 1 \\ 0 \\ 0 \end{bmatrix} + x_4\begin{bmatrix} -\frac{1}{2} \\ 0 \\ -\frac{1}{2} \\ 1 \end{bmatrix}$$

**答案 (a)：** $N(A) = Sp\left\{ \begin{bmatrix} 0 \\ 1 \\ 0 \\ 0 \end{bmatrix}, \begin{bmatrix} -\frac{1}{2} \\ 0 \\ -\frac{1}{2} \\ 1 \end{bmatrix} \right\}$

**(b) 列空间 $col(A)$：**

主元列为 1 和 3，因此 $col(A)$ 由原始 $A$ 的第 1 列和第 3 列张成：

**答案 (b)：** $col(A) = Sp\left\{ \begin{bmatrix} 1 \\ 2 \\ 1 \end{bmatrix}, \begin{bmatrix} 1 \\ 0 \\ -1 \end{bmatrix} \right\}$

**(c) 行空间 $row(A)$：**

RREF 的非零行构成一个基：

**答案 (c)：** $row(A) = Sp\left\{ \begin{bmatrix} 1 & 0 & 0 & \frac{1}{2} \end{bmatrix}, \begin{bmatrix} 0 & 0 & 1 & \frac{1}{2} \end{bmatrix} \right\}$
{{< /details >}}

### Q5. 列空间、行空间和零空间的基与维数

> 设 $A = \begin{bmatrix} 1 & 2 & 2 & -5 & 6 \\ -1 & -2 & -1 & 1 & -1 \\ 4 & 8 & 5 & -8 & 9 \\ 3 & 6 & 1 & 5 & -6 \end{bmatrix}$。  
> 求 $A$ 的列空间、行空间和零空间的基。给出各自的维数。

{{< details summary="**本题答案**" >}}
$$A = \begin{bmatrix} 1 & 2 & 2 & -5 & 6 \\ -1 & -2 & -1 & 1 & -1 \\ 4 & 8 & 5 & -8 & 9 \\ 3 & 6 & 1 & 5 & -6 \end{bmatrix}$$

**行化简：**

$R_2 \to R_2 + R_1$：$[0, 0, 1, -4, 5]$
$R_3 \to R_3 - 4R_1$：$[0, 0, -3, 12, -15]$
$R_4 \to R_4 - 3R_1$：$[0, 0, -5, 20, -24]$

$$\left[\begin{array}{ccccc} 1 & 2 & 2 & -5 & 6 \\ 0 & 0 & 1 & -4 & 5 \\ 0 & 0 & -3 & 12 & -15 \\ 0 & 0 & -5 & 20 & -24 \end{array}\right]$$

$R_3 \to R_3 + 3R_2$：$[0, 0, 0, 0, 0]$
$R_4 \to R_4 + 5R_2$：$[0, 0, 0, 0, 1]$

交换 $R_3 \leftrightarrow R_4$：

$$\left[\begin{array}{ccccc} 1 & 2 & 2 & -5 & 6 \\ 0 & 0 & 1 & -4 & 5 \\ 0 & 0 & 0 & 0 & 1 \\ 0 & 0 & 0 & 0 & 0 \end{array}\right]$$

**化为 RREF：**
$R_2 \to R_2 - 5R_3$：$[0, 0, 1, -4, 0]$
$R_1 \to R_1 - 6R_3$：$[1, 2, 2, -5, 0]$
$R_1 \to R_1 - 2R_2$：$[1, 2, 0, 3, 0]$

$$\text{RREF} = \left[\begin{array}{ccccc} 1 & 2 & 0 & 3 & 0 \\ 0 & 0 & 1 & -4 & 0 \\ 0 & 0 & 0 & 0 & 1 \\ 0 & 0 & 0 & 0 & 0 \end{array}\right]$$

主元列：1, 3, 5。自由变量：$x_2, x_4$。

**列空间：** 原始 $A$ 的第 1、3、5 列：
$$\text{基} = \left\{ \begin{bmatrix} 1 \\ -1 \\ 4 \\ 3 \end{bmatrix}, \begin{bmatrix} 2 \\ -1 \\ 5 \\ 1 \end{bmatrix}, \begin{bmatrix} 6 \\ -1 \\ 9 \\ -6 \end{bmatrix} \right\}, \quad \dim = 3$$

**行空间：** RREF 的非零行（写为行向量）：
$$\text{基} = \left\{ \begin{bmatrix} 1 & 2 & 0 & 3 & 0 \end{bmatrix}, \begin{bmatrix} 0 & 0 & 1 & -4 & 0 \end{bmatrix}, \begin{bmatrix} 0 & 0 & 0 & 0 & 1 \end{bmatrix} \right\}, \quad \dim = 3$$

**零空间：**
$$\begin{cases} x_1 + 2x_2 + 3x_4 = 0 \\ x_3 - 4x_4 = 0 \\ x_5 = 0 \end{cases} \implies \begin{cases} x_1 = -2x_2 - 3x_4 \\ x_3 = 4x_4 \\ x_5 = 0 \end{cases}$$

$$\vec{x} = x_2\begin{bmatrix} -2 \\ 1 \\ 0 \\ 0 \\ 0 \end{bmatrix} + x_4\begin{bmatrix} -3 \\ 0 \\ 4 \\ 1 \\ 0 \end{bmatrix}$$

$$\text{基} = \left\{ \begin{bmatrix} -2 \\ 1 \\ 0 \\ 0 \\ 0 \end{bmatrix}, \begin{bmatrix} -3 \\ 0 \\ 4 \\ 1 \\ 0 \end{bmatrix} \right\}, \quad \dim = 2$$

**最终答案**
- 列空间基：$\left\{ \begin{bmatrix} 1 \\ -1 \\ 4 \\ 3 \end{bmatrix}, \begin{bmatrix} 2 \\ -1 \\ 5 \\ 1 \end{bmatrix}, \begin{bmatrix} 6 \\ -1 \\ 9 \\ -6 \end{bmatrix} \right\}$，$\dim = 3$
- 行空间基：$\left\{ \begin{bmatrix} 1 & 2 & 0 & 3 & 0 \end{bmatrix}, \begin{bmatrix} 0 & 0 & 1 & -4 & 0 \end{bmatrix}, \begin{bmatrix} 0 & 0 & 0 & 0 & 1 \end{bmatrix} \right\}$，$\dim = 3$
- 零空间基：$\left\{ \begin{bmatrix} -2 \\ 1 \\ 0 \\ 0 \\ 0 \end{bmatrix}, \begin{bmatrix} -3 \\ 0 \\ 4 \\ 1 \\ 0 \end{bmatrix} \right\}$，$\dim = 2$
{{< /details >}}

### Q6. 子空间的基与维数

> 设 $W = \left\{ \vec{x} = \begin{bmatrix} x_1 \\ x_2 \\ x_3 \end{bmatrix} \in \mathbb{R}^3 : x_1 - x_2 + x_3 = 0 \right\}$。
>
> - (a) 求 $W$ 的基。
> - (b) $W$ 的维数是多少？

{{< details summary="**本题答案**" >}}
$W = \{ \vec{x} \in \mathbb{R}^3 : x_1 - x_2 + x_3 = 0 \}$

我们可以写成 $x_1 = x_2 - x_3$，因此 $x_2$ 和 $x_3$ 是自由变量。

**(a)** $W$ 中的任意向量可写为：
$$\vec{x} = \begin{bmatrix} x_2-x_3 \\ x_2 \\ x_3 \end{bmatrix} = x_2\begin{bmatrix} 1 \\ 1 \\ 0 \end{bmatrix} + x_3\begin{bmatrix} -1 \\ 0 \\ 1 \end{bmatrix}$$

这两个向量线性无关（一个不是另一个的标量倍数）。

**答案 (a)：** $W$ 的基为 $\left\{ \begin{bmatrix} 1 \\ 1 \\ 0 \end{bmatrix}, \begin{bmatrix} -1 \\ 0 \\ 1 \end{bmatrix} \right\}$

**(b)** 维数是基中向量的个数。

**答案 (b)：** $\dim(W) = 2$

**最终答案**
- (a) 基：$\left\{ \begin{bmatrix} 1 \\ 1 \\ 0 \end{bmatrix}, \begin{bmatrix} -1 \\ 0 \\ 1 \end{bmatrix} \right\}$
- (b) $\dim(W) = 2$
{{< /details >}}

### Q7. Gram-Schmidt 正交化过程与坐标

> 设 $W = Sp\{\vec{v}_1, \vec{v}_2, \vec{v}_3\}$，其中 $\vec{v}_1 = \begin{bmatrix} 2 \\ 2 \\ 1 \end{bmatrix}$，$\vec{v}_2 = \begin{bmatrix} -2 \\ 1 \\ 2 \end{bmatrix}$，$\vec{v}_3 = \begin{bmatrix} 18 \\ 0 \\ 0 \end{bmatrix}$ 线性无关。
>
> - (a) 使用 Gram-Schmidt 正交化构造 $W$ 的标准正交基 $\{\vec{u}_1, \vec{u}_2, \vec{u}_3\}$。
> - (b) 求 $\vec{x} = \begin{bmatrix} 1 \\ 1 \\ 1 \end{bmatrix}$ 关于 $\vec{u}_1, \vec{u}_2, \vec{u}_3$ 的坐标。  
>   即，求 $a_1, a_2, a_3$ 使得 $\vec{x} = a_1\vec{u}_1 + a_2\vec{u}_2 + a_3\vec{u}_3$。

{{< details summary="**本题答案**" >}}
$\vec{v}_1 = \begin{bmatrix} 2 \\ 2 \\ 1 \end{bmatrix}, \;\vec{v}_2 = \begin{bmatrix} -2 \\ 1 \\ 2 \end{bmatrix}, \;\vec{v}_3 = \begin{bmatrix} 18 \\ 0 \\ 0 \end{bmatrix}$

**(a) Gram-Schmidt 正交化：**

**步骤 1：** $\vec{w}_1 = \vec{v}_1 = \begin{bmatrix} 2 \\ 2 \\ 1 \end{bmatrix}, \quad \|\vec{w}_1\| = \sqrt{4+4+1} = 3$

**步骤 2：**
$$\vec{w}_2 = \vec{v}_2 - \frac{\vec{v}_2 \cdot \vec{w}_1}{\|\vec{w}_1\|^2}\vec{w}_1$$
$\vec{v}_2 \cdot \vec{w}_1 = (-2)(2) + (1)(2) + (2)(1) = -4 + 2 + 2 = 0$
$$\vec{w}_2 = \vec{v}_2 = \begin{bmatrix} -2 \\ 1 \\ 2 \end{bmatrix}, \quad \|\vec{w}_2\| = \sqrt{4+1+4} = 3$$

**步骤 3：**
$$\vec{w}_3 = \vec{v}_3 - \frac{\vec{v}_3 \cdot \vec{w}_1}{\|\vec{w}_1\|^2}\vec{w}_1 - \frac{\vec{v}_3 \cdot \vec{w}_2}{\|\vec{w}_2\|^2}\vec{w}_2$$
$\vec{v}_3 \cdot \vec{w}_1 = 18(2) = 36$  
$\vec{v}_3 \cdot \vec{w}_2 = 18(-2) = -36$
$$\vec{w}_3 = \begin{bmatrix} 18 \\ 0 \\ 0 \end{bmatrix} - \frac{36}{9}\begin{bmatrix} 2 \\ 2 \\ 1 \end{bmatrix} - \frac{-36}{9}\begin{bmatrix} -2 \\ 1 \\ 2 \end{bmatrix} = \begin{bmatrix} 18 \\ 0 \\ 0 \end{bmatrix} - 4\begin{bmatrix} 2 \\ 2 \\ 1 \end{bmatrix} + 4\begin{bmatrix} -2 \\ 1 \\ 2 \end{bmatrix}$$
$$= \begin{bmatrix} 18-8-8 \\ 0-8+4 \\ 0-4+8 \end{bmatrix} = \begin{bmatrix} 2 \\ -4 \\ 4 \end{bmatrix}, \quad \|\vec{w}_3\| = \sqrt{4+16+16} = 6$$

**归一化得到标准正交基：**
$$\vec{u}_1 = \frac{1}{3}\begin{bmatrix} 2 \\ 2 \\ 1 \end{bmatrix}, \quad \vec{u}_2 = \frac{1}{3}\begin{bmatrix} -2 \\ 1 \\ 2 \end{bmatrix}, \quad \vec{u}_3 = \frac{1}{6}\begin{bmatrix} 2 \\ -4 \\ 4 \end{bmatrix}$$

---

**(b) $\vec{x} = \begin{bmatrix} 1 \\ 1 \\ 1 \end{bmatrix}$ 的坐标：**

由于 $\{\vec{u}_1, \vec{u}_2, \vec{u}_3\}$ 是标准正交的：
$$a_1 = \vec{x} \cdot \vec{u}_1 = \frac{1}{3}(2+2+1) = \frac{5}{3}$$
$$a_2 = \vec{x} \cdot \vec{u}_2 = \frac{1}{3}(-2+1+2) = \frac{1}{3}$$
$$a_3 = \vec{x} \cdot \vec{u}_3 = \frac{1}{6}(2-4+4) = \frac{1}{3}$$

**验证：** $\frac{5}{3}\vec{u}_1 + \frac{1}{3}\vec{u}_2 + \frac{1}{3}\vec{u}_3 = \frac{5}{9}\begin{bmatrix} 2 \\ 2 \\ 1 \end{bmatrix} + \frac{1}{9}\begin{bmatrix} -2 \\ 1 \\ 2 \end{bmatrix} + \frac{1}{18}\begin{bmatrix} 2 \\ -4 \\ 4 \end{bmatrix} = \frac{1}{18}\begin{bmatrix} 18 \\ 18 \\ 18 \end{bmatrix} = \begin{bmatrix} 1 \\ 1 \\ 1 \end{bmatrix}$ $\checkmark$

**最终答案**
- (a) $\vec{u}_1 = \frac{1}{3}\begin{bmatrix} 2 \\ 2 \\ 1 \end{bmatrix}, \;\vec{u}_2 = \frac{1}{3}\begin{bmatrix} -2 \\ 1 \\ 2 \end{bmatrix}, \;\vec{u}_3 = \frac{1}{6}\begin{bmatrix} 2 \\ -4 \\ 4 \end{bmatrix}$
- (b) $a_1 = \frac{5}{3}, \;a_2 = \frac{1}{3}, \;a_3 = \frac{1}{3}$
{{< /details >}}

### Q8. 特征值、重数与亏损性

> 对于以下矩阵，求 $A$ 的特征值和特征向量。对于每个特征值，给出代数和几何重数。$A$ 是否亏损？
>
> - (a) $A = \begin{bmatrix} 3 & 0 \\ 0 & 3 \end{bmatrix}$。
> - (b) $A = \begin{bmatrix} 3 & 1 \\ 0 & 3 \end{bmatrix}$。

{{< details summary="**本题答案**" >}}
**(a)** $A = \begin{bmatrix} 3 & 0 \\ 0 & 3 \end{bmatrix}$

这是 $3I$。特征方程：$\det(A - \lambda I) = (3-\lambda)^2 = 0$。

- **特征值：** $\lambda = 3$
- **代数重数：** 2

特征向量：$(A - 3I)\vec{x} = \vec{0} \implies \begin{bmatrix} 0 & 0 \\ 0 & 0 \end{bmatrix}\vec{x} = \vec{0}$。$\mathbb{R}^2$ 中的任意向量都是特征向量。

特征空间的基：$\left\{ \begin{bmatrix} 1 \\ 0 \end{bmatrix}, \begin{bmatrix} 0 \\ 1 \end{bmatrix} \right\}$

- **几何重数：** 2
- **是否亏损？** 否（所有特征值的代数重数等于几何重数）

---

**(b)** $A = \begin{bmatrix} 3 & 1 \\ 0 & 3 \end{bmatrix}$

特征方程：$\det(A - \lambda I) = (3-\lambda)^2 = 0$。

- **特征值：** $\lambda = 3$
- **代数重数：** 2

特征向量：$(A - 3I)\vec{x} = \vec{0} \implies \begin{bmatrix} 0 & 1 \\ 0 & 0 \end{bmatrix}\begin{bmatrix} x_1 \\ x_2 \end{bmatrix} = \begin{bmatrix} 0 \\ 0 \end{bmatrix} \implies x_2 = 0, x_1$ 自由。

特征空间的基：$\left\{ \begin{bmatrix} 1 \\ 0 \end{bmatrix} \right\}$

- **几何重数：** 1
- **是否亏损？** 是（代数重数 2 > 几何重数 1）

**最终答案**
- (a) $\lambda = 3$（代数重数 2，几何重数 2），非亏损
- (b) $\lambda = 3$（代数重数 2，几何重数 1），亏损
{{< /details >}}

### Q9. 特征值与特征空间

> $A = \begin{bmatrix} 1 & -1 \\ 1 & 1 \end{bmatrix}$。  
> 求 $A$ 的特征值和特征空间的基。

{{< details summary="**本题答案**" >}}
$$A = \begin{bmatrix} 1 & -1 \\ 1 & 1 \end{bmatrix}$$

**特征方程：**
$$\det(A - \lambda I) = \det\begin{bmatrix} 1-\lambda & -1 \\ 1 & 1-\lambda \end{bmatrix} = (1-\lambda)^2 + 1 = 0$$
$$(1-\lambda)^2 = -1 \implies 1-\lambda = \pm i$$

**特征值：**
$$\lambda_1 = 1 + i, \quad \lambda_2 = 1 - i$$

---

**$\lambda_1 = 1 + i$ 的特征向量：**

$$(A - (1+i)I)\vec{x} = \begin{bmatrix} -i & -1 \\ 1 & -i \end{bmatrix}\begin{bmatrix} x_1 \\ x_2 \end{bmatrix} = \begin{bmatrix} 0 \\ 0 \end{bmatrix}$$

由第一行：$-ix_1 - x_2 = 0 \implies x_2 = -ix_1$。

令 $x_1 = 1 \implies x_2 = -i$。特征空间的基：$\begin{bmatrix} 1 \\ -i \end{bmatrix}$。

---

**$\lambda_2 = 1 - i$ 的特征向量：**

$$(A - (1-i)I)\vec{x} = \begin{bmatrix} i & -1 \\ 1 & i \end{bmatrix}\begin{bmatrix} x_1 \\ x_2 \end{bmatrix} = \begin{bmatrix} 0 \\ 0 \end{bmatrix}$$

由第一行：$ix_1 - x_2 = 0 \implies x_2 = ix_1$。

令 $x_1 = 1 \implies x_2 = i$。特征空间的基：$\begin{bmatrix} 1 \\ i \end{bmatrix}$。

**最终答案**
- $\lambda_1 = 1+i$，基：$\left\{ \begin{bmatrix} 1 \\ -i \end{bmatrix} \right\}$
- $\lambda_2 = 1-i$，基：$\left\{ \begin{bmatrix} 1 \\ i \end{bmatrix} \right\}$
{{< /details >}}

### Q10. 矩阵对角化

> 设 $A = \begin{bmatrix} 4 & -3 \\ 2 & -1 \end{bmatrix}$。  
> 将矩阵对角化，并利用对角化计算 $A^6$。

{{< details summary="**本题答案**" >}}
$$A = \begin{bmatrix} 4 & -3 \\ 2 & -1 \end{bmatrix}$$

**步骤 1：求特征值**

$$\det(A - \lambda I) = \det\begin{bmatrix} 4-\lambda & -3 \\ 2 & -1-\lambda \end{bmatrix} = (4-\lambda)(-1-\lambda) + 6 = \lambda^2 - 3\lambda + 2 = (\lambda-1)(\lambda-2) = 0$$

**特征值：** $\lambda_1 = 1$，$\lambda_2 = 2$。

---

**步骤 2：求特征向量**

**对于 $\lambda_1 = 1$：**
$$(A - I)\vec{x} = \begin{bmatrix} 3 & -3 \\ 2 & -2 \end{bmatrix}\begin{bmatrix} x_1 \\ x_2 \end{bmatrix} = \begin{bmatrix} 0 \\ 0 \end{bmatrix} \implies x_1 = x_2$$
特征向量：$\vec{p}_1 = \begin{bmatrix} 1 \\ 1 \end{bmatrix}$

**对于 $\lambda_2 = 2$：**
$$(A - 2I)\vec{x} = \begin{bmatrix} 2 & -3 \\ 2 & -3 \end{bmatrix}\begin{bmatrix} x_1 \\ x_2 \end{bmatrix} = \begin{bmatrix} 0 \\ 0 \end{bmatrix} \implies 2x_1 = 3x_2 \implies x_1 = \frac{3}{2}x_2$$
特征向量：$\vec{p}_2 = \begin{bmatrix} 3 \\ 2 \end{bmatrix}$

---

**步骤 3：对角化**

$$P = \begin{bmatrix} 1 & 3 \\ 1 & 2 \end{bmatrix}, \quad D = \begin{bmatrix} 1 & 0 \\ 0 & 2 \end{bmatrix}$$

验证：$A = PDP^{-1}$，其中 $P^{-1} = \frac{1}{2-3}\begin{bmatrix} 2 & -3 \\ -1 & 1 \end{bmatrix} = \begin{bmatrix} -2 & 3 \\ 1 & -1 \end{bmatrix}$

---

**步骤 4：计算 $A^6$**

$$A^6 = PD^6P^{-1} = \begin{bmatrix} 1 & 3 \\ 1 & 2 \end{bmatrix}\begin{bmatrix} 1 & 0 \\ 0 & 64 \end{bmatrix}\begin{bmatrix} -2 & 3 \\ 1 & -1 \end{bmatrix}$$

$$= \begin{bmatrix} 1 & 192 \\ 1 & 128 \end{bmatrix}\begin{bmatrix} -2 & 3 \\ 1 & -1 \end{bmatrix} = \begin{bmatrix} -2+192 & 3-192 \\ -2+128 & 3-128 \end{bmatrix} = \begin{bmatrix} 190 & -189 \\ 126 & -125 \end{bmatrix}$$

**最终答案**
- $A = PDP^{-1}$，其中 $P = \begin{bmatrix} 1 & 3 \\ 1 & 2 \end{bmatrix}$，$D = \begin{bmatrix} 1 & 0 \\ 0 & 2 \end{bmatrix}$，$P^{-1} = \begin{bmatrix} -2 & 3 \\ 1 & -1 \end{bmatrix}$
- $A^6 = \begin{bmatrix} 190 & -189 \\ 126 & -125 \end{bmatrix}$
{{< /details >}}

### Q11. 对称矩阵的对角化

> 设 $A = \begin{bmatrix} 2 & 0 & -1 \\ 0 & 3 & 0 \\ -1 & 0 & 2 \end{bmatrix}$。  
> $A$ 是否可对角化？如果是，求 $A$ 的对角化。

{{< details summary="**本题答案**" >}}
$$A = \begin{bmatrix} 2 & 0 & -1 \\ 0 & 3 & 0 \\ -1 & 0 & 2 \end{bmatrix}$$

由于 $A$ 是对称矩阵，保证可以对角化。

**步骤 1：求特征值**

$$\det(A - \lambda I) = \det\begin{bmatrix} 2-\lambda & 0 & -1 \\ 0 & 3-\lambda & 0 \\ -1 & 0 & 2-\lambda \end{bmatrix}$$

沿第二行展开：
$$(3-\lambda) \cdot \det\begin{bmatrix} 2-\lambda & -1 \\ -1 & 2-\lambda \end{bmatrix} = (3-\lambda)\left((2-\lambda)^2 - 1\right)$$
$$= (3-\lambda)(\lambda^2 - 4\lambda + 3) = (3-\lambda)(\lambda-1)(\lambda-3) = -(\lambda-1)(\lambda-3)^2$$

**特征值：** $\lambda_1 = 1$，$\lambda_2 = 3$。

---

**步骤 2：求特征向量**

**对于 $\lambda_1 = 1$：**
$$(A - I)\vec{x} = \begin{bmatrix} 1 & 0 & -1 \\ 0 & 2 & 0 \\ -1 & 0 & 1 \end{bmatrix}\begin{bmatrix} x_1 \\ x_2 \\ x_3 \end{bmatrix} = \begin{bmatrix} 0 \\ 0 \\ 0 \end{bmatrix}$$
$x_1 - x_3 = 0 \implies x_1 = x_3$，且 $2x_2 = 0 \implies x_2 = 0$。  
特征向量：$\vec{p}_1 = \begin{bmatrix} 1 \\ 0 \\ 1 \end{bmatrix}$

**对于 $\lambda_2 = 3$：**
$$(A - 3I)\vec{x} = \begin{bmatrix} -1 & 0 & -1 \\ 0 & 0 & 0 \\ -1 & 0 & -1 \end{bmatrix}\begin{bmatrix} x_1 \\ x_2 \\ x_3 \end{bmatrix} = \begin{bmatrix} 0 \\ 0 \\ 0 \end{bmatrix}$$
$x_1 + x_3 = 0 \implies x_3 = -x_1$，且 $x_2$ 自由。  
特征向量：$\vec{p}_2 = \begin{bmatrix} 0 \\ 1 \\ 0 \end{bmatrix}$，$\vec{p}_3 = \begin{bmatrix} 1 \\ 0 \\ -1 \end{bmatrix}$

---

**步骤 3：对角化**

$$P = \begin{bmatrix} 1 & 0 & 1 \\ 0 & 1 & 0 \\ 1 & 0 & -1 \end{bmatrix}, \quad D = \begin{bmatrix} 1 & 0 & 0 \\ 0 & 3 & 0 \\ 0 & 0 & 3 \end{bmatrix}$$

由于 $A$ 是对称矩阵且来自不同特征空间的特征向量正交，我们可以归一化：
$$\vec{u}_1 = \frac{1}{\sqrt{2}}\begin{bmatrix} 1 \\ 0 \\ 1 \end{bmatrix}, \;\vec{u}_2 = \begin{bmatrix} 0 \\ 1 \\ 0 \end{bmatrix}, \;\vec{u}_3 = \frac{1}{\sqrt{2}}\begin{bmatrix} 1 \\ 0 \\ -1 \end{bmatrix}$$

$$Q = \begin{bmatrix} \frac{1}{\sqrt{2}} & 0 & \frac{1}{\sqrt{2}} \\ 0 & 1 & 0 \\ \frac{1}{\sqrt{2}} & 0 & -\frac{1}{\sqrt{2}} \end{bmatrix}, \quad D = \begin{bmatrix} 1 & 0 & 0 \\ 0 & 3 & 0 \\ 0 & 0 & 3 \end{bmatrix}$$

且 $A = QDQ^T$（正交对角化）。

**最终答案**
- 是，$A$ 可对角化（它是对称矩阵）。
- 特征值：$\lambda = 1$（重数 1），$\lambda = 3$（重数 2）
- $A = PDP^{-1}$，其中 $P = \begin{bmatrix} 1 & 0 & 1 \\ 0 & 1 & 0 \\ 1 & 0 & -1 \end{bmatrix}$，$D = \begin{bmatrix} 1 & 0 & 0 \\ 0 & 3 & 0 \\ 0 & 0 & 3 \end{bmatrix}$
- 正交对角化：$A = QDQ^T$，其中 $Q$ 为上述标准正交矩阵。
{{< /details >}}
