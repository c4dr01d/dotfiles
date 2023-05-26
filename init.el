;; -*- lexical-binding: t -*-
(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))
(add-to-list 'load-path (expand-file-name "site-lisp" user-emacs-directory))

(defvar is-guix-system
	(and (eq system-type 'gnu/linux)
	     (file-exists-p "/etc/os-release")
	     (with-temp-buffer
               (insert-file-contents "/etc/os-release")
               (search-forward "ID=guix" nil t))
	     t))

(defvar is-windows
	(eq system-type 'windows-nt))

(defvar exwm-enabled
	(and (eq system-type 'gnu/linux)
	     (eq window-system 'x)))

(setq user-full-name "c4droid")
(setq user-mail-address "c4droid@foxmail.com")

(require 'init-package)
(require 'init-evil)
(require 'init-org)
(require 'init-editor)
(require 'init-completion)
(require 'init-dired)
(require 'init-magit)
(require 'init-lisp)
(require 'init-python)
(require 'init-mail)
(when exwm-enabled
  (require 'init-exwm))
