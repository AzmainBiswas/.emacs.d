;; init.el -- Main Entry Point -*- lexical-binding: t; -*-

;;
;; Emacs Settings
;;

;; Some settings
(setq inhibit-startup-screen t)		;stop welcome screen in emacs
(menu-bar-mode 0)			;disable manu bar
(tool-bar-mode 0)			;disable tool bar
(scroll-bar-mode 0)			;disable scroll bar

;; (setq display-line-numbers-type 'relative) ; set type of line numbering (global variable)
(global-display-line-numbers-mode) ; activate line numbering in all buffers/modes

;; Font
(set-face-attribute 'default nil
                    :family "FiraCode Nerd Font"
					:weight 'regular
                    :height 140)

;; Zoom with mouse
(global-set-key (kbd "C-=") 'text-scale-increase)
(global-set-key (kbd "C--") 'text-scale-decrease)
(global-set-key (kbd "<C-wheel-up>") 'text-scale-increase)
(global-set-key (kbd "<C-wheel-down>") 'text-scale-decrease)

(setq ring-bell-function 'ignore)
(setq use-dialog-box nil)
(setq-default tab-width 4)
(defalias 'yes-or-no-p 'y-or-n-p)
(global-subword-mode 1)
(fringe-mode -1)
(global-auto-revert-mode 1)	   ; reload files autometecaly
(setq history-length 25)	   ; hestiry to 25 to load faster.
(savehist-mode 1)			   ; saving history.
(save-place-mode 1)			   ; for remenbarring location in the file
(setq use-dialog-box nil)	   ; stoping Graphical UI
(global-auto-revert-mode 1)	   ; Revert buffers when the fill cnanged
(setq global-auto-revert-non-file-buffers t)
(setq dired-dwim-target t)

;; recentf mode
(recentf-mode 1)			   ; recent mode one M-x recentf-open-file
(setq recentf-max-menu-items 50)  ;Limit the list to the last 50 files
(global-set-key (kbd "C-c r") 'recentf-open-files)

(use-package savehist 
  :ensure nil
  :config
  (savehist-mode 1))					;save the history

(delete-selection-mode 1) 				;Typing or pasting text over a selection instantly replaces it
(add-to-list 'default-frame-alist '(fullscreen . maximized))
;; (add-hook 'window-setup-hook 'toggle-frame-maximized t)

;;(desktop-save-mode 1)				   ; save session
(electric-pair-mode 1)				   ; turn on electric pair mode

; (ido-mode 1)
;; Configure Ido's behavior
; (setq ido-everywhere t)
; (setq ido-enable-flex-matching t)

;; set "gnu" style indent for c
(setq c-default-style "linux"
	  c-basic-offset 2)

; (setq split-height-threshold nil)
; (setq split-width-threshold 0)

;; Put backup files neatly away
(setq backup-directory-alist '(("." . "~/emacs_temp/")))
;; (setq undo-tree-history-directory-alist '(("." . "~/emacs_temp/")))
(setq tramp-backup-directory-alist '((".*" . "~/emacs_temp/")))
(setq auto-save-file-name-transforms `((".*" "~/emacs_temp/" t)))
(setq tramp-auto-save-directory "~/emacs_temp/")

;; Ensure the directory exists
(make-directory "~/emacs_temp/" t)

(setq backup-by-copying t    ; Don't delink hardlinks
      delete-old-versions t  ; Clean up the backups
      version-control t      ; Use version numbers on backups,
      kept-new-versions 5    ; keep some new versions
      kept-old-versions 2)   ; and some old ones, too

;; Custome file
(setq custom-file "~/.custom.el")		; for throughing errors in different file

;; Mode line
(display-battery-mode 1)
(display-time-mode 1)
(format-time-string "%I:%M %P")

;; Melpa setup
(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))
(add-to-list 'package-archives
             '("melpa-stable" . "https://stable.melpa.org/packages/"))
(package-initialize)

(use-package vertico
  :ensure t
  :config
  (vertico-mode 1)) ;; nice M-x

(use-package marginalia
  :ensure t
  :config
  (marginalia-mode 1))

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
(which-key-mode 1)

;; one dark theme
(use-package atom-one-dark-theme
  :ensure t
  :config
  (load-theme 'atom-one-dark t))

;; magit
(use-package magit
  :ensure t
  :bind
  ("M-g" . magit-status))

;; auto complete
(use-package company
  :ensure t
  :hook (after-init-hook . global-company-mode)
  :custom
  (company-minimum-prefix-length 1)
  (company-idle-delay 0.0))
(setq company-files-exclusions '(".git/" ".DS_Store"))

(use-package company-box
  :ensure t
  :hook (company-mode . company-box-mode))

;;
;; Markdown
;;
(use-package markdown-mode
  :ensure t
  :commands (markdown-mode gfm-mode)
  :mode (("README\\.md\\'" . gfm-mode)))

;;
;; org mode
;;
(use-package org
  :ensure nil)

;; Store all Org files
(setq org-directory
	  (expand-file-name
	   (if (eq system-type 'windows-nt)
		   "D:/Org"
		 "~/Doucuments/Org")))

;; Mian task and note file
(setq org-agenda-file
	  (list (expand-file-name "tasks.org" org-directory)
			(expand-file-name "notes.org" org-directory)))

(setq org-default-notes-file
      (expand-file-name "notes.org" org-directory))

;; TODO workflow
(setq org-todo-keywords
      '((sequence
         "TODO(t)"
         "NEXT(n)"
         "IN-PROGRESS(i)"
         "|"
         "DONE(d)"
         "CANCELLED(c)")))

;; Record when tasks are completed
(setq org-log-done 'time)

;; Record when a task enters a TODO state
(setq org-log-into-drawer t)

;; Task priorities: A (highest), B, C (lowest)
(setq org-priority-highest ?A)
(setq org-priority-lowest ?C)
(setq org-priority-default ?B)

;; Quick-access keyboard shortcuts
(global-set-key (kbd "C-c a") #'org-agenda)
(global-set-key (kbd "C-c c") #'org-capture)

;; Improve readability in Org buffers
(add-hook 'org-mode-hook #'visual-line-mode)
(add-hook 'org-mode-hook #'org-indent-mode)

;; custome function
(defun ab/get-font-name()
  (interactive)
  "get the font famil"
  (insert (face-attribute 'default :family)))

(defun ab/hide-trailing-carriage-returns ()
  (interactive)
  "Hide trailing carriage returns in the current buffer."
  (setq-local buffer-display-table
              (or (copy-sequence buffer-display-table)
                  (make-display-table)))
  (aset buffer-display-table ?\r []))

;; add configs folder to the path 
(add-to-list 'load-path (expand-file-name "configs" user-emacs-directory))
