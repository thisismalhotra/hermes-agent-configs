# Gmail Read-Only Fallback via Himalaya

Use this when Gmail/Google Workspace OAuth is revoked, missing scopes, or otherwise unavailable, but the user only needs to *read/search* mail.

## Pattern

1. Try the configured Google Workspace path first when the task depends on Gmail/Calendar/Drive integration.
2. If `setup.py --check` or `gws` returns an auth error such as `invalid_grant`, do not stop if the request is read-only email.
3. Check whether Himalaya is configured (`himalaya account list`). If a default account exists, use it as a read-only fallback and clearly label that the Google token needs re-auth later.
4. Use structured output for search:
   - `himalaya envelope list --page-size 10 --output json 'subject "Blooming Einsteins" order by date desc'`
   - Put options before the quoted query; otherwise Himalaya may parse `--page-size` / `--output` as part of the search string.
5. Read exact candidate messages by ID:
   - `himalaya message read MESSAGE_ID --output plain`
   - `himalaya message export MESSAGE_ID --full` if HTML/text parts need extraction.
6. For recurring newsletters/camp logistics, search both the provider name and likely body terms, then read the latest matching message rather than relying on snippets.

## Pitfalls

- Himalaya query syntax is not Gmail syntax. Use conditions like `subject "Summer Camp"`, `body "Aarushi"`, `from "Blooming Einsteins"`, plus `order by date desc`.
- Multi-word patterns must be quoted inside the query string.
- A newsletter subject may identify the week, while transaction/enrollment emails may contain the child-specific activity/theme and dates.
- If the latest newsletter for the next week is not present, say that explicitly and use enrollment/payment notices only for confirmed theme/date details.