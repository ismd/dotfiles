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

;; Reduce childframe latency on PGTK (Wayland)
(when (boundp 'pgtk-wait-for-event-timeout)
  (setq pgtk-wait-for-event-timeout 0.001))

;; Local Variables:
;; no-byte-compile: t
;; no-native-compile: t
;; no-update-autoloads: t
;; End:
