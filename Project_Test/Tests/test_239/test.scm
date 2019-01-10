
                (define *free-variable* 'lexical-scope)
                (define return-free-variable
                (lambda () *free-variable*))
                (define get-scope
                (lambda ()
                (let ((*free-variable* 'dynamic-scope))
                (return-free-variable))))

                (get-scope)
    