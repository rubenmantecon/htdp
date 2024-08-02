;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname ex-320) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "abstraction.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "abstraction.rkt" "teachpack" "2htdp")) #f)))
;; Exercise 320. Practice the step from data definition to function design with two changes to the definition of S-expr.

; An S-expr is one of: 
; – Number
; - String
; - Symbol
; – SL

; An SL is a [List-of S-expr]

; X -> Boolean
; determines if x is an sexp
(check-satisfied '(1 2 3) sexp?)
(check-satisfied "a" sexp?)
(check-satisfied '(11 (2 3) (('(3)))) sexp?)
(define (sexp? x)
  (cond
    [(list? x) (andmap sexp? x)]
    [else (or (string? x) (number? x) (symbol? x))]))

; S-expr -> N
; count the number of symbols in a S-expr
(check-expect (count.v1 '() 1) 0)
(check-expect (count.v1 '("1" "2" "3") 1) 0)
(check-expect (count.v1 '(a 1 2 3 (2 3) (2 ('c c c))) 'c) 3)
(check-expect (count.v1 '(a b c b) 'b) 2)
(check-expect (count.v1 '(a (1 2) (b (c d))) 'a) 1)
(define (count.v1 sexp sy)
  (cond
    [(empty? sexp) 0]
    [(number? sexp) 0]
    [(string? sexp) 0]
    [(symbol? sexp) (if (symbol=? sexp sy) 1 0)]
    [else (local (; SL Symbol -> N
                  ; count the symbols in a SL
                  (define (count-sl sl sy)
                    (cond
                      [(empty? sl) 0]
                      [else (+ (count.v1 (first sl) sy)
                               (count-sl (rest sl) sy))])))
            (count-sl sexp sy)
    )]))

;; For the second step, Integrate the data definition of SL into the one for S-expr. Simplify count again. Hint Use lambda.

; An S-expr is one of: 
; – Number
; - String
; - Symbol
; – [List-of S-expr]

; S-expr -> N
; count the number of symbols in a S-expr
(check-expect (count '() 1) 0)
(check-expect (count '("1" "2" "3") 1) 0)
(check-expect (count '(a 1 2 3 (2 3) (2 ('c c c))) 'c) 3)
(check-expect (count '(a b c b) 'b) 2)
(check-expect (count '(a (1 2) (b (c d))) 'a) 1)
(define (count sexp sy)
  (cond
    [(number? sexp) 0]
    [(string? sexp) 0]
    [(symbol? sexp) (if (symbol=? sexp sy) 1 0)]
    [else (foldl (lambda (sexp acc) (+ (count sexp sy) acc)) 0 sexp)]))
