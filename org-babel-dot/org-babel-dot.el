(require 'org-babel)

(org-babel-add-interpreter "dot")

(add-to-list 'org-babel-tangle-langs '("dot" "dot"))

(defvar org-babel-default-header-args:dot '((:results . "file") (:exports . "results"))
  "Default arguments to use when evaluating a dot source block.")

(defun org-babel-execute:dot (body params)
  "Execute a block of Dot code with org-babel.  This function is
called by `org-babel-execute-src-block'."
  (message "executing Dot source code block")
  (let ((result-params (split-string (or (cdr (assoc :results params)) "")))
        (out-file (cdr (assoc :file params)))
        (cmdline (cdr (assoc :cmdline params)))
        (cmd (or (cdr (assoc :cmd params)) "dot"))
        (in-file (make-temp-file "org-babel-dot")))
    (with-temp-file in-file (insert body))
    (message (concat cmd " " in-file " " cmdline " -o " out-file))
    (shell-command (concat cmd " " in-file " " cmdline " -o " out-file))
    out-file))

(defun org-babel-prep-session:dot (session params)
  (error "Dot does not support sessions"))

(provide 'org-babel-dot)
;;; org-babel-dot.el ends here
