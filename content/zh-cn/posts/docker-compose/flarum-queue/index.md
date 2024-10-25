---
title: 修正因 Queue 导致的 Flarum 的邮件无法发送问题
subtitle:
date: 2024-10-25T12:30:55-04:00
slug: flarum-queue
draft: false
author:
  name: James
  link: https://www.jamesflare.com
  email:
  avatar: /site-logo.avif
description: 本博客文章讨论了Flarum邮件发送的问题，该问题是由于不当的队列处理造成的。它提供了使用Docker命令和一个Flarum插件的解决方案，以确保电子邮件正确发送，尤其是在Docker容器中运行Flarum时。
keywords:
license:
comment: true
weight: 0
tags:
  - Docker
  - Flarum
  - PHP
  - 开源软件
categories:
  - 教程
collections:
  - Docker Compose
hiddenFromHomePage: false
hiddenFromSearch: false
hiddenFromRss: false
hiddenFromRelated: false
summary: 本博客文章讨论了Flarum邮件发送的问题，该问题是由于不当的队列处理造成的。它提供了使用Docker命令和一个Flarum插件的解决方案，以确保电子邮件正确发送，尤其是在Docker容器中运行Flarum时。
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

最近在配置 Flarum 的时候碰见一件怪事，那就是 Email SMTP 配置正确的情况下，用户收不到邮件。包括但不限于，注册激活，忘记密码，通知等等。

## 故障原因

经过对发件日志的搜寻，我发现这个问题在几个月前并不存在，复盘我这几个里的操作和社区的反馈，我把问题锁定在了，Queue 上。在 [Redis sessions, cache & queues](https://discuss.flarum.org/d/21873-redis-sessions-cache-queues) 里有提到 Queue。我当初使用 Redis 的时候没注意这行话。

## 解决方案

一种办法就是如它所说，执行 `php flarum queue:work`。但是这个命令会开启一个不中断的窗口，我们可以开一个进程守护之类的东西去确保它正确执行。不过我的 Flarum 实例运行在 Docker 容器里，这对我来说不太方便。不过我们可以先跑一下，看看是不是这个问题导致的邮件无法发送。

```bash
docker exec flarum /bin/sh -c "cd /flarum/app && php flarum schedule:run"
```

我观察到执行后邮件正确发送了，那么就证实问题是 Queue 没正确执行导致的了。

第二种办法也是我最终采用的，[Database Queue - the simplest queue, even for shared hosting](https://discuss.flarum.org/d/28151-database-queue-the-simplest-queue-even-for-shared-hosting) 提供了一个小插件来解决这个问题，它利用 Cron 任务来处理 Queue。这样的话我们只需要确保 Cron 正常执行就行了。

安装插件，我这里因为在 Docker 容器里，所以我重新构造一下命令

```bash
docker exec flarum /bin/sh -c "cd /flarum/app && composer require blomstra/database-queue:*"
```

`flarum` 是我的容器名，你可以参考一下改成你的。

然后重启一下 Flarum，查看一下 Cron 里有没有正确添加，你应该得到类似的东西

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

`'/usr/bin/php8' 'flarum' queue:work --stop-when-empty` 就是我们期望的东西，看样子没问题了。

不过记得添加 Cron，如果你没有添加的话，那可以参考我的。首先进入 crontab

```bash
crontab -e
```

添加

```bash
* * * * * /usr/bin/docker exec flarum /bin/sh -c "cd /flarum/app && php flarum schedule:run" >> /dev/null 2>&1
```

## 结尾

不出意外，你已经解决了邮件发不出去的问题。如果邮件还是发不出去，那可能是配置问题，在开始前最好确保 SMTP 信息是正确的，同时测试一下。

## 参考资料

- [Redis sessions, cache & queues](https://discuss.flarum.org/d/21873-redis-sessions-cache-queues)
- [Database Queue - the simplest queue, even for shared hosting](https://discuss.flarum.org/d/28151-database-queue-the-simplest-queue-even-for-shared-hosting)