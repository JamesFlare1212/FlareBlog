---
title: MATH 2010 Exam 2 Review Problems
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
description: MATH 2010 exam 2 review problems and solution
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
summary: MATH 2010 exam 2 review problems and solution
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

Exam #2 will be administered in Test Block on Wednesday, March 11 and will cover all Multivariable Calculus content. There will be a greater emphasis on material covered after Exam 1 (sections **15.1, 15.2, 15.3, 15.4, 16.1, 16.2, 16.3, and 17.1**), but you should be prepared to answer questions from any of the sections covered on Exam 1 (sections 14.3, 14.4, 14.5, 14.6, 14.7, and 14.8)

If you submitted a ANSS memo with accommodations for exams, you will be contacted via email with details regarding the alternate location of your exam. Only students who have emailed the instructor their accommodations memorandum by Monday 3/9 at 5PM will be able to use their testing accommodations on Exam 2.

You will have 70 minutes to complete the exam. Students must arrive on time and listen to instructions regarding seating requirements. Students must leave all belongings (backpacks, jackets, and phones) in the front of the exam room up against the wall.  Do not block any exits or obstruct any walkways. You will not be granted any additional time to complete your exam if you arrive after the exam has begun. Students will be required to sign in and collected exams will be cross-checked with the sign-in sheets. Exams from students who do not sign in will not be graded.

## Questions

### Q1. Integration in Two Variables

> Evaluate $\iint_D xy \, dA$ where $D$ is the region bounded by the curves $y=x$ and $y=\sqrt{x}$.

{{< details summary="**Answer of This Question**" >}}
To evaluate the double integral $\iint_D xy \, dA$, we first need to determine the region of integration $D$ and set up the iterated integral.

**1. Determine the Region $D$**

The region $D$ is bounded by the curves $y = x$ and $y = \sqrt{x}$. To find the intersection points of these curves, we set the equations equal to each other:
$$
x = \sqrt{x}
$$
Squaring both sides gives:
$$
x^2 = x \implies x^2 - x = 0 \implies x(x - 1) = 0
$$
Thus, the intersection points occur at $x = 0$ and $x = 1$. The corresponding $y$-values are $y=0$ and $y=1$, giving the points $(0,0)$ and $(1,1)$.

On the interval $0 < x < 1$, we have $\sqrt{x} > x$. Therefore, the region $D$ can be described as:
$$
D = \{ (x, y) \mid 0 \le x \le 1, \, x \le y \le \sqrt{x} \}
$$

**2. Set Up the Integral**

We can express the double integral as an iterated integral integrating with respect to $y$ first, then $x$:
$$
\iint_D xy \, dA = \int_0^1 \int_x^{\sqrt{x}} xy \, dy \, dx
$$

**3. Evaluate the Inner Integral**

First, we integrate with respect to $y$, treating $x$ as a constant:
$$
\int_x^{\sqrt{x}} xy \, dy = x \left[ \frac{y^2}{2} \right]_{y=x}^{y=\sqrt{x}}
$$
Substituting the limits of integration:
$$
= x \left( \frac{(\sqrt{x})^2}{2} - \frac{x^2}{2} \right) = x \left( \frac{x}{2} - \frac{x^2}{2} \right) = \frac{x^2}{2} - \frac{x^3}{2}
$$

**4. Evaluate the Outer Integral**

Now, we integrate the result with respect to $x$ from $0$ to $1$:
$$
\int_0^1 \left( \frac{x^2}{2} - \frac{x^3}{2} \right) dx = \left[ \frac{x^3}{6} - \frac{x^4}{8} \right]_0^1
$$
Evaluating at the boundaries:
$$
= \left( \frac{1^3}{6} - \frac{1^4}{8} \right) - (0 - 0) = \frac{1}{6} - \frac{1}{8}
$$
Finding a common denominator:
$$
= \frac{4}{24} - \frac{3}{24} = \frac{1}{24}
$$

**Final Answer**

$$
\iint_D xy \, dA = \frac{1}{24}
$$
{{< /details >}}

### Q2. Integration in Polar Coordinates

> Compute the integral $\iint_D (x^2+y^2) \, dA$ using polar coordinates, where $D$ is the region bounded between the circles $x^2+y^2=4$, $x^2+y^2=9$ and $x \ge 0, y \ge 0$.

{{< details summary="**Answer of This Question**" >}}
To compute the integral $\iint_D (x^2+y^2) \, dA$ using polar coordinates, we proceed with the following steps.

**1. Coordinate Transformation**
We convert from Cartesian coordinates $(x, y)$ to polar coordinates $(r, \theta)$ using the relations:
$$
x = r \cos \theta, \quad y = r \sin \theta
$$
Consequently, the term $x^2 + y^2$ becomes $r^2$, and the area element $dA$ becomes $r \, dr \, d\theta$.

**2. Determine the Region of Integration**
The region $D$ is bounded by the circles $x^2+y^2=4$ and $x^2+y^2=9$, with the constraints $x \ge 0$ and $y \ge 0$.
- The equations of the circles translate to $r^2 = 4 \implies r = 2$ and $r^2 = 9 \implies r = 3$. Thus, the radial bounds are $2 \le r \le 3$.
- The constraints $x \ge 0$ and $y \ge 0$ restrict the region to the first quadrant, which corresponds to $0 \le \theta \le \frac{\pi}{2}$.

So, the region $D$ in polar coordinates is defined as:
$$
D = \left\{ (r, \theta) \mid 2 \le r \le 3, \, 0 \le \theta \le \frac{\pi}{2} \right\}
$$

**3. Set Up the Integral**
Substituting the integrand and the differential element into the double integral:
$$
\iint_D (x^2+y^2) \, dA = \int_0^{\pi/2} \int_2^3 (r^2) \cdot r \, dr \, d\theta = \int_0^{\pi/2} \int_2^3 r^3 \, dr \, d\theta
$$

**4. Evaluate the Integral**
First, we evaluate the inner integral with respect to $r$:
$$
\int_2^3 r^3 \, dr = \left[ \frac{r^4}{4} \right]_2^3 = \frac{3^4}{4} - \frac{2^4}{4} = \frac{81}{4} - \frac{16}{4} = \frac{65}{4}
$$
Next, we evaluate the outer integral with respect to $\theta$:
$$
\int_0^{\pi/2} \frac{65}{4} \, d\theta = \frac{65}{4} \Big[ \theta \Big]_0^{\pi/2} = \frac{65}{4} \left( \frac{\pi}{2} - 0 \right) = \frac{65\pi}{8}
$$

**Final Answer**
$$
\iint_D (x^2+y^2) \, dA = \frac{65\pi}{8}
$$
{{< /details>}}

### Q3. Integration in Polar Coordinates

> Calculate the integral of $f(x,y) = (x^2+y^2)^{-3/2}$ over the region $D$ given by $x^2+y^2 \le 16, x+y \ge 4$ by changing to polar coordinates.

{{< details summary="**Answer of This Question**" >}}
To calculate the integral of $f(x,y) = (x^2+y^2)^{-3/2}$ over the region $D$ using polar coordinates, we proceed as follows.

**1. Understand the Region $D$**

The region $D$ is defined by two conditions:
- $x^2+y^2 \le 16$: This is a disk of radius 4 centered at the origin.
- $x+y \ge 4$: This is the half-plane above the line $x+y=4$.

The region $D$ is the portion of the disk that lies above the line $x+y=4$.

**2. Find Intersection Points**

To find where the line $x+y=4$ intersects the circle $x^2+y^2=16$, we substitute $y = 4-x$ into the circle equation:
$$
x^2 + (4-x)^2 = 16
$$
$$
x^2 + 16 - 8x + x^2 = 16
$$
$$
2x^2 - 8x = 0 \implies 2x(x-4) = 0
$$
Thus, $x = 0$ or $x = 4$. The intersection points are $(0, 4)$ and $(4, 0)$.

**3. Convert to Polar Coordinates**

Using polar coordinates:
- $x = r \cos \theta$
- $y = r \sin \theta$
- $x^2 + y^2 = r^2$
- $dA = r \, dr \, d\theta$

The integrand becomes:
$$
(x^2+y^2)^{-3/2} = (r^2)^{-3/2} = r^{-3}
$$

**4. Determine the Bounds**

- **Radial bounds:** From the line $x+y=4$, we have $r(\cos\theta + \sin\theta) = 4$, so $r = \frac{4}{\cos\theta + \sin\theta}$. From the circle, $r = 4$. Thus, $\frac{4}{\cos\theta + \sin\theta} \le r \le 4$.
- **Angular bounds:** The intersection points $(4, 0)$ and $(0, 4)$ correspond to $\theta = 0$ and $\theta = \frac{\pi}{2}$ respectively. Thus, $0 \le \theta \le \frac{\pi}{2}$.

**5. Set Up the Integral**

$$
\iint_D (x^2+y^2)^{-3/2} \, dA = \int_0^{\pi/2} \int_{\frac{4}{\cos\theta + \sin\theta}}^4 r^{-3} \cdot r \, dr \, d\theta
$$
$$
= \int_0^{\pi/2} \int_{\frac{4}{\cos\theta + \sin\theta}}^4 r^{-2} \, dr \, d\theta
$$

**6. Evaluate the Inner Integral**

$$
\int_{\frac{4}{\cos\theta + \sin\theta}}^4 r^{-2} \, dr = \left[ -\frac{1}{r} \right]_{\frac{4}{\cos\theta + \sin\theta}}^4
$$
$$
= -\frac{1}{4} - \left( -\frac{\cos\theta + \sin\theta}{4} \right) = \frac{\cos\theta + \sin\theta - 1}{4}
$$

**7. Evaluate the Outer Integral**

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

**Final Answer**

$$
\iint_D (x^2+y^2)^{-3/2} \, dA = \frac{1}{2} - \frac{\pi}{8}
$$
{{< /details>}}

### Q4. Triple Integrals

> Evaluate $\iiint_B (xz + yz^2) \, dV$, where $B = [0,1] \times [2,4] \times [0,2]$.

{{< details summary="**Answer of This Question**" >}}
To evaluate the triple integral $\iiint_B (xz + yz^2) \, dV$, where $B = [0,1] \times [2,4] \times [0,2]$, we set up the iterated integral based on the bounds of the rectangular box $B$.

**1. Set Up the Integral**

The region $B$ is defined by the inequalities:
$$
0 \le x \le 1, \quad 2 \le y \le 4, \quad 0 \le z \le 2
$$
We can write the triple integral as an iterated integral. The order of integration does not matter for a rectangular box, but we will integrate with respect to $z$, then $y$, then $x$:
$$
\iiint_B (xz + yz^2) \, dV = \int_0^1 \int_2^4 \int_0^2 (xz + yz^2) \, dz \, dy \, dx
$$

**2. Evaluate the Inner Integral (with respect to $z$)**

First, we integrate with respect to $z$, treating $x$ and $y$ as constants:
$$
\int_0^2 (xz + yz^2) \, dz = \left[ x \frac{z^2}{2} + y \frac{z^3}{3} \right]_{z=0}^{z=2}
$$
Substituting the limits $z=2$ and $z=0$:
$$
= \left( x \frac{2^2}{2} + y \frac{2^3}{3} \right) - 0 = 2x + \frac{8y}{3}
$$

**3. Evaluate the Middle Integral (with respect to $y$)**

Next, we integrate the result with respect to $y$ from $2$ to $4$, treating $x$ as a constant:
$$
\int_2^4 \left( 2x + \frac{8y}{3} \right) \, dy = \left[ 2xy + \frac{8}{3} \cdot \frac{y^2}{2} \right]_{y=2}^{y=4}
$$
Simplifying the term with $y^2$:
$$
= \left[ 2xy + \frac{4y^2}{3} \right]_{y=2}^{y=4}
$$
Evaluating at the boundaries:
$$
= \left( 2x(4) + \frac{4(4)^2}{3} \right) - \left( 2x(2) + \frac{4(2)^2}{3} \right)
$$
$$
= \left( 8x + \frac{64}{3} \right) - \left( 4x + \frac{16}{3} \right)
$$
$$
= 4x + \frac{48}{3} = 4x + 16
$$

**4. Evaluate the Outer Integral (with respect to $x$)**

Finally, we integrate with respect to $x$ from $0$ to $1$:
$$
\int_0^1 (4x + 16) \, dx = \left[ 2x^2 + 16x \right]_0^1
$$
Evaluating at the boundaries:
$$
= (2(1)^2 + 16(1)) - 0 = 2 + 16 = 18
$$

**Final Answer**

$$
\iiint_B (xz + yz^2) \, dV = 18
$$
{{< /details>}}

### Q5. Triple Integrals

> Evaluate $\iiint_W 66z \, dV$ where $W: x^2 \le y \le 1, 0 \le x \le 1, x-y \le z \le x+y$

{{< details summary="**Answer of This Question**" >}}
To evaluate the triple integral $\iiint_W 66z \, dV$ over the region $W$, we first need to determine the limits of integration based on the given inequalities.

**1. Determine the Region of Integration**

The region $W$ is defined by:
- $0 \le x \le 1$
- $x^2 \le y \le 1$
- $x-y \le z \le x+y$

We can set up the iterated integral in the order $dz \, dy \, dx$:
$$
\iiint_W 66z \, dV = \int_0^1 \int_{x^2}^1 \int_{x-y}^{x+y} 66z \, dz \, dy \, dx
$$

**2. Evaluate the Inner Integral (with respect to $z$)**

First, we integrate with respect to $z$, treating $x$ and $y$ as constants:
$$
\int_{x-y}^{x+y} 66z \, dz = 66 \left[ \frac{z^2}{2} \right]_{x-y}^{x+y} = 33 \left[ z^2 \right]_{x-y}^{x+y}
$$
Substituting the limits:
$$
= 33 \left( (x+y)^2 - (x-y)^2 \right)
$$
Using the identity $(a+b)^2 - (a-b)^2 = 4ab$, where $a=x$ and $b=y$:
$$
= 33 (4xy) = 132xy
$$

**3. Evaluate the Middle Integral (with respect to $y$)**

Now, we integrate the result with respect to $y$ from $x^2$ to $1$, treating $x$ as a constant:
$$
\int_{x^2}^1 132xy \, dy = 132x \int_{x^2}^1 y \, dy
$$
$$
= 132x \left[ \frac{y^2}{2} \right]_{x^2}^1 = 132x \left( \frac{1^2}{2} - \frac{(x^2)^2}{2} \right)
$$
$$
= 132x \left( \frac{1}{2} - \frac{x^4}{2} \right) = 66x (1 - x^4) = 66x - 66x^5
$$

**4. Evaluate the Outer Integral (with respect to $x$)**

Finally, we integrate with respect to $x$ from $0$ to $1$:
$$
\int_0^1 (66x - 66x^5) \, dx = 66 \int_0^1 (x - x^5) \, dx
$$
$$
= 66 \left[ \frac{x^2}{2} - \frac{x^6}{6} \right]_0^1
$$
Evaluating at the boundaries:
$$
= 66 \left( \left( \frac{1}{2} - \frac{1}{6} \right) - 0 \right)
$$
Finding a common denominator for the fractions:
$$
= 66 \left( \frac{3}{6} - \frac{1}{6} \right) = 66 \left( \frac{2}{6} \right) = 66 \left( \frac{1}{3} \right) = 22
$$

**Final Answer**

$$
\iiint_W 66z \, dV = 22
$$
{{< /details>}}

### Q6. Vector Fields

> Find $\text{div}(\vec{F})$ and $\text{curl}(\vec{F})$ if $\vec{F} = \langle xy, e^{2y+3z}, x^2+z^2 \rangle$.

{{< details summary="**Answer of This Question**" >}}
Let the vector field be $\vec{F} = \langle P, Q, R \rangle$, where:
$$
P = xy, \quad Q = e^{2y+3z}, \quad R = x^2+z^2
$$

**1. Calculate the Divergence**

The divergence of $\vec{F}$ is given by the dot product of the del operator $\nabla$ and the vector field $\vec{F}$:
$$
\text{div}(\vec{F}) = \nabla \cdot \vec{F} = \frac{\partial P}{\partial x} + \frac{\partial Q}{\partial y} + \frac{\partial R}{\partial z}
$$

We compute the partial derivatives:
$$
\frac{\partial P}{\partial x} = \frac{\partial}{\partial x}(xy) = y
$$
$$
\frac{\partial Q}{\partial y} = \frac{\partial}{\partial y}(e^{2y+3z}) = 2e^{2y+3z}
$$
$$
\frac{\partial R}{\partial z} = \frac{\partial}{\partial z}(x^2+z^2) = 2z
$$

Adding these together, we get:
$$
\text{div}(\vec{F}) = y + 2e^{2y+3z} + 2z
$$

**2. Calculate the Curl**

The curl of $\vec{F}$ is given by the cross product of the del operator $\nabla$ and the vector field $\vec{F}$:
$$
\text{curl}(\vec{F}) = \nabla \times \vec{F} = \begin{vmatrix} \mathbf{i} & \mathbf{j} & \mathbf{k} \\ \frac{\partial}{\partial x} & \frac{\partial}{\partial y} & \frac{\partial}{\partial z} \\ P & Q & R \end{vmatrix}
$$
$$
= \left\langle \frac{\partial R}{\partial y} - \frac{\partial Q}{\partial z}, \frac{\partial P}{\partial z} - \frac{\partial R}{\partial x}, \frac{\partial Q}{\partial x} - \frac{\partial P}{\partial y} \right\rangle
$$

We compute the necessary partial derivatives:
- For the $\mathbf{i}$-component:
  $$
  \frac{\partial R}{\partial y} = 0, \quad \frac{\partial Q}{\partial z} = 3e^{2y+3z} \implies 0 - 3e^{2y+3z} = -3e^{2y+3z}
  $$
- For the $\mathbf{j}$-component:
  $$
  \frac{\partial P}{\partial z} = 0, \quad \frac{\partial R}{\partial x} = 2x \implies 0 - 2x = -2x
  $$
- For the $\mathbf{k}$-component:
  $$
  \frac{\partial Q}{\partial x} = 0, \quad \frac{\partial P}{\partial y} = x \implies 0 - x = -x
  $$

Thus, the curl is:
$$
\text{curl}(\vec{F}) = \langle -3e^{2y+3z}, -2x, -x \rangle
$$

**Final Answer**

$$
\text{div}(\vec{F}) = y + 2e^{2y+3z} + 2z
$$
$$
\text{curl}(\vec{F}) = \langle -3e^{2y+3z}, -2x, -x \rangle
$$
{{< /details>}}

### Q7. Scalar Line Integrals

> Evaluate $\int_C \sqrt{1+36xy} \, ds$ where $C$ is the curve $y=4x^3$ from $(0,0)$ to $(1,4)$.

{{< details summary="**Answer of This Question**" >}}
To evaluate the line integral $\int_C \sqrt{1+36xy} \, ds$, we need to parametrize the curve $C$, determine the arc length element $ds$, and then compute the definite integral.

**1. Parametrize the Curve $C$**

The curve $C$ is given by the function $y = 4x^3$ from the point $(0,0)$ to $(1,4)$. We can use $x$ as the parameter.  
Let $x = t$. Then $y = 4t^3$.  
The range for $x$ is from $0$ to $1$, so the parameter $t$ ranges from $0$ to $1$.
$$
\vec{r}(t) = \langle t, 4t^3 \rangle, \quad 0 \le t \le 1
$$

**2. Calculate the Arc Length Element $ds$**

The differential arc length $ds$ is given by:
$$
ds = \sqrt{\left(\frac{dx}{dt}\right)^2 + \left(\frac{dy}{dt}\right)^2} \, dt
$$
First, compute the derivatives with respect to $t$:
$$
\frac{dx}{dt} = 1, \quad \frac{dy}{dt} = 12t^2
$$
Substitute these into the formula for $ds$:
$$
ds = \sqrt{(1)^2 + (12t^2)^2} \, dt = \sqrt{1 + 144t^4} \, dt
$$

**3. Express the Integrand in Terms of $t$**

The integrand is $f(x,y) = \sqrt{1+36xy}$. Substitute $x=t$ and $y=4t^3$:
$$
\sqrt{1+36(t)(4t^3)} = \sqrt{1 + 144t^4}
$$

**4. Set Up and Evaluate the Integral**

Now, substitute the integrand and $ds$ into the line integral:
$$
\int_C \sqrt{1+36xy} \, ds = \int_0^1 \sqrt{1 + 144t^4} \cdot \sqrt{1 + 144t^4} \, dt
$$
The two square root terms multiply to form the expression inside the root:
$$
= \int_0^1 (1 + 144t^4) \, dt
$$
Now, evaluate the definite integral:
$$
= \left[ t + 144 \frac{t^5}{5} \right]_0^1
$$
$$
= \left( 1 + \frac{144}{5} \right) - (0 + 0)
$$
$$
= \frac{5}{5} + \frac{144}{5} = \frac{149}{5}
$$

**Final Answer**

$$
\int_C \sqrt{1+36xy} \, ds = \frac{149}{5}
$$
{{< /details>}}

### Q8. Vector Line Integrals

> Compute $\int_C \vec{F} \cdot d\vec{r}$ if $\vec{F} = \langle xy, 3, z^3 \rangle$ and $C$ is the curve parameterized by $\vec{r}(t) = \langle \cos t, \sin t, t \rangle$ for $0 \le t \le \pi$.  
> Note: $\vec{F}$ is not conservative. How do you know?

{{< details summary="**Answer of This Question**" >}}
To address the note first, we determine if the vector field $\vec{F}$ is conservative by calculating its curl.

**1. Is $\vec{F}$ Conservative?**

A vector field $\vec{F} = \langle P, Q, R \rangle$ is conservative if and only if $\text{curl}(\vec{F}) = \vec{0}$ (assuming the domain is simply connected).  
Given $\vec{F} = \langle xy, 3, z^3 \rangle$, we have $P = xy$, $Q = 3$, and $R = z^3$.  
The curl is given by:
$$
\text{curl}(\vec{F}) = \nabla \times \vec{F} = \left\langle \frac{\partial R}{\partial y} - \frac{\partial Q}{\partial z}, \frac{\partial P}{\partial z} - \frac{\partial R}{\partial x}, \frac{\partial Q}{\partial x} - \frac{\partial P}{\partial y} \right\rangle
$$
Calculating the components:
- $\frac{\partial R}{\partial y} - \frac{\partial Q}{\partial z} = 0 - 0 = 0$
- $\frac{\partial P}{\partial z} - \frac{\partial R}{\partial x} = 0 - 0 = 0$
- $\frac{\partial Q}{\partial x} - \frac{\partial P}{\partial y} = 0 - x = -x$

Thus,
$$
\text{curl}(\vec{F}) = \langle 0, 0, -x \rangle
$$
Since $\text{curl}(\vec{F}) \neq \vec{0}$ (specifically, the $z$-component is $-x$, which is not identically zero), the vector field is **not conservative**. This is why we cannot use the Fundamental Theorem of Line Integrals and must evaluate the integral directly.

**2. Compute the Line Integral**

We evaluate $\int_C \vec{F} \cdot d\vec{r}$ using the parameterization $\vec{r}(t) = \langle \cos t, \sin t, t \rangle$ for $0 \le t \le \pi$.

**Step 1: Find $d\vec{r}$**
$$
\vec{r}'(t) = \frac{d}{dt}\langle \cos t, \sin t, t \rangle = \langle -\sin t, \cos t, 1 \rangle
$$
$$
d\vec{r} = \vec{r}'(t) \, dt = \langle -\sin t, \cos t, 1 \rangle \, dt
$$

**Step 2: Evaluate $\vec{F}$ on the curve**
Substitute $x = \cos t$, $y = \sin t$, and $z = t$ into $\vec{F}$:
$$
\vec{F}(\vec{r}(t)) = \langle (\cos t)(\sin t), 3, t^3 \rangle = \langle \cos t \sin t, 3, t^3 \rangle
$$

**Step 3: Compute the dot product $\vec{F} \cdot d\vec{r}$**
$$
\vec{F}(\vec{r}(t)) \cdot \vec{r}'(t) = (\cos t \sin t)(-\sin t) + (3)(\cos t) + (t^3)(1)
$$
$$
= -\cos t \sin^2 t + 3 \cos t + t^3
$$

**Step 4: Integrate with respect to $t$**
$$
\int_C \vec{F} \cdot d\vec{r} = \int_0^{\pi} \left( -\cos t \sin^2 t + 3 \cos t + t^3 \right) \, dt
$$
We can split this into three integrals:
$$
= \int_0^{\pi} -\cos t \sin^2 t \, dt + \int_0^{\pi} 3 \cos t \, dt + \int_0^{\pi} t^3 \, dt
$$

- **First integral:** Let $u = \sin t$, then $du = \cos t \, dt$. The limits change from $0 \to 0$ and $\pi \to 0$.
  $$
  \int_0^{\pi} -\sin^2 t \cos t \, dt = \left[ -\frac{\sin^3 t}{3} \right]_0^{\pi} = 0 - 0 = 0
  $$

- **Second integral:**
  $$
  \int_0^{\pi} 3 \cos t \, dt = 3 [\sin t]_0^{\pi} = 3(0 - 0) = 0
  $$

- **Third integral:**
  $$
  \int_0^{\pi} t^3 \, dt = \left[ \frac{t^4}{4} \right]_0^{\pi} = \frac{\pi^4}{4} - 0 = \frac{\pi^4}{4}
  $$

Summing these results:
$$
0 + 0 + \frac{\pi^4}{4} = \frac{\pi^4}{4}
$$

**Final Answer**

$$
\int_C \vec{F} \cdot d\vec{r} = \frac{\pi^4}{4}
$$
{{< /details>}}

### Q9. Scalar/Vector Line Integrals

> Let $C$ be the line segment from the point $(-2, 1, 0)$ to the point $(-1, 2, 1)$. Set up the following integrals. Simplify the integrands.  
> a. $\int_C f(x,y,z) \, ds$, where $f(x,y,z) = yz - x^2$  
> b. $\int_C \vec{F} \cdot d\vec{r}$, where $\vec{F} = \langle 2x-y, 2z, y-z \rangle$

{{< details summary="**Answer of This Question**" >}}
To solve these integrals, we first need to parametrize the line segment $C$.

**1. Parametrize the Curve $C$**

The curve $C$ is the line segment from $P_0 = (-2, 1, 0)$ to $P_1 = (-1, 2, 1)$.  
The direction vector is $\vec{v} = P_1 - P_0 = \langle -1 - (-2), 2 - 1, 1 - 0 \rangle = \langle 1, 1, 1 \rangle$.  
We can parametrize the curve using $t$ where $0 \le t \le 1$:
$$
\vec{r}(t) = P_0 + t\vec{v} = \langle -2, 1, 0 \rangle + t\langle 1, 1, 1 \rangle = \langle -2+t, 1+t, t \rangle
$$
Thus, the coordinates are:
$$
x(t) = -2+t, \quad y(t) = 1+t, \quad z(t) = t
$$
The derivative of the position vector is:
$$
\vec{r}'(t) = \langle 1, 1, 1 \rangle
$$
The magnitude of the derivative is:
$$
\|\vec{r}'(t)\| = \sqrt{1^2 + 1^2 + 1^2} = \sqrt{3}
$$
Therefore, the differential arc length is $ds = \sqrt{3} \, dt$, and the differential vector is $d\vec{r} = \langle 1, 1, 1 \rangle \, dt$.

---

**a. Scalar Line Integral**

We need to set up $\int_C f(x,y,z) \, ds$ where $f(x,y,z) = yz - x^2$.

**Step 1: Substitute the parametrization into $f$**
$$
f(\vec{r}(t)) = y(t)z(t) - (x(t))^2 = (1+t)(t) - (-2+t)^2
$$
**Step 2: Simplify the integrand**
$$
= (t + t^2) - (4 - 4t + t^2)
$$
$$
= t + t^2 - 4 + 4t - t^2
$$
$$
= 5t - 4
$$
**Step 3: Set up the integral**
$$
\int_C f(x,y,z) \, ds = \int_0^1 (5t - 4) \sqrt{3} \, dt
$$
**Step 4: Evaluate**
$$
= \sqrt{3} \int_0^1 (5t - 4) \, dt = \sqrt{3} \left[ \frac{5t^2}{2} - 4t \right]_0^1
$$
$$
= \sqrt{3} \left( \frac{5}{2} - 4 \right) = \sqrt{3} \left( -\frac{3}{2} \right) = -\frac{3\sqrt{3}}{2}
$$

---

**b. Vector Line Integral**

We need to set up $\int_C \vec{F} \cdot d\vec{r}$ where $\vec{F} = \langle 2x-y, 2z, y-z \rangle$.

**Step 1: Substitute the parametrization into $\vec{F}$**
$$
\vec{F}(\vec{r}(t)) = \langle 2(-2+t) - (1+t), \, 2(t), \, (1+t) - t \rangle
$$
**Step 2: Simplify the components of $\vec{F}$**
- $x$-component: $2(-2+t) - (1+t) = -4 + 2t - 1 - t = t - 5$
- $y$-component: $2t$
- $z$-component: $1 + t - t = 1$
So, $\vec{F}(\vec{r}(t)) = \langle t - 5, 2t, 1 \rangle$.

**Step 3: Compute the dot product $\vec{F} \cdot \vec{r}'(t)$**
$$
\vec{F}(\vec{r}(t)) \cdot \vec{r}'(t) = \langle t - 5, 2t, 1 \rangle \cdot \langle 1, 1, 1 \rangle
$$
$$
= (t - 5)(1) + (2t)(1) + (1)(1)
$$
$$
= t - 5 + 2t + 1 = 3t - 4
$$
**Step 4: Set up the integral**
$$
\int_C \vec{F} \cdot d\vec{r} = \int_0^1 (3t - 4) \, dt
$$
**Step 5: Evaluate**
$$
= \left[ \frac{3t^2}{2} - 4t \right]_0^1
$$
$$
= \left( \frac{3}{2} - 4 \right) - 0 = \frac{3}{2} - \frac{8}{2} = -\frac{5}{2}
$$

**Final Answer**

a. $\displaystyle \int_C (yz - x^2) \, ds = \int_0^1 \sqrt{3}(5t - 4) \, dt = -\frac{3\sqrt{3}}{2}$  
b. $\displaystyle \int_C \vec{F} \cdot d\vec{r} = \int_0^1 (3t - 4) \, dt = -\frac{5}{2}$
{{< /details>}}

### Q10 Conservative Vector Field

> Let $\vec{F} = \langle 3+2xy, x^2-3y^2 \rangle$.  
> a. Show that $\vec{F}$ is conservative, then find a potential function for $\vec{F}$.  
> b. Evaluate $\int_C \vec{F} \cdot d\vec{r}$, where $C$ is given by $\vec{r}(t) = \langle e^t \sin t, e^t \cos t \rangle, 0 \le t \le \pi$.

{{< details summary="**Answer of This Question**" >}}
**a. Show that $\vec{F}$ is conservative and find a potential function**

Let $\vec{F} = \langle P, Q \rangle$, where $P = 3+2xy$ and $Q = x^2-3y^2$.  
For $\vec{F}$ to be conservative on a simply connected domain (like $\mathbb{R}^2$), the condition $\frac{\partial P}{\partial y} = \frac{\partial Q}{\partial x}$ must hold.

Calculate the partial derivatives:
$$
\frac{\partial P}{\partial y} = \frac{\partial}{\partial y}(3+2xy) = 2x
$$
$$
\frac{\partial Q}{\partial x} = \frac{\partial}{\partial x}(x^2-3y^2) = 2x
$$
Since $\frac{\partial P}{\partial y} = \frac{\partial Q}{\partial x}$, the vector field $\vec{F}$ is conservative.

To find the potential function $f(x,y)$ such that $\nabla f = \vec{F}$, we solve the system:
1. $\frac{\partial f}{\partial x} = 3+2xy$
2. $\frac{\partial f}{\partial y} = x^2-3y^2$

Integrate the first equation with respect to $x$:
$$
f(x,y) = \int (3+2xy) \, dx = 3x + x^2y + g(y)
$$
where $g(y)$ is an arbitrary function of $y$.

Now, differentiate this expression with respect to $y$ and set it equal to $Q$:
$$
\frac{\partial f}{\partial y} = \frac{\partial}{\partial y}(3x + x^2y + g(y)) = x^2 + g'(y)
$$
$$
x^2 + g'(y) = x^2 - 3y^2
$$
$$
g'(y) = -3y^2
$$
Integrate with respect to $y$:
$$
g(y) = \int -3y^2 \, dy = -y^3 + C
$$
Thus, the potential function is:
$$
f(x,y) = 3x + x^2y - y^3 + C
$$
We can choose $C=0$ for simplicity.

---

**b. Evaluate $\int_C \vec{F} \cdot d\vec{r}$**

Since $\vec{F}$ is conservative, we can use the Fundamental Theorem of Line Integrals:
$$
\int_C \vec{F} \cdot d\vec{r} = f(\text{end point}) - f(\text{start point})
$$
The curve $C$ is parameterized by $\vec{r}(t) = \langle e^t \sin t, e^t \cos t \rangle$ for $0 \le t \le \pi$.

Find the start point ($t=0$):
$$
\vec{r}(0) = \langle e^0 \sin 0, e^0 \cos 0 \rangle = \langle 0, 1 \rangle
$$
Find the end point ($t=\pi$):
$$
\vec{r}(\pi) = \langle e^\pi \sin \pi, e^\pi \cos \pi \rangle = \langle 0, -e^\pi \rangle
$$

Evaluate the potential function $f(x,y) = 3x + x^2y - y^3$ at these points:
At the start point $(0, 1)$:
$$
f(0, 1) = 3(0) + 0^2(1) - 1^3 = -1
$$
At the end point $(0, -e^\pi)$:
$$
f(0, -e^\pi) = 3(0) + 0^2(-e^\pi) - (-e^\pi)^3 = -(-e^{3\pi}) = e^{3\pi}
$$

Calculate the integral:
$$
\int_C \vec{F} \cdot d\vec{r} = f(0, -e^\pi) - f(0, 1) = e^{3\pi} - (-1) = e^{3\pi} + 1
$$

**Final Answer**

a. $\vec{F}$ is conservative because $\frac{\partial P}{\partial y} = \frac{\partial Q}{\partial x} = 2x$. A potential function is $f(x,y) = 3x + x^2y - y^3$.  
b. $\displaystyle \int_C \vec{F} \cdot d\vec{r} = e^{3\pi} + 1$
{{< /details>}}

### Q11. Conservative Vector Field

> The vector field $\vec{F} = \langle 2xy-z, x^2+2y, 1-x \rangle$ is conservative.  
> a. Find a potential function for $\vec{F}$.  
> b. Using the potential function from (a) evaluate $\int_C \vec{F} \cdot d\vec{r}$ where $C$ is any curve from $(1, 0, 2)$ to $(2, 1, 3)$.

{{< details summary="**Answer of This Question**" >}}
**a. Find a potential function for $\vec{F}$**

Since $\vec{F}$ is conservative, there exists a potential function $f(x, y, z)$ such that $\nabla f = \vec{F}$. This implies:
$$
\frac{\partial f}{\partial x} = 2xy - z, \quad \frac{\partial f}{\partial y} = x^2 + 2y, \quad \frac{\partial f}{\partial z} = 1 - x
$$

1.  **Integrate with respect to $x$:**
    $$
    f(x, y, z) = \int (2xy - z) \, dx = x^2y - xz + g(y, z)
    $$
    where $g(y, z)$ is an arbitrary function of $y$ and $z$.

2.  **Differentiate with respect to $y$ and compare:**
    $$
    \frac{\partial f}{\partial y} = \frac{\partial}{\partial y}(x^2y - xz + g(y, z)) = x^2 + \frac{\partial g}{\partial y}
    $$
    Comparing this to the given component $\frac{\partial f}{\partial y} = x^2 + 2y$, we get:
    $$
    x^2 + \frac{\partial g}{\partial y} = x^2 + 2y \implies \frac{\partial g}{\partial y} = 2y
    $$

3.  **Integrate with respect to $y$:**
    $$
    g(y, z) = \int 2y \, dy = y^2 + h(z)
    $$
    where $h(z)$ is an arbitrary function of $z$. Substituting this back into $f$:
    $$
    f(x, y, z) = x^2y - xz + y^2 + h(z)
    $$

4.  **Differentiate with respect to $z$ and compare:**
    $$
    \frac{\partial f}{\partial z} = \frac{\partial}{\partial z}(x^2y - xz + y^2 + h(z)) = -x + h'(z)
    $$
    Comparing this to the given component $\frac{\partial f}{\partial z} = 1 - x$, we get:
    $$
    -x + h'(z) = 1 - x \implies h'(z) = 1
    $$

5.  **Integrate with respect to $z$:**
    $$
    h(z) = \int 1 \, dz = z + C
    $$
    Combining all parts, the potential function is:
    $$
    f(x, y, z) = x^2y - xz + y^2 + z + C
    $$
    We can set $C=0$ for simplicity.

---

**b. Evaluate $\int_C \vec{F} \cdot d\vec{r}$**

By the Fundamental Theorem of Line Integrals, since $\vec{F} = \nabla f$:
$$
\int_C \vec{F} \cdot d\vec{r} = f(\text{end point}) - f(\text{start point})
$$
The curve $C$ goes from $A = (1, 0, 2)$ to $B = (2, 1, 3)$.

Evaluate $f$ at $B(2, 1, 3)$:
$$
f(2, 1, 3) = (2)^2(1) - (2)(3) + (1)^2 + 3 = 4 - 6 + 1 + 3 = 2
$$

Evaluate $f$ at $A(1, 0, 2)$:
$$
f(1, 0, 2) = (1)^2(0) - (1)(2) + (0)^2 + 2 = 0 - 2 + 0 + 2 = 0
$$

Calculate the difference:
$$
\int_C \vec{F} \cdot d\vec{r} = 2 - 0 = 2
$$

**Final Answer**

a. A potential function is $f(x, y, z) = x^2y - xz + y^2 + z$.  
b. $\displaystyle \int_C \vec{F} \cdot d\vec{r} = 2$
{{< /details>}}

### Q12. Green's Theorem

> Use Green's Theorem to compute the integral $\oint_C xy^3 \, dx + x^2y^2 \, dy$ where $C$ is the rectangle with vertices $(0,0), (2,0), (2,3), (0,3)$ oriented counter clockwise.

{{< details summary="**Answer of This Question**" >}}
To evaluate the line integral using Green's Theorem, we proceed with the following steps.

**1. State Green's Theorem**

Green's Theorem relates a line integral around a simple closed curve $C$ to a double integral over the plane region $D$ bounded by $C$. For a positively oriented (counter-clockwise) curve $C$:
$$
\oint_C P \, dx + Q \, dy = \iint_D \left( \frac{\partial Q}{\partial x} - \frac{\partial P}{\partial y} \right) \, dA
$$

**2. Identify $P$ and $Q$**

From the given integral $\oint_C xy^3 \, dx + x^2y^2 \, dy$, we identify:
$$
P(x, y) = xy^3, \quad Q(x, y) = x^2y^2
$$

**3. Compute the Partial Derivatives**

Calculate the partial derivative of $Q$ with respect to $x$:
$$
\frac{\partial Q}{\partial x} = \frac{\partial}{\partial x}(x^2y^2) = 2xy^2
$$
Calculate the partial derivative of $P$ with respect to $y$:
$$
\frac{\partial P}{\partial y} = \frac{\partial}{\partial y}(xy^3) = 3xy^2
$$

**4. Determine the Integrand**

Subtract the partial derivatives:
$$
\frac{\partial Q}{\partial x} - \frac{\partial P}{\partial y} = 2xy^2 - 3xy^2 = -xy^2
$$

**5. Define the Region $D$**

The region $D$ is the rectangle with vertices $(0,0), (2,0), (2,3), (0,3)$. This region can be described by the inequalities:
$$
0 \le x \le 2, \quad 0 \le y \le 3
$$

**6. Set Up and Evaluate the Double Integral**

Substitute the integrand and the limits into the double integral:
$$
\iint_D (-xy^2) \, dA = \int_0^3 \int_0^2 -xy^2 \, dx \, dy
$$
First, evaluate the inner integral with respect to $x$:
$$
\int_0^2 -xy^2 \, dx = -y^2 \left[ \frac{x^2}{2} \right]_0^2 = -y^2 \left( \frac{4}{2} - 0 \right) = -2y^2
$$
Next, evaluate the outer integral with respect to $y$:
$$
\int_0^3 -2y^2 \, dy = -2 \left[ \frac{y^3}{3} \right]_0^3 = -2 \left( \frac{27}{3} - 0 \right) = -2(9) = -18
$$

**Final Answer**

$$
\oint_C xy^3 \, dx + x^2y^2 \, dy = -18
$$
{{< /details>}}

### Q13. Green's Theorem

> Use Green's Theorem to evaluate $\oint_C (3y - e^{\sin x}) \, dx + (7x + \sqrt{y^4+1}) \, dy$, where $C$ is the circle $x^2+y^2=9$ oriented counterclockwise.

{{< details summary="**Answer of This Question**" >}}
To evaluate the line integral using Green's Theorem, we proceed with the following steps.

**1. State Green's Theorem**

Green's Theorem relates a line integral around a simple closed curve $C$ to a double integral over the plane region $D$ bounded by $C$. For a positively oriented (counter-clockwise) curve $C$:
$$
\oint_C P \, dx + Q \, dy = \iint_D \left( \frac{\partial Q}{\partial x} - \frac{\partial P}{\partial y} \right) \, dA
$$

**2. Identify $P$ and $Q$**

From the given integral $\oint_C (3y - e^{\sin x}) \, dx + (7x + \sqrt{y^4+1}) \, dy$, we identify:
$$
P(x, y) = 3y - e^{\sin x}, \quad Q(x, y) = 7x + \sqrt{y^4+1}
$$

**3. Compute the Partial Derivatives**

Calculate the partial derivative of $Q$ with respect to $x$:
$$
\frac{\partial Q}{\partial x} = \frac{\partial}{\partial x}(7x + \sqrt{y^4+1}) = 7 + 0 = 7
$$
Calculate the partial derivative of $P$ with respect to $y$:
$$
\frac{\partial P}{\partial y} = \frac{\partial}{\partial y}(3y - e^{\sin x}) = 3 - 0 = 3
$$
Note that the complicated terms $e^{\sin x}$ and $\sqrt{y^4+1}$ vanish upon differentiation because they depend only on $x$ and $y$ respectively, not the variable of differentiation.

**4. Determine the Integrand**

Subtract the partial derivatives:
$$
\frac{\partial Q}{\partial x} - \frac{\partial P}{\partial y} = 7 - 3 = 4
$$

**5. Define the Region $D$**

The curve $C$ is the circle $x^2+y^2=9$. This is a circle centered at the origin with radius $r = \sqrt{9} = 3$.  
The region $D$ is the disk enclosed by this circle.

**6. Set Up and Evaluate the Double Integral**

Substitute the integrand and the limits into the double integral:
$$
\iint_D 4 \, dA = 4 \iint_D dA
$$
The integral $\iint_D dA$ represents the area of the region $D$. Since $D$ is a disk with radius $r=3$, its area is:
$$
\text{Area}(D) = \pi r^2 = \pi (3)^2 = 9\pi
$$
Therefore, the value of the double integral is:
$$
4 \times 9\pi = 36\pi
$$

**Final Answer**

$$
\oint_C (3y - e^{\sin x}) \, dx + (7x + \sqrt{y^4+1}) \, dy = 36\pi
$$
{{< /details>}}

## Cribs

### Double Integral in Polar Coordinates

For a continuous function $f$ on the domain

$$D: \theta_1 \le \theta \le \theta_2, \quad r_1(\theta) \le r \le r_2(\theta)$$

$$\iint_D f(x,y) \, dA = \int_{\theta_1}^{\theta_2} \int_{r_1(\theta)}^{r_2(\theta)} f(r\cos\theta, r\sin\theta) \, r \, dr \, d\theta$$

Here, the region $D$ is **radially simple**.

**Notes:**
- The transformation uses: $x = r\cos\theta$, $y = r\sin\theta$
- The extra factor of $r$ in the integrand comes from the Jacobian determinant of the polar coordinate transformation
- The region $D$ is described as a polar rectangle where the radial bounds may depend on the angle $\theta$

### Operations on Vector Fields

Let $\vec{F} = \langle F_1, F_2, F_3 \rangle$ be a vector field. We define:

1. The **Divergence** of $\vec{F}$

   $$\text{div}(\vec{F}) = \nabla \cdot \vec{F} = \left\langle \frac{\partial}{\partial x}, \frac{\partial}{\partial y}, \frac{\partial}{\partial z} \right\rangle \cdot \langle F_1, F_2, F_3 \rangle$$

   $$= \frac{\partial F_1}{\partial x} + \frac{\partial F_2}{\partial y} + \frac{\partial F_3}{\partial z}$$

2. The **Curl** of $\vec{F}$

   $$\text{curl}(\vec{F}) = \nabla \times \vec{F} = \begin{vmatrix} \hat{i} & \hat{j} & \hat{k} \\ \frac{\partial}{\partial x} & \frac{\partial}{\partial y} & \frac{\partial}{\partial z} \\ F_1 & F_2 & F_3 \end{vmatrix}$$

   $$= \left(\frac{\partial F_3}{\partial y} - \frac{\partial F_2}{\partial z}\right)\hat{i} - \left(\frac{\partial F_3}{\partial x} - \frac{\partial F_1}{\partial z}\right)\hat{j} + \left(\frac{\partial F_2}{\partial x} - \frac{\partial F_1}{\partial y}\right)\hat{k}$$

   $$= \left\langle \frac{\partial F_3}{\partial y} - \frac{\partial F_2}{\partial z}, \ \frac{\partial F_1}{\partial z} - \frac{\partial F_3}{\partial x}, \ \frac{\partial F_2}{\partial x} - \frac{\partial F_1}{\partial y} \right\rangle$$

### Curl of a Conservative Vector Field

   1. In $\mathbf{R}^2$, if the vector field $\mathbf{F} = \langle F_1, F_2 \rangle$ is conservative, then

   $$\frac{\partial F_1}{\partial y} = \frac{\partial F_2}{\partial x}$$

   2. In $\mathbf{R}^3$, if the vector field $\mathbf{F} = \langle F_1, F_2, F_3 \rangle$ is conservative, then

   $$\text{curl}(\mathbf{F}) = \mathbf{0}, \quad \text{or equivalently,} \quad \frac{\partial F_1}{\partial y} = \frac{\partial F_2}{\partial x}, \ \frac{\partial F_2}{\partial z} = \frac{\partial F_3}{\partial y}, \ \frac{\partial F_3}{\partial x} = \frac{\partial F_1}{\partial z}$$

### Computing a Scalar Line Integral

Let $\vec{r}(t)$ be a parameterization that directly traverses a curve $C$ for $a \le t \le b$. If $f(x,y,z)$ and $\vec{r}(t)$ are continuous, then

$$\int_C f(x,y,z) \, ds = \int_{t=a}^{t=b} f(\vec{r}(t)) \, \|\vec{r}'(t)\| \, dt \quad \text{(similar in 2D)}$$
$$\int_C f(x,y),ds=\int_a^b f(x(t),y(t)) \, \sqrt{\left(\frac{dx}{dt}\right)^2+\left(\frac{dy}{dt}\right)^2} \, dt$$

where $\vec{r}(t) = \langle x(t), y(t), z(t) \rangle$

- $ds = \|\vec{r}'(t)\| \, dt$ is called the **arc length differential**

- The value of the scalar line integral does not depend on the parameterization of $C$ used as long as $C$ is only traced once from $t=a$ to $t=b$.

### Computing a Vector Line Integrals

Let $\vec{F}$ be a continuous vector field defined on a smooth, oriented curve $C$ given by $\vec{r}(t)$, $a \le t \le b$. Then the **line integral of $\vec{F}$ along $C$** is:

$$\int_C \vec{F} \cdot d\vec{r} = \int_a^b \vec{F}(\vec{r}(t)) \cdot \vec{r}'(t) \, dt = \int_C \vec{F} \cdot \frac{\vec{r}'(t)}{\|\vec{r}'(t)\|} \|\vec{r}'(t)\| \, dt = \int_C \vec{F} \cdot \vec{T} \, ds$$

where $\vec{T} = \frac{\vec{r}'(t)}{\|\vec{r}'(t)\|}$ is the unit tangent vector.

### Fundamental Theorem of Line Integrals

$$
\int_C \vec{F} \cdot d\vec{r} = f(\text{end point}) - f(\text{start point})
$$

### Green's Theorem

Let $D$ be a domain whose boundary $\partial D$ is a **positively-oriented**, simple closed curve in the plane. If $\vec{F} = \langle F_1, F_2 \rangle$, where $F_1$ and $F_2$ have continuous partial derivatives, then

$$\oint_C \vec{F} \cdot d\vec{r} = \oint_{\partial D} F_1 \, dx + F_2 \, dy = \iint_D \left(\frac{\partial F_2}{\partial x} - \frac{\partial F_1}{\partial y}\right) \, dA$$

where $C = \partial D$

**Notation for vector line integrals:**
- $\oint_C \vec{F} \cdot d\vec{r}$ — Notation 1
- $\oint_{\partial D} F_1 \, dx + F_2 \, dy$ — Notation 2

### Green's Theorem for a Curve That Is Not Closed

Let $C$ be a non-closed curve that can be completed to form a closed boundary $\partial D = C + C_1$, where $C_1$ is an auxiliary curve that closes the region $D$. If $\vec{F} = \langle F_1, F_2 \rangle$ has continuous partial derivatives on $D$, then by Green's Theorem:

$$\oint_{\partial D} \vec{F} \cdot d\vec{r} = \int_C \vec{F} \cdot d\vec{r} + \int_{C_1} \vec{F} \cdot d\vec{r} = \iint_D \left(\frac{\partial F_2}{\partial x} - \frac{\partial F_1}{\partial y}\right) dA$$

Rearranging to solve for the line integral along the non-closed curve $C$:

$$\int_C \vec{F} \cdot d\vec{r} = \iint_D \left(\frac{\partial F_2}{\partial x} - \frac{\partial F_1}{\partial y}\right) dA - \int_{C_1} \vec{F} \cdot d\vec{r}$$

**Note:** The orientation of $C$ and $C_1$ must be consistent with the positive (counterclockwise) orientation of the closed boundary $\partial D$.

### Trigonometric Function

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
