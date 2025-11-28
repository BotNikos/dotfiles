#! /usr/bin/csi -script

(import (chicken base)
	(chicken process)
	(chicken format)
	(chicken random)
	(chicken process-context))

(define titles '("Time to rest 🖥️"
		 "Take your time 💤"
		 "Time's up ⏱️"
		 "Look away 🌿"
		 "Take care of your eyes 👀"))

(define (notify)
  (process-wait (process-run "notify-send" `("-u"
					     "low"
					     ,(list-ref titles (pseudo-random-integer (length titles)))
					     ,(format  "You've been looking on the screen ~a already. <i>Rest a little bit!</i>" (car (command-line-arguments)))))))

(define (convert-time time-string)
  (let ((units (string-ref time-string (- (string-length time-string) 1)))
	(value (string->number (substring time-string 0 (- (string-length time-string) 1)))))
    (case units
      ((#\s) value)
      ((#\m) (* value 60))
      ((#\h) (* value 60 60)))))

(define (tick time)
  (sleep time)
  (notify)
  (tick time))

(define (main time-string)
  (let ((time (convert-time time-string)))
    (tick time)))

(main (car (command-line-arguments)))
