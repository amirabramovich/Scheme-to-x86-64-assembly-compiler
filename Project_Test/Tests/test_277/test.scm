
              (define append
                  (let ((null? null?) (car car) (cdr cdr) (cons cons))
                    (lambda args
                      ((letrec ((f (lambda (ls args)
                                    (if (null? args)
                                        ls
                                        ((letrec ((g (lambda (ls)
                                                        (if (null? ls)
                                                            (f (car args) (cdr args))
                                                            (cons (car ls) (g (cdr ls)))))))
                                            g) ls)))))
                        f) '() args))))
    