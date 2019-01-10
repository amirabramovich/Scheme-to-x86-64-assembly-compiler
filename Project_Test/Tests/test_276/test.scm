   
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

            (define (subsets L)
                (if (null? L)
                (list '())
                (extend (subsets (cdr L))
                (car L))
                ))  

        (subsets '(1 2) )
        (subsets '(1 2 3))
          
    