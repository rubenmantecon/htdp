;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname ex-293) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp")) #f)))
;; Exercise 293. Develop found?, a specification for the find function: 

; [X] X [List-of X] -> [Maybe [List-of X]]
; returns the first sublist of l that starts
; with x, #false otherwise
(define (find x l)
  (cond
    [(empty? l) #false]
    [else
     (if (equal? (first l) x) l (find x (rest l)))]))

;; Use found? to formulate a check-satisfied test for find.

(define a-list '(1 5 3 8 9 3 123 4 24 76))

; [X] X [X [List-of X] -> [Maybe [List-of X]]] -> Boolean
; is X in [List-of X]
(check-satisfied (find '() a-list) (found? '()))
(check-satisfied (find "a" a-list) (found? "a"))
(check-satisfied (find 3 a-list) (found? 3))
(check-satisfied (find 999 a-list) (found? 999))
(check-satisfied (find 999 '()) (found? 999))
(check-satisfied (find 999 '(999)) (found? 999))
(define (found? x)
  (lambda (l)
    (if (boolean? l) #false #true)))