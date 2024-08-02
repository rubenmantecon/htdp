;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname ex-315) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "abstraction.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "abstraction.rkt" "teachpack" "2htdp")) #f)))
;; Exercise 315. Design the function average-age. It consumes a family forest and a year (N).
;; From this data, it produces the average age of all child instances in the forest.

; An FF (short for family forest) is one of: 
; – '()
; – (cons FT FF)
; interpretation a family forest represents several
; families (say, a town) and their ancestor trees

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
            (count-persons (person-mother an-ftree))
            (count-persons (person-father an-ftree))))]))


; FT Number -> Number
; produce the average age of all children in an FT
(check-expect (average-age-ft Carl 2000) 74)
(check-expect (average-age-ft Gustav 2000) 229)
(define (average-age-ft ft year)
  (cond
    [(no-parent? ft) 0]
    [else (+
           (- year (person-date ft))
           (average-age-ft (person-father ft) year)
           (average-age-ft (person-mother ft) year))]))

; [List-of FT] Number -> Number
; produce the average age of a forest
(check-expect (average-age (list Gustav) 2000) 229)
(define (average-age ff year)
  (cond
    [(empty? ff) 0]
    [else (+
           (average-age-ft (first ff) year)
           (average-age (rest ff) year))]))

