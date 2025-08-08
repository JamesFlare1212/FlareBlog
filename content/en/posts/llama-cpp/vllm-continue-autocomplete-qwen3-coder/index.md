---
title: Running Qwen3-Coder with vLLM and configuring VSCode to use Continue for code completion
subtitle:
date: 2025-08-05T22:47:46-04:00
lastmod: 2025-08-05T22:47:46-04:00
slug: vllm-continue-autocomplete-qwen3-coder
draft: false
author:
  name: James
  link: https://www.jamesflare.com
  email:
  avatar: /site-logo.avif
description: This tutorial will guide you step-by-step on how to deploy Qwen3-Coder-30B-A3B-Instruct-FP8 using vLLM on consumer-grade GPUs, and configure Continue to achieve a unified Chatbot, Agent, and FIM code completion functionality.
keywords: ["vLLM", "Continue", "Qwen3 Coder", "VSCode", "autocomplete"]
license:
comment: true
weight: 0
tags:
  - LLM
  - vLLM
  - VSCode
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
summary: This tutorial will guide you step-by-step on how to deploy Qwen3-Coder-30B-A3B-Instruct-FP8 using vLLM on consumer-grade GPUs, and configure Continue to achieve a unified Chatbot, Agent, and FIM code completion functionality.
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

## Getting Started

The launch of Qwen3-Coder delivers a remarkably capable programming model, with the added bonus of a lightweight variant—Qwen3-Coder-Flash ([Qwen3-Coder-30B-A3B-Instruct-FP8](https://huggingface.co/Qwen/Qwen3-Coder-30B-A3B-Instruct-FP8))—designed to run on consumer-grade hardware.

Notably, it retains FIM (Fill-in-the-Middle) support like its predecessor Qwen2.5-Coder while adding tool calling capabilities, enabling a single model to function as a chatbot, AI agent, and code completion tool.

## Deploying with vLLM

My decision to use vLLM for deploying Qwen3-Coder-30B-A3B-Instruct-FP8—rather than Ollama—was primarily driven by performance. As for why I didn't opt for SGLang? At the time of writing, SGLang still had unresolved tool calling issues with this model.

Installation steps are omitted here (refer to the official [vLLM docs](https://docs.vllm.ai/en/latest/getting_started/installation/index.html)). On my RTX 4090 (48GB VRAM), the model handles ~256K FP8 contexts at 90% VRAM utilization.

For conservative operation, I configured 200K context length at 85% VRAM usage. Adjust `--gpu-memory-utilization` and `--max-model-len` for longer contexts while tuning `--max-num-batched-tokens` accordingly.

```bash {data-open=true}
VLLM_ATTENTION_BACKEND=FLASHINFER \
vllm serve ~/models/Qwen3-Coder-30B-A3B-Instruct-FP8 \
--served-model-name qwen3-coder-flash \
--enable-auto-tool-choice \
--tool-call-parser qwen3_coder \
--max-model-len 200K \
--max-seq-len-to-capture 200000 \
--max-num-batched-tokens 16K \
--max-num-seqs 64 \
--model-impl auto \
--gpu-memory-utilization 0.85 \
--kv-cache-dtype fp8_e4m3 \
--dtype auto \
--load-format auto \
--api-key sk-pvKXxjh8b9mJXfEe1fF979F65c9548BdAcCb85C7Cf8242B7 \
--port 30000 --host 0.0.0.0
```

Key parameters:
- Model path: `~/models/Qwen3-Coder-30B-A3B-Instruct-FP8`
- Native 256K context support (extendable to 1M with YaRN)
- FP8 KV Cache quantization (`fp8_e4m3`) reduces VRAM footprint
- `--max-seq-len-to-capture` matches context length for optimal CUDA graph performance

## Continue Configuration

Update Continue's config as follows:

```yaml {data-open=true}
name: my-configuration
version: 0.0.1
schema: v1
models:
  - name: Qwen3
    provider: openai
    model: qwen3-coder-flash
    apiBase: https://localhost:30000/v1
    apiKey: sk-xxxx
    defaultCompletionOptions:
      contextLength: 128000
      temperature: 0.6
      maxTokens: 1024
    roles:
      - chat
      - edit
      - autocomplete
      - apply
    capabilities:
        - tool_use
    promptTemplates: 
      autocomplete: |
        `<|im_start|>system
        You are a code completion assistant.<|im_end|>
        <|im_start|>user
        <|fim_prefix|>{{{prefix}}}<|fim_suffix|>{{{suffix}}}<|fim_middle|><|im_end|>
        <|im_start|>assistant
        `
```

The autocomplete prompt template required special attention. Initially using Qwen2.5-Coder's template yielded poor results. The correct approach involves wrapping the FIM tokens in a chat completion format:

```python {data-open=true}
# Correct message format for /v1/chat/completions
messages = [
    {"role": "system", "content": "You are a code completion assistant."},
    {"role": "user", "content": "<|fim_prefix|>...<|fim_middle|>"}
]
```

Since Continue sends templates directly to `/v1/completions` (suitable for base models), we manually adapted the chat template for our instruct-tuned model:

```jinja
<|im_start|>system
You are a code completion assistant.<|im_end|>
<|im_start|>user
<|fim_prefix|>{{{prefix}}}<|fim_suffix|>{{{suffix}}}<|fim_middle|><|im_end|>
<|im_start|>assistant
```

This implementation demonstrates excellent performance in practice.
