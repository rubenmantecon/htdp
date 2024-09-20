;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname ex-318) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "abstraction.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "abstraction.rkt" "teachpack" "2htdp")) #f)))
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
; is X an atom
(check-expect (atom? (make-posn 0 0)) #false)
(check-expect (atom? 'a) #true)
(define (atom? x) (or (number? x) (string? x) (symbol? x)))

; S-expr -> N
; determine the depth of an S-expr

(check-expect (depth '(hello)) 1)
(check-expect (depth '(hello bye)) 1)
(check-expect (depth '(hello (bye))) 2)
(check-expect (depth '(hello (bye) (greetings))) 2)
(check-expect (depth '(hello (bye) (greetings (partner)))) 3)
(define (depth sexp)
  (cond
    [(atom? sexp) 0]
    [else (depth-sl sexp)]))

; SL -> N
; determine the depth of an SL
(check-expect (depth-sl '()) 0)
(check-expect (depth-sl '(hello)) 1)
(check-expect (depth-sl '(hello bye)) 1)
(check-expect (depth-sl '(hello (bye))) 2)
(check-expect (depth-sl '(hello (bye) (greetings))) 2)
(check-expect (depth-sl '(hello (bye) (greetings (partner)))) 3)
(define (depth-sl sl)
  (cond
    [(empty? sl) 0]
    [else (max (add1 (depth (first sl))) (depth-sl (rest sl)))]))
