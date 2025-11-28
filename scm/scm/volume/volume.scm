#! /usr/bin/csi -script

(import (chicken process)
	(chicken format)
	(chicken io))

(define (notify-volume volume-f)
  (let ((volume-p (inexact->exact (truncate  (* volume-f 100)))))
    (process-wait (process-run "notify-send" `("-t"
					       "2000"
					       "-a"
					       "wp-vol"
					       "-h"
					       ,(format "int:value:~a" volume-p)
					       ,(format " ~a/100" volume-p))))))

(let-values (((i o p) (process "wpctl" '("get-volume" "@DEFAULT_AUDIO_SINK@"))))
  (notify-volume (cadr (read-list i))))

