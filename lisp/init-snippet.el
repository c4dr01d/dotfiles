;; -*- lexical-binding: t -*-
(use-package yasnippet
  :hook ((prog-mode . yas-minor-mode)
         (post-command . local/yas-try-expanding-auto-snippets))
  :config
  (defun local/yas-try-expanding-auto-snippets ()
    (when (and (boundp 'yas-minor-mode) yas-minor-mode)
      (let ((yas-buffer-local-condition '(require-snippet-condition . auto)))
        (yas-expand))))

  (yas-reload-all))

(provide 'init-snippet)
