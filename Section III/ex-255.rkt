;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname ex-255) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; [ListOf Number] (Number -> Number) -> [ListOf Number]
(define (map-n lon fn) '(...))

; [ListOf String] (String -> String) -> [ListOf String]
(define (map-s los fn) '(...))

; [ListOf Number] (Number -> Number) -> [ListOf Number]
;            |        |         |                  |
; [ListOf String] (String -> String) -> [ListOf String]

; [ListOf X] (X -> X) -> [ListOf X]
(define (map-abs l fn) '(...))

; map1 does indeed match:
; [ListOf Y] (Y -> Y) -> [ListOf Y]
(define (map1 k g)
  (cond
    [(empty? k) '()]
    [else
     (cons
       (g (first k))
       (map1 (rest k) g))]))
	

 