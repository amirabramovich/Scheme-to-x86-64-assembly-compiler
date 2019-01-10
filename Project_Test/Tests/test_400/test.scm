   
          (define a 'alpha)
          (define b 'beta)

          ((lambda (x y)
            (begin
              (set! y  "alpha")
              (eq? x y))) a b)
	
    