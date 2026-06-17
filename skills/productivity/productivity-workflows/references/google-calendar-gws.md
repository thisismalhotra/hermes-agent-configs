# Google Calendar via `gws`

Use this when creating or verifying Google Calendar events with the Google Workspace CLI.

## Auth triage
1. Check authentication first:
   ```bash
   gws auth status
   ```
2. If the token is expired or revoked, re-auth with the narrowest necessary scope:
   ```bash
   gws auth login --scopes https://www.googleapis.com/auth/calendar
   ```
3. Keep the login process alive while the user completes the browser OAuth flow. If running in a terminal process, background it with completion notification and open the emitted URL for the user.
4. After the user approves, confirm:
   ```bash
   gws auth status
   gws calendar calendarList list --params '{"maxResults":250}' --format json
   ```

## Finding a family calendar
- List calendars and inspect `summary`, `id`, `accessRole`, and whether the calendar can accept writes.
- Match exact `summary` first (for example `Family`), then cautious case-insensitive contains matches.
- Do not assume the Apple Family calendar and Google Family calendar are the same backend.

## Creating an appointment
- Use Google Calendar Events `insert` with a concrete `calendarId`.
- Include `summary`, `location`, `description`, `source`/link if useful, and `start`/`end` with `timeZone`.
- For appointments where the message says “arrive by X” and “scheduled at Y,” start the event at the arrival time and mention the scheduled time in the description.
- Add reminders only if appropriate for the user/task; avoid noisy defaults unless the event source or user asked for them.

## Verification
After insert, read back the event by returned ID and report:
- Calendar summary / ID
- Event ID and `htmlLink`
- Start/end time and timezone
- Location

If auth is blocked, stop and ask the user to complete OAuth; do not claim the event was added.