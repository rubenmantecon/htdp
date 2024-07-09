;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname ex-292) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp")) #f)))
; [X X -> Boolean] [NEList-of X] -> Boolean 
; determines whether l is sorted according to cmp
(check-expect (sorted? < '(1 2 3)) #true)
(check-expect (sorted? < '(2 1 3)) #false)
(check-expect (sorted? string<? '("a" "b" "c")) #true)
(check-expect (sorted? string<? '("c" "a" "b")) #false)
(define (sorted? cmp l)
  (equal? (sort l cmp) l))

; [X X -> Boolean] -> [[List-of X] -> Boolean]
; is the given list l0 sorted according to cmp
(check-expect [(sorted string<?) '("b" "c")] #true)
(check-expect [(sorted <) '(1 2 3 4 5 6)] #true)
(define (sorted cmp)
  (lambda (l0)
    (local (; [NEList-of X] -> Boolean 
            ; is l sorted according to cmp
            (define (sorted/l l)
              (cond
                [(empty? (rest l)) #true]
                [else (and (cmp (first l) (second l))
                           (sorted/l (rest l)))])))
      (if (empty? l0) #true (sorted/l l0)))))


;; Stop! Could you redefine sorted to use sorted? from exercise 292? Explain why sorted/l does not consume cmp as an argument.

; Why, yes:
(check-expect [(sorted string<?) '("b" "c")] [(sorted.v2 string<?) '("b" "c")])
(check-expect [(sorted <) '(1 2 3 4 5 6)] [(sorted.v2 <) '(1 2 3 4 5 6)])
(define (sorted.v2 cmp)
  (lambda (l) (if (empty? l) #true (sorted? cmp l))))

; sorted/l does not consume cmp as an argument because it can access it any time, since it's part of the local scope