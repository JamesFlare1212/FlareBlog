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

这份作业总共占你总作业成绩的100分。它将于2024年3月21日晚上11:59:59截止。像往常一样，会有自动评分的部分、助教测试案例部分和TA评分的部分。这个作业只有一个“part”。

请参阅手头文件中的提交指南和合作政策以了解关于评分的讨论以及什么被认为是过度的合作行为。这些规则在整个学期中都有效。

你需要我们提供的数据文件 `hw6_files.zip`，所以务必从Submitty课程材料部分下载该文件并将其解压缩到你为作业6创建的目录下。zip 文件包含了数据文件和程序示例输入/输出。

## 问题介绍

有许多软件系统用于分析书面文本的风格和复杂性，并且可以判断两份文档是否由同一人撰写。这些系统根据词汇使用的复杂程度、常用词以及紧密相邻出现的词语来分析文档。在这个作业中，你将编写一个Python程序，该程序读取两个包含不同文档内容的文件，对每个文档进行分析，并比较这两个文档。我们使用的方法是自然语言处理（NLP）领域实际应用中的更高级方法的简化版本。

### 文件和参数

你的程序必须与三个文件和一个整数参数一起工作。

第一个文件的名字将是 `stop.txt`，每次运行程序时都会用到这个文件名，因此你不需要向用户请求它。该文件包含了我们称为“停用词”的单词——应该忽略的词汇。你需要确保 `stop.txt` 文件位于你的 `hw6_sol.py` Python 文件所在的同一目录下。我们会提供一个示例，但测试代码可能会使用其他不同的文件。

你还必须请求两个文档的名字用于分析和比较以及一个整数参数“最大间隔”，这个参数将被称作 `max_sep`。这些请求应该像下面这样：

```text  
输入要分析并比较的第一个文件名 ==> doc1.txt  
doc1.txt  
输入要分析并比较的第二个文件名 ==> doc2.txt   
doc2.txt  
输入单词对之间允许的最大间隔数 ==> 2  
2
```

### 解析

这个作业的任务是将一个文本文件解析成单个连续词组成的列表。为此，应该首先将文件内容分割成字符串列表，其中每个字符串包含连续的非空格字符。然后，需要从每个字符串中移除所有非字母字符，并将所有字母转换为小写形式。例如，如果读取了一个名为 `doc1.txt` 的文件（注意行尾和制表符）：

```python  
s = " 01-34 can't 42weather67 puPPy, \r \t and123\n Ch73%allenge 10ho32use,.\n"  
```

那么分割结果应该得到字符串列表：

```python
['01-34', "can't", '42weather67', 'puPPy,', 'and123', 'Ch73%allenge', '10ho32use,.']
```

然后进一步解析为非空字符串的列表

```python  
['cant', 'weather', 'puppy', 'and', 'challenge', 'house']  
```

注意，第一个字符串 `'01-34'` 因为没有字母而完全被移除。所有三个文件——`stop.txt` 和两个文档文件 `doc1.txt` 和 `doc2.txt` ——都应按照这种方式进行解析。

一旦完成这些解析步骤，从解析 `stop.txt` 文件得到的列表应该转换成集合。此集合包含自然语言处理（NLP）中所谓的“停用词”——在文本中出现频繁到可以忽略不计的词汇。

文件 `doc1.txt` 和 `doc2.txt` 包含要比较的两个文档的内容。对于每个文件，解析返回的列表应进一步通过移除所有停用词来修改。继续我们的示例，如果 `'cant'` 和 `'and'` 是停用词，则单词列表应该被减少为：

```python  
['weather', 'puppy', 'challenge', 'house']  
```

像 "and" 这样的词汇几乎总是出现在停用词表中，而 "cant"（实际上是缩写形式的 "can't"）则在某些情况下会出现。注意，从 `doc1.txt` 和 `doc2.txt` 构建出来的单词列表应该保持为列表形式，因为单词顺序很重要。

### 分析每个文档的单词列表

一旦你生成了移除了停用词后的单词列表，就可以开始分析这个单词列表了。有许多方法可以完成这一点，但这里只列出本作业所要求的方法：

1. 计算并输出平均单词长度（保留两位小数）。这里的思路是，单词长度是一个粗略的语言复杂度指标。

2. 计算并输出不同词的数量与总词数量的比例（保留三位小数），这衡量了使用的语言的多样性（不过必须记住一些作者会反复使用某些词汇和短语来加强他们的信息）。

3. 对于每个从1开始的单词长度，找到具有该长度的所有单词集合。打印出这个长度、不同单词的数量，并输出最多六个这些单词。如果对于某个特定长度有六或更少个单词，则全部列出，如果有超过六个则列出前三个和后三个按字母顺序排列。

4. 找到文档中的所有唯一单词对。一个单词对是一个两个元素的元组，在文档列表中距离不超过 `max_sep` 的位置出现的两个词构成。例如，如果用户输入导致 `max_sep == 2`，那么生成的第一个六个单词对是：

    ```python  
    ('puppy', 'weather'), ('challenge', 'weather'),   
    ('challenge', 'puppy'), ('house', 'puppy'),  
    ('challenge', 'house'), ('challenge', 'whistle')  
    ```

    你的程序应该输出唯一单词对的总数，并且也应按字母顺序输出前五个和后五个单词对。你可以假设有足够的单词来生成这些对。

5. 最终，作为衡量单词对独特性的指标，计算并输出（保留三位小数）唯一单词对的数量与总单词对数量的比例。

### 比较文档

最后一步是根据复杂性和相似性比较这两个文档。有许多可能的度量标准，我们将实现其中的一些。

在进行这个步骤之前我们需要定义两个集合之间的相似度测量方法。一个非常常见且在这里使用的叫做雅卡尔相似度（Jaccard Similarity）。这是一个听起来很高深但其实很简单的方法（这种情况在计算机科学和其他STEM学科中经常出现）。如果A和B是两个集合，那么雅卡尔相似度就是

$$
J(A, B) = \frac{|A \cap B|}{|A \cup B|}
$$

用简单的英语来说，这就是两个集合的交集大小除以它们并集的大小。例如，如果 $A$ 和 $B$ 相等，则 $J(A, B)$ = 1；如果 $A$ 和 $B$ 没有共同元素（即不相交），则 $J(A, B)$ = 0。作为特殊情况，如果一个或两个集合为空，度量值为0。雅卡尔度量使用Python集合操作计算非常简单。

这里有一些文档之间比较的度量标准：

1. 决定哪个文档具有更大的平均单词长度。这是一个粗略的语言复杂性的指标。
2. 计算两份文档中整体词汇使用的雅卡尔相似度（保留三位小数）。
3. 对于每个单词长度，计算单词使用情况的雅卡尔相似度。输出也应精确到三位小数。
4. 计算单词对集合之间的雅卡尔相似度。输出应该准确到四位小数。我们研究的这些文档不会具有大量的成对相似性，但在其他情况下这是一个有用的比较度量。

请参考示例输出以获取详细信息。

## 备注

- 这个作业的重要部分是练习使用集合。最复杂的实例出现在处理每个单词长度的词集计算中。这需要你构建一个列表中的集合。列表第k项对应的集合应该包含长度为k的单词。
  
- 排序两个字符串元组构成的列表或集合非常简单。（注意当你对集合进行排序时，结果是一个列表）产生的顺序是按元组的第一个元素字母顺序排列，对于并列的情况则按照第二个元素字母顺序。例如：

    ```python
    >>> v = [('elephant', 'kenya'), ('lion', 'kenya'), ('elephant', 'tanzania'),
            ('bear', 'russia'), ('bear', 'canada')]
    >>> sorted(v)
    [('bear', 'canada'), ('bear', 'russia'), ('elephant', 'kenya'),
    ('elephant', 'tanzania'), ('lion', 'kenya')]
    ```

- 提交一个单一的Python文件 `hw6_sol.py`。
  
- 我们的分析中缺失的一个重要部分是每个单词出现的频率。这很容易使用字典来跟踪，但我们不会在本次作业中这样做。当你学习到字典时，请思考如何利用它们来增强我们在此处进行的分析。

## 文档文件

我们已经提供了上述示例，并且我们将对你的代码进行测试，同时还将提供其他一些文档（其中几个包括）：

- Elizabeth Alexander 的诗歌《赞歌》。
- Maya Angelou 的诗歌《脉搏之晨》。
- William Shakespeare 的戏剧《哈姆雷特》中的一个场景。
- Dr. Seuss 的《帽子猫》
- Walt Whitman 的《当紫丁香在门廊绽放时》（不包括全部内容！）

所有这些都可以在线全文获取。请访问 poetryfoundation.org 了解一些诗人、剧作家和作者的历史。

## 支持文件

{{< link href="HW6.zip" content="HW6.zip" title="Download HW6.zip" download="HW6.zip" card=true >}}

## 参考答案

### hw6_sol.py

```python
# Debugging
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