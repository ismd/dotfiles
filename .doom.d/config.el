;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
(setq user-full-name "Vladimir Kosteley"
      user-mail-address "chezero@pm.me")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-unicode-font' -- for unicode glyphs
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!
(setq doom-font (font-spec :family "FiraCode Nerd Font" :size 11.0)
      doom-variable-pitch-font (font-spec :family "NotoSans Nerd Font" :size 11.0)
      doom-big-font (font-spec :family "FiraCode Nerd Font" :size 18.0)
      doom-unicode-font (font-spec :family "FiraCode Nerd Font" :size 11.0)
      doom-serif-font (font-spec :family "NotoSerif Nerd Font" :size 11.0))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one-light)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
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

;;
;; Functions
;;
(defun ismd/delete-word (arg)
  "Delete characters until encountering the end of a word.
With argument ARG, do this that many times."
  (interactive "p")
  (delete-region (point) (progn (forward-word arg) (point))))

(defun ismd/backward-delete-word (arg)
  "Delete characters backward until encountering the beginning of a word.
With argument ARG, do this that many times."
  (interactive "p")
  (delete-region (point) (progn (backward-word arg) (point))))

(defun ismd/kill-line ()
  (interactive)
  (cond ((ismd/current-line-empty-p) (delete-char 1))
    (t (delete-region (point) (line-end-position)))))

(defun ismd/current-line-empty-p ()
  (save-excursion
    (beginning-of-line)
    (looking-at "[[:space:]]*$")))

(defun ismd/dired-up-dir ()
  "Go up a directory."
  (interactive)
  (let ((current-dir (dired-current-directory)))
    (find-alternate-file "..")
    (dired-goto-file current-dir)))

;;
;; Keybindings
;;
;; Move cursor with M-n and M-p
(global-set-key (kbd "M-n") "\C-u3\C-v")
(global-set-key (kbd "M-p") "\C-u3\M-v")

;; Winum select window
(global-set-key (kbd "M-0") 'treemacs-select-window)
(global-set-key (kbd "M-1") 'winum-select-window-1)
(global-set-key (kbd "M-2") 'winum-select-window-2)
(global-set-key (kbd "M-3") 'winum-select-window-3)
(global-set-key (kbd "M-4") 'winum-select-window-4)
(global-set-key (kbd "M-5") 'winum-select-window-5)
(global-set-key (kbd "M-6") 'winum-select-window-6)
(global-set-key (kbd "M-7") 'winum-select-window-7)
(global-set-key (kbd "M-8") 'winum-select-window-8)
(global-set-key (kbd "M-9") 'winum-select-window-9)

;; Revert buffer
(global-set-key (kbd "C-M-r") 'revert-buffer)

;; Avy
(global-set-key (kbd "M-s s") 'avy-goto-char-timer)

;; Kill, delete
(global-set-key (kbd "C-k") 'ismd/kill-line)
(global-set-key (kbd "M-d") 'ismd/delete-word)
(global-set-key (kbd "M-<backspace>") 'ismd/backward-delete-word)

;; Workspaces swap
(global-set-key (kbd "C-c w <") '+workspace/swap-left)
(global-set-key (kbd "C-c w >") '+workspace/swap-right)

;; Search
(global-set-key (kbd "C-s") '+default/search-buffer)

;;
;; Init
;;
;;(doom/set-frame-opacity 90)
(setq auto-save-default nil)
(+global-word-wrap-mode +1)
(setq-default cursor-type 'bar)

(custom-set-faces!
  '(font-lock-comment-face :slant italic)
  '(font-lock-keyword-face :slant italic))

;; Dired
(map! :map dired-mode-map "<backspace>" #'ismd/dired-up-dir)

;; Indent rigidly
(map! :map indent-rigidly-map "b" #'indent-rigidly-left)
(map! :map indent-rigidly-map "f" #'indent-rigidly-right)
(map! :map indent-rigidly-map "B" #'indent-rigidly-left-to-tab-stop)
(map! :map indent-rigidly-map "F" #'indent-rigidly-right-to-tab-stop)

;; Vertico
(after! vertico
  (setq vertico-cycle nil))

;; Ws-butler
(after! ws-butler
  (add-to-list 'ws-butler-global-exempt-modes 'org-mode))

;; Super save
(use-package! super-save
  :ensure t
  :config
  (super-save-mode +1)
  (setq super-save-auto-save-when-idle t))

;; Company
(setq company-idle-delay nil)
;; (setq +company-backend-alist '(
;;   (org-mode company-capf)
;;   (text-mode company-yasnippet)
;;   (prog-mode company-capf company-yasnippet)
;;   (conf-mode company-capf company-dabbrev-code company-yasnippet)))

;; Projectile
(setq projectile-project-search-path '(("~/coding/" . 1) ("~/a/data-ui/" . 1)))

;; (projectile-register-project-type 'arcadia '("a.yaml")
;;   :project-file "a.yaml"
;;   :compile "npm install"
;;   :test "npm test"
;;   :run "npm start"
;;   :test-suffix ".spec")

;; Org-agenda
(setq
  org-fancy-priorities-list '("⚡" "☝" "⚑")
  org-agenda-block-separator 8411)

(setq org-agenda-custom-commands
      '(("v" "A better agenda view"
         ((tags "work"
                ((org-agenda-skip-function '(org-agenda-skip-entry-if 'todo 'done))
                 (org-agenda-overriding-header "Work tasks:")))
           (tags "private"
                ((org-agenda-skip-function '(org-agenda-skip-entry-if 'todo 'done))
                 (org-agenda-overriding-header "Private tasks:")))

          (agenda "")))))

;; Centaur tabs
(after! centaur-tabs
  (centaur-tabs-change-fonts "Anonymice Nerd Font" 130)
  (centaur-tabs-group-by-projectile-project)
  (centaur-tabs-headline-match)
  (centaur-tabs-enable-buffer-reordering)
  (setq centaur-tabs-height 50
    centaur-tabs-set-bar nil
    centaur-tabs-adjust-buffer-order t))
