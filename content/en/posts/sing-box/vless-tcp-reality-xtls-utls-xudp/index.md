---
title: Configure VLESS + REALITY + Vision with sing-box 1.14
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
description: A sing-box 1.14.2 guide to VLESS + TCP + REALITY + Vision + uTLS + XUDP, with updated DNS, TUN, route actions, optional bypass rules, and official binary validation.
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
hidden_from_home_page: false
hidden_from_search: false
hidden_from_feed: false
hidden_from_related: false
summary: A sing-box 1.14.2 guide to VLESS + TCP + REALITY + Vision + uTLS + XUDP, with updated DNS, TUN, route actions, optional bypass rules, and official binary validation.
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

## Version and scope

This guide was rewritten on **October 3, 2026** against the official documentation and the latest stable release at that time, [sing-box 1.14.2](https://github.com/SagerNet/sing-box/releases/tag/v1.14.2). It covers a Linux server, a Windows / Linux TUN client, and a local HTTP / SOCKS5 client that does not require TUN. Read the [migration guide](https://sing-box.sagernet.org/migration/) and [deprecation list](https://sing-box.sagernet.org/deprecated/) before upgrading. The website also documents development releases; this tutorial targets the stable version rather than an alpha.

VLESS provides the proxy protocol, TCP carries the connection, REALITY authenticates with a key pair and a handshake target, `xtls-rprx-vision` enables Vision, uTLS selects the client's ClientHello fingerprint, and XUDP encodes UDP traffic. You need a reachable server IP and TCP port, but do not need to obtain a domain or certificate for the proxy server.

The [VLESS outbound documentation](https://sing-box.sagernet.org/configuration/outbound/vless/) lists `xudp` as the current default packet encoding. It is explicit here for clarity. Do not set `network` to `tcp`: that field restricts the traffic the outbound can proxy and would disable UDP. TCP in this guide describes the underlying VLESS connection. Leave `transport` unset to use the default TCP transport.

The official [TLS documentation](https://sing-box.sagernet.org/configuration/shared/tls/#utls) currently advises against relying on uTLS for fingerprint resistance. This guide retains `chrome` to cover the original combination, without promising that it makes traffic undetectable. XUDP alone also does not guarantee Full Cone NAT behavior throughout the network.

## Changes required by the old configuration

Replacing only the server address and keys is no longer enough to run the original configuration.

| Old setting | Replacement used here | Version |
| --- | --- | --- |
| TUN `inet4_address` / `inet6_address` | `address` array | Old fields removed in 1.12 |
| Inbound `sniff` / `sniff_override_destination` / `domain_strategy` | Route actions such as `sniff` and `resolve` | Old fields removed in 1.13 |
| `type: dns` outbound | `action: hijack-dns` | Old outbound removed in 1.13 |
| `type: block` outbound | `action: reject` | Old outbound removed in 1.13 |
| DNS server `address` / `address_resolver` | `type`, `server`, `domain_resolver` | Old format removed in 1.14 |
| DNS rule `outbound: any`; dialer `domain_strategy` | Outbound `domain_resolver` or `route.default_domain_resolver` | Explicit resolver migration in 1.14 |
| Rule-set `download_detour` | `http_clients` and rule-set `http_client` | Deprecated in 1.14; removal scheduled for 1.16 |

See the official [deprecation list](https://sing-box.sagernet.org/deprecated/). These configurations also omit `stack`, using the installed version's default implementation. Documentation about its deprecation starting in 1.15 does not mean that 1.14 already uses the new TCP/IP stack.

## Install and verify the version

### Linux server

Use an official package as described in the [installation documentation](https://sing-box.sagernet.org/installation/package-manager/). Download and inspect the installer before installing the version tested here:

```bash
curl -fsSL https://sing-box.app/install.sh -o install-sing-box.sh
less install-sing-box.sh
sudo sh install-sing-box.sh --version 1.14.2
sing-box version
```

For a standalone Linux x86_64 binary, use the following commands. ARM64 machines should select the `linux-arm64` asset and its corresponding checksum instead:

```bash
curl -fL https://github.com/SagerNet/sing-box/releases/download/v1.14.2/sing-box-1.14.2-linux-amd64.tar.gz -o sing-box-1.14.2-linux-amd64.tar.gz
cat > sing-box.sha256 <<'SHA256'
a684484d7477d1437282ee411f4d131d0340aaad60a7868841ebd5d87dd8a0c6  sing-box-1.14.2-linux-amd64.tar.gz
SHA256
sha256sum -c sing-box.sha256
tar -xzf sing-box-1.14.2-linux-amd64.tar.gz
./sing-box-1.14.2-linux-amd64/sing-box version
```

The SHA-256 above comes from the official release asset digest. Extracting the standalone archive does not install a systemd service; the service commands below assume installation through the official package. With the standalone binary, replace subsequent `sing-box` commands with its actual path, such as `./sing-box-1.14.2-linux-amd64/sing-box`.

### Windows client

Windows x64 users can download the same version's official archive in PowerShell:

```powershell
Invoke-WebRequest -Uri 'https://github.com/SagerNet/sing-box/releases/download/v1.14.2/sing-box-1.14.2-windows-amd64.zip' -OutFile 'sing-box.zip'
Expand-Archive -Path '.\sing-box.zip' -DestinationPath '.\sing-box'
Set-Location '.\sing-box\sing-box-1.14.2-windows-amd64'
.\sing-box.exe version
```

Choose `windows-arm64` on ARM64 Windows. Configuration checks and the local mixed proxy can run without elevation. Creating a TUN interface requires an administrator PowerShell session. If using another client application, check its bundled sing-box core version as well.

## Generate connection parameters

Run these commands on a machine with sing-box installed:

```bash
sing-box generate reality-keypair
sing-box generate uuid
sing-box generate rand 8 --hex
```

The first command prints `PrivateKey` and `PublicKey` for the server and client respectively. The last command produces **8 bytes, or 16 hexadecimal characters**, rather than eight characters. The server accepts an array of short IDs; the client uses one matching string.

All UUIDs, keys and short IDs below are public demonstration values. **Generate and replace them before deployment; keep the private key on the server.** `203.0.113.10` is a documentation address and must be replaced with your actual VPS address.

| Parameter | Server location | Client location |
| --- | --- | --- |
| VPS address and listening port | `listen_port`; the host's public address | VLESS outbound `server`, `server_port` |
| UUID | `users[].uuid` | `uuid` |
| Vision | `users[].flow` | `flow`; both use `xtls-rprx-vision` |
| REALITY key pair | `tls.reality.private_key` | `tls.reality.public_key` |
| Short ID | `tls.reality.short_id[]` | `tls.reality.short_id` |
| Handshake target hostname | `tls.reality.handshake.server`, `tls.server_name` | `tls.server_name` |

`server` identifies your VPS; `server_name` is the REALITY handshake target's hostname. This guide uses `portfolio.newschool.edu:443` as an example target. Before deploying, verify TLS 1.3 and certificate validation from the VPS, and choose a stable, reachable target:

```bash
openssl s_client -connect portfolio.newschool.edu:443 -servername portfolio.newschool.edu -tls1_3 -alpn h2 -verify_return_error </dev/null
```

Public websites can change. The local tests below do not establish that this public target is reachable from your server.

## Server configuration

Save this as `server.json`, or download [server.json](server.json). Refer to the [VLESS inbound](https://sing-box.sagernet.org/configuration/inbound/vless/) and [REALITY TLS fields](https://sing-box.sagernet.org/configuration/shared/tls/#reality-fields) for field definitions.

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

Allow incoming TCP 443 in both the host firewall and the cloud security group. The server also needs outgoing access to the handshake target and requested destinations. If another service already owns port 443, choose a different TCP port and update the client. XUDP carries UDP inside the VLESS TCP connection, so it does not require opening an additional incoming UDP 443 port.

`dns-local` resolves domain destinations on the server using its system DNS, which must work. Multiplex and Brutal tuning are omitted from this basic setup.

Check the configuration before starting in the foreground:

```bash
sing-box check -c server.json
sudo sing-box run -c server.json
```

After confirming it works, package installations can use systemd:

```bash
sudo install -o sing-box -m 600 server.json /etc/sing-box/config.json
sudo sing-box check -D /var/lib/sing-box -C /etc/sing-box
sudo systemctl enable --now sing-box
sudo systemctl restart sing-box
sudo systemctl status sing-box --no-pager
sudo journalctl -u sing-box --output cat -e
```

The [official 1.14.2 systemd unit](https://github.com/SagerNet/sing-box/blob/v1.14.2/release/config/sing-box.service) runs as the `sing-box` user, uses `/var/lib/sing-box` as its working directory, and loads configurations with `-C /etc/sing-box`. The permissions and check command above match it. Other JSON configurations in that directory are also loaded, so move old configurations or backup files elsewhere first. Stop the foreground process to release the listening port, and check new configurations before restarting a running service.

## Client: TUN and local proxy

Save this as `client.json`, or download [client.json](client.json). Private and local network destinations connect directly; other TCP / UDP traffic uses the proxy. Optional mainland China bypass rules are described separately below.

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

DNS and routing work together as follows:

- `dns-bootstrap` connects directly to `223.5.5.5` to resolve a proxy server hostname. The example uses a VPS IP, so no such lookup is needed for that connection. If using a hostname, choose a bootstrap resolver reachable from your location. Keeping bootstrap resolution outside `proxy` prevents a circular dependency.
- `dns-remote` sends normal application DNS queries to DoH through `proxy`. Using `1.1.1.1` avoids bootstrapping a DoH hostname. New DNS server types dial directly by default, so `detour: proxy` is explicit. See the [DoH documentation](https://sing-box.sagernet.org/configuration/dns/server/https/).
- The route `sniff` action precedes `hijack-dns`, which sends recognized ordinary DNS traffic to the internal resolver. `dns_mode: hijack` uses the 1.14 TUN DNS behavior. `dns_address` is unset so the core chooses the DNS address within the TUN subnet.
- `auto_detect_interface` binds outgoing connections to the default interface to prevent routing loops. On Windows, `strict_route` helps restrict ordinary DNS leakage across other interfaces. An application's own DoH / DoT is not automatically converted into an internal DNS query.

See the [TUN documentation](https://sing-box.sagernet.org/configuration/inbound/tun/) for platform behavior and [dial fields](https://sing-box.sagernet.org/configuration/shared/dial/) for resolvers. UDP 443 remains allowed, so QUIC can be proxied; actual behavior still depends on the application and network.

On Linux:

```bash
sing-box check -c client.json
sudo sing-box run -c client.json
```

The official documentation also recommends `auto_redirect` on Linux. Add `"auto_redirect": true` to the TUN inbound and ensure the required nftables / NFQueue kernel support is available. This option is Linux-specific and should not be added to the Windows configuration.

On Windows, use administrator PowerShell:

```powershell
.\sing-box.exe check -c .\client.json
.\sing-box.exe run -c .\client.json
```

### HTTP / SOCKS5 without TUN

Download [client-mixed.json](client-mixed.json), replace the same VPS, UUID and REALITY parameters, and run it. It removes only the TUN inbound, retaining the mixed inbound on `127.0.0.1:1080`. It needs no administrator privileges and does not change system routes.

```bash
sing-box check -c client-mixed.json
sing-box run -c client-mixed.json
```

Test from another terminal:

```bash
curl --noproxy "" --proxy socks5h://127.0.0.1:1080 https://example.com/
curl --noproxy "" --proxy http://127.0.0.1:1080 https://example.com/
```

Use `curl.exe` on Windows. `socks5h` delegates hostname resolution to the proxy instead of resolving locally in curl. The mixed inbound listens only on loopback, and applications must opt into using it.

## Optional mainland China bypass

Download the complete [client-cn.json](client-cn.json), replace the connection parameters, and use it instead of `client.json`. It preserves the original guide's intent to connect directly to mainland China destinations while using the 1.14 HTTP client format.

The added remote rule-sets are `geosite-cn` for domains and `geoip-cn` for destination IPs. Routing proceeds through sniffing, DNS hijacking, private-address bypass, Chinese-domain bypass, DNS resolution, then Chinese-IP bypass; remaining traffic uses the proxy. DNS rules reference only the domain rule-set, avoiding deprecated DNS address-filter semantics.

The rule-set download client is configured as:

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

Each rule-set references it, for example:

```json
{
  "type": "remote",
  "tag": "geosite-cn",
  "format": "binary",
  "url": "https://raw.githubusercontent.com/SagerNet/sing-geosite/rule-set/geosite-cn.srs",
  "http_client": "rules-download"
}
```

These are excerpts from the complete downloadable configuration, not standalone client configurations. See [rule-sets](https://sing-box.sagernet.org/configuration/rule-set/) and [HTTP Client](https://sing-box.sagernet.org/configuration/shared/http-client/).

`client-cn.json` resolves Chinese domains using DoH at `223.5.5.5`, with TLS `server_name` set to `dns.alidns.com`. The direct outbound explicitly uses that resolver too. Other application domains use the proxied DoH server. The `resolve` action lets connections addressed by hostname subsequently match IP rules; DNS routing alone does not select a connection's outbound.

The first startup downloads rule-sets from GitHub through the proxy. Confirm that the basic configuration connects before enabling bypass rules. `cache_file` persists rule-sets and needs a writable working directory. Classification is imperfect, and CDNs, DNS responses and the proxy exit location can affect routing.
