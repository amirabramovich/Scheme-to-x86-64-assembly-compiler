
              (define length
                  (let ((null? null?) (pair? pair?) (cdr cdr) (+ +))
                    (lambda (x)
                      (letrec ((count 0) (loop (lambda (lst count)
                        (cond ((null? lst) count)
                              ((pair? lst) (loop (cdr lst) (+ 1 count)))
                              (else "this should be an error, but you don't support exceptions")))))
                  (loop x 0)))))
    