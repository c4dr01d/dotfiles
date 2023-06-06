;; -*- lexical-binding: t -*-
(setq w32-lwindow-modifier 'super)
(setq w32-apps-modifier 'hyper)
(w32-register-hot-key [s-t])

(setq w32-get-true-file-attributes nil)
(setq w32-use-native-image-API t)
(setq w32-pipe-read-delay 0)
(setq w32-pipe-buffer-size (* 64 1024))
(provide 'init-windows)
