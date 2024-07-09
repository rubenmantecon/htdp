;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname ex-281) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp")) #f)))
;; Write down a lambda expression that:

; consumes a number and decides whether it is less than 10;
(lambda (x) (< x 10))

; multiplies two given numbers and turns the result into a string;
(lambda (x y) (number->string (* x y)))

; consumes a natural number and returns 0 for evens and 1 for odds;
(lambda (x) (if (even? x) 0 1))

; consumes two inventory records and compares them by price; and
(lambda (x y) (equal? (IR-price x) (IR-price y)))

; adds a red dot at a given Posn to a given Image.
(lambda (dot posn) (place-image dot (posn-x posn) (posn-y posn)))