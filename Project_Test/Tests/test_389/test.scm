   
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

         (define factorial
          (lambda (n)
          (letrec ([fact (lambda (i)
              (if (= i 0)
                  1
                  (* i (fact (- i 1)))))])
                  (fact n))))
        
        (factorial 0)  
        (factorial 1) 
        (factorial 2)  
        (factorial 3) 
        (factorial 10)  
    