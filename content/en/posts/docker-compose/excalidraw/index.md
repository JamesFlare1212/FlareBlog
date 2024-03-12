---
slug: "excalidraw-full-stack-docker"
title: "Excalidraw Full-Stack Self-Deployment"
subtitle: ""
date: 2023-01-13T15:54:36+08:00
lastmod: 2024-03-11T12:39:36-05:00
draft: false
author:
  name: James
  link: https://www.jamesflare.com
  email:
  avatar: /site-logo.avif
description: This article provides a comprehensive guide on deploying the full Excalidraw stack using Docker Compose, including the frontend, storage backend, and collaboration components, to enable a fully functional private deployment with sharing and collaboration features.
keywords: ["Excalidraw","Docker","Docker Compose","Private Deployment"]
license: ""
comment: true
weight: 0

tags:
- Excalidraw
- Open Source
- Docker
categories:
- Tutorials
- Sharing

hiddenFromHomePage: false
hiddenFromSearch: false

summary: This article provides a comprehensive guide on deploying the full Excalidraw stack using Docker Compose, including the frontend, storage backend, and collaboration components, to enable a fully functional private deployment with sharing and collaboration features.
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
  enable: true
  url: ""

# See details front matter: https://fixit.lruihao.cn/theme-documentation-content/#front-matter
---

## Intro

This might be the only article on the Chinese internet that discusses how to fully deploy the Excalidraw stack. Most only deploy a crippled frontend.

I tried to privately deploy Excalidraw locally, and the operation is very simple. According to the official README, it can be completed quickly.

### Issue

But have you noticed that sharing links and online collaboration have issues and don't work? Even Libraries have some problems?

This is because almost all the deployment tutorials on the internet only deploy the excalidraw-app frontend, and its storage requires excalidraw-json, while collaboration requires excalidraw-room.

The official code for these is all open source, but the progress of the frontend is too fast, so they are all unusable now.

For example, the officially released excalidraw-json uses S3 storage, and now it's firebase without exception. The official version hasn't released a stripped-down version, so what should we do?

### Solution

The answer is to **downgrade** and **build a full stack**.

We use the official excalidraw-app, but the version is about 9 months old. Frankly speaking, there aren't many missing features, and there are no major bug issues. This generation of frontend is quite compatible.

excalidraw-json is unusable. There are also some solutions abroad that use minio to run S3 to interface with it, but I tested it and found some big problems. This backend should be unusable. Fortunately, I found a third-party solution that implements a fully functional backend with its own code, supports v2 API, called excalidraw-storage-backend.

We use the official excalidraw-room, the latest version, which is about 9 months old, consistent with the frontend, and can be used normally.

redis is required by excalidraw-storage-backend and is used to temporarily store shared canvas data, so it cannot guarantee data reliability.

So let's get started. This solution uses docker-compose.

- excalidraw-app
- excalidraw-room
- excalidraw-storage-backend
- redis

## Docker Compose

Docker Compose configuration

```yaml
version: "3.8"

services:
  excalidraw:
    image: kiliandeca/excalidraw
    healthcheck:
      disable: true
    ports:
      - "80:80" # Default port 80, can be modified
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

It does not support https by default. If needed, it can be achieved through a reverse proxy, but remember to modify the variables in the environment at the same time.

This configuration file has been tested locally and can run perfectly.

{{< image src="excalidrawLocalDemo.webp" >}}

---

If you have a conflict with port 6379, you can choose to build a network.

```bash
docker network create excalidraw-net
```

Then make some modifications like this, and it's done.

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

Find or create a new directory and create a docker-compose file.

```bash
nano docker-compose.yml
```

Fill in the docker-compose configuration, and remember to modify it according to your actual situation.

After that, we need to configure the reverse proxy. Remember to configure WebSocket support. I'll skip it here.

The idea is like this. You can refer to the configuration below:

{{< image src="stackDrawing.webp" caption="Stack" width="600px" >}}