;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname ex-321) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "abstraction.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "abstraction.rkt" "teachpack" "2htdp")) #f)))
;; Exercise 321. Abstract the data definitions for S-expr and SL so that they abstract over the kinds of Atoms that may appear.

; I don't really understand the question...

; An Atom is one of: 
; – Number
; – String
; – Symbol

; An SL is a [List-of S-expr]

; An S-expr is one of: 
; - Atom
; – SL

; OR

; An S-expr is one of: 
; – Number
; - String
; - Symbol
; – [List-of S-expr]