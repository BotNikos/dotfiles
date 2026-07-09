(use-package nerd-icons
  :ensure t)

(use-package nerd-icons-completion
  :ensure t
  :after marginalia
  :config
  (nerd-icons-completion-mode)
  (add-hook 'marginalia-mode-hook #'nerd-icons-completion-marginalia-setup))

(use-package nerd-icons-ibuffer
  :ensure t
  :hook (ibuffer-mode . nerd-icons-ibuffer-mode))

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
  (setq embark-indicators '(embark-minimal-indicator embark-highlight-indicator))
  (setq embark-prompter 'embark-keymap-prompter)
  (setq embark-quit-after-action nil)
 
  :config
  (add-to-list 'display-buffer-alist
               '("\\`\\*Embark Collect \\(Live\\|Completions\\)\\*"
                 nil
                 (window-parameters (mode-line-format . none)))))

;; Treesit ---------------------------------------------------------------------

(use-package treesit
  :ensure nil
  :mode (("\\.c\\'" . c-ts-mode)
         ("\\.cpp\\'" . cpp-ts-mode))
  :config
  (setq treesit-language-source-alist
        '((c "https://github.com/tree-sitter/tree-sitter-c" "v0.20.8")
	  (cpp "https://github.com/tree-sitter/tree-sitter-cpp" "v0.22.0")
	  (javascript "https://github.com/tree-sitter/tree-sitter-javascript" "v0.20.1")
	  (lua "https://github.com/tjdevries/tree-sitter-lua")))

  (setq c-ts-mode-indent-offset 8))

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
  (vertico-mode)
  (vertico-multiform-mode))

;;; Avy ------------------------------------------------------------------------

(use-package avy
  :ensure t)

;;; Projectile -----------------------------------------------------------------

(use-package ripgrep
  :ensure t)

(use-package projectile
  :ensure t)

;; Parenthesis setup ----------------------------------------------------------

(use-package smartparens
  :ensure t
  :config
  (smartparens-global-mode))

(use-package highlight-parentheses
  :ensure t
  :config
  
  ;; (setq highlight-parentheses-background-colors `(,(face-attribute 'orderless-match-face-0 :foreground)
  ;; 						  ,(face-attribute 'orderless-match-face-1 :foreground)
  ;; 						  ,(face-attribute 'orderless-match-face-2 :foreground)
  ;; 						  ,(face-attribute 'orderless-match-face-3 :foreground)))
  
  ;; (setq highlight-parentheses-colors `(,(face-attribute 'highlight :foreground)
  ;; 				       ,(face-attribute 'highlight :foreground)
  ;; 				       ,(face-attribute 'highlight :foreground)
  ;; 				       ,(face-attribute 'highlight :foreground)))

  ;; (setq highlight-parentheses-background-colors `(,(face-attribute 'pulse-highlight-face :background)
  ;; 						  ,(face-attribute 'font-lock-constant-face :background)
  ;; 						  ,(face-attribute 'magit-diff-base :background)
  ;; 						  ,(face-attribute 'font-lock-variable-name-face :background)))
  
  (setq highlight-parentheses-background-colors `("#ffffaa"
						  "#d2ebe3"
						  "#f7e0c3"
						  "#dde4f2"))

  (setq highlight-parentheses-colors `(,(face-attribute 'font-lock-string-face :foreground)
				       ,(face-attribute 'font-lock-string-face :foreground)
				       ,(face-attribute 'font-lock-string-face :foreground)
				       ,(face-attribute 'font-lock-string-face :foreground)))

  (global-highlight-parentheses-mode))

;; Doom modeline ---------------------------------------------------------------

(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1)
  :config (setq doom-modeline-bar-width 8
		doom-modeline-icon nil
		doom-modeline-buffer-encoding nil))


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
  :hook ((eglot-managed-mode . (lambda ()
				 (set-face-attribute 'eglot-highlight-symbol-face nil :inherit 'region)
				 (tempel-setup-capf)))
	 (c-mode . eglot-ensure)
	 (c-ts-mode . eglot-ensure)
	 (cpp-ts-mode . eglot-ensure)
	 (js2-mode . eglot-ensure))
  :config
  (add-to-list 'eglot-server-programs '(c-mode "ccls"))
  (add-to-list 'eglot-server-programs '(c-ts-mode "ccls")))

;; Eldoc-box -------------------------------------------------------------------

(use-package eldoc-box
  :ensure t
  :hook (eldoc-mode . eldoc-box-hover-mode))

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
	(append '(nerd-icons vc-state)
		'(file-size))))

;; Geiser and depended packages ------------------------------------------------

(use-package geiser-chicken
  :ensure t
  :hook ((geiser-mode . (lambda () (my/geiser-mode-bindings))))
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
  :hook (lua-mode . my/lua-mode-hook)
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

;; Highlight-numbers -----------------------------------------------------------

(use-package highlight-numbers
  :ensure t
  :hook (prog-mode . highlight-numbers-mode)
  :config)

;; Beacon-mode------------------------------------------------------------------

(use-package beacon
  :ensure t
  :config
  (beacon-mode 1))

;; Plantuml -------------------------------------------------------------------

(use-package plantuml-mode
  :ensure t
  :config
  (setq plantuml-jar-path "~/plantuml.jar")
  (setq org-plantuml-jar-path "~/plantuml.jar")
  (setq plantuml-default-exec-mode 'jar)
  (add-to-list 'org-src-lang-modes '("plantuml" . plantuml)))

;; Vue-mode -------------------------------------------------------------------

(use-package vue-mode
  :ensure t
  :config
  (add-hook 'mmm-mode-hook
            (lambda ()
              (set-face-background 'mmm-default-submode-face nil))))

;; Undo-fu --------------------------------------------------------------------

(use-package undo-fu
  :ensure t
  :config
  (setq undo-limit 67108864) ; 64 mb.
  (setq undo-strong-limit 100663296) ; 96 mb.
  (setq undo-outer-limit 1006632960) ; 960 mb
  )

;; Repeat-fu -------------------------------------------------------------------

(use-package repeat-fu
  :ensure t
  :commands (repeat-fu-mode repeat-fu-execute)
  :config
  (setq repeat-fu-preset 'meow)
  :hook
  ((meow-mode)
   .
   (lambda ()
     (when (and (not (minibufferp)) (not (derived-mode-p 'special-mode)))
       (repeat-fu-mode)
       (define-key meow-normal-state-keymap (kbd "'") 'repeat-fu-execute)
       (define-key meow-insert-state-keymap (kbd "C-'") 'repeat-fu-execute)))))


;; JS2-mode --------------------------------------------------------------------

(use-package js2-mode
  :ensure t
  :bind (:map js2-mode-map
	      ("M-." . xref-find-definitions))
  :config
  (add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode)))

;; Emmet-mode -----------------------------------------------------------------

(use-package emmet-mode
  :ensure t
  :bind (:map emmet-mode-keymap
	      ("C-j" . nil)))

;; Surround --------------------------------------------------------------------

(use-package surround
  :ensure t
  :bind-keymap ("M-'" . surround-keymap))


;; Garbage Collector Magic Hack ------------------------------------------------

(use-package gcmh
  :ensure t
  :config

  ;; Garbage collector (100 MB)
  (setq gc-cons-threshold (* 100 1024 1024))
  (gcmh-mode 1))

;; Org appear ------------------------------------------------------------------
(use-package org-appear
  :ensure t
  :hook (org-mode . org-appear-mode)
  :config
  (setq org-hide-emphasis-markers t))

;; Buffer-terminator -----------------------------------------------------------
(use-package buffer-terminator
  :ensure t
  :custom
  (buffer-terminator-inactivity-timeout (* 30 60))
  (buffer-terminatlr-interval (* 10 60))
  :config
  (buffer-terminator-mode 1))

;; Inhibit mouse ---------------------------------------------------------------
(use-package inhibit-mouse
  :ensure t
  :custom
  (inhibit-mouse-adjust-mouse-highlight t)
  (inhibit-mouse-adjust-show-help-function t)
  :config
  (if (daemonp)
      (add-hook 'server-after-make-frame-hook #'inhibit-mouse-mode)
    (inhibit-mouse-mode 1)))
