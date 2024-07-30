;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname ex-318) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "abstraction.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "abstraction.rkt" "teachpack" "2htdp")) #f)))
;; Exercise 318. Design depth. The function consumes an S-expression and determines its depth.
;; An Atom has a depth of 1. The depth of a list of S-expressions is the maximum depth of its items plus 1.

; An S-expr is one of: 
; – Atom
; – SL
 
; An SL is one of: 
; – '()
; – (cons S-expr SL)

; An Atom is one of: 
; – Number
; – String
; – Symbol 

; X -> Boolean
; determines if x is an atom
(define (atom? x)
  (or (string? x) (number? x) (symbol? x)))

; S-expr -> N
; determines an S-expr's depth
(check-expect (depth 'a) 1)
(check-expect (depth 1) 1)
(check-expect (depth "1") 1)
(check-expect (depth '(a)) 2)
(check-expect (depth '(1)) 2)
(check-expect (depth '("1")) 2)
(check-expect (depth '(1 "1" (1 2))) 4)
(check-expect (depth '(1 2 (1 (2 "hi") 4))) 4)
(define (depth sexp)
  (cond
    [(atom? sexp) 1]
    [else (add1 (depth-sl sexp))]))

(define (depth-sl sl)
  (cond
    [(empty? sl) 0]
    [else (+ (add1 0) (depth-sl (rest sl)))]))

