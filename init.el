;;  _____                         
;; |  ___|                        
;; | |__ _ __ ___   __ _  ___ ___ 
;; |  __| '_ ` _ \ / _` |/ __/ __|
;; | |__| | | | | | (_| | (__\__ \
;; \____/_| |_| |_|\__,_|\___|___/

;;
;; Azmain Emacs Config
;;

;;
;; Settings
;; 

;; Bar(Menu Bar, Tool bar, scroll-bar)
(menu-bar-mode 0)
(scroll-bar-mode 0)
(tool-bar-mode 0)

;; set type of line numbering (global variable)
(setq display-line-numbers-type 'relative) 
;; activate line numbering in all buffers/modes
(global-display-line-numbers-mode)

;; Font
(add-to-list 'default-frame-alist
	     '(font . "MesloLGM Nerd Font-12"))

;; Zoom with mouse
(global-set-key (kbd "C-=") 'text-scale-increase)
(global-set-key (kbd "C--") 'text-scale-decrease)
(global-set-key (kbd "<C-wheel-up>") 'text-scale-increase)
(global-set-key (kbd "<C-wheel-down>") 'text-scale-decrease)

;; some more settings
(setq ring-bell-function 'ignore)
(setq use-dialog-box nil)
(setq use-file-dialog nil)
(setq make-backup-files nil)
(setq auto-save-default nil)
(setq tab-width 2) ; or any other preferred value
(defvaralias 'c-basic-offset 'tab-width)
(defalias 'yes-or-no-p 'y-or-n-p)
(global-subword-mode 1)
(fringe-mode -1)
(recentf-mode 1) ;; recent mode one M-x recentf-open-file
(setq history-length 25) ;; hestiry to 25 to load faster.
(savehist-mode 1) ;; saving history.
(save-place-mode 1) ;; for remenbarring location in the file 
(setq use-dialog-box nil) ;; stoping Graphical UI
(global-auto-revert-mode 1) ;; Revert buffers when the fill cnanged
(setq global-auto-revert-non-file-buffers t)


;;
;; Packages
;;

;; Melpa setup
(require 'package)
(setq package-enable-at-startup nil)

(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))

(package-initialize)

;; use-package setup
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))


;;
;; Some Ui plugins
;; 

;; Doom themes
(use-package doom-themes
  :ensure t
  :if window-system
  :ensure t
  :config
  (doom-themes-org-config)
  (doom-themes-visual-bell-config))

(setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
      doom-themes-enable-italic t) ; if nil, italics is universally disabled
(load-theme 'doom-one t)

;; icons
(use-package all-the-icons
  :ensure t
  :if (display-graphic-p))

(use-package all-the-icons-dired
  :ensure t
  :init (add-hook 'dired-mode-hook 'all-the-icons-dired-mode))

;; Dash board
(use-package dashboard
  :ensure t
  :config
  (dashboard-setup-startup-hook)
  (setq dashboard-startup-banner "~/.emacs.d/logo.png")
  (setq dashboard-banner-logo-title "I am just trying to learn code")
  (setq dashboard-display-icons-p t) ;; display icons on both GUI and terminal
  (setq dashboard-icon-type 'nerd-icons) ;; use `nerd-icons' package
  (setq initial-buffer-choice (lambda () (get-buffer-create "*dashboard*")))
  (setq dashboard-items '((recents  . 5)
			  (bookmarks . 5)
			  (projects . 5))))

;; Mode line
(display-battery-mode 1)
(display-time-mode 1)
(format-time-string "%I:%M %P")

(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1)
  :custom (
	   (doom-modeline-height 25)
	   (setq doom-modeline-icon t)
	   (setq doom-modeline-lsp-icon t)
	   (setq doom-modeline-time-icon t)
	   (setq doom-modeline-lsp t)
	   (setq doom-modeline-env-version t)))

;; Rainbow-Delimiters is useful in programming modes because it colorizes nested parentheses
(use-package rainbow-delimiters
  :ensure t
  :hook (prog-mode . rainbow-delimiters-mode))

;; Rainbow Mode for color in hexcode
(use-package rainbow-mode
  :ensure t
  :hook org-mode prog-mode)

;; Imenu-list
(use-package imenu-list
  :ensure t
  :bind
  (:map global-map
	("C-c i i" . imenu-list-smart-toggle)
	("C-c i d" . imenu-list-display-entry))
  :config
  (setq imenu-list-focus-after-activation t)
  (setq imenu-list-size 0.2))

;; Which Key
(use-package which-key
  :ensure t
  :init
  (setq which-key-side-window-location 'bottom
	which-key-sort-order #'which-key-key-order-alpha
	which-key-sort-uppercase-first nil
	which-key-add-column-padding 1
	which-key-max-display-columns nil
	which-key-min-display-lines 6
	which-key-side-window-slot -10
	which-key-side-window-max-height 0.25
	which-key-idle-delay 0.8
	which-key-max-description-length 25
	which-key-allow-imprecise-window-fit t
	which-key-separator " → " ))

(which-key-mode)

;; Undo Tree
;;C-_ and C-/  (undo-tree-undo) Undo changes.
;; M-_ and C-?  (undo-tree-redo) Redo changes.
(use-package undo-tree
  :ensure t)
(undo-tree-mode t)
(global-undo-tree-mode)

;; Ivy
(use-package ivy
  :ensure t
  :diminish
  :bind (
	 :map global-map
	 ("C-s" . counsel-grep-or-swiper)
	 ("C-r" . counsel-grep-or-swiper-backward)
	 ("M-x" . counsel-M-x)
	 ("M-y" . counsel-yank-pop)
	 ("C-x b" . counsel-switch-buffer)
	 ("C-c i m" . counsel-imenu)
	 ("C-c s" . counsel-rg)
	 ("C-x C-f" . counsel-find-file)
	 ("C-c C-r" . ivy-resume)
	 :map ivy-minibuffer-map
	 ("TAB" . ivy-alt-done)
	 ("C-l" . ivy-alt-done)
	 ("C-j" . ivy-next-line)
	 ("C-n" . ivy-next-line)
	 ("C-k" . ivy-previous-line)
	 ("C-p" . ivy-previous-line)
	 :map ivy-switch-buffer-map
	 ("C-k" . ivy-previous-line)
	 ("C-l" . ivy-done)
	 ("C-d" . ivy-switch-buffer-kill)
	 :map ivy-reverse-i-search-map
	 ("C-k" . ivy-previous-line)
	 ("C-d" . ivy-reverse-i-search-kill))
  :custom
  (setq ivy-use-virtual-buffers t)
  (setq ivy-count-format "(%d/%d) ")
  (setq enable-recursive-minibuffers t)
  :config
  (ivy-mode 1))
(setq ivy-initial-inputs-alist nil)

(use-package all-the-icons-ivy-rich
  :ensure t
  :init (all-the-icons-ivy-rich-mode 1))

(use-package ivy-rich
  :ensure t
  :after ivy
  :init
  (ivy-rich-mode 1)
  :custom
  (ivy-virtual-abbreviate 'full
			  ivy-rich-switch-buffer-align-virtual-buffer t
			  ivy-rich-path-style 'abbrev))

(use-package counsel
  :ensure t
  :custom
  (counsel-linux-app-format-function #'counsel-linux-app-format-function-name-only)
  :config
  (counsel-mode 1))

;; Move test
(use-package move-text
  :ensure t)
(global-set-key (kbd "M-S-<up>") 'move-text-up)
(global-set-key (kbd "M-S-<down>") 'move-text-down)


;;
;; IDE Like feature
;;

;; git
(use-package magit
  :ensure t
  :config
  (setq magit-push-always-verify nil)
  (setq git-commit-summary-max-length 50)
  :bind
  ("M-g" . magit-status))

;; Snippets
(use-package yasnippet
  :ensure t
  :config
  (yas-global-mode 1))
(setq yas-snippet-dirs
      '("~/.emacs.d/snippets")) ;; personal snippets add if u want
       
;; projectile
;; Projectile is a project interaction library for Emacs.
(use-package projectile
  :ensure t
  :diminish projectile-mode
  :config (projectile-mode)
  :custom (projectile-completion-system 'ivy)
  :bind-keymap
  ("C-c p" . projectile-command-map))

;; Tree-sitter
(use-package tree-sitter
  :ensure t)
(use-package tree-sitter-langs
  :ensure t)
(global-tree-sitter-mode)
(add-hook 'tree-sitter-after-on-hook #'tree-sitter-hl-mode)

;;
;; LSP
(use-package lsp-mode
  :ensure t
  :init  
  (setq lsp-keymap-prefix "C-c l")
  :hook ((python-mode . lsp)
	 (c++-mode . lsp)
	 (lua-mode . lsp)
	 (sh-mode . lsp)
	 (c-mode . lsp)
	 (TeX-mode  . lsp)
	 (markdown-mode . lsp)
	 (lsp-mode . lsp-enable-which-key-integration))
  :commands lsp)

(use-package lsp-ui
  :ensure t
  :hook (lsp-mode . lsp-ui-mode))


(use-package lsp-ivy
  :ensure t
  :commands lsp-ivy-workspace-symbol)

;; Auto complitions
(use-package company
  :ensure t
  :after lsp-mode
  :hook (lsp-mode . company-mode)
  :custom
  (company-minimum-prefix-length 1)
  (company-idle-delay 0.0))

(use-package flycheck
  :ensure t
  :config
  (add-hook 'after-init-hook #'global-flycheck-mode))

(use-package company-box
  :ensure t
  :hook (company-mode . company-box-mode)
  :config
  (setq company-box-frame-top-margin 20)
  (setq company-box-frame-top-margin 75))
  


;;
;; Org mode
;;
;; org-bullets
(use-package org-bullets
  :ensure t
  :config
  (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1))))
(require 'org-tempo)

;;
;; Custome functions
;;

;; open config file of emacs
(defun open-config ()
  (interactive)
  (find-file "~/.emacs.d/init.el"))
(global-set-key (kbd "C-c o") 'open-config)

;; Reload Config file of emacs
(defun config-reload ()
  (interactive)
  (load-file "~/.emacs.d/init.el"))
(global-set-key (kbd "C-c r") 'config-reload)


;;
;; Startup time
;;

;; Makes startup faster by reducing the frequency of garbage collection
;; Using garbage magic hack.
(use-package gcmh
  :ensure t
  :config
  (gcmh-mode 1))
;; Setting garbage collection threshold
(setq gc-cons-threshold 402653184
      gc-cons-percentage 0.6)

;; Profile emacs startup
(add-hook 'emacs-startup-hook
          (lambda ()
            (message "*** Emacs loaded in %s with %d garbage collections."
                     (format "%.2f seconds"
                             (float-time
                              (time-subtract after-init-time before-init-time)))
                     gcs-done)))

;; Silence compiler warnings as they can be pretty disruptive (setq comp-async-report-warnings-errors nil)
;; Silence compiler warnings as they can be pretty disruptive
(if (boundp 'comp-deferred-compilation)
    (setq comp-deferred-compilation nil)
  (setq native-comp-deferred-compilation nil))
;; In noninteractive sessions, prioritize non-byte-compiled source files to
;; prevent the use of stale byte-code. Otherwise, it saves us a little IO time
;; to skip the mtime checks on every *.elc file.
(setq load-prefer-newer noninteractive)

;; 
;; Custome file
;;

(setq custom-file "~/.custom.el")

