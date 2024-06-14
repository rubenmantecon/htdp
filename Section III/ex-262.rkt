;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname ex-262) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
; [X] [List-of X] X Number -> [List-of X]
; insert item at index
(define (insert l x i)
  (cond
    [(empty? l) (cons x '())]
    [(= i 0) (cons x l)]
    [else (cons (first l) (insert (rest l) x (sub1 i)))]))

; Number -> [List-of [List-of Number]]
; create identity matrices for a given number
(check-expect (identityM 1) (list (list 1)))
(check-expect (identityM 3)
              (list (list 1 0 0) (list 0 1 0) (list 0 0 1)))
(define (identityM m)
  (cond
    [(<= m 0) '()]
    [else (local (; list of zeros of length m
                  (define row (make-list (sub1 m) 0))

                  ; [X] Number -> [List-of [List-of X]]
                  ; create a matrix of lists
                  (define (make-matrix m)
                    (cond
                      [(= 0 m) '()]
                      [else (cons row (make-matrix (sub1 m)))]))

                  ; [List-of [List-of X]] Number Number -> [List-of [List-of X]]
                  ; turn a matrix into an identity matrix
                  (define (make-identity-matrix matrix m)
                    (cond
                      [(empty? matrix) '()]
                      [else (cons (insert (first matrix) 1 (sub1 m))
                                  (make-identity-matrix (rest matrix) (sub1 m)))]))
                  
                  ) (reverse (make-identity-matrix (make-matrix m) m)))]))

(define (draw-identityM matrix)
  (local (;; Some graphical constants first
          (define SIDE 8)
          (define RED-SQUARE (square SIDE  "solid" "crimson"))
          (define WHITE-SQUARE (square  SIDE "solid" "white"))

          ; [List-of X] -> Image
          ; draw a row
          (define (draw-row row)
            (cond
              [(empty? row) '()]
              [(empty? (rest row)) (if (= (first row) 1) RED-SQUARE WHITE-SQUARE)]
              [else (if (= (first row) 1)
                        (beside RED-SQUARE
                                (draw-row (rest row)))
                        (beside WHITE-SQUARE
                                (draw-row (rest row))))]))
          
          ; [List-of [List-of X]] -> Image
          ; draw a matrix
          (define (draw-matrix matrix)
            (cond
              [(empty? matrix) '()]
              [(empty? (rest matrix)) (draw-row (first matrix))]
              [else (above (draw-row (first matrix)) (draw-matrix (rest matrix)))]))
          )
    (draw-matrix matrix)))

