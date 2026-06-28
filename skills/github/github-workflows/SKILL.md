---
name: github-workflows
description: "Use when working with GitHub repositories, authentication, issues, pull requests, reviews, releases, or codebase inspection. Umbrella workflow for gh CLI, git, REST API, and repo quality checks."
version: 1.0.0
author: Hermes Agent
license: MIT
metadata:
  hermes:
    tags: [github, gh, git, pull-requests, issues, reviews, repositories]
    related_skills: [requesting-code-review, systematic-debugging]
---

# GitHub Workflows

## Overview
This umbrella covers GitHub work as a class: authenticating, inspecting repositories, managing issues, creating PRs, reviewing PRs, troubleshooting CI, and publishing repository artifacts. Prefer this class-level entry over narrow task skills; load the relevant subsection based on the user's actual GitHub goal.

Archived predecessor skills remain recoverable as complete packages if deep command examples are needed: `github-auth`, `github-repo-management`, `github-issues`, `github-pr-workflow`, `github-code-review`, and `codebase-inspection`.

## When to Use
- The user asks to clone, fork, create, configure, or inspect a GitHub repository.
- The user asks to authenticate `gh`, fix HTTPS/SSH token problems, or diagnose Git remotes.
- The user asks to create, triage, label, assign, or close issues.
- The user asks to create a branch, commit, open a PR, update a PR, monitor CI, merge, or release.
- The user asks for PR/code review using diffs, comments, REST API, or `gh`.
- The user asks for language/LOC/codebase composition via tools such as `pygount`.

## Core Workflow
1. Establish repository context with `git status --short --branch`, `git remote -v`, and `gh repo view` when relevant.
2. Verify authentication before remote side effects: `gh auth status`; for git pushes check credential helper/SSH remote style.
3. Use `gh` for GitHub-native objects (`issue`, `pr`, `api`, `run`) and `git` for repository state.
4. Before editing or committing, inspect current changes with `git diff --stat` and `git diff`.
5. After any side effect, read back the created/updated object (`gh issue view`, `gh pr view`, `gh run list`, `git log -1`).

## Authentication and Remotes
- Prefer `gh auth login` or an existing `GH_TOKEN`/`GITHUB_TOKEN`; never ask the user to paste secrets into chat.
- Diagnose mismatch between HTTPS and SSH remotes before changing credentials.
- Use `gh auth setup-git` when `gh` is authenticated but `git push` still fails over HTTPS.

## Repository Management
- For repo creation/forking, confirm owner/name/visibility before side effects.
- Preserve remotes intentionally: `origin` for the write target, `upstream` for canonical source.
- For existing customer/domain repos that should behave as downstreams of an upstream base without recreating GitHub fork lineage, prefer an enforceable fork-guard contract: `upstream` remote + narrow `.fork-allowlist` + `.fork-baseline` + `scripts/check-fork-divergence.sh` + CI workflow. See `references/downstream-fork-governance.md`.
- For releases, verify tags locally and remotely before creating a release.

## Issues
- Gather title, body, labels, assignees, milestone, and reproduction evidence.
- Use templates when available; otherwise include expected behavior, actual behavior, steps, environment, and evidence.
- After creation, return the issue URL/number from `gh issue view --json url,number`.

## GitHub Projects v2 Roadmap/Epic Work
- For roadmap epics, inspect existing `[Epic]` conventions, labels, and the target Project v2 fields before creating new items.
- Create the GitHub issue first, add it to the Project v2 board, then populate board fields (`Status`, `Area`, `Priority`, `Sprint or Iteration`, `Size`, text/date fields) using Project item IDs and field option IDs.
- Use GraphQL to discover iteration IDs; `gh project field-list` may show fields/options but not enough iteration detail for reliable sprint assignment.
- Verify both the issue (`gh issue view`) and Project item field values before reporting success.
- See `references/github-projects-v2-roadmap-epics.md` for a command-level Projects v2 epic creation pattern.

## Pull Requests and CI
- Create a topic branch, make focused commits, and open PRs with explicit test evidence.
- Use `gh pr checks --watch` or `gh run watch` for CI; if failing, inspect logs rather than guessing.
- When merging, obey repository merge policy and only merge when explicitly requested or clearly in scope.

## Code Review
- Review the diff, not just files. Use `gh pr diff`, targeted file reads, and test evidence.
- Separate blocking correctness/security issues from suggestions.
- If posting comments, verify line anchors against the current PR diff.

## Codebase Inspection
- Use codebase metrics to guide review or planning, not as a substitute for semantic inspection.
- Prefer `pygount`/language-aware counters when available; exclude vendored/build directories.

## Common Pitfalls
1. Creating PRs from a dirty unrelated working tree. Always inspect status and diff first.
2. Treating auth failure as a code failure. Verify `gh auth status` and remote URL style.
3. Posting review comments without validating line numbers against the current diff.
4. Reporting CI pass/fail without reading back the run/check result.

## Verification Checklist
- [ ] Repository/owner/branch context verified.
- [ ] Authentication verified before remote side effects.
- [ ] Object URLs or IDs read back after creation/update.
- [ ] Git status clean or expected after edits.
- [ ] CI/test evidence included for PR work.
