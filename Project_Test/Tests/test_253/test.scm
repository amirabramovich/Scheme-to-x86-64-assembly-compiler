   
            ;;
            ;; Function: fast-fibonacci
            ;; ------------------------
            ;; Relies on the services of a helper function to
            ;; generate the nth fibonacci number much more quickly. The
            ;; key observation here: the nth number is the Fibonacci
            ;; sequence starting out 0, 1, 1, 2, 3, 5, 8 is the (n-1)th
            ;; number in the Fibonacci-like sequence starting out with
            ;; 1, 1, 2, 3, 5, 8. The recursion basically slides down
            ;; the sequence n or so times in order to compute the answer.
            ;; As a result, the recursion is linear instead of binary, and it
            ;; runs as quickly as factorial does.
            ;;
            (define (fast-fibonacci n)
            (fast-fibonacci-helper n 0 1))

            (define (fast-fibonacci-helper n base-0 base-1)
            (cond ((zero? n) base-0)
            ((zero? (- n 1)) base-1)
            (else (fast-fibonacci-helper (- n 1) base-1 (+ base-0 base-1)))))  

            (fast-fibonacci 0)
            (fast-fibonacci 1)
            (fast-fibonacci 2)
            (fast-fibonacci 3)
            (fast-fibonacci 4)
            (fast-fibonacci 5)
            (fast-fibonacci 6)
            (fast-fibonacci 7)
            (fast-fibonacci 8)
            (fast-fibonacci 9)
            (fast-fibonacci 10)
            (fast-fibonacci 11)
            (fast-fibonacci 12)
            (fast-fibonacci 13)
            (fast-fibonacci 14)
            (fast-fibonacci 15)
            (fast-fibonacci 16)
            (fast-fibonacci 17)
            (fast-fibonacci 18)
            (fast-fibonacci 19)  
    