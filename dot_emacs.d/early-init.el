;; Redirect to XDG config directory -*- lexical-binding: t; -*-
(setq user-emacs-directory (expand-file-name "~/.config/emacs/"))
(load (expand-file-name "early-init" user-emacs-directory) nil t)