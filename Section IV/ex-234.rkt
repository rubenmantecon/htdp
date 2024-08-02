;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname ex-234) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "abstraction.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "abstraction.rkt" "teachpack" "2htdp")) #f)))
;; Exercise 324. Design the function inorder. It consumes a binary tree
;; and produces the sequence of all the ssn numbers in the tree
;; as they show up from left to right when looking at a tree drawing.

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

; BT -> [List-of Number]
; produce the sequence of all the ssn numbers in a bt
(check-expect (inorder TREE-A) (list 10 15 24 29 63 77 89 95 99))
(check-expect (inorder TREE-B) (list 87 15 24 29 63 33 89 95 99))
(define (inorder bt)
  (cond
    [(no-info? bt) '()]
    [else (append (inorder (node-left bt)) (list (node-ssn bt)) (inorder (node-right bt)))]))