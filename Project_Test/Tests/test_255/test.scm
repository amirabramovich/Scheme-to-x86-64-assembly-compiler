   
            ;;
            ;; Function: triple-everything
            ;; ---------------------------
            ;; Takes a list of integers (identified by sequence)
            ;; and generates a copy of the list, except that
            ;; every integer in the new list has been tripled.
            ;;
            (define (triple-everything numbers)
            (if (null? numbers) '()
            (cons (* 3 (car numbers)) (triple-everything (cdr numbers)))))    

            (triple-everything '())
            (triple-everything '(1))
            (triple-everything '(1 2))
            (triple-everything '(1 2 3 4))
            (triple-everything '(1 2 3 4 5 6))
            (triple-everything '(1 2 3 4 5 6 7 8 9 10))
            (triple-everything '(1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40))

    