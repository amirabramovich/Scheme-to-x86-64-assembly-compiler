 
               
              (define x1 (lambda () '()))           
              (define x2 (lambda (y1) '(y1)))          
              (define x3 (lambda (y1 y2) '(y1 y2)))
              (define x4 (lambda (y1 y2 y3) '(y1 y2 y3))) 
              (define x5 (lambda (y1 y2 y3 y4) '(y1 y2 y3 y4))) 
              (define x6 (lambda (y1 y2 y3 y4 y5) '(y1 y2 y3 y4 y5))) 

              ;Checking applic is ok, poping stack correctly after execution, check rsp is restored correctly if seg fault 
              (x1)
              (x2 1)
              (x3 1 2)
              (x4 1 2 3)
              (x5 1 2 3 4)
              (x6 1 2 3 4 5)
    