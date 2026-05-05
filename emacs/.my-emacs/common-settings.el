;; Common settings

;;; Global minor modes
(winner-mode)
(electric-pair-mode)
(global-visual-line-mode)

;;; Font and colors

(use-package doom-themes
  :ensure t
  :config
  ;; Another good themes
  
  ;; Light
  ;; (load-theme 'doom-everforest-light t)
  ;; (load-theme 'doom-gruvbox-light t)
  (load-theme 'doom-flatwhite t))

(set-frame-font "FantasqueSansM Nerd Font 13")
(set-face-attribute 'font-lock-comment-face nil :slant 'italic)

(setq-default line-spacing 0)

;; Еще несколько неплохих вариантов
;; (set-frame-font "Agave Nerd Font 14")
;; (set-frame-font "Mononoki Nerd Font 13")
;; (set-frame-font "Miracode 12")
;; (set-frame-font "Monaco 13")
;; (set-frame-font "Terminess Nerd Font 14")
;; (set-frame-font "ComicShannsMono Nerd Font 14")
;; (set-frame-font "ProFont 16")
;; (set-frame-font "Indicate Mono 14") ;; Нет поддержки русского языка

;;; Line numbers
(global-display-line-numbers-mode)
(setq-default display-line-numbers-type 'relative)
(setq-default display-line-numbers-width 4)

;;; Disable unnecessary UI elements
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(show-paren-mode -1)

;; Disable backup files
(setq make-backup-files nil)

;; Garbage collector (100 MB)
(setq gc-cons-threshold (* 100 1024 1024))


;;; Indentaion
(setq-default tab-width 8)
(setq sgml-basic-offset 8)
(setq c-basic-offset tab-width)
(setq js-indent-level tab-width)


;; Scrolling
(pixel-scroll-precision-mode 1)
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1))) ; one line at a time
(setq mouse-wheel-progressive-speed nil)            ; don't accelerate scrolling


;; Disable line numbers with large files
(defun disable-line-numbers-if-large-file ()
  "Disable line numbers if the buffer has more than 1000 lines."
  (when (> (count-lines (point-min) (point-max)) 1000)
    (display-line-numbers-mode 0)))

(add-hook 'find-file-hook #'disable-line-numbers-if-large-file)
