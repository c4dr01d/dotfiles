;; -*- lexical-binding: t -*-

;; 其他配置加载路径
(add-to-list 'load-path (expand-file-name "modules" user-emacs-directory))

;; 系统平台判别
(defvar is-guix-system
  (and (eq system-type 'gnu/linux)
       (file-exists-p "/etc/os-release")
       (with-temp-buffer
	 (insert-file-contents "/etc/os-release")
	 (search-forward "ID=guix" nil t))
       t))

(defvar exwm-enabled
  (eq window-system 'x))

;; 用户信息
(setq user-full-name "c4droid")
(setq user-mail-address "c4droid@foxmail.com")

;; 加载模块
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
