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

; Nelon -> Number
; determines the smallest
; number on l
(define (inf l)
  (cond
    [(empty? (rest l)) (first l)]
    [else (if (< (first l) (inf (rest l))) (first l) (inf (rest l)))]))

; Nelon -> Number
; determines the largest
; number on l
(define (sup l)
  (cond
    [(empty? (rest l)) (first l)]
    [else (if (> (first l) (sup (rest l))) (first l) (sup (rest l)))]))

; Nelon -> Number
; determines the smallest number on l
(define (inf-1 l)
  (first (sort l <)))

; Nelon -> Number
; determines the biggest number on l
(define (sup-1 l)
  (first (sort l >)))

; Nelon -> Number
; determines the smallest number on l
(define (inf-2 l)
  (min l))

; Nelon -> Number
; determines the biggest number on l
(define (sup-2 l)
  (max l))
