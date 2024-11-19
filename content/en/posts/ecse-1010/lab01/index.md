---
title: ECSE 1010 Proof of Concepts - Omega Lab01
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
description: This blog post presents a comprehensive proof of concepts for ECSE 1010 Omega Lab01, focusing on electrical engineering principles such as Ohm's Law, KCL, KVL, voltage dividers, and current flow in circuits. It includes detailed circuit schematics, analysis, simulations, and experimental measurements to validate theoretical concepts.
keywords: ["Ohm's Law", "KCL", "KVL", "Voltage Divider", "Current Flow", "Electrical Engineering", "Circuit Analysis", "Simulation", "Measurement"]
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
summary: This blog post presents a comprehensive proof of concepts for ECSE 1010 Omega Lab01, focusing on electrical engineering principles such as Ohm's Law, KCL, KVL, voltage dividers, and current flow in circuits. It includes detailed circuit schematics, analysis, simulations, and experimental measurements to validate theoretical concepts.
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

## Lab Document

{{< link href="Lab01.pdf" content="Lab01.pdf" title="Download Lab01.pdf" download="Lab01.pdf" card=true >}}

## 1. Prove Ohm's Law, KCL, and KVL in a Circuit

### Circuit Schematic

{{< image src="Proof%20of%20Concept%20-%20Omega%20Lab%2001%20-%201%20-%20Schematic.avif" caption="Proof of Concept - Omega Lab 01 - 1 - Schematic" width=600px >}}

### Description

- Based on the description of Ohm's Law, the voltage is equal to current times resistance. So, I will check the real measurements with voltmeter and the theoretic values.
- Based on the description of KCL, the current goes into a node is equal to current goes out the node. So I am going to measure the currents and add them together to check if it matches the theory.
- Based on the description of KVL, the net voltage of nodes in the loop is equal to zero. So, I am going to measure all the voltage across the loop and check the sum.

### Analysis

We know that, the Ohm's Law, KCL, and KVL can be shown as these formulas:

$$
V = IR \\\
\textstyle \sum I_{in} = \sum I_{out} \\\
\textstyle \sum V_{n} = 0
$$

***

Based on $V = IR$, the total $I$ should be

$$
\begin{align*}
	V &= IR \\\
	I &= \frac{V}{R} \\\
	I_{total} &= \frac{5}{10K + \cfrac{1}{\frac{1}{1K} + \frac{1}{1K}} + 10K} \\\
	I_{total} &= \frac{5}{10000 + 500 + 10000} \\\
	I_{total} &= 0.000243902439 \\\
\end{align*}
$$

And $I(R2) = I(R3)$ should be

$$
\begin{align*}
	 I(R2) = I(R3) &= I_{total} \times  \frac{R2}{R2 + R3} \\\
	 I(R2) = I(R3) &= 0.000243902439 \times \frac{1000}{1000 + 1000} \\\
	 I(R2) = I(R3) &= 0.0001219512195
\end{align*}
$$

***

To find $V(R1) = V(R4)$ and $V(R2) = V(R3)$, we can use

$$
\begin{align*}
	V(R1) = V(R4) &= V_{total} \times \frac{R1}{R1 + R2 \Vert R3 + R4} \\\
	V(R1) = V(R4) &= 5 \times \frac{10000}{10000 + 500 + 10000} \\\
	V(R1) = V(R4) &= 2.4390244
\end{align*}
$$

$$
\begin{align*}
	V(R2) = V(R3) &= V_{total} \\\
	V(R2) = V(R3) &= (5 - 2.4390244 - 2.4390244) \\\
	V(R2) = V(R3) &= 0.1219512
\end{align*}
$$

***

Based on $\sum I_{in} = \sum I_{out}$, we should see $I(R1) = I(R2) + I(R3)$, since $I(R1)$ is the current goes into node `n002` and $I(R2) + I(R3)$ is the current goes out node `n002`.

Based on $\sum V_{n} = 0$, we should expect $V(n001) - V(n002) - V(n003) = 0$, since they are in the same loop.

We will check if the experimental results fit these expectations.

### Simulation

{{< figure src="Proof%20of%20Concept%20-%20Omega%20Lab%2001%20-%201%20-%20Simulation.avif" caption="Proof of Concept - Omega Lab 01 - 1 - Simulation" width=600px >}}

```text
       --- Operating Point ---

V(n001):	 5	 voltage
V(n002):	 2.56098	 voltage
V(n003):	 2.43902	 voltage
I(R1):	 -0.000243902	 device_current
I(R2):	 0.000121951	 device_current
I(R3):	 0.000121951	 device_current
I(R4):	 0.000243902	 device_current
I(V1):	 -0.000243902	 device_current
```

### Measurement

{{< figure src="Proof%20of%20Concept%20-%20Omega%20Lab%2001%20-%201%20-%20Measurement.avif" caption="Proof of Concept - Omega Lab 01 - 1 - Measurement" width=600px >}}

$V(R1) = 2.4963V$

{{< figure src="Proof%20of%20Concept%20-%20Omega%20Lab%2001%20-%201%20-%20Measurement%20-%201.avif" caption="Proof of Concept - Omega Lab 01 - 1 - Measurement - 1" width=600px >}}

$V(R2) = V(R3) = 166.5mV$

{{< figure src="Proof%20of%20Concept%20-%20Omega%20Lab%2001%20-%201%20-%20Measurement%20-%202.avif" caption="Proof of Concept - Omega Lab 01 - 1 - Measurement - 2" width=600px >}}

$V(R4) = 2.4616V$

{{< figure src="Proof%20of%20Concept%20-%20Omega%20Lab%2001%20-%201%20-%20Measurement%20-%203.avif" caption="Proof of Concept - Omega Lab 01 - 1 - Measurement - 3" width=600px >}}

### Discussion

First, let's compare the theoretical value with the experimental measurements.

We got the experimental reading from Analog Discovery 3.

```text
V(R1) = 2.4963V
V(R2) = V(R3) = 166.5mV
V(R4) = 2.4616V
```

To find out the theoretic values of $V(R1)$, $V(R2) = V(R3)$ and $V(R4)$. We need to do some math.

We know the simulation output is

```text
V(n001):	 5	 voltage
V(n002):	 2.56098	 voltage
V(n003):	 2.43902	 voltage
```

and the voltage is the difference in potential. Based on that, we can caculate the theoretic values of $V(R1)$, $V(R2) = V(R3)$ and $V(R4)$.

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

Let's make a table to compare the results

|Iteams|Analysis|Simulation|Experiement|diff|$\%$diff|
|:-:|:-:|:-:|:-:|:-:|-:|
|$V(R1)$|$2.4390V$|$2.4390V$|$2.4963V$|$57.28mV$|$2.3\%$|
|$V(R2)$|$0.1219V$|$0.1219V$|$0.1665V$|$44.54mV$|$26.8\%$|
|$V(R3)$|$0.1219V$|$0.1219V$|$0.1665V$|$44.54mV$|$26.8\%$|
|$V(R4)$|$2.4390V$|$2.4390V$|$2.4616V$|$22.58mV$|$0.9\%$|

We can see that $V(R1)$ and $V(R4)$ are very accurate. But $V(R2)$ and $V(R3)$ has a lot of error. A potential explanation is that, there is a background noise.

If we look at the "Measurement", channel 2 is empty, but it still has a reading around $50mV$. It's very likely to be a background noise. If we remove this noise from Experimental Measurements. The $\%$diff will be less than $1\%$. Consider that the resistor has a Tolerance of $5\%$ (from 4 Band Resistor Color Code). We can consider this as systematic error and the Experimental Measurements is very close to Simulations.

***

Now, let's check KCL.

We got the simulations data like

```text
I(R1):	 -0.000243902	 device_current
I(R2):	 0.000121951	 device_current
I(R3):	 0.000121951	 device_current
I(R4):	 0.000243902	 device_current
I(V1):	 -0.000243902	 device_current
```

Using the expectation $I(R1) = I(R2) + I(R3)$ from Analysis. We can check

$$
\begin{align*}
	& I(R1) + I(R2) + I(R3) \\\
	=& -0.000243902 + 0.000121951 + 0.000121951 \\\
	=& \; \boxed{0}
\end{align*}
$$

KCL is very likely be True.

***

Then, let's check KVL.

We can use the result from previous part.

$$
\begin{align*}
	V(R1) &= 2.43902 \\\
	V(R2) = V(R3) &= 0.12196 \\\
	V(R4) &= 2.43902
\end{align*}
$$

Use the expectation $V(n001) - V(n002) - V(n003) = 0$ from Analysis. We can check

$$
\begin{align*}
	& V(n001) - V(n002) - V(n003) \\\
	=& \; 2.43902 - 0.12196 - 0.12196\\\
	=& \; 0 \\\
	& \; 0 = 0 \; \boxed{\text{True}}
\end{align*}
$$

KVL is very likely be True.

***

Finally, let's check Ohm's Law. Using the expectation $V=IR$ and the experimental data.

```text
R1 = 10K
R2 = R3 = 1K
R4 = 10K
V(R1) = 2.4963V
V(R2) = V(R3) = 166.5mV
V(R4) = 2.4616V
```

to calculate $I$ based on Ohm's Law.

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

Then, we can check these current result with simulation data.

|Iteams|Analysis|Simulation|Experiement|diff|$\%$diff|
|:-:|:-|:-|:-|:-:|-:|
|$I(R1)$|$0.2439mA$|$0.2439mA$|$0.2496mA$|$0.005728mA$|$2.3\%$|
|$I(R2)$|$0.1665mA$|$0.1665mA$|$0.1219mA$|$0.044549mA$|$26.8\%$|
|$I(R3)$|$0.1665mA$|$0.1665mA$|$0.1219mA$|$0.044549mA$|$26.8\%$|
|$I(R4)$|$0.2439mA$|$0.2439mA$|$0.2461mA$|$0.002258mA$|$0.9\%$|

We can see that $I(R1)$ and $I(R4)$ are very accurate. But $I(R2)$ and $I(R3)$ has a lot of error. A potential explanation is that, there is a background noise.

If we look at the "Measurement", channel 2 is empty, but it still has a reading around $50mV$. It's very likely to be a background noise. If we remove this noise from Experimental Measurements. The $\%$diff will be less than $1\%$. Consider that the resistor has a Tolerance of $5\%$ (from 4 Band Resistor Color Code). We can consider this as systematic error and the Experimental Measurements is very close to Simulations.

Also, we can check to total current in the circuit. Using the expectation form "Analysis" - $I_{total} = 0.000243902439$, this matches the simulation - $0.000243902A$.

***

In conclusion, the simulation 100% fit the KCL and KVL. The experimental data is close to the simulation. And very close to simulation if we remove the background noise and consider the $5\%$ tolerance of the resistor. Then, we used Ohm's Law with experimental data to compare the simulation. The result is also very close. Thus, we proved Ohm's Law, KCL, and KVL in a Circuit.

## 2. Prove the Concept of a Voltage Divider in a Series Circuit

### Circuit Schematic

{{< figure src="Proof%20of%20Concept%20-%20Omega%20Lab%2001%20-%202%20-%20Schematic.avif" caption="Proof of Concept - Omega Lab 01 - 2 - Schematic" width=600px >}}

### Description

I am going to build a series circuit with two resistors and measure the voltage across the resistors to compare the theoretic values.

### Analysis

The Voltage Divider equation is

$$
\frac{V_1}{V_2} = \frac{R_1}{R_2}
$$

If we have the voltage source $5V$ and $R1=R2=10K$. Put the values into the equation and get

$$
\frac{V_1}{V_2} = \frac{10K}{10K} = \frac{1}{1}
$$

We know that $V_1 + V_2 = 5$ and $1 \cdot V_1 = 1 \cdot V_2$. So, we should expect $V_1 = V_2 = 2.5$.

### Simulation

{{< figure src="Proof%20of%20Concept%20-%20Omega%20Lab%2001%20-%202%20-%20Simulation.avif" caption="Proof of Concept - Omega Lab 01 - 2 - Simulation" width=600px >}}

```text
       --- Operating Point ---

V(n001):	 5	 voltage
V(n002):	 2.5	 voltage
I(R1):	 -0.00025	 device_current
I(R2):	 -0.00025	 device_current
I(V1):	 -0.00025	 device_current
```

### Measurement

{{< figure src="Proof%20of%20Concept%20-%20Omega%20Lab%2001%20-%202%20-%20Measurement.avif" caption="Proof of Concept - Omega Lab 01 - 2 - Measurement" width=600px >}}

$V(R1) = 2.5539V$

{{< figure src="Proof%20of%20Concept%20-%20Omega%20Lab%2001%20-%202%20-%20Measurement%20-%201.avif" caption="Proof of Concept - Omega Lab 01 - 2 - Measurement - 1" width=600px >}}

$V(R2) = 2.5204V$

{{< figure src="Proof%20of%20Concept%20-%20Omega%20Lab%2001%20-%202%20-%20Measurement%20-%202.avif" caption="Proof of Concept - Omega Lab 01 - 2 - Measurement - 2" width=600px >}}

### Discussion

First, let's compare the theoretical value with the experimental measurements.

We got the experimental reading from Analog Discovery 3.

```text
V(R1) = 2.5539V
V(R2) = 2.5204V
```

and the voltage is the difference in potential. Based on that, we can calculate the theoretic values of $V(R1)$ and $V(R2)$. We need to do some math.

We know the simulation output is

```text
V(n001):	 5	 voltage
V(n002):	 2.5	 voltage
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

Let's make a table to compare the results

|Iteams|Analysis|Simulation|Experiement|diff|$\%$diff|
|:-:|:-:|:-:|:-:|:-:|-:|
|$V(R1)$|$2.5V$|$2.5V$|$2.5539V$|$0.0539V$|$2.1\%$|
|$V(R2)$|$2.5V$|$2.5V$|$2.5204V$|$0.0204V$|$0.8\%$|

We can see that both $V(R1)$ and $V(R2)$ are very accurate. They are some errors, A potential explanation is that, there is a background noise.

If we look at the "Measurement", channel 2 is empty, but it still has a reading around $40mV$. It's very likely to be a background noise. If we remove this noise from Experimental Measurements. The $\%$diff will be less than $1\%$. Consider that the resistor has a Tolerance of $5\%$ (from 4 Band Resistor Color Code). We can consider this as systematic error and the Experimental Measurements is very close to Simulations.

In conclusion, the simulation 100% fits the Voltage Divider theoretic formula. And the experimental reading is close to theoretic values. And the experimental reading is very close to theoretic values if we removed the background noise. Thus, we proved the Concept of a Voltage Divider in a Series Circuit.

## 3. Prove the Concept of How Current Flows in a Series Circuit

### Circuit Schematic

{{< figure src="Proof%20of%20Concept%20-%20Omega%20Lab%2001%20-%202%20-%20Schematic.avif" caption="Proof of Concept - Omega Lab 01 - 2 - Schematic" width=600px >}}

### Description

I am going to use the Ohm's Law to find out the current flows through every resistor in the series circuit and compare it with the theoretic values.

### Analysis

The feature of series circuit is that

- There is only one path for the current to flow through the circuit.
- The current is the same at any point in the circuit.

Since Analog Discovery 3 can't directly measures the current but the voltage. We are going to use Ohm's Law to find out the current flow through the resistor.

We know this relationship from Ohm's Law

$$
V = IR
$$

We can change it a bit into

$$
I = \frac{V}{R}
$$

Also, we know that $R_1 = R_2 = 10K$ and the voltage across the resistor can be found by voltage divider formula. which is

$$
\begin{align*}
	\frac{V_1}{V_2} &= \frac{R_1}{R_2} \\\
	\frac{V_1}{V_2} &= \frac{10K}{10K} = \frac{1}{1}
\end{align*}
$$

We know that $V_1 + V_2 = 5$ and $1 \cdot V_1 = 1 \cdot V_2$. So, we should expect $V_1 = V_2 = 2.5$.

Using these values, we can find out $I(R1)$ and $I(R2)$ by

$$
\begin{align*}
	I(R1) = I(R2) &= \frac{V}{R} \\\
	I(R1) = I(R2) &= \frac{2.5}{10K} \\\
	I(R1) = I(R2) &= \boxed{0.00025}
\end{align*}
$$

We expect $I(R1)$ and $I(R2)$ to be $0.00025A$.

### Simulation

{{< figure src="Proof%20of%20Concept%20-%20Omega%20Lab%2001%20-%202%20-%20Simulation.avif" caption="Proof of Concept - Omega Lab 01 - 2 - Simulation" width=600px >}}

```text
       --- Operating Point ---

V(n001):	 5	 voltage
V(n002):	 2.5	 voltage
I(R1):	 -0.00025	 device_current
I(R2):	 -0.00025	 device_current
I(V1):	 -0.00025	 device_current
```

### Measurement

{{< figure src="Proof%20of%20Concept%20-%20Omega%20Lab%2001%20-%202%20-%20Measurement.avif" caption="Proof of Concept - Omega Lab 01 - 2 - Measurement" width=600px >}}

$V(R1) = 2.5539V$

{{< figure src="Proof%20of%20Concept%20-%20Omega%20Lab%2001%20-%202%20-%20Measurement%20-%201.avif" caption="Proof of Concept - Omega Lab 01 - 2 - Measurement - 1" width=600px >}}

$V(R2) = 2.5204V$

{{< figure src="Proof%20of%20Concept%20-%20Omega%20Lab%2001%20-%202%20-%20Measurement%20-%202.avif" caption="Proof of Concept - Omega Lab 01 - 2 - Measurement - 2" width=600px >}}

### Discussion

From the Simulation Result, 

```text
I(R1):	 -0.00025	 device_current
I(R2):	 -0.00025	 device_current
```

It proves $I(R1)=I(R2)$, which

- There is only one path for the current to flow through the circuit.
- The current is the same at any point in the circuit.

***

From the Measurement Result, we got the voltage across $R1$ and $R2$

$V(R1) = 2.5539V$
$V(R2) = 2.5204V$

Based on the Ohm's Law - the relationship we got in Analysis $I = \frac{V}{R}$. We can find $R1$ and $R2$ by

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

Both  $R1$ and $R2$ are very close, we can say that $R1 \approx R2$. Consider that the resistor has a Tolerance of $5\%$ (from 4 Band Resistor Color Code). We can consider this as systematic error and the Experimental Measurements is very close to Simulations.

***

In conclusion, the simulation 100% fits the feature of current in series circuit. And the experimental reading is close to theoretic values. And the experimental reading is very close to theoretic values if we consider that the resistor has a Tolerance of $5\%$ (from 4 Band Resistor Color Code). Thus, we proved the Concept of How Current Flows in a Series Circuit.

- There is only one path for the current to flow through the circuit.
- The current is the same at any point in the circuit.

## 4. Prove the Concept of Voltage Across a Parallel Circuit

### Circuit Schematic

{{< figure src="Proof%20of%20Concept%20-%20Omega%20Lab%2001%20-%204%20-%20Schematic.avif" caption="Proof of Concept - Omega Lab 01 - 4 - Schematic" width=600px >}}

### Description

I am going to use the Ohm's Law and feature of node to find out the voltage across every resistor in the parallel circuit and compare it with the theoretic values.

### Analysis

The feature of parallel circuit is that

- There are multiple paths for the current to flow through the circuit.
- The voltage across each branch is the same and equal to the voltage supplied by the source.

$$
V_{total} = V_1 = V_2 = V_3 = \ldots = V_n
$$

We know that the voltage in the same node is the same (they are connected by a wire). And `n001`, `n002` connected both side of resistor. So, we should expect $V(R1) = V(R2)$.

Also, the voltage is potential difference between the component.

$$
\begin{align*}
	V(R1) = V(R2) &= n001 - \text{GND} \\\
	V(R1) = V(R2) &= 5 - 0 \\\
	V(R1) = V(R2) &= \boxed{5}
\end{align*}
$$

***

Also, we can check the current of this circuit. We know that the current in a parallel circuit is

$$
I_{total} = I_1 + I_2 + I_3 + \dots
$$

and from Ohm's Law, we know that

$$
V = IR
$$

We can change it a bit into

$$
I = \frac{V}{R}
$$

And, we know that the resistance in parallel is

$$
\frac{1}{R_{total}} = \frac{1}{R_1} + \frac{1}{R_2} + \frac{1}{R_3} + \ldots + \frac{1}{R_n}
$$

So,

$$
R_{total} = \frac{1}{\frac{1}{R_1} + \frac{1}{R_2} + \frac{1}{R_3} + \ldots + \frac{1}{R_n}}
$$

Combine them together, we got

$$
I_{total} = \frac{V}{\cfrac{1}{\frac{1}{R_1} + \frac{1}{R_2} + \frac{1}{R_3} + \ldots + \frac{1}{R_n}}}
$$

Let's put values into equation

$$
\begin{align*}
	I_{total} &= \frac{5}{\cfrac{1}{\frac{1}{10K} + \frac{1}{10K}}} \\\
	I_{total} &= \frac{5}{5K} \\\
	I_{total} &= \boxed{0.001}
\end{align*}
$$

We can check this to double confirm our result.

### Simulation

{{< figure src="Proof%20of%20Concept%20-%20Omega%20Lab%2001%20-%204%20-%20Simulation.avif" caption="Proof of Concept - Omega Lab 01 - 4 - Simulation" width=600px >}}

```text
       --- Operating Point ---

V(n001):	 5	 voltage
I(R2):	 0.0005	 device_current
I(R1):	 0.0005	 device_current
I(V1):	 -0.001	 device_current
```

### Measurement

{{< figure src="Proof%20of%20Concept%20-%20Omega%20Lab%2001%20-%204%20-%20Measurement.avif" caption="Proof of Concept - Omega Lab 01 - 4 - Measurement" width=600px >}}

$V(R1)=V(R2)=5.0305V$

{{< figure src="Proof%20of%20Concept%20-%20Omega%20Lab%2001%20-%204%20-%20Measurement%20-%201.avif" caption="Proof of Concept - Omega Lab 01 - 4 - Measurement - 1" width=600px >}}

### Discussion

First, let's compare the theoretical value with the experimental measurements.

We got the experimental reading from Analog Discovery 3.

```text
V(R1) = 5.0305V
V(R2) = 5.0305V
```

To find out the theoretic values of $V(R1)$ and $V(R2)$. We need to do some math.

We know the simulation output is

```text
V(n001):	 5	 voltage
```

and the voltage is the difference in potential. Based on that, we can caculate the theoretic values of $V(R1)$ and $V(R2)$.

$$
\begin{align*}
	V(R1) = V(R2) &= V(n001) - \text{GND} \\\
	V(R1) = V(R2) &= 5 - 0 \\\
	V(R1) = V(R2) &= \boxed{5}
\end{align*}
$$

Let's make a table to compare the results

|Iteams|Analysis|Simulation|Experiement|diff|$\%$diff|
|:-:|:-:|:-:|:-:|:-:|-:|
|$V(R1)$|$5V$|$5V$|$5.0305V$|$0.0305V$|$0.6\%$|
|$V(R2)$|$5V$|$5V$|$5.0305V$|$0.0305V$|$0.6\%$|

We can see that both $V(R1)$ and $V(R2)$ are very accurate. They are some errors, A potential explanation is that, there is a background noise.

If we look at the "Measurement", channel 2 is empty, but it still has a reading around $40mV$. It's very likely to be a background noise. If we remove this noise from Experimental Measurements. The $\%$diff will be less than $0.2\%$. Consider that the resistor has a Tolerance of $5\%$ (from 4 Band Resistor Color Code). We can consider this as systematic error and the Experimental Measurements is very close to Simulations.

***

Secondly, we can check to $I_{total}$ as double confirm.

We know the simulation output is

```text
I(R2):	 0.0005	 device_current
I(R1):	 0.0005	 device_current
```

and from Analysis, we expect

$$
I_{total} = 0.001
$$

We know that, the $I_{total}$ of a parallel circuit is

$$
I_{total} = I_1 + I_2 + I_3 + \dots
$$

So, we get

$$
\begin{align*}
	I_{total} &= I(R2) + I(R1) \\\
	I_{total} &= 0.0005 + 0.0005 \\\
	I_{total} &= 0.001 \\\
	& 0.001 = 0.001 \; \boxed{\text{True}}
\end{align*}
$$

Our Analysis matches Simulation.

***

Additionally, we can check the experimental data as well. Since Analog Discovery 3 can't measure the current directly, we need use Ohm's Law to find out current.

We got

```text
V(R1) = 5.0305V
V(R2) = 5.0305V
```

and we know that

```text
R1 = 10K
R2 = 10K
```

Then, we can find out $I(R1)$ and $I(R2)$ by

$$
\begin{align*}
	V &= IR \\\
	I &= \frac{V}{R} \\\
	I(R1) = I(R2) &= \frac{5.0305}{10000} \\\
	I(R1) = I(R2) &= \boxed{0.0005305}
\end{align*}
$$

$0.0005305 \approx 0.0005$ with only $0.6\%$diff (even less then $0.2\%$ if we remove $40mV$ background noise). Our theory is very likely be true. Since the resistor has a Tolerance of $5\%$ (from 4 Band Resistor Color Code). We can consider this as systematic error and the Experimental Measurements is very close to Simulations.

***

In conclusion, we checked the simulation 100% fit the Analysis' expectation. And the experimental data only has $0.2\%$ to $0.6\%$ than the theoretic values. Thus, we proved Concept of Voltage Across a Parallel Circuit.

- There are multiple paths for the current to flow through the circuit.
- The voltage across each branch is the same and equal to the voltage supplied by the source.

## 5. Prove the Concept of a Current Divider in a Parallel Circuit

### Circuit Schematic

{{< figure src="Proof%20of%20Concept%20-%20Omega%20Lab%2001%20-%204%20-%20Schematic.avif" caption="Proof of Concept - Omega Lab 01 - 4 - Schematic" width=600px >}}

### Description

I am going to use the Ohm's Law to find out the current across every resistor in the parallel circuit and compare its sum with the theoretic values.

### Analysis

The feature of parallel circuit is that

- There are multiple paths for the current to flow through the circuit.
- The voltage across each branch is the same and equal to the voltage supplied by the source.
- The total current entering the parallel circuit is divided among the branches.

$$
V_{total} = V_1 = V_2 = V_3 = \ldots = V_n
$$

We know that the voltage in the same node is the same (they are connected by a wire). And `n001`, `n002` connected both side of resistor. So, we should expect $V(R1) = V(R2)$.

Also, the voltage is potential difference between the component.

$$
\begin{align*}
	V(R1) = V(R2) &= n001 - \text{GND} \\\
	V(R1) = V(R2) &= 5 - 0 \\\
	V(R1) = V(R2) &= \boxed{5}
\end{align*}
$$

and from Ohm's Law, we know that

$$
V = IR
$$

We can change it a bit into

$$
I = \frac{V}{R}
$$

and get

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

the relationship between $I(R1)$ and $I(R2)$ can be express as

$$
\begin{align*}
	\frac{I(R1)}{I(R2)} &= \cfrac{\cfrac{V(R1)}{R1}}{\cfrac{V(R2)}{R2}} \\\
	\because V(R1) &= V(R2) \\\
	\therefore \frac{I(R1)}{I(R2)} &= \cfrac{\cfrac{\cancel{V(R1)}}{R1} \times \cfrac{1}{\cancel{V(R1)}}}{\cfrac{\cancel{V(R2)}}{R2} \times \cfrac{1}{\cancel{V(R2)}}} \\\
	\frac{I(R1)}{I(R2)} &= \frac{\frac{1}{R1}}{\frac{1}{R2}} \\\
	&\boxed{\frac{I(R1)}{I(R2)} = \frac{R2}{R1}}
\end{align*}
$$

In our case, $1 \cdot R1 = 1 \cdot R2$, so

$$
\frac{I(R1)}{I(R2)} = \frac{R2}{R1} = \frac{1}{1}
$$

as we get the $I_{total}$ by

$$
\begin{align*}
	I_{total} &= \frac{V_{total}}{R_{total}} \\\
	I_{total} &= \frac{5}{\cfrac{1}{\cfrac{1}{10K} + \cfrac{1}{10K}}} \\\
	I_{total} &= \frac{5}{5K} \\\
	I_{total} &= 0.001
\end{align*}
$$

As

$$
\frac{I(R1)}{I(R2)} = \frac{1}{1}
$$

We can get $I(R1)$ and $I(R2)$ by

$$
\begin{align*}
	I(R1) = I(R2) &= I_{total} \times \frac {R1}{R1 + R2} \\\
	I(R1) = I(R2) &= 0.001 \times \frac {10K}{10K + 10K} \\\
	I(R1) = I(R2) &= \boxed{0.0005}
\end{align*}
$$

At this point, our logic is consistent, which

$$
\begin{align*}
	& \because R1 = R2 = 10K \\\
	& \because I(R1) = I(R2) = 0.0005 \\\
	& \because V(R1) = V(R2) = 5 \\\
	& \because I_{total} = I(R1) + I(R2) = 0.001 \\\
	& \because  \frac{I(R1)}{I(R2)} = \frac{R2}{R1} \\\
	& \therefore I(R1) = I(R2) = I_{total} \times \frac {R1}{R1 + R2} \\\
\end{align*}
$$

The result of $I(R1) = I(R2) = 0.0005$ also got cross checked by $I = \frac{V}{R}$. So, we are very confident that

$$
\frac{I(R1)}{I(R2)} = \frac{R2}{R1}
$$

For any current of the resistor in parallel circuit (e.g $I(R1)$)

$$
I(R1) = I_{total} \times \frac {R1}{R1 + R2 + \cdots}
$$

### Simulation

{{< figure src="Proof%20of%20Concept%20-%20Omega%20Lab%2001%20-%204%20-%20Simulation.avif" caption="Proof of Concept - Omega Lab 01 - 4 - Simulation" width=600px >}}

```text
       --- Operating Point ---

V(n001):	 5	 voltage
I(R2):	 0.0005	 device_current
I(R1):	 0.0005	 device_current
I(V1):	 -0.001	 device_current
```

### Measurement

{{< figure src="Proof%20of%20Concept%20-%20Omega%20Lab%2001%20-%204%20-%20Measurement.avif" caption="Proof of Concept - Omega Lab 01 - 4 - Measurement" width=600px >}}

$V(R1)=V(R2)=5.0305V$

{{< figure src="Proof%20of%20Concept%20-%20Omega%20Lab%2001%20-%204%20-%20Measurement%20-%201.avif" caption="Proof of Concept - Omega Lab 01 - 4 - Measurement - 1" width=600px >}}

### Discussion

First, let's compare the theoretical value with the experimental measurements.

We got the experimental reading from Analog Discovery 3.

```text
V(R1) = 5.0305V
V(R2) = 5.0305V
```

To find out the theoretic values of $V(R1)$ and $V(R2)$. We need to do some math.

We know the simulation output is

```text
V(n001):	 5	 voltage
```

and the voltage is the difference in potential. Based on that, we can caculate the theoretic values of $V(R1)$ and $V(R2)$.

$$
\begin{align*}
	V(R1) = V(R2) &= V(n001) - \text{GND} \\\
	V(R1) = V(R2) &= 5 - 0 \\\
	V(R1) = V(R2) &= \boxed{5}
\end{align*}
$$

Let's make a table to compare the results

|Iteams|Analysis|Simulation|Experiement|diff|$\%$diff|
|:-:|:-:|:-:|:-:|:-:|-:|
|$V(R1)$|$5V$|$5V$|$5.0305V$|$0.0305V$|$0.6\%$|
|$V(R2)$|$5V$|$5V$|$5.0305V$|$0.0305V$|$0.6\%$|

We can see that both $V(R1)$ and $V(R2)$ are very accurate. They are some errors, A potential explanation is that, there is a background noise.

If we look at the "Measurement", channel 2 is empty, but it still has a reading around $40mV$. It's very likely to be a background noise. If we remove this noise from Experimental Measurements. The $\%$diff will be less than $0.2\%$. Consider that the resistor has a Tolerance of $5\%$ (from 4 Band Resistor Color Code). We can consider this as systematic error and the Experimental Measurements is very close to Simulations.

***

Second, let's check $I(R1)$ and $I(R2)$ with theoretical values.

Since Analog Discovery 3 can't measure the current directly, we need use Ohm's Law to find out current.

We got

```text
V(R1) = 5.0305V
V(R2) = 5.0305V
```

and we know that

```text
R1 = 10K
R2 = 10K
```

Then, we can find out $I(R1)$ and $I(R2)$ by

$$
\begin{align*}
	V &= IR \\\
	I &= \frac{V}{R} \\\
	I(R1) = I(R2) &= \frac{5.0305}{10000} \\\
	I(R1) = I(R2) &= \boxed{0.0005305}
\end{align*}
$$

|Iteams|Analysis|Simulation|Experiement|diff|$\%$diff|
|:-:|:-:|:-:|:-:|:-:|-:|
|$I(R1)$|$0.5mA$|$0.5mA$|$0.50305mA$|$0.00305mA$|$0.6\%$|
|$I(R2)$|$0.5mA$|$0.5mA$|$0.50305mA$|$0.00305mA$|$0.6\%$|

We can see that both $I(R1)$ and $I(R2)$ are very accurate. They are some errors, A potential explanation is that, there is a background noise.

If we look at the "Measurement", channel 2 is empty, but it still has a reading around $40mV$. It's very likely to be a background noise. If we remove this noise from Experimental Measurements. The $\%$diff will be less than $0.2\%$. Consider that the resistor has a Tolerance of $5\%$ (from 4 Band Resistor Color Code). We can consider this as systematic error and the Experimental Measurements is very close to Simulations.

***

In conclusion, we checked the simulation 100% fit the Analysis' expectation. And the experimental data only has $0.2\%$ to $0.6\%$ than the theoretic values. Thus, we proved Concept of How Current Flows in a Series Circuit.

- There are multiple paths for the current to flow through the circuit.
- The voltage across each branch is the same and equal to the voltage supplied by the source.
- The total current entering the parallel circuit is divided among the branches.

## 6. Prove the Concept of a Voltage Divider in Temperature Sensing Circuit

### Circuit Schematic

{{< figure src="Proof%20of%20Concept%20-%20Omega%20Lab%2001%20-%206%20-%20Schematic.avif" caption="Proof of Concept - Omega Lab 01 - 6 - Schematic" width=600px >}}

### Description

We are going to use NTC 100K as our thermistor, and we will compare the reading with our thermometer and simulation to check its reliability.

### Analysis

NTC thermistor uses Beta formula to calculate the resistance under a specific temperature. The formula is like

$$
\frac{1}{T_1} = \frac{1}{T_0} + \frac{1}{\beta} \ln\left(\frac{R_1}{R_0}\right) \\\
$$

We can move $R_1$ to the left side to get

$$
R_1 = R_0 e^{\beta(T_1^{-1} - T_0^{-1})}
$$

Since we want to find out the resistance of this thermistor under a specific temperature.

***

The thermistor we are using is NTC 100K. Which means it has $100k \Omega$ at the reference temperature $25 \degree C$

$$
T_0 = 298.15K \\\
R_0 = 100k \Omega
$$

Also, we got the $\beta$ value from the manufacturer, which

$$
\beta = 3950
$$

We know the Voltage Divider

$$
\frac{V_1}{V_2} = \frac{R_1}{R_2}
$$

put them together, we got

$$
\frac{V_1}{V_2} = \frac{R_0 e^{\beta(T_1^{-1} - T_0^{-1})}}{R_2}
$$

### Simulation

{{< figure src="Proof%20of%20Concept%20-%20Omega%20Lab%2001%20-%206%20-%20Simulation.avif" caption="Proof of Concept - Omega Lab 01 - 6 - Simulation" width=600px >}}

We got a curve shows the relationship between the temperature and resistance in range of $T = 0 \degree C$ to $T = 40 \degree C$

For $T = 29.12 \degree C$, $V$ should be $4.465V$

{{< figure src="Proof%20of%20Concept%20-%20Omega%20Lab%2001%20-%206%20-%20Simulation%20-%201.avif" caption="Proof of Concept - Omega Lab 01 - 6 - Simulation - 1" width=600px >}}

For $T = 27.3 \degree C$, $V$ should be $4.501V$

{{< figure src="Proof%20of%20Concept%20-%20Omega%20Lab%2001%20-%206%20-%20Simulation%20-%202.avif" caption="Proof of Concept - Omega Lab 01 - 6 - Simulation - 2" width=600px >}}

For $T = 30.25 \degree C$, $V$ should be $4.441V$

{{< figure src="Proof%20of%20Concept%20-%20Omega%20Lab%2001%20-%206%20-%20Simulation%20-%203.avif" caption="Proof of Concept - Omega Lab 01 - 6 - Simulation - 3" width=600px >}}

### Measurement

{{< figure src="Proof%20of%20Concept%20-%20Omega%20Lab%2001%20-%206%20-%20Measurement.avif" caption="Proof of Concept - Omega Lab 01 - 6 - Measurement" width=600px >}}

We used the math function in Scope with

```js
1/((1/298.15)+(1/3950)*log((((10000*C1)/(5-C1))/100000),2.71828)) - 273.15
```

to get the temperature in $\degree C$. This is from

$$
\frac{1}{T_1} = \frac{1}{T_0} + \frac{1}{\beta} \ln\left(\frac{R_1}{R_0}\right) \\\
$$

which $T_1$ is the temperature reading we want.

Then, we calibrate the thermistor with another thermometer at $24 \degree C$.

{{< figure src="Proof%20of%20Concept%20-%20Omega%20Lab%2001%20-%206%20-%20Measurement%20-%202.avif" caption="Proof of Concept - Omega Lab 01 - 6 - Measurement - 2" width=600px >}}

Later on, we toke three more reading

$V = 4.465V, T = 29.12 \degree C$

{{< figure src="Proof%20of%20Concept%20-%20Omega%20Lab%2001%20-%206%20-%20Measurement%20-%201.avif" caption="Proof of Concept - Omega Lab 01 - 6 - Measurement - 1" width=600px >}}

$V = 4.502V, T = 27.3 \degree C$

{{< figure src="Proof%20of%20Concept%20-%20Omega%20Lab%2001%20-%206%20-%20Measurement%20-%203.avif" caption="Proof of Concept - Omega Lab 01 - 6 - Measurement - 3" width=600px >}}

$V = 4.441V, T = 30.25 \degree C$

{{< figure src="Proof%20of%20Concept%20-%20Omega%20Lab%2001%20-%206%20-%20Measurement%20-%204.avif" caption="Proof of Concept - Omega Lab 01 - 6 - Measurement - 4" width=600px >}}

### Discussion

|Temp|Analysis|Simulation|Experiement|diff|$\%$diff|
|:-:|:-:|:-:|:-:|:-|-:|
|$29.12 \degree C$|$4.465V$|$4.465V$|$4.465V$|$0V$|$0\%$|
|$27.3 \degree C$|$4.501V$|$4.501V$|$4.502V$|$1mV$|$0.1\%$|
|$30.25 \degree C$|$4.441V$|$4.441V$|$4.441V$|$0V$|$0\%$|

As we can see, the difference between theory and measurements is extremely small. This may due to the temperature reading is calculated from voltage by Math.

But even we look the thermometer's reading, both of them shows around $24 \degree C$. In the worst case, the error is $5\%$. So, over all, our reading is reliable.

***

The wheatstone bridge is better than a normal voltage divider because it is more sensitive than a voltage divider. A voltage divider relies on the ratio of resistances between two resistors, so even if the ratio of the resistors change, as long as the change isn't massive, the output voltage stays the same.

When a wheatstone bridge is balanced, meaning R1/R2=R3/R4, the current flowing through the galvanometer in the center of the wheatstone bridge is 0. When current is zero, the calculated resistance is no longer affected by innate resistance of wires, resistors, and voltameters. This allows measurements with the wheatstone bridge to be more accurate than a voltage divider. 

Advantages:
- Wheatstone bridge is more accurate than voltage divider
- Voltage source does not need to be calibrated to measure resistance

Disadvantages: 
- Voltage divider is easier and cheaper to make 
- Lower power consumption