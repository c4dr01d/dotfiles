;; -*- lexical-binding: t -*-
(unless (daemonp)
  (defvar initial-file-name-handler-alist file-name-handler-alist)
  (setq file-name-handler-alist nil)
  (defun reset-file-handler-alist ()
    (dolist (handler file-name-handler-alist)
      (add-to-list 'initial-file-name-handler-alist handler))
    (setq file-name-handler-alist initial-file-name-handler-alist))
  (add-hook 'emacs-startup-hook #'reset-file-handler-alist))

(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))
(add-to-list 'load-path (expand-file-name "site-lisp" user-emacs-directory))

(defvar is-linux
        (eq system-type 'gnu/linux))

(defvar is-guix-system
	(and is-linux
	     (file-exists-p "/etc/os-release")
	     (with-temp-buffer
               (insert-file-contents "/etc/os-release")
               (search-forward "ID=guix" nil t))
	     t))

(defvar is-windows
	(eq system-type 'windows-nt))

(defvar exwm-enabled
	(and is-linux
	     (eq window-system 'x)))

(setq user-full-name "c4droid")
(setq user-mail-address "c4droid@foxmail.com")

(require 'init-package)
(require 'init-editor)
(require 'init-evil)
(require 'init-completion)
(require 'init-dired)
(require 'init-magit)
(require 'init-terminal)
(require 'init-coding)
(require 'init-snippet)
(require 'init-lsp)
(require 'init-lisp)
(require 'init-python)
(require 'init-web)
(require 'init-org)
(require 'init-mail)
(when exwm-enabled
  (require 'init-exwm))
