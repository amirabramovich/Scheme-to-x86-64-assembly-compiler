   
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

           (define member
            (lambda (x ls)
              (cond
                [(null? ls) #f]
                [(equal? (car ls) x) ls]
                [else (member x (cdr ls))])))
        (member '(b) '((a) (b) (c)))
        (member '(d) '((a) (b) (c))) 
        (member "b" '("a" "b" "c"))


        (let ()
          (define member?
            (lambda (x ls)
              (and (member x ls) #t)))
          (member? '(b) '((a) (b) (c))))
    