;; -*- lexical-binding: t -*-
(use-package dired
  :ensure nil
  :config
  (setq dired-omit-files (rx line-start ?. (* nonl)))
  (setq dired-create-destination-dirs 'ask)
  (setq dired-vc-rename-file t)
  (setq dired-listing-switches "-alh --group-directories-first")
  (setq dired-recursive-copies 'always)
  (setq dired-recursive-deletes 'always)
  (setq dired-dwim-target t)
  (setq dired-auto-revert-buffer t)
  (setq wdired-allow-to-change-permissions t)
  (with-eval-after-load 'dired
    (add-hook 'dired-mode-hook 'dired-omit-mode)
    (add-hook 'dired-mode-hook 'hl-line-mode)))
(provide 'init-dired)
