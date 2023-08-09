;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 9.6-a-note-on-lists-and-sets) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
; 9.6 A Note on Lists and Sets

; List-of-string String -> N
; determines how often s occurs in los
(define (count los s)
  (cond
    [(empty? los) 0]
    [else (if (string-contains? s (first los))
              (add1 (count (rest los) s))
              (count (rest los) s))]
    ))

(check-expect (count (cons "hey" (cons "hey" (cons "now" (cons "you're a rockstar" '())))) "hey") 2)

; A Son.L is one of: 
; – empty 
; – (cons Number Son.L)
	
; A Son.R is one of: 
; – empty 
; – (cons Number Son.R)
; 
; Constraint If s is a Son.R, 
; no number occurs twice in s
; 
; Son is used when it 
; applies to Son.L and Son.R

; Son
(define es '())
 
; Number Son -> Boolean
; is x in s
(define (in? x s)
  (member? x s))

; Number Son.L -> Son.L
; removes x from s
(define (set-.L x s)
  (remove-all x s))

(define s1.L
  (cons 1 (cons 1 '())))
 
(check-expect
 (set-.L 1 s1.L) es)

; Number Son.R -> Son.R
; removes x from s
(define (set-.R x s)
  (remove x s))

; Number Son.R -> Son.R
; removes x from s
(define s1.R
  (cons 1 '()))
 
(check-expectR) es)

; Exercise 160. Design the functions set+.L and set+.R, which create a set by adding a number x to some given set s for the left-hand and right-hand data definition, respectively

; SoN.L -> Son.L
; add x to a Son.L set
(define (set+.L x s)
  (cond
    [(empty? s) (cons x '())]
    [else (cons s (cons (x '())))]))

; SoN.R -> SoN.R
; add x to a SoN.R set
(define (set+.R x s)
  (cond
    [(empty? s) (cons x '())]
    [(member? x s) s]
    [else (cons s (cons x '()))]))

