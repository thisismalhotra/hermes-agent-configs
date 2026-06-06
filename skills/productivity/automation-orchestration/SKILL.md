---
name: automation-orchestration
description: "Patterns and templates for creating scheduled, multi-source automated workflows (e.g., Daily Briefings) using Python, Cron, and external APIs."
version: 1.0.0
author: Hermes Agent
license: MIT
---

# Automation Orchestration

This skill provides the architectural patterns and boilerplate code required to transform fragmented data from disparate sources (Google, Apple, RSS, etc.) into a cohesive, scheduled "Daily Brief" or "Pulse Report."

## Core Architecture: The Dispatcher Pattern

Instead of complex, long-running processes, use a trifecta of lightweight components:

1.  **The Source (Data Handlers):** Small, focused scripts or skill calls that fetch raw data from a single provider (e.g., `gws` for Google, `remindctl` for Apple).
2.  **The Engine (Orchestrator):** A Python script that executes the handlers, aggregates the findings, and applies formatting/summarization logic.
3.  **The Trigger (Cronjob):** A scheduled `cronjob` in Hermes that runs the Engine at specific intervals (e.g., 7:00 AM).

## Implementation Workflow

### 1. Define the Data Schema
Identify the intersection of what you need to know. For a "Kids Brief," this is often:
*   **Events:** [Source: Google/Apple Calendar] $\rightarrow$ `summary`, `start_time`.
*   **Tasks:** [Source: Apple Reminders] $\rightarrow$ `title`, `due_date`.
*   **Commms:** [Source: Gmail] $\rightarrow$ `sender`, `snippet`.

### 2. Create the Prototype Engine
Use the template in `templates/prototype_engine.py` to create a script that:
*   Takes a "period" argument (`morning` vs `evening`).
*   Uses `subprocess` or direct tool calls to fetch data.
*   Generates a formatted string (Markdown or Plain Text).

### 
### 3. Set the Schedule
Use `cronjob(action='create', schedule='7:00', prompt='...')`. Ensure the prompt points to your engine script and specifies the "morning" context.

## Pitfalls

*   **Context Erasure:** Cron jobs run in fresh sessions. **Never** rely on local chat history or unpersisted variables. All required logic and credentials must be self-contained within the script or loaded via skills.
*   **Authentication Drifts:** If using OAuth (e.g., Google), ensure your engine handles `NOT_AUTHENTICATED` errors by logging them or alerting the user, rather than failing silently.
*   **Path Fragility:** Always use absolute paths in your Python scripts and Cron prompts. Using `~/` can be ambiguous depending on the execution environment.

## Templates & References
*   `templates/prototype_engine.py`: A boilerplate orchestrator for multi-source aggregation.
*   `references/multi_source_flow.md`: Architectural diagram of a cross-platform briefing pipeline.
