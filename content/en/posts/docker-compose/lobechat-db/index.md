---
title: Use Docker Compose to Deploy the LobeChat Server Database Version
subtitle:
date: 2024-09-15T04:52:21-04:00
slug: install-lobechat-db
draft: false
author:
  name: James
  link: https://www.jamesflare.com
  email:
  avatar: /site-logo.avif
description: This blog post offers a comprehensive guide on setting up LobeChat DB version, including configuring Logto for authentication, MinIO for S3 storage, and PostgreSQL for the database. It also covers customizing Logto's sign-in experience and enabling various models for LobeChat.
keywords: ["LobeChat", "Logto", "MinIO", "PostgreSQL", "Docker", "S3 Storage", "Authentication", "Database Configuration"]
license:
comment: true
weight: 0
tags:
  - Open Source
  - LobeChat
  - Docker
categories:
  - Tutorials
  - Sharing
collections:
  - Docker Compose
hiddenFromHomePage: false
hiddenFromSearch: false
hiddenFromRss: false
hiddenFromRelated: false
summary: This blog post offers a comprehensive guide on setting up LobeChat DB version, including configuring Logto for authentication, MinIO for S3 storage, and PostgreSQL for the database. It also covers customizing Logto's sign-in experience and enabling various models for LobeChat.
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

## Before Start

LobeChat defaults to using IndexedDB to store user data, which means the data is stored locally in the browser. This results in the inability to synchronize data across multiple devices and the risk of data loss. At the same time, LobeChat has a server-side database version that addresses the aforementioned issues and also enables the use of a knowledge base feature.

However, configuring the LobeChat DB version is not straightforward. It involves several parts: configuring the database, setting up the authentication service, and configuring the S3 storage service [^1].

[^1]: Refer to the official documentation https://lobehub.com/en/docs/self-hosting/server-database

## Configuring Logto

I recommend deploying the Logto service separately, as it may also be used in other projects and can be managed independently.

First, create a new directory and navigate into it:

```bash
mkdir logto
cd logto
```

Here is my `docker-compose.yaml` file, which you can refer to and modify the relevant parts to suit your own needs:

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

After making the modifications, write them into the `docker-compose.yaml` file. Then, run the container:

```bash
docker compose up -d
```

Remember to configure the reverse proxy correctly. This proxy must support HTTPS because Logto's various APIs must run in a secure environment, otherwise, errors will occur [^2]. Moreover, simply having HTTPS is not enough; you must also set the value of the `X-Forwarded-Proto` header to `https` to inform Logto that the user is accessing via HTTPS. I use Nginx as the reverse proxy service, and the following configuration can be referenced. Remember to modify the content according to your situation (e.g., `proxy_pass`).

[^2]: Discussion on errors https://github.com/logto-io/logto/issues/4279

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

Additionally, this is just a small part of the configuration. If you are manually crafting the Nginx configuration file rather than managing it through a graphical tool like Nginx Proxy Manager, you will need to complete the other parts yourself. Do not simply copy and paste. In other words, if you are using Nginx Proxy Manager, you can directly copy the modified `proxy_pass` into the corresponding reverse proxy's Advanced configuration box.

Afterward, you can visit the ADMIN_ENDPOINT to complete registration and configuration (the first registered account will automatically become an administrator). Remember to add an Application (in preparation for the installation of the LobeChat DB version), and the type can be selected as Next.js (App Router). There are several key parameters that should not be written incorrectly (replace the domain name with your own LobeChat DB version instance):

- `Redirect URIs` write `https://lobe.example.com/api/auth/callback/logto`
- `Post sign-out redirect URIs` write `https://lobe.example.com/`
- `CORS allowed origins` write `https://lobe.example.com`

There are three parameters that we will use later in the configuration of the LobeChat DB version: Issuer endpoint, App ID, and App secrets (this needs to be added). You can take note of them.

You can also visit the user ENDPOINT's `/demo-app` path to test login, registration, and other functions to see if they are working properly. If everything is OK, then Logto is fine, and you can proceed with the following tasks.

## Configuring MinIO

I also recommend deploying MinIO separately, as it can be used for other projects.

Create a directory and navigate into it:

```bash
mkdir minio
cd minio
```

Here is my `docker-compose.yaml` file, which you can refer to:

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

After making the modifications, write them into the `docker-compose.yaml` file. Then, run the container:

```bash
docker compose up -d
```

Next, log in to your MinIO instance from your MINIO_BROWSER_REDIRECT_URL, create a Bucket, and name it `lobe` as an example. If you change it to something else, remember to modify the corresponding configuration files.

In the Access Policy, choose Custom and fill in a configuration similar to the following (using `lobe` as the Bucket name):

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

Then, go to Access Keys and create a token. Please save the values here, as they will be used in the subsequent configuration of the LobeChat DB version.

## Configuring the LobeChat DB Version

Next, we will start configuring the LobeChat DB version. First, create a directory and navigate into it:

```bash
mkdir lobe-db
cd lobe-db
```

Here is the `docker-compose.yaml` configuration file I use. Remember to modify it to your values:

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

For security reasons, `KEY_VAULTS_SECRET` and `NEXT_AUTH_SECRET` need to be a random 32-character string, which can be generated by running the command `openssl rand -base64 32`.

Then, change the domain names in the environment variables to your own. In addition, there are several Logto values, which are related as follows:

- `Issuer endpoint` corresponds to `LOGTO_ISSUER`
- `App ID` corresponds to `LOGTO_CLIENT_ID`
- `App secrets` corresponds to `LOGTO_CLIENT_SECRET`

These can all be found on the created Application page.

Regarding the S3 configuration, remember to modify it, such as `S3_ENDPOINT`, `S3_BUCKET`, `S3_PUBLIC_DOMAIN`, `S3_ACCESS_KEY_ID`, `S3_SECRET_ACCESS_KEY`. As for `S3_ENABLE_PATH_STYLE`, it is generally `1`. If your S3 provider uses virtual-host, change it to `0`.

{{< admonition type=question title="What is the difference between path-style and virtual-host?" open=true >}}
path-style and virtual-host are different ways to access buckets and objects in S3, with different URL structures and domain name resolutions.

Assuming the S3 provider's domain is s3.example.net, the bucket is mybucket, and the object is config.env, the specific differences are as follows:

- path-style: s3.example.net/mybucket/config.env
- virtual-host: mybucket.s3.example.net/config.env
{{< /admonition >}}

Finally, configure your API-related content (optional), which is exemplified in my configuration for using OpenAI. If you do not configure it on the server side, users will need to fill it in themselves on the frontend.

After making the modifications, write them into the `docker-compose.yaml` file. Then, run the container:

```bash
docker compose up -d
```

In theory, you should now be able to access and use the LobeChat DB version. If you need to deploy it in a production environment, please carefully check to ensure there are no security issues. If you have any questions, feel free to comment.

## Extended Content

### Customizing Logto Login/Registration Options

In the Logto management page, you can see a Sign-in experience, where there are various customization options, such as enabling registration, disabling registration, and using social media SSO. The default Sign-up identifier is Username. I recommend changing it to Email address after configuring SMTP in Connectors, otherwise, users will not be able to retrieve their passwords via email, and forgetting the password will be problematic.

### Enabling Dark Mode for Logto Login/Registration Pages

In the Logto management page, you can see a Sign-in experience, where checking Enable dark mode will enable dark mode.

### Enabling GitHub Login/Registration Options for Logto

In the Logto management page, you can see a Connectors, where you can add GitHub in the Social connectors, and the same applies to others.

### Configuring More Models

LobeChat supports many models, and you can set different environment variables to start them. You can refer to the official documentation [LobeChat Model Service Providers - Environment Variables and Configuration](https://lobehub.com/en/docs/self-hosting/environment-variables/model-provider) for the configuration options and explanations of `OPENAI_MODEL_LIST`. Of course, there are also options for other model providers, such as DeepSeek.

Of course, you can also obtain the Model List through the API on the frontend and then select the required models.

## References

- [Deploying Server-Side Database for LobeChat](https://lobehub.com/en/docs/self-hosting/server-database)
- [bug: use docker deploy logto v1.6 will always redirect to /unknown-session #4279](https://github.com/logto-io/logto/issues/4279)
- [Deployment | Logto docs #reverse-proxy](https://docs.logto.io/docs/recipes/deployment/#reverse-proxy)
- [Deploying LobeChat Server Database with Docker Compose](https://lobehub.com/en/docs/self-hosting/server-database/docker-compose)
- [LobeChat Model Service Providers - Environment Variables and Configuration #openai-model-list](https://lobehub.com/en/docs/self-hosting/environment-variables/model-provider#openai-model-list)