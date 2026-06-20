# Gmail last-24-hours summary workflow

Use this pattern for scheduled email-summary jobs that need Gmail/Google Workspace data and a clean categorized report.

## Preferred path: `gws` Gmail API

1. Verify `gws` exists and use Gmail search syntax with a narrow query:
   ```bash
   gws gmail users messages list \
     --params '{"userId":"me","q":"newer_than:1d","maxResults":500,"includeSpamTrash":true}' \
     --format json
   ```
2. For each returned message ID, fetch metadata only unless body content is required:
   ```bash
   gws gmail users messages get \
     --params '{"userId":"me","id":"MSG_ID","format":"metadata","metadataHeaders":["Subject","From","Date","List-Unsubscribe","Precedence","Auto-Submitted"]}' \
     --format json
   ```
3. Prefer `internalDate` for filtering the exact 24-hour window; fall back to the `Date` header when needed.
4. Treat unread (`UNREAD` label) as Action Required. Also classify keyword hits such as `action`, `urgent`, and `request` as Action Required.

## Robust parsing notes

- `gws` and IMAP fallbacks may print non-JSON status/warning text before the JSON payload (for example keyring status or IMAP codec warnings). Do **not** blindly parse from the first `{` or `[` because warning text can contain bracket characters too. In scripts, scan candidate `{`/`[` positions and use `json.JSONDecoder().raw_decode(...)` on each until one succeeds; then parse only that payload instead of assuming the entire stdout is JSON.
- If `gws` returns an auth error, report the auth problem directly and do not invent a Google Workspace result. Use Himalaya only as a clearly-labeled read-only fallback when configured.

## Safe fallback when Gmail API auth is unavailable

If the mailbox is also configured in Himalaya, use IMAP as a read-only fallback for reporting:

```bash
himalaya envelope list --folder '[Gmail]/All Mail' --page 1 --page-size 100 --output json
```

Then paginate until either:
- the page contains no messages within the last 24 hours, or
- the page size is smaller than requested.

Himalaya envelope IDs are folder-relative. Re-list if later actions need a message ID. For a report-only job, subject/from/date/flags from `envelope list` are usually enough.

## Suggested categories

- **Action Required**: unread messages or messages whose subject/from/snippet contain `action`, `urgent`, or `request`. If the user explicitly says unread belongs here, obey it even when a message also looks promotional; mention this rule briefly if the category appears noisy.
- **Notifications**: automated alerts, newsletters, receipts, statements, GitHub/CI alerts, no-reply/notification senders, or operational status messages.
- **To Delete/Ignore**: marketing, promotions, coupons, sales, feedback requests, and obvious junk. For cleaner user-facing output, put read marketing here; unread marketing may remain Action Required under the explicit unread rule unless the user asks for semantic-only classification.

For scheduled delivery, include a short source note if a fallback was used, then list only subject and sender under each category unless the user requested more detail.
