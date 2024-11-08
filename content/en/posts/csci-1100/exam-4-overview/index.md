---
title: CSCI 1100 - Test 4 Overview and Practice Questions
subtitle:
date: 2024-04-26T03:54:07-04:00
slug: csci-1100-exam-4-overview
draft: true
author:
  name: James
  link: https://www.jamesflare.com
  email:
  avatar: /site-logo.avif
description: 
keywords: ["CSCI 1100","Computer Science","Test 4","Practice Questions", "Python"]
license:
comment: true
weight: 0
tags:
  - CSCI 1100
  - Exam
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
summary: 
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

## Overview

- The final exam will be held Monday, April 29, 2024 from 6:30 pm - 8:30 pm. Note that this will be a two-hour exam.
- Most students will take the exam from 6:30 pm - 8:30 pm (120 minutes). The exam will be given in 308 DCC for most students.
- Students who provided an accommodation letter indicating the need for extra time or a quiet location will be given extra time beyond the 2 hour base. Shianne Hulbert will send you a reminder for your time and location. Use whatever information she sends you. It overrides any assignments given you on Submitty. If you show up at your Submitty location or time, you will be allowed to take the exam, but you will lose the accommodations.
- Students MUST:
    - Go to their assigned rooms.
    - Bring their IDs to the exam.
    - Sit in the correct room/section.
    - Put away all calculators, phones, etc. and take off/out all headphones and earbuds

Failing to do one of these may result in a 20 point penalty on the exam score. Failure to do all can cost up to 80 points.

- During the exam, if you are doubtful/confused about a problem, simply state your assumptions and/or interpretation as comments right before your code and write your solution accordingly.
- Exam coverage is the entire semester, except for the following:
    - JSON data format
    - Images

You do not need to know the intricacies of tkinter GUI formatting, but you should understand the GUI code structure we outlined (Lecture Notes and Class Code), be able to trace through event driven code and write small methods that are invoked by the GUI. Consider the lecture exercises for Lecture 22 and the modifications you made to the BallDraw class during Lab 11 for practice.

- Please review lecture notes, class exercises, labs, homework, practice programs, and tests, working through problems on your own before looking at the solutions.
- You are expected to abide by the following Honor code when appearing for this exam:
    
    "On my honor, I have neither given nor received any aid on this exam."

- As part of our regular class time on Monday April 22, we will answer questions about the course material, so bring your questions!
- There are often study events held on campus, for example UPE often holds tutoring sessions. I do not know of any specific events right now, but we will post anything we learn to the Submitty discussion forum. Please monitor the channel if you are looking for help.
- What follows are a few additional practice problems. These are by no means comprehensive, so rework problems from earlier in the semester. All the material from tests 1, 2, and 3 are also fair game. This is a comprehensive final exam.
- We have separately provided Spring 2017's final exam.

## Questions

### Merge Without Extend

> Write a version of `merge` that does all of the work inside the `while` loop and does not use the `extend`.

### Three Way Merge

> Using what you learned from writing the solution to the previous problem, write a function to merge three sorted lists. For example:
>
> ```python
> print(three_way_merge([2, 3, 4, 4, 4, 5], [1, 5, 6, 9], [6, 9, 13]))
> ```
>
> Should output:
>
> ```
> [1, 2, 3, 4, 4, 4, 5, 5, 6, 6, 9, 9, 13]
> ```

### Score Range Counts

> Given a list of test scores, where the maximum score is 100, write code that prints the number of scores that are in the range 0-9, 10-19, 20-29, ... 80-89, 90-100. Try to think of several ways to do this. Outline test cases you should add.
>
> For example, given the list of scores:
>
> ```python
> scores = [12, 90, 100, 52, 56, 76, 92, 83, 39, 77, 73, 70, 80]
> ```
>
> The output should be something like:
>
> ```
> [0,9]: 0
> [10,19]: 1
> [20,29]: 0
> [30,39]: 1
> [40,49]: 0
> [50,59]: 2
> [60,69]: 0
> [70,79]: 4
> [80,89]: 2
> [90,100]: 3
> ```

### Closest 10 Values

> Given a list of floating point values containing at least 10 values, how do you find the 10 values that are closest to each other? In other words, find the smallest interval that contains 10 values. By definition the minimum and maximum of this interval will be values in the original list. These two values and the 8 in between constitute the desired answer. This is a bit of a challenging variation on earlier problems from the semester. Start by outlining your approach. Outline the test cases. For example, given the list:
>
> ```python
> values = [1.2, 5.3, 1.1, 8.7, 9.5, 11.1, 2.5, 3, 12.2, 8.8, 6.9, 7.4,
>           0.1, 7.7, 9.3, 10.1, 17, 1.1]
> ```
>
> The list of the closest 10 should be:
>
> ```
> [6.9, 7.4, 7.7, 8.7, 8.8, 9.3, 9.5, 10.1, 11.1, 12.2]
> ```
