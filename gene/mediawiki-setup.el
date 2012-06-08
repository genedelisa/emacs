(when (require 'mediawiki nil 'noerror)
  (setq mediawiki-site-alist '(
                               ("Rocco" "http://rocco/~gene/mediawiki/" "" "" "Main Page")
                               ("Wikipedia" "http://en.wikipedia.org/w" "" "" "Main Page")
                               ("WikEmacs" "http://wikemacs.org/w/" "" "" "Main Page")))

  (setq mediawiki-site-default "Rocco")
  (define-key mediawiki-mode-map (kbd "C-c o") 'mediawiki-browse)

  )
