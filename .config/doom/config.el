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
    company-idle-delay 0
    company-minimum-prefix-length 1)
  (add-to-list 'company-frontends 'company-preview-frontend))

(setq +company-backend-alist '(
                               (conf-mode (:separate company-files :separate company-capf :separate company-dabbrev-code company-dabbrev :separate company-yasnippet))
                               (prog-mode (:separate company-files :separate company-capf :with company-yasnippet :separate company-dabbrev-code))
                               ;; (terraform-mode (:separate company-files :separate company-terraform :with company-yasnippet))
                               (text-mode (:separate company-files :separate company-capf :separate company-dabbrev-code company-dabbrev :separate company-ispell :separate company-yasnippet))))

(after! terraform-mode
  (set-company-backend! 'terraform-mode '(:separate company-files :separate company-terraform :with company-yasnippet)))

(global-set-key (kbd "C-c C-/") #'company-other-backend)

;; (setq-default cursor-type 'bar)
(blink-cursor-mode)

(after! doom-modeline
  (setq doom-modeline-enable-word-count t
        doom-modeline-persp-name t
        doom-modeline-persp-icon t
        doom-modeline-major-mode-icon t))

(setq doom-font (font-spec :family "FiraCode Nerd Font Mono" :size 14.0)
      doom-variable-pitch-font (font-spec :family "JetBrainsMonoNL Nerd Font" :size 14.0)
      doom-big-font (font-spec :family "FiraCode Nerd Font Mono" :size 22.0)
      ;; doom-unicode-font (font-spec :family "Iosevka Nerd Font Mono" :size 13.0)
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

(global-set-key (kbd "M-s s") 'avy-goto-char-timer)

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

(setq doom-theme 'doom-one)

(setq tramp-terminal-type "tramp")

(add-hook! treemacs-mode
  (treemacs-follow-mode))

;; (after! vertico
;;   (setq vertico-cycle nil))

(after! ws-butler
  (add-to-list 'ws-butler-global-exempt-modes 'org-mode))
