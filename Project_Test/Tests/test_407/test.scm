   
                      (define fraction? (lambda (x) (and (number? x) (not (integer? x)))))

                      ((lambda (x)
                          (cond 
                            ((integer? x) "integer")
                            ((fraction? x) "fraction")
                            ((char? x) "char")
                            ((symbol? x) "symbol")
                            ((boolean? x) "boolean")
                            ((procedure? x) "procedure")
                            (else "nothing"))) 'x)
	
    