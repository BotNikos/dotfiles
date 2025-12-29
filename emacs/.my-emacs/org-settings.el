(setq org-directory "~/org")

(setq org-capture-templates
      `(("p" "Current project TODO" entry (file (lambda () (concat org-directory "/projects/" (projectile-project-name) ".org")))
	 "** TODO %? %i\n%u\n%a")))

;; Agenda-files

(setq org-agenda-files '("~/org/" "~/org/work/" "~/org/daily/" "~/org/dnd/" "~/org/projects" ))
(setq org-agenda-files (append org-agenda-files (directory-files-recursively "~/org/study/" "\\.org$")))
(setq org-agenda-files (append org-agenda-files (directory-files-recursively "~/org/todo/" "\\.org$")))

(setq org-agenda-span 'day)

(setq org-todo-keywords '((sequence "TODO(t)" "PROJ(p)" "LOOP(r)" "STRT(s)" "WAIT(w)" "HOLD(h)" "IDEA(i)" "|" "DONE(d)" "KILL(k)")
			  (sequence "[ ](T)" "[-](S)" "[?](W)" "|" "[X](D)")
			  (sequence "|" "OKAY(o)" "YES(y)" "NO(n)")))

(setq org-todo-keyword-faces '(("[-]" .		(:inherit bold font-lock-constant-face org-todo))
			       ("STRT" .	(:inherit bold font-lock-constant-face org-todo))
			       ("[?]" .		(:inherit bold warning org-todo))
			       ("WAIT" .	(:inherit bold warning org-todo))
			       ("HOLD" .	(:inherit bold warning org-todo))
			       ("PROJ" .	(:inherit bold font-lock-doc-face org-todo))
			       ("NO" .		(:inherit bold error org-todo))
			       ("KILL" .	(:inherit bold error org-todo))))

(setq org-habit-graph-column 100)

;; Babel

(setq org-confirm-babel-evaluate nil)
(org-babel-do-load-languages 'org-babel-load-languages '((sql		. t)
							 (sqlite	. t)
							 (C		. t)
							 (gnuplot	. t)
							 (restclient	. t)
							 (scheme	. t)))

(defun org-return-dwim ()
  (interactive)
  (let ((type (org-element-type (org-element-context))))
    (pcase type
      (`headline (org-todo 'done))
      (`link (org-open-at-point))
      ((or `src-block `inline-src-block)
       (org-babel-execute-src-block)))))

(use-package org
  :bind (:map org-mode-map
	 ("M-RET" . org-return-dwim)
	 ("C-j" . scroll-half-page-up)
	 ("C-k" . scroll-half-page-down)
	 ("M-h" . org-metaleft)
	 ("M-j" . org-metadown)
	 ("M-k" . org-metaup)
	 ("M-l" . org-metaright))
  
  :hook ((org-mode . org-indent-mode)
	 (org-super-agenda-mode . (lambda () (setq org-habit-graph-column (- (window-width) 50))))))
