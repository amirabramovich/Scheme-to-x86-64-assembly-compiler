   
        (define foo (lambda (x t y) "\n \r \f this is \n \r \f " 55 '#(5 6 7 8)
                                t))
        (apply foo '(1 2 3))
    