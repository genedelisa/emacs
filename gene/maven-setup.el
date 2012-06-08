;;; maven-setup.el --- maven setup

;; Copyright (C) 2012  Gene De Lisa

;; Author: Gene De Lisa <gene@rockhoppertech.com>
;; Keywords:

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;;

;;; Code:

(require 'compile)
(defvar mvn-command-history nil  "Maven command history variable")

(defun mvnfast()
  (interactive)
  (let ((fn (buffer-file-name)))
    (let ((dir (file-name-directory fn)))
      (while (and (not (file-exists-p (concat dir "/pom.xml")))
                  (not (equal dir (file-truename (concat dir "/..")))))
        (setq dir (file-truename (concat dir "/.."))))
      (if (not (file-exists-p (concat dir "/pom.xml")))
          (message "No pom.xml found")
        (compile (concat "mvn -f " dir "/pom.xml install -Dmaven.test.skip=true"))))))

;;(define-key java-mode-map "\C-c\C-x5" 'mvnfast)

(defun mvn(&optional args)
  "Runs maven in the current project. Starting at the directoy
where the file being visited resides, a search is made for
pom.xml recsurively. A maven command is made from the first
directory where the pom.xml file is found is then displayed in
the minibuffer. The command can be edited as needed and then
executed. Errors are navigate to as in any other compile mode"
  (interactive)
  (let ((fn (buffer-file-name)))
    (let ((dir (file-name-directory fn)))
      (while (and (not (file-exists-p (concat dir "/pom.xml")))
                  (not (equal dir (file-truename (concat dir "/..")))))
        (setq dir (file-truename (concat dir "/.."))))
      (if (not (file-exists-p (concat dir "/pom.xml")))
          (message "No pom.xml found")
        (compile (read-from-minibuffer "Command: "
                                       (concat "mvn -f "
                                               dir "/pom.xml install -Dmaven.test.skip=true")
                                       nil nil 'mvn-command-history))))))

;; String pattern for locating errors in maven output. This assumes a Windows
;; drive letter at the beginning(add-to-list 'compilation-error-regexp-alist
;; '("^\\([a-zA-Z]:.*\\):\\[\\([0-9]+\\),\\([0-9]+\\)\\]" 1 2 3))


(provide 'maven-setup)

;;; maven-setup.el ends here
