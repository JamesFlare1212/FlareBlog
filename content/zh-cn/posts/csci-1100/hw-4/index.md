---
title: CSCI 1100 - 作业 4 - 循环和列表；密码和隔离
subtitle:
date: 2024-03-13T15:15:44-04:00
slug: csci-1100-hw-4
draft: false
author:
  name: James
  link: https://www.jamesflare.com
  email:
  avatar: /site-logo.avif
description: 本文概述了 CSCI 1100 计算机科学导论课程第四次作业的要求和指南。作业包括两部分内容：使用 Python 编程评估密码强度，以及分析 COVID-19 疫情期间各州的隔离情况。
keywords: ["CSCI 1100","计算机科学","Python","密码强度","COVID-19"]
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
summary: 本文概述了 CSCI 1100 计算机科学导论课程第四次作业的要求和指南。作业包括两部分内容：使用 Python 编程评估密码强度，以及分析 COVID-19 疫情期间各州的隔离情况。
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
  enable: true
  url:

# 查看详细的 front matter: https://fixit.lruihao.cn/documentation/content-management/introduction/#front-matter
---

<!--more-->

## 作业概述

本次作业总分为 100 分，将计入你的总作业成绩。截止日期为一周后，即 2024 年 2 月 22 日（星期四）晚上 11:59:59。和往常一样，作业包括自动评分、教师测试用例评分和助教评分三部分。作业分为两个部分，需分别提交。所有部分都必须在截止日期前提交，否则你的程序将被视为逾期。

关于评分标准和过度合作的讨论，请参阅提交指南和合作政策手册。这些规则将在本学期剩余时间内持续有效。

你需要使用我们在 `hw4_files.zip` 中提供的实用工具和数据文件，所以请务必从 Submitty 的课程资料部分下载该文件，并将其解压缩到你的作业 4 目录中。

`hw4_util.py` 模块旨在帮助你从文件中读取信息。你不需要了解 `hw4_util.py` 中提供的函数是如何实现的（但如果你感兴趣，可以随意查看代码），只需直接使用它们即可。

最后需要注意的是，你需要在本次作业中使用循环。我们将根据任务和你的个人偏好，让你自行选择使用 while 循环还是 for 循环。

## 第一部分：密码强度

创建密码时，通常会评估其强度。强度估计是通过应用几个规则来计算的，包括密码长度、特定类型字符的存在、与常见密码的匹配程度，甚至与车牌号的匹配程度。在作业的这一部分，你将实现一些简单的强度判断规则，然后确定密码是被拒绝，还是被评为差、一般、好或优秀。

你的程序应该先要求用户输入一个密码并读取它。然后根据以下规则评估密码强度。每个规则都会对一个数值分数（初始为 0）产生影响：

1. **长度**：如果密码长度为 6 或 7 个字符，则加 1 分；如果长度为 8、9 或 10 个字符，则加 2 分；如果长度超过 10 个字符，则加 3 分。
2. **大小写**：如果密码包含至少两个大写字母和两个小写字母，则加 2 分；如果至少包含一个大写字母和一个小写字母，则加 1 分。 
3. **数字**：如果密码包含至少两个数字，则加 2 分；如果至少包含一个数字，则加 1 分。
4. **标点符号**：如果密码包含至少一个 !@#$ 符号，则加 1 分；如果至少包含一个 %^&* 符号，则再加 1 分（总共最多加 2 分）。
5. **纽约车牌**：如果密码包含三个字母（大写或小写）后跟四个数字，则可能与纽约州车牌号格式匹配。在这种情况下，扣 2 分。
6. **常见密码**：如果密码的小写形式与常见密码列表中的某个密码完全匹配，则扣 3 分。

每当应用一条规则导致分数发生变化时，生成一行解释性输出。在应用所有规则后，输出最终得分，然后将其转换为密码的强度等级：

- **拒绝**：分数小于或等于 0。
- **差**：分数为 1 或 2。
- **一般**：分数为 3 或 4。
- **好**：分数为 5 或 6。
- **优秀**：分数为 7 或以上。

### 注意事项

1. 对于第一部分和第二部分，你应该编写函数以保持代码的整洁、清晰和易于管理。
2. 我们为你提供了许多示例，展示了输出值和格式。请仔细遵循这些示例。
3. 常见密码是从文件中提取的。我们提供的实用函数之一会读取该文件并返回这些密码的列表。要使用此函数，首先确保 `hw4_util.py` 和 `password_list_top_100.txt` 与你的代码在同一文件夹中。然后在你的程序中添加以下行：
	```python
	import hw4_util
	```
	最后，调用不带任何参数的函数 `hw4_util.part1_get_top()`。它将返回一个包含 100 个密码的字符串列表供你进行比较。
4. 只提交你的程序文件 `hw4_part1.py`。不要提交 `hw4_util.py`。

## 第二部分：COVID-19 隔离州

纽约州 COVID-19 旅行建议 [COVID-19 Travel Advisory](https://coronavirus.health.ny.gov/covid-19-travel-advisory) 要求从 COVID-19 社区传播严重的州来到纽约的个人必须自我隔离 14 天。一个州的"严重传播"是指：

- 在过去七天中，平均每天每 10 万居民中有超过 10 人检测呈阳性，或者
- 在过去七天中，平均每天超过 10% 的检测呈阳性。

我们将具有严重传播的州称为隔离州。在作业的这一部分中，你将使用从 [COVID Tracking Project](https://covidtracking.com/) 下载的各州数据来回答有关哪些州是隔离州以及何时是隔离州的查询。

我们获得的数据是在 2023 年 10 月 5 日以大型"逗号分隔值"文件的形式下载的。该文件每个州每天包含一行，每行有许多字段。我们已将其浓缩为适合 CS1 作业的形式。这些数据是根据知识共享 BY 4.0 许可证共享的，这意味着我们可以：

- 共享：以任何媒体或格式复制和重新分发材料，以及
- 改编：以任何目的重新混合、转换和构建材料，甚至是商业目的。

我们提供了一个简单的实用程序，让你可以访问浓缩后的数据。要使用它（与第一部分类似），你必须在与你自己的代码相同的文件夹中拥有 `hw4_util.py` 和 `prob2_data.csv` 文件。然后你必须在程序中导入 `hw4_util` 模块：

```python
import hw4_util
```

`hw4_util` 有一个名为 `part2_get_week` 的函数，它接受一个整数参数 `w`，并返回一个列表的列表。参数 `w` 是前几周的索引，其中 `w==1` 表示最近一周，`w==2` 表示前一周，以此类推，直到 `w==29`，对应于 29 周前，一直追溯到 3 月 15 日。返回的列表包含每个州一个子列表，加上哥伦比亚特区 (DC) 和波多黎各 (PR)，总共 52 个。每个州的子列表有 16 个元素：

- 元素 0 是一个字符串，表示两个字母（大写）的州缩写。这些缩写是正确的。
- 元素 1 是一个整数，表示该州的人口估计值，来自 2019 年人口普查局估计 [Census Bureau estimate](https://www.census.gov/newsroom/press-kits/2019/national-state-estimates.html)。
- 元素 2-8 是指定周的七天中每一天该州的阳性检测数，最近的日期在前。
- 元素 9-15 是指定周的七天中每一天该州的阴性检测数，最近的日期在前。

例如，第 1 周阿拉斯加州的子列表是：

```text
['AK',\
731545,\
189,147,128,132,106,125,118,\
3373,3819,6839,4984,6045,6140,1688]
```

以下是你在这个作业中需要完成的任务。你的程序应该在一个循环中，首先要求用户指定一个周的索引，如上所述。（你可以假设输入一个整数作为周数。）负数表示程序应该结束。对于非负数，如果该周的数据不可用，函数将返回一个空列表；在这种情况下，跳过循环体的其余部分。否则，在获得列表的列表后，程序应该回答关于该周的四个不同信息请求之一。回答请求首先由用户输入一个关键字。关键字包括 'daily'、'pct'、'quar'、'high'。对于每个请求，程序必须执行以下操作：

- **'daily'**：询问用户州缩写，然后输出该州在给定周内平均每日每 10 万人中的阳性病例数，精确到小数点后一位。
- **'pct'**：询问用户州缩写，然后输出该州在给定周内平均每日检测阳性百分比，精确到百分之一。
- **'quar'**：按两个字母缩写的字母顺序输出给定周的旅行隔离州的州缩写列表，如上所述。每行应有十个州缩写，使用你的缩写列表调用 `hw4_util.print_abbreviations` 函数以按要求打印输出。（注意：每周至少有一个隔离州。）
- **'high'**：输出在给定周内平均每日每 10 万人中阳性病例数最高的州的两个字母缩写，并输出这个平均数，精确到小数点后一位。

输入的关键字和州缩写可以使用大写或小写字母，程序仍然应该能够正确匹配。如果关键字不是这四个之一，或者由于州缩写输入错误而未找到对应的州，则输出一个简单的错误消息，并在当前循环迭代中不执行其他操作。

## 注意事项

1. 和往常一样，查看我们提供的示例输出并准确遵循它。
2. 所有报告的阳性和阴性检测结果数量至少为 0，但有些可能为 0。不过，你可以假设不会出现一周内所有日子的阴性检测数都为 0 的情况。
3. 通过对一周的阳性病例求和以及对一周的阴性病例求和来计算每日检测阳性的百分比。如果这些和分别为 P 和 N，则阳性百分比为 $P/(P+N) * 100$。这与一周内每日百分比的平均值不完全相同，但更容易计算。
4. 只提交你的程序文件 `hw4_part2.py`。不要提交 `hw4_util.py`。

## 支持文件

{{< link href="HW4.zip" content="HW4.zip" title="下载 HW4.zip" download="HW4.zip" card=true >}}

## 参考答案

### hw4_part1.py

```python
"""
This script is used to test password strength based on certain criteria.
Author: Jinshan Zhou
"""

import hw4_util

if __name__ == "__main__":
    # initialize variables
    strength = 0
    report = ""

    # Debugging

    #user_password = "AdmIn123%^%*(&"
    #user_password = "jaX1234"

    # get user input
    user_password = str(input("Enter a password => ").strip())

    # print the password for testing purposes
    print(user_password)

    # get the length of the password
    length = len(user_password)

    # check the length of the password and update strength and report accordingly
    if length <= 7 and length >= 6:
        strength += 1
        report += "Length: +1\n"
    elif length >= 8 and length <= 10:
        strength += 2
        report += "Length: +2\n"
    elif length > 10:
        strength += 3
        report += "Length: +3\n"

    # count the number of uppercase and lowercase letters in the password
    num_upper = sum(1 for c in user_password if c.isupper())
    num_lower = sum(1 for c in user_password if c.islower())

    # check the number of uppercase and lowercase letters and update strength and report accordingly
    if num_upper >= 2 and num_lower >= 2:
        strength += 2
        report += "Cases: +2\n"
    elif num_upper >= 1 and num_lower >= 1:
        strength += 1
        report += "Cases: +1\n"

    # count the number of digits in the password
    num_digits = sum(1 for c in user_password if c.isdigit())

    # check the number of digits and update strength and report accordingly
    if num_digits >= 2:
        strength += 2
        report += "Digits: +2\n"
    elif num_digits >= 1:
        strength += 1
        report += "Digits: +1\n"

    # check for special characters and update strength and report accordingly
    if any(c in "!@#$" for c in user_password):
        strength += 1
        report += "!@#$: +1\n"
    if any(c in "%^&*" for c in user_password):
        strength += 1
        report += "%^&*: +1\n"

    # check for a specific pattern and update strength and report accordingly
    if (num_upper + num_lower) == 3 and num_digits == 4 and len(user_password) > 3:
        check = user_password.replace(user_password[0:3], "")
        if sum(1 for c in check if c.isdigit()) == 4:
            strength -= 2
            report += "License: -2\n"

    # check if the password is in the top 10,000 most common passwords and update strength and report accordingly
    if user_password.lower() in hw4_util.part1_get_top():
        strength -= 3
        report += "Common: -3\n"

    # add the combined score to the report
    report += "Combined score: " + str(strength) + "\n"

    # check the strength and add the appropriate message to the report
    if strength <= 0:
        report += "Password is rejected"
    elif strength >= 1 and strength <= 2:
        report += "Password is poor"
    elif strength >= 3 and strength <= 4:
        report += "Password is fair"
    elif strength >= 5 and strength <= 6:
        report += "Password is good"
    elif strength >= 7:
        report += "Password is excellent"

    # print the report
    print(report)
```

### hw4_part2.py

```python
import hw4_util

"""
hw4_util.part2_get_week(1)[0] ==> ['AK',\
    731545, 189, 147, 128, 132, 106, 125,\
    118, 3373, 3819, 6839, 4984, 6045,\
    6140, 1688]
"""

def find_state(states, state):
    state = state.upper()
    found_status = False
    for i in states:
        if i[0].upper() == state:
            found_status = True
            return i
    if not found_status:
        return []

def get_postive_per_100k(status):
    population = status[1]
    total_postive = 0
    for i in range (2, 9):
        total_postive += status[i]
    postive_per_100k = ((total_postive / 7) / population) * 100000
    return postive_per_100k
    
def get_pct_postive_tests(status):
    num_tested = 0
    num_postive = 0
    for i in range (2, 16):
        num_tested += status[i]
    for i in range (2, 9):
        num_postive += status[i]
    pct_postive_tests = num_postive / num_tested
    return pct_postive_tests

def action_valid(request_code):
    request_code = request_code.lower()
    allowed_action = ["daily", "pct", "quar", "high"]
    if request_code in allowed_action:
        return True
    else:
        return False

def quar(week):
    states = []
    for i in week:
        if get_postive_per_100k(i) >= 10 or get_pct_postive_tests(i) >= 0.1:
            states.append(i[0])
    states.sort()
    return states

def high(week):
    highest = ""
    highest_value = 0
    for i in week:
        if get_postive_per_100k(i) > highest_value:
            highest = i[0]
            highest_value = get_postive_per_100k(i)
    return highest.upper()

def show_high(week):
    highest = high(week)
    highest_postive_per_100k = get_postive_per_100k(find_state(week, highest))
    print("State with highest infection rate is", highest)
    print("Rate is {:.1f} per 100,000 people".format(highest_postive_per_100k))


if __name__ == "__main__":
    index_week = 0 # Initialize index_week
    print("...")
    
    while index_week != -1:
        # Get index of week
        index_week = input("Please enter the index for a week: ").strip()
        print(index_week)
        index_week = int(index_week)
        
        # Stop if the index is -1
        if index_week < 0:
            break
        
        # Get the week, check if the week is valid
        week = hw4_util.part2_get_week(index_week).copy()
        if week == []:
            print("No data for that week")
            print("...")
            continue
        
        # Get the Action
        request_code = input("Request (daily, pct, quar, high): ").strip()
        print(request_code)
        request_code = request_code.lower()
        
        # Check if the action is valid
        if not action_valid(request_code):
            print("Unrecognized request")
            print("...")
            continue
        
        # Perform the action
        if request_code == "daily":
            state = input("Enter the state: ").strip()
            print(state)
            state = state.upper()
            if find_state(week,state) == []:
                print("State {} not found".format(state))
                print("...")
            else:
                state_data = find_state(week,state)
                print("Average daily positives per 100K population: {:.1f}".format(get_postive_per_100k(state_data)))
                print("...")
        elif request_code == "pct":
            state = input("Enter the state: ").strip()
            print(state)
            state = state.upper()
            if find_state(week,state) == []:
                print("State {} not found".format(state))
                print("...")
            else:
                state_data = find_state(week,state)
                print("Average daily positive percent: {:.1f}".format(get_pct_postive_tests(state_data)*100))
                print("...")
        elif request_code == "quar":
            print("Quarantine states:")
            hw4_util.print_abbreviations(quar(week))
            print("...")
        elif request_code == "high":
            show_high(week)
            print("...")
```