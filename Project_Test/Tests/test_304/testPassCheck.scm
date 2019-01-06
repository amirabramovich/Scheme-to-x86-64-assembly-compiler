(equal? 

 ;Scheme Output:
'(

(2 3)
('bye "helloa")
(1 2)
(2 3)


) 





;Yours Output:
'(

(2 3)
((quote bye) "helloa")
(1 2)
(2 3)


)



)