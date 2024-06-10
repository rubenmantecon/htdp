;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname ex-261) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "abstraction.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "abstraction.rkt" "teachpack" "2htdp")) #f)))
(define-struct IR [name price])
; An IR is a structure:
;   (make-IR String Number)

; An Inventory is a list of IRs

(define inv1 (list (make-IR "box" 0.23) (make-IR "shoe" 1.22) (make-IR "sock" 0.66) (make-IR "box" 0.23) (make-IR "shoe" 1.22) (make-IR "sock" 0.66) (make-IR "box" 0.23) (make-IR "shoe" 1.22) (make-IR "sock" 0.66) (make-IR "box" 0.23) (make-IR "shoe" 1.22) (make-IR "sock" 0.66) (make-IR "box" 0.23) (make-IR "shoe" 1.22) (make-IR "sock" 0.66) (make-IR "box" 0.23) (make-IR "shoe" 1.22) (make-IR "sock" 0.66) (make-IR "box" 0.23) (make-IR "shoe" 1.22) (make-IR "sock" 0.66) (make-IR "box" 0.23) (make-IR "shoe" 1.22) (make-IR "sock" 0.66) (make-IR "box" 0.23) (make-IR "shoe" 1.22) (make-IR "sock" 0.66) (make-IR "box" 0.23) (make-IR "shoe" 1.22) (make-IR "sock" 0.66)))
(define inv2 (list (make-IR "fork" 0.88) (make-IR "spoon" 1) (make-IR "knife" 1.25 )))

; Inventory -> Inventory
; creates an Inventory from an-inv for all
; those items that cost less than a dollar
(define (extract1 an-inv)
  (cond
    [(empty? an-inv) '()]
    [else
     (cond
       [(<= (IR-price (first an-inv)) 1.0)
        (cons (first an-inv) (extract1 (rest an-inv)))]
       [else (extract1 (rest an-inv))])]))

; Inventory -> Inventory
; creates an Inventory from an-inv for all
; those items that cost less than a dollar
(define (extract2 an-inv)
  (cond
    [(empty? an-inv) '()]
    [else
     (local
       ((define extract1-rest (extract1 (rest an-inv))))
       (cond
         [(<= (IR-price (first an-inv)) 1.0)
          (cons (first an-inv) extract1-rest)]
         [else extract1-rest]))]))

(time (extract1 inv1))
(time (extract2 inv1))