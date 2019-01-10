   
            ;;
            ; Function: sum
            ; -------------
            ; Computes the sum of all of the numbers in the specified
            ; number list. If the list is empty, then the sum is 0.
            ; Otherwise, the sum is equal to the value of the car plus
            ; the sum of whatever the cdr holds.
            ;;
            (define (sum ls)
            (if (null? ls) 0
            (+ (car ls) (sum (cdr ls)))))  

            (sum '())
            (sum '(1))
            (sum '(1 2))
            (sum '(1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40))

    