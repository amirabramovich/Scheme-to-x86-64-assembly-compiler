   
           (begin
            ((lambda (x)
            x
                            ((lambda ()
                                ((lambda ()
                                '#(5 6 7 8)
                                55
                                "\n \r \f this is \n \r \f "
                                (set! x (set! x 4))
                                ))
                                ((lambda ()
                                (set! x 5)
                                ))
                            ))
                            ((lambda ()
                                (set! x 400)
                            
                            ))
            x
                            ) 100))    
    