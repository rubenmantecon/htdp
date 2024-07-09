;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname ex-295) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp")) #f)))
;; Exercise 295. Develop n-inside-playground?, a specification of the random-posns function below.
;; The function generates a predicate that ensures that the length of the given list is some given
;; count and that all Posns in this list are within a WIDTH by HEIGHT rectangle:

; distances in terms of pixels 
(define WIDTH 300)
(define HEIGHT 300)
 
; N -> [List-of Posn]
; generates n random Posns in [0,WIDTH) by [0,HEIGHT)
(check-satisfied (random-posns 3)
                 (n-inside-playground? 3))
(check-satisfied random-posns/bad (n-inside-playground? 3))
(define (random-posns n)
  (build-list
    n
    (lambda (i)
      (make-posn (random WIDTH) (random HEIGHT)))))

;; Define random-posns/bad that satisfies n-inside-playground? and does not live up to the expectations
;; implied by the above purpose statement.
;; Note This specification is incomplete. Although the word “partial” might come to mind,
;; computer scientists reserve the phrase “partial specification” for a different purpose.

; [N -> [List-of Posn]] -> Boolean
(define (n-inside-playground? n)
  (lambda (l)
    (if (and
         (= (length l) n)
         (andmap (lambda (p) (and (and (> (posn-x p) 0) (< (posn-x p) WIDTH)) (and (> (posn-y p) 0) (< (posn-y p) HEIGHT)))) l))
        #true #false)))

; My personal rationale is that random-posns/bad technically satisfies the requirements, but, well, is not really random.
; That's what, on an intuitive level one would expect, but at the same time, is not really baked into the specification
(define random-posns/bad (list (make-posn 1 1) (make-posn 1 1) (make-posn 1 1)))