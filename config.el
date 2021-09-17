(map! :leader
      (:prefix ("b". "buffer")
       :desc "List bookmarks" "L" #'list-bookmarks
       :desc "Save current bookmarks to bookmark file" "w" #'bookmark-save))

(map! :leader
      :desc "shell"
      "s h" #'shell)

(map! :leader
      :desc "launch Web Browser with rich tools"
      "o w"#'xwidget-webkit-browse-url)

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
      :desc "open irb script"
      "r r" #'run-ruby)

(map! :leader
      :desc "org-table"
      "t o" #'org-table-create)

(map! :leader
      :desc "org-table"
      "e s" #'eshell)

(setq doom-theme 'doom-dracula)

(setq gdscript-godot-executable "/Users/yamamotoryuuji/desktop/Godot.app/contents/MacOS/Godot")

 (defun lsp--gdscript-ignore-errors (original-function &rest args)
  (if (string-equal major-mode "gdscript-mode")
      (let ((json-data (nth 0 args)))
        (if (and (string= (gethash "jsonrpc" json-data "") "2.0")
                 (not (gethash "id" json-data nil))
                 (not (gethash "method" json-data nil)))
            nil ; (message "Method not found")
          (apply original-function args)))
    (apply original-function args)))
(advice-add #'lsp--get-message-type :around #'lsp--gdscript-ignore-errors)

(use-package dap-mode)

(requirr 'dap-chrome)

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

(when (string-equal system-type "darwin")
(setq org-directory "~/MEGA/MEGAsync"))
 
(when (string-equal system-type "gnu/linux")
(setq org-directory "~/MEGAsync"))

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



(when (string-equal system-type "darwin")
 (setq org-roam-server-file-path "/Users/yamamotoryuuji/org-roam-server")
)
(when (string-equal system-type "gnu/linux")
 (setq org-roam-server-file-path "/home/ryu/org-roam-server")
)
(use-package org-roam-server
  :ensure t
  :load-path org-roam-server-file-path
  :config
  :init
  (setq org-roam-server-host "127.0.0.1"
        org-roam-server-port 8080
        org-roam-server-authenticate nil
        org-roam-server-export-inline-images t
        org-roam-server-serve-files nil
        org-roam-server-served-file-extensions '("pdf" "mp4" "ogv")
        org-roam-server-network-poll t
        org-roam-server-network-arrows nil
        org-roam-server-network-label-truncate t
        org-roam-server-network-label-truncate-length 60
        org-roam-server-network-label-wrap-length 20)
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

(setq org-startup-folded t)

(require 'org-tempo)
(add-to-list 'org-structure-template-alist '("el" . "src emacs-lisp"))
(add-to-list 'org-structure-template-alist '("cl" . "src lisp"))
(add-to-list 'org-structure-template-alist '("aw" . "src awk"))
(add-to-list 'org-structure-template-alist '("sh" . "src sh"))

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
 '(shell . t)
 )

(with-eval-after-load 'magit
  (require 'forge))


