(setq magit-save-repository-buffers nil)
(setq magit-diff-refile-hunk 'all)
(with-eval-after-load 'magit-mode
  (setq magit-display-buffer-function 'magit-display-buffer-fullframe-status-v1))
(provide 'init-magit)
