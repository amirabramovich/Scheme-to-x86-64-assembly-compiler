   
              (define list->vector
                (let ((null? null?)(pair? pair?)(car car)(cdr cdr)(make-vector make-vector)(length length)(+ +))
                  (lambda (lst)
                    (letrec ((loop (lambda (lst vec count)
                        (cond ((null? lst) vec)
                        ((pair? lst) (loop (cdr lst) (begin (vector-set! vec count (car lst)) vec) (+ 1 count)))
                        (else "this should be an error, but you don't support exceptions")))))
                (loop lst (make-vector (length lst)) 0)))))
    