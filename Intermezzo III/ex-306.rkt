;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname ex-306) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "abstraction.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "abstraction.rkt" "teachpack" "2htdp")) #f)))
;; Exercise 306. Use loops to define a function that

;; creates the list (list 0 ... (- n 1)) for any natural number n
; Number -> [List-of Number]
(define (build-list.1 n)
  (for/list ([i n]) i))

;; creates the list (list 1 ... n) for any natural number n
; Number -> [List-of Number]
(define (build-list.2 n)
  (for/list ([i n]) (+ i 1)))

;;creates the list (list 1 1/2 ... 1/n) for any natural number n
; Number -> [List-of Number]
(define (build-list.3 n)
  (for/list ([i n]) (/ 1 (+ 1 i))))

;; creates the list of the first n even numbers
; Number -> [List-of Number]
(define (build-list.4 n)
  (for/list ([i n]) (if (even? i) i #false))) ; Wrong

;; creates a diagonal square of 0s and 1s; see exercise 262.
; Number -> [List-of [List-of Number]]
(define (build-list.5 n)
  (for/list ([i n]) (for/list ([j n]) (if (= i j) 1 0))))

;; Finally, use loops to define tabulate from exercise 250
; Number [Number -> Number] -> [List-of Number]
(define (tabulate n f)
  (for/list ([i (add1 n)]) (f i)))
