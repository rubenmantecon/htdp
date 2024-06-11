;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname ex-262) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Number -> [List-of [List-of Number]]
; create identity matrices for a given number
(define (identityM m)
  (cond
    [(<= m 0) '()]
    [else (local (; list of zeros of length m
                  (define row (cond
                                [(= m 1) (make-list m 1)]
                                [else (make-list m 0)]))

                  ; [X] Number -> [List-of [List-of X]]
                  ; create a matrix of lists
                  (define (make-matrix m)
                    (cond
                      [(= 0 m) '()]
                      [else (cons row (make-matrix (sub1 m)))]))
                  
                  
                  ; [List-of [List-of X]] Number -> [List-of [List-of X]]
                  ; diagonalize
                  (define (diagonalize matrix n)
                    (cond
                      [(= n 0) '()]
                      [else (cons
                             (cons 1 (rest (first matrix)))
                             (diagonalize (rest matrix) (sub1 n)))]))
                  
                  ) (diagonalize (make-matrix m) m))]))
                