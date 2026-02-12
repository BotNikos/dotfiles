#! /usr/local/bin/csi -script

(import (chicken io)
	(chicken process)
	(chicken format))


(define (perc-to-int str)
  (let ((str (symbol->string str)))
    (string->number (substring str 0 (sub1 (string-length str))))))

(define (notify-send data)
  (when (and (eq? (car data) 'Discharging) (<= (perc-to-int (cdr data)) 20))
    (process-wait (process-run "notify-send" `("-t"
					       "0"
					       "-u"
					       "critical"
					       "Low battery ⚡"
					       ,(format "Your charge on ~a\nDo something or you will die!" (cdr data)))))))

(define (main)
  (let-values (((i o p) (process "acpi" '("-b"))))
    (let ((data (read-list i)))
      (notify-send (cons (caddr data)
			 (cadr (cadddr data))))))
  ;; Sleep for 10 min
  (sleep (* 60 10))
  (main))

(main)
