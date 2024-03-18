;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname ex-224-full-space-war) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/universe)
(require 2htdp/image)

;; Constants
(define UFO-WIDTH 18)
(define UFO-HEIGHT 2)
(define UFO-DIAMETER 4)
(define TANK-WIDTH 8)
(define TANK-HEIGHT 6)
(define SHOT-SIZE 4)
(define UFO (overlay
             (circle UFO-DIAMETER "solid" "purple")
             (rectangle UFO-WIDTH UFO-HEIGHT "solid" "royal blue")
             ))
(define SHOT (triangle SHOT-SIZE "solid" "crimson"))
(define TANK (rectangle TANK-WIDTH TANK-HEIGHT "solid" "dark olive green"))
(define WIDTH 250)
(define HEIGHT 200)
(define BACKGROUND (empty-scene WIDTH HEIGHT))
(define RATE 0.2)

;; Data definitions
; A Direction is one of:
; - "up"
; - "down"
; - "left"
; - "right"
; 
; A UFO is a Posn
; (make-posn x y)
(define ufo0 (make-posn (/ WIDTH 2) (* HEIGHT 0.20)))
; interpretation: the position of the UFO in the scene
;
; A Tank is a structure:
(define-struct tank [position direction])
; (make-tank Posn String)
(define tank0 (make-tank (make-posn (/ WIDTH 2) (* HEIGHT 0.90)) "right"))
; interpretation: the position of the tank in the scene, and which direction in the X axis is going
;
; A ShotList is a NEList-of-Posn, and thus either:
; - (cons Posn '())
; - (cons Posn ShotList)
(define shotlist0 (list (make-posn 40 150) (make-posn 70 150)))
; interpretation: the position of the shots in space
;
; A SpaceWar is a structure:
(define-struct sw [ufo tank shotlist])
; (make-sw Posn Tank ShotList)
(define sw0 (make-sw ufo0 tank0 shotlist0))
; interpretation: the full state of the space war

;; Data collections

;; Helper functions
; UFO -> Image
; render the UFO
(check-expect (render-ufo ufo0) (place-image UFO (posn-x ufo0) (posn-y ufo0) BACKGROUND))
(define (render-ufo ufo) (place-image UFO (posn-x ufo) (posn-y ufo) BACKGROUND))

; Tank -> Image
; render the tank
(check-expect (render-tank tank0) (place-image TANK (posn-x (tank-position tank0)) (posn-y (tank-position tank0)) BACKGROUND))
(define (render-tank tank) (place-image TANK (posn-x (tank-position tank)) (posn-y (tank-position tank)) BACKGROUND))

; ShotList -> Image
; renders a ShotList
(define (render-shotlist shotlist)
  (cond
    [(empty? shotlist) BACKGROUND]
    [else (place-image
           SHOT
           (posn-x (first shotlist))
           (posn-y (first shotlist))
           (render-shotlist (rest shotlist)))]))

; UFO -> Boolean
; checks whether the UFO has reached the bottom of the scene
(check-expect (ufo-breached? ufo0 tank0) #false)
(check-expect (ufo-breached? (make-posn (/ WIDTH 2) (* HEIGHT 0.89)) tank0) #false)
(check-expect (ufo-breached? (make-posn (/ WIDTH 2) (* HEIGHT 0.90)) tank0) #true)
(check-expect (ufo-breached? (make-posn (/ WIDTH 2) (* HEIGHT 0.95)) tank0) #true)
(define (ufo-breached? ufo tank) (>= (posn-y ufo) (posn-y (tank-position tank))))

; UFO -> Boolean
; checks whether the UFO has crashed against the tank
(define (ufo-crashed? ufo tank)
  ; Gotta check that it's within a range of collision, not just the same posn
  ...)

; UFO -> Boolean
; checks whether the UFO is withing crashing range

; Tank -> Boolean
; checks whether the tank is at scene limit
(define (tank-against-width? tank)...)

; UFO ShotList -> Boolean
; checks whether a shot has hit the UFO
(define (ufo-hit? ufo shotlist)...)

; UFO -> UFO
; moves the UFO
(define (move-ufo ufo)...)

; Tank KeyEvent -> Tank
; moves the tank
(define (move-tank tank ke)...)

; ShotList -> ShotList
; moves the shots currently in space
(define (move-shotlist shotlist)...)

;; World functions
; SpaceWar -> SpaceWar
; update the SpaceWar upon CPU clock tick
(define (tock sw) ...)

; SpaceWar -> Image
; renders the SpaceWar
(define (render sw)...)

; SpaceWar -> Image
; render the final SpaceWar state
(define (render-end sw)...)

; SpaceWar KeyEvent -> SpaceWar
; updates the SpaceWar upon a KeyEvent
(define (key-h sw ke)...)

; SpaceWar -> Boolean
; determines whether the game has reached its final state
(define (end? sw)...)