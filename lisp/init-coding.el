;; -*- lexical-binding: t -*-
(use-package prog-mode
  :ensure nil
  :hook (prog-mode . flymake-mode))

(use-package flymake
  :ensure nil
  :bind (:map flymake-mode-map
         ("C-c n" . flymake-goto-next-error)
         ("C-c p" . flymake-goto-prev-error))
  :custom (elisp-flymake-byte-compile-load-path load-path))

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
  :if is-windows
  :after projectile)

(provide 'init-coding)
