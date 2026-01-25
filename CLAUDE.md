# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a **chezmoi dotfiles repository** managing Linux desktop configurations for an Arch Linux system with a Wayland-based Hyprland setup. The repository supports multiple hosts through chezmoi's templating system.

## Key Commands

### Applying Changes
```bash
chezmoi apply                    # Apply all changes to home directory
chezmoi apply ~/.config/hypr     # Apply specific path
chezmoi diff                     # Preview changes before applying
```

### Working with Templates
```bash
chezmoi execute-template < file.tmpl   # Test template rendering
chezmoi cat-config                      # View merged config
```

### Adding New Files
```bash
chezmoi add ~/.config/app/config       # Add file to source state
chezmoi add --template ~/.config/app   # Add as template
```

## Architecture

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

1. `early-init.el` → Disables built-in package.el
2. `init.el` → Loads `config.org` via `org-babel-load-file`
3. `config.org`:
   - Sets up load path for `lisp/`
   - Initializes **Elpaca** package manager
   - Configures fonts (FiraCode Nerd Font)
   - Loads theme (checks `~/.config/emacs/theme.el` override)
   - Loads modules in order: core → ui → completion → keybindings → ai → files → languages → org → shells → vcs
   - Starts Emacs daemon

### Package Manager: Elpaca

Uses **Elpaca** (modern, fast, git-based) instead of package.el/straight.el:
```elisp
(use-package some-package
  :ensure (:host github :repo "user/repo")
  :config ...)
```

Key Elpaca keywords:
- `:ensure t` - install from MELPA
- `:ensure (:host github :repo "...")` - install from GitHub
- `:wait t` - block until installed (for dependencies)

### Module Overview

| Module | Purpose | Key Packages |
|--------|---------|--------------|
| **core.org** | Defaults, auto-save, backups, editing | envrc, super-save, expand-region, multiple-cursors, mwim |
| **ui.org** | Visual enhancements | doom-modeline, dashboard, nerd-icons, which-key, winum, perspective |
| **completion.org** | Completion system | vertico, corfu, consult, orderless, marginalia, embark |
| **keybindings.org** | Keybinding system | general.el (all bindings defined here) |
| **ai.org** | AI assistants | claude-code, claude-code-ide, gptel, copilot, copilot-chat |
| **files.org** | File management | dirvish, treemacs, project.el, rg |
| **languages.org** | Programming support | eglot, treesit-auto, dart-mode, go-mode, elpy, terraform-mode |
| **org-config.org** | Notes & Org mode | denote, org-bullets, org-appear, ox-gfm |
| **shells.org** | Terminals | vterm, vterm-toggle, eshell, eat |
| **vcs.org** | Git integration | magit, git-gutter, git-timemachine |
| **themes.org** | Themes | ef-themes (default: ef-owl), doom-themes, modus-themes |

### Keybinding System

Uses **general.el** with organized prefixes:

| Prefix | Domain | Examples |
|--------|--------|----------|
| `C-c a` | AI | Claude Code, Copilot Chat, GPTel |
| `C-c b` | Buffers | kill, clone, bookmark, list |
| `C-c d` | Dired | dirvish, treemacs |
| `C-c e` | Errors | flymake navigation |
| `C-c f` | Files | find, recent, sudo-edit, config |
| `C-c h` | Help | describe function/variable/key |
| `C-c l` | LSP | eglot format, actions, rename |
| `C-c m` | Multiple Cursors | mark-all, edit-lines |
| `C-c n` | Notes | denote create, link, backlinks |
| `C-c o` | Org | agenda, todo, export |
| `C-c p` | Project | project.el commands |
| `C-c s` | Search | ripgrep, consult-grep |
| `C-c t` | Toggle | line numbers, vterm, word-wrap |
| `C-c v` | VCS | magit status, dispatch, timemachine |
| `C-c w` | Workspaces | perspective, buffer-move |

**Global shortcuts:**
- `M-1` to `M-9` - Window switching (winum)
- `M-s` - Jump to char (avy)
- `C-s` - Search in buffer (consult-line)
- `C-a/C-e` - Smart line navigation (mwim)
- `C-k` - Delete to EOL

### Custom Functions (ismd/ prefix)

| Function | Purpose |
|----------|---------|
| `ismd/reload-buffer` | Revert without confirmation |
| `ismd/delete-word`, `ismd/delete-word-backward` | Word deletion |
| `ismd/delete-line` | Delete to EOL |
| `ismd/delete-this-file` | Delete file and buffer |
| `ismd/fold-toggle`, `ismd/fold-close-all`, `ismd/fold-open-all` | Smart folding (treesit or kirigami) |
| `ismd/dirvish-dual-pane` | Side-by-side file browser |
| `ismd/open-emacs-config` | Edit config.org |
| `ismd/window-split-toggle` | Toggle H/V split |

### Editing Guidelines

**Adding a new package:**
1. Find the appropriate module in `modules/`
2. Add `use-package` block with `:ensure` clause
3. Group with related packages

**Adding keybindings:**
1. Edit `modules/keybindings.org`
2. Use `ismd/leader-keys-C-c` for `C-c` prefixed bindings
3. Follow existing naming patterns

**Adding a new module:**
1. Create `modules/new-module.org` with org-babel code blocks
2. Add `(ismd/load-module "new-module")` to `config.org`
3. Place in correct loading order (dependencies first)

**Modifying AI integrations:**
- Claude Code: `modules/ai.org` → `claude-code` and `claude-code-ide` sections
- GPTel: `modules/ai.org` → `gptel` section (Anthropic backend configured)
- Copilot: `modules/ai.org` → `copilot` and `copilot-chat` sections

**Theme customization:**
- Default theme: `ef-owl` (ef-themes)
- Override: Create `~/.config/emacs/theme.el` with `(load-theme 'theme-name t)`
- Available: ef-themes, doom-themes, modus-themes, nord-theme

### File Locations

| Path | Purpose |
|------|---------|
| `~/Nextcloud/Notes/` | Org agenda & Denote notes |
| `~/.config/emacs/custom.el` | Custom variables (API keys loaded here) |
| `~/.config/emacs/.perspectives` | Saved workspace state |
| `~/.local/share/Trash/files` | Backup files |

### Key Technical Details

- **Fonts**: FiraCode Nerd Font (mono: 130, variable: 140), Noto Color Emoji
- **LSP**: Eglot (built-in, no lsp-mode)
- **Diagnostics**: Flymake (built-in, no flycheck)
- **Completion**: Vertico+Corfu (no Ivy/Helm/Company)
- **Tree-sitter**: Auto-installed via treesit-auto
- **Daemon**: Auto-starts in config.org
