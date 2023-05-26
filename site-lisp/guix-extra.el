(require 'cl-lib)
(require 'use-package)
(defun guix-use-package-init ()
  (unless (member :guix use-package-keywords)
    (setq use-package-keywords
          (let* ((pos (cl-position :unless use-package-keywords))
                 (head (cl-subseq use-package-keywords 0 (+ 1 pos)))
                 (tail (nthcdr (+ 1 pos) use-package-keywords)))
            (append head (list :guix) tail)))))
;;;###autoload
(defun use-package-normalize/:guix (name:symbol keyword args)
  (use-package-only-one
    (symbol-name keyword)
    args
    `(lambda (_label arg)
       arg)))
;;;###autoload
(defun use-package-handler/:guix (name:symbol keyword spec rest state)
  (use-package-process-keywords name:symbol rest state))
(guix-use-package-init)
(provide 'guix-extra)
