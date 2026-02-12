(use-package nerd-icons
  :ensure t)

;;; Perspective ----------------------------------------------------------------

(use-package perspective
  :ensure t
  :custom
  (persp-mode-prefix-key (kbd "C-c TAB"))
  :config
  (persp-mode)
  
  (customize-set-variable 'display-buffer-base-action
			  '((display-buffer-reuse-window display-buffer-same-window)
			    (reusable-frames . t)))

  (customize-set-variable 'even-window-sizes nil)
  (customize-set-variable 'ediff-window-setup-function 'ediff-setup-windows-plain))

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
  (add-to-list 'consult-buffer-sources persp-consult-source)
  (setq xref-show-xrefs-function #'consult-xref
	xref-show-definitions-function #'consult-xref))

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
  (vertico-multiform-mode)
  (add-to-list 'vertico-multiform-categories '(embark-keybinding grid))
  (vertico-mode))

;;; Avy ------------------------------------------------------------------------

(use-package avy
  :ensure t)

;;; Projectile -----------------------------------------------------------------

(use-package ripgrep
  :ensure t)

(use-package projectile
  :ensure t)

;; Parenthesis setup ----------------------------------------------------------

(use-package highlight-parentheses
  :ensure t
  :config
  (setq highlight-parentheses-background-colors `(,(face-attribute 'orderless-match-face-0 :foreground)
						  ,(face-attribute 'orderless-match-face-1 :foreground)
						  ,(face-attribute 'orderless-match-face-2 :foreground)
						  ,(face-attribute 'orderless-match-face-3 :foreground)))
  
  (setq highlight-parentheses-colors `(,(face-attribute 'highlight :foreground)
				       ,(face-attribute 'highlight :foreground)
				       ,(face-attribute 'highlight :foreground)
				       ,(face-attribute 'highlight :foreground)))
  (global-highlight-parentheses-mode))

;; Doom modeline ---------------------------------------------------------------

(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1)
  :config (setq doom-modeline-bar-width 8
		doom-modeline-icon nil
		doom-modeline-buffer-encoding nil))

;; Emacs everywhere ------------------------------------------------------------

(use-package emacs-everywhere
  :ensure t
  :config

  (setq emacs-everywhere-frame-name-format "emacs-everywhere ∷ %s — %s")
  (add-to-list 'emacs-everywhere-markdown-apps "Keybase" t)

  ;; Extend emacs-everywhere-system-configs
  (setq emacs-everywhere-system-configs
        (append emacs-everywhere-system-configs
                '(((wayland . niri)
                   :focus-command ("niri" "msg" "action" "focus-window" "--id" "%w")
                   :info-function emacs-everywhere--app-info-linux-niri))))

  (defun emacs-everywhere--app-info-linux-niri ()
    "Return information on the current active window, on a Linux Niri session."
    (require 'json)
    (let* ((json (json-read-from-string
		  (emacs-everywhere--call
                   "niri" "msg" "-j" "focused-window"))) ;; -j for json
	   (wid (cdr (assq 'id json)))
	   (window-id (if (numberp wid) (number-to-string wid) wid))
	   (window-title (cdr (assq 'title json)))
	   (app-name (cdr (assq 'app_id json)))
	   (window-geometry nil)) ;; no geometry in niri
      (make-emacs-everywhere-app
       :id window-id
       :class app-name
       :title window-title
       :geometry window-geometry))))
 

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
  :init (zoom-mode)
  :hook (ediff-after-setup-windows . (lambda () (my/fix-ediff-size) (dimmer-mode -1)))
  :config
  (setq zoom-size '(0.618 . 0.618))
  (setq zoom-ignored-major-modes '(ediff-mode dired-mode))
  (setq zoom-ignored-buffer-name-regexps '("gud" "locals of" "stack frames of" "breakpoints of" "input/output of" "^\\*Org " "^CAPTURE-"))

  (defun my/fix-ediff-size ()
    (with-selected-window (get-buffer-window "*Ediff Control Panel*")
      (setq window-size-fixed t)
      (window-resize (selected-window) (- 5 (window-total-height)) nil t))))

;; Eglot -----------------------------------------------------------------------
(use-package eglot
  :after (tempel)
  :hook ((eglot-managed-mode . (lambda () (set-face-attribute 'eglot-highlight-symbol-face nil :inherit 'region) (tempel-setup-capf)))
	 (c-mode . eglot-ensure))
  :config
  (add-to-list 'eglot-server-programs '(c-mode "ccls")))

;; Dimmer ----------------------------------------------------------------------
(use-package dimmer
  :ensure t
  :config
  (dimmer-configure-magit)
  (dimmer-configure-org)
  (dimmer-configure-posframe)
  (setq dimmer-adjustment-mode :foreground)
  (setq dimmer-fraction 0.30)
  (setq dimmer-prevent-dimming-predicates '(window-minibuffer-p vertico-active-p))
  (setq dimmer-exclusion-regexp-list '(" \\*\\(LV\\|transient\\)\\*"
                                       "^\\*Minibuf-[0-9]+\\*"
                                       "^.\\*which-key\\*$"
                                       "^.\\*Echo.*\\*"))
  :init (dimmer-mode))

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
  :ensure t
  :bind (:map paredit-mode-map
	      ("C-)" . paredit-forward-slurp-sexp)
	      ("C-(" . paredit-backward-slurp-sexp)
	      ("C-}" . paredit-forward-barf-sexp)
	      ("C-{" . paredit-backward-barf-sexp)
	      ("C-j" . scroll-half-page-up)
	      ("C-k" . scroll-half-page-down)))

(use-package geiser-chicken
  :ensure t
  :hook ((geiser-mode . (lambda () (paredit-mode) (my/geiser-mode-bindings))))
  :config
  (defun my/geiser-mode-bindings ()
    (define-key geiser-mode-map (kbd "C-.") nil)))

;; Diff-hl ---------------------------------------------------------------------
(use-package diff-hl
  :ensure t
  :init (global-diff-hl-mode)
  (diff-hl-flydiff-mode))

;; hl-todo ---------------------------------------------------------------------
(use-package hl-todo
  :ensure t
  :init (global-hl-todo-mode))

;; Colorful-mode ---------------------------------------------------------------
(use-package colorful-mode
  :ensure t
  :config
  (setq colorful-use-prefix t)
  (global-colorful-mode))

;; Lua-mode --------------------------------------------------------------------
(use-package lua-mode
  :ensure t
  :config
  (setq lua-indent-level 8))

;; Dashboard -------------------------------------------------------------------
(use-package dashboard
  :ensure t
  :config
  (dashboard-setup-startup-hook)
  (setq dashboard-startup-banner 'logo)
  (setq dashboard-week-agenda 'nil)
  (setq dashboard-items '((recents	. 10)
			  (projects	. 10))))

;; Tempel ----------------------------------------------------------------------

(use-package tempel
  :ensure t
  :hook ((conf-mode . tempel-setup-capf)
	 (prog-mode . tempel-setup-capf)
	 (text-mode . tempel-setup-capf)
	 (org-mode  . tempel-setup-capf))
  :init
  (defun tempel-setup-capf ()
    (setq-local completion-at-point-functions
                (cons #'tempel-expand (remq 'tempel-expand completion-at-point-functions)))))

(use-package tempel-collection
  :ensure t)

;; Ibuffer-projectile ----------------------------------------------------------
(use-package ibuffer-vc
  :hook (ibuffer-mode . ibuffer-vc-set-filter-groups-by-vc-root)
  :ensure t)


;; Spelling --------------------------------------------------------------------

(use-package flyspell-correct
  :ensure t
  :bind (:map flyspell-mode-map
	      ("C-;" . flyspell-correct-wrapper)
	      ("C-," . nil)))

;; Gnuplot ---------------------------------------------------------------------

(use-package gnuplot
  :ensure t)

;; Restclient ------------------------------------------------------------------

(use-package jq-mode
  :ensure t)

(use-package ob-restclient
  :ensure t)

(use-package restclient
  :ensure t)

;; Embark ----------------------------------------------------------------------

;; Consult users will also want the embark-consult package.
(use-package embark-consult
  :ensure t ; only need to install it, embark loads it after consult if found
  :hook
  (embark-collect-mode . consult-preview-at-point-mode))

(use-package embark
  :ensure t

  :bind
  (("C-." . embark-act)         ;; pick some comfortable binding
   ("C-;" . embark-dwim)        ;; good alternative: M-.
   ("C-h B" . embark-bindings)) ;; alternative for `describe-bindings'

  :init

  ;; Optionally replace the key help with a completing-read interface
  (setq p find-file refix-help-command #'embark-prefix-help-command)
  (setq embark-indicators
	'(embark-minimal-indicator  ; default is embark-mixed-indicator
          embark-highlight-indicator
          embark-isearch-highlight-indicator))
  (setq embark-prompter 'embark-keymap-prompter)
  (setq embark-quit-after-action nil)
  

  ;; Show the Embark target at point via Eldoc. You may adjust the
  ;; Eldoc strategy, if you want to see the documentation from
  ;; multiple providers. Beware that using this can be a little
  ;; jarring since the message shown in the minibuffer can be more
  ;; than one line, causing the modeline to move up and down:

  ;; (add-hook 'eldoc-documentation-functions #'embark-eldoc-first-target)
  ;; (setq eldoc-documentation-strategy #'eldoc-documentation-compose-eagerly)

  ;; Add Embark to the mouse context menu. Also enable `context-menu-mode'.
  ;; (context-menu-mode 1)
  ;; (add-hook 'context-menu-functions #'embark-context-menu 100)

  :config

  ;; Hide the mode line of the Embark live/completions buffers
  (add-to-list 'display-buffer-alist
               '("\\`\\*Embark Collect \\(Live\\|Completions\\)\\*"
                 nil
                 (window-parameters (mode-line-format . none)))))

;; Org-roam --------------------------------------------------------------------
(use-package org-roam
  :ensure t
  :config
  (setq org-roam-directory (file-truename "~/org"))
  (setq org-roam-node-display-template (concat "${title:*} " (propertize "${tags:10}" 'face 'org-tag)))
  (setq org-roam-graph-link-hidden-types '("file"))
  (setq org-roam-graph-viewer "/usr/bin/firefox")
  (setq org-roam-graph-executable "dot")
  (org-roam-db-autosync-mode))

(use-package org-roam-ui
  :ensure t
  :config
  (setq org-roam-ui-sync-theme t
        org-roam-ui-follow t
        org-roam-ui-update-on-save t
        org-roam-ui-open-on-start t))


;; Sqlformatter ----------------------------------------------------------------
(use-package sqlformat
  :ensure t
  :config
  (setq sqlformat-command 'sql-formatter))

;; Org-wild-notifier -----------------------------------------------------------
(use-package org-wild-notifier
  :ensure t
  :config
  (setq alert-default-style 'libnotify)
  (setq org-wild-notifier-alert-time '(5 0)))

