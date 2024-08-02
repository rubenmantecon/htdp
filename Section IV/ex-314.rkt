;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname ex-314) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "abstraction.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "abstraction.rkt" "teachpack" "2htdp")) #f)))
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

(define ff1 (list Carl Bettina))
(define ff2 (list Fred Eva))
(define ff3 (list Fred Eva Carl))

;; Exercise 314. Reformulate the data definition for FF with the List-of abstraction. Now do the same for the blue-eyed-child-in-forest? function. Finally, define blue-eyed-child-in-forest? using one of the list abstractions from the preceding chapter.

; A FF (short for Family Forest) is a [List-of FT]

; [List-of FT] -> Boolean
; does the forest contain any child with "blue" eyes
(check-expect (blue-eyed-child-in-forest? ff1) #false)
(check-expect (blue-eyed-child-in-forest? ff2) #true)
(check-expect (blue-eyed-child-in-forest? ff3) #true)
(define (blue-eyed-child-in-forest? l)
 (ormap blue-eyed-child? l))

(check-expect (blue-eyed-child-in-forest?.2 ff1) #false)
(check-expect (blue-eyed-child-in-forest?.2 ff2) #true)
(check-expect (blue-eyed-child-in-forest?.2 ff3) #true)
(define (blue-eyed-child-in-forest?.2 l)
  (cond
    [(empty? l) #false]
    [else (or (blue-eyed-child? (first l))
              (blue-eyed-child-in-forest?.2 (rest l)))]))