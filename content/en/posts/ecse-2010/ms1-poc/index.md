---
title: ECSE 2010 Omega Lab MS1 Proof of Concepts
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
description: This blog post presents a comprehensive proof of concepts for ECSE 2010 Omega Lab MS1, focusing on electrical engineering principles such as voltage dividers, operational amplifiers as comparators, and LED control circuits. It includes detailed circuit schematics, mathematical analysis, LTSpice simulations, and experimental measurements to validate theoretical concepts.
keywords: ["Voltage Divider", "Operational Amplifier", "Comparator", "OP37", "LDR", "Photoresistor", "Electrical Engineering", "Circuit Analysis", "LTSpice", "Simulation", "Measurement"]
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
  - ECSE 2010
hiddenFromHomePage: false
hiddenFromSearch: false
hiddenFromRss: false
hiddenFromRelated: false
summary: This blog post presents a comprehensive proof of concepts for ECSE 2010 Omega Lab MS1, focusing on electrical engineering principles such as voltage dividers, operational amplifiers as comparators, and LED control circuits. It includes detailed circuit schematics, mathematical analysis, LTSpice simulations, and experimental measurements to validate theoretical concepts.
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

## Voltage Divider

### Circuit Schematic

{{< image src="figure-1-1.png" caption="Figure 1.1 - Schematic" width=600px >}}

### Description

We designed two voltage divider circuits. One is used to convert the 12V power supply into a 6V reference voltage ($V_{ref}$) for the subsequent voltage comparator; the other is used to generate the input voltage ($V_{in}$) for the voltage comparator. This input voltage is determined by the resistance of the photoresistor (LDR) through the voltage divider circuit.

### Analysis

Calculate $V_{ref}$, given

- $V_{bus} = 12 \text{ V}$
- $R_1 = 1\text{ k} \Omega$
- $R_2 = 1\text{ k} \Omega$

#### Step 1: Total series resistance in that branch

$$
R_{total} = R_1 + R_2 = 1k + 1k = 2\text{ k}\Omega
$$

#### Step 2: Branch current (Ohm’s law)

$$
I = \frac{V}{R_{total}} = \frac{12}{2000} = 0.006\text{ A} = 6\text{ mA}
$$

#### Step 3: Voltage at midpoint ($V_{ref}$)

$V_{ref}$ is the voltage across $R_2$ (because it’s the resistor from midpoint down to ground):
$$
V_{ref} = I \cdot R_2 = (6\text{ mA})(1\text{ k}\Omega) = \boxed{6\text{ V}}
$$

Equivalently: $V_{ref}=12\cdot \frac{R_2}{R_1+R_2}=12\cdot \frac{1}{2}=6\text{ V}$

---

Calculate $V_{in}$, given:

- $V_{bus} = 12\text{ V}$
- $R_3 = 1\text{ k}\Omega$
- $R_{LDR} = 2\text{ k}\Omega$

#### Step 1: Total series resistance in that branch

$$
R_{total} = R_3 + R_{LDR} = 1k + 2k = 3\text{ k}\Omega
$$

#### Step 2: Branch current

$$
I = \frac{12}{3000} = 0.004\text{ A} = 4\text{ mA}
$$

#### Step 3: Voltage at midpoint ($V_{in}$)

$V_{in}$ is the voltage across the bottom resistor (the LDR):
$$
V_{in} = I \cdot R_{LDR} = (4\text{ mA})(2\text{ k}\Omega) = \boxed{8\text{ V}}
$$

Equivalently: $V_{in}=12\cdot \frac{R_{LDR}}{R_3+R_{LDR}}=12\cdot \frac{2}{3}=8\text{ V}$

### Simulation

Running LTSpice with following config

{{< image src="figure-1-1.png" caption="Figure 1.2 - Simulation" width=600px >}}

We got this result

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

### Experimental

With this setup

{{< image src="figure-1-2.avif" caption="Figure 1.3 - Experimental" width=600px >}}

we powered with 12V DC as initially designed.

{{< image src="figure-1-3.avif" caption="Figure 1.4 - Experimental" width=600px >}}

Then measured the $V_{ref} = 6.066 \text{ V}$

{{< image src="figure-1-4.avif" caption="Figure 1.5 - Experimental" width=600px >}}

and the $V_{in} = 7.967 \text{ V}$

{{< image src="figure-1-5.avif" caption="Figure 1.6 - Experimental" width=600px >}}

### Discussion

Here’s how the **hand calc**, **LTspice**, and **bench measurement** line up, plus the **percent error** of the measurement vs. the design target.

| Node      | Design (calc) | LTspice op point | Measured | Abs. error (Meas − Design) | % error |
| --------- | ------------: | ---------------: | -------: | -------------------------: | ------: |
| $V_{ref}$ |       6.000 V |          6.000 V |  6.066 V |                   +0.066 V |  +1.10% |
| $V_{in}$  |       8.000 V |          8.000 V |  7.967 V |                   −0.033 V |  −0.41% |

both measured voltages are very close to the ideal divider predictions (within about **±1.1%**). LTspice matches exactly because it uses ideal component values unless you add tolerances.

Why the measurement differs from the ideal (most likely causes)

1. Resistor tolerance (biggest for $V_{ref}$)
   With two “1 kΩ” resistors, $V_{ref}$ is *exactly* 6 V only if $R_1=R_2$.
   If $V_{bus}=12\text{ V}$ exactly, my measured $V_{ref}=6.066\text{ V}$ implies the ratio is slightly off:
   $$
   \frac{R_2}{R_1}\approx 1.022
   $$
   $R_2$ about 2.2% higher than $R_1$, totally plausible for common 5% (and even possible with 1% parts depending on pairing).

2. LDR isn’t a fixed 2 kΩ (it changes with light + temperature)
   Using my measured $V_{in}=7.967\text{ V}$, $R_3=1k\Omega$, and $V_{bus}=12\text{ V}$, the inferred LDR value is:
   $$
   R_{LDR} = R_3\frac{V_{in}}{V_{bus}-V_{in}} \approx 1k\cdot\frac{7.967}{12-7.967}\approx 1.98k\Omega
   $$
   So the LDR at measurement time was basically **~1.98 kΩ**, which explains why $V_{in}$ is very close to 8 V.

## Operational Amplifier as a Comparator

### Circuit Schematic

{{< image src="figure-2-1.png" caption="Figure 2.1 - Schematic" width=600px >}}

### Description

This part is a voltage comparator. The previously generated 6V reference voltage from the voltage divider circuit, along with the signal, is fed into an OP37 operational amplifier. Once the signal output from the voltage divider circuit containing the LDR exceeds 6V, the final output becomes high (lighting up the LED), and vice versa.

### Analysis

#### Step 1: Use the divider results (inputs of the op-amp)

From my earlier values (and assuming ideal op-amp inputs draw zero current, so the dividers are not loaded):

- $V_{ref}$ from $R_1=1k$ over $R_2=1k$:
  $$
  V_{ref}=12\cdot \frac{1k}{1k+1k}=12\cdot\frac12=6\text{ V}
  $$

- $V_{in}$ from $R_3=1k$ over $\text{LDR}=2k$:
  $$
  V_{in}=12\cdot \frac{2k}{1k+2k}=12\cdot\frac{2}{3}=8\text{ V}
  $$

#### Step 2: Compare op-amp input polarities

From the diagram connections:

- The top input is “−” (inverting) and is connected to $V_{ref}$
- The bottom input is “+” (non-inverting) and is connected to $V_{in}$

So:
$$
V_+ = V_{in} = 8\text{ V},\quad V_- = V_{ref} = 6\text{ V}
$$

#### Step 3: Ideal op-amp output behavior (open-loop comparator)

For an ideal op-amp (infinite open-loop gain):

* If $V_+ > V_-$ ⇒ output drives to the positive rail
* If $V_+ < V_-$ ⇒ output drives to the negative rail

Here:
$$
V_+ - V_- = 8 - 6 = 2\text{ V} > 0
$$
So the output goes high.

#### Step 4: Output rail values

The op-amp is powered from:

- $+V = V_{bus} = 12\text{ V}$
- $-V = 0\text{ V (ground)}$

Therefore, based on an ideal op-amp only:
$$
\boxed{V_{out} = 12\text{ V (HIGH)}}
$$

*Real OP37 behavior may not swing exactly to the rails.*

### Simulation

{{< image src="figure-2-1.png" caption="Figure 2.1 - Simulation" width=600px >}}

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

### Experimental

With this setup

{{< image src="figure-2-2.avif" caption="Figure 2.2 - Experimental" width=600px >}}

we powered with 12V DC as initially designed.

{{< image src="figure-1-3.avif" caption="Figure 2.3 - Experimental" width=600px >}}

Then measured the $V_{out} = 11.454 \text{ V}$

{{< image src="figure-2-3.avif" caption="Figure 2.4 - Experimental" width=600px >}}

### Discussion

Below is the calc vs. LTspice vs. measurement comparison for the OP37 used as a comparator, plus % error.

#### Comparator node voltages (with error %)

| Node | Ideal | LTspice op point | Measured | Abs. error | % error | % error |
| ---- | ----: | ---------------: | -------: | ---------: | ------: | ------: |
| $V_{ref}$ | 6.000 V  | 6.572 V  | — | — | — | — |
| $V_{in}$  | 8.000 V  | 7.237 V  | — | — | — | — |
| $V_{out}$ | 12.000 V | 11.138 V | 11.454 V | +0.316 V | +2.84% | −4.55% |

What this says:

- my measured output is very close to the LTspice OP37 model (only 2.84% high vs sim).
- my output is below 12 V because OP37 is not rail-to-rail, and output swing depends on load current and headroom.

---

#### Why LTspice shows “weird” $V_{ref}$ and $V_{in}$ (6.57 V and 7.24 V)

In an ideal comparator assumption, the inputs draw ~0 current, so the dividers stay exactly at 6 V and 8 V.

But my LTspice operating point report shows this:

- $I(R1)=5.4279 \text{ mA}$ while $I(R2)=6.5721 \text{ mA}$
- $I(R3)=4.7628 \text{ mA}$ while $I(LDR)=3.6186 \text{ mA}$

Those mismatches mean the divider midpoints are being loaded, and the amount is:

$$
I_{\text{load}} \approx 6.5721 - 5.4279 = 1.1442\ \text{mA}
$$
(same 1.1442 mA shows up on the other divider too)

---

#### Input clamp effect

The OP37 has back-to-back input protection diodes between its inputs, and if the differential input exceeds ~0.7 V, those diodes conduct and you must limit the current.

the ideal differential would be:
$$
V_{in}-V_{ref} = 8-6 = 2\text{ V}
$$
That’s well above ~0.7 V, so in a real device (and many macromodels), the input protection network can conduct and effectively pull the two input nodes toward each other, which is exactly what my sim shows:

- LTspice differential becomes
  $$
  7.237 - 6.572 = 0.665\text{ V}
  $$
  right near the diode clamp region

Because my divider resistors are only 1 kΩ, even ~mA of clamp current will shift node voltages by hundreds of mV, explaining the ~$\pm 0.57\text{ V}$ movement in $V_{ref}$ and $V_{in}$.

---

#### In Total

- **The comparator output behaves correctly**: since $V_{in} > V_{ref}$, the OP37 drives $V_{out}$ high, and you measured $11.454\text{ V}$, close to the simulated $11.138\text{ V}$ (2.84% error).
- **The output doesn’t reach 12 V** because OP37 output swing is limited (not rail-to-rail) and depends on load/headroom.
- **LTspice shows the input nodes shifting** because in open-loop comparator use, the input differential can exceed the internal protection diode threshold; the model then allows input clamp current (~1.14 mA) which loads the 1 kΩ dividers and moves $V_{ref}$ up and $V_{in}$ down.
