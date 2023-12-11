;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname 12.4-word-games-the-heart-of-the-problem) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
; A Word is one of:
; – '() or
; – (cons 1String Word)
; interpretation a Word is a list of 1Strings (letters)

; Word -> List-of-words
; produces a list of all the possible arrangements a word can have
(define (arrangements w)
  (cond
    [(empty? w) '()]
    [else (insert-everywhere/in-all-words (first w)
                                          (arrangements (rest w)))]))


;; Ex 212

(define WORD1 '("a"))
(define WORD2 '("o" "h"))
(define WORD3 '("t" "i" "e"))
(define WORD4 '("b" "a" "r" "k"))

(define LWORD1 (list WORD1))
(define LWORD2 '(WORD1 WORD2))
(define LWORD3 '(WORD1 WORD2 WORD3))
(define LWORD4 '(WORD1 WORD2 WORD3 WORD4))

; 1String List-of-words -> List-of-words
; inserts the 1string in all possible positions of the list of words
(define (insert-everywhere/in-all-words s low)
  (cond
    [(empty? low) '()]
    [else (append
           (insert-everywhere/word s (first low)) (insert-everywhere/in-all-words s (rest low)))]))

(check-expect (insert-everywhere/in-all-words "x" '()) '())
(check-expect (insert-everywhere/in-all-words "x" (list
                                                   (list "a")))
              (list
               (list "x" "a")
               (list "a" "x")))

(check-expect (insert-everywhere/in-all-words "x" (list
                                                   (list "a" "b")
                                                   (list "c" "d")))
              (list
               (list "x" "a" "b")
               (list "a" "x" "b")
               (list "a" "b" "x")
               (list "x" "c" "d")
               (list "c" "x" "d")
               (list "c" "d" "x")))

; 1String Word -> Word
; inserts the 1String in all possible positions of a Word
(define (insert-everywhere/word s w)
  (cond
    [(empty? w) '()]
    [(empty? (rest w)) (list
                       (insert-first/word s w)
                       (insert-last/word s w))]
    [else (list
           (insert-first/word s w)
           (insert-in-between/word s w)
           (insert-last/word s w))])) 

(define (insert-first/word s w)
  (cond
    [(empty? w) '()]
    [else (cons s w)]))

(define (insert-last/word s w)
  (cond
    [(empty? w) '()]
    [else (append w (list s))]))

(define (insert-in-between/word s w)
  (cond
    [(empty? w) '()]
    [(empty? (rest w)) w]
    [else (append (list (first w)) (list s) (insert-in-between/word s (rest w)))]))


(check-expect (insert-in-between/word "x" (list "a" "b" "c"))
              (list "a" "x" "b" "x" "c"))