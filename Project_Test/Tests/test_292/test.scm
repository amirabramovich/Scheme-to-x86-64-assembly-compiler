   
                (define - 5)
                (define -
                    (let ((null? null?)(- -)(+ +)(car car)(apply apply)(length length)(cdr cdr))
                      (letrec ((loop (lambda x (if (null? x) 0 (- (apply loop (cdr x)) (car x) )))))
                        (lambda num
                    (cond ((null? num) "this should be an error, but you don't support exceptions")
                          ((= (length num) 1) (- 0 (car num)))
                          (else (+ (car num) (apply loop (cdr num)))))))))
    