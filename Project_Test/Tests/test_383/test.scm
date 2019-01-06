   
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

           (define assq
                (lambda (x ls)
                  (cond
                    [(null? ls) #f]
                    [(eq? (caar ls) x) (car ls)]
                    [else (assq x (cdr ls))])))

            (assq 'b '((a . 1) (b . 2)))
            (cdr (assq 'b '((a . 1) (b . 2))))
            (assq 'c '((a . 1) (b . 2)))
    