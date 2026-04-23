---
title: MATH 2010 Exam 4 Review Problems
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
description: MATH 2010 exam 3 review problems and solution
keywords:
license:
comment: true
weight: 0
tags:
  - RPI
  - Exam
  - MATH-2010
categories:
  - Electrical Engineering
collections:
  - MATH-2010
hiddenFromHomePage: false
hiddenFromSearch: false
hiddenFromRss: false
hiddenFromRelated: false
summary: MATH 2010 exam 3 review problems and solution
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

## Overview

Exam #4 will be administered in LECTURE on Friday, April 24 and will cover all Matrix Algebra content covered this semester (Lectures 13–26). There will be a greater emphasis on material covered after Exam 3 (sections **3.3, 3.4, 3.5, 3.6, 4.1, 4.2, 4.4, 4.5, 4.6, and 4.7**), but you should be prepared to answer questions from any of the sections covered on Exam 3 (sections 1.1, 1.2, 1.3, 1.5, 1.6, 1.7, 1.9, and 3.2).

If you submitted a ANSS memo with accommodations for exams, you will be contacted via email with details regarding the alternate location of your exam. Only students who have emailed the instructor their accommodations memorandum by Wednesday 4/22 at 5PM will be able to use their testing accommodations on Exam 3.

You will have 70 minutes to complete the exam. Students must arrive on time and listen to instructions regarding seating requirements. Students must leave all backpacks in the front of the exam room up against the wall.  Do not block any exits or obstruct any walkways. You will not be granted any additional time to complete your exam if you arrive after the exam has begun. Students will be required to sign in and collected exams will be cross-checked with the sign-in sheets. Exams from students who do not sign in will not be graded.

## Questions

### Q1. Span and Linear Combinations

> Let $\vec{v}_1 = \begin{bmatrix} 1 \\ 2 \\ 0 \end{bmatrix}$ and $\vec{v}_2 = \begin{bmatrix} 0 \\ -1 \\ 1 \end{bmatrix}$.  
> For each vector below, determine if the vector is in $Sp\{\vec{v}_1, \vec{v}_2\}$. For each vector in $Sp\{\vec{v}_1, \vec{v}_2\}$ write the vector as a linear combination of $\vec{v}_1$ and $\vec{v}_2$.
>
> - (a) $\vec{v} = \begin{bmatrix} 1 \\ 1 \\ -1 \end{bmatrix}$
> - (b) $\vec{w} = \begin{bmatrix} 2 \\ 3 \\ 1 \end{bmatrix}$

{{< details summary="**Answer of This Question**" >}}
We check if each vector can be written as $c_1\vec{v}_1 + c_2\vec{v}_2$.

**(a)** $\vec{v} = \begin{bmatrix} 1 \\ 1 \\ -1 \end{bmatrix}$

Set up the system $c_1\begin{bmatrix} 1 \\ 2 \\ 0 \end{bmatrix} + c_2\begin{bmatrix} 0 \\ -1 \\ 1 \end{bmatrix} = \begin{bmatrix} 1 \\ 1 \\ -1 \end{bmatrix}$:

$$\begin{cases} c_1 = 1 \\ 2c_1 - c_2 = 1 \\ c_2 = -1 \end{cases}$$

From the first equation: $c_1 = 1$.  
From the third equation: $c_2 = -1$.  
Substituting into the second: $2(1) - (-1) = 3 \neq 1$. **Contradiction.**

**Answer (a):** $\vec{v} \notin Sp\{\vec{v}_1, \vec{v}_2\}$.

---

**(b)** $\vec{w} = \begin{bmatrix} 2 \\ 3 \\ 1 \end{bmatrix}$

Set up the system $c_1\begin{bmatrix} 1 \\ 2 \\ 0 \end{bmatrix} + c_2\begin{bmatrix} 0 \\ -1 \\ 1 \end{bmatrix} = \begin{bmatrix} 2 \\ 3 \\ 1 \end{bmatrix}$:

$$\begin{cases} c_1 = 2 \\ 2c_1 - c_2 = 3 \\ c_2 = 1 \end{cases}$$

From the first equation: $c_1 = 2$.  
From the third equation: $c_2 = 1$.  
Checking the second: $2(2) - 1 = 3$. **Consistent** $\checkmark$

**Answer (b):** $\vec{w} \in Sp\{\vec{v}_1, \vec{v}_2\}$ and $\vec{w} = 2\vec{v}_1 + \vec{v}_2$.

**Final Answer**
- (a) $\vec{v} \notin Sp\{\vec{v}_1, \vec{v}_2\}$
- (b) $\vec{w} = 2\vec{v}_1 + \vec{v}_2$
{{< /details >}}

### Q2. Null Space

> Determine which of the following vectors are in the null space of the matrix $A = \begin{bmatrix} 2 & 2 \\ 3 & 3 \end{bmatrix}$.
>
> - (a) $\vec{a} = \begin{bmatrix} 1 \\ -1 \end{bmatrix}$
> - (b) $\vec{b} = \begin{bmatrix} 2 \\ -3 \end{bmatrix}$
> - (c) $\vec{c} = \begin{bmatrix} -2 \\ 2 \end{bmatrix}$
> - (d) $\vec{d} = \begin{bmatrix} 1 \\ 0 \end{bmatrix}$
> - (e) $\vec{e} = \begin{bmatrix} 0 \\ 0 \end{bmatrix}$

{{< details summary="**Answer of This Question**" >}}
A vector $\vec{x}$ is in the null space of $A$ if $A\vec{x} = \vec{0}$.

**Check each vector:**

**(a)** $A\vec{a} = \begin{bmatrix} 2 & 2 \\ 3 & 3 \end{bmatrix}\begin{bmatrix} 1 \\ -1 \end{bmatrix} = \begin{bmatrix} 2-2 \\ 3-3 \end{bmatrix} = \begin{bmatrix} 0 \\ 0 \end{bmatrix}$ ✅

**(b)** $A\vec{b} = \begin{bmatrix} 2 & 2 \\ 3 & 3 \end{bmatrix}\begin{bmatrix} 2 \\ -3 \end{bmatrix} = \begin{bmatrix} 4-6 \\ 6-9 \end{bmatrix} = \begin{bmatrix} -2 \\ -3 \end{bmatrix} \neq \vec{0}$ ❌

**(c)** $A\vec{c} = \begin{bmatrix} 2 & 2 \\ 3 & 3 \end{bmatrix}\begin{bmatrix} -2 \\ 2 \end{bmatrix} = \begin{bmatrix} -4+4 \\ -6+6 \end{bmatrix} = \begin{bmatrix} 0 \\ 0 \end{bmatrix}$ ✅

**(d)** $A\vec{d} = \begin{bmatrix} 2 & 2 \\ 3 & 3 \end{bmatrix}\begin{bmatrix} 1 \\ 0 \end{bmatrix} = \begin{bmatrix} 2 \\ 3 \end{bmatrix} \neq \vec{0}$ ❌

**(e)** $A\vec{e} = \begin{bmatrix} 2 & 2 \\ 3 & 3 \end{bmatrix}\begin{bmatrix} 0 \\ 0 \end{bmatrix} = \begin{bmatrix} 0 \\ 0 \end{bmatrix}$ ✅

**Final Answer**
In $N(A)$: $\vec{a}, \vec{c}, \vec{e}$. Not in $N(A)$: $\vec{b}, \vec{d}$.
{{< /details >}}

### Q3. Range (Column Space)

> Determine which of the following vectors are in the range of the matrix $A = \begin{bmatrix} -1 & 3 \\ 2 & -6 \end{bmatrix}$ (Also called the column space of $A$). If the vector is in the range of $A$, write the vector as a linear combination of the columns of $A$.
>
> - (a) $\vec{b}_1 = \begin{bmatrix} 1 \\ -3 \end{bmatrix}$
> - (b) $\vec{b}_2 = \begin{bmatrix} 4 \\ -8 \end{bmatrix}$

{{< details summary="**Answer of This Question**" >}}
A vector $\vec{b}$ is in the range (column space) of $A$ if $A\vec{x} = \vec{b}$ is consistent. Equivalently, if $\vec{b}$ is a linear combination of the columns of $A$.

Let the columns of $A = \begin{bmatrix} -1 & 3 \\ 2 & -6 \end{bmatrix}$ be $\vec{a}_1 = \begin{bmatrix} -1 \\ 2 \end{bmatrix}$ and $\vec{a}_2 = \begin{bmatrix} 3 \\ -6 \end{bmatrix}$.

Note that $\vec{a}_2 = -3\vec{a}_1$, so the column space is 1-dimensional: $col(A) = Sp\{\vec{a}_1\}$.

**(a)** $\vec{b}_1 = \begin{bmatrix} 1 \\ -3 \end{bmatrix}$

Solve $c_1\begin{bmatrix} -1 \\ 2 \end{bmatrix} + c_2\begin{bmatrix} 3 \\ -6 \end{bmatrix} = \begin{bmatrix} 1 \\ -3 \end{bmatrix}$:
$$\begin{cases} -c_1 + 3c_2 = 1 \\ 2c_1 - 6c_2 = -3 \end{cases}$$
The second equation is $-2$ times the first: $-2(1) = -2 \neq -3$. **Inconsistent.**

**Answer (a):** $\vec{b}_1 \notin col(A)$.

---

**(b)** $\vec{b}_2 = \begin{bmatrix} 4 \\ -8 \end{bmatrix}$

Solve $c_1\begin{bmatrix} -1 \\ 2 \end{bmatrix} + c_2\begin{bmatrix} 3 \\ -6 \end{bmatrix} = \begin{bmatrix} 4 \\ -8 \end{bmatrix}$:
$$\begin{cases} -c_1 + 3c_2 = 4 \\ 2c_1 - 6c_2 = -8 \end{cases}$$
The second equation is $-2$ times the first: $-2(4) = -8$. **Consistent.**

Choosing $c_2 = 0$, we get $c_1 = -4$. So $\vec{b}_2 = -4\vec{a}_1 + 0\vec{a}_2$.

**Answer (b):** $\vec{b}_2 \in col(A)$ and $\vec{b}_2 = -4\vec{a}_1 + 0\vec{a}_2$.

**Final Answer**
- (a) $\vec{b}_1 \notin col(A)$
- (b) $\vec{b}_2 \in col(A)$, $\vec{b}_2 = -4\vec{a}_1 + 0\vec{a}_2$
{{< /details >}}

### Q4. Subspaces of a Matrix

> Let $A = \begin{bmatrix} 1 & 0 & 1 & 1 \\ 2 & 0 & 0 & 1 \\ 1 & 0 & -1 & 0 \end{bmatrix}$.
>
> - (a) Write $N(A)$ as the span of a set of linearly independent vectors.
> - (b) Write $col(A)$ as the span of a set of linearly independent vectors.
> - (c) Write $row(A)$ as the span of a set of linearly independent vectors.

{{< details summary="**Answer of This Question**" >}}
First, row reduce $A = \begin{bmatrix} 1 & 0 & 1 & 1 \\ 2 & 0 & 0 & 1 \\ 1 & 0 & -1 & 0 \end{bmatrix}$:

$$\left[\begin{array}{cccc} 1 & 0 & 1 & 1 \\ 2 & 0 & 0 & 1 \\ 1 & 0 & -1 & 0 \end{array}\right] \xrightarrow{R_2 \to R_2-2R_1,\; R_3 \to R_3-R_1} \left[\begin{array}{cccc} 1 & 0 & 1 & 1 \\ 0 & 0 & -2 & -1 \\ 0 & 0 & -2 & -1 \end{array}\right]$$

$$\xrightarrow{R_3 \to R_3-R_2} \left[\begin{array}{cccc} 1 & 0 & 1 & 1 \\ 0 & 0 & -2 & -1 \\ 0 & 0 & 0 & 0 \end{array}\right] \xrightarrow{R_2 \to -\frac{1}{2}R_2} \left[\begin{array}{cccc} 1 & 0 & 1 & 1 \\ 0 & 0 & 1 & \frac{1}{2} \\ 0 & 0 & 0 & 0 \end{array}\right]$$

$$\xrightarrow{R_1 \to R_1-R_2} \left[\begin{array}{cccc} 1 & 0 & 0 & \frac{1}{2} \\ 0 & 0 & 1 & \frac{1}{2} \\ 0 & 0 & 0 & 0 \end{array}\right]$$

This is the RREF. Pivot columns: 1, 3. Free variables: $x_2, x_4$.

**(a) Null space $N(A)$:**

From RREF: $x_1 + \frac{1}{2}x_4 = 0$ and $x_3 + \frac{1}{2}x_4 = 0$.

$$\begin{cases} x_1 = -\frac{1}{2}x_4 \\ x_2 = x_2 \text{ (free)} \\ x_3 = -\frac{1}{2}x_4 \\ x_4 = x_4 \text{ (free)} \end{cases}$$

In vector form:
$$\vec{x} = x_2\begin{bmatrix} 0 \\ 1 \\ 0 \\ 0 \end{bmatrix} + x_4\begin{bmatrix} -\frac{1}{2} \\ 0 \\ -\frac{1}{2} \\ 1 \end{bmatrix}$$

**Answer (a):** $N(A) = Sp\left\{ \begin{bmatrix} 0 \\ 1 \\ 0 \\ 0 \end{bmatrix}, \begin{bmatrix} -\frac{1}{2} \\ 0 \\ -\frac{1}{2} \\ 1 \end{bmatrix} \right\}$

**(b) Column space $col(A)$:**

Pivot columns are 1 and 3, so $col(A)$ is spanned by columns 1 and 3 of the original $A$:

**Answer (b):** $col(A) = Sp\left\{ \begin{bmatrix} 1 \\ 2 \\ 1 \end{bmatrix}, \begin{bmatrix} 1 \\ 0 \\ -1 \end{bmatrix} \right\}$

**(c) Row space $row(A)$:**

The nonzero rows of the RREF form a basis:

**Answer (c):** $row(A) = Sp\left\{ \begin{bmatrix} 1 \\ 0 \\ 0 \\ \frac{1}{2} \end{bmatrix}^T, \begin{bmatrix} 0 \\ 0 \\ 1 \\ \frac{1}{2} \end{bmatrix}^T \right\}$
{{< /details >}}

### Q5. Basis and Dimension for Column, Row, and Null Spaces

> Let $A = \begin{bmatrix} 1 & 2 & 2 & -5 & 6 \\ -1 & -2 & -1 & 1 & -1 \\ 4 & 8 & 5 & -8 & 9 \\ 3 & 6 & 1 & 5 & -6 \end{bmatrix}$.  
> Find a basis for the column space, row space and nullspace of $A$. State the dimensions of each.

{{< details summary="**Answer of This Question**" >}}
$$A = \begin{bmatrix} 1 & 2 & 2 & -5 & 6 \\ -1 & -2 & -1 & 1 & -1 \\ 4 & 8 & 5 & -8 & 9 \\ 3 & 6 & 1 & 5 & -6 \end{bmatrix}$$

**Row reduction:**

$R_2 \to R_2 + R_1$: $[0, 0, 1, -4, 5]$
$R_3 \to R_3 - 4R_1$: $[0, 0, -3, 12, -15]$
$R_4 \to R_4 - 3R_1$: $[0, 0, -5, 20, -24]$

$$\left[\begin{array}{ccccc} 1 & 2 & 2 & -5 & 6 \\ 0 & 0 & 1 & -4 & 5 \\ 0 & 0 & -3 & 12 & -15 \\ 0 & 0 & -5 & 20 & -24 \end{array}\right]$$

$R_3 \to R_3 + 3R_2$: $[0, 0, 0, 0, 0]$
$R_4 \to R_4 + 5R_2$: $[0, 0, 0, 0, 1]$

Swap $R_3 \leftrightarrow R_4$:

$$\left[\begin{array}{ccccc} 1 & 2 & 2 & -5 & 6 \\ 0 & 0 & 1 & -4 & 5 \\ 0 & 0 & 0 & 0 & 1 \\ 0 & 0 & 0 & 0 & 0 \end{array}\right]$$

**To RREF:**
$R_2 \to R_2 - 5R_3$: $[0, 0, 1, -4, 0]$
$R_1 \to R_1 - 6R_3$: $[1, 2, 2, -5, 0]$
$R_1 \to R_1 - 2R_2$: $[1, 2, 0, 3, 0]$

$$\text{RREF} = \left[\begin{array}{ccccc} 1 & 2 & 0 & 3 & 0 \\ 0 & 0 & 1 & -4 & 0 \\ 0 & 0 & 0 & 0 & 1 \\ 0 & 0 & 0 & 0 & 0 \end{array}\right]$$

Pivot columns: 1, 3, 5. Free variables: $x_2, x_4$.

**Column space:** Columns 1, 3, 5 of the original $A$:
$$\text{basis} = \left\{ \begin{bmatrix} 1 \\ -1 \\ 4 \\ 3 \end{bmatrix}, \begin{bmatrix} 2 \\ -1 \\ 5 \\ 1 \end{bmatrix}, \begin{bmatrix} 6 \\ -1 \\ 9 \\ -6 \end{bmatrix} \right\}, \quad \dim = 3$$

**Row space:** Nonzero rows of RREF (written as row vectors):
$$\text{basis} = \left\{ \begin{bmatrix} 1 & 2 & 0 & 3 & 0 \end{bmatrix}, \begin{bmatrix} 0 & 0 & 1 & -4 & 0 \end{bmatrix}, \begin{bmatrix} 0 & 0 & 0 & 0 & 1 \end{bmatrix} \right\}, \quad \dim = 3$$

**Null space:**
$$\begin{cases} x_1 + 2x_2 + 3x_4 = 0 \\ x_3 - 4x_4 = 0 \\ x_5 = 0 \end{cases} \implies \begin{cases} x_1 = -2x_2 - 3x_4 \\ x_3 = 4x_4 \\ x_5 = 0 \end{cases}$$

$$\vec{x} = x_2\begin{bmatrix} -2 \\ 1 \\ 0 \\ 0 \\ 0 \end{bmatrix} + x_4\begin{bmatrix} -3 \\ 0 \\ 4 \\ 1 \\ 0 \end{bmatrix}$$

$$\text{basis} = \left\{ \begin{bmatrix} -2 \\ 1 \\ 0 \\ 0 \\ 0 \end{bmatrix}, \begin{bmatrix} -3 \\ 0 \\ 4 \\ 1 \\ 0 \end{bmatrix} \right\}, \quad \dim = 2$$

**Final Answer**
- Column space basis: $\left\{ \begin{bmatrix} 1 \\ -1 \\ 4 \\ 3 \end{bmatrix}, \begin{bmatrix} 2 \\ -1 \\ 5 \\ 1 \end{bmatrix}, \begin{bmatrix} 6 \\ -1 \\ 9 \\ -6 \end{bmatrix} \right\}$, $\dim = 3$
- Row space basis: $\left\{ \begin{bmatrix} 1 & 2 & 0 & 3 & 0 \end{bmatrix}, \begin{bmatrix} 0 & 0 & 1 & -4 & 0 \end{bmatrix}, \begin{bmatrix} 0 & 0 & 0 & 0 & 1 \end{bmatrix} \right\}$, $\dim = 3$
- Null space basis: $\left\{ \begin{bmatrix} -2 \\ 1 \\ 0 \\ 0 \\ 0 \end{bmatrix}, \begin{bmatrix} -3 \\ 0 \\ 4 \\ 1 \\ 0 \end{bmatrix} \right\}$, $\dim = 2$
{{< /details >}}

### Q6. Basis and Dimension of a Subspace

> Let $W = \left\{ \vec{x} = \begin{bmatrix} x_1 \\ x_2 \\ x_3 \end{bmatrix} \in \mathbb{R}^3 : x_1 - x_2 + x_3 = 0 \right\}$.
>
> - (a) Find a basis for $W$.
> - (b) What is the dimension of $W$?

{{< details summary="**Answer of This Question**" >}}
$W = \{ \vec{x} \in \mathbb{R}^3 : x_1 - x_2 + x_3 = 0 \}$

We can write $x_1 = x_2 - x_3$, so $x_2$ and $x_3$ are free variables.

**(a)** Any vector in $W$ can be written as:
$$\vec{x} = \begin{bmatrix} x_2-x_3 \\ x_2 \\ x_3 \end{bmatrix} = x_2\begin{bmatrix} 1 \\ 1 \\ 0 \end{bmatrix} + x_3\begin{bmatrix} -1 \\ 0 \\ 1 \end{bmatrix}$$

These two vectors are linearly independent (one is not a scalar multiple of the other).

**Answer (a):** A basis for $W$ is $\left\{ \begin{bmatrix} 1 \\ 1 \\ 0 \end{bmatrix}, \begin{bmatrix} -1 \\ 0 \\ 1 \end{bmatrix} \right\}$

**(b)** The dimension is the number of vectors in the basis.

**Answer (b):** $\dim(W) = 2$

**Final Answer**
- (a) Basis: $\left\{ \begin{bmatrix} 1 \\ 1 \\ 0 \end{bmatrix}, \begin{bmatrix} -1 \\ 0 \\ 1 \end{bmatrix} \right\}$
- (b) $\dim(W) = 2$
{{< /details >}}

### Q7. Gram-Schmidt Process and Coordinates

> Let $W = Sp\{\vec{v}_1, \vec{v}_2, \vec{v}_3\}$ where $\vec{v}_1 = \begin{bmatrix} 2 \\ 2 \\ 1 \end{bmatrix}$, $\vec{v}_2 = \begin{bmatrix} -2 \\ 1 \\ 2 \end{bmatrix}$, $\vec{v}_3 = \begin{bmatrix} 18 \\ 0 \\ 0 \end{bmatrix}$ are linearly independent.
>
> - (a) Use Gram-Schmidt to construct an orthonormal basis $\{\vec{u}_1, \vec{u}_2, \vec{u}_3\}$ for $W$.
> - (b) Find the coordinates of $\vec{x} = \begin{bmatrix} 1 \\ 1 \\ 1 \end{bmatrix}$ in terms of $\vec{u}_1, \vec{u}_2, \vec{u}_3$.  
>   i.e., Find $a_1, a_2, a_3$ such that $\vec{x} = a_1\vec{u}_1 + a_2\vec{u}_2 + a_3\vec{u}_3$.

{{< details summary="**Answer of This Question**" >}}
$\vec{v}_1 = \begin{bmatrix} 2 \\ 2 \\ 1 \end{bmatrix}, \;\vec{v}_2 = \begin{bmatrix} -2 \\ 1 \\ 2 \end{bmatrix}, \;\vec{v}_3 = \begin{bmatrix} 18 \\ 0 \\ 0 \end{bmatrix}$

**(a) Gram-Schmidt orthogonalization:**

**Step 1:** $\vec{w}_1 = \vec{v}_1 = \begin{bmatrix} 2 \\ 2 \\ 1 \end{bmatrix}, \quad \|\vec{w}_1\| = \sqrt{4+4+1} = 3$

**Step 2:**
$$\vec{w}_2 = \vec{v}_2 - \frac{\vec{v}_2 \cdot \vec{w}_1}{\|\vec{w}_1\|^2}\vec{w}_1$$
$\vec{v}_2 \cdot \vec{w}_1 = (-2)(2) + (1)(2) + (2)(1) = -4 + 2 + 2 = 0$
$$\vec{w}_2 = \vec{v}_2 = \begin{bmatrix} -2 \\ 1 \\ 2 \end{bmatrix}, \quad \|\vec{w}_2\| = \sqrt{4+1+4} = 3$$

**Step 3:**
$$\vec{w}_3 = \vec{v}_3 - \frac{\vec{v}_3 \cdot \vec{w}_1}{\|\vec{w}_1\|^2}\vec{w}_1 - \frac{\vec{v}_3 \cdot \vec{w}_2}{\|\vec{w}_2\|^2}\vec{w}_2$$
$\vec{v}_3 \cdot \vec{w}_1 = 18(2) = 36$
$\vec{v}_3 \cdot \vec{w}_2 = 18(-2) = -36$
$$\vec{w}_3 = \begin{bmatrix} 18 \\ 0 \\ 0 \end{bmatrix} - \frac{36}{9}\begin{bmatrix} 2 \\ 2 \\ 1 \end{bmatrix} - \frac{-36}{9}\begin{bmatrix} -2 \\ 1 \\ 2 \end{bmatrix} = \begin{bmatrix} 18 \\ 0 \\ 0 \end{bmatrix} - 4\begin{bmatrix} 2 \\ 2 \\ 1 \end{bmatrix} + 4\begin{bmatrix} -2 \\ 1 \\ 2 \end{bmatrix}$$
$$= \begin{bmatrix} 18-8-8 \\ 0-8+4 \\ 0-4+8 \end{bmatrix} = \begin{bmatrix} 2 \\ -4 \\ 4 \end{bmatrix}, \quad \|\vec{w}_3\| = \sqrt{4+16+16} = 6$$

**Normalize to get orthonormal basis:**
$$\vec{u}_1 = \frac{1}{3}\begin{bmatrix} 2 \\ 2 \\ 1 \end{bmatrix}, \quad \vec{u}_2 = \frac{1}{3}\begin{bmatrix} -2 \\ 1 \\ 2 \end{bmatrix}, \quad \vec{u}_3 = \frac{1}{6}\begin{bmatrix} 2 \\ -4 \\ 4 \end{bmatrix}$$

---

**(b) Coordinates of $\vec{x} = \begin{bmatrix} 1 \\ 1 \\ 1 \end{bmatrix}$:**

Since $\{\vec{u}_1, \vec{u}_2, \vec{u}_3\}$ is orthonormal:
$$a_1 = \vec{x} \cdot \vec{u}_1 = \frac{1}{3}(2+2+1) = \frac{5}{3}$$
$$a_2 = \vec{x} \cdot \vec{u}_2 = \frac{1}{3}(-2+1+2) = \frac{1}{3}$$
$$a_3 = \vec{x} \cdot \vec{u}_3 = \frac{1}{6}(2-4+4) = \frac{1}{3}$$

**Verification:** $\frac{5}{3}\vec{u}_1 + \frac{1}{3}\vec{u}_2 + \frac{1}{3}\vec{u}_3 = \frac{5}{9}\begin{bmatrix} 2 \\ 2 \\ 1 \end{bmatrix} + \frac{1}{9}\begin{bmatrix} -2 \\ 1 \\ 2 \end{bmatrix} + \frac{1}{18}\begin{bmatrix} 2 \\ -4 \\ 4 \end{bmatrix} = \frac{1}{18}\begin{bmatrix} 18 \\ 18 \\ 18 \end{bmatrix} = \begin{bmatrix} 1 \\ 1 \\ 1 \end{bmatrix}$ $\checkmark$

**Final Answer**
- (a) $\vec{u}_1 = \frac{1}{3}\begin{bmatrix} 2 \\ 2 \\ 1 \end{bmatrix}, \;\vec{u}_2 = \frac{1}{3}\begin{bmatrix} -2 \\ 1 \\ 2 \end{bmatrix}, \;\vec{u}_3 = \frac{1}{6}\begin{bmatrix} 2 \\ -4 \\ 4 \end{bmatrix}$
- (b) $a_1 = \frac{5}{3}, \;a_2 = \frac{1}{3}, \;a_3 = \frac{1}{3}$
{{< /details >}}

### Q8. Eigenvalues, Multiplicities, and Defectiveness

> For the following matrices, find the eigenvalues and eigenvectors of $A$. For each eigenvalue, state the algebraic and geometric multiplicities. Is $A$ defective?
>
> - (a) $A = \begin{bmatrix} 3 & 0 \\ 0 & 3 \end{bmatrix}$.
> - (b) $A = \begin{bmatrix} 3 & 1 \\ 0 & 3 \end{bmatrix}$.

{{< details summary="**Answer of This Question**" >}}
**(a)** $A = \begin{bmatrix} 3 & 0 \\ 0 & 3 \end{bmatrix}$

This is $3I$. Characteristic equation: $\det(A - \lambda I) = (3-\lambda)^2 = 0$.

- **Eigenvalue:** $\lambda = 3$
- **Algebraic multiplicity:** 2

Eigenvectors: $(A - 3I)\vec{x} = \vec{0} \implies \begin{bmatrix} 0 & 0 \\ 0 & 0 \end{bmatrix}\vec{x} = \vec{0}$. Every vector in $\mathbb{R}^2$ is an eigenvector.

Basis for eigenspace: $\left\{ \begin{bmatrix} 1 \\ 0 \end{bmatrix}, \begin{bmatrix} 0 \\ 1 \end{bmatrix} \right\}$

- **Geometric multiplicity:** 2
- **Defective?** No (algebraic = geometric for all eigenvalues)

---

**(b)** $A = \begin{bmatrix} 3 & 1 \\ 0 & 3 \end{bmatrix}$

Characteristic equation: $\det(A - \lambda I) = (3-\lambda)^2 = 0$.

- **Eigenvalue:** $\lambda = 3$
- **Algebraic multiplicity:** 2

Eigenvectors: $(A - 3I)\vec{x} = \vec{0} \implies \begin{bmatrix} 0 & 1 \\ 0 & 0 \end{bmatrix}\begin{bmatrix} x_1 \\ x_2 \end{bmatrix} = \begin{bmatrix} 0 \\ 0 \end{bmatrix} \implies x_2 = 0, x_1$ free.

Basis for eigenspace: $\left\{ \begin{bmatrix} 1 \\ 0 \end{bmatrix} \right\}$

- **Geometric multiplicity:** 1
- **Defective?** Yes (algebraic multiplicity 2 > geometric multiplicity 1)

**Final Answer**
- (a) $\lambda = 3$ (alg. mult. 2, geo. mult. 2), not defective
- (b) $\lambda = 3$ (alg. mult. 2, geo. mult. 1), defective
{{< /details >}}

### Q9. Eigenvalues and Eigenspaces

> $A = \begin{bmatrix} 1 & -1 \\ 1 & 1 \end{bmatrix}$.  
> Find the eigenvalues and a basis for the eigenspaces of $A$.

{{< details summary="**Answer of This Question**" >}}
$$A = \begin{bmatrix} 1 & -1 \\ 1 & 1 \end{bmatrix}$$

**Characteristic equation:**
$$\det(A - \lambda I) = \det\begin{bmatrix} 1-\lambda & -1 \\ 1 & 1-\lambda \end{bmatrix} = (1-\lambda)^2 + 1 = 0$$
$$(1-\lambda)^2 = -1 \implies 1-\lambda = \pm i$$

**Eigenvalues:**
$$\lambda_1 = 1 + i, \quad \lambda_2 = 1 - i$$

---

**Eigenvectors for $\lambda_1 = 1 + i$:**

$$(A - (1+i)I)\vec{x} = \begin{bmatrix} -i & -1 \\ 1 & -i \end{bmatrix}\begin{bmatrix} x_1 \\ x_2 \end{bmatrix} = \begin{bmatrix} 0 \\ 0 \end{bmatrix}$$

From the first row: $-ix_1 - x_2 = 0 \implies x_2 = -ix_1$.

Let $x_1 = 1 \implies x_2 = -i$. Basis for the eigenspace: $\begin{bmatrix} 1 \\ -i \end{bmatrix}$.

---

**Eigenvectors for $\lambda_2 = 1 - i$:**

$$(A - (1-i)I)\vec{x} = \begin{bmatrix} i & -1 \\ 1 & i \end{bmatrix}\begin{bmatrix} x_1 \\ x_2 \end{bmatrix} = \begin{bmatrix} 0 \\ 0 \end{bmatrix}$$

From the first row: $ix_1 - x_2 = 0 \implies x_2 = ix_1$.

Let $x_1 = 1 \implies x_2 = i$. Basis for the eigenspace: $\begin{bmatrix} 1 \\ i \end{bmatrix}$.

**Final Answer**
- $\lambda_1 = 1+i$, basis: $\left\{ \begin{bmatrix} 1 \\ -i \end{bmatrix} \right\}$
- $\lambda_2 = 1-i$, basis: $\left\{ \begin{bmatrix} 1 \\ i \end{bmatrix} \right\}$
{{< /details >}}

### Q10. Matrix Diagonalization

> Let $A = \begin{bmatrix} 4 & -3 \\ 2 & -1 \end{bmatrix}$.  
> Diagonalize the matrix and use the diagonalization to compute $A^6$.

{{< details summary="**Answer of This Question**" >}}
$$A = \begin{bmatrix} 4 & -3 \\ 2 & -1 \end{bmatrix}$$

**Step 1: Find eigenvalues**

$$\det(A - \lambda I) = \det\begin{bmatrix} 4-\lambda & -3 \\ 2 & -1-\lambda \end{bmatrix} = (4-\lambda)(-1-\lambda) + 6 = \lambda^2 - 3\lambda + 2 = (\lambda-1)(\lambda-2) = 0$$

**Eigenvalues:** $\lambda_1 = 1$, $\lambda_2 = 2$.

---

**Step 2: Find eigenvectors**

**For $\lambda_1 = 1$:**
$$(A - I)\vec{x} = \begin{bmatrix} 3 & -3 \\ 2 & -2 \end{bmatrix}\begin{bmatrix} x_1 \\ x_2 \end{bmatrix} = \begin{bmatrix} 0 \\ 0 \end{bmatrix} \implies x_1 = x_2$$
Eigenvector: $\vec{p}_1 = \begin{bmatrix} 1 \\ 1 \end{bmatrix}$

**For $\lambda_2 = 2$:**
$$(A - 2I)\vec{x} = \begin{bmatrix} 2 & -3 \\ 2 & -3 \end{bmatrix}\begin{bmatrix} x_1 \\ x_2 \end{bmatrix} = \begin{bmatrix} 0 \\ 0 \end{bmatrix} \implies 2x_1 = 3x_2 \implies x_1 = \frac{3}{2}x_2$$
Eigenvector: $\vec{p}_2 = \begin{bmatrix} 3 \\ 2 \end{bmatrix}$

---

**Step 3: Diagonalization**

$$P = \begin{bmatrix} 1 & 3 \\ 1 & 2 \end{bmatrix}, \quad D = \begin{bmatrix} 1 & 0 \\ 0 & 2 \end{bmatrix}$$

Check: $A = PDP^{-1}$ where $P^{-1} = \frac{1}{2-3}\begin{bmatrix} 2 & -3 \\ -1 & 1 \end{bmatrix} = \begin{bmatrix} -2 & 3 \\ 1 & -1 \end{bmatrix}$

---

**Step 4: Compute $A^6$**

$$A^6 = PD^6P^{-1} = \begin{bmatrix} 1 & 3 \\ 1 & 2 \end{bmatrix}\begin{bmatrix} 1 & 0 \\ 0 & 64 \end{bmatrix}\begin{bmatrix} -2 & 3 \\ 1 & -1 \end{bmatrix}$$

$$= \begin{bmatrix} 1 & 192 \\ 1 & 128 \end{bmatrix}\begin{bmatrix} -2 & 3 \\ 1 & -1 \end{bmatrix} = \begin{bmatrix} -2+192 & 3-192 \\ -2+128 & 3-128 \end{bmatrix} = \begin{bmatrix} 190 & -189 \\ 126 & -125 \end{bmatrix}$$

**Final Answer**
- $A = PDP^{-1}$ where $P = \begin{bmatrix} 1 & 3 \\ 1 & 2 \end{bmatrix}$, $D = \begin{bmatrix} 1 & 0 \\ 0 & 2 \end{bmatrix}$, $P^{-1} = \begin{bmatrix} -2 & 3 \\ 1 & -1 \end{bmatrix}$
- $A^6 = \begin{bmatrix} 190 & -189 \\ 126 & -125 \end{bmatrix}$
{{< /details >}}

### Q11. Diagonalization of Symmetric Matrix

> Let $A = \begin{bmatrix} 2 & 0 & -1 \\ 0 & 3 & 0 \\ -1 & 0 & 2 \end{bmatrix}$.  
> Is $A$ diagonalizable? If so, find the diagonalization of $A$.

{{< details summary="**Answer of This Question**" >}}
$$A = \begin{bmatrix} 2 & 0 & -1 \\ 0 & 3 & 0 \\ -1 & 0 & 2 \end{bmatrix}$$

Since $A$ is symmetric, it is guaranteed to be diagonalizable.

**Step 1: Find eigenvalues**

$$\det(A - \lambda I) = \det\begin{bmatrix} 2-\lambda & 0 & -1 \\ 0 & 3-\lambda & 0 \\ -1 & 0 & 2-\lambda \end{bmatrix}$$

Expanding along the second row:
$$(3-\lambda) \cdot \det\begin{bmatrix} 2-\lambda & -1 \\ -1 & 2-\lambda \end{bmatrix} = (3-\lambda)\left((2-\lambda)^2 - 1\right)$$
$$= (3-\lambda)(\lambda^2 - 4\lambda + 3) = (3-\lambda)(\lambda-1)(\lambda-3) = -(\lambda-1)(\lambda-3)^2$$

**Eigenvalues:** $\lambda_1 = 1$, $\lambda_2 = 3$.

---

**Step 2: Find eigenvectors**

**For $\lambda_1 = 1$:**
$$(A - I)\vec{x} = \begin{bmatrix} 1 & 0 & -1 \\ 0 & 2 & 0 \\ -1 & 0 & 1 \end{bmatrix}\begin{bmatrix} x_1 \\ x_2 \\ x_3 \end{bmatrix} = \begin{bmatrix} 0 \\ 0 \\ 0 \end{bmatrix}$$
$x_1 - x_3 = 0 \implies x_1 = x_3$, and $2x_2 = 0 \implies x_2 = 0$.
Eigenvector: $\vec{p}_1 = \begin{bmatrix} 1 \\ 0 \\ 1 \end{bmatrix}$

**For $\lambda_2 = 3$:**
$$(A - 3I)\vec{x} = \begin{bmatrix} -1 & 0 & -1 \\ 0 & 0 & 0 \\ -1 & 0 & -1 \end{bmatrix}\begin{bmatrix} x_1 \\ x_2 \\ x_3 \end{bmatrix} = \begin{bmatrix} 0 \\ 0 \\ 0 \end{bmatrix}$$
$x_1 + x_3 = 0 \implies x_3 = -x_1$, and $x_2$ is free.
Eigenvectors: $\vec{p}_2 = \begin{bmatrix} 0 \\ 1 \\ 0 \end{bmatrix}$, $\vec{p}_3 = \begin{bmatrix} 1 \\ 0 \\ -1 \end{bmatrix}$

---

**Step 3: Diagonalization**

$$P = \begin{bmatrix} 1 & 0 & 1 \\ 0 & 1 & 0 \\ 1 & 0 & -1 \end{bmatrix}, \quad D = \begin{bmatrix} 1 & 0 & 0 \\ 0 & 3 & 0 \\ 0 & 0 & 3 \end{bmatrix}$$

Since $A$ is symmetric and eigenvectors from distinct eigenspaces are orthogonal, we can normalize:
$$\vec{u}_1 = \frac{1}{\sqrt{2}}\begin{bmatrix} 1 \\ 0 \\ 1 \end{bmatrix}, \;\vec{u}_2 = \begin{bmatrix} 0 \\ 1 \\ 0 \end{bmatrix}, \;\vec{u}_3 = \frac{1}{\sqrt{2}}\begin{bmatrix} 1 \\ 0 \\ -1 \end{bmatrix}$$

$$Q = \begin{bmatrix} \frac{1}{\sqrt{2}} & 0 & \frac{1}{\sqrt{2}} \\ 0 & 1 & 0 \\ \frac{1}{\sqrt{2}} & 0 & -\frac{1}{\sqrt{2}} \end{bmatrix}, \quad D = \begin{bmatrix} 1 & 0 & 0 \\ 0 & 3 & 0 \\ 0 & 0 & 3 \end{bmatrix}$$

And $A = QDQ^T$ (orthogonal diagonalization).

**Final Answer**
- Yes, $A$ is diagonalizable (it is symmetric).
- Eigenvalues: $\lambda = 1$ (mult. 1), $\lambda = 3$ (mult. 2)
- $A = PDP^{-1}$ where $P = \begin{bmatrix} 1 & 0 & 1 \\ 0 & 1 & 0 \\ 1 & 0 & -1 \end{bmatrix}$, $D = \begin{bmatrix} 1 & 0 & 0 \\ 0 & 3 & 0 \\ 0 & 0 & 3 \end{bmatrix}$
- Orthogonal diagonalization: $A = QDQ^T$ where $Q$ is the orthonormal matrix above.
{{< /details >}}
