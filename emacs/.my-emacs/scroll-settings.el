(setq scroll-step 1)
(setq scroll-conservatively most-positive-fixnum)

(defun scroll-half-page-down ()
  (interactive)
  (scroll-down-line (/ (window-height) 2)))

(defun scroll-half-page-up ()
  (interactive)
  (scroll-up-line (/ (window-height) 2)))

(global-set-key (kbd "C-j") #'scroll-half-page-up)
(global-set-key (kbd "C-k") #'scroll-half-page-down)
(global-set-key (kbd "M-j") (lambda () (interactive) (scroll-up-line 1)))
(global-set-key (kbd "M-k") (lambda () (interactive) (scroll-down-line 1)))
