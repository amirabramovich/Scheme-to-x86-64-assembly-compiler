   
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

        (define list-tail
        (lambda (ls n)
          (if (= n 0)
              ls
              (list-tail (cdr ls) (- n 1))))) 




    (list-tail '(a b c) 0)
    (list-tail '(a b c) 2)
    (list-tail '(a b c) 3) 
    (list-tail '(a b c . d) 2)
    (list-tail '(a b c . d) 3) 
    (let ([x (list 1 2 3)])
      (eq? (list-tail x 2)
          (cddr x)))   
    