;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
(setq user-full-name "Vladimir Kosteley"
      user-mail-address "zzismd@gmail.com")

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
(setq doom-font (font-spec :family "FiraCode Nerd Font" :size 19)
      doom-variable-pitch-font (font-spec :family "FiraCode Nerd Font" :size 19)
      doom-big-font (font-spec :family "FiraCode Nerd Font" :size 21)
      doom-unicode-font (font-spec :family "MesloLGS Nerd Font Mono")
      doom-serif-font (font-spec :family "FiraCode Nerd Font" :size 19))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one-light)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/Yandex.Disk/Documents/org/")


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

;; Centaur tabs
(global-set-key (kbd "C-c <")  'centaur-tabs-move-current-tab-to-left)
(global-set-key (kbd "C-c >") 'centaur-tabs-move-current-tab-to-right)

;; Search
(global-set-key (kbd "C-s") '+default/search-buffer)

;;
;; Init
;;
;; Opacity
;;(doom/set-frame-opacity 90)
(global-auto-revert-mode 1)

(setq tab-width 4)
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1))) ;; one line at a time
(setq mouse-wheel-progressive-speed nil) ;; don't accelerate scrolling
(setq treemacs-width 25)

;; Super save
(use-package! super-save
  :ensure t
  :config
  (super-save-mode +1)
  (setq super-save-auto-save-when-idle t))

;; (setq super-save-exclude '(".org" ".md"))

;; Dired
(map! :map dired-mode-map "<backspace>" #'ismd/dired-up-dir)
(map! :map dired-mode-map "C-x M-r" #'dired-du-mode)

;; Centaur tabs
(after! centaur-tabs
  (centaur-tabs-group-by-projectile-project))

;; Indent rigidly
(map! :map indent-rigidly-map "b" #'indent-rigidly-left)
(map! :map indent-rigidly-map "f" #'indent-rigidly-right)
(map! :map indent-rigidly-map "B" #'indent-rigidly-left-to-tab-stop)
(map! :map indent-rigidly-map "F" #'indent-rigidly-right-to-tab-stop)

;; Vertico
(after! vertico
  (setq vertico-cycle nil))

;; Projectile
(setq projectile-project-search-path '(("~/coding/" . 1) ("~/a/data-ui/" . 1)))

;; (projectile-register-project-type 'npm '("package.json")
;;   :project-file "package.json"
;;   :compile "npm install"
;;   :test "npm test"
;;   :run "npm start"
;;   :test-suffix ".spec")

(projectile-register-project-type 'arcadia '("a.yaml")
  :project-file "a.yaml"
  :compile "npm install"
  :test "npm test"
  :run "npm start"
  :test-suffix ".spec")

;; C/C++
(after! c
  (c-set-style "java"))

;; ws-butler
;; Doesn't work right now
;; (remove-hook 'doom-first-buffer-hook #'ws-butler-global-mode)
;; It works
(after! ws-butler
  (add-to-list 'ws-butler-global-exempt-modes 'org-mode))
;; (add-hook! org 'doom-disable-delete-trailing-whitespace-h)

;; Tabnine
(use-package! company-tabnine
  :ensure t
  :after company
  :config
  (add-to-list 'company-backends #'company-tabnine)
  ;; Trigger completion immediately.
  (setq company-idle-delay 1.2))

;; Ivy
(after! ivy
  (setq ivy-extra-directories '("./"))
  (setq ivy-wrap nil)
  (global-set-key (kbd "C-c C-r") 'ivy-resume))
