(add-to-list 'load-path
  (expand-file-name "scripts" user-emacs-directory))

(setopt custom-file (expand-file-name "customs.el" user-emacs-directory)
		default-input-method "russian-computer"
		warning-minimum-level :emergency
		;; debug-on-error t
		make-backup-files nil
		auto-save-default nil
		ring-bell-function 'ignore
		kill-ring-max 100
		display-time-default-load-average nil)

;; (pixel-scroll-precision-mode 1)
(defalias 'yes-or-no-p 'y-or-n-p)
(global-subword-mode 1)

; keybindings
(defun config-visit ()
  (interactive)
  (find-file (concat user-emacs-directory "init.el")))
(defun config-reload ()
  (interactive)
  (load-file (concat user-emacs-directory "init.el")))
(global-set-key (kbd "C-c e") 'config-visit)
(global-set-key (kbd "C-c r") 'config-reload)
(global-set-key (kbd "C-x C-b") 'ibuffer)

(defun split-and-follow-horizontally ()
  (interactive)
  (split-window-below)
  (balance-windows)
  (other-window 1))
(global-set-key (kbd "C-x 2") 'split-and-follow-horizontally)
(defun split-and-follow-vertically ()
  (interactive)
  (split-window-right)
  (balance-windows)
  (other-window 1))
(global-set-key (kbd "C-x 3") 'split-and-follow-vertically)

; org
(setopt org-src-fontify-natively t
      org-src-tab-acts-natively t
      org-confirm-babel-evaluate nil
      org-export-with-smart-quotes t
      org-edit-src-content-indentation 0
      org-src-window-setup 'current-window)
(add-hook 'org-mode-hook 'org-indent-mode)

(require 'setup-elpaca)
(require 'setup-meow)

(use-package which-key
  :init (which-key-mode))

(use-package async
  :init (dired-async-mode 1))

(use-package sudo-edit
  :bind ("s-e" . sudo-edit))

(use-package hungry-delete
  :config (global-hungry-delete-mode))

(use-package expand-region
  :bind ("C-q" . er/expand-region))

(use-package popup-kill-ring
  :bind ("M-y" . popup-kill-ring))

(use-package rainbow-mode
  :init (add-hook 'prog-mode-hook 'rainbow-mode))

(use-package rainbow-delimiters
  :init (rainbow-delimiters-mode 1)
  :config
  (setopt electric-pair-pairs '(
				     (?\{ . ?\})
				     (?\( . ?\))
				     (?\[ . ?\])
				     (?\" . ?\")
				     ))
  (electric-pair-mode t))

(use-package marginalia
  :bind (:map minibuffer-local-map
         ("M-A" . marginalia-cycle))
  :init
  (marginalia-mode))

(use-package vertico
  :init
  (vertico-mode))

(use-package orderless
  :custom
  (completion-styles '(orderless basic))
  (completion-category-defaults nil)
  (completion-category-overrides '((file (styles partial-completion)))))

(use-package corfu
  :init
  (global-corfu-mode))

(use-package smartparens
  :ensure smartparens  ;; install the package
  :hook (prog-mode text-mode markdown-mode) ;; add `smartparens-mode` to these hooks
  :config
  ;; load default 
  (require 'smartparens-config))

(use-package direnv
 :config
 (direnv-mode))

(use-package crux)

;; (setopt eglot-sync-connect 0)

(use-package consult)

(use-package emacs
  :ensure nil
  :config
  (winner-mode 1)
  (savehist-mode)
  :bind (("M-[" . winner-undo)
         ("M-]" . winner-redo)))

(use-package zig-mode)

(eval-after-load 'dired
  '(progn
     (define-key dired-mode-map (kbd "c") 'my-dired-create-file)
     (defun create-new-file (file-list)
       (defun exsitp-untitled-x (file-list cnt)
         (while (and (car file-list) (not (string= (car file-list) (concat "untitled" (number-to-string cnt) ".txt"))))
           (setopt file-list (cdr file-list)))
         (car file-list))

       (defun exsitp-untitled (file-list)
         (while (and (car file-list) (not (string= (car file-list) "untitled.txt")))
           (setopt file-list (cdr file-list)))
         (car file-list))

       (if (not (exsitp-untitled file-list))
           "untitled.txt"
         (let ((cnt 2))
           (while (exsitp-untitled-x file-list cnt)
             (setopt cnt (1+ cnt)))
           (concat "untitled" (number-to-string cnt) ".txt")
           )
         )
       )
     (defun my-dired-create-file (file)
       (interactive
        (list (read-file-name "Create file: " (concat (dired-current-directory) (create-new-file (directory-files (dired-current-directory))))))
        )
       (write-region "" nil (expand-file-name file) t) 
       (dired-add-file file)
       (revert-buffer)
       (dired-goto-file (expand-file-name file))
       )
     )
  )

(when (boundp 'w32-pipe-read-delay)
  (setq w32-pipe-read-delay 0)) 

(global-set-key (kbd "M-u") 'upcase-dwim)
(global-set-key (kbd "M-l") 'downcase-dwim)
(global-set-key (kbd "M-c") 'capitalize-dwim)

;; (define-key dired-mode-map (kbd "<M-down>") 'dired-find-file)
;; (define-key dired-mode-map (kbd "<M-up>") #'dired-up-directory)
;; (define-key dired-mode-map (kbd "<M-down>") #'dired-down-directory)

;; (define-key dired-mode-map (kbd "h") 'dired-up-directory)
;; (define-key dired-mode-map (kbd "l") 'dired-down-directory)

(use-package writeroom-mode)
(use-package focus)
(use-package drag-stuff)
(use-package undo-tree)

(setq scroll-preserve-screen-position t
      scroll-conservatively 0
      maximum-scroll-margin 0.5
      scroll-margin 99999
      )
