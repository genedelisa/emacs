;;; gene-midnight-theme.el
;;
;; Gene's Midnight Color Theme for Emacs 24
;;
;; Copyright (C) 2011 Gene De Lisa
;;
;; Author: Gene De Lisa <gene@rockhoppertech.com>
;; URL: https://github.com/
;; Version: 0.0.5
;;
;; Status: In progress
;;
;; Hints
;; M-x list-faces-display

(unless (>= 24 emacs-major-version)
  (error "gene-midnight-theme requires Emacs 24 or later."))

(deftheme gene-midnight
  "Gene's midnight color theme")

(let ((gene-blue "#89BDFF")
      (gene-fg "Wheat")
      (gene-bg "Black")
      )

  (custom-theme-set-faces
   'gene-midnight

   '(default ((t (:stipple nil :background "MidnightBlue" :foreground
                           "gold2" :inverse-video nil :box nil
                           :strike-through nil :overline nil
                           :underline nil :slant normal :weight
                           normal :height 140 :width normal :family
                           "Monaco"))))

   '(fixed-pitch ((t (:family "courier"))))
   '(variable-pitch ((t (:family "helv"))))

   '(bold ((t (:weight bold))))
   '(bold-italic ((t (:slant italic :weight bold))))
   '(italic ((t (:italic t :slant italic))))
   '(underline ((t (:underline t))))

   ;; font lock
   '(font-lock-builtin-face ((t (:foreground "Violet"))))
   '(font-lock-comment-face ((t (:foreground "Coral"))))
   '(font-lock-comment-delimiter-face ((t (:foreground "green"))))
   '(font-lock-constant-face ((t (:foreground "Aquamarine"))))
   '(font-lock-doc-face ((t (:foreground "LimeGreen"))))
   '(font-lock-doc-string-face ((t (:foreground "green2"))))
   '(font-lock-function-name-face ((t (:foreground "SteelBlue"))))
   '(font-lock-keyword-face ((t (:foreground "aquamarine"))))
   '(font-lock-preprocessor-face ((t (:foreground "CornFlowerBlue" :slant normal))))
   '(font-lock-string-face ((t (:foreground "LimeGreen"))))
   '(font-lock-type-face ((t (:foreground "#9290ff"))))
   '(font-lock-variable-name-face ((t (:foreground "Khaki"))))
   '(font-lock-warning-face ((t (:bold t :foreground "Pink" :weight bold))))
   '(font-lock-negation-char-face ((t (:inherit 'default))))
   '(font-lock-pseudo-keyword-face ((t (:inherit 'default))))
   '(font-lock-operator-face ((t (:inherit 'default))))
   '(font-lock-regexp-grouping-backslash ((t (:foreground "Khaki"))))
   '(font-lock-regexp-grouping-construct ((t (:foreground "Khaki"))))
   '(font-lock-trailing-ws-face ((t (:background "#000000008000"))))


   '(border ((t (:background "DarkSlateBlue"))))
   '(cursor ((t (:background "Wheat"))))
   '(fringe ((t (:background "grey10"))))
   '(header-line ((t (:background "grey20" :foreground "grey90" :box nil))))
   '(highlight ((t (:background "darkseagreen2" :foreground "black"))))

   '(list-mode-item-selected ((t (:background "gray68"))))
   '(menu ((t (nil))))

   ;; mode line
   '(mode-line ((t (:foreground "light gray" :background "dark slate blue" :inverse-video nil
                                :box (:line-width 2 :style released-button)))))
   '(mode-line-inactive ((t (:foreground "light gray" :background "gray30"
                                         :inverse-video nil :box (:line-width 2 :style released-button)))))
   '(mode-line-emphasis ((t (:bold t :weight bold))))
   '(mode-line-highlight ((t (:foreground "black" :background "light sky blue"
                                          :inverse-video nil :box (:line-width 2 :style released-button)))))
   '(modeline-buffer-id ((t (:foreground "khaki" :background "dark slate blue" :inverse-video nil
                                         :box (:line-width 2 :style released-button)))))

   '(modeline-mousable ((t (:foreground "khaki" :background "dark slate blue" :inverse-video nil
                                        :box (:line-width 2 :style released-button)))))
   '(modeline-mousable-minor-mode ((t (:foreground "khaki" :background "dark slate blue"
                                                   :inverse-video nil
                                                   :box (:line-width 2 :style released-button)))))


   '(mouse ((t (:background "Wheat"))))
   '(paren-match ((t (:background "darkseagreen4"))))
   '(region ((t (:background "MediumSlateBlue" :foreground "White"))))
   '(scroll-bar ((t (nil))))
   '(secondary-selection ((t (:background "SkyBlue4"))))

   `(minibuffer-prompt ((t (:foreground "yellow") :background "black")))

   ;; highlight
;;   '(highlight-current-line ((t (:foreground "MidnightBlue" :background "gold2"))))

   ;; hightlight the current line
;;   '(hl-line ((t (:foreground "MidnightBlue" :background "gold2"))))
   '(hl-line ((t (:inherit nil :background "grey10"))))

   ;; comint
   '(comint-highlight-input ((t (:bold t :weight bold))))
   '(comint-highlight-prompt ((t (:foreground "cyan"))))

   ;; eshell
   '(eshell-prompt ((t (:inherit 'default))))
   '(eshell-ls-archive ((t (:foreground "red" :weight bold))))
   '(eshell-ls-directory ((t (:foreground "blue" :weight bold))))
   '(eshell-ls-symlink ((t (:foreground "cyan" :weight bold))))
   '(eshell-ls-archive-face ((t (:foreground "indian red"))))
   '(eshell-ls-backup ((t (:foreground "LightSteelBlue4"))))
   '(eshell-ls-clutter ((t (:background "indian red" :foreground "green"))))
   '(eshell-ls-executable ((t (:foreground "medium sea green"))))
   '(eshell-ls-missing ((t (:background "indian red" :foreground "green" :bold t))))
   '(eshell-ls-product ((t (:background "dark red" :foreground "green" :bold t))))
   '(eshell-ls-readonly ((t (:background "dark red" :foreground "green" :bold t))))
   '(eshell-ls-special ((t (:foreground "pale violet red"))))
   '(eshell-ls-unreadable ((t (:background "indian red" :foreground "green" :bold t))))

   ;; isearch
   '(isearch ((t (:background "paleturquoise" :foreground "black"))))
   `(isearch-fail ((t (:foreground "Wheat" :background "Black"))))
   '(isearch-lazy-highlight-face ((t (:background "paleturquoise4"))))

   ;; jde
   '(jde-bug-breakpoint-cursor ((t (:background "brown" :foreground "cyan"))))
   '(jde-bug-breakpoint-marker ((t (:background "yellow" :foreground "red"))))
   '(jde-java-font-lock-api-face ((t (:foreground "chartreuse1"))))
   '(jde-java-font-lock-bold-face ((t (:foreground "white"))))
   '(jde-java-font-lock-bold-face ((t (:foreground "white" :weight
                                                   bold))))
   '(jde-java-font-lock-code-face ((t (:foreground "salmon1"))))

   '(jde-java-font-lock-constant-face ((t (:foreground "green"))))
   '(jde-java-font-lock-doc-tag-face ((t (:foreground "khaki"))))
   '(jde-java-font-lock-italic-face ((t (:foreground "OliveDrab1"
                                                     :slant
                                                     italic))))
   '(jde-java-font-lock-link-face ((t (:foreground "plum3" :underline t))))
   '(jde-java-font-lock-modifier-face ((t (:foreground "yellow"))))
   '(jde-java-font-lock-number-face ((t (:foreground "deep pink"))))
   '(jde-java-font-lock-package-face ((t (:foreground "red"))))
   '(jde-java-font-lock-pre-face ((t (:foreground "orchid"))))
   '(jde-java-font-lock-underline-face ((t (:foreground "white" :underline t))))

   ;; rainbow-delimiters
   '(rainbow-delimiters-depth-1-face ((t (:foreground "cyan"))))
   '(rainbow-delimiters-depth-2-face ((t (:foreground "yellow" ))))
   '(rainbow-delimiters-depth-3-face ((t (:foreground "blue"))))
   '(rainbow-delimiters-depth-4-face ((t (:foreground "red"))))
   '(rainbow-delimiters-depth-5-face ((t (:foreground "green"))))
   '(rainbow-delimiters-depth-6-face ((t (:foreground "white"))))
   '(rainbow-delimiters-depth-7-face ((t (:foreground "orange"))))
   '(rainbow-delimiters-depth-8-face ((t (:foreground "magenta"))))
   '(rainbow-delimiters-depth-9-face ((t (:foreground "yellow"))))

   ;; tabbar
   '(tabbar-selected ((t (:background "grey90" :foreground "black"))))
   '(tabbar-unselected ((t (:background "grey10" :foreground "grey90"))))

   ;; compilation
   '(compilation-warning-face ((t (:background "indian red" :foreground "green"))))
   '(compilation-warning ((t (:background "indian red" :foreground "green"))))
   '(compilation-info-face ((t (:foreground "dark orchid"))))
   '(compilation-info ((t (:foreground "dark orchid"))))
   '(compilation-error-face ((t (:foreground "dark orchid"))))
   '(compilation-error ((t (:foreground "dark orchid"))))


   ;; dired
   '(dired-symlink ((t (:background "red" :foreground "black"))))
   ;; '(dired-directory ((t (:background "black" :foreground "blue"))))
   ;; '(dired-flagged ((t (:background "black" :foreground "blue"))))
   ;; '(dired-header ((t (:background "black" :foreground "blue"))))
   ;; '(dired-ignored ((t (:background "black" :foreground "blue"))))
   ;; '(dired-mark ((t (:background "black" :foreground "blue"))))
   ;; '(dired-marked ((t (:background "black" :foreground "blue"))))
   ;; '(dired-perm-write ((t (:background "black" :foreground "blue"))))
   ;; '(dired-warning ((t (:background "black" :foreground "blue"))))

   ;; magit
   '(magit-section-title ((t (:background "yellow" :foreground "black" ))))
   '(magit-item-highlight ((t (:foreground "blue"))))

   ;; show-paren
   '(show-paren-match-face ((t (:background "yellow" :foreground "black"))))
   '(show-paren-mismatch-face ((t (:background "red" :foreground "white"))))

   ;; speedbar
   '(speedbar-button-face ((t (:foreground "green3"))))
   '(speedbar-directory-face ((t (:foreground "light blue"))))
   '(speedbar-file-face ((t (:foreground "cyan"))))
   '(speedbar-highlight-face ((t (:background "sea green"))))
   '(speedbar-selected-face ((t (:foreground "red" :underline t))))
   '(speedbar-tag-face ((t (:foreground "yellow"))))

   ;; slime
   '(slime-error-face ((t (:underline t :background "red" :foreground "Yellow"))))
   '(slime-note-face ((t (:background "Brown" :foreground "Yellow"))))
   '(slime-style-warning-face ((t (:background "Brown" :foreground "Yellow"))))
   '(slime-inspector-topline-face ((t (:background "gray30" :foreground "green"))))
   '(slime-inspector-label-face ((t (:bold t :weight bold :foreground "#660066"))))
   '(slime-inspector-value-face ((t (:foreground "light pink"))))
   '(slime-inspector-action-face ((t (:bold t :weight bold :foreground "Red1"))))
   '(slime-inspector-type-face ((t (:foreground "ForestGreen"))))
   '(slime-highlight-edits-face ((t (:background "lightgray"))))
   '(slime-highlight-face ((t (:background "darkseagreen2" :underline nil))))
   '(slime-reader-conditional-face ((t (:italic t :slant italic :foreground "#009933"))))
   '(slime-repl-inputted-output-face ((t (:background "Brown" :foreground "Yellow"))))
   '(slime-repl-input-face ((t (:bold t :weight bold))))
   '(slime-repl-inputed-output-face ((t (:foreground "Red"))))
   '(slime-repl-output-face ((t (:foreground "#990099"))))
   '(slime-repl-output-mouseover-face ((t (:foreground "Red"
                                                       :box (:line-width 1 :color "black" :style released-button)))))
   '(slime-repl-prompt-face ((t (:bold t :weight bold :foreground "#cc3300"))))
   '(slime-repl-result-face ((t (nil))))
   '(slime-warning-face ((t (:underline t "orange"))))

   ;; clojure
   '(clojure-test-failure-face ((t (:background "red" :foreground "white"))))
   '(clojure-test-error-face ((t (:background "orange4"))))
   '(clojure-test-success-face ((t (:background "green" :foreground "black"))))


   '(tool-bar ((t (:background "grey75" :foreground "black" :box
                               (:line-width 1 :style
                                            released-button)))))

   '(hover-highlight ((t (:underline t :foreground "#f8f893"))))
   '(trailing-whitespace ((t (:background "red"))))

   ;; widgets
   '(widget-button-face ((t (:bold t :background "gray60" :foreground
                                   "black" :weight bold))))

   '(widget-button-pressed-face ((t (:foreground "red"))))
   '(widget-documentation-face ((t (:foreground "lime green"))))
   '(widget-field-face ((t (:background "Brown" :foreground "Yellow"))))
   '(widget-inactive-face ((t (:foreground "light gray"))))
   '(widget-single-line-field-face ((t (:background "dim gray"))))

   ;; ido
   `(ido-first-match ((t (:foreground "purple"))))
   `(ido-only-match ((t (:foreground "green"))))
   `(ido-subdir ((t (:foreground "blue"))))

   ))

;;;###autoload
(when load-file-name
  (add-to-list 'custom-theme-load-path
               (file-name-as-directory (file-name-directory load-file-name))))

(provide-theme 'gene-midnight)

;; Local Variables:
;; no-byte-compile: t
;; End:

;;; gene-midnight-theme.el ends here
