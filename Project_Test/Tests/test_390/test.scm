   
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

           (define factorial-iter
          (lambda (n)
            (letrec ([fact (lambda (i a)
              (if (= i 0)
                  a
                  (fact (- i 1) (* a i))))])
                  (fact n 1))))

        (factorial-iter 0)  
        (factorial-iter 1) 
        (factorial-iter 2)  
        (factorial-iter 3) 
        (factorial-iter 10) 
    