(require 'package)
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
			 ("org" . "https://orgmode.org/elpa/")
			 ("elpa" . "https://elpa.gnu.org/packages/")
			 ("nongnu" . "https://elpa.nongnu.org/nongnu/")))

(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

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

(setq inhibit-startup-message t)

(scroll-bar-mode -1)
(tool-bar-mode -1)
(tooltip-mode -1)
(set-fringe-mode 0)

;; (set-face-attribute 'default nil :font "Comic Mono" :height 220)
;; I will use this but since I haven't put it in nix I'll leave
;; a note here. Must be added to ~/.local/share/fonts
(set-face-attribute 'default nil :font "Liga Comic Mono" :height 220)
(menu-bar-mode -1)
(load-theme 'tango-dark)

(global-display-line-numbers-mode 1)

  ;(dolist (mode '(org-mode-hook
;		  term-mode-hook
;		  eshell-mode-hook
;		  eww-mode-hook))
 ;   (add-hook mode (lambda () (display-line-numbers-mode 0))))

(global-set-key (kbd "<escape>") 'keyboard-escape-quit)
(electric-pair-mode 1)

(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

(use-package prism)

(use-package centered-cursor-mode)
(global-centered-cursor-mode 1)

(use-package ligature
  :config
  ;; Enable the "www" ligature in every possible major mode
  (ligature-set-ligatures 't '("www"))
  ;; Enable traditional ligature support in eww-mode, if the
  ;; `variable-pitch' face supports it
  (ligature-set-ligatures 'eww-mode '("ff" "fi" "ffi"))
  ;; Enable all Cascadia Code ligatures in ALL modes
    (ligature-set-ligatures 't '("^=" "~~" "~~>" "~@" "~=" "~>" "~-" "*>" "|||>"
                                       "||=" "||>" "||-" "|}" "|]" "|=" "|=>" "|>" "|-" "|->"
                                       "{|" "[|" "]#" "::=" ":=" ":>" ":<" "$>" "=:=" "==" "==="
                                       "==>" "=!=" "=>" "=>>" "=<<" "=/=" "!=" "!==" "!!." ">:" ">="
                                       ">=>" ">>" ">>=" ">>>" ">>-" ">-" ">->" "-~" "-|" "->" "->>"
                                       "-->" "---" "-<" "-<<" "<~" "<~~" "<~>" "<*" "<*>" "<|"
                                       "<||" "<|||" "<|>" "<:" "<$" "<$>" "<=" "<=|" "<=="
                                       "<==>" "<=>" "<=<" "<!--" "<>" "<-" "<-|" "<->" "<--" "<-<"
                                       "<<" "<<=" "<<-" "<<->>" "<<<" "<+" "+>" "<+>" "</" "</>" "#{"
                                       "#[" "#:" "#=" "#!" "#(" "#?" "#_" "#_(" "%%" ".=" ".-" ".." "..="
                                       "..<" "..." ".?" "?:" "?=" "?." "/=" "/==" "/>" "_|_" "__" "www"))
  ;; Enables ligature checks globally in all buffers. You can also do it
  ;; per mode with `ligature-mode'.
  (global-ligature-mode t))

;; (global-set-key (kbd "C-x h" 'previous-buffer))

(use-package eat
  :pin nongnu
  :custom
  (eat-kill-buffer-on-exit t)
  :config
  (delete [?\C-u] eat-semi-char-non-bound-keys) ; make C-u work in Eat terminals like in normal terminals
  (delete [?\C-g] eat-semi-char-non-bound-keys) ; ditto for C-g
  (eat-update-semi-char-mode-map)
  ;; XXX: Awkward workaround for the need to call eat-reload after changing Eat's keymaps,
  ;; but reloading from :config section causes infinite recursion because :config wraps with-eval-after-load.
  (defvar eat--prevent-use-package-config-recursion nil)
  (unless eat--prevent-use-package-config-recursion
    (setq eat--prevent-use-package-config-recursion t)
    (eat-reload))
  (makunbound 'eat--prevent-use-package-config-recursion)
  )

(use-package org
  :config
  (setq org-ellipsis " ▾"))

(require 'org-tempo)
(add-to-list 'org-structure-template-alist '("el" . "src emacs-lisp"))
(setq org-startup-indented t)
(setq org-src-preserve-indentation t)

(use-package org-bullets
  :after org
  :hook (org-mode . org-bullets-mode)
  :custom
  (org-bullets-bullet-list '("◉" "○" "●" "○" "●" "○" "●")))

  (defun efs/org-babel-tangle-config ()
    (when (string-equal (buffer-file-name)
                        (expand-file-name "~/.emacs.d/config.org"))
      (let ((org-confirm-babel-evaulate nil))
        (org-babel-tangle))))
  
  (add-hook 'org-mode-hook (lambda () (add-hook 'after-save-hook #'efs/org-babel-tangle-config)))

(use-package ivy
  :diminish
  :bind (("C-s" . swiper)
	 :map ivy-minibuffer-map
	 ("TAB" . ivy-alt-done)
	 ("C-l" . ivy-alt-done)
	 ("C-j" . ivy-next-line)
	 ("C-k" . ivy-previous-line)
	 :map ivy-switch-buffer-map
	 ("C-k" . ivy-previous-line)
	 ("C-l" . ivy-done)
	 ("C-d" . ivy-switch-buffer-kill)
	 :map ivy-reverse-i-search-map
	 ("C-k" . ivy-previous-line)
	 ("C-d" . ivy-reverse-i-search-kill))
  :config
  (ivy-mode 1)
  (setq ivy-use-virtual-buffers t)
  (setq ivy-count-format "(%d/%d) ")
  (setq ivy-wrap t)
  (setq ivy-height 10))

(use-package swiper)

(use-package counsel
  :bind (("M-x" . 'counsel-M-x)
	 ("C-x b" . 'counsel-switch-buffer)
	 ("C-x C-b" . 'counsel-switch-buffer)
	 ("C-x C-f" . 'counsel-find-file))
  :config
  (setq ivy-inital-inputs-alist nil)
  )

(use-package ivy-rich
  :init
  (ivy-rich-mode 1))

(use-package helpful
  :custom
  (counsel-describe-function-function #'helpful-callable)
  (counsel-describe-variable-function #'helpful-variable)
  :bind
  ([remap describe-function] . counsel-describe-function)
  ([remap describe-command] . helpful-function)
  ([remap describe-variable] . counsel-describe-variable)
  ([remap describe-key] . helpful-key))

(use-package ivy-prescient
  :init
  (ivy-prescient-mode 1))

(add-hook 'eww-mode-hook 'meow-normal-mode)

(use-package lispy)
(add-hook 'emacs-lisp-mode-hook (lambda () (lispy-mode 1)))
(add-hook 'lisp-mode-hook (lambda () (lispy-mode 1)))

(use-package puni)

(use-package forth-mode)

(use-package racket-mode)

(use-package julia-mode)
;(use-package julia-repl)
;(add-hook 'julia-mode-hook 'julia-repl-mode)
;(use-package julia-img-view
;  :after julia-repl
;  :config (julia-img-view-setup))
; put this before snail
(use-package vterm
  :ensure t)
(use-package julia-snail
  :ensure t
  :hook (julia-mode . julia-snail-mode))
(setq julia-snail-multimedia-enable t)
;(use-package eglot-jl)
; this actually fixed the autocomplete and
; unicode issue
(add-hook 'julia-snail-mode-hook
  (lambda ()
    (remove-hook 'completion-at-point-functions #'julia-snail-company-capf t)
    (remove-hook 'completion-at-point-functions #'julia-snail-repl-completion-at-point t)
    (remove-function (local 'eldoc-documentation-function) #'julia-snail-eldoc)
    (remove-hook 'xref-backend-functions #'julia-snail-xref-backend t)))

(use-package sly)

(use-package tex-mode)
(use-package tex
  :ensure auctex)
(use-package xenops)
(use-package pdf-tools)

(use-package shen-mode)
(use-package shen-elisp)
;; set to this if using chicken shen
(setq inferior-shen-program "chicken-shen")

;; (use-package nix-mode)
;; (use-package nix-mode
;;   :mode ("\\.nix\\'" "\\.nix.in\\'"))

;; not sure why this doesn't work
;; but looks to come with emacs by default
;; (use-package prolog-mode)
;; (use-package prolog ; https://bruda.ca/_media/emacs/prolog.el
;;   :load-path "/home/trevor/.emacs.d/my/prolog"
;;   :commands (prolog-mode run-prolog)
;;   :custom
;;   (prolog-program-name '((t "/home/trevor/.local/bin/scryer-prolog"))))

;; this kinda doesn't work with scryer
;; need nicer way of doing this
 (load "~/.emacs.d/prolog.el")
 (autoload 'run-prolog "prolog" "Start a Prolog sub-process." t)
 (autoload 'prolog-mode "prolog" "Major mode for editing Prolog programs." t)
 (autoload 'mercury-mode "prolog" "Major mode for editing Mercury programs." t)
 (setq prolog-system 'scryer)
 (setq prolog-program-name
       '((t "/etc/profiles/per-user/trevor/bin/scryer-prolog")))
 (setq prolog-program-name "scryer-prolog")
 (setq prolog-electric-if-then-else-flag t)

(load "~/.emacs.d/ediprolog.el")
;;(use-package ediprolog)
(setq ediprolog-system 'scryer)
;; (setq ediprolog-program 'scryer-prolog)
(setq auto-mode-alist (append '(("\\.pl$" . prolog-mode)
                                ("\\.m$" . mercury-mode))
			      auto-mode-alist))
(global-set-key "\C-c\C-e" 'ediprolog-dwim)
(global-set-key "\C-c\C-x" 'ediprolog-remove-interactions)

(rassq-delete-all 'perl-mode auto-mode-alist)

(use-package geiser-guile)
(defun geiser-racket--language () '())
;; (setq scheme-program-name "guile")
(use-package geiser-chez)

(use-package uiua-mode
 :mode "\\.ua\\'"
 :ensure t)

(use-package perspective
  ;; :bind
  ;; ("C-x C-b" . persp-list-buffers)
  :custom
  (persp-mode-prefix-key (kbd "C-x C-x"))
  :init
  (persp-mode))

(use-package meow)

(defun meow-setup ()
  (setq meow-cheatsheet-layout meow-cheatsheet-layout-qwerty)
  (meow-motion-overwrite-define-key
   '("j" . meow-next)
   '("k" . meow-prev)
   '("<escape>" . ignore))
  (meow-leader-define-key
   ;; SPC j/k will run the original command in MOTION state.
   '("j" . "H-j")
   '("k" . "H-k")
   ;; Use SPC (0-9) for digit arguments.
   '("1" . meow-digit-argument)
   '("2" . meow-digit-argument)
   '("3" . meow-digit-argument)
   '("4" . meow-digit-argument)
   '("5" . meow-digit-argument)
   '("6" . meow-digit-argument)
   '("7" . meow-digit-argument)
   '("8" . meow-digit-argument)
   '("9" . meow-digit-argument)
   '("0" . meow-digit-argument)
   '("/" . meow-keypad-describe-key)
   '("?" . meow-cheatsheet)
   ;; lost settings must remember
   '("w" . other-window)
   '("SPC" . "C-x C-x")
   '("a" . previous-buffer)
   '(";" . next-buffer)
   '("k" . kill-this-buffer))
  (meow-normal-define-key
   '("0" . meow-expand-0)
   '("9" . meow-expand-9)
   '("8" . meow-expand-8)
   '("7" . meow-expand-7)
   '("6" . meow-expand-6)
   '("5" . meow-expand-5)
   '("4" . meow-expand-4)
   '("3" . meow-expand-3)
   '("2" . meow-expand-2)
   '("1" . meow-expand-1)
   '("-" . negative-argument)
   '(";" . meow-reverse)
   '("," . meow-inner-of-thing)
   '("." . meow-bounds-of-thing)
   '("[" . meow-beginning-of-thing)
   '("]" . meow-end-of-thing)
   '("a" . meow-append)
   '("A" . meow-open-below)
   '("b" . meow-back-word)
   '("B" . meow-back-symbol)
   '("c" . meow-change)
   '("d" . meow-delete)
   '("D" . meow-backward-delete)
   '("e" . meow-next-word)
   '("E" . meow-next-symbol)
   '("f" . meow-find)
   '("g" . meow-cancel-selection)
   '("G" . meow-grab)
   '("h" . meow-left)
   '("H" . meow-left-expand)
   '("i" . meow-insert)
   '("I" . meow-open-above)
   '("j" . meow-next)
   '("J" . meow-next-expand)
   '("k" . meow-prev)
   '("K" . meow-prev-expand)
   '("l" . meow-right)
   '("L" . meow-right-expand)
   '("m" . meow-join)
   '("n" . meow-search)
   '("o" . meow-block)
   '("O" . meow-to-block)
   '("p" . meow-yank)
   '("P" . meow-puni-mode)
   '("q" . meow-quit)
   '("Q" . meow-goto-line)
   '("r" . meow-replace)
   '("R" . meow-swap-grab)
   '("s" . meow-kill)
   '("t" . meow-till)
   '("u" . meow-undo)
   '("U" . meow-undo-in-selection)
   '("v" . meow-visit)
   '("w" . meow-mark-word)
   '("W" . meow-mark-symbol)
   '("x" . meow-line)
   '("X" . meow-goto-line)
   '("y" . meow-save)
   '("Y" . meow-sync-grab)
   '("z" . meow-pop-selection)
   '("'" . repeat)
   '("/" . swiper)
   '("<escape>" . ignore))
(setq meow-keypad-start-keys
      '((?c . ?c) (?h . ?h) (?x . ?x)))

;; taken from the github page examples of
;; customization
(setq meow-puni-keymap (make-keymap))

(meow-define-state puni
  "meow state for interacting with puni"
  :lighter " [P]"
  :keymap meow-puni-keymap)

;; meow-define-state creates the variable
(setq meow-cursor-type-puni 'hollow)

(meow-define-keys 'puni
  '("<escape>" . meow-normal-mode)
  ;; Ideally insert mode would return to whatever
  ;; it was called from
  '("i" . meow-insert-mode)
  '("l" . puni-forward-sexp-or-up-list)
  '("L" . puni-syntactic-forward-punct)
  '("h" . puni-backward-sexp-or-up-list)
  '("j" . lispy-down)
  '("k" . lispy-up)
  '("t" . puni-transpose)
  '("n" . puni-slurp-forward)
  '("b" . puni-barf-forward)
  '("v" . puni-barf-backward)
  '("c" . puni-slurp-backward)
  '("u" . meow-undo))

;; shorter delay is good
(setq meow-esc-delay 0.001)

(setq meow-keypad-describe-delay .2)

;; adding angles as a selection item
(meow-thing-register 'angle
		     '(pair ("<") (">"))
		     '(pair ("<") (">")))

;; overwriting window with word
(meow-thing-register 'word 'word 'word)

(setq meow-char-thing-table
      '((97 . angle)
       (114 . round)
       (115 . square)
       (99 . curly)
       (103 . string)
       (101 . symbol)
       (119 . word)
       (98 . buffer)
       (112 . paragraph)
       (108 . line)
       (118 . visual-line)
       (100 . defun)
       (46 . sentence))))

(require 'meow)
(meow-setup) 
(meow-global-mode 0)
(put 'downcase-region 'disabled nil)
