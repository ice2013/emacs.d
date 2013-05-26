;;------------------------------------------------------------------------------
;;                            ---> Emacs Setup <---
;;------------------------------------------------------------------------------
;;                                                       ver 0.1  28-03-2013
;;------------------------------------------------------------------------------
;;
;;    Look before you leap
;;
;;    “Every time I read an article like this, it’s how a power user installs
;;    an array of plugins and customizations to really soup up Vim, which to
;;    me kind of misses the point. If you want that level whiz-bang, use Coda
;;    or Sublime Text 2 or Eclipse or whatever.” -- Hacker News
;;
;;    “I’ve seen one too many love-letter-to-Vim blog posts where the author
;;    recommends a flashy plugin that does nothing to really improve
;;    productivity. You know what improves productivity? Mastering motions and
;;    operators.” -- “Stop the Vim Configuration Madness”
;;
;;    Read the fucking manual and wiki quickly and effectively
;;
;;    http://xkcd.com/378/
;;    http://usevim.com/2013/02/20/configuration/
;;    https://news.ycombinator.com/item?id=5245426
;;
;;------------------------------------------------------------------------------


;;------------------------------------------------------------------------------
;;                                                             basic options
;;------------------------------------------------------------------------------
;;
;;    some setups use menu and click then check the code changes in .emacs
;;
      (add-to-list 'load-path "~/.emacs.d/plugins")

      (custom-set-variables
;;      custom-set-variables was added by Custom.
;;      If you edit it by hand, you could mess it up, so be careful.
;;      Your init file should contain only one such instance.
;;      If there is more than one, they won't work right.
        '(auto-save-default nil)
        '(auto-save-list-file-name nil t)
        '(auto-save-list-file-prefix nil)
        '(default-tab-width 4 t)
        '(delete-auto-save-files t)
        '(display-time-mode t)
        '(global-font-lock-mode 1)
        '(indent-tabs-mode nil)
        '(inhibit-startup-echo-area-message t)
        '(inhibit-startup-screen t)
        '(make-backup-files nil)
        '(menu-bar-mode nil)
        '(scroll-bar-mode nil)
        '(show-paren-mode t)
        '(tool-bar-mode nil))
;;
;;------------------------------------------------------------------------------


;;------------------------------------------------------------------------------
;;                                                              visible-bell
;;------------------------------------------------------------------------------
;;
;;    http://emacsblog.org/2007/02/06/quick-tip-visible-bell/
;;    Emacs does not beep or flash anymore
;;    on hit C-g in the minibuffer or during an isearch
;;
      (setq ring-bell-function
        (lambda ()
          (unless (memq this-command
            '(isearch-abort abort-recursive-edit
                            exit-minibuffer
                            keyboard-quit))
                                            (ding))))
      (setq visible-bell t)
;;
;;-----------------------------------------------------------------------------


;;-----------------------------------------------------------------------------
;;                                                           window setting    
;;-----------------------------------------------------------------------------
;;
;;    http://stackoverflow.com/questions/92971
;;
      (set-frame-position (selected-frame) 280 120)  ; upper left corner (0,0）
      (add-to-list 'default-frame-alist '(height . 32))
      (add-to-list 'default-frame-alist '(width . 107))
      (setq scroll-margin 3 ;0                                ; nice scrolling
        scroll-conservatively 100000
        scroll-preserve-screen-position 1)
;;
;;-----------------------------------------------------------------------------


;;-----------------------------------------------------------------------------
;;                                                             transparency
;;-----------------------------------------------------------------------------
;;
;;    http://www.emacswiki.org/emacs/TransparentEmacs
;;
      (set-frame-parameter
        (selected-frame) 'alpha '(85 50))  ; transparency 85%, inactive 50%
        (eval-when-compile (require 'cl))
        (defun toggle-transparency ()
          (interactive)
            (if (/= (cadr (frame-parameter nil 'alpha)) 100)
                (set-frame-parameter nil 'alpha '(100 100))
                (set-frame-parameter nil 'alpha '(85 50))))
      (global-set-key (kbd "C-c t") 'toggle-transparency)
;;
;;-----------------------------------------------------------------------------


;;-----------------------------------------------------------------------------
;;                                                                     font
;;-----------------------------------------------------------------------------
;;
;;    http://emacswiki.org/emacs/SetFonts#toc12
;;    http://ergoemacs.org/emacs/emacs_list_and_set_font.html
;;    set font for all windows
;;    (add-to-list 'default-frame-alist '(font . "Menlo-14"))
;;
      (set-default-font "Consolas-11")
;;    (set-default-font "Menlo-10.5")
      (set-fontset-font
        (frame-parameter nil 'font)
        'han
        (font-spec :family "Microsoft YaHei"))               ; Chinese font 
;;
;;-----------------------------------------------------------------------------


;;-----------------------------------------------------------------------------
;;                                                   title bar: buffer name
;;-----------------------------------------------------------------------------
;;
      (setq frame-title-format
      '("%S" (buffer-file-name "%f"
      (dired-directory dired-directory "%b"))))
;;
;;-----------------------------------------------------------------------------


;;-----------------------------------------------------------------------------
;;                                                             cursor style
;;-----------------------------------------------------------------------------
;;
;;    http://www.emacswiki.org/emacs/ChangingCursorDynamically
;;    (setq-default cursor-type 'box)
;;    (setq-default cursor-type 'bar)
;;    default cursor style is box, no need to set it in here
;;    use cursor-chg to change it dynamically
;;
      (add-to-list 'default-frame-alist '(cursor-color . "#0A9DFF"))
      (require 'cursor-chg)
      (toggle-cursor-type-when-idle 1)   ; cursor change when Emacs is idle
      (change-cursor-mode 1)      ; on for overwrite, read-only, input mode
;;
;;-----------------------------------------------------------------------------


;;-----------------------------------------------------------------------------
;;                                                              color-theme
;;-----------------------------------------------------------------------------
;;
;;    http://www.emacswiki.org/emacs/FrameParameters
;;    http://www.emacswiki.org/emacs/SetColor
;;    http://flatuicolors.com/
;;    
      (add-to-list 'custom-theme-load-path "~/.emacs.d/color-themes")

;;    https://github.com/lvillani/el-monokai-theme
;;    (load-theme 'monokai t)

;;(load-theme 'molokai t)

;;(load-theme 'flat-monokai t)
;;
;;    https://github.com/chriskempson/tomorrow-theme
      (add-to-list 'load-path "~/.emacs.d/color-themes/tomorrow")
;;    (load-theme 'tomorrow-day t)
;;    (load-theme 'tomorrow-night-bright t)
 ;;   (load-theme 'tomorrow-night-blue t)
;;    (load-theme 'tomorrow-night-eighties t)
;;    (load-theme 'tomorrow-night t)
;;
;;    http://ethanschoonover.com/solarized
;;    https://github.com/bbatsov/solarized-emacs
      (add-to-list 'load-path "~/.emacs.d/color-themes/solarized")
    (load-theme 'solarized-dark t)
;;    (load-theme 'solarized-light t)
;;
;;-----------------------------------------------------------------------------


;;-----------------------------------------------------------------------------
;;                                                                powerline
;;-----------------------------------------------------------------------------
;; https://github.com/jonathanchu/emacs-powerline
;; https://github.com/milkypostman/powerline --not in use, check later
;; http://hico-horiuchi.com/wiki/doku.php?id=emacs:powerline
;; http://tcnksm.sakura.ne.jp/blog/2012/05/02/
(require 'powerline)
;; モードラインの色

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(fringe ((t nil)))
 '(linum ((t (:inherit (shadow default) :foreground "gray36"))))
 ;;'(linum-highlight-face ((t (:background "#34495e" :foreground "yellow" :weight bold))))
 '(linum-highlight-face ((t (:foreground "yellow" :weight bold))))
 '(mode-line ((t (:background "#6699ff" :foreground "white" :box nil))))
 '(mode-line-inactive ((t (:foreground "white" :background "#262626" :box nil)))))
                         ; 背景色: 黒


(setq powerline-arrow-shape 'arrow14)             ;; フォントサイズが小さい場合
;; モードライン2色目
(setq powerline-color1 "#ff66ff") ; #ff66ff #0088cc
;; モードライン3色目
;;(setq powerline-color2 "#696969") ; gray white
(setq powerline-color2 "#bdc3c7")
;; バッファ情報の書式
(defpowerline buffer-id (propertize (car (propertized-buffer-identification "%b"))
                                    'face (powerline-make-face color1)))
(defpowerline row     "%l")    ; 行番号の書式
(defpowerline column  "%c")    ; 列番号の書式
(defpowerline percent "%p")    ; カーソル位置の割合
(defpowerline time    "%M")    ; 時計の書式
;; 右部分の位置合わせ(右端から何文字分を左に寄せるか、デフォルト+15文字)
(defun powerline-make-fill (color)
  (let ((plface (powerline-make-face color)))
    (if (eq 'right (get-scroll-bar-mode))
      (propertize " " 'display '((space :align-to (- right-fringe 36))) 'face plface)
      (propertize " " 'display '((space :align-to (- right-fringe 39))) 'face plface))))
;; Powerlineの書式
(setq-default mode-line-format (list
 '("-" mode-line-mule-info mode-line-modified)
 '(:eval (concat
           (powerline-buffer-id   'left   nil powerline-color1)
           (powerline-major-mode  'left       powerline-color1)
           (powerline-minor-modes 'left       powerline-color1)
           (powerline-narrow      'left       powerline-color1 powerline-color2)
           (powerline-vc          'center                      powerline-color2)
           (powerline-make-fill                                powerline-color2)
           (powerline-row         'right      powerline-color1 powerline-color2)
           (powerline-make-text   ": "        powerline-color1)
           (powerline-column      'right      powerline-color1)
           (powerline-percent     'right      powerline-color1)
           (powerline-time        'right  nil powerline-color1)
           (powerline-make-text   "  "    nil )))))
;; 時計のフォーマット
(setq display-time-string-forms '((format
  "%s/%s(%s) %s:%s" month day dayname 24-hours minutes)))
(display-time-mode t)    ; 時計を表示
;;-----------------------------------------------------------------------------


;;-----------------------------------------------------------------------------
;;                                                              line number
;;-----------------------------------------------------------------------------
;;
;;    http://d.hatena.ne.jp/tm_tn/20110605/1307238416
;;    http://overwatering.org/blog/2011/10/better-line-numbering-in-emacs/
;;    use M-x customize-face linum & linum-highlight-mode to set color and
;;    others all together make the line number vim style
;;  
      (require 'hlinum)                                ; hlinum-mode 載せる
      (global-linum-mode 1)
      (setq linum-format " %4d")
      (global-hl-line-mode 1)                   ; highlight the cursor line
      (global-hi-lock-mode 1)                                     ; Hi Lock
;;    (global-visual-line-mode 1)           ; soft wrapped at word boundary
;;
;;------------------------------------------------------------------------------


;;------------------------------------------------------------------------------
;;                                                             code folding
;;------------------------------------------------------------------------------

;;------------------------------------------------------------------------------


;;------------------------------------------------------------------------------
;;                                                                 ido-mode
;;------------------------------------------------------------------------------
;;
;;    www.masteringemacs.org/articles/2010/10/10/introduction-to-ido-mode
;;
      (setq ido-enable-flex-matching t)
      (setq ido-everywhere t)
      (ido-mode 1)
      (setq ido-use-filename-at-point 'guess)
      (setq ido-create-new-buffer 'always)
;;
;;------------------------------------------------------------------------------


;;------------------------------------------------------------------------------
;;                                                                save place
;;------------------------------------------------------------------------------
;;
;;    http://www.emacswiki.org/emacs/SavePlace
;;
      (require 'saveplace)
        (setq save-place-file "~/.emacs.d/saved-places")
        (setq-default save-place t)
;;
;;------------------------------------------------------------------------------


;;------------------------------------------------------------------------------
;;                                                           clean-mode-line
;;------------------------------------------------------------------------------
;;
;;(require 'clean-mode-line)

(defvar mode-line-cleaner-alist
  `((auto-complete-mode . " α")
    (yas-minor-mode . " γ")
    (paredit-mode . " Φ")
    (eldoc-mode . "")
    (abbrev-mode . "")
    (undo-tree-mode . " τ")
    (wrap-region-mode . "")
    ;;(volatile-highlights-mode . " υ")
    (elisp-slime-nav-mode . " δ")
    (nrepl-mode . " ηζ")
    (nrepl-interaction-mode . " ηζ")
    (auto-fill-function . " φ")
    (autopair-mode . "")
    (lambda-mode . "")
    (projectile-mode . "")
    ;; Major modes
    (clojure-mode . "λ")
    (hi-lock-mode . "")
    (python-mode . "Py")
    (emacs-lisp-mode . "EL")
    (markdown-mode . "md")
    (org-mode . "Ο")
    (processing-mode . "P5"))
  "Alist for `clean-mode-line'.

When you add a new element to the alist, keep in mind that you
must pass the correct minor/major mode symbol and a string you
want to use in the modeline *in lieu of* the original.")


(defun clean-mode-line ()
  (interactive)
  (loop for cleaner in mode-line-cleaner-alist
        do (let* ((mode (car cleaner))
                 (mode-str (cdr cleaner))
                 (old-mode-str (cdr (assq mode minor-mode-alist))))
             (when old-mode-str
                 (setcar old-mode-str mode-str))
               ;; major mode
             (when (eq mode major-mode)
               (setq mode-name mode-str)))))


(add-hook 'after-change-major-mode-hook 'clean-mode-line)


;;; Greek letters - C-u C-\ greek ;; C-\ to revert to default
;;; α β ψ δ ε φ γ η ι ξ κ λ μ ν ο π ρ σ τ θ ω ς χ υ ζ
;;; Α Β Ψ Δ Ε Φ Γ Η Ι Ξ Κ Λ Μ Ν Ο Π Ρ Σ Τ Θ Ω Σ Χ Υ Ζ


;;-----------------------------------------------------------------------------
;;  rainbow-mode
;;-----------------------------------------------------------------------------
;; http://julien.danjou.info/projects/emacs-packages
(require 'rainbow-mode)
(global-set-key (kbd "C-c r") 'rainbow-mode)
;;-----------------------------------------------------------------------------


;;-----------------------------------------------------------------------------
;;  indentation guide
;;-----------------------------------------------------------------------------
;; https://github.com/antonj/Highlight-Indentation-for-Emacs/
(require 'highlight-indentation)
(set-face-background 'highlight-indentation-face "#e3e3d3")
;;(setq highlight-indentation-offset 8)
;;-----------------------------------------------------------------------------


;;-----------------------------------------------------------------------------
;;                                                 対応する括弧をハイライト
;;-----------------------------------------------------------------------------
;;
      (show-paren-mode t)            ;have matching parenthesis highlighted
      (setq show-paren-delay 0)                       ; 表示までの秒数: 0秒
;;    (setq show-paren-style 'expression)              ; 括弧内もハイライト
      (setq show-paren-style 'parenthesis)
      (set-face-background 'show-paren-match-face "#f39c12")  ; 背景色: なし
;;    (set-face-underline-p 'show-paren-match-face "yellow")    ; 下線色: 黄
;;
;;-----------------------------------------------------------------------------


;;-----------------------------------------------------------------------------
;;                                                                auto-pair
;;-----------------------------------------------------------------------------
;;
;;    https://github.com/capitaomorte/autopair
;;
      (require 'autopair)
      (autopair-global-mode) ;; enable autopair in all buffers
;;
;;-----------------------------------------------------------------------------
;;                                                 Xcode style {} auto pair
;;-----------------------------------------------------------------------------
;;
;;    http://kei10in.hatenablog.jp/entry/20110625/1309004717
;;
;;    (defun newline-skeleton-pair-insert-brace ()
;;      (interactive)
;;        (if (and (eq (char-before) ?{)
;;          (or (eq last-command 'yank)
;;          (eq last-command 'self-insert-command)
;;          (eq last-command 'c-electric-brace)))
;;      (progn
;;        (newline-and-indent)
;;        (save-excursion (insert "\n}") (indent-according-to-mode)))
;;      (newline-and-indent)))
;;    (global-set-key (kbd "RET") 'newline-skeleton-pair-insert-brace)
;;
;;    modified for all modes by me on 28-03-2013
;;    to achieve the complete effect later...
;;
;;-----------------------------------------------------------------------------


;;-----------------------------------------------------------------------------
;;                                                                   tabbar
;;-----------------------------------------------------------------------------
;;
;;    http://d.hatena.ne.jp/tequilasunset/20110103/p1
;;    http://d.hatena.ne.jp/hico_horiuchi/20121208/1354975316
;;    http://d.hatena.ne.jp/plasticster/20110825/1314271209
;;    http://blog.csdn.net/CherylNatsu/article/details/6204737\
;;    http://www.ivanpig.com/blog/?p=354
;;
;;    (require 'tabbar)
;;    (tabbar-mode)
;;    (global-set-key "\M-]" 'tabbar-forward)  ; 次のタブ
;;    (global-set-key "\M-[" 'tabbar-backward) ; 前のタブ
;;    タブ上でマウスホイールを使わない
;;    (tabbar-mwheel-mode nil)
;;    グループを使わない
;;    (setq tabbar-buffer-groups-function nil)
;;    左側のボタンを消す
;;    (dolist (btn '(tabbar-buffer-home-button
;;               tabbar-scroll-left-button
;;               tabbar-scroll-right-button))
;;    (set btn (cons (cons "" nil)
;;                 (cons "" nil))))
;;
;;    タブの長さ
;;    (setq tabbar-separator '(0.3))

;;    色設定
;;    (set-face-attribute ; バー自体の色
;;      'tabbar-default nil
;;      :background "gray80"
;;      :family "Menlo"
;;      :height 1.0)
;;    (set-face-attribute ; アクティブなタブ
;;      'tabbar-selected nil
;;      :background "black"
;;      :foreground "yellow"
;;      :weight 'bold
;;      :box nil)
;;    (set-face-attribute ; 非アクティブなタブ
;;      'tabbar-unselected nil
;;      :background "white"
;;      :foreground "black"
;;      :box nil)
;;
;;-----------------------------------------------------------------------------


;;-----------------------------------------------------------------------------
;;                                     キーバインドをツールチップで表示する
;;-----------------------------------------------------------------------------
;;
;;    http://d.hatena.ne.jp/tequilasunset/20101211/p1
;;    https://gist.github.com/tequilasunset/736979
;;    popup.el is needed, https://github.com/auto-complete/popup-el

      (require 'popup-keybindings)
;;
;;-----------------------------------------------------------------------------


;;-----------------------------------------------------------------------------
;;                                               保存時に最終行の改行を削除
;;-----------------------------------------------------------------------------

      (add-hook 'before-save-hook 'delete-trailing-whitespace)
;;
;;-----------------------------------------------------------------------------


;;-----------------------------------------------------------------------------
;;                                                                yasnippet
;;-----------------------------------------------------------------------------
;;
;;    https://github.com/capitaomorte/yasnippet
;;
      (add-to-list 'load-path "~/.emacs.d/plugins/yasnippet")
      (require 'yasnippet)
      (setq yas-snippet-dirs
        '("~/.emacs.d/plugins/yasnippet/snippets"          ;; personal snippets
        ;;"/path/to/some/collection/"            ;; just some foo-mode snippets
        ;;"/path/to/some/othercollection/"  ;; more foo-mode, complete baz-mode
        ;;"/path/to/yasnippet/snippets"               ;; the default collection
        ))
      (setq yas-prompt-functions '(yas-dropdown-prompt
                                   yas-ido-prompt
                                   yas-completing-prompt))
      (yas-global-mode 1)
     ;;(yas-minor-mode-on)
;;
;;-----------------------------------------------------------------------------
;;                                                            auto-complete
;;-----------------------------------------------------------------------------
;;
      (add-to-list 'load-path "~/.emacs.d/plugins/autocomplete")
      ;;(require 'auto-complete)
      (require 'auto-complete-config)

      (defun ac-yasnippet-candidates ()

(with-no-warnings

;; >0.6.0

(apply ‘append (mapcar ‘ac-yasnippet-candidate-1 (yas/get-snippet-tables)))

))


      (ac-config-default)
      (add-to-list 'ac-sources 'ac-source-yasnippet)
      (add-to-list 'ac-dictionary-directories
                      "~/.emacs.d/plugins/autocomplete/ac-dict")

      (global-auto-complete-mode t)

      ;;; yasnippetのbindingを指定するとエラーが出るので回避する方法。
(setf (symbol-function 'yas-active-keys)
      (lambda ()
        (remove-duplicates (mapcan #'yas--table-all-keys (yas--get-snippet-tables)))))

;;
;;(add-to-list 'ac-sources 'ac-source-yasnippet)
;;(add-to-list 'ac-dictionary-directories "~/.emacs.d/plugins/autocomplete/ac-dict")
;;;;(global-auto-complete-mode t)
;;(setq ac-expand-on-auto-complete nil)
;;(setq ac-auto-start nil)
;;;;(setq ac-dwim nil) ; To get pop-ups with docs even if a word is uniquely completed

;;----------------------------------------------------------------------------
;; Use Emacs' built-in TAB completion hooks to trigger AC (Emacs >= 23.2)
;;----------------------------------------------------------------------------
;;(setq tab-always-indent 'complete) ;; use 't when auto-complete is disabled
;;(add-to-list 'completion-styles 'initials t)

;; TODO: find solution for php, c++, haskell modes where TAB always does something

;; hook AC into completion-at-point
;;(defun sanityinc/auto-complete-at-point ()
  ;;(when (and (not (minibufferp))
;;(fboundp 'auto-complete-mode)
;;auto-complete-mode)
  ;;  (auto-complete)))

;;(defun set-auto-complete-as-completion-at-point-function ()
  ;;(add-to-list 'completion-at-point-functions 'sanityinc/auto-complete-at-point))

;;(add-hook 'auto-complete-mode-hook 'set-auto-complete-as-completion-at-point-function)


;;(set-default 'ac-sources
  ;;           '(ac-source-imenu
    ;;           ac-source-dictionary
      ;;         ac-source-words-in-buffer
        ;;       ac-source-words-in-same-mode-buffers
          ;;     ac-source-words-in-all-buffer))

;;(dolist (mode '(magit-log-edit-mode log-edit-mode org-mode text-mode haml-mode
  ;;              sass-mode yaml-mode csv-mode espresso-mode haskell-mode
    ;;            html-mode nxml-mode sh-mode smarty-mode clojure-mode
      ;;          lisp-mode textile-mode markdown-mode tuareg-mode
        ;;        js3-mode css-mode less-css-mode sql-mode ielm-mode))
  ;;(add-to-list 'ac-modes mode))


;; Exclude very large buffers from dabbrev
(defun sanityinc/dabbrev-friend-buffer (other-buffer)
  (< (buffer-size other-buffer) (* 1 1024 1024)))

(setq dabbrev-friend-buffer-function 'sanityinc/dabbrev-friend-buffer)
;;-----------------------------------------------------------------------------
;;                                                                   aspell
;;-----------------------------------------------------------------------------
;;
;;    http://www.emacswiki.org/emacs/AspellWindows
;;    more http://www.ibm.com/developerworks/cn/linux/l-cn-emacs-spllchk/
;;
      (add-to-list 'exec-path "C:/Program Files/Aspell/bin/")
      (setq-default ispell-program-name "aspell")
      (global-set-key (kbd "C-<f8>") 'flyspell-mode)
;;
;;-----------------------------------------------------------------------------


;;-----------------------------------------------------------------------------
;;                                                                   popwin
;;-----------------------------------------------------------------------------
;;
;;    https://github.com/m2ym/popwin-el
;;    close the popup window smoothly by typing 'C-g' in anytime.
;;
      (require 'popwin)
      (popwin-mode 1)
;;
;;------------------------------------------------------------------------------


;;------------------------------------------------------------------------------
;;                                                               japan-color
;;------------------------------------------------------------------------------
;;
;;    http://d.hatena.ne.jp/tequilasunset/20100225/p1
;;    usage: M-x list-jpncolors-display
;;    modify line 528
;;    "(indent-to (max (- (window-width) 8) 44))" to
;;    "(indent-to (max (- (window-width) 16) 44))"
;;
      (require 'jpncolor)
;;    (set-jpncolor-foreground 'face "color")
;;    (set-jpncolor-background 'face "color")
;;
;;------------------------------------------------------------------------------


;;------------------------------------------------------------------------------
;;                                                     file-column-indicator
;;------------------------------------------------------------------------------
;;    https://github.com/alpaker/Fill-Column-Indicator
;;    http://emacswiki.org/emacs/FillColumnIndicator
;;    read through the whole wiki to get the shit correct setup
;;    try RTFM always quickly and effectively
;;
    (require 'fill-column-indicator)
    (define-globalized-minor-mode global-fci-mode
                                  fci-mode (lambda () (fci-mode 1)))
    (global-fci-mode 1)
    (setq-default fill-column 80)
    (setq fci-rule-column 81)
    (setq fci-rule-use-dashes 1)
    (setq fci-dash-pattern 0.1)
    ;;(setq fci-rule-color "#6688ff")
    (setq fci-rule-color "#3498db")
;;-----------------------------------------------------------------------------


;;-----------------------------------------------------------------------------
;;  flymake
;;-----------------------------------------------------------------------------
;; https://github.com/purcell/flymake-ruby
;; http://mtoou.info/ruby-emacs-ide/ & rspec-mode both need check later

(require 'flymake-easy)
(require 'flymake-ruby) ; flymake ruby
;;-----------------------------------------------------------------------------


;;-----------------------------------------------------------------------------
;;  yaml-mode
;;-----------------------------------------------------------------------------
;; https://github.com/yoshiki/yaml-mode
;; http://www.yaml.org/

;;(add-to-list 'load-path "/Users/ice/.emacs.d/plugins/yaml-mode")
;;(require 'yaml-mode)
;;(add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))
;;(add-hook 'yaml-mode-hook
  ;;    '(lambda ()
    ;;    (define-key yaml-mode-map "\C-m" 'newline-and-indent)))
;;-----------------------------------------------------------------------------


;;-----------------------------------------------------------------------------
;;  haml-mode
;;-----------------------------------------------------------------------------
;; https://github.com/nex3/haml-mode
;; http://haml-lang.com

(require 'haml-mode)
;;-----------------------------------------------------------------------------



;;-----------------------------------------------------------------------------
;;                                                              yes/no 選択
;;-----------------------------------------------------------------------------
;;
      (fset 'yes-or-no-p 'y-or-n-p)                           ; y/nで選択
      (define-key query-replace-map [return] 'act)            ; RETでyes選択
;;
;;-----------------------------------------------------------------------------


;;-----------------------------------------------------------------------------
;;                                                          smart-open-line
;;-----------------------------------------------------------------------------
;;
;;    http://emacsredux.com/blog/2013/03/26/smarter-open-line/
;;    insert an empty line after the current line.
;;    position the cursor at its beginning, according to the current mode.
;;
      (defun smart-open-line ()
        (interactive)
          (move-end-of-line nil)
            (newline-and-indent))
      (global-set-key [(shift return)] 'smart-open-line)
;;
;;-----------------------------------------------------------------------------


;;-----------------------------------------------------------------------------
;;  ack
;;-----------------------------------------------------------------------------
;; https://github.com/leoliu/ack-el
;; http://betterthangrep.com/
;;(add-to-list 'load-path "/Users/ice/.emacs.d/plugins/ack-el")

;;(require 'ack)
;;-----------------------------------------------------------------------------
;;                                                            hippie-expand
;;-----------------------------------------------------------------------------
;;
;;    http://www.emacswiki.org/emacs/HippieExpand
;;
      (global-set-key (kbd "M-/") 'hippie-expand)
      (setq hippie-expand-try-functions-list
      '(try-complete-file-name-partially
        try-complete-file-name
        try-expand-dabbrev
        try-expand-dabbrev-all-buffers
        try-expand-dabbrev-from-kill))
;;
;;-----------------------------------------------------------------------------
;;                                                      multi-cursor-select
;;-----------------------------------------------------------------------------
;;
;;    https://github.com/magnars/multiple-cursors.el
;;    http://emacsrocks.com/e13.html
;;
      (add-to-list 'load-path "~/.emacs.d/plugins/multiple-cursors")
      (require 'multiple-cursors)
      (global-set-key (kbd "C->") 'mc/mark-next-like-this)
      (global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
      (global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)
;;
;;------------------------------------------------------------------------------


;;------------------------------------------------------------------------------
;;                                                              join-line-up
;;------------------------------------------------------------------------------
;;
;;    with point anywhere on the first line
;;    simply press 'M-j' multiple times to pull the lines up
;;
      (global-set-key (kbd "M-j")
          (lambda ()
              (interactive)
              (join-line -1)))
;;
;;------------------------------------------------------------------------------


;;------------------------------------------------------------------------------
;;                    nicer naming of buffers for files with identical names
;;------------------------------------------------------------------------------

      (require 'uniquify)
      (setq uniquify-buffer-name-style 'reverse)
      (setq uniquify-separator " • ")
      (setq uniquify-after-kill-buffer-p t)
      (setq uniquify-ignore-buffers-re "^\\*")
;;
;;------------------------------------------------------------------------------


;;------------------------------------------------------------------------------
;;                                                              things to do
;;------------------------------------------------------------------------------
;;
;;     1. popup menus' font color (lightblue, bold), background color
;;     2. https://github.com/bbatsov/prelude
;;     3. http://emacsredux.com/
;;     4. read the article in the 'diminish.el' file
;;     5. code folding with little triangle in the fringe area, CEDET has this
;;        function (global-semantic-tag-folding-mode 1) --> cedet.sourceforge.net
;;        but it is not so good to use just the folding function while has to
;;        install the whole CEDET, it is not so useful and will slow down Emacs
;;     6. http://whattheemacsd.com/
;;     7. always check this site first to update configuration:
;;        https://github.com/purcell/emacs.d
;;     8. http://www.emacswiki.org/emacs/DiredPlus
;;     9. http://www.emacswiki.org/emacs/FlyMake
;;        http://www.emacswiki.org/emacs/FlymakeCursor
;;        https://github.com/purcell/emacs.d/blob/master/init-flymake.el
;;    10. use hunspell
;;        http://ergoemacs.org/emacs/emacs_spell_checker_problems.html
;;    11.
;;
;;------------------------------------------------------------------------------
