;; -*- lexical-binding: t -*-
(use-package flycheck
  :hook (prog-mode . flycheck-mode)
  :custom (flycheck-emacs-lisp-load-path 'inherit))

(use-package compile
  :ensure nil
  :bind (("C-c c" . compile)
         ("C-c C" . recompile)))

(use-package projectile
  :demand t
  :custom
  (projectile-completion-system 'default)
  (projectile-project-root-files '(".projectile" ".dir-locals.el" ".git"))
  :init (projectile-mode)
  :config
  (defadvice projectile-project-root (around ignore-remote first activate)
    (unless (file-remote-p default-directory) ad-do-it)))

(use-package perspective
  :commands (persp-new persp-switch persp-state-save)
  :hook (kill-emacs . persp-state-save)
  :custom (persp-state-default-file (expand-file-name "var/persp-state.el" user-emacs-directory))
  :init (persp-mode))

(use-package persp-projectile
  :if (windowsp)
  :after projectile)

(provide 'init-coding)
