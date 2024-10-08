;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname ex-326) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "abstraction.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "abstraction.rkt" "teachpack" "2htdp")) #f)))
(define-struct no-info [])
(define NONE (make-no-info))
 
(define-struct node [ssn name left right])
; A BT (short for BinaryTree) is one of:
; – NONE
; – (make-node Number Symbol BT BT)

; The BST Invariant
;
;    A BST (short for binary search tree) is a BT according to the following conditions:
;
;        NONE is always a BST.
;
;        (make-node ssn0 name0 L R) is a BST if
;
;            L is a BST,
;
;            R is a BST,
;
;            all ssn fields in L are smaller than ssn0,
;
;            all ssn fields in R are larger than ssn0.

; 15
;   \
;    24
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

(define BST (make-node 63 'a
                       (make-node 29 'b
                                  (make-node 15 'd
                                             (make-node 10 'h NONE NONE)
                                             (make-node 24 'i NONE NONE))
                                  NONE)
                       (make-node 89 'c
                                  (make-node 77 'l NONE NONE)
                                  (make-node 95 'g NONE (make-node 99 'o NONE NONE)))))

; BST N Symbol -> BST
; create/insert a BST into a preexisting BST
(check-expect (create-bst A 10 'h) (make-node 15 'd
                                              (make-node 10 'h NONE NONE)
                                              (make-node 24 'i NONE NONE)))
(check-expect (create-bst A 29 'b) (make-node 29 'b
                                              (make-node 15 'd
                                                         NONE
                                                         (make-node 24 'i NONE NONE))
                                              NONE))
(check-expect (create-bst BST 28 'x) (make-node 63 'a
                                                (make-node 29 'b
                                                           (make-node 28 'x
                                                                      (make-node 15 'd
                                                                                 (make-node 10 'h NONE NONE)
                                                                                 (make-node 24 'i NONE NONE)) NONE)
                                                           NONE                                     )
                                                (make-node 89 'c
                                                           (make-node 77 'l NONE NONE)
                                                           (make-node 95 'g NONE (make-node 99 'o NONE NONE)))))
(check-expect (create-bst BST 30 'x) (make-node 63 'a
                                                (make-node 30 'x
                                                           (make-node 29 'b
                                                                      (make-node 15 'd
                                                                                 (make-node 10 'h NONE NONE)
                                                                                 (make-node 24 'i NONE NONE)) NONE)
                                                           NONE)
                                                (make-node 89 'c
                                                           (make-node 77 'l NONE NONE)
                                                           (make-node 95 'g NONE (make-node 99 'o NONE NONE)))))
(define (create-bst bst n s)
  (cond
    [(no-info? bst) (make-node n s NONE NONE)]
    [(< n (node-ssn bst)) (make-node (node-ssn bst) (node-name bst)
                                     (create-bst (node-left bst) n s)
                                     (node-right bst))]
    [(> n (node-ssn bst)) (make-node n s bst NONE)]))
