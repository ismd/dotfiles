------------------
---- MONITORS ----
------------------

require("monitors")

---------------------
---- MY PROGRAMS ----
---------------------

local terminal = "kitty"
local fileManager = "dolphin"
local menu = "dms ipc call spotlight openWith apps"
local screenshot = "dms screenshot"

-------------------
---- AUTOSTART ----
-------------------

hl.on("hyprland.start", function()
  -- Export env to systemd: XDG_SESSION_ID for DMS loginctl integration,
  -- HYPRLAND_INSTANCE_SIGNATURE for hypr-monitors.service socket access
  hl.exec_cmd("systemctl --user import-environment XDG_SESSION_ID HYPRLAND_INSTANCE_SIGNATURE")
  hl.exec_cmd("~/.bin/thinkpad-leds.sh")
  hl.exec_cmd("sleep 3s && bitwarden-desktop")
  hl.exec_cmd("walker --gapplication-service")
  hl.exec_cmd("nm-applet")
  hl.exec_cmd("nextcloud")
  -- hl.exec_cmd("polychromatic-tray-applet")
  hl.exec_cmd("kdeconnectd")
end)

-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------

hl.env("XDG_MENU_PREFIX", "arch-")

-----------------------
---- LOOK AND FEEL ----
-----------------------

hl.config({
  general = {
    allow_tearing = false,
    layout = "master",
    resize_on_border = false,
  },

  decoration = {
    rounding_power = 2.0,

    shadow = {
      enabled = true,
      range = 4,
      render_power = 3,
      color = 0xee1a1a1a,
    },

    blur = {
      enabled = true,
      passes = 1,
      size = 3,
      vibrancy = 0.1696,
    },
  },

  animations = {
    enabled = true,
  },

  dwindle = {
    preserve_split = true,
  },

  master = {
    mfact = 0.8,
    new_status = "inherit",
  },

  misc = {
    force_default_wallpaper = 0,
    disable_hyprland_logo = true,
  },

  xwayland = {
    force_zero_scaling = true,
  },
})

-- Curves, see https://wiki.hypr.land/Configuring/Advanced-and-Cool/Animations/
hl.curve("easeOutQuint", { type = "bezier", points = { { 0.23, 1 }, { 0.32, 1 } } })
hl.curve("easeInOutCubic", { type = "bezier", points = { { 0.65, 0.05 }, { 0.36, 1 } } })
hl.curve("linear", { type = "bezier", points = { { 0, 0 }, { 1, 1 } } })
hl.curve("almostLinear", { type = "bezier", points = { { 0.5, 0.5 }, { 0.75, 1 } } })
hl.curve("quick", { type = "bezier", points = { { 0.15, 0 }, { 0.1, 1 } } })

hl.animation({ leaf = "global", enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "border", enabled = true, speed = 5.39, bezier = "easeOutQuint" })
hl.animation({ leaf = "windows", enabled = true, speed = 4.79, bezier = "easeOutQuint" })
hl.animation({ leaf = "windowsIn", enabled = true, speed = 4.1, bezier = "easeOutQuint", style = "popin 87%" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 1.49, bezier = "linear", style = "popin 87%" })
hl.animation({ leaf = "fadeIn", enabled = true, speed = 1.73, bezier = "almostLinear" })
hl.animation({ leaf = "fadeOut", enabled = true, speed = 1.46, bezier = "almostLinear" })
hl.animation({ leaf = "fade", enabled = true, speed = 3.03, bezier = "quick" })
hl.animation({ leaf = "layers", enabled = true, speed = 3.81, bezier = "easeOutQuint" })
hl.animation({ leaf = "layersIn", enabled = true, speed = 4, bezier = "easeOutQuint", style = "fade" })
hl.animation({ leaf = "layersOut", enabled = true, speed = 1.5, bezier = "linear", style = "fade" })
hl.animation({ leaf = "fadeLayersIn", enabled = true, speed = 1.79, bezier = "almostLinear" })
hl.animation({ leaf = "fadeLayersOut", enabled = true, speed = 1.39, bezier = "almostLinear" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesIn", enabled = true, speed = 1.21, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesOut", enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "zoomFactor", enabled = true, speed = 7, bezier = "quick" })

---------------
---- INPUT ----
---------------

hl.config({
  input = {
    kb_layout = "us,ru",
    kb_options = "grp:toggle,ctrl:nocaps",

    follow_mouse = 1,

    sensitivity = 0, -- -1.0 - 1.0, 0 means no modification.

    repeat_rate = 22,
    repeat_delay = 250,

    touchpad = {
      disable_while_typing = true,
      drag_lock = false,
      natural_scroll = false,
      tap_to_click = true,
    },
  },
})

hl.gesture({
  fingers = 3,
  direction = "horizontal",
  action = "workspace",
})

hl.device({
  name = "elan0676:00-04f3:3195-touchpad",
  sensitivity = 0.4,
})

hl.device({
  name = "logitech-mx-anywhere-3s",
  scroll_factor = 4.0,
})

---------------------
---- KEYBINDINGS ----
---------------------

local mainMod = "SUPER"

hl.bind(mainMod .. " + Return", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + Q", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + C", hl.dsp.window.close())
hl.bind(mainMod .. " + M", hl.dsp.exit())
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + R", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + G", hl.dsp.window.fullscreen())
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen())
hl.bind(mainMod .. " + X", hl.dsp.exec_cmd("dms ipc call powermenu toggle"))

-- Move focus with mainMod + arrow keys
hl.bind(mainMod .. " + left", hl.dsp.focus({ direction = "l" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "r" }))
hl.bind(mainMod .. " + up", hl.dsp.focus({ direction = "u" }))
hl.bind(mainMod .. " + down", hl.dsp.focus({ direction = "d" }))

-- Switch workspaces with mainMod + [0-9]
-- Move active window to a workspace (silently) with mainMod + SHIFT + [0-9]
for i = 1, 10 do
  local key = i % 10 -- 10 maps to key 0
  hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
  hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i, follow = false }))
end

-- Special workspace (scratchpad)
hl.bind(mainMod .. " + S", hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic", follow = true }))

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Move workspace to monitor
hl.bind(mainMod .. " + SHIFT + bracketleft", hl.dsp.workspace.move({ monitor = "l" }))
hl.bind(mainMod .. " + SHIFT + bracketright", hl.dsp.workspace.move({ monitor = "r" }))

-- Laptop multimedia keys for volume and LCD brightness
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("~/.bin/volume.sh up"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("~/.bin/volume.sh down"), { locked = true, repeating = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("~/.bin/volume.sh toggle"), { locked = true, repeating = true })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("~/.bin/mic-mute.sh toggle-mic"), { locked = true, repeating = true })

hl.bind(mainMod .. " + F10", hl.dsp.exec_cmd("~/.bin/volume.sh toggle"), { locked = true })
hl.bind(mainMod .. " + F11", hl.dsp.exec_cmd("~/.bin/volume.sh down"), { locked = true, repeating = true })
hl.bind(mainMod .. " + F12", hl.dsp.exec_cmd("~/.bin/volume.sh up"), { locked = true, repeating = true })

hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("~/.bin/brightness.sh up"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("~/.bin/brightness.sh down"), { locked = true, repeating = true })

-- Requires playerctl
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })

-- Print
hl.bind(mainMod .. " + SHIFT + Print", hl.dsp.exec_cmd(screenshot))
hl.bind(mainMod .. " + SHIFT + P", hl.dsp.exec_cmd(screenshot))

-- Master layout
hl.bind(mainMod .. " + T", hl.dsp.layout("swapwithmaster master"))

-- Power
hl.bind(mainMod .. " + SHIFT + Escape", hl.dsp.exec_cmd("nwg-bar"))

-- Lock
hl.bind(mainMod .. " + L", hl.dsp.exec_cmd("dms ipc call lock lock"))

-- Lid toggle
hl.bind("switch:on:Lid Switch", hl.dsp.exec_cmd("dms ipc call lock lock"), { locked = true })
hl.bind("switch:off:Lid Switch", hl.dsp.exec_cmd("~/.bin/thinkpad-leds.sh"), { locked = true })

-- Notifications
hl.bind(mainMod .. " + N", hl.dsp.exec_cmd("dms ipc call notifications open"))
hl.bind(mainMod .. " + SHIFT + N", hl.dsp.exec_cmd("dms ipc call notifications toggleDoNotDisturb"))
hl.bind(mainMod .. " + Escape", hl.dsp.exec_cmd("dms ipc call notifications dismissAllPopups"))

-- Translate
hl.bind(mainMod .. " + SHIFT + T", hl.dsp.exec_cmd("dmenu-translate"))

-- Tab
hl.bind(mainMod .. " + Tab", hl.dsp.window.cycle_next())

-- Pin
hl.bind(mainMod .. " + SHIFT + V", hl.dsp.window.pin())

--------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------

-- Fix some dragging issues with XWayland
hl.window_rule({
  match = {
    class = "^$",
    title = "^$",
    xwayland = true,
    float = true,
    fullscreen = false,
    pin = false,
  },
  no_focus = true,
})

-- Bitwarden
hl.window_rule({
  match = { class = "brave-nngceckbapebfimnlniiiahkandclblb-Default" },
  float = true,
})

-- Choose files
hl.window_rule({ match = { class = "^(xdg-desktop-portal-gtk)$" }, float = true })
hl.window_rule({ match = { title = "^(Choose Files)$" }, float = true })

-- Floating windows
hl.window_rule({ match = { class = "^(gnome-calculator)$" }, float = true })
hl.window_rule({ match = { class = "^(blueman-manager)$" }, float = true })
hl.window_rule({ match = { class = "^(org\\.gnome\\.Nautilus)$" }, float = true })

-- GNOME apps
hl.window_rule({ match = { class = "^(org\\.gnome\\.)" }, rounding = 12 })
hl.window_rule({ match = { class = "^(org\\.gnome\\.)" }, border_size = 0 })

-- Telegram
hl.window_rule({
  match = { class = "^(org.telegram.desktop)$", title = "^(Media viewer)$" },
  float = true,
})

-- Terminal apps - no borders
hl.window_rule({ match = { class = "^(org\\.wezfurlong\\.wezterm)$" }, border_size = 0 })
hl.window_rule({ match = { class = "^(Alacritty)$" }, border_size = 0 })
hl.window_rule({ match = { class = "^(zen)$" }, border_size = 0 })
hl.window_rule({ match = { class = "^(com\\.mitchellh\\.ghostty)$" }, border_size = 0 })
hl.window_rule({ match = { class = "^(kitty)$" }, border_size = 0 })

-------------
---- DMS ----
-------------

require("dms.colors")
require("dms.layout")
require("dms.windowrules")
require("dms.cursor")
