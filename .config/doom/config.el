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
    company-idle-delay 1
    company-minimum-prefix-length 1)
  ;; (add-to-list 'company-frontends 'company-preview-frontend)
  )

(setq +lsp-company-backends nil)

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

;; (setq-default cursor-type 'bar)
(blink-cursor-mode)

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
      doom-variable-pitch-font (font-spec :family "Ubuntu Nerd Font" :size 15.0 :dpi 144)
      doom-big-font (font-spec :family "FiraCode Nerd Font Mono" :size 25.0 :dpi 144)
      doom-symbols-font (font-spec :family "Symbols Nerd Font Mono" :size 15.0 :dpi 144)
      doom-serif-font (font-spec :family "Ubuntu Nerd Font" :size 15.0 :dpi 144)
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

;; (add-to-list 'default-frame-alist '(alpha-background . 50))

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

(pixel-scroll-precision-mode)

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
