   
                  (define map
                    (let ((null? null?) (cons cons) (apply apply) (car car) (cdr cdr))
                      (lambda (f ls . more)
                        (if (null? more)
                      (let ([ls ls])
                        (letrec ((map1 (lambda (ls) 
                            (if (null? ls)
                          '()
                          (cons (f (car ls))
                                (map1 (cdr ls)))) )))
                          (map1 ls))
                        )
                      (let ([ls ls] [more more])
                        (letrec ((map-more (lambda (ls more)
                          (if (null? ls)
                              '()
                              (cons
                                (apply f (car ls) (map car more))
                                (map-more (cdr ls) (map cdr more)))))))
                          (map-more ls more))
                        )))))
    