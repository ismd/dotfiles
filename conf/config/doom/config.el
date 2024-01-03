(after! doom-themes
  (setq doom-themes-enable-bold t
        doom-themes-enable-italic t))

(custom-set-faces!
  '(font-lock-comment-face :slant italic)
  '(font-lock-keyword-face :slant italic))

(setq user-full-name "Vladimir Kosteley"
      user-mail-address "cz@cqz.me")

(setq auto-save-default nil)

(use-package! super-save
  :ensure t
  :config
  (super-save-mode +1)
  (setq super-save-auto-save-when-idle t))

(after! company
  (setq
    ;; company-frontends '(company-pseudo-tooltip-frontend company-preview-frontend)
    company-idle-delay nil
    company-minimum-prefix-length 0))

(setq +lsp-company-backends '(:separate company-capf company-files))

(after! prog-mode
  (set-company-backend! 'prog-mode
    '(:separate company-capf company-files)
    '(:separate company-dabbrev-code company-keywords)))

;; (after! terraform-mode
;;   (set-company-backend! 'terraform-mode
;;     '(:separate company-terraform company-capf company-files)
;;     '(:separate company-dabbrev-code company-keywords)))

;; (after! web-mode
;;   (set-company-backend! 'web-mode
;;     '(:separate company-capf company-files)
;;     '(:separate company-dabbrev-code company-keywords)))

(global-set-key (kbd "C-c C-/") #'company-other-backend)

;; accept completion from copilot and fallback to company
(use-package! copilot
  :hook (prog-mode . copilot-mode)
  :bind (:map copilot-completion-map
              ("<tab>" . 'copilot-accept-completion)
              ("TAB" . 'copilot-accept-completion)
              ("C-TAB" . 'copilot-accept-completion-by-word)
              ("C-<tab>" . 'copilot-accept-completion-by-word)))

;; (setq-default cursor-type 'bar)
(blink-cursor-mode)

(add-hook! dart-mode
  (lsp-dart-closing-labels-mode)
  (lsp-dart-flutter-fringe-colors-mode)
  (lsp-dart-flutter-widget-guides-mode))

(use-package dirvish
  :init
  (dirvish-override-dired-mode)
  ;; :custom
  ;; (dirvish-quick-access-entries ; It's a custom option, `setq' won't work
  ;;  '(("h" "~/"                          "Home")
  ;;    ("d" "~/Downloads/"                "Downloads")
  ;;    ("m" "/mnt/"                       "Drives")
  ;;    ("t" "~/.local/share/Trash/files/" "TrashCan")))
  :config
  ;; (dirvish-peek-mode) ; Preview files in minibuffer
  (dirvish-side-follow-mode) ; similar to `treemacs-follow-mode'
  (setq dirvish-mode-line-format
        '(:left (sort symlink) :right (omit yank index)))
  (setq dirvish-attributes
        '(file-time collapse vc-state git-msg))
  (setq delete-by-moving-to-trash t)
  (setq dired-listing-switches
        "-l --almost-all --human-readable --group-directories-first --no-group")
  :bind ; Bind `dirvish|dirvish-side|dirvish-dwim' as you see fit
  (("C-c f" . dirvish-fd)
   ("C-c o p" . dirvish-side)
   :map dirvish-mode-map ; Dirvish inherits `dired-mode-map'
   ("a"   . dirvish-quick-access)
   ("f"   . dirvish-file-info-menu)
   ("y"   . dirvish-yank-menu)
   ("N"   . dirvish-narrow)
   ("^"   . dirvish-history-last)
   ("h"   . dirvish-history-jump) ; remapped `describe-mode'
   ("s"   . dirvish-quicksort)    ; remapped `dired-sort-toggle-or-edit'
   ("v"   . dirvish-vc-menu)      ; remapped `dired-view-file'
   ("TAB" . dirvish-subtree-toggle)
   ("M-f" . dirvish-history-go-forward)
   ("M-b" . dirvish-history-go-backward)
   ("M-l" . dirvish-ls-switches-menu)
   ("M-m" . dirvish-mark-menu)
   ("M-t" . dirvish-layout-toggle)
   ("M-s" . dirvish-setup-menu)
   ("M-e" . dirvish-emerge-menu)
   ("M-j" . dirvish-fd-jump)))

(after! doom-modeline
  (setq doom-modeline-enable-word-count t
        doom-modeline-persp-name t
        doom-modeline-persp-icon t
        doom-modeline-major-mode-icon t))

(defun set-exec-path-from-shell-PATH ()
  "Set up Emacs' `exec-path' and PATH environment variable to match
that used by the user's shell.

This is particularly useful under Mac OS X and macOS, where GUI
apps are not started from a shell."
  (interactive)
  (let ((path-from-shell (replace-regexp-in-string
        "[ \t\n]*$" "" (shell-command-to-string
            "$SHELL --login -c 'string join : $PATH'"
            ))))
    (setenv "PATH" path-from-shell)
    (setq exec-path (split-string path-from-shell path-separator))))

(set-exec-path-from-shell-PATH)

(setq doom-font (font-spec :family "FiraCode Nerd Font Mono" :size 15.0 :dpi 144)
      doom-variable-pitch-font (font-spec :family "UbuntuMono Nerd Font" :size 15.0 :dpi 144)
      doom-big-font (font-spec :family "FiraCode Nerd Font Mono" :size 60.0 :dpi 144)
      doom-symbols-font (font-spec :family "Symbols Nerd Font Mono" :size 15.0 :dpi 144)
      doom-serif-font (font-spec :family "UbuntuMono Nerd Font" :size 15.0 :dpi 144)
      )

(setq +format-on-save-enabled-modes '(not emacs-lisp-mode sql-mode tex-mode latex-mode org-msg-edit-mode yaml-mode))

(add-hook! ibuffer
  (ibuffer-projectile-set-filter-groups)
  (unless (eq ibuffer-sorting-mode 'alphabetic)
    (ibuffer-do-sort-by-alphabetic)))

(after! ivy
  (setq ivy-use-virtual-buffers t)
  (setq ivy-count-format "(%d/%d) ")
  (setq +ivy-buffer-preview 'everything))

(setq auto-mode-alist (delete '("\\.[mc]?js\\'" . rjsx-mode) auto-mode-alist))
(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))

;; (setq-hook! 'json-mode-hook +format-with-lsp nil)

(global-set-key (kbd "M-s") 'avy-goto-char-timer)

(global-set-key (kbd "C-c <") 'previous-buffer)
(global-set-key (kbd "C-c >") 'next-buffer)

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

;; (global-set-key (kbd "M-d") 'ismd/delete-word)
;; (global-set-key (kbd "M-<backspace>") 'ismd/backward-delete-word)
(global-set-key (kbd "M-d") 'ismd/delete-word)
(global-set-key (kbd "M-<backspace>") 'ismd/backward-delete-word)

(defun ismd/dired-up-dir ()
  "Go up a directory."
  (interactive)
  (let ((current-dir (dired-current-directory)))
    (find-alternate-file "..")
    (dired-goto-file current-dir)))

(map! :map dired-mode-map "<backspace>" #'ismd/dired-up-dir)

(map! :map indent-rigidly-map "b" #'indent-rigidly-left)
(map! :map indent-rigidly-map "f" #'indent-rigidly-right)
(map! :map indent-rigidly-map "B" #'indent-rigidly-left-to-tab-stop)
(map! :map indent-rigidly-map "F" #'indent-rigidly-right-to-tab-stop)

(defun ismd/kill-line ()
  (interactive)
  (cond ((ismd/current-line-empty-p) (delete-char 1))
    (t (delete-region (point) (line-end-position)))))

(defun ismd/current-line-empty-p ()
  (save-excursion
    (beginning-of-line)
    (looking-at "[[:space:]]*$")))

;; (global-set-key (kbd "C-k") 'ismd/kill-line)

(global-set-key (kbd "M-n") "\C-u3\C-v")
(global-set-key (kbd "M-p") "\C-u3\M-v")

(global-set-key (kbd "C-s") '+default/search-buffer)

;; (global-set-key (kbd "C-<iso-lefttab>") 'centaur-tabs-backward-tab)
;; (global-set-key (kbd "C-<tab>") 'centaur-tabs-forward-tab)
;; (global-set-key (kbd "C-<") 'centaur-tabs-move-current-tab-to-left)
;; (global-set-key (kbd "C->") 'centaur-tabs-move-current-tab-to-right)

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

(global-set-key (kbd "C-c w <") '+workspace/swap-left)
(global-set-key (kbd "C-c w >") '+workspace/swap-right)

(setq display-line-numbers-type t)
(global-visual-line-mode t)
;; (+global-word-wrap-mode +1)

(use-package! lsp-mode
  :init
  (setq lsp-enable-symbol-highlighting t
        lsp-lens-enable t
        lsp-headerline-breadcrumb-enable t
        lsp-modeline-code-actions-enable t
        lsp-diagnostics-provider :flycheck
        lsp-completion-show-detail t
        lsp-completion-show-kind t))

(use-package! lsp-ui
  :init
  (setq ;; lsp-ui-doc-enable t
   lsp-ui-imenu-enable t
   lsp-ui-sideline-enable t))

;; (doom/set-frame-opacity 50)

(add-to-list 'default-frame-alist '(alpha-background . 92))

(setq calendar-week-start-day 1)
(setq org-startup-with-inline-images t
      org-startup-with-latex-preview t)

(setq org-fancy-priorities-list '("⚡" "☝" "⚑")
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

(setq org-directory "~/org/")

(with-eval-after-load 'org (global-org-modern-mode))

(setq projectile-project-search-path '(("~/coding" . 1)))

(pixel-scroll-precision-mode)

(add-hook! org-mode 'rainbow-mode)
(add-hook! prog-mode 'rainbow-mode)

(after! centaur-tabs
  (centaur-tabs-group-by-projectile-project)
  (centaur-tabs-headline-match)
  (setq
   centaur-tabs-gray-out-icons 'buffer
   centaur-tabs-set-bar 'left
   centaur-tabs-set-icons t
   centaur-tabs-show-count t
   centaur-tabs-show-new-tab-button nil
   ;; centaur-tabs-adjust-buffer-order t
   x-underline-at-descent-line t
   ))

(use-package lsp-mode
  :ensure t
  :hook ((terraform-mode . lsp-deferred)))

(setq doom-theme 'doom-one)

(setq tramp-terminal-type "tramp")

(add-hook! treemacs-mode
  (treemacs-follow-mode))

;; (after! vertico
;;   (setq vertico-cycle nil))

(after! ws-butler
  (add-to-list 'ws-butler-global-exempt-modes 'org-mode))
