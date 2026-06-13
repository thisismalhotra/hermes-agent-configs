---
name: creative-design-artifacts
description: "Use when creating visual design artifacts: HTML mockups, landing pages, dashboards, infographics, architecture diagrams, Excalidraw sketches, design-token docs, or design-system inspired prototypes."
version: 1.0.0
author: Hermes Agent
license: MIT
metadata:
  hermes:
    tags: [design, html, diagrams, infographics, prototypes, excalidraw, design-systems]
    related_skills: [creative-media-generation, humanizer]
---

# Creative Design Artifacts

## Overview
This umbrella covers static or interactive visual artifacts meant to communicate ideas: HTML prototypes, one-off web designs, architecture diagrams, infographics, Excalidraw drawings, and DESIGN.md token specs. Use labeled subsections to select the right output format.

Archived predecessor packages remain recoverable with their templates/assets intact: `architecture-diagram`, `baoyu-infographic`, `claude-design`, `design-md`, `excalidraw`, `popular-web-designs`, and `sketch`.

## When to Use
- The user asks for a visual mockup, dashboard, landing page, deck-like artifact, or prototype.
- The user asks for architecture/cloud/infra diagrams.
- The user asks for infographic layouts or Chinese/English visual summaries.
- The user asks for Excalidraw-style hand-drawn diagrams.
- The user asks to author or validate DESIGN.md design token specs.
- The user asks to imitate a recognizable web design system style.

## Shared Design Workflow
1. Identify audience, medium, dimensions, and required deliverable format.
2. Choose the artifact type: HTML/CSS, SVG, Excalidraw JSON, DESIGN.md, or template-backed markdown.
3. Generate a complete file, not a fragment, unless explicitly asked.
4. Validate by opening/rendering or running the relevant parser/exporter when available.
5. Return the file path or rendered media and summarize design choices.

## HTML Mockups and Prototypes
- Use when the user wants a landing page, dashboard, app screen, or side-by-side variants.
- Prefer self-contained HTML/CSS/JS for easy preview.
- Create 2-3 variants for exploratory design tasks unless the user specifies a single direction.

## Architecture Diagrams
- Use dark-themed SVG/HTML diagrams for infra/cloud/system architecture.
- Make labels legible and group subsystems visually.
- Verify rendered output; don't rely on unviewed SVG text.

## Infographics
- Convert dense content into a clear visual hierarchy: title, key insight, sections, data callouts, conclusion.
- Choose layout/style intentionally rather than dumping prose into boxes.

## Excalidraw
- Use Excalidraw JSON when the user wants hand-drawn, editable diagrams.
- Keep element IDs unique and validate/import when possible.

## DESIGN.md
- Use for design token specifications, validation, and export workflows.
- Preserve token semantics; don't turn specs into one-off CSS without asking.

## Design-System Inspiration
- Use named design-system templates as inspiration, not plagiarism.
- Capture typography, spacing, color rhythm, and component feel.

## Common Pitfalls
1. Delivering descriptions instead of files or renderable artifacts.
2. Creating unvalidated HTML/SVG/JSON that cannot open.
3. Mixing too many styles in one artifact.
4. Ignoring the user's requested format.

## Verification Checklist
- [ ] Deliverable format matches request.
- [ ] File is complete and renderable/parseable.
- [ ] Visual hierarchy and labels are clear.
- [ ] Output path or media handle returned.
