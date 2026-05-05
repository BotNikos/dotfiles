;; Lazy package loading
(setq package-quickstart t)
(setq use-package-always-defer t)

;; Disable backup files
(setq mode-line-format nil
      make-backup-files nil
      backup-directory-alist '((".*" . "~/.local/share/Trash/files")))

