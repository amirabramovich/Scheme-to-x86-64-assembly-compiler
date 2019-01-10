
              (define make-vector 5)
              (set! make-vector
                (let ((length length)(make-vector make-vector)(car car)(null? null?))
                  (lambda (x . y)
                    (cond ((null? y) (make-vector x 0))
                    ((= 1 (length y)) (make-vector x (car y)))
                    (else "this should be an error, but you don't support exceptions")))))
    