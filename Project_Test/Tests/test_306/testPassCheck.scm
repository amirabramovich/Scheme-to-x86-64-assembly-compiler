(equal? 

 ;Scheme Output:
'(

(2 3)
(1 1 2)
('bye "helloa")
("bye")
(1 2)
4
(2 3)
1


) 





;Yours Output:
'(

(2 3)
(1 1 2)
((quote bye) "helloa")
("bye")
(1 2)
4
(2 3)
1


)



)