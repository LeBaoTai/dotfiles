(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name
        "straight/repos/straight.el/bootstrap.el"
        (or (bound-and-true-p straight-base-dir)
            user-emacs-directory)))
      (bootstrap-version 7))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))
(setq package-enable-at-startup nil)

(straight-use-package 'use-package)
(setq straight-use-package-by-default t)

(defun reload-init-file ()
  (interactive)
  (load-file user-init-file))

;; ==========================================
;; CẤU HÌNH VERTICO + ORDERLESS (STRAIGHT.EL)
;; ==========================================
;; 1. Cài đặt và kích hoạt Vertico (Giao diện danh sách dọc)
(use-package vertico
  :straight t
  :init
  (vertico-mode 1)
  :custom
  (vertico-count 12)       ; Hiển thị tối đa 12 dòng gợi ý
  (vertico-resize nil)     ; Cố định chiều cao minibuffer để giao diện không bị giật lag
  (vertico-cycle t))       ; Cuộn tròn danh sách khi đi hết hàng


;; 2. Cài đặt và cấu hình Orderless (Bộ lọc tìm kiếm linh hoạt)
(use-package orderless
  :straight t
  :custom
  ;; Định nghĩa các kiểu hoàn thành (completion styles)
  (completion-styles '(orderless basic))
  ;; Hỗ trợ hoàn thành tệp tin khi sử dụng TRAMP (kết nối từ xa)
  (completion-category-overrides '((file (styles partial-completion)))))

;; 3. Cấu hình Minibuffer và giao diện gốc của Emacs
(use-package emacs
  :init
  ;; Xóa màn hình chào mừng mặc định khi khởi động
  (setq inhibit-startup-screen t)
  (setq native-comp-async-report-warnings-errors 'silent)
  (setq warning-minimum-level :error)
  (setq create-lockfiles nil)

  ;; ido mode
  (require 'ido)
  (ido-mode 1)
  (ido-everywhere 1)

  (setq make-backup-files nil)   ; Tắt hoàn toàn việc tạo file đuôi ~
  (setq auto-save-default nil)   ; Tắt hoàn toàn việc tạo file dạng #file#
  (setq compile-command nil)     ; remove all command will be input automatically

  ;; Chỉ phóng to hết cỡ (Maximized) chứ không chiếm toàn màn hình (Fullscreen)
  (add-to-list 'default-frame-alist '(fullscreen . maximized))
  (global-display-line-numbers-mode 1)
  (setq display-line-numbers-type 'relative)
  (setq display-line-numbers-current-absolute t)
  (setq display-line-numbers-grow-only nil)
  (setq display-line-numbers-width nil)   ; để Emacs tự tính độ rộng
  
  ;; 1. Đặt phông chữ mặc định toàn hệ thống (Cỡ chữ 13, nét Regular)
  (set-face-attribute 'default nil
                      :font "Maple Mono NF CN"
                      :height 140
                      :weight 'regular)

  ;; 2. Định dạng chữ nghiêng (Italic) cho phần chú thích (Comment)
  (set-face-attribute 'font-lock-comment-face nil
                      :slant 'italic)

  ;; 3. Định dạng chữ nghiêng (Italic) cho các từ khóa lập trình (Keyword)
  (set-face-attribute 'font-lock-keyword-face nil
                      :slant 'italic)

  ;; 4. Đảm bảo khi mở thêm Frame/Cửa sổ mới, phông chữ vẫn giữ nguyên cỡ 13
  (add-to-list 'default-frame-alist '(font . "Maple Mono NF CN-14"))
  ;; Cấu hình khoảng cách giữa các dòng
  (setq-default line-spacing 0.12)

  ;; Hiển thị số cột ở thanh trạng thái (mode-line)
  (column-number-mode t)

  ;; Tắt tiếng bíp thông báo phiền phức
  (setq ring-bell-function 'ignore)

  ;; Hiển thị gợi ý ngay cả khi không khớp chính xác chữ hoa/chữ thường
  (setq read-buffer-completion-ignore-case t)
  (setq read-file-name-completion-ignore-case t)
  (setq completion-ignore-case t)

  ;; Không tự động hoàn thành khi nhấn Tab nếu minibuffer đang trống
  (setq tab-always-indent 'complete)
  
  ;; Ẩn các thanh công cụ để giao diện sạch sẽ, tối giản
  (menu-bar-mode -1)            ; Ẩn thanh menu
  (tool-bar-mode -1)            ; Ẩn thanh công cụ
  (scroll-bar-mode -1)          ; Ẩn thanh cuộn
  (electric-pair-mode 1)

  ;; Bật chế độ tự động xuống dòng trực quan toàn cục
  (global-visual-line-mode t)
  
  ;; Tự động bật số dòng (tương đối) cho các mode lập trình, văn bản, cấu hình
  (dolist (mode '(text-mode-hook
                  prog-mode-hook
                  conf-mode-hook))
    (add-hook mode (lambda () (display-line-numbers-mode 1))))

  ;; Tự reload file khi nó bị thay đổi bên ngoài Emacs
  (global-auto-revert-mode 1)

  ;; Tự refresh cả Dired (và các buffer không phải file)
  (setq global-auto-revert-non-file-buffers t)

  ;; Không hiện thông báo "Reverting buffer..." mỗi lần refresh
  (setq auto-revert-verbose nil)

  :bind
  ;; Gán các phím tắt phóng to/thu nhỏ chữ và reset về mặc định
  (("<escape>" . keyboard-escape-quit)
   ("M-o" . other-window)
   ("M-;" . execute-extended-command)
   ("C-=" . text-scale-increase)
   ("C--" . text-scale-decrease)
   ("C-0" . (lambda () (interactive) (text-scale-set 0)))
   ("<C-wheel-up>" . text-scale-increase)
   ("<C-wheel-down>" . text-scale-decrease)))

;; 4. Cài đặt và cấu hình Marginalia (Thêm chú thích chi tiết cho danh sách)
(use-package marginalia
  :straight t
  :bind (:map minibuffer-local-map
         ("M-A" . marginalia-cycle))
  :init
  (marginalia-mode 1))

;; 5. Cài đặt và cấu hình Consult (Hệ thống tìm kiếm nâng cao)
(use-package consult
  :straight t
  :bind (("C-s" . consult-line)          ; Tìm kiếm từ khóa trong buffer hiện tại
         ("C-x b" . consult-buffer)      ; Chuyển đổi qua lại giữa các buffer
         ("M-y" . consult-yank-pop)      ; Xem lịch sử copy để paste
         ("M-g g" . consult-goto-line)   ; Nhảy đến dòng mong muốn kèm live preview
         ("M-i" . consult-imenu))        ; Xem nhanh cấu trúc hàm/biến trong file
  :init
  (setq consult-preview-key 'any)
  :config
  (setq consult-async-split-style 'perl)
  (setq consult-async-split-transform 'consult--async-split-perl)
  (setq consult-async-input-debounce 0)
  (setq consult-async-input-throttle 0))

;; 6. Cấu hình Icons hiển thị đồ họa
(use-package nerd-icons
  :straight t)

(use-package nerd-icons-completion
  :straight t
  :after (marginalia nerd-icons)
  :init
  (nerd-icons-completion-mode 1)
  :config
  (add-hook 'marginalia-mode-hook #'nerd-icons-completion-marginalia-setup))

;; Thêm Icon vào giao diện Dired để đồng bộ với Vertico
(use-package nerd-icons-dired
  :straight t
  :hook (dired-mode . nerd-icons-dired-mode))

;; =============================================================================
;; THEME
;; =============================================================================
(use-package doom-themes
  :straight t
  :config
  (load-theme 'doom-one t)
  (set-face-attribute 'line-number-current-line nil
                    :inherit nil
                    :foreground "#ff9e64"
                    :background 'unspecified
                    :box nil
                    :underline nil
                    :overline nil
                    :inverse-video nil
                    :weight 'bold)
  (doom-themes-org-config))

;; =============================================================================
;; CẤU HÌNH HỆ THỐNG LSP (EGLOT TÍCH HỢP SẴN)
;; =============================================================================
(use-package eglot
  :straight nil ; Sử dụng eglot có sẵn trong Emacs 29+
  :hook
  ;; Tự động bật LSP khi mở các file Go, Terraform, và YAML
  ((go-mode . eglot-ensure)
   (terraform-mode . eglot-ensure)
   (yaml-mode . eglot-ensure))
  :config
  ;; Cấu hình thời gian trễ phản hồi của LSP xuống thấp (giảm giật lag)
  (setq eglot-connect-timeout 10)
  (setq eglot-events-buffer-size 0) ; Tắt logging để tăng hiệu năng gõ code

  ;; Tự động chạy format code (như gofmt) và sửa các dòng import mỗi khi lưu file (Ctrl+x Ctrl+s)
  (add-hook 'before-save-hook
            (lambda ()
              (when (eglot-managed-p)
                (eglot-format-buffer)))))

;; Cài đặt gói hiển thị thông tin lỗi ngay dưới dòng code (Flymake trực quan)
(use-package flymake
  :straight nil
  :bind (:map flymake-mode-map
              ("M-n" . flymake-goto-next-error)
              ("M-p" . flymake-goto-prev-error)))

;; =============================================================================
;; 1. CẤU HÌNH GOLANG
;; =============================================================================
(use-package go-mode
  :straight t
  :config
  ;; Thiết lập độ rộng ký tự Tab chuẩn của Go (bằng 4 khoảng trắng)
  (add-hook 'go-mode-hook
            (lambda ()
              (setq tab-width 4)
              (setq indent-tabs-mode t))))


;; =============================================================================
;; 2. CẤU HÌNH TERRAFORM
;; =============================================================================
(use-package terraform-mode
  :straight t
  :config
  ;; Tự động căn lề (indent) chuẩn cho các block tài nguyên của Terraform
  (add-hook 'terraform-mode-hook
            (lambda ()
              (setq-local tab-width 2)
              (setq-local indent-tabs-mode nil))))

;; =============================================================================
;; 3. CẤU HÌNH YAML & KUBERNETES
;; =============================================================================
(use-package yaml-mode
  :straight t
  :config
  ;; YAML bắt buộc dùng khoảng trắng thay cho dấu Tab thực tế
  (add-hook 'yaml-mode-hook
            (lambda ()
              (setq-local tab-width 2)
              (setq-local indent-tabs-mode nil)))

  ;; Nhận diện file cấu hình Kubernetes (nếu file có chữ k8s hoặc deployment, v.v...)
  (add-to-list 'auto-mode-alist '("\\.k8s\\.yaml\\'" . yaml-mode))
  (add-to-list 'auto-mode-alist '("deployment\\.yaml\\'" . yaml-mode)))

;; =============================================================================
;; CẤU HÌNH GIAO DIỆN TỰ ĐỘNG HOÀN THÀNH CODE (CORFU AUTO-COMPLETE)
;; =============================================================================
(use-package corfu
  :straight t
  ;; Cho phép corfu tự động chạy khi mở các bộ gõ lệnh
  :init
  (global-corfu-mode 1)
  :custom
  (corfu-auto t)                 ; TỰ ĐỘNG hiện bảng gợi ý khi bạn vừa gõ chữ (không cần bấm phím tắt)
  (corfu-auto-delay 0.0)         ; Thời gian chờ bật lên bằng 0 (hiện lập tức)
  (corfu-auto-prefix 1)          ; Chỉ cần gõ từ 1 ký tự là bảng gợi ý đã hiện ra ngay
  (corfu-cycle t)                ; Cho phép cuộn tròn danh sách lựa chọn gợi ý
  (corfu-quit-no-match 'separator) ; Tự động đóng bảng nếu gõ ký tự không khớp
  
  :config
  ;; Tích hợp danh sách phím tắt điều hướng trong bảng gợi ý cho Evil Mode
  ;; Giúp bạn dùng Ctrl+n (Next) và Ctrl+p (Previous) để chọn hàm/biến rất nhanh
  (with-eval-after-load 'evil
    (define-key corfu-map (kbd "C-n") 'corfu-next)
    (define-key corfu-map (kbd "C-p") 'corfu-previous)
    ;; Nhấn Escape để hủy/đóng bảng gợi ý quay về Normal Mode mượt mà
    (define-key corfu-map (kbd "<escape>") 'corfu-quit)))

;; ==========================================
;; CẤU HÌNH COMPILATION MODE
;; ==========================================

(require 'ansi-color)
;; Hiển thị đúng màu ANSI trong *compilation*
(add-hook 'compilation-filter-hook #'ansi-color-compilation-filter)
