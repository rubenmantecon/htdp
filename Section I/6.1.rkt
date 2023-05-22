;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |6.1|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
;Exercise 94. Draw some sketches of what the game scenery looks like at various stages. Use the sketches to determine the constant and the variable pieces of the game. For the former, develop physical and graphical constants that describe the dimensions of the world (canvas) and its objects. Also develop some background scenery. Finally, create your initial scene from the constants for the tank, the UFO, and the background.

(define WIDTH 400)
(define HEIGHT 250)
(define BACKGROUND (empty-scene WIDTH HEIGHT "steelblue"))
(define UFO-WIDTH 60)
(define UFO-HEIGHT (/ UFO-WIDTH 6))
(define UFO (overlay/align
             "center" "center"
             (circle UFO-HEIGHT "solid" "fuchsia")
             (ellipse UFO-WIDTH UFO-HEIGHT "solid" "silver")
             ))

(define TANK (rectangle 60 20 "solid" "chartreuse"))
(define MISSILE (triangle 5 "solid" "crimson"))

(define UFO-POSN (make-posn (image-width UFO) (image-height UFO)))
(define TANK-POSN (make-posn (/ WIDTH 2) HEIGHT))


(define-struct aim [ufo tank])
; Keeps track of the state for the time period when the player is trying to get the tank in position for a shot

(define-struct fired [ufo tank missile])
; Keeps track of the state for representing states after the missile is fired

; Data structure(s) definitions proposed by the book:

; A UFO is a Posn. 
; interpretation (make-posn x y) is the UFO's location 
; (using the top-down, left-to-right convention)

(define-struct tank [loc vel])
; A Tank is a structure:
;   (make-tank Number Number). 
; interpretation (make-tank x dx) specifies the position:
; (x, HEIGHT) and the tank's speed: dx pixels/tick

; A Missile is a Posn. 
; interpretation (make-posn x y) is the missile's place

; Final data definion for keeping the world's state, proposed by the book:

; A SIGS is one of: 
; – (make-aim UFO Tank)
; – (make-fired UFO Tank Missile)
; interpretation represents the complete state of a 
; space invader game

; My interpretation: en esta itemización, cada struct representa el estado de todos los ítems presentes en el mundo. Por tanto, sólo considera dos casos realmente distintos: cuando se ha disparado un misil, y cuando no. Cuando no se ha disparado, el UFO y el tanque tienen unas posiciones particulares (que varían en función del input y de los ticks del reloj). Cuando se ha disparado, entra en juego también la posición del misil. De ahí que exista un struct de structs que contenga cada elemento que forma parte del mundo.

;; SIGS -> Image
;; adds TANK, UFO, and possibly MISSILE to 
;; the BACKGROUND scene
;(define (si-render s)
;  (cond
;    [(aim? s) (... (aim-tank s) ... (aim-ufo s) ...)]
;    [(fired? s) (... (fired-tank s) ... (fire-ufo s) ... (fired-missile s) ...)]))


; SIGS -> Image
; renders the given game state on top of BACKGROUND 
; for examples see figure 32
(define (si-render s)
  (cond
    [(aim? s)
     (tank-render (aim-tank s)
                  (ufo-render (aim-ufo s) BACKGROUND))]
    [(fired? s)
     (tank-render
      (fired-tank s)
      (ufo-render (fired-ufo s)
                  (missile-render (fired-missile s)
                                  BACKGROUND)))]))

; Figure 33: The complete rendering function

; Tank Image -> Image 
; adds t to the given image im
(define (tank-render t im)
  (place-image TANK (posn-x t) (posn-y t) im))
 
; UFO Image -> Image 
; adds u to the given image im
(define (ufo-render u im)
  (place-image UFO (posn-x u) (posn-y t) im))

; Missile Image -> Image
; adds m to the given image im
(define (missile-render m im)
  (place-image MISSILE (posn-x m) (posn-y m))im)


;Exercise 97. Design the functions tank-render, ufo-render, and missile-render. Compare this expression:
;
;    (tank-render
;      (fired-tank s)
;      (ufo-render (fired-ufo s)
;                  (missile-render (fired-missile s)
;                                  BACKGROUND)))
;
;with this one:
;
;    (ufo-render
;      (fired-ufo s)
;      (tank-render (fired-tank s)
;                   (missile-render (fired-missile s)
;                                   BACKGROUND)))
;
; When do the two expressions produce the same result?

; Tank Image -> Image 
; adds t to the given image im
(define (tank-render t im)
  ())

; UFO Image -> Image 
; adds u to the given image im
; (define (ufo-render u im)

; Missile Image -> Image 
; adds m to the given image im
; (define (missile-render m im) im)
 

