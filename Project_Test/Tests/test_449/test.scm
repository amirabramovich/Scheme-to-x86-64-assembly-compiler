 
            ; matrix? checks to see if its argument is a matrix.
            ; It isn't foolproof, but it's generally good enough.
            (define matrix?
            (lambda (x)
                (and (vector? x)
                    (> (vector-length x) 0)
                    (vector? (vector-ref x 0)))))
    