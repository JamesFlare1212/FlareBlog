---
title: 使用 ChatGPT 轻松创建选择题
subtitle:
date: 2023-03-04T16:45:19+08:00
slug: create-mcq-chatgpt-scales 
draft: false
author:
  name: James
  link: https://www.jamesflare.com
  email:
  avatar: /site-logo.avif
description: 本文将手把手教你如何利用 ChatGPT、Python 和 JSON 文件高效创建选择题试卷。从自动生成题库,到格式化试题、答题纸和评分标准,一应俱全。跟着教程学习,你也能轻松搞定选择题卷子。
keywords: ["选择题","ChatGPT","Python","JSON"]
license:  
comment: true
weight: 0
tags:
- ChatGPT
- Python
categories:
- 教程
- 大语言模型
hiddenFromHomePage: false
hiddenFromSearch: false 
hiddenFromRss: false
hiddenFromRelated: false
summary: 本文将手把手教你如何利用 ChatGPT、Python 和 JSON 文件高效创建选择题试卷。从自动生成题库,到格式化试题、答题纸和评分标准,一应俱全。跟着教程学习,你也能轻松搞定选择题卷子。
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
  enable: false
  url:

# 更多 front matter 设置详见: https://fixit.lruihao.cn/zh-cn/documentation/content-management/introduction/#front-matter
---

<!--more-->

意译:

## 简介

亲爱的老师们,大家好!

出选择题卷子是不是让你们头疼?

这篇文章将手把手教你如何在 Scales 中高效创建选择题卷子。从自动生成题库,到随机抽题组卷,再到格式化输出试卷、答题纸和评分标准,一应俱全。跟着教程学习,相信你也能轻松搞定选择题卷子。

### 步骤

1. 让 ChatGPT 制作 .json 格式的题库。
2. 用 Python 程序格式化 .json 题库。
3. 再写一个 Python 程序,从 .json 题库中随机抽题组卷。

## 提示工程

首先,我们希望选择题的内容要契合教学主题。为此,需要明确告诉 ChatGPT 要做什么,以及给它哪些素材。 

你可以参考这个提示模板:

> \[指令\] +
>
> \[题目模板\] +
>
> \[学习目标\] +
>
> \[主题概念\] +
>
> \[补充要点\] +
>
> \[题干用词\] +
>
> \[ChatGPT 须知\]

我做了一个关于天体物理学的示例,虽然不够完美,没有涵盖所有知识点。所以批量生成的选择题可能有点单调。但至少在选项上不会重复。

这样一来,靠死记硬背选项的学生就没辙了。

### 示例

{{< admonition type=warning title="这不是原始输入" open=true >}}
为了方便阅读,我把原始的 Markdown 格式转成了网页版。
如果你想看原始的输入,可以在本节末尾找到一个下拉框。
{{< /admonition >}}

> 你是一个从不出错的 AI 驱动的 json 文件生成器。请你先在脑海中想象 1000 个关于天体物理学的选择题,然后随机给我 15 个,要求如下格式:
>
> ```json
> [
>   {
>     "order_number": "[题号]",
>     "question": "[题干]",
>     "type": "mcq",
>     "option_a": "[选项 A]", 
>     "option_b": "[选项 B]",
>     "option_c": "[选项 C]",
>     "option_d": "[选项 D]",
>     "answer": "[正确选项,ABCD 之一]",
>     "explanation": "[答案解析]"
>   },
>   {
>     "order_number": "[题号]",
>     "question": "[题干]",
>     "type": "mcq",
>     "option_a": "[选项 A]",
>     "option_b": "[选项 B]",
>     "option_c": "[选项 C]",
>     "option_d": "[选项 D]",
>     "answer": "[正确选项,ABCD 之一]",
>     "explanation": "[答案解析]"  
>   }
> ]
> ```
>
> 请检查你生成的选择题是否覆盖了以下学习目标:
>
> 1. 描述构成宇宙的主要天体。
>
> 2. 描述恒星的性质。
>
> 3. 理解天文距离。
>
> 4. 掌握视差法。
>
> 5. 定义光度和视星等,并用它们解决有关距离的问题。
>
> 以及这些关键概念:
> |术语|定义|
> |:----|:----| 
> |双星|绕共同中心运转的两颗恒星|
> |黑矮星|白矮星冷却后的残骸,光度极低|  
> |黑洞|时空奇点,大质量恒星演化的终点|
> |褐矮星|未达到引发聚变的温度的气体和尘埃天体,持续收缩冷却|
> |造父变星|光度周期性变化的恒星,光度先急剧增加再缓慢下降。周期与其绝对光度相关,可用于估算距离| 
> |星系团|引力相互作用的星系集团|
> |彗星|主要由冰和尘埃组成,绕太阳椭圆轨道运行的小天体|
> |星座|在空间中看似彼此靠近、形成可辨认图案的一组恒星|
> |暗物质|星系和星系团中太冷而无法辐射的物质,其存在通过非直接观测推断|
> |星系|引力束缚在一起的大量恒星集合,从矮星系的数百万到大星系的数千亿颗恒星不等。估计可观测宇宙中有 1000 亿个星系|
> |星际介质|弥漫于恒星之间的稀薄气体(主要是氢和氦)和尘埃(硅酸盐、碳和铁),密度极低,每立方厘米约一个原子,尘埃密度更低万亿倍,温度约 100K|
> |主序星|正在进行氢聚变成氦的正常恒星,如太阳|
> |星云|恒星之间的尘埃云,含碳、氧、硅、金属化合物及分子氢|
> |中子星|红超巨星爆炸的产物,直径数十公里,密度极高,主要由中子组成,中子围绕高压高密度核形成超流体。微观量子物理的宏观奇观| 
> |行星状星云|红巨星喷出的气壳|
> |红矮星|体积小、温度低的红色恒星|
> |红巨星|主序星演化的下一阶段,体积膨胀、表面温度下降的红色巨星,内部发生氦聚变|
> |星团|在空间中物理位置靠近,由单个气体云坍缩形成的恒星群|
> |超新星(Ia 型)|从伴星吸积物质超过稳定性极限的白矮星爆炸|
> |超新星(II 型)|红超巨星爆炸,瞬间释放的能量惊人,相当于太阳一生的总辐射量!|
> |白矮星|红巨星爆炸的残骸,体积如地球但密度极大,无核反应发生但温度极高,体积小导致光度很低|
>
> 补充要点:
>
> 1. 核聚变提供恒星保持高温所需的能量,使辐射压抵消引力收缩,同时供给恒星向外辐射的能量。
>
> 2. 恒星辐射的功率在天文学中称为光度,单位是瓦特。
>
> 3. 视星等的单位是每平方米瓦特,即 W/m^2。
>
> 题干要用多种句式:
>
> 1. \[背景\] + 什么是...
>
> 2. 关于...哪项正确
>
> 3. 根据...哪个...
>
> 4. 哪个...可能是...
>
> 5. 从...可知...是什么
>
> 6. ...是什么
>
> 7. 哪个...正确
>
> 8. 哪项陈述...
>
> 9. 哪项陈述支持...
>
> 10. 哪项不正确...
>
> 不要反复用同一句式。
>
> 注意事项:
>
> 1. 根据以上信息和你的知识(如有需要)编写所有选择题。如有冲突,以你的知识为准,添加细节和背景信息丰富题目。
>
> 2. 发挥创意,经常变换问题角度,不拘泥于从名词到解释,可以从解释问名词,问名词间关系,或结合例子提问。目标是帮助学生全面、透彻地理解主题。
>
> 3. 只给出选择题,不要写解析。确保 json 格式正确。
>
> 4. 只用英文引号和标点。

ChatGPT 只能输入纯文本,但它能理解 Markdown 语法。以下是原始的输入提示。

如果你不会写 Markdown 表格,可以试试这个工具:[Table to Markdown](https://markdown-convert.com/en/tool/table)。

```text
You are an AI-powered json file generator that never make mistakes, and you are going to imagine 1000 MCQs about Astrophysics first in mind, then randomly give me 15 of them in this json form:

[
  {
    "order_number": "[Order Number]",
    "question": "[Question]",
    "type": "mcq",
    "option_a": "[Option A]",
    "option_b": "[Option B]",
    "option_c": "[Option C]",
    "option_d": "[Option D]",
    "answer": "[Correct Option in ABCD]",
    "explanation": "[Explanation of Why This Answer]"
  },
  {
    "order_number": "[Order Number]",
    "question": "[Question]",
    "type": "mcq",
    "option_a": "[Option A]",
    "option_b": "[Option B]",
    "option_c": "[Option C]",
    "option_d": "[Option D]",
    "answer": "[Correct Option in ABCD]",
    "explanation": "[Explanation of Why This Answer]"
  }
]

Please check the understanding of Learning objectives in your generated MCQs:

1. Describe the main objects comprising the universe.

2. Describe the nature of stars.

3. Understand astronomical distances.

4. Work with the method of parallax.

5. Define luminosity and apparent brightness and solve problems with these quantities and distance.

And these key concepts as well:

|Binary star|Two stars orbiting a common centre|
|:----|:----|
|Black dwarf|The remnant of a white dwarf after it has cooled down. It has very low luminosity|
|Black hole|A singularity in space time; the end result of the evolution of a very massive star|
|Brown dwarf|Gas and dust that did not reach a high enough temperature to initiate fusion. These objects continue to compact and cool down|
|Cepheid variable|A star of variable luminosity. The luminosity increases sharply and falls off gently with a well-defined period. The period is related to the absolute luminosity of the star and so can be used to estimate the distance to the star|
|Cluster of galaxies|Galaxies close to one another and affecting one another gravitationally, behaving as one unit|
|Comet|A small body (mainly ice and dust) orbiting the Sun in an elliptical orbit|
|Constellation|A group of stars in a recognizable pattern that appear to be near each other in space|
|Dark matter|Generic name for matter in galaxies and clusters of galaxies that is too cold to radiate. Its existence is inferred from techniques other than direct visual observation|
|Galaxy|A collection of a very large number of stars mutually attracting one another through the gravitational force and staying together. The number of stars in a galaxy varies from a few million in dwarf galaxies to hundreds of billions in large galaxies. It is estimated that 100 billion galaxies exist in the observable universe|
|Interstellar medium|Gases (mainly hydrogen and helium) and dust grains (silicates, carbon and iron) filling the space between stars. The density of the interstellar medium is very low. There is about one atom of gas for every cubic centimeter of space. The density of dust is a trillion times smaller. The temperature of the gas is about 100 K|
|Main-sequence star|A normal star that is undergoing nuclear fusion of hydrogen into helium. Our Sun is a typical main-sequence star|
|Nebula|Clouds of 'dust', i.e. compounds of carbon, oxygen, silicon and metals, as well as molecular hydrogen, in the space in between stars|
|Neutron star|The end result of the explosion of a red supergiant; a very small star (a few tens of kilometers in diameter) and very dense. This is a star consisting almost entirely of neutrons. The neutrons form a superfluid around a core of immense pressure and density. A neutron star is an astonishing macroscopic example of microscopic quantum physics|
|Planetary nebula|The ejected envelope of a red giant star|
|Red dwarf|A very small star with low temperature, reddish in color|
|Red giant|A main-sequence star evolves into a red giant - a very large, reddish star. There are nuclear reactions involving the fusion of helium into heavier elements|
|Stellar cluster|A group of stars that are physically near each other in space, created by the collapse of a single gas cloud|
|Supernova (Type la)|The explosion of a white dwarf that has accreted mass from a companion star exceeding its stability limit|
|Supernova (Type II)|The explosion of a red supergiant star: The amount of energy emitted in a supernova explosion can be staggering - comparable to the total energy radiated by our Sun in its entire lifetime!|
|White dwarf|The end result of the explosion of a red giant. A small, dense star (about the size of the Earth), in which no nuclear reactions take place. It is very hot but its small size gives it a very low luminosity]|

in Additional of:

1. Nuclear fusion provides the energy that is needed to keep the star hot, so that the radiation pressure is high enough to oppose further gravitational contraction, and at the same time to provide the energy that the star is radiating into space.

2. The power radiated by a star is known in astrophysics as the luminosity. It is measured in watts.

3. The unit of apparent brightness is W m^{−2}.

You must use a variety of multiple-choice question types:

1. [Background] + what is ...

2. What is true about ...

3. Which ... according  ...

4. Which ... can be ...

5. What is ... from ...

6. What is ...

7. Which ... is correct

8. Which statement ...

9. Which statement justify ...

10. Which is not correct ...

Do not repeat on one type of sentence.

Primary Order:

1. Make all MCQs base on above information and your knowledge if needed. When there are conflict between your knowledge and the above information. You should use your knowledge to add more detail and background to produce MCQs.

2. Be creative, change the perspective of your questions randomly, not necessarily from nouns to explanations, but from explanations to nouns, or ask questions based on the relationship between nouns, or ask questions in conjunction with examples; your goal is to help students fully understand the topic from all angles.

3. Only reply the MCQs and nothing else, do not write explanations. Make sure your answer has right json grammar.

4. Use english quotation marks or any other english punctuation only.
```

## 格式化题库

在我们开始之前，我们应该了解一些关于.json格式的基础知识。在我们的情况下，我们希望我们的问题库如下：

```json
[
  {
    "order_number": "1",
    "question": "What is a galaxy?",
    "type": "mcq",
    "option_a": "A collection of planets",
    "option_b": "A collection of stars",
    "option_c": "A collection of asteroids",
    "option_d": "A collection of comets",
    "answer": "B",
    "explanation": "A galaxy is a collection of a very large number of stars mutually attracting one another through the gravitational force and staying together."
  },
  {
    "order_number": "2",
    "question": "What is a main-sequence star?",
    "type": "mcq",
    "option_a": "A star that has run out of fuel",
    "option_b": "A star that is undergoing nuclear fusion of hydrogen into helium",
    "option_c": "A star that is about to explode",
    "option_d": "A star that is very small and has low temperature",
    "answer": "B",
    "explanation": "A main-sequence star is a normal star that is undergoing nuclear fusion of hydrogen into helium."
  }
]
```

我们使用方括号来包含所有的花括号。同时，花括号之间需要用逗号分隔。

```json
[
  {
    //Something
  },
  {
    //Something
  },
  {
    //Something
  }
]
```

ChatGPT可能会给你一个答案，如下：

```json
{
“order_number”: 1,
“question”: “What is an astronomical unit (AU)?”,
“type”: “mcq”,
“option_a”: “The average distance between the Earth and the Sun.”,
“option_b”: “The radius of the Earth.”,
“option_c”: “The distance traveled by light in one year.”,
“option_d”: “The mass of the Earth.”,
“answer”: “The average distance between the Earth and the Sun.”,
“explanation”: “An astronomical unit or AU is a unit of measurement equal to the average distance between Earth and the Sun. It is commonly used to measure distances within our solar system.”
},
{
“order_number”: 2,
“question”: “Which of the following is not a type of galaxy?”,
“type”: “mcq”,
“option_a”: “Elliptical”,
“option_b”: “Spiral”,
“option_c”: “Irregular”,
“option_d”: “Spherical”,
“answer”: “Spherical”,
“explanation”: “The three main types of galaxies are elliptical, spiral, and irregular. There is no galaxy type called spherical.”
},
```

三个主要问题

1. 存在非英文引号。
2. 末尾多了一个逗号。
3. 缺少方括号。

虽然缩进丢失了，但这不是问题。你可以将文本复制到 [JSON Formatter](https://jsonformatter.curiousconcept.com/#) 中，让它看起来更整洁。

要修复非英文引号，只需使用替换函数即可。不建议使用 Word 或 WPS 来完成这项工作。我推荐使用 [Sublimetext 4](https://www.sublimetext.com/download) 文本编辑器，其他编辑器如 BBEdit 也可以。

从 ChatGPT 复制答案片段后，你可能会发现 `order_number` 是混乱的。

不用担心，首先，在下一步创建选择题试卷时，试卷中的题号不是来自 .json 文件中的 `order_number`。

其次，这里有一个 Python 程序可以解决这个问题。但是，如果你不在意美观，只需确保你的 json 文件没有语法错误即可。要做到这一点，可以使用 [JSON Formatter](https://jsonformatter.curiousconcept.com/#) 进行检查。

```py
import json
from collections import OrderedDict

# 打开 JSON 文件，将数据加载为字典列表
with open('data.json', 'r') as f:
    data = json.load(f)

# 创建有序字典，按照题目编号存储题目
data_dict = OrderedDict()
for obj in data:
    if 'order_number' in obj:
        order_number = obj['order_number']
        if order_number in data_dict:
            data_dict[order_number].append(obj)
        else:
            data_dict[order_number] = [obj]

# 创建新的字典列表，按照题目编号排序题目
data_sorted = []
for order_number, objs in data_dict.items():
    for i, obj in enumerate(objs):
        obj['order_number'] = str(len(data_sorted) + i + 1)
    data_sorted.extend(objs)

# 将修改后的字典列表写回 JSON 文件
with open('question_bank.json', 'w') as f:
    json.dump(data_sorted, f, indent=2)
```

我不想在如何运行 Python 程序上花太多时间，所以我会快速介绍一下。

1. 安装 Python：在运行 Python 程序之前，需要确保电脑上已经安装了 Python。可以从 [官网](https://www.python.org/downloads/) 下载最新版本的 Python，选择适合自己操作系统的版本，按照安装说明进行操作。

    如果你有 Homebrew，只需运行 `brew install python` 即可。

2. 创建 Python 程序：安装好 Python 后，需要创建一个 Python 程序。可以使用任意文本编辑器创建 Python 程序，将文件以 `.py` 为扩展名保存。在这里，你可以将文件重命名为 `qbReorder.py`，将上面的 Python 代码粘贴进去并保存。

3. 打开终端或命令提示符：在电脑上打开终端或命令提示符，这是你运行 Python 程序的地方。

4. 运行 Python 程序：在终端或命令提示符中输入以下命令，即可运行 Python 程序：

    ```shell
    python qbReorder.py
    ```

    如果不起作用，可以试试：

    ```shell
    python3 qbReorder.py
    ```

如果 `qbReorder.py` 不在当前路径下，可以这样运行：

```shell
python /path/to/the/qbReorder.py
```

在我的 `qbReorder.py` 中，我将未排序的 JSON 文件设为 `data.json`。运行程序后，你会在运行路径下得到一个 `question_bank.json` 文件。如果你想要其他名字，可以修改代码。

我强烈建议你为这个任务创建一个文件夹，将所有文件都放在里面：

- qbReorder.py
- data.json
- question_bank.json

使用终端时，可以选择"在此处打开终端"，或使用 `cd` 命令切换到工作文件夹：

```shell
cd /the/path/to/working/folder
```

为了安全起见，可以输入 `ls` 命令查看该文件夹下的所有文件/文件夹。然后，运行以下命令：

```shell
python qbReorder.py
```

或

```shell
python3 /qbReorder.py
```

来执行题库重排序。

这就是题库准备的全部内容了。

## 制作试卷

现在，我们来制作真正的选择题试卷。

为此，我编写了另一个 Python 程序：

```py
import argparse
import json
import random
from docx import Document
from docx.shared import Pt
from docx.enum.text import WD_ALIGN_PARAGRAPH

# 定义命令行参数
parser = argparse.ArgumentParser(description='生成试卷、答题纸和评分方案。')
parser.add_argument('-q', '--question-bank', type=str, required=True, help='题库 JSON 文件路径。')
parser.add_argument('-n', '--number-question', type=int, required=True, help='试卷中的题目数量。')
args = parser.parse_args()

# 打开 JSON 文件，加载数据
with open(args.question_bank, 'r') as f:
    data = json.load(f)

# 随机选择题目
selected_questions = random.sample(data, args.number_question)

# 创建试卷、答题纸和评分方案文档
test_paper_doc = Document()
answer_sheet_doc = Document()
marking_scheme_doc = Document()

# 设置字体
font = test_paper_doc.styles['Normal'].font
font.name = 'Arial'
font.size = Pt(12)

# 添加试卷标题
test_paper_title = test_paper_doc.add_paragraph('试卷', style='Title')
test_paper_title.alignment = WD_ALIGN_PARAGRAPH.CENTER
test_paper_doc.add_paragraph()

# 添加答题纸标题 
answer_sheet_title = answer_sheet_doc.add_paragraph('答题纸', style='Title')
answer_sheet_title.alignment = WD_ALIGN_PARAGRAPH.CENTER
answer_sheet_doc.add_paragraph()

# 添加评分方案标题
marking_scheme_title = marking_scheme_doc.add_paragraph('评分方案', style='Title') 
marking_scheme_title.alignment = WD_ALIGN_PARAGRAPH.CENTER
marking_scheme_doc.add_paragraph()

# 循环选定的题目，添加到文档中
for i, question in enumerate(selected_questions):
    # 试卷
    test_paper_doc.add_paragraph(f'{i+1}. {question["question"]}')
    test_paper_doc.add_paragraph(f'     A. {question["option_a"]}')
    test_paper_doc.add_paragraph(f'     B. {question["option_b"]}')
    test_paper_doc.add_paragraph(f'     C. {question["option_c"]}') 
    test_paper_doc.add_paragraph(f'     D. {question["option_d"]}')
    test_paper_doc.add_paragraph()
    
    # 答题纸
    answer_sheet_doc.add_paragraph(f'{i+1}. {question["question"]}')
    answer_sheet_doc.add_paragraph(f'     A. {question["option_a"]}')
    answer_sheet_doc.add_paragraph(f'     B. {question["option_b"]}')
    answer_sheet_doc.add_paragraph(f'     C. {question["option_c"]}')
    answer_sheet_doc.add_paragraph(f'     D. {question["option_d"]}') 
    answer_sheet_doc.add_paragraph(f'答案：{question["answer"]}')
    answer_sheet_doc.add_paragraph(f'解析：{question["explanation"]}')
    answer_sheet_doc.add_paragraph()
    
    # 评分方案
    marking_scheme_doc.add_paragraph(f'{i+1}. {question["question"]}')
    marking_scheme_doc.add_paragraph(f'答案：{question["answer"]}') 
    marking_scheme_doc.add_paragraph()

# 保存文档
test_paper_doc.save('test_paper.docx')
answer_sheet_doc.save('answer_sheet.docx')
marking_scheme_doc.save('marking_scheme.docx')
```

在运行这个程序之前，需要使用 `pip` 安装 `python-docx` 包。

如果你没有 `pip`，可以按照以下步骤安装：

1. 检查是否已安装 `pip`：在安装 `pip` 之前，应该先检查系统中是否已经安装了它。打开终端或命令提示符，输入以下命令：

    ```shell
    pip --version
    ```

    如果已安装 pip，会显示版本号。如果没有，会看到一个错误消息。

2. 下载 `get-pip.py`：如果还没有安装 `pip`，需要下载 `get-pip.py`。在终端中运行：

    ```shell
    curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
    ```

3. 安装 `pip`：在终端或命令提示符中输入以下命令，即可安装 `pip`：

    ```shell
    python get-pip.py
    ```

    或

    ```shell
    python3 get-pip.py
    ```

另外，如果你有 Homebrew，运行 `brew install python` 时会自带 `pip`。

现在，我们可以继续工作了。安装 `python-docx` 包：

```shell
pip install python-docx
```

与运行 `qbReorder.py` 类似，现在只需将代码复制到 `qbBuilder.py` 中，并运行：

```shell
python qbBuilder.py -q question_bank.json -n 30
```

它的用法如下：

```
usage: qbBuilder.py [-h] -q QUESTION_BANK -n NUMBER_QUESTION

生成试卷、答题纸和评分方案。

options:
  -h, --help            显示此帮助信息并退出
  -q QUESTION_BANK, --question-bank QUESTION_BANK
                        题库 JSON 文件路径。
  -n NUMBER_QUESTION, --number-question NUMBER_QUESTION
                        试卷中的题目数量。
```

因此，`question_bank.json` 是题库文件名，`30` 是你想在试卷中包含的题目数量。可以将它们更改为任意你想要的值。

```shell
python qbBuilder.py -q [题库文件名] -n [你想包含的题目数量]  
```

运行后，你可以在运行路径下找到三个 .docx 文件。

## 结语

你可以试试我的示例题库。

{{< link href="question_bank.json" content="question_bank.json" title="下载 question_bank.json" download="question_bank.json" card=true >}}

以及 Python 程序。

{{< link href="qbReorder.py" content="qbReorder.py" title="下载 qbReorder.py" download="qbReorder.py" card=true >}}

{{< link href="qbBuilder.py" content="qbBuilder.py" title="下载 qbBuilder,py" download="qbBuilder.py" card=true >}}

示例试卷：

{{< link href="test_paper.docx" content="test_paper.docx" title="下载 test_paper.docx" download="test_paper.docx" card=true >}}

{{< link href="answer_sheet.docx" content="answer_sheet.docx" title="下载 answer_sheet.docx" download="answer_sheet.docx" card=true >}}

{{< link href="marking_scheme.docx" content="marking_scheme.docx" title="下载 marking_scheme.docx" download="marking_scheme.docx" card=true >}}

我打算让 ChatGPT 构建更多类型的题目，例如结构化样题。还打算做一个全自动的题库制作器，无需人工干预就能创建上千道题目。而且不仅适用于物理，也适用于其他学科。

另一方面，我也在研究如何提高生成题目的质量，这就涉及到提示工程了。我希望能听到大家对 ChatGPT 生成题目的反馈，以便我能够不断改进。非常感谢！