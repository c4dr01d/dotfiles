;; -*- lexical-binding: t -*-
(use-package epa
  :ensure nil
  :custom (epa-pinentry-mode 'loopback))

(use-package smtpmail
  :ensure nil
  :custom
  (send-mail-function 'smtpmail-send-it)
  :config
  (setq smtpmail-default-smtp-server "smtp.qq.com")
  (setq smtpmail-stream-type 'ssl)
  (setq smtpmail-smtp-service 587))

(use-package gnus
  :ensure nil
  :custom
  (message-send-mail-function 'smtpmail-send-it)
  :init (setq gnus-select-method '(nnimap "foxmail"
					  (nnimap-address "imap.qq.com")
					  (nnimap-server-port 993)
					  (nnimap-stream ssl)
					  (nnir-search-engine imap)))
  :config
  (setq gnus-use-cache t)
  (setq gnus-thread-sort-functions '(gnus-thread-sort-by-most-recent-date
				     (not gnus-thread-sort-by-number)))
  (setq gnus-summary-thread-gathering-function 'gnus-gather-threads-by-subject))

(provide 'init-mail)
