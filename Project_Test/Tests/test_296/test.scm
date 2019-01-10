   
                (define > 4)
                (define >
                    (let ((null? null?)(< <)(= =)(not not)(car car)(cdr cdr))
                      (letrec ((loop (lambda (element lst) (if 
                              (null? lst) 
                              #t 
                              (if 
                              (not (or (< element (car lst)) (= element (car lst))))
                              (loop (car lst) (cdr lst))
                              #f)
                              ))))
                        (lambda lst
                    (cond ((null? lst) "this should be an error, but you don't support exceptions")
                          (else (loop (car lst) (cdr lst))))))))
    