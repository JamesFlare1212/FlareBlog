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

## Introduction

By default, LobeChat uses IndexedDB to store user data, meaning the data is stored locally in the browser. Consequently, it becomes impossible to synchronize across multiple devices and poses a risk of data loss. Meanwhile, there is a server database version of LobeChat that addresses these issues and also allows for knowledge base functionality.

However, configuring the LobeChat DB version isn't straightforward. It involves several parts: setting up the database, configuring authentication services, and configuring S3 storage[^1].

[^1]: See official documentation https://lobehub.com/en/docs/self-hosting/server-database

## Configuring Logto

I recommend deploying the Logto service separately to potentially use it in other projects and manage them independently.

First, create a directory and enter it:

```bash
mkdir logto  
cd logto  
```

Here is my `docker-compose.yaml` file for reference. Modify the relevant parts according to your own setup.

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

After modifying, write the `docker-compose.yaml` file. Then start the container:

```bash
docker compose up -d  
```

> [!WARNING]
> Don't forget to set `X-Forwarded-Proto` header in Nginx!

this proxy must support HTTPS because all of Logto's APIs must be run in a secure environment, otherwise errors will occur[^2]. Additionally, just having HTTPS isn't enough; you also need to set the `X-Forwarded-Proto` header value to `https` to inform Logto that users are accessing it via HTTPS. I use Nginx as my reverse proxy service and provide a reference configuration below (modify according to your situation).

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

If you are manually configuring your Nginx configuration file rather than using a graphical tool like Nginx Proxy Manager, you need to complete other parts on your own (do not directly copy). In other words, if you use Nginx Proxy Manager, you can modify the `proxy_pass` and then directly input it into the Advanced settings of the corresponding reverse proxy.

Afterwards, you can access the ADMIN_ENDPOINT to complete registration and configuration (the first registered account will automatically become an admin), remember to add an Application (prepare for LobeChat DB version installation), with a type selected as Next.js (App Router). Several key parameters should not be written incorrectly (replace domain names with your own LobeChat DB instance):

- `Redirect URIs` write `https://lobe.example.com/api/auth/callback/logto`
- `Post sign-out redirect URIs` write `https://lobe.example.com/`
- `CORS allowed origins` write `https://lobe.example.com`

There are three parameters that we will use when configuring the LobeChat DB version: Issuer endpoint, App ID, and App secrets (add one). Note them down.

You can also visit the `/demo-app` path of your user ENDPOINT to test login and registration functions. If everything is fine, then Logto should be properly configured, allowing you to proceed with further steps.

## Configuring MinIO

I recommend deploying MinIO separately for potential use in other projects as well.

Create a directory and enter it:

```bash
mkdir minio  
cd minio  
```

Here is my `docker-compose.yaml` file for reference:

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

After modifying, write the `docker-compose.yaml` file. Then start the container:

```bash
docker compose up -d  
```

Subsequently, log into your MinIO instance from your MINIO_BROWSER_REDIRECT_URL, create a Bucket (e.g., name it as `lobe`; if you change this, remember to modify corresponding configuration files), and configure an Access Policy similar to the following JSON file:

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

Then go to Access Keys and create a token, save these values as they will be used in the LobeChat DB version configuration.

## Configuring LobeChat DB Version

Now we start configuring the LobeChat DB version. First, create a directory and enter it:

```bash
mkdir lobe-db  
cd lobe-db  
```

Here is my `docker-compose.yaml` file for reference; remember to modify according to your setup:

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

For security reasons, `KEY_VAULTS_SECRET` and `NEXT_AUTH_SECRET` should be a random 32-character string. You can generate it using the command `openssl rand -base64 32`.

Then modify domain names in environment variables to your own setup. Additionally, several Logto values need to be set:

- `Issuer endpoint` corresponds to `LOGTO_ISSUER`
- `App ID` corresponds to `LOGTO_CLIENT_ID`
- `App secrets` corresponds to `LOGTO_CLIENT_SECRET`

These can all be found on the Application page you created.

For S3 configuration, also modify accordingly (e.g., `S3_ENDPOINT`, `S3_BUCKET`, `S3_PUBLIC_DOMAIN`, `S3_ACCESS_KEY_ID`, `S3_SECRET_ACCESS_KEY`). As for `S3_ENABLE_PATH_STYLE`, it is usually set to `1`. If your S3 provider uses virtual-host style, change this value to `0`.

{{< admonition type=question title="What are the differences between path-style and virtual-host?" open=true >}}
Path-style and virtual-host are different ways of accessing buckets and objects in S3. The URL structure and domain name resolution differ:

Assuming your S3 provider's domain is s3.example.net, bucket is mybucket, object is config.env, the specific differences are as follows:
- Path-style: `s3.example.net/mybucket/config.env`
- Virtual-host: `mybucket.s3.example.net/config.env`
{{< /admonition >}}

Finally, configure your API-related content (optional). My configuration example uses OpenAI. If you do not set it up on the server side, users will need to enter their own keys in the frontend.

After modifying, write the `docker-compose.yaml` file and start the container:

```bash
docker compose up -d  
```

In theory, you can now access LobeChat DB version. Before deploying to production, carefully check for any security issues. If you have questions, feel free to comment.

## Additional Content

### Customizing Logto Login/Registration Options

On the Logto management page, there is a Sign-in experience section with various customization options such as enabling or disabling registration and using social media SSO. By default, the Sign-up identifier is Username; I recommend configuring SMTP in Connectors to change it to Email address so users can recover their passwords via email.

### Enabling Dark Mode for Logto Login/Registration Pages

On the Logto management page, under Sign-in experience, check Enable dark mode to turn on dark mode.

### Adding GitHub Login/Registration Options in Logto

In the Logto management page, go to Connectors and add GitHub under Social connectors. Other options are similar.

### Configuring Additional Models

LobeChat supports many models; you can set different environment variables to enable them. See the official documentation for `OPENAI_MODEL_LIST` configuration options and explanations [here](https://lobehub.com/en/docs/self-hosting/environment-variables/model-provider). There are also other model provider options like DeepSeek.

You can retrieve Model List via API on the frontend to select needed models.

## References

- [Deploying Server-Side Database for LobeChat](https://lobehub.com/en/docs/self-hosting/server-database)
- [bug: use docker deploy logto v1.6 will always redirect to /unknown-session #4279](https://github.com/logto-io/logto/issues/4279)
- [Deployment | Logto docs #reverse-proxy](https://docs.logto.io/docs/recipes/deployment/#reverse-proxy)
- [Deploying LobeChat Server Database with Docker Compose](https://lobehub.com/en/docs/self-hosting/server-database/docker-compose)
- [LobeChat Model Service Providers - Environment Variables and Configuration #openai-model-list](https://lobehub.com/en/docs/self-hosting/environment-variables/model-provider#openai-model-list)