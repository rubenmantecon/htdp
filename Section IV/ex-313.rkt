;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname ex-313) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "abstraction.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "abstraction.rkt" "teachpack" "2htdp")) #f)))
;; Exercise 313. Suppose we need the function blue-eyed-ancestor?, which is like blue-eyed-child? but
;; responds with #true only when a proper ancestor, not the given child itself, has blue eyes.

(define-struct no-parent [])
(define-struct person [father mother name date eyes])
(define NP (make-no-parent))
; An FT is one of: 
; – NP
; – (make-child FT FT String N String)

; Oldest Generation:
(define Carl (make-person NP NP "Carl" 1926 "green"))
(define Bettina (make-person NP NP "Bettina" 1926 "green"))
 
; Middle Generation:
(define Adam (make-person Carl Bettina "Adam" 1950 "hazel"))
(define Dave (make-person Carl Bettina "Dave" 1955 "black"))
(define Eva (make-person Carl Bettina "Eva" 1965 "blue"))
(define Fred (make-person NP NP "Fred" 1966 "pink"))
 
; Youngest Generation: 
(define Gustav (make-person Fred Eva "Gustav" 1988 "brown"))

; FT -> Boolean
; does the ancestor of a FT have blue eyes?
(check-expect (blue-eyed-ancestor-bad? Eva) #false)
(check-expect (blue-eyed-ancestor-bad? Gustav) #true)
(define (blue-eyed-ancestor-bad? an-ftree)
  (cond
    [(no-parent? an-ftree) #false]
    [else
     (or
       (blue-eyed-ancestor-bad?
         (person-father an-ftree))
       (blue-eyed-ancestor-bad?
         (person-mother an-ftree)))]))

; blue-eyed-ancestor-bad? will always produce false because, under the current definitions, will always
; end up encountering a person with no ancestors, thus producing false.
; An alternative, then, it's to traverse the graph and check, a bit cleverly, whether the child of the ancestor
; of the current node (that is, the node in itself) has blue eyes. Looking one level up and from there down, so to
; speak, prevents us from entering the clause [(no-parent?) ...] without traversing to that node and effectively
; entering into that clause.
; Therefore:

; FT -> Boolean
; does FT contain a child with blue eyes?
(check-expect (blue-eyed-child? Carl) #false)
(check-expect (blue-eyed-child? Gustav) #true)
(define (blue-eyed-child? an-ftree)
  (cond
    [(no-parent? an-ftree) #false]
    [else (or (string=? (person-eyes an-ftree) "blue")
              (blue-eyed-child? (person-father an-ftree))
              (blue-eyed-child? (person-mother an-ftree)))]))

; FT -> Boolean
; does the ancestor of a FT have blue eyes?
(check-expect (blue-eyed-ancestor? Eva) #false)
(check-expect (blue-eyed-ancestor? Gustav) #true)
(define (blue-eyed-ancestor? ft)
  (cond
    [(no-parent? ft) #false]
    [else (or
           (blue-eyed-child? (person-mother ft))
           (blue-eyed-child? (person-father ft)))]))

