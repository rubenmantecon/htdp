;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname 12.5-feeding-worms) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
;; Ex 215

;; Constants
(define WIDTH 280)
(define HEIGHT 80)
(define WW-X 15)
(define WW-Y 30)
(define WW-DIR "right")
(define DIAMETER 2)
(define PIECE (circle DIAMETER "solid" "red")) 
(define BACKGROUND (empty-scene WIDTH HEIGHT))
(define RATE 2)

;; Data definitions
;; A Worm is a Posn

;; A Direction is one of:
;; - "up"
;; - "down"
;; - "left"
;; - "right"

;; A Worm World (ww) is a structure
(define-struct ww [worm direction])
;; (make-ww Posn String)
;; interpretation: the position of the worm and its current direction

(define WW1
  (make-ww
   (make-posn WW-X WW-Y)
   WW-DIR))

;; World functions
; WorldState -> Image 
; renders the worm based on the current WorldState (Posn)
(define (render cw) (place-image PIECE (posn-x (ww-worm cw)) (posn-y (ww-worm cw)) BACKGROUND))

; WorldState -> WorldState  
; updates the state of the world after each CPU clock tick
(define (tock cw)
  (cond
    [(key=? (ww-direction cw) "up") (make-ww (make-posn (posn-x (ww-worm cw)) (sub1 (posn-y (ww-worm cw)))) "up")] 
    [(key=? (ww-direction cw) "down") (make-ww (make-posn (posn-x (ww-worm cw)) (add1 (posn-y (ww-worm cw)))) "down")]
    [(key=? (ww-direction cw) "right") (make-ww (make-posn (add1 (posn-x (ww-worm cw))) (posn-y (ww-worm cw))) "right")]
    [(key=? (ww-direction cw) "left") (make-ww (make-posn (sub1 (posn-x (ww-worm cw))) (posn-y (ww-worm cw))) "left")]
    [else cw]))


; KeyEvent Worm -> Worm
; updates the state of the worm upon a KeyEvent
(define (ke-h cw ke)
  (cond
    [(key=? "up" ke) (make-ww (make-posn (posn-x (ww-worm cw)) (sub1 (posn-y (ww-worm cw)))) ke)]
    [(key=? "down" ke) (make-ww (make-posn (posn-x (ww-worm cw)) (add1 (posn-y (ww-worm cw)))) ke)]
    [(key=? "right" ke) (make-ww (make-posn (add1 (posn-x (ww-worm cw))) (posn-y (ww-worm cw))) ke)]
    [(key=? "left" ke) (make-ww (make-posn (sub1 (posn-x (ww-worm cw))) (posn-y (ww-worm cw))) ke)]
    [else cw]
    ))
  

;; WorldState -> Boolean
;; evaluates, after each event, if the conditions to stop the program are satisifed
(define (end? cw)
  (if
   (or
    (or
     (<= (posn-x (ww-worm cw)) 0)
     (>= (posn-x (ww-worm cw)) WIDTH))
    (or
     (<= (posn-y (ww-worm cw)) 0)
     (>= (posn-y (ww-worm cw)) HEIGHT)))
   #true
   #false))

(define (render-end cw)
  (place-images
                   (list
                    PIECE
                    (text "worm hit border" 14 "red"))
                   (list
                    (make-posn (posn-x (ww-worm cw)) (posn-y (ww-worm cw)))
                    (make-posn (/ WIDTH 2) (/ HEIGHT 2)))
                   BACKGROUND))

(define (main-worm cw)
 (big-bang cw
  [on-key ke-h]
  [on-tick tock 1]
  [on-draw render]
  [stop-when end? render-end]))
  
