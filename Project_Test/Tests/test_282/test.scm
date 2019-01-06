
              (define make-string 5)
              (set! make-string
                (let ((null? null?)(make-string make-string)(car car)(= =)(length length))
                  (lambda (x . y)
                    (cond ((null? y) (make-string x #\nul))
                    ((= 1 (length y)) (make-string x (car y)))
                    (else "this should be an error, but you don't support exceptions")))))
    