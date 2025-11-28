;; Common settings

;;; Global minor modes
(winner-mode)
(electric-pair-mode)
(global-hl-line-mode)

;;; Font and colors

(set-face-attribute 'font-lock-comment-face nil :slant 'italic)
(setq font-lock-maximum-decoration 2)

(use-package doom-themes
  :ensure t
  :config)

(setq doom-everforest-background "hard")
(load-theme 'doom-everforest t)

(set-frame-font "Mononoki Nerd Font 16")
(setq-default line-spacing 0)

;; Еще несколько неплохих вариантов
;; (set-frame-font "Miracode 14")
;; (set-frame-font "Monaco 16")
;; (set-frame-font "Agave Nerd Font 16")
;; (set-frame-font "Terminess Nerd Font 20")
;; (set-frame-font "ComicShannsMono Nerd Font 16")

;;; Line numbers
(global-display-line-numbers-mode)
(setq-default display-line-numbers-type 'relative)
(setq-default display-line-numbers-width 4)

;;; Disable unnecessary UI elements
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

;; Disable backup files
(setq make-backup-files nil)

;;; Indentaion
(setq-default tab-width 8)
(setq c-basic-offset tab-width)
(setq js-indent-level tab-width)

;;; Fill-column indicator
(setq fill-column 80)
(setq display-fill-column-indicator "#")
;; (set-face-attribute 'fill-column-indicator nil :foreground nil :background nil)


