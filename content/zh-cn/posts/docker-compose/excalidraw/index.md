---
slug: "excalidraw-full-stack-docker"
title: "Excalidraw 全栈自部署教程"
subtitle: ""
date: 2023-01-13T15:54:36+08:00
lastmod: 2024-03-11T12:39:36-05:00
draft: false
author:
  name: James
  link: https://www.jamesflare.com
  email:
  avatar: /site-logo.avif
description: 本文为你提供了一份使用 Docker Compose 部署完整 Excalidraw 技术栈的详细指南，包括前端界面、数据存储后端以及协作组件，让你能够快速搭建一个功能完备、支持分享和多人协作的 Excalidraw 私有部署。
license: ""
comment: true
weight: 0

tags:
- Excalidraw
- 开源软件
- Docker
categories:
- 教程
- 资源分享

hiddenFromHomePage: false
hiddenFromSearch: false

summary: 通过本文，你将学会使用 Docker Compose 一键部署拥有前端界面、数据存储和多人协作等全部功能的 Excalidraw 技术栈，快速搭建一个可以私有使用、分享协作的 Excalidraw 部署。
resources:
- name: featured-image
  src: featured-image.jpg
- name: featured-image-preview
  src: featured-image-preview.jpg

toc:
  enable: true
math:
  enable: false
lightgallery: true
seo:
  images: []

repost:
  enable: false
  url:

# 查看 Front Matter 的详细配置说明：https://fixit.lruihao.cn/theme-documentation-content/#front-matter
---

## Intro

这可能是中文互联网上唯一一篇讲如何全栈部署 Excalidraw 的，绝大多数只是部署了一个残血的前端。

本人试图在本地私有化部署 Excalidraw，操作是很简单，根据官方的 README，一会就完成了是吧。

### Issue

但是有没有发现，分享链接和在线协作有问题，用不了？甚至 Libraries 还有点问题？

这是因为，几乎全网的搭建教程都只是搭建了 excalidraw-app 这个前端，它的存储需要 excalidraw-json，协作需要 excalidraw-room。

这些代码官方都开源了，不过前端的进度实在是太快了，于是乎这些就都用不了了。

比如官方开放的 excalidraw-json 是 S3 的存储，现在不出意外是 firebase，官方也没出个剥离的版本，那我们怎么办呢？

### Solution

答，**降级**，**构建全栈**。

excalidraw-app 我们用官方的，不过版本差不多是 9 个月前的，讲道理，功能也没少多少，bug 也没什么问题，这一代前端可以很好兼容。

excalidraw-json 是用不得了，国外也有一些方案用 minio 来跑 S3 对接它，但是我测试了，问题有些大，这个后端应该是用不得了，所幸的是，我找到了一个第三方，用自己代码实现的全功能后端，支持 v2 的 api，excalidraw-storage-backend。

excalidraw-room 我们用官方的，最新一版，差不多是 9 个月前的，和前端一致，可以正常使用。

redis，这个是 excalidraw-storage-backend 所需要的，用于临时存储分享画板的数据，所以它不能保证数据可靠性。

那我们开始吧，本方案使用 docker-compose。

- excalidraw-app
- excalidraw-room
- excalidraw-storage-backend
- redis

## Docker Compose

Docker Compose 配置

```yaml
version: "3.8"

services:
  excalidraw:
    image: kiliandeca/excalidraw
    healthcheck:
      disable: true
    ports:
      - "80:80" # 默认端口80，可以修改
    environment:
      BACKEND_V2_GET_URL: http://localhost:8080/api/v2/scenes/
      BACKEND_V2_POST_URL: http://localhost:8080/api/v2/scenes/
      LIBRARY_URL: https://libraries.excalidraw.com
      LIBRARY_BACKEND: https://us-central1-excalidraw-room-persistence.cloudfunctions.net/libraries
      SOCKET_SERVER_URL: http://localhost:5000/
      STORAGE_BACKEND: "http"
      HTTP_STORAGE_BACKEND_URL: "http://localhost:8080/api/v2"

  excalidraw-storage-backend:
    image: kiliandeca/excalidraw-storage-backend
    ports:
      - "8080:8080"
    environment:
      STORAGE_URI: redis://redis:6379

  excalidraw-room:
    image: excalidraw/excalidraw-room
    ports:
      - "5000:80"

  redis:
    image: redis
    ports:
      - "6379:6379"
```

本身不支持 https，如有需要可以通过反向代理实现，不过记得同时修改 environment 中的变量

此配置文件经本地测试通过，可完美运行。

{{< image src="excalidrawLocalDemo.webp" >}}

---

如果你 6379 端口有冲突，那可以选择构建一个 network

```bash
docker network create excalidraw-net
```

然后像这样对其进行一些修改，就完成了

```yaml
version: "3.8"

services:
  excalidraw:
    image: kiliandeca/excalidraw
    healthcheck:
      disable: true
    ports:
      - "80:80"
    environment:
      BACKEND_V2_GET_URL: http://localhost:8080/api/v2/scenes/
      BACKEND_V2_POST_URL: http://localhost:8080/api/v2/scenes/
      LIBRARY_URL: https://libraries.excalidraw.com
      LIBRARY_BACKEND: https://us-central1-excalidraw-room-persistence.cloudfunctions.net/libraries
      SOCKET_SERVER_URL: http://localhost:5000/
      STORAGE_BACKEND: "http"
      HTTP_STORAGE_BACKEND_URL: "http://localhost:8080/api/v2"

  excalidraw-storage-backend:
    image: kiliandeca/excalidraw-storage-backend
    ports:
      - "8080:8080"
    environment:
      STORAGE_URI: redis://redis:6379

  excalidraw-room:
    image: excalidraw/excalidraw-room
    ports:
      - "5000:80"

  redis:
    image: redis
    expose:
      - "6379"

networks:
  default:
    external:
      name: excalidraw-net
```

## Run

找一个，或者新建一个目录，创建 docker-compose 文件。

```bash
nano docker-compose.yml
```

填入 docker-compose 配置，记得按你的实际情况修改。

随后我们要配置一下反向代理，记得配置 WebSocket 支持，我这里就跳过了。

思路是这样的，参考下面配置即可：

{{< image src="stackDrawing.webp" caption="Stack" width="600px" >}}