;; -*- mode: elisp -*-
;; Base init file to load config

;;;; Package Management and Configuration
;; straight.el for package management and installation
;; use-package.el for package configuration

;; bootstrap straight
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 5))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

;; use-package uses straight to install packages
(setq straight-use-package-by-default t)
(straight-use-package 'use-package)
(require 'use-package)

;; initialize environment variables
;(use-package exec-path-from-shell
;  :ensure t)
;(exec-path-from-shell-initialize)

;;;;; Editor
(when (eq system-type 'darwin)
  (set-face-attribute 'default nil :family "Iosevka Extended" :height 150))

;; Disable toolbar
(tool-bar-mode -1)

(use-package evil
  :ensure t
  :config
  (evil-mode)
  (evil-set-undo-system 'undo-tree))

(use-package undo-tree
  :ensure t
  :config
  (global-undo-tree-mode 1))

(use-package auctex
  :ensure t
  :defer t)

(setq TeX-auto-save t)
(setq Tex-parse-self t)
(setq-default TeX-master nil)

(setq ConTeXt-Mark-version "IV")

;;;;; Org Mode

(defun my-org-settings ()
  (evil-mode)
  (turn-on-visual-line-mode)
  (org-indent-mode)
)

(add-hook 'org-mode-hook #'my-org-settings)

;; Disable audible bell sound
(setq ring-bell-function 'ignore)

;; Backup files are created in Trash
(setq backup-directory-alist            '((".*" . "~/.Trash")))

;; Recent Files
(recentf-mode 1)
(setq recentf-max-menu-items 25)
(setq recentf-max-saved-items 25)
(global-set-key "\C-x\ \C-r" 'recentf-open-files)

