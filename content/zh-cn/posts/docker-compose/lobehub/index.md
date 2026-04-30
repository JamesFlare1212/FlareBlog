---
title: 使用Docker Compose部署LobeHub
subtitle:
date: 2026-04-13T16:01:35-04:00
lastmod: 2026-04-13T16:01:35-04:00
slug: install-lobehub
draft: false
author:
  name: James
  link: https://www.jamesflare.com
  email:
  avatar: /site-logo.avif
description: 这篇博客文章展示了更新后LobeHub的Docker Compose配置文件以及其参数
keywords:
license:
comment: true
weight: 0
tags:
  - 开源软件
  - Docker
  - LobeChat
categories:
  - 教程
collections:
  - Docker Compose
hiddenFromHomePage: false
hiddenFromSearch: false
hiddenFromRss: false
hiddenFromRelated: false
summary: 这篇博客文章展示了更新后LobeHub的Docker Compose配置文件以及其参数
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

## 前言

在[使用Docker Compose部署LobeHub](../install-lobechat-db)我讲了LobeChat DB是怎么部署的，不过现在有些过时了，重构后叫LobeHub 2.0，也必须要数据库配置。

我省略一些相同的步骤，只展示配置文件。此外，迁移的过程我没细细讨论，细节可以看[这里](https://lobehub.com/zh/docs/self-hosting/migration/v2/breaking-changes)。

## 配置LobeHub 2.0

接下来我们开始配置LobeChat DB版，首先创建一个目录并进入

```bash
mkdir lobe-db
cd lobe-db
```

以下是我用的`docker-compose.yaml`配置文件，记得修改成你的值。

```yaml
name: lobehub
services:
  lobe:
    image: lobehub/lobehub
    container_name: lobehub
    ports:
      - 127.0.0.1:3033:3210
    depends_on:
      postgresql:
        condition: service_healthy
      redis:
        condition: service_healthy
    environment:
      - 'APP_URL=https://lobehub.example.com'
      - 'KEY_VAULTS_SECRET=KHPHvj6ubTttfqkAzFHGeeWKxiyMZZzQ+Rc2CqaI3Tg='
      - 'AUTH_SECRET=xN/y2TzZ5BALIS/VvtYQf9TRuFW6QCqkkaYVIS7GpfY='
      - 'JWKS_KEY={"keys":[{"d":"R5pN-sx0ntSbBH2Ep-kMwStf74-cUw-caVF32Xn8AISl0etPqAqNE5_8Glfo1Gx-DGN7ZsQvmPTOYLyDuYZNCNkq-1CVdvjB6Kc7Ux9eaRq_IkmPKAAAGB-oxtH-qFJLLY1uhZYTfdG602AFQmxhEOLTIaL3VKd_tXfS2aybPkEqH1N5fEl_aBcxJLZjg75IV9iuZEij1cVBfAF6_5_7hJD5atNjBiP3ccsaCuKqapuM4j-DeitjcmwX51wSzPuazZQb5KyoZFPIafN1mLkxSe_yoqbTamfGCz_FHoYEnupYM7C9iWonTRr3hx_NgUN7bzvcE7vASgve1PC5vEEAYQ","dp":"iODTRGRcBpQyznrX5BU3iYc_352oHuMi0cxry-z7gGleLDefQG9UvwnpSzVpbX4kTkC4NoTTHSBlCeO9e6dh9Cn3A2XE1azeUXxdiQbM35oujKPHvibxLqW7xjeTbHbnGluFjrSEJ7tyXuYLQGvBy-aHU650_Hpe0n9EBqVvqzE","dq":"adwbqNzocqc38FbieFa45MdvMVfLRQDdP-QW-144me-_e6g7WmsVy4KkfRUk2wuPhgBxtsYV-vuvb24wx2s6G0nJ8_wVGOJEB99-VR8W636ZE24HOlJR1UlTEMjzl5WbdQO3gzC8Sb14rzJlj9LNwk4JDayP8SYm68I1KUyapI8","e":"AQAB","kty":"RSA","n":"tNjyW0OEMiF7uqDdXXdsWWz4QTB1yRsG_oTYhqruYm2xN3Ual4_Q8QOq3FM4b6fIrkk-BPfk0iW4d8LL7aFF9eEtY0k2anSBS-ZPG7DFt45tIHw-12I5xp4ZjrAj70bfIBcCCtu-XwA0JGnY9IhDOAmCyWc06re01Nyatjy-UkrFhuNVthSVyGROmwPQvn0S879Cj6cYebxDUTqHfmqCQb9TGWpmbqvHL4cUuFYu0z_DJK1CiHVfcNGHsr_UAAQmPqfI9g4wEezbLYdSxnInBcUx49bkYuBSOgqT-2hR3Gdz9qz_iqo5NWhth1v0DUEmg_UvLdxamhg0iT2YV0Fxnw","p":"2-OP4jp8ngi-YQYW1bAAmDOqZnHardD47XIqxf9k3NCGrJPDaGJTeVo9Br5xBUsjF808tpzWkkHtcKF-IE9NdRF2_COxwhzkAKthTFuaiKQlSr0ieaD3H9iBy1w0VbUsNbtGOFaqNULBY5OHdTAhrsbdzUh4Jj_GpprpOIKpohU","q":"0owG2CgZSvYpQCPyOiNEC7fnBURxX4G5CvUDc_qXq3mLEfu4JAlbDQRD5l_mxHP3V4DVPZGTYW4JhJ-kLn2Lj4CglfWs7LRQCdj4Nl0e8uu8HRyWcZyqU7KnSQ2XUrof-4TBQYTTDzPI0DxzF-SSYPD-LAhHZVlKe1Xs_jAfFeM","qi":"XfGEJVYiwh1sr0M7qtG8CPO4Rc7TiiNwuNzCcjOIIejCsMqk-aKWZnClFEzPN3phmKKkwy6cKihttDugrwwVKXocbCj557galhUDeqO-i5CqEWQm1YZTEvG2DuqIhzTdq9eXd-PwdgboO3zhm7opT10Rnfg15eq0wppQPfkRbH8","use":"sig","kid":"8793c39179dcb360","alg":"RS256"}]}'
      - 'AUTH_SSO_PROVIDERS=logto'
      - 'AUTH_LOGTO_ISSUER=https://logto.example.com/oidc' #Issuer endpoint
      - 'AUTH_LOGTO_ID=xxxxxx' #App ID
      - 'AUTH_LOGTO_SECRET=xxxxxx' #App secrets
      - 'DATABASE_URL=postgresql://postgres:lobe-db@postgresql:5432/lobe-db'
      - 'POSTGRES_PASSWORD=lobe-db'
      - 'LOBE_DB_NAME=lobe-db'
      - 'S3_ENDPOINT=https://usc1.contabostorage.com'
      - 'S3_BUCKET=lobe'
      - 'S3_PUBLIC_DOMAIN=https://usc1.contabostorage.com'
      - 'S3_ACCESS_KEY_ID=xxxxxx'
      - 'S3_SECRET_ACCESS_KEY=xxxxxx'
      - 'S3_REGION=auto'
      - 'S3_ENABLE_PATH_STYLE=1'
      - 'S3_SET_ACL=0'
      - 'ENABLED_OLLAMA=0'
      - 'OPENAI_API_KEY=sk-xxxxxx' #your OpenAI API Key
      - 'OPENAI_PROXY_URL=https://api.openai.com/v1'
      - 'OPENAI_MODEL_LIST=-all,+deepseek-chat=DeepSeek V3.2 Exp<128000:fc>,+deepseek-reasoner=DeepSeek V3.2 Exp Thinking<128000:reasoning:fc>,+Qwen3=Qwen3.5 27B<262144:reasoning:fc:vision>,+Qwen3-nothinking=Qwen3.5 27B Nothinking<262144:fc:vision>' #change on your own needs, see https://lobehub.com/zh/docs/self-hosting/environment-variables/model-provider#openai-model-list
      - 'SEARXNG_URL=http://searxng:8080'
      - 'REDIS_URL=redis://redis:6379'
      - 'REDIS_PREFIX=lobechat'
      - 'REDIS_TLS=0'
    restart: always

  postgresql:
    image: paradedb/paradedb:latest-pg17
    container_name: lobe-postgres
    command: ["postgres", "-c", "shared_preload_libraries=pg_search"]
    volumes:
      - './data:/var/lib/postgresql/data'
    environment:
      - 'POSTGRES_DB=lobe-db'
      - 'POSTGRES_PASSWORD=lobe-db'
    healthcheck:
      test: ['CMD-SHELL', 'pg_isready -U postgres']
      interval: 5s
      timeout: 5s
      retries: 5
    restart: always

  redis:
    image: redis:7-alpine
    container_name: lobe-redis
    command: redis-server --save 60 1000 --appendonly yes
    volumes:
      - './redis_data:/data'
    healthcheck:
      test: ['CMD', 'redis-cli', 'ping']
      interval: 5s
      timeout: 3s
      retries: 5
    restart: always

  searxng:
    image: searxng/searxng
    container_name: lobe-searxng
    volumes:
      - './searxng/config:/etc/searxng'
      - './searxng/data/:/var/cache/searxng/'
    restart: always

  logto:
    image: svhd/logto:latest
    container_name: logto
    ports:
      - '127.0.0.1:3034:3034'
      - '127.0.0.1:3035:3035'
    depends_on:
      postgresql:
        condition: service_healthy
    environment:
      - 'PORT=3034'
      - 'ADMIN_PORT=3035'
      - 'TRUST_PROXY_HEADER=1'
      - 'DB_URL=postgresql://postgres:logto@postgresql:5432/logto'
      - 'ENDPOINT=https://logto.example.com'
      - 'ADMIN_ENDPOINT=https://logto-admin.example.com'
    entrypoint: ['sh', '-c', 'npm run cli db seed -- --swe && npm start']
```

为了安全性，`KEY_VAULTS_SECRET`和`AUTH_SECRET`需要是一个随机的32位字符串，可以运行命令`openssl rand -base64 32`生成。

`JWKS_KEY`以及上面的变量也可以使用这个[工具](https://lobehub.com/zh/docs/self-hosting/platform/docker#%E5%88%9B%E5%BB%BA%E5%90%8D%E4%B8%BA-lobehub-env-%E6%96%87%E4%BB%B6%E7%94%A8%E4%BA%8E%E5%AD%98%E6%94%BE%E7%8E%AF%E5%A2%83%E5%8F%98%E9%87%8F)生成

有关S3的配置，也记得修改，比如`S3_ENDPOINT`，`S3_BUCKET`，`S3_PUBLIC_DOMAIN`，`S3_ACCESS_KEY_ID`，`S3_SECRET_ACCESS_KEY`。至于`S3_ENABLE_PATH_STYLE`，一般情况下都是`1`，如果你的S3供应商用的是virtual-host，那就改成`0`。

{{< admonition type=question title=path-style和virtual-host有什么区别？ open=true >}}
path-style和virtual-host在S3中是访问bucket和object的不同方式，URL的结构和域名解析不太一样

假设S3服务商的域名是s3.example.net，bucket为mybucket，object为config.env，具体区别如下：

- path-style: s3.example.net/mybucket/config.env
- virtual-host: mybucket.s3.example.net/config.env
{{< /admonition >}}

我这里用的是Contabo的S3存储，仅供参考。

最后配置你的API相关内容（可选），我的配置里按使用OpenAI的情况举例。如果你不在服务端配置，那么用户需要在前端自己填写。

修改完后写入`docker-compose.yaml`文件。然后运行容器

```bash
docker compose up -d
```
