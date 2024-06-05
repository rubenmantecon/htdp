;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname ex-253) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; [Number -> Boolean]
(number? 1)

; [Boolean String -> Boolean]
(check-expect (string->bool=? #true "#true") #t)
(check-expect (string->bool=? #true "#false") #f)
(define (string->bool=? bool str)
  (string=? (boolean->string bool) str))

; [Number Number Number -> Number]
(max 1 76 3)

; [Number -> [List-of Number]]
(define (countdown n)
  (cond
    [(= n 0) '()]
    [else (cons n (countdown (sub1 n)))]))

; [[List-of Number] -> Boolean]
(check-expect (number-all? '(1)) #true)
(check-expect (number-all? '(1 "string")) #false)
(check-expect (number-all? '("string" 2)) #false)
(check-expect (number-all? '(1 2 3)) #true)
(define (number-all? l)
  (cond
    [(empty? (rest l)) (number? (first l))]
    [else (if (number? (first l))
              (number-all? (rest l))
              #false)]))