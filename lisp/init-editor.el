;; -*- lexical-binding: t -*-
(use-package startup
  :ensure nil
  :custom
  (inhibit-startup-message t)
  (inhibit-startup-echo-area-message t)
  (initial-scratch-message nil))

(use-package server
  :ensure nil
  :init (unless (and (fboundp 'server-running-p) (server-running-p))
          (server-start)))

(use-package mule
  :ensure nil
  :config
  (set-language-environment 'utf-8)
  (set-keyboard-coding-system 'utf-8)
  (set-clipboard-coding-system 'utf-8)
  (set-terminal-coding-system 'utf-8)
  (set-buffer-file-coding-system 'utf-8)
  (set-selection-coding-system 'utf-8)
  (modify-coding-system-alist 'process "*" 'utf-8)
  (setq default-process-coding-system '(utf-8 . utf-8))
  (setq-default pathname-coding-system 'utf-8))

(setq scroll-step 1)
(setq scroll-conservatively 10000)
(setq scroll-perserve-screen-position t)
(setq auto-window-vscroll t)

(advice-add 'risky-local-variable-p :override #'ignore)

(use-package restart-emacs
  :bind ("C-c x r" . restart-emacs))

(use-package no-littering
  :demand
  :config (with-eval-after-load 'recentf
            (add-to-list 'recentf-exclude no-littering-var-directory)
            (add-to-list 'recentf-exclude no-littering-etc-directory)))

(use-package dracula-theme
  :if (or is-windows is-linux exwm-enabled)
  :init (load-theme 'dracula t))

(use-package simple
  :ensure nil
  :init
  (setq-default make-backup-files nil)
  (setq-default auto-save-default nil)
  (setq mode-line-compact t)
  (setq column-number-indicator-zero-based nil)
  (column-number-mode)
  :config
  (tooltip-mode 0)
  (menu-bar-mode 0)
  (tool-bar-mode 0)
  (scroll-bar-mode 0)
  (fringe-mode 0)
  (blink-cursor-mode 0))

(if (boundp 'use-short-answers)
    (setq use-short-answers t)
  (fset 'yes-or-no-p 'y-or-n-p))
(setq-default use-dialog-box nil)
(setq-default use-file-dialog nil)

(setq kill-whole-line t)
(setq-default indent-tabs-mode nil)
(setq-default require-final-newline nil)
(setq tab-always-indent 'complete)

(use-package display-line-numbers
  :ensure nil
  :hook (prog-mode . display-line-numbers-mode))

(use-package elec-pair
  :ensure nil
  :hook (after-init . electric-pair-mode)
  :init (setq electric-pair-inhibit-predicate 'electric-pair-conservative-inhibit))

(use-package wgrep
  :hook (grep-mode . wgrep-setup)
  :custom
  (wgrep-auto-save-buffer t)
  (wgrep-change-readonly-file t))

(use-package savehist
  :ensure nil
  :hook (after-init . savehist-mode)
  :init
  (setq enable-recursive-minibuffers t)
  (setq history-delete-duplicates t)
  (setq history-length 100)
  (setq savehist-additional-variables '(mark-ring
					global-mark-ring
					search-ring
					regexp-search-ring
					extended-command-history
					kill-ring)))

(use-package saveplace
  :ensure nil
  :hook (after-init . save-place-mode))

(use-package recentf
  :ensure nil
  :hook (after-init . recentf-mode))

(use-package delsel
  :ensure nil
  :hook (after-init . delete-selection-mode))

(define-key ctl-x-map "h" 'help-command)

(use-package imenu
  :ensure nil
  :custom
  (imenu-auto-rescan t)
  (imenu-auto-rescan-maxout 60000)
  (imenu-use-popup-menu nil))

(use-package eldoc
  :ensure nil
  :hook (after-init . global-eldoc-mode)
  :custom
  (max-mini-window-height 1)
  (eldoc-idle-delay 0)
  (eldoc-echo-area-use-multiline-p nil))
(provide 'init-editor)
