;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname ex-269) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
; An IR is a structure:
(define-struct IR [name price])
; (make-IR Number)
; interpretation: an inventory item
; structure made with just two fields for the sake of brevity

; [List-of IR] -> [List-of IR]
; sort a list of IR by price, according to cmp
(define (sort-IR l cmp)
  (sort l (lambda (x y) (cmp (IR-price x) (IR-price y)))))

; Number [List-of IR] ->[List-of IR]
; filter out items whose price is above n
(define (eliminate-expensive n l)
  (filter (lambda (x) (< (IR-price x) n)) l))

; String [List-of IR] -> [List-of IR]
; filter out items whose names match ty
(define (recall ty l)
  (filter (lambda (x) (not (string=? ty (IR-name x)))) l))


; [List-of String] [List-of String] -> [List-of String]
; filter names from the second list which are not present in the first
(define (selection l j)
  (local
    (; String -> Boolean
     (define (is-on-first-list? s)
       (member? s l)))
  (filter is-on-first-list? j)))

