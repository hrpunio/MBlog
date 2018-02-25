; Run geocodeCoder0.pl with region content as -a option
; Result is displayed in *Shell Command Output* buffer
(defun My-GGeoceoder (begin end)
  (interactive "r")
  (shell-command-on-region begin end
      (concat "geocodeCoder0.pl -a "
	  (buffer-substring begin end)) ))
