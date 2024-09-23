;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname ex-323) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "abstraction.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "abstraction.rkt" "teachpack" "2htdp")) #f)))
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

; BT N -> [Maybe Symbol]
; return the ssn of a node whose value is n
(check-expect (search-bt? NONE 90) #false)
(check-expect (search-bt? A 15) 'd)
(check-expect (search-bt? A 30) #false)
(check-expect (search-bt? B 87) 'h)
(check-expect (search-bt? B 100) #false)
(define (search-bt? bt n)
  (cond
    [(no-info? bt) #false]
    [(= (node-ssn bt) n) (node-name bt)]
    [else (local (
                  (define left-branch (search-bt? (node-left bt) n))
                  (define right-branch (search-bt? (node-right bt) n)))
            (cond
              [(boolean? left-branch) right-branch]
              [(boolean? right-branch) left-branch])
            )]))