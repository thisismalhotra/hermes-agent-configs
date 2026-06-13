---
name: kanban-workflows
description: "Use when coordinating Hermes Kanban work: orchestrator decomposition, worker execution, task handoffs, lifecycle discipline, and board hygiene. Umbrella for Kanban agent roles."
version: 1.0.0
author: Hermes Agent
license: MIT
metadata:
  hermes:
    tags: [kanban, orchestration, workers, project-management, devops]
    related_skills: [automation-orchestration]
---

# Kanban Workflows

## Overview
This umbrella covers Hermes Kanban coordination as a class: splitting work, routing tasks, worker execution rules, lifecycle updates, and avoiding orchestrator/worker role confusion.

Archived predecessor packages remain recoverable: `kanban-orchestrator` and `kanban-worker`.

## When to Use
- The user asks to run or coordinate a Kanban-backed multi-agent workflow.
- Work must be decomposed into independent board items.
- A worker needs clear task boundaries, acceptance criteria, and handoff notes.
- The board has stale, blocked, or mis-scoped items that need triage.

## Orchestrator Responsibilities
- Decompose goals into small, independently verifiable tasks.
- Assign each card a clear owner, acceptance criteria, inputs, outputs, and dependencies.
- Avoid doing worker implementation work unless explicitly necessary to unblock.
- Keep board state current: pending, in progress, blocked, review, done.

## Worker Responsibilities
- Read the card, linked context, and acceptance criteria before acting.
- Work only within the assigned scope; surface blockers rather than expanding scope silently.
- Produce a concise completion note with files changed, tests run, and remaining risks.
- Do not mark done until verification evidence exists.

## Handoffs and Quality Gates
- Use checklists for reproducibility: commands run, artifacts created, links/IDs returned.
- Separate blocker reports from completion reports.
- Require review for broad refactors, security-sensitive changes, or unclear acceptance criteria.

## Common Pitfalls
1. Orchestrator temptation: implementing tasks directly instead of shaping and routing them.
2. Worker drift: solving adjacent problems not on the card.
3. Status lies: moving cards to done without verification evidence.
4. Missing dependencies: starting work before upstream artifacts are available.

## Verification Checklist
- [ ] Cards have owners, scope, and acceptance criteria.
- [ ] Board statuses match reality.
- [ ] Worker completion notes include real verification output.
- [ ] Blockers are explicit and actionable.
