---
title: 将Docker部署的Umami从一台服务器迁移到另一台服务器
subtitle:
date: 2024-03-11T18:03:39-04:00
slug: umami-docker-migration
draft: false
author:
  name: James
  link: https://www.jamesflare.com
  email:
  avatar: /site-logo.avif
description: 本文将介绍如何通过导出和导入 PostgreSQL 数据库，将 Docker 上运行的 Umami 服务器从一台机器迁移到另一台机器，确保在保留所有关键数据的同时实现平稳过渡。
license:
comment: true
weight: 0
tags:
  - PostgreSQL
  - 开源
  - Docker
  - Umami
categories:
  - 教程
collections:
  - Docker Compose
hiddenFromHomePage: false
hiddenFromSearch: false
hiddenFromRss: false
hiddenFromRelated: false
summary: 本文将介绍如何通过导出和导入 PostgreSQL 数据库，将 Docker 上运行的 Umami 服务器从一台机器迁移到另一台机器，确保在保留所有关键数据的同时实现平稳过渡。
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

# 查看前言详细信息：https://fixit.lruihao.cn/documentation/content-management/introduction/#front-matter
---

<!--more-->

## 简介

最近我从 netcup GmbH 购买了一台新的 ARM 服务器，需要把 Umami 服务器从旧服务器迁移到新服务器上。但我是用 Docker 安装的 Umami。

```yaml
version: '3'
services:
  umami:
    image: ghcr.io/umami-software/umami:postgresql-latest
    ports:
      - "3000:3000"
    environment:
      DATABASE_URL: postgresql://umami:umami@db:5432/umami
      DATABASE_TYPE: postgresql
      APP_SECRET: replace-me-with-a-random-string
    depends_on:
      db:
        condition: service_healthy
    restart: always
  db:
    image: postgres:15-alpine
    environment:
      POSTGRES_DB: umami
      POSTGRES_USER: umami
      POSTGRES_PASSWORD: umami
    volumes:
      - umami-db-data:/var/lib/postgresql/data
    restart: always
    healthcheck:
      test: ["CMD-SHELL", "pg_isready -U $${POSTGRES_USER} -d $${POSTGRES_DB}"]
      interval: 5s
      timeout: 5s
      retries: 5
volumes:
  umami-db-data:
```

迁移中最困难和重要的部分就是导出 Umami 的数据。我们有几种方法可以实现：

- 导出 Docker 卷（非常复杂）
- 导出数据库（我的选择）
- 复制整个路径（不推荐）

## 比较方法

首先，我们要知道 Umami 的数据是存储在卷（Volume）中的。因为 `docker-compose.yml` 指定了：

```yaml
services:
  db:
    volumes:
      - umami-db-data:/var/lib/postgresql/data
volumes:
  umami-db-data:
```

如果我把路径挂载到容器里而不是卷，那就可以直接把路径复制到新机器上。比如：

```yaml
services:
  db:
    volumes:
      - /root/umami/data:/var/lib/postgresql/data
```

可惜我用了卷，导致事情变得复杂。如何正确迁移 Docker 卷在网上有很多讨论，比如 [将 Docker 卷移动到另一台主机](https://4sysops.com/archives/move-a-docker-volume-to-another-host/)。但对我来说太复杂了。你可能会问，Docker 卷不是存储在固定路径如 `/var/lib/docker/volumes/*` 吗？为什么不直接把文件夹复制到另一台机器并正常启动呢？这确实可行，我以前也这么干过。但它可能会导致一些潜在问题，尤其是对于不同的 Docker 容器版本。

最后，我决定只导出数据库并导入到新实例中。让我们一步一步来。

## 迁移数据库

首先，让我们进入旧容器的 Shell。

```bash
docker exec -it umami-db-1 /bin/sh
```

将数据库导出为 `.sql` 文件。

```bash
cd /
pg_dump --username=umami umami > umami.sql
```

现在数据库备份在 `umami.sql` 文件中，但它在容器内部。按 `Ctrl + D` 退出容器 Shell，然后把文件复制到宿主机。

```bash
docker cp umami-db-1:/umami.sql /root
```

接着，你需要把这个备份文件传输到新主机上。在新主机上 `docker compose up -d` 后，`umami-db-1` 容器就会被创建。然后你可以通过以下命令把数据库备份文件复制到容器中：

```bash
docker cp /root/umami.sql umami-db-1:/
```

进入新的 `umami-db-1` 容器：

```bash
docker exec -it umami-db-1 /bin/sh
```

要把备份导入 Postgres，我们需要以 `umami` 用户登录 `psql`：

```bash
psql --username=umami -d postgres
```

在 `psql` Shell 中，我们先删除原有数据库，再创建一个空白数据库以准备导入。

```bash
DROP DATABASE umami;
CREATE DATABASE umami;
```

然后退出 `psql` Shell，运行以下命令导入备份文件：

```bash
cd /
psql --username=umami -f umami.sql umami
```

最后，重启 Umami 实例：

```bash
cd /path/to/umami/docker-compose.yaml/
docker compose down
docker compose up -d
```

## 检查

现在可以检查数据库是否迁移成功了。打开新 Umami 的 URL，尝试用原来的账号登录。如果能登录，那数据库很可能迁移成功了（账号信息是存在数据库里的）。

为了进一步确认，你可以进入仪表盘，看看所有数据是否正常显示。

如果不正常，说明数据库没有成功迁移。你可以检查导出的备份文件（里面是否包含正确的数据？），以及导入的方式（看看备份文件是否成功导入到新的 Postgres）。

## 参考

- [如何将 Umami 从一台服务器迁移到另一台服务器](https://www.programonaut.com/how-to-migrate-umami-from-one-server-to-another/)
- [如何在 Linux 中备份和恢复 PostgreSQL 数据库](https://www.tecmint.com/backup-and-restore-postgresql-database/)