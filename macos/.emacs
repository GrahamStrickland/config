;; Line numbers
(setq display-line-numbers-type 'relative)
(global-display-line-numbers-mode 1)

;; Theme setup
(load-theme 'gruvbox-dark-medium)

;; Clojure setup
(unless (package-installed-p 'clojure-mode)
  (package-install 'clojure-mode))
(unless (package-installed-p 'cider)
  (package-install 'cider))
(unless (package-installed-p 'inf-clojure)
  (package-refresh-contents)
  (package-install 'inf-clojure))

;; Clojure setup
(unless (package-installed-p 'clojure-mode)
  (package-install 'clojure-mode))
(unless (package-installed-p 'cider)
  (package-install 'cider))
(unless (package-installed-p 'inf-clojure)
  (package-refresh-contents)
  (package-install 'inf-clojure))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("72ed8b6bffe0bfa8d097810649fd57d2b598deef47c992920aef8b5d9599eefe"
     "066340f9c95b7cb2cfdb830a45470d5d399b248faf1621429396dfb463abafb9"
     default))
 '(package-selected-packages '(cider clojure-mode gruvbox-theme inf-clojure)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
