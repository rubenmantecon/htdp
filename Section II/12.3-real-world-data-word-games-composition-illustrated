;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname |12|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp")) #f)))
;; 12.3 Word Games, Composition Illustrated

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

; Word -> List-of-words
; finds all rearrangements of word
; temporary stub definition for this section
(define (arrangements word)
  (list word))

;; Ex 209

; String -> Word
; converts s to the chosen word representation 
(define (string->word s) (explode s))

; Word -> String
; converts w to a string
(define (word->string w) (implode w))

;; Ex 210

; List-of-words -> List-of-strings
; Convert a list of lists of 1Strings into a list of strings
(define (words->strings low)
  (cond
    [(empty? low) '()]
    [else (cons (word->string (first low)) (words->strings (rest low)))]))

(check-expect (words->strings (list
                               (list "a" "b" "c")
                               (list "c" "h" "o" "n" "k"))) (list "abc" "chonk"))

;; Ex 211


; List-of-strings -> List-of-strings
; picks out all the Strings that occur in the dictionary 
(define (in-dictionary los)
  (cond
    [(empty? los) '()]
    [else
     (if (word-in-dict? (first los) AS-LIST)
         (cons (first los) (in-dictionary (rest los)))
         (in-dictionary (rest los)))]))

; Word Dictionary -> Boolean
; member?-like predicate, determine if a Word belongs to the Dictionary
(define (word-in-dict? word dict)
  (cond
    [(empty? dict) #false]
    [else
     (or (string=? word (first dict)) (word-in-dict? word (rest dict)))]))

(check-expect (word-in-dict? "abroad" AS-LIST) #true)
(check-expect (word-in-dict? "dingus" AS-LIST) #false)