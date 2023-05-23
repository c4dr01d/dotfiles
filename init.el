;; -*- lexical-binding: t -*-
(setq user-full-name "c4droid")
(setq user-mail-address "c4droid@foxmail.com")

(load-theme 'solarized-light t)

(setq inhibit-startup-screen t)
(setq inhibit-startup-echo-area-message t)
(setq initial-scratch-message nil)

(tooltip-mode 0)
(menu-bar-mode 0)
(tool-bar-mode 0)
(scroll-bar-mode 0)
(fringe-mode 0)
(blink-cursor-mode 0)
(setq-default cursor-type 'bar)

(add-hook 'prog-mode-hook 'display-line-numbers-mode)

(setq mode-line-compact t)
(setq column-number-indicator-zero-based nil)
(column-number-mode)

(add-hook 'grep-mode-hook 'wgrep-setup)

(electric-pair-mode)

(require 'vertico)
(define-key vertico-map "C-j" 'vertico-next)
(define-key vertico-map "C-k" 'vertico-previous)
(define-key vertico-map "C-f" 'vertico-exit-input)
(define-key minibuffer-local-map "M-h" 'vertico-directory-up)
(setq vertico-cycle t)
(vertico-mode)

(require 'corfu)
(define-key corfu-map "C-j" 'corfu-next)
(define-key corfu-map "C-k" 'corfu-previous)
(define-key corfu-map "TAB" 'corfu-insert)
(define-key corfu-map "C-f" 'corfu-insert)
(setq corfu-cycle t)
(setq corfu-auto t)
(setq corfu-preview-current nil)
(setq corfu-quit-at-bounary t)
(setq corfu-quit-no-match t)
(global-corfu-mode)
(defun corfu-enable-in-minibuffer ()
  (when (where-is-internal #'completion-at-point (list (current-local-map)))
    (setq-local corfu-echo-delay nil)
    (setq-local corfu-popupinfo-delay nil)
    (corfu-mode)))
(add-hook 'minibuffer-setup-hook #'corfu-enable-in-minibuffer)

(require 'orderless)
(setq completion-styles '(orderless))
(setq completion-category-defaults nil)
(setq orderless-matching-styles '(orderless-literal orderless-regexp))
(setq completion-category-overrides '((file (styles partial-completion))))

(require 'consult)
(require 'consult-dir)
(global-set-key (kbd "C-s") 'consult-line)
(global-set-key (kbd "C-M-l") 'consult-imenu)
(global-set-key (kbd "C-x C-b") 'consult-buffer)
(define-key minibuffer-local-map "C-r" 'consult-history)
(setq completion-in-region-function #'consult-completion-in-region)
(global-set-key (kbd "C-x C-d") 'consult-dir)
(define-key vertico-map (kbd "C-x C-d") 'consult-dir)
(define-key vertico-map (kbd "C-x C-j") 'consult-dir-jump-file)
(setq consult-dir-project-list-function nil)

(require 'marginalia)
(setq marginalia-annotators '(marginalia-annotators-heavy
			      marginalia-annotators-light
			      nil))
(marginalia-mode)

(require 'embark)
(global-set-key (kbd "C-M-.") 'embark-act)
(define-key minibuffer-local-map "C-d" 'embark-act)
(setq prefix-help-command #'embark-prefix-help-command)

(setq savehist-file (concat (getenv "XDG_CACHE_HOME") "/emacs/savehist"))
(setq history-delete-duplicates t)
(setq history-length t)
(setq savehist-additional-variables '(kill-ring))
(recentf-mode)
(save-place-mode)
(savehist-mode)

(setq backup-by-copying t)
(setq version-control t)
(setq vc-make-backup-files t)
(setq delete-old-versions 0)
(setq auto-save-include-big-deletions t)
(setq backup-directory-alist `((".*" . ,(concat (getenv "XDG_CACHE_HOME") "/emacs/backups"))))
(setq auto-save-file-name-transforms `((".*" ,(concat (getenv "XDG_CACHE_HOME") "/emacs/autosaves") t)))

(setq scroll-step 1)
(setq scroll-conservatively 10000)
(setq scroll-perserve-screen-position t)
(setq auto-window-vscroll t)

(setq use-short-answers t)
(setq confirm-nonexistent-file-or-buffer nil)
(setq-default use-dialog-box nil)
(setq-default use-file-dialog nil)

(setq kill-whole-line t)
(setq indent-tabs-mode nil)
(setq require-final-newline nil)
(setq tab-always-indent 'complete)
(delete-selection-mode)

(define-key ctl-x-map "h" 'help-command)
(global-set-key [remap upcase-word] 'upcase-dwim)
(global-set-key [remap downcase-word] 'downcase-dwim)
(global-set-key [remap capitalize-word] 'capitalize-dwim)

(setq imenu-auto-rescan t)
(setq imenu-auto-rescan-maxout 60000)
(setq imenu-use-popup-menu nil)

(setq max-mini-window-height 1)
(setq eldoc-echo-area-use-multiline-p nil)
(setq eldoc-idle-delay 0)

(setq magit-save-repository-buffers nil)
(setq magit-diff-refile-hunk 'all)
(with-eval-after-load 'magit-mode
  (setq magit-display-buffer-function 'magit-display-buffer-fullframe-status-v1))

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
  (add-hook 'dired-mode-hook 'dired-async-mode)
  (add-hook 'dired-mode-hook 'hl-line-mode))

(setq-default python-indent-guess-offset-verbose nil)

(setq geiser-active-implementations '(guile))
(add-hook 'geiser-mode-hook #'macrostep-geiser-setup)
(add-hook 'geiser-repl-mode-hook #'macrostep-geiser-setup)

(setq eval-expression-print-level nil)
(setq eval-expression-print-length nil)

(setq org-directory "~/org")

(global-set-key (kbd "C-c c") 'org-capture)
(global-set-key (kbd "C-c a") 'org-agenda)

(setq org-agenda-files '("~/org"))

(setq org-startup-folded t)

(require 'org-tempo)

(setq org-todo-keywords
      '((sequence "TODO(t)" "WAIT(w)" "|" "DONE(d)" "CANCELED(c)")))

(setq org-capture-templates
      '(("i" "Inbox" entry (file "inbox.org")
	 "* %?\n/Entered on/ %U")
	("l" "学习" entry (file "learning.org")
	 "* TODO %?\n/Entered on/ %U")
	("w" "工作" entry (file "work.org")
	 "* TODO %?\n/Entered on/ %U")
	("p" "工程" entry (file "projects.org")
	 "* TODO %?\n/Entered on/ %U")
	("s" "私人" entry (file "private.org")
	 "* %?\n/Entered on/ %U")))

(setq org-refile-use-outline-path 'file)
(setq org-refile-allow-creating-parent-nodes 'confirm)
(setq org-outline-path-complete-in-steps nil)
(setq org-refile-targets
      '((org-agenda-files :maxlevel . 3)))

(org-babel-do-load-languages
 'org-babel-load-languages
 '((emacs-lisp . t)
   (scheme . t)))

(setq epa-pinentry-mode 'loopback)

(setq send-mail-function 'smtpmail-send-it)
(setq message-send-mail-function 'smtpmail-send-it)
(setq smtpmail-default-smtp-server "smtp.qq.com")
(setq smtpmail-stream-type 'ssl)
(setq smtpmail-smtp-service 587)

(setq gnus-select-method '(nnimap "foxmail"
				  (nnimap-address "imap.qq.com")
				  (nnimap-server-port 993)
				  (nnimap-stream ssl)
				  (nnir-search-engine imap)))
(setq gnus-use-cache t)
(setq gnus-thread-sort-functions '(gnus-thread-sort-by-most-recent-date
				   (not gnus-thread-sort-by-number)))
(setq gnus-summary-thread-gathering-function 'gnus-gather-threads-by-subject)
