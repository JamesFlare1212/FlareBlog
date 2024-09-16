---
title: 使用Docker Compose部署LobeChat服务端数据库版本
subtitle:
date: 2024-09-15T04:52:21-04:00
slug: install-lobechat-db
draft: false
author:
  name: James
  link: https://www.jamesflare.com
  email:
  avatar: /site-logo.avif
description: 这篇博客文章提供了关于设置 LobeChat DB 版本的全面指南，包括配置 Logto 进行身份验证、使用 MinIO 进行 S3 存储以及使用 PostgreSQL 作为数据库。它还涵盖了自定义 Logto 的登录体验和启用 LobeChat 的各种模型。
keywords: ["LobeChat", "Logto", "MinIO", "PostgreSQL", "Docker", "S3 存储", "身份验证", "数据库配置"]
license:
comment: true
weight: 0
tags:
  - 开源软件
  - Docker
  - LobeChat
categories:
  - 教程
  - 资源分享
collections:
  - Docker Compose
hiddenFromHomePage: false
hiddenFromSearch: false
hiddenFromRss: false
hiddenFromRelated: false
summary: 这篇博客文章提供了关于设置 LobeChat DB 版本的全面指南，包括配置 Logto 进行身份验证、使用 MinIO 进行 S3 存储以及使用 PostgreSQL 作为数据库。它还涵盖了自定义 Logto 的登录体验和启用 LobeChat 的各种模型。
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

LobeChat默认使用IndexedDB储存用户数据，换句话说就是数据储存在浏览器本地，这样就导致没法在多个设备间同步，而且有丢失的风险。与此同时，LobeChat有服务端数据库版本，它解决了上述问题的同时，还可以使用知识库功能。

不过要配置LobeChat DB版就没那么简单了，总体有这几部分：配置数据库，配置身份验证服务，配置S3存储服务[^1]。

[^1]: 参考官方文档 https://lobehub.com/zh/docs/self-hosting/server-database

## 配置Logto

我推荐单独部署Logto服务，这样也许还能用在别的项目上，可以分开管理。

首先新建一个目录，并进入

```bash
mkdir logto
cd logto
```

这是我的`docker-compose.yaml`文件，可以参考一下，把相应的部分改成你自己的即可。

```yaml
services:

  postgresql:
    image: postgres:16
    container_name: logto-postgres
    volumes:
      - './data:/var/lib/postgresql/data'
    environment:
      - 'POSTGRES_DB=logto'
      - 'POSTGRES_PASSWORD=logto'
    healthcheck:
      test: ['CMD-SHELL', 'pg_isready -U postgres']
      interval: 5s
      timeout: 5s
      retries: 5
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

修改完后写入`docker-compose.yaml`文件。然后运行容器

```bash
docker compose up -d
```

然后记得正确配置反向代理，这个代理必须支持HTTPS，因为Logto的各项API必须跑在安全的环境下，不然就会报错[^2]。而且反向代理光有HTTPS还不行，还得把`X-Forwarded-Proto`标头的值设置成`https`来告诉Logto用户访问用的是HTTPS。我用的Nginx作为反代服务，以下配置可供参考，记得把内容按你的情况进行修改（比如`proxy_pass`）。

[^2]: 有关报错的讨论 https://github.com/logto-io/logto/issues/4279

```nginx
location / {
  proxy_set_header Host $host;
  proxy_set_header X-Real-IP $remote_addr;
  proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
  proxy_set_header X-Forwarded-Proto https;

  proxy_pass http://127.0.0.1:3034;
  proxy_redirect off;
}
```

还有，这是一小部分配置，如果你是完全手搓的Nginx配置文件，不是通过Nginx Proxy Manger这样的图形化工具管理的。那么你还要自行补齐其它部分，可别直接抄了。换句话说，如果你用的Nginx Proxy Manger，那么你可以在把`proxy_pass`修改后直接抄到对应反代的Advanced配置框里。

之后你可以访问ADMIN_ENDPOINT完成注册以及配置（首个注册的账户将自动成为管理员），记得添加一个Application（为LobeChat DB版的安装做准备），类型可以选Next.js (App Router)。有几个关键参数别写错了（把域名改成你自己的LobeChat DB版实例的）

- `Redirect URIs` 写 `https://lobe.example.com/api/auth/callback/logto`
- `Post sign-out redirect URIs` 写 `https://lobe.example.com/`
- `CORS allowed origins` 写 `https://lobe.example.com`

有三个参数是我们待会配置LobeChat DB版要用到的：Issuer endpoint，App ID，App secrets（这个要添加一个）。可以留意一下。

你还可以访问用户ENDPOINT的`/demo-app`路径测试登录，注册等功能是否正常。如果一切OK，那么Logto就没问题了，可以开始下面的工作了。

## 配置MinIO

我也推荐你单独部署MinIO，这样可以用于其它项目。

创建目录并进入

```bash
mkdir minio
cd minio
```

以下是我的`docker-compose.yaml`文件，可供参考

```yaml
services:

minio:
    image: quay.io/minio/minio
    container_name: minio
    restart: unless-stopped
    environment:
      - MINIO_DOMAIN=minio.example.com
      - MINIO_SERVER_URL=https://minio.example.com
      - MINIO_BROWSER_REDIRECT_URL=https://console.minio.example.com
      - MINIO_ROOT_USER=xxxx #change it
      - MINIO_ROOT_PASSWORD=xxxxx #change it
    ports:
      - "9000:9000"
      - "9090:9090"
    volumes:
      - ./data:/data
    healthcheck:
      test: ["CMD", "curl", "-f", "http://localhost:9000/minio/health/live"]
      interval: 30s
      timeout: 20s
      retries: 3
    command: server /data --console-address ":9090"
```

修改完后写入`docker-compose.yaml`文件。然后运行容器

```bash
docker compose up -d
```

之后从你的MINIO_BROWSER_REDIRECT_URL登入你的MinIO实例，创建一个Bucket，名字这里以`lobe`为例，如果你改成别的，相应的配置文件记得修改。

在Access Policy里选择自定义，然后填入类似下面的配置文件（Bucket名以`lobe`为例）

```json
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "AWS": [
                    "*"
                ]
            },
            "Action": [
                "s3:GetBucketLocation"
            ],
            "Resource": [
                "arn:aws:s3:::lobe"
            ]
        },
        {
            "Effect": "Allow",
            "Principal": {
                "AWS": [
                    "*"
                ]
            },
            "Action": [
                "s3:ListBucket"
            ],
            "Resource": [
                "arn:aws:s3:::lobe"
            ],
            "Condition": {
                "StringEquals": {
                    "s3:prefix": [
                        "files/*"
                    ]
                }
            }
        },
        {
            "Effect": "Allow",
            "Principal": {
                "AWS": [
                    "*"
                ]
            },
            "Action": [
                "s3:DeleteObject",
                "s3:GetObject",
                "s3:PutObject"
            ],
            "Resource": [
                "arn:aws:s3:::lobe/files/**"
            ]
        }
    ]
}
```

然后去Access Keys里创建一个令牌，这里的值请保存好，它们会在后面的LobeChat DB版的配置里用到。

## 配置LobeChat DB版

接下来我们开始配置LobeChat DB版，首先创建一个目录并进入

```bash
mkdir lobe-db
cd lobe-db
```

以下是我用的`docker-compose.yaml`配置文件，记得修改成你的值。

```yaml
services:

  postgresql:
    image: pgvector/pgvector:pg16
    container_name: lobe-postgres
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

  lobe:
    image: lobehub/lobe-chat-database
    container_name: lobe-database
    ports:
      - 127.0.0.1:3033:3210
    depends_on:
      postgresql:
        condition: service_healthy

    environment:
      - 'APP_URL=https://lobe-db.example.com'
      - 'NEXT_AUTH_SSO_PROVIDERS=logto'
      - 'KEY_VAULTS_SECRET=NIdSgLKmeFhWmTuQKQYzn99oYk64aY0JTSssZuiWR8A=' #generate using `openssl rand -base64 32`
      - 'NEXT_AUTH_SECRET=+IHNVxT2qZpA8J+vnvuwA5Daqz4UFFJOahK6z/GsNIo=' #generate using `openssl rand -base64 32`
      - 'NEXTAUTH_URL=https://lobe.example.com/api/auth'
      - 'LOGTO_ISSUER=https://logto.example.com/oidc' #Issuer endpoint
      - 'LOGTO_CLIENT_ID=xxxx' #App ID
      - 'LOGTO_CLIENT_SECRET=xxxx' #App secrets
      - 'DATABASE_URL=postgresql://postgres:lobe-db@postgresql:5432/lobe-db'
      - 'POSTGRES_PASSWORD=lobe-db'
      - 'LOBE_DB_NAME=lobe-db'
      - 'S3_ENDPOINT=https://minio.example.com'
      - 'S3_BUCKET=lobe'
      - 'S3_PUBLIC_DOMAIN=https://minio.example.com'
      - 'S3_ACCESS_KEY_ID=xxxxx'
      - 'S3_SECRET_ACCESS_KEY=xxxxxx'
      - 'S3_ENABLE_PATH_STYLE=1'
      - 'OPENAI_API_KEY=sk-xxxxxx' #your OpenAI API Key
      - 'OPENAI_PROXY_URL=https://api.openai.com/v1'
      - 'OPENAI_MODEL_LIST=-all,+gpt-4o,+gpt-4o-mini,+claude-3-5-sonnet-20240620,+deepseek-chat,+o1-preview,+o1-mini' #change on your own needs, see https://lobehub.com/zh/docs/self-hosting/environment-variables/model-provider#openai-model-list
    restart: always
```

为了安全性，`KEY_VAULTS_SECRET`和`NEXT_AUTH_SECRET`需要是一个随机的32位字符串，可以运行命令`openssl rand -base64 32`生成。

然后把环境变量中的域名改成你自己的，除此之外还有几个Logto的值，它们的关系如下：

- `Issuer endpoint`对应`LOGTO_ISSUER`
- `App ID`对应`LOGTO_CLIENT_ID`
- `App secrets`对应`LOGTO_CLIENT_SECRET`

都可以在创建的Application页面中找到。

有关S3的配置，也记得修改，比如`S3_ENDPOINT`，`S3_BUCKET`，`S3_PUBLIC_DOMAIN`，`S3_ACCESS_KEY_ID`，`S3_SECRET_ACCESS_KEY`。至于`S3_ENABLE_PATH_STYLE`，一般情况下都是`1`，如果你的S3供应商用的是virtual-host，那就改成`0`。

{{< admonition type=question title=path-style和virtual-host有什么区别？ open=true >}}
path-style和virtual-host在S3中是访问bucket和object的不同方式，URL的结构和域名解析不太一样

假设S3服务商的域名是s3.example.net，bucket为mybucket，object为config.env，具体区别如下：

- path-style: s3.example.net/mybucket/config.env
- virtual-host: mybucket.s3.example.net/config.env
{{< /admonition >}}

最后配置你的API相关内容（可选），我的配置里按使用OpenAI的情况举例。如果你不在服务端配置，那么用户需要在前端自己填写。

修改完后写入`docker-compose.yaml`文件。然后运行容器

```bash
docker compose up -d
```

理论上你就可以访问LobeChat DB版使用了。如果需要投入生产环境，请仔细检查，确保没什么安全问题。有疑问的话欢迎评论。

## 扩展内容

### 自定义Logto登录/注册选择

在Logto的管理页面可以看到有一个Sign-in experience，在里面有各个自定义选项，比如开启注册，关闭注册，使用社交媒体的SSO。默认的Sign-up identifier是Username，我推荐在Connectors里配置好SMTP后改成Email address，不然的话用户没办法通过邮件找回密码，忘了密码就完了。

### 开启Logto登录/注册页面的深色模式

在Logto的管理页面可以看到有一个Sign-in experience，勾选里面的Enable dark mode就开启了深色模式。

### 开启Logto的GitHub登录/注册选项

在Logto的管理页面可以看到有一个Connectors，在Social connectors里添加GitHub即可，其它的也同理。

### 配置更多模型

LobeChat支持很多很多模型，你可以设置不同的环境变量以启动，可以看看官方文档 [LobeChat 模型服务商相关环境变量配置指南](https://lobehub.com/zh/docs/self-hosting/environment-variables/model-provider) 中对`OPENAI_MODEL_LIST`的配置选项以及说明。当然也有其它模型供应商的选项，比如DeepSeek等。

当然，你可以可以在前端通过API获取Model List，然后选择需要的模型。

## 参考内容

- [使用服务端数据库部署 - 配置数据库、身份验证服务和 S3 存储服务](https://lobehub.com/zh/docs/self-hosting/server-database)
- [bug: use docker deploy logto v1.6 will always redirect to /unknown-session #4279](https://github.com/logto-io/logto/issues/4279)
- [Deployment | Logto docs #reverse-proxy](https://docs.logto.io/docs/recipes/deployment/#reverse-proxy)
- [通过 Docker Compose 部署 LobeChat](https://lobehub.com/zh/docs/self-hosting/server-database/docker-compose)
- [LobeChat 模型服务商相关环境变量配置指南 #openai-model-list](https://lobehub.com/zh/docs/self-hosting/environment-variables/model-provider#openai-model-list)