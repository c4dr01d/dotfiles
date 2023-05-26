;; -*- lexical-binding: t -*-
(use-package org
  :ensure nil
  :custom (org-directory "~/org")
  :init (setq org-startup-folded t)
  :bind (("C-c o c" . org-capture)
         ("C-c o a" . org-agenda)
         ("C-c o x" . org-export-dispatch))
  :config
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
        '((org-agenda-files :maxlevel . 3))))

(use-package org-tempo :ensure nil :after org)

(use-package org-agenda
  :ensure nil
  :custom (org-agenda-files '("~/org"))
  :config
  (setq org-todo-keywords
        '((sequence "TODO(t)" "WAIT(w)" "|" "DONE(d)" "CANCELED(c)"))))
(provide 'init-org)
