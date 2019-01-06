   
                  (define + 5)
                  (define +
                    (let ((null? null?)(+ +)(car car)(apply apply)(cdr cdr))
                      (letrec ((loop (lambda x (if (null? x) 0 (+ (car x) (apply loop (cdr x)))))))
                        loop)))
    