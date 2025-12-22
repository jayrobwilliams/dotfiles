;;; emacs config

;; 14 pt font
(set-face-attribute 'default nil :height 140)

;; display column numbers
(column-number-mode)

;; enable line numbers globally
(global-display-line-numbers-mode t)

;; Disable line numbers for some modes
(dolist (mode '(org-mode-hook
                term-mode-hook
                eshell-mode-hook
		treemacs-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))

;; add 80 character column indicator
(add-hook 'prog-mode-hook #'display-fill-column-indicator-mode
	  (setq-default fill-column 80))

;; don't display bars
(tool-bar-mode 0)
(menu-bar-mode 0)
(scroll-bar-mode 0)

(use-package doom-modeline
  :ensure t
  :init (setq doom-modeline-bar-width 2)
  :hook (after-init . doom-modeline-mode))

;; auto reload changes from disk
(global-auto-revert-mode 1)

;; add MELPA stable, GNU ELPA, and MELPA
(require 'package)
;;(add-to-list 'package-archives
;;             '("MELPA Stable" . "https://stable.melpa.org/packages/") t)
(setq package-archives
      '(("GNU ELPA"     . "https://elpa.gnu.org/packages/")
	("MELPA Stable" . "https://stable.melpa.org/packages/")
        ("MELPA"        . "https://melpa.org/packages/"))
      package-archive-priorities
      '(("MELPA Stable" . 10)
        ("GNU ELPA"     . 5)
        ("MELPA"        . 0)))
(package-initialize)

(eval-when-compile
  (require 'use-package))

;; install flycheck
(use-package flycheck
  :ensure t
  :init (global-flycheck-mode))

;; Rainbow delimiters
(use-package rainbow-delimiters
  :ensure t
  :hook (prog-mode . rainbow-delimiters-mode))

(use-package all-the-icons
  :ensure t
  :if (display-graphic-p))

(use-package csv-mode
  :ensure t
  :mode "\\.csv\\'")

(use-package xclip
  :ensure t
  :defer)
(xclip-mode 1)

(use-package ace-window
  :ensure t
  :commands 'ace-window
  :bind ("M-o" . ace-window)
  )

;; project management
(use-package projectile
  :ensure t
  :init
  (projectile-mode +1)
  :bind (:map projectile-mode-map
              ("s-p" . projectile-command-map)
              ("C-c p" . projectile-command-map)))

;; git integration
(use-package git-gutter
  :ensure t
  :hook (prog-mode . git-gutter-mode)
  :config
  (setq git-gutter:update-interval 0.02)
  )

(when (display-graphic-p)
  (use-package git-gutter-fringe
    :ensure t
    :config
    (define-fringe-bitmap 'git-gutter-fr:added [224] nil nil '(center repeated))
    (define-fringe-bitmap 'git-gutter-fr:modified [224] nil nil '(center repeated))
    (define-fringe-bitmap 'git-gutter-fr:deleted [128 192 224 240] nil nil 'bottom)
    )
)

;; themes
(defun load-only-theme ()
  "Disable all themes and then load a single theme interactively."
  (interactive)
  (while custom-enabled-themes
    (disable-theme (car custom-enabled-themes)))
  (call-interactively 'load-theme))

;; use centaur tabs and base16 tomorrow in GUI (colors wrong in terminal)
(when (display-graphic-p)
    (use-package centaur-tabs
      :demand
      :config
      (setq centaur-tabs-style "bar"
	  centaur-tabs-height 32
	  centaur-tabs-set-icons t
	  centaur-tabs-set-modified-marker t
	  centaur-tabs-show-navigation-buttons t
	  centaur-tabs-set-bar 'under
	  x-underline-at-descent-line t)
      (centaur-tabs-headline-match)
      (centaur-tabs-group-by-projectile-project)
      ;; (setq centaur-tabs-gray-out-icons 'buffer)
      ;; (centaur-tabs-enable-buffer-reordering)
      ;; (setq centaur-tabs-adjust-buffer-order t)
      (centaur-tabs-mode t)
      :bind
      ("C-<prior>" . centaur-tabs-backward)
      ("C-<next>" . centaur-tabs-forward))
    (use-package base16-theme
      :ensure t
      :config
      (load-theme 'base16-tomorrow t))
  )

;; use window tab line and doom themes tomorrow in terminal (colors wrong w/ centaur tabs)
(unless (display-graphic-p)
    (use-package doom-themes
      :ensure t
      :config
      (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
            doom-themes-enable-italic t) ; if nil, italics is universally disabled
      (load-theme 'doom-tomorrow-day t))
    (global-tab-line-mode t)(setq tab-line-new-button-show nil)  ;; do not show add-new button
    (setq tab-line-close-button-show nil)  ;; do not show close button
    (setq tab-line-separator "")
    )

(require 'treemacs-all-the-icons)
(treemacs-load-theme "all-the-icons")
