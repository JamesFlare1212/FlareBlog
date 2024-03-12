---
title: CSCI 1100 - 作业2 - 字符串和函数
subtitle:
date: 2024-03-12T02:41:25-04:00
slug: csci-1100-hw-2
draft: false
author:
  name: James
  link: https://www.jamesflare.com
  email:
  avatar: /site-logo.avif
description: 本次家庭作业共分为三部分，重点是使用 Python 函数和字符串操作来设计口香糖机的大小，实现一个简单的替换密码，以及对句子进行基本的情感分析。
keywords: ["Python","函数","字符串操作","情感分析"]
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
  - CSCI
  - 编程语言
collections:
  - CSCI 1100
hiddenFromHomePage: false
hiddenFromSearch: false
hiddenFromRss: false
hiddenFromRelated: false
summary: 本次家庭作业共分为三部分，重点是使用 Python 函数和字符串操作来设计口香糖机的大小，实现一个简单的替换密码，以及对句子进行基本的情感分析。
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

# See details front matter: https://fixit.lruihao.cn/documentation/content-management/introduction/#front-matter
---

<!--more-->

## 概述

本次家庭作业总分100分，将计入你的总体家庭作业成绩，截止日期为2024年2月1日星期四晚上11:59:59。三个部分应分别提交。所有部分都必须在截止日期前提交，否则你的程序将被视为迟交。

**关于评分的注意事项**：请务必仔细阅读提交指南文档。它适用于本次和以后所有的家庭作业，并且将变得越来越重要。在家庭作业的所有部分中，我们会指定你必须提供哪些函数。即使这些函数非常简单，也请务必编写它们。否则，你将失去分数。随着学期的进展，我们将编写更复杂的函数。此外，在评分本次家庭作业时，我们还会检查程序结构（参见第4讲），以及变量和函数的命名。

在本次作业中的任何地方都不允许使用任何循环。

## 关于过度合作的严正警告

对于本学期的所有家庭作业，我们将使用软件来比较所有提交的程序，以发现不当的相似之处。该软件可以处理程序之间的各种差异，因此如果你 (a) 拿了别人的程序，修改了（或没有修改）并作为自己的程序提交，(b) 与一个或多个同学一起编写了一个程序，并分别提交修改后的版本作为自己的作品，或者 (c) 提交（可能经过轻微修改）以前某一年提交的软件作为你的软件，这个软件都会将这些提交标记为非常相似。

(a)、(b) 和 (c) 都超出了本课程可接受的范围——它们违反了学术诚信政策。此外，这种抄袭行为会阻碍你学习如何解决问题，从长远来看会对你不利。你编写自己的代码越多，学到的东西就越多。

请阅读合作政策文档，了解可接受的合作水平以及如何保护自己。该文档可以在 Submitty 的课程材料页面上找到。过度合作的处罚可高达：

- 家庭作业得0分，并且
- 学期成绩再额外降低5%。

受到处罚的学生也将被禁止退出该课程。更严重的违规行为，如盗用他人代码，将导致该课程自动得F。第二次被发现学术诚信违规的学生将自动得到F。

通过提交你的家庭作业，你断言你 (a) 理解学术诚信政策，并且 (b) 没有违反它。

最后请注意，制定这项政策是为了应对本课程中可能出现的小部分问题。遵循上述策略并在执行过程中运用常识的学生不会在学术诚信方面遇到任何麻烦。

## 第1部分：一分钱一个口香糖米奇（40分）

我们将进行一个销售口香糖的实验，但需要做一些假设。假设你从自动售货机出售口香糖。售货机是立方体形状，口香糖是球形。你每周检查一次售货机。目标是调整售货机的大小，使其在每周开始时完全装满，在你回来检查之前不会卖完口香糖，并且在一周结束时不会留下太多变质的口香糖。我们假设所有的口香糖都整齐地排列，因此沿立方体任何一个维度的口香糖数量就等于该维度的边长除以口香糖直径。例如，如果边长是9.0，口香糖的半径正好是0.5，那么每个维度正好可以容纳9个口香糖，整个售货机总共可容纳729个口香糖。这被称为立方晶格。

请完成以下任务：

1. 首先编写两个函数，`find_volume_sphere(radius)` 和 `find_volume_cube(side)`，分别用于计算给定半径的球体体积和给定边长的立方体体积。

2. 然后询问用户口香糖的半径和每周的销售量。

3. 计算售货机需要容纳的口香糖总数为每周销售量的1.25倍，并利用这个数据计算以口香糖个数为单位的售货机边长。提示：你知道口香糖的总数，在立方晶格中，每个维度可以容纳相同数量的口香糖，所以如果每个维度可以容纳 N 个口香糖，那么整个售货机可以容纳 N³ 个口香糖。数学模块的 `ceil` 函数总是向上取整，可能会有用。（我们不会切割口香糖来使它们适合售货机。）

4. 再计算几个值：考虑到你选择的尺寸，实际可以容纳多少个口香糖（记住，沿立方体的每个维度必须容纳整数个口香糖）；立方体的体积；每个口香糖的体积；如果我们放入需要容纳的口香糖数量和实际可以容纳的数量，浪费的空间大小。

5. 使用 `.2f` 格式打印这些值，所有浮点数保留2位小数。

在文件 `hw2 part1 output 01.txt` 和 `hw2 part1 output 02.txt`（需要从 Submitty 的课程材料部分下载 `hw02_files.zip` 文件，并将其解压缩到你的 HW 2 目录中）中提供了程序运行的两个示例（使用 Spyder IDE 运行时的样子）。

我们将测试你的代码是否符合上述值以及一系列不同的值。请充分测试你的代码，确保它能正常工作后，将其作为 `hw2 part1.py` 文件提交到 Submitty 作为家庭作业的第1部分。

## 第2部分：找到隐藏的信息（40分）

编写一个程序，判断对于给定的字符串，简单的替换密码是否可逆。该程序应使用 `input` 要求用户输入一个包含句子的字符串。然后，程序应将字符串加密成密文，再解密密文，并将解密结果与原始句子进行比较。如果解密后的密文与原始句子匹配，则该操作在该字符串上是可逆的。否则，它是不可逆的。

在此过程中，程序应打印出密文、密文与原始句子之间的长度差（始终打印为正数）、解密后的密文以及一条简短消息，说明该操作是否可逆。

在文件 `hw2 part2 output 01.txt` 和 `hw2 part2 output 02.txt`（可以在 `hw02_files.zip` 文件中找到）中提供了程序运行的两个示例（使用 Spyder IDE 运行时的样子）。

加密规则基于一组字符串替换，它们应该按照以下确切顺序应用：

| 原始 | 替换 | 注释 |
|:----:|:----:|:-----|
| ' a' | '%4%' | 将空格后的任何'a'替换为'%4%' |
| 'he' | '7!' | 将所有出现的'he'替换为'7!' |
| 'e' | '9(*9(' | 将任何剩余的'e'替换为'9(*9(' |
| 'y' | '*%' | 将所有出现的'y'替换为'*%' |
| 'u' | '@@@' | 将所有出现的'u'替换为'@@@' |
| 'an' | '-?' | 将所有出现的'an'替换为'-?' |
| 'th' | '!@+3' | 将所有出现的'th'替换为'!@+3' |
| 'o' | '7654' | 将所有出现的'o'替换为'7654' |
| '9' | '2' | 将所有出现的'9'替换为'2' |
| 'ck' | '%4' | 将所有出现的'ck'替换为'%4' |

例如，"methane"的密文是 `m2(*2(!@+3-?2(*2(`。以下是加密过程：

```python
>>> 'methane'.replace('e','9(*9(')
'm9(*9(than9(*9('
>>> 'm9(*9(than9(*9('.replace('an','-?')
'm9(*9(th-?9(*9('
>>> 'm9(*9(th-?9(*9('.replace('th','!@+3')
'm9(*9(!@+3-?9(*9('
>>> 'm9(*9(!@+3-?9(*9('.replace('9', '2')
'm2(*2(!@+3-?2(*2('
```

解密将按相反顺序使用这些规则。

你的程序必须使用两个函数：

- 编写一个函数 `encrypt(word)`，它接受一个普通英语字符串作为参数，并返回它的密文版本（也是字符串）。

- 编写第二个函数 `decrypt(word)`，它执行相反的操作：接受密文字符串并返回它的普通英语版本。

这两个函数在结构上会非常相似，但它们使用字符串替换规则的顺序不同。现在，你可以通过先加密一个字符串，然后再解密来测试你的函数是否正确。如果替换规则没有歧义，结果应该与原始字符串相同。

使用这些函数来实现上述程序。我们将测试你的代码是否符合上述值以及一系列不同的值。

请充分测试你的代码，确保它能正常工作后，将其作为 `hw2 part2.py` 文件提交到 Submitty 作为家庭作业的第2部分。

## 第3部分：你对家庭作业有何感想？（20分）

在本部分作业中，你将实现一个非常简单的情感分析工具。虽然真正的工具使用自然语言处理，但它们都使用类似于我们在这里使用的词频统计。理解消息中的情感是许多人工智能工具的关键部分。

编写一个程序，要求用户输入一个包含句子的字符串。然后，程序将使用下面描述的两个函数计算句子的快乐程度和悲伤程度。如果快乐程度高于悲伤程度，那么句子的语气是快乐的。如果悲伤程度更高，那么句子的语气是悲伤的。否则，它是中性的。首先打印一行情感分析结果，其中 + 号的数量等于快乐词的数量，- 号的数量等于悲伤词的数量，然后给出一个简单的分析结论，找出并打印句子的语气。

在文件 `hw2 part3 output 01.txt` 和 `hw2 part3 output 02.txt`（可以在 `hw02_files.zip` 文件中找到）中提供了程序运行的两个示例（使用 Spyder IDE 101 运行时的样子）。

为了实现这一点，你将编写一个名为 `number_happy(sentence)` 的函数，它返回给定字符串中称为句子的快乐词的数量。为此，统计以下6个词的出现次数：laugh、happiness、love、excellent、good、smile。下面是此函数的一个示例运行：

```python
>>> number_happy("I laughed and laughed at her excellent joke.")
3
```

这是因为快乐词的数量是3（laugh 出现了两次）。即使句子中有大小写词和句子开头及结尾有额外的空格，你的代码也应该能正常工作。

```python
>>> number_happy(" Happiness is the state of a student who started homework early. ")
1
```

接下来，编写第二个函数 `number_sad(sentence)`，它的工作方式相同，但统计句子中以下6个悲伤词的数量：bad、sad、terrible、horrible、problem、hate。

```python
>>> number_sad("Dr. Horrible's Sing-Along Blog is an excellent show.")
1
>>> number_sad("Alexander and the Terrible, Horrible, No Good, Very Bad Day")
3
```

当然，每个类别的词语远不止6个。在未来的课程中，我们将学习如何使用文件来读取词语并用列表来处理它们。

请充分测试你的代码，确保它能正常工作后，将其作为 `hw2 part3.py` 文件提交到 Submitty 作为家庭作业的第3部分。

## 支持文件

{{< link href="HW2.zip" content="HW2.zip" title="下载 HW2.zip" download="HW2.zip" card=true >}}

***

## 参考答案

### hw2_part1.py

```python
import math

#Functions

def find_volume_sphere(radius):
    """Calculates the volume of a sphere with a given radius"""
    return (4/3) * math.pi * radius**3

def find_volume_cube(side):
    """Calculates the volume of a cube with a given side length"""
    return side**3

#Input

radius = str(input("Enter the gum ball radius (in.) => ").strip())
print(radius)
weekly_sales = str(input("Enter the weekly sales => ").strip())
print(weekly_sales, "\n")

#Calculations

target_sales = math.ceil(float(weekly_sales) * 1.25)

edge_gumballs = math.ceil(target_sales**(1/3))
edge_length = edge_gumballs * float(radius)*2
edge_gumballs_max = edge_length / (float(radius)*2 + 0.0000000000000001)
#Aviod ZeroDivisionError by adding a small number to the radius

number_extra_gumballs = math.ceil(edge_gumballs_max**3 - target_sales)

volume_gumballs = find_volume_sphere(float(radius))
volume_cube = find_volume_cube(edge_length)
volume_wasted_target = volume_cube - volume_gumballs * target_sales
volume_wasted_full = volume_cube - volume_gumballs * (edge_gumballs_max) ** 3

#Print

print("The machine needs to hold", str(edge_gumballs), "gum balls along each edge.")
print("Total edge length is", "{:.2f}".format(edge_length), "inches.")
print("Target sales were", str(target_sales) + ", but the machine will hold", str(int(number_extra_gumballs)), "extra gum balls.")
print("Wasted space is", "{:.2f}".format(volume_wasted_target), "cubic inches with the target number of gum balls,")
print("or", "{:.2f}".format(volume_wasted_full), "cubic inches if you fill up the machine.")
```

### hw2_part2.py

```python
user_input = input("Enter a string to encode ==> ").strip()
print(user_input, "\n")

#Replacing
def encrypt(word):
    word = word.replace(" a", "%4%")
    word = word.replace("he", "7!")
    word = word.replace("e", "9(*9(")
    word = word.replace("y", "*%$")
    word = word.replace("u", "@@@")
    word = word.replace("an", "-?")
    word = word.replace("th", "!@+3")
    word = word.replace("o", "7654")
    word = word.replace("9", "2")
    word = word.replace("ck", "%4")
    return word

#Calculation

length_difference = abs(len(user_input) - len(encrypt(user_input)))

#Decoding

def decrypt(word):
    word = word.replace("%4", "ck")
    word = word.replace("2", "9")
    word = word.replace("7654", "o")
    word = word.replace("!@+3", "th")
    word = word.replace("-?", "an")
    word = word.replace("@@@", "u")
    word = word.replace("*%$", "y")
    word = word.replace("9(*9(", "e")
    word = word.replace("7!", "he")
    word = word.replace("%4%", " a")
    return word

#Printing

print("Encrypted as ==>", encrypt(user_input))
print("Difference in length ==>", str(length_difference))
print("Deciphered as ==>", decrypt(encrypt(user_input)))

if user_input == decrypt(encrypt(user_input)):
    print("Operation is reversible on the string.")
else:
    print("Operation is not reversible on the string.")
```

### hw2_part3.py

```python
def number_happy(sentence):
    happy_words = ["laugh", "happiness", "love", "excellent", "good", "smile"]
    sentence = sentence.lower()
    #sentence = sentence.strip()
    #sentence = sentence.split()
    count = 0
    for word in happy_words:
        count += sentence.count(word)
    return count

def number_sad(sentence):
    sad_words = ["bad", "sad", "terrible", "horrible", "problem", "hate"]
    sentence = sentence.lower()
    #sentence = sentence.strip()
    #sentence = sentence.split()
    count = 0
    for word in sad_words:
        count += sentence.count(word)
    return count

#Get user input

#sentence = "I laughed and laughed at her excellent joke."
sentence = input("Enter a sentence => ").strip()

#Print

#print(number_happy(sentence))
print(sentence)
print("Sentiment: " + ("+" * number_happy(sentence)) + ("-" * number_sad(sentence)))

if number_happy(sentence) > number_sad(sentence):
    print("This is a happy sentence.")
elif number_happy(sentence) == number_sad(sentence):
    print("This is a neutral sentence.")
else:
    print("This is a sad sentence.")
```