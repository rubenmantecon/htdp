;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname ex-320) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "abstraction.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "abstraction.rkt" "teachpack" "2htdp")) #f)))
; An S-expr.v2 is one of: 
; – Number
; – String
; – Symbol
; – SL
 
; An SL.v2 is a [List-of S-expr]
		
; X -> Boolean
; is X an atom
(check-expect (atom? (make-posn 0 0)) #false)
(check-expect (atom? 'a) #true)
(define (atom? x) (or (number? x) (string? x) (symbol? x)))

; S-expr.v2 Symbol -> N
; count all occurrences of Symbol in S-expr
(check-expect (count.v2 'world 'hello) 0)
(check-expect (count.v2 '(world hello) 'hello) 1)
(check-expect (count.v2 '(((world) hello) hello) 'hello) 2)
(define (count.v2 sexp sy)
  (cond
    [(number? sexp) 0]
    [(string? sexp) 0]
    [(symbol? sexp) (if (symbol=? sexp sy) 1 0)]
    [else (count-sl.v2 sexp sy)]))

; [List-of S-expr] Symbol -> N
; count all occurences of Symbol in list of S-expr
(define (count-sl.v2 los sy)
  (cond
    [(empty? los) 0]
    [else (+ (count.v2 (first los) sy) (count-sl.v2 (rest los) sy))]))

; An S-expr.v3 is one of:
; – Number
; – String
; – Symbol
; – [List-of S-expr.v3]

; S-expr.v3 Symbol -> N
; count all occurences of Symbol in list of S-expr
(check-expect (count.v3 'world 'hello) 0)
(check-expect (count.v3 '(world hello) 'hello) 1)
(check-expect (count.v3 '(((world) hello) hello) 'hello) 2)
(define (count.v3 sexp sy)
  (cond
    [(number? sexp) 0]
    [(string? sexp) 0]
    [(symbol? sexp) (if (symbol=? sexp sy) 1 0)]
    [else (foldr
           (lambda (x acc) (+ (count.v3 x sy) acc))
           0 sexp)]))
