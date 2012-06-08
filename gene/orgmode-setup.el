(require 'org-install)
(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))

(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)
(global-set-key (kbd "C-x g") 'gtd)

(setq org-directory "~/Dropbox/org")
(setq org-default-notes-file "~/Dropbox/org/refile.org")
;;(setq org-directory "~/git/org")
;;(setq org-default-notes-file "~/git/org/refile.org")

;; Set to <your Dropbox root directory>/MobileOrg.
(setq org-mobile-directory "~/Dropbox/MobileOrg")
;; by default this is org-agenda-files
;;(setq org-mobile-files )
;; Set to the name of the file where new notes will be stored
(setq org-mobile-inbox-for-pull "~/Dropbox/org/from-mobile.org")
;;

(setq org-todo-keywords '((type "TODO" "NEXT" "WAITING" "DONE")))
;; (setq org-todo-keywords '((sequence "TODO" | "DONE")
;;    			  (sequence "REPORT" "BUG" "KNOWNCAUSE" | "FIXED")
;;  			  (sequence | "CANCELLED")))
(setf org-todo-keyword-faces '(("NEXT" . (:foreground "yellow" :background "red" :bold t :weight bold))
			       ("TODO" . (:foreground "cyan" :background "steelblue" :bold t :weight bold))
			       ("WAITING" . (:foreground "yellow" :background "magenta2" :bold t :weight bold))
			       ("DONE" . (:foreground "gray50" :background "gray30"))))

;; (setq org-agenda-custom-commands
;;       '(("w" todo "WAITING" nil)
;; 	("n" todo "NEXT" nil)
;; 	("d" "Agenda + Next Actions" ((agenda) (todo "NEXT")))))
;;http://orgmode.org/worg/users/bzg.html
(setq org-agenda-custom-commands
      '(;; Daily agenda view
        (" " "Today" agenda "List of tasks for today"
         ((org-agenda-ndays 1)
          (org-deadline-warning-days 3)
          (org-agenda-sorting-strategy '(time-up todo-state-up priority-down))))

        ;; Everything that has a NEXT keyword
        ("," . "NEXT")
        (",," tags-todo "Status={Work}/NEXT" nil)
        (",!" tags-todo "-Status={Work}/NEXT" nil)
        (",+" tags-todo "Status={Leisure}/NEXT" nil)
        (",?" tags-todo "Status={GTD}/NEXT" nil)
        (",#" tags-todo "Status={WOT}/NEXT" nil)
        (",*" todo "NEXT" nil)

        ;; Everything that has a TODO keyword
        (";" . "TODO")
        (";;" tags-todo "Status={Work}/TODO" nil)
        (";!" tags-todo "-Status={Work}/TODO" nil)
        (";+" tags-todo "Status={Leisure}/TODO" nil)
        (";?" tags-todo "Status={GTD}/TODO" nil)
        (";#" tags-todo "Status={WOT}/TODO" nil)
        (";*" todo "TODO" nil)

        ;; Everything that has a NEXT or a TODO keyword
        ("." . "NEXT|TODO")
        (".." tags-todo "Status={Work}/NEXT|TODO" nil)
        (".!" tags-todo "-Status={Work}/NEXT|TODO" nil)
        (".+" tags-todo "Status={Leisure}/NEXT|TODO" nil)
        (".?" tags-todo "Status={GTD}/NEXT|TODO" nil)
        (".#" tags-todo "Status={WOT}/NEXT|TODO" nil)
        (".*" todo "NEXT|TODO" nil)

        ;; Everything that is in progress
        (":" . "In progress")
        ("::" tags-todo "+Progress={[0-9]+%}Status={Work}")
        (":!" tags-todo "+Progress={[0-9]+%}-Status={Work}")
        (":+" tags-todo "+Progress={[0-9]+%}+Status={Leisure}")
        (":?" tags-todo "+Progress={[0-9]+%}+Status={GTD}")
        (":#" tags-todo "+Progress={[0-9]+%}+Status={WOT}")
        (":*" tags-todo "+Progress={[0-9]+%}"
         ((org-agenda-sorting-strategy '(time-up todo-state-up priority-down))))

        ;; Everything that has a "Read" tag
        ("R" tags-todo "Status={Work}+Read/NEXT" ; shortcut for `C-c a r ,'
         ((org-agenda-sorting-strategy '(time-up todo-state-up priority-down effort-up))))
        ("r" . "Read")
        ("rr" tags-todo "Status={Work}+Read/NEXT" nil)
        ("r." tags-todo "Read/NEXT|TODO" nil)
        ("r," tags-todo "Read/NEXT" nil)
        ("r;" tags-todo "Read/TODO" nil)
        ("r:" tags "+Progress={[0-9]+%}+Read" nil)
        ("r!" tags-todo "-Status={Work}+Read/NEXT" nil)
        ("r+" tags-todo "+Status={Leisure}+Read/NEXT" nil)
        ("r?" tags-todo "+Status={GTD}+Read/NEXT" nil)
        ("r#" tags-todo "+Status={WOT}+Read/NEXT" nil)
        ("r*" tags "Read"
         ((org-agenda-sorting-strategy '(time-up todo-state-up priority-down))))
;;      ("r_" tags "Read+LEVEL<3" nil)
        ("rF" tags "+Read+@Offline" nil)
        ("r@" tags "+Read+Mail" nil)

        ;; Everything that has a "Write" tag
        ("W" tags-todo "Status={Work}+Write/NEXT"  ; shortcut for `C-c a w ,'
         ((org-agenda-sorting-strategy '(time-up todo-state-up priority-down effort-up))))
        ("w" . "Write")
        ("ww" tags-todo "Status={Work}+Write/NEXT" nil)
        ("w." tags-todo "Write/NEXT|TODO" nil)
        ("w," tags-todo "Write/NEXT" nil)
        ("w;" tags-todo "Write/TODO" nil)
        ("w:" tags "+Progress={[0-9]+%}+Write" nil)
        ("w!" tags-todo "-Status={Work}+Write/NEXT" nil)
        ("w+" tags-todo "+Status={Leisure}+Write/NEXT" nil)
        ("w?" tags-todo "+Status={GTD}+Write/NEXT" nil)
        ("w#" tags-todo "+Status={WOT}+Write/NEXT" nil)
        ("wo" tags "+Write+@Online" nil)
        ("w@" tags "+Write+Mail" nil)
        ("w*" tags "Write"
         ((org-agenda-sorting-strategy '(time-up todo-state-up priority-down))))

        ;; Working on bugs
        ("b" . "Bug")
        ("bb" tags-todo "+Bug"
         ((org-agenda-sorting-strategy '(time-up todo-state-up priority-down))))
        ("b," tags-todo "+Bug/NEXT"
         ((org-agenda-sorting-strategy '(time-up todo-state-up priority-down))))
        ("b." tags-todo "+Bug/NEXT|TODO"
         ((org-agenda-sorting-strategy '(time-up todo-state-up priority-down))))
        ("b;" tags-todo "+Bug/TODO"
         ((org-agenda-sorting-strategy '(time-up todo-state-up priority-down))))
        ("b:" tags-todo "+Bug+Progress={[0-9]+%}"
         ((org-agenda-sorting-strategy '(time-up todo-state-up priority-down))))

        ;; Working on code
        ("$" . "Code")
        ("$$" tags-todo "+Code"
         ((org-agenda-sorting-strategy '(time-up todo-state-up priority-down))))
        ("$," tags-todo "+Code/NEXT"
         ((org-agenda-sorting-strategy '(time-up todo-state-up priority-down))))
        ("$." tags-todo "+Code/NEXT|TODO"
         ((org-agenda-sorting-strategy '(time-up todo-state-up priority-down))))
        ("$;" tags-todo "+Code/TODO"
         ((org-agenda-sorting-strategy '(time-up todo-state-up priority-down))))
        ("$:" tags-todo "+Code+Progress={[0-9]+%}"
         ((org-agenda-sorting-strategy '(time-up todo-state-up priority-down))))

        ;; Others contexts
        ("F" tags "@Offline"
         ((org-agenda-sorting-strategy '(time-up todo-state-up priority-down))))
        ("p" tags "Print"
         ((org-agenda-sorting-strategy '(time-up todo-state-up priority-down))))
        ("?" todo "WAITING")
        ("D" todo "DELEGATED")
        ("v" tags "Watch" ((org-agenda-sorting-strategy '(time-up todo-state-up priority-down))))
        ("g" tags "Blog" ((org-agenda-sorting-strategy '(time-up todo-state-up priority-down))))
        ("l" tags "Listen" ((org-agenda-sorting-strategy '(time-up todo-state-up priority-down))))
        ("@" tags "Mail" ((org-agenda-sorting-strategy '(time-up todo-state-up priority-down)))) ;; necessary?
        ))



;;(org-agenda-files (directory-files org-directory t ".*\.org$"))

(setq org-agenda-files (quote (
                               "~/Dropbox/org/gtd.org"
                               "~/Dropbox/org/shopping.org"
                               "~/Dropbox/org/home.org"
                               "~/Dropbox/org/genedelisa-com.org"
                               "~/Dropbox/org/programming.org"
                               "~/Dropbox/org/financial.org"
                               "~/Dropbox/org/rockhoppertech-com.org"
                               )))

(defun gtd ()
  (interactive)
  (find-file "~/Dropbox/org/gtd.org")
  )

(defun refile ()
  (interactive)
  (find-file "~/Dropbox/org/refile.org")
  )

(defun orgdir ()
  (interactive)
  (dired "~/Dropbox/org/")
  )



;; Capture
;; http://orgmode.org/manual/Template-elements.html#Template-elements
;; http://doc.norang.ca/org-mode.html#CaptureTemplates
;; Capture templates for: TODO tasks, Notes, appointments, phone calls, and org-protocol
(setq org-capture-templates
      (quote (("t" "todo" entry (file "~/Dropbox/org/refile.org")
               "* TODO %?\n%U\n%a\n" :clock-in t :clock-resume t)
              ("r" "respond" entry (file "~/Dropbox/org/refile.org")
               "* TODO Respond to %:from on %:subject\n%U\n%a\n"
               :clock-in t
               :clock-resume t
               :immediate-finish t)

              ("e" "Emacs" entry (file "~/Dropbox/org/emacs.org")
               "* %? :EMACS:\n%U\n%a\n" :clock-in t :clock-resume t)

              ("n" "note" entry (file "~/Dropbox/org/refile.org")
               "* %? :NOTE:\n%U\n%a\n" :clock-in t :clock-resume t)
              ("j" "Journal" entry (file+datetree "~/Dropbox/org/journal.org")
               "* %?\n%U\n" :clock-in t :clock-resume t)
              ("w" "org-protocol" entry (file "~/Dropbox/org/refile.org")
               "* TODO Review %c\n%U\n" :immediate-finish t)
              ("p" "Phone call" entry (file "~/Dropbox/org/refile.org")
               "* PHONE %? :PHONE:\n%U" :clock-in t :clock-resume t)
              ("h" "Habit" entry (file "~/Dropbox/org/refile.org")
               "* NEXT %?\n%U\n%a\nSCHEDULED: %t .+1d/3d\n:PROPERTIES:\n:STYLE: habit\n:REPEAT_TO_STATE: NEXT\n:END:\n"))))

 ;; Targets include this file and any file contributing to the agenda - up to 9 levels deep
(setq org-refile-targets (quote ((nil :maxlevel . 9)
                                 (org-agenda-files :maxlevel . 9))))

 ;; Use full outline paths for refile targets - we file directly with IDO
(setq org-refile-use-outline-path t)

 ;; Targets complete directly with IDO
(setq org-outline-path-complete-in-steps nil)

 ;; Allow refile to create parent tasks with confirmation
(setq org-refile-allow-creating-parent-nodes (quote confirm))

 ;; Use IDO for both buffer and file completion and ido-everywhere to t
(setq org-completion-use-ido t)
(setq ido-everywhere t)
(setq ido-max-directory-size 100000)
(ido-mode (quote both))

;;;; Refile settings
 ;; Exclude DONE state tasks from refile targets
(defun bh/verify-refile-target ()
  "Exclude todo keywords with a done state from refile targets"
  (not (member (nth 2 (org-heading-components)) org-done-keywords)))

(setq org-refile-target-verify-function 'bh/verify-refile-target)
;;;


;; babel setup
(org-babel-do-load-languages
 'org-babel-load-languages
 '((clojure . t)
   (haskell . t)
   (C . t)
   (emacs-lisp . t)
   (R . t)
   (sh . t)
   ))

(defun gene/org-mode-hook ()
  (local-set-key "\C-x\C-a" 'show-all)
  (imenu-add-to-menubar "Imenu")
  (setq comment-start nil)
  )
(add-hook 'org-mode-hook 'gene/org-mode-hook)



(setq org-tag-alist '((:startgroup . nil)
                      ("@WORK" . ?w)
                      ("@HOME" . ?h)
                      (:endgroup . nil)
                      ("EMACS" . ?e)
		      ("READING" . ?r)
                      ("FINANCIAL" . ?f)
                      ("MAIL" . ?m)
                      ("SHOPPING" . ?s)
                      ("MACBOOK" . ?b)
                      ("IMAC" . ?i)))

(setq t-alist'(("Read" . ?r) ("Write" . ?w) ("Watch" . ?v) ("Blog" . ?g)
               ("Listen" . ?l) ("Code" . ?c) ("Bug" . ?b)
               ("@HOME" . ?H) ("@LAB" . ?L) ("@Online" . ?O)
               ("@Offline" . ?F) ("Mail" . ?m) ("Print" . ?p)))


(require 'diary-lib)
(add-hook 'diary-display-hook 'fancy-diary-display)

(add-to-list 'org-link-abbrev-alist '("google" . "http://www.google.com/search?q="))

(setq org-reverse-note-order t)  ;; note at beginning of file by default.

(setq org-startup-folded nil)
(setq org-log-done 'time)
(setq org-hide-leading-stars t)
(setq org-agenda-include-diary t)
(setq org-agenda-skip-scheduled-if-done t)
(setq org-agenda-skip-deadline-if-done t)
(setq org-agenda-include-all-todo t)
(setq org-use-property-inheritance t)
;; (setq org-enforce-todo-dependencies t)
(setq org-special-ctrl-a/e t)
(setq org-special-ctrl-k t)
(setq org-blank-before-new-entry (quote ((heading . auto) (plain-list-item))))
(setq org-agenda-dim-blocked-tasks 'invisible)
(setq org-enforce-todo-checkbox-dependencies t)
;; (setq org-completion-use-iswitchb t)
;; (setq org-export-allow-BIND t)
(setq diary-file "~/Dropbox/org/diary")
(setq mark-diary-entries-in-calendar t)
