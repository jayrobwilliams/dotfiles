;;; emacs config

;;display column numbers
(column-number-mode)

;; enable line numbers globally
(global-display-line-numbers-mode t)

;; disable line numbers in specific modes
(add-hook 'treemacs-mode-hook (lambda() (display-line-numbers-mode -1)))

(tool-bar-mode 0)
(menu-bar-mode 0)
(scroll-bar-mode 0)

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

