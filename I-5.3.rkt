;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname I-5.3) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
(define p (make-posn 31 26))
(posn-x p)
(posn-x (make-posn 31 26))

(define (distance-to-0 ap)
  (sqrt (+ (sqr (posn-x ap)) (sqr (posn-y ap)) )))
(check-expect (distance-to-0 (make-posn 0 5)) 5)
(check-expect (distance-to-0 (make-posn 7 0)) 7)
(check-expect (distance-to-0 (make-posn 3 4)) 5)
(check-expect (distance-to-0 (make-posn 8 6)) 10)
(check-expect (distance-to-0 (make-posn 5 12)) 13)

; Exercise 64. Design the function manhattan-distance,
; which measures the Manhattan distance of the given posn to the origin.

; A Manhattan Distance (MS) is a Number
; Posn -> Number
; takes a position and computes how many 'steps' there are until (0,0)
(define (manhattan-distance p q)
  (+
   (abs
    (-
     (posn-x p)
     (posn-y p)))
   (abs
    (-
     (posn-x q)
     (posn-y q))))
  )


