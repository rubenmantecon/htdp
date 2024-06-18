;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname ex-273) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp")) #f)))
; [X] [X -> X] [List-of X]  -> [List-of X]
; map a function to a list using foldr
(check-expect (map-from-fold sqr '(1 2 3))
              (map sqr '(1 2 3)))
(define (map-from-fold fn l)
  (foldr (lambda (x y) (cons (fn x) y)) '() l))

; [X] [X -> X] [List-of X]  -> [List-of X]
; map a function to a list using foldr
(check-expect (map-from-fold.2 sqr '(1 2 3))
              (map sqr '(1 2 3)))

(define (map-from-fold.2 fn l)
  (local ((define (apply-f x y)
            (cons (fn x) y)))
    (foldr apply-f '() l)))