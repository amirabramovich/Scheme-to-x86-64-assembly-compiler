   
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

           (define assp (lambda (p lst)
                          (cond 
                              [(null? lst) #f]
                              [(p (caar lst)) (car lst)]
                              [else (assp p (cdr lst))])))
            
            (define even?
                        (lambda (x)
                          (or (= x 0)
                              (odd? (- x 1)))))
            
            (define odd?
              (lambda (x)
                (and (not (= x 0))
                      (even? (- x 1)))))

          (assp odd? '((1 . a) (2 . b)))  
          (assp even? '((1 . a) (2 . b)))  
          (let ([ls (list (cons 1 'a) (cons 2 'b))])
            (eq? (assp odd? ls) (car ls))) 
          (let ([ls (list (cons 1 'a) (cons 2 'b))])
            (eq? (assp even? ls) (cadr ls)))
          (assp odd? '((2 . b)))
    