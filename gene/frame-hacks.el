;; -*- mode: Emacs-Lisp; mode: auto-fill; -*-
;;
;; Time-stamp: "2012-05-01 11:49:34 gene"
;;

(defun frame-half-screen()
  (interactive)
  (setq max-frame-width (/ (x-display-pixel-width) (frame-char-width)))
  (setq max-frame-height (/ (x-display-pixel-height) (frame-char-height)))
  (setq half-max-width  (/ max-frame-width 2))
  (setq half-max-height  (/ max-frame-height 2))
  (modify-frame-parameters
   (selected-frame)
   '(
     (width . half-max-width)
     (height . half-max-height)
     )
   )
  (set-frame-width (selected-frame) half-max-width)
  (set-frame-height (selected-frame) half-max-height)
  (set-frame-position (selected-frame) -1 5)
  )

;; 8 and 5 take the borders into account
;;(setq debug-on-error t)
(setq debug-on-error nil)

(defun frame-full-screen()
  (interactive)

  ;; the 5 and 3 are "magic" numbers. would be nice to calc them.
  (setq wpad 5)
  (setq hpad 3)
                                        ;  (setq wpad (frame-char-width) )
  (setq max-frame-width (- (/ (x-display-pixel-width) (frame-char-width)) wpad) )
  (setq max-frame-height (- (/ (x-display-pixel-height) (frame-char-height)) hpad ))

  ;; these are too big
  ;;  (setq max-frame-width  (/ (x-display-pixel-width) (frame-char-width)) )
  ;;  (setq max-frame-height  (/ (x-display-pixel-height) (frame-char-height)))

  ;; the width and height are in lines and column, not pixels
  (modify-frame-parameters
   (selected-frame)
   '(
     (width . max-frame-width)
     (height . max-frame-height)
     )
   )
  (set-frame-width (selected-frame) max-frame-width)
  (set-frame-height (selected-frame) max-frame-height)
  (set-frame-position (selected-frame) 0 0)
  )

(defun frame-center()
  (interactive)
  (set-frame-position
   (selected-frame)

   ;;center the screen horizontally
   (/ (- (x-display-pixel-width)
         (frame-pixel-width)) 2)

   ;; need to account for the title bar and menu when centering
   ;; vertically
   (- (/ (- (x-display-pixel-height)
            (frame-pixel-height)) 5) 2))
  )

(defun frame-half-size ()
  (interactive)
  (setq half-frame-width  (/  (frame-width) 2 ))
  (setq half-frame-height (/  (frame-height) 2 ))
  (modify-frame-parameters
   (selected-frame)
   '(
     (width . half-frame-width)
     (height . half-frame-height)
     )
   )
  (set-frame-width (selected-frame) half-frame-width)
  (set-frame-height (selected-frame) half-frame-height)
  (set-frame-position (selected-frame) -1 5)
  )

(defun frame-top-left ()
  (interactive)
  (modify-frame-parameters
   (selected-frame)
   '(
     (top . 0)
     (left . 0)
     )
   )
  (set-frame-position (selected-frame) 0 0)
  )

;; -0 should work but doesn't
(defun frame-top-right ()
  (interactive)
  (modify-frame-parameters
   (selected-frame)
   '(
     (top . 0)
     (left .  -1)
     )
   )
  (set-frame-position (selected-frame) -1 0)
  )

(defun frame-bottom-right ()
  (interactive)
  (modify-frame-parameters
   (selected-frame)
   '(
     (top . -1)
     (left .  -1)
     )
   )
  (set-frame-position (selected-frame) -1 -1)
  )

(defun frame-bottom-left ()
  (interactive)
  (modify-frame-parameters
   (selected-frame)
   '(
     (top . -1)
     (left .  0)
     )
   )
  (set-frame-position (selected-frame) 0 -1)
  )

;;(message (frame-parameters) )
;;(message (x-parse-geometry "80x40+0-0"))
;;(message (int-to-string (frame-height)))
;;(message (int-to-string (frame-width)))

(defun show-frame-size ()
  (interactive)
  (message (concat
            '"width "
            (int-to-string (frame-width))

            '" height "
            (int-to-string (frame-height))

            '" pixelwidth "
            (int-to-string (frame-pixel-width))

            '" pixelheight "
            (int-to-string (frame-pixel-height))


            " char width in pixels "
            (int-to-string  (frame-char-width))

            " char height "
            (int-to-string  (frame-char-height))

            " max width "
            (int-to-string (/ (x-display-pixel-width) (frame-char-width)))

            " max height "
            (int-to-string (/ (x-display-pixel-height) (frame-char-height)))

            )
           )
  )


;; your display settings
(defun show-window-size ()
  (interactive)
  (message (concat
	    '"height "
	    (int-to-string (x-display-pixel-height))
	    '" width "
	    (int-to-string (x-display-pixel-width))
	    )
	   )
  )

(defun maximize-frame ()
  (interactive)
  (set-frame-position (selected-frame) 0 0)
  (set-frame-size (selected-frame) 1000 1000))

(global-set-key (kbd "<s-S-return>") 'maximize-frame)

;; from stackoverflow
(defun set-frame-size-according-to-resolution ()
  (interactive)
  (if window-system
      (progn
        ;; use 120 char wide window for largeish displays
        ;; and smaller 80 column windows for smaller displays
        ;; pick whatever numbers make sense for you
        (if (> (x-display-pixel-width) 1280)
            (add-to-list 'default-frame-alist (cons 'width 120))
          (add-to-list 'default-frame-alist (cons 'width 80)))
        ;; for the height, subtract a couple hundred pixels
        ;; from the screen height (for panels, menubars and
        ;; whatnot), then divide by the height of a char to
        ;; get the height we want
        (add-to-list 'default-frame-alist
                     (cons 'height (/ (- (x-display-pixel-height) 200)
                                      (frame-char-height)))))))

;;(set-frame-size-according-to-resolution)

;;macbook 1280x800
;;(message "%s"   (x-display-pixel-width) )
;;(message "%s"   (x-display-pixel-height) )
;;(message  "%s" (frame-height (selected-frame)))
;;(message  "%s" (frame-parameters))


;;(when (require 'sr-speedbar nil 'noerror)
;;  (global-set-key (kbd "C-c s") 'sr-speedbar-toggle)
;;  )


;; Local Variables:
;; coding: utf-8
;; End:
;;; frame-hacks.el ends here
