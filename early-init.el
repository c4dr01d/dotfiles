;; -*- lexical-binding: t -*-
(let ((old-threshold gc-cons-threshold))
  (add-hook 'emacs-startup-hook
	    (lambda ()
	      (setq gc-cons-threshold old-threshold)))
  (setq gc-cons-threshold most-positive-fixnum))

(setq warning-minimum-level :emergency)
(setq warning-suppress-types '((comp)))

(setq native-comp-async-report-warnings-errors nil)
(setq native-comp-deferred-compilation nil)

(setq package-enable-at-startup nil)
