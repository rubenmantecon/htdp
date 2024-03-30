;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname ex-234) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require lang/htdp-beginner-abbr)

(define one-list '("Asia: Heat of the Moment" "U2: One" "The White Stripes: Seven Nation Army"))

; List-of-ranking -> ...nested list...
; create a list of HTML rows from a list of rankings
(define (make-rows-ranking lor)
  (cond
    [(empty? lor) '()]
    [else `(,(make-row-ranking (first lor))
                ,@(make-rows-ranking (rest lor)))]))

; Ranking -> ...nested list...
; create a row for an HTML row from a rank
(define (make-row-ranking r)
  `(tr ,(make-cell-number (first r)) ,(make-cell-string (second r))))

; List-of-numbers -> ... nested list ...
; creates a row for an HTML table from l
(define (make-row-number l)
  (cond
    [(empty? l) '()]
    [else (cons (make-cell-number (first l)) (make-row-number (rest l)))]))

; List-of-strings -> ... nested list ...
; creates a row for an HTML table from l
(define (make-row-string l)
  (cond
    [(empty? l) '()]
    [else (cons (make-cell-string (first l)) (make-row-string (rest l)))]))

; Number -> ... nested list ...
; creates a cell for an HTML table from a number
(define (make-cell-number n)
  `(td ,(number->string n)))

; String -> ... nested list ...
; creates a cell for an HTML from a number
(define (make-cell-string s)
  `(td ,s))

; List-of-numbers List-of-numbers -> ... nested list ...
; creates an HTML table from two lists of numbers
(define (make-table-number row1 row2)
  `(table ((border "1")) (tr ,@(make-row-number row1)) (tr ,@(make-row-number row2))))

; List-of-numbers List-of-numbers -> ... nested list ...
; creates an HTML table from two lists of numbers
(define (make-table-string row1 row2)
  `(table ((border "1")) (tr ,@(make-row-string row1)) (tr ,@(make-row-string row2))))
;
; List-of-strings -> List-of-ranks
; sort a list of strings by ascending order of appearence
(define (ranking los)
  (reverse (add-ranks (reverse los))))

; List-of-strings -> List-of-ranks
; rank a list of strings by descending order of appearance
(define (add-ranks los)
  (cond
    [(empty? los) '()]
    [else (cons (list (length los) (first los)) (add-ranks (rest los)))]))

; List-of-ranks -> ... nested list ...
; turn a list of ranks into an HTML table
(define (make-table-ranking lor)
  `(table ((border "1"))
          ,(make-rows-ranking lor)))

(make-table-number '(1 2 3) '(4 5 6))
(make-rows-ranking (ranking one-list))
(make-table-ranking (ranking one-list))
