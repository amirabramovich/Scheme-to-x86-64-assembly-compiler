   
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

          (define list->string
          (lambda (ls)
            (let* ( [i 0] [s (make-string (length ls))] )
                  (letrec ([loop (lambda (ls i)
                      (if  (null? ls)
                          s
                          (begin 
                              (string-set! s i (car ls)) 
                              (loop (cdr ls) (+ i 1)))))])
                          (loop ls i)))))
        (list->string '())
        (list->string '(#\a #\b #\c))
        (list->string '(#\s #\f #\s #\g #\g #\r #\e #\r)) 
    