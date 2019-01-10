   
            ;;
            ;; Function: celsius->fahrenheit
            ;; -----------------------------
            ;; Simple conversion function to bring a Celsius
            ;; degree amount into Fahrenheit.
            ;;
            (define (celsius->fahrenheit celsius)
            (+ (* 1.8 celsius) 32))    

            (celsius->fahrenheit 34)
            (celsius->fahrenheit 22)
            (celsius->fahrenheit 11)
            (celsius->fahrenheit 1000)
    