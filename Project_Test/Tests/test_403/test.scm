   
            (define foo
            (lambda (n e)
              (if (= 0 (/ n 2))
                (foo (/ n 2) (+ e 1))
                e)))

            (foo 64 0)
	
    