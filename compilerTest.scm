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
(set-car! y 0)
y ; (0 . 2)
(set-cdr! y 1)
y ; (0 . 1)
"----------------------"

;; Lambda
"Lambda"
(eq? ((lambda (x) x) 1) 1) ; 1
((lambda (x) (+ x x)) 1) ; 2
((lambda (x y) (+ x y)) 1 2) ; 3
"----------------------"

;; Applic
"Applic"
((lambda (x)
    (* (x 1 2) 2))
        (lambda (y z) (+ y z))) ; 6
((lambda ()
    (+ 1 2)
    (+ 1 1))) ; 2
"----------------------"

"*** End of tests ***"