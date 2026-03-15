;; Emacs pre-initialisation config -*- lexical-binding: t; -*-

(setq package-enable-at-startup nil)

;; Maximize GC threshold during startup (restored in core.org)
(setq gc-cons-threshold most-positive-fixnum)

;; Disable UI elements via frame params (avoids frame redraws)
(push '(menu-bar-lines . 0) default-frame-alist)
(push '(tool-bar-lines . 0) default-frame-alist)
(push '(vertical-scroll-bars) default-frame-alist)

;; Set initial frame colors to match modus-vivendi-tinted, preventing flash
(push '(background-color . "#0d0e1c") default-frame-alist)
(push '(foreground-color . "#ffffff") default-frame-alist)

;; Temporarily nullify file-name-handler-alist during startup
(defvar ismd/file-name-handler-alist file-name-handler-alist)
(setq file-name-handler-alist nil)
(add-hook 'emacs-startup-hook
  (lambda ()
    (setq file-name-handler-alist
      (delete-dups (append file-name-handler-alist
                     ismd/file-name-handler-alist)))))

(setq auto-mode-case-fold nil)           ; skip case-insensitive auto-mode pass
(setq ffap-machine-p-known 'reject)      ; don't ping domain-like strings
(setq inhibit-x-resources t)             ; irrelevant on Wayland/PGTK
(setq load-prefer-newer t)               ; prefer newer .el over stale .elc
(setq native-comp-async-report-warnings-errors 'silent)

;; Reduce childframe latency on PGTK (Wayland)
(when (boundp 'pgtk-wait-for-event-timeout)
  (setq pgtk-wait-for-event-timeout 0.001))

;; Local Variables:
;; no-byte-compile: t
;; no-native-compile: t
;; no-update-autoloads: t
;; End:
