;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname ex-326) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "abstraction.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "abstraction.rkt" "teachpack" "2htdp")) #f)))
;; Exercise 326. Design the function create-bst. It consumes a BST B, a number N, and a symbol S.
;; It produces a BST that is just like B and that in place of one NONE subtree contains the node structure
;;    (make-node N S NONE NONE)

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




; BST N Symbol -> BST
; add a node containing symbol at the end of the tree
(check-expect (create-bst NONE 3 'a) (make-node 3 'a NONE NONE))
(check-member-of (create-bst (make-node 3 'a NONE NONE) 4 'b)
                 (make-node 3 'a (make-node 4 'b NONE NONE) NONE)
                 (make-node 3 'a NONE (make-node 4 'b NONE NONE)))
(check-member-of (create-bst TREE-A 120 'w) 
                 (make-node 63 'a
                          (make-node 29 'b
                                     (make-node 15 'c
                                                (make-node 10 'd (make-node 120 'w NONE NONE) NONE)
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
                                                           NONE))))
                 (make-node 63 'a
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
                                                           (make-node 120 'w NONE NONE))))))

(define (create-bst bst n s)
  (cond
    [(no-info? bst) (make-node n s NONE NONE)]
    [else (append-to-bst bst n s)]))

; BST N Symbol -> BST
(define (append-to-bst bst n s)
  (local ((define keep-searching-left (create-bst (node-left bst) n s))
          (define keep-searching-right (create-bst (node-right bst) n s)))
  (cond
    [(node? keep-searching-left) (make-node (node-ssn bst) (node-name bst) keep-searching-left NONE)]
    [(node? keep-searching-right) (make-node (node-ssn bst) (node-name bst) NONE keep-searching-right )]
    )))