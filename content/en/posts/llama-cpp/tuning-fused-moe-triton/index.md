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
description: This blog post explains how to resolve GPU memory overflow issues in SGLang on RTX 4090 by tuning Fused MoE Triton configurations, optimizing performance for MoE models.
keywords: ["SGLang", "Fused MoE Triton", "GPU memory", "RTX 4090", "tuning script", "MoE models"]
license:
comment: true
weight: 0
tags:
  - LLM
  - SGLang
  - Qwen3
categories:
  - LLM
  - Tutorials
collections:
  - LLM
hiddenFromHomePage: false
hiddenFromSearch: false
hiddenFromRss: false
hiddenFromRelated: false
summary: This blog post explains how to resolve GPU memory overflow issues in SGLang on RTX 4090 by tuning Fused MoE Triton configurations, optimizing performance for MoE models.
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

## What's going on?

SGLang defaults to using a configuration of `128 × 128 tile, num_stages = 4`. A quick calculation shows how much GPU memory it requires.

$$128 \times 128 \times ( \text{bf16} = 2 \; \text{bytes} ) \times 4 \; \text{stages} = 147 456 \; \text{bytes}$$

This exceeds the cache size of the RTX 4090, so it throws an error.

```console
OutOfResources: shared memory, Required: 147456, Hardware limit: 101376
```

## Why do we need to consider cache size?

Fused MoE Triton is an inference optimization technique for Mixture of Experts (MoE) models, combining the Triton framework (a tool developed by NVIDIA for efficient GPU computing) and the core idea of Fused MoE, aiming to improve the performance of MoE models during inference.

In traditional MoE inference, each expert's computation needs to be scheduled separately, leading to high scheduling overhead and memory access fragmentation. The optimization idea of Fused MoE is to fuse multiple expert computations (such as matrix multiplications) into a single unified kernel, reduce the splitting of the computation graph, and improve hardware utilization. For example:

- Group GEMM: Merge the FFN (feed-forward network) weights of different experts into a single GEMM operation, avoiding redundant computation.
- Memory access optimization: Improve efficiency by pre-allocating shared memory and reducing data movement.

This has been well implemented in SGLang. However, it seems that SGLang focuses more on high-end hardware like H100, and hasn't considered consumer-grade GPUs like the RTX 4090.

## How to fix it?

The simplest way is to adjust the `num_stages` value so that it doesn't exceed the memory limit. However, this is too rough and may negatively affect performance.

### Using tuning_fused_moe_triton.py

SGLang provides a tool that we can run to fine-tune the optimal Fused MoE Triton configuration. According to my practice, the `tuning_fused_moe_triton.py` script is not included in the SGLang installed via pip. I recommend installing it from the source code.

```bash
# For example, version v0.4.9
git clone -b v0.4.9 https://github.com/sgl-project/sglang.git
cd sglang

pip install --upgrade pip
pip install -e "python[all]"
```

The script is located at `benchmark/kernels/fused_moe_triton/tuning_fused_moe_triton.py`, so you can run it with a command like the following:

```bash
cd benchmark/kernels/fused_moe_triton
python tuning_fused_moe_triton.py \
--model /home/james/models/Qwen3-30B-A3B-FP8-dynamic \
--tp-size 1 \
--dtype fp8_w8a8 \
--tune
```

- `--model` is followed by the path to the model you want to optimize. I use the local `Qwen3-30B-A3B-FP8-dynamic` as an example.
- `--tp-size` is the number of tensor parallelism, and here I use a single GPU, so the value is 1.
- `--dtype` is the data type you want to optimize. Yes, the tuning configuration for fp16 and fp8 is different. Even for the same model, if you tune for fp16 but run with fp8, the configuration will not take effect, and the error `OutOfResources: shared memory` will still occur.

This step is extremely time-consuming and may take 3–4 hours. After completion, a configuration file similar to `E=128,N=768,device_name=NVIDIA_GeForce_RTX_4090,dtype=fp8_w8a8.json` will be generated in the same location.

### Placing the configuration file

Place it in the directory where Fused MoE Triton configuration files are stored. Normally, it should be in `python/sglang/srt/layers/moe/fused_moe_triton/configs`. There are different versions of the Triton directory, and you can usually place it in the latest one. I use `triton_3_3_1` as an example.

The correct location is similar to:

```console
/home/james/sglang/python/sglang/srt/layers/moe/fused_moe_triton/configs/triton_3_3_1/E=128,N=768,device_name=NVIDIA_GeForce_RTX_4090,dtype=fp8_w8a8.json
```

### Start the service

After that, we can start the SGLang service and see if it works normally. If everything goes well, the error should be resolved, and the throughput should also improve.

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

## Common Issues

### Does tuning improve performance?

Yes, it can improve the throughput of MoE models by up to 30%.

### Is the optimization effective for all models?

No. Theoretically, it only works for MoE models, and has no effect on dense models.
