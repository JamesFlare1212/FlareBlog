---
title: Choice a Ideal Quantization Type for llama.cpp
subtitle:
date: 2024-03-09T20:59:27-05:00
slug: quantization-llama-cpp
draft: true
author:
  name: James
  link: https://www.jamesflare.com
  email:
  avatar: /site-logo.avif
description:
keywords:
license:
comment: true
weight: 0
tags:
  - LLM
  - Ollama
  - llama.cpp
categories:
  - AI
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
  enable: true
  url:

# See details front matter: https://fixit.lruihao.cn/documentation/content-management/introduction/#front-matter
---

<!--more-->

| Q Type | Size | ppl Change | Note |
|:---:|:---:|:---:|:---:|
| Q2\_K\_S | 2.16G | +9.0634 | @ LLaMA-v1-7B |
| Q2\_K | 2.63G | +0.6717 | @ LLaMA-v1-7B |
| Q3\_K\_S | 2.75G | +0.5551 | @ LLaMA-v1-7B |
| Q3\_K | - | - | alias for Q3\_K\_M |
| Q3\_K\_M | 3.07G | +0.2496 | @ LLaMA-v1-7B |
| Q3\_K\_L | 3.35G | +0.1764 | @ LLaMA-v1-7B |
| Q4\_0 | 3.56G | +0.2166 | @ LLaMA-v1-7B |
| Q4\_K\_S | 3.59G | +0.0992 | @ LLaMA-v1-7B |
| Q4\_K | - | - | alias for Q4\_K\_M |
| Q4\_K\_M | 3.80G | +0.0532 | @ LLaMA-v1-7B |
| Q4\_1 | 3.90G | +0.1585 | @ LLaMA-v1-7B |
| Q5\_0 | 4.33G | +0.0683 | @ LLaMA-v1-7B |
| Q5\_K\_S | 4.33G | +0.0400 | @ LLaMA-v1-7B |
| Q5\_1 | 4.70G | +0.0349 | @ LLaMA-v1-7B |
| Q5\_K | - | - | alias for Q5\_K\_M |
| Q5\_K\_M | 4.45G | +0.0122 | @ LLaMA-v1-7B |
| Q6\_K | 5.15G | +0.0008 | @ LLaMA-v1-7B |
| Q8\_0 | 6.70G | +0.0004 | @ LLaMA-v1-7B |