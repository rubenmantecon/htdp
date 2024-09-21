;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname ex-319) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "abstraction.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "abstraction.rkt" "teachpack" "2htdp")) #f)))
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

; S-expr Symbol Symbol -> S-expr
; substitute all occurences of the first symbol by the second
(check-expect (substitute '(hello) 'hello 'bye) '(bye))
(check-expect (substitute '(hello) 'bye 'whatever) '(hello))
(check-expect (substitute '(hello "dummy") 'bye 'whatever) '(hello "dummy"))
(check-expect (substitute '(hello goodbye ahoy 9) 'goodbye 'what?) '(hello what? ahoy 9))
(define (substitute sexp old new)
  (cond
    [(number? sexp) sexp]
    [(string? sexp) sexp]
    [(symbol? sexp) (if (symbol=? sexp old) new sexp)]
    [else (local (
                  (define (substitute-sl sl)
                    (cond
                      [(empty? sl) '()]
                      [else (cons (substitute (first sl) old new) (substitute-sl (rest sl)))])))
            (substitute-sl sexp))]))
