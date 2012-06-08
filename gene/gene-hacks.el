;; -*- coding: latin-1; mode: Emacs-Lisp; mode: auto-fill; -*-
;;
;; $ID$
;; Time-stamp: "Sat July 06, 2002 12:50:05 No one@PENGUIN gene-hacks.el"
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defvar quoted-string-regexp "[\\(a-zA-Z0-9 \t]*\\(\".*\"\\)"
  "Regular expression matching anything inside double quotes. Users need to
   access subexpression 1")


(defvar assignment-noprespace-regexp "[^ ]\\(=\\)"
  "Regular expression matching = not preceeded by a space. Users need to
   access subexpression 1")

;  (re-search-forward "[\\(a-zA-Z0-9 \t]*\\(\"[:!@#$%^&*-= ()\\a-zA-Z0-9]*\"\\)")
;  (re-search-forward "[\\(a-zA-Z0-9 \t]*\\(\"[\000-\377]*\"\\)")
;  (re-search-forward "[\\(a-zA-Z0-9 \t]*\\(\".*\"\\)")
;  (re-search-forward quoted-string-regexp)
;  (re-search-forward "\\(=\\)")
;;  (re-search-forward "[^ ]\\(=\\)\\|\\(=\\)[^ ]")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun test-re ()
  (interactive )
;; symbol constituent is \s_
  (re-search-forward "\\(\\S-\\)\\([=]\\)+\\(\\S-\\)")
;;  (re-search-forward "[^ ]\\(=\\)\\([^ ]\\)")
  (set-mark (match-beginning 0 ) )
  )

;;         int wh = 8;
;;         int wh=8;
;;         int wh =8;
;;         int wh= 8;

;;(perform-replace "=" " = " t nil nil)

;; doesn't work yet. howto match just the =?
(defun add-eq-space ()
  (interactive )
  (save-excursion
    (save-restriction
      (widen)
      (goto-char (point-min))
      (while (re-search-forward
              "\\S-\\(=\\)\\S-"
              nil t)
        (replace-match "\\1" nil nil " \\1 " )
        )
      ))
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun find-long-line ()
"Search forward for the next line longer than 80 cols. If none, leave point unchanged."
(interactive)
;;
;; Search forward until we are at end of file, or
;; we find a line longer than 80 cols
;;
(let ((bad-pos
       (save-excursion
         ;;
         ;; If we are at end-of-line already, go forward one first
         ;;
         (if (= (point) (save-excursion (end-of-line) (point)))
             (forward-line 1))
         (while (and (< (current-column) 80)
                     (< (point) (point-max)))
           (forward-line 1)
           (end-of-line))
         (if (>= (current-column) 80)
             (point))))
      )
  (if bad-pos
      (progn
        (goto-char bad-pos)
        (message "Line %d has %d columns" (count-lines 1 (point))
                 (current-column))
        t)
    ;;else
    (message "No lines >80 chars after point")
    nil)
  ))

(defun find-long-string()
  (interactive )
  (re-search-forward quoted-string-regexp)
  (set-mark (match-beginning 1 ) )
  (if (> (current-column) 80)
      (progn
        (message (concat "too long: " (int-to-string (current-column)) ))
        (foo)
        )
    (message "ok") )
  )

(defun foo(b e)
  (interactive "r")
;  (message (concat (int-to-string e) (int-to-string e) ))
  (move-to-column 80)
  (backward-word 1)
  )
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun mydirs ()
  "just dired some dirs"
  (interactive )
  (dired "c:\\patterns-course")
  (dired "c:\\jsp-course")
  (dired "c:\\ejb-course")
  (dired "e:\\rti\\src")
  (dired "~")
  )


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; this is for people who write code with 500 character lines.
; might have to run this several times
(defun trim-cols ()
  "insert a newline if lines are too long"
  (interactive )
  (save-excursion
    (goto-char (point-min))
    (while (not (eobp))
      (progn
        (forward-line 1)
        (end-of-line 1)
                                        ;	(message  "%d" (current-column))
        (if (> (current-column) 80)
            (progn
              (message  "%d is too big!" (current-column))
                                        ;(backward-word 1)
              (search-backward " ")
              (newline-and-indent)
              )
          )
        )
      )
    )
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun match-paren (arg)
  "Go to the matching parenthesis if on parenthesis otherwise insert %."
  (interactive "p")
  (cond ((looking-at "\\s\(") (forward-list 1) (backward-char 1))
	((looking-at "\\s\)") (forward-char 1) (backward-list 1))
	(t (self-insert-command (or arg 1)))))
(global-set-key "%" 'match-paren)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; delete blank lines from end of file
;; and make newlines butt up to preceding text.
(defun trim-write-hook ()
 (save-excursion
  (save-restriction
   (widen)
   (goto-char (point-max))
   (delete-blank-lines)
   (goto-char (point-min))
   (replace-regexp "  *$" ""))) nil)

;; function executes when file is written out.
(add-hook 'write-file-hooks  'trim-write-hook)
; from checkstyle:
;Binary operators are separated from operands by spaces. For example x = y + 1;
;Unary operators are not separated by spaces. For example x = --y + z++;
;The keywords if/for/while/do/catch/synchronized/return are surrounded by spaces.
;Casts and commas (',') are followed by whitespace.
;Periods ('.') are not surrounded by whitespace.
;Correct padding of parenthesises ()'s.


;; find keywords followed by spaces and remove the spaces
(defun remove-keywords-space ()
  (interactive )
  (save-excursion
    (save-restriction
      (widen)
      (goto-char (point-min))
      (while (re-search-forward
              "\\(if\\|for\\|while\\|do\\|catch\\|synchronized\\|return\\)[ \t]*\("
              nil t)
        (replace-match "\\1(" )
        )
      ))
  )


(defun add-keywords-space ()
  (interactive )
  (save-excursion
    (save-restriction
      (widen)
      (goto-char (point-min))
      (while (re-search-forward
              "\\(if\\|for\\|while\\|do\\|catch\\|synchronized\\|return\\)\("
              nil t)
        (replace-match "\\1 (" )
        )
      ))
  )

(defun add-binop-space ()
  (interactive )
  (save-excursion
    (save-restriction
      (widen)
      (goto-char (point-min))
      (while (re-search-forward
              "\\(=\\|+\\|-\\|==\\|%\\|+=\\|-=\\)[^ ]"
              nil t)
        (replace-match " \\1 " )
        )
      ))
  )

;; turn foo() to foo () and if(x) to if (x) but ignoring foo ()
;; (already spaced)
(defun add-paren-space ()
  (interactive )
  (save-excursion
    (save-restriction
      (widen)
      (goto-char (point-min))
      (while (re-search-forward "\\([^ \t][a-zA-Z0-9]*\\)(" nil t)
        ; \\ the \\1 means first subexpression
        (replace-match "\\1 (" )
        )
      ))
  )

(defun remove-paren-space ()
  (interactive )
  (save-excursion
    (save-restriction
      (widen)
      (goto-char (point-min))
      (while (re-search-forward "\\([^ \t][a-zA-Z0-9]*\\)[ \t]*\(" nil t)
        (replace-match "\\1(")
        )
      ))
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; XML responses from servers are sometimes one big string
;; This will insert newlines on > boundaries. Not perfect but ok
(defun xmlspace ()
  "When you get a raw response, you might like to respace it"
  (interactive )
  (save-excursion
    (goto-char (point-min))
    (while (re-search-forward "</" nil t)
      (replace-match "\n</")
      )

    (goto-char (point-min))
    (while (re-search-forward ">" nil t)
      (replace-match ">\n")
      )


    (indent-region (point-min) (point-max) nil)
    )
  )

;; if you do this: (insert (prin1-to-string (x-list-fonts "*")))
;; you might want to have one font per line
(defun string-breakspace ()
  "When you "
  (interactive )
  (save-excursion
    (goto-char (point-min))
    (while (re-search-forward "\" \"" nil t)
      (replace-match "\"\n \"")
      )
    (indent-region (point-min) (point-max) nil)
    )
  )

;; so you can copy instance vars into the ctor
(defun swapdef ()
  "turn Type foo into foo = new Type();"
  (interactive )
  (save-excursion
    ;; first word on line
    (back-to-indentation)
    (forward-word 1)
    (transpose-words 1)
    (insert "();")
    (backward-word 1)
    (insert " = new ")
    )
  )
;; test it here
;;  Type foo

;; Something like this:
;; class Junk {
;;    private int foo;
;;    private String name;
;;    Junk() {
;;       // paste in your instance vars and swapdef
;;    }


(defun clear-ws-eol (start end)
  "Clear trailing white space from ends of lines in REGION."
  (interactive "*r")
  (save-excursion
    (goto-char start)
    (beginning-of-line 1)
    (setq start (point))
    (goto-char end)
    (end-of-line 1)
    (setq end (point))
    (save-restriction
      (narrow-to-region start end)
      (goto-char (point-min))
      (while (re-search-forward "\\s +$" nil t)
        (replace-match "")))))



;; Jump to beginning of the next line if possible.
(defun beginning-of-next-line()
  "Moves cursor to the beginning of the next line, or nowhere if at
end of the buffer"
  (interactive)
  (end-of-line)
  (if (not (eobp))
      (forward-char 1)))


;; Will align c/c++ variable declarations in the selected region
;; Example:
;; int a;
;; const QString b;
;; static unsigned int c;
;;
;; will become:
;; int                 a;
;; const QString       b;
;; static unsigned int c;
;; (defun align-vars(beg end)
;;   "Aligns c/c++ variable declaration names on the same column, with beginning and end taken from selected region."
;;   (interactive "r")
;;   (save-excursion
;;     (let (bol eol expr-end
;;           (max-col 0) col
;;           poslist curpos)
;;       (goto-char end)
;;       (if (not (bolp))
;;           (setq end (line-end-position)))
;;       (goto-char beg)
;;       (while (and (> end (point)) (not (eobp)))
;;         (setq bol (line-beginning-position))
;;         (setq eol (line-end-position))
;;         (beginning-of-line)
;;         (setq expr-end (point))
;;         (if (search-forward-regexp "^[^/][^/]\\([a-zA-Z][a-zA-Z]*\\)[ \t]+[^;]" eol t)
;;             (let ()
;;               (setq expr-end (match-end 1))
;;               (while (search-forward-regexp "\\([a-zA-Z][a-zA-Z]*\\)[ \t]+[^;]" eol t)
;;                 (setq expr-end (match-end 1)))
;;               (goto-char expr-end)
;;               (setq col (current-column))
;;               (if (search-forward-regexp (concat "\\(\\*\\|&[ \t]*\\)?"
;;                                                  "\\([a-zA-Z\\_][a-zA-Z0-9\\_]*\\)\\([\[][0-9]+[\]]\\)?"
;;                                                  "\\([ \t]*,[ \t]*\\([a-zA-Z\\_][a-zA-Z0-9\\_]*\\)\\([\[][0-9]+[\]]\\)?\\)*"
;;                                                  "[ \t]*;$") eol t)
;;                   (let ((name-col-end 0))
;;                     (if (eq (match-beginning 2) (match-beginning 0))
;;                         (setq name-col-end 1))
;;                     (setq poslist (cons (list expr-end col (match-beginning 0) name-col-end) poslist))
;;                     (if (> col max-col)
;;                         (setq max-col col))
;;                     (beginning-of-next-line))
;;                 (beginning-of-next-line)))
;;           (beginning-of-next-line)))
;;       (setq curpos poslist)
;;       (while curpos
;;         (let* ((pos (car curpos))
;;                (col (car (cdr pos)))
;;                (col-end (car (cdr (cdr pos))))
;;                (col-end-name (car (cdr (cdr (cdr pos)))))
;;                (abs-pos (car pos)))
;;           (goto-char abs-pos)
;;           (delete-region abs-pos col-end)
;;           (insert-string (make-string (+ (+ (- max-col col) 1) col-end-name) 32)))
;;         (setq curpos (cdr curpos))))))

  (require 'align)

;; ;; Aligns all variable declarations in this buffer
;; (defun align-vars-buffer()
;;   "Aligns c/c++ variable declaration names on the same column in this buffer."
;;   (interactive)
;;   (save-excursion
;;     (let (beg end)
;;       (beginning-of-buffer)
;;       (setq beg (point))
;;       (end-of-buffer)
;;       (setq end (point))
;;       (align-vars beg end))))




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(global-set-key '[f12] 'gene-reformat)
(defun gene-reformat ()
  "Format code the way it should be. :)"
  (interactive )
  ; convert tabs to spaces
  (untabify  (point-min) (point-max))
  ; convert big blocks of space to one space
  (canonically-space-region (point-min) (point-max))
  ; you know
  (fixbraces)
  ; in newer cc-modes
  ;(compact-empty-funcall)
  ; reindent according to the current style
  (indent-region (point-min) (point-max) nil)

  )

(defun fixbraces ()
  "Fix braces to the one true style as in BSD unix. Use this to fix
java code written by VB idiots."
  (interactive)
  (save-excursion
    (goto-char (point-min))
    (while (re-search-forward "^[ \t\n]*{" nil t)
      (goto-char (match-beginning 0))
      (forward-char)
      (delete-indentation)
      (forward-char)
      )
    )

  (save-excursion
    (goto-char (point-min))
    (while (re-search-forward "^[ \t\n]*catch" nil t)
      (goto-char (match-beginning 0))
      (forward-char)
      (delete-indentation)
      (forward-char)
      )
    )
  )
(defun comma ()
  "If you have this: a,b,c,d then put them on separate lines"
  (interactive)
  (save-excursion
    (goto-char (point-min))
    (while (re-search-forward "," nil t)
      (goto-char (match-beginning 0))
      (forward-char)
      (insert-string "\n")
      (forward-char)
      )
    )
  )
