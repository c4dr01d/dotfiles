;; -*- lexical-binding: t -*-
(require 'package)
(when (not is-guix-system)
  (setq package-archives '(("gnu" . "https://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")
                           ("nongnu" . "https://mirrors.tuna.tsinghua.edu.cn/elpa//nongnu/")
                           ("melpa" . "https://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/")))
  (defun advice/save-selected-packages (&optional value)
    (when value
      (setq package-selected-packages value)))
  (advice-add 'package--save-selected-packages :override #'advice/save-selected-packages)
  (unless (bound-and-true-p package--initialized)
    (package-initialize))
  (unless (package-installed-p 'use-package)
    (package-refresh-contents)
    (package-install 'use-package)))
(eval-and-compile
  (setq use-package-always-ensure (not is-guix-system))
  (setq use-package-always-defer t)
  (setq use-package-expand-minimally t))
(eval-when-compile
  (require 'use-package))
(require 'guix-extra)
(provide 'init-package)
