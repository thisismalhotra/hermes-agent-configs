---
name: mlops-model-workflows
description: "Use when working with ML/LLM models across the lifecycle: Hugging Face assets, local/server inference, evaluation, experiment tracking, quantization, model surgery, and specialized model tools."
version: 1.0.0
author: Hermes Agent
license: MIT
metadata:
  hermes:
    tags: [mlops, llm, inference, evaluation, huggingface, wandb, vllm, llama-cpp]
    related_skills: [research-workflows]
---

# MLOps Model Workflows

## Overview
This umbrella covers model operations as a class: discovering/downloading/uploading model assets, serving LLMs, running local GGUF inference, benchmarking, tracking experiments, quantizing, ablating/refusal analysis, and using specialized audio/vision models.

Archived predecessor packages remain recoverable with references/templates/scripts intact: `huggingface-hub`, `llama-cpp`, `serving-llms-vllm`, `evaluating-llms-harness`, `weights-and-biases`, `obliteratus`, `segment-anything-model`, and `audiocraft-audio-generation`.

## When to Use
- The user asks to find, download, upload, or inspect models/datasets on Hugging Face.
- The user asks to serve or benchmark an LLM locally or via vLLM/llama.cpp.
- The user asks for quantization, GGUF, OpenAI-compatible servers, or GPU throughput tuning.
- The user asks to evaluate models with lm-eval-harness or log experiments in W&B.
- The user asks for model surgery/abliteration or specialized SAM/AudioCraft workflows.

## Shared Workflow
1. Identify model, task, hardware, precision, and output constraints.
2. Verify required commands/credentials before long downloads or runs.
3. Use a small smoke test before full training/evaluation/serving jobs.
4. Capture exact versions, model IDs, commit revisions, seeds, and commands.
5. Verify outputs with logs, metrics, API probes, or generated artifacts.

## Hugging Face Assets
- Use `hf`/Hub APIs for model and dataset discovery, downloads, uploads, and auth checks.
- Pin revisions for reproducibility when results matter.

## Inference Serving
- `llama.cpp`: best for GGUF local inference, CPU/Metal/GPU tests, quantized models.
- `vLLM`: best for high-throughput server deployment and OpenAI-compatible APIs.
- Always probe health/completions endpoints after server startup.

## Evaluation and Tracking
- Use lm-eval-harness for benchmark suites; record task names, few-shot settings, batch size, and model args.
- Use W&B for runs, sweeps, artifacts, and dashboards; verify project/entity before logging.

## Model Surgery and Specialized Models
- For abliteration/refusal work, preserve baseline metrics and compare before/after behavior.
- For SAM, define prompts (points/boxes/masks) and inspect generated masks.
- For AudioCraft, validate generated audio files and sampling settings.

## Common Pitfalls
1. Launching full benchmarks before a smoke test.
2. Omitting model revision, quantization, or hardware details.
3. Reporting server readiness before an actual API probe.
4. Mixing W&B entities/projects or leaking tokens.

## Verification Checklist
- [ ] Model/task/hardware constraints captured.
- [ ] Credentials and commands available.
- [ ] Smoke test completed before expensive run.
- [ ] Metrics/artifacts/API probes recorded.
- [ ] Reproducibility details included.
