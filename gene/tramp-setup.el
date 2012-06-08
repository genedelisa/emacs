;; Copyright (C) 2003 Gene De Lisa
;;
;; Author: gene@rockhoppertech.com
;; Keywords: tramp, ssh
;; Requirements:
;; Status: In progress


;; Use C-x C-f to find files over ssh.
;; Normally: C-x C-f /path/to/file
;; Using ssh: C-x C-f /ssh:username@myhost.univ:/path/to/file
;; using sudo: C-x C-f /su::/etc/hosts


(when (require 'tramp nil 'noerror)
  (setq tramp-default-method "ssh")
  (setq tramp-default-user "gene"
        tramp-default-host "rocco")

  (tramp-set-completion-function "ssh"
                                 '((tramp-parse-sconfig "/etc/ssh_config")
                                   (tramp-parse-sconfig "~/.ssh/config")))

  ;; host, user, method
  (add-to-list 'tramp-default-method-alist '("" "gene" "ssh"))
  (add-to-list 'tramp-default-method-alist '("" "root" "ssh"))
  (add-to-list 'tramp-default-method-alist
               '("\\`localhost\\'" "\\`root\\'" "su"))

  ;; method, host, user
  (add-to-list 'tramp-default-user-alist
               '("ssh" ".*\\.rockhoppertech\\.com\\'" "rockhopp"))
  (add-to-list 'tramp-default-user-alist
               '("ssh" ".*\\.rocco\\'" "gene"))

  (tramp-set-completion-function "ssh"
                                 '((tramp-parse-sconfig "/etc/ssh_config")
                                   (tramp-parse-netrc "~/.authinfo")
                                   (tramp-parse-sconfig "~/.ssh/config")))

  )
;;; tramp-setup.el ends here
