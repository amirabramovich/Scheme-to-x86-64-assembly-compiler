;  1 2 #t 5 3.14 #\a '() "yo" #(1 2 3) 'cool '(1) '(1 2 3) '(9 . 9) '(3.14)
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
; ((((lambda (x y d e f g h i j k l m n o p) (lambda (z) (lambda (a b c) d))) 1 2 10 20 30 40 50 60 70 80 90 100 120 130 140) 3)4 5 6)

; (define (func .  x) x)
; (define gaa (lambda (a b . c) (+ a b)))
; (define voo (lambda (x . y) (begin x y)))
;; (define adder (lambda (x) (lambda (y) (+ x y))))
;; adder
;; ((adder 3)9)

;  (define plus3 (adder 3))
;  (plus3 9)
;  adder

;  ((adder ((goo 9)))10)
; (define g (lambda(x)x))
; (define f (lambda(x)(+ x 1)))
; ((lambda (x) (f (g (g x))))5)
; (define yo (lambda (x y) (lambda (z) (+ (+ 1 y) z))))
;  ((yo 3 5) 9)

;; (list? 1)
;; (apply < '(1 2 3 4)) ; #t
;; (apply list '(1 2 3)) ;; (1 2 3)
                      ;; (3 2)

;; (apply list '(1 2)) ;; (1 2)
                      ;; (2 1) 


;; false ?
                    ;;  push only last 2 vars ... 


;; (+ 1 2) ; 3