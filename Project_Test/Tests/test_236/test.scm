   
            (define filter-numbers
                (lambda (lis)
                (cond ((null? lis) lis)
                ((number? (car lis))
                (cons (car lis) (filter-numbers (cdr lis))))
                (else (filter-numbers (cdr lis))))))     

                (filter-numbers '(1 one 2 two foo zero 22.7 0))   
    