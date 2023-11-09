;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname 12.5-feeding-worms) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
;; Ex 215

;; Constants
(define DIAMETER 2)
(define PIECE (circle DIAMETER "solid" "red")) 
(define BACKGROUND (empty-scene 120 80))

;; Data definitions

; A WorldState is a Posn
; interpretation the location of the worm at each moment in time

;; World functions

; WorldState -> Image 
; renders the worm based on the current WorldState (Posn)
(define (render cw) (place-image PIECE (posn-x cw) (posn-y cw) BACKGROUND))

; WorldState -> WorldState  
; updates the state of the world after each CPU clock tick
(define (tock cw)
 (make-posn (+ (posn-x cw) DIAMETER) (+ (posn-y cw) DIAMETER)))
 

; KeyEvent Worm -> Worm
; updates the state of the worm upon a KeyEvent
(define (ke-h cw ke)
 (cond
  [(key=? ke "up") (make-posn (posn-x cw)  (- (posn-y cw) DIAMETER))]
  [(key=?  ke "down") (make-posn (posn-x cw) (+ (posn-y cw) DIAMETER))]
  [(key=? ke "left") (make-posn (- (posn-x cw) DIAMETER) (posn-y cw))]
  [(key=? ke "right" ) (make-posn (+ (posn-x cw) DIAMETER) (posn-y cw))]
  [else cw]))
  

;; WorldState -> Boolean
;; evaluates, after each event, if the conditions to stop the program are satisifed
;(define (end? world) '())

(define (main world)
 (big-bang world
  [on-key ke-h]
  [on-tick tock 1]
  [on-draw render]))
  