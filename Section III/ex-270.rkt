;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname ex-270) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
; Number -> [List-of Number]
; creates a list of numbers from n to (- n 1)
(check-expect (build-list.1 5) (list 0 1 2 3 4))
(define (build-list.1 n)
  (cons 0 (build-list (- n 1) add1)))

; Number -> [List-of Number]
; creates a list of numbers from 1 to n
(check-expect (build-list.2 5) (list 1 2 3 4 5))
(define (build-list.2 n)
  (build-list n add1))

; Number -> [List-of Number]
; creates a list of numbers from 1 to 1/n
(check-expect (build-list.3 5) (list 1 1/2 1/3 1/4 1/5))
(define (build-list.3 n)
  (build-list n (lambda (x) (if (= x 0) 1 (/ 1 (+ 1 x))))))

; Number -> [List-of Number]
; creates a list of the first n even numbers
(check-expect (build-list.4 5) (list 1 3 5))
(define (build-list.4 n)
  (filter odd? (build-list n add1)))

; Number -> [List-of Number]
; creates a diagonal square of 0s and 1s
(check-expect (build-list.5 5) (list (list 1 0 0 0 0)
                                     (list 0 1 0 0 0)
                                     (list 0 0 1 0 0)
                                     (list 0 0 0 1 0)
                                     (list 0 0 0 0 1)))
(define (build-list.5 n)
  (build-list n
              (lambda (i)
                (build-list n
                            (lambda (j)
                              (if (= i j) 1 0))))))

; Number [Number -> Number] -> [List-of Number]
; tabulates a trigonometric function
; between n and 0 (inc. in a list)
(check-within (tabulate 5 sin) (list (sin 0) (sin 1) (sin 2) (sin 3) (sin 4) (sin 5)) 0)
(define (tabulate n fn)
  (build-list (add1 n) fn))