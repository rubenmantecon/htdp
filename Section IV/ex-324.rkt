;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname ex-324) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "abstraction.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "abstraction.rkt" "teachpack" "2htdp")) #f)))
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

; BT -> [List-of N]
; output a BT's ssns as a list of values, read in left-to-right order
(check-expect (inorder NONE) '())
(check-expect (inorder A) '(15 24))
(check-expect (inorder B) '(15 87))
(define (inorder bt)
  (cond
    [(no-info? bt) '()]
    [else (append (list (node-ssn bt)) (inorder (node-left bt)) (inorder (node-right bt)))]))