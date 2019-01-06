   
        (define last-pair
        (letrec ((loop
        (lambda (s r)
        (if (pair? r)
        (loop r (cdr r))
        s))))
        (lambda (s)
        (loop s (cdr s)))))   

        (define foo
        (lambda ()
        (let ((s (list 'he 'said:)))
        (set-cdr! (last-pair s)
        (list 'ha 'ha))
        s)))
        (define goo
        (lambda ()
        (let ((s '(he said:)))
        (set-cdr! (last-pair s)
        (list 'ha 'ha))
        s)))         

        (foo)
        (foo)
        (foo)
        (foo)
        (foo)
        (foo)
        (foo)
        (foo)

        (goo)
        (goo)
        (goo)
        (goo)
        (goo)
        (goo)
        (goo)
        (goo)
        (goo)
    