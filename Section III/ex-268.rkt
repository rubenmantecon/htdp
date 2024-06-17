;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname ex-268) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
; An IR is a structure:
(define-struct IR [price])
; (make-IR Number)
; interpretation: an inventory item
; structure made with just one field for the sake of brevity

; [List-of IR] -> [List-of IR]
(define (sort-IR l cmp)
  (sort l (lambda (x y) (cmp (IR-price x) (IR-price y)))))