(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

(load-file "~/.my-emacs/common-settings.el")
(load-file "~/.my-emacs/scroll-settings.el")
(load-file "~/.my-emacs/org-settings.el")
(load-file "~/.my-emacs/packages-settings.el")
(load-file "~/.my-emacs/meow-settings.el")
(load-file "~/.my-emacs/keybinds.el")

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("f1e8339b04aef8f145dd4782d03499d9d716fdc0361319411ac2efc603249326" default))
 '(package-selected-packages
   '(colorful-mode highlight-parentheses hl-todo paredit diff-hl geiser-chicken dirvish dimmer zoom spacious-padding kanagawa-themes indent-bars ripgrep magit cape org-super-agenda doom-modeline flycheck nerd-icons rainbow-delimiters marginalia projectile perspective punch-line meow avy orderless vertico emacs-everywhere doom-themes mu4e)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
