   

            ;;
            ;; Function: fibonacci
            ;; -------------------
            ;; Traditional recursive implementation of
            ;; the fibonacci function. This particular
            ;; implementation is pretty inefficient, since
            ;; it makes an exponential number of recursive
            ;; calls.
            ;;
            (define (fibonacci n)
            (if (< n 2) n
            (+ (fibonacci (- n 1))
            (fibonacci (- n 2)))))    

            (fibonacci 0)
            (fibonacci 1)
            (fibonacci 2)
            (fibonacci 3)
            (fibonacci 4)
            (fibonacci 5)
            (fibonacci 6)
            (fibonacci 7)
            (fibonacci 8)
            (fibonacci 9)
            (fibonacci 10)
            (fibonacci 11)
            (fibonacci 12)
            (fibonacci 13)
            (fibonacci 14)
            (fibonacci 15)
            (fibonacci 16)
            (fibonacci 17)
            (fibonacci 18)
            (fibonacci 19)
    