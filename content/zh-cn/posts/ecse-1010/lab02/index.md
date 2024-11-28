---
title: ECSE 1010 概念验证 - Omega Lab02
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
description: This blog post discusses a detailed lab assignment focusing on proving various electrical concepts using resistors, diodes, op-amps, and nodal analysis. The experiments aim to validate Ohm's Law, non-linear IV curves for LEDs, differential resistance in diode IV curves, nodal voltage solving with Kirchhoff’s Laws, the function of an op amp comparator, mathematical op amp functionality, and two-channel audio mixer transfer functions.
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
summary: This blog post discusses a detailed lab assignment focusing on proving various electrical concepts using resistors, diodes, op-amps, and nodal analysis. The experiments aim to validate Ohm's Law, non-linear IV curves for LEDs, differential resistance in diode IV curves, nodal voltage solving with Kirchhoff’s Laws, the function of an op amp comparator, mathematical op amp functionality, and two-channel audio mixer transfer functions.
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

## 0. 参考文档

<div style="width: 100%; max-width: 600px; margin: 0 auto; display: block;">
  <embed src="Lab02.pdf" type="application/pdf" width="100%" height="500px">
</div>

## 1. 证明不同阻值的两个电阻 IV 曲线斜率等于欧姆定律中的电阻值

### 构建模块

{{< image src="P1-1-a.avif" caption="P1-1-a" width=600px >}}

让我们选择两个电阻。第一个是：

{{< figure src="P1-1-b.avif" caption="P1-1-b" width=600px >}}

四色环代码：橙、橙、棕、金

$$
\begin{align*}
	33 \times (1\times10^1) = 330 \Omega \pm 5\%
\end{align*}
$$

检查一下：

{{< image src="P1-1-b-2.avif" caption="P1-1-b-2" width=600px >}}

第二个是：

{{< image src="P1-1-c.avif" caption="P1-1-c" width=600px >}}

四色环代码：棕、棕、红、金

$$
\begin{align*}
	11 \times (1\times10^2) = 1100 \Omega \pm 5\%
\end{align*}
$$

检查一下：

{{< image src="P1-1-c-2.avif" caption="P1-1-c-2" width=600px >}}

### 分析

我们知道 IV 曲线表示 y 轴为 I，x 轴为 V。因此它必须是线性函数，因为 IV 没有幂次。

使用线性函数的思想，我们可知斜率是 $\frac{\Delta X}{\Delta Y}$。回到我们的案例中，就变成了 $\frac{\Delta V}{\Delta I}$。另外我们知道欧姆定律，即 $\frac{V}{I} = R$。因此，斜率很可能是电阻 $R$。

如果我们取 $R_1 = 10 \Omega$，$R_2 = 100 \Omega$（如仿真设置）。我们应得到：

{{< image src="P1-2-a.avif" caption="P1-2-a" width=600px >}}

如果我们将它们一起绘制，则得到

{{< image src="P1-2-b.avif" caption="P1-2-b" width=600px >}}

这里是数据表：

|$I$  | $V = IR_1$  | $V = IR_2$  |
|:----|----------:|----------:|
| 0   | 0         | 0         |
| 0.2 | 2         | 20        |
| 0.4 | 4         | 40        |
| 0.6 | 6         | 60        |
| 0.8 | 8         | 80        |
| 1   | 10        | 100       |

### 模拟

{{< image src="P1-3-a.avif" caption="P1-3-a" width=600px >}}

### 测量

首先我们构建了一个这样的电路：

{{< image src="P1-4-a.avif" caption="P1-4-a" width=600px >}}

这是基于实验手册中的图示。

{{< image src="P1-4-a-2.avif" caption="P1-4-a-2" width=250px >}}

我们只改变了 $R1, R2$ 的值。另外，很难在面包板上插表。因此我们在前面交叉了 V+ 电路

{{< image src="P1-4-b.avif" caption="P1-4-b" width=600px >}}

这种方法不是理想的选择，但可以工作。

***

让我们开始吧：

对于 $V+ = 0.5V$，我们得到：

{{< image src="P1-4-c.avif" caption="P1-4-c" width=600px >}}

{{< image src="P1-4-c-2.avif" caption="P1-4-c-2" width=600px >}}

为了节省空间和工作量，我们不会展示每个结果。但这里是数据：

|$V+$|$V(R1)$|$V(R1)$|$I$|
|:---|:------|:------|:--|
|$0V$|$0V$|$0V$|$0mA$|
|$0.5V$|$0.142V$|$0.396V$|$0.3mA$|
|$1V$|$0.238V$|$0.724V$|$0.6mA$|
|$1.5V$|$0.358V$|$1.126V$|$1.0mA$|
|$2V$|$0.463V$|$1.492V$|$1.3mA$|
|$2.5V$|$0.572V$|$1.831V$|$1.6mA$|
|$3V$|$0.632V$|$1.994V$|$1.9mA$|

使用以下 MATLAB 代码：

```matlab
% 步骤 1：输入数据
V_plus = [0, 0.5, 1, 1.5, 2, 2.5, 3]; % V+ 值
V_R1 = [0, 0.142, 0.238, 0.358, 0.463, 0.572, 0.632]; % V(R1) 值
V_R2 = [0, 0.396, 0.724, 1.126, 1.492, 1.831, 1.994]; % V(R2) 值
I = [0, 0.3, 0.6, 1.0, 1.3, 1.6, 1.9] * 1e-3; % I 值（A，转换为 mA）

% 步骤 2：绘制数据
figure;

% 绘制电阻 R1 的曲线
subplot(2, 1, 1);
plot(V_R1, I, '-o');
xlabel('电压 V(R1) (V)');
ylabel('电流 I (A)');
title('电阻 R1: 电流与电压的关系图');
grid on;

% 绘制电阻 R2 的曲线
subplot(2, 1, 2);
plot(V_R2, I, '-o');
xlabel('电压 V(R2) (V)');
ylabel('电流 I (A)');
title('电阻 R2: 电流与电压的关系图');
grid on;
```

我们得到了 $R1$ 和 $R2$ 的曲线：

{{< image src="P1-4-d.svg" caption="P1-4-d" width=600px >}}

现在，让我们为两者创建拟合线。需要找到斜率（$R = V/I$）。为此，我们稍微修改了代码如下：

```matlab
% 步骤 1：输入数据
V_plus = [0, 0.5, 1, 1.5, 2, 2.5, 3]; % V+ 值
V_R1 = [0, 0.142, 0.238, 0.358, 0.463, 0.572, 0.632]; % V(R1) 值
V_R2 = [0, 0.396, 0.724, 1.126, 1.492, 1.831, 1.994]; % V(R2) 值
I = [0, 0.3, 0.6, 1.0, 1.3, 1.6, 1.9] * 1e-3; % I 值（A，转换为 mA）

% 步骤 2：拟合线性回归曲线
% 拟合电阻 R1 的曲线
p_R1 = polyfit(I, V_R1, 1);
slope_R1 = p_R1(1);
R_R1 = slope_R1; % 电阻 R1

% 拟合电阻 R2 的曲线
p_R2 = polyfit(I, V_R2, 1);
slope_R2 = p_R2(1);
R_R2 = slope_R2; % 电阻 R2

% 步骤 3：显示电阻值
fprintf('电阻 R1: %.3f ohms\n', R_R1);
fprintf('电阻 R2: %.3f ohms\n', R_R2);

% 步骤 4：绘制数据和拟合曲线
figure;

% 绘制电阻 R1 的曲线
subplot(2, 1, 1);
plot(V_R1, I, 'o');
hold on;
plot(polyval(p_R1, I), I, '-');
xlabel('电压 V(R1) (V)');
ylabel('电流 I (A)');
title('电阻 R1: 电流与电压的关系图（带线性拟合）');
legend('数据', '线性拟合');
grid on;

% 绘制电阻 R2 的曲线
subplot(2, 1, 2);
plot(V_R2, I, 'o');
hold on;
plot(polyval(p_R2, I), I, '-');
xlabel('电压 V(R2) (V)');
ylabel('电流 I (A)');
title('电阻 R2: 电流与电压的关系图（带线性拟合）');
legend('数据', '线性拟合');
grid on;
```

我们得到了结果：

```text
电阻 R1: 331.144 ohms
电阻 R2: 1069.374 ohms
```

以及曲线图：

{{< image src="P1-4-e.svg" caption="P1-4-e" width=600px >}}

检查这个结果，从万用表的读数来看

{{< image src="P1-4-d.avif" caption="P1-4-d" width=600px >}}

{{< image src="P1-4-d-2.avif" caption="P1-4-d-2" width=600px >}}

太好了！实际读数非常接近我们从 IV 测量数据和线性回归得出的电阻值。平均误差小于 1%。

### 讨论

我们在每次会话中进行了大量的讨论，而不是一次完成所有内容，这使得文档更加逻辑化并遵循流程。因此，我们将只总结未出现的内容。

首先，我们使用 LTSpecie 确定了两个电阻 $R_1 = 10\Omega$ 和 $R_2 = 100\Omega$ 的 IV 曲线（这只是为了证明我们的分析）。然后，我们构建了一个串联电路，并知道所有组件的电流相同。只要我们得到一些读数对，就可以绘制曲线图。结果与预期一致，误差小于 1%。

因此，我们证明了不同阻值的两个电阻 IV 曲线斜率等于欧姆定律中的电阻值。

## 2. 证明发光二极管的非线性 IV 曲线

### 构建模块

{{< image src="P3-1-a.avif" caption="P3-1-a" width=600px >}}

### 分析

为了绘制一个二极管的 IV 曲线，我们需要找到一些重要的数据。

- 正向电压（$V_F$）
- 反向击穿电压（$V_{BR}$）
- 反向漏电流（$I_S$）

根据 [QED123](https/www.onsemi.com/pdf/datasheet/qed123-d.pdf) 的数据表：

- $V_F = 1.7V$
- $I_F = 100 mA$
- $V_{BR} = 5V$
- $I_S = 10 \mu A$

我们将其绘制到标准二极管 IV 特性图中，得到

{{< image src="P2-2-a.avif" caption="P2-2-a" width=600px >}}

### 模拟

{{< image src="P3-3-a.avif" caption="P2-3-a" width=600px >}}

1N914 的开启电压约为 $0.7V$

### 测量

{{< image src="P3-4-a.avif" caption="P3-4-a" width=600px >}}

我们创建了一个三角波，如图所示：

{{< image src="P3-4-b.avif" caption="P3-4-b" width=600px >}}

幅度为 5V（10V 峰峰值），频率为 200 Hz，相位为 90 度。

然后我们使用通道 1 来测量电流

```js
C1/330*1000
```

{{< image src="P3-4-b-2.avif" caption="P3-4-b-2" width=600px >}}

以及 IV 曲线：

{{< image src="P3-4-b-3.avif" caption="P3-4-b-3" width=600px >}}

使用以下 MATLAB 代码，我们得到

```matlab
% 步骤 1：导入 CSV 文件
data = readmatrix('P2-4-c.csv');

% 步骤 2：提取列
voltage = data(:, 2); % 第二列为电压（V）
current = data(:, 1); % 第三列为电流（I）

% 步骤 3：绘制 I-V 曲线
figure;
plot(voltage, current, 'k-', 'LineWidth', 1.5);
xlabel('电压 (V)');
ylabel('电流 (I)');
title('IV 曲线');
grid on;
```

我们得到

{{< image src="P2-4-c-2.svg" caption="P2-4-c-2" width=600px >}}

### 讨论

我们的实验结果与数据表一致。考虑到数据表中：

- $V_F = 1.7V$
- $I_F = 100 mA$

我们得到的 $1.7V$ 对应于 $10mA$，这符合数据表曲线。

## 3. 显示/证明二极管 IV 曲线不同区域中的微分电阻变化

### 构建模块

{{< image src="P3-1-a.avif" caption="P3-1-a" width=600px >}}

### 分析

为了绘制一个二极管的 IV 曲线，我们需要找到一些重要的数据。

- 正向电压（$V_F$）
- 反向击穿电压（$V_{BR}$）
- 反向漏电流（$I_S$）

根据 [QED123](https/www.onsemi.com/pdf/datasheet/qed123-d.pdf) 的数据表：

- $V_F = 1.7V$
- $I_F = 100 mA$
- $V_{BR} = 5V$
- $I_S = 10 \mu A$

我们将其绘制到标准二极管 IV 特性图中，得到

{{< image src="P2-2-a.avif" caption="P2-2-a" width=600px >}}

### 模拟

{{< image src="P3-3-a.avif" caption="P3-3-a" width=600px >}}

1N914 的开启电压约为 $0.7V$

### 测量

{{< image src="P3-4-a.avif" caption="P3-4-a" width=600px >}}

我们创建了一个三角波，如图所示：

{{< image src="P3-4-b.avif" caption="P3-4-b" width=600px >}}

幅度为 5V（10V 峰峰值），频率为 200 Hz，相位为 90 度。

然后我们使用通道 1 来测量电流

```js
C1/330*1000
```

{{< image src="P3-4-b-2.avif" caption="P3-4-b-2" width=600px >}}

以及 IV 曲线：

{{< image src="P3-4-b-3.avif" caption="P3-4-b-3" width=600px >}}

使用以下 MATLAB 代码，我们得到

```matlab
% 步骤 1：导入 CSV 文件
data = readmatrix('P2-4-c.csv');

% 步骤 2：提取列
voltage = data(:, 2); % 第二列为电压（V）
current = data(:, 1); % 第三列为电流（I）

% 步骤 3：绘制 I-V 曲线
figure;
plot(voltage, current, 'k-', 'LineWidth', 1.5);
xlabel('电压 (V)');
ylabel('电流 (I)');
title('IV 曲线');
grid on;
```

我们得到

{{< image src="P2-4-c-2.svg" caption="P2-4-c-2" width=600px >}}

### 讨论

为了展示二极管 IV 曲线不同区域中的微分电阻变化，我们将代码稍微修改了一下以计算两个随机点的斜率。

```matlab
% 步骤 1：导入 CSV 文件
data = readmatrix('P2-4-c.csv');

% 步骤 2：提取列
voltage = data(:, 2); % 第二列为电压（V）
current = data(:, 1); % 第三列为电流（I）

% 步骤 3：选择两个随机点
num_points = length(current);
random_indices = randperm(num_points, 2); % 生成两个不同的随机索引

% 步骤 4：提取所选点的电压和电流值
V1 = voltage(random_indices(1));
V2 = voltage(random_indices(2));
I1 = current(random_indices(1));
I2 = current(random_indices(2));

% 步骤 5：计算斜率
slope1 = (V2 - V1) / (I2 - I1);
slope2 = (V1 - V2) / (I1 - I2); % 这与 slope1 相同，但反向计算

% 步骤 6：打印斜率
fprintf('在随机选择的点（I1 = %.4f, V1 = %.4f）和（I2 = %.4f, V2 = %.4f）之间的斜率为: %.4f\n', I1, V1, I2, V2, slope1);
fprintf('在随机选择的点（I2 = %.4f, V2 = %.4f）和（I1 = %.4f, V1 = %.4f）之间的斜率为: %.4f\n', I2, V2, I1, V1, slope2);
```

我们得到

> 在随机选择的点（I1 = 0.0097, V1 = 0.2959）和（I2 = 0.0036, V2 = -2.6254）之间的斜率为: 479.8789
>
> 在随机选择的点（I2 = 7.9784, V2 = 1.2568）和（I1 = 2.8170, V1 = 1.1975）之间的斜率为: 0.0115

可以看出它们非常不同。

## 4. 证明节点分析能确定电路中未知节点的电压

### 构建模块

{{< image src="P4-1-a.avif" caption="P4-1-a" width=600px >}}

### 分析

{{< image src="P4-2-a.avif" caption="P4-2-a" width=600px >}}

为了简化我们的生活，我将一些方程重写为 $\LaTeX$。

电阻中的电流：

$$
I_R = \frac{V_A - V_B}{R}
$$

节点 B 的基尔霍夫电流定律（KCL）：

$$
I_{R_1} + I_{R_2} + I_{R_3} = 0
$$

节点 C 的 KCL：

$$
I_{R_3} + I_{R_4} = 0
$$

用电压表示电流。从第一个方程：

$$
\frac{V_B - V_A}{R_1} + \frac{V_B}{R_2} + \frac{V_B - V_C}{R_3} = 0
$$

从第二个方程：

$$
\frac{V_C - V_B}{R_3} + \frac{V_C - V_D}{R_4} = 0
$$

代入已知值。给定 $V_A = 5$ 和 $V_D = 0$，方程变为：

$$
2.5V_B - V_C = 5 \\
2V_C - V_B = 0
$$

矩阵形式表示为：$\begin{bmatrix} 2.5 & -1 \\ -1 & 2 \end{bmatrix} \cdot \begin{bmatrix} V_B \\ V_C \end{bmatrix} = \begin{bmatrix} 5 \\ 0 \end{bmatrix}$

手动求解：

```matlab
% 定义矩阵 A 和向量 b
A = [2.5, -1; -1, 2];
b = [5; 0];

% 解线性方程组 A * x = b
x = A \ b;

% 显示结果
disp('解为：');
disp(x);
```

我们得到

```text
解为：
    2.5000
    1.2500
```

因此，$\begin{bmatrix} V_B \\ V_C \end{bmatrix} =$ $\begin{bmatrix}2.5 \\ 1.25 \end{bmatrix}$

### 模拟

{{< image src="P4-3-a.avif" caption="P4-3-a" width=600px >}}

### 测量

{{< image src="P4-4-a.avif" caption="P4-4-a" width=600px >}}

对于 $V_C$，我们得到：

{{< image src="P4-4-b-1.avif" caption="P4-4-b-1" width=600px >}}

对于 $V_B$，我们得到：

{{< image src="P4-4-b-2.avif" caption="P4-4-b-2" width=600px >}}

### 讨论

| 节点 | 分析 | 模拟 | 实验测量 | 差值 | 百分比误差 |
|:---:|:---:|:---:|:---:|:---:|:---:|
|$V_B$|$2.50V$|$2.50V$|$2.45V$|$5mV$|$2\%$|
|$V_C$|$1.25V$|$1.25V$|$1.22V$|$3mV$|$2.4\%$|

我们的分析与模拟一致。实验数据的误差小于 2.5%，这非常小。因此，我们证明了节点分析能确定电路中未知节点的电压。

## 5. 证明/演示使用节点分析设计电路的方法

### 构建模块

{{< image src="P5-3-a.avif" caption="P5-3-a" width=600px >}}

### 分析

{{< image src="P5-2-a.avif" caption="P5-2-a" width=600px >}}

为了简化我们的生活，我将一些方程重写为 $\LaTeX$。

给定值：

- $V_A = 3 \, \text{V}$
- $V_C = 0 \, \text{V}$
- $V_B$ 是未知的。

使用节点 B 的基尔霍夫电流定律（KCL）：

$$
\frac{V_B - V_A}{R_1} + \frac{V_B - V_C}{R_2} + \frac{V_B - V_C}{R_3} = 0
$$

代入给定值和电阻：

$$
\frac{V_B - 3}{1} + \frac{V_B - 0}{4} + \frac{V_B - 0}{4} = 0
$$

简化方程：

$$
(V_B - 3) + \frac{V_B}{4} + \frac{V_B}{4} = 0
$$

合并项：

$$
V_B - 3 + \frac{V_B}{2} = 0
$$

乘以 2 清除分数：

$$
2V_B - 6 + V_B = 0
$$

合并项：

$$
3V_B = 6
$$

解得 $V_B$：

$$
V_B = 2
$$

### 模拟

{{< image src="P5-3-a.avif" caption="P5-3-a" width=600px >}}

### 测量

{{< image src="P5-4-a-1.avif" caption="P5-4-a-1" width=600px >}}

对于 $V_B$，我们得到：

{{< image src="P5-4-a.avif" caption="P5-4-a" width=600px >}}

### 讨论

| 节点 | 分析 | 模拟 | 实验测量 | 差值 | 百分比误差 |
|:---:|:---:|:---:|:---:|:---:|:---:|
|$V_B$|$2V$|$2V$|$1.979V$|$21mV$|$1.1\%$|

我们的分析与模拟一致。实验数据的误差小于 1.2%，这非常小。因此，我们证明了节点分析能确定电路中未知节点的电压。

## 6. 证明运算放大器比较器的功能

### 构建模块

{{< image src="P6-1-a.avif" caption="P6-1-a" width=600px >}}

### 分析
一个非反相比较器的传递函数为：

$$
\begin{equation*}
V_{out}=\begin{cases}
          \text{如果} \; V_{in} < V_{ref}, V_{out} = -5V \\
		  \text{如果} \; V_{in} > V_{ref}, V_{out} = 5V \\
     \end{cases}
  \end{equation*}
$$

在我们的情况下，我们得到：

$$
\begin{equation*}
V_{out}=\begin{cases}
          \text{如果} \; V_{in} < 0V, V_{out} = -5V \\
		  \text{如果} \; V_{in} > 0V, V_{out} = 5V \\
     \end{cases}
  \end{equation*}
$$

我们的电源电压为 $5V$ 和 $-5V$，输入信号是幅度为 $1V$ 的正弦波，并且参考电压为 GND（即 $0V$）。

### 模拟

{{< image src="P6-3-b.avif" caption="P6-3-b" width=600px >}}

{{< image src="P6-3-a.avif" caption="P6-3-a" width=600px >}}

### 测量

{{< image src="P6-4-a-b.avif" caption="P6-4-a-b" width=600px >}}

{{< image src="P6-4-a.avif" caption="P6-4-a" width=600px >}}

### 讨论

将我们的模拟与实验结果进行比较，我们看到两者都是方波，并且具有相同的周期和类似的幅度。它们在 $5V$ 和 $-5V$ 之间波动，这是我们的电源电压。这合乎情理，因为电源电压是运算放大器比较器的输出。

这证明了运算放大器比较器的功能。

## 7. 证明数学运算放大器的功能

### 构建模块

{{< image src="P8-1-a.avif" caption="P8-1-a" width=600px >}}

### 分析

{{< image src="P8-2-a.avif" caption="P8-2-a" width=600px >}}

求和放大器电路的传递函数如下：

$$
V_{out} = - \frac{Rf}{R1} \cdot V1 - \frac{Rf}{R2} \cdot V2
$$

在我们的情况下，希望使用 $50K \Omega$ 的电位器作为电阻，以便根据需求进行调整。然后，我们得到：

$$
\begin{align*}
	V_{out} &= - \frac{\cancel{50K}}{\cancel{50K}} \cdot V1 - \frac{\cancel{\cancel{50K}}}{\cancel{50K}} \cdot V2 \\
	V_{out} &= - V1 - V2 \\
\end{align*}
$$

### 模拟

我们在模拟中使用了两个不同频率（$500 \; \text{Hz}$ 和 $1K \; \text{Hz}$）的正弦波。

{{< image src="P8-3-a.avif" caption="P8-3-a" width=600px >}}

{{< image src="P5-3-b.avif" caption="P5-3-b" width=600px >}}

### 测量

然后，我们搭建了电路。我们将示波器通道 1 连接到 $V_{out}$ 来检查是否正常工作。

{{< image src="P8-4-a-b.avif" caption="P8-4-a-b" width=600px >}}

我们的电源电压为 $V_s + = 5V$ 和 $V_s - = -5V$

{{< image src="P8-4-a.avif" caption="P8-4-a" width=600px >}}

我们使用信号发生器生成两个频率分别为 $500 \; \text{Hz}$ 和 $1K \; \text{Hz}$ 的正弦波。

{{< image src="P8-4-b.avif" caption="P8-4-b" width=600px >}}

并使用示波器通道 1+ 检查输出波形

{{< image src="P8-4-c.avif" caption="P8-4-c" width=600px >}}

### 讨论

如我们所见，输出波形的形状与我们的模拟完全相同。仿真和测量中的输出波形幅度约为 $1.75V$，周期也相同。

由于实验波形的所有特征都与模拟一致，我们知道运算放大器在不同电压范围内都能正常工作。

这证明了求和放大器的概念，即数学运算放大器的功能。

## 8. 证明双通道音频混音器传输函数的概念

### 构建模块

{{< image src="P8-1-a.avif" caption="P8-1-a" width=600px >}}

### 分析

{{< image src="P8-2-a.avif" caption="P8-2-a" width=600px >}}

求和放大器电路的传递函数如下：

$$
V_{out} = - \frac{Rf}{R1} \cdot V1 - \frac{Rf}{R2} \cdot V2
$$

在我们的情况下，希望使用 $50K \Omega$ 的电位器作为电阻，以便根据需求进行调整。然后，我们得到：

$$
\begin{align*}
	V_{out} &= - \frac{\cancel{50K}}{\cancel{50K}} \cdot V1 - \frac{\cancel{\cancel{50K}}}{\cancel{50K}} \cdot V2 \\
	V_{out} &= - V1 - V2 \\
\end{align*}
$$

### 模拟

我们在模拟中使用了两个不同频率（$500 \; \text{Hz}$ 和 $1K \; \text{Hz}$）的正弦波。

{{< image src="P8-3-a.avif" caption="P8-3-a" width=600px >}}

{{< image src="P5-3-b.avif" caption="P5-3-b" width=600px >}}

### 测量

然后，我们搭建了电路。我们将示波器通道 1 连接到 $V_{out}$ 来检查是否正常工作。

{{< image src="P8-4-a-b.avif" caption="P8-4-a-b" width=600px >}}

我们的电源电压为 $V_s + = 5V$ 和 $V_s - = -5V$

{{< image src="P8-4-a.avif" caption="P8-4-a" width=600px >}}

并使用信号发生器生成两个频率分别为 $500 \; \text{Hz}$ 和 $1K \; \text{Hz}$ 的正弦波。

{{< image src="P8-4-b.avif" caption="P8-4-b" width=600px >}}

并使用示波器通道 1+ 检查输出波形

{{< image src="P8-4-c.avif" caption="P8-4-c" width=600px >}}

### 讨论

如我们所见，输出波形的形状与我们的模拟完全相同。仿真和测量中的输出波形幅度约为 $1.75V$，周期也相同。

这证明了求和放大器的概念。
