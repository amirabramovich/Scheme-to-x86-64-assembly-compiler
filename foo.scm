;; Mayer_Tests:
;; 006, 008- Not Sure, I think Parsed
;; 000, 001, 03 => Sig
;; 007 -Stack OverFlow


;; Yonatan tests
;; 47- Stack OverFlow (Support ~ 375 X's)
;; 70, 406- Fail
;; 454- Not sure (I can Run)

;70
;; (define x '(1 2))
;; (define y '(3 4))
;; (define z (append x y))
;; (set-car! x '*)
;; (set-car! y '$)
;; z
;(1 2 $ 4)
;(1 2 \x24 ;  4)

;406
;; (let ((baf (lambda (f)
;;                     (lambda (n)
;;                         (if (> n 0)
;;                             `(* ,n ,((f f) (- n 1)))
;;                             "end")))))
;;             ((baf baf) 3))
;(* 3 (* 2 (* 1 "end")))
;(\x2a ;  3 (\x2a ;  2 (\x2a ;  1 "end")))

;; `(* ,1)
;(* 1)
;(\x2a ;  1)

;; '$
;$
;\x24 ;

;; #\x2A
;; #\space

;; `(* ,33)
; (* 33)
;(\x2a ;  33)

;; '(* ,33)
;(* ,33)
;(\x2a ;  (unquote 33))

;; #\tab
;; '$
;; '*

;; *
;#<closure [env:0x6cb5b9, code:0x4017db]>
;#<closure [env:0x7fb3c305eab0, code:0x4061c8]>
;#<procedure *>

;; Nadav Tests
;; 104, 202, 242, 243, 245, 246, 251, 263, 270- Fail
;; 10,25,30,34 - Parsed (Not sure)

;104
;; (define x '(1 2))
;; (define y '(3 4))
;; (define z (append x y))
;; (set-car! x '*)
;; (set-car! y '$)
;; z 
;(1 2 $ 4)
;(1 2 \x24 ;  4)

;202
;; (char->integer (integer->char 255))
;#\ÿ
;#\�
;; '*

;; (char->integer (integer->char 1))
;; (char->integer(integer->char 2))
;; (char->integer(integer->char 3))
;; (char->integer(integer->char 4))

;; (integer->char 52)
;; (integer->char 75)
;; (integer->char 76)
;; (integer->char 77)
;; (integer->char 78)

;; (integer->char(char->integer #\x01))
;; (integer->char(char->integer #\x02))
;; (integer->char(char->integer #\x03))
;; (integer->char(char->integer #\x04))
;; (char->integer #\x05)


;; (set-car! '(a b c) '(x y z))
;; (set-car! '(1 2 3) (cdr '(1 2 3)))
;; ; I do not sure
;; (set-cdr! '(a b c) '(x y z))
;; (set-cdr! '(1 2 3) (cdr '(1 2 3)))
;; (string-set! "string" 1 #\p)
;; (symbol->string 'sym)
;; ;"sym"
;; (vector-set! '#(4 5 6) 1 7)
;; (define x (make-string 4 #\x20))
;; (string-set! x 1 #\p)
;; x
;" p  "
;" p  "

;47