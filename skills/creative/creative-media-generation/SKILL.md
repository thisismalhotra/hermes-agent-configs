---
name: creative-media-generation
description: "Use when generating creative media with code or AI tools: ASCII art/video, p5.js sketches, Manim animations, TouchDesigner scenes, ComfyUI workflows, audio/music prompts, and multimedia exports."
version: 1.0.0
author: Hermes Agent
license: MIT
metadata:
  hermes:
    tags: [creative-coding, ascii, video, animation, p5js, manim, comfyui, music]
    related_skills: [creative-design-artifacts]
---

# Creative Media Generation

## Overview
This umbrella covers generative media workflows: text/ASCII art, ASCII video, p5.js sketches, Manim animations, TouchDesigner MCP scenes, ComfyUI image/video/audio workflows, and music/audio generation prompts.

Archived predecessor packages remain recoverable with their reference files and scripts intact: `ascii-art`, `ascii-video`, `p5js`, `manim-video`, `touchdesigner-mcp`, `comfyui`, `songwriting-and-ai-music`, `heartmula`, `songsee`, `gif-search`, and `youtube-content`. AudioCraft-style model operations are covered by `mlops-model-workflows`.

## When to Use
- The user asks for generated art, creative coding, animation, video, GIFs, or audio/music.
- The task needs a runnable sketch, render script, workflow JSON, or media export.
- The user asks to transform media into ASCII, spectrograms, summaries, or prompts.

## Shared Media Workflow
1. Determine desired medium, duration/dimensions, style, and final format.
2. Choose the toolchain: terminal art, p5.js, Manim, TouchDesigner, ComfyUI, audio CLI/model, or transcript/GIF tooling.
3. Create a runnable artifact with dependencies and export commands.
4. Run or validate the artifact; inspect logs and output files.
5. Return the media path/URL and concise usage notes.

## ASCII Art and Video
- Use pyfiglet/cowsay/boxes/image-to-ASCII for static terminal art.
- For video, preserve timing and audio considerations; test short clips before long renders.

## p5.js and Browser Creative Coding
- Produce self-contained sketches with clear canvas sizing and deterministic seeds when useful.
- Validate in a browser when visual correctness matters.

## Manim Animations
- Plan scenes before coding; keep mathematical explanations paced and legible.
- Render a low-quality preview before a final export.

## TouchDesigner MCP
- Use MCP control for live operator graphs, parameters, wiring, and animation.
- Verify the network state after mutations.

## ComfyUI and AI Media Workflows
- Preserve workflow graph integrity and model/node requirements.
- Fetch logs and validate generated outputs instead of assuming success.

## Music and Audio
- Separate songwriting craft (lyrics, structure, tags) from tool execution.
- For spectrogram/features, return generated plots/data paths and explain axes/features.

## GIF and YouTube Content
- Use GIF search/download for reaction media; respect result relevance and licensing/context.
- Use transcript extraction for YouTube summaries, threads, and blog transformations.

## Common Pitfalls
1. Returning prompts without generating or validating the requested artifact.
2. Running expensive renders before a cheap preview.
3. Losing support files or workflow references when moving between tools.
4. Ignoring codec, duration, size, or platform constraints.

## Verification Checklist
- [ ] Medium/toolchain selected intentionally.
- [ ] Artifact or media output was actually generated or validated.
- [ ] Output path/URL returned.
- [ ] Dependencies, seeds, and rerun commands documented when relevant.
