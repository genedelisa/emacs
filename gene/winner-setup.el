;;; winner-setup.el --- winner setup

;; Filename: winner-setup.el
;; Description: winner setup
;; Author: Gene De Lisa <gene@rockhoppertech.com>
;; Maintainer: Gene De Lisa <gene@rockhoppertech.com>
;; Copyright (C) 2012, Gene De Lisa, all rights reserved.
;; Created: 2012-05-05 13:21:58
;; Version: 0.1
;; Last-Updated: 2012-05-05 13:21:58
;;           By: Gene De Lisa
;; URL: http://www.emacswiki.org/emacs/download/winner-setup.el
;; Keywords: winner
;; Compatibility: GNU Emacs 24.0.96.1
;;
;; Features that might be required by this library:
;;
;; save windows and buffers
;;

;;; This file is NOT part of GNU Emacs

;;; License
;;
;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 3, or (at your option)
;; any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program; see the file COPYING.  If not, write to
;; the Free Software Foundation, Inc., 51 Franklin Street, Fifth
;; Floor, Boston, MA 02110-1301, USA.

;;; Commentary:
;;
;; winner setup
;;

;;; Installation:
;;
;; Put winner-setup.el to your load-path.
;; The load-path is usually ~/elisp/.
;; It's set in your ~/.emacs like this:
;; (add-to-list 'load-path (expand-file-name "~/elisp"))
;;
;; And the following to your ~/.emacs startup file.
;;
;; (require 'winner-setup)
;;
;; No need more.

;;; Customize:
;;
;;
;;
;; All of the above can customize by:
;;      M-x customize-group RET winner-setup RET
;;

;;; Change log:
;;	
;; 2012/05/05
;;      * First released.
;;

;;; Acknowledgements:
;;
;;
;;

;;; TODO
;;
;;
;;

;;; Require


;;; Code:

;; Useful to switch between different/previous buffer-layouts, or buffer history.

;; Winner-mode---------------------------------
;; cycle through window layouts/contents
;; winner conflicts with org, use C-c left/right instead
(when (require 'winner nil 'noerror)
  (setq winner-dont-bind-my-keys t)
  (global-set-key (kbd "<C-c left>")  'winner-undo)
  (global-set-key (kbd "<C-c right>") 'winner-redo)
  (global-set-key (kbd "<XF86Back>")    'winner-undo)
  (global-set-key (kbd "<XF86Forward>") 'winner-redo)
  (winner-mode t))
;;--------------------------------------------



(provide 'winner-setup)

;;; winner-setup.el ends here
