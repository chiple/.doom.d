(map! :leader
      (:prefix ("b". "buffer")
       :desc "List bookmarks" "L" #'list-bookmarks
       :desc "Save current bookmarks to bookmark file" "w" #'bookmark-save))

(map! :leader
      :desc "tangle"
      "o t" #'org-babel-tangle)

(map! :leader
      :desc "find-file"
      "f f" #'find-file)

(map! :leader
      :desc "org-table"
      "t o" #'org-table-create)

(map! :leader
      :desc "org-table"
      "s h" #'eshell)
(map! :leader
      :desc "zoom"
      "z z" #'+hydra/text-zoom/body)
(map! :leader
      :desc "org-slide-start"
      "o s s" #'org-tree-slide-mode)

(map! :leader
      :desc "org-slide-right"
      "o s l" #'org-tree-slide-move-next-tree)

(map! :leader
      :desc "org-quote"
      "o q" #'tempo-template-org-quote)

(map! :leader
      :desc "org-quote"
      "g n" #'elgantt-open)

(map! :leader
      :desc "counsel capture"
      "c p" #'counsel-org-capture)
(map! :leader
      :desc "counsel capture"
      "y c" #'org-code-capture--store-here)

(map! :leader
      :desc "右下がアジェンダ、左下がシェルです。"
      "l 1" #'split-screen-1)

(map! :leader
      :desc "clisp用のです"
      "l c l" #'split-screen-3)


(map! :leader
      :desc "contest用（ABCの）"
      "l c o" #'split-screen-4)

(map! :leader
      :desc "contest用（ABCの）"
      "l c o" #'split-screen-4)

(map! :leader
      :desc "ace-window"
      "a c" #'ace-window)
(setq aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l))

(map! :leader
      :desc "imenu-list"
      "t l" #'imenu-list-smart-toggle)
;;visual line of numbers ではない

(map! :leader
      :desc "snippets-find"
      "s n o" #'+snippets/find)

(map! :leader
      :desc "snippets-insert"
      "s n i" #'+snippets/new)

(map! :leader
      :desc "snippets-edit"
      "s n e" #'+snippets/edit)

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
(global-set-key  (kbd "C-j") 'move-line-down)
(global-set-key (kbd "C-k")  'move-line-up)

;;クリップボードにPwd
(map! :leader
      :desc "evil-pwd"
      "p w"#'+evil:pwd)

(map! :leader
      :desc "ranger"
      "f j"#'ranger)

(map! :leader
      :desc "ranger"
      "v a"#'ankki)

(map! :leader
      :desc "man page"
      "d c"#'man)

(map! :leader
      :desc "run sly"
      "a a" #'sly)
(map! :leader
      :desc "clippy-describe-variable"
      "v v" #'clippy-describe-variable)

(map! :leader
      :desc "clippy-describe-function"
      "v f" #'clippy-describe-function)

(map! :leader
      :desc "clippy-describe-function"
      "q n" #'sp-forward-sexp)

(map! :leader
      :desc "clippy-describe-function"
      "q b" #'sp-barkward-sexp)

(map! :leader
      :desc  "hydra gd"
      "g d"#'gdscript-hydra-show)

(map! :leader
      :desc "latex-preview"
      "l p"#'org-latex-preview)

(custom-set-faces!
  '(doom-dashboard-banner :foreground "red"  :weight bold)
  '(doom-dashboard-footer :inherit font-lock-constant-face)
  '(doom-dashboard-footer-icon :inherit all-the-icons-red)
  '(doom-dashboard-loaded :inherit font-lock-warning-face)
  '(doom-dashboard-menu-desc :inherit font-lock-string-face)
  '(doom-dashboard-menu-title :inherit font-lock-function-name-face))

(use-package doom-themes
    :custom
    (doom-themes-enable-italic t)
    (doom-themes-enable-bold t)
    :custom-face
    (doom-modeline-bar ((t (:background "#6272a4"))))
    :config
    (load-theme 'doom-dracula t)
    (doom-themes-neotree-config )
    (doom-themes-org-config))

(use-package! glsl-mode)
(add-to-list 'auto-mode-alist '("\\.gdshader\\'" . glsl-mode))

(setq org-plantuml-jar-path "~/.emacs.d/lib/plantuml.jar")

(setq gdscript-godot-executable "/Users/yamamotoryuuji/Desktop/Godot.app/Contents/MacOS/Godot")

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

(use-package sly)

(use-package! coconut-mode)
(add-to-list 'auto-mode-alist '("\\.coco\\'" . coconut-mode))

(use-package! request)

(require 'org-habit)

(when (string-equal system-type "darwin")

(setq org-directory "~/org")

)
(when (string-equal system-type "gnu/linux")
(setq org-directory "~/org")
)

(when (string-equal system-type "darwin")

(setq +org-capture-journal-file "~/org" )

)
(when (string-equal system-type "gnu/linux")
(setq org-journal-dir "~/MEGAsync/journal" )
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
                           "~/org/hackemacs.oeg"
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
      '(("n" "🐕🐕🐩🐕🐕"
         ((tags "PRIORITY=\"A\""
                ((org-agenda-skip-function '(org-agenda-skip-entry-if 'todo 'done))
                 (org-agenda-overriding-header "High-priority unfinished tasks:")))
          (agenda "" ((org-agenda-span 4)))
          (alltodo ""
                   ((org-agenda-skip-function
                     '(or (air-org-skip-subtree-if-priority ?A)
                          (org-agenda-skip-if nil '(scheduled deadline))))))))
        ("w" "🐩🐩🐕🐩🐩"
         ((alltodo ""
                   (org-habit-show-habits t))))))

(use-package! org-download
  :after org
  :config
  (setq-default org-download-image-dir "./images/"
                ;; org-download-screenshot-method "flameshot gui --raw > %s"
                org-download-delete-image-after-download t
                org-download-method 'directory
                org-download-heading-lvl 1
                org-download-screenshot-file "/tmp/screenshot.png"
                )
  (cond (IS-LINUX (setq-default org-download-screenshot-method "xclip -selection clipboard -t image/png -o > %s"))
        (IS-MAC (setq-default org-download-screenshot-method "screencapture -i %s")))
  )

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

;;      :custom (org-bullets-bullet-list '())
(setq org-startup-folded t)

(setq
    org-superstar-headline-bullets-list '("♁" "☾" "☿" "♀" "☉" "♂" "♃" "♄")
)

(require 'org-tempo)
(add-to-list 'org-structure-template-alist '("el" . "src emacs-lisp"))
(add-to-list 'org-structure-template-alist '("cl" . "src lisp"))
(add-to-list 'org-structure-template-alist '("aw" . "src awk"))
(add-to-list 'org-structure-template-alist '("fi" . "src fish"))
(add-to-list 'org-structure-template-alist '("py" . "src python"))
(add-to-list 'org-structure-template-alist '("hs" . "src haskell"))
(add-to-list 'org-structure-template-alist '("pl" . "src plantuml"))
(add-to-list 'org-structure-template-alist '("js" . "src javascript"))

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
 '(fish . t)
 '(python . t)
 '(haskell. t)
 '(C++ . t)
 '(dot . t)
 '(javascript . t)
 '(plantuml. t)
 )

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
        )))

(setq org-roam-directory "/Users/yamamotoryuuji/Dropbox/roam")
(use-package org-roam-bibtex
  :after org-roam
  :config
  (require 'org-ref))

(use-package! websocket
    :after org-roam)

(use-package! org-roam-ui
    :after org ;; or :after org
         normally we'd recommend hooking orui after org-roam, but since org-roam does not have
         a hookable mode anymore, you're advised to pick something yourself
         if you don't care about startup time, use
    :hook (after-init . org-roam-ui-mode)
    :config
    (setq org-roam-ui-sync-theme t
         org-roam-ui-follow t
          org-roam-ui-update-on-save t
         org-roam-ui-open-on-start t))

(setq org-roam-dailies-directory "/Users/yamamotoryuuji/Dropbox/roam/journal")
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (setq org-roam-dialies-capture-template                                    ;;
;;       '(("d" "default" entry "* %<%I:%H%p>: %?"                            ;;
;;         :if-new (file+head "%S<%Y-%m-%d>.org" "#+title: %<%Y-%m%d>\n?")))) ;;
;;;;;;;;;;;f;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(setq org-roam-dailies-capture-templates
      '(("d" "Journal" entry "* %<%H: %M>\n"
         :if-new (file+head+olp "%<%Y-%m-%d>.org"
  	  	        "#+title: %<%Y-%m-%d>\n#+filetags: %<:%Y:%B:>\n"
		  	        ("Journal")))
        ("b" "books" entry "* books"
         :if-new (file+head+olp "%<%Y-%m-%d>.org"
  	  	        "#+title: %<%Y-%m-%d>\n#+filetags: %<:%Y:%B:>\n"
		  	        ("Journal")))


        ("m" "Most Important Thing" entry "* TODO %? :mit:"
         :if-new (file+head+olp "%<%Y-%m-%d>.org"
			        "#+title: %<%Y-%m-%d>\n#+filetags: %<:%Y:%B:>\n"
			        ("Most Important Thing(s)")))))

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
         "%a"
         :immediate-finish t))

(setq org-src-fontify-natively t)

(defun my-pretty-lambda ()
  (setq prettify-symbols-alist '(("lambda" . 955)
                                 )))

(add-hook 'python-mode-hook 'my-pretty-lambda)
(add-hook 'python-mode-hook 'prettify-symbols-mode)
(add-hook 'org-mode-hook 'my-pretty-lambda)
(add-hook 'org-mode-hook 'prettify-symbols-mode)
(add-hook 'lisp-mode-hook 'my-pretty-lambda)
(add-hook 'lisp-mode-hook 'prettify-symbols-mode)
(add-hook 'emacs-lisp-mode-hook 'my-pretty-lambda)
(add-hook 'emacs-lisp-mode-hook 'prettify-symbols-mode)

(defun font-set-yay ()
(set-fontset-font t 'japanese-jisx0208 (font-spec :family "ヒラギノ角ゴシック")))

(set-fontset-font t 'japanese-jisx0208 (font-spec :family "ヒラギノ角ゴシック"))
(add-hook 'emacs-startup-hook 'font-set-yay)

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
     (insert "─"))
    ))


;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (defun box-display () ;;
;;   (interactive)       ;;
;;)
;;;;;;;;;;;;;;;;;;;;;;;;;;;



(map! :leader
      :desc "個数を指定して矢印をつくる"
      "a j l" #'yajirushi-add)

(map! :leader
      :desc "文字の種類に応じて変換"
      "a r" #'yajirushi-rotate)

(map! :leader
      :desc "文字の種類に応じて変換"
      "a x" #'yajirushi-expand)
(map! :leader
      :desc "文字の種類に応じて変換"
      "a o" #'yajirushi-new-line)

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



(use-package ob)
