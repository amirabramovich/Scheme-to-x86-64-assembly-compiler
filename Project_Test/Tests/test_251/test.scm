   

            ;;
            ;; Function: factorial
            ;; -------------------
            ;; Traditional recursive formulation of the most obvious recursive
            ;; function ever. Note the use of the built-in zero?
            ;; to check to see if we have a base case.
            ;;
            ;; What's more impressive about this function is that it demonstrates
            ;; how Scheme can represent arbitrarily large integers. Type
            ;; in (factorial 1000) and see what you get. Try doing *that* with
            ;; C or Java.
            ;;

            (define (factorial n)
                (if (zero? n) 1
                (* n (factorial (- n 1)))))  

            (factorial 0)
            (factorial 1)
            (factorial 2)
            (factorial 3)
            (factorial 4)
            (factorial 5)
            (factorial 6)
            (factorial 7)
            (factorial 8)
            (factorial 9)
            (factorial 10)
            (factorial 11)
            (factorial 12)
            (factorial 13)
            (factorial 14)
            (factorial 15)
            (factorial 16)
            (factorial 17)
            (factorial 18)
            (factorial 19)
            (factorial 20)
    