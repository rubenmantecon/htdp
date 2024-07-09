;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname ex-274) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp")) #f)))
; [List-of 1String] -> [List-of [List-of 1String]]
; produces a list of all the prefixes of a given list of 1String
(check-expect (prefixes.v2 '()) '())
(check-expect (prefixes.v2 (list "x")) (list (list "x")))
(check-expect (prefixes.v2 (list "a" "b" "c"))
              (list
               (list "a" "b" "c")
               (list "a" "b")
               (list "a")))

(define (prefixes.v2 l)
  (local (; [List-of String] -> [List-of String]
          ; produce a prefix
          (define (prefix x y)
          (cond
            [(empty? x) x]
            [(empty? y) y]
            [else (cons (reverse x) (prefix (rest (reverse x)) y))])))
    (foldr prefix l (list l))))

; [List-of 1String] -> [List-of [List-of 1String]]
; produces a list of all the sufixes of a given list of 1String
(check-expect (suffixes.v2 '()) '())
(check-expect (suffixes.v2 (list "x")) (list (list "x")))
(check-expect (suffixes.v2 (list "a" "b" "c"))
              (list
               (list "a" "b" "c")
               (list "b" "c") 
               (list "c")))
(define (suffixes.v2 l)
  (local (; [List-of 1String] -> [List-of 1String]
          ; produce a suffix
          (define (suffix/inner x y)
            (cond
              [(empty? x) '()]
              [(empty? y) y]
              [else (cons y (suffix/inner x (rest y)))])))
    (foldl suffix/inner l (list l))))


; [List-of String] -> [List-of String]
; generate the first suffix of x
(define (suffix acc l)
            (cond
              [(empty? acc) '()]
              [(empty? l) l]
              [else (cons l (suffix acc (rest l)))]))

; [List-of 1String] -> [List-of [List-of 1String]]
; produces a list of all the sufixes of a given list of 1String
(check-expect (suffixes.v3 '()) '())
(check-expect (suffixes.v3 (list "x")) (list (list "x")))
(check-expect (suffixes.v3 (list "a" "b" "c"))
              (list
               (list "a" "b" "c")
               (list "b" "c") 
               (list "c")))
(define (suffixes.v3 l)
  (foldl suffix l (list l)))
