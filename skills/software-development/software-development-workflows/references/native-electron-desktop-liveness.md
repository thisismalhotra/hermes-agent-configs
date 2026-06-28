# Native Electron/Desktop App Liveness vs Window-State Debugging

Use this reference when a desktop app appears broken from the UI, but process/backend checks suggest it is still alive.

## Durable pattern

A native Electron app can have a live main process and live local backend while its visible/capturable window is stale, hidden, minimized, or otherwise in a bad window state. In that case, a GUI capture may return a 0×0 window even though the backend responds normally.

## Triage sequence

1. **Check service/process liveness first**
   - `ps aux | egrep -i 'AppName|electron|backend-name'`
   - If a backend process exists, inspect listening ports: `lsof -Pan -p <pid> -iTCP -sTCP:LISTEN`
2. **Probe local backend endpoints when present**
   - Start with `/`, `/api/status`, `/api/health`, `/status`, `/health`.
   - A `401` can still prove the route exists and the backend is alive.
3. **Check GUI/window state separately**
   - `computer_use(action="list_apps")`
   - `computer_use(action="capture", app="AppName")`
   - If capture returns `0x0`, treat it as a window-state symptom, not proof the whole app is down.
4. **Safe recovery**
   - If there is no unsaved-work risk, restart only the desktop app/main process and re-capture.
   - Verify with both process/backend checks and a successful GUI capture.
5. **Escalate only if repeated across apps**
   - If multiple apps capture as 0×0 or restart does not help, ask the user to run the platform/computer-use doctor tool.

## Reporting

Separate the diagnosis clearly:

- Backend/service alive or down
- Native app process alive or down
- Window/capture usable or stale
- What was restarted, if anything
- Exact verification output/observable result

## Safety

Do not restart apps that may contain unsaved work unless the user approves. Do not bring windows to the foreground unless asked; background app targeting is usually enough.