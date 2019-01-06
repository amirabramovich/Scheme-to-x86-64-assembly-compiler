   
           ;;
            ;; Function: flatten
            ;; -----------------
            ;; Takes an arbitrary list and generates a another list where all atoms of the
            ;; original are laid down in order as top level elements.
            ;;
            ;; In order for the entire list to be flattened, the cdr of the
            ;; list needs to be flattened. If the car of the entire list is a primitive
            ;; (number, string, character, whatever), then all we need to do is
            ;; cons that primitive onto the front of the recursively flattened cdr.
            ;; If the car is itself a list, then it also needs to be flattened.
            ;; The flattened cdr then gets appended to the flattened car.
            ;;
            (define (flatten sequence)
                (cond ((null? sequence) '())
                ((list? (car sequence)) (append (flatten (car sequence))
                (flatten (cdr sequence))))
                (else (cons (car sequence) (flatten (cdr sequence)))))) 

            (flatten '(1 (2) 3))   
            (flatten '((1) (2 3 4) (5 6)))
            (flatten '(a (b (c d (e) f (g h))) (i j)))
            (flatten '("nothing" "to" "flatten"))
    