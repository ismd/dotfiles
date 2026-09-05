-- DMS user keybind overrides (edit via Control Center or dms; do not remove this header)

hl.unbind("SUPER + W")
hl.bind("SUPER + W", hl.dsp.exec_cmd("dms ipc call notepad collapse"), { description = "Notepad: Collapse" })
