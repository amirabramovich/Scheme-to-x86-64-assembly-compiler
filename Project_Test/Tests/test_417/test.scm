   
                      (define ascii 
                      (lambda ()
                        (letrec ((loop (lambda (i)
                                (if (< i 127)
                                  (cons (integer->char i) (loop (+ 1 i)))
                                  '()))))
                          (loop (char->integer #\space)))))

                    (ascii)
		
    