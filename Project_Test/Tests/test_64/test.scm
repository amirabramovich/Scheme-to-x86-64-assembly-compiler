   
                ((((lambda (x)
                (lambda (y)
                  (x y)))
              (lambda (p)
                (p (lambda (x y)
                (lambda (p)
                  (p y x))))))
              (lambda (z) (z #t #f)))
            (lambda (x y) x))
    