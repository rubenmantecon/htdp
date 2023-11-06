;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname 12.5-feeding-worms) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))

;; Ex 215

;; Constants
(define PIECE (circle 2 "solid" "red")) 
(define BACKGROUND (empty-scene 120 80))

;; Data definitions

; A Worm is a Posn:
; (make-posn Number Number)
; interpretation: the location of the Worm in space

;; World functions

; Worm -> Image
; based on the data available, renders the equivalent picture of it
(define (render worm) (place-image PIECE (posn-x worm) (posn-y worm) BACKGROUND))

; Worm -> Worm  
; updates the state of the world after each CPU clock tick
(define (clock-tick-handler worm)
 '()) 

; KeyEvent Worm -> Worm
; updates the state of the worm upon a KeyEvent
(define (key-event-handler ke worm)
 (cond
  [(key=? ke "up") (make-posn (posn-x worm) (add1 (posn-y worm)))]
  [(key=?  ke "down") (make-posn (posn-x worm) (sub1 (posn-y worm)))]
  [(key=? ke "left") (make-posn (sub1 (posn-x worm)) (posn-y worm))]
  [(key=? ke "right" ) (make-posn (add1 (posn-x worm)) (posn-y worm))]))
  

;; WorldState -> Boolean
;; evaluates, after each event, if the conditions to stop the program are satisifed
;(define (end? world) '())

(define (main world)
 (big-bang world
  [on-key key-event-handler]
  [on-draw render]))
  