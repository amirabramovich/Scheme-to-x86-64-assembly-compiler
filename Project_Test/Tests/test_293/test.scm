   
                  (define / 5)
                (define /
                    (let ((null? null?)(/ /)(* *)(car car)(apply apply)(length length)(cdr cdr))
                      (lambda num
                        (cond ((null? num) "this should be an error, but you don't support exceptions")
                        ((= (length num) 1) (/ 1 (car num)))
                        (else (/ (car num) (apply * (cdr num))))))))
    