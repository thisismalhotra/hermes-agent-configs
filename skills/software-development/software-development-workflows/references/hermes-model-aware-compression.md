# Hermes model-aware compression defaults

Use this reference when changing Hermes Agent compression/model-default behavior, especially changes that affect gateway surfaces (Telegram/iMessage/Discord/etc.).

## Durable lesson

For large-context model exceptions, prefer a **silent model-aware default** over a global threshold change or repeated lifecycle notice.

Example pattern from Codex `gpt-5.5`:

- Keep global `compression.threshold` at `0.50` for safety across smaller/fuzzier model windows.
- Apply a route/model-specific override only for `provider: openai-codex` + `gpt-5.5` family.
- Preserve an opt-out config key if one already exists, but treat it as a legacy opt-out rather than a user-facing warning mechanism.
- Do not replay informational startup notices into gateway chats; repeated Telegram/iMessage lifecycle messages are user-visible noise.

## Implementation checklist

1. Locate both the pure helper and the runtime init path.
   - Helper-level tests prove matching/route scoping.
   - Runtime-init tests prove the effective compressor threshold and absence of warning replay.
2. Preserve global defaults and model-route scoping.
   - Same model slug on other providers should keep the user/global threshold.
3. Remove or avoid user-facing notice plumbing for silent defaults.
   - Check CLI/TUI print paths.
   - Check gateway `_compression_warning` / replay paths.
4. Update docs/config comments so they say "silent model-aware default" instead of "notice" or "autoraise message".
5. Verify with focused tests using the canonical test runner when available.

## Regression assertions worth adding

- Effective threshold is `0.85` for Codex `gpt-5.5` when opt-out is enabled/default.
- Global threshold remains `0.50` in config/defaults.
- `_compression_warning` is `None` for silent model defaults.
- Gateway replay callback receives no lifecycle event for the silent default.
- CLI output does not contain strings like `auto-compaction was raised` or `Opt back out`.

## Pitfall

Do not encode transient local test-environment setup failures as rules. If pytest or dev dependencies are missing locally, install the declared dev dependency and continue verification; the durable lesson is to run the project’s canonical focused tests after setup, not that the test runner is broken.
