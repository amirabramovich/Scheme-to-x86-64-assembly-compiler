   
                  (define float? 5)
                  (define number?
                    (let ((float? float?) (integer? integer?))
                      (lambda (x)
                        (or (float? x) (integer? x)))))
    