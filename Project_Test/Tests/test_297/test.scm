 
                (define float? 5)  
                (define equal?
                    (let ((< <)(= =)(not not)(string-length string-length)(string-ref string-ref)(vector-ref vector-ref)(vector-length vector-length)(integer? integer?) (float? float?) (pair? pair?) (char? char?) (string? string?)(vector? vector?)(eq? eq?)(car car)(cdr cdr)(char->integer char->integer)(- -))
                      (let ((compare-composite (lambda (container-1 container-2 container-ref-fun container-size-fun)
                              (letrec ((loop (lambda (container-1 container-2 container-ref-fun 				index)
                              (if (< index 0)
                                  #t
                                  (and (equal? (container-ref-fun container-1 index) (container-ref-fun container-2 index)) (loop container-1 container-2 container-ref-fun (- index 1)))))))
                          (if (not (= (container-size-fun container-1) (container-size-fun container-2)))
                              #f
                              (loop container-1 container-2 container-ref-fun (- (container-size-fun container-1) 1)))))))
                        
                        (lambda (x y)
                    (or 
                    (and (integer? x) (integer? y) (= x y))
                    (and (float? x) (float? y) (= x y))
                    (and (pair? x) (pair? y) (equal? (car x) (car y)) (equal? (cdr x) (cdr y)))
                    (and (char? x) (char? y) (= (char->integer x) (char->integer y)))
                    (and (string? x) (string? y) (compare-composite x y string-ref string-length))
                    (and (vector? x) (vector? y) (compare-composite x y vector-ref vector-length))
                    (eq? x y))))))
      