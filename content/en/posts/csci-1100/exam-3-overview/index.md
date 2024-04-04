---
title: CSCI 1100 - Test 3 Overview and Practice Questions
subtitle:
date: 2024-04-03T03:54:07-04:00
slug: csci-1100-exam-3-overview
draft: false
author:
  name: James
  link: https://www.jamesflare.com
  email:
  avatar: /site-logo.avif
description: This blog post provides an overview of Test 3 for CSCI 1100 - Computer Science 1, including important logistical instructions, topics covered, and practice questions on sets, dictionaries, classes, and file I/O in Python
keywords: ["CSCI 1100","Computer Science","Test 2","Practice Questions", "Python", "Sets", "Dictionaries", "Classes", "File I/O"]
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
summary: This blog post provides an overview of Test 3 for CSCI 1100 - Computer Science 1, including important logistical instructions, topics covered, and practice questions on sets, dictionaries, classes, and file I/O in Python
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

## Important Logistical Instructions:

- Test 3 will be held Thursday, April 4, 2024.
- Most students will take the exam from 6:00 - 7:30 pm (90 minutes).
- Students who provided us with an accommodation letter indicating the need for extra time or a quiet location will be given extra time beyond 7:30.
- Room assignments will be posted on Submitty by the Wednesday night before the exam, April 3rd.
- Students MUST:
  - Go to their assigned rooms.
  - Bring their IDs to the exam.
  - Sit in the correct section.
  - Put away all calculators, phones, etc. and take off/out all headphones and earbuds
  - Hand over their tests as soon as the time is up. Those found working on the test after 90 minutes will receive a zero.

Failing to do one of these may result in a 20 point penalty on the exam score. Failure to do all can cost up to 80 points.

- You cannot leave the exam room (not even for a bathroom break) until you hand over your exam.
- Similar to exam 1 and 2, a one-page crib-sheet is allowed during the test.

## Overview

- Primary coverage is Lectures 14-19, Labs 7-9, HW 5-7.
- Please review lecture notes, class exercises, labs, homework, practice programs, and tests, working through problems on your own before looking at the solutions.
- Some problems will be related to material covered in Exam 2:
  - Lists and files
  - List and string splitting; ranges
- You should review relevant material from the Exam 2 practice problems if you are not yet comfortable with these topics.
- No calculators, no textbook, no classnotes, no electronics of any kind! BUT, you may bring a one-page, double-sided, 8.5” x 11” “crib sheet” sheet with you. You may prepare this as you wish, and you may work in groups to prepare a common crib sheet. Of course, each of you must have your own copy during the test. You will need to turn in a signed copy of your crib sheet at the end of the test. If you need to keep a copy for your records, please photocopy it prior to coming to the exam.
- Please refer back to the Test 1 and Test 2 practice problems for further instructions.

## Questions

### Not Used

> Write a function called `notused` that takes a list of words as its single parameter, and returns a set containing the letters of the English alphabet that are not used by any of the words in the input list. Your function must use sets. Here is an example of how your function should work:
>
> ```python
> >>> notused([ "Dog", "pony", "elephant", "Tiger", "onyx", "Zebu" ])
> {'c', 'f', 'k', 'j', 'm', 'q', 's', 'w', 'v'}
> ```
>
> Hint: you can use the following set in your solution:
>
> ```python 
> all_letters = set("abcdefghijklmnopqrstuvwxyz")
> ```

{{< details summary="**Answer of This Question**" >}}
Here's a Python function `notused` that takes a list of words and returns a set containing the letters of the English alphabet that are not used by any of the words in the input list:

```python
def notused(words):
    all_letters = set("abcdefghijklmnopqrstuvwxyz")
    used_letters = set()

    for word in words:
        used_letters |= set(word.lower())

    return all_letters - used_letters
```

Explanation:

1. We define the function `notused` that takes a list of words as its parameter.

2. We create a set called `all_letters` that contains all the lowercase letters of the English alphabet using `set("abcdefghijklmnopqrstuvwxyz")`.

3. We initialize an empty set called `used_letters` to store the letters used by the words in the input list.

4. We start a loop that iterates over each word in the `words` list.

5. For each word, we convert it to lowercase using `word.lower()` to ensure case-insensitivity. Then, we convert the lowercase word into a set of its individual letters using `set(word.lower())`.

6. We update the `used_letters` set by taking the union of itself with the set of letters from the current word using the `|=` operator. This adds any new letters from the current word to the `used_letters` set.

7. After the loop, `used_letters` will contain all the letters used by the words in the input list.

8. Finally, we return the set difference between `all_letters` and `used_letters` using `all_letters - used_letters`. This gives us the set of letters from the English alphabet that are not used by any of the words in the input list.

Here's an example of how the function works:

```python
print(notused(["Dog", "pony", "elephant", "Tiger", "onyx", "Zebu"]))
# Output: {'c', 'f', 'k', 'j', 'm', 'q', 's', 'w', 'v'}
```

In this example, the function `notused` is called with a list of words. It returns a set containing the letters 'c', 'f', 'k', 'j', 'm', 'q', 's', 'w', and 'v', which are the letters of the English alphabet that are not used by any of the words in the input list.

The solution uses sets to efficiently handle the comparison and difference operations between the sets of letters.
{{< /details >}}

### Set Intersection

> Given three sets, `s1`, `s2`, and `s3`, write a short segment of Python code to find the values that are in exactly one of the three sets. The result should be stored in a set called `s`. You may NOT use any loops or ifs.

{{< details summary="**Answer of This Question**" >}}
To find the values that are in exactly one of the three sets `s1`, `s2`, and `s3` without using any loops or conditionals, you can use set operations in Python. Here's the code segment:

```python
s = (s1 ^ s2 ^ s3) - (s1 & s2) - (s1 & s3) - (s2 & s3)
# Or this one
#s = (s1 - s2 - s3) | (s2 - s1 - s3) | (s3 - s1 - s2)
```

Explanation:

1. The `^` operator performs the symmetric difference operation between sets. It returns a new set that contains elements that are in either of the sets but not in both.
   - `s1 ^ s2 ^ s3` gives us a set containing elements that are in exactly one or all three sets.

2. To remove the elements that are in more than one set, we need to subtract the intersections of each pair of sets.
   - `s1 & s2` gives us the elements that are common to both `s1` and `s2`.
   - `s1 & s3` gives us the elements that are common to both `s1` and `s3`.
   - `s2 & s3` gives us the elements that are common to both `s2` and `s3`.

3. By subtracting the intersections `(s1 & s2)`, `(s1 & s3)`, and `(s2 & s3)` from the symmetric difference `(s1 ^ s2 ^ s3)`, we remove the elements that are in more than one set.

4. The resulting set `s` will contain only the elements that are in exactly one of the three sets `s1`, `s2`, and `s3`.

This code segment achieves the desired result without using any loops or conditionals, utilizing only set operations.
{{< /details >}}

### Words in All Strings

> Given three strings of words, with each word separated by a space, write code to output the number of words that appear in all three strings. Assume the strings are associated with the variables `w1`, `w2` and `w3`.
>
> For 
> ```python
> w1 = "the quick brown fox jumps over the lazy dog"
> w2 = "hey diddle diddle the cat and the fiddle the cow jumps over the moon"  
> w3 = "jack and jill went over the hill to fetch a pail of water"
> ```
> The output should be `2` because `the` and `over` appear in all three. No loops are allowed. You can solve this in one (long) line of code. In this case, it is acceptable to use more than one line, but make sure you understand the one-line solution when you see it.

{{< details summary="**Answer of This Question**" >}}
To find the number of words that appear in all three strings without using loops, you can use the `set` data structure and the `intersection` method. Here's the solution:

```python
print(len(set(w1.split()) & set(w2.split()) & set(w3.split())))
```

Explanation:

1. We use the `split()` method on each string (`w1`, `w2`, `w3`) to split them into lists of words. By default, `split()` splits the string on whitespace, which separates the words.

2. We convert each list of words into a set using `set()`. A set is an unordered collection of unique elements, so it eliminates any duplicate words within each string.

3. We use the `&` operator (set intersection) to find the common elements between the sets. The intersection of two sets returns a new set containing only the elements that are present in both sets.

4. We chain the `&` operator to find the intersection of all three sets, which gives us a set of words that appear in all three strings.

5. Finally, we use the `len()` function to count the number of elements in the resulting set, which represents the number of words that appear in all three strings.

The one-line solution combines all these steps into a single line of code, making it concise but potentially less readable. It's important to understand the individual steps and the concept of set intersection to comprehend the one-line solution.

You can test the code with the provided example:

```python
w1 = "the quick brown fox jumps over the lazy dog"
w2 = "hey diddle diddle the cat and the fiddle the cow jumps over the moon"  
w3 = "jack and jill went over the hill to fetch a pail of water"

print(len(set(w1.split()) & set(w2.split()) & set(w3.split())))  # Output: 2
```

The output will be `2` because the words "the" and "over" appear in all three strings.
{{< /details >}}

### Set Operations Output

> What is the output when the following code is run by Python? For sets, do not worry about getting the exact order of the output correct.
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
> Of course, you can make up many other questions about set operations.

{{< details summary="**Answer of This Question**" >}}
The output of the given code will be:

```text
{12, 7}
{'b', 7, 9, 10, 12, 'car', 'abc'}
True
False
True
{12, 7, 14, 'ab'}
```

Explanation:

1. `s1 = set([7, 9, 12, 7, 9])`: This creates a set `s1` with elements 7, 9, and 12. Duplicates are automatically removed.

2. `s2 = set(['abc', 12, 'b', 'car', 7, 10, 12])`: This creates a set `s2` with elements 'abc', 12, 'b', 'car', 7, and 10. Again, duplicates are removed.

3. `s3 = set([12, 14, 12, 'ab'])`: This creates a set `s3` with elements 12, 14, and 'ab'.

4. `print(s1 & s2)`: This performs the intersection operation between sets `s1` and `s2`, which returns a new set containing the common elements. The output will be `{12, 7}`.

5. `print(s1 | s2)`: This performs the union operation between sets `s1` and `s2`, which returns a new set containing all the elements from both sets. The output will be `{'b', 7, 9, 10, 12, 'car', 'abc'}`.

6. `print('b' in s2)`: This checks if the element 'b' is present in set `s2`. It will output `True` since 'b' is in `s2`.

7. `print('ab' in s2)`: This checks if the element 'ab' is present in set `s2`. It will output `False` since 'ab' is not in `s2`.

8. `print('ab' in s3)`: This checks if the element 'ab' is present in set `s3`. It will output `True` since 'ab' is in `s3`.

9. `s2.discard(12)`: This removes the element 12 from set `s2` if it exists. After this operation, `s2` will be `{'abc', 'b', 'car', 7, 10}`.

10. `print((s1 & s2) ^ s3)`: This performs the following operations:
    - `s1 & s2` calculates the intersection of sets `s1` and `s2`, which is `{7}`.
    - `(s1 & s2) ^ s3` performs the symmetric difference operation between the result of `s1 & s2` and set `s3`. It returns a new set containing elements that are in either `(s1 & s2)` or `s3`, but not in both. The output will be `{12, 7, 14, 'ab'}`.

The order of elements in the output sets may vary since sets are unordered collections. The actual output you provided matches the expected output.
{{< /details >}}

### Restaurant Reviews

> You are given a dictionary containing reviews of restaurants. Each key is the name of the restaurant. Each item in the dictionary is a list of reviews. Each review is a single string. See the example below.
> ```python
> rest_reviews = {"DeFazio's":["Great pizza", "Best in upstate"], \
>   "I Love NY Pizza":["Great delivery service"], \
>   "Greasy Cheese": [ "Awful stuff", "Everything was terrible" ] }
> ```
> Assuming `rest_reviews` has already been created, solve the following problems.
>
> (a) Write code to find all restaurants where the review contains at least one of the following words: awful, terrible, dump. For each restaurant found, output the name of the restaurant and the number of reviews that have at least one of the words. Be careful about capitalization. 'Awful' and 'awful' should match.
>
> (b) Write code to find and print the name of the restaurant with the highest number of reviews. If there is more than one restaurant with the same number of reviews, print the names of each of these restaurants.
>  
> (c) Write a function that takes as arguments the review dictionary, a new review, and the name of a restaurant. The function should add the review to the dictionary. If the restaurant is already in the dictionary, the function should add the review to the existing list of reviews for that restaurant. If the restaurant is not in the dictionary, the function should add a new item to the dictionary. Your function should be called by `add_review(rest_reviews, new_review, rest_name)`
>
> (d) Write a function that takes the same arguments as `add_review`, but deletes the given review. Specifically, if the review is in the dictionary associated with the restaurant, the function should delete the review and return True. Otherwise, the function should return False. If the given restaurant is not in the dictionary, the function should also return False. The function should be called by `del_review(rest_reviews, old_review, rest_name)`


{{< details summary="**Answer of Part A**" >}}
```python
for restaurant, reviews in rest_reviews.items():
    count = 0
    for review in reviews:
        if any(word in review.lower() for word in ["awful", "terrible", "dump"]):
            count += 1
    if count > 0:
        print(f"{restaurant}: {count} review(s) containing the specified words")
```

Explanation:
- We iterate over each restaurant and its reviews in the `rest_reviews` dictionary.
- For each restaurant, we initialize a `count` variable to keep track of the number of reviews containing the specified words.
- We iterate over each review and check if any of the specified words ("awful", "terrible", "dump") are present in the review (case-insensitive).
- If a review contains any of the specified words, we increment the `count`.
- After checking all reviews for a restaurant, if the `count` is greater than 0, we print the restaurant name and the count of reviews containing the specified words.
{{< /details >}}

{{< details summary="**Answer of Part B**" >}}
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

print("Restaurant(s) with the highest number of reviews:")
for restaurant in restaurants_with_max_reviews:
    print(restaurant)
```

Explanation:
- We initialize `max_reviews` to keep track of the highest number of reviews and `restaurants_with_max_reviews` to store the restaurant(s) with the highest number of reviews.
- We iterate over each restaurant and its reviews in the `rest_reviews` dictionary.
- For each restaurant, we calculate the number of reviews using `len(reviews)`.
- If the number of reviews is greater than the current `max_reviews`, we update `max_reviews` and set `restaurants_with_max_reviews` to a list containing only the current restaurant.
- If the number of reviews is equal to `max_reviews`, we append the current restaurant to `restaurants_with_max_reviews`.
- Finally, we print the restaurant(s) with the highest number of reviews.
{{< /details >}}

{{< details summary="**Answer of Part C**" >}}
```python
def add_review(rest_reviews, new_review, rest_name):
    if rest_name in rest_reviews:
        rest_reviews[rest_name].append(new_review)
    else:
        rest_reviews[rest_name] = [new_review]
```

Explanation:
- The `add_review` function takes the `rest_reviews` dictionary, a `new_review`, and the `rest_name` as arguments.
- If the `rest_name` is already present in the `rest_reviews` dictionary, we append the `new_review` to the existing list of reviews for that restaurant.
- If the `rest_name` is not in the dictionary, we create a new entry in the dictionary with the `rest_name` as the key and a list containing the `new_review` as the value.
{{< /details >}}

{{< details summary="**Answer of Part D**" >}}
```python
def del_review(rest_reviews, old_review, rest_name):
    if rest_name in rest_reviews:
        if old_review in rest_reviews[rest_name]:
            rest_reviews[rest_name].remove(old_review)
            return True
    return False
```

Explanation:
- The `del_review` function takes the `rest_reviews` dictionary, an `old_review`, and the `rest_name` as arguments.
- If the `rest_name` is present in the `rest_reviews` dictionary, we check if the `old_review` is in the list of reviews for that restaurant.
- If the `old_review` is found, we remove it from the list using the `remove` method and return `True` to indicate successful deletion.
- If the `rest_name` is not in the dictionary or the `old_review` is not found, we return `False` to indicate that the deletion was not successful.
{{< /details >}}

### Python Output

> For each of the following sections of code, write the output that Python would generate:
>
> Part A
> ```python
> x = {1:['joe',set(['skiing','reading'])],\
> 2:['jane',set(['hockey'])]}
> x[1][1].add('singing')
> x[1][0] = 'kate'
> for item in sorted(x.keys()):
>     print(x[item][0], len(x[item][1]))
> ```
>
> Part B
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
> Part C: Note that this problem requires an understanding of aliasing.
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
> Part D:
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

{{< details summary="**Answer of Part A**" >}}
Output:
```
kate 3
jane 1
```

Explanation:
1. The code creates a dictionary `x` with keys 1 and 2. The value for key 1 is a list containing the string 'joe' and a set with elements 'skiing' and 'reading'. The value for key 2 is a list containing the string 'jane' and a set with the element 'hockey'.
2. The line `x[1][1].add('singing')` adds the element 'singing' to the set at index 1 of the list associated with key 1 in the dictionary `x`.
3. The line `x[1][0] = 'kate'` updates the string at index 0 of the list associated with key 1 in the dictionary `x` to 'kate'.
4. The `for` loop iterates over the sorted keys of the dictionary `x`.
5. For each key `item`, it prints the string at index 0 of the corresponding list (`x[item][0]`) and the length of the set at index 1 of the list (`len(x[item][1])`).
6. The output shows that for key 1, the string is 'kate' and the set has 3 elements, and for key 2, the string is 'jane' and the set has 1 element.
{{< /details >}}

{{< details summary="**Answer of Part B**" >}}
Output:
```
** alice
** bob
** jane
!! jane
!! kristin
```

Explanation:
1. The code creates a dictionary `y` with keys 'jane', 'alice', 'bob', and 'kristin', and their corresponding values.
2. The variable `m` is initialized to 0.
3. The first `for` loop iterates over the sorted keys of the dictionary `y`.
4. For each `person`, if the value `y[person]` is greater than `m`, it prints `"** " + person` and updates `m` to the value of `y[person]`. This finds the maximum value in the dictionary.
5. The output of the first loop shows that 'alice', 'bob', and 'jane' are printed with `"**"` prefix because their values are greater than the initial value of `m` (which is 0).
6. After the first loop, `m` holds the maximum value found in the dictionary, which is 10.
7. The second `for` loop iterates over the sorted keys of the dictionary `y` again.
8. For each `person`, if the value `y[person]` is equal to `m` (the maximum value), it prints `"!! " + person`.
9. The output of the second loop shows that 'jane' and 'kristin' are printed with `"!!"` prefix because their values are equal to the maximum value `m` (which is 10).

Thank you for pointing out the mistake. I appreciate your attention to detail!
{{< /details >}}

{{< details summary="**Answer of Part C**" >}}
Output:
```
5 0 1 6 
8 car b k 
```

Explanation:
1. The code creates two lists, `L1` and `L2`, and a dictionary `d` with keys 5 and 8. The value for key 5 is `L1`, and the value for key 8 is `L2`.
2. The line `L1[2] = 6` updates the element at index 2 of `L1` to 6.
3. The line `d[8].append('k')` appends the element 'k' to the list `L2`, which is the value for key 8 in the dictionary `d`.
4. The line `L2[0] = 'car'` updates the element at index 0 of `L2` to 'car'.
5. The `for` loop iterates over the sorted keys of the dictionary `d`.
6. For each key `k`, it prints the string representation of `k` followed by a space.
7. The nested `for` loop iterates over the values `v` in the list `d[k]` and prints the string representation of each `v` followed by a space.
8. After each inner loop, it prints a newline character to move to the next line.
9. The output shows that for key 5, the corresponding list is `[0, 1, 6]`, and for key 8, the corresponding list is `['car', 'b', 'k']`.
{{< /details >}}

{{< details summary="**Answer of Part D**" >}}
Output:
```
[5, 1, 2]
0
2
4
6
```

Explanation:
1. The code creates a list `L1` with elements `[0, 1, 2, 4, 1, 0]`.
2. The line `s1 = set(L1)` creates a set `s1` from the elements of `L1`. The set will contain only unique elements from `L1`, which are `{0, 1, 2, 4}`.
3. The lines `L1.pop()`, `L1.pop()`, and `L1.pop()` remove the last three elements from the list `L1`. After these operations, `L1` becomes `[0, 1, 2]`.
4. The line `L1[0] = 5` updates the element at index 0 of `L1` to 5. Now, `L1` becomes `[5, 1, 2]`.
5. The line `s1.add(6)` adds the element 6 to the set `s1`. The set `s1` becomes `{0, 1, 2, 4, 6}`.
6. The line `s1.discard(1)` removes the element 1 from the set `s1`. The set `s1` becomes `{0, 2, 4, 6}`.
7. The line `print(L1)` prints the updated list `L1`, which is `[5, 1, 2]`.
8. The `for` loop iterates over the sorted elements `v` in the set `s1` and prints each element on a new line.
9. The output shows the updated list `L1` and the elements of the set `s1` in sorted order, which are `0`, `2`, `4`, and `6`.

Thank you for bringing this to my attention. I appreciate your careful review of the answers!
{{< /details >}}

### Person Class

> Suppose `Person` is a class that stores for each person their name, birthday, name of their mother and father. All of these are strings. The start of the class, including the initializer, is given below.
> ```python
> class Person(object):
>     def __init__(self, n, bd, m, f):
>         self.name = n
>         self.birthday = bd
>         self.mother = m
>         self.father = f
> ```
> Write a method for the `Person` class that takes as an argument self and another `Person` object and returns `2` if the two people are twins, `1` if they are siblings (but not twins), `-1` if two people are the same, and `0` otherwise. Note that siblings or twins must have the same mother and the same father.

{{< details summary="**Answer of This Question**" >}}
To determine the relationship between two `Person` objects, we can compare their mother, father, and birthday attributes. Here's the method you can add to the `Person` class:

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

Explanation:

1. The method `relationship` takes two arguments: `self` (the current `Person` object) and `other` (another `Person` object).

2. We first check if `self` and `other` refer to the same `Person` object using the equality operator `==`. If they are the same object, we return -1.

3. If `self` and `other` are not the same object, we check if they have the same mother and father by comparing the `mother` and `father` attributes of both objects. If they have the same mother and father, it means they are either twins or siblings.

4. If `self` and `other` have the same mother and father, we further check their `birthday` attribute:
   - If their birthdays are the same, we return 2 to indicate that they are twins.
   - If their birthdays are different, we return 1 to indicate that they are siblings (but not twins).

5. If `self` and `other` do not have the same mother and father, we return 0 to indicate that they are not related as siblings or twins.

With this method added to the `Person` class, you can create `Person` objects and determine their relationship using the `relationship` method. For example:

```python
person1 = Person("John", "1990-01-01", "Mary", "David")
person2 = Person("Jane", "1990-01-01", "Mary", "David")
person3 = Person("Alice", "1992-05-10", "Mary", "David")
person4 = Person("Bob", "1995-03-15", "Lisa", "Tom")

print(person1.relationship(person2))  # Output: 2 (twins)
print(person1.relationship(person3))  # Output: 1 (siblings)
print(person1.relationship(person4))  # Output: 0 (not related)
print(person1.relationship(person1))  # Output: -1 (same person)
```

The `relationship` method correctly determines the relationship between two `Person` objects based on their mother, father, and birthday attributes.
{{< /details >}}

### Merge Dictionaries

> You are given dictionaries D1 and D2 where each key is a string representing a name and each value is a set of phone numbers. Write a function to merge D1 and D2 into a single dictionary D. D should contain all the information in both D1 and D2. As an example,
> 
> ```python
> D1 = {'Joe':set(['555-1111','555-2222']), 'Jane':set(['555-3333'])}
> D2 = {'Joe':set(['555-2222','555-4444']), 'Kate':set(['555-6666'])}
> merge_dict(D1,D2)
> {'Joe':set(['555-1111','555-2222','555-4444']), 'Jane':set(['555-3333']), 'Kate':set(['555-6666']) }
> ```

### Student Class

> This question involves a class called Student that stores the student's name (a string), id number (a string), courses taken (list of strings), and major (a string). Write the Python code that implements this class, including just the following methods:
>
> (a) An initializer having as parameters only the name and the id. This should initialize the list of courses to empty and the major to "Undeclared". An example use of this method would be:
>
> ```python
> p = Student( "Chris Student", "123454321" )
> ```
>
> (b) A method called "add_courses" to add a list of courses to the courses that the student takes. For example, the following should add three courses to Chris Student.
>
> ```python 
> p.add_courses( [ "CSCI1100", "BASK4010", "GEOL1320" ] )
> ```
>
> (c) A method called common_courses that returns a list containing the courses two students have taken in common:
>  
> ```python
> q = Student( "Bilbo Baggins", "545454545" )
> q.add_courses( [ "MATH1240", "CSCI1100", "HIST2010", "BASK4010" ] ) 
> print(q.common_courses(p))
> [ "CSCI1100", "BASK4010" ]
> ```

Here is the text processed with the requested formatting:

### Taking Multiple CSCI Courses

> Using the Student methods and attributes from the previous question, suppose you are given a list of student objects called all_students. Write a segment of code to output the names of all students who have taken at least two courses that start with CSCI.

### K Smallest Values

> Given a list L and a positive integer k, create a new list containing only the k smallest values in L list. For example, if L = [ 15, 89, 3, 56, 83, 123, 51, 14, 15, 67, 15 ] and k=4, then the new list should have the values Ls = [3, 14, 15, 15] (Note that one of the 15s is not here.) Write a function, k_smallest(L,k), that returns the desired list. It does this using sorting, but does not change L. Do this in 4 lines of code without writing any loops.

### Code Segment Output

> What is the output of the following two code segments?
>
> ```python
> # Part A 
> dt = { 1: [ 'mom', 'dad'], 'hi': [1, 3, 5 ]}
> print(len(dt))
> print(dt[1][0])
> dt['hi'].append(3)
> dt[1][0] = 'gran'
> print(dt[1])
> ```
>
> ```python
> # Part B
> # Remember that pop() removes and returns the last value from the list.
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

### Finding Names by Age

> Given is a list of dictionaries, where each dictionary stores information about a person in the form of attribute (key) / value pairs. For example, here is a list of dictionaries representing four people:
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
> Write code that finds and outputs, in alphabetical order, the names of all people whose age is known to be at least 30. You may assume that each dictionary in people has a 'name' key, but not necessarily a 'age' key. For the example above, the output should be:
>
> ```text
> Andre
> Sue  
> ```

### Creating a City to State Dictionary

> Given a dictionary that associates the names of states with a list of the names of (some of the) cities that appear in it, write a function that creates and returns a new dictionary that associates the name of a city with the list of states that it appears in. Within the function, output the cities that are unique — they appear in only one state. Do this in alphabetical order. As an example, if the first dictionary looks like:
>
> ```python
> states = {
>     'New Hampshire': ['Concord', 'Hanover'],
>     'Massachusetts': ['Boston', 'Concord', 'Springfield'],
>     'Illinois': ['Chicago', 'Springfield', 'Peoria']
> }
> ```
>
> then after the function the new dictionary call cities should look like:
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
> and the four unique cities output should be:
>
> ```text
> Boston
> Chicago
> Hanover
> Peoria
> ```
>
> Here is the function prototype:
>
> ```python
> def create_cities(states):
> ```

### Rectangle Class Methods

> Consider the following definition of a Rectangle class:
>
> ```python
> class Rectangle(object):
>     def __init__( self, u0, v0, u1, v1 ):
>         self.x0 = u0 # x0 and y0 form the lower left corner of the rectangle
>         self.y0 = v0
>         self.x1 = u1 # x1 and y1 form the upper right corner of the rectangle 
>         self.y1 = v1
>         self.points = [] # See part (b)
> ```
>
> (a) Write a Rectangle class method called contains that determines if a location represented by an x and a y value is inside the rectangle. Note, that for this example, on the boundary counts as in the rectangle. For example:
>
> ```python
> r = Rectangle( 1, 3, 7, 10 )
> r.contains( 1, 4)
> True
> r.contains( 2,11) 
> False
> ```
>
> (b) Suppose there is a second class:
>
> ```python
> class Point(object):
>     def __init__( self, x0, y0, id0 ):
>         self.x = x0
>         self.y = y0
>         self.id = id0
> ```
>
> and each Rectangle stores a list of Point objects whose coordinates are inside the rectangle. Write a Rectangle class method called add_points that adds a list of Point objects to the existing (initially empty) list of Point objects stored with the Rectangle object. If a point is outside the rectangle's boundary or if a point with the same id is already in the rectangle's point list, the point should be ignored. Otherwise, it should be added to the rectangle's point list. Your method must make use of the contains method from part (a).

### Code Output

> Show the output of the following code:
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

### Business Reviews

> Suppose you are given a file named `businesses.txt` in which each line contains the name of a business and its category (a single value), followed by a sequence of review scores, each separated by '|'. Write a piece of code that reads this file, and prints the names of all businesses, their categories, and the average review score for each business. Also print the total number of unique categories in this file. For example, for the file below:
> 
> ```text
> Dinosaur Bar-B-Que|BBQ|5|4|4|4|5|5|4|2
> DeFazio's Pizzeria|Pizza|5|5|5|5|5|5|5|5|5|5|3|5|5|5
> I Love NY Pizza|Pizza|4|5|5|3
> ```
> 
> Your program should print:
> 
> ```text
> Dinosaur Bar-B-Que (BBQ): Score 4.125 
> DeFazio's Pizzeria (Pizza): Score 4.857
> I Love NY Pizza (Pizza): Score 4.250
> 2 categories found.
> ```

### Histogram Function

> Write a function that takes as input a list of numbers and generates a histogram. The histogram prints a star (*) for each occurrence of a number in the list. For example, if the list was:
> 
> ```python
> numbers = [5, 4, 1, 1, 3, 1, 2, 2, 4, 1]
> ```
> 
> Your function should print (sorted by the values):
> 
> ```text
> 1: ****
> 2: **  
> 3: *
> 4: **
> 5: *
> ```
> 
> (a) Write the function using a dictionary. You may not use a set.
> 
> (b) Write the same function using a set. You may not use a dictionary (hint: use `count` for the unique items in the list).

### Alumni Information

> You are given a list of RPI Alumni as shown below. Each item in the list is a dictionary containing information about an alumnus and all items have the same keys. Write a piece of code that prints the name and addresses of each person who graduated before 2013. For example, given the list:
> 
> ```python
> alums = [{'fname':'Abed', 'lname':'Nadir', 'graduated':2012, 'addresses':['Troy&Abed apt.','Abed&Annie apt.']}, {'fname':'Troy', 'lname':'Barnes', 'graduated':2013, 'addresses':['Troy&Abed apt.']}, {'fname':'Britta', 'lname':'Perry', 'graduated':2012, 'addresses':['1 Revolution lane']}]
> ```
> 
> Your code should print (all information is printed in the order it appears in the list):
> 
> ```text
> Abed Nadir
> Troy&Abed apt.
> Abed&Annie apt.
> Britta Perry 
> 1 Revolution lane
> ```

### File Line Extraction

> Write a function called `get_line(fname,lno,start,end)` that takes as input a file name `fname`, a line number `lno`, and starting and end points (`start`,`end`) on the given line. The function should return the string containing all the characters from the starting point up to but not including the end point on that line (same as it would be with string slicing!).
> 
> Line numbers start at 1; characters in a line are counted starting with zero and include the new line character at the end. If there are fewer than `lno` lines, your function should return None. If the line at `lno` has fewer than `end` characters, return an empty string.
> 
> Given the following contents of file `hpss.txt`:
> 
> ```text
> Nearly ten years had passed since the Dursleys had
> woken up to find their nephew on the front step.
> Privet Drive had hardly changed at  
> all.
> ```
> 
> The following program:
> 
> ```python
> print('1:', get_line('hpss.txt', 2, 9, 15))
> print('2:', get_line('hpss.txt', 5, 5, 9))
> print('3:', get_line('hpss.txt', 5, 0, 4))
> print('4:', get_line('hpss.txt', 8, 0, 10))
> ```
>  
> Should print (notice for 3, the newline is also included in the returned string):
> 
> ```text
> 1: to fin
> 2: 
> 3: all.
> 4: None
> ```

### Coldest Years

> Suppose you are given the mean temperature for Troy in the month of December in a dictionary `temp` as shown below. The keys of the dictionary are years and the values are the mean temperature for that year. Write a piece of code that finds and prints the top three coldest years according to this dictionary. Note: If there are ties in values, any ordering of years is acceptable.
> 
> For example, given the dictionary below:
> 
> ```python 
> temp = { 2001: 36.4, 2002: 27.4, 2003: 29.3, 2004: 28.6, 2005: 27.8,
> 2006: 37.3, 2007: 28.1, 2008: 30.2, 2010: 26.0, 2011: 35.4,
> 2012: 33.8, 2013: 27.9, 2014: 32.8}
> ```
> 
> Your program should output:
> 
> ```text
> 2010: 26.0
> 2002: 27.4
> 2005: 27.8
> ```

### Thanksgiving Dinner Menus

> Suppose you are given three variables `t1`,`t2`,`t3` in your program. Each variable is a set containing the menu for a different Thanksgiving dinner you are invited to.
> First, print items that are in the menu for all three dinners. Then, print the items that are in the menu for exactly one dinner. All items should be listed in alphabetical order.
> 
> For example, if you are given menus:
> 
> ```python
> t1 = set(['Turkey', 'Potatoes', 'Green Beans', 'Cranberry', 'Gravy'])
> t2 = set(['Turkey', 'Yams', 'Stuffing', 'Cranberry', 'Marshmallows'])
> t3 = set(['Turkey', 'Gravy', 'Yams', 'Green Beans', 'Cranberry', 'Turducken'])
> ```
> 
> Your program must print the following (your output should match ours):
> 
> ```text
> Items in all three dinners: Cranberry, Turkey
> Items in exactly one dinner: Marshmallows, Potatoes, Stuffing, Turducken
> ```

### Algorithm Running Times

> What are the running times of the following algorithms:
> 
> (a) membership test in a list (`list.index(value)`)
> 
> (b) membership test in a set (`value in set`)
> 
> (c) nested for loops over an entire list