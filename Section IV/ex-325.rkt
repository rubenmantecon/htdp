;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname ex-325) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "abstraction.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "abstraction.rkt" "teachpack" "2htdp")) #f)))
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

(define BST (make-node 63 'a
                       (make-node 29 'b
                                  (make-node 15 'd
                                             (make-node 10 'h NONE NONE)
                                             (make-node 24 'i NONE NONE))
                                  NONE)
                       (make-node 89 'c
                                  (make-node 77 'l NONE NONE)
                                  (make-node 95 'g NONE (make-node 99 'o NONE NONE)))))


; BST N -> SymbolOrNONE
; If the tree contains a node whose ssn field is n,
; produce the value of the name field in that node.
; Otherwise, produce NONE.
(check-expect (search-bst NONE 200) NONE)
(check-expect (search-bst BST 200) NONE)
(check-expect (search-bst BST 63) 'a)
(check-expect (search-bst BST 29) 'b)
(check-expect (search-bst BST 95) 'g)
(define (search-bst bst n)
  (cond
    [(no-info? bst) NONE]
    [(= (node-ssn bst) n) (node-name bst)]
    [(< n (node-ssn bst)) (search-bst (node-left bst) n)]
    [(> n (node-ssn bst)) (search-bst (node-right bst) n)]
;    [else (local ((define left-branch-result (search-bst (node-left bst) n))
;                  (define right-branch-result (search-bst (node-right bst) n)))
;            (cond
;              [(no-info? left-branch-result) right-branch-result]
;              [(no-info? right-branch-result) left-branch-result]))]
    ))