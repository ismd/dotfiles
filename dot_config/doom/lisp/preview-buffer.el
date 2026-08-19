;;; lisp/preview-buffer.el -*- lexical-binding: t; -*-

;; Preview buffers, in the spirit of VS Code's preview tab.  A file opened by
;; browsing -- treemacs, dired, xref, grep, consult -- lands in a single
;; temporary buffer.  Opening the next one replaces it; editing it, or running
;; `ismd/preview-keep', turns it into an ordinary buffer.
;;
;; A buffer that was already open stays permanent: like VS Code, browsing to it
;; never demotes it back to a preview.

;; `face-remap-add-relative' is autoloaded but `face-remap-remove-relative' is
;; not, so pull the library in explicitly.
(require 'face-remap)

(defvar ismd/preview-buffer nil
  "The buffer currently held open as a preview, or nil.")

(defvar-local ismd/preview-buffer-p nil
  "Non-nil when this buffer is the preview buffer.")

(defvar-local ismd/preview--face-cookie nil
  "Cookie from `face-remap-add-relative' italicising the modeline file name.")

(defvar ismd/preview--busy nil
  "Non-nil while a command from `ismd/preview-commands' is on the stack.
Keeps the outermost command in charge when they nest, e.g. `compile-goto-error'
calling `next-error'.")

(defvar ismd/preview-commands
  '(treemacs-visit-node-no-split
    treemacs-visit-node-in-most-recently-used-window
    dired-find-file
    dired-find-alternate-file
    dired-find-file-other-window
    +lookup/definition
    +lookup/references
    +lookup/implementations
    +lookup/type-definition
    xref-goto-xref
    xref-find-definitions
    xref-find-references
    compile-goto-error
    next-error
    previous-error
    first-error
    consult-ripgrep
    consult-grep
    consult-git-grep
    consult-line
    consult-flymake
    flymake-goto-diagnostic
    +default/search-project
    +default/search-cwd)
  "Commands whose file visits are treated as temporary previews.
Changing this only takes effect the next time `ismd/preview-buffers-mode' is
turned on.")

(defface ismd/preview-modeline
  '((t (:inherit (doom-modeline-buffer-file italic))))
  "Face for the preview marker in the mode line.")

(defun ismd/preview--promote (&optional buffer)
  "Turn BUFFER (default current) into an ordinary, permanent buffer.
Also used as a buffer-local `first-change-hook', which is why it takes no
required argument."
  (with-current-buffer (or buffer (current-buffer))
    (when ismd/preview-buffer-p
      (setq ismd/preview-buffer-p nil)
      (remove-hook 'first-change-hook #'ismd/preview--promote t)
      (when ismd/preview--face-cookie
        (face-remap-remove-relative ismd/preview--face-cookie)
        (setq ismd/preview--face-cookie nil))
      (force-mode-line-update))
    (when (eq (current-buffer) ismd/preview-buffer)
      (setq ismd/preview-buffer nil))))

(defun ismd/preview--disposable-p (buffer)
  "Non-nil when BUFFER is a preview that may be killed to make room for another."
  (and (buffer-live-p buffer)
       (buffer-local-value 'ismd/preview-buffer-p buffer)
       (not (buffer-modified-p buffer))
       (not (get-buffer-window buffer t))
       (not (get-buffer-process buffer))))

(defun ismd/preview--reap (buffer)
  "Kill BUFFER if it is still an unwanted preview."
  (when (ismd/preview--disposable-p buffer)
    (let ((kill-buffer-query-functions nil))
      (kill-buffer buffer))))

(defun ismd/preview--mark (buffer)
  "Make BUFFER the preview buffer, retiring the previous one."
  (let ((old ismd/preview-buffer))
    (setq ismd/preview-buffer buffer)
    (with-current-buffer buffer
      (unless ismd/preview-buffer-p
        (setq ismd/preview-buffer-p t)
        (add-hook 'first-change-hook #'ismd/preview--promote nil t)
        (setq ismd/preview--face-cookie
              (face-remap-add-relative 'doom-modeline-buffer-file 'italic)))
      (force-mode-line-update))
    (when (and old (not (eq old buffer)))
      ;; The old preview is still on screen right now; let redisplay swap it out
      ;; before deciding whether it is safe to kill.
      (run-at-time 0 nil #'ismd/preview--reap old))))

(defun ismd/preview--call (fn &rest args)
  "Apply FN to ARGS, then treat any file it opened as the preview buffer.
Used both as `:around' advice on `ismd/preview-commands' and directly by
`ismd/preview-find-file'."
  (if ismd/preview--busy
      (apply fn args)
    (let ((known (buffer-list))
          (ismd/preview--busy t))
      (prog1 (apply fn args)
        ;; `buffer-list' is most-recently-used first, so the first hit is the
        ;; file the command just visited.
        (let ((opened (seq-find (lambda (buf)
                                  (and (buffer-file-name buf)
                                       (not (memq buf known))))
                                (buffer-list)))
              (shown (window-buffer (selected-window))))
          (cond
           ;; A file buffer that did not exist before: this is the preview.
           (opened (ismd/preview--mark opened))
           ;; Revisiting the current preview keeps it a preview.
           ((eq shown ismd/preview-buffer) (ismd/preview--mark shown))))))))

(defun ismd/preview-find-file (filename &optional wildcards)
  "Visit FILENAME as a preview, whatever the usual behaviour would be.
Ordinary `find-file' opens a file for good, as in VS Code; this is the
deliberate \"just let me look at it\" counterpart.  FILENAME and WILDCARDS are
read exactly as `find-file' reads them."
  (interactive (find-file-read-args "Preview file: "
                                    (confirm-nonexistent-file-or-buffer)))
  (ismd/preview--call #'find-file filename wildcards))

(defun ismd/preview-keep ()
  "Keep the current buffer around, cancelling its preview status."
  (interactive)
  (if ismd/preview-buffer-p
      (progn
        (ismd/preview--promote)
        (message "Buffer kept"))
    (message "Not a preview buffer")))

;;;###autoload
(define-minor-mode ismd/preview-buffers-mode
  "Open browsed files in a single temporary buffer, like VS Code's preview tab."
  :global t
  :group 'convenience
  (if ismd/preview-buffers-mode
      (dolist (cmd ismd/preview-commands)
        (advice-add cmd :around #'ismd/preview--call))
    (dolist (cmd ismd/preview-commands)
      (advice-remove cmd #'ismd/preview--call))
    (dolist (buf (buffer-list))
      (ismd/preview--promote buf))))

;; `misc-info' is part of doom-modeline's `main' modeline and renders
;; `mode-line-misc-info' in every window, active or not.
(add-to-list 'mode-line-misc-info
             '(ismd/preview-buffer-p
               (:propertize " PREVIEW" face ismd/preview-modeline))
             t)

(provide 'preview-buffer)
;;; preview-buffer.el ends here
