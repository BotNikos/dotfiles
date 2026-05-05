#! /usr/local/bin/csi -script

(import (chicken process)
	(chicken io)
	(srfi-13)
	(cjson))

(define (convert-string str)
  (string-upcase (substring str 0 2)))

(define (notify str)
  (process-wait (process-run "notify-send" `("-t"
					     "2000"
					     "-a"
					     "wp-lang"
					     ,str))))

(let-values (((i o p) (process "niri msg --json keyboard-layouts")))
  (let ((json (string->json (read-line i))))
    (notify (convert-string (vector-ref (cdr (assoc 'names json))
					(inexact->exact (cdr (assoc 'current_idx json))))))))
