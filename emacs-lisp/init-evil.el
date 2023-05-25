(setq evil-want-integration t)
(setq evil-want-keybinding nil)
(setq evil-want-C-u-scroll t)
(setq evil-want-C-i-jump nil)
(setq evil-want-respect-visual-line-mode t)
(setq evil-undo-system 'undo-redo)
(require 'evil)
(evil-mode 1)
(dolist (mode '(custom-mode
		eshell-mode
		git-rebase-mode
		term-mode))
  (add-to-list 'evil-emacs-state-modes mode))
(evil-set-initial-state 'messages-buffer-mode 'normal)

(require 'evil-collection)
(setq evil-collection-outline-bind-tab-p nil)
(setq evil-collection-company-use-tng nil)
(evil-collection-init)

(require 'evil-org)
(add-hook 'org-mode-hook 'evil-org-mode)
(add-hook 'org-agenda-mode-hook 'evil-org-mode)
(require 'evil-org-agenda)
(evil-org-set-key-theme '(navigation todo insert textobjects additional))
(evil-org-agenda-set-keys)
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
