;; this is the host specific init file
;; my hostname is rocco.home

;; esk loads this before the user specific init file

;; loaded from starter-kit-autoloads.el
(message "rocco.home.el init")

(setq initial-frame-alist
      '((top . 31) (left . 480)
        (width . 240) (height . 70)
        ))
(setq default-frame-alist
      '((top . 31) (left . 600)
        (width . 250) (height . 75)
        ))


(setq markdown-command "/usr/local/bin/Markdown.pl")
(push "/usr/bin" exec-path)
(push "/opt/local/bin" exec-path)
(push "/opt/local/sbin" exec-path)

;;sudo port install aspell
;;sudo port install aspell-dict-en
(setq ispell-program-name "aspell")
