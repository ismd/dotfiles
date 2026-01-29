---
name: emacs
description: Assist with Emacs configuration in dotfiles
user-invocable: true
---

# Emacs Configuration Skill

Help with editing and maintaining the Emacs configuration in this dotfiles repository.

## Trigger

Use this skill when asked to modify, add, or troubleshoot Emacs configuration including packages, keybindings, modules, and custom functions.

## Configuration Structure

The Emacs config uses **literate programming** with org-babel. All code is in `.org` files:

```
dot_config/emacs/
├── config.org              # Main entry point (loads modules, fonts, daemon)
├── early-init.el           # Pre-initialization
├── init.el                 # Bootstrap (loads config.org)
├── lisp/                   # Elisp utilities
└── modules/
    ├── core.org            # Defaults, utilities, basic editing
    ├── ui.org              # Dashboard, modeline, icons, visual
    ├── completion.org      # Vertico, Corfu, Consult, Orderless
    ├── keybindings.org     # General.el keybinding system
    ├── ai.org              # Claude, Copilot, GPTel
    ├── files.org           # Dired, Dirvish, Treemacs, project.el
    ├── languages.org       # LSP (Eglot), tree-sitter, language modes
    ├── notes.org           # Org mode, Denote notes
    ├── shells.org          # Vterm, Eshell, Eat terminals
    ├── vcs.org             # Magit, git-gutter, git-timemachine
    ├── themes.org          # Theme packages
    └── archive.org         # Legacy configs
```

## Instructions

### Before making changes

1. Read the relevant module file(s) to understand existing structure
2. Check `keybindings.org` if adding keybindings
3. Maintain org-babel code block format with proper headers

### Adding a new package

Place in the appropriate module with this pattern:

```org
** Package Name
Description of what this package does.

#+begin_src emacs-lisp
(use-package package-name
  :ensure t  ; or :ensure (:host github :repo "user/repo")
  :hook (mode-name . package-mode)
  :custom
  (setting-name value)
  :config
  (setup-code))
#+end_src
```

### Adding keybindings

All keybindings go in `modules/keybindings.org` using `general.el`:

```elisp
(ismd/leader-keys-C-c
  "x" '(:ignore t :wk "prefix-name")
  "x a" '(command-name :wk "description"))
```

Existing prefixes:
- `a` - AI, `b` - Buffers, `d` - Dired, `e` - Errors
- `f` - Files, `h` - Help, `l` - LSP, `m` - Multiple Cursors
- `n` - Notes, `o` - Org, `p` - Project, `s` - Search
- `t` - Toggle, `v` - VCS, `w` - Workspaces

### Adding custom functions

Use `ismd/` prefix for custom functions. Place in relevant module or `core.org`.

### Key technical constraints

- Package manager: **Elpaca** (not package.el/straight.el)
- LSP: **Eglot** (not lsp-mode)
- Completion: **Vertico+Corfu** (not Ivy/Helm/Company)
- Diagnostics: **Flymake** (not flycheck)
- Keybindings: **general.el**

### After making changes

Remind user to:
1. Evaluate the changed code block with `C-c C-c` or restart Emacs
2. Run `chezmoi apply` if changes should persist to home directory
