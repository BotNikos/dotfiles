#! /usr/local/bin/csi -script

(import (chicken file)
	(chicken random)
	(chicken process)
	(chicken process signal)
	(chicken process-context)
	(chicken process-context posix))

(define (convert-time time-string)
  (let ((units (string-ref time-string (sub1 (string-length time-string))))
	(value (string->number (substring time-string 0 (sub1 (string-length time-string))))))
    (case units
      ((#\s) value)
      ((#\m) (* value 60))
      ((#\h) (* value 60 60)))))

(define (select-img path)
  (let* ((files (directory path #f))
	 (wall (list-ref files (pseudo-random-integer (length files)))))
    wall))

(define (show-wall time path)
  (let ((wall (select-img path)))
    (process-wait (process-run "awww" `("img" ,(string-append path wall) "-t" "random" "--transition-fps" "60")))
    (sleep time)
    (show-wall time path)))

(define (main time path)
  (show-wall (convert-time time) path))

(with-output-to-file "/tmp/wallpapers.pid" (lambda () (print (current-process-id))))
(set-signal-handler! signal/usr1 (lambda (signum) (void))) ;; When a signal alarms, all remaining sleep time is skipped
(main (car (command-line-arguments)) (cadr (command-line-arguments)))

