;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname ex-275) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
(define LOCATION "./words.txt")

; A Letter is one of the following 1Strings: 
; – "a"
; – ... 
; – "z"
; or, equivalently, a member? of this list: 
(define LETTERS
  (explode "abcdefghijklmnopqrstuvwxyz"))

; A Dictionary is a List-of-strings.
(define AS-LIST (read-lines LOCATION))

; A LetterCount is either of:
; - '()
; (cons String Number LetterCount)

; Dictionary -> LetterCount
; produce the highest LetterCount
(check-expect (most-frequent (list "a" "abba" "armaggedon" "bone" "boggling" "brutal" "battery" "sadistic" "subhuman" "sovereign" "satori" "solace" "sail")) (list "s" 6))
(define (most-frequent dict)
  (cond
    [(empty? dict) '()]
    [else (local
            (; Dictionary Letter -> LetterCount
             ; produce a LetterCount for a letter
             (define (lettercount dict letter)
               (list
                letter
                (length (filter (lambda (x) (string-ci=? letter (string-ith x 0))) dict))))

             ; Dictionary [List-of Letter] -> [List-of LetterCount]
             ; produce LetterCounts for a given Dictionary
             (define (lettercounts dict lol)
               (cond
                 [(empty? (rest lol)) (list (lettercount dict (first lol)))]
                 [else (cons (lettercount dict (first lol)) (lettercounts dict (rest lol)))]))
             )         
            (first (sort (lettercounts dict LETTERS) (lambda (x y) (> (second x) (second y))))))]))

; Dictionary -> [List-of Dictionary]
; produce a list of Dictionaries, one per Letter
(check-expect (words-by-first-letter (list "a" "abba" "armaggedon" "bone" "boggling" "brutal" "battery" "sadistic" "subhuman" "sovereign" "satori" "solace" "sail"))
              (list
               (list "a" "abba" "armageddon")
               (list "bone" "boggling" "brutal" "battery")
               (list "sadistic" "subhuman" "sovereign" "satori" "solace" "sail"
                     )))
(define (words-by-first-letter dict)
  (cond
    [(empty? dict) '()]
    [else (local
            (; Dictionary -> Dictionary
             ; generate a Dictionary containing the words that start with a letter
             (define (words-by-first-letter/inner dict letter)
              (filter (lambda (x) (string-ci=? letter (string-ith x 0))) dict)
               )

             ; Dictionary [List-of Letter] -> [List-of Dictionary]
             ; generate the full list of Dictionaries per letter
             (define (dictionaries-per-letter dict lol)
               (cond
                 [(empty? (rest lol)) (words-by-first-letter/inner dict (first lol))]
                 [else (if (empty? (words-by-first-letter/inner dict (first lol)))
                                   (dictionaries-per-letter dict (rest lol))
                                   (cons (words-by-first-letter/inner dict (first lol)) (dictionaries-per-letter dict (rest lol))))]))
             )      
            (dictionaries-per-letter dict LETTERS))]))