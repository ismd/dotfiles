#!/usr/bin/env bash
# Auto-switch DMS display profiles based on connected monitors.
# Listens for Hyprland monitor events and switches to the profile
# that DMS matched for the current monitor set.

set -euo pipefail

DEBOUNCE_SECS=2
debounce_pid=

update_profile() {
    local status active matched
    status=$(dms ipc call outputs status)
    active=$(echo "$status" | sed -n 's/^active: //p')
    matched=$(echo "$status" | sed -n 's/^matched: //p')

    [[ -z "$matched" || "$matched" == "none" ]] && return

    if [[ "$matched" != "$active" ]]; then
        dms ipc call outputs setProfile "$matched"
    fi
}

schedule_update() {
    if [[ -n "$debounce_pid" ]] && kill -0 "$debounce_pid" 2>/dev/null; then
        kill "$debounce_pid" 2>/dev/null || true
    fi

    (sleep "$DEBOUNCE_SECS" && update_profile) &
    debounce_pid=$!
}

cleanup() {
    if [[ -n "$debounce_pid" ]] && kill -0 "$debounce_pid" 2>/dev/null; then
        kill "$debounce_pid" 2>/dev/null || true
    fi
    exit 0
}
trap cleanup EXIT INT TERM

# Wait for DMS to be ready
until dms ipc call outputs status &>/dev/null; do
    sleep 1
done

# Apply correct profile at startup
update_profile

# Listen for monitor connect/disconnect events
SOCKET="$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock"
socat -u "UNIX-CONNECT:$SOCKET" - | while IFS= read -r line; do
    case "$line" in
        monitoradded\>*|monitorremoved\>*)
            schedule_update
            ;;
    esac
done
