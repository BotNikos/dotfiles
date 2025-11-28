;; Org-settings
(setq org-directory "~/org")
(setq org-agenda-files '("~/org/" "~/org/work/" "~/org/daily/" "~/org/dnd/" ))
(setq org-agenda-files (append org-agenda-files (directory-files-recursively "~/org/study/" "\\.org$")))
(setq org-agenda-files (append org-agenda-files (directory-files-recursively "~/org/todo/" "\\.org$")))

