;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname ex-265-sample-problem-2) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
;; Sample Problem Design a function that eliminates all Posns with
;; y-coordinates larger than 100 from some given list.
(define (keep-good lop)
  (local (; Posn -> Posn
          ; should this Posn stay on the list
          (define (good? p)
            (not (> (posn-y p) 100))))
    (filter good? lop)))

;; Explain the definition of good? and simplify it.
; good? simply determines if a posn matches a certain criteria.
; A simplifaction, would be to do (< (posn-y p) 100). A further one
; would be to use lambda altogether. 
(define (keep-good.v2 lon)
  (filter (lambda (n) (< n 100)) lon))