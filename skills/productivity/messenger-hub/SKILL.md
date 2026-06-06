---
name: messenger-hub
description: A centralized notification dispatcher for sending urgent alerts or status updates to Telegram and iMessage.
category: productivity
tools: [terminal, imessage, telegram]
---
# Messenger Hub Skill

This skill manages outgoing notifications across multiple channels, ensuring the right level of urgency reaches the right device.

## Capabilities

### 1. `broadcast_alert` (Urgent)
Sends a high-visibility notification to **both** Telegram and iMessage. 
*   **When to use:** System failures, security alerts, or critical backups errors.
*   **Example Prompt:** "Use messenger-hub to broadcast an urgent alert that the backup failed!"

### 2. `send_status` (Info)
Sends a non-intrusive summary only to **Telegram**. 
*   **When to use:** Daily briefing completions, routine task confirmations, or daily success logs.
*   **Example Prompt:** "Use messenger_hub to send an info update that the morning brief is highly successful."

## Usage via Terminal (for scripts/cron)

```bash
python3 $HOME/.hermes/skills/productivity/messenger-hub/scripts/dispatcher.py urgent "Backups failed!"
python3 $HOME/.hermes/skills/productivity/messenger-hub/scripts/dispatcher.py info "Daily brief complete."
```

## Implementation Details
The routing is handled by `dispatcher.py`. It maintains a local audit log at `/Users/gauravmalhotra/hermes_system_audit.log` for every message sent.
