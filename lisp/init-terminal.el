;; -*- lexical-binding: t -*-
(use-package eshell
  :ensure nil
  :bind ("C-c s s" . eshell))

(use-package term
  :ensure nil
  :bind ("C-c s t" . ansi-term))

(use-package exec-path-from-shell
  :if is-linux
  :hook (emacs-startup . (lambda ()
                           (setq exec-path-from-shell-arguments '("-l"))
                           (exec-path-from-shell-initialize))))

(provide 'init-terminal)
