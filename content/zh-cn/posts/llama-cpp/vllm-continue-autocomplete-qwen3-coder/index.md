---
title: 使用vLLM运行Qwen3-Coder并且配置VSCode使用Continue进行代码补全
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
description: 本教程手把手教你用vLLM在消费级显卡上部署Qwen3-Coder-30B-A3B-Instruct-FP8，并配置Continue实现Chatbot、Agent与FIM代码补全三合一。
keywords: ["vLLM", "Continue", "Qwen3 Coder", "VSCode"]
license:
comment: true
weight: 0
tags:
  - 大语言模型
  - vLLM
  - VSCode
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
summary: 本教程手把手教你用vLLM在消费级显卡上部署Qwen3-Coder-30B-A3B-Instruct-FP8，并配置Continue实现Chatbot、Agent与FIM代码补全三合一。
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

## 开始之前

Qwen3-Coder的发布带给我们带来了一个极强的编程模型，难能可贵的是它还提供了一个足够轻量的Qwen3-Coder-Flash版本，也就是[Qwen3-Coder-30B-A3B-Instruct-FP8](https://huggingface.co/Qwen/Qwen3-Coder-30B-A3B-Instruct-FP8)，它能在一般消费级硬件上部署。

更值得高兴的是它除了支持工具调用外还像Qwen2.5-Coder一样，继续支持FIM，这意味单个模型可以完成从Chatbot，Agent到代码补全的全部功能。

## 启动vLLM

我最终选择使用vLLM部署Qwen3-Coder-30B-A3B-Instruct-FP8而不是Ollama很大程度上是出于性能的考量。你问我为什么不用SGLang？那是因为截止我写稿时，SGLang在Qwen3-Coder-30B-A3B-Instruct-FP8上的工具调用还是有点问题我没搞定。

安装过程我这里省略，可以参考官方的[文档](https://docs.vllm.ai/en/latest/getting_started/installation/index.html)。以我的设备，单张RTX 4090 48G为例。它在使用90%显存运行Qwen3-Coder-30B-A3B-Instruct-FP8的时候可以处理差不多256K长，FP8类型的上下文。

我这里保守一点就设置成200K上下文，85%显存占用，如果需要更长的上下文可以增加`--gpu-memory-utilization`和`--max-model-len`，同时适当减少`--max-num-batched-tokens`。

```bash
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

其中，

- `~/models/Qwen3-Coder-30B-A3B-Instruct-FP8`是模型的路径
- `--max-model-len 128K`以及`--max-num-batched-tokens 128K`是我设置的上下文长度，对Qwen3-Coder-Flash而言，原生支持256K，配置YaRN方法后可以到1M
- `--kv-cache-dtype fp8_e4m3`则配置针对KV Cache的量化，默认是fp16精度，换成fp8可以显著减少显存占用
- `--max-seq-len-to-capture`参数用于指定CUDA graphs可以覆盖的最大序列长度。如果序列长度超过了这个值，系统会回退到eager模式。为了最好的性能，我这里把它设置成和上下文一样长

## 配置Continue

更改Continue的配置文件，添加或修改成如下形式

```yaml
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

大部分都很好理解，其中比较坑的是用于autocomplete的Prompt Templates。

一开始我按照qwen2.5-coder的默认模板进行配置。

```yaml
    promptTemplates: 
      autocomplete: "<|fim_prefix|>{{{prefix}}}<|fim_suffix|>{{{suffix}}}<|fim_middle|>"
```

发现效果不佳。经过一段时间研究后，发现正确的[使用方式](https://github.com/QwenLM/Qwen3-Coder)类似于

```python
input_text = """<|fim_prefix|>def quicksort(arr):
    if len(arr) <= 1:
        return arr
    pivot = arr[len(arr) // 2]
    <|fim_suffix|>
    middle = [x for x in arr if x == pivot]
    right = [x for x in arr if x > pivot]
    return quicksort(left) + middle + quicksort(right)<|fim_middle|>"""
            
messages = [
    {"role": "system", "content": "You are a code completion assistant."},
    {"role": "user", "content": input_text}
]
```

换句话说，我们应该向`/v1/chat/completions`端点发送一条以`<|fim_prefix|>{{{prefix}}}<|fim_suffix|>{{{suffix}}}<|fim_middle|>`为内容的对话，此时响应内容就是补全的代码。

而Continue的策略是把这个模板直接发送到`/v1/completions`。这对未经对话微调的Base模型是正确的，但我们这是对话模型。所以我们只能手动套用对话模板了

```jinja
<|im_start|>system
You are a code completion assistant.<|im_end|>
<|im_start|>user
<|fim_prefix|>{{{prefix}}}<|fim_suffix|>{{{suffix}}}<|fim_middle|><|im_end|>
<|im_start|>assistant
```

实测效果非常好。
