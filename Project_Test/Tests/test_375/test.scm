   
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

          (define memq
          (lambda (x ls)
            (cond
              [(null? ls) #f]
              [(eq? (car ls) x) ls]
              [else (memq x (cdr ls))])))


      (memq 'a '(b c a d e))
      (memq 'a '(b c d e g)) 
          
      (define count-occurrences
        (lambda (x ls)
          (cond
            [(memq x ls) =>
            (lambda (ls)
              (+ (count-occurrences x (cdr ls)) 1))]
            [else 0])))

      (count-occurrences 'a '(a b c d a)) 
    