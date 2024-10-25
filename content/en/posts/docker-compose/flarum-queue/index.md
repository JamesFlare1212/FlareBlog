---
title: Fix the Issue of Flarum Emails Not Being Sent Due to Queue.
subtitle:
date: 2024-10-25T12:30:55-04:00
slug: flarum-queue
draft: false
author:
  name: James
  link: https://www.jamesflare.com
  email:
  avatar: /site-logo.avif
description: This blog post addresses an issue with Flarum's email delivery, caused by improper Queue handling. It provides solutions using Docker commands and a Flarum plugin to ensure emails are sent correctly, especially when running Flarum in a Docker container.
keywords:
license:
comment: true
weight: 0
tags:
  - Docker
  - Flarum
  - PHP
  - Open Source
categories:
  - Tutorials
  - Sharing
collections:
  - Docker Compose
hiddenFromHomePage: false
hiddenFromSearch: false
hiddenFromRss: false
hiddenFromRelated: false
summary: This blog post addresses an issue with Flarum's email delivery, caused by improper Queue handling. It provides solutions using Docker commands and a Flarum plugin to ensure emails are sent correctly, especially when running Flarum in a Docker container.
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

Recently, while configuring Flarum, I encountered a peculiar issue where users were not receiving emails despite the Email SMTP configuration being correct. This included, but was not limited to, registration activation, password recovery, notifications, etc.

## Cause of the Issue

After searching through the sending logs, I discovered that this problem did not exist a few months ago. Reviewing my recent operations and community feedback, I narrowed the issue down to the Queue. In [Redis sessions, cache & queues](https://discuss.flarum.org/d/21873-redis-sessions-cache-queues), there is mention of the Queue. I overlooked this when initially using Redis.

## Solution

One approach is to execute `php flarum queue:work`, as suggested. However, this command opens an uninterrupted window, and we can use a process guardian to ensure it runs correctly. My Flarum instance runs in a Docker container, which is inconvenient for me. Nevertheless, we can run it first to see if it resolves the email sending issue.

```bash
docker exec flarum /bin/sh -c "cd /flarum/app && php flarum schedule:run"
```

I observed that emails were sent correctly after execution, confirming that the issue was due to the Queue not running properly.

The second method, which I ultimately adopted, involves a small plugin provided by [Database Queue - the simplest queue, even for shared hosting](https://discuss.flarum.org/d/28151-database-queue-the-simplest-queue-even-for-shared-hosting). This plugin uses Cron tasks to handle the Queue, requiring only that Cron runs normally.

To install the plugin, since I am in a Docker container, I reconstructed the command:

```bash
docker exec flarum /bin/sh -c "cd /flarum/app && composer require blomstra/database-queue:*"
```

`flarum` is the name of my container; you can modify it accordingly.

Then, restart Flarum and check if Cron has been correctly added. You should see something similar to:

```bash
root@debain:~# docker exec flarum /bin/sh -c "cd /flarum/app && php flarum schedule:list"
+-------------------------------------------------------+-----------+---------------------------------------------------------------------------------------------------------------------+----------------------------+
| Command                                               | Interval  | Description                                                                                                         | Next Due                   |
+-------------------------------------------------------+-----------+---------------------------------------------------------------------------------------------------------------------+----------------------------+
| '/usr/bin/php8' 'flarum' drafts:publish               | * * * * * | Publish all scheduled drafts.                                                                                       | 2024-10-25 17:00:00 +00:00 |
| '/usr/bin/php8' 'flarum' fof:best-answer:notify       | 0 * * * * | After a configurable number of days, notifies OP of discussions with no post selected as best answer to select one. | 2024-10-25 17:00:00 +00:00 |
| '/usr/bin/php8' 'flarum' queue:work --stop-when-empty | * * * * * |                                                                                                                     | 2024-10-25 17:00:00 +00:00 |
+-------------------------------------------------------+-----------+---------------------------------------------------------------------------------------------------------------------+----------------------------+
```

`'/usr/bin/php8' 'flarum' queue:work --stop-when-empty` is what we expect, indicating no issues.

Remember to add Cron if you haven't already. You can refer to my example. First, enter crontab:

```bash
crontab -e
```

Add:

```bash
* * * * * /usr/bin/docker exec flarum /bin/sh -c "cd /flarum/app && php flarum schedule:run" >> /dev/null 2>&1
```

## Conclusion

Barring any unforeseen circumstances, you should have resolved the issue of emails not being sent. If emails still fail to send, it may be a configuration issue. Ensure the SMTP information is correct before starting and test it.

## References

- [Redis sessions, cache & queues](https://discuss.flarum.org/d/21873-redis-sessions-cache-queues)
- [Database Queue - the simplest queue, even for shared hosting](https://discuss.flarum.org/d/28151-database-queue-the-simplest-queue-even-for-shared-hosting)