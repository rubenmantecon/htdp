;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname ex-315) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "abstraction.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "abstraction.rkt" "teachpack" "2htdp")) #f)))
;; Exercise 315. Design the function average-age. It consumes a family forest and a year (N).
;; From this data, it produces the average age of all child instances in the forest.
;; Note If the trees in this forest overlap, the result isn’t a true average because some people contribute more than others.
;; For this exercise, act as if the trees don’t overlap.

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

; A FF (short for Family Forest) is a [List-of FT]:
(define ff1 (list Carl Bettina))
(define ff2 (list Fred Eva))
(define ff3 (list Fred Eva Carl))

; [List-of FT] N -> Number
; produces the average age of all child instances in the forest
(check-expect (average-age ff1 2000) (/ (- 2000 (+ (person-date Carl) (person-date Bettina))) 2))
(define (average-age l year)
  (cond
    [(empty? l) 0]
    [else
     (/
      (+
         (average-age-ft (first l) year)
         (average-age (rest l) year))
      year)]))

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