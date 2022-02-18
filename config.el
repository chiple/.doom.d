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
      :desc "man page"
      "d c"#'man)

(map! :leader
      :desc "run sly"
      "a a" #'sly)

(map! :leader
      :desc  "hydra gd"
      "g d"#'gdscript-hydra-show)

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

(setq gdscript-godot-executable "/Users/yamamotoryuuji/desktop/Godot.app/contents/MacOS/Godot")

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

  (setq org-agenda-files '("~/MEGA/MEGAsync/org"
                           "~/org/todo.org"
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

(setq org-roam-directory "/Users/yamamotoryuuji/roam")
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

(setq org-roam-dailies-directory "/Users/yamamotoryuuji/roam/journal")

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
