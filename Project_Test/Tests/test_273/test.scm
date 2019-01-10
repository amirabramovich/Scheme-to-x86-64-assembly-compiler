   
            (define (revall L)
                (if (null? L)
                L
                (let ((E (if (list? (car L))
                (revall (car L))
                (car L) )))
                (append (revall (cdr L))
                (list E))
                )
                ))     

                (revall '( (1 2) (3 4)))
    