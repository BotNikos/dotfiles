
(use-package nerd-icons
  :ensure t)

;;; Perspective ----------------------------------------------------------------

(use-package perspective
  :ensure t
  :custom
  (persp-mode-prefix-key (kbd "C-c TAB"))
  :config
  (persp-mode))

;;; Vertico and dependet packages ----------------------------------------------

(use-package emacs
  :custom
  (enable-recursive-minibuffers t))

(use-package cape
  :ensure t
  :init
  (add-hook 'completion-at-point-functions #'cape-dabbrev)
  (add-hook 'completion-at-point-functions #'cape-file)
  (add-hook 'completion-at-point-functions #'cape-elisp-block))

(use-package marginalia
  :ensure t
  :bind (:map minibuffer-local-map
	      ("M-A" . marginalia-cycle))
  :init
  (marginalia-mode))

(use-package consult
  :ensure t
  :config
  (consult-customize consult--source-buffer :hidden t :default nil)
  (add-to-list 'consult-buffer-sources persp-consult-source))

(use-package orderless
  :ensure t
  :custom
  (completion-styles '(orderless basic))
  (completion-category-overrides '((file (styles partial-completion))))
  (completion-category-defaults nil) ;; Disable defaults, use our settings
  (completion-pcm-leading-wildcard t))

(use-package vertico
  :ensure t
  :init
  (setq completion-in-region-function #'consult-completion-in-region)
  :config
  (setq vertico-count 17)
  (define-key vertico-map (kbd "C-j") #'vertico-next)
  (define-key vertico-map (kbd "C-k") #'vertico-previous)
  (vertico-mode))

;; Navigation ------------------------------------------------------------------

;;; Avy ------------------------------------------------------------------------

(use-package avy
  :ensure t)

;;; Projectile -----------------------------------------------------------------

(use-package ripgrep
  :ensure t)

(use-package projectile
  :ensure t)

;; Rainbow-delimiters ----------------------------------------------------------

(use-package rainbow-delimiters
  :ensure t
  :hook (prog-mode . rainbow-delimiters-mode))

;; Doom modeline ---------------------------------------------------------------

(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1)
  :config (setq doom-modeline-bar-width 8
		doom-modeline-icon nil
		doom-modeline-buffer-encoding nil))

;; Emacs everywhere ------------------------------------------------------------

(use-package emacs-everywhere
  :ensure t)

;; Org-super-agenda ------------------------------------------------------------

(use-package org-super-agenda
  :ensure t
  :hook (org-agenda-mode . org-super-agenda-mode)
  :config
  (setq org-super-agenda-groups
	'((:name "Today"
		 :time-grid t)
	  (:order 98
		  :habit t)
	  (:auto-tags t)))
  (setq org-super-agenda-header-map (make-sparse-keymap)))


;; Magit -----------------------------------------------------------------------
(use-package magit
  :ensure t)

;; Spacious padding ------------------------------------------------------------
(use-package spacious-padding
  :ensure t
  :init (spacious-padding-mode))

;; Zoom ------------------------------------------------------------------------
 (use-package zoom
  :ensure t
  :config
  (setq zoom-size '(0.618 . 0.618))
  (setq zoom-ignored-major-modes '(ediff-mode dired-mode))
  (setq zoom-ignored-buffer-name-regexps '("gud" "locals of" "stack frames of" "breakpoints of" "input/output of" "^\\*Org " "^CAPTURE-"))
  :init (zoom-mode))

;; Eglot -----------------------------------------------------------------------
(use-package eglot
  :hook ((eglot-managed-mode . (lambda () (set-face-attribute 'eglot-highlight-symbol-face nil :inherit 'region))))
  :config
  (add-to-list 'eglot-server-programs '(c-mode "ccls")))

;; Dimmer ----------------------------------------------------------------------
;; (use-package dimmer
;;   :ensure t
;;   :config
;;   (dimmer-configure-magit)
;;   (dimmer-configure-org)
;;   (dimmer-configure-posframe)
;;   (setq dimmer-adjustment-mode :foreground)
;;   (setq dimmer-fraction 0.30)
;;   (setq dimmer-prevent-dimming-predicates '(window-minibuffer-p vertico-active-p))
;;   (setq dimmer-exclusion-regexp-list '(" \\*\\(LV\\|transient\\)\\*"
;;                                        "^\\*Minibuf-[0-9]+\\*"
;;                                        "^.\\*which-key\\*$"
;;                                        "^.\\*Echo.*\\*"))
;;   :init (dimmer-mode))

;; Dirvish ---------------------------------------------------------------------
(use-package dirvish
  :ensure t
  :hook (dirvish-setup . (lambda () (display-line-numbers-mode -1)))
  :init (dirvish-override-dired-mode)
  :custom
  (dirvish-quick-access-entries
   '(("h" "~/" "Home")
     ("d" "~/Downloads" "Downloads")
     ("p" "/usr/local/src" "Projects")))
  :config
  (setq dired-listing-switches "-lah --group-directories-first")
  (setq dirvish-attributes
	(append '(nerd-icons collapse vc-state)
		'(git-msg file-size))))

;; Geiser and depended packages ------------------------------------------------
(use-package paredit
  :ensure t)

(use-package geiser-chicken
  :ensure t
  :bind (:map geiser-mode-map
	      ("C-." . nil))
  :hook ((geiser-mode . paredit-mode)))

;; Diff-hl ---------------------------------------------------------------------
(use-package diff-hl
  :ensure t
  :init (global-diff-hl-mode)
  (diff-hl-flydiff-mode))


;; Org -------------------------------------------------------------------------
(use-package org
  :bind (:map org-mode-map
	      ("M-RET" . org-insert-heading-after-current))
  :hook (org-mode . org-indent-mode))

;; hl-todo ---------------------------------------------------------------------
(use-package hl-todo
  :ensure t
  :init (global-hl-todo-mode))
