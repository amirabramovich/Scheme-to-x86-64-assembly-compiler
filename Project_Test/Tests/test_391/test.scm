 
          (define caar (lambda (pair) (car (car pair))))
          (define cadr (lambda (pair) (car (cdr pair))))
          (define cddr (lambda (pair) (cdr (cdr pair))))
          (define cdar (lambda (pair) (cdr (car pair))))
          (define caaar (lambda (pair) (car (caar pair))))
          (define caadr (lambda (pair) (cdr (car pair))))
          (define cdaar (lambda (pair) (cdr (caar pair))))
          (define cdadr (lambda (pair) (cdr (cadr pair))))
          (define cddar (lambda (pair) (cdr (cdar pair))))
          (define cdddr (lambda (pair) (cdr (cddr pair)))) 

         (define product$
          (lambda (ls k)
            (let ([break k])
              (letrec ([f (lambda (ls k) 
                (cond
                  [(null? ls) (k 1)]
                  [(= (car ls) 0) (break 0)]
                  [else (f (cdr ls)
                          (lambda (x)
                            (k (* (car ls) x))))]))])
                (f ls k)))))

        (product$ '(1 2 3 4 5) (lambda (x) x))
        (product$ '(7 3 8 0 1 9 5) (lambda (x) x))
        (product$ '(7 3 8 1 1 912 5) (lambda (x) x))  
    