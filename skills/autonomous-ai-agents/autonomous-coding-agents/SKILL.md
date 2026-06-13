---
name: autonomous-coding-agents
description: "Use when delegating software work to autonomous coding CLIs such as Claude Code, Codex, or OpenCode. Umbrella for agent setup, prompting, monitoring, review, and integration."
version: 1.0.0
author: Hermes Agent
license: MIT
metadata:
  hermes:
    tags: [coding-agents, claude-code, codex, opencode, delegation, autonomous]
    related_skills: [github-workflows, requesting-code-review, systematic-debugging]
---

# Autonomous Coding Agents

## Overview
This umbrella covers using external autonomous coding CLIs to implement, debug, review, or prototype software changes. It consolidates tool-specific playbooks for Claude Code, OpenAI Codex, and OpenCode into one class-level workflow.

Archived predecessor packages remain recoverable: `claude-code`, `codex`, and `opencode`.

## When to Use
- The user explicitly asks to use a coding agent CLI.
- A software task is large enough to benefit from an isolated agent subprocess.
- You need parallel independent implementations/reviews.
- You need an agent to explore a repo while you keep orchestration context clean.

Do not use this when a normal tool call or direct edit is simpler, when the task needs secrets, or when the user has not authorized an external agent with side effects.

## Universal Agent Workflow
1. Inspect repo state first: `git status --short --branch`, project files, tests, and instructions.
2. Define a tight mission: goal, constraints, files/areas, forbidden side effects, expected verification.
3. Run the chosen CLI in an isolated worktree or clean branch when possible.
4. Monitor logs/output for stalls, permission prompts, or scope creep.
5. Verify the resulting diff yourself. Subagent self-reports are not proof.
6. Run tests/lints/builds relevant to the change and report real output.

## Claude Code
- Best for deep repo navigation, multi-file implementation, and iterative debugging.
- Provide explicit stop conditions and require a concise final summary with changed files and tests.

## Codex
- Best for focused coding tasks, patch generation, and CLI-friendly repo edits.
- Keep prompts concrete; include failing commands and exact acceptance criteria.

## OpenCode
- Best for terminal-first workflows, feature work, and PR review loops.
- Ask for small commits or a bounded diff; verify independently.

## Integration and Review
- Treat agent output as untrusted until reviewed.
- Use `git diff`, targeted file reads, and real tests to verify.
- If opening a PR, use the GitHub workflow umbrella for branch/PR/CI steps.

## Common Pitfalls
1. Delegating before understanding the repo state.
2. Letting an agent run against a dirty tree with unrelated changes.
3. Trusting the agent's claim that tests passed without rerunning or inspecting logs.
4. Giving broad prompts that invite architecture churn.

## Verification Checklist
- [ ] Repo state captured before delegation.
- [ ] Prompt included constraints and acceptance tests.
- [ ] Diff reviewed by the orchestrator.
- [ ] Relevant tests/lints/builds run and output recorded.
- [ ] No secrets or unsafe prompts were exposed.
