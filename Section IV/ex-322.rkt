;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname ex-322) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "abstraction.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "abstraction.rkt" "teachpack" "2htdp")) #f)))
;; Exercise 322. Draw the above two trees in the manner of figure 119.
;; Then design contains-bt?, which determines whether a given number occurs in some given BT. 

(define-struct no-info [])
(define NONE (make-no-info))
 
(define-struct node [ssn name left right])
; A BT (short for BinaryTree) is one of:
; – NONE
; – (make-node Number Symbol BT BT)

(define BT1 (make-node
  15
  'd
  NONE
  (make-node
    24 'i NONE NONE)))

(define BT2 (make-node
  15
  'd
  (make-node
    87 'h NONE NONE)
  NONE))

; BT N -> Boolean
; does a given number occur in some given binary tree
(check-expect (contains-bt? BT1 25) #false)
(check-expect (contains-bt? BT2 25) #false)
(check-expect (contains-bt? NONE 25) #false)
(check-expect (contains-bt? BT1 15) #true)
(check-expect (contains-bt? BT1 24) #true)
(check-expect (contains-bt? BT2 15) #true)
(check-expect (contains-bt? BT2 87) #true)
(define (contains-bt? bt n)
  (cond
    [(no-info? bt) #false]
    [else (or (= n (node-ssn bt))
              (contains-bt? (node-left bt) n)
              (contains-bt? (node-right bt) n))]))