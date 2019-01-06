(equal? 

 ;Scheme Output:
'(

(1 2 (1 2 3))
("hello" 'hello #(#t #f 0.002))


) 





;Yours Output:
'(

(1 2 (1 2 3))
("hello" (quote hello) #(#t #f 0.002000))


)



)