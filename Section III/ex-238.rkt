;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname ex-238) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "abstraction.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "abstraction.rkt" "teachpack" "2htdp")) #f)))
; Nelon -> Number
; determines the smallest
; number on l
(define (inf l)
  (cond
    [(empty? (rest l)) (first l)]
    [else (if (< (first l) (inf (rest l))) (first l) (inf (rest l)))]))

; Nelon -> Number
; determines the largest
; number on l
(define (sup l)
  (cond
    [(empty? (rest l)) (first l)]
    [else (if (> (first l) (sup (rest l))) (first l) (sup (rest l)))]))

; Nelon -> Number
; determines the smallest number on l
(define (inf-1 l)
  (first (sort l <)))

; Nelon -> Number
; determines the biggest number on l
(define (sup-1 l)
  (first (sort l >)))

; Nelon -> Number
; determines the smallest number on l
(define (inf-2 l)
  (cond
    [(empty? (rest l)) (first l)]
    [else (min (first l) (inf-2 (rest l)))]))

; Nelon -> Number
; determines the biggest number on l
(define (sup-2 l)
  (cond
    [(empty? (rest l)) (first l)]
    [else (max (first l) (sup-2 (rest l)))]))

; NeLon Function -> Number
; map any function to a list of numbers, return computation of recursively applying said function to the NeLon
; since it's a NeLon, not any function will compute, but you get the gist
(define (map-it func list)
  (cond
    [(empty? (rest list)) (first list)]
    [else (func (first list) (map-it func (rest list)))]))