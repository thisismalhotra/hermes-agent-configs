# Hermes iMessage Gateway: Photon vs BlueBubbles

Use this reference when the user wants to text Hermes from iMessage and have Hermes reply like a bot. This is different from local `imsg` CLI control of the Mac's Messages.app.

## First classify the request

1. **Local Mac message control** — user wants the agent to send/read iMessages from this Mac during a session.
   - Use `imsg status`, `imsg send`, `imsg chats`, `imsg history`, etc.
   - Requires Messages.app signed into Apple ID and appropriate macOS permissions.
   - Does not require `hermes gateway setup`.

2. **Hermes as an iMessage bot** — user wants to text a number/contact from iMessage and receive replies from Hermes.
   - Configure the Hermes gateway with an iMessage platform.
   - Current practical routes: Photon iMessage or BlueBubbles.

## Recommended default: Photon

Recommend Photon first when the user wants the quickest bot-style setup and does not specifically need replies to come from their personal Apple ID/phone number.

Why:
- Built into Hermes via `hermes photon setup`.
- Avoids installing and maintaining BlueBubbles Server.
- Avoids local webhook/firewall/ngrok/Dynamic DNS setup.
- Works like a persistent gateway channel; the plugin supervises the sidecar.

Check readiness:

```bash
hermes photon status
command -v node && node --version
hermes gateway status
```

Typical setup:

```bash
hermes photon install-sidecar        # safe to run if dependencies are missing
hermes photon setup --phone +1XXXXXXXXXX
hermes plugins enable photon-platform # setup may store credentials without enabling the bundled plugin
hermes gateway restart
hermes photon status
```

Successful browser/device login often shows a page like **"Device connected — You can return to your device"** with a code and signed-in account. Treat that as the web authorization succeeding, then return to the terminal/setup flow and verify with `hermes photon status` plus gateway logs.

Post-setup verification:

```bash
hermes photon status
hermes gateway status
hermes logs gateway --lines 300 | grep -Ei 'photon|spectrum|sidecar|imessage'
```

Look for:

```text
[photon] connected — sidecar on 127.0.0.1:8789, streaming inbound over gRPC
gateway.run: ✓ photon connected
```

If `hermes photon status` shows stored token/project secret, the user's number, an assigned number, node binary, and sidecar deps, Photon is provisioned. The user texts the **assigned number** to reach Hermes. If the first outbound attempt logs `Target not allowed for this project`, do not treat Photon as broken; start/authorize the conversation from the user's phone to the assigned Photon number and handle pairing/allowlist approval.

Caveat: Photon free tier may use shared/assigned iMessage sending lines, so recipients may not see the user's personal Apple ID/number. This is acceptable for a personal Hermes bot unless the user explicitly requires their own sender identity.

## Choose BlueBubbles when sender identity/local control matters

Recommend BlueBubbles when the user specifically wants Hermes to use their own Mac + Messages.app + Apple ID/phone number identity.

Requirements:
- Always-on Mac running BlueBubbles Server.
- Apple ID signed into Messages.app on that Mac.
- BlueBubbles Server URL and password.
- Network reachability between Hermes and BlueBubbles.

Setup outline:

```bash
hermes gateway setup
# Select BlueBubbles (iMessage), then enter server URL/password.
hermes gateway run   # or restart/start the installed gateway service
```

Authorization options include DM pairing (`hermes pairing list` / `hermes pairing approve bluebubbles <CODE>`), pre-authorized users via env, or allow-all. Prefer pairing unless the user explicitly wants open access.

## Explanation to give users

Use a clear distinction:
- `imsg` = local Mac CLI for sending/reading Messages from the agent.
- Photon/BlueBubbles gateway = iMessage as a chat interface to the Hermes bot.

Avoid implying that installing `imsg` alone makes Hermes reachable as a bot over iMessage.