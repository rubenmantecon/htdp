;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname ex-322) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "abstraction.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "abstraction.rkt" "teachpack" "2htdp")) #f)))
(define-struct no-info [])
(define NONE (make-no-info))
 
(define-struct node [ssn name left right])
; A BT (short for BinaryTree) is one of:
; – NONE
; – (make-node Number Symbol BT BT)

;  15
;    \
;     24
(define A (make-node
  15
  'd
  NONE
  (make-node
    24 'i NONE NONE)))

;   15
;  |
; 87
(define B (make-node
  15
  'd
  (make-node
    87 'h NONE NONE)
  NONE))

; BT N -> Boolean
; determine whether N is present in BT
(check-expect (contains-bt? NONE 87) #false)
(check-expect (contains-bt? A 15) #true)
(check-expect (contains-bt? A 24) #true)
(check-expect (contains-bt? A 30) #false)
(check-expect (contains-bt? B 15) #true)
(check-expect (contains-bt? B 100) #false)
(define (contains-bt? bt n)
  (cond
    [(no-info? bt) #false]
    [(= (node-ssn bt) n) #true]
    [else (or
           (contains-bt? (node-left bt) n)
           (contains-bt? (node-right bt) n))]))
