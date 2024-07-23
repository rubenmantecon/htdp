;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname ex-308) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "abstraction.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "abstraction.rkt" "teachpack" "2htdp")) #f)))
;; Exercise 308. Design the function replace, which substitutes the area code 713 with 281 in a list of phone records.

(define-struct phone [area switch four])

; [List-of Phone] -> [List-of Phone]
; substitutes the area code 713 with 281 in a list of phone records
(define (replace lop)
  (for/list ((p lop))
    (match p
    [(phone 713 switch four) (make-phone 281 switch four)]
    [else p]
    )))