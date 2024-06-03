;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname ex-251) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "abstraction.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "abstraction.rkt" "teachpack" "2htdp")) #f)))
; [[List-of Number] -> Number] [List-of Number] Number -> Number
(check-expect (fold1 + '(1 2 3) 0) 6)
(check-expect (fold1 - '(1 2 3) 0) 2)
(check-expect (fold1 * '(1 2 3) 1) 6)
(define (fold1 fn l bool)
  (cond
    [(empty? l) bool]
    [else
     (fn (first l)
         (fold1 fn (rest l) bool))]))

