(when (require 'yasnippet nil 'noerror)
  ;; not yasnippet-bundle

  (yas/initialize)


(require 'dropdown-list)
(setq yas/prompt-functions '(yas/dropdown-prompt
                             yas/ido-prompt
                             yas/completing-prompt))

  (eval-after-load 'yasnippet
    '(progn
       ;;(add-to-list 'yas/root-directory "~/.emacs.d/snippets/")
;;       (setq yas/root-directory "~/.emacs.d/snippets")
;;       (setq yas/root-directory "~/.Emacs.d/elpa/yasnippet-0.6.1/snippets/text-mode" )
;;       (yas/load-directory yas/root-directory)


;;        (setq yas/root-directory '("~/.emacs.d/snippets"
;; ;;                                  "~/.emacs.d/elpa/yasnippet-20120502/snippets"
;; ;;                                  "~/.emacs.d/elpa/yasnippet-0.6.1/snippets/text-mode"
;; ))

       ;; Map `yas/load-directory' to every element
;;       (mapc 'yas/load-directory yas/root-directory)



      )))
