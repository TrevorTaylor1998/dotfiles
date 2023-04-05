(setq display-line-numbers-type t)

;; (setq doom-font (font-spec :family "JetBrains Mono" :size 13))

(setq julia-snail-multimedia-enable t)

(defun mytest ()
  (interactive)
  (insert "sun and moon"))

(defun true-false-swap ()
  "swaps True and False still a tad picky on cursor position"
  (interactive)
  (cond ((equal (thing-at-point 'word) "True")
         (backward-kill-word 1)
         (kill-word 1)
         (insert "False"))
        ((equal (thing-at-point 'word) "False")
         (backward-kill-word 1)
         (kill-word 1)
         (insert "True"))
        (t
         (print "no"))))

;; (add-hook 'org-mode-hook 'org-download-enable)
;; (add-hook 'dired-mode-hook 'org-download-enable)
