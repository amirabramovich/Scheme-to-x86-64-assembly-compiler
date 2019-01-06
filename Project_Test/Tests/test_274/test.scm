   
            (define (distrib L E)
                (if (null? L)
                '()
                (cons (cons E (car L))
                (distrib (cdr L) E))
                )
                )   
            (distrib '(() (1) (2) (1 2)) 3) 
    