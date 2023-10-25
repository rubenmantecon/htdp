;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname 12.4-word-games-the-heart-of-the-problem) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
;; 12.4 Word Games, the Heart of the Problem

; A Word is one of:
; – '() or
; – (cons 1String Word)
; interpretation a Word is a list of 1Strings (letters)

(define (arrangements w)
  (cond
    [(empty? w) (list '())]
    [else (insert-everywhere/in-all-words (first w)
                                          (arrangements (rest w)))]))

;(check-expect (arrangements '("a")) '("a"))
;(check-expect (arrangements '("o" "h")) '(("o" "h") ("h" "o")))

;; Ex 213

; 1String List-of-Words -> List-of-Words
; inserts the 1String in all possible positions of the list of words
(define (insert-everywhere/in-all-words s low)
  (cond
    [(empty? low) '()]
    [else (cons (insert-everywhere/word s (first low)) (insert-everywhere/in-all-words s (rest low)))]))

(check-expect (insert-everywhere/in-all-words "a" '()) '())
(check-expect (insert-everywhere/in-all-words "a" (list (list "b"))) (list
                                                                      (list "a" "b")
                                                                      (list "b" "a")))



; 1String Word -> List-of-Words
; appends and prepends 1String to Word, producing a list of words
(define (insert-everywhere/word s w)
  (cond
    [(empty? w) '()]
    [else (cons ... ) (insert-everywhere/word s (rest w)))]))

(check-expect (insert-everywhere/word "x" '()) '())
(check-expect (insert-everywhere/word "x" (list "a")) (list
                                                       (list "a" "x")
                                                       (list "x" "a")))
(check-expect (insert-everywhere/word "x" (list "a" "b")) (list
                                                          (list "a" "b" "x")
                                                          (list "a" "x" "b")
                                                          (list "x" "a" "b")))

