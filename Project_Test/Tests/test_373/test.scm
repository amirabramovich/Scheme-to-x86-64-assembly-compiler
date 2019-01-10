   
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

        (define list?
        (lambda (x)
          (letrec ([race
                    (lambda (h t)
                      (if (pair? h)
                          (let ([h (cdr h)])
                            (if (pair? h)
                                (and (not (eq? h t))
                                    (race (cdr h) (cdr t)))
                                (null? h)))
                          (null? h)))])
            (race x x))))

        (define make-cyclic-pair (lambda (first second) 
                (let ([lst (list first second '())])
                (set-cdr! (cdr lst) lst) lst)))

        (define cyc-pair (make-cyclic-pair 'a 1))
        (list? cyc-pair)
        (list? '(1 2 3 4 6 6 8 #\a "ef"))   
    