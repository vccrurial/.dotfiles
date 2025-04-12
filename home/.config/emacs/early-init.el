; elpaca intead of package.el
(setq package-enable-at-startup nil)

; appearance
(setopt inhibit-startup-message t)

(menu-bar-mode -1)
(tool-bar-mode -1)
(add-to-list 'default-frame-alist '(font . "monospace-12"))
(load-theme 'wombat)
