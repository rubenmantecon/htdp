;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 12.1-real-world-data-dictionaries) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
;; 12.1 Real-World Data: Dictionaries

(define LOCATION "./words.txt")

; A Dictionary is a List-of-strings.
(define AS-LIST (read-lines LOCATION))

; A Letter is one of the following 1Strings: 
; – "a"
; – ... 
; – "z"
; or, equivalently, a member? of this list: 
(define LETTERS
  (explode "abcdefghijklmnopqrstuvwxyz"))

; Letter Dictionary -> Number
; counts how many words in Dictionary start with Letter
(define (starts-with# letter dict)
  (cond
    [(empty? dict) 0]
    [else (if (string=? (string-ith (first dict) 0) letter)
              (+ (starts-with# letter (rest dict)) 1)
              (starts-with# letter (rest dict)))
          ]))

(check-expect (starts-with# "z" AS-LIST) 30)

; A LetterCount is any of:
; - '()
; (list String Number LetterCount)

; Dictionary -> List-of-Letter-Counts
; counts how often a word in a dictionary starts with each letter of the alphabet
(define (count-by-letter dict)
  (count-by-letter/inner LETTERS dict))

; List-of-strings Dictionary -> List-of-LetterCounts
; counts, for a dictionary, how many letters there are
(define (count-by-letter/inner letters dict)
  (cond
    [(empty? letters) '()]
    [else (cons (list (first letters) (starts-with# (first letters) dict))
                (count-by-letter/inner (rest letters) dict))]))


;; Ex 197

; Dictionary -> LetterCount
; return the LetterCount with the highest number of occurrences
(define (most-frequent dict)
  (cond
    [(empty? dict) '()]
    [else  (first (sort-lc> (count-by-letter dict))) ]))

(check-expect (most-frequent '()) '())
(check-expect (most-frequent (list "a" "abba" "armaggedon" "bone" "boggling" "brutal" "battery" "sadistic" "subhuman" "sovereign" "satori" "solace" "sail")) (list "s" 6))

; List-of-LetterCounts -> List-of-LetterCounts
; sorts a list of lettercounts by number of occurrences
(define (sort-lc> lolc)
  (cond
    [(empty? lolc) '()]
    [else (insert-lc (first lolc) (sort-lc> (rest lolc)))]))

(check-expect (sort-lc> (list
                         (list "a" 3)
                         (list "b" 4)
                         (list "f" 0)
                         (list "s" 6)))
              (list
               (list "s" 6)
               (list "b" 4)
               (list "a" 3)
               (list "f" 0)))

; LetterCount List-of-lettercounts -> List-of-lettercounts
; inserts a LetterCount into a descending ordered list of lettercounts
(define (insert-lc lc lolc)
  (cond
    [(empty? lc) lolc]
    [(empty? lolc) (list lc)]
    [else (if (lc>? lc (first lolc))
              (cons lc lolc)
              (cons (first lolc) (insert-lc lc (rest lolc)))) ]))

(check-expect (insert-lc (list "t" 12) (list
                                        (list "b" 10)
                                        (list "c" 9)))
              (list
               (list "t" 12)
               (list "b" 10)
               (list "c" 9)))

(check-expect (insert-lc (list "t" 3) (list
                                       (list "x" 15)
                                       (list "s" 8)
                                       (list "h" 2)))
              (list
               (list "x" 15)
               (list "s" 8)
               (list "t" 3)
               (list "h" 2)))

; LetterCount LetterCount -> Boolean
; determines if the first LetterCount has a bigger count than the second
(define (lc>? lc1 lc2)
  (if (>= (second lc1) (second lc2))
      #true
      #false))

;; Ex 198

; Dictionary -> List-of-dictionaries
; produce a list of dictionaries, one Dictionary per Letter
(define (words-by-first-letter dict)
  (words-by-first-letter/outer LETTERS dict))

; List-of-strings Dictionary -> List-of-dictionaries
; produce a list of dictionaries, one Dictionary per Letter
(define (words-by-first-letter/outer letters dict)
  (cond
    [(empty? dict) '()]
    [(empty? letters) '()]
    [else (cons (words-by-first-letter/inner (first letters) dict) (words-by-first-letter/outer (rest letters) dict))]))

;(check-expect (words-by-first-letter (list "a" "abba" "armaggedon" "bone" "boggling" "brutal" "battery" "sadistic" "subhuman" "sovereign" "satori" "solace" "sail"))
;              (list
;               (list "a" "abba" "armageddon")
;               (list "bone" "boggling" "brutal" "battery")
;               (list "sadistic" "subhuman" "sovereign" "satori" "solace" "sail"
;                     )))

; List-of-letters Dictionary -> Dictionary
; produce from a dictionary, a dictionary whose words start by Letter
(define (words-by-first-letter/inner letter dict)
  (cond
    [(empty? dict) '()]
    [else (if (string=? (substring (first dict) 0 1) letter)
              (cons (first dict) (words-by-first-letter/inner letter (rest dict)))
              (words-by-first-letter/inner letter (rest dict)))]))

(define (most-frequent.v2 dict)'())