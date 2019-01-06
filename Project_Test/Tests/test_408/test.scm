   
                      (define foo (lambda (x)
                      (cons
                        (begin (lambda () (set! x 1) 'void))
                        (lambda () x))))
              (define p (foo 2))

              (define x ((cdr p)))
              (define y ((car p)))
              (define z ((cdr p)))


              (cons  x (cons y (cons z'())))
		
	
    