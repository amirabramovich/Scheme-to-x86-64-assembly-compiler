   
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

         (define reverse
          (lambda (ls)
            (letrec ([rev (lambda (ls new)
              (if (null? ls)
                  new
                  (rev (cdr ls) (cons (car ls) new))))])
              (rev ls '()))))

      (reverse '(1 2 3 4))
      (reverse '(12 4 "sf" #t))  
    