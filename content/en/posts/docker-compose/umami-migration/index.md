---
title: Migrate Umami Docker From One Server to Another
subtitle:
date: 2024-03-11T18:03:39-04:00
slug: umami-docker-migration
draft: false
author:
  name: James
  link: https://www.jamesflare.com
  email:
  avatar: /site-logo.avif
description: This blog post provides a step-by-step guide on migrating an Umami server running on Docker from one machine to another by exporting and importing the PostgreSQL database, ensuring a smooth transition while preserving all the essential data.
keywords: ["Docker", "PostgreSQL", "Umami", "Migration"]
license:
comment: true
weight: 0
tags:
- PostgreSQL
- Open Source
- Docker
- Umami
categories:
- Tutorials
hiddenFromHomePage: false
hiddenFromSearch: false
hiddenFromRss: false
hiddenFromRelated: false
summary: This blog post provides a step-by-step guide on migrating an Umami server running on Docker from one machine to another by exporting and importing the PostgreSQL database, ensuring a smooth transition while preserving all the essential data.
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

## Introduction

Nearly, I bought a new ARM server from netcup GmbH, and I need to migrate my umami server from the old server to the new one. But I installed umami with Docker.

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

The most difficult and important part is exporting data in umami. To do that, we have several methods:

- Export the Docker volume (Very complex)
- Export the database (My choice)
- Copy the whole path (Not recommend)

## Compare Methods

First, we need to know that umami's data is in the volume. Since `docker-compose.yml` specify that:

```yaml
services:
  db:
    volumes:
      - umami-db-data:/var/lib/postgresql/data
volumes:
  umami-db-data:
```

If I mounted a path into the container instead of a volume, I can simply copy the path to my new machine. For example,

```yaml
services:
  db:
    volumes:
      - /root/umami/data:/var/lib/postgresql/data
```

Sadly I used a volume and made things complex. How to migrated Docker volume (in a right way) is welled discussed over the internet. For example, [Move a Docker volume to another host](https://4sysops.com/archives/move-a-docker-volume-to-another-host/). This is too complex for me. You may ask, the Docker volumes are stored in a fixed path like `/var/lib/docker/volumes/*`. Why not just copy the folder to another machine and start as normal? Well, this is applicable and I have done this before. But it may cause some potential issues, especially for different Docker container version.

Finally, I choice to just export the database and import to the new instance. Let's do it step by step.

## Migrate Database

FIrst, let's attach to the old container.

```bash
docker exec -it umami-db-1 /bin/sh
```

Export the database as a `.sql` file.

```bash
cd /
pg_dump --username=umami umami > umami.sql
```

Now the database is in `umami.sql`, but it's inside the container, so press `Ctrl + D` to disconnect from the container shell. Then, copy the file into host machine.

```bash
docker cp umami-db-1:/umami.sql /root
```

Then, you need transfer this backup file to your new host machine. After you `docker compose up -d` the `umami-db-1` container will be created. Then, you can copy the database backup file into the container by:

```bash
docker cp /root/umami.sql umami-db-1:/
```

Then, we can attach to the `umami-db-1` by:

```bash
docker exec -it umami-db-1 /bin/sh
```

To import the backup into the PostgreSQL, we need login `psql` as `umami`:

```bash
psql --username=umami -d postgres
```

In `psql` shell, we will drop the original database and create a blank one for preparing import.

```bash
DROP DATABASE umami;
CREATE DATABASE umami;
```

Then, quit `psql` shell and run:

```bash
cd /
psql --username=umami -f umami.sql umami
```

to import backup file. Finally, restart the umami instance:

```bash
cd /path/to/umami/docker-compose.yaml/
docker compose down
docker compose up -d
```

## Check

Now, you may have a check to see the database is migrated or not. Open the URL of your new umami location and try to login with your original credentials. If you can login, the database is very likely migrated (credentials is stored in database).

To further confirm, you can go to the dashboard and check if all data is displaying properly.

If not, which mean the database didn't migrated successfully. You may check the exported backup file (does it contain the right data?) and the way you import (see if the backup file is successfully imported to the new PostgreSQL).

## Reference

- [How To Migrate Umami From One Server To Another](https://www.programonaut.com/how-to-migrate-umami-from-one-server-to-another/)
- [How to Backup and Restore a PostgreSQL Database in Linux](https://www.tecmint.com/backup-and-restore-postgresql-database/)