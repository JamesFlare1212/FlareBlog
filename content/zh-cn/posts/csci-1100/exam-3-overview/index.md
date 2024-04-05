---
title: CSCI 1100 - 测试 3 概览与练习题
subtitle:
date: 2024-04-03T03:54:07-04:00
slug: csci-1100-exam-3-overview
draft: false
author:
  name: James
  link: https://www.jamesflare.com
  email:
  avatar: /site-logo.avif
description: 这篇博客文章为CSCI 1100 - 计算机科学1的第三次测试提供了一个概述，包括重要的后勤指示，所涵盖的主题，以及关于Python中的集合，字典，类和文件I/O的练习问题
keywords: ["CSCI 1100","计算机科学","测试 3","练习题"]
license:
comment: true
weight: 0
tags:
  - CSCI 1100
  - 考试
  - RPI
  - Python
  - 编程
categories:
  - 编程
collections:
  - CSCI 1100
hiddenFromHomePage: false
hiddenFromSearch: false
hiddenFromRss: false
hiddenFromRelated: false
summary: 这篇博客文章为CSCI 1100 - 计算机科学1的第三次测试提供了一个概述，包括重要的后勤指示，所涵盖的主题，以及关于Python中的集合，字典，类和文件I/O的练习问题
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

## 重要的后勤说明：

- 测试 3 将于 2024 年 4 月 4 日星期四举行。
- 大多数学生将在下午 6:00 - 7:30 进行考试（90 分钟）。
- 向我们提供了说明需要额外时间或安静地点的便利信函的学生将在 7:30 之后获得额外时间。
- 考试前的星期三晚上，即 4 月 3 日，考场分配将在 Submitty 上公布。
- 学生必须：
  - 前往他们被分配的考场。
  - 携带他们的身份证参加考试。
  - 坐在正确的考场区域。
  - 收起所有计算器、手机等，并取下/取出所有耳机和耳塞。
  - 时间一到就立即交卷。在 90 分钟后仍在答题的人将得零分。

不遵守其中一项可能会导致考试成绩被扣 20 分。不遵守所有规定可能会被扣多达 80 分。

- 在交卷之前，你不能离开考场（甚至不能去洗手间）。
- 与考试 1 和 2 类似，考试期间允许使用一页小抄。

## 概述

- 主要涵盖第 14-19 讲，实验 7-9，家庭作业 5-7。
- 请复习讲义、课堂练习、实验、家庭作业、练习程序和测试，在查看解决方案之前自己尝试解决问题。
- 有些问题将与考试 2 中涉及的材料有关：
  - 列表和文件
  - 列表和字符串分割；范围
- 如果你对这些主题还不熟悉，你应该复习考试 2 练习题中的相关材料。
- 不允许使用计算器、教科书、课堂笔记、任何类型的电子设备！但是，你可以携带一张双面的 8.5" x 11" 的"小抄"。你可以按照自己的意愿准备这张小抄，也可以与小组成员一起准备共同的小抄。当然，在考试期间，每个人都必须有自己的副本。考试结束时，你需要上交一份签名的小抄副本。如果你需要保留一份副本作为记录，请在来参加考试之前复印一份。
- 请参考测试 1 和测试 2 的练习题以获取更多说明。

## 问题

### 未使用的字母

> 编写一个名为 `notused` 的函数，它接受一个单词列表作为其唯一参数，并返回一个集合，其中包含输入列表中的单词未使用的英文字母。你的函数必须使用集合。下面是你的函数应该如何工作的示例：
>
> ```python
> >>> notused([ "Dog", "pony", "elephant", "Tiger", "onyx", "Zebu" ])
> {'c', 'f', 'k', 'j', 'm', 'q', 's', 'w', 'v'}
> ```
>
> 提示：你可以在解决方案中使用以下集合：
>
> ```python
> all_letters = set("abcdefghijklmnopqrstuvwxyz")
> ```

{{< details summary="**此问题的答案**" >}}
以下是一个 Python 函数 `notused`，它接受一个单词列表，并返回一个集合，其中包含输入列表中的单词未使用的英文字母：

```python
def notused(words):
    all_letters = set("abcdefghijklmnopqrstuvwxyz")
    used_letters = set()

    for word in words:
        used_letters |= set(word.lower())

    return all_letters - used_letters
```

解释：

1. 我们定义了函数 `notused`，它接受一个单词列表作为其参数。

2. 我们创建了一个名为 `all_letters` 的集合，其中包含英文字母表中所有小写字母，使用 `set("abcdefghijklmnopqrstuvwxyz")`。

3. 我们初始化一个名为 `used_letters` 的空集合，用于存储输入列表中的单词使用的字母。

4. 我们开始一个循环，遍历 `words` 列表中的每个单词。

5. 对于每个单词，我们使用 `word.lower()` 将其转换为小写，以确保不区分大小写。然后，我们使用 `set(word.lower())` 将小写单词转换为其各个字母的集合。

6. 我们使用 `|=` 运算符将 `used_letters` 集合与当前单词的字母集合进行并集更新。这会将当前单词中的任何新字母添加到 `used_letters` 集合中。

7. 循环结束后，`used_letters` 将包含输入列表中的单词使用的所有字母。

8. 最后，我们使用 `all_letters - used_letters` 返回 `all_letters` 和 `used_letters` 之间的集合差。这给了我们一个集合，其中包含输入列表中的单词未使用的英文字母。

以下是该函数的工作示例：

```python
print(notused(["Dog", "pony", "elephant", "Tiger", "onyx", "Zebu"]))
# 输出：{'c', 'f', 'k', 'j', 'm', 'q', 's', 'w', 'v'}
```

在这个示例中，函数 `notused` 被调用，并传入一个单词列表。它返回一个集合，其中包含字母 'c'、'f'、'k'、'j'、'm'、'q'、's'、'w' 和 'v'，这些字母是英文字母表中未被输入列表中的任何单词使用的字母。

该解决方案使用集合来高效地处理字母集合之间的比较和差异操作。
{{< /details >}}

### 集合交集

> 给定三个集合 `s1`、`s2` 和 `s3`，编写一段简短的 Python 代码来查找仅在这三个集合中的一个集合中出现的值。结果应该存储在一个名为 `s` 的集合中。你不能使用任何循环或条件语句。

{{< details summary="**此问题的答案**" >}}
要在不使用任何循环或条件语句的情况下查找仅在三个集合 `s1`、`s2` 和 `s3` 中的一个集合中出现的值，你可以在 Python 中使用集合运算。下面是代码段：

```python
s = (s1 ^ s2 ^ s3) - (s1 & s2) - (s1 & s3) - (s2 & s3)
# 或者这个
#s = (s1 - s2 - s3) | (s2 - s1 - s3) | (s3 - s1 - s2)
```

解释：

1. `^` 运算符执行集合之间的对称差运算。它返回一个新集合，其中包含仅在其中一个集合中出现的元素，而不是在两个集合中都出现的元素。
   - `s1 ^ s2 ^ s3` 给出了一个集合，其中包含仅在一个或全部三个集合中出现的元素。

2. 为了删除在多个集合中出现的元素，我们需要减去每对集合的交集。
   - `s1 & s2` 给出了 `s1` 和 `s2` 共有的元素。
   - `s1 & s3` 给出了 `s1` 和 `s3` 共有的元素。
   - `s2 & s3` 给出了 `s2` 和 `s3` 共有的元素。

3. 通过从对称差 `(s1 ^ s2 ^ s3)` 中减去交集 `(s1 & s2)`、`(s1 & s3)` 和 `(s2 & s3)`，我们删除了在多个集合中出现的元素。

4. 结果集合 `s` 将只包含仅在三个集合 `s1`、`s2` 和 `s3` 中的一个集合中出现的元素。

这段代码段通过仅使用集合运算实现了所需的结果，而没有使用任何循环或条件语句。
{{< /details >}}

### 所有字符串中的单词

> 给定三个由空格分隔的单词字符串，编写代码来输出在所有三个字符串中都出现的单词数量。假设这些字符串与变量 `w1`、`w2` 和 `w3` 相关联。
>
> 对于
> ```python
> w1 = "the quick brown fox jumps over the lazy dog"
> w2 = "hey diddle diddle the cat and the fiddle the cow jumps over the moon"  
> w3 = "jack and jill went over the hill to fetch a pail of water"
> ```
> 输出应该是 `2`，因为 `the` 和 `over` 出现在所有三个字符串中。不允许使用循环。你可以用一行（很长的）代码来解决这个问题。在这种情况下，可以使用多行代码，但当你看到一行解决方案时，要确保你理解它。

{{< details summary="**此问题的答案**" >}}
要在不使用循环的情况下找出在所有三个字符串中都出现的单词数量，你可以使用 `set` 数据结构和 `intersection` 方法。下面是解决方案：

```python
print(len(set(w1.split()) & set(w2.split()) & set(w3.split())))
```

解释：

1. 我们对每个字符串（`w1`、`w2`、`w3`）使用 `split()` 方法将它们分割成单词列表。默认情况下，`split()` 根据空格分割字符串，从而分隔单词。

2. 我们使用 `set()` 将每个单词列表转换为集合。集合是一个无序的唯一元素集合，因此它消除了每个字符串中的任何重复单词。

3. 我们使用 `&` 运算符（集合交集）来查找集合之间的公共元素。两个集合的交集返回一个新集合，其中只包含两个集合中都存在的元素。

4. 我们使用 `&` 运算符链接所有三个集合的交集，得到一个包含在所有三个字符串中都出现的单词的集合。

5. 最后，我们使用 `len()` 函数来计算结果集合中的元素数量，这表示在所有三个字符串中都出现的单词数量。

一行解决方案将所有这些步骤合并到一行代码中，使其简洁但可能可读性较差。重要的是要理解各个步骤和集合交集的概念，以理解一行解决方案。

你可以使用提供的示例测试代码：

```python
w1 = "the quick brown fox jumps over the lazy dog"
w2 = "hey diddle diddle the cat and the fiddle the cow jumps over the moon"  
w3 = "jack and jill went over the hill to fetch a pail of water"

print(len(set(w1.split()) & set(w2.split()) & set(w3.split())))  # 输出：2
```

输出将是 `2`，因为单词 "the" 和 "over" 出现在所有三个字符串中。
{{< /details >}}

### 集合运算输出

> 当 Python 运行以下代码时，输出是什么？对于集合，不必担心获得准确的输出顺序。
> ```python
> s1 = set([7, 9, 12, 7, 9] )
> s2 = set(['abc', 12, 'b', 'car', 7, 10, 12 ])
> s3 = set([12, 14, 12, 'ab'])
> print(s1 & s2)
> print(s1 | s2)
> print('b' in s2)
> print('ab' in s2)
> print('ab' in s3)
> s2.discard(12)
> print((s1 & s2) ^ s3)
> ```
> 当然，你可以提出许多其他关于集合运算的问题。

{{< details summary="**此问题的答案**" >}}
给定代码的输出将是：

```text
{12, 7}
{'b', 7, 9, 10, 12, 'car', 'abc'}
True
False
True
{12, 7, 14, 'ab'}
```

解释：

1. `s1 = set([7, 9, 12, 7, 9])`：这将创建一个包含元素 7、9 和 12 的集合 `s1`。重复项会自动删除。

2. `s2 = set(['abc', 12, 'b', 'car', 7, 10, 12])`：这将创建一个包含元素 'abc'、12、'b'、'car'、7 和 10 的集合 `s2`。同样，重复项会被删除。

3. `s3 = set([12, 14, 12, 'ab'])`：这将创建一个包含元素 12、14 和 'ab' 的集合 `s3`。

4. `print(s1 & s2)`：这执行集合 `s1` 和 `s2` 之间的交集运算，返回一个包含公共元素的新集合。输出将是 `{12, 7}`。

5. `print(s1 | s2)`：这执行集合 `s1` 和 `s2` 之间的并集运算，返回一个包含两个集合中所有元素的新集合。输出将是 `{'b', 7, 9, 10, 12, 'car', 'abc'}`。

6. `print('b' in s2)`：这检查元素 'b' 是否存在于集合 `s2` 中。它将输出 `True`，因为 'b' 在 `s2` 中。

7. `print('ab' in s2)`：这检查元素 'ab' 是否存在于集合 `s2` 中。它将输出 `False`，因为 'ab' 不在 `s2` 中。

8. `print('ab' in s3)`：这检查元素 'ab' 是否存在于集合 `s3` 中。它将输出 `True`，因为 'ab' 在 `s3` 中。

9. `s2.discard(12)`：这将从集合 `s2` 中删除元素 12（如果存在）。执行此操作后，`s2` 将为 `{'abc', 'b', 'car', 7, 10}`。

10. `print((s1 & s2) ^ s3)`：这执行以下操作：
    - `s1 & s2` 计算集合 `s1` 和 `s2` 的交集，结果为 `{7}`。
    - `(s1 & s2) ^ s3` 执行 `s1 & s2` 的结果与集合 `s3` 之间的对称差运算。它返回一个新集合，其中包含 `(s1 & s2)` 或 `s3` 中的元素，但不包含两者中的元素。输出将是 `{12, 7, 14, 'ab'}`。

输出集合中元素的顺序可能有所不同，因为集合是无序的集合。你提供的实际输出与预期输出相匹配。
{{< /details >}}

### 餐厅评论

> 给你一个包含餐厅评论的字典。每个键是餐厅的名称。字典中的每个项目都是评论列表。每个评论都是一个字符串。请参见下面的示例。
> ```python
> rest_reviews = {"DeFazio's":["Great pizza", "Best in upstate"], \
>   "I Love NY Pizza":["Great delivery service"], \
>   "Greasy Cheese": [ "Awful stuff", "Everything was terrible" ] }
> ```
> 假设已经创建了 `rest_reviews`，请解决以下问题。
>
> (a) 编写代码以查找评论中至少包含以下单词之一的所有餐厅：awful、terrible、dump。对于找到的每个餐厅，输出餐厅的名称和至少包含其中一个单词的评论数量。请注意大小写。'Awful' 和 'awful' 应该匹配。
>
> (b) 编写代码以查找并打印评论数量最多的餐厅名称。如果有多个餐厅的评论数量相同，请打印每个餐厅的名称。
>  
> (c) 编写一个函数，它接受评论字典、新评论和餐厅名称作为参数。该函数应将评论添加到字典中。如果餐厅已经在字典中，该函数应将评论添加到该餐厅现有的评论列表中。如果餐厅不在字典中，该函数应向字典添加一个新项目。你的函数应该通过 `add_review(rest_reviews, new_review, rest_name)` 调用。
>
> (d) 编写一个函数，它接受与 `add_review` 相同的参数，但删除给定的评论。具体来说，如果评论在与餐厅关联的字典中，该函数应删除评论并返回 True。否则，该函数应返回 False。如果给定的餐厅不在字典中，该函数也应返回 False。该函数应通过 `del_review(rest_reviews, old_review, rest_name)` 调用。

{{< details summary="**A 部分的答案**" >}}
```python
for restaurant, reviews in rest_reviews.items():
    count = 0
    for review in reviews:
        if any(word in review.lower() for word in ["awful", "terrible", "dump"]):
            count += 1
    if count > 0:
        print(f"{restaurant}: {count} 条评论包含指定的单词")
```

解释：
- 我们遍历 `rest_reviews` 字典中的每个餐厅及其评论。
- 对于每个餐厅，我们初始化一个 `count` 变量来跟踪包含指定单词的评论数量。
- 我们遍历每个评论，并检查指定的单词（"awful"、"terrible"、"dump"）是否出现在评论中（不区分大小写）。
- 如果评论包含任何指定的单词，我们将 `count` 增加 1。
- 在检查完一个餐厅的所有评论后，如果 `count` 大于 0，我们打印餐厅名称和包含指定单词的评论数量。
{{< /details >}}

{{< details summary="**B 部分的答案**" >}}
```python
max_reviews = 0
restaurants_with_max_reviews = []

for restaurant, reviews in rest_reviews.items():
    num_reviews = len(reviews)
    if num_reviews > max_reviews:
        max_reviews = num_reviews
        restaurants_with_max_reviews = [restaurant]
    elif num_reviews == max_reviews:
        restaurants_with_max_reviews.append(restaurant)

print("评论数量最多的餐厅：")
for restaurant in restaurants_with_max_reviews:
    print(restaurant)
```

解释：
- 我们初始化 `max_reviews` 来跟踪最高评论数量，并初始化 `restaurants_with_max_reviews` 来存储评论数量最多的餐厅。
- 我们遍历 `rest_reviews` 字典中的每个餐厅及其评论。
- 对于每个餐厅，我们使用 `len(reviews)` 计算评论数量。
- 如果评论数量大于当前的 `max_reviews`，我们更新 `max_reviews` 并将 `restaurants_with_max_reviews` 设置为只包含当前餐厅的列表。
- 如果评论数量等于 `max_reviews`，我们将当前餐厅附加到 `restaurants_with_max_reviews` 中。
- 最后，我们打印评论数量最多的餐厅。
{{< /details >}}

{{< details summary="**C 部分的答案**" >}}
```python
def add_review(rest_reviews, new_review, rest_name):
    if rest_name in rest_reviews:
        rest_reviews[rest_name].append(new_review)
    else:
        rest_reviews[rest_name] = [new_review]
```

解释：
- `add_review` 函数接受 `rest_reviews` 字典、`new_review` 和 `rest_name` 作为参数。
- 如果 `rest_name` 已经存在于 `rest_reviews` 字典中，我们将 `new_review` 附加到该餐厅现有的评论列表中。
- 如果 `rest_name` 不在字典中，我们在字典中创建一个新条目，以 `rest_name` 作为键，以包含 `new_review` 的列表作为值。
{{< /details >}}

{{< details summary="**D 部分的答案**" >}}
```python
def del_review(rest_reviews, old_review, rest_name):
    if rest_name in rest_reviews:
        if old_review in rest_reviews[rest_name]:
            rest_reviews[rest_name].remove(old_review)
            return True
    return False
```

解释：
- `del_review` 函数接受 `rest_reviews` 字典、`old_review` 和 `rest_name` 作为参数。
- 如果 `rest_name` 存在于 `rest_reviews` 字典中，我们检查 `old_review` 是否在该餐厅的评论列表中。
- 如果找到 `old_review`，我们使用 `remove` 方法将其从列表中删除，并返回 `True` 以指示删除成功。
- 如果 `rest_name` 不在字典中或未找到 `old_review`，我们返回 `False` 以指示删除不成功。
{{< /details >}}

### Python 输出

> 对于以下每个代码部分，编写 Python 将生成的输出：
>
> 部分 A
> ```python
> x = {1:['joe',set(['skiing','reading'])],\
> 2:['jane',set(['hockey'])]}
> x[1][1].add('singing')
> x[1][0] = 'kate'
> for item in sorted(x.keys()):
>     print(x[item][0], len(x[item][1]))
> ```
>
> 部分 B
> ```python
> y = {'jane':10, 'alice':2, 'bob':8,\
>      'kristin':10}
> m = 0
> for person in sorted(y.keys()):
>     if y[person] > m:
>         print("**", person)
>         m = y[person]
> for person in sorted(y.keys()):
>     if y[person] == m:
>         print("!!", person)
> ```
>
> 部分 C：请注意，此问题需要理解别名的概念。
> ```python
> L1 = [0,1,2]
> L2 = ['a','b']
> d = {5:L1, 8:L2}
> L1[2] = 6
> d[8].append('k')
> L2[0] = 'car'
> for k in sorted(d.keys()):
>     print(str(k) + ' ', end='')
>     for v in d[k]:
>         print(str(v) + ' ', end='')
>     print()
> ```
>
> 部分 D：
> ```python
> L1 = [0,1,2,4,1,0]
> s1 = set(L1)
> L1.pop()
> L1.pop()
> L1.pop()
> L1[0] = 5
> s1.add(6)
> s1.discard(1)
> print(L1)
> for v in sorted(s1):
>     print(v)
> ```

{{< details summary="**A 部分的答案**" >}}
输出：
```
kate 3
jane 1
```

解释：
1. 该代码创建了一个字典 `x`，其中键为 1 和 2。键 1 的值是一个列表，包含字符串 'joe' 和一个包含元素 'skiing' 和 'reading' 的集合。键 2 的值是一个列表，包含字符串 'jane' 和一个包含元素 'hockey' 的集合。
2. 代码行 `x[1][1].add('singing')` 将元素 'singing' 添加到字典 `x` 中键 1 关联的列表的索引 1 处的集合中。
3. 代码行 `x[1][0] = 'kate'` 将字典 `x` 中键 1 关联的列表的索引 0 处的字符串更新为 'kate'。
4. `for` 循环遍历字典 `x` 的有序键。
5. 对于每个键 `item`，它打印相应列表的索引 0 处的字符串（`x[item][0]`）和列表的索引 1 处的集合的长度（`len(x[item][1])`）。
6. 输出显示，对于键 1，字符串为 'kate'，集合有 3 个元素；对于键 2，字符串为 'jane'，集合有 1 个元素。
{{< /details >}}

{{< details summary="**B 部分的答案**" >}}
输出：
```
** alice
** bob
** jane
!! jane
!! kristin
```

解释：
1. 该代码创建了一个字典 `y`，其中包含键 'jane'、'alice'、'bob' 和 'kristin'，以及它们对应的值。
2. 变量 `m` 被初始化为 0。
3. 第一个 `for` 循环遍历字典 `y` 的有序键。
4. 对于每个 `person`，如果值 `y[person]` 大于 `m`，它会打印 `"** " + person` 并将 `m` 更新为 `y[person]` 的值。这会找到字典中的最大值。
5. 第一个循环的输出显示，'alice'、'bob' 和 'jane' 都带有 `"**"` 前缀打印，因为它们的值大于 `m` 的初始值（即 0）。
6. 第一个循环结束后，`m` 保存字典中找到的最大值，即 10。
7. 第二个 `for` 循环再次遍历字典 `y` 的有序键。
8. 对于每个 `person`，如果值 `y[person]` 等于 `m`（最大值），它会打印 `"!! " + person`。
9. 第二个循环的输出显示，'jane' 和 'kristin' 都带有 `"!!` 前缀打印，因为它们的值等于最大值 `m`（即 10）。

感谢你指出错误。我很感谢你对细节的关注！
{{< /details >}}

{{< details summary="**C 部分的答案**" >}}
输出：
```
5 0 1 6 
8 car b k 
```

解释：
1. 该代码创建了两个列表 `L1` 和 `L2`，以及一个字典 `d`，其中键为 5 和 8。键 5 的值为 `L1`，键 8 的值为 `L2`。
2. 代码行 `L1[2] = 6` 将 `L1` 的索引 2 处的元素更新为 6。
3. 代码行 `d[8].append('k')` 将元素 'k' 附加到列表 `L2` 中，`L2` 是字典 `d` 中键 8 的值。
4. 代码行 `L2[0] = 'car'` 将 `L2` 的索引 0 处的元素更新为 'car'。
5. `for` 循环遍历字典 `d` 的有序键。
6. 对于每个键 `k`，它打印 `k` 的字符串表示形式，后跟一个空格。
7. 嵌套的 `for` 循环遍历列表 `d[k]` 中的值 `v`，并打印每个 `v` 的字符串表示形式，后跟一个空格。
8. 在每个内部循环之后，它打印一个换行符以移动到下一行。
9. 输出显示，对于键 5，对应的列表为 `[0, 1, 6]`，对于键 8，对应的列表为 `['car', 'b', 'k']`。
{{< /details >}}

{{< details summary="**D 部分的答案**" >}}
输出：
```
[5, 1, 2]
0
2
4
6
```

解释：
1. 该代码创建了一个包含元素 `[0, 1, 2, 4, 1, 0]` 的列表 `L1`。
2. 代码行 `s1 = set(L1)` 从 `L1` 的元素创建了一个集合 `s1`。集合将只包含 `L1` 中的唯一元素，即 `{0, 1, 2, 4}`。
3. 代码行 `L1.pop()`、`L1.pop()` 和 `L1.pop()` 从列表 `L1` 中删除最后三个元素。执行这些操作后，`L1` 变为 `[0, 1, 2]`。
4. 代码行 `L1[0] = 5` 将 `L1` 的索引 0 处的元素更新为 5。现在，`L1` 变为 `[5, 1, 2]`。
5. 代码行 `s1.add(6)` 将元素 6 添加到集合 `s1` 中。集合 `s1` 变为 `{0, 1, 2, 4, 6}`。
6. 代码行 `s1.discard(1)` 从集合 `s1` 中删除元素 1。集合 `s1` 变为 `{0, 2, 4, 6}`。
7. 代码行 `print(L1)` 打印更新后的列表 `L1`，即 `[5, 1, 2]`。
8. `for` 循环遍历集合 `s1` 中的有序元素 `v`，并在新行上打印每个元素。
9. 输出显示更新后的列表 `L1` 和集合 `s1` 中按排序顺序排列的元素，即 `0`、`2`、`4` 和 `6`。

感谢你提醒我注意这一点。我很感谢你仔细审阅答案！
{{< /details >}}

### Person 类

> 假设 `Person` 是一个类，它为每个人存储他们的姓名、生日、母亲和父亲的姓名。这些都是字符串。类的开头，包括初始化函数，如下所示。
> ```python
> class Person(object):
>     def __init__(self, n, bd, m, f):
>         self.name = n
>         self.birthday = bd
>         self.mother = m
>         self.father = f
> ```
> 为 `Person` 类编写一个方法，该方法将 self 和另一个 `Person` 对象作为参数，如果两个人是双胞胎，则返回 `2`；如果他们是兄弟姐妹（但不是双胞胎），则返回 `1`；如果两个人是同一个人，则返回 `-1`；否则返回 `0`。请注意，兄弟姐妹或双胞胎必须有相同的母亲和父亲。

{{< details summary="**此问题的答案**" >}}
为了确定两个 `Person` 对象之间的关系，我们可以比较它们的母亲、父亲和生日属性。以下是你可以添加到 `Person` 类中的方法：

```python
def relationship(self, other):
    if self == other:
        return -1
    elif self.mother == other.mother and self.father == other.father:
        if self.birthday == other.birthday:
            return 2
        else:
            return 1
    else:
        return 0
```

解释：

1. `relationship` 方法接受两个参数：`self`（当前的 `Person` 对象）和 `other`（另一个 `Person` 对象）。

2. 我们首先使用相等运算符 `==` 检查 `self` 和 `other` 是否引用同一个 `Person` 对象。如果它们是同一个对象，我们返回 -1。

3. 如果 `self` 和 `other` 不是同一个对象，我们通过比较两个对象的 `mother` 和 `father` 属性来检查它们是否有相同的母亲和父亲。如果它们有相同的母亲和父亲，这意味着它们要么是双胞胎，要么是兄弟姐妹。

4. 如果 `self` 和 `other` 有相同的母亲和父亲，我们进一步检查它们的 `birthday` 属性：
   - 如果他们的生日相同，我们返回 2 表示他们是双胞胎。
   - 如果他们的生日不同，我们返回 1 表示他们是兄弟姐妹（但不是双胞胎）。

5. 如果 `self` 和 `other` 没有相同的母亲和父亲，我们返回 0 表示他们没有兄弟姐妹或双胞胎的关系。

将此方法添加到 `Person` 类后，你可以创建 `Person` 对象并使用 `relationship` 方法确定它们之间的关系。例如：

```python
person1 = Person("John", "1990-01-01", "Mary", "David")
person2 = Person("Jane", "1990-01-01", "Mary", "David")
person3 = Person("Alice", "1992-05-10", "Mary", "David")
person4 = Person("Bob", "1995-03-15", "Lisa", "Tom")

print(person1.relationship(person2))  # 输出：2（双胞胎）
print(person1.relationship(person3))  # 输出：1（兄弟姐妹）
print(person1.relationship(person4))  # 输出：0（没有关系）
print(person1.relationship(person1))  # 输出：-1（同一个人）
```

`relationship` 方法根据两个 `Person` 对象的母亲、父亲和生日属性正确确定它们之间的关系。
{{< /details >}}

### 合并字典

> 给你两个字典 D1 和 D2，其中每个键是表示姓名的字符串，每个值是电话号码的集合。编写一个函数将 D1 和 D2 合并为一个字典 D。D 应该包含 D1 和 D2 中的所有信息。例如，
>
> ```python
> D1 = {'Joe':set(['555-1111','555-2222']), 'Jane':set(['555-3333'])}
> D2 = {'Joe':set(['555-2222','555-4444']), 'Kate':set(['555-6666'])}
> merge_dict(D1,D2)
> {'Joe':set(['555-1111','555-2222','555-4444']), 'Jane':set(['555-3333']), 'Kate':set(['555-6666']) }
> ```

{{< details summary="**此问题的答案**" >}}
这是一个 Python 函数，它根据给定的要求将两个字典 `D1` 和 `D2` 合并为一个字典 `D`：

```python
def merge_dict(D1, D2):
    D = {}
    
    # 合并 D1 的键
    for name, numbers in D1.items():
        D[name] = numbers.copy()
    
    # 合并 D2 的键
    for name, numbers in D2.items():
        if name in D:
            D[name] |= numbers
        else:
            D[name] = numbers.copy()
    
    return D
```

解释：

1. 我们首先创建一个空字典 `D` 来存储合并的结果。

2. 我们使用 `items()` 方法遍历 `D1` 中的每个键值对：
   - 对于每个 `name`（键）和 `numbers`（值）对，我们将 `name` 作为键添加到 `D` 中，并使用 `numbers.copy()` 创建 `numbers` 集合的副本。这确保了 `D1` 中的原始集合不会被修改。

3. 接下来，我们遍历 `D2` 中的每个键值对：
   - 如果 `name`（键）已经存在于 `D` 中，我们使用 `|=` 运算符（集合并集）将 `D2` 中的 `numbers` 集合与 `D` 中现有的集合合并。
   - 如果 `name`（键）不存在于 `D` 中，我们将其作为新键添加到 `D` 中，并使用 `numbers.copy()` 创建 `D2` 中 `numbers` 集合的副本。

4. 最后，我们返回合并后的字典 `D`。

该函数正确地将 `D1` 和 `D2` 的信息合并到一个字典 `D` 中。如果一个名字在两个字典中都存在，则对应的电话号码集合会使用集合并集进行合并。

你可以使用提供的示例测试该函数：

```python
D1 = {'Joe': set(['555-1111', '555-2222']), 'Jane': set(['555-3333'])}
D2 = {'Joe': set(['555-2222', '555-4444']), 'Kate': set(['555-6666'])}
merged_dict = merge_dict(D1, D2)
print(merged_dict)
```

输出：
```
{'Joe': {'555-1111', '555-2222', '555-4444'}, 'Jane': {'555-3333'}, 'Kate': {'555-6666'}}
```

合并后的字典 `D` 包含了 `D1` 和 `D2` 的所有信息，对于相同的名字，电话号码集合进行了合并。
{{< /details >}}

### Student 类

> 这个问题涉及一个名为 `Student` 的类，它存储学生的姓名（字符串）、学号（字符串）、所修课程（字符串列表）和专业（字符串）。编写实现这个类的 Python 代码，只包括以下方法：
>
> (a) 一个初始化方法，只有姓名和学号作为参数。它应该将课程列表初始化为空，将专业初始化为 "Undeclared"。这个方法的使用示例如下：
>
> ```python
> p = Student( "Chris Student", "123454321" )
> ```
>
> (b) 一个名为 `add_courses` 的方法，用于将课程列表添加到学生所修的课程中。例如，以下代码应该为 Chris Student 添加三门课程。
>
> ```python
> p.add_courses( [ "CSCI1100", "BASK4010", "GEOL1320" ] )
> ```
>
> (c) 一个名为 `common_courses` 的方法，返回两个学生共同修过的课程列表：
>
> ```python
> q = Student( "Bilbo Baggins", "545454545" )
> q.add_courses( [ "MATH1240", "CSCI1100", "HIST2010", "BASK4010" ] )
> print(q.common_courses(p))
> [ "CSCI1100", "BASK4010" ]
> ```

{{< details summary="**此问题的答案**" >}}
```python
class Student:
    def __init__(self, name, id):
        self.name = name
        self.id = id
        self.courses = []
        self.major = "Undeclared"
    
    def add_courses(self, courses):
        self.courses.extend(courses)
    
    def common_courses(self, other_student):
        return list(set(self.courses) & set(other_student.courses))
```

解释：

(a) `__init__` 方法是 `Student` 类的初始化方法。它接受 `name` 和 `id` 作为参数，并初始化 `Student` 对象的 `name` 和 `id` 属性。它还将 `courses` 属性初始化为空列表，并将 `major` 属性设置为 "Undeclared"。

(b) `add_courses` 方法接受一个课程列表作为参数，并将它们添加到 `Student` 对象的 `courses` 属性中。它使用列表的 `extend` 方法一次添加多个课程。

(c) `common_courses` 方法接受另一个 `Student` 对象（`other_student`）作为参数，并返回两个学生共同修过的课程列表。它使用集合交集运算（`&`）来查找当前学生的 `courses` 和其他学生的 `courses` 之间的共同课程。结果集合然后使用 `list` 函数转换回列表。

你可以按照以下方式使用该类：

```python
p = Student("Chris Student", "123454321")
p.add_courses(["CSCI1100", "BASK4010", "GEOL1320"])

q = Student("Bilbo Baggins", "545454545")
q.add_courses(["MATH1240", "CSCI1100", "HIST2010", "BASK4010"])

print(q.common_courses(p))  # 输出：['CSCI1100', 'BASK4010']
```

这段代码创建了两个 `Student` 对象 `p` 和 `q`，分别有它们的姓名和学号。它使用 `add_courses` 方法为每个学生添加课程。最后，它调用 `q` 上的 `common_courses` 方法，将 `p` 作为参数传递，以查找两个学生共同修过的课程。输出将是 `['CSCI1100', 'BASK4010']`。
{{< /details >}}

### 修读多门 CSCI 课程

> 使用上一个问题中的 `Student` 方法和属性，假设给你一个名为 all_students 的学生对象列表。编写一段代码，输出修读了至少两门以 CSCI 开头的课程的所有学生的姓名。

{{< details summary="**此问题的答案**" >}}
假设你有一个名为 `all_students` 的 `Student` 对象列表，下面是一段代码，输出修读了至少两门以 "CSCI" 开头的课程的学生姓名：

```python
for student in all_students:
    csci_courses = [course for course in student.courses if course.startswith("CSCI")]
    if len(csci_courses) >= 2:
        print(student.name)
```

解释：

1. 我们使用 `for` 循环遍历 `all_students` 列表中的每个 `Student` 对象。

2. 对于每个学生，我们使用列表推导式创建一个名为 `csci_courses` 的新列表。这个列表推导式做了以下事情：
   - 它使用 `for course in student.courses` 遍历学生的 `courses` 列表中的每门课程。
   - 对于每门课程，它使用 `startswith` 方法检查课程是否以 "CSCI" 开头：`if course.startswith("CSCI")`。
   - 如果课程以 "CSCI" 开头，它将被包含在 `csci_courses` 列表中。

3. 创建 `csci_courses` 列表后，我们使用 `len(csci_courses)` 检查其长度。如果长度大于或等于 2，则表示该学生至少修读了两门以 "CSCI" 开头的课程。

4. 如果条件 `len(csci_courses) >= 2` 为真，我们使用 `print(student.name)` 打印学生的姓名。

这段代码将输出 `all_students` 列表中至少修读了两门以 "CSCI" 开头的课程的所有学生的姓名。

例如，如果你有以下 `all_students` 列表：

```python
p = Student("Chris Student", "123454321")
p.add_courses(["CSCI1100", "BASK4010", "GEOL1320"])

q = Student("Bilbo Baggins", "545454545")
q.add_courses(["MATH1240", "CSCI1100", "HIST2010", "BASK4010"])

r = Student("Alice Smith", "987654321")
r.add_courses(["CSCI1100", "CSCI2200", "MATH1240", "HIST2010"])

all_students = [p, q, r]
```

在这个 `all_students` 列表上运行代码段将输出：

```
Alice Smith
```

这是因为只有学生 "Alice Smith" 修读了至少两门以 "CSCI" 开头的课程（"CSCI1100" 和 "CSCI2200"）。
{{< /details >}}

### K 个最小值

> 给定一个列表 `L` 和一个正整数 `k`，创建一个新列表，只包含 `L` 列表中最小的 k 个值。例如，如果 `L = [ 15, 89, 3, 56, 83, 123, 51, 14, 15, 67, 15 ]` 且 `k=4`，则新列表应该包含值 `Ls = [3, 14, 15, 15]`（请注意，其中一个 15 不在这里）。编写一个函数 `k_smallest(L,k)`，返回所需的列表。该函数使用排序，但不会更改 `L`。在不编写任何循环的情况下，用 4 行代码完成此操作。

{{< details summary="**此问题的答案**" >}}
这是一个 Python 函数 `k_smallest(L, k)`，它从输入列表 `L` 中返回一个包含 k 个最小值的新列表，而不修改 `L`，使用排序并且不编写任何循环：

```python
def k_smallest(L, k):
    sorted_L = sorted(L)
    Ls = sorted_L[:k]
    return Ls
```

解释：

1. 我们通过调用输入列表 `L` 上的 `sorted()` 函数创建一个新列表 `sorted_L`。这将创建一个按升序排列的新排序列表，而不修改原始列表 `L`。

2. 我们使用切片语法 `sorted_L[:k]` 从索引 0 到索引 `k`（不包括）切片 `sorted_L` 列表，创建一个新列表 `Ls`。这将选择排序列表中的前 `k` 个元素，它们对应于最小的 `k` 个值。

3. 最后，我们返回包含原始列表 `L` 中最小的 `k` 个值的 `Ls` 列表。

该函数在只有 4 行代码的情况下实现了所需的结果，没有使用任何循环。它利用内置的 `sorted()` 函数对列表进行排序，并使用切片提取最小的 `k` 个值。

你可以使用提供的示例测试该函数：

```python
L = [15, 89, 3, 56, 83, 123, 51, 14, 15, 67, 15]
k = 4
Ls = k_smallest(L, k)
print(Ls)  # 输出：[3, 14, 15, 15]
```

该函数将返回列表 `[3, 14, 15, 15]`，其中包含原始列表 `L` 中最小的 4 个值，而不修改 `L`。
{{< /details >}}

### 代码段输出

> 以下两个代码段的输出是什么？
>
> 部分 A
> ```python
> dt = { 1: [ 'mom', 'dad'], 'hi': [1, 3, 5 ]}
> print(len(dt))
> print(dt[1][0])
> dt['hi'].append(3)
> dt[1][0] = 'gran'
> print(dt[1])
> ```
>
> 部分 B
> ```python
> # 请记住，pop() 删除并返回列表中的最后一个值。
> LP = [2, 3, 5, 7]
> LC = [4, 6, 8, 9]
> nums = dict()
> nums['pr'] = LP
> nums['co'] = LC[:]
> LP[1] = 5
> print(len(nums['co']))
> v = LC.pop()
> v = LC.pop()
> v = LC.pop()
> LC.append(12)
> print(len(LC))
> print(len(nums['co']))
> v = nums['pr'].pop()
> v = nums['pr'].pop()
> print(nums['pr'][1])
> print(len(LP))
> ```

{{< details summary="**A 部分的答案**" >}}
输出：
```text
2
mom
['gran', 'dad']
```

解释：
1. 该代码创建了一个字典 `dt`，其中键 1 的值是一个包含字符串 'mom' 和 'dad' 的列表，键 'hi' 的值是一个包含整数 1、3 和 5 的列表。
2. 代码行 `print(len(dt))` 打印字典 `dt` 的长度，即 2，因为它有两个键值对。
3. 代码行 `print(dt[1][0])` 打印字典 `dt` 中与键 1 关联的列表的索引 0 处的元素，即 'mom'。
4. 代码行 `dt['hi'].append(3)` 将整数 3 附加到字典 `dt` 中与键 'hi' 关联的列表。执行此操作后，键 'hi' 的值变为 [1, 3, 5, 3]。
5. 代码行 `dt[1][0] = 'gran'` 将字典 `dt` 中与键 1 关联的列表的索引 0 处的元素更新为 'gran'。
6. 代码行 `print(dt[1])` 打印字典 `dt` 中与键 1 关联的列表，现在是 ['gran', 'dad']。
{{< /details >}}

{{< details summary="**B 部分的答案**" >}}
输出：
```text
4
2
4
5
2
```

解释：
1. 该代码创建了两个列表 `LP` 和 `LC`，并包含一些初始值。
2. 它创建了一个名为 `nums` 的空字典。
3. 代码行 `nums['pr'] = LP` 将列表 `LP` 赋值为字典 `nums` 中键 'pr' 的值。
4. 代码行 `nums['co'] = LC[:]` 创建列表 `LC` 的浅拷贝，并将其赋值为字典 `nums` 中键 'co' 的值。
5. 代码行 `LP[1] = 5` 将列表 `LP` 的索引 1 处的元素更新为 5。这不会影响列表 `nums['pr']`，因为它是一个单独的副本。
6. 代码行 `print(len(nums['co']))` 打印字典 `nums` 中与键 'co' 关联的列表的长度，即 4。
7. 代码行 `v = LC.pop()`、`v = LC.pop()` 和 `v = LC.pop()` 删除列表 `LC` 的最后三个元素，并将它们赋值给变量 `v`。执行这些操作后，`LC` 变为 [4]。
8. 代码行 `LC.append(12)` 将整数 12 附加到列表 `LC`。现在，`LC` 变为 [4, 12]。
9. 代码行 `print(len(LC))` 打印列表 `LC` 的长度，即 2。
10. 代码行 `print(len(nums['co']))` 打印字典 `nums` 中与键 'co' 关联的列表的长度，仍然是 4，因为它是一个单独的副本，不受对 `LC` 所做更改的影响。
11. 代码行 `v = nums['pr'].pop()` 和 `v = nums['pr'].pop()` 删除字典 `nums` 中与键 'pr' 关联的列表的最后两个元素，并将它们赋值给变量 `v`。执行这些操作后，`nums['pr']` 变为 [2, 5]。
12. 代码行 `print(nums['pr'][1])` 打印字典 `nums` 中与键 'pr' 关联的列表的索引 1 处的元素，即 5。
13. 代码行 `print(len(LP))` 打印列表 `LP` 的长度，即 2，因为它受到对 `nums['pr']` 执行的 `pop()` 操作的影响。
{{< /details >}}

### 按年龄查找姓名

> 给定一个字典列表，其中每个字典以属性（键）/值对的形式存储有关一个人的信息。例如，这里有一个代表四个人的字典列表：
>
> ```python
> people = [
>     { 'name':'Paul', 'age' : 25, 'weight' : 165 },
>     { 'height' : 155, 'name' : 'Sue', 'age' : 30, 'weight' : 123 },
>     { 'weight' : 205, 'name' : 'Sam' },
>     { 'height' : 156, 'name' : 'Andre', 'age' : 39, 'weight' : 123 }
> ]
> ```
>
> 编写代码，按字母顺序查找并输出已知年龄至少为 30 岁的所有人的姓名。你可以假设 people 中的每个字典都有一个 'name' 键，但不一定有 'age' 键。对于上面的示例，输出应该是：
>
> ```text
> Andre
> Sue
> ```

{{< details summary="**此问题的答案**" >}}
要查找并输出已知年龄至少为 30 岁的人的姓名，你可以使用列表推导式根据 'age' 键过滤字典，然后按字母顺序对结果姓名进行排序。以下是实现此目的的代码：

```python
people = [
    {'name': 'Paul', 'age': 25, 'weight': 165},
    {'height': 155, 'name': 'Sue', 'age': 30, 'weight': 123},
    {'weight': 205, 'name': 'Sam'},
    {'height': 156, 'name': 'Andre', 'age': 39, 'weight': 123}
]

names = [person['name'] for person in people if 'age' in person and person['age'] >= 30]
names.sort()

for name in names:
    print(name)
```

解释：

1. 我们从给定的字典列表 `people` 开始。

2. 我们使用列表推导式创建一个名为 `names` 的新列表。列表推导式遍历 `people` 列表中的每个字典 `person`。

3. 对于每个 `person` 字典，我们检查两个条件：
   - 首先，我们使用 `'age' in person` 条件检查字典中是否存在 'age' 键。这确保我们只考虑具有 'age' 键的字典。
   - 其次，我们使用 `person['age'] >= 30` 条件检查 'age' 键的值是否大于或等于 30。

4. 如果满足这两个条件，我们将 `person` 字典中 'name' 键的值包含在 `names` 列表中。

5. 列表推导式之后，我们得到一个列表 `names`，其中包含已知年龄至少为 30 岁的人的姓名。

6. 我们使用 `sort()` 方法按字母顺序对 `names` 列表进行排序。

7. 最后，我们遍历排序后的 `names` 列表中的每个 `name`，并逐个打印它们。

代码的输出将是：
```text
Andre
Sue
```

此代码根据年龄条件有效地过滤字典列表，提取姓名，按字母顺序排序，并按要求打印它们。
{{< /details >}}

### 创建城市到州的字典

> 给定一个字典，将州的名称与出现在其中的（某些）城市的名称列表相关联，编写一个函数，创建并返回一个新字典，将城市的名称与它出现的州的列表相关联。在函数中，按字母顺序输出唯一的城市——它们只出现在一个州中。例如，如果第一个字典如下所示：
>
> ```python
> states = {
>     'New Hampshire': ['Concord', 'Hanover'],
>     'Massachusetts': ['Boston', 'Concord', 'Springfield'],
>     'Illinois': ['Chicago', 'Springfield', 'Peoria']
> }
> ```
>
> 那么在函数执行后，新字典 cities 应该如下所示：
>
> ```python
> cities = {
>     'Hanover': ['New Hampshire'],
>     'Chicago': ['Illinois'],
>     'Boston': ['Massachusetts'],
>     'Peoria': ['Illinois'],
>     'Concord': ['New Hampshire', 'Massachusetts'],
>     'Springfield': ['Massachusetts', 'Illinois']
> }
> ```
>
> 并且输出的四个唯一城市应该是：
>
> ```text
> Boston
> Chicago
> Hanover
> Peoria
> ```
>
> 这是函数原型：
>
> ```python
> def create_cities(states):
> ```

{{< details summary="**此问题的答案**" >}}
这是一个 Python 函数，它创建一个新字典，将城市与它们出现的州关联起来，并按字母顺序输出唯一的城市：

```python
def create_cities(states):
    cities = {}
    unique_cities = []

    for state, city_list in states.items():
        for city in city_list:
            if city not in cities:
                cities[city] = [state]
            else:
                cities[city].append(state)

    for city, state_list in cities.items():
        if len(state_list) == 1:
            unique_cities.append(city)

    unique_cities.sort()

    for city in unique_cities:
        print(city)

    return cities
```

解释：

1. 我们定义函数 `create_cities`，它接受 `states` 字典作为输入。

2. 我们初始化一个名为 `cities` 的空字典来存储城市到州的映射。

3. 我们还初始化一个名为 `unique_cities` 的空列表来存储唯一个城市的名称。

4. 我们使用 `items()` 方法遍历 `states` 字典中的每个州及其对应的城市列表。

5. 对于城市列表中的每个城市，我们检查它是否已经作为键存在于 `cities` 字典中：
   - 如果城市不在 `cities` 字典中，我们将其作为键添加，并将当前州作为值的列表。
   - 如果城市已经在 `cities` 字典中，我们将当前州追加到该城市的现有州列表中。

6. 创建 `cities` 字典后，我们使用 `items()` 方法遍历 `cities` 字典中的每个城市及其对应的州列表。

7. 对于每个城市，我们检查其州列表的长度是否等于 1。如果是，则表示该城市只出现在一个州中，因此我们将城市名称追加到 `unique_cities` 列表中。

8. 我们使用 `sort()` 方法按字母顺序对 `unique_cities` 列表进行排序。

9. 我们遍历排序后的 `unique_cities` 列表中的每个城市，并逐个打印它们。

10. 最后，我们返回 `cities` 字典。

使用提供的示例 `states` 字典，函数的输出将是：
```text
Boston
Chicago
Hanover
Peoria
```

并且返回的 `cities` 字典将是：
```python
{
    'Concord': ['New Hampshire', 'Massachusetts'],
    'Hanover': ['New Hampshire'],
    'Boston': ['Massachusetts'],
    'Springfield': ['Massachusetts', 'Illinois'],
    'Chicago': ['Illinois'],
    'Peoria': ['Illinois']
}
```

此函数创建了所需的城市到州字典，按字母顺序输出唯一的城市，并返回 `cities` 字典。
{{< /details >}}

以下是我对您提供的文本的中文翻译：

### Rectangle 类方法

> 考虑以下 Rectangle 类的定义：
>
> ```python
> class Rectangle(object):
>     def __init__( self, u0, v0, u1, v1 ):
>         self.x0 = u0 # x0 和 y0 形成矩形的左下角
>         self.y0 = v0
>         self.x1 = u1 # x1 和 y1 形成矩形的右上角
>         self.y1 = v1
>         self.points = [] # 见 (b) 部分
> ```
>
> (a) 编写一个 `Rectangle` 类方法 contains，用于确定由 `x` 和 `y` 值表示的位置是否在矩形内。注意，在这个例子中，边界上的点也算在矩形内。例如：
>
> ```python
> r = Rectangle( 1, 3, 7, 10 )
> r.contains( 1, 4)
> True
> r.contains( 2,11) 
> False
> ```
>
> (b) 假设有第二个类：
>
> ```python
> class Point(object):
>     def __init__( self, x0, y0, id0 ):
>         self.x = x0
>         self.y = y0
>         self.id = id0
> ```
>
> 每个 `Rectangle` 存储一个 `Point` 对象列表，其坐标在矩形内。编写一个 Rectangle 类方法 `add_points`，将一个 `Point` 对象列表添加到 `Rectangle` 对象存储的现有（最初为空）`Point` 对象列表中。如果一个点在矩形边界之外，或者一个具有相同 id 的点已经在矩形的点列表中，则应忽略该点。否则，应将其添加到矩形的点列表中。你的方法必须使用 (a) 部分的 contains 方法。

{{< details summary="**A 部分的答案**" >}}
以下是 `Rectangle` 类的 `contains` 方法的实现：

```python
def contains(self, x, y):
    return self.x0 <= x <= self.x1 and self.y0 <= y <= self.y1
```

解释：
- `contains` 方法接受两个参数：`x` 和 `y`，表示要检查的点的坐标。
- 它检查给定的 `x` 和 `y` 值是否在矩形的边界内。
- 条件 `self.x0 <= x <= self.x1` 检查 `x` 是否在矩形的左右边界之间（包括边界）。
- 条件 `self.y0 <= y <= self.y1` 检查 `y` 是否在矩形的下上边界之间（包括边界）。
- 如果两个条件都为真，则表示该点在矩形内部或其边界上，方法返回 `True`。
- 否则，如果任一条件为假，则该点在矩形外部，方法返回 `False`。

使用示例：
```python
r = Rectangle(1, 3, 7, 10)
print(r.contains(1, 4))  # 输出：True
print(r.contains(2, 11))  # 输出：False
```

在第一个示例中，点 (1, 4) 在矩形内，因此 `contains` 返回 `True`。
在第二个示例中，点 (2, 11) 在矩形外，因此 `contains` 返回 `False`。
{{< /details >}}

{{< details summary="**B 部分的答案**" >}}
以下是 `Rectangle` 类的 `add_points` 方法的实现：

```python
def add_points(self, points):
    for point in points:
        if self.contains(point.x, point.y) and not any(p.id == point.id for p in self.points):
            self.points.append(point)
```

解释：
- `add_points` 方法接受一个 `Point` 对象列表作为参数。
- 它遍历 `points` 列表中的每个 `point`。
- 对于每个 `point`，它检查两个条件：
  1. 它调用 `contains` 方法（来自 a 部分）检查点的坐标（`point.x`，`point.y`）是否在矩形的边界内。
  2. 它使用 `any` 函数和生成器表达式检查具有与当前 `point` 相同 `id` 的点是否已经存在于矩形的 `points` 列表中。
- 如果两个条件都满足（即点在矩形内且 `points` 列表中不存在具有相同 `id` 的点），则使用 `self.points.append(point)` 将 `point` 添加到矩形的 `points` 列表中。
- 如果任一条件不满足（即点在矩形外或已存在具有相同 `id` 的点），则忽略 `point` 并且不将其添加到 `points` 列表中。

使用示例：
```python
r = Rectangle(1, 3, 7, 10)

p1 = Point(2, 5, 1)
p2 = Point(4, 8, 2)
p3 = Point(6, 12, 3)  # 在矩形外
p4 = Point(3, 6, 1)  # 与 p1 具有相同的 id

r.add_points([p1, p2, p3, p4])

for point in r.points:
    print(point.id)
```

输出：
```
1
2
```

在这个例子中：
- `p1` 和 `p2` 在矩形内且具有唯一的 `id`，因此它们被添加到 `points` 列表中。
- `p3` 在矩形外，因此被忽略。
- `p4` 与 `p1` 具有相同的 `id`，因此也被忽略。

添加点后，矩形的 `points` 列表只包含 `p1` 和 `p2`，如输出所示。
{{< /details >}}

### 代码输出

> 显示以下代码的输出：
> 
> ```python
> places = { 
>     'OR': {'Portland' : set(['Pearl District', 'Alameda']), 'Eugene' : set()},
>     'NY': {'Albany' : set(), 'NY' : set(['Chelsea', 'Harlem'])} 
> }
> print(places['OR']['Eugene'])
> a = []
> for place in places:
>     a += places[place].keys()
> print(a)
> for x in a:
>     if len(x) < 7:
>         print(x)
> for place in places:
>     if x in places[place]:
>         print(places[place][x])
> ```

{{< details summary="**这个问题的答案**" >}}
抱歉之前的回答有误。以下是给定代码的正确输出：

```
set()
['Portland', 'Eugene', 'Albany', 'NY']
Eugene
Albany
NY
{'Harlem', 'Chelsea'}
```

解释：
1. `print(places['OR']['Eugene'])`：
   - 这一行访问与字典 `places['OR']` 中的键 'Eugene' 相关联的值。
   - 与 'Eugene' 相关联的值是一个空集合 `set()`，因此它打印 `set()`。

2. `a = []` 和 `for place in places: a += places[place].keys()`：
   - 这些行初始化一个空列表 `a`，然后遍历 `places` 字典的键。
   - 对于每个键 `place`，它使用 `places[place].keys()` 检索嵌套字典 `places[place]` 的键，并将它们附加到列表 `a`。
   - 循环结束后，`a` 包含列表 `['Portland', 'Eugene', 'Albany', 'NY']`。

3. `print(a)`：
   - 这一行打印列表 `a`，即 `['Portland', 'Eugene', 'Albany', 'NY']`。

4. `for x in a: if len(x) < 7: print(x)`：
   - 这个循环遍历列表 `a` 中的每个元素 `x`。
   - 如果 `x` 的长度小于 7，它就打印 `x`。
   - 这个循环的输出是：
     ```
     Eugene
     Albany
     NY
     ```

5. `for place in places: if x in places[place]: print(places[place][x])`：
   - 这个循环遍历 `places` 字典中的每个键 `place`。
   - 它检查上一个循环的最后一个值 `x`（'NY'）是否是嵌套字典 `places[place]` 中的键。
   - 如果 'NY' 是 `places[place]` 中的键，它就打印与该键相关联的值。
   - 这个循环的输出是：
     ```
     {'Harlem', 'Chelsea'}
     ```
   - 打印行 `{'Harlem', 'Chelsea'}`，因为 'NY' 是 `places['NY']` 中的一个键，它打印与 'NY' 相关联的集合。

因此，代码的完整输出是：
```
set()
['Portland', 'Eugene', 'Albany', 'NY']
Eugene
Albany
NY
{'Harlem', 'Chelsea'}
```

我为之前答案中的混淆道歉。感谢您指出需要更正的地方。
{{< /details >}}

### 商家评论

> 假设给你一个名为 `businesses.txt` 的文件，其中每一行都包含一个商家的名称及其类别（单个值），后面是一系列评论分数，每个分数用 '|' 分隔。编写一段代码，读取这个文件，并打印所有商家的名称、类别以及每个商家的平均评论分数。同时打印该文件中唯一类别的总数。例如，对于下面的文件：
> 
> ```text
> Dinosaur Bar-B-Que|BBQ|5|4|4|4|5|5|4|2
> DeFazio's Pizzeria|Pizza|5|5|5|5|5|5|5|5|5|5|3|5|5|5
> I Love NY Pizza|Pizza|4|5|5|3
> ```
> 
> 你的程序应该打印：
> 
> ```text
> Dinosaur Bar-B-Que (BBQ): Score 4.125 
> DeFazio's Pizzeria (Pizza): Score 4.857
> I Love NY Pizza (Pizza): Score 4.250
> 2 categories found.
> ```

{{< details summary="**这个问题的答案**" >}}
这是一个 Python 脚本，它读取 `businesses.txt` 文件，计算每个商家的平均评论分数，并打印所需的信息：

```python
# 读取 businesses.txt 文件
with open('businesses.txt', 'r') as file:
    lines = file.readlines()

# 创建一个字典来存储类别及其对应的商家
categories = {}

# 处理文件中的每一行
for line in lines:
    # 将行拆分为商家名称、类别和评论分数
    data = line.strip().split('|')
    business_name = data[0]
    category = data[1]
    scores = [int(score) for score in data[2:]]

    # 计算平均评论分数
    average_score = sum(scores) / len(scores)

    # 将商家添加到字典中对应的类别
    if category in categories:
        categories[category].append((business_name, average_score))
    else:
        categories[category] = [(business_name, average_score)]

# 打印商家信息
for category, businesses in categories.items():
    for business_name, average_score in businesses:
        print(f"{business_name} ({category}): Score {average_score:.3f}")

# 打印唯一类别的总数
print(f"{len(categories)} categories found.")
```

解释：
1. 我们首先使用 `with` 语句以读取模式打开 `businesses.txt` 文件。这确保在我们读取完文件后文件被正确关闭。

2. 我们使用 `file.readlines()` 从文件中读取所有行，并将它们存储在 `lines` 列表中。

3. 我们创建一个名为 `categories` 的空字典来存储类别及其对应的商家。

4. 我们遍历 `lines` 列表中的每一行。

5. 对于每一行，我们使用 `line.strip().split('|')` 将其拆分为商家名称、类别和评论分数。`strip()` 方法用于删除行中的任何前导或尾随空格。

6. 我们使用列表推导式将评论分数从字符串转换为整数：`[int(score) for score in data[2:]]`。

7. 我们通过对所有分数求和并除以分数数量来计算平均评论分数。

8. 我们检查类别是否已经存在于 `categories` 字典中。如果存在，我们将商家名称和平均分数的元组追加到对应的列表中。如果不存在，我们创建一个包含商家名称和平均分数的新列表，并将其添加到字典中。

9. 处理完所有行后，我们遍历 `categories` 字典中的每个类别及其对应的商家。

10. 对于每个商家，我们使用 f-string 和所需的格式打印其名称、类别和平均评论分数。

11. 最后，我们通过获取 `categories` 字典的长度来打印唯一类别的总数。

当你使用提供的 `businesses.txt` 文件运行此脚本时，它将产生所需的输出：

```text
Dinosaur Bar-B-Que (BBQ): Score 4.125 
DeFazio's Pizzeria (Pizza): Score 4.857
I Love NY Pizza (Pizza): Score 4.250
2 categories found.
```
{{< /details >}}

### 直方图函数

> 编写一个函数，接受一个数字列表作为输入，并生成一个直方图。直方图为列表中每个数字的出现次数打印一个星号 (*)。例如，如果列表是：
> 
> ```python
> numbers = [5, 4, 1, 1, 3, 1, 2, 2, 4, 1]
> ```
> 
> 您的函数应该打印（按值排序）：
> 
> ```text
> 1: ****
> 2: **  
> 3: *
> 4: **
> 5: *
> ```
> 
> (a) 使用字典编写函数。您不能使用集合。
> 
> (b) 使用集合编写相同的函数。您不能使用字典（提示：对列表中的唯一项使用 `count`）。

{{< details summary="**A 部分的答案**" >}}
这是一个使用字典生成直方图的 Python 函数：

```python
def histogram_dict(numbers):
    # 创建一个字典来存储每个数字的计数
    count_dict = {}

    # 统计列表中每个数字的出现次数
    for num in numbers:
        if num in count_dict:
            count_dict[num] += 1
        else:
            count_dict[num] = 1

    # 打印直方图
    for num in sorted(count_dict.keys()):
        print(f"{num}: {'*' * count_dict[num]}")
```

解释：
1. 我们定义了一个名为 `histogram_dict` 的函数，它接受一个数字列表作为输入。

2. 我们创建一个名为 `count_dict` 的空字典来存储列表中每个数字的计数。

3. 我们遍历 `numbers` 列表中的每个数字 `num`。

4. 对于每个数字，我们检查它是否已经存在于 `count_dict` 中作为键：
   - 如果存在，我们将其计数增加 1。
   - 如果不存在，我们将其添加到字典中，初始计数为 1。

5. 在统计每个数字的出现次数后，我们使用 `sorted(count_dict.keys())` 对 `count_dict` 的键进行排序迭代。这确保直方图按数字的升序打印。

6. 对于每个数字 `num`，我们打印数字后跟一个冒号，然后根据其在 `count_dict` 中的计数打印相应数量的星号 (`*`)。我们使用 `'*' * count_dict[num]` 表达式将星号字符重复 `count_dict[num]` 次。

使用示例：
```python
numbers = [5, 4, 1, 1, 3, 1, 2, 2, 4, 1]
histogram_dict(numbers)
```

输出：
```text
1: ****
2: **
3: *
4: **
5: *
```

这个函数使用字典来统计每个数字的出现次数，然后根据计数打印直方图。
{{< /details >}}

{{< details summary="**B 部分的答案**" >}}
这是一个使用集合生成直方图的 Python 函数：

```python
def histogram_set(numbers):
    # 创建一个集合来存储唯一的数字
    unique_nums = set(numbers)

    # 打印直方图
    for num in sorted(unique_nums):
        count = numbers.count(num)
        print(f"{num}: {'*' * count}")
```

解释：
1. 我们定义了一个名为 `histogram_set` 的函数，它接受一个数字列表作为输入。

2. 我们通过将 `numbers` 列表传递给 `set()` 构造函数来创建一个名为 `unique_nums` 的集合。这会自动删除任何重复的数字，并给我们一个唯一数字的集合。

3. 我们使用 `sorted(unique_nums)` 对 `unique_nums` 集合中的每个数字 `num` 进行排序迭代。这确保直方图按数字的升序打印。

4. 对于每个唯一数字 `num`，我们在原始列表 `numbers` 上使用 `count()` 方法来统计该数字在原始列表中的出现次数。我们将计数存储在 `count` 变量中。

5. 我们打印数字后跟一个冒号，然后根据其计数打印相应数量的星号 (`*`)。我们使用 `'*' * count` 表达式将星号字符重复 `count` 次。

使用示例：
```python
numbers = [5, 4, 1, 1, 3, 1, 2, 2, 4, 1]
histogram_set(numbers)
```

输出：
```text
1: ****
2: **
3: *
4: **
5: *
```

这个函数使用集合来存储唯一的数字，然后使用 `count()` 方法统计原始列表中每个唯一数字的出现次数。它根据计数打印直方图。

注意：使用集合消除了单独计数步骤的需要，因为我们可以直接在原始列表上对每个唯一数字使用 `count()` 方法。
{{< /details >}}

### 校友信息

> 给你一个如下所示的 RPI 校友列表。列表中的每个项目都是一个包含校友信息的字典，所有项目都具有相同的键。编写一段代码，打印 2013 年之前毕业的每个人的姓名和地址。例如，给定列表：
> 
> ```python
> alums = [{'fname':'Abed', 'lname':'Nadir', 'graduated':2012, 'addresses':['Troy&Abed apt.','Abed&Annie apt.']}, {'fname':'Troy', 'lname':'Barnes', 'graduated':2013, 'addresses':['Troy&Abed apt.']}, {'fname':'Britta', 'lname':'Perry', 'graduated':2012, 'addresses':['1 Revolution lane']}]
> ```
> 
> 您的代码应该打印（所有信息按照它在列表中出现的顺序打印）：
> 
> ```text
> Abed Nadir
> Troy&Abed apt.
> Abed&Annie apt.
> Britta Perry 
> 1 Revolution lane
> ```

{{< details summary="**这个问题的答案**" >}}
这是打印 2013 年之前毕业的每个人的姓名和地址的 Python 代码：

```python
alums = [
    {'fname': 'Abed', 'lname': 'Nadir', 'graduated': 2012, 'addresses': ['Troy&Abed apt.', 'Abed&Annie apt.']},
    {'fname': 'Troy', 'lname': 'Barnes', 'graduated': 2013, 'addresses': ['Troy&Abed apt.']},
    {'fname': 'Britta', 'lname': 'Perry', 'graduated': 2012, 'addresses': ['1 Revolution lane']}
]

for alum in alums:
    if alum['graduated'] < 2013:
        print(alum['fname'], alum['lname'])
        for address in alum['addresses']:
            print(address)
```

解释：
1. 我们从给定的校友列表开始，其中每个校友由一个包含他们信息的字典表示。

2. 我们遍历 `alums` 列表中的每个 `alum` 字典。

3. 对于每个 `alum`，我们检查他们的毕业年份（`alum['graduated']`）是否小于 2013。此条件过滤掉 2013 年之前毕业的校友。

4. 如果条件为真，我们继续打印校友的姓名和地址。

5. 我们使用 `print()` 函数打印校友的名字（`alum['fname']`）和姓氏（`alum['lname']`）。

6. 然后我们遍历 `alum['addresses']` 列表中的每个 `address`。

7. 对于每个 `address`，我们使用 `print()` 函数在单独的行上打印它。

8. 处理完所有校友后，代码将打印 2013 年之前毕业的每个人的姓名和地址。

输出：
```text
Abed Nadir
Troy&Abed apt.
Abed&Annie apt.
Britta Perry
1 Revolution lane
```

这段代码遍历校友列表，检查他们的毕业年份，并打印 2013 年之前毕业的人的姓名和地址。信息按照它在列表中出现的顺序打印。
{{< /details >}}

以下是我对给定英文文本的中文翻译：

### 文件行提取

> 编写一个名为 `get_line(fname,lno,start,end)` 的函数，该函数接受一个文件名 `fname`、一个行号 `lno` 以及给定行上的起始点和结束点 ( `start`, `end` ) 作为输入。函数应返回包含从起始点到结束点之前 ( 但不包括结束点 ) 该行上所有字符的字符串 ( 与字符串切片相同！)。
>
> 行号从 1 开始；一行中的字符从零开始计数，并包括最后的换行符。如果行数少于 `lno`，则函数应返回 None。如果 `lno` 行的字符数少于 `end`，则返回一个空字符串。
>
> 给定文件 `hpss.txt` 的以下内容：
>
> ```text
> Nearly ten years had passed since the Dursleys had
> woken up to find their nephew on the front step.
> Privet Drive had hardly changed at
> all.
> ```
>
> 以下程序：
>
> ```python
> print('1:', get_line('hpss.txt', 2, 9, 15))
> print('2:', get_line('hpss.txt', 5, 5, 9))
> print('3:', get_line('hpss.txt', 5, 0, 4))
> print('4:', get_line('hpss.txt', 8, 0, 10))
> ```
>
> 应输出 ( 注意对于 3，换行符也包含在返回的字符串中 )：
>
> ```text
> 1: to fin
> 2:
> 3: all.
> 4: None
> ```

{{< details summary="**此问题的答案**" >}}
以下是 Python 中 `get_line` 函数的实现：

```python
def get_line(fname, lno, start, end):
    try:
        with open(fname, 'r') as file:
            lines = file.readlines()
            if lno <= len(lines):
                line = lines[lno - 1]
                if end <= len(line):
                    return line[start:end]
                else:
                    return ''
            else:
                return None
    except FileNotFoundError:
        return None
```

解释：
1. 我们定义了 `get_line` 函数，它接受四个参数：`fname` ( 文件名 )、`lno` ( 行号 )、`start` ( 起始点 ) 和 `end` ( 结束点 )。

2. 我们使用 `try` 块来处理文件可能不存在的情况。

3. 在 `try` 块内，我们使用 `with` 语句以读取模式打开由 `fname` 指定的文件。这确保在我们读取完文件后文件被正确关闭。

4. 我们使用 `file.readlines()` 读取文件中的所有行，并将它们存储在 `lines` 列表中。

5. 我们检查请求的行号 `lno` 是否小于或等于文件中的总行数 ( `len(lines)` )。

6. 如果条件为真，我们从 `lines` 列表中检索索引为 `lno - 1` 的行 ( 因为行号从 1 开始，但列表索引从 0 开始 )。

7. 然后我们检查请求的结束点 `end` 是否小于或等于检索到的行的长度 ( `len(line)` )。

8. 如果条件为真，我们使用字符串切片 ( `line[start:end]` ) 返回从索引 `start` 开始到索引 `end` ( 但不包括 ) 的行的子字符串。

9. 如果结束点 `end` 大于行的长度，我们返回一个空字符串 ( `''` )。

10. 如果请求的行号 `lno` 大于文件中的总行数，我们返回 `None`。

11. 如果发生 `FileNotFoundError` ( 即文件不存在 )，我们捕获异常并返回 `None`。

现在，让我们使用给定的程序测试 `get_line` 函数：

```python
print('1:', get_line('hpss.txt', 2, 9, 15))
print('2:', get_line('hpss.txt', 5, 5, 9))
print('3:', get_line('hpss.txt', 5, 0, 4))
print('4:', get_line('hpss.txt', 8, 0, 10))
```

输出：
```text
1: to fin
2:
3: all.
4: None
```

输出解释：
1. 对于第一种情况，函数返回第二行从索引 9 到 14 ( 包括 ) 的子字符串，即 `"to fin"`。

2. 对于第二种情况，函数返回一个空字符串，因为第五行没有足够的字符可以从索引 5 提取到 8。

3. 对于第三种情况，函数返回第五行从索引 0 到 3 ( 包括 ) 的子字符串，即 `"all."`。返回的字符串中也包括换行符。

4. 对于第四种情况，函数返回 `None`，因为文件中没有第八行。

`get_line` 函数正确处理请求的行号或结束点超过文件中可用行数或字符数的情况。
{{< /details >}}

### 最冷的年份

> 假设在字典 `temp` 中给你特洛伊 12 月的平均温度，如下所示。字典的键是年份，值是该年的平均温度。编写一段代码，根据这个字典找到并打印出前三个最冷的年份。注意：如果值有并列，任何年份的顺序都是可以接受的。
>
> 例如，给定以下字典：
>
> ```python
> temp = { 2001: 36.4, 2002: 27.4, 2003: 29.3, 2004: 28.6, 2005: 27.8,
> 2006: 37.3, 2007: 28.1, 2008: 30.2, 2010: 26.0, 2011: 35.4,
> 2012: 33.8, 2013: 27.9, 2014: 32.8}
> ```
>
> 你的程序应该输出：
>
> ```text
> 2010: 26.0
> 2002: 27.4
> 2005: 27.8
> ```

{{< details summary="**此问题的答案**" >}}
要根据字典中提供的平均温度数据找到前三个最冷的年份，你可以按升序对字典项进行排序，并打印前三个项。以下是实现这一点的代码：

```python
temp = {2001: 36.4, 2002: 27.4, 2003: 29.3, 2004: 28.6, 2005: 27.8,
        2006: 37.3, 2007: 28.1, 2008: 30.2, 2010: 26.0, 2011: 35.4,
        2012: 33.8, 2013: 27.9, 2014: 32.8}

# 按升序对字典项进行排序
sorted_temp = sorted(temp.items(), key=lambda x: x[1])

# 打印前三个最冷的年份
for year, temperature in sorted_temp[:3]:
    print(f"{year}: {temperature}")
```

解释：

1. 定义了 `temp` 字典，其中包含每年的给定平均温度数据。

2. 我们使用 `sorted()` 函数按升序对字典项进行排序。`items()` 方法用于从字典中获取键值对列表。`key` 参数设置为 `lambda x: x[1]`，这意味着排序将基于每个项元组的第二个元素 ( 即温度值 )。

3. 排序后的项存储在 `sorted_temp` 列表中，其中每个项是包含年份及其对应温度的元组。

4. 我们使用 `for` 循环遍历 `sorted_temp` 的前三个项，并将每个项解包到变量 `year` 和 `temperature` 中。

5. 最后，我们使用 f-string 打印每个年份及其对应的温度，f-string 允许我们直接在字符串中嵌入变量。

输出将是：
```text
2010: 26.0
2002: 27.4
2005: 27.8
```

此代码将根据字典中提供的平均温度数据找到并打印前三个最冷的年份。如果温度值有并列，则并列年份的任何顺序都是可以接受的。
{{< /details >}}

### 感恩节晚餐菜单

> 假设在你的程序中给你三个变量 `t1`、`t2`、`t3`。每个变量都是一个集合，包含你被邀请参加的三个不同感恩节晚餐的菜单。
> 首先，打印出所有三个晚餐菜单中都有的项目。然后，打印出只在一个晚餐菜单中出现的项目。所有项目应按字母顺序列出。
>
> 例如，如果给你的菜单是：
>
> ```python
> t1 = set(['Turkey', 'Potatoes', 'Green Beans', 'Cranberry', 'Gravy'])
> t2 = set(['Turkey', 'Yams', 'Stuffing', 'Cranberry', 'Marshmallows'])
> t3 = set(['Turkey', 'Gravy', 'Yams', 'Green Beans', 'Cranberry', 'Turducken'])
> ```
>
> 你的程序必须打印以下内容 ( 你的输出应与我们的相匹配 )：
>
> ```text
> Items in all three dinners: Cranberry, Turkey
> Items in exactly one dinner: Marshmallows, Potatoes, Stuffing, Turducken
> ```

{{< details summary="**此问题的答案**" >}}
要找出所有三个晚餐菜单中都有的项目以及只在一个晚餐菜单中出现的项目，你可以使用集合操作。以下是实现这一点的代码：

```python
t1 = set(['Turkey', 'Potatoes', 'Green Beans', 'Cranberry', 'Gravy'])
t2 = set(['Turkey', 'Yams', 'Stuffing', 'Cranberry', 'Marshmallows'])
t3 = set(['Turkey', 'Gravy', 'Yams', 'Green Beans', 'Cranberry', 'Turducken'])

# 找出所有三个晚餐中的项目
common_items = t1.intersection(t2, t3)
print("Items in all three dinners:", ', '.join(sorted(common_items)))

# 找出只在一个晚餐中的项目
unique_items = (t1 ^ t2 ^ t3) - (t1 & t2) - (t1 & t3) - (t2 & t3)
print("Items in exactly one dinner:", ', '.join(sorted(unique_items)))
```

解释：

1. 定义了集合 `t1`、`t2` 和 `t3`，其中包含每个感恩节晚餐的给定菜单项目。

2. 要找出所有三个晚餐菜单中都有的项目，我们使用 `intersection()` 方法。它返回一个新集合，其中包含所有集合中的公共元素。我们将 `t1`、`t2` 和 `t3` 作为参数传递给 `intersection()`，这给了我们所有三个集合中都存在的项目。

3. 我们使用 `print()` 打印公共项目。`sorted()` 函数用于按字母顺序对项目进行排序，`', '.join()` 用于将项目连接成逗号分隔的字符串。

4. 要找出只在一个晚餐菜单中出现的项目，我们使用以下集合操作：
   - `t1 ^ t2 ^ t3` 对所有三个集合执行对称差 (XOR) 操作。它给出了只在其中一个集合中的项目。
   - `(t1 & t2)`、`(t1 & t3)` 和 `(t2 & t3)` 对集合对执行交集操作。这给出了每对集合之间的公共项目。
   - 我们从对称差操作的结果中减去集合对之间的公共项目。这给出了只在一个晚餐中的项目。

5. 最后，我们使用 `print()` 打印唯一项目，再次按字母顺序对它们进行排序，并将它们连接成逗号分隔的字符串。

输出将是：
```text
Items in all three dinners: Cranberry, Turkey
Items in exactly one dinner: Marshmallows, Potatoes, Stuffing, Turducken
```

此代码找到并按字母顺序打印出所有三个晚餐菜单中都有的项目以及只在一个晚餐菜单中出现的项目。
{{< /details >}}

### 算法运行时间

> 以下算法的运行时间是多少：
>
> (a) 列表中的成员测试 ( `list.index(value)` )
>
> (b) 集合中的成员测试 ( `value in set` )
>
> (c) 遍历整个列表的嵌套 for 循环

{{< details summary="**A 部分的答案**" >}}
使用 `list.index(value)` 在列表中进行成员测试的运行时间是 O(n)，其中 n 是列表中元素的数量。

解释：
- `list.index(value)` 方法在列表中搜索指定值的第一次出现。
- 在最坏的情况下，该值可能位于列表的末尾或根本不存在于列表中。
- 该方法需要从头开始遍历列表，直到找到该值或到达列表的末尾。
- 随着列表大小的增加，需要搜索的元素数量呈线性增长。
- 因此，`list.index(value)` 的运行时间与列表的大小成正比，导致时间复杂度为 O(n)。
{{< /details >}}

{{< details summary="**B 部分的答案**" >}}
使用 `value in set` 在集合中进行成员测试的平均运行时间是 O(1)。

解释：
- Python 中的集合是使用哈希表实现的。
- `value in set` 操作检查指定值是否存在于集合中。
- 在哈希表中，元素根据其哈希值存储，这允许高效的检索。
- 平均而言，在哈希表中搜索元素的时间复杂度为 O(1)，即常数时间。
- 这是因为集合使用的哈希函数将元素均匀地分布在哈希表中，最小化了冲突。
- 即使存在冲突，哈希表中每个"桶"中的元素数量预计很小，导致平均查找时间为常数。
- 因此，`value in set` 的平均运行时间为 O(1)，与集合的大小无关。
{{< /details >}}

{{< details summary="**C 部分的答案**" >}}
遍历整个列表的嵌套 for 循环的运行时间是 O(n^2)，其中 n 是列表中元素的数量。

解释：
- 当你有遍历同一个列表的嵌套 for 循环时，总迭代次数是每个循环中迭代次数的乘积。
- 如果列表有 n 个元素，外层循环将迭代 n 次。
- 对于外层循环的每次迭代，内层循环也将迭代 n 次。
- 因此，总迭代次数为 n * n = n^2。
- 随着列表大小的增加，迭代次数呈二次方增长。
- 遍历整个列表的嵌套 for 循环的运行时间与列表大小的平方成正比，导致时间复杂度为 O(n^2)。
- 这表明，随着列表大小的增加，运行时间会迅速增长，与具有较低时间复杂度的算法相比，对于大型列表来说效率较低。
{{< /details >}}