;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname ex-311) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "abstraction.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "abstraction.rkt" "teachpack" "2htdp")) #f)))
;; Exercise 311. Develop the function average-age. It consumes a family tree and the current year.
;; It produces the average age of all child structures in the family tree. 

(define-struct no-parent [])
(define-struct child [father mother name date eyes])
(define NP (make-no-parent))
; An FT is one of: 
; – NP
; – (make-child FT FT String N String)

; Oldest Generation:
(define Carl (make-child NP NP "Carl" 1926 "green"))
(define Bettina (make-child NP NP "Bettina" 1926 "green"))
 
; Middle Generation:
(define Adam (make-child Carl Bettina "Adam" 1950 "hazel"))
(define Dave (make-child Carl Bettina "Dave" 1955 "black"))
(define Eva (make-child Carl Bettina "Eva" 1965 "blue"))
(define Fred (make-child NP NP "Fred" 1966 "pink"))
 
; Youngest Generation: 
(define Gustav (make-child Fred Eva "Gustav" 1988 "brown"))

; FT -> Number
; count how many children there are in a tree
(check-expect (count-persons Carl) 1)
(check-expect (count-persons Bettina) 1)
(check-expect (count-persons Adam) 3)
(check-expect (count-persons Dave) 3)
(define (count-persons an-ftree)
  (cond
    [(no-parent? an-ftree) 0]
    [else (add1
           (+
            (count-persons (child-mother an-ftree))
            (count-persons (child-father an-ftree))))]))


; FT Number -> Number
; produce the average age of all children in an FT
(check-expect (average-age Carl 2000) 74)
(check-expect (average-age Gustav 2000) 229)
(define (average-age ft year)
  (cond
    [(no-parent? ft) 0]
    [else (+
           (- year (child-date ft))
           (average-age (child-father ft) year)
           (average-age (child-mother ft) year))]))