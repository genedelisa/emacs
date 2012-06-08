;; this is the host specific init file
;; my hostname is gene.macbook

;; esk loads this before the user specific init file

;; loaded from starter-kit-autoloads.el
(message "gene.mackbook.el init")

(setq default-frame-alist
      '((top . 22) (left . 270)
        (width . 110) (height . 40)
        ))
(setq initial-frame-alist
      '((top . 22) (left . 270)
        (width . 110) (height . 40)
        ))

(setq markdown-command "/usr/local/bin/Markdown.pl")
(push "/usr/bin" exec-path)
(push "/opt/local/bin" exec-path)
(push "/opt/local/sbin" exec-path)

;;sudo port install aspell
;;sudo port install aspell-dict-en
(setq ispell-program-name "aspell")

;; doesn't work with emacs 24 yet
;;(add-to-list 'load-path "/usr/share/emacs/site-lisp/w3m")
;;(require 'w3m-load)
