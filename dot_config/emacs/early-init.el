;; Emacs pre-initialisation config -*- lexical-binding: t; -*-

(setq package-enable-at-startup nil)

;; Disable UI elements before they render
(menu-bar-mode -1)
(scroll-bar-mode -1)
(tool-bar-mode -1)

;; Set initial frame colors to match modus-vivendi-tinted, preventing flash
(push '(background-color . "#0d0e1c") default-frame-alist)
(push '(foreground-color . "#ffffff") default-frame-alist)

;; Local Variables:
;; no-byte-compile: t
;; no-native-compile: t
;; no-update-autoloads: t
;; End:
