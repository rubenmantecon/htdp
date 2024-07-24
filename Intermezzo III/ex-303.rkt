;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname ex-303) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
;; Exercise 303. Draw arrows from the shaded occurrences of x to their binding occurrences in each of the following three lambda expressions:
(lambda (x y)
  (+ x (* x y)))

; First ocurring 'x' is bound to the top-level definition in the lambda

(lambda (x y)
  (+ x
     (local ((define x (* y y)))
       (+ (* 3 x)
          (/ 1 x)))))

; First ocurring 'x' is bound to the top-level definition in the lambda
; Third one is bound to the local definition, NOT the lambda definition inmediately after

(lambda (x y)
  (+ x
     ((lambda (x)
        (+ (* 3 x)
           (/ 1 x)))
      (* y y))))

; First ocurring 'x' is bound to the top-level definition in the lambda
; Third one is bound to the lambda definition inmediately after