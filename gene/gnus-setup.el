;;in init.el
;; (setq gnus-init-file "~/.emacs.d/gene/gnus-setup.el")

;;http://exal.0x2.org/conf/gnus.html
(require 'info)
(require 'gnus-spec)
(require 'gnus-demon)
(require 'gnus-mh)
(require 'starttls)
(require 'smtpmail)
(require 'gnus-kill)
(require 'nnir)

(setq smtpmail-debug-info t)
(setq user-mail-address "gendelisa@gmail.com")
;;(setq user-mail-address "gene@rockhoppertech.com")
(setq user-full-name "Gene De Lisa")
;;(setq mail-host-address "mail.rockhoppertech.com")
(setq mail-host-address "gmail.com")

(setq nnmail-expiry-wait 2)
(setq nnmail-resplit-incoming t)

;;(setq gnus-message-archive-group "nnimap+user1:INBOX.Sent")
;;(setq gnus-outgoing-message-group "nnimap+user1:INBOX.Sent")



;; Define how Gnus is to fetch news.  We do this over NNTP
;; from your ISP's server.
;;(setq gnus-select-method '(nntp "news.giganews.com"))
;;(setq gnus-select-method '(nntp "news.gmane.org"))

(setq gnus-select-method '(nntp "news"
				(nntp-address "news.gmane.org")
				(nnir-search-engine nntp))
      )



;; Define how Gnus is to read your mail.  We read mail from
;; your ISP's POP server.

;; (setq mail-sources '((pop :server "pop.genedelisa.com"
;;                                :user "gene"
;;                                )))


;; (add-to-list 'gnus-secondary-select-methods '(nnimap "gmail"
;;                                   (nnimap-address "imap.gmail.com")
;;                                   (nnimap-server-port 993)
;;                                   (nnimap-stream ssl)))


;; (setq gnus-secondary-select-methods
;;       '((nnml "gmail")
;;         (nnimap-address "imap.gmail.com")
;;         (nnimap-server-port 993)
;;         ))
;; (setq gnus-secondary-select-methods
;;       '((nnml "private")
;;         (nnimap "rockhopper"
;;                 (nnimap-address "rockhoppertech.com")
;;                 (nnimap-authenticator login))))


;; (setq gnus-secondary-select-methods
;;       '((nnimap "rockhopp"
;; 		(remove-prefix "INBOX.")
;; 		(nnimap-address "mail.rockhoppertech.com")
;;                 (nnimap-)
;; 		(nnimap-stream ssl)
;; 		(nnimap-authinfo-file "~/.authinfo")
;; 		)))


;; Say how Gnus is to store the mail.  We use nnml groups.
;;(setq gnus-secondary-select-methods '((nnml "")))

;; (add-to-list 'gnus-secondary-select-methods '(nntp
;;                                               "news.gnus.org"))

;; Make Gnus into an offline newsreader.
;; (gnus-agentize) ; The obsolete setting.
;; (setq gnus-agent t) ; Now the default.




;;;
;;(setq gnus-select-method '(nntp "news.bellatlantic.net"))
;;(setq gnus-startup-file "c:/.newsrc")


;; (setq mail-sourcesx
;;       '((file)
;;         (pop :server "mail.rockhoppertech.com"
;;              :user "rockhopp"
;;              :port 26
;;              )
;;         )
;;       '(pop :server "mail.rockhoppertech.com"
;;             :user "gene"  )
;;       )




;; standard way of getting imap going
;;(setq gnus-secondary-select-methods '((nnml "")))
(add-to-list 'gnus-secondary-select-methods '(nntp
                                              "news.gnus.org"))
(add-to-list 'gnus-secondary-select-methods '(nntp "nntp.perl.org"))
;;(add-to-list 'gnus-secondary-select-methods '(nntp "nntp.common-lisp.net"))
;;(add-to-list 'gnus-secondary-select-methods '(nntp "news1.open-news-network.org"))
;^;(add-to-list 'gnus-secondary-select-methods '(nntp "news2.open-news-network.org"))
(add-to-list 'gnus-secondary-select-methods '(nntp "news.gwene.org"))
(add-to-list 'gnus-secondary-select-methods '(nntp "freenews.netfront.net"))

(add-to-list 'gnus-secondary-select-methods '(nnimap "gmail"
                                                     (nnimap-address "imap.gmail.com")
                                                     (nnimap-server-port 993)
                                                     (nnimap-authinfo-file "~/.authinfo")
                                                     (nnimap-stream ssl)))

(setq imap-log t)



;; set up smtp so we can send from gmail too:
(setq message-send-mail-function 'smtpmail-send-it
      smtpmail-starttls-credentials '(("smtp.gmail.com" 587 nil nil))
      smtpmail-auth-credentials '(("smtp.gmail.com" 587 "myemailaddy@gmail.com" nil))
      smtpmail-default-smtp-server "smtp.gmail.com"
      smtpmail-smtp-server "smtp.gmail.com"
      smtpmail-smtp-service 587)
;;;;;;;;;;;;;;;; POP3 configuration stuff
(require 'pop3)

(eval-after-load "mail-sources"
  (setq mail-sources '((pop  :server "mail.rockhoppertech.com"
                             :user "gene"
                             :password "penguin69"
                             :port 26
                             :leave t)
                       (pop  :server "mail.rockhoppertech.com"
                             :user "rockhopp"
                             :password "c45p4rcr33k"
                             :port 26
                             :leave t)

                       ;; (imap :server "imap.gmail.com"
                       ;;       :port 993
                       ;;       :user "genedelisa@gmail.com"
                       ;;       :password "gene@penguin105"
                       ;;       :authentication 'login
                       ;;       :stream ssl
                       ;;        )

                       )))


;;(add-to-list 'gnus-secondary-select-methods '(nnml ""))

(setq gnus-permanently-visible-groups "mail")

(setq gnus-posting-styles
   '((".*" (name "Gene D"))))

(setq mail-sourcesjunk					
      '((file :path "/var/mail/bc")
        (pop :server "pop.gmail.com"
	     :port 995
	     :user "billclem"
	     :connection ssl
	     :leave t)))

;;;;;;;;;;;;End pop3 configuration stuff


;; from the ntemacs faq
;;(setq smtpmail-default-smtp-server "mail.rockhoppertech.com")
;;(setq smtpmail-local-domain nil)
;;(setq send-mail-function 'smtpmail-send-it)
;;(load-library "smtpmail")
;;(load-library "message")


;;(setq nnmail-spool-file "po:rockhopp")
;;(setq nnmail-pop-password-required t)

;; (setq mail-sources
;;       '((file)
;;         (pop :server "rockhoppertech.com"
;;              :user "rockh73"
;;              )
;;         (webmail :subtype 'hotmail
;;                  :user "therockhopper"
;;                  )
;;         )
;;       )


;;(setq gnus-show-threads nil) ;; Turn off threading


(gnus-compile)

;;; Local Variables:
;;; mode: emacs-lisp
;;; End:
