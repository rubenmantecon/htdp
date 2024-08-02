;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname ex-319) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "abstraction.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "abstraction.rkt" "teachpack" "2htdp")) #f)))
;; Exercise 319. Design substitute. It consumes an S-expression s and two symbols, old and new.
;; The result is like s with all occurrences of old replaced by new.

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

; S-exp Symbol Symbol -> S-exp
; replace old symbol occurrences with new symbol occurrences
(check-expect (substitute 1 12 'A) 'A)
(check-expect (substitute '(1) 1 '(1 2 3)) '((1 2 3)))
(check-expect (substitute '(1 2 3) 2 "a") '(1 "a" 3))
(define (substitute s old new)
  (local (; SL -> SL
          ; replace old symbol with new symbol
          (define (substitute-sl s)
            (cond
              [(empty? s) '()]
              [else (if (and (atom? (first s)) (equal? (first s) old))
                        (cons new (substitute-sl (rest s)))
                        (cons (first s) (substitute-sl (rest s))))]
              )))
    
    (cond
      [(atom? s) new]
      [else (substitute-sl s)])))