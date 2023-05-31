;; -*- lexical-binding: t -*-
(use-package magit
  :custom
  (magit-save-repository-buffers nil)
  (magit-diff-refile-hunk 'all)
  :init (setq magit-display-buffer-function 'magit-display-buffer-fullframe-status-v1))
(provide 'init-magit)
