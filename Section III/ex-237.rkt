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
; Lon Number -> Lon
; select those numbers on l
; that are below t
(define (small l t)
  (cond
    [(empty? l) '()]
    [else
     (cond
       [(< (first l) t) (cons (first l) (small (rest l) t))]
       [else (small (rest l) t)])]))

; Lon Number -> Lon
; select those numbers on l
; that are above t
(define (large l t)
  (cond
    [(empty? l) '()]
    [else
     (cond
       [(> (first l) t) (cons (first l) (large (rest l) t))]
       [else (large (rest l) t)])]))

(check-expect (extract < '() 5) (small '() 5))
(check-expect (extract < '(3) 5) (small '(3) 5))
(check-expect (extract < '(1 6 4) 5) (small '(1 6 4) 5))
(define (extract R l t)
  (cond
    [(empty? l) '()]
    [else
     (cond
       [(R (first l) t) (cons (first l) (extract R (rest l) t))]
       [else (extract R (rest l) t)])]))

; Lon Number -> Lon
(define (small-1 l t)
  (extract < l t))

; Lon Number -> Lon
(define (large-1 l t)
  (extract > l t))

; Number Number -> Boolean
; is the area of a square with side x larger than c
(define (squared>? x c)
  (> (* x x) c))
