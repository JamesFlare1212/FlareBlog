---
title: 使用 sing-box 1.14 配置 VLESS + REALITY + Vision
subtitle:
date: 2024-03-09T22:44:42-05:00
modified: 2026-10-03T18:00:00-04:00
slug: vless-tcp-reality-xtls-utls-xudp
draft: false
author:
  name: James
  link: https://www.jamesflare.com
  email:
  avatar: /site-logo.avif
description: 基于 sing-box 1.14.2 重写的 VLESS + TCP + REALITY + Vision + uTLS + XUDP 教程，涵盖新版 DNS、TUN、路由动作和分流，并附官方二进制配置检查及连通测试记录。
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
hidden_from_home_page: false
hidden_from_search: false
hidden_from_feed: false
hidden_from_related: false
summary: 基于 sing-box 1.14.2 重写的 VLESS + TCP + REALITY + Vision + uTLS + XUDP 教程，涵盖新版 DNS、TUN、路由动作和分流，并附官方二进制配置检查及连通测试记录。
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

## 版本与适用范围

本文于 **2026 年 10 月 3 日**按官方文档重写，使用当时的最新稳定版 [sing-box 1.14.2](https://github.com/SagerNet/sing-box/releases/tag/v1.14.2)。服务器以 Linux 为例，客户端提供 Windows / Linux 的 TUN 配置，以及无需 TUN 的本地 HTTP / SOCKS5 配置。升级前先查看[迁移指南](https://sing-box.sagernet.org/migration/)和[弃用列表](https://sing-box.sagernet.org/deprecated/)；官网也会介绍开发版功能，本文不以 alpha 版为基准。

这里的组合分别承担以下工作：VLESS 负责代理协议，TCP 承载连接，REALITY 使用握手目标与密钥对完成认证，`xtls-rprx-vision` 启用 Vision，uTLS 设置客户端 ClientHello 指纹，XUDP 编码 UDP 数据。无需为这台代理服务器申请域名和证书，但必须有客户端可访问的服务器 IP 和 TCP 端口。

根据 [VLESS 出站文档](https://sing-box.sagernet.org/configuration/outbound/vless/)，`packet_encoding` 当前默认就是 `xudp`，本文显式填写以便阅读。不要把 `network` 设置成 `tcp`：这个字段限制可代理的流量类型，会同时禁用 UDP；这里的 TCP 指 VLESS 连接的底层传输。省略 `transport` 即可使用默认 TCP 传输。

官方 [TLS 文档](https://sing-box.sagernet.org/configuration/shared/tls/#utls)目前不推荐将 uTLS 用于抗指纹识别。本文为了延续这一组合保留 `chrome` 配置，但它不保证连接无法被识别；XUDP 本身也不能保证整个网络具有 Full Cone NAT 行为。

## 旧配置需要迁移哪些地方

以下字段在旧文章中出现过。仅替换服务器地址和密钥已经不足以让原配置在新版本运行。

| 旧写法 | 本文的写法 | 变更版本 |
| --- | --- | --- |
| TUN 的 `inet4_address` / `inet6_address` | `address` 数组 | 1.12 已移除旧字段 |
| 入站的 `sniff` / `sniff_override_destination` / `domain_strategy` | 路由中的 `sniff` / `resolve` 动作 | 1.13 已移除旧字段 |
| `type: dns` 出站 | `action: hijack-dns` | 1.13 已移除旧出站 |
| `type: block` 出站 | `action: reject` | 1.13 已移除旧出站 |
| DNS 服务器的 `address` / `address_resolver` | `type`、`server`、`domain_resolver` | 1.14 已移除旧格式 |
| DNS 规则的 `outbound: any`；拨号的 `domain_strategy` | 出站的 `domain_resolver` 或 `route.default_domain_resolver` | 1.14 迁移到显式解析器 |
| 规则集的 `download_detour` | `http_clients` 与规则集的 `http_client` | 1.14 弃用，1.16 计划移除 |

变更依据见官方[弃用列表](https://sing-box.sagernet.org/deprecated/)。新配置也省略 `stack`，使用所安装版本的默认实现；官网中 1.15 开始弃用该字段的说明不代表 1.14 已经采用新的 TCP/IP 栈。

## 安装与核对版本

### Linux 服务器

可以按[官方安装文档](https://sing-box.sagernet.org/installation/package-manager/)安装发行包。下面先下载脚本，查看内容，再安装本文验证过的版本：

```bash
curl -fsSL https://sing-box.app/install.sh -o install-sing-box.sh
less install-sing-box.sh
sudo sh install-sing-box.sh --version 1.14.2
sing-box version
```

如果只想下载独立二进制，Linux x86_64 可以使用下列命令；ARM64 机器应在发布页选择 `linux-arm64` 文件，校验值也要对应替换：

```bash
curl -fL https://github.com/SagerNet/sing-box/releases/download/v1.14.2/sing-box-1.14.2-linux-amd64.tar.gz -o sing-box-1.14.2-linux-amd64.tar.gz
cat > sing-box.sha256 <<'SHA256'
a684484d7477d1437282ee411f4d131d0340aaad60a7868841ebd5d87dd8a0c6  sing-box-1.14.2-linux-amd64.tar.gz
SHA256
sha256sum -c sing-box.sha256
tar -xzf sing-box-1.14.2-linux-amd64.tar.gz
./sing-box-1.14.2-linux-amd64/sing-box version
```

本文的 SHA-256 来自该发布版本的官方资产摘要。独立压缩包不会自动安装 systemd 服务；后文的 `systemctl` 命令适用于通过官方发行包安装的情况。若使用独立二进制，后文的 `sing-box` 命令应替换成它的实际路径，例如 `./sing-box-1.14.2-linux-amd64/sing-box`。

### Windows 客户端

Windows x64 可以直接下载同一个版本的官方压缩包。在 PowerShell 中执行：

```powershell
Invoke-WebRequest -Uri 'https://github.com/SagerNet/sing-box/releases/download/v1.14.2/sing-box-1.14.2-windows-amd64.zip' -OutFile 'sing-box.zip'
Expand-Archive -Path '.\sing-box.zip' -DestinationPath '.\sing-box'
Set-Location '.\sing-box\sing-box-1.14.2-windows-amd64'
.\sing-box.exe version
```

ARM64 Windows 应选择相应的 `windows-arm64` 包。配置检查和本地 mixed 代理可以普通权限运行，创建 TUN 接口需要以管理员身份启动 PowerShell。安装其他客户端时，也要确认它实际内置的 sing-box 核心版本。

## 生成服务器与客户端参数

在安装好 sing-box 的机器上执行：

```bash
sing-box generate reality-keypair
sing-box generate uuid
sing-box generate rand 8 --hex
```

第一条命令输出 `PrivateKey` 和 `PublicKey`，分别写入服务器与客户端。最后一条生成 **8 字节，也就是 16 个十六进制字符**的 short ID，不是 8 个字符。服务器的 `short_id` 是数组，客户端填其中一个字符串。

下面所有配置中的 UUID、密钥和 short ID 都是公开的示例值。**部署前生成并替换成自己的值，私钥只保留在服务器。** `203.0.113.10` 是文档示例 IP，必须换成真实 VPS 地址。

| 参数 | 服务器位置 | 客户端位置 |
| --- | --- | --- |
| VPS 地址、监听端口 | `listen_port`；主机自身的公网地址 | VLESS 出站的 `server`、`server_port` |
| UUID | `users[].uuid` | `uuid` |
| Vision | `users[].flow` | `flow`，两端均为 `xtls-rprx-vision` |
| REALITY 密钥对 | `tls.reality.private_key` | `tls.reality.public_key` |
| short ID | `tls.reality.short_id[]` | `tls.reality.short_id` |
| 握手目标域名 | `tls.reality.handshake.server`、`tls.server_name` | `tls.server_name` |

`server` 是自己的 VPS；`server_name` 是 REALITY 握手目标的域名，二者不能混淆。本文使用 `portfolio.newschool.edu:443` 作为目标示例，实际部署前应从 VPS 验证目标的 TLS 1.3 握手和证书是否正常，并选择稳定、可达的目标：

```bash
openssl s_client -connect portfolio.newschool.edu:443 -servername portfolio.newschool.edu -tls1_3 -alpn h2 -verify_return_error </dev/null
```

目标站点状态可能变化，本文的离线测试不构成对这个公网目标可用性的保证。

## 服务器配置

保存为 `server.json`，或下载 [server.json](server.json)。字段说明可参考 [VLESS 入站](https://sing-box.sagernet.org/configuration/inbound/vless/)和 [REALITY TLS](https://sing-box.sagernet.org/configuration/shared/tls/#reality-fields)文档。

```json
{
  "log": {
    "level": "info",
    "timestamp": true
  },
  "dns": {
    "servers": [
      {
        "type": "local",
        "tag": "dns-local"
      }
    ]
  },
  "inbounds": [
    {
      "type": "vless",
      "tag": "vless-in",
      "listen": "::",
      "listen_port": 443,
      "users": [
        {
          "name": "example-user",
          "uuid": "4012432b-c3a0-4da0-bdb1-c3728707af47",
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
          "private_key": "YLVFXAQhUF7m_XJg-gmcXLyT_t_UQUuiiYGxRDkfDk4",
          "short_id": [
            "1338a0a5f15eaa28"
          ]
        }
      }
    }
  ],
  "outbounds": [
    {
      "type": "direct",
      "tag": "direct"
    }
  ],
  "route": {
    "final": "direct",
    "default_domain_resolver": "dns-local"
  }
}
```

服务器监听 TCP 443，VPS 防火墙及云安全组需要允许这个端口，也要允许服务器访问握手目标和代理目的地。已有 Web 服务占用 443 时，可以选其他 TCP 端口，并同步修改客户端。这里的 UDP 通过 VLESS TCP 连接携带，不需要为了 XUDP 另外开放服务器 UDP 443。

`dns-local` 用于服务器解析客户端请求中的域名；服务器应有正常可用的系统 DNS。本例省略 multiplex、Brutal 等与基础部署无关的调优项。

先检查再前台启动：

```bash
sing-box check -c server.json
sudo sing-box run -c server.json
```

通过发行包安装并确认前台运行正常后，可以将配置交给 systemd：

```bash
sudo install -o sing-box -m 600 server.json /etc/sing-box/config.json
sudo sing-box check -D /var/lib/sing-box -C /etc/sing-box
sudo systemctl enable --now sing-box
sudo systemctl restart sing-box
sudo systemctl status sing-box --no-pager
sudo journalctl -u sing-box --output cat -e
```

1.14.2 的[官方 systemd 单元](https://github.com/SagerNet/sing-box/blob/v1.14.2/release/config/sing-box.service)以 `sing-box` 用户运行，使用 `/var/lib/sing-box` 作为工作目录，并通过 `-C /etc/sing-box` 加载配置。上面的权限和检查命令与它保持一致；该目录中的其他 JSON 配置也会被加载，应先移走旧配置或备份文件。执行前先停止前台进程，避免端口占用。更新已运行的服务时，始终先检查新配置，再重启。

## 客户端：TUN 与本地代理

保存为 `client.json`，或下载 [client.json](client.json)。此版本将局域网和私有地址直连，其余 TCP / UDP 流量默认走代理；中国大陆分流在下一节单独添加。

```json
{
  "log": {
    "level": "info",
    "timestamp": true
  },
  "dns": {
    "servers": [
      {
        "type": "udp",
        "tag": "dns-bootstrap",
        "server": "223.5.5.5"
      },
      {
        "type": "https",
        "tag": "dns-remote",
        "server": "1.1.1.1",
        "path": "/dns-query",
        "detour": "proxy"
      }
    ],
    "final": "dns-remote"
  },
  "inbounds": [
    {
      "type": "tun",
      "tag": "tun-in",
      "address": [
        "172.19.0.1/30",
        "fdfe:dcba:9876::1/126"
      ],
      "mtu": 1500,
      "auto_route": true,
      "strict_route": true,
      "dns_mode": "hijack"
    },
    {
      "type": "mixed",
      "tag": "mixed-in",
      "listen": "127.0.0.1",
      "listen_port": 1080
    }
  ],
  "outbounds": [
    {
      "type": "vless",
      "tag": "proxy",
      "server": "203.0.113.10",
      "server_port": 443,
      "uuid": "4012432b-c3a0-4da0-bdb1-c3728707af47",
      "flow": "xtls-rprx-vision",
      "packet_encoding": "xudp",
      "domain_resolver": "dns-bootstrap",
      "tls": {
        "enabled": true,
        "server_name": "portfolio.newschool.edu",
        "utls": {
          "enabled": true,
          "fingerprint": "chrome"
        },
        "reality": {
          "enabled": true,
          "public_key": "BOB8UnJ_beddqArT3CEeuK_68z7wUC_Qruezq3YI8C0",
          "short_id": "1338a0a5f15eaa28"
        }
      }
    },
    {
      "type": "direct",
      "tag": "direct",
      "domain_resolver": "dns-bootstrap"
    }
  ],
  "route": {
    "auto_detect_interface": true,
    "default_domain_resolver": "dns-bootstrap",
    "rules": [
      {
        "action": "sniff"
      },
      {
        "protocol": "dns",
        "action": "hijack-dns"
      },
      {
        "ip_is_private": true,
        "action": "route",
        "outbound": "direct"
      }
    ],
    "final": "proxy"
  }
}
```

DNS 和路由的关系如下：

- `dns-bootstrap` 使用直连的 `223.5.5.5` 解析代理服务器域名。示例的 VPS 地址是 IP，因此连接代理时不需要这一步；换成域名时要选择当地可达的 bootstrap DNS。它不经过 `proxy`，避免「先连接代理才能解析代理域名」的循环。
- `dns-remote` 是通过 `proxy` 访问的 DoH，负责默认的应用 DNS 查询。直接填写 `1.1.1.1` 避免额外的 DoH 域名引导解析。新 DNS 服务器的默认拨号方式是直连，因此这里显式写出 `detour: proxy`，详见 [DoH 文档](https://sing-box.sagernet.org/configuration/dns/server/https/)。
- `sniff` 放在路由规则中，随后用 `hijack-dns` 将识别出的普通 DNS 流量交给内置 DNS。`dns_mode: hijack` 使用 1.14 的 TUN DNS 设置；本例不手动设置 `dns_address`，由核心选择 TUN 网段中的 DNS 地址。
- `auto_detect_interface` 把出站连接绑定到默认网卡，防止 TUN 路由回环。`strict_route` 在 Windows 上有助于限制多网卡普通 DNS 泄漏；应用自带的 DoH / DoT 不会自动变成内置 DNS 查询。

TUN 行为依据 [TUN 文档](https://sing-box.sagernet.org/configuration/inbound/tun/)；解析器配置依据[拨号字段](https://sing-box.sagernet.org/configuration/shared/dial/)。配置不阻断 UDP 443，因此可以代理 QUIC；是否工作还取决于网络状况和应用本身。

Linux 使用：

```bash
sing-box check -c client.json
sudo sing-box run -c client.json
```

Linux 上官方推荐同时开启 `auto_redirect`。在 `type: tun` 的入站中添加 `"auto_redirect": true`，并确保内核支持所需的 nftables / NFQueue 功能；这是 Linux 专用选项，不要加入 Windows 配置。

Windows 在管理员 PowerShell 中使用：

```powershell
.\sing-box.exe check -c .\client.json
.\sing-box.exe run -c .\client.json
```

### 只使用 HTTP / SOCKS5

下载 [client-mixed.json](client-mixed.json)，替换相同的 VPS、UUID 和 REALITY 参数后运行。它与上面的客户端配置相同，只删除 TUN 入站，保留 `127.0.0.1:1080` 的 mixed 入站，不需要管理员权限，也不会接管系统路由。

```bash
sing-box check -c client-mixed.json
sing-box run -c client-mixed.json
```

另开终端测试：

```bash
curl --noproxy "" --proxy socks5h://127.0.0.1:1080 https://example.com/
curl --noproxy "" --proxy http://127.0.0.1:1080 https://example.com/
```

Windows 使用 `curl.exe`。`socks5h` 将域名交给代理解析，避免 curl 在本机先做 DNS 查询。mixed 只监听回环地址，需要应用自行配置代理。

## 可选：中国大陆直连分流

下载完整的 [client-cn.json](client-cn.json)，替换连接参数后代替 `client.json` 使用。这个版本保留旧教程的大陆直连意图，并将配置迁移到 1.14 的 HTTP 客户端格式。

它增加两个远程规则集：`geosite-cn` 匹配域名，`geoip-cn` 匹配目标 IP。路由依次执行 sniff、DNS 接管、私有地址直连、中国域名直连、DNS 解析、中国 IP 直连，剩余流量走代理。DNS 规则只引用域名规则集，避免依赖已弃用的 DNS 地址过滤语义。

其中下载规则集的配置为：

```json
{
  "http_clients": [
    {
      "tag": "rules-download",
      "detour": "proxy"
    }
  ]
}
```

规则集引用这个客户端，例如：

```json
{
  "type": "remote",
  "tag": "geosite-cn",
  "format": "binary",
  "url": "https://raw.githubusercontent.com/SagerNet/sing-geosite/rule-set/geosite-cn.srs",
  "http_client": "rules-download"
}
```

这两段是完整下载配置中的节选，不能作为独立的 `client.json` 运行。规则集和 DNS 分流配置可参考[规则集文档](https://sing-box.sagernet.org/configuration/rule-set/)与 [HTTP Client 文档](https://sing-box.sagernet.org/configuration/shared/http-client/)。

`client-cn.json` 使用 `223.5.5.5` 的 DoH 为大陆域名解析，TLS `server_name` 为 `dns.alidns.com`；直连出站也显式使用这个解析器。其他应用域名通过代理 DoH 解析。`resolve` 规则确保只有域名的连接也能继续匹配目标 IP；DNS 选路不自动决定连接的出站。

首次启动需要通过代理从 GitHub 下载规则集，因此先用基础配置确认代理能够连接，再启用分流。`cache_file` 保存规则集缓存，工作目录需要可写。规则集不能保证每个站点分类准确，CDN、域名解析结果与代理出口所在地也可能影响分流。
