;; Common settings

;;; Global minor modes
(winner-mode)
(electric-pair-mode)
(global-visual-line-mode)

;;; Font and colors

(set-face-attribute 'font-lock-comment-face nil :slant 'italic)
(setq font-lock-maximum-decoration 2)

(use-package doom-themes
  :ensure t
  :config
  
  ;; Another good themes
  
  ;; Light
  ;; (load-theme 'doom-everforest-light t)
  ;; (load-theme 'doom-gruvbox-light t)

  (load-theme 'doom-flatwhite t)


  (defun my/theme-hook ()
    ;; Builtin keywords
    (set-face-attribute 'font-lock-builtin-face nil
			:foreground "#5b4343"
			:background "#f6cfcb"
			:inherit nil)

    ;; Function names
    (set-face-attribute 'font-lock-function-name-face nil
			:foreground "#614c61"
			:background "#f1ddf1"
			:weight 'regular
			:inherit nil)

    ;; Keywords
    (set-face-attribute 'font-lock-keyword-face nil
			:background nil)

    ;; Numbers
    (set-face-attribute 'font-lock-number-face nil
			:foreground "#465953"
			:background "#d2ebe3"))
  
  ;; (set-face-attribute 'highlight-numbers-number nil
  ;; 		      :foreground "#525643"
  ;; 		      :background "#e2e9c1")

  ;; (set-face-attribute 'highlight-numbers-number nil
  ;; 		      :foreground nil
  ;; 		      :background nil
  ;; 		      :inherit 'font-lock-constant-face)


  ;; Dark
  ;; (setq doom-everforest-background "hard")
  ;; (load-theme 'doom-everforest t)
  
  ;; (load-theme 'doom-gruvbox)
  )

(set-frame-font "FantasqueSansM Nerd Font 13")

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

;;; Fill-column indicator
;; (setq-default fill-column 80)
;; (set-face-attribute 'fill-column-indicator nil
;; 		    :foreground "grey40"
;; 		    :background nil)


;; Major mode hook
(add-hook 'window-configuration-change-hook (lambda ()
					      (my/theme-hook)
					      (run-mode-hooks (intern (format "%s-hook" major-mode)))))
