;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname ex-294) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp")) #f)))
;; Exercise 294. Develop is-index?, a specification for index:

; [X] X [List-of X] -> [Maybe N]
; determine the index of the first occurrence
; of x in l, #false otherwise
(define (index x l)
  (cond
    [(empty? l) #false]
    [else (if (equal? (first l) x)
              0
              (local ((define i (index x (rest l))))
                (if (boolean? i) i (+ i 1))))]))

;; Use is-index? to formulate a check-satisfied test for index.

; [[X] X [List-of X] -> [Maybe N]] -> Boolean
(check-satisfied (index 2 '(1 4 9 8 2)) (is-index? 2))
(check-satisfied (index 12 '(1 4 9 8 2)) (is-index? 2))
(define (is-index? x)
  (lambda (l)
    (if (boolean? l) #false #true)))