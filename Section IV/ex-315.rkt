;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname ex-315) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "abstraction.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "abstraction.rkt" "teachpack" "2htdp")) #f)))
(define-struct no-parent [])
(define-struct child [father mother name date eyes])
(define NP (make-no-parent))
; An FT (short for family tree) is one of: 
; – NP
; – (make-child FT FT String N String)

; An FF is a [List-of FT]
; interpretation a family forest represents several
; families (say, a town) and their ancestor trees

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

(define ff1 (list Carl Bettina))
(define ff2 (list Fred Eva))
(define ff3 (list Fred Eva Carl))

; [List-of FT] N -> N
; produce the average age of all child instances in a forest
(check-expect (average-age '() 2024) 0)
(check-expect (average-age ff1 2024) 196)
(define (average-age loft n)
  (cond
    [(empty? loft) 0]
    [else (+ (average-age/inner (first loft) n) (average-age (rest loft) n))])) 

; FT N -> N
; produce the average age of all child structures in an FT
(check-expect (average-age/inner NP 2024) 0)
(check-expect (average-age/inner Carl 2024) 98)
(check-expect (average-age/inner Gustav 2024) (/ (+ (- 2024 (child-date Gustav))
                                              (- 2024 (child-date Fred))
                                              (- 2024 (child-date Eva))
                                              (- 2024 (child-date Carl))
                                              (- 2024 (child-date Bettina)))
                                           5))

(define (average-age/inner ft n)
  (cond
    [(no-parent? ft) 0]
    [else (/ (total-age ft n) (count-persons ft))]))

; FT -> Number
; determine the total age of an FT
(check-expect (total-age Carl 2024) 98)
(check-expect (total-age Gustav 2024) 349)
(define (total-age ft n)
  (cond
    [(no-parent? ft) 0]
    [else (+
           (- n (child-date ft))
           (total-age (child-father ft) n) 
           (total-age (child-mother ft) n))]))

; FT -> N
; count the number of child structures in an FT
(check-expect (count-persons NP) 0)
(check-expect (count-persons Gustav) 5)
(check-expect (count-persons Fred) 1)
(check-expect (count-persons Carl) 1)
(define (count-persons ft)
  (cond
    [(no-parent? ft) 0]
    [else (add1
           (+
           (count-persons (child-father ft))
           (count-persons (child-mother ft))))]))