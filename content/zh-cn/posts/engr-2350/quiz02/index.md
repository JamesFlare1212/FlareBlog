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
description: 这篇帖子展示了2025年春季ENGR 2350课程的Quiz 2。它包含问题、答案及解释。
keywords: ["C语言","编程","RPI","ENGR 2350","Quiz"]
license:
comment: true
weight: 0
tags:
  - C语言
  - 编程
  - RPI
  - ENGR 2350
  - Quiz
categories:
  - 编程语言
  - Electrical Engineering
collections:
  - ENGR 2350
hiddenFromHomePage: false
hiddenFromSearch: false
hiddenFromRss: false
hiddenFromRelated: false
summary: 这篇帖子展示了2025年春季ENGR 2350课程的Quiz 2。它包含问题、答案及解释。
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

#### Q1 定时器计算

> 对于一个工作在 **12 MHz** 系统时钟下并且处于“向上模式”的 Timer\_A 模块...

##### Q1.1

> 要让定时器的溢出周期为 **8 ms**，需要设置其周期（以计数值表示）为多少？假设定时器的时钟分频器设置为 **32**。

$$\text{Timer clock} = \frac{12\,\text{MHz}}{32} = 375000 \text{ Hz} \quad (375 \text{ kHz})$$
$$N = 375000 \times 0.008 \text{ s} = \boxed{3000} \text{ ticks}$$

##### Q1.2

> 要使定时器仍能产生相同的溢出周期，最小的分频器应该是多少？假设定时器的周期（以计数值表示）可以调整。

如果我们想要最小的分频器设置为 1，则可以满足要求。因此，最小的分频器设置为 $\boxed{1}$

#### Q2 基本 GPIO

> 请回答以下关于 GPIO 功能和使用的问题，并考虑提供的电路图。
>
> {{< image src="q2-gpio.avif" width="480px" caption="Q2 Basic GPIO Pin Out" >}}

##### Q2.2

> 使用 **DriverLib** 初始化电路图中的 GPIO 引脚。不要修改端口的其他引脚。

```c
GPIO_setAsInputPin(GPIO_PORT_P6, GPIO_PIN1 | GPIO_PIN6);
GPIO_setAsOutputPin(GPIO_PORT_P6, GPIO_PIN4);
```

##### Q2.3

> 使用 **寄存器** 或 **DriverLib**，当 PB1 被按下且 PB2 未被按下时，点亮 LED1；否则关闭 LED。

```c
PB1 = GPIO_getInputPinValue(GPIO_PORT_P6, GPIO_PIN1);
PB2 = GPIO_getInputPinValue(GPIO_PORT_P6, GPIO_PIN6);

if (!PB1 && !PB2){ 
    GPIO_setOutputHighOnPin(GPIO_PORT_P3, GPIO_PIN6);
} else { 
    GPIO_setOutputLowOnPIN(GPIO_PORT_P3, GPIO_PIN6);
}
```

#### Q3

> 将流程图转换为等效的代码段。
>
> ```mermaid
>  flowchart LR
>     A([Start]) --> B{Are a and b<br/>both zero?}
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

#### Q4 定时器/中断代码

> 给定下面的完整程序，并且知道 SMCLK 是 **12 MHz**，回答以下问题。
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

##### Q4.1

> 在给定的代码中，哪个函数会被作为 **中断服务例程** 调用？给出函数名。

```c
IncC()
```

因为 `Timer_A_registerInterrupt(timer, TIMER_A_CCRX_AND_OVERFLOW_INTERRUPT, IncC);` 这一行将 `IncC()` 设置为定时器中断的 ISR。

##### Q4.2

> 这个函数被硬件触发的频率是多少？请给出答案并用毫秒为单位。

$$\text{Timer Clock} = \frac{12\,\text{MHz}}{32} = 375\,\text{kHz}$$
$$\text{Tick Period} = \frac{1}{375\,\text{kHz}} \approx 2.667\,\mu\text{s}$$
$$\text{Interrupt Period} = 12345 \times 2.667\,\mu\text{s} \approx \boxed{32.92}\,\text{ms}$$

##### Q4.3

> 编写一段代码，放在 `while(1)` 循环中，实现一个 **阻塞** 的延迟，大约为 5 秒钟，并且不使用 `__delay_cycles()`，使得每次延迟后打印出消息 "`5 seconds`"。

$$\text{Period} \approx \frac{12345}{12\,\text{MHz}/32} \approx 32.92\text{ ms}$$
$$\frac{5000\text{ ms}}{32.92\text{ ms}} \approx 152$$

```c
C = 0;
while(C < 152) {}
printf("5 seconds\n");
```

##### Q4.4

> 编写一段代码，放在 `while(1)` 循环中，实现一个 **非阻塞** 的延迟，大约为 5 秒钟，并且不使用 `__delay_cycles()`，使得每次延迟后打印出消息 "`5 seconds`" 并且连续打印出 "`not blocked`"。

```c
printf("not blocked");
if (C >= 152) {
    printf("5 seconds");
    C = 0;
}
```
