;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname ex-316) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "abstraction.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "abstraction.rkt" "teachpack" "2htdp")) #f)))
;; Exercise 316. Define the atom? function.

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

; R: essentially, and S-expr is either an Atom, or (nested) lists of Atoms

; X -> Boolean
; determines if x is an atom
(define (atom? x)
  (or (string? x) (number? x) (symbol? x)))

;; Sample Problem Design the function count, which determines how many times some symbol occurs in some S-expression.

; S-expr Symbol -> N 
; counts all occurrences of sy in sexp
(check-expect (count 'world 'hello) 0)
(check-expect (count '(world hello) 'hello) 1)
(check-expect (count '(((world) hello) hello) 'hello) 2)
(define (count sexp sy)
 (cond
   [(atom? sexp) (count-atom sexp sy)]
   [else (count-sl sexp sy)]))

 
(define (count-sl sl sy)
  (cond
    [(empty? sl) 0]
    [else (+ (count (first sl))
             (count-sl (rest sl) sy))]))


(define (count-atom at sy)
  (cond
    [(number? at) 1]
    [(string? at) 1]
    [(symbol? at) (if (symbol=? at sy) 1 0)]))