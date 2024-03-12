---
slug: "gravatar-cloudflare-workers"
title: "使用 CloudFlare Workers 反向代理"
subtitle: ""
date: 2023-01-15T21:31:42+08:00
draft: false
author:
  name: James
  link: https://www.jamesflare.com
  email:
  avatar: /site-logo.avif
description: "Gravatar 的头像服务在中国大陆不稳定。除了使用一些公开镜像，我们还能自行建立反代。不过如果要自己建立反代，就需要服务器，这可能需要额外的成本，更重要的一个问题是，一般人的服务器只能在一个机房，所以地区之间的速度差异会很大，而不像 Gravatar 在全球都有 CDN。"
keywords: ["Gravatar","CloudFlare Workers"]
license: ""
comment: true
weight: 0

tags:
- CloudFlare
- JavaScript
categories:
- 教程

hiddenFromHomePage: false
hiddenFromSearch: false

summary: "Gravatar 的头像服务在中国大陆不稳定。除了使用一些公开镜像，我们还能自行建立反代。不过如果要自己建立反代，就需要服务器，这可能需要额外的成本，更重要的一个问题是，一般人的服务器只能在一个机房，所以地区之间的速度差异会很大，而不像 Gravatar 在全球都有 CDN。"
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

## Introduction

在中国大陆 Gravatar 的头像服务一直处于不稳定，不可用的状态。除了使用一些公开服务，我们还能自行建立反代。

不过如果要自己建立反代，就需要服务器，这可能需要额外的成本，更重要的一个问题是，一般人的服务器只能在一个机房，所以地区之间的速度差异会很大，而不像 Gravatar 在全球都有 CDN。

我希望全球的用户加载速度都很快，退一万步说，用户挂的代理也可能遍布全球，是吧。

{{< image src="network-map.svg" width="750px" caption="CloudFlare Network Map" >}}

而 [CloudFlare Workers](https://developers.cloudflare.com/workers/learning/how-workers-works/) 直接可以在他们就近的数据中心处理，不比随便整一个服务器快多了。

## Pricing

那么，Workers 的[价格](https://developers.cloudflare.com/workers/platform/pricing)如何?

|          | Free plan                  | Paid Plan - Bundled                | Paid plan - Unbound                               |
| -------- | -------------------------- | ---------------------------------- | ------------------------------------------------- |
| Requests | 100,000 / day              | 10 million / month, +$0.50/million | 1 million / month, + $0.15/million                |
| Duration | 10ms CPU time / invocation | 50 ms CPU time / invocation        | 400,000 GB-s, + $12.50/million GB-s |

**答**，一般免费计划完全够用。

每天有 10 万次免费请求，基本上是用不完的。10ms 的 CPU 时间，这也是足够的，我们的代码估计也就 1ms 的时间。

退一万步，就算是要付钱，由于不需要 Workers KV，Queues，Durable Objects 等产品，只要单纯的请求数，也就是 Paid plan - Unbound。100 万次也就 $0.15，一元人民币的样子，巨便宜好吧。

### Calculation

图片算 30KB 一张的话，100 万张也就是 28.6G 流量，算上 VPS 可能是双向计算流量的，那就是 57.2G 的样子。

57G/元的价格放到 VPS 领域，可以说是中等水平，不算便宜，毕竟还有无限流量，俄罗斯 VPS 什么的不是？但是考虑到线路的水平，和全球的数据中心，这直接杀爆了。

CloudFlare 的速度也不是什么俄罗斯小鸡可以比的，如果是 CN2 这样的高级线路，那这个价格肯定是买不到的。

## Workers JS

使用方法很简单，基本上就是 JavaScript。

我们小小构造一下，

```JavaScript
addEventListener(
    "fetch", event => {
        let url = new URL(event.request.url);
        url.hostname = "www.gravatar.com";
        url.protocol = "https";
        let request = new Request(url, event.request);
        event.respondWith(
            fetch(request)
        )
    }
)
```

逻辑说白了就是返回以 https 请求收到的请求 URL，不过把请求时候发的`hostname`改成`www.gravatar.com`。

### Deploy

使用方法也很简单，在 CloudFlare 的 Workers 面板新建一个 Service。

把上面这个抄到里面，并且 Deploy。

## Custom Domains

默认会给你一个 workers.dev 的三级域名，如果你想用也完全没有问题，但是我希望设置一个自己的域名。

我们进入 Service，到 Trigger，点 Add Custom Domains，输入你需要的域名。

比如我选择 gravatar.jamesflare.com，那就输入`gravatar.jamesflare.com`。

## Testing

那我们测试一下，看看能不能用，这里用我头像测试`/avatar/75cea16f157b9c5da5435379ab6cf294?s=32&d=`。

构造一下，

![](https://gravatar.jamesflare.com/avatar/75cea16f157b9c5da5435379ab6cf294?s=32&d=) https://gravatar.jamesflare.com/avatar/75cea16f157b9c5da5435379ab6cf294?s=32&d=

可以看到，是没问题的。

## Use in Hugo

这属于衍生部分，其实过程相对曲折，而且不同主题可能还不一样，所以我希望记录一下思路而不是直接说结果，毕竟方案可能不通用。

我用的主题是 FixIt，约等于 LoveIt。

### Find Template File

通过查找，发现负责文章作者头像的模板位于`/FixIt/layouts/partials/single/post-author.html`

代码如下，

```go-html-template
{{- $params := .Scratch.Get "params" -}}

{{- $author := .Site.Author | merge (dict "name" "Anonymous" "link" (echoParam $params "authorlink") "email" (echoParam $params "authoremail")) -}}
{{- $avatar := .Site.Params.home.profile.avatarURL -}}
{{- if isset $params "author" | and (ne $params.author .Site.Author.name) -}}
  {{- $author = dict "name" $params.author | merge $author -}}
  {{- $author = dict "link" (echoParam $params "authorlink") | merge $author -}}
  {{- $author = dict "email" (echoParam $params "authoremail") | merge $author -}}
  {{- $avatar = "" -}}
{{- end -}}
{{- if (not $avatar | or $params.gravatarForce) | and $author.email -}}
  {{- $gravatar := .Site.Params.gravatar -}}
  {{- with $gravatar -}}
    {{- $avatar = printf "https://%v/avatar/%v?s=32&d=%v"
      (path.Clean .Host | default "www.gravatar.com")
      (md5 $author.email)
      (.Style | default "")
    -}}
  {{- end -}}
{{- end -}}
<span class="post-author">
  {{- $content := $author.name -}}
  {{- $icon := dict "Class" "fa-solid fa-user-circle" -}}
  {{- if $avatar -}}
    {{- $content = printf "%v&nbsp;%v" (dict "Src" $avatar "Class" "avatar" "Alt" $author.name | partial "plugin/image.html") $author.name -}}
    {{- $icon = "" -}}
  {{- end -}}
  {{- if $author.link -}}
    {{- $options := dict "Class" "author" "Destination" $author.link "Title" (T "single.author") "Rel" "author" "Icon" $icon "Content" $content -}}
    {{- partial "plugin/link.html" $options -}}
  {{- else -}}
    <span class="author">
      {{- with $icon -}}
        {{ . | partial "plugin/icon.html" }}
      {{ end -}}
      {{- $content | safeHTML -}}
    </span>
  {{- end -}}
</span>
{{- /* EOF */ -}}
```

### Find Code Section

如下片段是负责头像的

```go-html-template
{{- if (not $avatar | or $params.gravatarForce) | and $author.email -}}
  {{- $gravatar := .Site.Params.gravatar -}}
  {{- with $gravatar -}}
    {{- $avatar = printf "https://%v/avatar/%v?s=32&d=%v"
      (path.Clean .Host | default "www.gravatar.com")
      (md5 $author.email)
      (.Style | default "")
    -}}
  {{- end -}}
{{- end -}}
```

可以看见它判定配置文件 params 项下 gravatar 子项，Host 项下的值。

如果 Host 项是空，则默认`www.gravatar.com`。

那么很简单，有两种思路，一个是修改这个 HTML 模板本身，还有一个思路是修改配置文件的值。

### Make .toml Config

我选第二种。

我的配置文件是 .toml 格式的，稍微构造一下。

```toml
[params]
  [params.gravatar]
    host = "gravatar.jamesflare.com"
```

### Preview in Browser

重新生成一下站点，这里我只要预览即可，

```bash
hugo server -D -e production --disableFastRender
```

打开浏览器访问`http://localhost:1313/`，查看一下 HTML 源码有关部分。

```html
data-src="https://gravatar.jamesflare.com/avatar/75cea16f157b9c5da5435379ab6cf294?s=32&amp;d="
data-srcset="https://gravatar.jamesflare.com/avatar/75cea16f157b9c5da5435379ab6cf294?s=32&amp;d=, https://gravatar.jamesflare.com/avatar/75cea16f157b9c5da5435379ab6cf294?s=32&amp;d= 1.5x, https://gravatar.jamesflare.com/avatar/75cea16f157b9c5da5435379ab6cf294?s=32&amp;d= 2x"
```

可以看到已经改过来了，通过浏览器开发工具 Sources 栏也可以验证。

### Others

小插曲，FixIt 的配置文件原来已经有这项了，小丑原来是我自己，不过全网都搜不到，哭了。

```toml
[params]
  [params.gravatar]
    # Gravatar host, default: "www.gravatar.com"
    host = "www.gravatar.com" # ["cn.gravatar.com", "gravatar.loli.net", ...]
    style = "" # ["", "mp", "identicon", "monsterid", "wavatar", "retro", "blank", "robohash"]
```