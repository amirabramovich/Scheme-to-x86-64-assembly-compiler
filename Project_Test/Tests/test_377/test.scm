   
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

           (define memp (lambda (p lst)
            (if (null? lst)
                #f 
                (if (p (car lst))
                    lst
                    (memp p (cdr lst))))))

            (define even?
                        (lambda (x)
                          (or (= x 0)
                              (odd? (- x 1)))))
            
            (define odd?
              (lambda (x)
                (and (not (= x 0))
                      (even? (- x 1)))))

    (memp odd? '(1 2 3 4))
    (memp even? '(1 2 3 4))
    (let ([ls (list 1 2 3 4)])
      (eq? (memp odd? ls) ls)) 
    (let ([ls (list 1 2 3 4)])
      (eq? (memp even? ls) (cdr ls))) 
    (memp odd? '(2 4 6 8))
    