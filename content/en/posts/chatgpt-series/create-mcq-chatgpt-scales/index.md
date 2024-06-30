---
title: Create MCQs with ChatGPT in Scales
subtitle:
date: 2023-03-04T16:45:19+08:00
slug: create-mcq-chatgpt-scales
draft: false
author:
  name: James
  link: https://www.jamesflare.com
  email:
  avatar: /site-logo.avif
description: This blog post demonstrates how to create multiple-choice question (MCQ) papers using ChatGPT, Python, and JSON files, covering the process from generating a question bank to formatting and building the final test papers, answer sheets, and marking schemes.
keywords: ["MCQ","ChatGPT","Python","JSON"]
license:
comment: true
weight: 0
tags:
- ChatGPT
- Python
categories:
- Tutorials
- LLM
hiddenFromHomePage: false
hiddenFromSearch: false
hiddenFromRss: false
hiddenFromRelated: false
summary: This blog post demonstrates how to create multiple-choice question (MCQ) papers using ChatGPT, Python, and JSON files, covering the process from generating a question bank to formatting and building the final test papers, answer sheets, and marking schemes.
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

# See details front matter: https://fixit.lruihao.cn/documentation/content-management/introduction/#front-matter
---

<!--more-->

## Introduction

Hi, dear teachers!

Did you have difficulty on creating test paper for students?

In this post, I am going to show you how to create MCQs in scales and randomly pick a selected number of questions out, then make it into three formatted editable Word documents, includes test paper, answer sheet and marking scheme.

### Steps

1. Ask ChatGPT to make a .json format question bank.
2. Format the .json question bank through a Python Program.
3. Make another Python Program to create papers from the .json question bank.

## Prompt Engineering

Here is the first step. We want the MCQs fit for the topic. To do that, we need tell the ChatGPT what is should do, and where to do.

You may do your prompt like this format

> \[Instruction\] + 
> 
> \[Templates\] + 
> 
> \[Learning Objects\] + 
> 
> \[Topic Concepts\] + 
> 
> \[Additional Points\] + 
> 
> \[MCQ Command Words\] + 
> 
> \[Rules for ChatGPT\]

I made a non-perfect example on Astrophysics, which means not all objects were covered. So, the MCQs can be a bit boring under mass generation. But they will not repeat, at least in options.

Therefore, students who memorize options will be ended.

### Example

{{< admonition type=warning title="This is not The Raw Input" open=true >}}
To make it easier to read, I made the Raw Markdown input into this Web Page.  
If you want check out the Raw input, check the end of this section. There is a dropdown box.
{{< /admonition >}}

> You are an AI-powered json file generator that never make mistakes, and you are going to imagine 1000 MCQs about Astrophysics first in mind, then randomly give me 15 of them in this json form:
> 
> ```json
> [
>   {
>     "order_number": "[Order Number]",
>     "question": "[Question]",
>     "type": "mcq",
>     "option_a": "[Option A]",
>     "option_b": "[Option B]",
>     "option_c": "[Option C]",
>     "option_d": "[Option D]",
>     "answer": "[Correct Option in ABCD]",
>     "explanation": "[Explanation of Why This Answer]"
>   },
>   {
>     "order_number": "[Order Number]",
>     "question": "[Question]",
>     "type": "mcq",
>     "option_a": "[Option A]",
>     "option_b": "[Option B]",
>     "option_c": "[Option C]",
>     "option_d": "[Option D]",
>     "answer": "[Correct Option in ABCD]",
>     "explanation": "[Explanation of Why This Answer]"
>   }
> ]
> ```
> 
> Please check the understanding of these Learning objectives in your generated MCQs:
> 
> 1. Describe the main objects comprising the universe.
> 
> 2. Describe the nature of stars.
> 
> 3. Understand astronomical distances.
> 
> 4. Work with the method of parallax.
> 
> 5. Define luminosity and apparent brightness and solve problems with these quantities and distance.
> 
> And these key concepts as well:
> |Term|Definition|
> |:----|:----|
> |Binary star|Two stars orbiting a common centre|
> |Black dwarf|The remnant of a white dwarf after it has cooled down. It has very low luminosity|
> |Black hole|A singularity in space time; the end result of the evolution of a very massive star|
> |Brown dwarf|Gas and dust that did not reach a high enough temperature to initiate fusion. These objects continue to compact and cool down|
> |Cepheid variable|A star of variable luminosity. The luminosity increases sharply and falls off gently with a well-defined period. The period is related to the absolute luminosity of the star and so can be used to estimate the distance to the star|
> |Cluster of galaxies|Galaxies close to one another and affecting one another gravitationally, behaving as one unit|
> |Comet|A small body (mainly ice and dust) orbiting the Sun in an elliptical orbit|
> |Constellation|A group of stars in a recognizable pattern that appear to be near each other in space|
> |Dark matter|Generic name for matter in galaxies and clusters of galaxies that is too cold to radiate. Its existence is inferred from techniques other than direct visual observation|
> |Galaxy|A collection of a very large number of stars mutually attracting one another through the gravitational force and staying together. The number of stars in a galaxy varies from a few million in dwarf galaxies to hundreds of billions in large galaxies. It is estimated that 100 billion galaxies exist in the observable universe|
> |Interstellar medium|Gases (mainly hydrogen and helium) and dust grains (silicates, carbon and iron) filling the space between stars. The density of the interstellar medium is very low. There is about one atom of gas for every cubic centimeter of space. The density of dust is a trillion times smaller. The temperature of the gas is about 100 K|
> |Main-sequence star|A normal star that is undergoing nuclear fusion of hydrogen into helium. Our Sun is a typical main-sequence star|
> |Nebula|Clouds of 'dust', i.e. compounds of carbon, oxygen, silicon and metals, as well as molecular hydrogen, in the space in between stars|
> |Neutron star|The end result of the explosion of a red supergiant; a very small star (a few tens of kilometers in diameter) and very dense. This is a star consisting almost entirely of neutrons. The neutrons form a superfluid around a core of immense pressure and density. A neutron star is an astonishing macroscopic example of microscopic quantum physics|
> |Planetary nebula|The ejected envelope of a red giant star|
> |Red dwarf|A very small star with low temperature, reddish in color|
> |Red giant|A main-sequence star evolves into a red giant - a very large, reddish star. There are nuclear reactions involving the fusion of helium into heavier elements|
> |Stellar cluster|A group of stars that are physically near each other in space, created by the collapse of a single gas cloud|
> |Supernova (Type la)|The explosion of a white dwarf that has accreted mass from a companion star exceeding its stability limit|
> |Supernova (Type II)|The explosion of a red supergiant star: The amount of energy emitted in a supernova explosion can be staggering - comparable to the total energy radiated by our Sun in its entire lifetime!|
> |White dwarf|The end result of the explosion of a red giant. A small, dense star (about the size of the Earth), in which no nuclear reactions take place. It is very hot but its small size gives it a very low luminosity.|
>
> in Additional of:
>
> 1. Nuclear fusion provides the energy that is needed to keep the star hot, so that the radiation pressure is high enough to oppose further gravitational contraction, and at the same time to provide the energy that the star is radiating into space.
> 
> 1. The power radiated by a star is known in astrophysics as the luminosity. It is measured in watts.
> 
> 1. The unit of apparent brightness is W m^{−2}.
>
> You mush use a variety of multiple-choice question types:
> 
> 1. \[Background\] + what is ...
> 
> 2. What is true about ...
> 
> 3. Which ... according  ...
> 
> 4. Which ... can be ...
> 
> 5. What is ... from ...
> 
> 6. What is ...
> 
> 7. Which ... is correct
> 
> 8. Which statement ...
> 
> 9. Which statement justify ...
> 
> 10. Which is not correct ...
>
> Do not repeat on one type of sentence.
> 
> Primary Order:
> 
> 1. Make all MCQs base on above information and your knowledge if needed. When there are conflict between your knowledge and the above information. You should use your knowledge to add more detail and background to produce MCQs.
> 
> 2. Be creative, change the perspective of your questions randomly, not necessarily from nouns to explanations, but from explanations to nouns, or ask questions based on the relationship between nouns, or ask questions in conjunction with examples; your goal is to help students fully understand the topic from all angles.
>
> 3. Only reply the MCQs and nothing else, do not write explanations. Make sure your answer has right json grammar.
>
> 4. Use english quotation marks or any other english punctuation only.

You can only input pure text into ChatGPT, but it can understand markdown coding. This is the raw input prompt.

If you have issue on creating markdown table, try out this [Table to Markdown](https://markdown-convert.com/en/tool/table).

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

## Format Question Bank

Before we start, we should know some base knowledge about .json format. In our case, we want our question bank be like:

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

We use the square bracket to include all curly brackets. At the same time, the curly brackets need to be separated by a comma.

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

ChatGPT may give you an answer as:

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

Three main issues

1. There are non-english quotation marks.
2. An extra comma at the end
3. No square brackets

The ident is missing, but it's not a issue. You may copy the text into [JSON Formatter](https://jsonformatter.curiousconcept.com/#) just get it looks better.

To fix non-english quotation marks, just use a replacing function. Don't use Word or WPS for this job. I recommend a [Sublimetext 4](https://www.sublimetext.com/download) text editor for this job. Others, such as BBEdit is also fine.

After you copy answer parts from ChatGPT, you may find the `order_number` is mass.

Don't worry, first, in the next step of creating MCQ papers, the order number in the paper is not from the `order_number` in .json file.

Second, Here is a Python program that can fix this issue. But, If you do not care about beauty, just make sure there are not grammar mistake for your json file. To do that, you may use [JSON Formatter](https://jsonformatter.curiousconcept.com/#).

```py
import json
from collections import OrderedDict

# Open the JSON file and load the data as a list of dictionaries
with open('data.json', 'r') as f:
    data = json.load(f)

# Create an ordered dictionary to store the objects by their order_number
data_dict = OrderedDict()
for obj in data:
    if 'order_number' in obj:
        order_number = obj['order_number']
        if order_number in data_dict:
            data_dict[order_number].append(obj)
        else:
            data_dict[order_number] = [obj]

# Create a new list of dictionaries with the objects ordered by their order_number
data_sorted = []
for order_number, objs in data_dict.items():
    for i, obj in enumerate(objs):
        obj['order_number'] = str(len(data_sorted) + i + 1)
    data_sorted.extend(objs)

# Write the modified list of dictionaries back to the JSON file
with open('question_bank.json', 'w') as f:
    json.dump(data_sorted, f, indent=2)
```

I don't want to spend too much time on how to run a Python Program. I will cover it quickly.

1. Install Python: Before running a Python program, you need to ensure that Python is installed on your computer. You can download the latest version of Python from the [official website](https://www.python.org/downloads/). Choose the appropriate version for your operating system and follow the installation instructions.

    If you have Homebrew, just run `brew install python`.

2. Create a Python program: Once you have installed Python, you need to create a Python program. You can use any text editor to create a Python program. Save the file with a `.py` extension. In this case, you can rename a file into `qbReorder.py` and paste all my Python Code into it and save.

3. Open a terminal or command prompt: Open a terminal or command prompt on your computer. This is where you will run the Python program.

4. Run the Python program: To run the Python program, type the following command in the terminal or command prompt:

    ```shell
    python qbReorder.py
    ```

    If this doesn't work, try

    ```shell
    python3 qbReorder.py
    ```

If the `qbReorder.py` is not on the current path, you can run it as,

```shell
python /path/to/the/qbReorder.py
```

But in my `qbReorder.py`. I made the un-order .json file as `data.json`. After you run, you will get a `question_bank.json` on the running path. If you want another name, you may change the code.

I highly recommend you create a folder for this job and put all files here.

- qbReorder.py
- data.json
- question_bank.json

When you are going to use terminal, you can chose "Open terminal here", or use `cd` command to switch to the working folder

```shell
cd /the/path/to/working/folder
```

To be safe, type `ls` command to see all files/folders under this folder. Then, you can do

```shell
python qbReorder.py
```

or

```shell
python3 /qbReorder.py
```

To run the re-order.

This is the end of question bank preparing.

## Make the Papers

Now, it's time to make the real MCQ Papers.

To do that, I made another Python Program

```py
import argparse
import json
import random
from docx import Document
from docx.shared import Pt
from docx.enum.text import WD_ALIGN_PARAGRAPH

# Define command-line arguments
parser = argparse.ArgumentParser(description='Generate test papers, answer sheets, and marking scheme.')
parser.add_argument('-q', '--question-bank', type=str, required=True, help='Path to JSON file containing question bank.')
parser.add_argument('-n', '--number-question', type=int, required=True, help='Number of questions to include in the test paper.')
args = parser.parse_args()

# Open JSON file and load data
with open(args.question_bank, 'r') as f:
    data = json.load(f)

# Select random questions
selected_questions = random.sample(data, args.number_question)

# Create Test Paper, Answer Sheet, and Marking Scheme
test_paper_doc = Document()
answer_sheet_doc = Document()
marking_scheme_doc = Document()

# Set font
font = test_paper_doc.styles['Normal'].font
font.name = 'Arial'
font.size = Pt(12)

# Add test paper title
test_paper_title = test_paper_doc.add_paragraph('Test Paper', style='Title')
test_paper_title.alignment = WD_ALIGN_PARAGRAPH.CENTER
test_paper_doc.add_paragraph()

# Add answer sheet title
answer_sheet_title = answer_sheet_doc.add_paragraph('Answer Sheet', style='Title')
answer_sheet_title.alignment = WD_ALIGN_PARAGRAPH.CENTER
answer_sheet_doc.add_paragraph()

# Add marking scheme title
marking_scheme_title = marking_scheme_doc.add_paragraph('Marking Scheme', style='Title')
marking_scheme_title.alignment = WD_ALIGN_PARAGRAPH.CENTER
marking_scheme_doc.add_paragraph()

# Loop through selected questions and add to documents
for i, question in enumerate(selected_questions):
    # Test Paper
    test_paper_doc.add_paragraph(f'{i+1}. {question["question"]}')
    test_paper_doc.add_paragraph(f'     A. {question["option_a"]}')
    test_paper_doc.add_paragraph(f'     B. {question["option_b"]}')
    test_paper_doc.add_paragraph(f'     C. {question["option_c"]}')
    test_paper_doc.add_paragraph(f'     D. {question["option_d"]}')
    test_paper_doc.add_paragraph()

    # Answer Sheet
    answer_sheet_doc.add_paragraph(f'{i+1}. {question["question"]}')
    answer_sheet_doc.add_paragraph(f'     A. {question["option_a"]}')
    answer_sheet_doc.add_paragraph(f'     B. {question["option_b"]}')
    answer_sheet_doc.add_paragraph(f'     C. {question["option_c"]}')
    answer_sheet_doc.add_paragraph(f'     D. {question["option_d"]}')
    answer_sheet_doc.add_paragraph(f'Answer: {question["answer"]}')
    answer_sheet_doc.add_paragraph(f'Explanation: {question["explanation"]}')
    answer_sheet_doc.add_paragraph()

    # Marking Scheme
    marking_scheme_doc.add_paragraph(f'{i+1}. {question["question"]}')
    marking_scheme_doc.add_paragraph(f'Answer: {question["answer"]}')
    marking_scheme_doc.add_paragraph()

# Save documents
test_paper_doc.save('test_paper.docx')
answer_sheet_doc.save('answer_sheet.docx')
marking_scheme_doc.save('marking_scheme.docx')
```

Before, run this program, you need to use `pip` to install `python-docx` package.

If you don't have `pip`, here is the steps:

1. Check if `pip` is already installed: Before installing `pip`, you should check if it is already installed on your system. Open a terminal or command prompt and type the following command:

    ```shell
    pip --version
    ```

    If pip is already installed, it will display the version number. If not, you will see an error message.

2. Download `get-pip.py`: If pip is not already installed, you need to download `get-pip.py`. In the Terminal, run

    ```shell
    curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
    ```

3. Install `pip`: To install `pip`, type the following command in the terminal or command prompt:

    ```shell
    python get-pip.py
    ```

    or

    ```shell
    python3 get-pip.py
    ```

Additional, if you have Homebrew, when you run `brew install python`, `pip` is included.

Now, we can continue our work. Install `python-docx` package.

```shell
pip install python-docx
```

Do the similar thing when we run `qbReorder.py`. Now, just copy the code into `qbBuilder.py` and run

```shell
python qbBuilder.py -q question_bank.json -n 30
```

It works as

```
usage: qbBuilder.py [-h] -q QUESTION_BANK -n NUMBER_QUESTION

Generate test papers, answer sheets, and marking scheme.

options:
  -h, --help            show this help message and exit
  -q QUESTION_BANK, --question-bank QUESTION_BANK
                        Path to JSON file containing question bank.
  -n NUMBER_QUESTION, --number-question NUMBER_QUESTION
                        Number of questions to include in the test paper.
```

So, `question_bank.json` is the question bank's file name, `30` is the number of question you want to include in the paper. Change them into any value you want and enjoy.

```shell
python qbBuilder.py -q [Name of Question Bank File] -n [Number of Questions You Want to Include]
```

You can find three .docx files under the running path.

## End

You can try with my example question bank.

{{< link href="question_bank.json" content="question_bank.json" title="Download question_bank.json" download="question_bank.json" card=true >}}

Also, the Python Program.

{{< link href="qbReorder.py" content="qbReorder.py" title="Download qbReorder.py" download="qbReorder.py" card=true >}}

{{< link href="qbBuilder.py" content="qbBuilder.py" title="Download qbBuilder,py" download="qbBuilder.py" card=true >}}

Example Papers.

{{< link href="test_paper.docx" content="test_paper.docx" title="Download test_paper.docx" download="test_paper.docx" card=true >}}

{{< link href="answer_sheet.docx" content="answer_sheet.docx" title="Download answer_sheet.docx" download="answer_sheet.docx" card=true >}}

{{< link href="marking_scheme.docx" content="marking_scheme.docx" title="Download marking_scheme.docx" download="marking_scheme.docx" card=true >}}

I am going to made ChatGPT to build more types of question, such as sample structure questions. And a fully auto question bank maker, like create 1000 questions with out people. Also, not only for Physic, for other subjects as well.

On the other hand, I am also working on how to improve generated question's quality, which means prompt engineering. I want to hear feedbacks about the questions that generated by ChatGPT, and let me able to improve that. Great thanks!