;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname ex-307) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "abstraction.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "abstraction.rkt" "teachpack" "2htdp")) #f)))
;; Exercise 307. Define find-name. The function consumes a name and a list of names.
;; It retrieves the first name on the latter that is equal to, or an extension of, the former.

; String [List-of String] -> String
(check-expect (find-name "john" '("john" "dave")) "john")
(check-expect (find-name "john" '("johnny" "dave")) "johnny")
(define (find-name s l) (first (for/list ([name l]) (if (string-contains-ci? s name) name #false))))

;; Define a function that ensures that no name on some list of names exceeds some given width. Compare with exercise 271
; String [List-of String] -> Boolean
(check-expect (within-length 3 (list "Am" "Dal")) #true)
(check-expect (within-length 3 (list "Am" "Dal" "Alice")) #false)
(define (within-length n l) (for/and ([s l]) (<= (string-length s) n)))