   
            (define deep-member
            (lambda (a s)
            (or (equal? a s)
            (and (pair? s)
            (or (deep-member a (car s))
            (deep-member a (cdr s)))))))  

            (deep-member 'foo '(a b (c (d e foo g)) h)) 
            (deep-member 'foo '(a b (c (d e bar g)) h)) 
    