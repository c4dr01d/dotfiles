(when exwm-enabled
  (load-theme 'dracula t))

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
(provide 'init-editor)
