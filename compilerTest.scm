;; Tests
"*** compiler tests ***"


;; Const
"Const"
(eq? 1 1) ; .c1. int
(eq? 2.2 2.2) ; .c2. float
(eq? 'c 'c) ; .c3. quote
(eq? "" "str") ; .c4. string
(eq? '(1 2) '(1 2)) ; .c5. pair
(eq? '(1 2 3 4) '(1 2 3 4)) ; .c6. pair
"----------------------"


;; If
"If"
(eq? (if #t #t #f) #t) ; .i1. #t
(eq? (if #f 0 1) 1) ; .i2. 1
(eq? (cond (#f 1) 
    (#f 1 2)
      (else #t 1 0)) 0) ; .i3. 0
"----------------------"


;; Or
"Or"
(eq? (or #f #f) #f); .o1. #f
(eq? (or 1 0 2) 1) ; .o2. 1
"----------------------"


;; And
"And"
(and 1 2 3) ; .a1. 3
"----------------------"


;; Seq
;; "Seq"
;; ((lambda ()      
;;       (begin
;;         (+ 1 2)
;;       (+ 3 4)
;;       (* 1 2))
;;         )) ; .s1. 2
;; "----------------------"


;; Define
"Define"
(define y (cons 1 2)) ; .d1.
y ; (1 . 2)
(define x (+ 1 2)) ; .d2.
x ; 3
"----------------------"


;; Set
"Set"
(set-car! y 0) ; .s1. regular
y ; (0 . 2)
(set-cdr! y 1) ; .s2. regular
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
                    ) 2) ; .s3. 6, VarBound
((lambda (x)
    (set! x 3)
    x
        ) 1) ; s4. 3, VarParam
((lambda (x)
    ((lambda ()
        (set! x 2)
        x))
        ) 1) ; .s5. 2, VarBound, Set, works
"----------------------"


;; Lambda
"Lambda"
(eq? ((lambda (x) x) 1) 1) ; .l1. 1
((lambda (x) (+ x x)) 1) ; .l2. 2
((lambda (x y) (+ x y)) 1 2) ; .l3. 3
((lambda ()
        ((lambda ()
            (+ 2 2))))) ; .l4. 4
((lambda ()
        (+
        ((lambda ()
            (+ 2 2)))
            1
            )
            )) ; .l5. 5
((lambda ()
        (+
        ((lambda ()
            (+ 2 2)))
            ((lambda ()
                2))
            )
            )) ; .l6. 6
((lambda ()
        ((lambda ()
            ((lambda ()
                (+ 3 4)
            ))
                ))
                    )) ; .l7. 7
"----------------------"


;; LambdaOpt
"LambdaOpt"
((lambda (a . b) 1) 1) ; .l_1. 1
(define (func .  x) x) ; .l_2. expr' = Def' (Var' (VarFree "func"), LambdaOpt' ([], "x", Var' (VarParam ("x", 0))))
(func 2) ; (2)
((lambda (a b . c) (+ a b)) 1 2) ; .l_3.  3
((lambda (a . b)
        a) 4 2) ; .l_4. 4
((lambda (a . b)
        a) 5) ; .l_5. 5
((lambda (a b . c)
      (lambda () c)
      ((lambda ()
        ((lambda () 6))))) 1 2) ; .l_6. 6
((lambda (a b . c)
      (lambda () c)
      ((lambda ()
        ((lambda () 7))))) 1 2 3) ; .l_7. 7
((lambda (a b . c)
      (lambda ()
        (set! a (+ a a))
        c
      )
      (lambda () (set! b (lambda () (set! c 5))))
      (+ a b)
    ) 5 3) ; .l_8. 8
((lambda (a b . c)
      (lambda ()
        (set! a (+ a a))
        c
      )
      (lambda () (set! b (lambda () (set! c 5))))
      (+ a b)
    ) 6 3 4) ; .l_9. 9
;; TODO: add more complicated cases of LambdaOpt', check it, and fix code if needed
"----------------------"


;; Applic
"Applic"
(+ 1 2) ; .a0. simple Applic'
((lambda (x)
    (+
        ((lambda ()
            (begin
                (set! x 2)
                0)
                    ))
        ((lambda ()
            1))
                )
                    ) 2) ; .a1. 1
((lambda (x)
    (* (x 1 2) 2))
        (lambda (y z) (+ y z))) ; .a2. 6
((lambda ()
    (+ 1 2)
    (+ 1 1))) ; .a3. 2
(((lambda (a b)
            (begin 1
            2
            (lambda () 
                "done!")
                      )) 0 1)) ; .a4. "done!"
(cons 1 (cons 2 3)) ; .a5. (1 2 . 3)
(let ((x 1)
        (y 2))
    (+ x y)) ; .a6. 3
"----------------------"


;; ApplicTP
"ApplicTP"
((lambda ()
            (boolean? #t))) ; .a_1. #t ; this case works in curr ApplicTP'
((lambda (x)
            (boolean? x)) #t) ; .a_2. #t
((lambda (x y)
        (cons x y)) 1 2) ; .a_3. (1 . 2)
((lambda () 
    (and ((lambda() 1)) ((lambda() 2)) ((lambda () 3))))) ; .a_4. 3
(define adder (lambda (x) (lambda (y) (+ x y))))
((adder 3) 9) ; 12

;; (define foo (lambda (x y) 
;;             (cons x ((lambda () 
;;                         (set! x y)
;;                         y)
;;                         )))) ; .a_5.
;; (foo 0 1) ; (0 . 1), Failed

((lambda () (+ 1 2))) ; .a_6.

;; TODO: add more complicated cases of ApplicTP', and fix if needed
;; "----------------------"


;; Box
"Box"
((lambda (x)
    (lambda ()
        (set! x 2))
    x
        ) 1) ; .b1. 1, VarParam, BoxGet', Fixed

;; ((lambda (x)
;;     ((lambda ()
;;         (set! x 2)))
;;     x
;;         ) 1) ; .b2. 2, Param- BoxGet', Bound- BoxSet', Failed

((lambda (x)
    (set! x 3)
    ((lambda ()
        x))
    ) 1) ; .b3. 3, VarParam, BoxSet', VarBound, BoxGet'

((lambda (x)
    (set! x 4)
    ((lambda ()
        x))
       ) 1) ; .b4. 4, BoxGet', VarBound, BoxSet' VarParam, works

((lambda (x)
    ((lambda()
        (set! x 3)))
    ((lambda()
        x))
        ) 1) ; .b5. 3, BoxGet', VarBound, BoxSet', VarBound, Failed

((lambda (x y)
    (if x ((lambda ()
            (set! y x)
            x))
    ((lambda (z)
        (set! x z)
        x) 2)))
            1 2) ; .b6. 1, Failed

((lambda (x)
    (lambda ()
        (set! x 3))
    (if x #f #t)
            x) 1) ; .b7. 1 (VarParam, Box', BoxGet'), TODO: check where first fail

;; TODO: fix test that fails & check another cases of Box', and fix Box' if needed
"----------------------"


"*** End of tests ***"

;; Done:
;; .1. add names to each test (e.g c1 for const test, in number 1).
;; TODO:
;; .1. find way to check each expression (equal? or another function of compare).
;; .2. find way to concat all tests of each type together, and all tests together (list & equal? not supported yet).