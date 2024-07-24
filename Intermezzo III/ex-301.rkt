;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname ex-301) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
;; Draw a box around the scope of each binding occurrence of sort and alon in figure 105.
;; Then draw arrows from each occurrence of sort to the appropriate binding occurrence.
;; Now repeat the exercise for the variant in figure 106. Do the two functions differ other than in name?

(define (insertion-sort alon)
  ; ---------------------------------------------------
  (local (; -------------------------------------------
          (define (sort alon)
            (cond
              [(empty? alon) '()]
              [else
               (add (first alon) (sort (rest alon)))]))
          ; -------------------------------------------

          ; -------------------------------------------
          (define (add an alon)
            (cond
              [(empty? alon) (list an)]
              [else
               (cond
                 [(> an (first alon)) (cons an alon)]
                 [else (cons (first alon)
                             (add an (rest alon)))])]))
          ; -------------------------------------------
          )
    
    (sort alon))
; -----------------------------------------------------
  )

; Aside from the top level scope, the above lines represent each local/inner scope within the function
; The same applies to the variant. They don't differ, essentially.

(define (sort.v2 alon)
  (local ((define (sort.v2 alon)
            (cond
              [(empty? alon) '()]
              [else
               (add (first alon) (sort.v2 (rest alon)))]))
          (define (add an alon)
            (cond
              [(empty? alon) (list an)]
              [else
                (cond
                  [(> an (first alon)) (cons an alon)]
                  [else (cons (first alon)
                              (add an (rest alon)))])])))
    (sort.v2 alon)))

