;; -*- lexical-binding: t -*-
(use-package vertico
  :demand t
  :hook ((minibuffer-setup . vertico-repeat-save)
         (rfn-eshadow-update-overlay . vertico-directory-tidy))
  :bind (:map vertico-map
	 ("C-j" . vertico-next)
	 ("C-k" . vertico-previous)
	 ("C-f" . vertico-exit-input)
	 :map minibuffer-local-map
	 ("M-h" . vertico-directory-up))
  :custom
  (vertico-cycle t)
  (vertico-grid-separator "       ")
  (vertico-grid-lookahead 50)
  (vertico-buffer-display-action '(display-buffer-reuse-window))
  (vertico-multiform-categories '((file indexed)
                                  (consult-grep buffer)
                                  (consult-location)
                                  (imenu buffer)
                                  (library reverse indexed)
                                  (org-roam-node reverse indexed)
                                  (t reverse)))
  (vertico-multiform-commands '((org-refile grid reverse indexed)
                                (consult-yank-pop indexed)
                                (consult-flymake)
                                (consult-lsp-diagnostics)))
  :config
  (vertico-mode)

  (defun local/basic-remote-try-completion (string table pred point)
    (and (vertico--remote-p string)
         (completion-basic-try-completion string table pred point)))

  (defun local/basic-remote-all-completions (string table pred point)
    (and (vertico--remote-p string)
         (completion-basic-all-completions string table pred point)))

  (add-to-list 'completion-styles-alist
               '(basic-remote
                 local/basic-remote-try-completion
                 local/basic-remote-all-completions
                 nil))

  (setq completion-in-region-function (lambda (&rest args)
                                        (apply (if vertico-mode
                                                   #'consult-completion-in-region
                                                 #'completion--in-region)
                                               args)))
  
  (advice-add #'vertico--format-candidate
              :around (lambda (orig cand prefix suffix index _start)
                        (setq cand (funcall orig cand prefix suffix index _start))
                        (concat
                         (if (= vertico--index index)
                             (propertize "> " 'face 'vertico-current)
                           "  ")
                         cand))))

(use-package corfu
  :hook ((minibuffer-setup . corfu-enable-in-minibuffer)
         (prog-mode . corfu-mode)
         (org-mode . corfu-mode))
  :bind (:map corfu-map
	 ("C-j" . corfu-next)
	 ("C-k" . corfu-previous)
	 ("TAB" . corfu-insert)
	 ("C-f" . corfu-insert))
  :custom
  (corfu-cycle t)
  (corfu-auto nil)
  (corfu-auto-delay 0)
  (corfu-auto-prefix 0)
  (corfu-preview-current nil)
  (corfu-quit-at-boundary t)
  (corfu-quit-no-match t)
  :config
  (defun corfu-enable-in-minibuffer ()
    (when (where-is-internal #'completion-at-point (list (current-local-map)))
      (setq-local corfu-auto nil)
      (setq-local corfu-echo-delay nil)
      (setq-local corfu-popupinfo-delay nil)
      (corfu-mode))))

(use-package orderless
  :custom
  (completion-category-defaults nil)
  (completion-category-overrides '((file (styles partial-completion))))
  (completion-styles '(orderless)))

(use-package consult
  :demand t
  :bind (("C-s" . consult-line)
	 ("C-M-l" . consult-imenu)
	 ("C-x C-b" . consult-buffer)
	 :map minibuffer-local-map
	 ("C-r" . consult-history))
  :custom
  (completion-in-region-function #'consult-completion-in-region)
  (xref-show-xrefs-function #'consult-xref)
  (xref-show-definitions-function #'consult-xref)
  :config (setq consult-project-root-function #'projectile-project-root))

(use-package consult-dir
  :bind (("C-x C-d" . consult-dir)
	 :map vertico-map
	 ("C-x C-d" . consult-dir)
	 ("C-x C-j" . consult-dir-jump-file))
  :custom (consult-dir-project-list-function nil))

(use-package marginalia
  :after vertico
  :custom (marginalia-annotators '(marginalia-annotators-heavy
				   marginalia-annotators-light
				   nil))
  :init (marginalia-mode)
  :config (with-eval-after-load 'projectile
            (add-to-list 'marginalia-command-categories '(projectile-find-file . file))))

(use-package embark
  :after vertico
  :bind (("C-M-." . embark-act)
	 :map minibuffer-local-map
	 ("C-d" . embark-act))
  :config (setq prefix-help-command #'embark-prefix-help-command))
(provide 'init-completion)
