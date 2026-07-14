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
(setq doom-font                "MesloLGM Nerd Font Mono:size=25"
      doom-variable-pitch-font (font-spec :family "IBM Plex Sans" :size 25)
      doom-big-font            "MesloLGM Nerd Font Mono:size=40"
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

;; Claude Code (and vim/less/htop) run as fullscreen alt-screen apps: they own
;; the screen and keep no scrollback, so PageUp/PageDown on the Emacs side just
;; hit an empty buffer. Forward them to the app when it's on the alternate
;; screen; otherwise scroll ghostel's own scrollback as usual.
(defun ismd/ghostel-alt-screen-p ()
  "Non-nil when the current ghostel terminal is on the alternate screen."
  (and (derived-mode-p 'ghostel-mode)
       (bound-and-true-p ghostel--term)
       (or (ghostel--mode-enabled ghostel--term 1049)
           (ghostel--mode-enabled ghostel--term 1047)
           (ghostel--mode-enabled ghostel--term 47))))

(defun ismd/ghostel-page-down ()
  "Send PageDown to a fullscreen ghostel app, else scroll scrollback down."
  (interactive)
  (if (ismd/ghostel-alt-screen-p)
      (ghostel-send-key "next")
    (pixel-scroll-interpolate-down)))

(defun ismd/ghostel-page-up ()
  "Send PageUp to a fullscreen ghostel app, else scroll scrollback up."
  (interactive)
  (if (ismd/ghostel-alt-screen-p)
      (ghostel-send-key "prior")
    (pixel-scroll-interpolate-up)))

(defun ismd/scroll-down-lines ()
  "Scroll down 7 lines, interpolated like page scrolling."
  (interactive)
  (if (bound-and-true-p pixel-scroll-precision-mode)
      (pixel-scroll-precision-interpolate (- (* 7 (line-pixel-height))) nil 1)
    (scroll-up-command 7)))

(defun ismd/scroll-up-lines ()
  "Scroll up 7 lines, interpolated like page scrolling."
  (interactive)
  (if (bound-and-true-p pixel-scroll-precision-mode)
      (pixel-scroll-precision-interpolate (* 7 (line-pixel-height)) nil 1)
    (scroll-down-command 7)))

(map! "C-="           #'doom/increase-font-size
      "C--"           #'doom/decrease-font-size
      "C-0"           #'doom/reset-font-size
      "C-k"           #'ismd/delete-line
      "C-v"           #'pixel-scroll-interpolate-down
      "M-<backspace>" #'ismd/delete-word-backward
      "M-0"           #'treemacs-select-window
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
      "M-p"           #'ismd/scroll-up-lines
      "M-v"           #'pixel-scroll-interpolate-up)

(map!
 :prefix "C-c"
 "C-=" #'er/expand-region
 "C--" #'er/contract-region)

(map!
 :prefix "C-x"
 "K" #'kill-buffer-and-window
 "k" #'kill-current-buffer)

(map! :map key-translation-map
      "C-а" (kbd "C-f")
      "C-и" (kbd "C-b")
      "C-т" (kbd "C-n")
      "C-з" (kbd "C-p")
      "M-а" (kbd "M-f")
      "M-и" (kbd "M-b")
      "M-т" (kbd "M-n")
      "M-з" (kbd "M-p")
      "C-ф" (kbd "C-a")
      "C-у" (kbd "C-e")
      "C-в" (kbd "C-d")
      "M-в" (kbd "M-d")
      "C-." (kbd "C-/")
      "M-Ю" (kbd "M->")
      "M-Б" (kbd "M-<"))

(setq-default explicit-shell-file-name "/bin/fish"
              vterm-shell "/bin/fish")

(setq org-roam-directory "~/Nextcloud/Notes/Roam"
      pixel-scroll-precision-interpolate-page t
      recenter-positions '(0.2 top bottom)
      shell-file-name (executable-find "bash"))

(global-visual-line-mode +1)

(after! calendar
  (setq calendar-week-start-day 1))

(after! corfu
  (setq corfu-auto nil
        corfu-cycle nil
        ;; corfu-preselect 'valid
        ;; corfu-preview-current nil
        )

  (map! :map corfu-map
        "C-v" #'corfu-scroll-up
        "M-v" #'corfu-scroll-down))

(after! doom-modeline
  (setq doom-modeline-percent-position nil
        doom-modeline-position-column-line-format '("%l")
        doom-modeline-total-line-number t))

(after! ghostel
  (map! :map (ghostel-char-mode-map ghostel-semi-char-mode-map)
        "M-1" nil
        "M-2" nil
        "M-3" nil
        "M-4" nil
        "M-5" nil
        "M-6" nil
        "M-7" nil
        "M-8" nil
        "M-9" nil
        "M-0" nil))

(after! git-commit
  (setq git-commit-style-convention-checks
        (delq 'overlong-summary-line git-commit-style-convention-checks)))

(after! markdown-mode
  (map! :map markdown-mode-map
        "M-n" nil
        "M-p" nil))

(after! magit
  (setq git-commit-summary-max-length 72
        magit-diff-fontify-hunk t
        magit-ediff-dwim-show-on-hunks t))

(after! org
  (setq org-agenda-show-all-dates nil
        org-agenda-skip-deadline-if-done t
        org-agenda-skip-scheduled-if-done t
        org-agenda-skip-timestamp-if-done t
        org-agenda-span 'week
        org-agenda-start-day nil
        org-agenda-start-on-weekday nil
        org-deadline-warning-days 3
        org-todo-keywords '((sequence "IN-PROGRESS(i)" "TODO(t)" "WAIT(w)" "HOLD(h)" "|" "DONE(d)" "CANCELLED(c)"))))

;; `pixel-scroll-precision-mode' binds PageUp/PageDown in its own minor-mode
;; keymap, which outranks ghostel's major-mode map — so bind the dispatcher
;; there. Outside a fullscreen ghostel app it falls back to pixel scrolling,
;; leaving behavior everywhere else unchanged.
(after! pixel-scroll
  (map! :map pixel-scroll-precision-mode-map
        "<prior>" #'ismd/ghostel-page-up
        "<next>"  #'ismd/ghostel-page-down))

(after! vertico
  (setq vertico-cycle nil)

  (map! :map vertico-map
        "C-SPC" #'+vertico/embark-preview
        "C-v" #'vertico-scroll-up
        "M-v" #'vertico-scroll-down))

(after! vterm
  (map! :map vterm-mode-map
        "M-1" nil
        "M-2" nil
        "M-3" nil
        "M-4" nil
        "M-5" nil
        "M-6" nil
        "M-7" nil
        "M-8" nil
        "M-9" nil
        "M-0" nil))

(use-package! atomic-chrome
  :config
  (setq atomic-chrome-buffer-open-style 'frame
        atomic-chrome-url-major-mode-alist '(("github\\.com" . gfm-mode)
                                             ("gitlab\\.com" . gfm-mode)
                                             ("reddit\\.com" . markdown-mode)))
  (atomic-chrome-start-server))

(use-package! claude-code-ide
  :bind ("C-c RET" . claude-code-ide-menu)
  :custom
  (claude-code-ide-cli-path "~/.local/bin/claude")
  ;; (claude-code-ide-no-flicker t)
  (claude-code-ide-show-claude-window-in-ediff nil)
  (claude-code-ide-terminal-backend 'ghostel)
  ;; (claude-code-ide-vterm-render-delay 0.01)
  :config
  (claude-code-ide-emacs-tools-setup))

(use-package! gh-copilot-chat
  :hook (git-commit-setup . gh-copilot-chat-insert-commit-message)
  :custom
  (gh-copilot-chat-commit-model "claude-sonnet-5")
  (gh-copilot-chat-frontend 'shell-maker))

(use-package! copilot
  :hook
  (conf-mode . copilot-mode)
  (prog-mode . copilot-mode)
  (text-mode . copilot-mode)
  ;; (copilot-mode . (lambda ()
  ;;                   (setq-local copilot--indent-warning-printed-p t)))
  :custom
  (copilot-idle-delay 1)
  (copilot-indent-offset-warning-disable t)
  :bind
  ("C-c t C" . copilot-mode)
  (:map copilot-completion-map
        ("TAB"     . copilot-accept-completion)
        ("C-e"     . copilot-accept-completion-by-line)
        ("C-g"     . copilot-clear-overlay)
        ("C-c C-n" . copilot-next-completion)
        ("C-c C-p" . copilot-previous-completion)
        ("M-f"     . copilot-accept-completion-by-word)))

(use-package! super-save
  :custom
  (auto-save-default nil)
  (super-save-auto-save-when-idle t)
  (super-save-silent t)
  :config
  (super-save-mode +1))

(use-package! systemd
  :defer t
  :hook (systemd-mode . eglot-ensure)
  :config
  (set-eglot-client! 'systemd-mode '("systemd-lsp")))

(add-hook! '(magit-diff-mode-hook
             magit-mode-hook
             magit-status-mode-hook
             with-editor-mode-hook)
  (display-line-numbers-mode -1))

(remove-hook! '(text-mode-hook conf-mode-hook) #'display-line-numbers-mode)
(remove-hook 'undo-fu-mode-hook #'global-undo-fu-session-mode)
