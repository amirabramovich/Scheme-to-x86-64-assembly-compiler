   
              (define x1 (lambda y y))           
              (define x2 (lambda (y1 . y2) `(y1 ,@y2)))          
              (define x3 (lambda (y1 y2 . y3) `(y1 y2 ,@y3)))
              (define x4 (lambda (y1 y2 y3 . y4) `(y1 y2 y3 ,@y4))) 
              (define x5 (lambda (y1 y2 y3 y4 . y5) `(y1 y2 y3 y4 ,@y5))) 
              (define x6 (lambda (y1 y2 y3 y4 y5 . y6) `(y1 y2 y3 y4 y5 ,@y6))) 

              ;Checking applic is ok, poping stack correctly after execution, check rsp is restored correctly if seg fault 
              ; Checking lambda opt shift frame works correctly so that the applic will be able to restore rsp correctly 
              (x1)
              (x2 1 2 3 4 5 6 7 8 9 10)
              (x3 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20)
              (x4 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30)
              (x5 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40)
              (x6 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50)
    