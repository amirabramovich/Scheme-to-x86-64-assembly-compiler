; 1 2 #t 5 3.14 #\a '() "yo" #(1 2 3) 'cool '(1) '(1 2 3) '(9 . 9) '(3.14)
;  (if (if (if 1 2 3) (if 4 (if 5 (if 6 7 8) 9) 10) (if 11 (if 12 (if 13 14 15) 16) 17)) (if 18 (if 19 20 21) 22) 23)
; (or (or (or 1 2 3) (or 4 (or 5 (or 6 7 8) 9) 10) (or 11 (or 12 (or 13 14 15) 16) 17)) (or 18 (or 19 20 21) 22) 23)
;  (if (if (if 1 2 3) (if 4 (if 5 (or 6 7 8) 9) 10) (or 11 (or 12 (or 13 14 15) 16) 17)) (or 18 (or 19 20 21) 22) 23)
;  (if (or (if 1 2 3) (if 4 (if 5 (if 6 7 8) 9) 10) (if 11 (or 12 (or 13 14 15) 16) 17)) (if 18 (or 19 20 21) 22) 23)
; (boolean? 99)
;  1
;  (define x '(1 2))
;  (car '(1 2))
;   (cdr '(1 2))
;  x
;  (set! x 3)
;  (set! x '(1 2))
;  (car x)
;  (cdr x)
;  (define x '(1 2))
;   (set-car! x 0)
;   (set-cdr! x 0)
;   x ;; should print '(0 0)
; (cons 1 2) ;; should print (1 . 2)
; (cons 3 4) ;; should print (3 . 4)
;  (define goo (lambda(x)(lambda()1)))
; ((goo 9))
; (define g (lambda (x) x))
; ((lambda (x) (g (g x))) 1)
; (define yosi (lambda (x y d e f g h i j k l m n o p) (lambda (z) (lambda (a b c) d))))
; (((yosi 1 2 10 20 30 40 50 60 70 80 90 100 120 130 140) 3)4 5 6)
; ((((lambda (x y d e f g h i j k l m n o p) (lambda (z) (lambda (a b c) y))) 1 2 10 20 30 40 50 60 70 80 90 100 120 130 140) 3)4 5 6)
; ((((lambda (x y d e f g h i j k l m n o p) (lambda (z) (lambda (a b c) d))) 1 2 10 20 30 40 50 60 70 80 90 100 120 130 140) 3)4 5 6)

; (define (func .  x) x)
; (define gaa (lambda (a b . c) (+ a b)))
; (define voo (lambda (x . y) (begin x y)))
; (define adder (lambda (x) (lambda (y) (+ x y))))
; adder
; ((adder 3)9)
; (let ((a 3)(b 4)(c 5)(d 6)(e 7)(f 9))(let () f))
;  (define (func .  x) x)
;  (func) ; ()
;  (func 1) ; (1)
;  (func 1 2) ; (1 2)
;   (define gaa (lambda (a b . c) (+ a b)))
;   (gaa 2 3) ; 5
;   (gaa 2 3 4) ; 5
;   (define voo (lambda (x . y) (begin x y)))
;   (voo 1) ; ()
;   (voo 1 2) ; (2)
;   (voo 1 2 3) ; (2 3)
;   (voo 1 2 ((((lambda (x y d e f g h i j k l m n o p) (lambda (z) (lambda (a b c) y))) 1 2 10 20 30 40 50 60 70 80 90 100 120 130 140) 3)4 5 6))
;   (voo 1 ((((lambda (x y d e f g h i j k l m n o p) (lambda (z) (lambda (a b c) y))) 1 2 10 20 30 40 50 60 70 80 90 100 120 130 140) 3)4 5 6) 3)
;   (voo 1 2 ((((lambda (x y d e f g h i j k l m n o p) (lambda (z) (lambda (a b c) (voo 1 y p)))) 1 2 10 20 30 40 50 60 70 80 90 100 120 130 140) 3)4 5 6))
;   (voo 1 ((((lambda (x y d e f g h i j k l m n o p) (lambda (z) (lambda (a b c) (voo 1 x (gaa 2 y i))))) 1 2 10 20 30 40 50 60 70 80 90 100 120 130 140) 3)4 5 6) 3) 
; (define adder (lambda (x) (lambda (y) (+ x y))))
;  adder
; ((adder 3)9)
;  (define plus3 (adder 3))
;  (plus3 9)
;  adder
;  ((adder ((goo 9)))10)
; (define g (lambda(x)x))
; (define f (lambda(x)(+ x 1)))
; ((lambda (x) (f (g (g x))))5)
; (define yo (lambda (x y) (lambda (z) (+ (+ 1 y) z))))
;  ((yo 3 5) 9) 

; Test N31
; (define foo5
;     (lambda (x y)
;         (lambda () 
;                 "\n \r \f this is \n \r \f "
;                 (set! x 5))
;         (lambda () x)
;     ))
; ((foo5 1 2))  

; Test N47
; (define x_0 0)
; (define x_1 1)
; (define x_2 2)
; (set! x_0 -0)
; (set! x_1 -1)
; (set! x_2 -2)
; x_0
; x_1
; x_2

; Test N99
; (+ 3 -0.5) 
; Test N155
; (define x1 (lambda y y))           
; (define x2 (lambda (y1 . y2) `(y1 ,@y2)))          
; (define x3 (lambda (y1 y2 . y3) `(y1 y2 ,@y3)))
; (define x4 (lambda (y1 y2 y3 . y4) `(y1 y2 y3 ,@y4))) 
; (define x5 (lambda (y1 y2 y3 y4 . y5) `(y1 y2 y3 y4 ,@y5))) 
; (define x6 (lambda (y1 y2 y3 y4 y5 . y6) `(y1 y2 y3 y4 y5 ,@y6))) 

; (x1)
; (x2 1 2 3 4 5 6 7 8 9 10)
; (x3 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20)
; (x4 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30)
; (x5 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40)
; (x6 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50)
; Test N222
; (define x (lambda (x1 x2 x3 x4 x5 x6 x7 x8 x9 . x10) 
; (lambda (y1 y2 y3 y4 y5 y6 y7 y8 y9 . y10) 
; (lambda (z1 z2 z3 z4 z5 z6 z7 z8 z9 . z10) 
; (lambda (k1 k2 k3 k4 k5 k6 k7 k8 k9 . k10) 
; (lambda (l1 l2 l3 l4 l5 l6 l7 l8 l9 . l10) 
; (lambda (h1 h2 h3 h4 h5 h6 h7 h8 h9 . h10) 
; `(,x1 ,x2 ,x3 ,x4 ,x5 ,x6 ,x7 ,x8 ,x9 ,@x10 
; ,y1 ,y2 ,y3 ,y4 ,y5 ,y6 ,y7 ,y8 ,y9 ,@y10
; ,z1 ,z2 ,z3 ,z4 ,z5 ,z6 ,z7 ,z8 ,z9 ,@z10
; ,k1 ,k2 ,k3 ,k4 ,k5 ,k6 ,k7 ,k8 ,k9 ,@k10
; ,l1 ,l2 ,l3 ,l4 ,l5 ,l6 ,l7 ,l8 ,l9 ,@l10
; ,h1 ,h2 ,h3 ,h4 ,h5 ,h6 ,h7 ,h8 ,h9 ,@h10))))))))
; ((((((x 1 2 3 4 5 6 7 8 9 10) 11 12 13 14 15 16 17 18 19 20 -11) 21 22 23 24 25 26 27 28 29 30 -30 -31) 31 32 33 34 35 36 37 38 39 40 -40 -41 -42 -43) 41 42 43 44 45 46 47 48 49 50 -50 -51 -52 -53 -54 -55 -56) 51 52 53 54 55 56 57 58 59 60 -55 -66 -77 -88 -99 -100) 

; Test N223
; (define x (lambda x10 (lambda y10 (lambda z10 (lambda k10 (lambda l10 (lambda h10 
;     `(,@x10 ,@y10 ,@z10 ,@k10 ,@l10 ,@h10))))))))
; ((((((x 1 2 3 4 5 6 7 8 9 10) 11 12 13 14 15 16 17 18 19 20 -11) 21 22 23 24 25 26 27 28 29 30 -30 -31) 31 32 33 34 35 36 37 38 39 40 -40 -41 -42 -43) 41 42 43 44 45 46 47 48 49 50 -50 -51 -52 -53 -54 -55 -56) 51 52 53 54 55 56 57 58 59 60 -55 -66 -77 -88 -99 -100)       
;  ((yo 3 5) 9)

;; (list? 1)
;; (apply < '(1 2 3 4)) ; #t
;; (apply list '(1 2 3)) ;; (1 2 3)
                      ;; (3 2)
;; (apply list '(1 2)) ;; (1 2)
                      ;; (2 1) 

;; false ?
                    ;;  push only last 2 vars ... 

;; (append '(1 2) '(3 4)) ;(1 2 3 4)

;; (equal? 1 1);#t
;; (equal? '(1 2) '(1 2));#t
;; (equal? '(1 3) '(1 2));#f

;; (define n 1)
;; (= n 1);#t
;; (= n 2);#f
;; (> 1 2);#f
;; (> 2 1 3);#f
;; (< 1 2);#t
;; (< 2 1 3);#f
;; (length '(1 2 3 4));4

;; (define x4 (lambda (y1 y2 y3 . y4) `(y1 y2 y3 ,@y4)))
;; (x4 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30)
;(y1 y2 y3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30)
;(y1 y2 y3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30)
; fixed

; Test N155
; (define x1 (lambda y y))           
; (define x2 (lambda (y1 . y2) `(y1 ,@y2)))          
; (define x3 (lambda (y1 y2 . y3) `(y1 y2 ,@y3)))
; (define x4 (lambda (y1 y2 y3 . y4) `(y1 y2 y3 ,@y4))) 
;; (define x5 (lambda (y1 y2 y3 y4 . y5) `(y1 y2 y3 y4 ,@y5))) 
;; (define x6 (lambda (y1 y2 y3 y4 y5 . y6) `(y1 y2 y3 y4 y5 ,@y6))) 

; (x1)
; (x2 1 2 3 4 5 6 7 8 9 10)
; (x3 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20)
; (x4 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30)
;; (x5 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40)
; (y1 y2 y3 y4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40)
; (y1 y2 y3 y4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40)
;; (x6 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50)
; (y1 y2 y3 y4 y5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50)
; (y1 y2 y3 y4 y5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50)


; Test N222
;; (define x (lambda (x1 x2 x3 x4 x5 x6 x7 x8 x9 . x10)
;; (lambda (y1 y2 y3 y4 y5 y6 y7 y8 y9 . y10) 
;; (lambda (z1 z2 z3 z4 z5 z6 z7 z8 z9 . z10) 
;; (lambda (k1 k2 k3 k4 k5 k6 k7 k8 k9 . k10) 
;; (lambda (l1 l2 l3 l4 l5 l6 l7 l8 l9 . l10) 
;; (lambda (h1 h2 h3 h4 h5 h6 h7 h8 h9 . h10) 
;; `(,x1 ,x2 ,x3 ,x4 ,x5 ,x6 ,x7 ,x8 ,x9 ,@x10 
;;  ,y1 ,y2 ,y3 ,y4 ,y5 ,y6 ,y7 ,y8 ,y9 ,@y10
;;  ,z1 ,z2 ,z3 ,z4 ,z5 ,z6 ,z7 ,z8 ,z9 ,@z10
;;  ,k1 ,k2 ,k3 ,k4 ,k5 ,k6 ,k7 ,k8 ,k9 ,@k10
;;  ,l1 ,l2 ,l3 ,l4 ,l5 ,l6 ,l7 ,l8 ,l9 ,@l10
;;  ,h1 ,h2 ,h3 ,h4 ,h5 ,h6 ,h7 ,h8 ,h9 ,@h10))))))))
;;  ((((((x 1 2 3 4 5 6 7 8 9 10) 11 12 13 14 15 16 17 18 19 20 -11) 21 22 23 24 25 26 27 28 29 30 -30 -31) 31 32 33 34 35 36 37 38 39 40 -40 -41 -42 -43) 41 42 43 44 45 46 47 48 49 50 -50 -51 -52 -53 -54 -55 -56) 51 52 53 54 55 56 57 58 59 60 -55 -66 -77 -88 -99 -100)
; (1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 -11 21 22
; 23 24 25 26 27 28 29 30 -30 -31 31 32 33 34 35 36 37 38 39
; 40 -40 -41 -42 -43 41 42 43 44 45 46 47 48 49 50 -50 -51 -52
; -53 -54 -55 -56 51 52 53 54 55 56 57 58 59 60 -55 -66 -77
; -88 -99 -100)

; (1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 -11 21 22 
; 23 24 25 26 27 28 29 30 -30 -31 31 32 33 34 35 36 37 38 39 
; 40 -40 -41 -42 -43 41 42 43 44 45 46 47 48 49 50 -50 -51 -52 
; -53 -54 -55 -56 51 52 53 54 55 56 57 58 59 60 -55 -66 -77
; -88 -99 -100)

; Finally works ... 

; (1 2 3 4 5 6 7 8 9 11 12 13 14 15 16 17 18 19 
; 21 22 23 24 25 26 27 28 29 31 32 33 34 35 36 37 38 39 
; 41 42 43 44 45 46 47 48 49 51 52 53 54 55 56 57 58 59 -100 -99 -88 -77 -66 -55 60 -56 -55 -54 -53 -52
; -51 -50 50 -43 -42 -41 -40 40 -31 -30 30 -11 20 10)
; (-100 -99 -88 -77 -66 -55 60 59 58 57 56 55 54 53 52 51 -56 -55 -54 -53 -52 
; -51 -50 50 49 48 47 46 45 44 43 42 41 -43 -42 -41 -40 40 39 38 37 36 35 34 33 32 31 
; -31 -30 30 29 28 27 26 25 24 23 22 21 -11 20 19 18 17 16 15 14 13 12 11 10 9 8 7 6 5 4 3 2 1)

; reversed OutPut ... (Can Remove List.rev & Change Impl. of SimpleLambda)


;(1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22
; 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59 60)


; Test N223
;;  (define x (lambda x10 (lambda y10 (lambda z10 (lambda k10 (lambda l10 (lambda h10 
;;      `(,@x10 ,@y10 ,@z10 ,@k10 ,@l10 ,@h10))))))))
;;  ((((((x 1 2 3 4 5 6 7 8 9 10) 
;;         11 12 13 14 15 16 17 18 19 20 -11) 
;;             21 22 23 24 25 26 27 28 29 30 -30 -31) 
;;                 31 32 33 34 35 36 37 38 39 40 -40 -41 -42 -43) 
;;                     41 42 43 44 45 46 47 48 49 50 -50 -51 -52 -53 -54 -55 -56) 
;;                         51 52 53 54 55 56 57 58 59 60 -55 -66 -77 -88 -99 -100)

; (1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 -11 21 22
; 23 24 25 26 27 28 29 30 -30 -31 31 32 33 34 35 36 37 38 39
; 40 -40 -41 -42 -43 41 42 43 44 45 46 47 48 49 50 -50 -51 -52
; -53 -54 -55 -56 51 52 53 54 55 56 57 58 59 60 -55 -66 -77
; -88 -99 -100)

; (1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 -11 21 22
; 23 24 25 26 27 28 29 30 -30 -31 31 32 33 34 35 36 37 38 39
; 40 -40 -41 -42 -43 41 42 43 44 45 46 47 48 49 50 -50 -51 -52 
;-53 -54 -55 -56 51 52 53 54 55 56 57 58 59 60 -55 -66 -77
; -88 -99 -100)

; Finally works ..


; (-100 -99 -88 -77 -66 -55 60 59 58 57 56 55 54 53 52 51 -56 -55 -54 
; -53 -52 -51 -50 50 49 48 47 46 45 44 43 42 41 -43 -42 -41 -40 40 39 38 37 36 35 34 33 32 31 -31
; -30 30 29 28 27 26 25 24 23 22 21 -11 20 19 18 17 16 15 14 13 12 11 10 9 8 7 6 5 4 3 2 1)

;; OK, now prints all, But reversed.
;; Idea: Do Not Do List.rev to args, and Change Impl. SimpleLambda

; (1 2 3 4 5 6 7 8 9 10 ()
; 11 12 13 14 15 16 17 18 19 20 -11
; 21 22 23 24 25 26 27 28 29 30 -30 31
; 32 33 34 35 36 37 38 39 40 -40 41 42 43
; 44 45 46 47 48 49 50 -50 51 52 53 54 55 56
; 57 58 59 60 -55)


;; (define x (lambda a (lambda b (lambda c (lambda d
;;          `(,@a ,@b ,@c ,@d))))))
;; ((((x 1 2 3)
;;     10 11 12)
;;         20 21 22)
;;             30 31 32)
; (1 2 3 10 11 12 20 21 22 30 31 32)
; (1 2 3 10 11 12 20 21 22 30 31 32)

;; (define x (lambda a (lambda b (lambda c (lambda d (lambda e (lambda f
;;          `(,@a ,@b ,@c ,@d ,@e ,@f))))))))

;; ((((((x 0 1 2)
;;     10 11 12)
;;         20 21 22)
;;             30 31 32)
;;                 40 41 42)
;;                     50 51 52)
; (0 1 2 10 11 12 20 21 22 30 31 32 40 41 42 50 51 52)
; (0 1 2 10 11 12 20 21 22 30 31 32 40 41 42 50 51 52)

;; (define x (lambda a (lambda b (lambda c (lambda d
;;          `(,@a ,@b ,@c ,@d))))))
;; ((((x 1 2 3 4 5 6 7 8 9 10)
;;     11 12 13 14 15 16 17 18 19 20)
;;         21 22 23 24 25 26 27 28 29 30)
;;             31 32 33 34 35 36 37 38 39 40)
; (1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23
; 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40)
; (1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40)

;; (define x (lambda a (lambda b (lambda c (lambda d
;;          `(,@a ,@b ,@c ,@d))))))
;; ((((x 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15)
;;     16 17 18 19 20 21 22 23 24 25 26 27 28 29 30)
;;         31 32 33 34 35 36 37 38 39 40 41 42 43 44 45)
;;             46 47 48 49 50 51 52 53 54 55 56 57 58 59 60)
; (1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23
; 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43
; 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59 60)
; (1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59 60)

;;  (define x (lambda a (lambda b (lambda c
;;      `(,@a ,@b ,@c)))))
;;  (((x 1 2 3 4 5 6 7 8 9 10) 
;;         11 12 13 14 15 16 17 18 19 20 -11) 
;;             21 22 23 24 25 26 27 28 29 30 -30 -31)
; (1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 -11 21
; 22 23 24 25 26 27 28 29 30 -30 -31)

; (1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30)

;;  (define x (lambda a (lambda b (lambda c
;;      `(,@a ,@b ,@c)))))
;;  (((x 1 2 3 4 5 6 7 8 9 10) 
;;         11 12 13 14 15 16 17 18 19 20 21) 
;;             21 22 23 24 25 26 27 28 29 30 31 32)
; (1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 21 22
; 23 24 25 26 27 28 29 30 31 32)

; (1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30)

;; (define x (lambda a (lambda b (lambda c
;;      `(,@a ,@b ,@c)))))
;; (((x 1 2 3 4 5 6 7 8 9 10 11 12)
;;     21 22 23 24 25 26 27 28 29 30 31 32)
;;         31 32 33 34 35 36 37 38 39 40 41 42)
; (1 2 3 4 5 6 7 8 9 10 11 12 21 22 23 24 25 26 27 28 29 30 31
; 32 31 32 33 34 35 36 37 38 39 40 41 42)

; (1 2 3 4 5 6 7 8 9 10 11 12 21 22 23 24 25 26 27 28 29 30 31 32 31 32 33 34 35 36 37 38 39 40 41 42)

;; (define x (lambda a (lambda b (lambda c
;;      `(,@a ,@b ,@c)))))
;; (((x 1)
;;     21 22)
;;         31 32 33 34 35 36)
; (1 21 22 31 32 33 34 35 36)
; (1 21 31)

;; (define x (lambda a (lambda b
;;      `(,@a ,@b))))
;; ((x 1)
;;     21 22)
; (1 21 22)
; (1 21)

; the bug is that next applic think that it will got the same number of params like the previous,
; covered lambda: 1 param
; inner lambda: 2 params
; take from inner lambda only one param

;; (define x (lambda a (lambda b
;;      b )))
;; ((x 1)
;;     2 3) ; (2 3)
;;          ; (2 3)

;; ((lambda x x) 1)

;; Idea for impelemt- after create pairs, clean the stack of only opt args in.
;; so, in the next application, only <nArgs> + 1 params in the stack.
;; so, need to-
;; after application, 
;; add rsp, 8 * (<nArgs> - (<nParams> + 1))

;; (define x (lambda a (lambda b
;;      b )))
;; ((x 1 2 3 4 5 6)
;;     1 2 3 4 5 6 7 8 9 10 11 12 13)
; (1 2 3 4 5 6 7 8 9 10 11 12 13)
; (((((((((((((() . 1) . 2) . 3) . 4) . 5) . 6) . 7) . 8) . 9) . 10) . 11) . 12) . 13)


;; (define x (lambda a (lambda b
;;      `(,@a ,@b))))
;; ((x 1)
;;     21 22)

;; ((lambda a `(,@a)) 1 2 3)
; (1 2 3)
; new implematation do not support ,@ : |

    ;; ((lambda a a)1 2)


; (1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 
; 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59 60)

;; ((lambda (x)
;;     (+ 1 1)
;;     (+ 3 0)) 1)

;; (apply (lambda x x) '(3 4))
;; '()

;; (+ 1 2 3 4)

;; (apply (lambda(x)x) 5 '())

;; (define foo5
;;     (lambda (x y)
;;         (lambda () y)
;;         (lambda () x)))
;; ((foo5 1 2))
; 1

;; ((lambda(x)
;;     ((lambda(y z)
;;         x)1 2)) 3)
; 3

;; ((((lambda (x y d e f g h i j k l m n o p) (lambda (z) (lambda (a b c) d))) 1 2 10 20 30 40 50 60 70 80 90 100 120 130 140) 3)4 5 6)
; 10
; 10

;;  ((((lambda (x y d e f g h i j k l m n o p) (lambda (z) (lambda (a b c) m))) 1 2 10 20 30 40 50 60 70 80 90 100 120 130 140) 3)4 5 6)
; 100
; 100

;; (apply - `(3 ,@(append '(4 4) '(4))))
; -9
; -1

;; (define foo5
;;             (lambda (x y)
;;                 (lambda () 
;;                         "\n \r \f this is \n \r \f "
;;                         (set! x 5))
;;                 (lambda () x)
;;             ))

;; ((foo5 1 2)) 
; 1

;; (apply (lambda x x) '())

;; ((lambda x
;;     (lambda y
;;         y) 1) 2)

; T_421
;; (((lambda (x) 
;;                 (lambda (y . z) 
;;                 (if `notbool (+ (+ x  (* y (car z)) (car (cdr z))) 9)))) 8) 10 11 12)
; 139

; T_455
     (define andmap (lambda (p lst)
                      (or (null? lst)
                          (and (p (car lst)) (andmap p (cdr lst)))) ))
              ; make-matrix creates a matrix (a vector of vectors).
              ; make-matrix creates a matrix (a vector of vectors).
              (define make-matrix
                (lambda (rows columns)
                (letrec ([loop (lambda (m i)
                (if (= i rows)
                    (begin m)
                    (begin
                      (vector-set! m i (make-vector columns))
                      (loop m (+ i 1)))))])
              (loop (make-vector rows) 0)))) 

              ; matrix? checks to see if its argument is a matrix.
              ; It isn't foolproof, but it's generally good enough.
              (define matrix?
                (lambda (x)
                  (and (vector? x)
                      (> (vector-length x) 0)
                      (vector? (vector-ref x 0)))))

              ; matrix-rows returns the number of rows in a matrix.
              (define matrix-rows
                (lambda (x)
                  (vector-length x)))

              ; matrix-columns returns the number of columns in a matrix.
              (define matrix-columns
                (lambda (x)
                  (vector-length (vector-ref x 0))))

              ; matrix-ref returns the jth element of the ith row.
              (define matrix-ref
                (lambda (m i j)
                  (vector-ref (vector-ref m i) j)))

              ; matrix-set! changes the jth element of the ith row.
              (define matrix-set!
                (lambda (m i j x)
                  (vector-set! (vector-ref m i) j x)))

              ; mat-sca-mul multiplies a matrix by a scalar.
              (define mat-sca-mul
                (lambda (x m)
                  (let* ([nr (matrix-rows m)]
                        [nc (matrix-columns m)]
                        [r (make-matrix nr nc)])
                        (letrec ([loop (lambda (i)
                        (if (= i nr)
                            (begin r)
                            (begin
                                (letrec ([loop2 (lambda (j)
                                (if (= j nc)
                                    #t
                                    (begin
                                      (matrix-set! r i j (* x (matrix-ref m i j)))
                                      (loop2 (+ j 1)))))])
                (loop2 0))
                              (loop (+ i 1)))))])
              (loop 0)))))

              ; mat-mat-mul multiplies one matrix by another, after verifying
              ; that the first matrix has as many columns as the second
              ; matrix has rows.
              (define mat-mat-mul
                (lambda (m1 m2)
                  (let* ([nr1 (matrix-rows m1)]
                        [nr2 (matrix-rows m2)]
                        [nc2 (matrix-columns m2)]
                        [r (make-matrix nr1 nc2)])
                        (letrec ([loop (lambda (i)
                        (if (= i nr1)
                            (begin r)
                            (begin
                                (letrec ([loop (lambda (j)
                                (if (= j nc2)
                                    #t
                                    (begin
                                        (letrec ([loop (lambda (k a)
                                        (if (= k nr2)
                                            (begin (matrix-set! r i j a))
                                            (begin
                                              (loop
                                                (+ k 1)
                                                (+ a
                                                  (* (matrix-ref m1 i k)
                                                      (matrix-ref m2 k j)))))))])
                                            (loop 0 0))
                                      (loop (+ j 1)))))])
                                (loop 0))
                        (loop (+ i 1)))))])
              (loop 0))))) 


                ; mul is the generic matrix/scalar multiplication procedure
                (define mul
                  (lambda (x y)
                    (cond
                      [(number? x)
                      (cond
                        [(number? y) (* x y)]
                        [(matrix? y) (mat-sca-mul x y)]
                        [else "this should be an error, but you don't support exceptions"])]
                      [(matrix? x)
                      (cond
                        [(number? y) (mat-sca-mul y x)]
                        [(matrix? y) (mat-mat-mul x y)]
                        [else "this should be an error, but you don't support exceptions"])]
                      [else "this should be an error, but you don't support exceptions"])))


            ;;     (mul '#(#(2 3 4)
            ;;     #(3 4 5))
            ;;   '#(#(1) #(2) #(3)))
              ; #(#(20) #(26))

            ;;   (mul '#(#(1 2 3))
            ;;       '#(#(2 3)
            ;;           #(3 4)
            ;;           #(4 5)))
            ; #(#(20 26))

            ;;   (mul '#(#(1 2 3)
            ;;           #(4 5 6))
            ;;       '#(#(1 2 3 4)
            ;;           #(2 3 4 5)
            ;;           #(3 4 5 6)))
            ;#(#(14 20 26 32) #(32 47 62 77))

            ;;   (mul -2
            ;;     '#(#(3 -2 -1)
            ;;       #(-3 0 -5)
            ;;       #(7 -1 -1))
            ;;       )
            ; #(#(-6 4 2) #(6 0 10) #(-14 2 2))

                  (mul 0.5 '#(#(1 2 3)) )
                  (mul 1 0.5)
            ; 0.5
