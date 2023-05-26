;; -*- lexical-binding: t -*-
(use-package exwm
  :guix (:using channel :name emacs-exwm)
  :hook (exwm-update-class . (lambda ()
			       (exwm-workspace-rename-buffer exwm-class-name)))
  :config
  (setq mouse-autoselect-window nil)
  (setq focus-follows-mouse t)
  (setq exwm-workspace-wrap-cursor t)

  (require 'exwm-randr)
  (exwm-randr-enable)

  (exwm-enable)

  (require 'exwm-systemtray)
  (exwm-systemtray-enable)

  (defun exwm/run-in-background (command)
    (let ((command-parts (split-string command "[ ]+")))
      (apply #'call-process `(,(car command-parts) nil 0 nil ,@(cdr command-parts)))))

  (defun exwm/bind-function (key invocation &rest bindings)
    (while key
      (exwm-input-set-key (kbd key)
			  `(lambda ()
			     (interactive)
			     (funcall ',invocation)))
      (setq key (pop bindings))
      (setq invocation (pop bindings))))

  (defun exwm/bind-command (key command &rest bindings)
    (while key
      (exwm-input-set-key (kbd key)
			  `(lambda ()
			     (interactive)
			     (exwm/run-in-background ,command)))
      (setq key (pop bindings))
      (setq command (pop bindings)))))

(setq ediff-diff-options "-w")
(setq ediff-split-window-function 'split-window-horizontally)
(setq ediff-window-setup-function 'ediff-setup-windows-plain)
(provide 'init-exwm)
