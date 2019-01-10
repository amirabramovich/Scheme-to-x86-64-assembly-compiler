  
            (define (member x list)
                (if (null? list) #f                                
                    (if (equal? x (car list)) #t                   
                        (member x (cdr list))))) 

            (define set-union
            (lambda (s1 s2)
            (cond ((null? s1) s2)
            ((member (car s1) s2)
            (set-union (cdr s1) s2))
            (else (cons (car s1)
            (set-union (cdr s1) s2))))))

            (set-union (list 1 2 3 4) (list 6 4 8 2))
    