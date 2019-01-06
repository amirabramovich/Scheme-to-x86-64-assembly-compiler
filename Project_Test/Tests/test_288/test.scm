   
                  (define vector->list
                    (let ((< <)(vector-ref vector-ref)(cons cons)(vector-length vector-length)(- -))
                      (lambda (vec)
                        (letrec ((loop (lambda (vec lst count)
                            (cond ((< count 0) lst)
                            (else (loop vec (cons (vector-ref vec count) lst) (- count 1)))))))
                    (loop vec '() (- (vector-length vec) 1))))))
    