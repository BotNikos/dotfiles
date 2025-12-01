(setq org-directory "~/org")

;; Agenda-files 
(setq org-agenda-files '("~/org/" "~/org/work/" "~/org/daily/" "~/org/dnd/" ))
(setq org-agenda-files (append org-agenda-files (directory-files-recursively "~/org/study/" "\\.org$")))
(setq org-agenda-files (append org-agenda-files (directory-files-recursively "~/org/todo/" "\\.org$")))

(setq org-agenda-span 'day)

(setq org-todo-keywords '((sequence "TODO(t)" "PROJ(p)" "LOOP(r)" "STRT(s)" "WAIT(w)" "HOLD(h)" "IDEA(i)" "|" "DONE(d)" "KILL(k)")
			  (sequence "[ ](T)" "[-](S)" "[?](W)" "|" "[X](D)")
			  (sequence "|" "OKAY(o)" "YES(y)" "NO(n)")))

;; (setq org-agenda-skip-scheduled-if-done t)

(setq org-todo-keyword-faces '(("[-]" .		(:inherit bold font-lock-constant-face org-todo))
			       ("STRT" .	(:inherit bold font-lock-constant-face org-todo))
			       ("[?]" .		(:inherit bold warning org-todo))
			       ("WAIT" .	(:inherit bold warning org-todo))
			       ("HOLD" .	(:inherit bold warning org-todo))
			       ("PROJ" .	(:inherit bold font-lock-doc-face org-todo))
			       ("NO" .		(:inherit bold error org-todo))
			       ("KILL" .	(:inherit bold error org-todo))))

(use-package org
  :bind (:map org-mode-map
	 ("M-RET" . org-insert-heading-after-current)
	 ("C-j" . scroll-half-page-up)
	 ("C-k" . scroll-half-page-down))
  
  :hook (org-mode . org-indent-mode))

