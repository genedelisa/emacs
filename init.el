;; -*- Mode: Emacs-Lisp -*-
;;
;; File:   ~/.emacs.d/init.el
;;
;; Time-stamp: "Last Modified 2012-05-09 09:27:59 by Gene De Lisa, gene"
;; Gene De Lisa
;; gene@rockhoppertech.com
;; http://rockhoppertech.com/blog/
;;

(message "Emacs is powering up... Be patient, %s!"
         (getenv "USER"))

;;; load directories
;; default locations when you use make
;; /usr/local/share/emacs/site-lisp
;; /usr/local/share/info/

;; you can add to the info directory list. the above dirs are already in it
;; (add-to-list 'Info-default-directory-list "~/emacs/tramp/info/")

;; on OSX site-lisp is "/Applications/Emacs.app/Contents/Resources/site-lisp"
;; this will add to the beginning of the list
(add-to-list 'load-path "/usr/local/share/emacs/site-lisp")
;;;



;; use Leiningen in inferior lisp mode
(setq inferior-lisp-program "lein repl")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; OS X specific configuration
(if (eql system-type 'darwin)
    (progn
      (if window-system
          (menu-bar-mode t))
      (setq ns-command-modifier 'meta) ; on OSX make the command key the meta key
      (setq dired-use-ls-dired nil)
      (push "/usr/local/bin" exec-path) ;Emacs doesn't use the shell
                                        ;PATH if it's not started from
                                        ;the shell
      (push "/usr/local/git/bin" exec-path)
      (push "/opt/local/bin" exec-path) ;; macports installs. e.g. aspell
      (push "/usr/bin" exec-path)
      (setq ispell-program-name "aspell")
      ;;      (add-to-list  'Info-directory-list "/opt/local/share/info")

;;      (add-to-list 'ido-ignore-files "\\.DS_Store")
      (setq browse-url-browser-function 'browse-url-default-macosx-browser)

      (set-default-font "-apple-Inconsolata-medium-normal-normal-*-*-*-*-*-m-0-iso10646-1")

      (setq mac-option-key-is-meta nil)
      (setq mac-command-key-is-meta t)
      (setq mac-command-modifier 'meta)
      (setq mac-option-modifier nil)))
;; end OSX
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; display function name in modeline
(require 'which-func)
(add-to-list 'which-func-modes 'org-mode)
(which-function-mode 1)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; set up packages.
;; starter-kit lives at marmalade.
;; see https://github.com/technomancy/emacs-starter-kit
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") t)
;; (add-to-list 'package-archives
;;              '("marmalade" . "http://marmalade-repo.org/packages/") t)

(package-initialize)
;;
;; borrowed this from Phil Hagelberg. Good idea.
(when (not package-archive-contents)
  (package-refresh-contents))

(defvar my-packages '(starter-kit
                      starter-kit-lisp
                      starter-kit-eshell
                      starter-kit-bindings
                      tabbar
                      magit
                      speedbar
                      rainbow-mode
                      rainbow-delimiters
                      clojure-mode
                      clojure-test-mode
                      markdown-mode
                      ido-ubiquitous
                      smex
                      org2blog
                      mediawiki
                      yasnippet
                      marmalade))

(dolist (p my-packages)
  (when (not (package-installed-p p))
    (package-install p)))
;; end package grabbing
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;; read in PATH from .bash_profile
;; lein is in /usr/local/bin and that is put into the path by my .bash_profile
(if (not (getenv "TERM_PROGRAM"))
    (setenv "PATH"
            (shell-command-to-string "source $HOME/.bash_profile && printf $PATH")))

;; Git
;;(require 'magit)
;; TODO: esk should already load magit
(when (require 'magit nil 'noerror)
  ;;(global-set-key (kbd "C-c s") 'some-git-command)
  )
;;

(defun clojure-compile-on-save (&optional args)
  "Compile with slime on save"
  (interactive)
  (if (and (eq major-mode 'clojure-mode)
           (slime-connected-p))
      (slime-compile-and-load-file)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; hooks
(add-hook 'after-save-hook 'clojure-compile-on-save)

;; if you have a comment with Time-stamp: " " in the first 8 lines
;;(add-hook 'write-file-hooks 'time-stamp)
;;(add-hook 'before-save-hook 'time-stamp)
;; default format is
;;(setq time-stamp-format "%:y-%02m-%02d %02H:%02M:%02S %u")
;;(setq time-stamp-format "%3a %:b %02d, %:y %02H:%02M:%02S %U@%s %f")
;;(setq time-stamp-format "%:y-%02m-%02d %02H:%02M %U@%s %f")

;;Time-stamp files with "Time-stamp: <>" in header

;;Time-stamp-----------------------------------
;; when there is a "Time-stamp: <>" in the first 10 lines of the file,
;; emacs will write time-stamp information there when saving the file.
(setq time-stamp-active t          ; do enable time-stamps
      time-stamp-line-limit 10     ; check first 10 buffer lines for Time-stamp: <>
      time-stamp-format "Last Modified %04y-%02m-%02d %02H:%02M:%02S by %L, %u") ; date format
(add-hook 'before-save-hook 'time-stamp) ; update when saving
;;--------------------------------------------



(add-hook 'clojure-mode-hook
	  (lambda ()
	    (paredit-mode t)
            (setq show-trailing-whitespace t)
	    (show-paren-mode t)))

(add-hook 'slime-repl-mode-hook
	  (lambda ()
	    (paredit-mode t)))

(add-hook 'slime-repl-mode-hook
          (defun clojure-mode-slime-font-lock ()
            (require 'clojure-mode)
            (let (font-lock-mode)
              (clojure-mode-font-lock-setup))))

(add-hook 'emacs-lisp-mode-hook
	  (lambda ()
	    (paredit-mode t)
            (setq show-trailing-whitespace t)
	    (turn-on-eldoc-mode)
	    (eldoc-add-command
	     'paredit-backward-delete
	     'paredit-close-round)
            ;;	    (local-set-key (kbd "RET") 'electrify-return-if-match)
	    (eldoc-add-command 'electrify-return-if-match)
	    (show-paren-mode t)))

(add-hook 'org-mode-hook
          (lambda ()
            (setq show-trailing-whitespace t)
            ))

(add-hook
 'after-save-hook
 (lambda () (message "saved  buffer is: %s." (buffer-name)))
 nil t )

;;(message "saved  buffer is: %s." (buffer-name))

(defun my-after-save-hook ()
  "After-save-hook to 'git add' the modified file and schedule a commit and push in the idle loop."
  (let ((fn (buffer-file-name)))
    (message "git adding %s" fn)
    ;;    (shell-command (concat "git add " fn))
    ))

(defun my-setup-save-hook ()
  "Set up the save hook for the current file."
  (interactive)
  (message "Set up save hook for this buffer.")
  (add-hook 'after-save-hook 'my-after-save-hook nil t))

;;(my-setup-save-hook)

;; end mode hooks
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; cosmetics
;;
;; show menubar, hide toolbar and scrollbar.
(menu-bar-mode t)
(tool-bar-mode -1)
(scroll-bar-mode -1)
;; Highlight tabs so I can spot them in other people's code.
;;(highlight-tabs)
;; highlight trailing spaces
(setq-default show-trailing-whitespace t)
(setq-default fill-column 80)
(setq visible-bell nil)
(desktop-save-mode t)
;;(desktop-save "~/.desktop")

;; Highlight the current line.
(when (fboundp 'global-hl-line-mode)
  (global-hl-line-mode t))

;; Tabbar
(when (require 'tabbar nil 'noerror)
  (tabbar-mode))
;;(require 'tabbar)
;;(tabbar-mode)
;;(setq tabbar-ruler-global-ruler 't)
;;(require 'tabbar-ruler)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Backup management.
(setq make-backup-files t) ; Enable backup files.
(setq version-control t) ; Enable version controlling of the backup files.
(setq backup-directory-alist `((".*" . "~/.emacs_backups/"))) ; Where to store.
(setq backup-by-copying t)
(setq delete-old-versions t)
(setq kept-new-versions 6)
(setq kept-old-versions 2)
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Parens
;; Automatic display of matching parentheses
(setq show-paren-mode t)
(setq blink-matching-paren t)

(when (fboundp 'show-paren-mode)
  (show-paren-mode t)
  (setq show-paren-delay 0)
  (setq show-paren-style 'parenthesis))

(when (require 'rainbow-delimiters nil 'noerror)
  (add-hook 'clojure-mode-hook 'rainbow-delimiters-mode))
;;(add-hook 'after-change-major-mode-hook 'rainbow-delimiters-mode)
;; end parens
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Markdown
(defun turn-on-outline-minor-mode ()
  (outline-minor-mode 1))

(when (require 'markdown-mode nil 'noerror)
  (setq auto-mode-alist
        (cons '("\\.md" . markdown-mode) auto-mode-alist))
  (setq auto-mode-alist
        (cons '("\\.markdown" . markdown-mode) auto-mode-alist))

  ;; moved to .emacs.d/hostname.el
  ;;  (setq markdown-command "/usr/local/bin/Markdown.pl")
  ;;  (setq markdown-command "/opt/local/bin/multimarkdown")

  (add-hook 'markdown-mode-hook
            (lambda () (setq comment-auto-fill-only-comments nil)))
  (add-hook 'markdown-mode-hook 'turn-on-outline-minor-mode)
  (add-hook 'markdown-mode-hook 'turn-on-visual-line-mode)
  )
;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; themes
;;
;; solarized theme
;; https://github.com/sellout/emacs-color-theme-solarized
;;(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/sellout-emacs-color-theme-solarized-1aba0ed/" )
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/gene-dark" )
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/gene-midnight" )
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/gene-wargames" )
;; end themes
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; allow emacsclient to connect
(server-start)


;; keybindings
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; programming
(autoload 'linum-mode "linum" "mode for line numbers" t)
(global-set-key (kbd "C-<f5>") 'linum-mode)                 ;; line numbers
(global-set-key (kbd "C-<f6>") 'magit-status)               ;; ...git mode
(global-set-key (kbd "C-<f7>") 'compile)                     ;; compile
(global-set-key (kbd "C-<f8>") 'comment-or-uncomment-region) ;; (un)comment
;;
(global-set-key (kbd "C-c E")
                (lambda()(interactive)(find-file "~/.emacs.d/init.el")))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; scroll one line at a time (less "jumpy" than defaults)
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1))) ;; one line at a time
(setq mouse-wheel-progressive-speed nil)            ;; don't accelerate scrolling
(setq mouse-wheel-follow-mouse 't)                  ;; scroll window under mouse
(setq scroll-step 1)                                ;; keyboard scroll one line at a time
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; put customizations in a file
(setq custom-file "~/.emacs.d/gene-custom.el")
(if (file-exists-p "~/.emacs.d/gene-custom.el")
    (load custom-file))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq gnus-init-file "~/.emacs.d/gene/gnus-setup.el")
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Local Variables:
;; coding: utf-8
;; End:
;;; init.el ends here
