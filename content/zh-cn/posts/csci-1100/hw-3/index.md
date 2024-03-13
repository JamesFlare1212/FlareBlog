---
title: CSCI 1100 - 作业 3 - 循环、元组、列表和条件语句
subtitle:
date: 2024-03-13T14:28:32-04:00
slug: csci-1100-hw-3
draft: false
author:
  name: James
  link: https://www.jamesflare.com
  email:
  avatar: /site-logo.avif
description: 这次家庭作业的重点是在 Python 中运用列表、循环、元组和条件语句。它包括三个部分 - 分析文本复杂度、模拟皮卡丘的移动，以及模拟熊、浆果和游客的种群变化。
keywords: ["Python","循环","元组","列表","条件语句"]
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
summary: 这次家庭作业的重点是在 Python 中运用列表、循环、元组和条件语句。它包括三个部分 - 分析文本复杂度、模拟皮卡丘的移动，以及模拟熊、浆果和游客的种群变化。
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

# 有关详细的 front matter 设置，请参阅: https://fixit.lruihao.cn/documentation/content-management/introduction/#front-matter
---

<!--more-->

## 概述

这次家庭作业占你总家庭作业成绩的 100 分，截止日期为 2024 年 2 月 15 日星期四晚上 11:59:59。你有 1 周时间完成这个作业。

这个作业的目标是运用列表、循环、元组和条件语句。随着你的程序变得越来越长，你需要开发一些策略来测试你的代码。这里有一些简单的策略:尽早开始测试，通过编写一点点代码并进行测试来测试程序的小部分。我们将在家庭作业描述中引导你构建程序，并提供一些测试的想法。

和往常一样，确保你遵循程序结构指南。你将根据程序的正确性以及良好的程序结构进行评分。这包括注释。最低限度，我们期望在提交的开始有一个简短的 docstring 注释块，详细说明目的和简要总结 (你也可以包括额外的信息，如你的姓名和日期); 以及每个你定义的函数的 docstring 注释，详细说明目的、输入和预期的返回值。额外的注释必须伴随你代码中任何复杂的部分。

## 关于过度合作的警告

请记住遵守你在上一个作业中得到的合作政策。它在本学期的这个和所有作业中保持有效。我们将使用软件比较所有提交的程序，寻找不适当的相似之处。这个软件可以处理程序之间的各种差异，所以如果你 (a) 拿了别人的程序，修改了 (或没有修改)，并作为你自己的程序提交， (b) 与一个或多个同学一起编写了一个程序，并作为你自己的作业分别提交了修改后的版本，或者 (c) 提交了 (可能稍作修改) 前一年提交的软件作为你的软件，这个软件会将这些提交标记为非常相似。 (a)、 (b) 和 (c) 都超出了本课程可接受的范围 - 它们违反了学术诚信政策。此外，这种抄袭会阻碍你学习如何解决问题，从长远来看会伤害你。你编写自己的代码越多，你学到的就越多。

确保你已经阅读了合作政策，了解可接受的合作水平，以及你如何保护自己。该文件可以在 Submitty 的课程材料页面上找到。过度合作的处罚可高达:

- 家庭作业得 0 分，以及
- 学期成绩额外减少 5%。

受到处罚的学生也将被禁止退出该课程。更严重的违规行为，如盗用他人代码，将导致该课程自动得 F。第二次被发现违反学术诚信的学生将自动得到 F。

通过提交你的家庭作业，你断言你 (a) 理解学术诚信政策，并且 (b) 没有违反它。

最后，请注意，这项政策是针对本课程中将出现的少数问题而制定的。遵循上述策略并在这样做时运用常识的学生不会在学术诚信方面遇到任何麻烦。

## 第 1 部分: 文本中使用的语言有多复杂? (40 分)

为 HW 3 创建一个文件夹。从 Submitty 上的课程材料下载 zip 文件 `hw3_files.zip`。把它放在这个文件夹里并解压。你应该看到一个名为 `syllables.py` 的文件，它将是这个家庭作业的辅助模块。在与此文件相同的文件夹中编写你的程序，并将其命名为 `hw3_part1.py`。

在解决这一部分之前要熟悉的几件事。

在这一部分，你必须熟悉一个名为 `.split()` 的函数，它接受一段文本，并将其转换为一个字符串列表。下面是一个示例运行:

```python
>>> line = "Citadel Morning News. News about the Citadel in the morning, pretty self explanatory."
>>> m = line.split()
>>> m
['Citadel', 'Morning', 'News.', 'News', 'about', 'the', 'Citadel', 'in', 'the', 'morning,', 'pretty', 'self', 'explanatory.']
```

你还需要使用文件 `syllables.py` 中的函数 `find_num_syllables()`，它接受一个英语单词作为字符串输入，并返回该单词中音节的总数作为整数。即使单词有标点符号，该模块也能工作，所以你不需要显式地删除它们。确保你在程序中适当地导入这个模块。

```python
>>> find_num_syllables('computer')
3
>>> find_num_syllables('science')
1
>>> find_num_syllables('introduction')
4
```

显然，第二个结果是不正确的。我们提供的模块不是一个完美的音节计数实现，所以你可能会发现错误。修复它们不是你的工作，按原样使用该模块，包括其中的错误。不要担心它犯的错误。要正确地计算这个，我们需要使用一个自然语言处理 (NLP) 模块，如 NLTK，我们在本课程中没有安装。

### 问题规范

在这一部分，你将从用户那里读取一个包含多个英语句子的文本段落。假设句号标志着句子的结束。将段落读取为一行 (长) 文本。计算并打印与该文本的整体可读性相对应的以下度量。

- ASL (平均句子长度) 由每个句子的单词数给出。打印 ASL。
- PHW (困难词的百分比): 要计算这个值，首先计算三个或更多音节且不包含连字符 (-) 的单词数，以及不以 'es' 或 'ed' 结尾的三音节单词数。将这个计数除以文本中的总单词数，再乘以 100 得到百分比。打印 PHW。
- 将 PHW 计算中使用的所有单词收集到一个列表中，与它们在输入中出现的方式完全一致，并打印这个列表。
- ASYL (平均音节数) 由音节总数除以单词总数给出。打印 ASYL。
- GFRI 由公式 0.4*(ASL + PHW) 给出。打印 GFRI。
- FKRI 由公式 206.835-1.015*ASL-86.4*ASYL 给出。打印 FKRI。

请注意，GFRI 和 FKRI 这两个指标是著名的可读性指标 Gunning-Fog 和 Flesch Kincaid 的略微修改版本。在 Gunning-fog 中，计算出的值越高，文本就越难读。对于 Flesch Kincaid 来说则相反，值越高表示文本越容易阅读。

你可以在 `hw3_files.zip` 中的 `hw3_part1_01.txt` 和 `hw3_part1_02.txt` 中找到程序运行的示例。

完成后，请将你的程序作为 `hw3_part1.py` 提交到 Submitty。你必须使用这个文件名，否则你的提交在 Submitty 中将无法工作。你不必提交我们提供的任何文件。

## 第 2 部分: 野外的皮卡丘! (40 分)

假设你有一只皮卡丘站在图像的中间，坐标为 (75, 75)。假设图像左上角的坐标为 (0,0)。

我们将带着皮卡丘在图像中走动，寻找其他宝可梦。这是一种简单的模拟。首先，我们将通过询问用户模拟的回合数 (从第 0 回合开始)、皮卡丘的名字以及我们遇到其他宝可梦的频率来设置模拟参数。此时我们进入一个模拟循环 (while)。你的皮卡丘每回合走 5 步，方向为北 (N)、南 (S)、东 (E) 或西 (W)。每回合，询问用户皮卡丘行走的方向，并将皮卡丘移动到该方向。你应该忽略 N、S、E、W 以外的方向。每隔 often 回合，你就会遇到另一只宝可梦。询问用户类型 (地面 (G) 或水 (W))。如果是地面类型 'G'，你的皮卡丘就输了。它转身并以看到另一只宝可梦之前移动方向的相反方向跑 10 步。 (如果最后的方向不是有效方向，你的皮卡丘就不移动。) 如果是水类型 'W'，你的皮卡丘就赢了，并向前走 1 步。其他任何情况都意味着你实际上没有看到另一只宝可梦。在列表中记录胜利、失败和 "无宝可梦"。

在 turn 回合结束时，报告你的皮卡丘最终到达的位置，并打印出它的记录。

你必须为这个程序实现至少一个函数:

```python
move_pokemon((row, column), direction, steps)
```

它返回皮卡丘的下一个位置作为一个 (row, column) 元组。图像边界有一个围栏。没有坐标可以小于 0 或大于 150。0 和 150 是允许的。确保你的 `move_pokemon()` 函数不会返回这个范围之外的位置。

你可以使用以下代码来测试你的 `move_pokemon()` 函数。如果你愿意，可以随意编写其他函数，但一定要测试它们以确保它们按预期工作!

```python
from hw3_part2 import move_pokemon

row = 15
column = 10
print(move_pokemon((row, column), 'n', 20))  # 应该打印 (0, 10)
print(move_pokemon((row, column), 'e', 20))  # 应该打印 (15, 30)
print(move_pokemon((row, column), 's', 20))  # 应该打印 (35, 10)
print(move_pokemon((row, column), 'w', 20))  # 应该打印 (15, 0)

row = 135
column = 140
print(move_pokemon((row, column), 'N', 20))  # 应该打印 (115, 140)
print(move_pokemon((row, column), 'E', 20))  # 应该打印 (135, 150)
print(move_pokemon((row, column), 'S', 20))  # 应该打印 (150, 140)
print(move_pokemon((row, column), 'W', 20))  # 应该打印 (135, 120)
```

现在，编写一些代码，为输入的每个命令调用这些函数，并相应地更新皮卡丘的位置。

在文件 `hw3_part2_01.txt` 和 `hw3_part2_02.txt` (可以在 `hw03_files.zip` 文件中找到) 中提供了使用 Spyder IDE 运行程序时的两个示例 (它运行时的样子)。在 `hw3_part2_01.txt` 中，请注意 `f` 是无效方向，所以它对皮卡丘的状态没有影响，而 `r` 是无效的宝可梦类型，在结果列表中被标记为 "No Pokemon"。

我们将使用示例文件中的值以及其他一系列值来测试你的代码。好好测试你的代码，当你确定它可以工作时，请将其作为名为 `hw3_part2.py` 的文件提交到 Submitty 作为家庭作业的第 2 部分。

## 第 3 部分: 种群变化 - 有熊 (20 分) 

你将编写一个程序来计算一种类似于你在实验 3 中计算的兔子和狐狸的种群平衡问题。这个问题将涉及熊、浆果田和游客。我们将只使用 "浆果" 这个词来表示浆果田的面积。我们也将计算熊和游客的数量。

熊需要大量的浆果来生存并为冬天做准备。因此，浆果田的面积对它们的种群非常重要。浆果田通常会随着时间的推移而扩散，但如果被熊过度践踏，它们可能会停止生长，面积可能会缩小。游客是熊最大的敌人，经常使它们习惯于人类，导致攻击性行为。可悲的是，这可能导致熊被杀死以避免对人类生命的威胁。

下面是每个群体从一年到下一年之间的种群联系方式。假设变量 `bears` 存储在给定年份的熊的数量， `berries` 存储浆果田的面积。

- 给定年份的游客数量按以下方式确定。如果熊的数量少于 4 只或多于 15 只，就没有游客。对他们来说，要么不够有趣，要么太危险。在其他情况下，每只熊最多有 10,000 名游客，每增加一只熊就有 20,000 名游客。为计算游客编写一个函数并单独测试它是一个好主意。
- 根据给定年份的熊、浆果和游客的数量，下一年的熊和浆果的数量由以下公式决定:

```python
bears_next = berries/(50*(bears+1)) + bears*0.60 - (math.log(1+tourists,10)*0.1)
berries_next = (berries*1.5) - (bears+1)*(berries/14) - (math.log(1+tourists,10)*0.05)
```

请记住，这些值都不能最终为负数。负值应该被限制为零。此外，熊和游客是整数。 `log` 函数在 `math` 模块中。

你必须编写一个函数，它接受给定年份的熊、浆果和游客的数量作为输入，并返回下一年的熊数量和浆果田面积作为元组。

```python
>>> find_next(5, 1000, 40000)
(5, 1071.1984678861438)
```

然后编写主程序，读取两个值，即当前的熊数量和浆果田面积。你的程序然后找到并打印第一年和另外 9 年 (总共 10 年) 的所有三个群体 (熊、浆果和游客) 的数量。你必须使用循环来做到这一点。输出的格式是，所有值都以列的形式打印出来，并在每一列内左对齐。每一列的宽度正好是 10 个字符 (如果需要，用空格填充)。所有浮点值需要打印成正好一位小数。

完成后，你的程序应该输出: 在你的计算中达到的熊、浆果和游客数量的最小值和最大值。这些值应该使用与每年种群值相同的格式规则输出。

文件 `hw3_part3_01.txt` (可以在 `hw03_files.zip` 文件中找到) 提供了一个使用 Spyder IDE 运行程序时的示例 (它运行时的样子)。请注意，熊的数量可能会降到零，然后再回升。为什么? 邻近地区的熊可以迁移过来。熊、浆果和游客的最小值和最大值可能来自不同的年份。

我们将使用示例文件中的值以及其他一系列值来测试你的代码。好好测试你的代码，当你确定它可以工作时，请将其作为名为 `hw3_part3.py` 的文件提交到 Submitty 作为家庭作业的第 3 部分。

## 支持文件

{{< link href="HW3.zip" content="HW3.zip" title="下载 HW3.zip" download="HW3.zip" card=true >}}

## 参考答案

### hw3_part1.py

```python
import syllables

#user_input = "We hold these truths to be self-evident, that all men are created equal, that they are endowed by their Creator with certain unalienable Rights, that among these are Life, Liberty and the pursuit of Happiness."
#user_input = "There is a theory which states that if ever anyone discovers exactly what the Universe is for and why it is here, it will instantly disappear and be replaced by something even more bizarre and inexplicable. There is another theory which states that this has already happened."
user_input = str(input("Enter a paragraph => ")).strip()
print(user_input)

# Calculate ASL

sentences = user_input.split(". ")
words_per_sentence = []
#print(sentences)

for sentence in sentences:
    words = sentence.split()
    words_per_sentence.append(len(words))

asl = sum(words_per_sentence) / len(words_per_sentence)
#print(asl)

# Calculate PHW

words = user_input.split()
#print(len(words))

#find hard words
hard_words = []

for word in words:
    num_syllables = syllables.find_num_syllables(word)
    #print(num_syllables)
    if num_syllables >= 3 and "-" not in word and word[-2:] != "es" and word[-2:] != "ed":
        #print(words)
        hard_words.append(word)
        #print(hard_words)

#print(hard_words)
#print(len(hard_words))
#print(words)
#print(len(words))
phw = len(hard_words) / len(words) * 100

# Calculate ASYL

total_syllables = 0

for word in words:
    total_syllables += syllables.find_num_syllables(word)

asyl = total_syllables / len(words)

# Caclulate GFRI

gfri = 0.4 * (asl + phw)

# Calculate FKRI

fkri = 206.835 - 1.015 * asl - 86.4 * asyl

print("Here are the hard words in this paragraph:\n" + str(hard_words))
print("Statistics: ASL:{:.2f} PHW:{:.2f}% ASYL:{:.2f}".format(asl, phw, asyl))
print("Readability index (GFRI): {:.2f}".format(gfri))
print("Readability index (FKRI): {:.2f}".format(fkri))
```

### hw3_part2.py

```python
# Get user input

num_turn = int(input("How many turns? => ").strip())
print(num_turn)
pikachu_name = str(input("What is the name of your pikachu? => ").strip())
print(pikachu_name)
often_turn = int(input("How often do we see a Pokemon (turns)? => ").strip())
print(str(often_turn) + "\n")

position = (75, 75)
wins, losses, no_pokemon = 0, 0, 0
turn_counter = 0
records = []
last_direction = ""

# Debugging

#num_turn = 5
#print(num_turn)
#pikachu_name = "Piki"
#print(pikachu_name)
#often_turn = 1
#print(often_turn)

def move_pokemon(coords, direction, steps):
    global position
    x,y = coords
    direction = direction.lower()
    if direction in ['n', 's', 'e', 'w']:
        if direction == 'n':
            x = max(0, x - steps)
        elif direction == 'e':
            y = min(150, y + steps)
        elif direction == 's':
            x = min(150, x + steps)
        elif direction == 'w':
            y = max(0, y - steps)
        position = (x, y)

def walk(repeat):
    global turn_counter, last_direction
    for _ in range(repeat):
        direction = input("What direction does " + pikachu_name + " walk? => ").strip()
        print(direction)
        direction = direction.lower()
        if direction in ['n', 's', 'e', 'w']:
            move_pokemon(position, direction, 5)
            last_direction = direction
        turn_counter += 1

def turn_message(turn_counter, position):
    print("Turn " + str(turn_counter) + ", " + pikachu_name + " at " + str(position))

def battle(pokemon_type):
    global records, position, last_direction
    if pokemon_type.lower() == 'g':
        records.append('Lose')
        opposite_directions = {'n': 's', 's': 'n', 'e': 'w', 'w': 'e'}
        move_pokemon(position, opposite_directions[last_direction], 10)
        print(pikachu_name + " runs away to " + str(position))
    elif pokemon_type.lower() == 'w':
        records.append('Win')
        move_pokemon(position, last_direction, 1)
        print(pikachu_name + " wins and moves to " + str(position))
    else:
        records.append('No Pokemon')

print("Starting simulation, turn 0 " + pikachu_name + " at  (75, 75)")

for i in range(num_turn // often_turn):
    walk(often_turn)
    turn_message(turn_counter, position)
    pokemon_type = input("What type of pokemon do you meet (W)ater, (G)round? => ").strip()
    print(pokemon_type)
    battle(pokemon_type)

if num_turn < often_turn:
    for i in range(num_turn):
        direction = input("What direction does " + pikachu_name + " walk? => ").strip()
        print(direction)
        direction = direction.lower()
        if direction in ['n', 's', 'e', 'w']:
            move_pokemon(position, direction, 5)
            last_direction = direction
            turn_counter += 1

print(pikachu_name + " ends up at " + "(" + str(position[0]) + ", " + str(position[1]) + ")" + ", Record: " + str(records))
```

### hw3_part3.py

```python
import math

n_bear = input("Number of bears => ").strip()
print(n_bear)
n_size = input("Size of berry area => ").strip()
print(n_size)

n_bear = int(n_bear)
n_size = float(n_size)

year = 10
block_size = 10
data = []
title = ["Year", "Bears", "Berry", "Tourists"]

def print_line(b1, b2, b3, b4):
    b1 = b1 + " " * int(10 - len(b1))
    b2 = b2 + " " * int(10 - len(b2))
    b3 = b3 + " " * int(10 - len(b3))
    b4 = b4 + " " * int(10 - len(b4))
    print(b1 + b2 + b3 + b4)

def show_data(data):
    data_copy = data.copy()
    for line in data_copy:
        line[2] = "{:.1f}".format(float(line[2]))
        line = [str(i) for i in line]
        print_line(line[0], line[1], line[2], line[3])

def conclusion(data):
    #print(data)
    initial_line = data[0]
    max_bears, max_berry, max_tourists = initial_line[1], float(initial_line[2]), initial_line[3]
    min_bears, min_berry, min_tourists = initial_line[1], float(initial_line[2]), initial_line[3]
    for i in data:
        max_bears = max(max_bears, i[1])
        max_berry = max(max_berry, float(i[2]))
        max_tourists = max(max_tourists, i[3])
        min_bears = min(min_bears, i[1])
        min_berry = min(min_berry, float(i[2]))
        min_tourists = min(min_tourists, i[3])
    message = []
    message.append(["Min:", str(min_bears), str(min_berry), str(min_tourists)])
    message.append(["Max:", str(max_bears), str(max_berry), str(max_tourists)])
    show_data(message)

def find_next(bears, berry, tourists):
    bears_next = berry / (50*(bears+1)) + bears*0.60 - (math.log(1+tourists,10)*0.1)
    berries_next = (berry*1.5) - (bears+1)*(berry/14) - (math.log(1+tourists,10)*0.05)
    if berries_next < 0:
        berries_next = 0
    return (int(bears_next), berries_next)

def find_tourists(bears):
    bears = int(bears)
    if bears < 4 or bears > 15:
        tourists = 0
    elif bears <= 10:
        tourists = 10000*bears
    elif bears > 10:
        tourists = 100000 + 20000*(bears-10)
    return tourists
    
for i in range(year):
    tourists = find_tourists(n_bear)
    data.append([i+1, n_bear, n_size, tourists])
    n_bear, n_size = find_next(n_bear, n_size, tourists)

print_line(title[0], title[1], title[2], title[3])
show_data(data)
print()
conclusion(data)
```