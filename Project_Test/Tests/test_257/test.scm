   
            ;;
            ;; Function: partition
            ;; -------------------
            ;; Takes a pivot and a list and produces a pair two lists.
            ;; The first of the two lists contains all of those element less than the
            ;; pivot, and the second contains everything else. Notice that
            ;; the first list pair every produced is (() ()), and as the
            ;; recursion unwinds exactly one of the two lists gets a new element
            ;; cons'ed to the front of it.
            ;;
            (define cadr (lambda (pair) (car (cdr pair))))
            (define (partition pivot num-list)
            (if (null? num-list) '(() ())
            (let ((split-of-rest (partition pivot (cdr num-list))))
            (if (< (car num-list) pivot)
            (list (cons (car num-list) (car split-of-rest))
            (cadr split-of-rest))
            (list (car split-of-rest) (cons (car num-list)
            (car (cdr split-of-rest))))))))    

            (partition 5 '(6 4 3 7 8 2 1 9 11))
            (partition 2 '(6 4 3 7 8 2 1 9 11))
            (partition 8 '(6 4 3 7 8 2 1 9 11))
            (partition 15 '(6 4 3 7 8 2 1 9 11 66 33 44 55 10 2 4 5.5 3.3 7 232432 24234)) 
    