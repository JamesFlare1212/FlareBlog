---
title: CSCI 1100 - 作业 6 - 文件、集合和文档分析
subtitle:
date: 2024-04-13T15:36:47-04:00
slug: csci-1100-hw-6
draft: false
author:
  name: James
  link: https://www.jamesflare.com
  email:
  avatar: /site-logo.avif
description: 这篇博文介绍了一个 Python 编程作业，使用自然语言处理技术分析和比较文本文档，例如计算单词长度、不同单词比率以及单词集和对之间的 Jaccard 相似度。
keywords: ["Python", "自然语言处理", "文本分析", "文档比较"]
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
summary: 这篇博文介绍了一个 Python 编程作业，使用自然语言处理技术分析和比较文本文档，例如计算单词长度、不同单词比率以及单词集和对之间的 Jaccard 相似度。
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

## 概述

这个作业在你的总作业成绩中占 100 分。截止日期为 2024 年 3 月 21 日星期四晚上 11:59:59。像往常一样，会有自动评分分数、教师测试用例分数和助教评分分数的混合。这个作业只有一个"部分"。

请参阅提交指南和协作政策手册，了解关于评分和过度协作的讨论。这些规则将在本学期剩余时间内生效。

你将需要我们在 `hw6_files.zip` 中提供的数据文件，所以请务必从 Submitty 的课程材料部分下载此文件，并将其解压缩到你的 HW 6 目录中。该 zip 文件包含数据文件以及程序的示例输入/输出。

## 问题介绍

有许多软件系统可以分析书面文本的风格和复杂程度，甚至可以判断两个文档是否由同一个人撰写。这些系统根据词汇使用的复杂程度、常用词以及紧密出现在一起的词来分析文档。在这个作业中，你将编写一个 Python 程序，读取包含两个不同文档文本的两个文件，分析每个文档，并比较这些文档。我们使用的方法是在自然语言处理 (NLP) 领域实际使用的更复杂方法的简化版本。

## 文件和参数

你的程序必须使用三个文件和一个整数参数。

第一个文件的名称对于你程序的每次运行都将是 `stop.txt`，所以你不需要询问用户。该文件包含我们将称为"停用词"的内容——应该忽略的词。你必须确保 `stop.txt` 文件与你的 `hw6_sol.py` Python 文件在同一文件夹中。我们将提供一个示例，但可能在测试你的代码时使用其他示例。

你必须请求要分析和比较的两个文档的名称以及一个整数"最大分隔"参数，这里将称为 `max_sep`。请求应如下所示：

```text
Enter the first file to analyze and compare ==> doc1.txt
doc1.txt
Enter the second file to analyze and compare ==> doc2.txt 
doc2.txt
Enter the maximum separation between words in a pair ==> 2
2
```

## 解析

这个作业的解析工作是将文本文件分解为一个连续单词的列表。为此，应首先将文件的内容拆分为字符串列表，其中每个字符串包含连续的非空白字符。然后，每个字符串应删除所有非字母并将所有字母转换为小写。例如，如果文件的内容（例如 `doc1.txt`）被读取以形成字符串（注意行尾和制表符）

```python
s = " 01-34 can't 42weather67 puPPy, \r \t and123\n Ch73%allenge 10ho32use,.\n"
```

然后拆分应产生字符串列表

```python
['01-34', "can't", '42weather67', 'puPPy,', 'and123', 'Ch73%allenge', '10ho32use,.']
```

并且这应该被拆分为（非空）字符串列表

```python
['cant', 'weather', 'puppy', 'and', 'challenge', 'house']
```

请注意，第一个字符串 `'01-34'` 被完全删除，因为它没有字母。所有三个文件——`stop.txt` 和上面称为 `doc1.txt` 和 `doc2.txt` 的两个文档文件——都应以这种方式解析。

完成此解析后，解析 `stop.txt` 文件产生的列表应转换为集合。此集合包含在 NLP 中被称为"停用词"的内容——出现频率如此之高以至于应该忽略的词。

`doc1.txt` 和 `doc2.txt` 文件包含要比较的两个文档的文本。对于每个文件，从解析返回的列表应通过删除任何停用词来进一步修改。继续我们的示例，如果 `'cant'` 和 `'and'` 是停用词，那么单词列表应减少为

```python
['weather', 'puppy', 'challenge', 'house']
```

像"and"这样的词几乎总是在停用词列表中，而"cant"（实际上是缩写"can't"）在某些列表中。请注意，从 `doc1.txt` 和 `doc2.txt` 构建的单词列表应保留为列表，因为单词顺序很重要。

### 分析每个文档的单词列表
一旦你生成了删除停用词的单词列表，你就可以分析单词列表了。有很多方法可以做到这一点，但以下是此作业所需的方法：

1. 计算并输出平均单词长度，精确到小数点后两位。这里的想法是单词长度是复杂程度的粗略指标。

2. 计算并输出不同单词数与总单词数之比，精确到小数点后三位。这是衡量所使用语言多样性的一种方法（尽管必须记住，一些作者重复使用单词和短语以加强他们的信息。）

3. 对于从 1 开始的每个单词长度，找到具有该长度的单词集。打印长度、具有该长度的不同单词数以及最多六个这些单词。如果对于某个长度，有六个或更少的单词，则打印所有六个，但如果有超过六个，则按字母顺序打印前三个和后三个。例如，假设我们上面的简单文本示例扩展为列表

    ```python
    ['weather', 'puppy', 'challenge', 'house', 'whistle', 'nation', 'vest',
    'safety', 'house', 'puppy', 'card', 'weather', 'card', 'bike',
    'equality', 'justice', 'pride', 'orange', 'track', 'truck', 
    'basket', 'bakery', 'apples', 'bike', 'truck', 'horse', 'house',
    'scratch', 'matter', 'trash']
    ```

    那么输出应该是

    ```text
    1: 0:
    2: 0:  
    3: 0:
    4: 3: bike card vest
    5: 7: horse house pride ... track trash truck 
    6: 7: apples bakery basket ... nation orange safety
    7: 4: justice scratch weather whistle
    8: 1: equality
    9: 1: challenge
    ```

4. 找到此文档的不同单词对。单词对是文档列表中相隔 `max_sep` 个或更少位置出现的两个单词的二元组。例如，如果用户输入导致 `max_sep == 2`，那么生成的前六个单词对将是：

    ```python
    ('puppy', 'weather'), ('challenge', 'weather'), 
    ('challenge', 'puppy'), ('house', 'puppy'),
    ('challenge', 'house'), ('challenge', 'whistle')
    ```

    你的程序应输出不同单词对的总数。（请注意，`('puppy', 'weather')` 和 `('weather', 'puppy')` 应视为相同的单词对。）它还应按字母顺序输出前 5 个单词对（而不是它们形成的顺序，上面写的就是这样）和最后 5 个单词对。你可以假设，无需检查，有足够的单词来生成这些对。以下是上面较长示例的输出（假设读取它们的文件名为 `ex2.txt`）：

    ```text
    Word pairs for document ex2.txt
    54 distinct pairs
    apples bakery
    apples basket
    apples bike
    apples truck 
    bakery basket
    ...
    puppy weather
    safety vest
    scratch trash
    track truck
    vest whistle
    ```

5. 最后，作为单词对的独特性的度量，计算并输出不同单词对的数量与单词对总数之比，精确到小数点后三位。

#### 比较文档
最后一步是比较文档的复杂性和相似性。有许多可能的度量方法，所以我们将只实现其中的一些。

在我们这样做之前，我们需要定义两个集合之间的相似性度量。一个非常常见的，也是我们在这里使用的，称为 Jaccard 相似度。这是一个听起来很复杂的名称，但概念非常简单（在计算机科学和其他 STEM 学科中经常发生这种情况）。如果 A 和 B 是两个集合，那么 Jaccard 相似度就是

$$
J(A, B) = \frac{|A \cap B)|}{|A \cup B)|}
$$

用通俗的英语来说，它就是两个集合的交集大小除以它们的并集大小。举例来说，如果 $A$ 和 $B$ 相等，$J(A, B)$ = 1，如果 A 和 B 不相交，$J(A, B)$ = 0。作为特殊情况，如果一个或两个集合为空，则度量为 0。使用 Python 集合操作可以非常容易地计算 Jaccard 度量。

以下是文档之间的比较度量：

1. 决定哪个文档的平均单词长度更大。这是衡量哪个文档使用更复杂语言的粗略度量。

2. 计算两个文档中总体单词使用的 Jaccard 相似度。这应精确到小数点后三位。

3. 计算每个单词长度的单词使用的 Jaccard 相似度。每个输出也应精确到小数点后三位。

4. 计算单词对集之间的 Jaccard 相似度。输出应精确到小数点后四位。我们在这里研究的文档不会有实质性的对相似性，但在其他情况下，这是一个有用的比较度量。

有关详细信息，请参阅示例输出。

## 注意事项

- 本作业的一个重要部分是练习使用集合。最复杂的情况发生在处理每个单词长度的单词集的计算时。这需要你形成一个集合列表。与列表中的条目 k 相关联的集合应该是长度为 k 的单词。

- 对字符串的二元组列表或集合进行排序很简单。（请注意，当你对一个集合进行排序时，结果是一个列表。）产生的顺序是按元组的第一个元素按字母顺序排列，然后对于相同的元素，按第二个元素按字母顺序排列。例如，

```python
>>> v = [('elephant', 'kenya'), ('lion', 'kenya'), ('elephant', 'tanzania'), \
         ('bear', 'russia'), ('bear', 'canada')]
>>> sorted(v)
[('bear', 'canada'), ('bear', 'russia'), ('elephant', 'kenya'), \
 ('elephant', 'tanzania'), ('lion', 'kenya')]
```

- 只提交一个 Python 文件 `hw6_sol.py`。

- 我们分析中缺少的一个组成部分是每个单词出现的频率。使用字典可以很容易地跟踪这一点，但我们不会在这个作业中这样做。当你学习字典时，思考一下它们如何用于增强我们在这里所做的分析。

## 文档文件

我们提供了上面描述的示例，我们将使用其他几个文档测试你的代码（其中一些是）：

- Elizabeth Alexander 的诗《Praise Song for the Day》。
- Maya Angelou 的诗《On the Pulse of the Morning》。
- William Shakespeare 的《Hamlet》中的一个场景。
- Dr. Seuss 的《The Cat in the Hat》
- Walt Whitman 的《When Lilacs Last in the Dooryard Bloom'd》（不是全部！）

所有这些都可以在网上全文阅读。请访问poetryfoundation.org，了解这些诗人、剧作家和作者的一些历史。

## 支持文件

{{< link href="HW6.zip" content="HW6.zip" title="Download HW6.zip" download="HW6.zip" card=true >}}

## 参考答案

### hw6_sol.py

```python
"""
This is a implement of the homework 6 solution for CSCI-1100
"""

#work_dir = "/mnt/c/Users/james/OneDrive/RPI/Spring 2024/CSCI-1100/Homeworks/HW6/hw6_files/"
work_dir = ""
stop_word = "stop.txt"

def get_stopwords():
    stopwords = []
    stoptxt = open(work_dir + stop_word, "r")
    stop_words = stoptxt.read().split("\n")
    stoptxt.close()
    stop_words = [x.strip() for x in stop_words if x.strip() != ""]
    for i in stop_words:
        text = ""
        for j in i:
            if j.isalpha():
                text += j.lower()
        if text != "":
            stopwords.append(text)
    #print("Debug - Stop words:", stopwords)
    return set(stopwords)

def parse(raw):
    parsed = []
    parsing = raw.replace("\n"," ").replace("\t"," ").replace("\r"," ").split(" ")
    #print("Debug - Parssing step 1:", parsing)
    parsing = [x.strip() for x in parsing if x.strip() != ""]
    #print("Debug - Parssing step 2:", parsing)
    for i in parsing:
        text = ""
        for j in i:
            if j.isalpha():
                text += j.lower()
        if text != "":
            parsed.append(text)
    #print("Debug - Parssing step 3:", parsed)
    parsed = [x for x in parsed if x not in get_stopwords()]
    #print("Debug - Parssing step 4:", parsed)
    return parsed

def get_avg_word_len(file):
    #print("Debug - File:", file)
    filetxt = open(work_dir + file, "r")
    raw = filetxt.read()
    filetxt.close()
    parsed = parse(raw)
    #print("Debug - Parsed:", parsed)
    avg = sum([len(x) for x in parsed]) / len(parsed)
    #print("Debug - Average:", avg)
    return avg

def get_ratio_distinct(file):
    filetxt = open(work_dir + file, "r").read()
    distinct = list(set(parse(filetxt)))
    total = len(parse(filetxt))
    ratio = len(distinct) / total
    #print("Debug - Distinct:", ratio)
    return ratio

def word_length_ranking(file):
    filetxt = open(work_dir + file, "r").read()
    parsed = parse(filetxt)
    max_length = max([len(x) for x in parsed])
    #print("Debug - Max length:", max_length)
    ranking = [[] for i in range(max_length + 1)]
    for i in parsed:
        if i not in ranking[len(i)]:
            ranking[len(i)].append(i)
            #print("Debug - Adding", i, "to", len(i))
    for i in range(len(ranking)):
        ranking[i] = sorted(ranking[i])
    #print("Debug - Ranking:", ranking)
    return ranking

def get_word_set_table(file):
    str1 = ""
    data = word_length_ranking(file)
    for i in range(1, len(data)):
        cache = ""
        if len(data[i]) <= 6:
            cache = " ".join(data[i])
        else:
            cache = " ".join(data[i][:3]) + " ... "
            cache += " ".join(data[i][-3:])
        if cache != "":
            str1 += "{:4d}:{:4d}: {}\n".format(i, len(data[i]), cache)
        else:
            str1 += "{:4d}:{:4d}:\n".format(i, len(data[i]))
    return str1.rstrip()

def get_word_pairs(file, maxsep):
    filetxt = open(work_dir + file, "r").read()
    parsed = parse(filetxt)
    pairs = []
    for i in range(len(parsed)):
        for j in range(i+1, len(parsed)):
            if j - i <= maxsep:
                pairs.append((parsed[i], parsed[j]))
    return pairs

def get_distinct_pairs(file, maxsep):
    total_pairs = get_word_pairs(file, maxsep)
    pairs = []
    for i in total_pairs:
        cache = sorted([i[0], i[1]])
        pairs.append((cache[0], cache[1]))
    return sorted(list(set(pairs)))

def get_word_pair_table(file, maxsep):
    pairs = get_distinct_pairs(file, maxsep)
    #print("Debug - Pairs:", pairs)
    str1 = "  "
    str1 += str(len(pairs)) + " distinct pairs" + "\n"
    if len(pairs) <= 10:
        for i in pairs:
            str1 += "  {} {}\n".format(i[0], i[1])
    else:
        for i in pairs[:5]:
            str1 += "  {} {}\n".format(i[0], i[1])
        str1 += "  ...\n"
        for i in pairs[-5:]:
            str1 += "  {} {}\n".format(i[0], i[1])
    return str1.rstrip()

def get_jaccard_similarity(list1, list2):
    setA = set(list1)
    setB = set(list2)
    intersection = len(setA & setB)
    union = len(setA | setB)
    if union == 0:
        return 0.0
    else:
        return intersection / union

def get_word_similarity(file1, file2):
    file1txt = open(work_dir + file1, "r").read()
    file2txt = open(work_dir + file2, "r").read()
    parsed1 = parse(file1txt)
    parsed2 = parse(file2txt)
    return get_jaccard_similarity(parsed1, parsed2)

def get_word_similarity_by_length(file1, file2):
    word_by_length_1 = word_length_ranking(file1)
    word_by_length_2 = word_length_ranking(file2)
    similarity = []
    for i in range(1, max(len(word_by_length_1), len(word_by_length_2))):
        if i < len(word_by_length_1) and i < len(word_by_length_2):
            similarity.append(get_jaccard_similarity(word_by_length_1[i], word_by_length_2[i]))
        else:
            similarity.append(0.0)
    return similarity

def get_word_similarity_by_length_table(file1, file2):
    similarity = get_word_similarity_by_length(file1, file2)
    str1 = ""
    for i in range(len(similarity)):
        str1 += "{:4d}: {:.4f}\n".format(i+1, similarity[i])
    return str1.rstrip()

def get_word_pairs_similarity(file1, file2, maxsep):
    pairs1 = get_distinct_pairs(file1, maxsep)
    pairs2 = get_distinct_pairs(file2, maxsep)
    return get_jaccard_similarity(pairs1, pairs2)

if __name__ == "__main__":
    # Debugging
    #file1st = "cat_in_the_hat.txt"
    #file2rd = "pulse_morning.txt"
    #maxsep = 2
    
    #s = " 01-34 can't 42weather67 puPPy, \r \t and123\n Ch73%allenge 10ho32use,.\n"
    #print(parse(s))
    #get_avg_word_len(file1st)
    #get_ratio_distinct(file1st)
    #print(word_length_ranking(file1st)[10])
    #print(get_word_set_table(file1st))
    
    # Get user input
    file1st = input("Enter the first file to analyze and compare ==> ").strip()
    print(file1st)
    file2rd = input("Enter the second file to analyze and compare ==> ").strip()
    print(file2rd)
    maxsep = int(input("Enter the maximum separation between words in a pair ==> ").strip())
    print(maxsep)
    
    files = [file1st, file2rd]
    for i in files:
        print("\nEvaluating document", i)
        print("1. Average word length: {:.2f}".format(get_avg_word_len(i)))
        print("2. Ratio of distinct words to total words: {:.3f}".format(get_ratio_distinct(i)))
        print("3. Word sets for document {}:\n{}".format(i, get_word_set_table(i)))
        print("4. Word pairs for document {}\n{}".format(i, get_word_pair_table(i, maxsep)))
        print("5. Ratio of distinct word pairs to total: {:.3f}".format(len(get_distinct_pairs(i, maxsep)) / len(get_word_pairs(i, maxsep))))
    
    print("\nSummary comparison")
    avg_word_length_ranking = []
    for i in files:
        length = get_avg_word_len(i)
        avg_word_length_ranking.append((i, length))
    avg_word_length_ranking = sorted(avg_word_length_ranking, key=lambda x: x[1], reverse=True)
    print("1. {} on average uses longer words than {}".format(avg_word_length_ranking[0][0], avg_word_length_ranking[1][0]))
    print("2. Overall word use similarity: {:.3f}".format(get_word_similarity(file1st, file2rd)))
    print("3. Word use similarity by length:\n{}".format(get_word_similarity_by_length_table(file1st, file2rd)))
    print("4. Word pair similarity: {:.4f}".format(get_word_pairs_similarity(file1st, file2rd, maxsep)))
```