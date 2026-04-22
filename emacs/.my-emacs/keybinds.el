;; Keybindings file.

;; Some package-dependet keys may be defined in
;; use-package section wich can be found in
;; packages-settings.el file

(global-set-key (kbd "C-x k") #'kill-buffer-and-window)
(global-set-key (kbd "C-r") #'undo-fu-only-redo)
;; (global-set-key (kbd "C-c b b") #'consult-buffer)

;; Some meow-related keybinds, more in meow-settings.el
(global-set-key (kbd "C-M-z") #'undo-fu-only-undo)
(global-set-key (kbd "C-/") #'comment-line)
