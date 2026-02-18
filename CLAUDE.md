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
- `dot_bin/executable_monitors.sh.tmpl` - Display scaling per host
- `dot_profile.tmpl` - Environment variables per host
- `dot_config/emacs/config.org.tmpl` - Emacs configuration

### Automation Scripts
- `run_onchange_install-packages.sh` - Installs packages via `yay` when script content changes
- `run_onchange_dconf-load.sh.tmpl` - Loads GNOME/GTK settings from `dconf.ini`

### Directory Structure
- `dot_bin/` - Custom shell scripts
- `dot_config/` - Application configs (hypr, fish, kitty, emacs, etc.)
- `dot_emacs.d/` - Redirect stubs for `~/.emacs.d/` (see Emacs section)
- `dot_local/` - User-local data (desktop files, icons)
- `dot_var/` - Application data (EasyEffects profiles)

### Core Stack
- **WM**: Hyprland (Wayland)
- **Bar/Notifications**: [DankMaterialShell](https://github.com/AvengeMedia/DankMaterialShell)
- **Terminal**: Kitty
- **Shell**: Fish
- **Editor**: Emacs (wayland-native)

---

## Emacs Configuration

The Emacs configuration uses a **literate programming** approach with org-babel. All code is embedded in `.org` files for readability and self-documentation.

### Directory Structure

```
dot_config/emacs/
├── config.org              # Main entry point (loads modules, fonts, daemon)
├── early-init.el           # Pre-initialization (disables package.el)
├── init.el                 # Bootstrap (loads config.org via org-babel)
├── lisp/
│   ├── elpaca-setup.el     # Elpaca package manager bootstrap
│   └── buffer-move.el      # Buffer movement utilities
└── modules/
    ├── core.org            # Sane defaults, utilities, basic editing
    ├── ui.org              # Dashboard, modeline, icons, visual enhancements
    ├── completion.org      # Vertico, Corfu, Consult, Orderless
    ├── keybindings.org     # General.el keybinding system
    ├── ai.org              # Claude, Copilot, GPTel integrations
    ├── files.org           # Dired, Dirvish, Treemacs, project.el
    ├── languages.org       # LSP (Eglot), tree-sitter, language modes
    ├── org-config.org      # Org mode, Denote notes
    ├── shells.org          # Vterm, Eshell, Eat terminals
    ├── vcs.org             # Magit, git-gutter, git-timemachine
    ├── themes.org          # Theme packages (ef-themes default)
    └── archive.org         # Legacy configs for reference
```

### Initialization Flow

**Note:** Emacs prefers `~/.emacs.d/` over `~/.config/emacs/` if the directory exists — even without `init.el` inside. Since `~/.emacs.d/` is auto-generated and cannot be removed, `dot_emacs.d/early-init.el` and `dot_emacs.d/init.el` act as redirect stubs that set `user-emacs-directory` to `~/.config/emacs/` and delegate loading there.

1. `~/.emacs.d/early-init.el` → sets `user-emacs-directory` to `~/.config/emacs/`, loads real `early-init.el`
2. `~/.emacs.d/init.el` → loads `~/.config/emacs/init.el`
3. `~/.config/emacs/early-init.el` → Disables built-in package.el
4. `~/.config/emacs/init.el` → Loads `config.org` via `org-babel-load-file`
5. `config.org`:
   - Sets up load path for `lisp/`
   - Initializes **Elpaca** package manager
   - Configures fonts (FiraCode Nerd Font)
   - Loads theme (checks `~/.config/emacs/theme.el` override)
   - Loads modules in order: core → ui → completion → keybindings → ai → files → languages → org → shells → vcs
   - Starts Emacs daemon

For package management, module details, keybindings, custom functions, and editing guidelines, see `.claude/skills/emacs/SKILL.md`.

---

## Workflow Notes

- **Do not suggest `chezmoi apply`** — the user applies changes themselves when ready.
