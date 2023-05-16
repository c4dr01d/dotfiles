;; -*- lexical-binding: t -*-
(setq user-full-name "c4droid")
(setq user-mail-address "c4droid@foxmail.com")

(load-theme 'solarized-light t)

(setq inhibit-startup-screen t)
(setq inhibit-startup-echo-area-message t)
(setq inhibit-scratch-message nil)

(tooltip-mode 0)
(menu-bar-mode 0)
(tool-bar-mode 0)
(scroll-bar-mode 0)
(fringe-mode 0)
(blink-cursor-mode 0)
(setq-default cursor-type 'bar)

(setq mode-line-compact t)
(setq column-number-indicator-zero-based nil)
(column-number-mode)

(setq enable-recursive-minibuffers t)
(setq completion-ignore-case t)
(setq read-buffer-completion-ignore-case t)
(setq read-file-name-completion-ignore-case t)
(setq completion-auto-help nil)
(setq completion-cycle-threshold 2)
(setq completion-category-defaults nil)
(minibuffer-depth-indicate-mode)
(minibuffer-electric-default-mode)

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

(with-eval-after-load 'paredit
  (define-key paredit-mode-map "M-[" 'paredit-wrap-square)
  (define-key paredit-mode-map "M-]" 'paredit-wrap-curly))

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
(with-eval-after-load 'scheme
  (add-hook 'scheme-mode-hook 'paredit-mode))

(setq eval-expression-print-level nil)
(setq eval-expression-print-length nil)
(with-eval-after-load 'elisp-mode
  (add-hook 'emacs-lisp-mode-hook 'paredit-mode))

(setq org-startup-folded t)

(require 'org-tempo)

(require 'erc)
(defvar erc-sasl-use-sasl t
  "Set to nil to disable SASL auth")
(defvar erc-sasl-server-regexp-list '()
  "List of regexps matching server host names for which sasl
  should be used")
(defun erc-sasl-use-sasl-p ()
  "Used internally to decide whether SASL should be used in the
current session"
  (and erc-sasl-use-sasl
       (boundp 'erc-session-server)
       (cl-loop for re in erc-sasl-server-regexp-list
	     thereis (integerp (string-match re erc-session-server)))))
(define-erc-response-handler (CAP)
  "Client capability framework is used to request SASL auth, need
  to wait for ACK to begin" nil
  (let ((msg (erc-response.contents parsed)))
    (when (string-match " *sasl" msg)
      (erc-server-send "AUTHENTICATE PLAIN"))))
(define-erc-response-handler (AUTHENTICATE)
  "Handling empty server response indicating ready to receive
  authentication." nil
  (if erc-session-password
      (let ((msg (erc-response.contents parsed)))
	(when (string= "+" msg)
	  ;; plain auth
	  (erc-server-send
	   (format "AUTHENTICATE %s"
		   (base64-encode-string
		    (concat "\0" (erc-current-nick)
			    "\0" erc-session-password) t)))))
    (progn
      (erc-display-message
       parsed 'error
       (if erc-server-connected 'active proc)
       "You must set a password in order to use SASL authentication.")
      (erc-server-send (erc-server-send "AUTHENTICATE *")))))
(define-erc-response-handler (903)
  "Handling a successful SASL authentication." nil
  (erc-server-send "CAP END"))
(add-to-list 'erc-sasl-server-regexp-list "irc\\.libera\\.chat")
