---
title: "Fix `OutOfResources: shared memory` Error when Run GLM-4.7-Flash with SGLang on RTX 4090"
subtitle:
date: 2026-02-06T14:10:03-04:00
lastmod: 2026-02-06T14:10:03-04:00
slug: tuning-fused-moe-triton-b
draft: false
author:
  name: James
  link: https://www.jamesflare.com
  email:
  avatar: /site-logo.avif
description: This blog post explains how to resolve GPU memory overflow issues in SGLang on RTX 4090 by tuning Fused MoE Triton configurations, optimizing performance for GLM-4.7-Flash models.
keywords: ["SGLang", "Fused MoE Triton", "GPU memory", "RTX 4090", "tuning script", "GLM-4.7-Flash"]
license:
comment: true
weight: 0
tags:
  - LLM
  - SGLang
  - GLM-4.7-Flash
categories:
  - LLM
  - Tutorials
collections:
  - LLM
hiddenFromHomePage: false
hiddenFromSearch: false
hiddenFromRss: false
hiddenFromRelated: false
summary: This blog post explains how to resolve GPU memory overflow issues in SGLang on RTX 4090 by tuning Fused MoE Triton configurations, optimizing performance for GLM-4.7-Flash models.
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

## Background

Earlier, I mentioned the OutOfResources: shared memory issue encountered when running Qwen3-30B-A3B-FP8 in SGLang.

{{< link "../tuning-fused-moe-triton" "Fix `OutOfResources: shared memory` Error when Run Qwen3 MoE with SGLang on RTX 4090" "Source of Qwen3 Fused MoE Triton" true >}}

At that time, I used the `tuning_fused_moe_triton.py` script to fine-tune the Fused MoE Triton configuration.

However, as of version v0.5.8:

1. This script does not support the `Glm4MoeLiteForCausalLM` architecture. It cannot obtain the correct E/N parameters for GLM-4.7-Flash series models. The possible reason is that GLM-4.7-Flash was only supported in Transformer 5.x, while SGLang is currently using version 4.57.1.
2. Additionally, this script does not perform special handling for `OutOfResources: shared memory`, such as skipping overly large `num_stages`. While it won't cause an error, it will spend a lot of time attempting impossible combinations. In my single RTX 4090 48GB environment, tuning once takes nearly 10 hours.

## How to fix?

First, add `Glm4MoeLiteForCausalLM` support to `common_utils.py`. Then, accelerate tuning by caching "shared memory failure thresholds" for each (BLOCK_M,N,K,GROUP_M,warps) combination, and skipping larger or equal `num_stages` under the same tile shape (tested to speed up 4-5 times).

### Modified common_utils.py

```python
import json
from typing import Dict, List, TypedDict

import torch

from sglang.srt.layers.moe.fused_moe_triton.fused_moe import get_config_dtype_str
from sglang.srt.layers.moe.fused_moe_triton.fused_moe_triton_config import (
    get_config_file_name,
)
from sglang.srt.utils import is_hip
from sglang.srt.utils.hf_transformers_utils import get_config


class BenchmarkConfig(TypedDict):
    BLOCK_SIZE_M: int
    BLOCK_SIZE_N: int
    BLOCK_SIZE_K: int
    GROUP_SIZE_M: int
    num_warps: int
    num_stages: int


def calculate_shard_intermediate_size(
    intermediate_size: int, tp_size: int, ep_size: int = 1
) -> int:
    assert tp_size % ep_size == 0
    moe_tp_size = tp_size // ep_size
    assert intermediate_size % moe_tp_size == 0
    return 2 * intermediate_size // moe_tp_size


def get_model_config(
    model_name: str,
    tp_size: int,
    ep_size: int = 1,
    disable_shared_experts_fusion: bool = False,
    topk_ids_dir: str = None,
) -> Dict:
    config = get_config(model_name, trust_remote_code=True)

    block_shape = None
    if (
        hasattr(config, "quantization_config")
        and "weight_block_size" in config.quantization_config
    ):
        block_shape = config.quantization_config["weight_block_size"]
        assert len(block_shape) == 2

    architecture = config.architectures[0]

    # Replace config with text_config for encoder-decoder models after getting block_shape and architecture
    if hasattr(config, "text_config"):
        config = config.get_text_config()

    hidden_size = config.hidden_size
    if architecture == "DbrxForCausalLM":
        E = config.ffn_config.moe_num_experts // ep_size
        topk = config.ffn_config.moe_top_k
        intermediate_size = config.ffn_config.ffn_hidden_size
    elif architecture == "JambaForCausalLM":
        E = config.num_experts // ep_size
        topk = config.num_experts_per_tok
        intermediate_size = config.intermediate_size
    elif architecture in [
        "Qwen2MoeForCausalLM",
        "Qwen3MoeForCausalLM",
        "Qwen3NextForCausalLM",
        "Qwen3VLMoeForConditionalGeneration",
    ]:
        E = config.num_experts // ep_size
        topk = config.num_experts_per_tok
        intermediate_size = config.moe_intermediate_size
    elif architecture in [
        "DeepseekV2ForCausalLM",
        "DeepseekV3ForCausalLM",
        "Glm4MoeForCausalLM",
        "Glm4MoeLiteForCausalLM",
        "MistralLarge3ForCausalLM",
    ]:
        E = (config.n_routed_experts // ep_size) + (
            0
            if disable_shared_experts_fusion
            or architecture
            not in [
                "DeepseekV3ForCausalLM",
                "Glm4MoeForCausalLM",
                "Glm4MoeLiteForCausalLM",
                "MistralLarge3ForCausalLM",
            ]
            else 1
        )
        topk = config.num_experts_per_tok + (
            0 if disable_shared_experts_fusion or topk_ids_dir is None else 1
        )
        intermediate_size = config.moe_intermediate_size
    elif architecture == "Llama4ForConditionalGeneration":
        E = config.num_local_experts // ep_size + (
            0 if disable_shared_experts_fusion else 1
        )
        topk = config.num_experts_per_tok + (
            0 if disable_shared_experts_fusion or topk_ids_dir is None else 1
        )
        intermediate_size = config.intermediate_size
    elif architecture in [
        "Grok1ForCausalLM",
        "Grok1ImgGen",
        "Grok1AForCausalLM",
    ]:
        E = config.num_local_experts // ep_size
        topk = config.num_experts_per_tok
        intermediate_size = config.moe_intermediate_size
    elif architecture in [
        "BailingMoEForCausalLM",
        "BailingMoeForCausalLM",
        "BailingMoeV2ForCausalLM",
    ]:
        E = config.num_experts // ep_size
        topk = config.num_experts_per_tok
        intermediate_size = config.moe_intermediate_size
    elif architecture == "NemotronHForCausalLM":
        E = config.n_routed_experts // ep_size
        topk = config.num_experts_per_tok
        intermediate_size = config.moe_intermediate_size
        hidden_size = getattr(config, "moe_latent_size", None) or hidden_size
    else:
        # Default: Mixtral
        E = config.num_local_experts // ep_size
        topk = config.num_experts_per_tok
        intermediate_size = config.intermediate_size

    shard_intermediate_size = calculate_shard_intermediate_size(
        intermediate_size, tp_size, ep_size
    )

    return {
        "num_experts": E,
        "topk": topk,
        "hidden_size": hidden_size,
        "shard_intermediate_size": shard_intermediate_size,
        "dtype": config.torch_dtype,
        "block_shape": block_shape,
        "architecture": architecture,
    }


def get_rocm_configs_compute_bound() -> List[Dict[str, int]]:
    configs: List[BenchmarkConfig] = []
    waves_per_eu_range = 0
    for num_stages in [2]:
        for block_m in [32, 64, 128, 256]:
            for block_k in [32, 64, 128, 256]:
                for block_n in [16, 32, 64, 128, 256]:
                    for num_warps in [1, 2, 4, 8]:
                        for group_size in [1, 4, 8, 16, 32]:
                            configs.append(
                                {
                                    "BLOCK_SIZE_M": block_m,
                                    "BLOCK_SIZE_N": block_n,
                                    "BLOCK_SIZE_K": block_k,
                                    "GROUP_SIZE_M": group_size,
                                    "num_warps": num_warps,
                                    "num_stages": num_stages,
                                    "waves_per_eu": waves_per_eu_range,
                                }
                            )
    return configs


def get_configs_compute_bound() -> List[Dict[str, int]]:
    configs: List[BenchmarkConfig] = []
    if is_hip():
        configs = get_rocm_configs_compute_bound()
    else:
        for num_stages in [2, 3, 4, 5]:
            for block_m in [16, 32, 64, 128, 256]:
                for block_k in [64, 128, 256]:
                    for block_n in [32, 64, 128, 256]:
                        for num_warps in [4, 8]:
                            for group_size in [1, 16, 32, 64]:
                                configs.append(
                                    {
                                        "BLOCK_SIZE_M": block_m,
                                        "BLOCK_SIZE_N": block_n,
                                        "BLOCK_SIZE_K": block_k,
                                        "GROUP_SIZE_M": group_size,
                                        "num_warps": num_warps,
                                        "num_stages": num_stages,
                                    }
                                )
    return configs


def sort_config(config: BenchmarkConfig) -> BenchmarkConfig:
    return {
        "BLOCK_SIZE_M": config["BLOCK_SIZE_M"],
        "BLOCK_SIZE_N": config["BLOCK_SIZE_N"],
        "BLOCK_SIZE_K": config["BLOCK_SIZE_K"],
        "GROUP_SIZE_M": config["GROUP_SIZE_M"],
        "num_warps": config["num_warps"],
        "num_stages": config["num_stages"],
        **(
            {"waves_per_eu": config["waves_per_eu"]} if "waves_per_eu" in config else {}
        ),
        **({"USE_TMA": config["USE_TMA"]} if "USE_TMA" in config else {}),
    }


def save_configs(
    configs: Dict[int, BenchmarkConfig],
    filename: str,
) -> None:
    print(f"Writing best config to {filename}...")
    with open(filename, "w") as f:
        json.dump(configs, f, indent=4)
        f.write("\n")


def get_config_filename(
    num_experts: int,
    shard_intermediate_size: int,
    hidden_size: int,
    topk: int,
    dtype: torch.dtype,
    use_fp8_w8a8: bool,
    use_int8_w8a8: bool,
    use_int8_w8a16: bool,
    per_channel_quant: bool,
    block_shape: List[int],
) -> str:
    dtype_str = get_config_dtype_str(
        dtype,
        use_int8_w8a16=use_int8_w8a16,
        use_fp8_w8a8=use_fp8_w8a8,
        use_int8_w8a8=use_int8_w8a8,
    )

    # NOTE(woosuk): The current naming convention uses w2.shape[2], which
    # is the intermediate size after silu_and_mul.
    filename = get_config_file_name(
        num_experts,
        shard_intermediate_size // 2,
        dtype_str,
        block_shape,
        per_channel_quant,
    )

    return filename


def get_default_batch_sizes() -> List[int]:
    return [
        1,
        2,
        4,
        8,
        16,
        24,
        32,
        48,
        64,
        96,
        128,
        256,
        512,
        1024,
        1536,
        2048,
        3072,
        4096,
    ]
```

### Modified tuning_fused_moe_triton.py

```python
# Adapted from https://github.com/vllm-project/vllm/blob/main/benchmarks/kernels/benchmark_moe.py
import argparse
import time
from contextlib import nullcontext
from datetime import datetime
from typing import Any, Dict, List, Tuple

import ray
import torch
import triton
from common_utils import (
    BenchmarkConfig,
    get_config_filename,
    get_configs_compute_bound,
    get_default_batch_sizes,
    get_model_config,
    save_configs,
    sort_config,
)
from ray.experimental.tqdm_ray import tqdm

from sglang.srt.layers.moe.fused_moe_triton import override_config
from sglang.srt.layers.moe.fused_moe_triton.fused_moe import fused_moe
from sglang.srt.layers.moe.fused_moe_triton.fused_moe_triton_config import (
    get_config_dtype_str,
    get_default_config,
    get_moe_configs,
)
from sglang.srt.layers.moe.moe_runner import MoeRunnerConfig
from sglang.srt.layers.moe.topk import TopKConfig, select_experts
from sglang.srt.utils import is_hip

_is_hip = is_hip()


def _is_shared_mem_oor(err: Exception) -> bool:
    # Triton commonly reports: "OutOfResources: shared memory ..."
    msg = str(err).lower()
    return "shared memory" in msg or "shared-memory" in msg


def _stage_cache_key(config: BenchmarkConfig) -> Tuple[int, int, int, int, int]:
    # Cache shared-mem failures per tile-shape + warps (stages is what we skip upwards).
    return (
        config["BLOCK_SIZE_M"],
        config["BLOCK_SIZE_N"],
        config["BLOCK_SIZE_K"],
        config["GROUP_SIZE_M"],
        config["num_warps"],
    )


def benchmark_config(
    config: BenchmarkConfig,
    num_tokens: int,
    num_experts: int,
    shard_intermediate_size: int,
    hidden_size: int,
    topk: int,
    dtype: torch.dtype,
    use_fp8_w8a8: bool,
    use_int8_w8a8: bool,
    use_int8_w8a16: bool,
    per_channel_quant: bool,
    block_shape: List[int] = None,
    num_iters: int = 100,
) -> float:
    init_dtype = torch.float16 if use_fp8_w8a8 else dtype
    x = torch.randn(num_tokens, hidden_size, dtype=dtype)
    if use_int8_w8a16 or use_int8_w8a8:
        w1 = torch.randint(
            -127,
            127,
            (
                num_experts,
                shard_intermediate_size,
                hidden_size,
            ),
            dtype=torch.int8,
        )
        w2 = torch.randint(
            -127,
            127,
            (
                num_experts,
                hidden_size,
                shard_intermediate_size // 2,
            ),
            dtype=torch.int8,
        )
    else:
        w1 = torch.randn(
            num_experts, shard_intermediate_size, hidden_size, dtype=init_dtype
        )
        w2 = torch.randn(
            num_experts, hidden_size, shard_intermediate_size // 2, dtype=init_dtype
        )
    gating_output = torch.randn(num_iters, num_tokens, num_experts, dtype=torch.float32)

    w1_scale = None
    w2_scale = None
    a1_scale = None
    a2_scale = None
    if use_int8_w8a16:
        w1_scale = torch.randn(
            (num_experts, 2 * shard_intermediate_size), dtype=torch.float32
        )
        w2_scale = torch.randn((hidden_size, num_experts), dtype=torch.float32)
    if use_fp8_w8a8 or use_int8_w8a8:
        if use_int8_w8a8 and block_shape is None:
            w1_scale = torch.randn(
                num_experts, shard_intermediate_size, dtype=torch.float32
            )
            w2_scale = torch.randn(num_experts, hidden_size, dtype=torch.float32)
        elif block_shape is None:
            w1_scale = torch.randn(num_experts, dtype=torch.float32)
            w2_scale = torch.randn(num_experts, dtype=torch.float32)
            a1_scale = torch.randn(1, dtype=torch.float32)
            a2_scale = torch.randn(1, dtype=torch.float32)
        else:
            block_n, block_k = block_shape[0], block_shape[1]
            n_tiles_w1 = (shard_intermediate_size + block_n - 1) // block_n
            n_tiles_w2 = (hidden_size + block_n - 1) // block_n
            k_tiles_w1 = (hidden_size + block_k - 1) // block_k
            k_tiles_w2 = (shard_intermediate_size // 2 + block_k - 1) // block_k
            w1_scale = torch.rand(
                (num_experts, n_tiles_w1, k_tiles_w1), dtype=torch.float32
            )
            w2_scale = torch.rand(
                (num_experts, n_tiles_w2, k_tiles_w2), dtype=torch.float32
            )

    if use_fp8_w8a8:
        w1 = w1.to(torch.float8_e4m3fnuz if _is_hip else torch.float8_e4m3fn)
        w2 = w2.to(torch.float8_e4m3fnuz if _is_hip else torch.float8_e4m3fn)

    input_gating = torch.randn(num_tokens, num_experts, dtype=torch.float32)
    topk_config = TopKConfig(
        top_k=topk,
        renormalize=True,
    )
    topk_output = select_experts(x, input_gating, topk_config)

    def prepare(i: int):
        input_gating = gating_output[i]
        new_topk_output = select_experts(x, input_gating, topk_config)
        topk_output.topk_weights.copy_(new_topk_output.topk_weights)
        topk_output.topk_ids.copy_(new_topk_output.topk_ids)
        topk_output.router_logits.copy_(new_topk_output.router_logits)

    def run():
        moe_runner_config = MoeRunnerConfig(
            inplace=True,
        )

        with override_config(config):
            fused_moe(
                x,
                w1,
                w2,
                topk_output,
                moe_runner_config=moe_runner_config,
                use_fp8_w8a8=use_fp8_w8a8,
                use_int8_w8a8=use_int8_w8a8,
                use_int8_w8a16=use_int8_w8a16,
                w1_scale=w1_scale,
                w2_scale=w2_scale,
                a1_scale=a1_scale,
                a2_scale=a2_scale,
                per_channel_quant=per_channel_quant,
                block_shape=block_shape,
            )

    # JIT compilation & warmup
    run()
    torch.cuda.synchronize()

    # Capture 10 invocations with CUDA graph
    graph = torch.cuda.CUDAGraph()
    with torch.cuda.graph(graph):
        for _ in range(10):
            run()
    torch.cuda.synchronize()

    # Warmup
    for _ in range(5):
        graph.replay()
    torch.cuda.synchronize()

    # Flush L2 cache with 256 MB data
    cache_flush = torch.empty(int(256e6 // 4), dtype=torch.int, device="cuda")
    cache_flush.zero_()

    start_events = [torch.cuda.Event(enable_timing=True) for _ in range(num_iters)]
    end_events = [torch.cuda.Event(enable_timing=True) for _ in range(num_iters)]

    for i in range(num_iters):
        prepare(i)
        start_events[i].record()
        graph.replay()
        end_events[i].record()
    torch.cuda.synchronize()

    latencies: List[float] = []
    for i in range(num_iters):
        latencies.append(start_events[i].elapsed_time(end_events[i]))
    avg = sum(latencies) / (num_iters * 10) * 1000  # us
    graph.reset()
    return avg


@ray.remote(num_gpus=1)
class BenchmarkWorker:

    def __init__(self, seed: int) -> None:
        torch.set_default_device("cuda")
        torch.cuda.manual_seed_all(0)
        self.seed = seed
        # Get the device ID to allocate tensors and kernels
        # on the respective GPU.
        self.device_id = int(ray.get_gpu_ids()[0])

        # Cache: for a given tile-shape+warps, if stage S fails due to shared memory,
        # any stage >= S is very likely to fail too. Persist across batch sizes.
        self._shared_mem_fail_stage_by_key: Dict[Tuple[int, int, int, int, int], int] = {}

    def benchmark(
        self,
        num_tokens: int,
        num_experts: int,
        shard_intermediate_size: int,
        hidden_size: int,
        topk: int,
        dtype: torch.dtype,
        use_fp8_w8a8: bool,
        use_int8_w8a8: bool,
        use_int8_w8a16: bool,
        per_channel_quant: bool,
        block_shape: List[int],
    ) -> Tuple[Dict[str, int], float]:
        torch.cuda.manual_seed_all(0)
        dtype_str = get_config_dtype_str(
            dtype, use_int8_w8a16=use_int8_w8a16, use_fp8_w8a8=use_fp8_w8a8
        )
        # NOTE(woosuk): The current naming convention uses w2.shape[2], which
        # is the intermediate size after silu_and_mul.
        block_n = block_shape[0] if block_shape else 0
        block_k = block_shape[1] if block_shape else 0
        op_config = get_moe_configs(
            num_experts,
            shard_intermediate_size // 2,
            dtype_str,
            block_n,
            block_k,
            per_channel_quant,
        )
        if op_config is None:
            config = get_default_config(
                num_tokens,
                num_experts,
                shard_intermediate_size,
                hidden_size,
                topk,
                dtype_str,
                False,
                block_shape,
            )
        else:
            config = op_config[min(op_config.keys(), key=lambda x: abs(x - num_tokens))]
        with torch.cuda.device(self.device_id) if is_hip() else nullcontext():
            kernel_time = benchmark_config(
                config,
                num_tokens,
                num_experts,
                shard_intermediate_size,
                hidden_size,
                topk,
                dtype,
                use_fp8_w8a8,
                use_int8_w8a8,
                use_int8_w8a16,
                per_channel_quant,
                block_shape,
            )
        return config, kernel_time

    def tune(
        self,
        num_tokens: int,
        num_experts: int,
        shard_intermediate_size: int,
        hidden_size: int,
        topk: int,
        dtype: torch.dtype,
        use_fp8_w8a8: bool,
        use_int8_w8a8: bool,
        use_int8_w8a16: bool,
        per_channel_quant: bool,
        block_shape: List[int],
        search_space: List[Dict[str, int]],
    ) -> Dict[str, int]:
        best_config = None
        best_time = float("inf")
        with torch.cuda.device(self.device_id) if is_hip() else nullcontext():
            for config in tqdm(search_space):
                key = _stage_cache_key(config)
                bad_stage = self._shared_mem_fail_stage_by_key.get(key, None)
                if bad_stage is not None and config["num_stages"] >= bad_stage:
                    continue

                try:
                    kernel_time = benchmark_config(
                        config,
                        num_tokens,
                        num_experts,
                        shard_intermediate_size,
                        hidden_size,
                        topk,
                        dtype,
                        use_fp8_w8a8,
                        use_int8_w8a8,
                        use_int8_w8a16,
                        per_channel_quant,
                        block_shape,
                        num_iters=10,
                    )
                except (triton.runtime.autotuner.OutOfResources, RuntimeError) as e:
                    # Some configurations may be invalid and fail to compile.
                    # If it's shared-memory OOR, skip this stage and all larger stages
                    # for the same tile-shape+warps in future (including future batch sizes).
                    if _is_shared_mem_oor(e):
                        prev = self._shared_mem_fail_stage_by_key.get(key, None)
                        s = config["num_stages"]
                        if prev is None or s < prev:
                            self._shared_mem_fail_stage_by_key[key] = s
                    continue

                if kernel_time < best_time:
                    best_time = kernel_time
                    best_config = config
        now = datetime.now()
        print(f"{now.ctime()}] Completed tuning for batch_size={num_tokens}")
        assert best_config is not None
        return best_config


def main(args: argparse.Namespace):
    print(args)

    model_config = get_model_config(
        args.model, args.tp_size, args.ep_size, args.disable_shared_experts_fusion
    )

    E = model_config["num_experts"]
    topk = model_config["topk"]
    hidden_size = model_config["hidden_size"]
    shard_intermediate_size = model_config["shard_intermediate_size"]
    dtype = model_config["dtype"]
    block_shape = model_config["block_shape"]

    use_fp8_w8a8 = args.dtype == "fp8_w8a8"
    use_int8_w8a8 = args.dtype == "int8_w8a8"
    use_int8_w8a16 = args.dtype == "int8_w8a16"
    per_channel_quant = args.per_channel_quant

    if args.batch_size is None:
        batch_sizes = get_default_batch_sizes()
    else:
        batch_sizes = [args.batch_size]

    ray.init()
    num_gpus = int(ray.available_resources()["GPU"])
    workers = [BenchmarkWorker.remote(args.seed) for _ in range(num_gpus)]

    def _distribute(method: str, inputs: List[Any]) -> List[Any]:
        outputs = []
        worker_idx = 0
        for input_args in inputs:
            worker = workers[worker_idx]
            worker_method = getattr(worker, method)
            output = worker_method.remote(*input_args)
            outputs.append(output)
            worker_idx = (worker_idx + 1) % num_gpus
        return ray.get(outputs)

    if args.tune:
        search_space = get_configs_compute_bound()
        if block_shape is not None:
            block_n, block_k = block_shape[0], block_shape[1]
            search_space = [
                config
                for config in search_space
                if block_k % config["BLOCK_SIZE_K"] == 0
            ]

        filename = get_config_filename(
            E,
            shard_intermediate_size,
            hidden_size,
            topk,
            dtype,
            use_fp8_w8a8,
            use_int8_w8a8,
            use_int8_w8a16,
            per_channel_quant,
            block_shape,
        )
        print(
            f"Start tuning over {len(search_space)} configurations to create {filename}..."
        )

        start = time.perf_counter()
        configs = _distribute(
            "tune",
            [
                (
                    batch_size,
                    E,
                    shard_intermediate_size,
                    hidden_size,
                    topk,
                    dtype,
                    use_fp8_w8a8,
                    use_int8_w8a8,
                    use_int8_w8a16,
                    per_channel_quant,
                    block_shape,
                    search_space,
                )
                for batch_size in batch_sizes
            ],
        )
        best_configs = {
            M: sort_config(config) for M, config in zip(batch_sizes, configs)
        }
        save_configs(
            best_configs,
            filename,
        )
        end = time.perf_counter()
        print(f"Tuning took {end - start:.2f} seconds")
    else:
        outputs = _distribute(
            "benchmark",
            [
                (
                    batch_size,
                    E,
                    shard_intermediate_size,
                    hidden_size,
                    topk,
                    dtype,
                    use_fp8_w8a8,
                    use_int8_w8a8,
                    use_int8_w8a16,
                    per_channel_quant,
                    block_shape,
                )
                for batch_size in batch_sizes
            ],
        )

        for batch_size, (config, kernel_time) in zip(batch_sizes, outputs):
            print(f"Batch size: {batch_size}, config: {config}")
            print(f"Kernel time: {kernel_time:.2f} us")


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument(
        "--model", type=str, default="mistralai/Mixtral-8x7B-Instruct-v0.1"
    )
    parser.add_argument("--tp-size", "--tp", type=int, default=2)
    parser.add_argument("--ep-size", "--ep", type=int, default=1)
    parser.add_argument(
        "--dtype",
        type=str,
        choices=["auto", "fp8_w8a8", "int8_w8a16", "int8_w8a8"],
        default="auto",
    )
    parser.add_argument(
        "--per-channel-quant",
        action="store_true",
    )
    parser.add_argument("--seed", type=int, default=0)
    parser.add_argument("--batch-size", type=int, required=False)
    parser.add_argument("--tune", action="store_true")
    parser.add_argument("--disable-shared-experts-fusion", action="store_true")
    args = parser.parse_args()

    main(args)
```

### Modified tuning_fused_moe_triton_sep.py

```python
# Adapted from https://github.com/vllm-project/vllm/blob/main/benchmarks/kernels/benchmark_moe.py
import argparse
import dataclasses
import json
import os
import re
import time
from contextlib import nullcontext
from datetime import datetime
from functools import lru_cache
from typing import Any, Dict, List, Tuple

import ray
import torch
import triton
import triton.language as tl
from common_utils import (
    BenchmarkConfig,
    get_config_filename,
    get_configs_compute_bound,
    get_default_batch_sizes,
    get_model_config,
    sort_config,
)
from ray.experimental.tqdm_ray import tqdm

from sglang.srt.layers.moe.fused_moe_triton.fused_moe import (
    get_config_dtype_str,
    invoke_fused_moe_kernel,
    moe_align_block_size,
)
from sglang.srt.layers.moe.fused_moe_triton.fused_moe_triton_config import (
    get_config_file_name,
)
from sglang.srt.layers.moe.moe_runner import MoeRunnerConfig
from sglang.srt.layers.moe.topk import TopKConfig, select_experts
from sglang.srt.utils import is_hip

_is_hip = is_hip()


def _is_shared_mem_oor(err: Exception) -> bool:
    msg = str(err).lower()
    return "shared memory" in msg or "shared-memory" in msg


def _stage_cache_key(config: BenchmarkConfig) -> Tuple[int, int, int, int, int]:
    return (
        config["BLOCK_SIZE_M"],
        config["BLOCK_SIZE_N"],
        config["BLOCK_SIZE_K"],
        config["GROUP_SIZE_M"],
        config["num_warps"],
    )


@dataclasses.dataclass
class MoeInputs:
    topk_ids: torch.Tensor
    sorted_token_ids: torch.Tensor
    expert_ids: torch.Tensor
    num_tokens_post_padded: torch.Tensor


class KernelWrapper:
    def __init__(self, moe_inputs, use_cuda_graph=True, inner_iter=10, **kwargs):
        self.func = invoke_fused_moe_kernel
        self.use_cuda_graph = use_cuda_graph
        self.moe_inputs = moe_inputs
        self.inner_iter = inner_iter
        self.kwargs = kwargs
        if use_cuda_graph:
            self.graph = self.cuda_graph_wrapper()
        else:
            self.graph = None

    def cuda_graph_wrapper(self):
        moe_input = self.moe_inputs[0]
        self.func(
            **self.kwargs,
            topk_ids=moe_input.topk_ids,
            sorted_token_ids=moe_input.sorted_token_ids,
            expert_ids=moe_input.expert_ids,
            num_tokens_post_padded=moe_input.num_tokens_post_padded,
        )
        torch.cuda.synchronize()

        # Capture 10 invocations with CUDA graph
        graph = torch.cuda.CUDAGraph()
        with torch.cuda.graph(graph):
            for k in range(self.inner_iter):
                moe_input = self.moe_inputs[k]
                self.func(
                    **self.kwargs,
                    topk_ids=moe_input.topk_ids,
                    sorted_token_ids=moe_input.sorted_token_ids,
                    expert_ids=moe_input.expert_ids,
                    num_tokens_post_padded=moe_input.num_tokens_post_padded,
                )
        torch.cuda.synchronize()

        # Warmup
        for _ in range(5):
            graph.replay()
        torch.cuda.synchronize()
        return graph

    def forward_cost(self, try_cnt=2):
        time_cost = float("inf")
        for _ in range(try_cnt):
            start_event = torch.cuda.Event(enable_timing=True)
            end_event = torch.cuda.Event(enable_timing=True)
            start_event.record()
            if self.use_cuda_graph:
                self.graph.replay()
            else:
                for k in range(self.inner_iter):
                    moe_input = self.moe_inputs[k]
                    self.func(
                        **self.kwargs,
                        topk_ids=moe_input.topk_ids,
                        sorted_token_ids=moe_input.sorted_token_ids,
                        expert_ids=moe_input.expert_ids,
                        num_tokens_post_padded=moe_input.num_tokens_post_padded,
                    )
            end_event.record()
            torch.cuda.synchronize()
            time_cost = min(time_cost, start_event.elapsed_time(end_event))
        return time_cost


@lru_cache(maxsize=None)
def _list_topk_files(topk_ids_dir: str) -> List[str]:
    if not os.path.isdir(topk_ids_dir):
        raise FileNotFoundError(f"topk_ids_dir not found: {topk_ids_dir}")

    files = [f for f in os.listdir(topk_ids_dir) if f.endswith(".pt")]
    if not files:
        raise FileNotFoundError(f"No .pt files found under: {topk_ids_dir}")

    # Prefer the expected naming: topk_ids_layer{L}_idx{I}.pt
    pat = re.compile(r"topk_ids_layer(\d+)_idx(\d+)\.pt$")
    parsed = []
    fallback = []
    for f in files:
        m = pat.match(f)
        if m:
            layer = int(m.group(1))
            idx = int(m.group(2))
            parsed.append((idx, layer, f))
        else:
            fallback.append(f)

    if parsed:
        parsed.sort(key=lambda x: (x[0], x[1], x[2]))
        ordered = [os.path.join(topk_ids_dir, x[2]) for x in parsed]
        return ordered

    # Fallback: deterministic lexicographic order.
    fallback.sort()
    return [os.path.join(topk_ids_dir, f) for f in fallback]


def load_topk_ids(topk_ids_dir, i: int):
    files = _list_topk_files(topk_ids_dir)
    return torch.load(files[i % len(files)])


def benchmark_config(
    config: BenchmarkConfig,
    num_tokens: int,
    num_experts: int,
    shard_intermediate_size: int,
    hidden_size: int,
    topk: int,
    dtype: torch.dtype,
    use_fp8_w8a8: bool,
    use_int8_w8a8: bool,
    use_int8_w8a16: bool,
    topk_ids_list,
    block_shape: List[int] = None,
    ep_size: int = 1,
    num_iters: int = 100,
) -> float:
    ncu_enable = os.getenv("NCU_ENABLE", "0") == "1"
    if ncu_enable:
        num_iters = 1
    init_dtype = torch.float16 if use_fp8_w8a8 else dtype
    hidden_states = torch.randn(num_tokens, hidden_size, dtype=dtype)
    if use_int8_w8a16 or use_int8_w8a8:
        w1 = torch.randint(
            -127,
            127,
            (
                num_experts,
                shard_intermediate_size,
                hidden_size,
            ),
            dtype=torch.int8,
        )
        w2 = torch.randint(
            -127,
            127,
            (
                num_experts,
                hidden_size,
                shard_intermediate_size // 2,
            ),
            dtype=torch.int8,
        )
    else:
        w1 = torch.randn(
            num_experts, shard_intermediate_size, hidden_size, dtype=init_dtype
        )
        w2 = torch.randn(
            num_experts, hidden_size, shard_intermediate_size // 2, dtype=init_dtype
        )

    w1_scale = None
    w2_scale = None
    a1_scale = None
    a2_scale = None
    if use_int8_w8a16:
        w1_scale = torch.randn(
            (num_experts, 2 * shard_intermediate_size), dtype=torch.float32
        )
        w2_scale = torch.randn((hidden_size, num_experts), dtype=torch.float32)
    if use_fp8_w8a8 or use_int8_w8a8:
        if use_int8_w8a8 and block_shape is None:
            w1_scale = torch.randn(
                num_experts, shard_intermediate_size, dtype=torch.float32
            )
            w2_scale = torch.randn(num_experts, hidden_size, dtype=torch.float32)
        elif block_shape is None:
            w1_scale = torch.randn(num_experts, dtype=torch.float32)
            w2_scale = torch.randn(num_experts, dtype=torch.float32)
            a1_scale = torch.randn(1, dtype=torch.float32)
            a2_scale = torch.randn(1, dtype=torch.float32)
        else:
            block_n, block_k = block_shape[0], block_shape[1]
            n_tiles_w1 = (shard_intermediate_size + block_n - 1) // block_n
            n_tiles_w2 = (hidden_size + block_n - 1) // block_n
            k_tiles_w1 = (hidden_size + block_k - 1) // block_k
            k_tiles_w2 = (shard_intermediate_size // 2 + block_k - 1) // block_k
            w1_scale = torch.rand(
                (num_experts, n_tiles_w1, k_tiles_w1), dtype=torch.float32
            )
            w2_scale = torch.rand(
                (num_experts, n_tiles_w2, k_tiles_w2), dtype=torch.float32
            )

    if use_fp8_w8a8:
        w1 = w1.to(torch.float8_e4m3fnuz if _is_hip else torch.float8_e4m3fn)
        w2 = w2.to(torch.float8_e4m3fnuz if _is_hip else torch.float8_e4m3fn)

    input_gating = torch.randn(num_tokens, num_experts, dtype=torch.float32)
    topk_config = TopKConfig(
        top_k=topk,
        renormalize=True,
    )
    topk_output_ = select_experts(hidden_states, input_gating, topk_config)
    sorted_token_ids_, expert_ids_, num_tokens_post_padded_ = moe_align_block_size(
        topk_output_.topk_ids, config["BLOCK_SIZE_M"], num_experts
    )
    inner_iter = 10 if not ncu_enable else 1
    moe_inputs = [
        MoeInputs(
            topk_output_.topk_ids.clone(),
            sorted_token_ids_.clone(),
            expert_ids_.clone(),
            num_tokens_post_padded_.clone(),
        )
        for _ in range(inner_iter)
    ]
    M = hidden_states.shape[0]
    E, N, _ = w1.shape

    padded_tokens = min(M * topk, E + 1) * (
        config["BLOCK_SIZE_M"] - 1
    )  # if moe_use_tma else 0
    total_tokens = M * topk + padded_tokens
    cache = torch.empty(
        total_tokens * max(N, w2.shape[1]),
        device=hidden_states.device,
        dtype=hidden_states.dtype,
    )
    intermediate_cache1 = cache[: total_tokens * N].view(
        (total_tokens, N),
    )
    intermediate_cache2 = torch.empty(
        (total_tokens, N // 2),
        device=hidden_states.device,
        dtype=hidden_states.dtype,
    )
    intermediate_cache3 = cache[: M * topk * w2.shape[1]].view(
        (M, topk, w2.shape[1]),
    )

    def prepare(i: int, inner_iter):  # update inputs according to topk_ids
        for k in range(inner_iter):
            topk_ids = topk_ids_list[i * inner_iter + k]
            # With EP, saved topk_ids are global expert indices; remap to local.
            if ep_size > 1:
                topk_ids = (topk_ids // ep_size).to(
                    device=moe_inputs[k].topk_ids.device,
                    dtype=moe_inputs[k].topk_ids.dtype,
                )
            tokens, _topk = moe_inputs[k].topk_ids.shape
            moe_inputs[k].topk_ids.copy_(topk_ids[:tokens, :_topk])
            sorted_token_ids_, expert_ids_, num_tokens_post_padded_ = (
                moe_align_block_size(
                    moe_inputs[k].topk_ids, config["BLOCK_SIZE_M"], num_experts
                )
            )
            moe_inputs[k].sorted_token_ids.copy_(sorted_token_ids_)
            moe_inputs[k].expert_ids.copy_(expert_ids_)
            moe_inputs[k].num_tokens_post_padded.copy_(num_tokens_post_padded_)

    def get_kernel_wrapper(moe_use_tma, inner_iter, use_cuda_graph):
        compute_type = (
            tl.bfloat16 if hidden_states.dtype == torch.bfloat16 else tl.float16
        )
        moe_runner_config = MoeRunnerConfig(
            inplace=True,
        )
        apply_router_weight_on_input = moe_runner_config.apply_router_weight_on_input
        kernel0 = KernelWrapper(
            A=hidden_states,
            B=w1,
            bias=None,
            C=intermediate_cache1,
            A_scale=None,
            B_scale=w1_scale,
            B_zp=None,
            topk_weights=topk_output_.topk_weights,
            moe_inputs=moe_inputs,
            mul_routed_weight=apply_router_weight_on_input,
            top_k=topk,
            config=config,
            compute_type=compute_type,
            use_fp8_w8a8=use_fp8_w8a8,
            use_int8_w8a8=False,
            use_int8_w8a16=False,
            use_int4_w4a16=False,
            per_channel_quant=False,
            block_shape=block_shape,
            b_use_tma=moe_use_tma,
            c_sorted=moe_use_tma,
            filter_expert=False,
            use_cuda_graph=use_cuda_graph,
            inner_iter=inner_iter,
        )
        kernel1 = KernelWrapper(
            A=intermediate_cache2,
            B=w2,
            bias=None,
            C=intermediate_cache3,
            A_scale=a2_scale,
            B_scale=w2_scale,
            B_zp=None,
            topk_weights=topk_output_.topk_weights,
            moe_inputs=moe_inputs,
            mul_routed_weight=not apply_router_weight_on_input,
            top_k=1,
            config=config,
            compute_type=compute_type,
            use_fp8_w8a8=use_fp8_w8a8,
            use_int8_w8a8=False,
            use_int8_w8a16=False,
            use_int4_w4a16=False,
            per_channel_quant=False,
            block_shape=block_shape,
            a_use_tma=moe_use_tma,
            b_use_tma=moe_use_tma,
            filter_expert=False,
            use_cuda_graph=use_cuda_graph,
            inner_iter=inner_iter,
        )
        return kernel0, kernel1

    use_cuda_graph = True if not ncu_enable else False

    kernel0, kernel1 = get_kernel_wrapper(False, inner_iter, use_cuda_graph)
    kernel_tma0, kernel_tma1 = get_kernel_wrapper(True, inner_iter, use_cuda_graph)

    # JIT compilation & warmup
    if not ncu_enable:
        kernel0.forward_cost()
        kernel1.forward_cost()
        kernel_tma0.forward_cost()
        kernel_tma1.forward_cost()

    ts0 = []
    ts1 = []
    ts_tma0 = []
    ts_tma1 = []

    for i in range(num_iters // inner_iter):
        prepare(i, inner_iter)
        ts0.append(kernel0.forward_cost())
        ts1.append(kernel1.forward_cost())
        ts_tma0.append(kernel_tma0.forward_cost())
        ts_tma1.append(kernel_tma1.forward_cost())
    torch.cuda.synchronize()

    avg = sum(ts0) / (num_iters) * 1000  # us
    avg1 = sum(ts1) / (num_iters) * 1000  # us
    avg_tma = sum(ts_tma0) / (num_iters) * 1000  # us
    avg1_tma = sum(ts_tma1) / (num_iters) * 1000  # us

    return avg, avg_tma, avg1, avg1_tma


class BestConfigTrace:
    def __init__(self, name, down_moe=False):
        self.name = name
        self.down_moe = down_moe
        self.best_costs_m = {}  # block_m: best_cost

    def update(self, config, time_cost_all):
        block_m = config["BLOCK_SIZE_M"]
        if not self.down_moe:
            time_cost = time_cost_all[0]
        else:
            time_cost = min(time_cost_all[2], time_cost_all[3])
        if (
            block_m not in self.best_costs_m
            or time_cost < self.best_costs_m[block_m][1]
        ):
            self.best_costs_m[block_m] = config, time_cost, time_cost_all

    def time_cost(self, block_m):
        if block_m not in self.best_costs_m:
            return float("inf")
        time_cost = self.best_costs_m[block_m][1]
        return time_cost

    def config_dict(self, block_m):
        if block_m not in self.best_costs_m:
            return {}
        config, _, time_cost_all = self.best_costs_m[block_m]
        if not self.down_moe:
            return config
        else:
            return {
                **config,
                "USE_TMA": time_cost_all[2] > time_cost_all[3],
            }


class BenchmarkWorker:

    def __init__(self, seed: int) -> None:
        torch.set_default_device("cuda")
        torch.cuda.manual_seed_all(0)
        self.seed = seed
        # Get the device ID to allocate tensors and kernels
        # on the respective GPU.
        self.device_id = 0  # int(ray.get_gpu_ids()[0])

        # Persist shared-memory stage failures across batch sizes for speed.
        self._shared_mem_fail_stage_by_key: Dict[Tuple[int, int, int, int, int], int] = {}

    def benchmark(
        self,
        num_tokens: int,
        num_experts: int,
        shard_intermediate_size: int,
        hidden_size: int,
        topk: int,
        dtype: torch.dtype,
        use_fp8_w8a8: bool,
        use_int8_w8a8: bool,
        use_int8_w8a16: bool,
        block_shape: List[int],
        cfg: Dict[str, int],
        topk_ids_dir: str,
        ep_size: int = 1,
    ) -> Tuple[Dict[str, int], float]:
        torch.cuda.manual_seed_all(0)
        topk_ids_list = [load_topk_ids(topk_ids_dir, i) for i in range(100)]
        with torch.cuda.device(self.device_id) if is_hip() else nullcontext():
            kernel_time = benchmark_config(
                cfg,
                num_tokens,
                num_experts,
                shard_intermediate_size,
                hidden_size,
                topk,
                dtype,
                use_fp8_w8a8,
                use_int8_w8a8,
                use_int8_w8a16,
                topk_ids_list,
                block_shape,
                ep_size=ep_size,
            )
        return cfg, kernel_time

    def tune(
        self,
        num_tokens: int,
        num_experts: int,
        shard_intermediate_size: int,
        hidden_size: int,
        topk: int,
        dtype: torch.dtype,
        use_fp8_w8a8: bool,
        use_int8_w8a8: bool,
        use_int8_w8a16: bool,
        block_shape: List[int],
        search_space: List[Dict[str, int]],
        topk_ids_dir: str,
        ep_size: int = 1,
    ) -> Dict[str, int]:
        trace0 = BestConfigTrace("kernel0", down_moe=False)
        trace1 = BestConfigTrace("kernel1", down_moe=True)
        topk_ids_list = [load_topk_ids(topk_ids_dir, i) for i in range(100)]

        with torch.cuda.device(self.device_id) if is_hip() else nullcontext():
            for config in tqdm(search_space):
                key = _stage_cache_key(config)
                bad_stage = self._shared_mem_fail_stage_by_key.get(key, None)
                if bad_stage is not None and config["num_stages"] >= bad_stage:
                    continue

                try:
                    kt0_no_tma, kt0_tma, kt1_no_tma, kt1_tma = benchmark_config(
                        config,
                        num_tokens,
                        num_experts,
                        shard_intermediate_size,
                        hidden_size,
                        topk,
                        dtype,
                        use_fp8_w8a8,
                        use_int8_w8a8,
                        use_int8_w8a16,
                        topk_ids_list,
                        block_shape,
                        ep_size=ep_size,
                        num_iters=100,
                    )
                except (triton.runtime.autotuner.OutOfResources, RuntimeError) as e:
                    # Some configurations may be invalid and fail to compile.
                    if _is_shared_mem_oor(e):
                        prev = self._shared_mem_fail_stage_by_key.get(key, None)
                        s = config["num_stages"]
                        if prev is None or s < prev:
                            self._shared_mem_fail_stage_by_key[key] = s
                    continue

                trace0.update(
                    config,
                    (kt0_no_tma, kt0_tma, kt1_no_tma, kt1_tma),
                )
                trace1.update(
                    config,
                    (kt0_no_tma, kt0_tma, kt1_no_tma, kt1_tma),
                )

        now = datetime.now()
        print(f"{now.ctime()}] Completed tuning for batch_size={num_tokens}")
        best_block_m = 16
        for block_m in (32, 64, 128, 256):
            if trace0.time_cost(block_m) + trace1.time_cost(block_m) < trace0.time_cost(
                best_block_m
            ) + trace1.time_cost(best_block_m):
                best_block_m = block_m

        return (
            trace0.config_dict(best_block_m),
            trace1.config_dict(best_block_m),
            trace0.time_cost(best_block_m),
            trace1.time_cost(best_block_m),
        )

    def cmp_configs(
        self,
        num_tokens: List[int],
        num_experts: int,
        shard_intermediate_size: int,
        hidden_size: int,
        topk: int,
        dtype: torch.dtype,
        use_fp8_w8a8: bool,
        use_int8_w8a8: bool,
        use_int8_w8a16: bool,
        block_shape: List[int],
        cmp_config_files: List[str],
        topk_ids_dir: str,
        ep_size: int = 1,
    ):
        # compare performance of different configs
        cmp_configs = []
        for file in cmp_config_files:
            with open(file) as f:
                cmp_configs.append({int(key): val for key, val in json.load(f).items()})
        for i, file in enumerate(cmp_config_files):
            print(f"config {i}: {file}")

        topk_ids_list = [load_topk_ids(topk_ids_dir, i) for i in range(100)]
        torch.cuda.manual_seed_all(0)
        with torch.cuda.device(self.device_id) if is_hip() else nullcontext():
            for bs in num_tokens:
                kernel_times = []
                cfgs = []
                for configs in cmp_configs:
                    cfg_org = configs[min(configs.keys(), key=lambda x: abs(x - bs))]
                    cfgs.append(cfg_org)
                    cfg = cfg_org.copy()
                    cfg.pop("USE_TMA", None)
                    kernel_time = benchmark_config(
                        cfg,
                        bs,
                        num_experts,
                        shard_intermediate_size,
                        hidden_size,
                        topk,
                        dtype,
                        use_fp8_w8a8,
                        use_int8_w8a8,
                        use_int8_w8a16,
                        topk_ids_list,
                        block_shape,
                        ep_size=ep_size,
                    )
                    kernel_times.append(kernel_time)
                print(f"batch_size={bs=}:")
                for i, cfg in enumerate(cfgs):
                    print(f"  config {i} {cfg}: {kernel_times[i]}")


def save_configs_sep(
    configs: Dict[int, BenchmarkConfig],
    num_experts: int,
    shard_intermediate_size: int,
    hidden_size: int,
    topk: int,
    dtype: torch.dtype,
    use_fp8_w8a8: bool,
    use_int8_w8a8: bool,
    use_int8_w8a16: bool,
    block_shape: List[int],
    down_moe: bool = False,
) -> None:
    dtype_str = get_config_dtype_str(
        dtype,
        use_int8_w8a16=use_int8_w8a16,
        use_fp8_w8a8=use_fp8_w8a8,
        use_int8_w8a8=use_int8_w8a8,
    )

    # NOTE(woosuk): The current naming convention uses w2.shape[2], which
    # is the intermediate size after silu_and_mul.
    filename = get_config_file_name(
        num_experts,
        shard_intermediate_size // 2,
        dtype_str,
        block_shape,
        down_moe=down_moe,
    )

    print(f"Writing best config to {filename}...")
    with open(filename, "w") as f:
        json.dump(configs, f, indent=4)
        f.write("\n")


def main(args: argparse.Namespace):
    print(args)

    model_config = get_model_config(
        args.model,
        args.tp_size,
        args.ep_size,
        args.disable_shared_experts_fusion,
        args.topk_ids_dir,
    )

    E = model_config["num_experts"]
    topk = model_config["topk"]
    hidden_size = model_config["hidden_size"]
    shard_intermediate_size = model_config["shard_intermediate_size"]
    dtype = model_config["dtype"]
    block_shape = model_config["block_shape"]

    use_fp8_w8a8 = args.dtype == "fp8_w8a8"
    use_int8_w8a8 = args.dtype == "int8_w8a8"
    use_int8_w8a16 = args.dtype == "int8_w8a16"

    topk_ids_dir = args.topk_ids_dir
    if args.batch_size is None:
        batch_sizes = get_default_batch_sizes()
        batch_sizes.reverse()
    else:
        batch_sizes = [args.batch_size]

    if args.cmp_configs is not None:
        worker = BenchmarkWorker(args.seed)
        worker.cmp_configs(
            batch_sizes,
            E,
            shard_intermediate_size,
            hidden_size,
            topk,
            dtype,
            use_fp8_w8a8,
            use_int8_w8a8,
            use_int8_w8a16,
            block_shape,
            args.cmp_configs,
            topk_ids_dir,
            args.ep_size,
        )
        return

    if len(batch_sizes) == 1:
        worker = BenchmarkWorker(args.seed)
        if args.tune:
            search_space = get_configs_compute_bound()
            worker.tune(
                batch_sizes[0],
                E,
                shard_intermediate_size,
                hidden_size,
                topk,
                dtype,
                use_fp8_w8a8,
                use_int8_w8a8,
                use_int8_w8a16,
                block_shape,
                search_space,
                topk_ids_dir,
                args.ep_size,
            )
        else:
            cfg = {
                "BLOCK_SIZE_M": args.configs[0],
                "BLOCK_SIZE_N": args.configs[1],
                "BLOCK_SIZE_K": args.configs[2],
                "GROUP_SIZE_M": args.configs[3],
                "num_warps": args.configs[4],
                "num_stages": args.configs[5],
            }

            _, (t0, t0_tma, t1, t1_tma) = worker.benchmark(
                args.batch_size,
                E,
                shard_intermediate_size,
                hidden_size,
                topk,
                dtype,
                use_fp8_w8a8,
                use_int8_w8a8,
                use_int8_w8a16,
                block_shape,
                cfg,
                topk_ids_dir,
                args.ep_size,
            )
            print(f"{t0=}, {t0_tma=}, {t1=}, {t1_tma=}")
        return

    assert args.tune

    ray.init()
    num_gpus = int(ray.available_resources()["GPU"])
    workers = [
        ray.remote(num_gpus=1)(BenchmarkWorker).remote(args.seed)
        for _ in range(num_gpus)
    ]

    def _distribute(method: str, inputs: List[Any]) -> List[Any]:
        outputs = []
        worker_idx = 0
        for input_args in inputs:
            worker = workers[worker_idx]
            worker_method = getattr(worker, method)
            output = worker_method.remote(*input_args)
            outputs.append(output)
            worker_idx = (worker_idx + 1) % num_gpus
        return ray.get(outputs)

    search_space = get_configs_compute_bound()
    if block_shape is not None:
        block_n, block_k = block_shape[0], block_shape[1]
        search_space = [
            config for config in search_space if block_k % config["BLOCK_SIZE_K"] == 0
        ]
    filename = get_config_filename(
        E,
        shard_intermediate_size,
        hidden_size,
        topk,
        dtype,
        use_fp8_w8a8,
        use_int8_w8a8,
        use_int8_w8a16,
        False,
        block_shape,
    )
    print(
        f"Start tuning over {len(search_space)} configurations to create {filename}..."
    )

    start = time.perf_counter()
    configs = _distribute(
        "tune",
        [
            (
                batch_size,
                E,
                shard_intermediate_size,
                hidden_size,
                topk,
                dtype,
                use_fp8_w8a8,
                use_int8_w8a8,
                use_int8_w8a16,
                block_shape,
                search_space,
                topk_ids_dir,
                args.ep_size,
            )
            for batch_size in batch_sizes
        ],
    )
    print(f"{configs=}", flush=True)
    cur_time = time.strftime("%Y-%m-%d %H:%M:%S", time.localtime())
    with open(f"tuning_result_{cur_time}.txt", "w") as f:
        print(configs, file=f)
    batch_sizes.reverse()
    configs0 = [config[0] for config in configs]
    configs1 = [config[1] for config in configs]
    configs0.reverse()
    configs1.reverse()
    best_configs0 = {M: sort_config(config) for M, config in zip(batch_sizes, configs0)}
    save_configs_sep(
        best_configs0,
        E,
        shard_intermediate_size,
        hidden_size,
        topk,
        dtype,
        use_fp8_w8a8,
        use_int8_w8a8,
        use_int8_w8a16,
        block_shape,
    )

    best_configs1 = {M: sort_config(config) for M, config in zip(batch_sizes, configs1)}
    save_configs_sep(
        best_configs1,
        E,
        shard_intermediate_size,
        hidden_size,
        topk,
        dtype,
        use_fp8_w8a8,
        use_int8_w8a8,
        use_int8_w8a16,
        block_shape,
        down_moe=True,
    )
    end = time.perf_counter()
    print(f"Tuning took {end - start:.2f} seconds")


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument(
        "--model", type=str, default="mistralai/Mixtral-8x7B-Instruct-v0.1"
    )
    parser.add_argument("--tp-size", "--tp", type=int, default=2)
    parser.add_argument("--ep-size", "--ep", type=int, default=1)
    parser.add_argument(
        "--dtype",
        type=str,
        choices=["auto", "fp8_w8a8", "int8_w8a16", "int8_w8a8"],
        default="auto",
    )
    parser.add_argument("--seed", type=int, default=0)
    parser.add_argument("--batch-size", type=int, required=False)
    parser.add_argument("--tune", action="store_true")
    parser.add_argument("--disable-shared-experts-fusion", action="store_true")
    parser.add_argument("--configs", type=int, nargs="+", required=False)
    parser.add_argument("--topk-ids-dir", type=str, required=True)
    parser.add_argument("--cmp-configs", type=str, nargs="+", required=False)
    args = parser.parse_args()

    main(args)
```

## Start Tuning

Here I assume you have installed Transformer 5.x. See [GLM-4.7-Flash Model Card](https://huggingface.co/zai-org/GLM-4.7-Flash#sglang).

```bash
pip install git+https://github.com/huggingface/transformers.git@76732b4e7120808ff989edbd16401f61fa6a0afa
```

I'll not go into details, you can refer to the previous article.

```bash
python tuning_fused_moe_triton.py \
--model /home/james/models/GLM-4.7-Flash-REAP-23B-A3B-FP8-Dynamic \
--tp-size 1 \
--dtype fp8_w8a8 \
--per-channel-quant \
--tune
```

## One More Thing

I haven't tested `tuning_fused_moe_triton_sep.py`, but if someone has tested it, please share.
