;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname ex-302) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
;; Exercise 302. Recall that each occurrence of a variable receives its value from its binding occurrence.
;; Consider the following definition:

(define x (cons 1 x))

;; Where is the shaded occurrence of x bound? Since the definition is a constant definition and not a function definition,
;; we need to evaluate the right-hand side immediately. What should be the value of the right-hand side according to our rules?

; Uhm, I actually don't know, but I know that this expression does not compute.
; I did not understand the following explanation...