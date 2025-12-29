(setq meow-default-leader-keys
      ;; Use SPC (0-9) for digit arguments.
      '(("1" . meow-digit-argument)
	("2" . meow-digit-argument)
	("3" . meow-digit-argument)
	("4" . meow-digit-argument)
	("5" . meow-digit-argument)
	("6" . meow-digit-argument)
	("7" . meow-digit-argument)
	("8" . meow-digit-argument)
	("9" . meow-digit-argument)
	("0" . meow-digit-argument)
	("/" . meow-keypad-describe-key)
	("?" . meow-cheatsheet)
	
	;; Some custom keys

	;; Windows managment
	("w w" . other-window)
	("w h" . windmove-left)
	("w j" . windmove-down)
	("w k" . windmove-up)
	("w l" . windmove-right)
	("w v" . split-window-right)
	("w s" . split-window-below)
	("w m" . delete-other-windows)
	("w c" . delete-window)
	("w u" . winner-undo)
	("w r" . winner-redo)
	
	;; Perspective keys
	("TAB s" . persp-switch)
	("TAB [" . persp-prev)
	("TAB ]" . persp-next)
	("TAB r" . persp-rename)
	("TAB d" . (lambda () (interactive) (persp-kill (persp-name (persp-curr)))))
	("TAB t" . persp-switch-to-scratch-buffer)


	("s s" . avy-goto-char-timer)
	("."   . find-file)
	("b k" . kill-buffer-and-window)
	("b i" . ibuffer)
	("b b" . consult-buffer)
	
	;; Open things
	("o /" . dirvish)
	("o s" . (lambda ()
		   (interactive)
		   (split-window-right)
		   (other-window 1)
		   (persp-switch-to-scratch-buffer)))
        
	;; Projectile keys
	("p p" . projectile-switch-project)
	("p a" . projectile-add-known-project)
	("p s" . consult-ripgrep)
	("p c" . projectile-compile-project)
	("p r" . projectile-run-project)
	("SPC" . projectile-find-file)

	;; Magit keys (version control system)
	("v v" . magit-status)
	("v l" . magit-log-buffer-file)
	("v b" . magit-branch-checkout)
	("v B" . magit-blame-addition)

	;; Tempel keys
	("t i" . tempel-insert)))

(setq meow-local-leader-org-keys '(("n d s" . org-schedule)))

(setq meow-local-leader-geiser-keys '(("n e b" . geiser-eval-buffer)
				      ("n e e" . geiser-eval-last-sexp)
				      ("n e r" . geiser-eval-region)
				      ("n '" . geiser-repl-switch)))

(defun meow-leader-change-keymap (keymap)
  (let ((new-keymap (append meow-default-leader-keys keymap)))
    (setf (alist-get 'leader meow-keymap-alist) (make-sparse-keymap))
    (apply #'meow-leader-define-key new-keymap)))

;; Dirvish keymap --------------------------------------------------------------

(setq meow-dired-keymap (make-keymap))
(meow-define-state dir
  "meow state for moving in dired"
  :lighter " [D]"
  :keymap meow-dired-keymap)

(setq meow-cursor-type-dir 'box)

(meow-define-keys 'dir
  '("h" . dired-up-directory)
  '("j" . meow-next)
  '("k" . meow-prev)
  '("l" . dired-find-file)
  '("TAB" . dirvish-subtree-toggle)
  '("F" . dirvish-layout-toggle)
  '("n" . consult-focus-lines)
  '("b" . dirvish-quick-access))

(add-to-list 'meow-mode-state-list '(dired-mode . dir))


;; Org-agenda keymap -----------------------------------------------------------

(setq meow-agenda-keymap (make-keymap))
(meow-define-state agenda
  "meow state fro org-agenda"
  :lighter " [A]"
  :keymap meow-agenda-keymap)

(setq meow-cursor-type-agenda "box")

(meow-define-keys 'agenda
  '("j" . meow-next)
  '("k" . meow-prev)
  '("]" . org-agenda-later)
  '("[" . org-agenda-earlier)
  '("SPC d s" . org-agenda-schedule)
  '("SPC t" . org-agenda-todo))

(add-to-list 'meow-mode-state-list '(org-agenda-mode . agenda))

;; Default settings ------------------------------------------------------------

(defun meow-setup ()
  (setq meow-cheatsheet-layout meow-cheatsheet-layout-qwerty)
  
  (meow-motion-define-key
   '("j" . meow-next)
   '("k" . meow-prev)
   '("<escape>" . ignore))
  
  (apply #'meow-leader-define-key meow-default-leader-keys)
  
  (meow-normal-define-key
   '("0" . meow-expand-0)
   '("9" . meow-expand-9)
   '("8" . meow-expand-8)
   '("7" . meow-expand-7)
   '("6" . meow-expand-6)
   '("5" . meow-expand-5)
   '("4" . meow-expand-4)
   '("3" . meow-expand-3)
   '("2" . meow-expand-2)
   '("1" . meow-expand-1)
   '("-" . negative-argument)
   '(";" . meow-reverse)
   '("," . meow-inner-of-thing)
   '("." . meow-bounds-of-thing)
   '("[" . meow-beginning-of-thing)
   '("]" . meow-end-of-thing)
   '("a" . meow-append)
   '("A" . meow-open-below)
   '("b" . meow-back-word)
   '("B" . meow-back-symbol)
   '("c" . meow-change)
   '("d" . meow-delete)
   '("D" . meow-backward-delete)
   '("e" . meow-next-word)
   '("E" . meow-next-symbol)
   '("f" . meow-find)
   '("g" . meow-cancel-selection)
   '("G" . meow-grab)
   '("h" . meow-left)
   '("H" . meow-left-expand)
   '("i" . meow-insert)
   '("I" . meow-open-above)
   '("j" . meow-next)
   '("J" . meow-next-expand)
   '("k" . meow-prev)
   '("K" . meow-prev-expand)
   '("l" . meow-right)
   '("L" . meow-right-expand)
   '("m" . meow-join)
   '("n" . meow-search)
   '("o" . meow-block)
   '("O" . meow-to-block)
   '("p" . meow-yank)
   '("P" . consult-yank-from-kill-ring)
   '("q" . meow-quit)
   '("Q" . meow-goto-line)
   '("r" . meow-replace)
   '("R" . meow-swap-grab)
   '("s" . meow-kill)
   '("t" . meow-till)
   '("u" . meow-undo)
   '("U" . meow-undo-in-selection)
   '("v" . meow-visit)
   '("w" . meow-mark-word)
   '("W" . meow-mark-symbol)
   '("x" . meow-line)
   '("X" . meow-goto-line)
   '("y" . meow-save)
   '("Y" . meow-sync-grab)
   '("z" . meow-pop-selection)
   '("'" . repeat)
   '("=" . indent-region)
   '("<escape>" . ignore)))

(use-package meow
  :ensure
  :hook ((org-mode . (lambda () (meow-leader-change-keymap meow-local-leader-org-keys)))
	 (geiser-mode . (lambda () (meow-leader-change-keymap meow-local-leader-geiser-keys))))
  :config
  (meow-setup)
  (meow-global-mode 1)
  (setf meow-expand-hint-remove-delay 2)
  (setq meow-use-clipboard t)
  (setq meow-expand-hint-counts '((word . 10)
				  (line . 10)
				  (block . 10)
				  (find . 10)
				  (till . 10)))
  (setq meow--kbd-undo "C-M-z")
  (global-set-key (kbd "C-o") 'meow-pop-to-mark))
