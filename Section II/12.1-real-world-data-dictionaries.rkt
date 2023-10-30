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

(check-expect (count-by-letter (list "a" "abba" "armaggedon" "bone" "boggling" "brutal" "battery" "sadistic" "subhuman" "sovereign" "satori" "solace" "sail"))
              (list
               (list "a" 3)
               (list "b" 4)
               (list "s" 6)))

;; Ex 197

; Dictionary -> LetterCount
; gets a list of lettercounts from a dictionary, and takes the LetterCount with the highest number
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
    [else ...]))

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
