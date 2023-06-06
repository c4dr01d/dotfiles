;; -*- lexical-binding: t -*-
(defun macp ()
  (eq system-type 'darwin))

(defun linuxp ()
  (eq system-type 'gnu/linux))

(defun windowsp ()
  (eq system-type 'windows-nt))

(defun guixp ()
  (and (linuxp)
       (file-exists-p "/etc/os-release")
       (with-temp-buffer
         (insert-file-contents "/etc/os-release")
         (search-forward "ID=guix" nil t))
       t))

(defun windows-graphic-p ()
  (and (windowsp)
       (memq (window-system) '(w32))))

(defun linux-graphic-p ()
  (and (linuxp)
       (memq (window-system) '(x))))

(provide 'init-funcs)
