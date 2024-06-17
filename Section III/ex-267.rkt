;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname ex-267) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
; [List-of Number] -> [List-of Number]
; convert $ to €
(define (convert-euro l)
  (map (lambda (x) (* 1.06 x)) l))

; [List-of Number] -> [List-of Number]
; convert Fahrenheit to Celsius
(define (convertFC l)
  (map (lambda (x) (/ (- x 32) 1.8)) l))

; [List-of Posn] -> [List-of [List-of Number]]
; convert a list of Posns into tuples
(define (translate l)
  (map (lambda (x) (list (posn-x x) (posn-y x))) l))