 
          (letrec ((countdown (lambda (i)
                      (if (= i 0) 'liftoff
                          (begin
                            'finish
                            (countdown (- i 1)))))))
            (countdown 100))
    