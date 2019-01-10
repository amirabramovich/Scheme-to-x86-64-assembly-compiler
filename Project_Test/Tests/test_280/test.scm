
              (define list? 
                  (let ((null? null?) (pair? pair?) (cdr cdr))
                    (lambda (x)
                      (or (null? x)
                    (and (pair? x) (list? (cdr x)))))))
    