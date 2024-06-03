;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname ex-243) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "abstraction.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "abstraction.rkt" "teachpack" "2htdp")) #f)))
(define (f x) x)

(cons f '())
(f f)
(cons f (cons 10 (cons (f 10) '())))

; As far as I can understand, they all are values, because the all evaluate to something
; The first, to a list of (a) primitive(s)
; The second, to a primitive (a function definition is passed as a
; parameter to a function that simply returns said passed parameter.
; Since the parameter is a now considered a value in ISL, I consider it a primitive)
; The third, to another list of numbers (values in and by themselves
; and derived from function evaluation) and primitives