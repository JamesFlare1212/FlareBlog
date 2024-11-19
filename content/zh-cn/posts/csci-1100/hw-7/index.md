---
title: CSCI 1100 - 作业 7 - 字典
subtitle:
date: 2024-09-12T15:36:47-04:00
slug: csci-1100-hw-7
draft: false
author:
  name: James
  link: https://www.jamesflare.com
  email:
  avatar: /site-logo.avif
description: 这篇博客文章概述了一个满分100分的家庭作业，截止日期为2024年3月28日，重点是Python字典操作。该作业包括两部分内容：自动更正程序和电影评分分析，都需要仔细处理数据文件和字典操作。
keywords: ["Python", "字典"]
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
summary: 这篇博客文章概述了一个满分100分的家庭作业，截止日期为2024年3月28日，重点是Python字典操作。该作业包括两部分内容：自动更正程序和电影评分分析，都需要仔细处理数据文件和字典操作。
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

## 作业概述
  
该作业总分为100分，截止日期为2024年3月28日星期四晚上11:59:59。
  
本作业包含两部分，每部分各占50分。请下载`hw7_files.zip`并将其解压到你的HW7目录下。你将找到多个将在两个部分中使用的数据文件。

本次作业的目标是使用字典进行编程。在第一部分中，你需要做一些简单的文件处理工作，请仔细阅读指导说明。在第二部分中，我们已经为你完成了所有的文件操作，因此你应该只需几行代码就可以完成任务了。对于两部分中的每一部分，你将花费大部分时间来操作给定的各种文件中的字典。

请记得将你的文件命名为`hw7_part1.py`和`hw7_part2.py`。

一如既往，请确保遵循程序结构的指导方针。我们将根据程序正确性和良好的程序结构进行评分。

同样要提醒的是，我们会继续对作业相似度进行检测。因此，请务必遵守我们关于合作程度的规定。如果你需要复习这些规定，可以从Submitty课程资源部分下载指南。请注意，这包括使用以前学期某位同学的代码。请确保你提交的代码确实是你自己写的。

### 荣誉声明

在家庭作业中出现了许多学术不端行为，这种情况必须改变。利用自动化工具很容易发现这些案件，并由讲师验证。这种做法会导致严重的分数扣减、不良的学习效果、挫折感以及浪费所有相关人员宝贵的资源时间。为了缓解这一问题，以下是课程诚信政策的重申形式：

- 我没有向本班级中的任何人展示我的代码，特别是用于指导他们自己的工作。
- 我没有复制另一位同学或以前学期学生的代码（无论是修改过的还是未修改过的）。
- 我没有使用在网络上找到或购买的解决方案完成这项作业。
- 我提交的工作是我自己写的，并且我完全理解并遵守这一承诺
- 如果我发现违反了上述任何一条，将在这次作业中得到零分，并额外扣除10分总成绩。

在你提交你的家庭作业之前，你需要同意这些单独声明。

请明白如果你是绝大多数遵循规则的学生之一——只是与其他同学一起了解问题描述、Python结构和解决方案方法——那么你就不会遇到任何麻烦。

## 第一部分：自动更正

我们所有人都使用过自动更正来修正我们在写作时的各种拼写错误，但你是否想过它是如何工作的呢？这里有一个小型的自动更正程序，它会查找一些常见的打字错误。

要解决这个问题，你的程序将读取三个文件的名字：

- 第一个包含有效单词及其频率的列表，
- 第二个包含需要自动更正的单词列表，
- 第三个包含可能的字母替换（如下所述）。

输入单词文件每行有两个条目；第一项是单个有效的英文单词，第二项是一个表示该词在词汇表中的频次的浮点数。这两个值之间用逗号分隔。

读取这个英语字典并将其转换为Python字典：使用单词作为键和频率作为值。你将利用这些频率来决定多个可能更正中最有可能的一个。

键盘文件每一行对应一个字母，第一项是需要替换的字母，其余的是该字母可能的替换选项。这一行中的所有字母之间用空格分隔。这些替代方案基于键盘上的相邻关系计算得出，所以如果你查看一下你的键盘，会发现“a”键周围有“q”，“w”，“s”，和“z”。其他替代方案也是类似方式计算出来的，例如：

```text
b v f g h n
```

这意味着`b`的可能替换可以是`v`, `f`, `g`, `h`, 或者 `n`。读取这个键盘文件并将其转换为字典：第一个字母作为键（如 b），其余字母作为值，存储为列表。

你的程序将遍历输入文件中的每一个单词，对每个单词进行自动更正，并打印出更正结果。为了修正一个单独的单词，你将考虑以下情况：

- **找到**：如果这个单词在字典中，它就是正确的。不需要任何更改。将其打印为“找到”，然后继续下一个单词。
- 否则，请考虑所有剩余的可能性。

  - **删除**：如果没有找到该词，则考虑从该词中删除一个字母的所有可能方式。将任何有效单词（即在你的英文字典中的单词）存储在一个容器（列表/集合/字典）中，这些将是候选更正。
  - **插入**：如果该词不存在，则考虑向该词插入一个单个字母的所有可能方式。将所有有效单词存储在一个容器（列表/集合/字典）中，这些将是候选更正。
  - **交换**：考虑从该词交换两个连续字母的所有方式。将任何有效单词存储在一些容器（列表/集合/字典）中，这些将是候选更正。
  - **替换**：接下来，考虑使用键盘文件中存在的可能替换对单个字母进行更改的所有可能性。将所有有效单词存储在一个容器（列表/集合/字典）中，这些将是候选更正。

例如，对于给定的键盘文件来说，`b` 的可能替换为 `v f g h n`。因此，如果你在 `abar` 中替换 `b`，你应该考虑：`avar`, `afar`, `agar`, `ahar`, `anar`。

经过上述所有步骤后，如果有多于一个潜在匹配，则按其在英语字典中的频率进行排序，并返回使用最频繁的前三个值作为最可能的更正结果。如果有三或更少个潜在匹配，请按顺序打印它们。在这种不太可能发生的情况下，两个单词基于频率相等时，你应该选择字典序靠后的那个。

如果没有任何上述更正方法的有效匹配，则打印“未找到”。否则，在一行中打印该词（15个空格），匹配的数量，并且最多三个匹配项。

你程序的一个示例输出包含在文件 `part1_output_01.txt` 中。注意，我们在Submitty上将使用一个更广泛的字典，因此你的结果可能与你在笔记本电脑上的不同。

当你确定作业正确无误后，请将其提交到 Submitty。你的程序必须命名为 `hw7_part1.py` 才能正常工作。

### 注意事项：

1. 不要写循环来搜索字符串（单词或字母）是否在字典中！这将非常慢，并可能导致Submitty终止你的程序（并且你将失去大量分数）。相反，你应该使用 `in` 操作符。
2. 可能，但不太可能，候选替换词会被生成多次。我们建议你在查找之前先将所有可能的候选替换存储在一个集合中。
3. 通过频率排序潜在匹配项可以简单处理。对于每个潜在匹配项，创建一个元组，首先包含频率值，然后是单词。将其添加到列表中并按反向顺序对列表进行排序。例如，如果列表为 `v`，则只需使用代码：`v.sort(reverse=True)`

## 第二部分：评分高和低的电影...

在这个部分，我们将提供两个数据文件 `movies.json` 和 `ratings.json`，格式是 JSON 数据格式。第一个数据文件是从 IMDB 直接获取的电影信息，包括一些但不是所有电影的评分。第二个文件包含来自 Twitter 的评分。

请注意：并非所有的电影在 `movies.json` 中都有对应的评级，也并非所有的电影在 `ratings.json` 中都有相关的电影信息。

这些数据可以通过以下五行代码完整读取：

```python
import json

if __name__ == "__main__":
    movies = json.loads(open("movies.json").read())
    ratings = json.loads(open("ratings.json").read())
```

两个文件都以字典的形式存储数据。第一个字典使用电影 ID 作为键，值是一个包含电影属性列表的第二个字典。例如：

```python
print(movies['3520029'])
(movie with id '3520029') produces the output:
{'genre': ['Sci-Fi', 'Action', 'Adventure'], 'movie_year': 2010, 
'name': 'TRON: Legacy', 'rating': 6.8, 'numvotes': 254865}
```

这相当于：

```python
movies = dict()
movies['3520029'] = {'genre': ['Sci-Fi', 'Action', 'Adventure'], 
'movie_year': 2010, 'name': 'TRON: Legacy',
'rating': 6.8, 'numvotes': 254865}
```

如果我们想获取每个电影的单独信息，可以使用以下命令：

```python
print(movies['3520029']['genre'])
print(movies['3520029']['movie_year'])
print(movies['3520029']['rating'])
print(movies['3520029']['numvotes'])
```

这将提供以下输出：

```python
['Sci-Fi', 'Action', 'Adventure']
2010
6.8
254865
```

第二个字典同样使用电影 ID 作为键，值是一个评分列表。例如，

```python
print(ratings['3520029'])
(movie with id '3520029') produces the output:
[6, 7, 7, 7, 8]
```

因此，这部电影有五个评分：6、7、7、7 和 8。

现在开始作业：

### 问题描述

在这个家庭作业中，假设你有两个名为 `movies.json` 和 `ratings.json` 的文件。请从这些文件中读取数据，并让用户输入一个年份范围（最小和最大年份）以及两个权重：`w1` 和 `w2`。找到在 min 到 max 年之间制作的所有电影（包含 min 和 max）。对于每部电影，计算其综合评分为：

```python
(w1 * imdb_rating + w2 * average_twitter_rating) / (w1 + w2)
```

其中 `imdb_rating` 来自于 movies 文件，而 `average_twitter_rating` 是 ratings 文件中的平均评分。

如果某部电影没有在 Twitter 上被评分，或者其 Twitter 评分少于三个条目，则跳过该电影。然后反复询问用户输入一个电影类型，并返回该类型的最佳和最差电影（基于给定年份和计算出的评分）。重复此操作直到用户输入“stop”。

程序运行的一个示例（在你使用 Spyder 运行时的样子）包含在文件 `hw7_part2_output_01.txt` 中（每部电影第二行有8个空格，评分为 `{:.2f}` 格式）。

我们提供的用于测试的电影是一个子集，在 Submitty 上进行测试时会有所不同，所以当你提交作业时可能会看到不同之处。

当你确定你的程序正确无误后，请将其提交到 Submitty。你的程序必须命名为 `hw7_part2.py` 才能正常工作。

### 排序的一般提示

有可能两部电影的评分相同。考虑以下代码：

```python
>>> example = [(1, "b"), (1, "a"), (2, "b"), (2, "a")]
>>> sorted(example)
[(1, 'a'), (1, 'b'), (2, 'a'), (2, 'b')]
>>> sorted(example, reverse=True)
[(2, 'b'), (2, 'a'), (1, 'b'), (1, 'a')]
```

注意，排序是基于索引 0 的值进行的，但如果出现并列情况，则根据索引 1 的值来决定。如果在索引 0 和索引 1 都有并列时，排序将继续使用索引 2 的值（如果有）以此类推。对列表列表也是一样的关系。

为了确定最佳和最差电影，示例代码中用了一个将评分放在索引 0 处、名字放在索引 1 处的排序方法。在你决定最佳和最差电影时，请记住这一点。
  
## 支持文件

{{< link href="HW7.zip" content="HW7.zip" title="Download HW7.zip" download="HW7.zip" card=true >}}

## 解决方案

> [!NOTE]
> 我在这个作业中没有得到满分（只有 96%），所以你不应该相信每一行代码。我可能会重新做一遍以获得满分，之后会将它添加在这里。

### hw7_part1.py

```python
"""
An implementation of HW7 Part 1
"""

# Global Variables
word_path = ""
#word_path = "/mnt/c/Users/james/OneDrive/RPI/Spring 2024/CSCI-1100/Homeworks/HW7/hw7_files/"

# Debugging Variables
dictionary_file = "words_10percent.txt"
input_file = "input_words.txt"
keyboard_file = "keyboard.txt"

def get_dictionary(file_name):
    words_dict = dict()
    data = open(file_name, 'r')
    for lines in data:
        lines = lines.strip()
        the_key = lines.split(",")[0]
        the_value = float(lines.split(",")[1])
        words_dict[the_key] = the_value
    data.close()
    return words_dict

def get_keyboard(file_name):
    keyboard_dict = dict()
    data = open(file_name, 'r')
    for lines in data:
        lines = lines.strip()
        the_key = lines.split(" ")[0]
        keyboard_dict[the_key] = []
        for i in lines.split(" ")[1:]:
            keyboard_dict[the_key].append(i)
    data.close()
    return keyboard_dict

def check_in_dictionary(word, dictionary):
    if word in dictionary:
        return True
    return False

def get_input_words(file_name):
    input_words = []
    file = open(file_name, 'r')
    for lines in file:
        lines = lines.strip()
        input_words.append(lines)
    file.close()
    return input_words

def get_drop_words(word):
    drop_words = set()
    for i in range(len(word)):
        drop_words.add(word[:i] + word[i+1:])
    return drop_words

def get_insert_words(word):
    insert_words = set()
    alphabet = "abcdefghijklmnopqrstuvwxyz"
    for i in range(len(word)+1):
        for j in alphabet:
            insert_words.add(word[:i] + j + word[i:])
            #print("Inserting: ", word[:i] + j + word[i:])
    return insert_words

def get_swap_words(word):
    swap_words = set()
    for i in range(len(word) - 1):
        swap_words.add(word[:i] + word[i+1] + word[i] + word[i+2:])
    return swap_words

def get_replace_words(word, keyboard):
    replace_words = set()
    #print(keyboard)
    for i in range(len(word)):
        for j in range(len(word[i])):
            for k in keyboard[word[i][j]]:
                replace_words.add(word[:i] + k + word[i+1:])
    return replace_words

def get_all_possible_words(word, keyboard):
    all_possible_words = set()
    all_possible_words.update(get_drop_words(word))
    all_possible_words.update(get_insert_words(word))
    all_possible_words.update(get_swap_words(word))
    all_possible_words.update(get_replace_words(word, keyboard))
    return all_possible_words

def get_suggestions(word, dictionary, keyboard):
    suggestions = dict()
    all_possible_words = get_all_possible_words(word, keyboard)
    for i in all_possible_words:
        if i in dictionary:
            suggestions[i] = dictionary[i]
    topx = sorted(suggestions, key=lambda x: (suggestions[x], x), reverse=True)
    #print(topx)
    return topx

def construct_output(input_words, dictionary, keyboard):
    output = ""
    max_length = max([len(i) for i in input_words])
    for i in input_words:
        output += "    " + " " * (max_length - len(i)) + i + " -> "
        if check_in_dictionary(i, dictionary):
            output += "FOUND"
        elif len(get_suggestions(i, dictionary, keyboard)) == 0:
            output += "NOT FOUND"
        else:
            output += "FOUND {:2d}".format(len(get_suggestions(i, dictionary, keyboard))) + ": "
            suggestions = get_suggestions(i, dictionary, keyboard)[:3]
            for j in suggestions:
                output += " " + j
        output += "\n"
    return output

if __name__ == "__main__":
    dictionary_file = input("Dictionary file => ").strip()
    print(dictionary_file)
    input_file = input("Input file => ").strip()
    print(input_file)
    keyboard_file = input("Keyboard file => ").strip()
    print(keyboard_file)
    
    dictionary = get_dictionary(word_path + dictionary_file)
    #print(dictionary)
    keyboard = get_keyboard(word_path + keyboard_file)
    #print(keyboard)
    #print(get_input_words(word_path + input_file))
    #print(get_drop_words("hello"))
    #print("shut" in get_insert_words("shu"))
    #print(get_swap_words("hello"))
    #print("integers" in get_replace_words("inteters", keyboard))
    #print(get_all_possible_words("hello", keyboard))
    #print(get_suggestions("doitd", dictionary, keyboard))
    print(construct_output(get_input_words(word_path + input_file), dictionary, keyboard), end = "")
```

### hw7_part2.py

```python
"""
An implementation of HW7 Part 2
"""
import json

# Global Variables
word_path = ""
#word_path = "/mnt/c/Users/james/OneDrive/RPI/Spring 2024/CSCI-1100/Homeworks/HW7/hw7_files/"
genre = ""

# Debugging Variables
#min_year = 2000
#max_year = 2016
#imdb_weight = 0.7
#twitter_weight = 0.3
#genre = "sci-fi"

def get_movie_ids(movies, min_year, max_year):
    ids = set()
    for i in movies.keys():
        if movies[i]['movie_year'] >= min_year and movies[i]['movie_year'] <= max_year:
            ids.add(int(i))
    return ids
            
def get_imdb_rating(movies, movie_id):
    return float(movies[str(movie_id)]['rating'])

def get_twitter_rating(ratings, movie_id):
    if str(movie_id) in ratings.keys():
        return ratings[str(movie_id)]
    else:
        return []

def get_num_twitter_ratings(ratings, movie_id):
    return len(get_twitter_rating(ratings, movie_id))

def get_weighted_rating(movies, ratings, movie_id, imdb_weight, twitter_weight):
    imdb = get_imdb_rating(movies, movie_id)
    twitter = 0.0
    for i in get_twitter_rating(ratings, movie_id):
        twitter += i
    twitter /= len(get_twitter_rating(ratings, movie_id))
    return (imdb * imdb_weight + twitter * twitter_weight) / (imdb_weight + twitter_weight)

def get_movie_name(movies, movie_id):
    return movies[str(movie_id)]['name']

if __name__ == "__main__":
    movies = json.loads(open(word_path + "movies.json").read())
    ratings = json.loads(open(word_path + "ratings.json").read())
    
    """
    movies['3520029'] = {'genre': ['Sci-Fi', 'Action', 'Adventure'],
                         'movie_year': 2010, 'name': 'TRON: Legacy',
                         'rating': 6.8, 'numvotes': 254865}
    """
    
    min_year = int(input("Min year => ").strip())
    print(min_year)
    max_year = int(input("Max year => ").strip())
    print(max_year)
    imdb_weight = float(input("Weight for IMDB => ").strip())
    print(imdb_weight)
    twitter_weight = float(input("Weight for Twitter => ").strip())
    print(twitter_weight)
    
    ids = get_movie_ids(movies, min_year, max_year)
    #print(ids)
    while genre.lower() !="stop":
        genre = input("\nWhat genre do you want to see? ").strip()
        print(genre)
        
        if genre == "stop":
            break
        
        min_rating = 10000.0
        max_rating = 0.0
        min_name = ""
        max_name = ""
        mv_min_year = 10000
        mv_max_year = 0
        
        for i in ids:
            if get_num_twitter_ratings(ratings, i) <= 3:
                continue
            genres = movies[str(i)]['genre']
            genres = [x.lower() for x in genres]
            #print("Debug", i, genres)
            if genre.lower() in genres:
                rating = get_weighted_rating(movies, ratings, i, imdb_weight, twitter_weight)
                #print("Debug", rating)
                if rating < min_rating:
                    min_rating = rating
                    min_name = get_movie_name(movies, i)
                    mv_min_year = movies[str(i)]['movie_year']
                if rating > max_rating:
                    max_rating = rating
                    max_name = get_movie_name(movies, i)
                    mv_max_year = movies[str(i)]['movie_year']
        
        if min_name == "" or max_name == "":
            print("\nNo {} movie found in {} through {}".format(genre, mv_min_year, mv_max_year))
        else:
            print("\nBest:\n        Released in {}, {} has a rating of {:.2f}".format(mv_max_year, max_name, max_rating))
            print("\nWorst:\n        Released in {}, {} has a rating of {:.2f}".format(mv_min_year, min_name, min_rating))        
        
        genre = genre
        #genre = "stop" # Debugging Only
```
