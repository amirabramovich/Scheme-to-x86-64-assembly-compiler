;; Tests
"*** compiler tests ***"


;; Const
"Const"
(eq? 1 1) ; int
(eq? 2.2 2.2) ; float
(eq? 'c 'c) ; quote
(eq? "str" "str") ; string
(eq? '(1 2) '(1 2)) ; pair
(eq? '(1 2 3 4) '(1 2 3 4)) ; pair
"----------------------"


;; If
"If"
(eq? (if #t #t #f) #t) ; #t
(eq? (if #f 0 1) 1) ; 1
(eq? (cond (#f 1) 
    (#f 1 2)
      (else #t 1 0)) 0) ; 0
"----------------------"


;; Or
"Or"
(eq? (or #f #f) #f); #f
(eq? (or 1 0 2) 1) ; 1
"----------------------"


;; And
"And"
(and 1 2 3) ; 3
"----------------------"


;; Seq
"Seq"
((lambda ()      
      (begin
        (+ 1 2)
      (+ 3 4)
      (* 1 2))
        )) ; 2
"----------------------"


;; Define
"Define"
(define y (cons 1 2))
y ; (1 . 2)
(define x (+ 1 2))
x ; 3
"----------------------"


;; Set
"Set"
(set-car! y 0) ; regular
y ; (0 . 2)
(set-cdr! y 1) ; regular
y ; (0 . 1)
((lambda (x)
    (+
        ((lambda ()
            (begin
                (set! x 2)
                4)
                    ))
        ((lambda ()
            2))
                )
                    ) 2) ; 6, VarBound
((lambda (x)
    (set! x 3)
    x
        ) 1) ; 3, VarParam
"----------------------"


;; Lambda
"Lambda"
(eq? ((lambda (x) x) 1) 1) ; 1
((lambda (x) (+ x x)) 1) ; 2
((lambda (x y) (+ x y)) 1 2) ; 3
((lambda ()
        ((lambda ()
            (+ 2 2))))) ; 4
((lambda ()
        (+
        ((lambda ()
            (+ 2 2)))
            1
            )
            )) ; 5
((lambda ()
        (+
        ((lambda ()
            (+ 2 2)))
            ((lambda ()
                2))
            )
            )) ; 6
((lambda ()
        ((lambda ()
            ((lambda ()
                (+ 3 4)
            ))
                ))
                    )) ; 7
"----------------------"


;; Applic
"Applic"
((lambda (x)
    (* (x 1 2) 2))
        (lambda (y z) (+ y z))) ; 6
((lambda ()
    (+ 1 2)
    (+ 1 1))) ; 2
(((lambda (a b)
            (begin 1
            2
            (lambda () 
                "done!")
                      )) 0 1)) ; "done!"
(cons 1 (cons 2 3)) ; (1 2 . 3)
(let ((x 1)
        (y 2))
    (+ x y)) ; 3
"----------------------"


;; ApplicTP
"ApplicTP"
((lambda (x)
            (boolean? x)) #t) ; #t
((lambda (x y)
        (cons x y)) 1 2) ; (1 . 2)
((lambda () 
    (and ((lambda() 1)) ((lambda() 2)) ((lambda () 3))))) ; 3
(define adder (lambda (x) (lambda (y) (+ x y))))
((adder 3) 9) ; 12
;; (define foo (lambda (x y) 
;;             (cons x ((lambda () 
;;                         (set! x y)
;;                         y)
;;                         ))))
;; (foo 0 1) ; (0 . 1)
"----------------------"


;;Box
"Box"
((lambda (x)
    (+
        ((lambda ()
            (begin
                (set! x 2)
                4)
                    ))
        ((lambda ()
            2))
                )
                    ) 2) ; 6
((lambda (x)
    (lambda ()
        (set! x 3))
    x
        ) 1) ; 1, VarParam, BoxGet', Fixed
((lambda (x)
    (set! x 3)
    ((lambda ()
        x))
    ) 1) ; 3, VarParam, BoxSet'
((lambda (x y)
(if x ((lambda ()
    (set! y x)
    y))
    (lambda (z) (set! x z)))) 1 2) ; 1
;; ((lambda (x)
;;     (lambda ()
;;         (set! x 3))
;;     (if x #f #t)
;;             x) 1) ; 1 (VarParam, Box', BoxGet')

"----------------------"


"*** End of tests ***"