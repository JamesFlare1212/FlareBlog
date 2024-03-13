---
title: CSCI 1100 - 作业 1 - 计算与字符串处理
subtitle:
date: 2024-03-12T02:12:11-04:00
slug: csci-1100-hw-1
draft: false
author:
  name: James
  link: https://www.jamesflare.com
  email:
  avatar: /site-logo.avif
description: 这篇博客详细介绍了一项 Python 编程作业，包括创建一个 Mad Libs 文字游戏，计算速度和配速，以及生成一个用户指定尺寸的带框文本框。
keywords: ["Python", "编程", "作业", "Mad Libs", "速度计算", "带框文本框"]
license:
comment: true
weight: 0
tags:
  - CSCI 1100
  - 作业
  - RPI
  - Python
  - 编程
categories:
  - 编程语言
collections:
  - CSCI 1100
hiddenFromHomePage: false
hiddenFromSearch: false
hiddenFromRss: false
hiddenFromRelated: false
summary: 这篇博客详细介绍了一项 Python 编程作业，包括创建一个 Mad Libs 文字游戏，计算速度和配速，以及生成一个用户指定尺寸的带框文本框。
resources:
  - name: featured-image
    src: featured-image.jpg
  - name: featured-image-preview
    src: featured-image-preview.jpg
toc: true
math: false
lightgallery: false
password:
message:
repost:
  enable: true
  url:

# 查看详细的 front matter 设置: https://fixit.lruihao.cn/documentation/content-management/introduction/#front-matter
---

<!--more-->

## 概述

本次作业总分为100分，将计入你的总作业成绩，截止日期为2023年9月14日 ( 星期四 ) 晚上11:59:59。三个部分需分别提交。所有部分必须在截止日期前提交，否则你的程序将被视为迟交。

在开始本次作业之前，请仔细阅读提交指南文档。它将详细说明我们的期望，并回答一些常见问题，包括你需要通过 Submitty 提交程序，以及 Submitty 将在2023年9月11日 ( 星期一 ) 之前开放。

请记住，你的输出格式必须与 `hw01_files.zip` 文件中的示例运行结果完全一致。这样做的目的是简化测试过程，同时教会你如何使用我们提供的工具进行精确编程。我们欣赏创造力，但不要体现在作业的输出格式上！

## 第1部分：Mad Libs 文字游戏 ( 40分 ) 

在这一部分，你将编写一个 Python 程序来构建下面的 Mad Libs 文字游戏：

```text
Good morning <proper name>!

  This will be a/an <adjective1> <noun1>! Are you <verb1> forward to it?
  You will <verb2> a lot of <noun2> and feel <emotion1> when you do.
  If you do not, you will <verb3> this <noun3>.
  
  This <season> was <adjective2>. Were you <emotion2> when <team_name> won
  the <noun4>?
  
  Have a/an <adjective3> day!
```

你需要使用 `input` 函数请求程序用户提供缺失的单词，即那些用 `< >` 括起来的单词。然后，你将获取所有用户指定的输入，并构建上面的 Mad Libs 文字游戏。确保你的输出看起来像上面的段落，只是缺失的信息被用户输入所填充。

文件 `hw1 part1 output.txt` 中提供了程序运行的示例 ( 你需要从 Submitty 的课程材料部分下载 `hw01_files.zip` 文件，并将其解压到你的作业1目录中 )。

我们提供了合理的输入示例，但 Mad Libs 的乐趣在于输入随机的词，看看结果有多搞笑。不妨试试看！

当然，你编写的程序只适用于我们上面提供的特定 Mad Libs 文本。一个更具挑战性的问题是，编写一个程序来读取任意的 Mad Libs 文本，弄清楚要问用户什么，询问用户并读取输入，最后生成完整的 Mad Libs。不过这需要我们学完整个学期的内容，你才能解决。

请充分测试你的代码，确保其正常工作后，将其作为 `hw1_part1.py` 文件提交到 Submitty，作为作业的第1部分。

## 第2部分：速度计算 ( 40分 ) 

许多运动类 App 会记录用户在步行、跑步、骑自行车或游泳时的时间和距离。有些用户想知道他们每英里的平均配速 ( 以分钟和秒为单位 )，而另一些人想知道他们每小时的平均速度 ( 以英里为单位 )。在很多情况下，我们还想知道特定距离的预计时间。例如，如果我用53分30秒跑了6.3英里，我的平均配速是每英里8分29秒，平均速度是每小时7.07英里，而跑2.7英里的预计时间是22分55秒。

在本次作业的第2部分，你需要编写一个程序，要求用户输入一次锻炼的时间 ( 分钟和秒 )、跑过的距离 ( 英里 ) 和目标距离 ( 英里 )，并计算平均配速和平均速度。

文件 `hw1 part2 output.txt` 中提供了程序运行的示例 ( 可以在 `hw01_files.zip` 文件中找到 )。

你可以假设分钟和秒都是整数，但跑过的距离和目标距离是浮点数。所有的分钟和秒必须保持整数形式，因此请使用整数除法和取模运算。例如：

```python  
>>> x = 29.52
>>> y = int(x)  
>>> print(y)
29
```

速度的输出应为浮点数，保留2位小数。另外请注意，我们的参考答案在输出计算结果之前会先输出一个空行。

我们将用示例中的值以及各种不同的值来测试你的代码。请充分测试你的代码，确保其正常工作后，将其作为 `hw1_part2.py` 文件提交到 Submitty，作为作业的第2部分。

## 第3部分：带框文本框 ( 20分 ) 

编写一个程序，要求用户输入一个作为边框的字符，以及文本框的高度和宽度，然后输出一个指定大小的文本框，并用指定的字符作为边框。此外，在文本框内水平垂直居中输出文本框的尺寸。如果无法完美垂直居中，尺寸文本应输出在靠上的位置，即上方留白行数比下方少一行。如果无法完美水平居中，尺寸文本的左侧空格应比右侧少一个。

你可以假设用户输入的值都是有效的：宽度是一个正整数 ( 7或更大 )，高度是一个正整数 ( 4或更大 )，边框字符是一个单个字符。

文件 `hw1 part3 output 01.txt` 和 `hw1 part3 output 02.txt` 中提供了程序运行的两个示例 ( 可以在 `hw01_files.zip` 文件中找到 )。

你需要先将文本框尺寸放入一个字符串中，然后利用字符串的长度来确定尺寸文本所在行的长度。如果你有编程经验，可能会想用循环来生成完整的边框，但 Python 提供的字符串操作功能 ( 第3课内容 ) 使得这没有必要。你不能在程序中使用任何 `if` 语句或循环。我们还没学过它们，而且本题并不需要，使用它们也不会让你的解决方案更优雅。

我们将用示例中的值以及各种不同的值来测试你的代码。请充分测试你的代码，确保其正常工作后，将其作为 `hw1_part3.py` 文件提交到 Submitty，作为作业的第3部分。

## 支持文件

{{< link href="HW1.zip" content="HW1.zip" title="下载 HW1.zip" download="HW1.zip" card=true >}}

***

## 参考答案

### hw1_part1.py

```python
#Prepare variables

proper_name = ""
adjective1 = ""
noun1 = ""
verb1 = ""
verb2 = ""
noun2 = ""
emotion1 = ""
verb3 = ""
noun3 = ""
season = ""
adjective2 = ""
emotion2 = ""
team_name = ""
noun4 = ""
adjective3 = ""

template= """
Good morning <proper name>!

  This will be a/an <adjective1> <noun1>! Are you <verb1> forward to it?
  You will <verb2> a lot of <noun2> and feel <emotion1> when you do.
  If you do not, you will <verb3> this <noun3>.
  
  This <season> was <adjective2>. Were you <emotion2> when <team_name> won
  the <noun4>?
  
  Have a/an <adjective3> day!"""
output = ""

#Get user's input

print("Let's play Mad Libs for Homework 1")
print("Type one word responses to the following:\n")

proper_name = input("proper_name ==> ").strip()
print(proper_name)
adjective1 = input("adjective ==> ").strip()
print(adjective1)
noun1 = input("noun ==> ").strip()
print(noun1)
verb1 = input("verb ==> ").strip()
print(verb1)
verb2 = input("verb ==> ").strip()
print(verb2)
noun2 = input("noun ==> ").strip()
print(noun2)
emotion1 = input("emotion ==> ").strip()
print(emotion1)
verb3 = input("verb ==> ").strip()
print(verb3)
noun3 = input("noun ==> ").strip()
print(noun3)
season = input("season ==> ").strip()
print(season)
adjective2 = input("adjective ==> ").strip()
print(adjective2)
emotion2 = input("emotion ==> ").strip()
print(emotion2)
team_name = input("team-name ==> ").strip()
print(team_name)
noun4 = input("noun ==> ").strip()
print(noun4)
adjective3 = input("adjective ==> ").strip()
print(adjective3)

#Construct the Mad Lib

output = template.replace("<proper name>", proper_name)
output = output.replace("<adjective1>", adjective1)
output = output.replace("<noun1>", noun1)
output = output.replace("<verb1>", verb1)
output = output.replace("<verb2>", verb2)
output = output.replace("<noun2>", noun2)
output = output.replace("<emotion1>", emotion1)
output = output.replace("<verb3>", verb3)
output = output.replace("<noun3>", noun3)
output = output.replace("<season>", season)
output = output.replace("<adjective2>", adjective2)
output = output.replace("<emotion2>", emotion2)
output = output.replace("<team_name>", team_name)
output = output.replace("<noun4>", noun4)
output = output.replace("<adjective3>", adjective3)

#Print the Mad Lib

print("\nHere is your Mad Lib...")
print(output, end="")
```

### hw1_part2.py

```python
#Perpare Variables

minutes = 00
seconds = 00
miles = 00.00
target_miles = 00.00

pace_seconds_per_mile = 00.00
pace_seconds = 00
pace_minutes = 00

speed_mph = 00.00

target_time_total_seconds = 00.00
target_time_seconds = 00
target_time_minutes = 00

#Get User Input

minutes = str(input("Minutes ==> "))
print(minutes)
seconds = str(input("Seconds ==> "))
print(seconds)
miles = str(input("Miles ==> "))
print(miles)
target_miles = str(input("Target Miles ==> "))
print(target_miles)

#Calculate Pace

pace_seconds_per_mile = (int(minutes) * 60 + int(seconds)) / float(miles)
pace_seconds = int(pace_seconds_per_mile % 60)
pace_minutes = int(pace_seconds_per_mile // 60)

#Calculate Speed

speed_mph = float(miles) / (int(minutes) / 60 + int(seconds) / 3600)

#Calculate Target Time

target_time_total_seconds = float(target_miles) * pace_seconds_per_mile
target_time_seconds = int(target_time_total_seconds % 60)
target_time_minutes = int(target_time_total_seconds // 60)

#Print Results

print("\nPace is " + str(pace_minutes) + " minutes and " + str(pace_seconds) + " seconds per mile.")
print("Speed is {0:.2f} miles per hour.".format(float(speed_mph)))
print("Time to run the target distance of {0:.2f} miles is {1} minutes and {2} seconds.".format(float(target_miles), int(target_time_minutes), int(target_time_seconds)), end="")
```

### hw1_part3.py

```python
#Prepare Variables
frame_character = ""
height = 0
width = 0
free_space = 0.0

#Get user input
frame_character = input("Enter frame character ==> ").strip()
print(frame_character)
height = int(input("Height of box ==> ").strip())
print(height)
width = int(input("Width of box ==> ").strip())
print(width, "\n")

#Calculate dimensions line
dimensions = str(width) + "x" + str(height)
free_space = width - 2 - len(dimensions)

#Calculate the left and right padding considering odd/even width
left_space = free_space // 2
right_space = free_space // 2 + (free_space % 2)

#Prepare rows
top_bottom_row = frame_character * width
empty_row = frame_character + " " * (width - 2) + frame_character
dimension_row = frame_character + " " * left_space + dimensions + " " * right_space + frame_character

#Calculate the number of rows before and after the dimensions row
before_rows = ((height - 2) // 2) - ((height - 1) % 2)
after_rows = height - 3 - before_rows

#Output box
print("Box:")
print(top_bottom_row)
print((empty_row + '\n') * before_rows, end="")
print(dimension_row)
print((empty_row + '\n') * after_rows, end="")
print(top_bottom_row)
```