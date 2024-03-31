#reader
(lib "htdp-intermediate-reader.ss" "lang")
((modname test)
 (read-case-sensitive #t)
 (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")
                                                    (lib "web-io.rkt" "teachpack" "2htdp")
                                                    (lib "abstraction.rkt" "teachpack" "2htdp")))
 (htdp-settings #(#t
                  constructor
                  repeating-decimal
                  #f
                  #t
                  none
                  #f
                  ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")
                                                         (lib "web-io.rkt" "teachpack" "2htdp")
                                                         (lib "abstraction.rkt" "teachpack" "2htdp"))
                  #f)))
; Lon -> Lon
; adds 1 to each item on l
(check-expect (add1* '(1 2 3)) '(2 3 4))
(check-expect (add1* '(2 3 4)) '(3 4 5))
(define (add1* l)
  (cond
    [(empty? l) '()]
    [else (cons (add1 (first l)) (add1* (rest l)))]))

; Lon -> Lon
; adds 5 to each item on l
(check-expect (plus5 '(1 2 3)) '(6 7 8))
(check-expect (plus5 '(6 7 8)) '(11 12 13))
(define (plus5 l)
  (cond
    [(empty? l) '()]
    [else (cons (+ (first l) 5) (plus5 (rest l)))]))

; Lon -> Lon
; adds a number to each item on a list of numbers
(check-expect (add 1 '(1 2 3)) (add1* '(1 2 3)))
(check-expect (add 5 '(6 7 8)) (plus5 '(6 7 8)))
(define (add n l)
  (cond
    [(empty? l) '()]
    [(zero? n) l]
    [else (cons (+ n (first l)) (add n (rest l)))]))

; Lon -> Lon
; substracts a number to each item on a list of numbers
(check-expect (sub 2 '(2 2 2)) '(0 0 0))
(check-expect (sub 2 '(2 4 6)) '(0 2 4))
(define (sub n l)
  (cond
    [(empty? l) '()]
    [(zero? n) l]
    [else (cons (- (first l) n) (sub n (rest l)))]))
