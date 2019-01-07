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
<<<<<<< HEAD
;; (apply list '(1 2 3)) ;; (1 2 3)
=======
; (apply list '(1 2 3)) ;; (1 2 3)
>>>>>>> 9a708ad5fc3458140ea2f03e6be3d2a4a1244337
                      ;; (3 2)

;; (apply list '(1 2)) ;; (1 2)
                      ;; (2 1) 


;; false ?
                    ;;  push only last 2 vars ... 
<<<<<<< HEAD


;; (+ 1 2) ; 3
=======
>>>>>>> 9a708ad5fc3458140ea2f03e6be3d2a4a1244337
