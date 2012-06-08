;; http://atomized.org/2010/08/frame-tiling-and-centering-in-emacs/

(defun screen-usable-height (&optional display)
  "Return the usable height of the display.

Some window-systems have portions of the screen which Emacs
cannot address. This function should return the height of the
screen, minus anything which is not usable."
  (- (display-pixel-height display)
     (cond ((eq window-system 'ns) 22)
           (t 0))))

(defun screen-usable-width (&optional display)
  "Return the usable width of the display.

This works like `screen-usable-height', but for the width of the display."
  (display-pixel-width display))

(defun frame-sort-ltr (frames)
  "Sort frames by their visual order, left to right.

This method takes a list of frames, and returns that list, sorted
by the visual display order. This is determined by comparing the
left position of the frames; the leftmost frames are returned
first."
  (sort frames (lambda (framea frameb)
                 (< (frame-parameter framea 'left)
                    (frame-parameter frameb 'left)))))

(defun frame-box-get-center (w h cw ch)
  "Center a box inside another box.

Returns a list of `(TOP LEFT)' representing the centered position
of the box `(w h)' inside the box `(cw ch)'."
  (list (/ (- cw w) 2) (/ (- ch h) 2)))

(defun frame-get-center (frame)
  "Return the center position of FRAME on its display."
  (frame-box-get-center (frame-pixel-width frame) (frame-pixel-height frame)
                        (screen-usable-width) (screen-usable-height)))

(defun frame-center (&optional frame)
  "Center a frame on the screen."
  (interactive)
  (apply 'set-frame-position
         `(,(or frame (selected-frame)) ,@(frame-get-center frame))))

(defun frame-tile-horizonal ()
  "Tile visible frames horizontally.

This function tiles visible frames, distributing them evenly
across the display, and centering them vertically.

It doesn't know about multi-head displays, and will probably fail
dramatically if used in such an environment."
  (interactive)
  (let ((pos)
        (offset 0)
        (vwidth (/ (screen-usable-width) (length (visible-frame-list)))))
    (dolist (frame (frame-sort-ltr (visible-frame-list)))
      (setq pos (frame-box-get-center (frame-pixel-width frame)
                                      (frame-pixel-height frame)
                                      vwidth (screen-usable-height)))
      (set-frame-position frame (+ offset (car pos)) (cadr pos))
      (incf offset vwidth))))

(defun frame-tile-center-horizonal ()
  "Tile visible frames horizontally, center-weighted.

Rather than tiling frames evenly across the available width of
the display, this function tiles them into the center of the
display, adding a 2% margin in between frames.

It doesn't know about multi-head displays, and will probably fail
dramatically if used in such an environment."
  (interactive)
  (let* ((framewidth (apply '+ (mapcar 'frame-pixel-width (visible-frame-list))))
         (margin (/ (screen-usable-width) 50)) ;; = (/ s-u-w *.02) = 2%
         (totalwidth (+ framewidth (* margin
                                      (- (length (visible-frame-list)) 1))))
         (offset (car (frame-box-get-center totalwidth 0 (screen-usable-width)
                                            (screen-usable-height)))))

    (dolist (frame (frame-sort-ltr (visible-frame-list)))
      (set-frame-position frame offset (cadr (frame-get-center frame)))
      (incf offset (+ margin (frame-pixel-width frame))))))

(defun frame-restore-defaults (frame)
  (modify-frame-parameters frame default-frame-alist))

(defun frame-default ()
  (interactive)
  (mapcar 'frame-restore-defaults (frame-list))
  (if (> (length (frame-list)) 1)
      (frame-tile-center-horizonal)
    (frame-center)))

(provide 'ime-frame)
