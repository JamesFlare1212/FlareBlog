---
title: CSCI 1200 - 作业 2 - 设计一个简单的 Uber
subtitle:
date: 2025-01-22T09:28:20-05:00
lastmod: 2025-01-22T09:28:20-05:00
slug: csci-1200-hw-2
draft: false
author:
  name: James
  link: https://www.jamesflare.com
  email:
  avatar: /site-logo.avif
description: 
keywords: ["C++", "编程", "作业", "String", "Vector", "Class"]
license:
comment: true
weight: 0
tags:
  - CSCI 1200
  - 作业
  - RPI
  - C++
  - 编程
categories:
  - 编程语言
collections:
  - CSCI 1200
hiddenFromHomePage: false
hiddenFromSearch: false
hiddenFromRss: false
hiddenFromRelated: false
summary:
resources:
  - name: featured-image
    src: featured-image.jpg
  - name: featured-image-preview
    src: featured-image-preview.jpg
toc: true
math: false
lightgallery: true
password:
message:
repost:
  enable: false
  url:

# See details front matter: https://fixit.lruihao.cn/documentation/content-management/introduction/#front-matter
---

<!--more-->

## 作业要求

````markdown
# 作业 2 - 设计一个简单的 Uber

在这个作业中，你将开发一个名为 New York Ride 的简单拼车应用程序。请在开始编写代码前阅读整个说明文件。

## 学习目标

- 练习实现和使用 C++ 类。
- 练习使用字符串类（std::string）和向量容器（std::vector）。

## 规范

New York Ride 应用程序应该支持两种不同的角色：司机、乘客。乘客可以执行以下任务：

- 请求乘车
- 取消乘车请求 

司机可以执行一个任务：

- 取消乘车请求

*注意*: 一个像 Uber 或 Lyft 这样的商业拼车产品当然允许乘客和司机执行更多任务，但让我们诚实地说，Uber/Lyft 拥有成千上万的软件工程师，而你只有一个人，并且只有一周的时间来完成这个作业，因此我们简化了这些任务。

## 输入文件

像 Uber 和 Lyft 这样的公司会将所有司机和乘客的信息存储在数据库中，但数据库超出了本课程的范围。因此我们将仅使用两个简单的文本文件 [drivers.txt](drivers.txt) 和 [riders.txt](riders.txt) 来存储司机和乘客的信息。在这个作业中，你将再次读取这些文件作为程序的输入，并解析它们以检索司机和/或乘客信息，并将其存储在自己的数据结构中。在这个任务中，你必须使用 *std::vector* 来存储司机和乘客。建议使用一个 *std::vector* 实例来存储所有司机，另一个 *std::vector* 实例来存储所有乘客。

### 司机信息

[drivers.txt](drivers.txt) 文件的格式如下：

```console
Sandra Huang Female 25 853-977-5304 3.1 40.4269 -73.0753 Standard On_the_way_to_pickup Michael Richard 445-915-1645
Susan Li Female 51 997-217-1025 3.7 40.5863 -73.8684 Premium On_the_way_to_pickup Lucia Kenneth 829-477-7963
Mary Zhang Female 47 765-620-6297 4.5 40.6988 -73.3988 Economy On_the_way_to_pickup Amy Lee 545-639-2924
William David Male 37 324-571-7028 3.8 40.2445 -73.5073 Premium Available null null null
Christopher Javier Male 25 218-980-8846 4.5 40.5784 -73.5479 Economy During_the_trip Daniel Chen 820-327-7312
Dorothy Daniel Female 21 332-586-7858 4 40.6672 -73.2472 Premium During_the_trip Juan Carlos 204-752-4660
Mateo Andres Male 55 201-564-6348 3.8 40.8771 -73.6288 Standard During_the_trip Karen Michael 534-197-2988
Dorothy Liu Female 41 507-944-8147 4.5 40.4938 -73.9905 Economy On_the_way_to_pickup Amy Christopher 601-148-3144
Mateo Robert Male 49 592-397-3458 3.5 40.4106 -73.3736 Economy On_the_way_to_pickup William David 693-200-8952
Valentina Andres Female 40 299-602-1498 3.3 40.3159 -73.8891 Standard On_the_way_to_pickup Susan Edward 809-345-5043
```

以上是 [drivers.txt](drivers.txt) 文件的前 10 行。它有 13 个字段，用空格分隔。这 13 个字段分别是：

- 司机的名字
- 司机的姓氏
- 司机的性别
- 司机的年龄
- 司机的电话号码
- 司机的评分
- 司机当前的位置纬度
- 司机当前的位置经度
- 司机的车辆类型
- 司机当前的状态
- 乘客的名字（如果分配了乘车请求）
- 乘客的姓氏（如果分配了乘车请求）
- 乘客的电话号码（如果分配了乘车请求）

最后三个字段只有在乘车请求分配给该司机时才有意义。在这个作业中，我们假设司机一旦被分配到这个请求就会接受。

一个司机可以处于以下状态之一：

- 可用（等待请求）
- 前往接客地点（已接受请求）
- 在行程中

当司机处于可用状态时，这意味着这个司机没有被分配乘车请求，并且因此不与任何乘客关联。因此，该司机的最后三个字段将只是
```console
null null null
```

### 乘客信息

[riders.txt](riders.txt) 文件的格式如下：

```console
Isabella Richard Female 39 301-144-6533 3.2 Top_of_the_Rock 40.7593 -73.979 Gowanus 40.6733 -73.99 Economy Ready_to_request null null null
Juan James Male 47 717-480-4710 3.2 Forest_Hills 40.7196 -73.8448 Park_Slope 40.6728 -73.9778 Standard Driver_on_the_way Melissa Kim 435-773-6289
Deborah Thomas Female 45 501-380-7736 5 Park_Slope 40.6728 -73.9778 Flatiron_Building 40.7411 -73.9897 Economy Driver_on_the_way Paul Daniel 815-649-6492
Sofia Steven Female 28 780-650-6240 3 Bay_Ridge 40.635 -74.019 High_Line_Park 40.748 -74.0048 Premium During_the_trip Thomas Edward 557-939-8060
Anthony Thomas Male 58 302-206-4102 4.3 Prospect_Heights 40.6775 -73.9692 East_River_Park 40.7135 -73.9756 Economy During_the_trip Juan Timothy 471-264-9092
Lucia Andres Female 59 256-799-3283 3.1 Grand_Central_Terminal 40.7527 -73.9772 Central_Park_Zoo 40.7678 -73.9718 Economy Driver_on_the_way Camila Mark 939-309-5453
Melissa Christopher Female 28 392-390-8218 4.6 The_High_Line 40.748 -74.0048 The_Vessel 40.7536 -74.0023 Standard Driver_on_the_way Brian Luis 845-708-1986
William Timothy Male 46 808-688-3264 3.7 Broadway_Theater_District 40.7589 -73.9851 Coney_Island 40.5749 -73.9859 Economy Driver_on_the_way Brenda Christopher 886-285-9845
Linda Chen Female 60 320-807-7264 4.6 Bushwick 40.6944 -73.9213 Columbia_University 40.8075 -73.9642 Premium Ready_to_request null null null
Brenda Thomas Female 45 470-325-3275 3.2 Bay_Ridge 40.635 -74.019 High_Line_Park 40.748 -74.0048 Premium Driver_on_the_way John Javier 446-656-6614
```

以上是 [riders.txt](riders.txt) 文件的前 10 行。它有 17 个字段，用空格分隔。这 17 个字段分别是：

- 乘客的名字
- 乘客的姓氏
- 乘客的性别
- 乘客的年龄
- 乘客的电话号码
- 乘客的评分
- 接客地点名称（如果分配了乘车请求）
- 接客地点的位置纬度（如果分配了乘车请求）
- 接客地点的位置经度（如果分配了乘车请求）
- 目的地名称（如果分配了乘车请求）
- 目的地位置的纬度（如果分配了乘车请求）
- 目的地位置的经度（如果分配了乘车请求）
- 乘客偏好的车辆类型
- 乘客当前的状态
- 司机的名字（如果分配了乘车请求）
- 司机的姓氏（如果分配了乘车请求）
- 司机的电话号码（如果分配了乘车请求）

一个乘客可以处于以下状态之一：

- 准备请求乘车
- 司机正在前往接客地点（已接受请求）
- 在行程中

理想情况下，应该有四个状态，另一个状态是：已经发出请求但尚未被任何司机接受。然而，正如我们提到的，在这个作业中，假设当乘客发出请求时，它会被一个司机接受，因此我们可以排除这种状态。

当乘客处于准备请求乘车的状态时，这意味着没有司机现在被分配到该乘车请求，并且因此，该乘客的最后三个字段将只是

```console
null null null
```

## 支持的命令

你的程序只需要支持两个命令：

### 乘车请求

第一个命令允许乘客发送一个乘车请求。

```console
nyride.exe drivers.txt riders.txt output0.txt output1.txt output2.txt phoneNumber request
```

这里

- `drivers.txt` 是包含所有司机信息的输入文件。你的程序不应该改变这个文件。
- `riders.txt` 是包含所有乘客信息的输入文件。你的程序不应该改变这个文件。
- `output0.txt` 是你向乘客或司机打印消息的输出文件。
- `output1.txt` 是更新后的司机信息，因此该文件应该与 drivers.txt 格式相同。
- `output2.txt` 是更新后的乘客信息，因此该文件应该与 riders.txt 格式相同。
- `phoneNumber`。理想情况下这应该是与 riders.txt 中状态为 "Ready_to_request" 的一个乘客的电话号码对应的；但生活不总是理想的，并且你的程序如何处理各种电话号码情况将在本节中描述。
- `request` 表示这是一个乘车请求。

当运行此命令时，如果找到司机，则

1. 你应该在 output0.txt 文件中打印以下信息：
```console
Ride requested for rider Rebecca, looking for an Economy vehicle.
Pick Up Location: Williamsburg, Drop Off Location: Statue_of_Liberty.
We have found the closest driver Elena(4.7) for you.
Elena is now 7.9 miles away from you.
```
用乘客的名字替换 *Rebecca*，用乘客偏好的车辆类型替换 *Economy*，用接客地点名称替换 *Williamsburg*，用目的地名称替换 *Statue_of_Liberty*。用司机的名字替换 *Elena*，用司机的评分替换 *4.7*。用司机距离乘客的距离替换 *7.9*。

1.2 在 output1.txt 文件中打印更新后的 drivers.txt 版本。
1.3 在 output2.txt 文件中打印更新后的 riders.txt 版本。

2. 如果找不到司机，则你的程序应该在 output0.txt 文件中打印以下消息：
```console
Ride requested for rider Isabella, looking for a Luxury vehicle.
Pick Up Location: Williamsburg, Drop Off Location: Boerum_Hill.
Sorry we can not find a driver for you at this moment.
```

用乘客的名字替换 *Isabella*，用乘客偏好的车辆类型替换 *Luxury*，用接客地点名称替换 *Williamsburg*，用目的地名称替换 *Boerum_Hill*。

3. 如果从命令行提供的电话号码不符合 xxx-xxx-xxxx 格式，则你的程序应该在 output0.txt 文件中打印以下消息：
```console
Phone number is invalid.
```

4. 如果从命令行提供的电话号码与任何乘客的电话号码都不匹配，则你的程序应该在 output0.txt 文件中打印以下消息：
```console
Account does not exist.
```

5. 如果发出此请求的乘客处于 "Driver_on_the_way" 状态，则你的程序应该在 output0.txt 文件中打印以下消息：
```console
You have already requested a ride and your driver is on the way to the pickup location.
```

6. 如果发出此请求的乘客处于 "During_the_trip" 状态，则你的程序应该在 output0.txt 文件中打印以下消息：
```console
You can not request a ride at this moment as you are already on a trip.
```

### 取消请求

第二个命令允许乘客或司机取消请求。请记住，乘客和司机都有权取消请求。

```console
nyride.exe drivers.txt riders.txt output0.txt output1.txt output2.txt phoneNumber cancel
```

此命令与第一个命令的唯一区别是最后一个参数是 *cancel*，而在第一个命令中，最后一个参数是 *request*。

当乘客取消请求时，你应该只取消该请求；当司机取消请求时，你也应该取消该请求，但同时找到另一个最近的司机为这个乘客服务。

只有处于前往接客地点状态的司机或其司机正在前往接客地点的乘客才能取消请求。

当运行此第二个命令时，

1. 如果从命令行提供的电话号码与任何乘客的电话号码都不匹配，并且也不与任何司机的电话号码匹配，则你的程序应该在 output0.txt 文件中打印以下消息：
```console
Account does not exist.
```

2. 如果发出取消请求的是一个状态不是 "Driver_on_the_way" 的乘客，则你的程序应该在 output0.txt 文件中打印以下消息：
```console
You can only cancel a ride request if your driver is currently on the way to the pickup location.
```

3. 如果发出取消请求的是一个状态不是 "On_the_way_to_pickup" 的司机，则你的程序应该在 output0.txt 文件中打印以下消息：
```console
You can only cancel a ride request if you are currently on the way to the pickup location.
```

4. 如果发出取消请求的是一个处于 "Driver_on_the_way" 状态的乘客，则

4.1 在 output0.txt 文件中打印以下消息：
```console
Ride request for rider Brenda is now canceled by the rider.
```
4.2 在 output1.txt 文件中打印更新后的 drivers.txt 版本：司机的状态应从 "On_the_way_to_pickup" 更改为 "Available"，并且该司机的最后三个字段应重置为 null，这意味着这个司机现在不再与任何乘客关联。

4.3 在 output2.txt 文件中打印更新后的 riders.txt 版本：乘客的状态应从 "Driver_on_the_way" 更改为 "Ready_to_request"，并且该乘客的最后三个字段应重置为 null，这意味着没有司机现在与这个乘客关联。

5. 如果发出取消请求的是一个处于 "On_the_way_to_pickup" 状态的司机，则

5.1 在 output0.txt 文件中打印以下消息：
```console
Your driver Edward has canceled the ride request. We will now find a new driver for you.
Ride requested for rider Angela, looking for a Standard vehicle.
Pick Up Location: The_Met_Cloisters, Drop Off Location: Brooklyn_Navy_Yard.
We have found the closest driver Robert(3.2) for you.
Robert is now 2.1 miles away from you.
```

用司机的名字替换 *Edward*。用乘客的名字替换 *Angela*，用乘客偏好的车辆类型替换 *Standard*。用接客地点名称替换 *The_Met_Cloisters*，用目的地名称替换 *Brooklyn_Navy_Yard*。用新司机的名字替换 *Robert*。用新司机的评分替换 *3.2*。用新司机距离乘客的距离替换 *2.1*。

5.2 在 output1.txt 文件中打印更新后的 drivers.txt 版本：旧司机的状态应从 "On_the_way_to_pickup" 更改为 "Available"。应该分配一个新的司机，并且该新司机的状态也应相应地更新。同时，旧司机不再与这个乘客关联，而新的司机现在与这个乘客关联。

5.3 在 output2.txt 文件中打印更新后的 riders.txt 版本：乘客现在应该与新的司机关联。

## 基于 Haversine 公式的距离计算

在查找司机时，你必须始终找到最近的车辆类型匹配乘客偏好的司机。当找到最接近的司机后，你也需要打印该司机和乘客之间的距离。因此，你需要一种方法来计算两个坐标之间的距离，在这个任务中，我们将使用 Haversine 公式，并且使用 Haversine 公式的代码如下：

```cpp
// 使用 Haversine 公式计算两个坐标之间的距离
double calculateDistance(double lat1, double lon1, double lat2, double lon2) {
    const double radiusOfEarth = 6371.0; // 地球半径（单位：公里）

    // 将纬度和经度从度转换为弧度
    lat1 *= M_PI / 180.0;
    lon1 *= M_PI / 180.0;
    lat2 *= M_PI / 180.0;
    lon2 *= M_PI / 180.0;

    // Haversine 公式
    double dLat = lat2 - lat1;
    double dLon = lon2 - lon1;
    double a = sin(dLat / 2.0) * sin(dLat / 2.0) + cos(lat1) * cos(lat2) * sin(dLon / 2.0) * sin(dLon / 2.0);
    double c = 2.0 * atan2(sqrt(a), sqrt(1.0 - a));
    // 距离（单位：公里）
    double distanceKM = radiusOfEarth * c;
    // 将距离转换为英里
    double distanceMiles = distanceKM * 0.621371;

    return distanceMiles;
}
```

此函数接受四个参数，即两个地理位置的纬度和经度，并返回这两个位置之间的距离（单位：英里）。该函数调用了几个数学库函数，因此你需要包含 cmath 库：

```cpp
#include <cmath>
```

## 包含防护

如果你编写了多个类，在编译时可能会遇到奇怪的编译错误。这可能是由于包括你的类文件的问题，可以通过以下方式解决：对于名为 myclass.h 的头文件，在该头文件顶部添加这两行：

```cpp
#ifndef __MYCLASS_H
#define __MYCLASS_H
```

并在 .h 文件底部添加这一行：

```cpp
#endif
```

这种技术称为“包含防护”。包含防护确保编译器只会处理一次头文件，无论它被包括多少次。

## 常见问题

1. Q: 乘客请求的车辆类型是否是严格要求？还是只是一个偏好。如果一个乘客请求 Economy 车型但没有可用的 Economy 司机，而有其他车型的司机，我们应该输出找不到司机，还是匹配最近的不同车型司机？

A: 这是一个严格的要求。不要为乘客选择不同的车型。

2. Q: 输出的距离精度是多少？是保留一位小数吗？是否需要四舍五入或直接截断？

A: 与 Uber 相同。保留一位小数。直接截断即可。例如，如果距离是 11.4571 英里，则应输出为 11.4 英里，而不是 11.5 英里。

## 程序要求及提交细节

在这个作业中，你必须使用 vector 来存储所有司机，并使用 vector 来存储所有乘客。你不允许使用我们尚未学习的数据结构，特别是 std::list。你的程序应该涉及至少两个类的定义，每个类都有自己的 .h 和 .cpp 文件。

在设计和实现程序时，请采用良好的编程风格：将代码组织成函数，不要把所有的代码都放在 main 函数中！请务必阅读 [家庭作业政策](https://www.cs.rpi.edu/academics/courses/spring25/csci1200/homework_policies.php) 以完善你的解决方案。请务必创建新的测试用例来完全调试程序，并不要忘记注释代码！使用提供的模板 [README.txt](./README.txt) 文件来记录你想评分者阅读的笔记。
你必须独立完成这个作业，如在 [合作政策及学术诚信](https://www.cs.rpi.edu/academics/courses/spring25/csci1200/academic_integrity.php) 页面中所述。如果你与任何人讨论过问题或错误信息等，请在 README.txt 文件中列出他们的名字。

**截止日期**: 2025 年 1 月 23 日，星期四晚上 10 点。

## 打分标准

14 分

- README.txt 完成 (3 分)
  - 缺少姓名、合作者或小时数中的一个 (-1)
  - 缺少姓名、合作者或小时数中的两个以上 (-2)
  - 没有反思 (-1)
- 类声明及实现和编码风格（良好的类设计，拆分为 .h 和 .cpp 文件。超过一行的函数放在 .cpp 文件中。组织良好的类实现，并在适当位置添加注释。正确使用 const/const& 和类方法 const） (6 分)
  - 没有信用（显著不完整的实现） (-6)
  - 不成功声明或使用任何新类 (-6)
  - 只声明或使用一个类 (-5)
  - 几乎所有代码都在 main 函数中。建议为不同的任务创建单独的函数。 (-2)
  - 错误使用或遗漏 const 和引用 (-1)
  - 超过一行语句的函数体放在 .h 文件中（模板类可以例外） (-2)
  - 函数没有很好地文档化，或者注释不足 (在 .h 或 .cpp 文件中) (-1)
  - 缺乏间距、过多空白或不良缩进 (-1)
  - 不良文件组织：将多个类放在一个文件中（非常小的辅助类可以例外） (-1)
  - 变量名选择不当：非描述性名称（例如 'vec'，'str'，'var'），单字母变量名（除了单个循环计数器除外）等。 (-2)
  - 使用全局变量 (-1)
- 数据表示 (必须使用向量实现) (5 分)
  - 没有信用（显著不完整的实现）。 (-5)
  - 不使用 std::vector 存储司机或乘客 (-5)
  - 使用 std::list 或本课程中未涵盖的数据结构 (-5)
  - 成员变量是公开的。 (-2)
````

## 程序设计

由于这次作业比较复杂，我们在开始前最好好好构思一下怎么实现。这里我借用两种情况，也就是指令是“request”和“cancel”两种情况分别设计它们单独的流程，然后在主程序中使用这两部分。姑且把它们称作`handleRequest()`以及`handleCancel()`。

由于流程图比较大，我暂时把它转换成了图片。

{{< image src="csci-1200-hw-2-flowchart-zh_cn.svg" caption="Flow Chart" >}}

Mermaid 源码如下：

```text
flowchart TD
    subgraph "Main Program"
        A(["Start main()"]) --> B["读取命令行参数 'drivers.txt' 'riders.txt' 'output0.txt' 'output1.txt' 'output2.txt' 'phoneNumber' 'command'"]
        B --> C["loadDrivers(): 读取 'drivers.txt' 到 drivers"]
        C --> D["loadRiders(): 读取 'riders.txt' 到 riders"]
        D --> E{"command == 'request'?"}
        E -- Yes --> MR["调用 handleRequest()"]
        E -- No --> F{"command == 'cancel'?"}
        F -- Yes --> MC["调用 handleCancel()"]
        F -- No --> G["输出 'Invalid command.'"]
        MR --> H["输出处理结果到 'output0.txt'"]
        MC --> H
        G --> H
        H --> I["将更新后的 drivers 写到 'output1.txt'"]
        I --> J["将更新后的 riders 写到 'output2.txt'"]
        J --> K(["End main()"])
    end
    
    subgraph "handleRequest()"
        R1["检查 phoneNumber 格式 (xxx-xxx-xxxx)"] --> R2{"有效?"}
        R2 -- No --> R3["输出 'Phone number is invalid.'"]
        R2 -- Yes --> R4["在 riders 中查找匹配的 phoneNumber"]
        R4 --> R5{"找到 Rider?"}
        R5 -- No --> R6["输出 'Account does not exist.'"]
        R5 -- Yes --> R7{"Rider.state？"}
        R7 -- "Driver_on_the_way" --> R71["输出 'You have already requested a ride...'"]
        R7 -- "During_the_trip" --> R72["输出 'You can not request a ride...'"]
        R7 -- "Ready_to_request" --> R8["输出 'Ride requested...' 信息,<br/>在 drivers 中查找匹配车辆类型<br/>且状态为 'Available' 的最近司机"]
        R8 --> R9{"找到可用 Driver?"}
        R9 -- No --> R10["输出 'Sorry we can not find a driver...'"]
        R9 -- Yes --> R11["计算距离, 更新状态：<br/>Driver='On_the_way_to_pickup', Rider='Driver_on_the_way'<br/>输出 'We have found the closest driver...'"]
    end
    
    subgraph "handleCancel()"
        C1["在 riders 中查找 phoneNumber"] --> C2{"找到 Rider?"}
        C2 -- No --> C3["在 drivers 中查找 phoneNumber"]
        C3 --> C4{"找到 Driver?"}
        C4 -- No --> C5["输出 'Account does not exist.'"]
        C4 -- Yes --> C6{"Driver.state == 'On_the_way_to_pickup'?"}
        C6 -- No --> C7["输出 'You can only cancel...'"]
        C6 -- Yes --> C8["Driver 取消: 状态->'Available'<br/>清空 Rider 关联信息"]
        C8 --> C9["输出 'Your driver X has canceled...'"]
        C9 --> C10["将 Rider 状态临时重置为 'Ready_to_request'<br/>再自动为 Rider 找新司机 (类似 request )"]
        C10 --> C11{"找到新 Driver?"}
        C11 -- No --> C12["输出 'Sorry we can not find...'"]
        C11 -- Yes --> C13["更新新 Driver='On_the_way_to_pickup',<br/>Rider='Driver_on_the_way'<br/>输出 'We have found the closest driver...'"]

        C2 -- Yes --> C14{"Rider.state == 'Driver_on_the_way'?"}
        C14 -- No --> C15["输出 'You can only cancel...'"]
        C14 -- Yes --> C16["输出 'Ride request for rider X is now canceled...',<br/>Driver->'Available', Rider->'Ready_to_request'"]
    end
```

有了流程图我们就可以慢慢实现它们了。当然，不一定要真写`handleRequest()`和`handleCancel()`两个function。把它们的逻辑直接在`main()`中实现也是可以的，我这里只是为了思路清晰而已。
