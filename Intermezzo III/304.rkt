;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |304|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "abstraction.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "abstraction.rkt" "teachpack" "2htdp")) #f)))
(for/list ([i 2] [j '(a b)]) (list i j))
; It will be (list (list 0 'a) (list 1 'b)



(for*/list ([i 2] [j '(a b)]) (list i j))
; It will be (list (list 0 'a) (list 1 'a) (list 0 'b) (list 1 'b))
; This one was off, but I got the gist of it
