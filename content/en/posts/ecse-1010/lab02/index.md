---
title: ECSE 1010 Proof of Concepts - Omega Lab02
subtitle:
date: 2024-11-28T12:57:51-05:00
lastmod: 2024-11-28T12:57:51-05:00
slug: ecse-1010-poc-lab02
draft: false
author:
  name: James
  link: https/www.jamesflare.com
  email:
  avatar: /site-logo.avif
description: The experiments aim to validate Ohm's Law, non-linear IV curves for LEDs, differential resistance in diode IV curves, nodal voltage solving with Kirchhoff’s Laws, the function of an op amp comparator, mathematical op amp functionality, and two-channel audio mixer transfer functions.
keywords: ["Electrical Engineering","Ohm's Law","IV curve","Nodal Analysis","Op-Amp"]
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
summary: The experiments aim to validate Ohm's Law, non-linear IV curves for LEDs, differential resistance in diode IV curves, nodal voltage solving with Kirchhoff’s Laws, the function of an op amp comparator, mathematical op amp functionality, and two-channel audio mixer transfer functions.
resources:
  - name: featured-image
    src: featured-image.avif
  - name: featured-image-preview
    src: featured-image-preview.avif
toc: true
math: true
lightgallery: true
password:
message:
repost:
  enable: false
  url:

# See details front matter: https/fixit.lruihao.cn/documentation/content-management/introduction/#front-matter
---

<!--more-->

## 0. Lab Document

<div style="width: 100%; max-width: 600px; margin: 0 auto; display: block;">
  <embed src="Lab02.pdf" type="application/pdf" width="100%" height="500px">
</div>

## 1. Prove That the Slope of an $IV$ Curve Corresponds with Ohm’s Law for Two Different Resistor Values

### Building Block

{{< image src="P1-1-a.avif" caption="P1-1-a" width=600px >}}

Let's pick two resistor. The first one is

{{< figure src="P1-1-b.avif" caption="P1-1-b" width=600px >}}

4-Band Color Code: Orange, Orange, Brown, Gold

$$
\begin{align*}
  33 \times (1\times10^1) = 330 \Omega \pm 5\%
\end{align*}
$$

have a check

{{< image src="P1-1-b-2.avif" caption="P1-1-b-2" width=600px >}}

The second one is

{{< image src="P1-1-c.avif" caption="P1-1-c" width=600px >}}

4-Band Color Code: Brown, Brown, Red, Gold

$$
\begin{align*}
  11 \times (1\times10^2) = 1100 \Omega \pm 5\%
\end{align*}
$$

have a check

{{< image src="P1-1-c-2.avif" caption="P1-1-c-2" width=600px >}}

### Analysis

We know that $IV$ curve means $I$ on the y-axis and $V$ on the x-axis of the plot. Then, it must be a linear function, because both $IV$ don't have powers.

Using the idea of linear function, we know the slope is $\frac{\Delta X}{\Delta Y}$. Back to our case, it becomes $\frac{\Delta V}{\Delta I}$. Also, we knows the Ohm's Law, which $\frac{V}{I} = R$. So, the slope is very likely to be the resistance $R$.

If we take $R_1 = 10 \Omega$,  $R_2 = 100 \Omega$ (As the simulation set). We should got.

{{< image src="P1-2-a.avif" caption="P1-2-a" width=600px >}}

If we plot them together, we got

{{< image src="P1-2-b.avif" caption="P1-2-b" width=600px >}}

Here is the data table

|$I$  | $V=IR_1$  | $V=IR_2$  |
|:----|----------:|----------:|
| 0   | 0         | 0         |
| 0.2 | 2         | 20        |
| 0.4 | 4         | 40        |
| 0.6 | 6         | 60        |
| 0.8 | 8         | 80        |
| 1   | 10        | 100       |

### Simulation

{{< image src="P1-3-a.avif" caption="P1-3-a" width=600px >}}

### Measurement

First we built a circuit like this

{{< image src="P1-4-a.avif" caption="P1-4-a" width=600px >}}

this is based on the diagram from the lab document

{{< image src="P1-4-a-2.avif" caption="P1-4-a-2" width=250px >}}

We only changed the $R1, R2$ values. Also, it's hard to plug multimeter on the breadboard. So, we intersect the $V+$ circuit at the front

{{< image src="P1-4-b.avif" caption="P1-4-b" width=600px >}}

This method is not ideal, but works.

***

Let's begin

For $V+ = 0.5V$, we got

{{< image src="P1-4-c.avif" caption="P1-4-c" width=600px >}}

{{< image src="P1-4-c-2.avif" caption="P1-4-c-2" width=600px >}}

To save some space and work, we just will not show each result. But here is the data

|$V+$|$V(R1)$|$V(R1)$|$I$|
|:---|:------|:------|:--|
|$0V$|$0V$|$0V$|$0mA$|
|$0.5V$|$0.142V$|$0.396V$|$0.3mA$|
|$1V$|$0.238V$|$0.724V$|$0.6mA$|
|$1.5V$|$0.358V$|$1.126V$|$1.0mA$|
|$2V$|$0.463V$|$1.492V$|$1.3mA$|
|$2.5V$|$0.572V$|$1.831V$|$1.6mA$|
|$3V$|$0.632V$|$1.994V$|$1.9mA$|

With this MATLAB code,

```matlab
% Step 1: Enter the data
V_plus = [0, 0.5, 1, 1.5, 2, 2.5, 3]; % V+ values
V_R1 = [0, 0.142, 0.238, 0.358, 0.463, 0.572, 0.632]; % V(R1) values
V_R2 = [0, 0.396, 0.724, 1.126, 1.492, 1.831, 1.994]; % V(R2) values
I = [0, 0.3, 0.6, 1.0, 1.3, 1.6, 1.9] * 1e-3; % I values in A (converted from mA)

% Step 2: Plot the data
figure;

% Plot for Resistor R1
subplot(2, 1, 1);
plot(V_R1, I, '-o');
xlabel('Voltage V(R1) (V)');
ylabel('Current I (A)');
title('Resistor R1: Current vs Voltage');
grid on;

% Plot for Resistor R2
subplot(2, 1, 2);
plot(V_R2, I, '-o');
xlabel('Voltage V(R2) (V)');
ylabel('Current I (A)');
title('Resistor R2: Current vs Voltage');
grid on;
```

we got the plot of $R1$ and $R2$

{{< image src="P1-4-d.svg" caption="P1-4-d" width=600px >}}

Now, let's create a fit line for both. It's needed to find out the slope ($R=V/I$). To do that, we changed the code a bit into

```matlab
% Step 1: Enter the data
V_plus = [0, 0.5, 1, 1.5, 2, 2.5, 3]; % V+ values
V_R1 = [0, 0.142, 0.238, 0.358, 0.463, 0.572, 0.632]; % V(R1) values
V_R2 = [0, 0.396, 0.724, 1.126, 1.492, 1.831, 1.994]; % V(R2) values
I = [0, 0.3, 0.6, 1.0, 1.3, 1.6, 1.9] * 1e-3; % I values in A (converted from mA)

% Step 2: Fit linear regression curves
% Fit for Resistor R1
p_R1 = polyfit(I, V_R1, 1);
slope_R1 = p_R1(1);
R_R1 = slope_R1; % Resistance of R1

% Fit for Resistor R2
p_R2 = polyfit(I, V_R2, 1);
slope_R2 = p_R2(1);
R_R2 = slope_R2; % Resistance of R2

% Step 3: Display the resistances
fprintf('Resistance of R1: %.3f ohms\n', R_R1);
fprintf('Resistance of R2: %.3f ohms\n', R_R2);

% Step 4: Plot the data and fitted curves
figure;

% Plot for Resistor R1
subplot(2, 1, 1);
plot(V_R1, I, 'o');
hold on;
plot(polyval(p_R1, I), I, '-');
xlabel('Voltage V(R1) (V)');
ylabel('Current I (A)');
title('Resistor R1: Current vs Voltage with Linear Fit');
legend('Data', 'Linear Fit');
grid on;

% Plot for Resistor R2
subplot(2, 1, 2);
plot(V_R2, I, 'o');
hold on;
plot(polyval(p_R2, I), I, '-');
xlabel('Voltage V(R2) (V)');
ylabel('Current I (A)');
title('Resistor R2: Current vs Voltage with Linear Fit');
legend('Data', 'Linear Fit');
grid on;
```

we got a result of

```text
Resistance of R1: 331.144 ohms
Resistance of R2: 1069.374 ohms
```

and the plots

{{< image src="P1-4-e.svg" caption="P1-4-e" width=600px >}}

Check this result from multimeter's reading of resistance

{{< image src="P1-4-d.avif" caption="P1-4-d" width=600px >}}

{{< image src="P1-4-d-2.avif" caption="P1-4-d-2" width=600px >}}

Great! The actual reading is very close to the resistances we determined from your IV measurement data and the linear regression. The average $\%$ error is less than $1\%$

### Discussion

We did a lot of discussion in each session instead of in one. This is just to make the document more logical and follows the flow. So, we will only summarize and add something not appear above.

First, we used LTSpecie to determine $IV$ curve of two resistor $R_1 = 10\Omega$ and $R_2 = 100\Omega$. (This is just for prove our Analysis, so it doesn't match the $R_1 = 330\Omega$ and $R_2 = 1100\Omega$ we used later). And it matches our Analysis. Both the plot created by Excel and the values.

Then, we built a series circuit, and we know they have the same current across all components. And, the $R$ is only related to $IV$. As long as we got some reading pairs, we can plot the curve. The result matches our expectation with less than $1\%$ error. Consider our multimeter can only measure down to $0.1 mV$. This accuracy is amazing!

Thus, we proved That the Slope of an $IV$ Curve Corresponds with Ohm’s Law for Two Different Resistor Values.

## 2. Prove the non linear $IV$ curve for a light emitting diode

### Building Block

{{< image src="P3-1-a.avif" caption="P3-1-a" width=600px >}}

### Analysis

To plot a $IV$ curve of a diode. We need to find out a few important data.

- Forward Voltage ($V_F$)
- Reverse Breakdown Voltage ($V_{BR}$)
- Reverse Leakage Current ($I_S$)

As the datasheet of [QED123](https/www.onsemi.com/pdf/datasheet/qed123-d.pdf) said

- $V_F = 1.7V$
- $I_F = 100 mA$
- $V_{BR} = 5V$
- $I_S = 10 \mu A$

We just plot them into a standard diode $IV$ characteristic diagram and get

{{< image src="P2-2-a.avif" caption="P2-2-a" width=600px >}}

### Simulation

{{< image src="P3-3-a.avif" caption="P2-3-a" width=600px >}}

The turn on voltage of 1N914 is about $0.7V$

### Measurement

{{< image src="P3-4-a.avif" caption="P3-4-a" width=600px >}}

We create a trig wave like

{{< image src="P3-4-b.avif" caption="P3-4-b" width=600px >}}

with amplitude to 5V (10 volts peak to peak), frequency to 200 Hz, and phase to 90 degrees.

Then, we use channel 1 to find out the current using the math function in scope

```js
C1/330*1000
```

{{< image src="P3-4-b-2.avif" caption="P3-4-b-2" width=600px >}}

and the $IV$ Curve

{{< image src="P3-4-b-3.avif" caption="P3-4-b-3" width=600px >}}

with this MATLAB Code,

```matlab
% Step 1: Import the CSV file
data = readmatrix('P2-4-c.csv');

% Step 2: Extract the columns
voltage = data(:, 2);  % Second column is voltage (V)
current = data(:, 1);  % Third column is current (I)


% Step 3: Plot the I-V curve
figure;
plot(currentvoltage, current, 'k-', 'LineWidth', 1.5);
xlabel('Voltage (V)');
ylabel('Current (I)');
title('I-V Curve');
grid on;
```

we got

{{< image src="P2-4-c-2.svg" caption="P2-4-c-2" width=600px >}}

### Discussion

Our experimental matches the datasheet. Consider the datasheet said

- $V_F = 1.7V$
- $I_F = 100 mA$

and we got $1.7V$ on $10 mA$ this matches the datasheet curve.

## 3. Show / demonstrate that the differential resistance changes in different regions in the diode $IV$ curve

### Building Block

{{< image src="P3-1-a.avif" caption="P3-1-a" width=600px >}}

### Analysis

To plot a $IV$ curve of a diode. We need to find out a few important data.

- Forward Voltage ($V_F$)
- Reverse Breakdown Voltage ($V_{BR}$)
- Reverse Leakage Current ($I_S$)

As the datasheet of [QED123](https/www.onsemi.com/pdf/datasheet/qed123-d.pdf) said

- $V_F = 1.7V$
- $I_F = 100 mA$
- $V_{BR} = 5V$
- $I_S = 10 \mu A$

We just plot them into a standard diode $IV$ characteristic diagram and get

{{< image src="P2-2-a.avif" caption="P2-2-a" width=600px >}}

### Simulation

{{< image src="P3-3-a.avif" caption="P3-3-a" width=600px >}}

The turn on voltage of 1N914 is about $0.7V$

### Measurement

{{< image src="P3-4-a.avif" caption="P3-4-a" width=600px >}}

We create a trig wave like

{{< image src="P3-4-b.avif" caption="P3-4-b" width=600px >}}

with amplitude to 5V (10 volts peak to peak), frequency to 200 Hz, and phase to 90 degrees.

Then, we use channel 1 to find out the current using the math function in scope

```js
C1/330*1000
```

{{< image src="P3-4-b-2.avif" caption="P3-4-b-2" width=600px >}}

and the $IV$ Curve

{{< image src="P3-4-b-3.avif" caption="P3-4-b-3" width=600px >}}

with this MATLAB Code,

```matlab
% Step 1: Import the CSV file
data = readmatrix('P2-4-c.csv');

% Step 2: Extract the columns
voltage = data(:, 2);  % Second column is voltage (V)
current = data(:, 1);  % Third column is current (I)


% Step 3: Plot the I-V curve
figure;
plot(voltage, current, 'k-', 'LineWidth', 1.5);
xlabel('Voltage (V)');
ylabel('Current (I)');
title('I-V Curve');
grid on;
```

we got

{{< image src="P2-4-c-2.svg" caption="P2-4-c-2" width=600px >}}

### Discussion

To find out at least 2 locations on the curve to show that the differential resistance changes along the I-V characteristic. We modified the code a bit to let it find out 2 random point on the plot and its slope.

```matlab
% Step 1: Import the CSV file
data = readmatrix('P2-4-c.csv');

% Step 2: Extract the columns
voltage = data(:, 2);  % Second column is voltage (V)
current = data(:, 1);  % Third column is current (I)

% Step 3: Select two random points
num_points = length(current);
random_indices = randperm(num_points, 2);  % Generate 2 unique random indices

% Step 4: Extract the voltage and current values for the selected points
V1 = voltage(random_indices(1));
V2 = voltage(random_indices(2));
I1 = current(random_indices(1));
I2 = current(random_indices(2));

% Step 5: Calculate the slopes
slope1 = (V2 - V1) / (I2 - I1);
slope2 = (V1 - V2) / (I1 - I2);  % This is the same as slope1 but calculated in reverse

% Step 6: Print the slopes
fprintf('The slope between the randomly selected points (I1 = %.4f, V1 = %.4f) and (I2 = %.4f, V2 = %.4f) is: %.4f\n', I1, V1, I2, V2, slope1);
fprintf('The slope between the randomly selected points (I2 = %.4f, V2 = %.4f) and (I1 = %.4f, V1 = %.4f) is: %.4f\n', I2, V2, I1, V1, slope2);
```

We got

> The slope between the randomly selected points (I1 = 0.0097, V1 = 0.2959) and (I2 = 0.0036, V2 = -2.6254) is: 479.8789
>
>The slope between the randomly selected points (I2 = 7.9784, V2 = 1.2568) and (I1 = 2.8170, V1 = 1.1975) is: 0.0115

We can see they are very different.

## 4. Prove That Nodal Analysis Solves Unknown Nodal Voltages in a Circuit

### Building Block

{{< image src="P4-1-a.avif" caption="P4-1-a" width=600px >}}

### Analysis

{{< image src="P4-2-a.avif" caption="P4-2-a" width=600px >}}

To make our life easier, I rewrite some equation in $\LaTeX$.

Current through a resistor:

$$
I_R = \frac{V_A - V_B}{R}
$$

Kirchhoff's Current Law (KCL) at node B:

$$
I_{R_1} + I_{R_2} + I_{R_3} = 0
$$

KCL at node C:

$$
I_{R_3} + I_{R_4} = 0
$$

Expressing currents in terms of voltages. From the first equation:

$$
\frac{V_B - V_A}{R_1} + \frac{V_B}{R_2} + \frac{V_B - V_C}{R_3} = 0
$$

From the second equation:

$$
\frac{V_C - V_B}{R_3} + \frac{V_C - V_D}{R_4} = 0
$$

Substituting known values. Given $V_A = 5$ and $V_D = 0$, the equations become:

$$
2.5V_B - V_C = 5 \\\
2V_C - V_B = 0
$$

Matrix form: $\begin{bmatrix} 2.5 & -1 \\\ -1 & 2 \end{bmatrix}$ $\begin{bmatrix} V_B \\\ V_C \end{bmatrix} =$ $\begin{bmatrix} 5 \\\ 0 \end{bmatrix}$

Solve them "by hand"

```matlab
% Define the matrix A and the vector b
A = [2.5, -1; -1, 2];
b = [5; 0];

% Solve the system of linear equations A * x = b
x = A \ b;

% Display the solution
disp('The solution is:');
disp(x);
```

we got

```text
The solution is:
    2.5000
    1.2500
```

Thus, $\begin{bmatrix} V_B \\\ V_C \end{bmatrix} =$ $\begin{bmatrix}2.5 \\\ 1.25 \end{bmatrix}$

### Simulation

{{< image src="P4-3-a.avif" caption="P4-3-a" width=600px >}}

### Measurement

{{< image src="P4-4-a.avif" caption="P4-4-a" width=600px >}}

For $V_C$, we got

{{< image src="P4-4-b-1.avif" caption="P4-4-b-1" width=600px >}}

For $V_B$, we got

{{< image src="P4-4-b-2.avif" caption="P4-4-b-2" width=600px >}}

### Discussion

|Node|Analysis|Simulation|Experimental|diff|%diff|
|:-:|:-:|:-:|:-:|:-:|:-|
|$V_B$|$2.50V$|$2.50V$|$2.45V$|$5mV$|$2\%$|
|$V_C$|$1.25V$|$1.25V$|$1.22V$|$3mV$|$2.4\%$|

Our Analysis matches the Simulation. The Experimental data has less than $2.5\%$ error than expect, which is very less. Thus, we proved That Nodal Analysis Solves Unknown Nodal Voltages in a Circuit.

## 5. Prove / demonstrate your approach to designing a circuit using nodal analysis

### Building Block

{{< image src="P5-3-a.avif" caption="P5-3-a" width=600px >}}

### Analysis

{{< image src="P5-2-a.avif" caption="P5-2-a" width=600px >}}

To make our life easier, I rewrite some equation in $\LaTeX$.

Given values:

- $V_A = 3 \, \text{V}$
- $V_C = 0 \, \text{V}$
- $V_B$ is unknown.

Using Kirchhoff's Current Law (KCL) at node B:

$$
\frac{V_B - V_A}{R_1} + \frac{V_B - V_C}{R_2} + \frac{V_B - V_C}{R_3} = 0
$$

Substituting the given values and resistances:

$$
\frac{V_B - 3}{1} + \frac{V_B - 0}{4} + \frac{V_B - 0}{4} = 0
$$

Simplifying the equation:

$$
(V_B - 3) + \frac{V_B}{4} + \frac{V_B}{4} = 0
$$

Combine terms:

$$
V_B - 3 + \frac{V_B}{2} = 0
$$

Multiply through by 2 to clear the fraction:

$$
2V_B - 6 + V_B = 0
$$

Combine terms:

$$
3V_B = 6
$$

Solve for $V_B$:

$$
V_B = 2
$$

### Simulation

{{< image src="P5-3-a.avif" caption="P5-3-a" width=600px >}}

### Measurement

{{< image src="P5-4-a-1.avif" caption="P5-4-a-1" width=600px >}}

For $V_B$, we got

{{< image src="P5-4-a.avif" caption="P5-4-a" width=600px >}}

### Discussion

|Node|Analysis|Simulation|Experimental|diff|%diff|
|:-:|:-:|:-:|:-:|:-:|:-|
|$V_B$|$2V$|$2V$|$1.979V$|$21mV$|$1.1\%$|

Our Analysis matches the Simulation. The Experimental data has less than $1.2\%$ error than expect, which is very less. Thus, we proved That Nodal Analysis Solves Unknown Nodal Voltages in a Circuit.

## 6. Prove the function of an op amp comparator

### Building Block

{{< image src="P6-1-a.avif" caption="P6-1-a" width=600px >}}

### Analysis
A non-inverted comparator has a transfer function of

$$
\begin{equation*}
V_{out}=\begin{cases}
          \text{if} \; V_{in} < V_{ref}, V_{out} = V_s - \\\
      \text{if} \; V_{in} > V_{ref}, V_{out} = V_s + \\\
     \end{cases}
  \end{equation*}
$$

In our case, we got

$$
\begin{equation*}
V_{out}=\begin{cases}
          \text{if} \; V_{in} < 0V, V_{out} = -5V \\\
      \text{if} \; V_{in} > 0V, V_{out} = 5V \\\
     \end{cases}
  \end{equation*}
$$

Our supply voltage are $5V$ and $-5V$, and the input is a SINE wave with amplitude of $1V$, and the reference voltage is $GND$ which is $0V$

### Simulation

{{< image src="P6-3-b.avif" caption="P6-3-b" width=600px >}}

{{< image src="P6-3-a.avif" caption="P6-3-a" width=600px >}}

### Measurement

{{< image src="P6-4-a-b.avif" caption="P6-4-a-b" width=600px >}}

{{< image src="P6-4-a.avif" caption="P6-4-a" width=600px >}}

### Discussion

Comparing our simulation to our experiment, we see that both of them are square waves with the same periods and similar amplitudes. They are fluctuating between 5 and -5, which are our supply voltages. This makes sense, because the supply voltages are the outputs of op amp comparators.

This proves our concept of an op amp comparator.

## 7. Prove the function of a mathematical op amp

### Building Block

{{< image src="P8-1-a.avif" caption="P8-1-a" width=600px >}}

### Analysis

{{< image src="P8-2-a.avif" caption="P8-2-a" width=600px >}}

Summing amplifier circuit has a transfer function like

$$
V_{out} = - \frac{Rf}{R1} \cdot V1 - \frac{Rf}{R2} \cdot V2
$$

In our case, we want to use $50K \Omega$ potentiometer as the resistors, so it can be adjusted according to our demand. Then, we got

$$
\begin{align*}
  V_{out} &= - \frac{\cancel{50K}}{\cancel{50K}} \cdot V1 - \frac{\cancel{\cancel{50K}}}{\cancel{50K}} \cdot V2 \\\
  V_{out} &= - V1 - V2 \\\
\end{align*}
$$

### Simulation

We just used two SINE waves with different frequencies ($500 \; \text{Hz}$ and $1K \; \text{Hz}$) in our simulation.

{{< image src="P8-3-a.avif" caption="P8-3-a" width=600px >}}

{{< image src="P5-3-b.avif" caption="P5-3-b" width=600px >}}

### Measurement

Then, we setup the circuit. We just connected scope channel 1 to the $V_{out}$ to check it works or not

{{< image src="P8-4-a-b.avif" caption="P8-4-a-b" width=600px >}}

We have  $V_s + = 5V$ and $V_s - = -5V$

{{< image src="P8-4-a.avif" caption="P8-4-a" width=600px >}}

We used wave generator to create to SINE waves of $500 \; \text{Hz}$ and $1K \; \text{Hz}$

{{< image src="P8-4-b.avif" caption="P8-4-b" width=600px >}}

And we checked the output wave using scope channel 1+

{{< image src="P8-4-c.avif" caption="P8-4-c" width=600px >}}

### Discussion

As we see, the shape of the output wave is exactly the same as our simulation. Both the amplitude of the output wave in the simulation and measurement is around $1.75V$, and the period is the same.

Since the shape and all features of our experimental wave matches our simulation, we know this op-amp works in different voltage ranges.

This proved our concept of summer amp which is a mathematical op-amp.

## 8. Prove the concept of transfer functions of Two-Channel Audio Mixer

### Building Block

{{< image src="P8-1-a.avif" caption="P8-1-a" width=600px >}}

### Analysis

{{< image src="P8-2-a.avif" caption="P8-2-a" width=600px >}}

Summing amplifier circuit has a transfer function like

$$
V_{out} = - \frac{Rf}{R1} \cdot V1 - \frac{Rf}{R2} \cdot V2
$$

In our case, we want to use $50K \Omega$ potentiometer as the resistors, so it can be adjusted according to our demand. Then, we got

$$
\begin{align*}
  V_{out} &= - \frac{\cancel{50K}}{\cancel{50K}} \cdot V1 - \frac{\cancel{\cancel{50K}}}{\cancel{50K}} \cdot V2 \\\
  V_{out} &= - V1 - V2 \\\
\end{align*}
$$

### Simulation

We just used to SINE wave with different frequency ($500 \; \text{Hz}$ and $1K \; \text{Hz}$) to test what we expect.

{{< image src="P8-3-a.avif" caption="P8-3-a" width=600px >}}

{{< image src="P5-3-b.avif" caption="P5-3-b" width=600px >}}

### Measurement

Then, we setup the circuit. We just connect scope channel 1 to the $V_{out}$ to check it works or not

{{< image src="P8-4-a-b.avif" caption="P8-4-a-b" width=600px >}}

We supply $V_s + = 5V$ and $V_s - = -5V$

{{< image src="P8-4-a.avif" caption="P8-4-a" width=600px >}}

And use wave generator to create to SINE wave of $500 \; \text{Hz}$ and $1K \; \text{Hz}$

{{< image src="P8-4-b.avif" caption="P8-4-b" width=600px >}}

And we checked the output wave using scope channel 1+

{{< image src="P8-4-c.avif" caption="P8-4-c" width=600px >}}

### Discussion

As we see, the shape of the output wave is exactly the same as what we simulated. Both the amplitude of the output wave in the simulation and measurement is around $1.75V$, and the period is the same.

This proved our concept of summer amp.
