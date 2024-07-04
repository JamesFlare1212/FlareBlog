---
title: 使用 sing-box 配置高级功能的 VLESS 协议
subtitle:
date: 2024-03-09T22:44:42-05:00
modified: 2024-06-06T14:31:06+08:00
slug: vless-tcp-reality-xtls-utls-xudp
draft: false
author:
  name: James
  link: https://www.jamesflare.com
  email:
  avatar: /site-logo.avif
description: 本文提供了使用 sing-box 设置 VLESS + TCP + REALITY + XTLS + uTLS + XUDP 配置的详细步骤，包括服务器和客户端的设置、安装和运行 sing-box，以实现一个安全高效的代理解决方案。
license:
comment: true
weight: 0
tags:
  - sing-box
  - 代理
  - 安全
  - 网络
categories:
  - 教程
  - 代理
hiddenFromHomePage: false
hiddenFromSearch: false
hiddenFromRss: false
hiddenFromRelated: false
summary: 本文提供了使用 sing-box 设置 VLESS + TCP + REALITY + XTLS + uTLS + XUDP 配置的详细步骤，包括服务器和客户端的设置、安装和运行 sing-box，以实现一个安全高效的代理解决方案。
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

# 查看详细的前言字段：https://fixit.lruihao.cn/documentation/content-management/introduction/#front-matter
---

<!--more-->

## 简介

VLESS + TCP + REALITY + XTLS + uTLS + XUDP 是一个非常优秀的组合。[XUDP](https://github.com/XTLS/Xray-core/discussions/252) 可以让 VLESS 支持全锥型 NAT。使用 [REALITY](https://github.com/XTLS/REALITY#vless-xtls-utls-reality-example-for-xray-core-%E4%B8%AD%E6%96%87) 代替 TLS 可以消除服务器端 TLS 指纹特征，同时仍然提供前向保密并使证书链攻击无效，其安全性超过了传统的 TLS。它可以指向其他网站，而无需购买域名或配置 TLS 服务器，使用起来更加方便。它实现了具有指定 SNI 的端到端真正 TLS 呈现给中间人。

## 获取 sing-box

## sing-box 基础知识

sing-box 使用 JSON 格式的配置文件。

```json
// 结构
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

你可以在[这里](https://sing-box.sagernet.org/configuration)获取详细的文档。我不会详细介绍每一项配置。

## 服务器端配置

在开始之前，我们需要为 REALITY 生成一个 x25519 密钥对。在 sing-box 中可以通过运行以下命令来生成：

```bash
sing-box generate reality-keypair
```

你应该会得到类似这样的输出：

```text
PrivateKey: 0H5tYLhpDT_r675UC93iWAS2LqN6mPZoDcVDqsff018
PublicKey: SeIw41mp1LFEd6CEGArmnSoaIXzNlwnkIbduoEY-OXk
```

可选地，你还可以为 REALITY 生成一个短 ID。通过运行以下命令，你应该会得到一个 8 位的十六进制数：

```bash
sing-box generate rand 8 --hex
```

输出大概是这样：

```text
26079ba8291ff0fc
```

最后，你还需要生成一个 UUID：

```bash
sing-box generate uuid
```

输出类似这样：

```text
11391936-7544-4af5-ad02-e9f3970b1f64
```

现在，让我们将它们填写到正确的位置并完成配置。如果你想节省时间，不想深入研究细节，可以参考这个配置示例：

```json
{
    "log": {
        "level": "info"
    },
    "inbounds": [
        {
            "type": "vless",
            "tag": "vless-in",
            "listen": "::",
            "listen_port": 443,
            "users": [
                {
                    "name": "jamesflare",
                    "uuid": "11391936-7544-4af5-ad02-e9f3970b1f64",
                    "flow": "xtls-rprx-vision"
                }
            ],
            "tls": {
                "enabled": true,
                "server_name": "portfolio.newschool.edu",
                "reality": {
                    "enabled": true,
                    "handshake": {
                        "server": "portfolio.newschool.edu",
                        "server_port": 443
                    },
                    "private_key": "0H5tYLhpDT_r675UC93iWAS2LqN6mPZoDcVDqsff018",
                    "short_id": [
                        "26079ba8291ff0fc"
                    ]
                }
            },
            "multiplex": {
                "enabled": false,
                "padding": true,
                "brutal": {
                    "enabled": false,
                    "up_mbps": 1000,
                    "down_mbps": 1000
                }
            }
        }
    ],
    "outbounds": [
        {
            "type": "direct",
            "tag": "direct"
        }
    ]
}
```

我强烈建议你根据自己的情况修改以下字段：

- `name`
- `uuid`
- `server_name`
- `server`
- `server_port`
- `private_key`
- `short_id`

## 客户端配置

我希望 sing-box 使用 `TUN` 作为入站，这样我们就可以实现全局代理。当然你也可以将其作为 http/socks 代理运行。无论如何，我将以 `TUN` 为例。

你需要将以下字段更改为你自己的值：

- `server`
- `server_port`
- `uuid`
- `server_name`
- `public_key`
- `short_id`

确保你的值与服务器端信息匹配。这里是一个配置示例：

```json
{
   "dns": {
      "final": "dns_proxy",
      "rules": [
         {
            "outbound": "any",
            "server": "dns_resolver"
         },
         {
            "rule_set": "geosite-geolocation-!cn",
            "server": "dns_proxy"
         },
         {
            "rule_set": "geosite-cn",
            "server": "dns_direct"
         }
      ],
      "servers": [
         {
            "address": "https://1.1.1.1/dns-query",
            "address_resolver": "dns_resolver",
            "detour": "proxy",
            "strategy": "prefer_ipv6",
            "tag": "dns_proxy"
         },
         {
            "address": "https://dns.alidns.com/dns-query",
            "address_resolver": "dns_resolver",
            "detour": "direct",
            "strategy": "prefer_ipv6",
            "tag": "dns_direct"
         },
         {
            "address": "223.5.5.5",
            "detour": "direct",
            "tag": "dns_resolver"
         }
      ]
   },
   "experimental": {
      "cache_file": {
         "enabled": true,
         "path": "cache.db"
      }
   },
   "inbounds": [
      {
         "auto_route": true,
         "inet4_address": "172.19.0.1/30",
         "inet6_address": "fdfe:dcba:9876::1/126",
         "interface_name": "tun0",
         "mtu": 9000,
         "sniff": true,
         "stack": "mixed",
         "strict_route": true,
         "tag": "tun-in",
         "type": "tun"
      },
      {
         "domain_strategy": "prefer_ipv6",
         "listen": "::",
         "listen_port": 1080,
         "set_system_proxy": false,
         "sniff": false,
         "sniff_override_destination": false,
         "sniff_timeout": "300ms",
         "tag": "mixed-in",
         "tcp_fast_open": true,
         "tcp_multi_path": true,
         "type": "mixed",
         "udp_disable_domain_unmapping": false,
         "udp_fragment": true,
         "udp_timeout": "5m"
      }
   ],
   "log": {
      "level": "info",
      "timestamp": true
   },
   "outbounds": [
      {
         "flow": "xtls-rprx-vision",
         "multiplex": {
            "brutal": {
               "down_mbps": 100,
               "enabled": false,
               "up_mbps": 1000
            },
            "enabled": false,
            "max_streams": 32,
            "padding": true,
            "protocol": "h2mux"
         },
         "packet_encoding": "xudp",
         "server": "your.server.ip.or.domain",
         "server_port": 443,
         "tag": "proxy",
         "tls": {
            "enabled": true,
            "reality": {
               "enabled": true,
               "public_key": "SeIw41mp1LFEd6CEGArmnSoaIXzNlwnkIbduoEY-OXk",
               "short_id": "26079ba8291ff0fc"
            },
            "server_name": "portfolio.newschool.edu",
            "utls": {
               "enabled": true,
               "fingerprint": "chrome"
            }
         },
         "type": "vless",
         "uuid": "11391936-7544-4af5-ad02-e9f3970b1f64"
      },
      {
         "tag": "direct",
         "type": "direct"
      },
      {
         "tag": "block",
         "type": "block"
      },
      {
         "tag": "dns-out",
         "type": "dns"
      }
   ],
   "route": {
      "auto_detect_interface": true,
      "final": "proxy",
      "rule_set": [
         {
            "download_detour": "proxy",
            "format": "binary",
            "tag": "geosite-geolocation-!cn",
            "type": "remote",
            "url": "https://raw.githubusercontent.com/SagerNet/sing-geosite/rule-set/geosite-geolocation-!cn.srs"
         },
         {
            "download_detour": "proxy",
            "format": "binary",
            "tag": "geoip-cn",
            "type": "remote",
            "url": "https://raw.githubusercontent.com/SagerNet/sing-geoip/rule-set/geoip-cn.srs"
         },
         {
            "download_detour": "proxy",
            "format": "binary",
            "tag": "geosite-cn",
            "type": "remote",
            "url": "https://raw.githubusercontent.com/SagerNet/sing-geosite/rule-set/geosite-cn.srs"
         }
      ],
      "rules": [
         {
            "outbound": "dns-out",
            "protocol": "dns"
         },
         {
            "network": "tcp",
            "outbound": "block",
            "port": 853
         },
         {
            "network": "udp",
            "outbound": "block",
            "port": [
               443,
               853
            ]
         },
         {
            "mode": "and",
            "outbound": "proxy",
            "rules": [
               {
                  "invert": true,
                  "rule_set": "geoip-cn"
               },
               {
                  "rule_set": "geosite-geolocation-!cn"
               }
            ],
            "type": "logical"
         },
         {
            "mode": "and",
            "outbound": "direct",
            "rules": [
               {
                  "rule_set": "geoip-cn"
               },
               {
                  "rule_set": "geosite-cn"
               }
            ],
            "type": "logical"
         },
         {
            "outbound": "direct",
            "rule_set": "geoip-cn"
         },
         {
            "ip_is_private": true,
            "outbound": "direct"
         }
      ]
   }
}
```

## 安装 sing-box

你可能会问"我如何使用上述配置运行 sing-box？"。首先你需要安装 sing-box。你可以在[官方文档](https://sing-box.sagernet.org/installation/package-manager/)中找到更多安装信息。

### 在 Debian 12 中安装

我在 Linux 服务器上运行 sing-box 服务器端，操作系统是 Debian 12。在这种情况下，我使用了 debian 的官方安装脚本：

```bash
bash <(curl -fsSL https://sing-box.app/deb-install.sh)  
```

你可以通过运行以下命令检查是否安装成功：

```bash
sing-box help
```

它应该会返回类似以下内容：

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

对于使用 systemd 的 Linux 系统，通常安装已经包括了一个 sing-box 服务，你可以使用以下命令管理该服务：

### 在 Windows 11 中安装

我的客户端是 Windows 11，我选择使用 [Chocolatey](https://chocolatey.org/install#individual) 进行托管安装。要安装 Chocolatey，你需要使用以下命令运行管理员 PowerShell：

```bash
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
```

如果你没有看到任何错误，就可以开始使用 Chocolatey 了！输入 `choco` 或 `choco -?` 检查是否安装成功。请记住，这只是一个非常简单的 Chocolatey 安装说明，还有许多其他安装方法和选项，请查看官网以获取更多信息。

现在，我们可以使用 Chocolatey 安装 sing-box：

```bash 
choco install sing-box
```

你可以通过运行以下命令检查是否安装成功：

```bash
sing-box help  
```

## 运行 sing-box

服务器端和客户端的 sing-box 程序没有区别。唯一的区别在于配置文件。

在开始之前，你应该将配置保存到 JSON 文件中。我会将它们命名为：`client.json`、`server.json`。然后在命令中指定配置文件，例如：

```bash
sing-box run -c client.json
```

你需要在客户端和服务器端都运行 sing-box。输出应该类似于：

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
