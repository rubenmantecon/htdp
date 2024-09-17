;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname ex-314) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "abstraction.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "abstraction.rkt" "teachpack" "2htdp")) #f)))
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

; [List-of FT] -> Boolean
; determine if an FT has blue eyes
(check-expect (blue-eyed-child? Eva) #true)
(define (blue-eyed-child? ft) (string=? "blue" (child-eyes ft)))

; [List-of FT] -> Boolean
; does the forest contain any child with "blue" eyes
(check-expect (blue-eyed-child-in-forest? ff1) #false)
(check-expect (blue-eyed-child-in-forest? ff2) #true)
(check-expect (blue-eyed-child-in-forest? ff3) #true)
(define (blue-eyed-child-in-forest? a-forest)
  (cond
    [(empty? a-forest) #false]
    [else
     (or (blue-eyed-child? (first a-forest))
         (blue-eyed-child-in-forest? (rest a-forest)))]))

; [List-of FT] -> Boolean
; does the forest contain any child with "blue" eyes
(check-expect (blue-eyed-child-in-forest?.v2 ff1) #false)
(check-expect (blue-eyed-child-in-forest?.v2 ff2) #true)
(check-expect (blue-eyed-child-in-forest?.v2 ff3) #true)
(define (blue-eyed-child-in-forest?.v2 loft)
  (ormap (lambda (ft) (string=? "blue" (child-eyes ft))) loft))

; [List-of FT] -> Boolean
; determine if an ancestor of the FT has blue eyes
(check-expect (blue-eyed-ancestor? Eva) #false)
(define (blue-eyed-ancestor? ft)
  (cond
    [(no-parent? ft) #false]
    [else (or
           (blue-eyed-child? (child-father ft))
           (blue-eyed-child? (child-mother ft)))]))