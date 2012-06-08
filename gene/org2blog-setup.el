;; org2blog
(when (require 'org2blog-autoloads nil 'noerror)

(setq org2blog/wp-blog-alist
      '(("genedelisa"
         :url "http://genedelisa.com/xmlrpc.php"
         :username "gene"
         :default-title "Hello World"
         :default-categories ("org2blog" "emacs")
         :tags-as-categories nil)
        ("rockhopper"
         :url "http://rockhoppertech.com/blog/xmlrpc.php"
         :username "gene")))
)
