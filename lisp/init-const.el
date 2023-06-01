;; -*- lexical-binding: t -*-
(defvar is-linux
        (eq system-type 'gnu/linux))

(defvar is-linux-graphical
        (and is-linux
             (display-graphic-p)))

(defvar is-guix-system
	(and is-linux
	     (file-exists-p "/etc/os-release")
	     (with-temp-buffer
               (insert-file-contents "/etc/os-release")
               (search-forward "ID=guix" nil t))
	     t))

(defvar is-windows
	(eq system-type 'windows-nt))

(defvar is-windows-graphical
        (and is-windows
             (display-graphic-p)))

(defvar exwm-enabled
	(and is-linux
	     (eq window-system 'x)))

(provide 'init-const)
