---
name: software-development-workflows
description: "Use when improving software systems: debugging Node/Python, TDD, spikes, simplification/refactoring, pre-commit review, codebase inspection, and systematic implementation quality gates."
version: 1.0.0
author: Hermes Agent
license: MIT
metadata:
  hermes:
    tags: [software-development, debugging, tdd, refactoring, code-review, spike]
    related_skills: [github-workflows, autonomous-coding-agents]
---

# Software Development Workflows

## Overview
This umbrella covers general software-development methods: systematic debugging, language/runtime debuggers, test-driven development, throwaway spikes, simplification/refactoring, code review, and codebase inspection. It deliberately does not replace the protected `plan` skill.

Archived predecessor packages remain recoverable: `node-inspect-debugger`, `python-debugpy`, `requesting-code-review`, `simplify-code`, `spike`, `systematic-debugging`, `test-driven-development`, `codebase-inspection`, and `jupyter-live-kernel`.

## When to Use
- The user asks to debug failing code, tests, runtime behavior, or production-like issues.
- The user asks to build a feature with tests first or improve test coverage.
- The user asks for a spike/prototype before implementation.
- The user asks to simplify/refactor recent changes.
- The user asks for pre-commit review, security checks, or quality gates.
- The user asks for interactive Python exploration or live notebook-style data/code iteration.

## Shared Workflow
1. Inspect repository state and project instructions before editing.
2. Reproduce the issue or establish a failing/acceptance test.
3. Choose the method: debugger, TDD loop, spike, refactor pass, or review pass.
4. Make minimal, focused changes.
5. Run real verification commands and report actual output.

## Systematic Debugging
- Follow understand → reproduce → isolate → fix → verify.
- Avoid speculative fixes before a confirmed failure mode.

## Runtime Debuggers
- Node: use `--inspect` and Chrome DevTools Protocol when stepping or runtime state is needed.
- Python: use `pdb`/`debugpy` when print/log inspection is insufficient.
- Never leave debug listeners exposed unnecessarily.

## Test-Driven Development
- RED: write or run a failing test that captures the desired behavior.
- GREEN: implement the smallest change to pass.
- REFACTOR: simplify while keeping tests green.

## Spikes
- Use throwaway experiments to validate unknown APIs, performance, feasibility, or design options.
- Keep spike code separate from production unless intentionally promoted.

## Simplification and Review
- Use diff-oriented review for correctness, security, maintainability, and test adequacy.
- For simplification, remove duplication and complexity without broadening scope.

## Codebase Inspection and Jupyter Iteration
- Use metrics and live kernels to understand structure or explore data, but verify conclusions with source/tests.
- Do not let exploratory notebooks become hidden production dependencies.

## Common Pitfalls
1. Editing before reproducing or defining acceptance criteria.
2. Treating a debugger session as proof without a regression test.
3. Keeping spike artifacts in production paths accidentally.
4. Reviewing only changed files while missing generated/config/security implications.

## Verification Checklist
- [ ] Initial repo state inspected.
- [ ] Failure/acceptance criterion established.
- [ ] Changes are focused and reviewed.
- [ ] Tests/lints/builds/debug probes run with real output.
- [ ] Temporary spike/debug artifacts removed or documented.
