# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a **chezmoi dotfiles repository** managing Linux desktop configurations for an Arch Linux system with a Wayland-based Hyprland setup. The repository supports multiple hosts through chezmoi's templating system.

## ## Architecture

### Chezmoi Naming Conventions
- `dot_` prefix → `.` in target (e.g., `dot_config/` → `~/.config/`)
- `executable_` prefix → file gets execute permission
- `.tmpl` suffix → processed as Go template
- `private_` prefix → restrictive file permissions
- `run_onchange_` prefix → script runs when its content changes

**Important:** Files in this repository use chezmoi naming, but represent actual dotfiles. For example, `dot_profile.tmpl` is a template for `~/.profile`, and `dot_config/fish/config.fish` becomes `~/.config/fish/config.fish`. When discussing or editing files, understand that the source file name differs from the target path.

### Multi-Host Templating
Templates use `{{ .chezmoi.hostname }}` for host-specific configurations. Current host: `mighty` (laptop).

Example pattern:
```go
{{- if eq .chezmoi.hostname "mighty" }}
# host-specific config
{{- end }}
```

### Key Templated Files
- `dot_config/hypr/hyprland.conf.tmpl` - Monitor configs, host-specific startup
- `dot_bin/executable_monitors.sh` - Display scaling per host
- `dot_profile.tmpl` - Environment variables per host

### Automation Scripts
- `run_onchange_install-packages.sh` - Installs packages via `yay` when script content changes
- `run_onchange_dconf-load.sh.tmpl` - Loads GNOME/GTK settings from `dconf.ini`

### Directory Structure
- `dot_bin/` - Custom shell scripts
- `dot_config/` - Application configs (hypr, fish, kitty, emacs, etc.)
- `dot_local/` - User-local data (desktop files, icons)
- `dot_var/` - Application data (EasyEffects profiles)

### Core Stack
- **WM**: Hyprland (Wayland)
- **Bar/Notifications**: [DankMaterialShell](https://github.com/AvengeMedia/DankMaterialShell)
- **Terminal**: Kitty
- **Shell**: Fish
- **Editor**: Emacs (wayland-native)

---

## Workflow Notes

- **Do not suggest `chezmoi apply`** — the user applies changes themselves when ready.
