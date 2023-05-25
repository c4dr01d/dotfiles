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
(provide 'init-org)
