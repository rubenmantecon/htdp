;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname ex-299) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp")) #f)))
;; Exercise 299. Design a data representation for finite and infinite sets so that you can represent
;; the sets of all odd numbers, all even numbers, all numbers divisible by 10, and so on.
;; Hint Mathematicians deal with sets as functions that consume a potential element ed and produce #true only if ed belongs to the set. 

; A Set is a function:
; [N -> Boolean]
; interpretation produces #true if N is an element of the set, #false otherwise
; essentially, a Set is a predicate

; Number Set -> Set
; add an element to any particular set
(define (add-element n s)
  (s n))

; Number -> Set
; add an element to the odd set
(define (odd-set n) (add-element n odd?))

; Number -> Set
; add an element to the even set
(define (even-set n) (add-element n even?))

; Number -> Set
; add an element to the set of numbers divisible by 10
(define (decimal-set n) (add-element n (lambda (x) (zero? (modulo x 10)))))

; Set Set -> Set
; combine the elements of two sets
(define (union s1 s2)
  (lambda (n)
    (or (add-element n s1) (add-element n s2))))

; Set Set -> Set
; collect all elements common to two sets
(define (intersect s1 s2)
  (lambda (n)
    (and (add-element n s1) (add-element s2))))


; I'm unsure if I have understood properly. The given hint trips me off. I think it makes reference to
; [Maybe X]. If that is the case, then I have not really understood, and I'm simply repeating the previous
; examples.