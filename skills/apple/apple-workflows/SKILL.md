---
name: apple-workflows
description: "Use when operating Apple/macOS apps and services from Hermes: Notes, Reminders, Messages, Find My, or background computer control. Umbrella for Apple ecosystem CLI and GUI automation workflows."
version: 1.0.0
author: Hermes Agent
license: MIT
metadata:
  hermes:
    tags: [apple, macos, notes, reminders, imessage, findmy, computer-use]
    related_skills: [macos-computer-use]
---

# Apple Workflows

## Overview
This umbrella covers Apple ecosystem tasks on macOS: Apple Notes, Reminders, Messages/SMS, Find My devices/AirTags, and background GUI control. Use the matching subsection after confirming the user's target app/service.

Archived predecessor packages remain recoverable: `apple-notes`, `apple-reminders`, `imessage`, `findmy`, and `macos-computer-use`.

## When to Use
- The user asks to create/search/edit Apple Notes.
- The user asks to add/list/complete Apple Reminders.
- The user asks to create, verify, or troubleshoot Apple Calendar events.
- The user asks to send or inspect iMessage/SMS conversations.
- The user asks to locate Apple devices or AirTags via Find My.
- The user asks to drive a macOS application in the background.

## Safety and Privacy
- Do not type passwords, one-time codes, payment details, or secrets.
- Do not click permission dialogs unless the user explicitly asked for that exact permission action.
- For messages, confirm recipient identity if there is ambiguity.
- For location data, return only what is necessary and respect sensitivity.

## Notes
- Use the configured Notes CLI (`memo`) for create/search/edit operations when available.
- Search before creating duplicates if the user refers to an existing note.
- Read back the created or edited note title/body snippet to verify.

## Reminders
- Use `remindctl` for reminder CRUD when available.
- Capture list name, due date/time, recurrence, priority, and notes when the user provides them.
- Verify by listing the target reminder/list after creation or completion.

## Calendar
- For Apple Calendar event writes, see `references/calendar-event-creation.md`.
- Prefer EventKit through a small signed helper `.app` with `NSCalendarsUsageDescription` and `NSCalendarsFullAccessUsageDescription`; bare AppleScript/Swift can hang behind privacy prompts.
- Always search for an existing matching event before creating a new one.
- If Calendar permission cannot be granted promptly, produce a valid `.ics` fallback (`MEDIA:/...`) and clearly say that direct insertion was not verified.
- Verify by reading back the created event title, start/end, calendar, and location whenever direct access succeeds.

## Calendar Event Creation Notes
- Prefer native, verifiable creation with EventKit when adding Apple Calendar events. Build a tiny signed `.app` helper with `NSCalendarsUsageDescription` and `NSCalendarsFullAccessUsageDescription`, request access via `EKEventStore`, select a modifiable target calendar by exact name first, then substring match, and save the event.
- Before saving, run a duplicate check over a narrow time window in the target calendar using title/location/date criteria.
- For appointment texts, distinguish appointment time from arrival time. If the user says “arrive by 11:15” for an 11:30 appointment, set the event start to the arrival time and mention the appointment time in notes.
- Include location, URL, notes, and sensible alarms when provided; avoid inventing missing details.
- Verify by reading the saved EventKit result/log, including event identifier, title, start/end, and calendar. If access is denied or the permission prompt times out, do not claim success; provide an `.ics` fallback and state that direct calendar insertion was unverified.
- Template: `templates/eventkit-calendar-helper.swift` contains a reusable Swift EventKit helper pattern for creating events and logging verification.

## Messages / iMessage
- First distinguish the user's goal:
  - **Local Mac send/read control**: use the configured iMessage/SMS CLI (`imsg`) for sending, receiving, and history from the Mac's native Messages.app. This requires Messages.app signed into Apple ID; basic `imsg` features do not require the Hermes gateway.
  - **Text Hermes as a bot from iMessage**: configure a Hermes messaging gateway channel, usually Photon iMessage or BlueBubbles, not merely `imsg`.
- For local `imsg` operations, resolve recipient ambiguity before sending. Never invent phone numbers or contacts.
- After sending, verify CLI success/status and report the recipient/channel.
- For Hermes-as-iMessage-bot setup, see `references/imessage-hermes-gateway.md` for the Photon vs BlueBubbles decision guide, setup checklist, plugin-enable/restart verification, and the `Target not allowed for this project` inbound-first/pairing pitfall.

## Find My
- Use FindMy.app/CLI workflows only for the user's devices/items.
- When reporting a location, include timestamp/freshness and uncertainty if present.
- If the device is stale/offline, say so directly.

## macOS Background Computer Use
- Prefer `computer_use` capture with `mode='som'` and `app=<target app>`.
- Click by element index, not coordinates, when possible.
- Re-capture after state-changing actions to verify the result.

## Common Pitfalls
1. Acting on the wrong contact, note, list, device, or window because names are similar.
2. Treating stale Find My locations as current.
3. Driving the frontmost screen when an app-scoped capture would be safer.
4. Sending messages without read-back verification.

## Verification Checklist
- [ ] Target app/service and object identified.
- [ ] Sensitive actions avoided or explicitly authorized.
- [ ] CLI/UI result read back after the operation.
- [ ] Ambiguity called out instead of guessed.
