   
            (define a 'alpha)
            (define b 'beta)

            ((lambda (x y)
              (set! y a)
              (eq? a b)) a b)
	
    