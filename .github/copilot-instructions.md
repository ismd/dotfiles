# Copilot instructions

Purpose
-------
Short guidance for AI assistants (Copilot/Code) working in this repository. This repo is a chezmoi-managed dotfiles collection with a literate Emacs configuration; the notes below focus on commands, high-level architecture, and repository-specific conventions that are useful for automated/code-assist workflows.

Quick commands (build / test / lint)
-----------------------------------
- There is no dedicated build/test/lint suite in this repository.
- Common operational commands (chezmoi):
  - `chezmoi apply` — apply all changes to the home directory
  - `chezmoi apply <path>` — apply a single path (example: `chezmoi apply ~/.config/hypr`)
  - `chezmoi diff` — preview changes before applying
  - `chezmoi execute-template <file.tmpl>` — render a Go template locally
  - `chezmoi cat-config` — view the merged configuration that will be applied
  - `chezmoi add [--template] <path>` — add a file to source state (use `--template` when adding templates)
- Emacs-specific quick checks:
  - Emacs config is literate (org-babel) under `dot_config/emacs/` and is loaded by `init.el` via `org-babel-load-file`.
  - To perform a non-interactive check of Emacs startup: `emacs --batch -l ~/.config/emacs/init.el` (this loads the init file; use an interactive Emacs to fully inspect UI behavior).

High-level architecture
-----------------------
- This repository is a chezmoi dotfiles repo (source files live here; chezmoi renders them into the home directory). Key pattern: `dot_*` → hidden files/dirs in target (e.g., `dot_config/` -> `~/.config/`).
- Emacs configuration is stored as literate Org files in `dot_config/emacs/`:
  - `config.org` is the main entrypoint; `init.el` loads `config.org` via org-babel.
  - `lisp/` contains small helper ELisp files (e.g., `elpaca-setup.el` bootstrap).
  - `modules/` contains modular org files (core, ui, completion, keybindings, ai, files, languages, org-config, shells, vcs, themes, etc.).
  - Elpaca is used as the package manager (see `elpaca-setup.el`).
- Automation scripts and helpers live under `dot_bin/` and `run_onchange_*` scripts which are intended to run when source content changes.

Key conventions (repo-specific)
-------------------------------
- Naming conventions used by chezmoi in this repo:
  - `dot_` prefix → `.` in the target home (e.g., `dot_profile.tmpl` -> `~/.profile`).
  - `executable_` prefix → file will receive execute permission.
  - `.tmpl` suffix → treated as a Go template by chezmoi and often contains host-specific logic.
  - `private_` prefix → files with restrictive permissions.
  - `run_onchange_` prefix → executable scripts that run when their content changes.
- Emacs modules are written as Org files (org-babel). New features or packages should be added to the appropriate module under `dot_config/emacs/modules/` and loaded by `config.org`.
- Use the `ismd/` prefix for custom ELisp helpers (consistent naming across modules).
- `~/.config/emacs/custom.el` is referenced for per-host secrets / variables (do not commit secrets).

AI / assistant-specific files to consult
---------------------------------------
- `CLAUDE.md` (root) contains an overview of the repo and Emacs-specific notes; read it for rationale and module ordering.
- `.claude/skills/emacs/SKILL.md` contains skill-specific guidance (if modifying Emacs-related behavior for a Claude/Copilot skill, check it).
- `dot_claude/` and `dot_claude/settings.json` may contain user-specific AI assistant settings; handle secrets carefully.

How Copilot should operate in this repo
--------------------------------------
- Prefer using ripgrep/glob (repo search) and reading the small source files under `dot_config/` and `dot_bin/` rather than issuing broad edits.
- Make the smallest possible change required; preview with `chezmoi diff` before committing changes to the repo.
- For Emacs edits: edit the corresponding `modules/*.org` block, then verify by loading the Emacs init (interactive Emacs or `emacs --batch -l ~/.config/emacs/init.el`).
- When touching templates (`*.tmpl`), consider host templating (`{{ .chezmoi.hostname }}`) and prefer testing with `chezmoi execute-template`.

Useful file locations
---------------------
- Main Emacs entry: `dot_config/emacs/config.org` (modules in `dot_config/emacs/modules/`).
- Bootstrap: `dot_config/emacs/init.el` and `dot_config/emacs/early-init.el`.
- chezmoi templates: files with `.tmpl` suffix (e.g., `dot_config/hypr/hyprland.conf.tmpl`).

Final notes
-----------
- This repository has no CI for running tests; use the commands above for local verification.
- Before applying changes to the user's home, always preview with `chezmoi diff` and document the intent in a commit message.

