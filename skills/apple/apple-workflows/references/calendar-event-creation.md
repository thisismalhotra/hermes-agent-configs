# Calendar Event Creation on macOS

Use this reference when adding appointments to Apple Calendar from Hermes.

## Preferred sequence
1. Try AppleScript only for lightweight read/list operations, but expect Calendar AppleEvents to hang if Calendar is not responding or permission prompts are hidden.
2. For write operations, prefer EventKit via a small signed helper `.app` with calendar usage strings, not a bare `swift` script. Bare CLI tools often cannot display the correct privacy prompt.
3. Include both privacy keys for modern macOS:
   - `NSCalendarsUsageDescription`
   - `NSCalendarsFullAccessUsageDescription`
4. If permissions do not resolve quickly, provide a standards-compliant `.ics` fallback so the user can import manually instead of leaving the task blocked.
5. Verify writes by reading back the event (title, start/end, calendar, location) whenever access is granted.

## EventKit helper pattern
- Build a temporary `.app` with `LSUIElement=true`, the compiled Swift executable under `Contents/MacOS/`, and the usage-description keys in `Info.plist`.
- Request full calendar access on macOS 14+ with `requestFullAccessToEvents`; use `requestAccess(to: .event)` on older systems.
- Log to `/tmp/...log` so results can be inspected if the GUI authorization flow stalls.
- Search for an existing matching event before saving to avoid duplicates.

## Fallback `.ics` pattern
When direct write access is unavailable, create an `.ics` file with:
- Stable `UID`
- `DTSTART;TZID=...` / `DTEND;TZID=...`
- `SUMMARY`, `LOCATION`, `DESCRIPTION`, `URL`
- Optional `VALARM` blocks

Return the file as `MEDIA:/absolute/path/file.ics` and clearly state that the direct write was not verified.