   
            (define (distrib L E)
                (if (null? L)
                '()
                (cons (cons E (car L))
                (distrib (cdr L) E))
                )
                ) 

            (define (extend L E)
                (append L (distrib L E))
                )  

            (extend '( () (a) ) 'b)
    