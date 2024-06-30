---
title: Get my Private sing-box Configuration
subtitle:
date: 2024-05-02T06:39:42-04:00
slug: get-my-proxy
draft: false
author:
  name: James
  link: https://www.jamesflare.com
  email:
  avatar: /site-logo.avif
description: My private sing-box configuration.
keywords:
license:
comment: true
weight: 0
tags:
  - sing-box
  - Proxy
  - Security
  - Networking
categories:
  - Proxy
hiddenFromHomePage: true
hiddenFromSearch: true
hiddenFromRss: true
hiddenFromRelated: true
summary: My private sing-box configuration.
resources:
  - name: featured-image
    src: featured-image.jpg
  - name: featured-image-preview
    src: featured-image-preview.jpg
toc: true
math: false
lightgallery: true
password: sing-box
message:
repost:
  enable: false
  url:

# See details front matter: https://fixit.lruihao.cn/documentation/content-management/introduction/#front-matter
---

<!--more-->

## Readme

This is my personal configuration. Obviously, exposing it to the public network is not a good choice. However, I don't think anyone will look into it in such detail. It's mainly for my own convenience in configuration. If you come across this file, please use it discreetly. Generally, I won't pay much attention to it.

## Sever Side

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

## Outbound Only

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

## Windows Client

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

## MacOS Client

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

## Android Client

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

## Commands

### Run sing-box Server

```bash
sudo curl -fsSL https://sing-box.app/gpg.key -o /etc/apt/keyrings/sagernet.asc
sudo chmod a+r /etc/apt/keyrings/sagernet.asc
echo "deb [arch=`dpkg --print-architecture` signed-by=/etc/apt/keyrings/sagernet.asc] https://deb.sagernet.org/ * *" | sudo tee /etc/apt/sources.list.d/sagernet.list > /dev/null
sudo apt update
sudo apt install sing-box
sudo systemctl enable sing-box

sudo systemctl stop sing-box
sudo mv /etc/sing-box/config.json /etc/sing-box/config.json.back
sudo wget -c https://www.jamesflare.com/en/get-my-proxy/server.json -O /etc/sing-box/config.json
sudo systemctl start sing-box
```

### Run sing-box Windows Client

Download [client-windows.json](client-windows.json)

Run the client

```bash
sing-box run -c client-windows.json
```

For WSL2

```bash
export ALL_PROXY=http://JamesFlare-NY-B.mshome.net:1080
```

Change the host to your own value which is the first hop of your route in WSL2. You can test it by

```bash
mtr jamesflare.com
```

### Run sing-box MacOS Client

```bash
brew install sing-box
wget -c https://www.jamesflare.com/en/get-my-proxy/client-macos.json -O ~/sing-box/config.json

sudo sing-box run -c ~/sing-box/config.json
```

### Run sing-box Android Client

Remote: https://www.jamesflare.com/en/get-my-proxy/client-android.json

Import: [sing-box://import-remote-profile](sing-box://import-remote-profile?url=https%3A%2F%2Fwww.jamesflare.com%2Fen%2Fget-my-proxy%2Fclient-android.json#DMIT)

{{< image src="sing-box-qr-code.png" width="240px" caption="sing-box QR Code" >}}

## Tools

### ip.skk.moe

<iframe src="https://ip.skk.moe/simple" style="width: 100%; border: 0"></iframe>
<iframe src="https://ip.skk.moe/simple-dark" style="width: 100%; border: 0"></iframe>