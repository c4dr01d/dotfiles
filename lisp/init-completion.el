;; -*- lexical-binding: t -*-
(use-package vertico
  :demand t
  :guix (:using channel :name emacs-vertico)
  :bind (:map vertico-map
	 ("C-j" . vertico-next)
	 ("C-k" . vertico-previous)
	 ("C-f" . vertico-exit-input)
	 :map minibuffer-local-map
	 ("M-h" . vertico-directory-up))
  :custom (vertico-cycle t)
  :config (vertico-mode))

(use-package corfu
  :guix (:using channel :name emacs-corfu)
  :hook (minibuffer-setup . corfu-enable-in-minibuffer)
  :bind (:map corfu-map
	 ("C-j" . corfu-next)
	 ("C-k" . corfu-previous)
	 ("TAB" . corfu-insert)
	 ("C-f" . corfu-insert))
  :custom
  (corfu-cycle t)
  (corfu-auto t)
  (corfu-preview-current nil)
  (corfu-quit-at-boundary t)
  (corfu-quit-no-match t)
  :config
  (global-corfu-mode)
  (defun corfu-enable-in-minibuffer ()
    (when (where-is-internal #'completion-at-point (list (current-local-map)))
      (setq-local corfu-echo-delay nil)
      (setq-local corfu-popupinfo-delay nil)
      (corfu-mode))))

(use-package orderless
  :demand t
  :guix (:using channel :name emacs-orderless)
  :config
  (orderless-define-completion-style orderless+initialism
    (orderless-matching-styles '(orderless-initialism
				 orderless-literal
				 orderless-regexp)))
  (setq completion-styles '(orderless))
  (setq completion-category-defaults nil)
  (setq orderless-matching-styles '(orderless-literal orderless-regexp))
  (setq completion-category-overrides '((file (styles partial-completion)))))

(use-package consult
  :demand t
  :guix (:using channel :name emacs-consult)
  :bind (("C-s" . consult-line)
	 ("C-M-l" . consult-imenu)
	 ("C-x C-b" . consult-buffer)
	 :map minibuffer-local-map
	 ("C-r" . consult-history))
  :custom
  (completion-in-region-function #'consult-completion-in-region))

(use-package consult-dir
  :guix (:using channel :name emacs-consult-dir)
  :bind (("C-x C-d" . consult-dir)
	 :map vertico-map
	 ("C-x C-d" . consult-dir)
	 ("C-x C-j" . consult-dir-jump-file))
  :custom (consult-dir-project-list-function nil))

(use-package marginalia
  :after vertico
  :guix (:using channel :name emacs-marginalia)
  :custom (marginalia-annotators '(marginalia-annotators-heavy
				   marginalia-annotators-light
				   nil))
  :config (marginalia-mode))

(use-package embark
  :after vertico
  :guix (:using channel :name emacs-embark)
  :bind (("C-M-." . embark-act)
	 :map minibuffer-local-map
	 ("C-d" . embark-act))
  :config (setq prefix-help-command #'embark-prefix-help-command))
(provide 'init-completion)
