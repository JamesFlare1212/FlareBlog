---
title: 获取我的私人配置文件
subtitle:
date: 2024-05-02T06:39:42-04:00
slug: get-my-proxy
draft: false
author:
  name: James
  link: https://www.jamesflare.com
  email:
  avatar: /site-logo.avif
description: 我sing-box的私人配置文件
keywords:
license:
comment: true
weight: 0
tags:
  - sing-box
  - 代理
  - 安全
  - 网络
categories:
  - 代理
hiddenFromHomePage: true
hiddenFromSearch: true
hiddenFromRss: true
hiddenFromRelated: true
summary:
resources:
  - name: featured-image
    src: featured-image.jpg
  - name: featured-image-preview
    src: featured-image-preview.jpg
toc: true
math: false
lightgallery: false
password: sing-box
message:
repost:
  enable: false
  url:

# See details front matter: https://fixit.lruihao.cn/documentation/content-management/introduction/#front-matter
---

<!--more-->

## Readme

这是我自用的配置，显然将它暴露在公网上不是一个好选择，不过应该也没人找得这么细吧，主要也是方便我自己配置。如果你翻到了这个文件，请低调使用，一般情况下我也不会去管。

## 服务端

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
                    "name": "james",
                    "uuid": "9337d5ec-b489-4bf4-a22c-19f7f6e8fbbd",
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
                    "private_key": "ePmluduoJRUXUEzKOgH8cCyPGB8tApDdytwDP-9SNnY",
                    "short_id": [
                        "7fcff4362963e98e"
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

## Outbound部分

```json
{
    "type": "vless",
    "tag": "proxy",
    "server": "154.17.5.35",
    "server_port": 443,
    "uuid": "9337d5ec-b489-4bf4-a22c-19f7f6e8fbbd",
    "flow": "xtls-rprx-vision",
    "tls": {
        "enabled": true,
        "server_name": "portfolio.newschool.edu",
        "utls": {
            "enabled": true,
            "fingerprint": "chrome"
        },
        "reality": {
            "enabled": true,
            "public_key": "dpU-LTUuyoCyox_4fh5n-h5NCsSSUKXayFsOsfcIzRA",
            "short_id": "7fcff4362963e98e"
        }
    },
    "multiplex": {
        "enabled": false,
        "protocol": "h2mux",
        "max_streams": 32,
        "padding": true,
        "brutal": {
            "enabled": false,
            "up_mbps": 1000,
            "down_mbps": 100
        }

    },
    "packet_encoding": "xudp"
}
```

## Windows 客户端

```json
{
    "log": {
        "level": "info",
        "timestamp": true
    },
    "dns": {
        "servers": [
            {
                "tag": "dns_proxy",
                "address": "https://1.1.1.1/dns-query",
                "address_resolver": "dns_resolver",
                "strategy": "prefer_ipv6",
                "detour": "proxy"
            },
            {
                "tag": "dns_direct",
                "address": "https://dns.alidns.com/dns-query",
                "address_resolver": "dns_resolver",
                "strategy": "prefer_ipv6",
                "detour": "direct"
            },
            {
                "tag": "dns_resolver",
                "address": "223.5.5.5",
                "detour": "direct"
            }
        ],
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
        "final": "dns_proxy"
    },
    "route": {
        "rule_set": [
            {
                "tag": "geosite-geolocation-!cn",
                "type": "remote",
                "format": "binary",
                "url": "https://raw.githubusercontent.com/SagerNet/sing-geosite/rule-set/geosite-geolocation-!cn.srs",
                "download_detour": "proxy"
            },
            {
                "tag": "geoip-cn",
                "type": "remote",
                "format": "binary",
                "url": "https://raw.githubusercontent.com/SagerNet/sing-geoip/rule-set/geoip-cn.srs",
                "download_detour": "proxy"
            },
            {
                "tag": "geosite-cn",
                "type": "remote",
                "format": "binary",
                "url": "https://raw.githubusercontent.com/SagerNet/sing-geosite/rule-set/geosite-cn.srs",
                "download_detour": "proxy"
            }
        ],
        "rules": [
            {
                "protocol": "dns",
                "outbound": "dns-out"
            },
            {
                "port": 853,
                "network": "tcp",
                "outbound": "block"
            },
            {
                "port": [
                    443,
                    853
                ],
                "network": "udp",
                "outbound": "block"
            },
            {
                "type": "logical",
                "mode": "and",
                "rules": [
                    {
                        "rule_set": "geoip-cn",
                        "invert": true
                    },
                    {
                        "rule_set": "geosite-geolocation-!cn"
                    }
                ],
                "outbound": "proxy"
            },
            {
                "type": "logical",
                "mode": "and",
                "rules": [
                    {
                        "rule_set": "geoip-cn"
                    },
                    {
                        "rule_set": "geosite-cn"
                    }
                ],
                "outbound": "direct"
            },
            {
                "rule_set": "geoip-cn",
                "outbound": "direct"
            },
            {
                "ip_is_private": true,
                "outbound": "direct"
            }
        ],
        "final": "proxy",
        "auto_detect_interface": true
    },
    "inbounds": [
        {
            "type": "tun",
            "tag": "tun-in",
            "interface_name": "tun0",
            "inet4_address": "172.19.0.1/30",
            "inet6_address": "fdfe:dcba:9876::1/126",
            "mtu": 9000,
            "auto_route": true,
            "strict_route": true,
            "stack": "mixed",
            "sniff": true
        },
        {
            "type": "mixed",
            "tag": "mixed-in",
            "listen": "::",
            "listen_port": 1080,
            "tcp_fast_open": true,
            "tcp_multi_path": true,
            "udp_fragment": true,
            "udp_timeout": "5m",
            "sniff": false,
            "sniff_override_destination": false,
            "sniff_timeout": "300ms",
            "domain_strategy": "prefer_ipv6",
            "udp_disable_domain_unmapping": false,
            "set_system_proxy": false
        }
    ],
    "outbounds": [
        {
            "type": "vless",
            "tag": "proxy",
            "server": "154.17.5.35",
            "server_port": 443,
            "uuid": "9337d5ec-b489-4bf4-a22c-19f7f6e8fbbd",
            "flow": "xtls-rprx-vision",
            "tls": {
                "enabled": true,
                "server_name": "portfolio.newschool.edu",
                "utls": {
                    "enabled": true,
                    "fingerprint": "chrome"
                },
                "reality": {
                    "enabled": true,
                    "public_key": "dpU-LTUuyoCyox_4fh5n-h5NCsSSUKXayFsOsfcIzRA",
                    "short_id": "7fcff4362963e98e"
                }
            },
            "multiplex": {
                "enabled": false,
                "protocol": "h2mux",
                "max_streams": 32,
                "padding": true,
                "brutal": {
                    "enabled": false,
                    "up_mbps": 1000,
                    "down_mbps": 100
                }
        
            },
            "packet_encoding": "xudp"
        },
        {
            "type": "direct",
            "tag": "direct"
        },
        {
            "type": "block",
            "tag": "block"
        },
        {
            "type": "dns",
            "tag": "dns-out"
        }
    ],
    "experimental": {
        "cache_file": {
            "enabled": true,
            "path": "cache.db"
        }
    }
}
```

## MacOS 客户端

```json
{
    "log": {
        "level": "info",
        "timestamp": true
    },
    "dns": {
        "servers": [
            {
                "tag": "dns_proxy",
                "address": "https://1.1.1.1/dns-query",
                "address_resolver": "dns_resolver",
                "strategy": "prefer_ipv6",
                "detour": "proxy"
            },
            {
                "tag": "dns_direct",
                "address": "https://dns.alidns.com/dns-query",
                "address_resolver": "dns_resolver",
                "strategy": "prefer_ipv6",
                "detour": "direct"
            },
            {
                "tag": "dns_resolver",
                "address": "223.5.5.5",
                "detour": "direct"
            }
        ],
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
        "final": "dns_proxy"
    },
    "route": {
        "rule_set": [
            {
                "tag": "geosite-geolocation-!cn",
                "type": "remote",
                "format": "binary",
                "url": "https://raw.githubusercontent.com/SagerNet/sing-geosite/rule-set/geosite-geolocation-!cn.srs",
                "download_detour": "proxy"
            },
            {
                "tag": "geoip-cn",
                "type": "remote",
                "format": "binary",
                "url": "https://raw.githubusercontent.com/SagerNet/sing-geoip/rule-set/geoip-cn.srs",
                "download_detour": "proxy"
            },
            {
                "tag": "geosite-cn",
                "type": "remote",
                "format": "binary",
                "url": "https://raw.githubusercontent.com/SagerNet/sing-geosite/rule-set/geosite-cn.srs",
                "download_detour": "proxy"
            }
        ],
        "rules": [
            {
                "protocol": "dns",
                "outbound": "dns-out"
            },
            {
                "port": 853,
                "network": "tcp",
                "outbound": "block"
            },
            {
                "port": [
                    443,
                    853
                ],
                "network": "udp",
                "outbound": "block"
            },
            {
                "type": "logical",
                "mode": "and",
                "rules": [
                    {
                        "rule_set": "geoip-cn",
                        "invert": true
                    },
                    {
                        "rule_set": "geosite-geolocation-!cn"
                    }
                ],
                "outbound": "proxy"
            },
            {
                "type": "logical",
                "mode": "and",
                "rules": [
                    {
                        "rule_set": "geoip-cn"
                    },
                    {
                        "rule_set": "geosite-cn"
                    }
                ],
                "outbound": "direct"
            },
            {
                "rule_set": "geoip-cn",
                "outbound": "direct"
            },
            {
                "ip_is_private": true,
                "outbound": "direct"
            }
        ],
        "final": "proxy",
        "auto_detect_interface": true
    },
    "inbounds": [
        {
            "type": "tun",
            "tag": "tun-in",
            "interface_name": "utun42",
            "inet4_address": "172.19.0.1/30",
            "inet6_address": "fdfe:dcba:9876::1/126",
            "mtu": 9000,
            "auto_route": true,
            "strict_route": true,
            "stack": "mixed",
            "sniff": true
        }
    ],
    "outbounds": [
        {
            "type": "vless",
            "tag": "proxy",
            "server": "154.17.5.35",
            "server_port": 443,
            "uuid": "9337d5ec-b489-4bf4-a22c-19f7f6e8fbbd",
            "flow": "xtls-rprx-vision",
            "tls": {
                "enabled": true,
                "server_name": "portfolio.newschool.edu",
                "utls": {
                    "enabled": true,
                    "fingerprint": "chrome"
                },
                "reality": {
                    "enabled": true,
                    "public_key": "dpU-LTUuyoCyox_4fh5n-h5NCsSSUKXayFsOsfcIzRA",
                    "short_id": "7fcff4362963e98e"
                }
            },
            "multiplex": {
                "enabled": false,
                "protocol": "h2mux",
                "max_streams": 32,
                "padding": true,
                "brutal": {
                    "enabled": false,
                    "up_mbps": 1000,
                    "down_mbps": 100
                }
        
            },
            "packet_encoding": "xudp"
        },
        {
            "type": "direct",
            "tag": "direct"
        },
        {
            "type": "block",
            "tag": "block"
        },
        {
            "type": "dns",
            "tag": "dns-out"
        }
    ],
    "experimental": {
        "cache_file": {
            "enabled": true,
            "path": "cache.db"
        }
    }
}
```

## Android 客户端

```json
{
    "log": {
        "level": "info",
        "timestamp": true
    },
    "dns": {
        "servers": [
            {
                "tag": "dns_proxy",
                "address": "https://1.1.1.1/dns-query",
                "address_resolver": "dns_resolver",
                "strategy": "prefer_ipv6",
                "detour": "proxy"
            },
            {
                "tag": "dns_direct",
                "address": "https://dns.alidns.com/dns-query",
                "address_resolver": "dns_resolver",
                "strategy": "prefer_ipv6",
                "detour": "direct"
            },
            {
                "tag": "dns_resolver",
                "address": "223.5.5.5",
                "detour": "direct"
            }
        ],
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
        "final": "dns_proxy"
    },
    "route": {
        "rule_set": [
            {
                "tag": "geosite-geolocation-!cn",
                "type": "remote",
                "format": "binary",
                "url": "https://raw.githubusercontent.com/SagerNet/sing-geosite/rule-set/geosite-geolocation-!cn.srs",
                "download_detour": "proxy"
            },
            {
                "tag": "geoip-cn",
                "type": "remote",
                "format": "binary",
                "url": "https://raw.githubusercontent.com/SagerNet/sing-geoip/rule-set/geoip-cn.srs",
                "download_detour": "proxy"
            },
            {
                "tag": "geosite-cn",
                "type": "remote",
                "format": "binary",
                "url": "https://raw.githubusercontent.com/SagerNet/sing-geosite/rule-set/geosite-cn.srs",
                "download_detour": "proxy"
            }
        ],
        "rules": [
            {
                "protocol": "dns",
                "outbound": "dns-out"
            },
            {
                "port": 853,
                "network": "tcp",
                "outbound": "block"
            },
            {
                "port": [
                    443,
                    853
                ],
                "network": "udp",
                "outbound": "block"
            },
            {
                "type": "logical",
                "mode": "and",
                "rules": [
                    {
                        "rule_set": "geoip-cn",
                        "invert": true
                    },
                    {
                        "rule_set": "geosite-geolocation-!cn"
                    }
                ],
                "outbound": "proxy"
            },
            {
                "type": "logical",
                "mode": "and",
                "rules": [
                    {
                        "rule_set": "geoip-cn"
                    },
                    {
                        "rule_set": "geosite-cn"
                    }
                ],
                "outbound": "direct"
            },
            {
                "rule_set": "geoip-cn",
                "outbound": "direct"
            },
            {
                "ip_is_private": true,
                "outbound": "direct"
            }
        ],
        "final": "proxy",
        "auto_detect_interface": true
    },
    "inbounds": [
        {
            "type": "tun",
            "tag": "tun-in",
            "interface_name": "tun0",
            "inet4_address": "172.19.0.1/30",
            "inet6_address": "fdfe:dcba:9876::1/126",
            "mtu": 9000,
            "auto_route": true,
            "strict_route": true,
            "stack": "mixed",
            "sniff": true
        }
    ],
    "outbounds": [
        {
            "type": "vless",
            "tag": "proxy",
            "server": "154.17.5.35",
            "server_port": 443,
            "uuid": "9337d5ec-b489-4bf4-a22c-19f7f6e8fbbd",
            "flow": "xtls-rprx-vision",
            "tls": {
                "enabled": true,
                "server_name": "portfolio.newschool.edu",
                "utls": {
                    "enabled": true,
                    "fingerprint": "chrome"
                },
                "reality": {
                    "enabled": true,
                    "public_key": "dpU-LTUuyoCyox_4fh5n-h5NCsSSUKXayFsOsfcIzRA",
                    "short_id": "7fcff4362963e98e"
                }
            },
            "multiplex": {
                "enabled": false,
                "protocol": "h2mux",
                "max_streams": 32,
                "padding": true,
                "brutal": {
                    "enabled": false,
                    "up_mbps": 1000,
                    "down_mbps": 100
                }
        
            },
            "packet_encoding": "xudp"
        },
        {
            "type": "direct",
            "tag": "direct"
        },
        {
            "type": "block",
            "tag": "block"
        },
        {
            "type": "dns",
            "tag": "dns-out"
        }
    ],
    "experimental": {
        "cache_file": {
            "enabled": true,
            "path": "cache.db"
        }
    }
}
```

## 命令行

### 配置 sing-box 服务端

```bash
sudo curl -fsSL https://sing-box.app/gpg.key -o /etc/apt/keyrings/sagernet.asc
sudo chmod a+r /etc/apt/keyrings/sagernet.asc
echo "deb [arch=`dpkg --print-architecture` signed-by=/etc/apt/keyrings/sagernet.asc] https://deb.sagernet.org/ * *" | sudo tee /etc/apt/sources.list.d/sagernet.list > /dev/null
sudo apt update
sudo apt install sing-box
sudo systemctl enable sing-box

sudo systemctl stop sing-box
sudo mv /etc/sing-box/config.json /etc/sing-box/config.json.back
sudo wget -c https://www.jamesflare.com/zh-cn/get-my-proxy/server.json -O /etc/sing-box/config.json
sudo systemctl start sing-box
```

### 配置 sing-box Windows 客户端

下载 [client-windows.json](client-windows.json)

运行客户端

```bash
sing-box run -c client-windows.json
```

对于 WSL2

```bash
export ALL_PROXY=http://JamesFlare-NY-B.mshome.net:1080
```

把Host名改成你自己的，通常是路由的第一跳，可以这样测试一下

```bash
mtr jamesflare.com
```

### 配置 sing-box MacOS 客户端

```bash
brew install sing-box
wget -c https://www.jamesflare.com/zh-cn/get-my-proxy/client-macos.json -O ~/sing-box/config.json

sing-box run -c ~/sing-box/config.json
```

### 配置 sing-box Android 客户端

Remote: https://www.jamesflare.com/zh-cn/get-my-proxy/client-android.json

Import: [sing-box://import-remote-profile](sing-box://import-remote-profile?url=https%3A%2F%2Fwww.jamesflare.com%2Fzh-cn%2Fget-my-proxy%2Fclient-android.json#DMIT)

{{< image src="sing-box-qr-code.png" width="240px" caption="sing-box QR Code" >}}

## 工具

### ip.skk.moe

<iframe src="https://ip.skk.moe/simple" style="width: 100%; border: 0"></iframe>
<iframe src="https://ip.skk.moe/simple-dark" style="width: 100%; border: 0"></iframe>