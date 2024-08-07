;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname ex-325) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "abstraction.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "abstraction.rkt" "teachpack" "2htdp")) #f)))
;; Exercise 325. Design search-bst. The function consumes a number n and a BST.
;; If the tree contains a node whose ssn field is n,
;; the function produces the value of the name field in that node.
;; Otherwise, the function produces NONE.
;; The function organization must exploit the BST invariant so that the function performs as few comparisons as necessary.

(define-struct no-info [])
(define NONE (make-no-info))
 
(define-struct node [ssn name left right])

; A BT (short for BinaryTree) is one of:
; – NONE
; – (make-node Number Symbol BT BT)

; A BST (short for binary search tree) is a BT according to the following conditions:
;
;    NONE is always a BST.
;
;    (make-node ssn0 name0 L R) is a BST if
;
;        L is a BST,
;
;        R is a BST,
;
;        all ssn fields in L are smaller than ssn0,
;
;        all ssn fields in R are larger than ssn0.

; A NONEOrString is either:
; - NONE
; - String

(define TREE-A (make-node 63 'a
                          (make-node 29 'b
                                     (make-node 15 'c
                                                (make-node 10 'd NONE NONE)
                                                (make-node 24 'f NONE NONE))
                                     NONE)
                          (make-node 89 'g
                                     (make-node 77 'h
                                                NONE
                                                NONE)
                                     (make-node 95 'i
                                                NONE
                                                (make-node 99 'j
                                                           NONE
                                                           NONE)))))

(define TREE-B (make-node 63 'a
                          (make-node 29 'b
                                     (make-node 15 'c
                                                (make-node 87 'd NONE NONE)
                                                (make-node 24 'f NONE NONE))
                                     NONE)
                          (make-node 89 'g
                                     (make-node 33 'h
                                                NONE
                                                NONE)
                                     (make-node 95 'i
                                                NONE
                                                (make-node 99 'j
                                                           NONE
                                                           NONE)))))
; BST N -> NONEOrString
; If the tree contains a node whose ssn field is n, return its name;
; else, return NONE
(define (search-bst bst n)
  (cond
    [(no-info? bst) NONE]
    [else (keep-searching bst n)]))

; BST N -> NONEOrString
(define (keep-searching bst n)
  (local ((define keep-searching-left (search-bst (node-left bst) n))
          (define keep-searching-right (search-bst (node-right bst) n)))
  (cond
    [(= n (node-ssn bst)) (node-name bst)]
    [(< n (node-ssn bst)) keep-searching-left]
    [(> n (node-ssn bst)) keep-searching-right])))



