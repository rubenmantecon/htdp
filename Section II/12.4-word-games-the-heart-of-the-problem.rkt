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
    [(empty? w) (list '())]
    [else (insert-everywhere/in-all-words (first w) (arrangements (rest w)))]))

(check-expect (arrangements (list "e" "r")) (list (list "e" "r") (list "r" "e")))

(check-expect (arrangements (list "d" "e" "r"))
              (list (list "d" "e" "r")
                    (list "e" "d" "r")
                    (list "e" "r" "d")
                    (list "r" "e" "d")
                    (list "r" "d" "e")
                    (list "d" "r" "e")))

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
    [else (list (... s (first low)) (insert-everywhere/in-all-words s (rest low)))]))

(check-expect (insert-everywhere/in-all-words "e" (list (list "r")))
              (list (list "e" "r") (list "r" "e")))

(check-expect (insert-everywhere/in-all-words "d" (list (list "e" "r")))
              (list (list "d" "e" "r")
                    (list "e" "d" "r")
                    (list "e" "r" "d")
                    (list "r" "e" "d")
                    (list "r" "d" "e")
                    (list "d" "r" "e")))

; 1String Word -> List-of-words
; produces all the permutations with the 1String for a Word
(define (insert-everywhere/words s w)
  (cond
    [(empty? w) '()]
    [(empty? (rest w)) (insert-end/word s w)]
    [else (list (insert-beginning/word s w) ...)]))

(check-expect (insert-everywhere/words "x" '()) '())

(check-expect (insert-everywhere/words "e" (list "r")) (list (list "e" "r") (list "r" "e")))

(check-expect (insert-everywhere/words "d" (list "e" "r"))
              (list (list "d" "e" "r")
                    (list "e" "d" "r")
                    (list "e" "r" "d")
                    (list "r" "e" "d")
                    (list "r" "d" "e")
                    (list "d" "r" "e")))

; 1String Word -> List-of-words
; produce permutations with the 1String in between
(define (insert-middle/words s w)
  (cond
    [(empty? w) '()]
    [(empty? (rest w)) w]
    [else (... (first w) (list s) (rest w))]))

(check-expect (insert-middle/words "x" (list "a" "b" "c"))
              (list (list "a" "x" "b" "c") (list "a" "b" "x" "c")))

; 1String Word -> Word
; inserts the 1String in all possible positions of a Word
(define (insert-everywhere/word s w)
  (cond
    [(empty? w) (list s)]
    [else (cons s (cons (first w) (insert-everywhere/word s (rest w))))]))

(check-expect (insert-everywhere/word "x" (list "a")) (list "x" "a" "x"))
(check-expect (insert-everywhere/word "x" (list "a" "b")) (list "x" "a" "x" "b" "x"))

; 1String Word -> Word
; inserts the 1String at the beginning of the Word
(define (insert-beginning/word s w)
  (cond
    [(empty? w) '()]
    [else (cons s w)]))

(check-expect (insert-beginning/word "x" '()) '())
(check-expect (insert-beginning/word "x" (list "a")) (list "x" "a"))

; 1String Word -> Word
; inserts the 1String at the end of the Word
(define (insert-end/word s w)
  (cond
    [(empty? w) '()]
    [else (append w (list s))]))

(check-expect (insert-end/word "x" '()) '())
(check-expect (insert-end/word "x" (list "a")) (list "a" "x"))

; 1String Word -> Word
; inserts the 1String in between all 1Strings of a Word
(define (insert-middle/word s w)
  (cond
    [(empty? w) '()]
    [(empty? (rest w)) w]
    [else (append (list (first w)) (list s) (insert-middle/word s (rest w)))]))

(check-expect (insert-middle/word "x" (list "a")) (list "a"))
(check-expect (insert-middle/word "x" (list "a" "b" "c")) (list "a" "x" "b" "x" "c"))
(check-expect (insert-middle/word "x" (list "a" "b")) (list "a" "x" "b"))
