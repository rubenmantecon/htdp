;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname ex-262) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
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

