;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname ex-240) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "abstraction.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "abstraction.rkt" "teachpack" "2htdp")) #f)))
; A Layer is a structure:
(define-struct layer [stuff])

; An LStr is one of: 
; – String
; – (make-layer LStr)
(make-layer (make-layer "LStr"))
; An LNum is one of: 
; – Number
; – (make-layer LNum)
(make-layer (make-layer "LNum"))

; A [List-of Layer] is one of:
; - '()
; - (cons Layer [List-of Layer])
(cons (make-layer "String") (cons (make-layer 2) '()))

