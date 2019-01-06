   
                (define foo 6)
                (define n 0)

                (set! foo (lambda (x  h)
                                (if (null? h)
                                    (begin (set! n (+ n 1))
                                     n)
                                (cons x (foo (car h) (cdr h))) 
                                )
                            )
                 )

        (foo "a" '("b" "c" "d" "e" "f" "g" "h" "i" "j" "k" "l" "m" "n" "o" "p" "q" "r" "s" "t" "u" "v" "w" "x" "y" "z"))
    