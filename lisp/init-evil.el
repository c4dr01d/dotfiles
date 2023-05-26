;; -*- lexical-binding: t -*-
(global-set-key (kbd "C-M-u") 'universal-argument)

(use-package evil
  :demand t
  :guix (:using channel :name emacs-evil)
  :hook (after-init . evil-mode)
  :init
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  (setq evil-want-C-u-scroll t)
  (setq evil-want-C-i-jump nil)
  (setq evil-respect-visual-line-mode t)
  (setq evil-undo-system 'undo-redo)
  :config
  (dolist (mode '(custom-mode
                  eshell-mode
                  git-rebase-mode
                  term-mode))
    (add-to-list 'evil-emacs-state-modes mode))
  (evil-set-initial-state 'messages-buffer-mode 'normal))

(use-package evil-collection
  :after evil
  :guix (:using channel :name emacs-evil-collection)
  :custom
  (evil-collection-outline-bind-tab-p nil)
  :config
  (setq evil-collection-company-use-tng nil)
  (evil-collection-init))

(use-package evil-org
  :after (evil org)
  :guix (:using channel :name emacs-evil-org)
  :hook ((org-mode . evil-org-mode)
         (org-agenda-mode . evil-org-mode))
  :config
  (require 'evil-org-agenda)
  (evil-org-set-key-theme '(navigation todo insert textobjects additional))
  (evil-org-agenda-set-keys))

(with-eval-after-load 'org
  (evil-define-key '(normal insert visual) org-mode-map (kbd "C-j") 'org-next-visible-heading)
  (evil-define-key '(normal insert visual) org-mode-map (kbd "C-k") 'org-previous-visible-heading)
  (evil-define-key '(normal insert visual) org-mode-map (kbd "M-j") 'org-metadown)
  (evil-define-key '(normal insert visual) org-mode-map (kbd "M-k") 'org-metaup))

(with-eval-after-load 'exwm
  (add-hook 'exwm-mode-hook
            (lambda ()
              (evil-local-set-key 'motion (kbd "C-u") nil))))
(provide 'init-evil)
