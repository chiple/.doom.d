(map! :leader
      (:prefix ("b". "buffer")
       :desc "List bookmarks" "L" #'list-bookmarks
       :desc "Save current bookmarks to bookmark file" "w" #'bookmark-save))

(map! :leader
      :desc "eww"
      "f j"#'ranger)



(map! :leader
      :desc "eww"
      "p l"#'prettify-symbols-mode)

(map! :leader
      :desc "Org-roam-server"
      "r s" #'org-roam-server-mode)

(map! :leader
      :desc "run sly"
      "a" #'sly)

(map! :leader
      :desc "dmenu"
      "d" #'dmenu)

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
      :desc "snippets-find"
      "s n o" #'+snippets/find)

(map! :leader
      :desc "snippets-insert"
      "s n i" #'+snippets/new)

(map! :leader
      :desc "snippets-edit"
      "s n e" #'+snippets/edit)

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

(require 'ob-fish)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (dap-register-debug-template "Debug react-native" ;;
;;     (list :type "chrome"                          ;;
;;           :cwd nil                                ;;
;;           :mode "url"                             ;;
;;           :reqest "launch"                        ;;
;;           :webRoot "~/Desktop/Tokyo100/"          ;;
;;           :url "http://localhost:19002"           ;;
;;           :name "Debug react-native"              ;;
;; ))                                                ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package sly)

(use-package! coconut-mode)

(require 'org-habit)

(when (string-equal system-type "darwin")

(setq org-directory "~/MEGA/MEGAsync")

)
(when (string-equal system-type "gnu/linux")
(setq org-directory "~/MEGAsync")
)

(when (string-equal system-type "darwin")

(setq +org-capture-journal-file "~/MEGA/MEGAsync/journal" )

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
                           "~/MEGA/MEGAsync/todo.org"
                           "~/MEGA/MEGAsync/journal.org"
                           "~/MEGA/MegaSyncFiles/todo.org"
                           )))

)
(when (string-equal system-type "gnu/linux")

  (setq org-agenda-files '("~/MEGAsync/org")))


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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (when (string-equal system-type "darwin")                                 ;;
;;  (setq org-roam-server-file-path "/Users/yamamotoryuuji/org-roam-server") ;;
;; )                                                                         ;;
;; (when (string-equal system-type "gnu/linux")                              ;;
;;  (setq org-roam-server-file-path "/home/ryu/org-roam-server")             ;;
;; )                                                                         ;;
;; (use-package org-roam-server                                              ;;
;;   :ensure t                                                               ;;
;;   :load-path org-roam-server-file-path                                    ;;
;;   :config                                                                 ;;
;;   :init                                                                   ;;
;;   (setq org-roam-server-host "127.0.0.1"                                  ;;
;;         org-roam-server-port 8080                                         ;;
;;         org-roam-server-authenticate nil                                  ;;
;;         org-roam-server-export-inline-images t                            ;;
;;         org-roam-server-serve-files nil                                   ;;
;;         org-roam-server-served-file-extensions '("pdf" "mp4" "ogv")       ;;
;;         org-roam-server-network-poll t                                    ;;
;;         org-roam-server-network-arrows nil                                ;;
;;         org-roam-server-network-label-truncate t                          ;;
;;         org-roam-server-network-label-truncate-length 60                  ;;
;;         org-roam-server-network-label-wrap-length 20)                     ;;
;; )                                                                         ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

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

(setq org-roam-directory "/Users/yamamotoryuuji/Creative Cloud Files/roam")
(use-package org-roam-bibtex
  :after org-roam
  :config
  (require 'org-ref))

(use-package! websocket
    :after org-roam)

(use-package! org-roam-ui
    :after org ;; or :after org
;;         normally we'd recommend hooking orui after org-roam, but since org-roam does not have
;;         a hookable mode anymore, you're advised to pick something yourself
;;         if you don't care about startup time, use
    :hook (after-init . org-roam-ui-mode)
    :config
    (setq org-roam-ui-sync-theme t
          org-roam-ui-follow t
          org-roam-ui-update-on-save t
          org-roam-ui-open-on-start t))

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
    org-superstar-headline-bullets-list '("🌜" "🐩" "🐈" "🐕")
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

(defun my-pretty-lambda ()
  (setq prettify-symbols-alist '(("lambda" . 955))))
(add-hook 'python-mode-hook 'my-pretty-lambda)
(add-hook 'python-mode-hook 'prettify-symbols-mode)
(add-hook 'org-mode-hook 'my-pretty-lambda)
(add-hook 'org-mode-hook 'prettify-symbols-mode)
(add-hook 'lisp-mode-hook 'my-pretty-lambda)
(add-hook 'lisp-mode-hook 'prettify-symbols-mode)

(defun font-set-yay ()
(set-fontset-font t 'japanese-jisx0208 (font-spec :family "ヒラギノ角ゴシック")))

(add-hook 'emacs-startup-hook 'font-set-yay)


