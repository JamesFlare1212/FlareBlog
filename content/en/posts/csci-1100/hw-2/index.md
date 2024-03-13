---
title: CSCI 1100 - Homework 2 - Strings and Functions
subtitle:
date: 2024-03-12T02:41:25-04:00
slug: csci-1100-hw-2
draft: false
author:
  name: James
  link: https://www.jamesflare.com
  email:
  avatar: /site-logo.avif
description: This homework assignment consists of three parts, focusing on sizing a gum ball machine, implementing a simple substitution cipher, and performing basic sentiment analysis on sentences using Python functions and string manipulation.
keywords: ["Python","functions","string manipulation","sentiment analysis"]
license:
comment: true
weight: 0
tags:
  - CSCI 1100
  - Homework
  - RPI
  - Python
  - Programming
categories:
  - Programming
collections:
  - CSCI 1100
hiddenFromHomePage: false
hiddenFromSearch: false
hiddenFromRss: false
hiddenFromRelated: false
summary: This homework assignment consists of three parts, focusing on sizing a gum ball machine, implementing a simple substitution cipher, and performing basic sentiment analysis on sentences using Python functions and string manipulation.
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

## Overview

This homework, worth 100 points total toward your overall homework grade, is due Thursday, February 1, 2024 at 11:59:59 pm. Three parts should each be submitted separately. All parts should be submitted by the deadline or your program will be considered late.

**Note on grading**: Make sure you read the Submission Guidelines document. It applies to this and all future homework assignments and will be of increasing importance. In all parts of the homework, we will specify which functions you must provide. Make sure you write these functions, even if they are very simple. Otherwise, you will lose points. We will write more complex functions as the semester goes on. In addition, we will also look at program structure (see Lecture 4), and at the names of variables and functions in grading this homework.

You are not allowed to use any loops anywhere in this assignment.

## Fair Warning About Excess Collaboration

For all homework assignments this semester we will be using software that compares all submitted programs, looking for inappropriate similarities. This handles a wide variety of differences between programs, so that if you either (a) took someone else’s program, modified it (or not), and submitted it as your own, (b) wrote a single program with one or more colleagues and submitted modified versions separately as your own work, or (c) submitted (perhaps slightly modified) software submitted in a previous year as your software, this software will mark these submissions as very similar.

All of (a), (b), and (c) are beyond what is acceptable in this course — they are violations of the academic integrity policy. Furthermore, this type of copying will prevent you from learning how to solve problems and will hurt you in the long run. The more you write your own code, the more you learn.

Please read the Collaboration Policy document for acceptable levels of collaboration and how you can protect yourself. The document can be found on the Course Materials page on Submitty. Penalties for excess collaboration can be as high as:

- 0 on the homework, and
- an additional overall 5% reduction on the semester grade.

Penalized students will also be prevented from dropping the course. More severe violations, such as stealing someone else’s code, will lead to an automatic F in the course. A student caught in a second academic integrity violation will receive an automatic F.

By submitting your homework you are asserting that you both (a) understand the academic integrity policy and (b) have not violated it.

Finally, please note that this policy is in place for the small percentage of problems that will arise in this course. Students who follow the strategies outlined above and use common sense in doing so will not have any trouble with academic integrity.

## Part 1: A Penny for a Gum Ball Mickey (40 pts)

We are going to conduct an experiment in selling gum balls, but we are going to make a few assumptions. Assume that you are selling gum balls from a vending machine. The machine is a cube, and the gum balls are spheres. You check the machine once a week. The goal is to size the machine so that it is completely full at the start of the week, you never run out of gum balls before you get back to check the machine, and you do not have too many gum balls left at the end of the week to go stale. We will make the assumption that all the gum balls line up so that the number of gum balls along any dimension of the cube is simply the side length divided by the diameter of the spheres. So if the side length is 9.0 and the gum balls have a radius of 0.5 exactly 9 gum balls would fit along each dimension, or 729 gum balls in total. This is known as a cubic lattice.

Do the following:

1. First write two functions, `find_volume_sphere(radius)` and `find_volume_cube(side)` that calculate the volume of a sphere given a radius, and that calculate the volume of a cube given a side, respectively.

2. Now ask the user for the radius of the gum balls and the weekly sales.

3. Calculate the total number of gum balls that need to fit in the machine as 1.25 times the weekly sales and use this to calculate the side length of the machine in terms of an integer number of gum balls. Hint: You know the total number of gum balls and in a cubic lattice, you can fit the same number along each dimension, so if you can fit N gum balls along each dimension, then the machine holds N³ gum balls. The math module function `ceil` will always round up and may be of use here. (We won’t be cutting gum balls to fit them in the machine.)

4. Calculate a few more values: how many gum balls will actually fit given the dimension you chose (remember that there must be an integer number of gum balls along each dimension of the cube); the volume of the cube; the volume of each gum ball, and the wasted space if we put in both the number of gum balls we need to hold and how many we can hold.

5. Print these values out using the `.2f` format for all floating point values.

Two examples of the program run (how it will look when you run it using Spyder IDE) are provided in files `hw2 part1 output 01.txt` and `hw2 part1 output 02.txt` (You will need to download file `hw02_files.zip` from the Course Materials section of Submitty and unzip it into your directory for HW 2).

We will test your code for the above values as well as a range of different values. Test your code well and when you are sure that it works, please submit it as a file named `hw2 part1.py` to Submitty for Part 1 of the homework.

## Part 2: Find the Hidden Message (40 pts)

Write a program to determine if a simple substitution code is reversible for a given string. The program should ask the user for a sentence using `input`. The program should then encrypt the string into a cipher, decode the cipher, and compare the result of the decode operation to the original sentence. If the decoded cipher matches the original, then the operation is reversible on the string. Otherwise, it is not reversible.

Along the way, the program should print out the cipher, the difference in length between the cipher and the original sentence, the decoded cipher, and a brief message saying whether the operation was reversible. Note that the difference in length should always be printed as a positive number.

Two examples of the program run (how it will look when you run it using Spyder IDE) are provided in files `hw2 part2 output 01.txt` and `hw2 part2 output 02.txt` (can be found inside the `hw02_files.zip` file).

The encryption rules are based on a set of string replacements, they should be applied in this order exactly:

| Original | Replacement | Note |
|:--------:|:-----------:|:-----|
| ' a' | '%4%' | Replace any 'a' after a space with '%4%' |
| 'he' | '7!' | Replace all occurrences of string 'he' with '7!' |
| 'e' | '9(*9(' | Replace any remaining 'e' with '9(*9(' |
| 'y' | '*%' | Replace all occurrences of string 'y' with '*%' |
| 'u' | '@@@' | Replace all occurrences of string 'u' with '@@@' |
| 'an' | '-?' | Replace all occurrences of string 'an' with '-?' |
| 'th' | '!@+3' | Replace all occurrences of string 'th' with '!@+3' |
| 'o' | '7654' | Replace all occurrences of string 'o' with '7654' |
| '9' | '2' | Replace all occurrences of string '9' with '2' |
| 'ck' | '%4' | Replace all occurrences of string 'ck' with '%4' |

For example the cipher for methane is `m2(*2(!@+3-?2(*2(`. Here is how we get this:

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

Decrypting will involve using the rules in reverse order.

Your program must use two functions:

- Write one function `encrypt(word)` that takes as an argument a string in plain English, and returns a ciphered version of it as a string.

- Write a second function `decrypt(word)` that does the reverse: takes a string in cipher and returns the plain English version of it.

Both functions will be very similar in structure, but they will use the string replacement rules in different order. You can now test whether your functions are correct by first encrypting a string, and then decrypting. The result should be identical to the original string (assuming the replacement rules are not ambiguous).

Use these functions to implement the above program. We will test your code for the above values as well as a range of different values.

Test your code well and when you are sure that it works, please submit it as a file named `hw2 part2.py` to Submitty for Part 2 of the homework.

## Part 3: How Do You Feel about Homework? (20 pts)

In this part of the homework, you will implement a very rough sentiment analysis tool. While the real tools use natural language processing, they all use word counts similar to the one we use here. Understanding the sentiment in messages is a crucial part of a lot of artificial intelligence tools.

Write a program that will ask the user for a string containing a sentence. The program will then compute the happiness and sadness level of the sentence using the two functions described below. If the happiness level is higher than sadness level, then the tone of the sentence is happy. If the sadness level is higher, then the tone of the sentence is sad. Otherwise, it is neutral. Find and print the tone of the sentence by first printing a sentiment line with a number of + equal to the number of happy words followed by the number of - equal to the number of sad words, followed by a simple statement of the analysis.

Two examples of the program run (how it will look when you run it using Spyder IDE 101) are provided in files `hw2 part3 output 01.txt` and `hw2 part3 output 02.txt` (Can be found inside the `hw02_files.zip` file).

To accomplish this you will write a function called `number_happy(sentence)` which returns the number of words in a given string called sentence that are happy. To do this, find the total count of the following 6 words: laugh happiness love excellent good smile. Here is an example run of this function:

```python
>>> number_happy("I laughed and laughed at her excellent joke.")
3
```

This is because the count of happy words is 3 (laugh is repeated twice). Your code should work even if there are upper and lower case words and extra spaces in the beginning and end of the sentence.

```python
>>> number_happy(" Happiness is the state of a student who started homework early. ")
1
```

Next, write a second function called `number_sad(sentence)` that works the same way but instead counts the number of the following 6 sad words in English: bad sad terrible horrible problem hate

```python
>>> number_sad("Dr. Horrible's Sing-Along Blog is an excellent show.")
1
>>> number_sad("Alexander and the Terrible, Horrible, No Good, Very Bad Day")
3
```

Of courses, there are more than 6 words of each category. We will see how to feed them using a file and use lists to process them in future classes.

Test your code well and when you are sure that it works, please submit it as a file named `hw2 part3.py` to Submitty for Part 3 of the homework.

## Supporting Files

{{< link href="HW2.zip" content="HW2.zip" title="Download HW2.zip" download="HW2.zip" card=true >}}

***

## Solution

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