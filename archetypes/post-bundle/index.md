---
title: {{ replace .TranslationBaseName "-" " " | title }}
subtitle:
date: {{ .Date }}
slug: {{ substr .File.UniqueID 0 7 }}
draft: true
author:
  name:
  link:
  email:
  avatar:
description:
keywords:
license:
comment: true
weight: 0
tags:
  - draft
categories:
  - draft
collections:
  - draft
hidden_from_home_page: false
hidden_from_search: false
hidden_from_feed: false
hidden_from_related: false
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