;; ;; Tests
;; "*** compiler tests ***"


;; ;; Const
;; "Const"
;; 1 ; .c1. int
;; 2.2 ; .c2. float
;; 'c ; .c3. quote
;; "str" ; .c4. string
;; '(1 2) ; .c5. pair
;; '(1 2 3 4) ; .c6. pair
;; pass
;; "----------------------"


;; ;; If
;; "If"
;; (eq? (if #t #t #f) #t) ; .i1. #t
;; (eq? (if #f 0 1) 1) ; .i2. 1
;; (eq? (cond (#f 1) 
    ;; (#f 1 2)
    ;;   (else #t 1 0)) 0) ; .i3. 0
;;   pass
;; "----------------------"


;; ;; Or
;; "Or"
;; (eq? (or #f #f) #f); .o1. #f
;; (eq? (or 1 0 2) 1) ; .o2. 1
;; pass
;; "----------------------"


;; ;; And
;; "And"
;; (and 1 2 3) ; .a1. 3
;; pass
;; "----------------------"


;; Seq
;; "Seq"
;; ((lambda ()      
;;       (begin
;;         (+ 1 2)
;;       (+ 3 4)
;;       (* 1 2))
;;         )) ; .s1. 2
;; pass
;; "----------------------"


;; ;; Define
;; "Define"
;; (define y (cons 1 2)) ; .d1.
;; y ; (1 . 2)
;; (define x (+ 1 2)) ; .d2.
;; x ; 3
;; all test pass
;; "----------------------"


;; ;; Set
;; "Set"
;; (set-car! y 0) ; .s1. regular
;; y ; (0 . 2)
;; (set-cdr! y 1) ; .s2. regular
;; y ; (0 . 1)
;; ((lambda (x)
;;     (+
;;         ((lambda ()
;;             (begin
;;                 (set! x 2)
;;                 4)
;;                     ))
;;         ((lambda ()
;;             2))
;;                 )
;;                     ) 2) ; .s3. 6, VarBound
;; ((lambda (x)
;;     (set! x 3)
;;     x
;;         ) 1) ; s4. 3, VarParam
;; ((lambda (x)
;;     ((lambda ()
;;         (set! x 2)
;;         x))
;;         ) 1) ; .s5. 2, VarBound, Set, works

;; all tests pass
;; "----------------------"


;; ;; Lambda
;; "Lambda"
;; (eq? ((lambda (x) x) 1) 1) ; .l1. 1
;; ((lambda (x) (+ x x)) 1) ; .l2. 2
;; ((lambda (x y) (+ x y)) 1 2) ; .l3. 3
;; ((lambda ()
;;         ((lambda ()
;;             (+ 2 2))))) ; .l4. 4
;; ((lambda ()
;;         (+
;;         ((lambda ()
;;             (+ 2 2)))
;;             1
;;             )
;;             )) ; .l5. 5, failed

;; ((lambda ()
;;         (+
;;         ((lambda ()
;;             (+ 2 2)))
;;             ((lambda ()
;;                 2))
;;             )
;;             )) ; .l6. 6, failed

;; ((lambda ()
;;         ((lambda ()
;;             ((lambda ()
;;                 (+ 3 4)
;;             ))
;;                 ))
;;                     )) ; .l7. 7

;; all passed, tests l5, l6 failed
;; "----------------------"


;; ;; LambdaOpt
;; "LambdaOpt"
;; ((lambda (a . b) 1) 1) ; .l_1. 1
;; (define (func .  x) x) ; .l_2. expr' = Def' (Var' (VarFree "func"), LambdaOpt' ([], "x", Var' (VarParam ("x", 0))))
;; (func 2) ; (2)
;; ((lambda (a b . c) (+ a b)) 1 2) ; .l_3.  3
;; ((lambda (a . b)
;;         a) 4 2) ; .l_4. 4
;; ((lambda (a . b)
;;         a) 5) ; .l_5. 5
;; ((lambda (a b . c)
;;       (lambda () c)
;;       ((lambda ()
;;         ((lambda () 6))))) 1 2) ; .l_6. 6
;; ((lambda (a b . c)
;;       (lambda () c)
;;       ((lambda ()
;;         ((lambda () 7))))) 1 2 3) ; .l_7. 7
;; ((lambda (a b . c)
;;       (lambda ()
;;         (set! a (+ a a))
;;         c
;;       )
;;       (lambda () (set! b (lambda () (set! c 5))))
;;       (+ a b)
;;     ) 5 3) ; .l_8. 8
;; ((lambda (a b . c)
;;       (lambda ()
;;         (set! a (+ a a))
;;         c
;;       )
;;       (lambda () (set! b (lambda () (set! c 5))))
;;       (+ a b)
;;     ) 6 3 4) ; .l_9. 9

;; TODO: add more complicated cases of LambdaOpt', check it, and fix code if needed
;; all tests passed
;; "----------------------"


;; Applic
;; "Applic"
;; (+ 1 2) ; .a0. 3, simple Applic'

;; ((lambda (x)
;;     (+
;;         ((lambda ()
;;             (begin
;;                 (set! x 2)
;;                 0)
;;                     ))
;;         ((lambda ()
;;             1))
;;                 )
;;                    ) 2) ; .a1. 1, Failed

;; ((lambda (x)
;;     (* (x 1) 2))
;;         (lambda (x) x)) ; 2

;; ((lambda (y z) (+ y z)) 2 4) ; .a2. 6

;; ((lambda ()
;;     (+ 1 2)
;;     (+ 1 1))) ; .a3. 2

;; (((lambda (a b)
;;             (begin 1
;;             2
;;             (lambda () 
;;                 "done!")
;;                       )) 0 1)) ; .a4. "done!"

;; (cons 1 (cons 2 3)) ; .a5. (1 2 . 3)
;; (let ((x 1)
;;         (y 2))
;;     (+ x y)) ; .a6. 3
;; all tests passed
;; "----------------------"


;; ApplicTP
;; "ApplicTP"
;; ((lambda ()
;;             (boolean? #t))) ; .a_1. #t ; this case works in curr ApplicTP'
;; ((lambda (x)
;;             (boolean? x)) #t) ; .a_2. #t
;; ((lambda (x y)
;;         (cons x y)) 1 2) ; .a_3. (1 . 2)
;; ((lambda () 
;;     (and ((lambda() 1)) ((lambda() 2)) ((lambda () 3))))) ; .a_4. 3
;; (define adder (lambda (x) (lambda (y) (+ x y))))
;; ((adder 3) 9) ; 12

;; (define foo (lambda (x y) 
;;             (cons x ((lambda () 
;;                         (set! x y)
;;                         y))
;;                         ))) ; .a_5.
;; (foo 0 1) ; (0 . 1), maybe OK, 
;;              ; (1 . 1)

;; ((lambda () (+ 1 2))) ; .a_6. 3

;; TODO: add more complicated cases of ApplicTP', and fix if needed
;; all pass, a5 failed
;; "----------------------"


;; ;; Box
;; "Box"
;; ((lambda (x)
;;     (lambda ()
;;         (set! x 2))
;;     x
;;         ) 1) ; .b1. 1, VarParam, BoxGet', Fixed

;; ((lambda (x)
;;     ((lambda ()
;;         (set! x 2)))
;;     x
;;         ) 1) ; .b2. 2, Param- BoxGet', Bound- BoxSet', Failed

;; ((lambda (x)
;;     (set! x 3)
;;     ((lambda ()
;;         x))
;;     ) 1) ; .b3. 3, VarParam, BoxSet', VarBound, BoxGet'

;; ((lambda (x)
;;     (set! x 4)
;;     ((lambda ()
;;         x))
;;        ) 1) ; .b4. 4, BoxGet', VarBound, BoxSet' VarParam, works

;; ((lambda (x)
;;     ((lambda()
;;         (set! x 3)))
;;     ((lambda()
;;         x))
;;         ) 1) ; .b5. 3, BoxGet', VarBound, BoxSet', VarBound, Failed

;; ((lambda (x y)
;;     (if x ((lambda ()
;;             (set! y x)
;;             x))
;;     ((lambda (z)
;;         (set! x z)
;;         x) 2)))
;;             1 2) ; .b6. 1, 

;; ((lambda (x)
;;     (lambda ()
;;         (set! x 3))
;;     (if x #f #t)
;;             x) 1) ; .b7. 1 (VarParam, Box', BoxGet'), 

;; ;; All pass, b5 failed
;; "----------------------"


;; "*** End of tests ***"



;; ;; Done:
;; ;; .1. add names to each test (e.g c1 for const test, in number 1).
;; ;; TODO:
;; ;; .1. find way to check each expression (equal? or another function of compare).
;; ;; .2. find way to concat all tests of each type together, and all tests together (list & equal? not supported yet).




;; ((lambda y y) 1 2 3) ; (1 2 3)
                   ; (2 ())

;; ((lambda y y) 1) ; (1)
                 ; (())

;; ((lambda y y)) ; ()

;; ((lambda y y)'()) ; (())

;; ((lambda (a . c)
;;     c) 1 2 3) ; (2 3)

;; ((lambda (a . c)
;;         c) 1) ; ()

;; ((lambda (a . c)
;;     c) 1 2 3 4 5) ; (2 3 4 5)


;; (define voo (lambda (x . y) (begin x y)))
;; (voo 1) ; ()
;; (voo 1 2) ; (2)
;; (voo 1 2 3) ;(2 3)


;; ((lambda ()
;;             (boolean? #t))) ;; #t


;; (define foo5
;;     (lambda (x y)
;;             (lambda () 
;;                     "\n \r \f this is \n \r \f "
;;                     (set! x 5)
;;                     )
;;             (lambda () x)
;;                             ))
;; ((foo5 1 2)) ;; 1
   

            ; Checking fvar_tbl working correctly 

            
            ;; (define x_0 0)
            ;; (define x_1 1)
            ;; (define x_2 2)
            ;; (define x_3 3) 

            ;; (set! x_0 -0)
            ;; (set! x_1 -1)
            ;; (set! x_2 -2)
            ;; (set! x_3 -3)

            ;; x_0
            ;; x_1
            ;; x_2
            ;; x_3
        

;; (append '((1 2) (3 4)) '((5 6) (7 8)) '(((9 10) '(11 12)))) ; ((1 2) (3 4) (5 6) (7 8) ((9 10) '(11 12)))
;;                                                             ; ((1 2) (3 4) (5 6) (7 8) ((9 10) (quote (11 12))))

;; (append '() '()) ; (), pass
;; (append '(1) '()) ; (1)
                  ; (1) , pass with Applic assembly code, for ApplicTP expr'

;; (append '() '(1)) ; (1), pass
                  ; (1)

;;  (append '(1) '(1)) ; (1 1)
                    ; pass with applic assembly code for applic tp expr'

;; ((lambda (a lst . b)
;;      (a lst b))
;;         cons '(1) 2 3 4 '(9) 'hello) ; ((1) 2 3 4 (9) hello)
;;                                                              ; ((1) (1) 2 3 4 (9))
;;((1) 2 3 4 (9) hello)

;; fixed

;;                                                              ; "forgot" last elem

;; ((lambda (a lst . b)
;;      (a lst b))
;;         cons 'lst 'b) ; (lst b)
        ;; fixed
;;                       ; (lst lst)

;; where |args| = 1,
;; arg and opt, sent correctly.

;; ((lambda (a . b)
;;     (cons a b))
;;         'a 'b) ; (a b)
                  ; (a b)

;; ((lambda (func a . b)
;;     (func a b))
;;         cons 'a 'b) ; (a b)
;;                     ; (a b)

                    ;; fixed

;; ((lambda (a b . c)
;;     (if a b c))
;;         #f 'b 'c) ; (c)
                  ; (c)
                  ;;fixed

;; ((lambda (a b . c)
;;     (if a c c))
;;         #f 'b 'c) ; (c)

;; fixed

                  ; (b)
                  ; where |args| > 1
                  ; opt param got 'b (the last arg param)
                  ; and not 'c (the opt param)
                  ; try to give opt the next PVAR(current + 1)
                  ; if current is the PVAR that "sent" now
                  ; the problem is, that the last arg is sent as "opt"
                  ; and "covered" by "pair" (two ()).

                  ; so I will check,
                  ; if |args| < 3 (include magic) jmp next (to the original code)
                  ; cmp rcx, 3
                  ; jl .continue
                  ; otherwise, I will inc the register of idx of opt in PVAR
                  ; 


;; another example
;; ((lambda (a b . c)
;;     (if a b b))
;;         #f 'b 'c) ; b
                  ; b
                  ; but, we can see that the last arg sent correctly.

;; ((lambda (a . b)
;;     (if #f a b))
;;         'a 'b) ; (b)
;;                ; (b)

;; ((lambda (a . b)
;;     (if #t a b))
;;         'a 'b) ; a
;;                ; a

;; (apply list '(1 2)) ;; (1 2)
;; (apply list '(1 2 3)) ;; (1 2 3)

;; (apply + '(1 2)) ;; 3

;; `(1 2) ; (1 2)

;; `(1 ,@'(2)) ; (1 2)
            ; (1 2), with applic assembly code for ApplicTP Expr'


;; `(1 ,@'()) ; (1)
            ; (1) , with Applic assmebly code for ApplicTP Expr'

;; `(1 ,@'(1)) ; (1 1)
            ; (1 1), with Applic assmebly code for ApplicTP Expr'

;; `(1 ,@`(1)) ; (1 1)
            ; (1 1), with Applic assmebly code for ApplicTP Expr'


;; `(1 '()) ; (1 '())
; (1 (quote ()))

;; `(1 `()) ; (1 `())
; (1 (quasiquote ()))

;; `(1 `(1 2)) ; (1 `(1 2))
; (1 (quasiquote (1 2)))


;; '(1 `(1)) ; (1 `(1))
         ; (1 (quasiquote (1)))

;; '(1 ,@`(1)) ; (1 ,@`(1))
; (1 (unquote-splicing (quasiquote (1))))

;; '(1 ,@'(1)) ; (1 ,@'(1))
; (1 (unquote-splicing (quote (1))))

; Test N155




; (define x5 (lambda (y1 y2 y3 y4 . y5) `(y1 y2 y3 y4 ,@y5))) 
; (define x6 (lambda (y1 y2 y3 y4 y5 . y6) `(y1 y2 y3 y4 y5 ,@y6))) 

;; (define x1 (lambda y y))                 
;; (x1) ; ()

;; (define x2 (lambda (y1 . y2) `(y1 ,@y2)))  
;; (x2 1 2 3 4 5 6 7 8 9 10) ; (y1 2 3 4 5 6 7 8 9 10)
                             ; (y1 2 3 4 5 6 7 8 9 10)


;; (define x3 (lambda (y1 y2 . y3) `(y1 y2 ,@y3)))
;; (x3 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20) ; (y1 y2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20)
                                                        ; (y1 y2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20)

;; (define x4 (lambda (y1 y2 y3 . y4) `(y1 y2 y3 ,@y4))) 
;; (x4 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30)

; (x5 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40)
; (x6 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50)

; Test N222
;;  (define x (lambda (x1 x2 x3 x4 x5 x6 x7 x8 x9 . x10)
;;  (lambda (y1 y2 y3 y4 y5 y6 y7 y8 y9 . y10) 
;;  (lambda (z1 z2 z3 z4 z5 z6 z7 z8 z9 . z10) 
;;  (lambda (k1 k2 k3 k4 k5 k6 k7 k8 k9 . k10) 
;;  (lambda (l1 l2 l3 l4 l5 l6 l7 l8 l9 . l10) 
;;  (lambda (h1 h2 h3 h4 h5 h6 h7 h8 h9 . h10) 
;;  `(,x1 ,x2 ,x3 ,x4 ,x5 ,x6 ,x7 ,x8 ,x9 ,@x10 
;;  ,y1 ,y2 ,y3 ,y4 ,y5 ,y6 ,y7 ,y8 ,y9 ,@y10
;;  ,z1 ,z2 ,z3 ,z4 ,z5 ,z6 ,z7 ,z8 ,z9 ,@z10
;;  ,k1 ,k2 ,k3 ,k4 ,k5 ,k6 ,k7 ,k8 ,k9 ,@k10
;;  ,l1 ,l2 ,l3 ,l4 ,l5 ,l6 ,l7 ,l8 ,l9 ,@l10
;;  ,h1 ,h2 ,h3 ,h4 ,h5 ,h6 ,h7 ,h8 ,h9 ,@h10))))))))

;;  ((((((x 1 2 3 4 5 6 7 8 9 10) 11 12 13 14 15 16 17 18 19 20 -11) 21 22 23 24 25 26 27 28 29 30 -30 -31) 31 32 33 34 35 36 37 38 39 40 -40 -41 -42 -43) 41 42 43 44 45 46 47 48 49 50 -50 -51 -52 -53 -54 -55 -56) 51 52 53 54 55 56 57 58 59 60 -55 -66 -77 -88 -99 -100) 


; Test N223
; (define x (lambda x10 (lambda y10 (lambda z10 (lambda k10 (lambda l10 (lambda h10 
;     `(,@x10 ,@y10 ,@z10 ,@k10 ,@l10 ,@h10))))))))
; ((((((x 1 2 3 4 5 6 7 8 9 10) 11 12 13 14 15 16 17 18 19 20 -11) 21 22 23 24 25 26 27 28 29 30 -30 -31) 31 32 33 34 35 36 37 38 39 40 -40 -41 -42 -43) 41 42 43 44 45 46 47 48 49 50 -50 -51 -52 -53 -54 -55 -56) 51 52 53 54 55 56 57 58 59 60 -55 -66 -77 -88 -99 -100)
