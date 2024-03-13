---
title: CSCI 1100 - Homework 1 - Calculations and Strings
subtitle:
date: 2024-03-12T02:12:11-04:00
slug: csci-1100-hw-1
draft: false
author:
  name: James
  link: https://www.jamesflare.com
  email:
  avatar: /site-logo.avif
description: This blog post provides a detailed overview of a Python programming homework assignment, which includes creating a Mad Libs game, calculating speed and pace, and generating a framed box with user-specified dimensions.
keywords: ["Python", "programming", "homework", "Mad Libs", "speed calculation", "framed box"]
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
summary: This blog post provides a detailed overview of a Python programming homework assignment, which includes creating a Mad Libs game, calculating speed and pace, and generating a framed box with user-specified dimensions.
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

This homework, worth 100 points total toward your overall homework grade, is due Thursday, September 14, 2023 at 11:59:59 pm. The three parts should each be submitted separately. All parts should be submitted by the deadline or your program will be considered late.

Please refer to the Submission Guidelines document before starting this assignment. It will give you details on what we expect and will answer some of the more common questions, including that you need to submit your program through Submitty and that Submitty will open by Monday, September 11th, 2023.

Remember that your output must match EXACTLY the format shown in example runs from the `hw01_files.zip` file. The purpose of this is to make testing easier and at the same time teach you how to be precise in your programming using the tools we gave you. We love creativity, but not in HW output formatting!

## Part 1: Mad Libs (40 pts)

In this part, you will write a Python program to construct the Mad Lib given below:

```text
Good morning <proper name>!

  This will be a/an <adjective1> <noun1>! Are you <verb1> forward to it?
  You will <verb2> a lot of <noun2> and feel <emotion1> when you do.
  If you do not, you will <verb3> this <noun3>.
  
  This <season> was <adjective2>. Were you <emotion2> when <team_name> won
  the <noun4>?
  
  Have a/an <adjective3> day!
```

You will ask the user of the program for the missing words | those enclosed in `< >` | using the input function. You will then take all the user-specified inputs and construct the above Mad Lib. Make sure your output looks like the above paragraph, except that the missing information is filled in with the user input.

An example of the program run is provided in file `hw1 part1 output.txt` (You will need to download file `hw01_files.zip` from the Course Materials section of Submitty and unzip it into your directory for HW 1).

We've provided reasonable inputs, but the idea of Mad Libs is to input random words and see how silly the result looks. Try it!

Of course, the program you write will only work for the specific Mad Lib we've written above. A more challenging problem, which you will be capable of solving by the end of the semester, is to write a program that reads in any Mad Lib, figures out what to ask the user, asks the user, reads the input, and generates the final Mad Lib.

Test your code well and when you are sure that it works, please submit it as a file named `hw1 part1.py` to Submitty for Part 1 of the homework.

## Part 2: Speed Calculations (40 pts)

Many exercise apps record both the time and the distance a user covers while walking, running, biking, or swimming. Some users of the apps want to know their average pace in minutes and seconds per mile, while others want to know their average speed in miles per hour. In many cases, we are interested in projected time over a specific distance. For example, if I run 6.3 miles in 53 minutes and 30 seconds, my average pace is 8 minutes and 29 seconds per mile, my average speed is 7.07 miles per hour, and my projected time for 2.7 miles is 22 minutes and 55 seconds.

Your job in Part 2 of this homework is to write a program that asks the user for the minutes, seconds, miles run, and miles to target from an exercise event and outputs both the average pace and the average speed.

An example of the program run is provided in file `hw1 part2 output.txt` (Can be found inside the `hw01_files.zip` file).

You can expect minutes and seconds to both be integers, but miles and miles to target will be floats. All minutes and seconds must be maintained as integers so please use integer division and modulo operations. For example:

```python
>>> x = 29.52
>>> y = int(x)
>>> print(y)
29
```

The output for the speed will be a float and should be printed to 2 decimal places. Notice also that our solution generates a blank line before the output of calculations.

We will test your code for the values used in our examples as well as a range of different values. Test your code well and when you are sure that it works, please submit it as a file named `hw1 part2.py` to Submitty for Part 2 of the homework.

## Part 3: Framed Box (20 pts)

Write a program that asks the user for a frame character, and then the height and width of a framed box. Then output a box of the given size, framed by the given character. Also, output the dimensions of the box centered horizontally and vertically inside the box. In case perfect vertical centering is not possible, dimensions should be output such that there is one less row above the text than below it. In case perfect horizontal centering is not possible, dimensions should be output such that there is one less space character to the left of the text than to the right.

Assume that the user inputs valid values for each input: width is a positive integer (7 or higher) and height is a positive integer (4 or higher), and a single character is given for the frame.

Two examples of the program run are provided in files `hw1 part3 output 01.txt` and `hw1 part3 output 02.txt` (Can be found inside the `hw01_files.zip` file).

You will need to put the box dimensions in a string first, and then use its length to figure out how long the line containing the dimensions should be. If you have prior programming experience you might be tempted to look for how Python implements "loops" in order to generate the full frame, but Python provides string manipulation tools (Lecture 3) that make this unnecessary. You must not use any if statements or loops in your program. We have not learned them yet, they are not needed, and they will not make your solution better or more elegant.

We will test your code for the values used in our examples as well as a range of different values. Test your code well and when you are sure that it works, please submit it as a file named `hw1 part3.py` to Submitty for Part 3 of the homework.

## Supporting Files

{{< link href="HW1.zip" content="HW1.zip" title="Download HW1.zip" download="HW1.zip" card=true >}}

***

## Solution

### hw1_part1.py

```python
#Prepare variables

proper_name = ""
adjective1 = ""
noun1 = ""
verb1 = ""
verb2 = ""
noun2 = ""
emotion1 = ""
verb3 = ""
noun3 = ""
season = ""
adjective2 = ""
emotion2 = ""
team_name = ""
noun4 = ""
adjective3 = ""

template= """
Good morning <proper name>!

  This will be a/an <adjective1> <noun1>! Are you <verb1> forward to it?
  You will <verb2> a lot of <noun2> and feel <emotion1> when you do.
  If you do not, you will <verb3> this <noun3>.
  
  This <season> was <adjective2>. Were you <emotion2> when <team_name> won
  the <noun4>?
  
  Have a/an <adjective3> day!"""
output = ""

#Get user's input

print("Let's play Mad Libs for Homework 1")
print("Type one word responses to the following:\n")

proper_name = input("proper_name ==> ").strip()
print(proper_name)
adjective1 = input("adjective ==> ").strip()
print(adjective1)
noun1 = input("noun ==> ").strip()
print(noun1)
verb1 = input("verb ==> ").strip()
print(verb1)
verb2 = input("verb ==> ").strip()
print(verb2)
noun2 = input("noun ==> ").strip()
print(noun2)
emotion1 = input("emotion ==> ").strip()
print(emotion1)
verb3 = input("verb ==> ").strip()
print(verb3)
noun3 = input("noun ==> ").strip()
print(noun3)
season = input("season ==> ").strip()
print(season)
adjective2 = input("adjective ==> ").strip()
print(adjective2)
emotion2 = input("emotion ==> ").strip()
print(emotion2)
team_name = input("team-name ==> ").strip()
print(team_name)
noun4 = input("noun ==> ").strip()
print(noun4)
adjective3 = input("adjective ==> ").strip()
print(adjective3)

#Construct the Mad Lib

output = template.replace("<proper name>", proper_name)
output = output.replace("<adjective1>", adjective1)
output = output.replace("<noun1>", noun1)
output = output.replace("<verb1>", verb1)
output = output.replace("<verb2>", verb2)
output = output.replace("<noun2>", noun2)
output = output.replace("<emotion1>", emotion1)
output = output.replace("<verb3>", verb3)
output = output.replace("<noun3>", noun3)
output = output.replace("<season>", season)
output = output.replace("<adjective2>", adjective2)
output = output.replace("<emotion2>", emotion2)
output = output.replace("<team_name>", team_name)
output = output.replace("<noun4>", noun4)
output = output.replace("<adjective3>", adjective3)

#Print the Mad Lib

print("\nHere is your Mad Lib...")
print(output, end="")
```

### hw1_part2.py

```python
#Perpare Variables

minutes = 00
seconds = 00
miles = 00.00
target_miles = 00.00

pace_seconds_per_mile = 00.00
pace_seconds = 00
pace_minutes = 00

speed_mph = 00.00

target_time_total_seconds = 00.00
target_time_seconds = 00
target_time_minutes = 00

#Get User Input

minutes = str(input("Minutes ==> "))
print(minutes)
seconds = str(input("Seconds ==> "))
print(seconds)
miles = str(input("Miles ==> "))
print(miles)
target_miles = str(input("Target Miles ==> "))
print(target_miles)

#Calculate Pace

pace_seconds_per_mile = (int(minutes) * 60 + int(seconds)) / float(miles)
pace_seconds = int(pace_seconds_per_mile % 60)
pace_minutes = int(pace_seconds_per_mile // 60)

#Calculate Speed

speed_mph = float(miles) / (int(minutes) / 60 + int(seconds) / 3600)

#Calculate Target Time

target_time_total_seconds = float(target_miles) * pace_seconds_per_mile
target_time_seconds = int(target_time_total_seconds % 60)
target_time_minutes = int(target_time_total_seconds // 60)

#Print Results

print("\nPace is " + str(pace_minutes) + " minutes and " + str(pace_seconds) + " seconds per mile.")
print("Speed is {0:.2f} miles per hour.".format(float(speed_mph)))
print("Time to run the target distance of {0:.2f} miles is {1} minutes and {2} seconds.".format(float(target_miles), int(target_time_minutes), int(target_time_seconds)), end="")
```

### hw1_part3.py

```python
#Prepare Variables
frame_character = ""
height = 0
width = 0
free_space = 0.0

#Get user input
frame_character = input("Enter frame character ==> ").strip()
print(frame_character)
height = int(input("Height of box ==> ").strip())
print(height)
width = int(input("Width of box ==> ").strip())
print(width, "\n")

#Calculate dimensions line
dimensions = str(width) + "x" + str(height)
free_space = width - 2 - len(dimensions)

#Calculate the left and right padding considering odd/even width
left_space = free_space // 2
right_space = free_space // 2 + (free_space % 2)

#Prepare rows
top_bottom_row = frame_character * width
empty_row = frame_character + " " * (width - 2) + frame_character
dimension_row = frame_character + " " * left_space + dimensions + " " * right_space + frame_character

#Calculate the number of rows before and after the dimensions row
before_rows = ((height - 2) // 2) - ((height - 1) % 2)
after_rows = height - 3 - before_rows

#Output box
print("Box:")
print(top_bottom_row)
print((empty_row + '\n') * before_rows, end="")
print(dimension_row)
print((empty_row + '\n') * after_rows, end="")
print(top_bottom_row)
```