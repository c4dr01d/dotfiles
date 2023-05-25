(setq geiser-default-implementations 'guile)
(setq geiser-active-implementations '(guile))
(add-hook 'geiser-mode-hook #'macrostep-geiser-setup)
(add-hook 'geiser-repl-mode-hook #'macrostep-geiser-setup)

(setq eval-expression-print-level nil)
(setq eval-expression-print-length nil)
(provide 'init-lisp)
