;; -*- mode: emacs-lisp -*-
;; This file is loaded by Spacemacs at startup.
;; It must be stored in your home directory.

(defun dotspacemacs/layers ()
  "Layer configuration:
This function should only modify configuration layer settings."
  (setq-default
   ;; Base distribution to use. This is a layer contained in the directory
   ;; `+distribution'. For now available distributions are `spacemacs-base'
   ;; or `spacemacs'. (default 'spacemacs)
   dotspacemacs-distribution 'spacemacs

   ;; Lazy installation of layers (i.e. layers are installed only when a file
   ;; with a supported type is opened). Possible values are `all', `unused'
   ;; and `nil'. `unused' will lazy install only unused layers (i.e. layers
   ;; not listed in variable `dotspacemacs-configuration-layers'), `all' will
   ;; lazy install any layer that support lazy installation even the layers
   ;; listed in `dotspacemacs-configuration-layers'. `nil' disable the lazy
   ;; installation feature and you have to explicitly list a layer in the
   ;; variable `dotspacemacs-configuration-layers' to install it.
   ;; (default 'unused)
   dotspacemacs-enable-lazy-installation 'unused

   ;; If non-nil then Spacemacs will ask for confirmation before installing
   ;; a layer lazily. (default t)
   dotspacemacs-ask-for-lazy-installation t

   ;; If non-nil layers with lazy install support are lazy installed.
   ;; List of additional paths where to look for configuration layers.
   ;; Paths must have a trailing slash (i.e. `~/.mycontribs/')
   dotspacemacs-configuration-layer-path '()

   ;; List of configuration layers to load.
   dotspacemacs-configuration-layers
   '(
     ;; ----------------------------------------------------------------
     ;; Example of useful layers you may want to use right away.
     ;; Uncomment some layer names and press `SPC f e R' (Vim style) or
     ;; `M-m f e R' (Emacs style) to install them.
     ;; ----------------------------------------------------------------
     (auto-completion :variables
                      auto-completion-enable-help-tooltip t
                      auto-completion-enable-sort-by-usage t
                      auto-completion-tab-key-behavior 'complete)
     (better-defaults :variables
                      better-defaults-move-to-beginning-of-code-first t
                      better-defaults-move-to-end-of-code-first nil)
     (c-c++ :variables
            c-c++-default-mode-for-headers 'c++-mode
            c-c++-enable-clang-support nil
            c-c++-enable-rtags-support t)
     ;; cscope
     csv
     emacs-lisp
     git
     ;; (gtags :variables
     ;;        gtags-enable-by-default t)
     helm
     html
     javascript
     (markdown :variables
               markdown-live-preview-engine 'vmd)
     neotree
     nginx
     ;; nlinum
     org
     php
     (python :variables
             python-enable-yapf-format-on-save t
             python-sort-imports-on-save t)
     (ranger :variables
             ranger-show-preview t)
     ;; semantic
     (shell :variables
            shell-default-height 30
            shell-default-position 'bottom
            shell-default-shell 'shell)
     shell-scripts
     (spell-checking :variables
                     spell-checking-enable-by-default nil
                     spell-checking-enable-auto-dictionary t
                     enable-flyspell-auto-completion nil)
     sql
     systemd
     (syntax-checking :variables
                      syntax-checking-enable-by-default nil
                      syntax-checking-enable-tooltips t)
     ;; tabbar
     themes-megapack
     (version-control :variables
                      version-control-diff-tool 'git-gutter
                      version-control-diff-side 'left
                      version-control-global-margin t)
     yaml)

   ;; List of additional packages that will be installed without being
   ;; wrapped in a layer. If you need some configuration for these
   ;; packages, then consider creating a layer. You can also put the
   ;; configuration in `dotspacemacs/user-config'.
   ;; To use a local version of a package, use the `:location' property:
   ;; '(your-package :location "~/path/to/your-package/")
   ;; Also include the dependencies as they will not be resolved automatically.
   dotspacemacs-additional-packages '(
                                      cmake-mode
                                      doom-themes
                                      editorconfig
                                      minimap
                                      pdf-tools
                                      yasnippet-snippets)

   ;; A list of packages that cannot be updated.
   dotspacemacs-frozen-packages '()

   ;; A list of packages that will not be installed and loaded.
   dotspacemacs-excluded-packages '()

   ;; Defines the behaviour of Spacemacs when installing packages.
   ;; Possible values are `used-only', `used-but-keep-unused' and `all'.
   ;; `used-only' installs only explicitly used packages and deletes any unused
   ;; packages as well as their unused dependencies. `used-but-keep-unused'
   ;; installs only the used packages but won't delete unused ones. `all'
   ;; installs *all* packages supported by Spacemacs and never uninstalls them.
   ;; (default is `used-only')
   dotspacemacs-install-packages 'used-only))

(defun dotspacemacs/init ()
  "Initialization:
This function is called at the very beginning of Spacemacs startup,
before layer configuration.
It should only modify the values of Spacemacs settings."
  ;; This setq-default sexp is an exhaustive list of all the supported
  ;; spacemacs settings.
  (setq-default
   ;; If non-nil ELPA repositories are contacted via HTTPS whenever it's
   ;; possible. Set it to nil if you have no way to use HTTPS in your
   ;; environment, otherwise it is strongly recommended to let it set to t.
   ;; This variable has no effect if Emacs is launched with the parameter
   ;; `--insecure' which forces the value of this variable to nil.
   ;; (default t)
   dotspacemacs-elpa-https t

   ;; Maximum allowed time in seconds to contact an ELPA repository.
   ;; (default 5)
   dotspacemacs-elpa-timeout 5

   ;; Set `gc-cons-threshold' and `gc-cons-percentage' when startup finishes.
   ;; This is an advanced option and should not be changed unless you suspect
   ;; performance issues due to garbage collection operations.
   ;; (default '(100000000 0.1))
   dotspacemacs-gc-cons '(100000000 0.1)

   ;; If non-nil then Spacelpa repository is the primary source to install
   ;; a locked version of packages. If nil then Spacemacs will install the
   ;; latest version of packages from MELPA. (default nil)
   dotspacemacs-use-spacelpa nil

   ;; If non-nil then verify the signature for downloaded Spacelpa archives.
   ;; (default nil)
   dotspacemacs-verify-spacelpa-archives nil

   ;; If non-nil then spacemacs will check for updates at startup
   ;; when the current branch is not `develop'. Note that checking for
   ;; new versions works via git commands, thus it calls GitHub services
   ;; whenever you start Emacs. (default nil)
   dotspacemacs-check-for-update nil

   ;; If non-nil, a form that evaluates to a package directory. For example, to
   ;; use different package directories for different Emacs versions, set this
   ;; to `emacs-version'. (default 'emacs-version)
   dotspacemacs-elpa-subdirectory 'emacs-version

   ;; One of `vim', `emacs' or `hybrid'.
   ;; `hybrid' is like `vim' except that `insert state' is replaced by the
   ;; `hybrid state' with `emacs' key bindings. The value can also be a list
   ;; with `:variables' keyword (similar to layers). Check the editing styles
   ;; section of the documentation for details on available variables.
   ;; (default 'vim)
   dotspacemacs-editing-style 'emacs

   ;; If non-nil output loading progress in `*Messages*' buffer. (default nil)
   dotspacemacs-verbose-loading nil

   ;; Specify the startup banner. Default value is `official', it displays
   ;; the official spacemacs logo. An integer value is the index of text
   ;; banner, `random' chooses a random text banner in `core/banners'
   ;; directory. A string value must be a path to an image format supported
   ;; by your Emacs build.
   ;; If the value is nil then no banner is displayed. (default 'official)
   dotspacemacs-startup-banner 'random

   ;; List of items to show in startup buffer or an association list of
   ;; the form `(list-type . list-size)`. If nil then it is disabled.
   ;; Possible values for list-type are:
   ;; `recents' `bookmarks' `projects' `agenda' `todos'.
   ;; List sizes may be nil, in which case
   ;; `spacemacs-buffer-startup-lists-length' takes effect.
   dotspacemacs-startup-lists '((recents . 5)
                                (projects . 7))

   ;; True if the home buffer should respond to resize events. (default t)
   dotspacemacs-startup-buffer-responsive t

   ;; Default major mode of the scratch buffer (default `text-mode')
   dotspacemacs-scratch-mode 'text-mode

   ;; Initial message in the scratch buffer, such as "Welcome to Spacemacs!"
   ;; (default nil)
   dotspacemacs-initial-scratch-message nil

   ;; List of themes, the first of the list is loaded when spacemacs starts.
   ;; Press `SPC T n' to cycle to the next theme in the list (works great
   ;; with 2 themes variants, one dark and one light)
   dotspacemacs-themes '(spacemacs-light
                         spacemacs-dark
                         doom-one
                         afternoon)

   ;; Set the theme for the Spaceline. Supported themes are `spacemacs',
   ;; `all-the-icons', `custom', `vim-powerline' and `vanilla'. The first three
   ;; are spaceline themes. `vanilla' is default Emacs mode-line. `custom' is a
   ;; user defined themes, refer to the DOCUMENTATION.org for more info on how
   ;; to create your own spaceline theme. Value can be a symbol or list with\
   ;; additional properties.
   ;; (default '(spacemacs :separator wave :separator-scale 1.5))
   dotspacemacs-mode-line-theme '(all-the-icons :separator arrow :separator-scale 1.5)

   ;; If non-nil the cursor color matches the state color in GUI Emacs.
   ;; (default t)
   dotspacemacs-colorize-cursor-according-to-state t

   ;; Default font, or prioritized list of fonts. `powerline-scale' allows to
   ;; quickly tweak the mode-line size to make separators look not too crappy.
   dotspacemacs-default-font '("Hack"
                               :size 14
                               :weight normal
                               :width normal)

   ;; The leader key (default "SPC")
   dotspacemacs-leader-key "SPC"

   ;; The key used for Emacs commands `M-x' (after pressing on the leader key).
   ;; (default "SPC")
   dotspacemacs-emacs-command-key "SPC"

   ;; The key used for Vim Ex commands (default ":")
   dotspacemacs-ex-command-key ":"

   ;; The leader key accessible in `emacs state' and `insert state'
   ;; (default "M-m")
   dotspacemacs-emacs-leader-key "M-m"

   ;; Major mode leader key is a shortcut key which is the equivalent of
   ;; pressing `<leader> m`. Set it to `nil` to disable it. (default ",")
   dotspacemacs-major-mode-leader-key ","

   ;; Major mode leader key accessible in `emacs state' and `insert state'.
   ;; (default "C-M-m")
   dotspacemacs-major-mode-emacs-leader-key "C-M-m"

   ;; These variables control whether separate commands are bound in the GUI to
   ;; the key pairs `C-i', `TAB' and `C-m', `RET'.
   ;; Setting it to a non-nil value, allows for separate commands under `C-i'
   ;; and TAB or `C-m' and `RET'.
   ;; In the terminal, these pairs are generally indistinguishable, so this only
   ;; works in the GUI. (default nil)
   dotspacemacs-distinguish-gui-tab nil

   ;; If non-nil `Y' is remapped to `y$' in Evil states. (default nil)
   dotspacemacs-remap-Y-to-y$ nil

   ;; If non-nil, the shift mappings `<' and `>' retain visual state if used
   ;; there. (default t)
   dotspacemacs-retain-visual-state-on-shift t

   ;; If non-nil, `J' and `K' move lines up and down when in visual mode.
   ;; (default nil)
   dotspacemacs-visual-line-move-text nil

   ;; If non-nil, inverse the meaning of `g' in `:substitute' Evil ex-command.
   ;; (default nil)
   dotspacemacs-ex-substitute-global nil

   ;; Name of the default layout (default "Default")
   dotspacemacs-default-layout-name "Default"

   ;; If non-nil the default layout name is displayed in the mode-line.
   ;; (default nil)
   dotspacemacs-display-default-layout nil

   ;; If non-nil then the last auto saved layouts are resumed automatically upon
   ;; start. (default nil)
   dotspacemacs-auto-resume-layouts nil

   ;; If non-nil, auto-generate layout name when creating new layouts. Only has
   ;; effect when using the "jump to layout by number" commands. (default nil)
   dotspacemacs-auto-generate-layout-names nil

   ;; Size (in MB) above which spacemacs will prompt to open the large file
   ;; literally to avoid performance issues. Opening a file literally means that
   ;; no major mode or minor modes are active. (default is 1)
   dotspacemacs-large-file-size 1

   ;; Location where to auto-save files. Possible values are `original' to
   ;; auto-save the file in-place, `cache' to auto-save the file to another
   ;; file stored in the cache directory and `nil' to disable auto-saving.
   ;; (default 'cache)
   dotspacemacs-auto-save-file-location 'cache

   ;; Maximum number of rollback slots to keep in the cache. (default 5)
   dotspacemacs-max-rollback-slots 5

   ;; If non-nil, `helm' will try to minimize the space it uses. (default nil)
   dotspacemacs-helm-resize nil

   ;; if non-nil, the helm header is hidden when there is only one source.
   ;; (default nil)
   dotspacemacs-helm-no-header nil

   ;; define the position to display `helm', options are `bottom', `top',
   ;; `left', or `right'. (default 'bottom)
   dotspacemacs-helm-position 'bottom

   ;; Controls fuzzy matching in helm. If set to `always', force fuzzy matching
   ;; in all non-asynchronous sources. If set to `source', preserve individual
   ;; source settings. Else, disable fuzzy matching in all sources.
   ;; (default 'always)
   dotspacemacs-helm-use-fuzzy 'always

   ;; If non-nil, the paste transient-state is enabled. While enabled, pressing
   ;; `p' several times cycles through the elements in the `kill-ring'.
   ;; (default nil)
   dotspacemacs-enable-paste-transient-state nil

   ;; Which-key delay in seconds. The which-key buffer is the popup listing
   ;; the commands bound to the current keystroke sequence. (default 0.4)
   dotspacemacs-which-key-delay 0.4

   ;; Which-key frame position. Possible values are `right', `bottom' and
   ;; `right-then-bottom'. right-then-bottom tries to display the frame to the
   ;; right; if there is insufficient space it displays it at the bottom.
   ;; (default 'bottom)
   dotspacemacs-which-key-position 'bottom

   ;; Control where `switch-to-buffer' displays the buffer. If nil,
   ;; `switch-to-buffer' displays the buffer in the current window even if
   ;; another same-purpose window is available. If non-nil, `switch-to-buffer'
   ;; displays the buffer in a same-purpose window even if the buffer can be
   ;; displayed in the current window. (default nil)
   dotspacemacs-switch-to-buffer-prefers-purpose nil

   ;; If non-nil a progress bar is displayed when spacemacs is loading. This
   ;; may increase the boot time on some systems and emacs builds, set it to
   ;; nil to boost the loading time. (default t)
   dotspacemacs-loading-progress-bar t

   ;; If non-nil the frame is fullscreen when Emacs starts up. (default nil)
   ;; (Emacs 24.4+ only)
   dotspacemacs-fullscreen-at-startup nil

   ;; If non-nil `spacemacs/toggle-fullscreen' will not use native fullscreen.
   ;; Use to disable fullscreen animations in OSX. (default nil)
   dotspacemacs-fullscreen-use-non-native nil

   ;; If non-nil the frame is maximized when Emacs starts up.
   ;; Takes effect only if `dotspacemacs-fullscreen-at-startup' is nil.
   ;; (default nil) (Emacs 24.4+ only)
   dotspacemacs-maximized-at-startup t

   ;; A value from the range (0..100), in increasing opacity, which describes
   ;; the transparency level of a frame when it's active or selected.
   ;; Transparency can be toggled through `toggle-transparency'. (default 90)
   dotspacemacs-active-transparency 90

   ;; A value from the range (0..100), in increasing opacity, which describes
   ;; the transparency level of a frame when it's inactive or deselected.
   ;; Transparency can be toggled through `toggle-transparency'. (default 90)
   dotspacemacs-inactive-transparency 90

   ;; If non-nil show the titles of transient states. (default t)
   dotspacemacs-show-transient-state-title t

   ;; If non-nil show the color guide hint for transient state keys. (default t)
   dotspacemacs-show-transient-state-color-guide t

   ;; If non-nil unicode symbols are displayed in the mode line. (default t)
   dotspacemacs-mode-line-unicode-symbols t

   ;; If non-nil smooth scrolling (native-scrolling) is enabled. Smooth
   ;; scrolling overrides the default behavior of Emacs which recenters point
   ;; when it reaches the top or bottom of the screen. (default t)
   dotspacemacs-smooth-scrolling t

   ;; Control line numbers activation.
   ;; If set to `t' or `relative' line numbers are turned on in all `prog-mode' and
   ;; `text-mode' derivatives. If set to `relative', line numbers are relative.
   ;; This variable can also be set to a property list for finer control:
   ;; '(:relative nil
   ;;   :disabled-for-modes dired-mode
   ;;                       doc-view-mode
   ;;                       markdown-mode
   ;;                       org-mode
   ;;                       pdf-view-mode
   ;;                       text-mode
   ;;   :size-limit-kb 1000)
   ;; (default nil)
   dotspacemacs-line-numbers t

   ;; Code folding method. Possible values are `evil' and `origami'.
   ;; (default 'evil)
   dotspacemacs-folding-method 'evil

   ;; If non-nil `smartparens-strict-mode' will be enabled in programming modes.
   ;; (default nil)
   dotspacemacs-smartparens-strict-mode nil

   ;; If non-nil pressing the closing parenthesis `)' key in insert mode passes
   ;; over any automatically added closing parenthesis, bracket, quote, etc…
   ;; This can be temporary disabled by pressing `C-q' before `)'. (default nil)
   dotspacemacs-smart-closing-parenthesis t

   ;; Select a scope to highlight delimiters. Possible values are `any',
   ;; `current', `all' or `nil'. Default is `all' (highlight any scope and
   ;; emphasis the current one). (default 'all)
   dotspacemacs-highlight-delimiters 'all

   ;; If non-nil, start an Emacs server if one is not already running.
   dotspacemacs-enable-server nil

   ;; If non-nil, advise quit functions to keep server open when quitting.
   ;; (default nil)
   dotspacemacs-persistent-server nil

   ;; List of search tool executable names. Spacemacs uses the first installed
   ;; tool of the list. Supported tools are `rg', `ag', `pt', `ack' and `grep'.
   ;; (default '("rg" "ag" "pt" "ack" "grep"))
   dotspacemacs-search-tools '("rg" "ag" "pt" "ack" "grep")

   ;; Format specification for setting the frame title.
   ;; %a - the `abbreviated-file-name', or `buffer-name'
   ;; %t - `projectile-project-name'
   ;; %I - `invocation-name'
   ;; %S - `system-name'
   ;; %U - contents of $USER
   ;; %b - buffer name
   ;; %f - visited file name
   ;; %F - frame name
   ;; %s - process status
   ;; %p - percent of buffer above top of window, or Top, Bot or All
   ;; %P - percent of buffer above bottom of window, perhaps plus Top, or Bot or All
   ;; %m - mode name
   ;; %n - Narrow if appropriate
   ;; %z - mnemonics of buffer, terminal, and keyboard coding systems
   ;; %Z - like %z, but including the end-of-line format
   ;; (default "%I@%S")
   dotspacemacs-frame-title-format "%I@%S"

   ;; Format specification for setting the icon title format
   ;; (default nil - same as frame-title-format)
   dotspacemacs-icon-title-format nil

   ;; Delete whitespace while saving buffer. Possible values are `all'
   ;; to aggressively delete empty line and long sequences of whitespace,
   ;; `trailing' to delete only the whitespace at end of lines, `changed' to
   ;; delete only whitespace for changed lines or `nil' to disable cleanup.
   ;; (default nil)
   dotspacemacs-whitespace-cleanup nil

   ;; Either nil or a number of seconds. If non-nil zone out after the specified
   ;; number of seconds. (default nil)
   dotspacemacs-zone-out-when-idle nil

   ;; Run `spacemacs/prettify-org-buffer' when
   ;; visiting README.org files of Spacemacs.
   ;; (default nil)
   dotspacemacs-pretty-docs nil))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; mousescroll
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun ismd/mousescroll ()
  ;; mouse-wheel scrolling
  (setq mouse-wheel-scroll-amount '(1 ((shift) . 1)
                                      ((control)))  ; one line at a time
        mouse-wheel-progressive-speed t             ; accelerate scrolling
        mouse-wheel-follow-mouse t)                 ; scroll- window under mouse

  (setq scroll-preserve-screen-position t ; keep relative column position when scrolling
        scroll-margin 3                   ; start scrolling n lines before window borders
        scroll-conservatively 10          ; scroll up to n lines to bring pointer back on screen
        scroll-step 0                     ; try scrolling n lines when pointer moves out
        auto-window-vscroll nil))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; modes
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun ismd/modes ()
  (global-company-mode)
  ;; (global-whitespace-mode t)
  (delete-selection-mode t)
  (xterm-mouse-mode t)
  (editorconfig-mode t)
  (global-auto-revert-mode t))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; keybindings
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun ismd/keybindings ()
  (interactive)

  ;; arrow keys
  (global-set-key (kbd "M-<left>") 'windmove-left)
  (global-set-key (kbd "M-<right>") 'windmove-right)
  (global-set-key (kbd "M-<up>") 'windmove-up)
  (global-set-key (kbd "M-<down>") 'windmove-down)

  (global-set-key (kbd "C-<left>") 'backward-word)
  (global-set-key (kbd "C-<right>") 'forward-word)
  (global-set-key (kbd "C-<up>") 'backward-paragraph)
  (global-set-key (kbd "C-<down>") 'forward-paragraph)

  ;; word deletion
  (global-set-key (kbd "M-d") 'sp-delete-word)
  (global-set-key (kbd "M-<backspace>") 'sp-backward-delete-word)
  (global-set-key (kbd "C-<delete>") 'sp-delete-word)
  (global-set-key (kbd "C-<backspace>") 'sp-backward-delete-word)

  ;; tab
  (global-set-key (kbd "<tab>") 'tab-indent-or-complete)
  ;; (global-set-key (kbd "C-<tab>") 'insert-tab)
  (global-set-key (kbd "S-<tab>") 'tab-indent-or-complete)
  (global-set-key (kbd "<backtab>") 'tab-indent-or-complete)

  ;; find file
  (global-set-key (kbd "M-m f f") 'helm-find)

  ;; just one space
  (global-set-key (kbd "M-SPC") 'just-one-space)

  ;; delete region
  (global-set-key (kbd "C-k") 'ismd/kill-line)

  ;; revert buffer
  (global-set-key (kbd "C-x C-r") 'revert-buffer)

  ;; rtags
  (rtags-enable-standard-keybindings))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; defaults
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun ismd/defaults ()
  ;; (setq backward-delete-char-untabify-method nil)

  ;; offsets
  (setq-default indent-tabs-mode nil)
  (setq-default tab-width 4)
  (setq-default js2-basic-offset 4)

  ;; cursor type
  ;; (setq-default evil-emacs-state-cursor '("chartreuse3" (hbar . 2)))

  ;; utf-8
  (prefer-coding-system 'utf-8)

  ;; link to X primary clipboard
  (setq-default x-select-enable-clipboard t)
  (setq-default interprogram-paste-function 'x-cut-buffer-or-selection-value)

  ;; require a ending newline
  (setq require-final-newline t)

  ;; warnings
  (setq-default warning-minimum-level :emergency)

  ;; no shell path warning
  ;; (setq exec-path-from-shell-check-startup-file nil)

  ;; spaceline
  (spaceline-toggle-buffer-size-off)
  (spaceline-toggle-column-off)
  (spaceline-toggle-minor-modes-off)

  ;; cmake
  (setq auto-mode-alist
        (append
         '(("CMakeLists\\.txt\\'" . cmake-mode))
         '(("\\.cmake\\'" . cmake-mode))
         auto-mode-alist))

  ;; projectile
  (setq-default projectile-switch-project-action 'neotree-projectile-action)

  ;; neotree
  (setq-default neo-autorefresh nil
                neo-banner-message nil
                neo-confirm-change-root 'off-p
                neo-mode-line-type 'none
                neo-toggle-window-keep-p nil)

  ;; c++
  (setq-default flycheck-gcc-language-standard "c++17")
  (setq-default flycheck-clang-language-standard "c++17")
  (setq-default company-clang-arguments '("-std=c++17"))

  ;; web-mode
  (setq-default web-mode-markup-indent-offset 4)
  (setq-default web-mode-css-indent-offset 4)
  (setq-default web-mode-code-indent-offset 4)
  (setq-default web-mode-attr-indent-offset nil)

  ;; python
  (setq-default python-indent-offset 4)
  (setq-default python-fill-docstring-style 'symmetric)

  ;; eshell
  (setq-default pcomplete-cycle-completions t))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; hooks
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun ismd/hooks ()
  (defun ismd/python-mode-hook ()
    ;; (setq flycheck-checker 'python-pylint
    ;;       flycheck-checker-error-threshold 300)

    ;; don't show anaconda mode error popup gaaarrhhgh
    ;; (remove-hook 'anaconda-mode-response-read-fail-hook
    ;;              'anaconda-mode-show-unreadable-response)

    ;; smart tabs
    ;; (smart-tabs-advice py-indent-line py-indent-offset)
    ;; (smart-tabs-advice py-newline-and-indent py-indent-offset)
    ;; (smart-tabs-advice py-indent-region py-indent-offset)
    )

  (defun ismd/web-mode-hook ()
    (setq-local company-idle-delay nil)

    (make-variable-buffer-local 'er/try-expand-list)
    (setq er/try-expand-list (append
                              er/try-expand-list
                              '(er/mark-html-attribute
                                er/mark-inner-tag
                                er/mark-outer-tag))))

  (defun ismd/emmet-mode-hook ()
    (define-key emmet-mode-keymap (kbd "<C-return>") 'emmet-expand)
    (evil-define-key 'insert emmet-mode-keymap (kbd "TAB") 'tab-indent-or-complete)
    (evil-define-key 'insert emmet-mode-keymap (kbd "<tab>") 'tab-indent-or-complete)
    (evil-define-key 'emacs emmet-mode-keymap (kbd "TAB") 'tab-indent-or-complete)
    (evil-define-key 'emacs emmet-mode-keymap (kbd "<tab>") 'tab-indent-or-complete)
    (evil-define-key 'hybrid emmet-mode-keymap (kbd "TAB") 'tab-indent-or-complete)
    (evil-define-key 'hybrid emmet-mode-keymap (kbd "<tab>") 'tab-indent-or-complete)
  )

  (defun ismd/js-mode-hook ())

  (defun ismd/json-mode-hook ()
    (setq-local js-indent-level 2))

  (defun ismd/c-mode-common-hook ())

  (defun ismd/c++-mode-hook ()
    (push 'company-rtags company-backends)
    ;; cmake-ide
    ;; (cmake-ide-setup)
    )

  (defun ismd/dired-mode-hook ()
    (setq dired-listing-switches "-lah --group-directories-first")
    (setq delete-by-moving-to-trash nil)
    (local-set-key (kbd "<backspace>") #'ismd/dired-up-dir))

  (defun ismd/focus-out-hook ()
    (save-some-buffers t))

  ;; (defun ismd/php-mode-hook ()
  ;;   (setq c-auto-newline nil))

  (defun ismd/neotree-mode-hook ()
    (setq-local neo-vc-integration '(face)))

  (defun ismd/terminal-hook ()
    (make-variable-buffer-local 'scroll-margin)
    (setq-local scroll-margin 0)
    (setq-local show-trailing-whitespace nil))

  (defun ismd/term-mode-hook ()
    (define-key term-raw-map (kbd "C-p") 'term-send-up)
    (define-key term-raw-map (kbd "C-n") 'term-send-down)
    (define-key term-raw-map (kbd "C-r") 'term-send-reverse-search-history)
    (define-key term-raw-map (kbd "M-.") 'term-send-raw-meta)
    (add-to-list 'term-bind-key-alist '("M-<backspace>" . term-send-backward-kill-word)))

  ;; hooks
  (add-hook 'python-mode-hook 'ismd/python-mode-hook)
  (add-hook 'web-mode-hook  'ismd/web-mode-hook)
  (add-hook 'emmet-mode-hook 'ismd/emmet-mode-hook)
  (add-hook 'js-mode-hook 'ismd/js-mode-hook)
  (add-hook 'json-mode-hook 'ismd/json-mode-hook)
  (add-hook 'c-mode-common-hook 'ismd/c-mode-common-hook)
  (add-hook 'c-++-mode-hook 'ismd/c++-mode-hook)
  (add-hook 'dired-mode-hook 'ismd/dired-mode-hook)
  (add-hook 'focus-out-hook 'ismd/focus-out-hook)
  ;; (add-hook 'php-mode-hook 'ismd/php-mode-hook)
  (add-hook 'neotree-mode-hook 'ismd/neotree-mode-hook)
  (add-hook 'term-mode-hook 'ismd/terminal-hook)
  (add-hook 'eshell-mode-hook 'ismd/terminal-hook)
  (add-hook 'shell-mode-hook 'ismd/terminal-hook)
  (add-hook 'compilation-mode-hook 'ismd/terminal-hook)
  (add-hook 'term-mode-hook 'ismd/term-mode-hook)

  ;; flycheck
  (add-hook 'c-mode-hook 'flycheck-mode)
  (add-hook 'c++-mode-hook 'flycheck-mode)

  ;; rtags
  (add-hook 'c-mode-hook 'rtags-start-process-unless-running)
  (add-hook 'c++-mode-hook 'rtags-start-process-unless-running)
  (add-hook 'objc-mode-hook 'rtags-start-process-unless-running)

  ;; isearch
  (add-hook 'isearch-mode-end-hook 'spacemacs/evil-search-clear-highlight)

  ;; correct zsh coloring in shell:
  ;; (add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)

  ;; don't echo passwords when using interactive terminal programs
  (add-hook 'comint-output-filter-functions 'comint-watch-for-password-prompt)

  ;; spacemacs buffer click
  (add-hook 'spacemacs-buffer-mode-hook (lambda ()
                                          (set (make-local-variable 'mouse-1-click-follows-link) nil)))

  ;; org
  (spacemacs|use-package-add-hook org
				  :pre-init
				  (package-initialize))

  (add-hook 'org-mode-hook (lambda ()
                             (setq org-pomodoro-audio-player "/usr/bin/mplayer")))

  ;; electric
  (add-hook 'after-change-major-mode-hook (lambda() (electric-indent-mode -1))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; functions
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun insert-tab ()
  (interactive)
  (insert-char ?\t))

(defun check-expansion ()
  (save-excursion
    (if (looking-at "\\_>") t
      (backward-char 1)
      (if (looking-at "\\.") t
        (backward-char 1)
        (if (looking-at "->") t nil)))))

(defun tab-indent-or-complete ()
  (interactive)
  (if (minibufferp)
    (minibuffer-complete)
    (if (check-expansion)
      (company-complete-common)
      (indent-for-tab-command))))

(defun ismd/reverse-input-method (input-method)
    "Build the reverse mapping of single letters from INPUT-METHOD."
    (interactive
     (list (read-input-method-name "Use input method (default current): ")))
    (if (and input-method (symbolp input-method))
        (setq input-method (symbol-name input-method)))
    (let ((current current-input-method)
          (modifiers '(nil (control) (meta) (control meta))))
      (when input-method
        (activate-input-method input-method))
      (when (and current-input-method quail-keyboard-layout)
        (dolist (map (cdr (quail-map)))
          (let* ((to (car map))
                 (from (quail-get-translation
                        (cadr map) (char-to-string to) 1)))
            (when (and (characterp from) (characterp to))
              (dolist (mod modifiers)
                (define-key local-function-key-map
                  (vector (append mod (list from)))
                  (vector (append mod (list to)))))))))
      (when input-method
        (activate-input-method current))))

(defun ismd/kill-line ()
  (interactive)
  (delete-region (point) (line-end-position)))

(defun ismd/dired-up-dir ()
  "Go up a directory."
  (interactive)
  (let ((current-dir (dired-current-directory)))
    (find-alternate-file "..")
    (dired-goto-file current-dir)))

(defun ismd/revert-all-file-buffers ()
  "Refresh all open file buffers without confirmation.
Buffers in modified (not yet saved) state in emacs will not be reverted. They
will be reverted though if they were modified outside emacs.
Buffers visiting files which do not exist any more or are no longer readable
will be killed."
  (interactive)
  (dolist (buf (buffer-list))
    (let ((filename (buffer-file-name buf)))
      ;; Revert only buffers containing files, which are not modified;
      ;; do not try to revert non-file buffers like *Messages*.
      (when (and filename
                 (not (buffer-modified-p buf)))
        (if (file-readable-p filename)
            ;; If the file exists and is readable, revert the buffer.
            (with-current-buffer buf
              (revert-buffer :ignore-auto :noconfirm :preserve-modes))
          ;; Otherwise, kill the buffer.
          (let (kill-buffer-query-functions) ; No query done when killing buffer
            (kill-buffer buf)
            (message "Killed non-existing/unreadable file buffer: %s" filename))))))
  (message "Finished reverting buffers containing unmodified files."))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; spacemacs init hooks
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun dotspacemacs/user-init ()
  "Initialization for user code:
This function is called immediately after `dotspacemacs/init', before layer
configuration.
It is mostly for variables that should be set before packages are loaded.
If you are unsure, try setting them in `dotspacemacs/user-config' first."

  (setq custom-file "~/.cache/custom.el")
  (ismd/hooks))

(defun dotspacemacs/user-config ()
  "Configuration for user code:
This function is called at the very end of Spacemacs startup, after layer
configuration.
Put your configuration code here, except for variables that should be set
before packages are loaded."

  (ismd/modes)
  (ismd/keybindings)
  (ismd/defaults)
  (ismd/mousescroll)

  ;; yes or no
  (fset 'yes-or-no-p 'y-or-n-p)

  ;; russian computer
  (ismd/reverse-input-method 'russian-computer)

  ;; neotree theme
  ;; (doom-themes-neotree-config)
  )
