---
title: ENGR 2350 - Quiz 2
date: 2025-02-13T12:26:20-05:00
lastmod: 2025-02-13T12:26:20-05:00
slug: engr-2350-quiz-02
draft: false
author:
  name: James
  link: https://www.jamesflare.com
  email:
  avatar: /site-logo.avif
description: This post shows the back Quiz 2 of ENGR 2350 on Spring 2025. It includes the question and answer with explains.
keywords: ["C","Programming","RPI","ENGR 2350","Quiz"]
license:
comment: true
weight: 0
tags:
  - C
  - Programming
  - RPI
  - ENGR 2350
  - Quiz
categories:
  - Programming
  - Electrical Engineering
collections:
  - ENGR 2350
hiddenFromHomePage: false
hiddenFromSearch: false
hiddenFromRss: false
hiddenFromRelated: false
summary: This post shows the back Quiz 2 of ENGR 2350 on Spring 2025. It includes the question and answer with explains.
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

## Q1 Timer Calculations

> For a Timer\_A module operating with a system clock of **12 MHz** and in "up mode"...

### Q1.1

> ...what must be the timer's period (in number of counts) be such that the overflow period is **8 ms**? Assume that the timer's clock divider is set to **32**.

$$\text{Timer clock} = \frac{12\text{ MHz}}{32} = 375000 \text{ Hz} \quad (375 \text{ kHz})$$
$$N = 375000 \times 0.008 \text{ s} = \boxed{3000} \text{ ticks}$$

### Q1.2

> What is the smallest divider possible that could still allow the timer to produce the same overflow period? Assume, of course, that the timer's period (in counts) can also change.

If we want the smallest divider possible, we’d ideally choose a divider of $\boxed{1}$

## Q2 Basic GPIO

> Answer the following questions about GPIO functionality and usage considering the circuit as provided below.
> {{< image src="q2-gpio.avif" width="480px" caption="Q2 Basic GPIO Pin Out" >}}

### Q2.2

> Initialize the GPIO pins in the circuit diagram above using the **DriverLib**. Do not modify any other pins in the port.

```c
GPIO_setAsInputPin(GPIO_PORT_P6, GPIO_PIN1 | GPIO_PIN6);
GPIO_setAsOutputPin(GPIO_PORT_P6, GPIO_PIN4);
```

### Q2.3

> Using **Registers** or the **DriverLib**, turn on LED1 only if PB1 is pressed and PB2 is not. The LED should be set off otherwise.

```c
PB1 = GPIO_getInputPinValue(GPIO_PORT_P6, GPIO_PIN1);
PB2 = GPIO_getInputPinValue(GPIO_PORT_P6, GPIO_PIN6);

if (!PB1 && !PB2){ 
    GPIO_setOutputHighOnPin(GPIO_PORT_P3, GPIO_PIN6);
} else { 
    GPIO_setOutputLowOnPIN(GPIO_PORT_P3, GPIO_PIN6);
}
```

## Q3

> Convert the flow chart to an equivalent segment of code.
>
> ```mermaid
>  flowchart TB
>     A([Start]) --> B{"Are a and b\nboth zero?"}
>     B -- Yes --> C([Done])
>     B -- No --> D[Divide a by 2<br/>and save back into a]
>     D --> E[Multiply b by a<br/>and save back into b]
>     E --> B
> ```

```c
while (a == 0 && b == 0) {
    a = a / 2;
    b = b * a;
}
```

## Q4 Timer / Interrupt Code

> Given the complete program below and knowing that SMCLK is **12 MHz**, answer the following questions.
>
> ```c
> void IncA(),IncB(),IncC();
> uint8_t A = 0,B = 0,C = 0;
> Timer_A_UpModeConfig tim_config;
> uint32_t timer = XXXXXXXXX; // Some valid value
> 
> void main(){
>   SysInit();
>   TimerInit();
>   while(1){
>         // To fill in
>   }
> }
> 
> void TimerInit(){
>   tim_config.clockSource = TIMER_A_CLOCKSOURCE_SMCLK;
>   tim_config.clockSourceDivider = TIMER_A_CLOCKSOURCE_DIVIDER_32;
>   tim_config.timerPeriod = 12345;
>   tim_config.timerClear = TIMER_A_DO_CLEAR;
>   tim_config.timerInterruptEnable_TAIE = TIMER_A_TAIE_INTERRUPT_ENABLE;
>   Timer_A_configureUpMode(timer,&tim_config);
>   Timer_A_registerInterrupt(timer,TIMER_A_CCRX_AND_OVERFLOW_INTERRUPT,IncC);
>   Timer_A_startCounter(timer,TIMER_A_UP_MODE);
> }
>
> void IncA(){
>   Timer_A_clearInterruptFlag(TIMER_A1_BASE);
>   A++;
> }
> 
> void IncB(){
>   Timer_A_clearInterruptFlag(TIMER_A2_BASE);
>   B++;
> }
> 
> void IncC(){
>   Timer_A_clearInterruptFlag(TIMER_A3_BASE);
>  C++;
> }
> ```

### Q4.1

> What function given in this code is and will be called as an **Interrupt Service Routine**? Give the function name.

```c
IncC()
```

Because the line `Timer_A_registerInterrupt(timer, TIMER_A_CCRX_AND_OVERFLOW_INTERRUPT, IncC);` It sets up `IncC()` as the ISR for the timer interrupt.

### Q4.2

> How often is this function triggered by the hardware? Give your answer in milliseconds.

$$\text{Timer Clock} = \frac{12\,\text{MHz}}{32} = 375\,\text{kHz}$$
$$\text{Tick Period} = \frac{1}{375\,\text{kHz}} \approx 2.667\,\mu\text{s}$$
$$\text{Interrupt Period} = 12345 \times 2.667\,\mu\text{s} \approx \boxed{32.92}\,\text{ms}$$

### Q4.3

> Write a segment of code to be placed in the `while(1)` loop that would implement a **blocking** delay of approximately 5 s without using `__delay_cycles()` such that the message "`5 seconds`" is printed after each delay.

$$\text{Period} \approx \frac{12345}{12\,\text{MHz}/32} \approx 32.92\text{ ms}$$
$$\frac{5000\text{ ms}}{32.92\text{ ms}} \approx 152$$

```c
C = 0;
while(C < 152) {}
printf("5 seconds\n");
```

### Q4.4

> Write a segment of code to be placed in the `while(1)` loop that would implement a **non-blocking** delay of approximately 5 s without using `__delay_cycles()` such that the message "`5 seconds`" is printed after each delay and "`not blocked`" is printed continuously.

```c
printf("not blocked");
if (C >= 152) {
    printf("5 seconds");
    C = 0;
}
```
