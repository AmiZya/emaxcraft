;;; package --- Summary
;;; code:
;;; commentary:

(setq user-full-name "Amine Zyad")
(setq user-mail-address "amizya@gmail.com")

;; Define and initialise package repositories
(require 'package)
(setq package-enable-at-startup nil)
(setq package-archives '(("gnu" . "http://mirrors.163.com/elpa/gnu/")
                         ("melpa" . "https://melpa.org/packages/")
                         ("org" . "http://orgmode.org/elpa/")))
(package-initialize)

;; use-package to simplify the config file
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(require 'use-package)
(setq use-package-always-ensure 't)


;; Keyboard-centric user interface
(setq inhibit-startup-message t)
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(defalias 'yes-or-no-p 'y-or-n-p)

;; Vertical Scroll
(setq scroll-step 1)
(setq scroll-margin 1)
(setq scroll-conservatively 101)
(setq scroll-up-aggressively 0.01)
(setq scroll-down-aggressively 0.01)
(setq auto-window-vscroll nil)
(setq fast-but-imprecise-scrolling nil)
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1)))
(setq mouse-wheel-progressive-speed nil)
;; Horizontal Scroll
(setq hscroll-step 1)
(setq hscroll-margin 1)

(global-hl-line-mode 1)

(set-frame-font "JetBrains Mono 14" nil t)

(add-to-list 'default-frame-alist '(ns-transparent-titlebar . t))
(add-to-list 'default-frame-alist '(ns-appearance . dark))
(setq ns-use-proxy-icon nil)
(setq frame-title-format nil)


;; Unbind unneeded keys
(global-set-key (kbd "C-z") nil)
(global-set-key (kbd "C-_") nil)
(global-set-key (kbd "M-z") nil)
(global-set-key (kbd "M-m") nil)
(global-set-key (kbd "C-x C-z") nil)
(global-set-key (kbd "M-/") nil)
(global-set-key (kbd "C-/") nil)
;; Truncate lines
(global-set-key (kbd "C-x C-l") #'toggle-truncate-lines)

(global-set-key (kbd "C-+") #'text-scale-increase)
(global-set-key (kbd "C--") #'text-scale-decrease)

(delete-selection-mode)
;; (global-set-key (kbd "M-<down>") #'forward-paragraph)
;; (global-set-key (kbd "M-<up>") #'backward-paragraph)

(setq mac-command-modifier 'meta
      mac-option-modifier 'none)

;; Restore after startup
(add-hook 'after-init-hook
          (lambda ()
            (setq gc-cons-threshold 1000000)
            (message "gc-cons-threshold restored to %S"
                     gc-cons-threshold)))

(use-package benchmark-init
  :config
  ;; To disable collection of benchmark data after init is done.
  (add-hook 'after-init-hook 'benchmark-init/deactivate))

(add-hook 'after-init-hook
          (lambda () (message "loaded in %s" (emacs-init-time))))


(defun find-config ()
  "Edit config.org."
  (interactive)
  (find-file "~/emaxraft/init.el"))

(global-set-key (kbd "C-c I") 'find-config)

;; (defun my-exec-path-from-shell-initialize ()
;;      (when (memq window-system '(mac ns x))
;;        (exec-path-from-shell-initialize)))

;; (use-package exec-path-from-shell	
;;   :init
;;   (add-hook 'after-init-hook 'my-exec-path-from-shell-initialize))

(use-package doom-themes
  :ensure t
  :config
  ;; Global settings (defaults)
  (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
        doom-themes-enable-italic t) ; if nil, italics is universally disabled
  (load-theme 'doom-henna t)

  ;; Enable flashing mode-line on errors
  (doom-themes-visual-bell-config)
  ;; Enable custom neotree theme (all-the-icons must be installed!)
  (doom-themes-neotree-config)
  ;; or for treemacs users
  (setq doom-themes-treemacs-theme "doom-atom") ; use "doom-colors" for less minimal icon theme
  (doom-themes-treemacs-config)
  ;; Corrects (and improves) org-mode's native fontification.
  (doom-themes-org-config))

(use-package doom-modeline
  :custom
  ;; Don't compact font caches during GC. Windows Laggy Issue
  (inhibit-compacting-font-caches t)
  (doom-modeline-minor-modes t)
  (doom-modeline-icon t)
  (doom-modeline-major-mode-color-icon t)
  (doom-modeline-height 15)
  :config
  (doom-modeline-mode))

(use-package marginalia
  ;; Either bind `marginalia-cycle' globally or only in the minibuffer
  :bind (("M-A" . marginalia-cycle)
         :map minibuffer-local-map
         ("M-A" . marginalia-cycle))

  ;; The :init configuration is always executed (Not lazy!)
  :init

  ;; Must be in the :init section of use-package such that the mode gets
  ;; enabled right away. Note that this forces loading the package.
  (marginalia-mode))

(use-package move-dup
  :bind (("M-<up>"   . move-dup-move-lines-up)
         ("C-M-<up>" . move-dup-duplicate-up)
         ("M-<down>"   . move-dup-move-lines-down)
         ("C-M-<down>" . move-dup-duplicate-down)))


(use-package nyan-mode
  :config
  (nyan-mode)
  (nyan-start-animation))

(use-package nov
  :config
(add-to-list 'auto-mode-alist '("\\.epub\\'" . nov-mode))
  )

(use-package diminish)
(diminish eldoc-mode)

(use-package ivy
      :diminish
      :config
      (ivy-mode t))
(setq ivy-initial-inputs-alist nil)

(use-package counsel
  :bind (("M-x" . counsel-M-x)
	 ("C-x C-f" . counsel-find-file)
	 ("C-x b" . counsel-switch-buffer)
	 ))

(use-package prescient)
  (use-package ivy-prescient
    :config
    (ivy-prescient-mode t))

(use-package swiper
    :bind (("M-s" . counsel-grep-or-swiper)))


(use-package which-key
    :diminish
    :config
    (add-hook 'after-init-hook 'which-key-mode))

(use-package undo-fu
  :config
  (global-unset-key (kbd "C-z"))
  (global-set-key (kbd "C-z")   'undo-fu-only-undo)
  (global-set-key (kbd "M-z") 'undo-fu-only-redo))

(use-package avy
  :defer t
  :bind
  (("C-j" . avy-goto-char-timer)
   ("C-o" . avy-goto-line))
  :custom
  (avy-timeout-seconds 0.3)
  (avy-style 'pre)
  :custom-face
  (avy-lead-face ((t (:background "#51afef" :foreground "#870000" :weight bold)))))

(use-package ace-window
  :bind
  ("C-o" . ace-window)
  ("C-x o" . ace-window))

(use-package expand-region
  :bind ("C-=" . er/expand-region))

(defun mac-toggle-max-window ()
    (interactive)
    (set-frame-parameter
     nil
     'fullscreen
     (if (frame-parameter nil 'fullscreen)
         nil
       'fullboth)))

(use-package projectile
  :diminish projectile-mode
  :config
  (setq projectile-completion-system 'ivy)
  (projectile-global-mode)
  :bind-keymap
  ("C-c p" . projectile-command-map)
  :init
  (setq projectile-project-search-path '("~/code/"))
  (setq projectile-switch-project-action #'projectile-dired))(use-package counsel-projectile
  :after projectile
  :bind
  ("C-p" . counsel-projectile-switch-project)
  :config
  (counsel-projectile-mode))


;; Dependencies
(use-package page-break-lines
  :diminish)

(use-package all-the-icons)

(use-package dashboard
  :config
  (setq show-week-agenda-p t)
  (setq dashboard-items '((recents . 10) (projects . 10)))
  (setq dashboard-set-heading-icons t)
  (setq dashboard-set-file-icons t)
  (setq dashboard-startup-banner 3)
  (dashboard-setup-startup-hook)
  )

(use-package magit
  :config
  (setq magit-completing-read-function 'ivy-completing-read)
  :bind
  ;; Magic
  ("C-x g s" . magit-status)
  ("C-x g x" . magit-checkout)
  ("C-x g c" . magit-commit)
  ("C-x g p" . magit-push)
  ("C-x g u" . magit-pull)
  ("C-x g e" . magit-ediff-resolve)
  ("C-x g r" . magit-rebase-interactive))(use-package magit-popup)

(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

(use-package term
  :commands term
  :config
  (setq explicit-shell-file-name "zsh") ;; Change this to zsh, etc
  ;;(setq explicit-zsh-args '())         ;; Use 'explicit-<shell>-args for shell-specific args

  ;; Match the default Bash shell prompt.  Update this if you have a custom prompt
  (setq term-prompt-regexp "^[^#$%>\n]*[#$%>] *"))

(use-package eterm-256color
  :hook (term-mode . eterm-256color-mode))

(use-package vterm
  :commands vterm
  :config
  (setq term-prompt-regexp "^[^#$%>\n]*[#$%>] *")  ;; Set this to match your custom shell prompt
  ;;(setq vterm-shell "zsh")                       ;; Set this to customize the shell to launch
  (setq vterm-max-scrollback 10000))

(use-package discover-my-major
  :bind ("C-h C-m" . discover-my-major))

(use-package yasnippet
  :diminish yas-minor-mode
  :init
  (use-package yasnippet-snippets :after yasnippet)
  :hook ((prog-mode LaTeX-mode org-mode markdown-mode) . yas-minor-mode)
  :bind
  (:map yas-minor-mode-map ("C-c C-n" . yas-expand-from-trigger-key))
  (:map yas-keymap
        (("TAB" . smarter-yas-expand-next-field)
         ([(tab)] . smarter-yas-expand-next-field)))
  :config
  (yas-reload-all)
  (defun smarter-yas-expand-next-field ()
    "Try to `yas-expand' then `yas-next-field' at current cursor position."
    (interactive)
    (let ((old-point (point))
          (old-tick (buffer-chars-modified-tick)))
      (yas-expand)
      (when (and (eq old-point (point))
                 (eq old-tick (buffer-chars-modified-tick)))
        (ignore-errors (yas-next-field))))))


(use-package flycheck
  :defer t
  :diminish
  :hook (after-init . global-flycheck-mode)
  :commands (flycheck-add-mode)
  :custom
  (flycheck-global-modes
   '(not outline-mode diff-mode shell-mode eshell-mode term-mode))
  (flycheck-emacs-lisp-load-path 'inherit)
  (flycheck-indication-mode (if (display-graphic-p) 'right-fringe 'right-margin))
  :init
  (if (display-graphic-p)
      (use-package flycheck-posframe
        :custom-face
        (flycheck-posframe-face ((t (:foreground ,(face-foreground 'success)))))
        (flycheck-posframe-info-face ((t (:foreground ,(face-foreground 'success)))))
        :hook (flycheck-mode . flycheck-posframe-mode)
        :custom
        (flycheck-posframe-position 'window-bottom-left-corner)
        (flycheck-posframe-border-width 3)
        (flycheck-posframe-inhibit-functions
         '((lambda (&rest _) (bound-and-true-p company-backend)))))
    (use-package flycheck-pos-tip
      :defines flycheck-pos-tip-timeout
      :hook (flycheck-mode . flycheck-pos-tip-mode)
      :custom (flycheck-pos-tip-timeout 30)))
  :config
  (use-package flycheck-popup-tip
    :hook (flycheck-mode . flycheck-popup-tip-mode))
  (when (fboundp 'define-fringe-bitmap)
    (define-fringe-bitmap 'flycheck-fringe-bitmap-double-arrow
      [16 48 112 240 112 48 16] nil nil 'center))
  (when (executable-find "vale")
    (use-package flycheck-vale
      :config
      (flycheck-vale-setup)
      (flycheck-add-mode 'vale 'latex-mode))))

(use-package flyspell
  :ensure nil
  :diminish
  :if (executable-find "aspell")
  :hook (((text-mode outline-mode latex-mode org-mode markdown-mode) . flyspell-mode))
  :custom
  (flyspell-issue-message-flag nil)
  (ispell-program-name "aspell")
  (ispell-extra-args
   '("--sug-mode=ultra" "--lang=en_US" "--camel-case"))
  :config
  (use-package flyspell-correct-ivy
    :after ivy
    :bind
    (:map flyspell-mode-map
          ([remap flyspell-correct-word-before-point] . flyspell-correct-wrapper)
          ("C-." . flyspell-correct-wrapper))
    :custom (flyspell-correct-interface #'flyspell-correct-ivy)))

(use-package quickrun
  :custom
  (quickrun-timeout-seconds 60)
  :bind
  (("M-r" . quickrun)
    ("C-c C-e" . quickrun-shell)))


(use-package lsp-mode
  :defer t
  :commands lsp
  :custom
  (lsp-keymap-prefix "C-x l")
  (lsp-auto-guess-root nil)
  (lsp-prefer-flymake nil) ; Use flycheck instead of flymake
  (lsp-enable-file-watchers nil)
  (lsp-enable-folding nil)
  (read-process-output-max (* 1024 1024))
  (lsp-keep-workspace-alive nil)
  (lsp-eldoc-hook nil)
  :bind (:map lsp-mode-map ("C-c C-f" . lsp-format-buffer))
  :hook ((java-mode python-mode go-mode rust-mode
          js-mode js2-mode typescript-mode web-mode
          c-mode c++-mode objc-mode) . lsp-deferred)
  :config
  (defun lsp-update-server ()
    "Update LSP server."
    (interactive)
    ;; Equals to `C-u M-x lsp-install-server'
    (lsp-install-server t)))

(use-package lsp-mode
  :defer t
  :commands lsp
  :custom
  (lsp-keymap-prefix "C-x l")
  (lsp-auto-guess-root nil)
  (lsp-prefer-flymake nil) ; Use flycheck instead of flymake
  (lsp-enable-file-watchers nil)
  (lsp-enable-folding nil)
  (read-process-output-max (* 1024 1024))
  (lsp-keep-workspace-alive nil)
  (lsp-eldoc-hook nil)
  :bind (:map lsp-mode-map ("C-c C-f" . lsp-format-buffer))
  :hook ((java-mode python-mode go-mode rust-mode
          js-mode js2-mode typescript-mode web-mode
          c-mode c++-mode objc-mode) . lsp-deferred)
  :config
  (defun lsp-update-server ()
    "Update LSP server."
    (interactive)
    ;; Equals to `C-u M-x lsp-install-server'
    (lsp-install-server t)))

(use-package company
  :diminish company-mode
  :hook ((prog-mode LaTeX-mode latex-mode ess-r-mode) . company-mode)
  :bind
  (:map company-active-map
        ([tab] . smarter-tab-to-complete)
        ("TAB" . smarter-tab-to-complete))
  :custom
  (company-minimum-prefix-length 1)
  (company-tooltip-align-annotations t)
  (company-require-match 'never)
  ;; Don't use company in the following modes
  (company-global-modes '(not shell-mode eaf-mode))
  ;; Trigger completion immediately.
  (company-idle-delay 0.1)
  ;; Number the candidates (use M-1, M-2 etc to select completions).
  (company-show-numbers t)
  :config
    (global-company-mode 1)
  (defun smarter-tab-to-complete ()
    "Try to `org-cycle', `yas-expand', and `yas-next-field' at current cursor position.

If all failed, try to complete the common part with `company-complete-common'"
    (interactive)
    (when yas-minor-mode
      (let ((old-point (point))
            (old-tick (buffer-chars-modified-tick))
            (func-list
             (if (equal major-mode 'org-mode) '(org-cycle yas-expand yas-next-field)
               '(yas-expand yas-next-field))))
        (catch 'func-suceed
          (dolist (func func-list)
            (ignore-errors (call-interactively func))
            (unless (and (eq old-point (point))
                         (eq old-tick (buffer-chars-modified-tick)))
              (throw 'func-suceed t)))
          (company-complete-common))))))

(use-package company-tabnine
  :defer 1
  :custom
  (company-tabnine-max-num-results 9)
  :bind
  (("M-q" . company-other-backend)
   ("C-c t" . company-tabnine))
  :init
  (defun company//sort-by-tabnine (candidates)
    "Integrate company-tabnine with lsp-mode"
    (if (or (functionp company-backend)
            (not (and (listp company-backend) (memq 'company-tabnine company-backends))))
        candidates
      (let ((candidates-table (make-hash-table :test #'equal))
            candidates-lsp
            candidates-tabnine)
        (dolist (candidate candidates)
          (if (eq (get-text-property 0 'company-backend candidate)
                  'company-tabnine)
              (unless (gethash candidate candidates-table)
                (push candidate candidates-tabnine))
            (push candidate candidates-lsp)
            (puthash candidate t candidates-table)))
        (setq candidates-lsp (nreverse candidates-lsp))
        (setq candidates-tabnine (nreverse candidates-tabnine))
        (nconc (seq-take candidates-tabnine 3)
               (seq-take candidates-lsp 6)))))
  (defun lsp-after-open-tabnine ()
    "Hook to attach to `lsp-after-open'."
    (setq-local company-tabnine-max-num-results 3)
    (add-to-list 'company-transformers 'company//sort-by-tabnine t)
    (add-to-list 'company-backends '(company-capf :with company-tabnine :separate)))
  (defun company-tabnine-toggle (&optional enable)
    "Enable/Disable TabNine. If ENABLE is non-nil, definitely enable it."
    (interactive)
    (if (or enable (not (memq 'company-tabnine company-backends)))
        (progn
          (add-hook 'lsp-after-open-hook #'lsp-after-open-tabnine)
          (add-to-list 'company-backends #'company-tabnine)
          (when (bound-and-true-p lsp-mode) (lsp-after-open-tabnine))
          (message "TabNine enabled."))
      (setq company-backends (delete 'company-tabnine company-backends))
      (setq company-backends (delete '(company-capf :with company-tabnine :separate) company-backends))
      (remove-hook 'lsp-after-open-hook #'lsp-after-open-tabnine)
      (company-tabnine-kill-process)
      (message "TabNine disabled.")))
  :hook
  (kill-emacs . company-tabnine-kill-process)
  :config
  (company-tabnine-toggle t))

(use-package company-box
  :diminish
  :if (display-graphic-p)
  :defines company-box-icons-all-the-icons
  :hook (company-mode . company-box-mode)
  :custom
  (company-box-backends-colors nil)
  (company-box-doc-delay 0.1)
  (company-box-doc-frame-parameters '((internal-border-width . 1)
                                      (left-fringe . 3)
                                      (right-fringe . 3)))
  :config
  (with-no-warnings
    ;; Prettify icons
    (defun my-company-box-icons--elisp (candidate)
      (when (or (derived-mode-p 'emacs-lisp-mode) (derived-mode-p 'lisp-mode))
        (let ((sym (intern candidate)))
          (cond ((fboundp sym) 'Function)
                ((featurep sym) 'Module)
                ((facep sym) 'Color)
                ((boundp sym) 'Variable)
                ((symbolp sym) 'Text)
                (t . nil)))))
    (advice-add #'company-box-icons--elisp :override #'my-company-box-icons--elisp)

    ;; Credits to Centaur for these configurations
    ;; Display borders and optimize performance
    (defun my-company-box--display (string on-update)
      "Display the completions."
      (company-box--render-buffer string on-update)

      (let ((frame (company-box--get-frame))
            (border-color (face-foreground 'font-lock-comment-face nil t)))
        (unless frame
          (setq frame (company-box--make-frame))
          (company-box--set-frame frame))
        (company-box--compute-frame-position frame)
        (company-box--move-selection t)
        (company-box--update-frame-position frame)
        (unless (frame-visible-p frame)
          (make-frame-visible frame))
        (company-box--update-scrollbar frame t)
        (set-face-background 'internal-border border-color frame)
        (when (facep 'child-frame-border)
          (set-face-background 'child-frame-border border-color frame)))
      (with-current-buffer (company-box--get-buffer)
        (company-box--maybe-move-number (or company-box--last-start 1))))
    (advice-add #'company-box--display :override #'my-company-box--display)

    (defun my-company-box-doc--make-buffer (object)
      (let* ((buffer-list-update-hook nil)
             (inhibit-modification-hooks t)
             (string (cond ((stringp object) object)
                           ((bufferp object) (with-current-buffer object (buffer-string))))))
        (when (and string (> (length (string-trim string)) 0))
          (with-current-buffer (company-box--get-buffer "doc")
            (erase-buffer)
            (insert (propertize "\n" 'face '(:height 0.5)))
            (insert string)
            (insert (propertize "\n\n" 'face '(:height 0.5)))

            ;; Handle hr lines of markdown
            ;; @see `lsp-ui-doc--handle-hr-lines'
            (with-current-buffer (company-box--get-buffer "doc")
              (let (bolp next before after)
                (goto-char 1)
                (while (setq next (next-single-property-change (or next 1) 'markdown-hr))
                  (when (get-text-property next 'markdown-hr)
                    (goto-char next)
                    (setq bolp (bolp)
                          before (char-before))
                    (delete-region (point) (save-excursion (forward-visible-line 1) (point)))
                    (setq after (char-after (1+ (point))))
                    (insert
                     (concat
                      (and bolp (not (equal before ?\n)) (propertize "\n" 'face '(:height 0.5)))
                      (propertize "\n" 'face '(:height 0.5))
                      (propertize " "
                                  'display '(space :height (1))
                                  'company-box-doc--replace-hr t
                                  'face `(:background ,(face-foreground 'font-lock-comment-face)))
                      (propertize " " 'display '(space :height (1)))
                      (and (not (equal after ?\n)) (propertize " \n" 'face '(:height 0.5)))))))))

            (setq mode-line-format nil
                  display-line-numbers nil
                  header-line-format nil
                  show-trailing-whitespace nil
                  cursor-in-non-selected-windows nil)
            (current-buffer)))))
    (advice-add #'company-box-doc--make-buffer :override #'my-company-box-doc--make-buffer)

    ;; Display the border and fix the markdown header properties
    (defun my-company-box-doc--show (selection frame)
      (cl-letf (((symbol-function 'completing-read) #'company-box-completing-read)
                (window-configuration-change-hook nil)
                (inhibit-redisplay t)
                (display-buffer-alist nil)
                (buffer-list-update-hook nil))
        (-when-let* ((valid-state (and (eq (selected-frame) frame)
                                       company-box--bottom
                                       company-selection
                                       (company-box--get-frame)
                                       (frame-visible-p (company-box--get-frame))))
                     (candidate (nth selection company-candidates))
                     (doc (or (company-call-backend 'quickhelp-string candidate)
                              (company-box-doc--fetch-doc-buffer candidate)))
                     (doc (company-box-doc--make-buffer doc)))
          (let ((frame (frame-local-getq company-box-doc-frame))
                (border-color (face-foreground 'font-lock-comment-face nil t)))
            (unless (frame-live-p frame)
              (setq frame (company-box-doc--make-frame doc))
              (frame-local-setq company-box-doc-frame frame))
            (set-face-background 'internal-border border-color frame)
            (when (facep 'child-frame-border)
              (set-face-background 'child-frame-border border-color frame))
            (company-box-doc--set-frame-position frame)

            ;; Fix hr props. @see `lsp-ui-doc--fix-hr-props'
            (with-current-buffer (company-box--get-buffer "doc")
              (let (next)
                (while (setq next (next-single-property-change (or next 1) 'company-box-doc--replace-hr))
                  (when (get-text-property next 'company-box-doc--replace-hr)
                    (put-text-property next (1+ next) 'display
                                       '(space :align-to (- right-fringe 1) :height (1)))
                    (put-text-property (1+ next) (+ next 2) 'display
                                       '(space :align-to right-fringe :height (1)))))))

            (unless (frame-visible-p frame)
              (make-frame-visible frame))))))
    (advice-add #'company-box-doc--show :override #'my-company-box-doc--show)

    (defun my-company-box-doc--set-frame-position (frame)
      (-let* ((frame-resize-pixelwise t)

              (box-frame (company-box--get-frame))
              (box-position (frame-position box-frame))
              (box-width (frame-pixel-width box-frame))
              (box-height (frame-pixel-height box-frame))
              (box-border-width (frame-border-width box-frame))

              (window (frame-root-window frame))
              ((text-width . text-height) (window-text-pixel-size window nil nil
                                                                  (/ (frame-pixel-width) 2)
                                                                  (/ (frame-pixel-height) 2)))
              (border-width (or (alist-get 'internal-border-width company-box-doc-frame-parameters) 0))

              (x (- (+ (car box-position) box-width) border-width))
              (space-right (- (frame-pixel-width) x))
              (space-left (car box-position))
              (fringe-left (or (alist-get 'left-fringe company-box-doc-frame-parameters) 0))
              (fringe-right (or (alist-get 'right-fringe company-box-doc-frame-parameters) 0))
              (width (+ text-width border-width fringe-left fringe-right))
              (x (if (> width space-right)
                     (if (> space-left width)
                         (- space-left width)
                       space-left)
                   x))
              (y (cdr box-position))
              (bottom (+ company-box--bottom (frame-border-width)))
              (height (+ text-height (* 2 border-width)))
              (y (cond ((= x space-left)
                        (if (> (+ y box-height height) bottom)
                            (+ (- y height) border-width)
                          (- (+ y box-height) border-width)))
                       ((> (+ y height) bottom)
                        (- (+ y box-height) height))
                       (t y))))
        (set-frame-position frame (max x 0) (max y 0))
        (set-frame-size frame text-width text-height t)))
    (advice-add #'company-box-doc--set-frame-position :override #'my-company-box-doc--set-frame-position))

  (when (require 'all-the-icons nil t)
    (declare-function all-the-icons-faicon 'all-the-icons)
    (declare-function all-the-icons-material 'all-the-icons)
    (declare-function all-the-icons-octicon 'all-the-icons)
    (setq company-box-icons-all-the-icons
          `((Unknown . ,(all-the-icons-material "find_in_page" :height 1.0 :v-adjust -0.2))
                        (Text . ,(all-the-icons-faicon "text-width" :height 1.0 :v-adjust -0.02))
                        (Method . ,(all-the-icons-faicon "cube" :height 1.0 :v-adjust -0.02 :face 'all-the-icons-purple))
                        (Function . ,(all-the-icons-faicon "cube" :height 1.0 :v-adjust -0.02 :face 'all-the-icons-purple))
                        (Constructor . ,(all-the-icons-faicon "cube" :height 1.0 :v-adjust -0.02 :face 'all-the-icons-purple))
                        (Field . ,(all-the-icons-octicon "tag" :height 1.1 :v-adjust 0 :face 'all-the-icons-lblue))
                        (Variable . ,(all-the-icons-octicon "tag" :height 1.1 :v-adjust 0 :face 'all-the-icons-lblue))
                        (Class . ,(all-the-icons-material "settings_input_component" :height 1.0 :v-adjust -0.2 :face 'all-the-icons-orange))
                        (Interface . ,(all-the-icons-material "share" :height 1.0 :v-adjust -0.2 :face 'all-the-icons-lblue))
                        (Module . ,(all-the-icons-material "view_module" :height 1.0 :v-adjust -0.2 :face 'all-the-icons-lblue))
                        (Property . ,(all-the-icons-faicon "wrench" :height 1.0 :v-adjust -0.02))
                        (Unit . ,(all-the-icons-material "settings_system_daydream" :height 1.0 :v-adjust -0.2))
                        (Value . ,(all-the-icons-material "format_align_right" :height 1.0 :v-adjust -0.2 :face 'all-the-icons-lblue))
                        (Enum . ,(all-the-icons-material "storage" :height 1.0 :v-adjust -0.2 :face 'all-the-icons-orange))
                        (Keyword . ,(all-the-icons-material "filter_center_focus" :height 1.0 :v-adjust -0.2))
                        (Snippet . ,(all-the-icons-material "format_align_center" :height 1.0 :v-adjust -0.2))
                        (Color . ,(all-the-icons-material "palette" :height 1.0 :v-adjust -0.2))
                        (File . ,(all-the-icons-faicon "file-o" :height 1.0 :v-adjust -0.02))
                        (Reference . ,(all-the-icons-material "collections_bookmark" :height 1.0 :v-adjust -0.2))
                        (Folder . ,(all-the-icons-faicon "folder-open" :height 1.0 :v-adjust -0.02))
                        (EnumMember . ,(all-the-icons-material "format_align_right" :height 1.0 :v-adjust -0.2))
                        (Constant . ,(all-the-icons-faicon "square-o" :height 1.0 :v-adjust -0.1))
                        (Struct . ,(all-the-icons-material "settings_input_component" :height 1.0 :v-adjust -0.2 :face 'all-the-icons-orange))
                        (Event . ,(all-the-icons-octicon "zap" :height 1.0 :v-adjust 0 :face 'all-the-icons-orange))
                        (Operator . ,(all-the-icons-material "control_point" :height 1.0 :v-adjust -0.2))
                        (TypeParameter . ,(all-the-icons-faicon "arrows" :height 1.0 :v-adjust -0.02))
                        (Template . ,(all-the-icons-material "format_align_left" :height 1.0 :v-adjust -0.2)))
          company-box-icons-alist 'company-box-icons-all-the-icons)))


(use-package ccls
  :defer t
  :hook ((c-mode c++-mode objc-mode) .
         (lambda () (require 'ccls) (lsp)))
  :custom
  (ccls-executable (executable-find "ccls")) ; Add ccls to path if you haven't done so
  (ccls-sem-highlight-method 'font-lock)
  (ccls-enable-skipped-ranges nil)
  :config
  (lsp-register-client
   (make-lsp-client
    :new-connection (lsp-tramp-connection (cons ccls-executable ccls-args))
    :major-modes '(c-mode c++-mode cuda-mode objc-mode)
    :server-id 'ccls-remote
    :multi-root nil
    :remote? t
    :notification-handlers
    (lsp-ht ("$ccls/publishSkippedRanges" #'ccls--publish-skipped-ranges)
            ("$ccls/publishSemanticHighlight" #'ccls--publish-semantic-highlight))
    :initialization-options (lambda () ccls-initialization-options)
    :library-folders-fn nil)))


(use-package python-mode
  :ensure nil
  :after flycheck
  :mode "\\.py\\'"
  :custom
  (python-indent-offset 4)
  (flycheck-python-pycompile-executable "python3")
  (python-shell-interpreter "python3"))

(use-package lsp-pyright
  :hook (python-mode . (lambda () (require 'lsp-pyright)))
  :custom
  (lsp-pyright-multi-root nil))

(use-package tex
  :ensure auctex
  :defer t
  :custom
  (TeX-auto-save t)
  (TeX-parse-self t)
  (TeX-master nil)
  (TeX-after-compilation-finished-functions #'TeX-revert-document-buffer)
  :hook
  (LaTeX-mode . (lambda ()
                  (turn-on-reftex)
                  (setq reftex-plug-into-AUCTeX t)
                  (reftex-isearch-minor-mode)
                  (setq TeX-PDF-mode t)
                  (setq TeX-source-correlate-method 'synctex)
                  (setq TeX-source-correlate-start-server t)))
  :config
  (when (version< emacs-version "26")
    (add-hook LaTeX-mode-hook #'display-line-numbers-mode)))

(use-package web-mode
  :custom-face
  (css-selector ((t (:inherit default :foreground "#66CCFF"))))
  (font-lock-comment-face ((t (:foreground "#828282"))))
  :mode
  ("\\.phtml\\'" "\\.tpl\\.php\\'" "\\.[agj]sp\\'" "\\.as[cp]x\\'"
   "\\.erb\\'" "\\.mustache\\'" "\\.djhtml\\'" "\\.[t]?html?\\'"))

(use-package js2-mode
  :mode "\\.js\\'"
  :interpreter "node")

(use-package typescript-mode
  :mode "\\.ts\\'"
  :commands (typescript-mode))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(company-show-quick-access t nil nil "Customized with use-package company")
 '(package-selected-packages
   '(l undo-fu move-dup diminish flyspell-correct-ivy hackernews quickrun py-snippets flycheck-popup-tip flycheck-posframe flycheck yasnippet-snippets yasnippet which-key vterm use-package undo-tree rainbow-delimiters page-break-lines magit-popup magit ivy-prescient expand-region exec-path-from-shell eterm-256color doom-themes doom-modeline discover-my-major dashboard counsel-projectile benchmark-init all-the-icons ace-window)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(avy-lead-face ((t (:background "#51afef" :foreground "#870000" :weight bold))))
 '(css-selector ((t (:inherit default :foreground "#66CCFF"))))
 '(flycheck-posframe-face ((t (:foreground "#53df83"))))
 '(flycheck-posframe-info-face ((t (:foreground "#53df83"))))
 '(font-lock-comment-face ((t (:foreground "#828282")))))

