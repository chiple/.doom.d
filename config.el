(map! :leader
      (:prefix ("b". "buffer")
       :desc "List bookmarks" "L" #'list-bookmarks
       :desc "Save current bookmarks to bookmark file" "w" #'bookmark-save))

;switch statement like in the javascript.
;or this name can be match using the name of the python.
(cl-defmacro switch (piv (test &body expr) &rest rest)
  (when (equal (length rest) 0)
    'nil)
  `(if (equal ,piv ,test)
       ,@expr
     (switch ,piv
             ,@rest)))

(defmacro with-splited-window (body)
  `(progn
     (+evil-window-vsplit-a)
     (+evil/window-move-right)
     ,body))

;;not classified
(map! (:leader
  (:desc "org-table" "s h" (lambda () (interactive) (with-splited-window (eshell)))
   :desc "zoom" "z z" #'+hydra/text-zoom/body
   :desc "org-table" "t o" #'org-table-create
   :desc "elgantt ""g n" #'elgantt-open
   :desc "find-file" "f f" #'find-file)))

;;org slide
(map! (:leader
      (:desc "tangle" "o t" #'org-babel-tangle
       :desc "org-slide-start" "o s s" #'org-tree-slide-mode
       :desc "org-slide-right" "o s l" #'org-tree-slide-move-next-tree)))

;;layout
(map! (:leader
       (:desc "右下がアジェンダ、左下がシェルです。" "l 1" #'split-screen-1
        :desc "clisp用のです" "l c l" #'split-screen-3
        :desc "contest用（ABCの）" "l c o" #'split-screen-4)))

;;ace-window
(setq aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l))
(map! :leader
      :desc "ace-window" "a c" #'ace-window)
;;smart toggle
(map! :leader
      :desc "imenu-list"
      "l e" #'imenu-list-smart-toggle)
;;visual line of numbers ではない

(map! (:leader
      (:desc "snippets-find" "s n o" #'+snippets/find
      :desc "snippets-insert" "s n i" #'+snippets/new
      :desc "snippets-edit" "s n e" #'+snippets/edit)))

(map! :leader
      :desc "heml kill ring"
      "k r" #'helm-show-kill-ring)

(defun move-line-up ()
  "Move up the current line."
  (interactive)
  (transpose-lines 1)
  (forward-line -2)
  (indent-according-to-mode))

(defun move-line-down ()
  "Move down the current line."
  (interactive)
  (forward-line 1)
  (transpose-lines 1)
  (forward-line -1)
  (indent-according-to-mode))

(map! (:leader
      (:desc "line-swap-down" "l d"#'move-line-down
       :desc "line-swap-down" "l u"#'move-line-up)))

(map! :leader
      :desc "man page"
      "d c"#'man)

(map! :leader :desc "run sly" "a a" #'sly)

(map! (:leader
       (:desc "sexp-forward" "s x f" #'sp-forward-sexp
        :desc "sexp-backward" "s x b" #'sp-backward-sexp
        :desc "sexp-kill" "s x d" #'sp-kill-sexp
        :desc "sexp-kill" "s x s" #'+default/search-other-project)))

(map! :leader
      :desc  "hydra gd"
      "g d"#'gdscript-hydra-show)

(map! :leader
      :desc "latex-preview"
      "l p"#'org-latex-preview)

(map! (:leader
       (:desc "down on google"
        "o g" #'(lambda ()
                  (interactive)
                  (let ((search-word (read-string "google:: ")))
                    (with-splited-window
                     (w3m-search "google" search-word)))))
       (:desc "open the link in the org file
but I don't really wanna do this cause this just prove that I can't over write the <return> key."
        "o o" #'(lambda ()
                  (interactive)
                  (let ((link (thing-at-point 'line t)))
                    (if (null (string-match "\\[\\[\\(.*\\)\\]\\[" link))
                        nil
                      (with-splited-window (w3m-goto-url (match-string 1 link))))
                    ))
        "o G" #'(lambda ()
                  (interactive)
                  (w3m-search-new-session "google" (read-string "google:: ")))
        "3 l" #'w3m-tab-next-buffer
        "3 h" #'w3m-tab-previous-buffer
        "3 d" #'w3m-delete-buffer)))

(map! (:leader
       (:desc "sexp-forward" "s x f" #'sp-forward-sexp
        :desc "sexp-backward" "s x b" #'sp-backward-sexp
        :desc "sexp-kill" "s x d" #'sp-kill-sexp
        :desc "sexp-kill" "s x s" #'+default/search-other-project)))

(use-package dashboard
  :config
  (dashboard-setup-startup-hook))
(setq dashboard-theme-directory (assoc-delete-all 'recents dashboard-item-generators))

(custom-set-faces!
  '(doom-dashboard-banner :foreground "red"  :weight bold)
  '(doom-dashboard-footer :inherit font-lock-constant-face)
  '(doom-dashboard-footer-icon :inherit all-the-icons-red)
  '(doom-dashboard-menu-desc :inherit font-lock-string-face)
  '(doom-dashboard-menu-title :inherit font-lock-function-name-face))
(set-face-attribute 'default nil :height 200)

(use-package! glsl-mode)
(add-to-list 'auto-mode-alist '("\\.gdshader\\'" . glsl-mode))

(setq org-plantuml-jar-path "~/.emacs.d/lib/plantuml.jar")

(setq lsp-auto-guess-root t)

(when (string-equal system-type "darwin")
(setq gdscript-godot-executable "~/Desktop/Godot.app/Contents/MacOS/Godot"))

(setq gdscript-godot-executable "~/Downloads/Godot_v3.5-stable_x11.64")

 (defun lsp--gdscript-ignore-errors (original-function &rest args)
  "Ignore the error message resulting from Godot not replying to the `JSONRPC' request."
  (if (string-equal major-mode "gdscript-mode")
      (let ((json-data (nth 0 args)))
        (if (and (string= (gethash "jsonrpc" json-data "") "2.0")
                 (not (gethash "id" json-data nil))
                 (not (gethash "method" json-data nil)))
            nil ; (message "Method not found")
          (apply original-function args)))
    (apply original-function args)))
;; Runs the function `lsp--gdscript-ignore-errors` around `lsp--get-message-type` to suppress unknown notification errors.
(advice-add #'lsp--get-message-type :around #'lsp--gdscript-ignore-errors)

(when (memq window-system '(mac ns x))
  (exec-path-from-shell-initialize))

(defun mark-and-find-definition ()
  (interactive)
  (evil-set-marker ?c)
  (lsp-find-definition))

(map! (:leader
      (:desc "lsp search difinition" "l s d" #'mark-and-find-definition)))

(add-hook 'racket-mode-hook
          (lambda ()
            (define-key racket-mode-map (kbd "<f5>") 'racket-run)))
(setq racket-program "/Applications/Racket\sv8.5/bin/racket")

(use-package sly)

(use-package! coconut-mode)
(add-to-list 'auto-mode-alist '("\\.coco\\'" . coconut-mode))

(use-package! request)

(defun head-add ()
  (interactive)
  (with-current-buffer
      (let ((content (read-string "* ")))
        (insert (concat "* " content "\n")))))

(map! :leader
      :desc "don't wanna write * again and again" "h h" #'head-add)

(require 'org-habit)

(when (string-equal system-type "darwin")
(setq org-directory "~/org"))
(when (string-equal system-type "gnu/linux")
(setq org-directory "~/org")
)

(when (string-equal system-type "gnu/linux")
  (setq org-journal-dir "~/Dropbox/roam/journal" )
  )


(setq org-journal-date-format "%A, %d %B %Y")
(require 'org-journal)

(setq org-agenda-skip-scheduled-if-done t
      org-agenda-skip-deadline-if-done t
      org-agenda-include-deadlines t
      org-agenda-block-separator #x2501
      org-agenda-compact-blocks t
      org-agenda-start-with-log-mode t)
(with-eval-after-load 'org-journal
(when (string-equal system-type "darwin")

  (setq org-agenda-files '("~/org/todo.org"
                           "~/org/elisptodo.org"
                           )))

)
(when (string-equal system-type "gnu/linux")

  (setq org-agenda-files '("~/org")))

(setq org-agenda-clockreport-parameter-plist
      (quote (:link t :maxlevel 5 :fileskip0 t :compact t :narrow 80)))
(setq org-agenda-deadline-faces
      '((1.0001 . org-warning)              ; due yesterday or before
        (0.0    . org-upcoming-deadline)))  ; due today or later

(defun air-org-skip-subtree-if-habit ()
  "Skip an agenda entry if it has a STYLE property equal to \"habit\"."
  (let ((subtree-end (save-excursion (org-end-of-subtree t))))
    (if (string= (org-entry-get nil "STYLE") "habit")
        subtree-end
      nil)))

(defun air-org-skip-subtree-if-priority (priority)
  "Skip an agenda subtree if it has a priority of PRIORITY.

PRIORITY may be one of the characters ?A, ?B, or ?C."
  (let ((subtree-end (save-excursion (org-end-of-subtree t)))
        (pri-value (* 1000 (- org-lowest-priority priority)))
        (pri-current (org-get-priority (thing-at-point 'line t))))
    (if (= pri-value pri-current)
        subtree-end
      nil)))

(setq org-agenda-custom-commands
      '(("n" "basic"
         ((tags "PRIORITY=\"A\""
                ((org-agenda-skip-function '(org-agenda-skip-entry-if 'todo 'done))
                 (org-agenda-overriding-header "High-priority unfinished tasks:")))
          (agenda "" ((org-agenda-span 4)))
          (alltodo ""
                   ((org-agenda-skip-function
                     '(or (air-org-skip-subtree-if-priority ?A)
                          (org-agenda-skip-if nil '(scheduled deadline))))))))
        ("w" "habits"
         ((alltodo ""
                   (org-habit-show-habits t))))))

(use-package org-pomodoro
    :after org-agenda
    :custom
    (org-pomodoro-ask-upon-killing t)
    (org-pomodoro-format "%s")
    (org-pomodoro-short-break-format "%s")
    (org-pomodoro-long-break-format  "%s")
    :custom-face
    (org-pomodoro-mode-line ((t (:foreground "#ff5555"))))
    (org-pomodoro-mode-line-break   ((t (:foreground "#50fa7b"))))
    :hook
    (org-pomodoro-started . (lambda () (notifications-notify
                                               :title "org-pomodoro"
                           :body "Let's focus for 25 minutes!"
                           :app-icon "~/.emacs.d/img/001-food-and-restaurant.png")))
    (org-pomodoro-finished . (lambda () (notifications-notify
                                               :title "org-pomodoro"
                           :body "Well done! Take a break."
                           :app-icon "~/.emacs.d/img/004-beer.png")))
    :config
    :bind (:map org-agenda-mode-map
                ("p" . org-pomodoro)))

;;(setq org-startup-folded t)

(defun efs/org-babel-tangle-config ()
  (when (string-equal (file-name-directory (buffer-file-name))
                      (expand-file-name "home/ryu/.doom.d/config.org"))
    ;; Dynamic scoping to the rescue
    (let ((org-confirm-babel-evaluate nil))
      (org-babel-tangle))))

(add-hook 'org-mode-hook (lambda () (add-hook 'after-save-hook #'efs/org-babel-tangle-config)))

(org-babel-do-load-languages
 'org-babel-load-languages
 '(lisp . t)
 '(awk . t)
 '(bash . t)
 '(python . t)
 '(haskell. t)
 '(C++ . t)
 '(dot . t)
 '(js . t)
 '(ditaa . t)
 '(plantuml. t)
 '(lilypond. t)
 '(rust . t)
 '(gnuplot . t)
 )

(setq org-babel-circler-excutebale "~/edu/clang/painting/unko")

(defun org-babel-execute:circler (body _)
  (interactive)
  "Org mode circler evaluate function"
  (let* ((filename "teston.txt")
         (cmd (concat org-babel-circler-excutebale " ./" filename)))
    (unless (shell-command-to-string (concat "cat" filename))
      (make-empty-file filename))
    (with-temp-file filename
      (insert body))
      (org-babel-eval cmd body)))

(after! org-roam
  (setq org-roam-capture-templates
        '(("d" "default" plain
           "%?"
           :if-new (file+head "%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}\n")
           :unnarrowed t)

          ("l" "programming language" plain
           "* Characteristics\n\n- Family: %?\n- Inspired by: \n\n* Reference:\n\n"
           :if-new (file+head "%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}\n")
           :unnarrowed t)

          ("b" "book notes" plain
           "\n* Source\n\nAuthor: %^{Author}\nTitle: ${title}\nYear: %^{Year}\n\n* Summary\n\n%?"
           :if-new (file+head "%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}\n")
           :unnarrowed t)
          ("p" "project" plain "* Goals\n\n%?\n\n* Tasks\n\n** TODO Add initial tasks\n\n* Dates\n\n"
           :if-new (file+head "%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}\n#+filetags: Project")
           :unnarrowed t)
          ("s" "ordinary stuff" "* aha"
           :fi-new (file+haed "%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}\n#+filetags: Project")
           :unnarrowed t)
          )))

(defun get-roam-links-json ()
  (json-encode-alist
   (org-uniquify-alist
    (org-roam-db-query
     `[:select  [links:source
                 links:dest]
       :from links
       :where (= links:type "id")]))))

(defun get-roam-nodes-json ()
  (json-encode-alist (org-roam-db-query [:select [id
                                                  file
                                                  title
                                                  level
                                                  pos
                                                  olp
                                                  properties
                                                  (funcall group-concat tag
                                                           (emacsql-escape-raw \, ))]
                                         :as tags
                                         :from nodes
                                         :left-join tags
                                         :on (= id node_id)
                                         :group :by id])))


;; for the homepage, I have to prepare the id and link information as json.
(defun create-node-and-link-json ()
  (interactive)
  (let ((output-dir "~/Dropbox/POKE/Web/raedme/public/texts"))
    (when (equal org-roam-directory output-dir)
      (with-temp-file  (concat output-dir "/links.json")
        (insert (get-roam-links-json)))
      (with-temp-file (concat output-dir "/nodes.json")
        (insert (get-roam-nodes-json)))
      )
    (message "node.json and links.json was written")
    ))

(add-to-list 'org-roam-capture-new-node-hook #'create-node-and-link-json)

(defun inuru ()
  (interactive)
  (let ((select '((me . roam)
                  (share . loggg)
                  (homepage . POKE/Web/raedme/public/texts))))
    (ivy-read "🐕🐕どのwikiにするか🐕🐕" select
    :require-match t
    :action (lambda (choice)
              (setq org-roam-directory (concat "~/Dropbox/"
                                               (symbol-name (cdr choice)))))))
  (org-roam-db-sync))

(setq org-roam-dailies-directory "~/Dropbox/roam/journal")
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (setq org-roam-dialies-capture-template                                    ;;
;;       '(("d" "default" entry "* %<%I:%H%p>: %?"                            ;;
;;         :if-new (file+head "%S<%Y-%m-%d>.org" "#+title: %<%Y-%m%d>\n?")))) ;;
;;;;;;;;;;;f;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package! elgantt)

(setq elgantt-user-set-color-priority-counter 0)
(elgantt-create-display-rule draw-scheduled-to-deadline
  :parser ((elgantt-color . ((when-let ((colors (org-entry-get (point) "ELGANTT-COLOR")))
                               (s-split " " colors)))))
  :args (elgantt-scheduled elgantt-color elgantt-org-id)
  :body ((when elgantt-scheduled
           (let ((point1 (point))
                 (point2 (save-excursion
                           (elgantt--goto-date elgantt-scheduled)
                           (point)))
                 (color1 (or (car elgantt-color)
                             "black"))
                 (color2 (or (cadr elgantt-color)
                             "red")))
             (when (/= point1 point2)
               (elgantt--draw-gradient
                color1
                color2
                (if (< point1 point2) point1 point2) ;; Since cells are not necessarily linked in
                (if (< point1 point2) point2 point1) ;; chronological order, make sure they are sorted
                nil
                `(priority ,(setq elgantt-user-set-color-priority-counter
                                  (1- elgantt-user-set-color-priority-counter))
                           ;; Decrease the priority so that earlier entries take
                           ;; precedence over later ones (note: it doesn’t matter if the number is negative)
                           :elgantt-user-overlay ,elgantt-org-id)))))))

(setq elgantt-header-type 'outline
      elgantt-insert-blank-line-between-top-level-header t
      elgantt-startup-folded nil
      elgantt-show-header-depth t
      elgantt-draw-overarching-headers t)

(defconst ladicle/org-journal-dir "~/roam/journal/")
(defconst ladicle/org-journal-file-format (concat ladicle/org-journal-dir "%Y%m%d.org"))

(defvar org-code-capture--store-file "")
(defvar org-code-capture--store-header "")

;; This function is used in combination with a coding template of org-capture.
(defun org-code-capture--store-here ()
  "Register current subtree as a capture point."
  (interactive)
  (message "the header is stored")
  (setq org-code-capture--store-file (buffer-file-name))
  (setq org-code-capture--store-header (nth 4 (org-heading-components))))

;; This function is used with a capture-template for (function) type.
;; Look for headline that registered at `org-code-capture--store-header`.
;; If the matching subtree is not found, create a new Capture tree.
(defun org-code-capture--find-store-point ()
  "Find registered capture point and move the cursor to it."
  (let ((filename (if (string= "" org-code-capture--store-file)
                      (format-time-string ladicle/org-journal-file-format)
                    org-code-capture--store-file)))
    (set-buffer (org-capture-target-buffer filename)))
  (goto-char (point-min))
  (unless (derived-mode-p 'org-mode)
    (error
     "Target buffer \"%s\" for org-code-capture--find-store-file should be in Org mode"
     (current-buffer))
    (current-buffer))
  (if (re-search-forward org-code-capture--store-header nil t)
      (goto-char (point-at-bol))
    (goto-char (point-max))
    (or (bolp) (insert "\n"))
    (insert "* Capture\n")
    (beginning-of-line 0))
  (org-end-of-subtree))

;; Capture templates for code-reading
(add-to-list 'org-capture-templates
      '("u" "code-link"
         plain
         (function org-code-capture--find-store-point)
         "% {Summary}\n%(with-current-buffer (org-capture-get :original-buffer) (browse-at-remote--get-remote-url))\n# %a"
         :immediate-finish t))

(add-to-list 'org-capture-templates
        '("p" "just-code-link"
         plain
         (function org-code-capture--find-store-point)
         "%A"
         :immediate-finish t))

;;keybinding
(map! (:leader
      (:desc "counsel capture" "c p" #'counsel-org-capture
       :desc "counsel capture"
      "y c" #'org-code-capture--store-here)))

(use-package org-modern-indent
  ;; :straight or :load-path here, to taste
  :hook
  (org-indent-mode . org-modern-indent-mode))
(add-hook 'org-mode-hook #'org-modern-mode)

(use-package org-auto-tangle
  :defer t
  :hook (org-mode . org-auto-tangle-mode))
(setq org-modern-table nil)
(progn
  (add-to-list 'load-path "~/.emacs.d/site-lisp")
  (require 'org-pretty-table)
  (add-hook 'org-mode-hook (lambda () (org-pretty-table-mode))))
(map! :leader
      :desc "execute under the subtree"
      "d o" #'org-babel-execute-subtree)

(setq easy-hugo-basedir "~/chiple.github.io/")
(doom! :lang
       (org +hugo))
(use-package ox-hugo
  :after ox)
(setq easy-hugo-url "https://chiple.github.io")
(setq easy-hugo-sshdomain "https://chiple.github.io")
(setq easy-hugo-root "/")
(setq easy-hugo-previewtime "300")
(setq easy-hugo-postdir "content/post")
(setq org-hugo-base-dir "~/chiple.github.io/")

(defun display-list-of (what-to-find)
  (interactive)
  (defun get-existing-heading-in-buffer ()
    (save-excursion
      (goto-char (point-min))
      (let ((head '()))
        (while (re-search-forward what-to-find (point-max) t)
          (add-to-list 'head (list (replace-regexp-in-string "\n" "" (thing-at-point 'line nil) )(point)))
          )
        head)))
  (ivy-read "headings> " (reverse (get-existing-heading-in-buffer))
            :action (lambda (x) (progn (goto-char (cadr x)) (evil-scroll-line-to-top (line-number-at-pos))))))
(map! :leader
      :desc "heading list of current buffer"
      "l h" (lambda () (interactive) (display-list-of "^*")))

(map! :leader
      :desc  "display TODO in the buffer and go there if you want"
      "l t" (lambda () (interactive) (display-list-of "TODO")))

(require 'org-tempo)
(add-to-list 'org-structure-template-alist '("el" . "src emacs-lisp"))
(add-to-list 'org-structure-template-alist '("ru" . "src rust"))
(add-to-list 'org-structure-template-alist '("cc" . "src C"))
(add-to-list 'org-structure-template-alist '("cl" . "src lisp"))
(add-to-list 'org-structure-template-alist '("aw" . "src awk"))
(add-to-list 'org-structure-template-alist '("ba" . "src bash"))
(add-to-list 'org-structure-template-alist '("py" . "src python"))
(add-to-list 'org-structure-template-alist '("hs" . "src haskell"))
(add-to-list 'org-structure-template-alist '("pl" . "src plantuml"))
(add-to-list 'org-structure-template-alist '("js" . "src js"))
(add-to-list 'org-structure-template-alist '("circler" . "src circler"))
(add-to-list 'org-structure-template-alist '("lil" . "src lilypond"))

(add-to-list 'org-capture-templates
        '("s" "ordinary stuff"
         plain
         #'(lambda () (print "para ppa"))
         "%a"
         :immediate-finish t))

(defun my-pretty-lambda ()
  (setq prettify-symbols-alist '(("lambda" . 955))))
(add-hook 'python-mode-hook 'my-pretty-lambda)
(add-hook 'python-mode-hook 'prettify-symbols-mode)
(add-hook 'org-mode-hook 'my-pretty-lambda)
(add-hook 'org-mode-hook 'prettify-symbols-mode)
(add-hook 'lisp-mode-hook 'my-pretty-lambda)
(add-hook 'lisp-mode-hook 'prettify-symbols-mode)
(add-hook 'emacs-lisp-mode-hook 'my-pretty-lambda)
(add-hook 'emacs-lisp-mode-hook 'prettify-symbols-mode)

(defun split-screen-1 ()
  (interactive)
  (progn
  (evil-window-split)
  (next-window-any-frame)
  (shrink-window 15)
  (evil-window-vsplit)
  (eshell)
  (next-window-any-frame)
  (org-agenda :key "n")
  (next-window-any-frame)
    ))

(defun split-screen-2 ()
  (interactive)
  (progn
  (evil-window-vsplit)
  (evil-window-split)
  (shrink-window 15)
  (evil-window-vsplit)
  (eshell)
  (next-window-any-frame)
  (org-agenda :key "n")
  (next-window-any-frame)
    ))

(defun split-screen-3 ()
  (interactive)
  (progn
  (evil-window-vsplit)
  (find-file "~/edu/clisp")
  (next-window-any-frame)
  (sly)
  (evil-window-vsplit)
  (org-roam-ref-find "clisp")
  ))

(defun split-screen-4 ()
  (interactive)
  (progn
    (let ((contest-num (read-string "What is the number of contest? :"))
          (dir-name nil))
  (evil-window-vsplit)
  (setq dir-name (concat "~/edu/python/abc" contest-num))
  (mkdir dir-name)
  (find-file (concat dir-name "/a.py"))
  (next-window-any-frame)
  (eshell)
  (next-window-any-frame)


    )))

  (use-package ace-window
   :custom-face
    (aw-leading-char-face ((t (:height 4.0 :foreground "#f1fa8c")))))

(defun append-string-to-file (s filename)
  (with-temp-buffer
    (insert s)
    (insert "\n")
    (write-region (point-min) (point-max) filename t)))

(defun ankki ()
  (interactive)
  (progn
    (let ((word (read-string "🐕Type in the word you don't know🐕: ")))
      (append-string-to-file word "~/Documents/words.txt")
      )
    (async-shell-command "python3 ~/.doom.d/asdf.py")
    )
  )

(defun yajirushi-add ()
  (interactive)
  (let ((length (cl-parse-integer(read-string "put the arrow length here: " "3") :radix 10))
        (result ""))
    (cl-do ((num 1 (1+ num)))
        ((> num length))
      (if (equal num length)
          (setq result (concat result "└─>"))
        (setq result (concat result "├─>\n"))))
    (with-current-buffer
        (insert result)
      (number-to-string (line-number-at-pos)))
    ))
;;横に伸びるやつ
(defun yajirushi-new-line ()
  (interactive)
  (cl-case (char-after)
    ((?│)
     (forward-line -1)
     (let ((line-content (thing-at-point 'line t)))
       (insert line-content)))
    ((?├)

     (forward-line 1)
     (let ((line-content (thing-at-point 'line t)))
       (insert "\n")
       (forward-line -1)
       (insert "│")
       ))

    ((?┬)
     (let ((line-content (thing-at-point 'line t))
           (end (point)))
       (beginning-of-line)
       (let* ((start (point))
              (offset (- end start)))
         (forward-line 1)
         (insert line-content)
         (forward-line -1)
         (cl-do ((num 0 (1+ num)))
             ((> num offset))
           (cl-case (char-after)
             ((?├)
              (delete-forward-char 1)
              (insert "│")
              (forward-char -1)
              )
             ((?┬)
              (delete-forward-char 1)
              (insert "└")
              (forward-char -1)
              )
             ((?─)
              (delete-forward-char 1)
              (insert " ")
              (forward-char -1)
              )
             ((?└)
              (delete-forward-char 1)
              (insert " ")
              (forward-char -1)
              )
             )

           (forward-char 1)
           )
         )))))
;;現在位置のXを保持したまま上へいく。
(defun yajirushi-go-upward ()
  (let ((end (point)))
    (beginning-of-line)
    (let* ((start (point))
           (offset (- end start))
           )
      (forward-line -1)
      (goto-char (+ offset (point)))
      )
    ))
;;もしかしたら、ぶつかるところがふえるかもしれない
(defun yajirushi-go-left ()
  (interactive)
  (while (not (equal (thing-at-point 'char t) "└"))
    (forward-char -1)))

(defun yajirushi-go-right ()
  (interactive)
  (while (not (equal (thing-at-point 'char t) "┘"))
    (forward-char 1)))
;;左までいって、上(yajirushi-go-upward)まで探索したら、そのポイントを保存する
;;右までいったら、そのポイントを保存する。
;;一つの辺に複数のHubがあったら、エラーを出す。
(defun detect-box ()
  (interactive)
  (let ((start) (top-left) (bottom-right))
    (setq start (point))
  (cl-case (char-after)
    ((?┯)
     (yajirushi-go-left)
     (while (not (equal (thing-at-point 'char t) "┌"))
       (yajirushi-go-upward))
     (setq top-left (point))
     (goto-char start)
     (yajirushi-go-right)
     (setq bottom-right (point))
     ))
  (print top-left)
  (print bottom-right)
  )
)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (defun adjust-box-shape () ;;
;;   (interactive))           ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;文字の長さを調べるー＞その分上のやつを作る。
;;入力した文字の両端に縦の罫線をつける
(defun moji-tree ()
  (interactive)
  (let ((word (cl-parse-integer(read-string "put string here: " ))
        (result ""))
        (with-current-buffer
        (insert result)
      (number-to-string (line-number-at-pos)))
    )
                        ))

(defun yajirushi-rotate ()
  (interactive)
  (cl-case (char-after)
    ;;
    ((?└)
     (delete-forward-char 1)
     (insert "├"))
    ((?├)
     (delete-forward-char 1)
     (insert "┌"))
    ((?┌)
     (delete-forward-char 1)
     (insert "└"))
    ;;横から
    ((?─)
     (delete-forward-char 1)
     (insert "┬")
     (forward-char -1)
     )
    ((?┬)
     (delete-forward-char 1)
     (insert "─"))
    ))

(defun yajirushi-expand ()
  (interactive)
  (cl-case (char-after)
    ((?─)
     (insert "─"))))

;;TODO;;;;;;;;;;;;;;;;;;;;;;;;;
;; (defun box-display ()     ;;
;;   (interactive)           ;;
;;)                          ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;key-bind
(map! (:leader
      (:desc "個数を指定して矢印をつくる" "a j l" #'yajirushi-add
      :desc "文字の種類に応じて回転" "a r" #'yajirushi-rotate
      :desc "文字の種類に応じてのばす" "a x" #'yajirushi-expand
      :desc "文字の種類に応じて改行" "a o" #'yajirushi-new-line)))

(use-package ivy-posframe
      :config
    (ivy-posframe-mode 1))
(setq ivy-posframe-parameters
      '((left-fringe . 10)
        (right-fringe . 10)))

(use-package beacon
  :custom
     (beacon-color "white")
    :config
    (beacon-mode 1)
    )

(with-eval-after-load 'org
  (require 'edraw-org)
  (edraw-org-setup-default))

(defun open-this-buffer-in-workspece ()
  (interactive)
  (let ((where-i-was (current-buffer)))
    (+workspace/new)
    (switch-to-buffer where-i-was)))

(map! (:leader
       (:desc "to-workspace" "w z"#'open-this-buffer-in-workspece
        :desc "to-workspace" "w d"#'+workspace/delete)))

(defun extract-link-name (link-content)
  (let ((brace link-content))
    (string-match "\\]\\[\\(.*\\)\\]\\]" brace)
    (match-string 1 brace)))

(defun get-exsting-link-name ()
  (save-excursion
    (goto-char (point-min))
    (let ((rect-bracketed '()))
      (while (re-search-forward "^\\[" (point-max) t)
        (add-to-list 'rect-bracketed
                     (extract-link-name (thing-at-point 'line t))))
      rect-bracketed)))

(defun linkp (name)
  (if (member name (get-exsting-link-name))
      t
    nil))

;I couldn't find the prepared thing for the org-dailies
(defun get-today-file ()
  ;;get the file name of current date
  (let ((file-name (org-journal--get-entry-path))
        year month date)
    (string-match "[0-9]+" file-name)
    (setq file-name (match-string 0 file-name))
    (cl-destructuring-bind (year month date)
        (mapcar #'(lambda (pos) (substring file-name (cl-first pos) (car (last pos))))
                (list '(0 4) '(4 6) '(6 8)))
    (format "%s-%s-%s.org" year month date))))

(unless (file-exists-p (format "%s/%s" org-roam-dailies-directory (get-today-file)))
  (org-roam-dailies-capture-today :KEYS "d") (save-buffer))

(defun get-node-name (str)
  (string-match "-.*" str)
  (print (substring (match-string 0 str) 1 (length (match-string 0 str)))))

;this name should be on create journal
;most fishy place
(defun write-to (buffer)
  (with-current-buffer
      (let ((new-node (buffer-name)))
        (set-buffer buffer)
        (goto-char (point-max))

        (unless (file-exists-p (format "%s/%s" org-roam-dailies-directory (get-today-file)))
          (print "no-today file"))
        ; if the link exist, skip, if no, create the link to it.
        (unless (linkp (get-node-name new-node))
          (save-excursion
            (look-for-header-insert
             (format "[[%s][%s]]\n" (concat org-roam-directory "/" new-node) (get-node-name new-node)) "visited")
            ))
        (insert-header-unless-exist "visited")
        (print (current-buffer)))))

(defun add-url-to-journal ()
  (interactive)
  (look-for-header-insert (format "[[%s][%s]]\n" w3m-current-url(read-string "What's our title of this page?> ")) "visited"))

(add-hook 'org-roam-capture-new-node-hook (lambda () (write-to (get-today-file))))
(add-hook 'org-roam-find-file-hook (lambda () (write-to (get-today-file))))

(defun today-buffer ()
  (let ((dirname (org-journal--get-entry-path))
        journal-entry (ymd '((0 4) (4 6) (6 8))))
    (string-match "journal/\\(.*\\)$" dirname)
    (apply #'(lambda (y m d) (format "%s-%s-%s.org" y m d))
           (cl-map 'list
                   #'(lambda (each) (substring (match-string 1 dirname) (car each) (cadr each)))
                   ymd))))

(setq +org-capture-journal-file (concat "~/Dropbox/roam/journal/" (today-buffer)))

;TODO really don't wanna make it today-buffer specific.
(defun look-for-header-insert (content header)
  (set-buffer (today-buffer))
  (save-excursion
    (goto-char (point-min))
    (while (re-search-forward (concat "^\\* " header) (point-max) t)
      (insert (concat "\n" content)))))

(defun insert-header-unless-exist (head)
  (let ((headline (concat "* " head)))
    (unless (headerp (today-buffer) headline)
      (goto-char (point-max)) (insert headline))))

(defun headerp (buffer heading)
  (set-buffer buffer)
  (save-excursion
    (let ((nodes '()))
      (goto-char (point-min))
      (while (re-search-forward "^*" (point-max) t)
        (add-to-list 'nodes (replace-regexp-in-string "\n" "" (thing-at-point 'line t))))
      (if (member heading nodes)
          t
        nil)
      )))

;;setup the key-binds
(map! (:leader
       (:desc "dict-lookup-with-journal"
        "s t" (lambda ()
                (interactive)

                (let ((thing (doom-thing-at-point-or-region 'word)))
                  (insert-header-unless-exist "vocab")
                  (+lookup/dictionary-definition thing)
                  (look-for-header-insert thing "vocab")))
        )
       (:desc "leave history with the w3m"
        "c u r i" #'add-url-to-journal)))

(add-to-list 'org-capture-templates
             '("j" "Journal" entry
               (file +org-capture-journal-file)
               "* %?\n" :prepend t))

(use-package ob)
(setq atco-dir "~/competi/")
(defun atco ()
  (interactive)
  (let ((contestname))
    (setq contestname(read-string "contest num>> "))
    (f-mkdir-full-path (concat atco-dir contestname))
    (shell-command (concat "cd " (concat atco-dir contestname) "&& acc new " contestname))))


(defun test-atco ()
  (interactive)
  (let ((exp (cadr (split-string (buffer-file-name (current-buffer)) "\\.")) ))
    (compile (cond
   ((equal exp "py") "oj t -c \"python3 ./main.py\" -d ./test/")
   ((equal exp "lisp") "oj t -c \"sbcl --script ./main.lisp\" -d ./test/")))))


(defun submit-atco()
  (interactive)
  (eshell "competi")
  (insert "acc s main.py")
  (execute-kbd-macro (kbd "<return>"))
  (execute-kbd-macro (kbd "<esc>")))

(general-simulate-key "SPC")
(map! (:leader
       (:desc "prepare tests and templates" "a t n" #'atco
        :desc "submit" "a t s" #'submit-atco
        :desc "test" "a t t" #'test-atco)))

(defun go-and-delete-in-double-quote ()
  (interactive)
  (re-search-forward "\"" (line-end-position) t)
  (kill-region (mark) (1- (point)))
  )
(map! :leader
      :desc "delete-content-of-double-quote"
      "d l w" #'go-and-delete-in-double-quote)

(defun goto-end-of-parenthesis ()
  (interactive)
  (set-mark (point))
  (re-search-forward ")" (line-end-position) t)
  (kill-region (mark) (1- (point))))
(map! :leader
      :desc "delete-content-of-double-quote"
      "d l )" #'goto-end-of-parenthesis)

(add-hook 'org-mode-hook #'org-inline-anim-mode)
(defun inline-img-wrap ()
  (interactive)
  (org-inline-anim-animate 4))

(map! :leader
      :desc "added the prefix"
      "a n" #'inline-img-wrap)

;; load environment value
(dolist (path (reverse (split-string (getenv "PATH") ":")))
  (add-to-list 'exec-path path))

(use-package! w3m
  :commands (w3m)
  :config
  (setq w3m-use-tab-line nil))

(map! (:leader
       (:desc "just goes to w3m "
        "w 3"
        (lambda () (interactive)
          (with-splited-window (w3m))))))

(setq gdscript-docs-local-path "~/sites/godot/")
(setq org-roam-directory "~/Dropbox/roam")
(defun read-book-with-chrome ()
  (interactive)
  (ivy-read "books to read> "
            (split-string (shell-command-to-string "cd ~/Dropbox/books && ls") "\n")
            :require-match t
            :action (lambda (choice) (shell-command (concat "google-chrome-stable ~/Dropbox/books/" choice)))))

(map! :leader
      :desc "using chrome, reading things, If the nyxt gets better I would use that."
      "b o" #'read-book-with-chrome)

;(use-package nyan-mode)
;(setq nyan-mode t)
;;(setq doom-modeline-mode 'nil)
;;(load-file "~/Dropbox/POKE/Elisp/pokel.el")
;;(setq pokel-mode t)

(map! (:leader
       :desc "git commit after stageing" "g c s"
       (lambda () (interactive) (magit-stage) (magit-commit))))

;;FIXME looks ugly. This just work. Can I use the _advice-add_ for this?
(defun find-file-other-window ()
  (interactive)
  (with-splited-window
   (find-file
    (car (find-file-read-args "Find file: "
                        (confirm-nonexistent-file-or-buffer)))
    )))

(map! (:leader
       :desc "split the window and search file" "f F" #'find-file-other-window))

(defun message-buffer-in-other-window()
  (interactive)
  (org-switch-to-buffer-other-window "*Messages*"))
(map! (:leader
       :desc "just jumping to the message buffer" "l o g" #'message-buffer-in-other-window))

(modus-themes-load-vivendi)
(defun get-max-linum (&optional file-or-buffer)
  (interactive)
  (cl-flet ((go-and-get-max-line ()(save-excursion
                                     (goto-char (point-max))
                                     (print (- (line-number-at-pos) 1))
                                     )))
    (cond
     ((null file-or-buffer)
      (go-and-get-max-line))
     ((eql (type-of file-or-buffer) 'buffer)
      (set-buffer file-or-buffer))
     ((eql (type-of file-or-buffer) 'file)
      (print "asdf"))
     ('t (message "%s is not either the type; file, buffer, nil"))
     )))

(set-language-environment "Japanese")
(map! :leader
      :desc "switch to japanese" "j a" #'(lambda () (interactive) (set-input-method "japanese"))
      :desc "switch to english" "e n" #'(lambda () (interactive) (set-input-method "ucs")))

(load "~/Projects/emacs/deepl.el")

(defun hira-kata (start end)
  (interactive "r")
  (let ((region (buffer-substring start end)))
    (delete-region start end)
    (insert (shell-command-to-string (concat "python ~/tools/hiragana_katakana.py " region)))))

(defun my-open-calendar ()
  (interactive)
  (cfw:open-calendar-buffer
   :contents-sources
   (list
    (cfw:org-create-source "Green")  ; org-agenda source
    (cfw:org-create-file-source "cal" "~/Dropbox/cal.org" "Cyan")  ; other org source
    )))

(map! :leader
      :desc "calender view" "s c h" #'my-open-calendar
      :desc "calender at point" "g c a l" #'org-gcal-post-at-point)

(let ((gcal-infos (json-read-file "~/Dropbox/au.json")))
  (setq
   org-gcal-client-id
   (cdr (assoc 'client_id (cdar gcal-infos)))
   org-gcal-client-secret (cdr (assoc 'client_secret (cdar gcal-infos)))
   ;; ID が sample@foo.google.com のカレンダーと ~/calendar.org を同期
   org-gcal-file-alist '(
                         ("the.brainga@gmail.com" . "~/calendar.org")
                         ("the.brainga@foo.google.com" .  "~/calendar2.org")
                         ))
  ;; token の保存場所を変更
  (setq org-gcal-dir "~/Dropbox/org-gcal")

  )

(map! :leader
      :desc "connect sly" "c n" (lambda () (interactive) (sly-connect "localhost" 4545)))

;;helper functions used by =emacsclient=.


;;;### (autoloads nil "tscn" "tscn.el" (25422 56915 349704 301000))
;;; Generated autoloads from tscn.el

(register-definition-prefixes "gdutil" '("format-prop" "group-by-prop" "prop-p" "tscn-lst"))

;kszxcvkj;;***

(register-definition-prefixes "test" '("testfile"))
