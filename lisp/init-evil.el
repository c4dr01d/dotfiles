;; -*- lexical-binding: t -*-
(use-package evil
  :demand t
  :hook (after-init . evil-mode)
  :init
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  (setq evil-want-C-u-scroll t)
  (setq evil-want-C-i-jump nil)
  (setq evil-respect-visual-line-mode t)
  (setq evil-undo-system 'undo-redo)
  (setq evil-lookup-func #'helpful-at-point)
  (setq evil-search-module 'evil-search)
  (setq evil-split-window-below t)
  (setq evil-vsplit-window-right t)
  (setq evil-auto-indent nil)
  :config
  (dolist (mode '(custom-mode
                  eshell-mode
                  git-rebase-mode
                  term-mode))
    (add-to-list 'evil-emacs-state-modes mode))
  (evil-set-initial-state 'messages-buffer-mode 'normal))

(use-package evil-collection
  :after evil
  :demand t
  :custom
  (evil-collection-magit-use-z-for-folds nil)
  (evil-eollection-company-use-tng nil)
  :init (evil-collection-init))

(use-package evil-commentary
  :after evil
  :init (evil-commentary-mode))

(use-package evil-surround
  :after evil
  :init (global-evil-surround-mode))

(use-package evil-cleverparens
  :after evil
  :hook ((emacs-lisp-mode scheme-mode) . local/init-cleverparens)
  :init (defun local/init-cleverparens ()
          (require 'evil-cleverparens-util)

          (evil-define-text-object evil-cp-a-defun (count &optional beg end type)
            (if (evil-cp--inside-form-p)
                (let ((bounds (evil-cp--top-level-bounds)))
                  (evil-range (car bounds) (cdr bounds) 'inclusive :expanded t))
              (error "Not inside a sexp.")))

          (evil-define-text-object evil-cp-inner-defun (count &optional beg end type)
            (if (evil-cp--inside-form-p)
                (let ((bounds (evil-cp--top-level-bounds)))
                  (evil-range (1+ (car bounds)) (1- (cdr bounds)) 'inclusive :expanded t))
              (error "Not inside a sexp.")))

          (define-key evil-outer-text-objects-map "f" #'evil-cp-a-defun)
          (define-key evil-inner-text-objects-map "f" #'evil-cp-inner-defun)))

(use-package evil-org
  :after (evil org)
  :hook ((org-mode . evil-org-mode)
         (org-agenda-mode . evil-org-mode))
  :config
  (require 'evil-org-agenda)
  (evil-org-set-key-theme '(navigation todo insert textobjects additional))
  (evil-org-agenda-set-keys))

(use-package which-key
  :demand t
  :custom
  (which-key-separator " ")
  (which-key-prefix-prefix "+")
  :init (which-key-mode))

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
