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
;; (integer->char 255)
;#\ÿ
;#\�
;; '*

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
            (define x_0 0)
            (define x_1 1)
            (define x_2 2)
            (define x_3 3)
            (define x_4 4)
            (define x_5 5)
            (define x_6 6)
            (define x_7 7)
            (define x_8 8)
            (define x_9 9)
            (define x_10 10)
            (define x_11 11)
            (define x_12 12)
            (define x_13 13)
            (define x_14 14)
            (define x_15 15)
            (define x_16 16)
            (define x_17 17)
            (define x_18 18)
            (define x_19 19)
            (define x_20 20)
            (define x_21 21)
            (define x_22 22)
            (define x_23 23)
            (define x_24 24)
            (define x_25 25)
            (define x_26 26)
            (define x_27 27)
            (define x_28 28)
            (define x_29 29)
            (define x_30 30)
            (define x_31 31)
            (define x_32 32)
            (define x_33 33)
            (define x_34 34)
            (define x_35 35)
            (define x_36 36)
            (define x_37 37)
            (define x_38 38)
            (define x_39 39)
            (define x_40 40)
            (define x_41 41)
            (define x_42 42)
            (define x_43 43)
            (define x_44 44)
            (define x_45 45)
            (define x_46 46)
            (define x_47 47)
            (define x_48 48)
            (define x_49 49)
            (define x_50 50)
            (define x_51 51)
            (define x_52 52)
            (define x_53 53)
            (define x_54 54)
            (define x_55 55)
            (define x_56 56)
            (define x_57 57)
            (define x_58 58)
            (define x_59 59)
            (define x_60 60)
            (define x_61 61)
            (define x_62 62)
            (define x_63 63)
            (define x_64 64)
            (define x_65 65)
            (define x_66 66)
            (define x_67 67)
            (define x_68 68)
            (define x_69 69)
            (define x_70 70)
            (define x_71 71)
            (define x_72 72)
            (define x_73 73)
            (define x_74 74)
            (define x_75 75)
            (define x_76 76)
            (define x_77 77)
            (define x_78 78)
            (define x_79 79)
            (define x_80 80)
            (define x_81 81)
            (define x_82 82)
            (define x_83 83)
            (define x_84 84)
            (define x_85 85)
            (define x_86 86)
            (define x_87 87)
            (define x_88 88)
            (define x_89 89)
            (define x_90 90)
            (define x_91 91)
            (define x_92 92)
            (define x_93 93)
            (define x_94 94)
            (define x_95 95)
            (define x_96 96)
            (define x_97 97)
            (define x_98 98)
            (define x_99 99)
            (define x_100 100)
       
            (set! x_0 -0)
            (set! x_1 -1)
            (set! x_2 -2)
            (set! x_3 -3)
            (set! x_4 -4)
            (set! x_5 -5)
            (set! x_6 -6)
            (set! x_7 -7)
            (set! x_8 -8)
            (set! x_9 -9)
            (set! x_10 -10)
            (set! x_11 -11)
            (set! x_12 -12)
            (set! x_13 -13)
            (set! x_14 -14)
            (set! x_15 -15)
            (set! x_16 -16)
            (set! x_17 -17)
            (set! x_18 -18)
            (set! x_19 -19)
            (set! x_20 -20)
            (set! x_21 -21)
            (set! x_22 -22)
            (set! x_23 -23)
            (set! x_24 -24)
            (set! x_25 -25)
            (set! x_26 -26)
            (set! x_27 -27)
            (set! x_28 -28)
            (set! x_29 -29)
            (set! x_30 -30)
            (set! x_31 -31)
            (set! x_32 -32)
            (set! x_33 -33)
            (set! x_34 -34)
            (set! x_35 -35)
            (set! x_36 -36)
            (set! x_37 -37)
            (set! x_38 -38)
            (set! x_39 -39)
            (set! x_40 -40)
            (set! x_41 -41)
            (set! x_42 -42)
            (set! x_43 -43)
            (set! x_44 -44)
            (set! x_45 -45)
            (set! x_46 -46)
            (set! x_47 -47)
            (set! x_48 -48)
            (set! x_49 -49)
            (set! x_50 -50)
            (set! x_51 -51)
            (set! x_52 -52)
            (set! x_53 -53)
            (set! x_54 -54)
            (set! x_55 -55)
            (set! x_56 -56)
            (set! x_57 -57)
            (set! x_58 -58)
            (set! x_59 -59)
            (set! x_60 -60)
            (set! x_61 -61)
            (set! x_62 -62)
            (set! x_63 -63)
            (set! x_64 -64)
            (set! x_65 -65)
            (set! x_66 -66)
            (set! x_67 -67)
            (set! x_68 -68)
            (set! x_69 -69)
            (set! x_70 -70)
            (set! x_71 -71)
            (set! x_72 -72)
            (set! x_73 -73)
            (set! x_74 -74)
            (set! x_75 -75)
            (set! x_76 -76)
            (set! x_77 -77)
            (set! x_78 -78)
            (set! x_79 -79)
            (set! x_80 -80)
            (set! x_81 -81)
            (set! x_82 -82)
            (set! x_83 -83)
            (set! x_84 -84)
            (set! x_85 -85)
            (set! x_86 -86)
            (set! x_87 -87)
            (set! x_88 -88)
            (set! x_89 -89)
            (set! x_90 -90)
            (set! x_91 -91)
            (set! x_92 -92)
            (set! x_93 -93)
            (set! x_94 -94)
            (set! x_95 -95)
            (set! x_96 -96)
            (set! x_97 -97)
            (set! x_98 -98)
            (set! x_99 -99)
            (set! x_100 -100)
         
           

            x_0
            x_1
            x_2
            x_3
            x_4
            x_5
            x_6
            x_7
            x_8
            x_9
            x_10
            x_11
            x_12
            x_13
            x_14
            x_15
            x_16
            x_17
            x_18
            x_19
            x_20
            x_21
            x_22
            x_23
            x_24
            x_25
            x_26
            x_27
            x_28
            x_29
            x_30
            x_31
            x_32
            x_33
            x_34
            x_35
            x_36
            x_37
            x_38
            x_39
            x_40
            x_41
            x_42
            x_43
            x_44
            x_45
            x_46
            x_47
            x_48
            x_49
            x_50
            x_51
            x_52
            x_53
            x_54
            x_55
            x_56
            x_57
            x_58
            x_59
            x_60
            x_61
            x_62
            x_63
            x_64
            x_65
            x_66
            x_67
            x_68
            x_69
            x_70
            x_71
            x_72
            x_73
            x_74
            x_75
            x_76
            x_77
            x_78
            x_79
            x_80
            x_81
            x_82
            x_83
            x_84
            x_85
            x_86
            x_87
            x_88
            x_89
            x_90
            x_91
            x_92
            x_93
            x_94
            x_95
            x_96
            x_97
            x_98
            x_99
            x_100
          