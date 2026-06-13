---
name: productivity-workflows
description: "Use when operating productivity systems and documents: Google Workspace, Airtable, Notion, maps/geocoding, PDFs/OCR, PowerPoint, Teams meeting pipelines, reminders/notifications, and scheduled automation."
version: 1.0.0
author: Hermes Agent
license: MIT
metadata:
  hermes:
    tags: [productivity, documents, google-workspace, airtable, notion, pdf, powerpoint, automation]
    related_skills: [automation-orchestration, apple-workflows]
---

# Productivity Workflows

## Overview
This umbrella covers external productivity systems, documents, and office automation. Use subsections to select the right API/CLI and verification pattern.

Archived predecessor packages remain recoverable with their support files intact: `airtable`, `google-workspace`, `notion`, `maps`, `messenger-hub`, `nano-pdf`, `ocr-and-documents`, `powerpoint`, `teams-meeting-pipeline`, and `automation-orchestration`.

## When to Use
- The user asks to read/write Gmail, Calendar, Drive, Docs, Sheets, Airtable, or Notion.
- The user asks to create/edit/extract PDFs, OCR scans, or PowerPoint decks.
- The user asks for geocoding, routes, POIs, or timezones.
- The user asks for scheduled/multi-source automation or notification dispatch.
- The user asks to operate a Teams meeting summary pipeline.

## Shared Workflow
1. Identify the service, object ID/name, account/workspace, and side effects.
2. Verify auth/config before API calls.
3. Prefer official CLIs or configured bridge scripts over ad-hoc scraping.
4. For writes, read back the updated object and return a URL/ID/path.
5. For documents, validate exported/openable files where possible.

## Google Workspace
- Use the configured `gws` CLI or bridge scripts for Gmail, Calendar, Drive, Docs, and Sheets.
- For Gmail search, use exact query syntax and verify message IDs before acting.

## Airtable and Notion
- Confirm base/database/table/page IDs and schemas before writes.
- For upserts, identify stable keys; never rely on row order.

## Documents, PDFs, OCR, and Slides
- Use OCR extraction for scanned documents; report confidence/limitations.
- Use PDF editing tools for small text/title fixes and verify by extracting or rendering.
- For PowerPoint, manipulate the package safely and validate deck structure after edits.

## Maps and Timezones
- Use OSM/OSRM/geocoding scripts for locations, routes, POIs, and timezone lookups.
- Include uncertainty for ambiguous place names.

## Automation and Notifications
- For scheduled workflows, separate data collection, reasoning, and delivery.
- For urgent notifications, dispatch through the configured hub and verify target routing.

## Teams Meeting Pipeline
- Use the pipeline CLI to inspect state, summarize meetings, and verify produced artifacts.
- Return paths/links to summaries and note missing transcripts/media.

## Common Pitfalls
1. Writing to the wrong account/workspace/base because IDs were not verified.
2. Reporting success without reading back the created/updated object.
3. Treating OCR output as perfect text.
4. Building cron-style automations without clear silence/error semantics.

## Verification Checklist
- [ ] Service/object/account identified.
- [ ] Auth/config checked before side effects.
- [ ] Writes read back with URL/ID/path.
- [ ] Documents exported or validated.
- [ ] Automation delivery/error behavior specified.
