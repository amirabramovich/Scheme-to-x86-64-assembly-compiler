 1 2 #t 5 3.14 #\a '() "yo" #(1 2 3) 'cool '(1) '(1 2 3) '(9 . 9) '(3.14)
 (if (if (if 1 2 3) (if 4 (if 5 (if 6 7 8) 9) 10) (if 11 (if 12 (if 13 14 15) 16) 17)) (if 18 (if 19 20 21) 22) 23)
(or (or (or 1 2 3) (or 4 (or 5 (or 6 7 8) 9) 10) (or 11 (or 12 (or 13 14 15) 16) 17)) (or 18 (or 19 20 21) 22) 23)
 (if (if (if 1 2 3) (if 4 (if 5 (or 6 7 8) 9) 10) (or 11 (or 12 (or 13 14 15) 16) 17)) (or 18 (or 19 20 21) 22) 23)
 (if (or (if 1 2 3) (if 4 (if 5 (if 6 7 8) 9) 10) (if 11 (or 12 (or 13 14 15) 16) 17)) (if 18 (or 19 20 21) 22) 23)
(boolean? 99)
 1
 (define x '(1 2))
 (car '(1 2))
  (cdr '(1 2))
 x
 (set! x 3)
 (set! x '(1 2))
 (car x)
 (cdr x)
 (define x '(1 2))
  (set-car! x 0)
  (set-cdr! x 0)
  x ;; should print '(0 0)
(cons 1 2) ;; should print (1 . 2)
(cons 3 4) ;; should print (3 . 4)
 (define goo (lambda(x)(lambda()1)))
((goo 9))
 (define adder (lambda (x) (lambda (y) (+ x y))))
 (define plus3 (adder 3))
 plus3
 (plus3 9)
;  ((adder 3)9)
;  ((adder ((goo 9)))10)
; (define g (lambda(x)x))
; (define f (lambda(x)(+ x 1)))
; ((lambda (x) (f (g (g x))))5)
