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

## Messages
- Use the configured iMessage/SMS CLI (`imsg`) for sending and receiving.
- Resolve recipient ambiguity before sending. Never invent phone numbers or contacts.
- After sending, verify CLI success/status and report the recipient/channel.

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
