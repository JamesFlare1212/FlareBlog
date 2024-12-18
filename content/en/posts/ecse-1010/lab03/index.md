---
title: ECSE 1010 Proof of Concepts - Alpha Lab03
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
description: This blog post outlines a series of lab experiments and analyses involving Fourier analysis, signal reconstruction, filter design, and frequency manipulation using MATLAB and other tools. It includes discussions on theoretical concepts, simulations, and practical applications.
keywords: ["Fourier Analysis","Signal Processing","Filter Design"]
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
summary: This blog post outlines a series of lab experiments and analyses involving Fourier analysis, signal reconstruction, filter design, and frequency manipulation using MATLAB and other tools. It includes discussions on theoretical concepts, simulations, and practical applications.
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

## 0. Lab Document

<div style="width: 100%; max-width: 600px; margin: 0 auto; display: block;">
  <embed src="Lab03.pdf" type="application/pdf" width="100%" height="500px">
</div>

## 1. Prove the Result of Summing 3 Sinusoidal Waves in the Time and Frequency Domains

### Description

We are going to sum 3 basic type of sine wave and check its spectrum of frequency domain. See if that matches our expectation.

### Analysis

To determine the time domain signal and frequency spectrum of summing 3 sinusoidal waves. We can use the properties of sinusoidal waves in time and frequency domains.

For example, Sine Wave $250Hz$, $500Hz$ and $750Hz$ should have a result of time domain like

{{< image src="P1-1-b.avif" caption="P1-1-b" width=600px >}}

For the frequency domain, it should be like

{{< image src="P1-1-c.avif" caption="P1-1-c" width=600px >}}

Since the sum is made by 3 single sine wave.

### Simulation

{{< image src="P1-2-a.avif" caption="P1-2-a" width=600px >}}

{{< image src="P1-1-b.avif" caption="P1-1-b" width=600px >}}

{{< image src="P1-1-a.avif" caption="P1-1-a" width=600px >}}

### Discussion

Both our sketch and the simulation of frequency domain has 3 positive identical peaks. Which proves our analysis. The reason that they are not fully matched is due to Discrete Fourier Transform.

The sine wave used in this simulation is discrete sine wave. Unlike normal Fourier Transform, how many data point leads to how many frequency it went through. But the value in $dBm$ is extremely low. So, it makes no different.

## 2. Prove the Concept of Fourier Analysis by Determining Which Two Basic Types of Signals were Summed to Create This Mystery Signal

### Description

We are going to find out two basic types of signals of a summed up signal by Fourier Analysis. To do that we are going to use the peak finder in spectrum analyzer in MATLAB.

### Analysis

We can pick the most strong signal in frequency spectrum. That should be the two basic types of signals were summed to create this mystery signal.

### Simulation

Let's load [Mystery Signal Audio File](lab03_mystery_signal.wav)

{{< image src="P2-2-a.avif" caption="P2-2-a" width=600px >}}

The time domain looks like

{{< image src="P2-1-a.avif" caption="P2-1-a" width=600px >}}

And the frequency domain looks like

{{< image src="P2-1-b.avif" caption="P2-1-b" width=600px >}}

### Discussion

Use the peak finder, the top 2 positive frequency are

| Peak Number | Frequency ($Hz$) | Magnitude ($dBm$) |
|:---:|:---:|:---:|
| 1 | $101.5050$ | $25.2965$ |
| 2 | $749.5751$ | $19.6980$ |

So, the two basic types of signals were summed to create this mystery signal are

- Sine Wave $101.5050Hz$
- Sine Wave $749.5751Hz$

## 3. Prove the Concept of Fourier Synthesis by Reconstructing the Mystery Signal in the Time Domain

### Description

After find out the top 2 basic type of wave inside the mystery signal. We are going to reconstruct it and see if that matches the original work. We may use more than top 2 signal to get a better fitting.

### Analysis

A signal composed of two sine waves with frequencies of $101.5050 Hz$ and $749.5751 Hz$ can be mathematically expressed as follows:

$$
x(t) = \sin(2\pi \times 101.5050 \, t) + \sin(2\pi \times 749.5751 \, t)
$$

- **$t$**: Represents time in seconds.
- **$\sin$**: The sine function, which generates the oscillating waveform.
- **$2\pi \times f \, t$**: Converts the frequency $f$ from Hertz (cycles per second) to radians per second, which is necessary for the sine function argument.

a more general form can be written as

$$
x(t) = A_1 \sin(2\pi f_1 t + \phi_1) + A_2 \sin(2\pi f_2 t + \phi_2)
$$

Where

- $A_1$ and $A_2$ are the amplitudes of the sine waves.
- $f_1 = 101.5050 Hz$ and $f_2 = 749.5751 Hz$ are the frequencies.
- $\phi_1$ and $\phi_2$ are the phase shifts.

Assuming both sine waves have an amplitude of 1 and no phase shift, the expression simplifies to:

$$
x(t) = \sin(2\pi \times 101.5050 \, t) + \sin(2\pi \times 749.5751 \, t)
$$

### Simulation & Discussion

{{< image src="P3-2-a.avif" caption="P3-2-a" width=600px >}}

Use the peak finder, the top 5 positive frequency are

| Peak Number | Frequency ($Hz$) | Magnitude ($dBm$) |
|:---:|:---:|:---:|
| 1 | $101.5$ | $25.2965$ |
| 2 | $749.6$ | $19.6980$ |
| 3 | $148.4$ | $-3.2694$ |
| 4 | $694.9$ | $-13.9588$ |
| 5 | $1350.8$ | $-14.5331$ |

Then, build a layout with 5 basic wave instead of 2 for better result

{{< image src="P3-2-b.avif" caption="P3-2-b" width=600px >}}

Let's check the result

{{< image src="P3-2-c.avif" caption="P3-2-c" width=600px >}}

The power is not exactly matched, since they were adjusted by hand. But they are close, and get a result reconstructing signal of time domain like

{{< image src="P3-2-d.avif" caption="P3-2-d" width=600px >}}

Compare our reconstructing signal to the original signal, they share the same period and shape.

{{< image src="P2-1-a.avif" caption="P2-1-a" width=600px >}}

The different in detail may due to leak of more basic type of waves and different power of basic type of waves.

## 4. Prove the Concept of an Analog High-Pass Filter Using an Inductor and a Resistor and Could I Make a Low-Pass Filter Using the Same Components?

### Circuit Schematic

For low-pass filter

{{< image src="P4-1-a.avif" caption="P4-1-a" width=600px >}}

For high-pass filter

{{< image src="P4-1-b.avif" caption="P4-1-b" width=600px >}}

### Description

We will make HF and LF filter using an inductor and a resistor. And check the result of frequency respond using network analyzer function in Analog Discovery 3.

### Analysis

The cutoff frequencies for both the LR Low-Pass and LR High-Pass filters using component values

- **Resistor ($R$)**: $510 \Omega$
- **Inductor ($L$)**: $1 mH = 0.001 H$

The cutoff frequency for both filters is given by:

$$
f_c = \frac{R}{2\pi L}
$$

Plugging in the Values

$$
\begin{align*}
  f_c &= \frac{510}{2 \times \pi \times 0.001} \\\
  f_c &= \frac{510}{0.00628318} \approx 81,000 \text{ Hz}
\end{align*}
$$

### Simulation

For low-pass filter

{{< image src="P4-3-a.avif" caption="P4-3-a" width=600px >}}

We got a cut off frequency around $82.37kHz$

{{< image src="P4-3-a-b.avif" caption="P4-3-a-b" width=600px >}}

For high-pass filter

{{< image src="P4-3-b.avif" caption="P4-3-b" width=600px >}}

We got a cut off frequency around $80.69kHz$

{{< image src="P4-3-b-b.avif" caption="P4-3-b-b" width=600px >}}

### Measurement

I am using the network analyzer to draw a frequency respond diagram. For low-pass filter, we had a setup like

{{< image src="P4-4-a-b.avif" caption="P4-4-a-b" width=600px >}}

We got a cut off frequency around $79.48kHz$

{{< image src="P4-4-a.avif" caption="P4-4-a" width=600px >}}

For high-pass filter

{{< image src="P4-4-a-b.avif" caption="P4-4-a-b" width=600px >}}

We got a cut off frequency around $80.98kHz$

{{< image src="P4-4-b.avif" caption="P4-4-b" width=600px >}}

### Discussion

Our Simulation matches our Analysis. The Measurement also matches our Simulation and Analysis. Both of them has a cut off frequency around $80kHz$ with mark of $-3dBm$.

## 5. Prove the concept of using Fourier Analysis to associate audible features of an audio signal with specific frequency ranges in its frequency spectrum

### Description

We are going to find out the leading signal of the given signal and try to reconstruct it. After reconstruction, we are going to compare some key feature to the original signal.

### Analysis

{{< image src="P5-1-a.avif" caption="P5-1-a" width=600px >}}

{{< image src="P5-1-b.avif" caption="P5-1-b" width=600px >}}

We used high-pass and low-pass filter to split two frequencies within a signal up. We ran these two frequencies, the original signal, and the two frequencies summed into the spectrum analyzer. We see the sum of the two filtered frequencies is fit to the original.

Then, we point out the main frequency from [splay](splay.zip)

{{< image src="P5-2-a.avif" caption="P5-2-a" width=600px >}}

which are

- $440.5Hz$
- $480.1Hz$

### Simulation & Discussion

Then, we reconstructed it.

{{< image src="P5-2-b.avif" caption="P5-2-b" width=600px >}}

They have identical shape and frequency domain.

{{< image src="P5-2-d.avif" caption="P5-2-d" width=600px >}}

{{< image src="P5-2-d.avif" caption="P5-2-d" width=600px >}}

## 6. Prove the Concept of Filtering Out or Isolating a Particular Range of Frequencies of a Signal

### Description

We are going to simulate the LP filter and using Simulink to create a mid-pass filter. After this, we are going to apply this to a song and see what can it change.

### Analysis

We simulated a low-pass filter. Red is the raw signal, and the black is the filtered signal. As we can see, part of signal got removed.

{{< image src="P6-2-a.avif" caption="P6-2-a" width=600px >}}

With the formula of

$$
F_{low} = \frac{1}{2 \pi RC}
$$

we can get the capacitance of the target LP filter.

$$
\begin{align*}
  300 &= \frac{1}{2 \pi \cdot  1K \cdot C} \\\
  C &= 5.6 \times 10^{-7}
\end{align*}
$$

### Simulation & Discussion

Our audio file was that of Mary Had a Little Lamb. We wanted to hear a higher pitched version of it.

{{< image src="P6-1-a.avif" caption="P6-1-a" width=600px >}}

by applying a Mid-pass filter from $800Hz$ to $1700Hz$, we are able to remove part of the signal and able to hear about the sound. We isolate a specific, higher range of the song.
We end up with a higher pitched version of the song and some high pitched screechy sound accompanying it. The higher pitched version is also less loud.

{{< image src="P6-1-b.avif" caption="P6-1-b" width=600px >}}

{{< image src="P6-1-c.avif" caption="P6-1-c" width=600px >}}
