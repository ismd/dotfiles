;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
;; (setq user-full-name "John Doe"
;;       user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-symbol-font' -- for symbols
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
(setq doom-font                "FiraCode Nerd Font:style=Retina:size=17"
      doom-variable-pitch-font (font-spec :family "IBM Plex Sans" :size 17)
      doom-big-font            "FiraCode Nerd Font:style=Retina:size=30"
      doom-symbol-font         (font-spec :family "Symbols Nerd Font Mono")
      doom-serif-font          (font-spec :family "IBM Plex Serif"))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/Nextcloud/Notes/")


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `with-eval-after-load' block, otherwise Doom's defaults may override your
;; settings. E.g.
;;
;;   (with-eval-after-load 'PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look them up).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

(defun ismd/delete-line ()
  "Delete text from current position to end of line char.
If at end of line, delete the following newline char."
  (interactive)
  (let ((end (line-end-position)))
    (when (eolp)
      (delete-char 1))
    (delete-region (point) end)))

(defun ismd/delete-word (arg)
  "Delete characters forward until encountering the end of a word.
With argument ARG, do this that many times."
  (interactive "p")
  (delete-region (point) (progn (forward-word arg) (point))))

(defun ismd/delete-word-backward (arg)
  "Delete characters backward until encountering the end of a word.
With argument ARG, do this that many times."
  (interactive "p")
  (ismd/delete-word (- arg)))

(defun ismd/scroll-down-lines ()
  "Scroll down 5 lines."
  (interactive)
  (scroll-up-command 5))

(defun ismd/scroll-up-lines ()
  "Scroll up 5 lines."
  (interactive)
  (scroll-down-command 5))

(map! "C-k"           #'ismd/delete-line
      "M-<backspace>" #'ismd/delete-word-backward
      "M-1"           #'winum-select-window-1
      "M-2"           #'winum-select-window-2
      "M-3"           #'winum-select-window-3
      "M-4"           #'winum-select-window-4
      "M-5"           #'winum-select-window-5
      "M-6"           #'winum-select-window-6
      "M-7"           #'winum-select-window-7
      "M-8"           #'winum-select-window-8
      "M-9"           #'winum-select-window-9
      "M-d"           #'ismd/delete-word
      "M-n"           #'ismd/scroll-down-lines
      "M-p"           #'ismd/scroll-up-lines)

(after! calendar
  (setq calendar-week-start-day 1))

(use-package! gh-copilot-chat
  :hook (git-commit-setup . gh-copilot-chat-insert-commit-message)
  :custom
  (gh-copilot-chat-commit-model "claude-sonnet-4.6")
  (gh-copilot-chat-frontend 'shell-maker))

(use-package! super-save
  :custom
  (auto-save-default nil)
  (super-save-auto-save-when-idle t)
  (super-save-silent t)
  :config
  (super-save-mode +1))
