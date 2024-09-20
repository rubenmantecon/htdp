;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname ex-317) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "abstraction.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "abstraction.rkt" "teachpack" "2htdp")) #f)))
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

; S-expr Symbol -> N
; count a symbol's occurrences in an S-expr
(check-expect (count 'world 'hello) 0)
(check-expect (count '(world hello) 'hello) 1)
(check-expect (count '(((world) hello) hello) 'hello) 2)
(define (count sexp sy)
  (local (
          (define (count-atom at)
            (cond
              [(number? at) 1]
              [(string? at) 1]
              [(symbol? at) (if (symbol=? at sy) 1 0)]))
          (define (count-sl sl)
            (cond
              [(empty? sl) 0]
              [else (+ (count (first sl) sy) (count-sl (rest sl)))])))
    (cond
      [(atom? sexp) (count-atom sexp)]
      [else (count-sl sexp)])))