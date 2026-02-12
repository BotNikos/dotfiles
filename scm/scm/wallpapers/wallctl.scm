#! /usr/local/bin/csi -script

(import (chicken process)
	(chicken process signal)
	(chicken process-context))

(define (next-wall pid)
  (process-signal pid signal/usr1))

(define (main arg)
  (let ((wall-proc-pid (with-input-from-file "/tmp/wallpapers.pid" (lambda () (read)))))
    (case (string->symbol arg)
      ((next) (next-wall wall-proc-pid)))))

(main (car (command-line-arguments)))
