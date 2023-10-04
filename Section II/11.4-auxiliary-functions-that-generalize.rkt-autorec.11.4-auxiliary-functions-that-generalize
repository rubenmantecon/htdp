;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 11.4-auxiliary-functions-that-generalize) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
; 11.4 Auxiliary Functions that Generalize

; A Polygon is one of:
; – (list Posn Posn Posn)
; – (cons Posn Polygon)

; The first clause says that a list of three Posns is a Polygon, and the second clause says that consing a Posn onto some existing Polygon creates another one.

; a plain background image 
(define MT (empty-scene 50 50))

 
; Image Polygon -> Image
; renders the given polygon p into img
(define (render-poly img p)
  (cond
    [(empty? (rest (rest (rest p))))
     (render-line
      (render-line
       (render-line MT (first p) (second p))
       (second p) (third p))
      (third p) (first p))]
    [else
     (render-line (render-poly img (rest p))
                  (first p)
                  (second p))]))

; Image Posn Posn -> Image 
; renders a line from p to q into img
(define (render-line img p q)
  (scene+line
   img
   (posn-x p) (posn-y p) (posn-x q) (posn-y q)
   "red"))

; An NELoP is one of: 
; – (cons Posn '())
; – (cons Posn NELoP)

; Image NELoP -> Image 
; connects the dots in p by rendering lines in img
(define (connect-dots img p)
  MT)

(check-expect (connect-dots MT triangle-p)
              (scene+line
               (scene+line MT 20 20 30 20 "red")
               20 10 20 20 "red"))