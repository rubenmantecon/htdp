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

; Ex 188

(define-struct email [from date message])
; An Email Message is a structure: 
;   (make-email String Number String)
; interpretation (make-email f d m) represents text m 
; sent by f, d seconds after the beginning of time

(define EMAIL1 (make-email "David" 0 "Hello, World!"))
(define EMAIL2 (make-email "Stern" 120 "Hey!"))
(define EMAIL3 (make-email "DARPA" 12142039 "I think I will take care of this."))


; LoE -> LoE
; sort emails in descending order
(define (sort-email> loe)
  (cond
    [(empty? loe) '()]
    [else (insert-email (first loe) (sort-email> (rest loe)))]))

; Email -> Email
; Assert whether email-1 is older than mail-2
(define (email>? email-1 email-2)
  (if (> (email-date email-1) (email-date email-2))
      #true
      #false))

; Email LoE -> LoE
; insert Email into a descending ordered LoE
(define (insert-email email loe)
  (cond
    [(empty? loe) (list email)]
    [(empty? email) loe]
    [else (if (email>? email (first loe))
              (cons email loe)
              (cons (first loe) (insert-email email (rest loe))))]))

(define (sorted-email>? loe)
  (cond
    [(empty? (rest loe)) #true]
    [else (if (email>? (first loe) (first (rest loe)))
              (sorted-email>? (rest loe))
              #false)]))

(check-satisfied (sort-email> (list EMAIL3 EMAIL2 EMAIL1)) sorted-email>?)

; Ex 189

; Number List-of-numbers -> Boolean
(define (search n alon)
  (cond
    [(empty? alon) #false]
    [else (or (= (first alon) n)
              (search n (rest alon)))]))

; Number List-of-numbers -> Boolean
; determine whether some number occurs in a a sorted list of numbers
(define (search-sorted n alon)
  (cond
    [(empty? alon) #false]
    [else (or (> n (first alon))
              (search-sorted n (rest alon)))]))

; Ex 190

; List-of-1String -> List-of-list-of-1String
; produce a list of all suffixes of the input
(define (suffixes l)
  (cond
    [(empty? l) '()]
    [else (cons l (suffixes (rest l)))]))

(define (prefixes l)
  (cond
    [(empty? l) '()]
    [else (reverse* (suffixes (reverse l))) ]))

(define (reverse* ll)
  (cond [(empty? ll) '()]
        [else (cons (reverse (first ll)) (reverse* (rest ll)))]))

(check-expect (prefixes (list "a")) (list (list "a")))
(check-expect (prefixes (list "a" "b")) (list (list "a" "b") (list "a")))
(check-expect (prefixes (list "a" "b" "c")) (list (list "a" "b" "c") (list "a" "b") (list "a")))