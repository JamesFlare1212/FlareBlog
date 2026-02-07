---
title: "修复在 RTX 4090 上使用 SGLang 运行 Qwen3 MoE 时的 OutOfResources: shared memory 错误"
subtitle:
date: 2025-07-07T11:10:02-04:00
lastmod: 2025-07-07T11:10:02-04:00
slug: tuning-fused-moe-triton
draft: false
author:
  name: James
  link: https://www.jamesflare.com
  email:
  avatar: /site-logo.avif
description: 这篇博客文章解释了如何通过调整SGLang在RTX 4090上的融合专家混合（MoE）Triton配置来解决GPU内存溢出问题，并优化专家混合（MoE）模型的性能。
keywords: ["SGLang", "Fused MoE Triton", "GPU memory", "RTX 4090", "tuning script", "MoE models"]
license:
comment: true
weight: 0
tags:
  - 大语言模型
  - SGLang
  - Qwen3
categories:
  - 大语言模型
  - 教程
collections:
  - LLM
hiddenFromHomePage: false
hiddenFromSearch: false
hiddenFromRss: false
hiddenFromRelated: false
summary: 这篇博客文章解释了如何通过调整SGLang在RTX 4090上的融合专家混合（MoE）Triton配置来解决GPU内存溢出问题，并优化专家混合（MoE）模型的性能。
resources:
  - name: featured-image
    src: featured-image.jpg
  - name: featured-image-preview
    src: featured-image-preview.jpg
toc: true
math: true
lightgallery: false
password:
message:
repost:
  enable: false
  url:

# See details front matter: https://fixit.lruihao.cn/documentation/content-management/introduction/#front-matter
---

<!--more-->

## 怎么回事？

SGLang默认会用这样的一个配置`128 × 128 tile, num_stages = 4`。稍微计算一下就可以得到它需要占用的GPU缓存大小

$$128 \times 128 \times ( \text{bf16} = 2 \; \text{bytes} ) \times 4 \; \text{stages} = 147 456 \; \text{bytes}$$

这超出了RTX 4090的缓存大小，所以就报错了。

```console
OutOfResources: shared memory, Required: 147456, Hardware limit: 101376
```

## 为什么需要考虑缓存大小？

Fused MoE Triton 是一种针对混合专家模型（Mixture of Experts, MoE） 的推理优化技术，结合了 Triton 框架（由 NVIDIA 开发的用于高效 GPU 计算的工具）和 Fused MoE 的核心思想，旨在提升 MoE 模型在推理阶段的性能。

传统 MoE 推理中，每个专家的计算需要独立调度，存在较高的调度开销和内存访问碎片化问题。Fused MoE 的优化思路是将多个专家的计算操作（如矩阵乘法）融合为一个统一的内核（Kernel），减少计算图的拆分，提升硬件利用率。例如：

- Group GEMM：将不同专家的 FFN（前馈网络）权重合并为一个 GEMM（矩阵乘法）操作，避免重复计算
- 内存访问优化：通过预分配共享内存、减少数据搬运等技术提升效率

这一点在SGLang中得到了良好的实现。不过SGLang的重心似乎在H100这样的高级硬件上，没对RTX 4090这样的消费级GPU考虑。

## 如何修复？

最简单的办法就是修改`num_stages`的大小，那它调到不爆内存的程度就行了。不过这样太粗糙，而且可能对性能产生负面影响。

### 使用tuning_fused_moe_triton.py

SGLang给我们提供了一个工具，我们可以运行它来微调最佳的Fused MoE Triton配置。根据我的实践，直接用pip安装的SGLang没有`tuning_fused_moe_triton.py`这个脚本，我建议从源码安装。

```bash
# 以v0.4.9版本为例
git clone -b v0.4.9 https://github.com/sgl-project/sglang.git
cd sglang

pip install --upgrade pip
pip install -e "python[all]"
```

脚本就位于`benchmark/kernels/fused_moe_triton/tuning_fused_moe_triton.py`，所以执行类似的命令即可

```bash
cd benchmark/kernels/fused_moe_triton
python tuning_fused_moe_triton.py \
--model /home/james/models/Qwen3-30B-A3B-FP8-dynamic \
--tp-size 1 \
--dtype fp8_w8a8 \
--tune
```

- `--model`后面跟你希望优调的模型地址，我这里以本地的Qwen3-30B-A3B-FP8-dynamic为例
- `--tp-size`则是张量并行的数量，这里我就单块GPU，所以数量就是1
- `--dtype`则是你希望调优的数据类型，是的，fp16和fp8的调优配置是不一样的。即便是同一个模型，如果你调优的是fp16，而你运行的是fp8，这时候配置不会生效，依旧会报错OutOfResources: shared memory

这一步极其耗时，可能会消耗3-4小时。完成后会在原地生成一个类似`E=128,N=768,device_name=NVIDIA_GeForce_RTX_4090,dtype=fp8_w8a8.json`的配置文件。

### 放置配置文件

把它放入Fused MoE Triton配置文件的地方，不出意外的话会在`python/sglang/srt/layers/moe/fused_moe_triton/configs`下，里面有不同版本的triton目录，一般放最新的那个即可。我以triton_3_3_1为例。

正确的位置类似于

```console
/home/james/sglang/python/sglang/srt/layers/moe/fused_moe_triton/configs/triton_3_3_1/E=128,N=768,device_name=NVIDIA_GeForce_RTX_4090,dtype=fp8_w8a8.json
```

### 启动服务

之后我们就可以启动SGLang服务看看正常没有，不出意外的话不仅故障消除了，吞吐量也会有所提升。

```bash {data-open=true}
python -m sglang.launch_server \
--model-path ~/models/Qwen3-30B-A3B-FP8-dynamic \
--served-model-name Qwen3 \
--reasoning-parser qwen3 \
--tool-call-parser qwen25 \
--context-length 131072 \
--max-prefill-tokens 131072 \
--chunked-prefill-size 2048 \
--max-running-requests 64 \
--mem-fraction-static 0.75 \
--kv-cache-dtype fp8_e4m3 \
--dtype auto \
--load-format auto
```

## 常见问题

### tuning后对性能有提升吗？

有的，对MoE模型的吞吐量提升最高可达30%

### 优化对所有模型都有效吗？

不是的，理论上只对MoE模型有效，稠密模型完全不起作用。
