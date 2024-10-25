---
title: CSCI 1100 - Homework 4 - Loops and Lists; Passwords and Quarantine
subtitle:
date: 2024-03-13T15:15:44-04:00
slug: csci-1100-hw-4
draft: false
author:
  name: James
  link: https://www.jamesflare.com
  email:
  avatar: /site-logo.avif
description: This blog post outlines the requirements and guidelines for completing Homework 4 in the CSCI 1100 - Computer Science 1 course, which consists of two parts focusing on password strength evaluation and analyzing COVID-19 quarantine states using Python programming.
keywords: ["CSCI 1100","Computer Science","Python","Password Strength","COVID-19"]
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
summary: This blog post outlines the requirements and guidelines for completing Homework 4 in the CSCI 1100 - Computer Science 1 course, which consists of two parts focusing on password strength evaluation and analyzing COVID-19 quarantine states using Python programming.
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

## Overview

This homework is worth 100 points total toward your overall homework grade. It is due in 1 week i.e., on Thursday, February 22, 2024 at 11:59:59 pm. As usual, there will be a mix of autograded points, instructor test case points, and TA graded points. There are two parts in the homework, each to be submitted separately. All parts should be submitted by the deadline or your program will be considered late.

See the handout for Submission Guidelines and Collaboration Policy for a discussion on grading and on what is considered excessive collaboration. These rules will be in force for the rest of the semester.

You will need the utilities and data files we provide in `hw4_files.zip`, so be sure to download this file from the Course Materials section of Submitty and unzip it into your directory for HW 4.

Module `hw4_util.py` is written to help you read information from the files. You do not need to know how functions provided in `hw4_util.py` are implemented (but feel free to examine the code, if you are interested), you can simply use them.

Final note, you will need to use loops in this assignment. We will leave the choice of the loop type up to you. Please feel free to use while loops or for loops depending on the task and your personal preference.

## Part 1: Password Strength

Often when you create a password it is judged for its strength. The estimate of strength is computed by applying several rules — about the length of the password, the presence of certain types of characters, its match against common passwords, and even its match against license plates. In this part of the homework you will implement a few simple strength judgment rules and then determine if a password is to be rejected, or rated poor, fair, good or excellent.

Your program should start by asking for, and reading in, a password. The program should then evaluate the password based on the following rules. Each rule contributes to a numerical score (which starts at 0):

1. **Length**: If the password is 6 or 7 characters long then add 1 to the score; if it is 8, 9 or 10 characters long then add 2; and longer than 10 add 3.
2. **Case**: If it contains at least two upper case letters and two lower case letters add 2 to the score, while if it contains at least one of each, add 1 to the score.
3. **Digits**: If it contains at least two digits add 2 to the score and if it contains at least one digit then add 1.
4. **Punctuation**: If it contains at least one of !@#$ add 1 and if it contains at least one of %^&* then add 1 (total possible of 2).
5. **NY License**: If it contains three letters (upper or lower case) followed by four digits, then it potentially matches a NY state license plate. In this case, subtract 2 from the score.
6. **Common Password**: If the lower case version of the password exactly matches a password found in a list of common passwords, then subtract 3 from the score.

Whenever a rule is applied that creates a change in the score, generate an explanatory line of output. After applying all the rules, output the score and then convert it to a final strength rating of the password:

- **Rejected**: the score is less than or equal to 0.
- **Poor**: the score is 1 or 2.
- **Fair**: the score is 3 or 4
- **Good**: the score is 5 or 6
- **Excellent**: the score is 7 or above.

### Notes

1. For this part and for part 2 you should write functions to keep the code clean, clear and easy to manage.
2. We have provided you with a number of examples that show output values and formatting. Please follow these examples closely.
3. The common passwords are extracted from a file. One of the utility functions we have provided reads this file and return a list of these passwords. To use this function, start by making sure that `hw4_util.py` and `password_list_top_100.txt` are in the same folder as your code. Then add the line
	```python
	import hw4_util
	```
	into your program. Finally, call function `hw4_util.part1_get_top` with no arguments. It will return a list of strings containing 100 passwords for you to compare against.
5. Submit only your program file `hw4_part1.py`. Do not submit `hw4_util.py`.

## Part 2: COVID-19 Quarantine States

The NY State COVID-19 Travel Advisory at [COVID-19 Travel Advisory](https://coronavirus.health.ny.gov/covid-19-travel-advisory) requires that individuals who travel to New York from states that have significant community spread of COVID-19 must self-quarantine for 14 days. “Significant spread” in a state is measured as either:

- a daily average of more than 10 people per 100,000 residents tested positive in the previous seven days, or
- a daily average of more than 10% of tests were positive in the previous seven days.

We will refer to states having a significant spread as quarantine states. In this part of HW 4 you will use per state data downloaded from [COVID Tracking Project](https://covidtracking.com/) to answer queries about which states were quarantine states and when.

The data we obtained was downloaded (on October 5, 2023) in the form of a large “comma-separated value” file. This file contains one line per day per state, and there are many fields per line. We have condensed it to a form suitable for a CS 1 homework. The data is shared under the Creative Commons BY 4.0 license which means we can:

- Share: copy and redistribute the material in any medium or format and
- Adapt: remix, transform, and build upon the material for any purpose, even commercially.

We have provided a simple utility to give you access to the condensed data. To use this (similar to Part 1) you must have the files `hw4_util.py` and `prob2_data.csv` in the same folder as your own code. You must then

```python
import hw4_util
```

into your program. `hw4_util` has a function called `part2_get_week` that accepts a single integer argument, `w`, and returns a list of lists. Argument `w` is the index of a previous week, with `w==1` being the most recent week, `w==2` being the week before that, etc., up to `w==29` which corresponds to 29 weeks ago, all the way back to March 15. The returned list contains one list per state, plus the District of Columbia (DC) and Puerto Rico (PR) — 52 in all. Each state list has 16 items:

- Item 0 is a string giving the two letter (upper case) state abbreviation. These are correct.
- Item 1 is an integer giving the state’s population estimate — from the 2019 Census Bureau estimate [Census Bureau estimate](https://www.census.gov/newsroom/press-kits/2019/national-state-estimates.html).
- Items 2-8 are the number of positive tests for that state in each of the seven days of the specified week — most recent day first.
- Items 9-15 are the number of negative tests for the state in each of the seven days of 
- the specified week — most recent day first.

For example, the list for Alaska for week 1 is

```text
['AK',\
731545,\
189,147,128,132,106,125,118,\
3373,3819,6839,4984,6045,6140,1688]
```

Here is what you need to do for this assignment. Your program, in a loop, must start by asking the user to specify the index for a week, as described above. (You may assume an integer is input as the week number.) A negative number for the week indicates that the program should end. For non-negative numbers, if the data are not available for that week the function will return an empty list; in this case, skip the rest of loop body. Otherwise, after getting the list of lists back, the program should answer one of four different requests for information about that week. Answering the request starts by the user typing in a keyword. The keywords are 'daily', 'pct', 'quar', 'high'. Here’s what the program must do for each request:

- **'daily'**: Ask the user for the state abbreviation and then output the average daily positive cases per 100,000 people for that state for the given week, accurate to the nearest tenth.
- **'pct'**: Ask the user for the state abbreviation and then output the average daily percentage of tests that are positive over the week, accurate to the nearest tenth of a percent.
- **'quar'**: Output the list of state abbreviations, alphabetically by two-letter abbreviation, of travel quarantine states for the given week as discussed above. There should be ten state abbreviations per line—call `hw4_util.print_abbreviations` with your list of abbreviations to print the output as required. (Note: every week has at least one quarantine state.)
- **'high'**: Output the two-letter abbreviation of the state that had the highest daily average number of positive cases per 100,000 people over the given week, and output this average number, accurate to the nearest tenth.

Input key words and state abbreviations may be typed in upper or lower case and still match correctly. If a key word is not one of these four or if a state is not found (because its abbreviation is incorrectly typed), output a simple error message and do nothing more in the current loop iteration.

## Notes

1. As always, look at the example output we provide and follow it accurately.
2. All reported values for numbers of positive and negative test results will be at least 0; however, some may be 0. You may assume, however, that there will never be a week where all days have 0 negative tests.
3. Compute the daily percentage of tests that are positives by summing the positive cases for the week, and summing negative cases for the week. If these sums are P and N respectively, then the percentage positive is $P/(P +N) * 100$. This is not exactly the same as the average of daily percentages for a week, but it is easier to compute.
4. Submit only your program file `hw4_part2.py`. Do not submit `hw4_util.py`.

## Supporting Files

{{< link href="HW4.zip" content="HW4.zip" title="Download HW4.zip" download="HW4.zip" card=true >}}

## Solution

### hw4_part1.py

```python
import hw4_util

if __name__ == "__main__":
    # initialize variables
    strength = 0
    report = ""

    # Debugging

    #user_password = "AdmIn123%^%*(&"
    #user_password = "jaX1234"

    # get user input
    user_password = str(input("Enter a password => ").strip())

    # print the password for testing purposes
    print(user_password)

    # get the length of the password
    length = len(user_password)

    # check the length of the password and update strength and report accordingly
    if length <= 7 and length >= 6:
        strength += 1
        report += "Length: +1\n"
    elif length >= 8 and length <= 10:
        strength += 2
        report += "Length: +2\n"
    elif length > 10:
        strength += 3
        report += "Length: +3\n"

    # count the number of uppercase and lowercase letters in the password
    num_upper = sum(1 for c in user_password if c.isupper())
    num_lower = sum(1 for c in user_password if c.islower())

    # check the number of uppercase and lowercase letters and update strength and report accordingly
    if num_upper >= 2 and num_lower >= 2:
        strength += 2
        report += "Cases: +2\n"
    elif num_upper >= 1 and num_lower >= 1:
        strength += 1
        report += "Cases: +1\n"

    # count the number of digits in the password
    num_digits = sum(1 for c in user_password if c.isdigit())

    # check the number of digits and update strength and report accordingly
    if num_digits >= 2:
        strength += 2
        report += "Digits: +2\n"
    elif num_digits >= 1:
        strength += 1
        report += "Digits: +1\n"

    # check for special characters and update strength and report accordingly
    if any(c in "!@#$" for c in user_password):
        strength += 1
        report += "!@#$: +1\n"
    if any(c in "%^&*" for c in user_password):
        strength += 1
        report += "%^&*: +1\n"

    # check for a specific pattern and update strength and report accordingly
    if (num_upper + num_lower) == 3 and num_digits == 4 and len(user_password) > 3:
        check = user_password.replace(user_password[0:3], "")
        if sum(1 for c in check if c.isdigit()) == 4:
            strength -= 2
            report += "License: -2\n"

    # check if the password is in the top 10,000 most common passwords and update strength and report accordingly
    if user_password.lower() in hw4_util.part1_get_top():
        strength -= 3
        report += "Common: -3\n"

    # add the combined score to the report
    report += "Combined score: " + str(strength) + "\n"

    # check the strength and add the appropriate message to the report
    if strength <= 0:
        report += "Password is rejected"
    elif strength >= 1 and strength <= 2:
        report += "Password is poor"
    elif strength >= 3 and strength <= 4:
        report += "Password is fair"
    elif strength >= 5 and strength <= 6:
        report += "Password is good"
    elif strength >= 7:
        report += "Password is excellent"

    # print the report
    print(report)
```

### hw4_part2.py

```python
import hw4_util

"""
hw4_util.part2_get_week(1)[0] ==> ['AK',\
    731545, 189, 147, 128, 132, 106, 125,\
    118, 3373, 3819, 6839, 4984, 6045,\
    6140, 1688]
"""

def find_state(states, state):
    state = state.upper()
    found_status = False
    for i in states:
        if i[0].upper() == state:
            found_status = True
            return i
    if not found_status:
        return []

def get_postive_per_100k(status):
    population = status[1]
    total_postive = 0
    for i in range (2, 9):
        total_postive += status[i]
    postive_per_100k = ((total_postive / 7) / population) * 100000
    return postive_per_100k
    
def get_pct_postive_tests(status):
    num_tested = 0
    num_postive = 0
    for i in range (2, 16):
        num_tested += status[i]
    for i in range (2, 9):
        num_postive += status[i]
    pct_postive_tests = num_postive / num_tested
    return pct_postive_tests

def action_valid(request_code):
    request_code = request_code.lower()
    allowed_action = ["daily", "pct", "quar", "high"]
    if request_code in allowed_action:
        return True
    else:
        return False

def quar(week):
    states = []
    for i in week:
        if get_postive_per_100k(i) >= 10 or get_pct_postive_tests(i) >= 0.1:
            states.append(i[0])
    states.sort()
    return states

def high(week):
    highest = ""
    highest_value = 0
    for i in week:
        if get_postive_per_100k(i) > highest_value:
            highest = i[0]
            highest_value = get_postive_per_100k(i)
    return highest.upper()

def show_high(week):
    highest = high(week)
    highest_postive_per_100k = get_postive_per_100k(find_state(week, highest))
    print("State with highest infection rate is", highest)
    print("Rate is {:.1f} per 100,000 people".format(highest_postive_per_100k))


if __name__ == "__main__":
    index_week = 0 # Initialize index_week
    print("...")
    
    while index_week != -1:
        # Get index of week
        index_week = input("Please enter the index for a week: ").strip()
        print(index_week)
        index_week = int(index_week)
        
        # Stop if the index is -1
        if index_week < 0:
            break
        
        # Get the week, check if the week is valid
        week = hw4_util.part2_get_week(index_week).copy()
        if week == []:
            print("No data for that week")
            print("...")
            continue
        
        # Get the Action
        request_code = input("Request (daily, pct, quar, high): ").strip()
        print(request_code)
        request_code = request_code.lower()
        
        # Check if the action is valid
        if not action_valid(request_code):
            print("Unrecognized request")
            print("...")
            continue
        
        # Perform the action
        if request_code == "daily":
            state = input("Enter the state: ").strip()
            print(state)
            state = state.upper()
            if find_state(week,state) == []:
                print("State {} not found".format(state))
                print("...")
            else:
                state_data = find_state(week,state)
                print("Average daily positives per 100K population: {:.1f}".format(get_postive_per_100k(state_data)))
                print("...")
        elif request_code == "pct":
            state = input("Enter the state: ").strip()
            print(state)
            state = state.upper()
            if find_state(week,state) == []:
                print("State {} not found".format(state))
                print("...")
            else:
                state_data = find_state(week,state)
                print("Average daily positive percent: {:.1f}".format(get_pct_postive_tests(state_data)*100))
                print("...")
        elif request_code == "quar":
            print("Quarantine states:")
            hw4_util.print_abbreviations(quar(week))
            print("...")
        elif request_code == "high":
            show_high(week)
            print("...")
```