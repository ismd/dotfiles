;;; init.el --- Emacs configuration -*- lexical-binding: t; -*-

;;; Commentary:
;;; Code:

(org-babel-load-file
  (expand-file-name
    "config.org"
    user-emacs-directory))
(put 'dired-find-alternate-file 'disabled nil)

;;; init.el ends here
