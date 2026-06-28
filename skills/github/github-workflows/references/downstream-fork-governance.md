# Downstream Fork Governance Pattern

Use this when a repo should operate as a downstream/customer/domain fork of an upstream base repo, but the existing GitHub repository should remain in place rather than being recreated as a literal GitHub fork.

## Pattern

Prefer a lightweight enforceable governance layer in each downstream repo:

- Add an `upstream` Git remote pointing at the base repo.
- Add `.fork-allowlist` with narrow path regexes for files allowed to diverge.
- Add `.fork-baseline` that pins accepted legacy divergence by path + blob id.
- Add `scripts/check-fork-divergence.sh [upstream-ref]` to compare downstream against upstream and fail on non-allowlisted, non-baselined drift.
- Add `.github/workflows/fork-guard.yml` to run the guard on PRs and pushes to `main`.
- Document the contract in `AGENTS.md`/`CLAUDE.md`/README: shared work lands upstream-first; downstream-only work stays inside the allowlist or requires explicit baseline review.

## Why this over a metadata-only plan

A machine-readable metadata file such as `.coreguard/upstream.yaml` can describe topology, but it does not enforce drift by itself. If a fork-guard implementation already exists, do not add a duplicate metadata system unless the user explicitly wants both. Finish/review the enforceable guard first.

## Review checklist

- `.fork-allowlist` is narrow; prefer exact files/directories over broad globs.
- `.fork-baseline` is treated as sensitive accepted legacy divergence, not a blanket bypass.
- The guard fails if a shared file changes outside allowlist/baseline.
- The workflow can access the upstream repo. If upstream is private, use a repo secret such as `UPSTREAM_TOKEN`; if absent, the workflow may skip with a notice, but full enforcement requires the secret.
- The PR links the parent downstream-governance issue/epic.
- Domain seed/demo/customer files do not leak between upstream/downstream repos.

## Local validation commands

```bash
git remote get-url upstream || git remote add upstream https://github.com/<owner>/<upstream>.git
git fetch upstream main
bash scripts/check-fork-divergence.sh upstream/main
git diff --stat main...HEAD
git diff main...HEAD -- .fork-allowlist .fork-baseline .github/workflows/fork-guard.yml scripts/check-fork-divergence.sh AGENTS.md CLAUDE.md README.md
```

## CI triage

If unrelated CI checks fail on a governance PR:

1. Check whether the same audit/test failure exists on downstream `main`.
2. If pre-existing, track it separately and document it on the PR.
3. If introduced by the governance branch, fix it before merge.
4. Do not mix broad dependency upgrades into the governance PR unless branch protection requires it.
