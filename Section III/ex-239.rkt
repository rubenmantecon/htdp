;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname ex-239) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "abstraction.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "abstraction.rkt" "teachpack" "2htdp")) #f)))
; A [List X Y] is a list: 
;   (cons X (cons Y '()))

; A Pair-of-Numbers is a [List Number Number]:
; (cons Number (cons Number '()))
(cons 1 (cons 2 '()))

; A Pair-of-Number-and-1String is a [List Number 1String]
; (cons Number (cons 1String '()))
(cons 1 (cons "o" '()))

; A Pair-of-String-and-Boolean is a [List String Boolean]
; (cons String (cons Boolean '()))
(cons "#true" (cons #t '()))