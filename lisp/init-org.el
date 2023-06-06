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
        `(("i" "Inbox" entry
           (file+headline "personal/inbox.org" "Inbox")
           ,(concat "* %^{标题}\n"
                    ":PROPERTIES:\n"
                    ":CAPTURED: %U\n"
                    ":END:\n\n"
                    "%i%l"))
          ("w" "工作" entry
           (file+headline "personal/todo.org" "工作")
           ,(concat "* TODO %^{标题} :@work:\n"
                    "SCHEDULED: %^t\n"
                    ":PROPERTIES:\n"
                    ":CAPTURED: %U\n"
                    ":END:\n\n"
                    "%i%?"))
          ("l" "学习" entry
           (file+headline "personal/todo.org" "学习")
           ,(concat "* TODO %^{标题} :@learn:\n"
                    "SCHEDULED: %^t\n"
                    ":PROPERTIES:\n"
                    ":CAPTURED: %U\n"
                    ":END:\n\n"
                    "%i%?"))))
  (setq org-refile-use-outline-path 'file)
  (setq org-refile-allow-creating-parent-nodes 'confirm)
  (setq org-outline-path-complete-in-steps nil)
  (setq org-refile-targets
        '((org-agenda-files :maxlevel . 3))))

(use-package org-tempo :ensure nil :after org)

(use-package org-agenda
  :ensure nil
  :custom (org-agenda-files '("~/org/personal"))
  :config
  (setq org-todo-keywords
        '((sequence "TODO(t)" "WAIT(w)" "|" "DONE(d)" "CANCELED(c)"))))

(use-package org-babel
  :ensure nil
  :custom (org-confirm-babel-evaluate nil))

(use-package org-roam
  :after org
  :bind (("C-c r b" . org-roam-buffer-toggle)
         ("C-c r f" . org-roam-node-find)
         ("C-c r g" . org-roam-graph)
         ("C-c r i" . org-roam-node-insert)
         ("C-c r c" . org-roam-capture)
         ("C-c r t" . org-roam-tag-add)
         ("C-c r r" . org-roam-ref-add)
         ("C-c r a" . org-roam-alias-add))
  :init
  (setq org-roam-directory (file-truename "~/note"))
  (setq org-roam-v2-ack t)
  (setq org-roam-capture-templates
        '(("d" "default" plain "%?"
           :target (file+head "personal/%<%Y%m%d-%H%M%S>-${slug}.org"
                              "#+TITLE: ${title}\n")
           :unnarrowed t)
          ("w" "work" plain "%?"
           :target (file+head "work/%<%Y%m%d-%H%M%S>-${slug}.org"
                              "#+TITLE: ${title}\n")
           :unnarrowed t)
          ("l" "learn" plain "%?"
           :target (file+head "learn/%<%Y%m%d-%H%M%S>-${slug}.org"
                              "#+TITLE: ${title}\n")
           :unnarrowed t)))
  :config (org-roam-setup))
(provide 'init-org)
