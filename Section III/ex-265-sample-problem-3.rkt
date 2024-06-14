;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname ex-265-sample-problem-3) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
; Posn Posn Number -> Boolean
; is the distance between p and q less than d
(define (close-to p q d)
  (< (sqrt (+ (sqr (- (posn-x p) (posn-x q))) (sqr (- (posn-y p) (posn-y q))))) d))

; [List-of Posn] Posn -> Boolean
; is any Posn on lop close to pt
(define (close? lop pt)
  (local (; Posn -> Boolean
          ; is one shot close to pt
          (define (is-one-close? p)
            (close-to p pt CLOSENESS)))
    (ormap is-one-close? lop)))

(define (close?.v2 lop pt)
  (ormap (lambda (p) (close-to p pt CLOSENESS)) lop))

(define CLOSENESS 5) ; in terms of pixels
(define LOP (list (make-posn 1 2) (make-posn 5 5)))
(check-expect (close? LOP (make-posn 0 0)) (close?.v2 LOP (make-posn 0 0)))