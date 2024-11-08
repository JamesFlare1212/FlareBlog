---
title: CSCI 1100 - Homework 7 - Dictionaries
subtitle:
date: 2024-09-12T15:36:47-04:00
slug: csci-1100-hw-7
draft: false
author:
  name: James
  link: https://www.jamesflare.com
  email:
  avatar: /site-logo.avif
description: "This blog post outlines a homework assignment worth 100 points, due on March 28, 2024, focusing on Python dictionary manipulation. The assignment includes two parts: an autocorrect program and a movie rating analysis, both requiring careful handling of data files and dictionary operations."
keywords: ["Python", "Dictionaries"]
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
summary: "This blog post outlines a homework assignment worth 100 points, due on March 28, 2024, focusing on Python dictionary manipulation. The assignment includes two parts: an autocorrect program and a movie rating analysis, both requiring careful handling of data files and dictionary operations."
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

This homework is worth 100 points and it will be due Thursday, March 28, 2024 at 11:59:59 pm.

It has two parts, each worth 50 points. Please download `hw7_files.zip` and unzip it into the directory for your HW7. You will find multiple data files to be used in both parts.

The goal of this assignment is to work with dictionaries. In part 1, you will do some simple file processing. Read the guidelines very carefully there. In part 2, we have done all the file work for you so you should be able to get the data loaded in just a few lines. For both parts, you will spend most of your time manipulating dictionaries given to you in the various files.

Please remember to name your files `hw7_part1.py` and `hw7_part2.py`.

As always, make sure you follow the program structure guidelines. You will be graded on program correctness as well as good program structure.

Remember as well that we will be continuing to test homeworks for similarity. So, follow our guidelines for the acceptable levels of collaboration. You can download the guidelines from the Course Resources section of Submitty if you need a refresher. Note that this includes using someone else’s code from a previous semester. Make sure the code you submit is truly your own.

## Honor Statement

There have been a number of incidents of academic dishonesty on homework assignments and this must change. Cases are easily flagged using automated tools, and verified by the instructors. This results in substantial grade penalties, poor learning, frustration, and a waste of precious time for everyone concerned. In order to mitigate this, the following is a restatement of the course integrity policy in the form of a pledge. By submitting your homework solution files for grading on Submitty, you acknowledge that you understand and have abided by this pledge:

- I have not shown my code to anyone in this class, especially not for the purposes of guiding their own work.
- I have not copied, with or without modification, the code of another student in this class or who took the class in a previous semester.
- I have not used a solution found or purchased on the internet for this assignment.
- The work I am submitting is my own and I have written it myself.
- I understand that if I am found to have broken this pledge that I will receive a 0 on the assignment and an additional 10 point overall grade penalty.

You will be asked to agree to each of these individual statements before you can submit your solutions to this homework.

Please understand that if you are one of the vast majority of the students who follow the rules and only work with other students to understand problem descriptions, Python constructs, and solution approaches you will not have any trouble whatsoever.

## Part 1: Autocorrect

We have all used auto-correct to fix our various typos and mistakes as we write, but have you ever wondered how it works? Here is a small version of autocorrect that looks for a few common typographical errors.

To solve this problem, your program will read the names of three files:

- The first contains a list of valid words and their frequencies,
- The second contains a list of words to autocorrect, and
- The third contains potential letter substitutions (described below).

The input word file has two entries per line; the first entry on the line is a single valid word in the English language and the second entry is a float representing the frequency of the word in the lexicon. The two values are separated by a comma.

Read this English dictionary into a Python dictionary, using words as keys and frequency as values. You will use the frequency for deciding the most likely correction when there are multiple possibilities

The keyboard file has a line for each letter. The first entry on the line is the letter to be replaced and the remaining letters are possible substitutions for that letter. All the letters on the line are separated by spaces. These substitutions are calculated based on adjacency on the keyboard, so if you look down at your keyboard, you will see that the “a” key is surrounded by “q”, “w”, “s”, and “z”. Other substitutions were calculated similarly, so:

```text
b v f g h n
```

means that a possible replacement for `b` is any one of `v f g h n`. Read this keyboard file into a dictionary: the first letter is the key (e.g., b) and the remaining letters are the value, stored as a list.

Your program will then go through every single word in the input file, autocorrect each word and print the correction. To correct a single word, you will consider the following:

- **FOUND**: If the word is in the dictionary, it is correct. There is no need for a change. Print it as found, and go on to the next word.
- Otherwise consider all of the remaining possibilities.

  - **DROP**: If the word is not found, consider all possible ways to drop a single letter from the word. Store any valid words (words that are in your English dictionary) in some container (list/set/dictionary). These will be candidate corrections.
  - **INSERT**: If the word is not found, consider all possible ways to insert a single letter in the word. Store any valid words in some container (list/set/dictionary). These will be candidate corrections.
  - **SWAP**: Consider all possible ways to swap two consecutive letters from the word. Store any valid words in some container (list/set/dictionary). These will be candidate corrections.
  - **REPLACE**: Next consider all possible ways to change a single letter in the word with any other letter from the possible replacements in the keyboard file. Store any valid words in some container (list/set/dictionary). These will be candidate corrections.

For example, for the keyboard file we have given you, possible replacements for `b` are `v f g h n`. Hence, if you are replacing `b` in `abar`, you should consider: `avar`, `afar`, `agar`, `ahar`, `anar`.

After going through all of the above, if there are multiple potential matches, sort them by their potential frequency from the English dictionary and return the top 3 values that are in most frequent usage as the most likely corrections in order. If there are three or fewer potential matches, print all of them in order. In the unlikely event that two words are equally likely based on frequency, you should pick the one that comes last in lexicographical order. See the note below.

If there are no potential matches using any of the above corrections, print `NOT FOUND`. Otherwise, print the word (15 spaces), the number of matches, and at most three matches, all on one line.

An example output of your program for the English dictionary we have given you is contained in `part1_output_01.txt`. Note that, we will use a more extensive dictionary on Submitty, so your results may be different on Submitty than they are on your laptop.

When you are sure your homework works properly, submit it to Submitty. Your program must be named `hw7_part1.py` to work correctly.

### Notes:

1. Do NOT write a for loop to search to see if a string (word or letter) is in a dictionary! This will be very slow and may cause Submitty to terminate your program (and you to lose substantial points). Instead, you must use the `in` operator.
2. It is possible, but unlikely, that a candidate replacement word is generated more than once. We recommend that you gather all possible candidate replacements into a set before looking them up in the dictionary.
3. Ordering the potential matches by frequency can be handled easily. For each potential match, create a tuple with the frequencey first, followed by the word. Add this to a list and then sort the list in reverse order. For example, if the list is `v`, then you just need the line of code `v.sort(reverse=True)`

## Part 2: Well rated and not so well rated movies ...

In this section, we are providing you with two data files `movies.json` and `ratings.json` in JSON data format. The first data file is movie information directly from IMDB, including ratings for some movies but not all. The second file contains ratings from Twitter. Be careful: Not all movies in `movies.json` have a rating in `ratings.json`, and not all movies in `ratings.json` have relevant info in `movies.json`.

The data can be read in its entirety with the following five lines of code:

```python
import json

if __name__ == "__main__":
    movies = json.loads(open("movies.json").read())
    ratings = json.loads(open("ratings.json").read())
```

Both files store data in a dictionary. The first dictionary has movie ids as keys and a second dictionary containing an attribute list for the movie as a value. For example:

```python
print(movies['3520029'])
(movie with id '3520029') produces the output:
{'genre': ['Sci-Fi', 'Action', 'Adventure'], 'movie_year': 2010,
'name': 'TRON: Legacy', 'rating': 6.8, 'numvotes': 254865}
```

This is same as saying:

```python
movies = dict()
movies['3520029'] = {'genre': ['Sci-Fi', 'Action', 'Adventure'],
'movie_year': 2010, 'name': 'TRON: Legacy',
'rating': 6.8, 'numvotes': 254865}
```

If we wanted to get the individual information for each movie, we can use the following commands:

```python
print(movies['3520029']['genre'])
print(movies['3520029']['movie_year'])
print(movies['3520029']['rating'])
print(movies['3520029']['numvotes'])
```

which would provide the output:

```python
['Sci-Fi', 'Action', 'Adventure']
2010
6.8
254865
```

The second dictionary again has movie ids as keys, and a list of ratings as values. For example,

```python
print(ratings['3520029'])
(movie with id '3520029') produces the output:
[6, 7, 7, 7, 8]
```

So, this movie had 5 ratings with the above values.

Now, on to the homework.

### Problem specification

In this homework, assume you are given these two files called `movies.json` and `ratings.json`. Read the data in from these files. Ask the user for a year range: min year and max year, and two weights: `w1` and `w2`. Find all movies in movies made between min and max years (inclusive of both min and max years). For each movie, compute the combined rating for the movie as follows:

```python
(w1 * imdb_rating + w2 * average_twitter_rating) / (w1 + w2)
```

where the `imdb_rating` comes from movies and `average_twitter_rating` is the average rating from ratings.

If a movie is not rated in Twitter, or if the Twitter rating has fewer than 3 entries, skip the movie. Now, repeatedly ask the user for a genre of movie and return the best and worst movies in that genre based on the years given and the rating you calculated. Repeat until the user enters stop.

An example of the program run (how it will look when you run it using Spyder) is provided in file `hw7_part2_output_01.txt` (the second line for each movie has 8 spaces at the start of the line, and the rating is given in `{:.2f}` format).

The movies we are giving you for testing are a subset of the movies we will use during testing on Submitty, so do not be surprised if there are differences when you submit.

When you are sure your homework works properly, submit it to Submitty. Your program must be named `hw7_part2.py` to work correctly.

### General hint on sorting

It is possible that two movies have the same rating. Consider the following code:

```python
>>> example = [(1, "b"), (1, "a"), (2, "b"), (2, "a")]
>>> sorted(example)
[(1, 'a'), (1, 'b'), (2, 'a'), (2, 'b')]
>>> sorted(example, reverse=True)
[(2, 'b'), (2, 'a'), (1, 'b'), (1, 'a')]
```

Note that the sort puts tuples in order based on the index 0 value first, but in the case of ties, the tie is broken by the index 1 tuple. (If there were a tie in both the index 0 and the index 1 tuple, the sort would continue with the index 2 tuple if available and so on.) The same relationship holds when sorting lists of lists.

To determine the worst and best movies, the example code used a sort with the rating in the index 0 spot and with the name of the movie in the index 1 position. Keep this in mind when you are determining the worst and best movies.

## Supporting Files

{{< link href="HW7.zip" content="HW7.zip" title="Download HW7.zip" download="HW7.zip" card=true >}}

## Solution

> [!NOTE]
> I didn't get a full mark in this assignment (Only 96%), so you should not fully trust it. I may redo it to get a full mark solution. After that, I will add it here.

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
