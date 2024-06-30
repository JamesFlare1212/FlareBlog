---
slug: "gravatar-cloudflare-workers"
title: "Using CloudFlare Workers for Reverse Proxy"
subtitle: ""
date: 2023-01-15T21:31:42+08:00
draft: false
author:
  name: James 
  link: https://www.jamesflare.com
  email:
  avatar: /site-logo.avif
description: "Gravatar's avatar service is unstable in mainland China. While we can use some public mirrors, we also have the option to set up our own reverse proxy. However, setting up a self-hosted reverse proxy requires a server, which may incur additional costs. More importantly, an individual's server is typically limited to a single data center, resulting in significant speed variations across different regions, unlike Gravatar's global CDN coverage."
keywords: ["Gravatar", "CloudFlare Workers"]
license: ""
comment: true
weight: 0

tags:
- CloudFlare
- JavaScript
categories:
- Tutorials

hiddenFromHomePage: false
hiddenFromSearch: false

summary: "Gravatar's avatar service is unstable in mainland China. While we can use some public mirrors, we also have the option to set up our own reverse proxy. However, setting up a self-hosted reverse proxy requires a server, which may incur additional costs. More importantly, an individual's server is typically limited to a single data center, resulting in significant speed variations across different regions, unlike Gravatar's global CDN coverage."
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
  enable: false
  url:

# See details front matter: https://fixit.lruihao.cn/theme-documentation-content/#front-matter
---

## Introduction

In mainland China, Gravatar's avatar service has always been unstable and unavailable. In addition to using some public mirror sites, we can also set up our own reverse proxy. However, if you want to set up your own reverse proxy, you need a server, which may incur additional costs. More importantly, a typical person's server can only be located in one data center, resulting in large speed differences between regions, unlike Gravatar which has a global CDN network.

I hope that users worldwide can enjoy fast loading speeds. At the very least, the proxies used by users may also be distributed globally, right?

{{< image src="network-map.svg" width="750px" caption="CloudFlare Network Map" >}}

[CloudFlare Workers](https://developers.cloudflare.com/workers/learning/how-workers-works/) can directly process requests in their nearby data centers, which is much faster than using a random server.

## Pricing

So, what is the [pricing](https://developers.cloudflare.com/workers/platform/pricing) for Workers?

|          | Free Plan                  | Paid Plan - Bundled                | Paid Plan - Unbound                               |
| -------- | -------------------------- | ---------------------------------- | ------------------------------------------------- |
| Requests | 100,000 / day              | 10 million / month, +$0.50/million | 1 million / month, + $0.15/million                |
| Duration | 10ms CPU time / invocation | 50 ms CPU time / invocation        | 400,000 GB-s, + $12.50/million GB-s |

The free plan is generally sufficient for most use cases.

You get 100,000 free requests per day, which is basically inexhaustible. The 10ms CPU time per invocation is also adequate, as our code likely only takes around 1ms to execute.

Even if you do need to pay, since we don't require Workers KV, Queues, Durable Objects, or other products, and only need the number of requests, the Paid Plan - Unbound tier applies. 1 million requests cost a mere $0.15, equivalent to about one Chinese yuan, which is incredibly cheap.

### Cost Calculation

Assuming each image is around 30KB, 1 million images would consume approximately 28.6GB of traffic. Considering that VPS providers may calculate traffic in both directions, it would be about 57.2GB.

The price of 57GB per yuan is considered average in the VPS market, not particularly cheap, especially when compared to unlimited traffic plans or Russian VPS offerings. However, when taking into account the quality of the network and the global distribution of data centers, CloudFlare's offering is unbeatable.

CloudFlare's speed is not something that cheap VPS plans can match. If you were to use a premium network like CN2, the price would definitely be much higher.

## Workers JavaScript

The usage is very straightforward, essentially just JavaScript.

Let's construct a simple example:

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

In essence, the logic is to return the requested URL received via HTTPS, but change the `hostname` sent at the time of the request to `www.gravatar.com`.

### Deployment

The deployment process is also very simple. Create a new Service in the CloudFlare Workers dashboard.

Copy the above code into it and click Deploy.

## Custom Domains

By default, you will be assigned a workers.dev subdomain, which is perfectly fine to use. However, I prefer to set up my own custom domain.

Go to the Service settings, then to Triggers, click Add Custom Domains, and enter your desired domain name.

For example, if I choose gravatar.jamesflare.com, I would enter `gravatar.jamesflare.com`.

## Testing

Let's test it out and see if it works. Here, I'll use my avatar URL for testing: `/avatar/75cea16f157b9c5da5435379ab6cf294?s=32&d=`.

Constructing the URL:

![](https://gravatar.jamesflare.com/avatar/75cea16f157b9c5da5435379ab6cf294?s=32&d=) https://gravatar.jamesflare.com/avatar/75cea16f157b9c5da5435379ab6cf294?s=32&d=

As you can see, it works perfectly.

## Usage in Hugo

This part is somewhat derivative. The process can be quite convoluted and may vary between different themes, so I want to focus on the thought process rather than providing a direct solution, as it may not be universally applicable.

I am using the FixIt theme, which is roughly equivalent to LoveIt.

### Locating the Template File

After some searching, I found that the template responsible for rendering the author's avatar in articles is located at `/FixIt/layouts/partials/single/post-author.html`.

The code is as follows:

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

### Identifying the Relevant Code Section

The following code snippet is responsible for handling the avatar:

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

It checks the value of the `Host` item under the `gravatar` sub-item of the `params` section in the configuration file.

If the `Host` item is empty, it defaults to `www.gravatar.com`.

There are two possible approaches: modifying the HTML template itself or modifying the value in the configuration file.

### Configuring the .toml File

I opted for the second approach.

My configuration file is in the .toml format, so I'll construct it as follows:

```toml
[params]
  [params.gravatar]
    host = "gravatar.jamesflare.com"
```

### Previewing in the Browser

Regenerate the site. Here, I only need to preview it:

```bash
hugo server -D -e production --disableFastRender
```

Open the browser and navigate to `http://localhost:1313/`. Check the relevant part of the HTML source code:

```html
data-src="https://gravatar.jamesflare.com/avatar/75cea16f157b9c5da5435379ab6cf294?s=32&amp;d="
data-srcset="https://gravatar.jamesflare.com/avatar/75cea16f157b9c5da5435379ab6cf294?s=32&amp;d=, https://gravatar.jamesflare.com/avatar/75cea16f157b9c5da5435379ab6cf294?s=32&amp;d= 1.5x, https://gravatar.jamesflare.com/avatar/75cea16f157b9c5da5435379ab6cf294?s=32&amp;d= 2x"
```

As you can see, the change has taken effect, which can also be verified using the Sources tab in the browser's developer tools.

### Side Note

As a side note, it turns out that the FixIt theme's configuration file already included this option, and I was the clown for not noticing it earlier, despite searching extensively online. Here's the relevant section:

```toml
[params]
  [params.gravatar]
    # Gravatar host, default: "www.gravatar.com"
    host = "www.gravatar.com" # ["cn.gravatar.com", "gravatar.loli.net", ...]
    style = "" # ["", "mp", "identicon", "monsterid", "wavatar", "retro", "blank", "robohash"]
```