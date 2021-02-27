
;; sokol-theme.el -- Sokol Theme special for subset of lisp language

;; Author: Bohdan Sokolovksyi
;; Version: 0.0.1 beta
;; Package-Requires: ((emcas "26"))
;; URL: ---

;;; Code:
(require 'cl-lib)
(deftheme sokol)

;; Assigment form: VARIABLE COLOR [TTY-COLOR]
(let ((colors '(;; Upstream theme color
                (sokol-bg              "#131122" "#000000") ;; #5c4b9b <- #251e3e (main) #1a1831
                (sokol-current         "#1a1831")
                (sokol-fg              "#f9f4f4")
                (sokol-comment         "#47476b")
                (sokol-orange          "#ff4dd2")
                (sokol-light-green     "#6decb9")
                (sokol-light-no-green  "#66ff33")
                (sokol-pink            "#aa26da")
                (sokol-light-pink      "#fecdd7")
                (sokol-light-pink-2    "#f5587b")
                (sokol-no-blue         "#1ce393")
                (sokol-yellow          "#ffdf5a")
                (sokol-light-green-2   "#c7dc09")
                (sokol-blue            "#3e64ff")
                (sokol-light-red       "#d55252")
                (sokol-const           "#fd5f00")
                (sokol-dark-orange     "#b32100")
                (sokol-lol             "#4da7b3")
                (sokol-anti-tomato     "#f67280")
                (sokol-cyan            "#6acafc")
                (sokol-gray            "#ffb5b5")
                (sokol-type            "#aa26da")
                (sokol-doc             "#b47a64")
                (sokol-fg-2            "#b3d9ff")
                (sokol-q               "#ccffcc")
                ;; Other colors
                (bg3                   "#1d1a33")
                (bg4                   "#6461b8")
                (fg2                   "#d0e1f9")
                (fg3                   "#0189cc")))

      (faces '(;; default
               (cursor :background ,fg2)
               (default :background ,sokol-bg :foreground ,sokol-fg-2)
               (default-italic :slant italic)
               (ffap :foreground ,fg3) ;; !
               (fringe :background ,sokol-bg :foreground ,fg3)
               (highlight :foreground ,fg2 :background ,bg3)
               (hl-line :background ,sokol-current :extend t)
               (info-quoted-name :foreground ,sokol-q)
               (info-string :foreground ,sokol-yellow)
               (lazy-highlight :foreground ,fg2 :background ,bg3) ;; !
               (link :foreground ,sokol-pink :underline t) ;; !
               (linum :slant italic :foreground ,bg4 :background ,sokol-bg)
               (line-number :slant italic :foreground ,bg4 :background ,sokol-bg)
               (minibuffer-prompt :weight bold :foreground ,sokol-light-pink)
               (region :background ,sokol-comment :foreground ,sokol-bg)
               (trailing-whitespace :foreground nil :background ,sokol-anti-tomato)
               (vertical-border :foreground ,bg3)
               (warning :foreground ,sokol-anti-tomato)
               (header-line :background ,sokol-bg)
               ;; syntax
               (font-lock-builtin-face :foreground ,sokol-blue)
               (font-lock-comment-face :foreground ,sokol-comment)
               (font-lock-comment-delimiter-face :foreground ,sokol-comment)
               (font-lock-constant-face :foreground ,sokol-const)
               (font-lock-doc-face :foreground ,sokol-doc)
               (font-lock-function-name-face :foreground ,sokol-light-no-green :weight bold)
               (font-lock-keyword-face :weight bold :foreground ,sokol-orange)
               (font-lock-string-face :foreground ,sokol-yellow)
               (font-lock-negation-char-face :foreground ,sokol-const)
               (font-lock-preprocessor-face :foreground ,sokol-anti-tomato)
               (font-lock-reference-face :foreground ,sokol-blue)
               (font-lock-regexp-grouping-backslash :foreground ,sokol-pink) ;; !
               (font-lock-regexp-grouping-construct :foreground ,sokol-const) ;; !
               (font-lock-warning-face :foreground ,sokol-anti-tomato :background ,bg3)
               (font-lock-variable-name-face :foreground ,sokol-gray :weight bold)
               (font-lock-type-face :foreground ,sokol-type)

               ;; auto-complete
               (ac-completion-face :underline t :foreground ,sokol-cyan)

               ;; slime
               (slime-repl-inputed-output-face :foreground ,sokol-light-green)
               )))
    
    (apply #'custom-theme-set-faces
           'sokol
           (let ((color-names (mapcar #'car colors))
                 (graphic-colors (mapcar #'cadr colors))
                 (tty-colors (mapcar #'car (mapcar #'last colors))))
               (cl-flet* ((expand-for-tty (spec) (cl-progv color-names tty-colors
                                                     (eval `(backquote ,spec))))
                          (expand-for-graphic (spec) (cl-progv color-names graphic-colors
                                                         (eval `(backquote ,spec)))))
                   (cl-loop for (face . spec) in faces
                      collect `(,face
                                ((((min-colors 16777216))
                                  ,(expand-for-graphic spec))
                                 (t
                                  ,(expand-for-tty spec)))))))))
;; autoload
(when load-file-name
    (add-to-list 'custom-theme-load-path
                 (file-name-as-directory (file-name-directory load-file-name))))

(provide-theme 'sokol)

;;; sokol-theme.el ends here
