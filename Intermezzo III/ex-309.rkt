;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname ex-309) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "abstraction.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "abstraction.rkt" "teachpack" "2htdp")) #f)))
;; Exercise 309. Design the function words-on-line, which determines the number of Strings per item in a list of list of strings.

;[List-of [List-of String]] -> [List-of Number]
(check-expect (words-on-line (list (list "a" "b" "c") (list "d" "e") (list "f"))) (list 3 2 1))
(define (words-on-line llos)
  (for/list ([l llos])
    (match l
      [los (length los)])))