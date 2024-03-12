---
title: Config VLESS Protocol with Advance Feature in sing-box
subtitle:
date: 2024-03-09T22:44:42-05:00
slug: vless-tcp-reality-xtls-utls-xudp
draft: false
author:
  name: James
  link: https://www.jamesflare.com
  email:
  avatar: /site-logo.avif
description: This blog post provides a step-by-step guide on setting up a VLESS + TCP + REALITY + XTLS + uTLS + XUDP configuration using sing-box, covering server and client-side setup, installation, and running sing-box for a secure and efficient proxy solution.
license:
comment: true
weight: 0
tags:
  - sing-box
  - Proxy
  - Security
  - Networking
categories:
  - Tutorials
  - Proxy
hiddenFromHomePage: false
hiddenFromSearch: false
hiddenFromRss: false
hiddenFromRelated: false
summary: This blog post provides a step-by-step guide on setting up a VLESS + TCP + REALITY + XTLS + uTLS + XUDP configuration using sing-box, covering server and client-side setup, installation, and running sing-box for a secure and efficient proxy solution.
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
  enable: true
  url:

# See details front matter: https://fixit.lruihao.cn/documentation/content-management/introduction/#front-matter
---

<!--more-->

## Introduction

VLESS + TCP + REALITY + XTLS + uTLS + XUDP is a very good combination. [XUDP](https://github.com/XTLS/Xray-core/discussions/252) let VLESS supports FullCone NAT. Using [REALITY](https://github.com/XTLS/REALITY#vless-xtls-utls-reality-example-for-xray-core-%E4%B8%AD%E6%96%87) instead of TLS can eliminate server-side TLS fingerprint characteristics, while still providing forward secrecy and rendering certificate chain attacks ineffective. Its security surpasses conventional TLS. It can point to other websites without the need to purchase a domain or configure a TLS server, making it more convenient. It achieves end-to-end genuine TLS presentation with a specified SNI to the middleman.

## Get sing-box

## sing-box Basic

sing-box uses JSON for configuration files.

```json
// Structure
{
  "log": {},
  "dns": {},
  "ntp": {},
  "inbounds": [],
  "outbounds": [],
  "route": {},
  "experimental": {}
}
```

You can get detailed documents [here](https://sing-box.sagernet.org/configuration). I will not go through too much of them.

## Server Side

Before start we need to generate a x25519 key pair for REALITY. To do that in sing-box just run:

```bash
sing-box generate reality-keypair
```

You should get something like this:

```text
PrivateKey: 0H5tYLhpDT_r675UC93iWAS2LqN6mPZoDcVDqsff018
PublicKey: SeIw41mp1LFEd6CEGArmnSoaIXzNlwnkIbduoEY-OXk
```

Optionally, you can generate a short id for REALITY as well. By running this, you should get a 8 digit hex number:

```bash
sing-box generate rand 8 --hex
```

You should get something like this:

```text
26079ba8291ff0fc
```

Finally, you need to generate a UUID:

```bash
sing-box generate uuid
```

You should get something like this:

```text
11391936-7544-4af5-ad02-e9f3970b1f64
```

Now, let's fill them into the right place and finish the config. If you want to save some time and do not want to dive too deep, you can refer this config:

```json
{
   "log":{
      "level":"info"
   },
   "inbounds":[
      {
         "type":"vless",
         "tag":"vless-in",
         "listen":"0.0.0.0",
         "listen_port":443,
         "users":[
            {
               "name":"jamesflare",
               "uuid":"11391936-7544-4af5-ad02-e9f3970b1f64",
               "flow":"xtls-rprx-vision"
            }
         ],
         "tls":{
            "enabled":true,
            "server_name":"www.rpi.edu",
            "reality":{
               "enabled":true,
               "handshake":{
                  "server":"www.rpi.edu",
                  "server_port":443
               },
               "private_key":"0H5tYLhpDT_r675UC93iWAS2LqN6mPZoDcVDqsff018",
               "short_id":[
                  "26079ba8291ff0fc"
               ]
            }
         },
         "multiplex":{
            "enabled":false
         }
      }
   ],
   "outbounds":[
      {
         "type":"direct",
         "tag":"direct"
      }
   ]
}
```

I highly recommand you change:

- `name`
- `uuid`
- `server_name`
- `server`
- `server_port`
- `private_key`
- `short_id`

to your own value, base on your own case.

## Client Side

I want sing-box use `TUN` as inbound, so we can archive global proxy. But you may run it as http/socks proxy as well. Anyhow, I will use `TUN` as example.

You need to change these following filed into your own value:

- `server`
- `server_port`
- `uuid`
- `server_name`
- `public_key`
- `short_id`

make sure your value match the server-side information. Here is an example:

```json
{
   "log":{
      "level":"info",
      "timestamp":true
   },
   "dns":{
      "servers":[
         {
            "tag":"cloudflare",
            "address":"1.1.1.1"
         }
      ],
      "rules":[
         {
            "outbound":"any",
            "server":"cloudflare"
         }
      ],
      "strategy":"ipv4_only"
   },
   "inbounds":[
      {
         "type":"tun",
         "tag":"tun-in",
         "interface_name":"tun0",
         "inet4_address":"172.28.0.1/30",
         "auto_route":true,
         "strict_route":true,
         "stack":"system",
         "sniff":true
      }
   ],
   "outbounds":[
      {
         "type":"vless",
         "tag":"vless-out",
         "server":"your.server.ip.or.domain",
         "server_port":443,
         "uuid":"11391936-7544-4af5-ad02-e9f3970b1f64",
         "flow":"xtls-rprx-vision",
         "tls":{
            "enabled":true,
            "server_name":"www.rpi.edu",
            "utls":{
               "enabled":true,
               "fingerprint":"chrome"
            },
            "reality":{
               "enabled":true,
               "public_key":"SeIw41mp1LFEd6CEGArmnSoaIXzNlwnkIbduoEY-OXk",
               "short_id":"26079ba8291ff0fc"
            }
         },
         "packet_encoding":"xudp",
         "multiplex":{
            "enabled":false
         }
      },
      {
         "type":"direct",
         "tag":"direct"
      },
      {
         "type":"dns",
         "tag":"dns"
      }
   ],
   "route":{
      "geoip":{
         "download_url":"https://github.com/SagerNet/sing-geoip/releases/latest/download/geoip.db",
         "download_detour":"vless-out"
      },
      "geosite":{
         "download_url":"https://github.com/SagerNet/sing-geosite/releases/latest/download/geosite.db",
         "download_detour":"vless-out"
      },
      "rules":[
         {
            "protocol":"dns",
            "outbound":"dns"
         },
         {
            "geoip":[
               "private"
            ],
            "outbound":"direct"
         }
      ],
      "auto_detect_interface":true
   }
}
```

## Install sing-box

You may ask "how can I run sing-box with aboving config?". Well, you need install sing-box at first. You can find more information in the [offical document](https://sing-box.sagernet.org/installation/package-manager/).

### In Debian 12

I run sing-box server side on a Linux server, the OS is Debian 12. I this way, I used the offical installing script for debian:

```bash
bash <(curl -fsSL https://sing-box.app/deb-install.sh)
```

You can check installation by running:

```bash
sing-box help
```

It should return something like:

```text
Usage:
  sing-box [command]

Available Commands:
  check       Check configuration
  completion  Generate the autocompletion script for the specified shell
  format      Format configuration
  generate    Generate things
  help        Help about any command
  merge       Merge configurations
  run         Run service
  tools       Experimental tools
  version     Print current version of sing-box

Flags:
  -c, --config stringArray             set configuration file path
  -C, --config-directory stringArray   set configuration directory path
  -D, --directory string               set working directory
      --disable-color                  disable color output
  -h, --help                           help for sing-box

Use "sing-box [command] --help" for more information about a command.
```

For Linux systems with systemd, usually the installation already includes a sing-box service, you can manage the service using the following command:

### In Windows 11

My client is Windows 11, I choice managed installation with [Chocolatey](https://chocolatey.org/install#individual). To install Chocolatey, you need run an Administrator PowerShell with:

```bash
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
```

If you don't see any errors, you are ready to use Chocolatey! Type `choco` or `choco -?` to check installation. Remember, this is a very simple instraction of Chocolatey, there are many other installation methods and options, please check offical site for more information.

Now, we can use Chocolatey to install sing-box:

```bash
choco install sing-box
```

You can check installation by running:

```bash
sing-box help
```

## Run sing-box

There are no different between server-side and client-side sing-box program. Only different is the config file.

Before start, you should save your config into a JSON file. I will name them like: `client.json`, `server.json`. Then specify the config in your command, like:

```bash
sing-box run -c client.json
```

You need to run sing-box both in client and server side. The output should be like:

```text
C:\Users\James\Desktop\Softwares\sing-box>sing-box run -c xray-ny-a-client.json
-0500 2023-12-27 23:23:32 INFO router: updated default interface Wi-Fi, index 18
-0500 2023-12-27 23:23:32 INFO inbound/tun[tun-in]: started at tun0
-0500 2023-12-27 23:23:32 INFO sing-box started (0.288s)
-0500 2023-12-27 23:23:32 INFO [832064929 0ms] inbound/tun[tun-in]: inbound packet connection from 172.28.0.1:55770
-0500 2023-12-27 23:23:32 INFO [1067986987 0ms] inbound/tun[tun-in]: inbound packet connection from 172.28.0.1:58423
-0500 2023-12-27 23:23:32 INFO [2253360887 0ms] inbound/tun[tun-in]: inbound connection from 172.28.0.1:60610
-0500 2023-12-27 23:23:32 INFO outbound/vless[vless-out]: outbound packet connection to 1.1.1.1:53
```