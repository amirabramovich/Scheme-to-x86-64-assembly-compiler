
              (define not
                (let ((eq? eq?))
                  (lambda (x)
                    (if (eq? x #t) #f #t))))
    