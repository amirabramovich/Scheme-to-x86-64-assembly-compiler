   
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

           (define filter (lambda (p lst)
                      (if (null? lst)
                      '()
                      (let* ([hd (car lst)] [tl (cdr lst)] [rest (lambda () (filter p tl))])
                          (if (p hd)
                              (cons hd (rest))
                              (rest))))))
            
            (define even?
                        (lambda (x)
                          (or (= x 0)
                              (odd? (- x 1)))))

            (define odd?
              (lambda (x)
                (and (not (= x 0))
                      (even? (- x 1)))))

      (filter odd? '(1 2 3 4))
      (filter
        (lambda (x) (and (> x 0) (< x 10)))
        '(-5 15 3 14 -20 6 0 -9))
    