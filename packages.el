;; -*- no-byte-compile: t; -*-
;;; $DOOMDIR/packages.el

;; To install a package with Doom you must declare them here and run 'doom sync'
;; on the command line, then restart Emacs for the changes to take effect -- or
;; use 'M-x doom/reload'.

;; To install SOME-PACKAGE from MELPA, ELPA or emacsmirror:
;(package! some-package)

;; To install a package directly from a remote git repo, you must specify a
;; `:recipe'. You'll find documentation on what `:recipe' accepts here:
;; https://github.com/raxod502/straight.el#the-recipe-format
;(package! another-package
;  :recipe (:host github :repo "username/repo"))
(package! org-roam-bibtex
  :recipe (:host github :repo "org-roam/org-roam-bibtex" :branch "orb-v0.5"))

(package! biblio.el
  :recipe (:host github :repo "cpitclaudel/biblio.el"))

(package! coconut-mode
  :recipe (:host github :repo "NickSeagull/coconut-mode"))
(package! ob-fish
  :recipe (:host github :repo "takeokunn/ob-fish"))

(package! circe
  :recipe (:host github :repo "emacs-circe/circe"))

(package! org-tree-slide
  :recipe (:host github :repo "takaxp/org-tree-slide"))

(package! request
  :recipe (:host github :repo "tkf/emacs-request"))

(package! ergantt
  :recipe (:host github :repo "legalnonsense/elgantt"))

(package! org-ql
  :recipe (:host github :repo "alphapapa/org-ql"))

(package! ace-window
  :recipe (:host github :repo "abo-abo/ace-window"))

(package! lsp-ui
  :recipe (:host github :repo "emacs-lsp/lsp-ui"))


(package! imenu-list
  :recipe (:host github :repo "bmag/imenu-list"))

(package! graphviz-dot-mode
  :recipe (:host github :repo "ppareit/graphviz-dot-mode"))

(package! clippy)
(package!  ivy-posframe
  :recipe (:host github :repo "tumashu/ivy-posframe"))
(package!  beacon
  :recipe (:host github :repo "Malabarba/beacon"))

(package! el-easydraw
  :recipe (:host github :repo "misohena/el-easydraw"))

(package! pos-tip
  :recipe (:host github :repo "tjarvstrand/pos-tip"))

(package! glsl-mode
  :recipe (:host github :repo "jimhourihan/glsl-mode"))

(package! oj
  :recipe (:host github :repo "conao3/oj.el"))

(package! cargo
  :recipe (:host github :repo "kwrooijen/cargo.el"))

(package! exec-path-from-shell
  :recipe (:host github :repo "purcell/exec-path-from-shell"))

(package! emacs-dashboard
  :recipe (:host github :repo "emacs-dashboard/emacs-dashboard"))
(package! nyan-mode
  :recipe (:host github :repo "TeMPOraL/nyan-mode"))

(package! org-graph-view
  :recipe (:host github :repo "alphapapa/org-graph-view"))

(package! org-pretty-table
  :recipe (:host github :repo "Fuco1/org-pretty-table"))

(package! org-mind-map
  :recipe (:host github :repo "the-ted/org-mind-map"))

(package! org-modern
  :recipe (:host github :repo "minad/org-modern"))

(package! modus-themes
  :recipe (:host github :repo "protesilaos/modus-themes"))

(package! ox-hugo
  :recipe (:host github :repo "kaushalmodi/ox-hugo"))

(package! emacs-easy-hugo
  :recipe (:host github :repo "masasam/emacs-easy-hugo"))

(package! nov.el
  :recipe (:host github :repo "wasamasa/nov.el"))

(package!  org-inline-anim.el
  :recipe (:host github :repo "shg/org-inline-anim.el"))


(unpin! org-roam company-org-roam)
(package! org-roam-ui)
;; If the package you are trying to install does not contain a PACKAGENAME.el
;; file, or is located in a subdirectory of the repo, you'll need to specify
;; `:files' in the `:recipe':
;(package! this-package
;  :recipe (:host github :repo "username/repo"
;           :files ("some-file.el" "src/lisp/*.el")))

;; If you'd like to disable a package included with Doom, you can do so here
;; with the `:disable' property:
;(package! builtin-package :disable t)

;; You can override the recipe of a built in package without having to specify
;; all the properties for `:recipe'. These will inherit the rest of its recipe
;; from Doom or MELPA/ELPA/Emacsmirror:
;(package! builtin-package :recipe (:nonrecursive t))
;(package! builtin-package-2 :recipe (:repo "myfork/package"))

;; Specify a `:branch' to install a package from a particular branch or tag.
;; This is required for some packages whose default branch isn't 'master' (which
;; our package manager can't deal with; see raxod502/straight.el#279)
;(package! builtin-package :recipe (:branch "develop"))

;; Use `:pin' to specify a particular commit to install.
;(package! builtin-package :pin "1a2b3c4d5e")


;; Doom's packages are pinned to a specific commit and updated from release to
;; release. The `unpin!' macro allows you to unpin single packages...
;(unpin! pinned-package)
;; ...or multiple packages
;(unpin! pinned-package another-pinned-package)
;; ...Or *all* packages (NOT RECOMMENDED; will likely break things)
;(unpin! t)
(package! dmenu)
