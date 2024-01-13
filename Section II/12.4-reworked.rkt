;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname 12.4-reworked) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
;; A Word is one of:
;; - '()
;; - (cons 1String Word)
;; interpretatition a Word is a list of 1Strings
(define WORD0 '())
(define WORD1 (list "a"))
(define WORD2 (list "o" "h"))
(define WORD3 (list "b" "a" "t"))
(define WORD4 (list "c" "r" "a" "p"))
(define WORD5 (list "w" "h" "a" "t" "?"))

;; A List-of-words is one of:
;; - '()
;; - (cons Word List-of-words)
(define LOW0 '())
(define LOW1 (list WORD1 WORD2))
(define LOW2 (list WORD3 WORD4 WORD5))

;; Word -> List-of-words
;; finds all rearrangements of a word
(define (arrangements w)
  (cond
    [(empty? w) (list '())]
    [else (insert-everywhere/in-all-words (first w) (arrangements (rest w)))]))

(check-expect (arrangements '()) (list '()))
(check-expect (arrangements WORD1) (list (list "a")))
(check-expect (arrangements WORD2) (list (list "o" "h") (list "h" "o")))
(check-expect (arrangements WORD3)
              '(("b" "a" "t") ("a" "b" "t") ("a" "t" "b") ("b" "t" "a") ("t" "b" "a") ("t" "a" "b")))

;; 1String List-of-words -> List-of-words
;; inserts s in every position, of every word, in the List-of-words
(define (insert-everywhere/in-all-words s low)
  (cond
    [(empty? low) '()]
    [else
     (append (insert-everywhere/in-one-word s (first low))
             (insert-everywhere/in-all-words s (rest low)))]))

(check-expect (insert-everywhere/in-all-words "x" (list WORD0)) (list (list "x")))
(check-expect (insert-everywhere/in-all-words "x" (list WORD1)) (list (list "x" "a") (list "a" "x")))
(check-expect (insert-everywhere/in-all-words "x" (list WORD1 WORD1))
              (list (list "x" "a") (list "a" "x") (list "x" "a") (list "a" "x")))

;; 1String Word -> List-of-words
;; return a list of every combination of 1String and Word
(define (insert-everywhere/in-one-word s w)
  (cond
    [(empty? w) (list (list s))]
    [else (cons (cons s w) (prepend/word (first w) (insert-everywhere/in-one-word s (rest w))))]))

(check-expect (insert-everywhere/in-one-word "X" WORD0) (list (list "X")))
(check-expect (insert-everywhere/in-one-word "X" WORD1) (list (list "X" "a") (list "a" "X")))
(check-expect
 (insert-everywhere/in-one-word "X" WORD3)
 (list (list "X" "b" "a" "t") (list "b" "X" "a" "t") (list "b" "a" "X" "t") (list "b" "a" "t" "X")))

;; 1String List-of-words -> List-of-words
;; prepend s to each word on a list
(define (prepend/word s low)
  (cond
    [(empty? low) '()]
    [else (cons (cons s (first low)) (prepend/word s (rest low)))]))
