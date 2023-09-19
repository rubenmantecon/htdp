;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname 11-lists) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
; 11 Design by Composition
; 11.3 Auxiliary Functions that Recur

; List-of-numbers -> List-of-numbers 
; rearranges alon in descending order
(define (sort> alon)
  (cond
    [(empty? alon) '()]
    [else
     (insert (first alon) (sort> (rest alon)))]))

(check-expect (sort> '()) '())
(check-expect (sort> (list 3 2 1)) (list 3 2 1))
(check-expect (sort> (list 1 2 3)) (list 3 2 1))
(check-expect (sort> (list 12 20 -5))
              (list 20 12 -5))


; Number List-of-numbers -> List-of-numbers
; inserts n into the sorted list of numbers alon
(define (insert n alon)
  (cond
    [(empty? alon) (list n)]
    [else (if (>= n (first alon))
              (cons n alon)
              (cons (first alon) (insert n (rest alon))))]))
    
(check-expect (insert 4 '()) (list 4))
(check-expect (insert 5 (list 6)) (list 6 5))
(check-expect (insert 5 (list 4)) (list 5 4))
(check-expect (insert 12 (list 20 -5))
              (list 20 12 -5))

; Recursive insertion sort, cool

; Ex 186

; NEList-of-Temperatures -> Boolean
; determines whether all temperatures are in descending order
(define (sorted>? ne-l)
  (cond
    [(empty? (rest ne-l)) #true]
    [else (if (> (first ne-l) (first (rest ne-l)))
              (sorted>? (rest ne-l))
              #false)]))
              

(check-satisfied (sort> (list 1 2 3 )) sorted>?)
(check-satisfied (sort> (list 12 20 -5)) sorted>?)
; (check-satisfied (list 12 20 -5) sorted>?)

; Exercise 187.

(define-struct gp [name score])
; A GamePlayer is a structure: 
;    (make-gp String Number)
; interpretation (make-gp p s) represents player p who 
; scored a maximum of s points

(define PLAYER1 (make-gp "Robert" 12))
(define PLAYER2 (make-gp "Anna" 54))
(define PLAYER3 (make-gp "Dennis" 2))

; List-of-GamePlayer -> List-of-GamePlayer
; sort a list of GP in descending order of points
(define (sort-gp lop)
  (cond
    [(empty? lop) '()]
    [else (insert-gp (first lop) (sort-gp (rest lop)))]))

; (check-expect (sort-gp (list PLAYER1 PLAYER2 PLAYER3)) (list PLAYER2 PLAYER1 PLAYER3))
; (check-expect (sort-gp (list PLAYER2 PLAYER1 PLAYER3)) (list PLAYER2 PLAYER1 PLAYER3))

; GP -> Boolean
; compare a struct of GP by its points
(define (gp>? gp1 gp2)
  (if (> (gp-score gp1) (gp-score gp2))
      #true
      #false))

(check-expect (gp>? PLAYER1 PLAYER2) #false)
(check-expect (gp>? PLAYER2 PLAYER3) #true)

; GP LoGP -> LoGP
; insert GP into descending-ordered LoGP
(define (insert-gp gp lop)
  (cond
    [(empty? lop) (list gp)]
    [(empty? gp) lop]
    [(gp>? gp (first lop)) (cons gp lop)]
    [else (cons (first lop) (insert-gp gp (rest lop)))]))

(check-expect (insert-gp PLAYER1 '()) (list PLAYER1))
(check-expect (insert-gp '() (list PLAYER2 PLAYER3)) (list PLAYER2 PLAYER3))
(check-expect (insert-gp PLAYER1 (list PLAYER2 PLAYER3)) (list PLAYER2 PLAYER1 PLAYER3))

