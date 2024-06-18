;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname ex-271) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; String [List-of String] -> Boolean
; determine whether any of the names in l
; are equal to or an extension of s
(check-expect (find-name "John" '()) #false)
(check-expect (find-name "John" (list "Anna" "Joe" "John")) #true)
(check-expect (find-name "John" (list "Anna" "Joe" "David")) #false)
(define (find-name s l)
  (ormap (lambda (x) (string-contains? x s)) l))

; String [List-of String] -> Boolean
; determine whether all of the names in l
; start with s
(check-expect (all-start-with? "a" (list "abba" "argh" "aha")) #true)
(check-expect (all-start-with? "a" (list "abba" "argh" "boo")) #false)
(check-expect (all-start-with? "a" (list "abba" "argh" "boo" "aha")) #false)
(define (all-start-with? s l)
  (andmap (lambda (x) (string=? (string-ith x 0) s)) l))

;; Should you use ormap or andmap to define a function that ensures that no name on some list exceeds a given width?
; ormap, since we just need one coincidence
(check-expect (any-longer-than? 3 (list "Bill" "Bob")) #t)
(check-expect (any-longer-than? 5 (list "Frank" "Tom")) #f)
(define (any-longer-than? n l)
  (ormap (lambda (x) (> (string-length x) n)) l))
