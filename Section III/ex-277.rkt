;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname ex-277) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp")) #f)))
(require 2htdp/universe)
(require 2htdp/image)

;; Constants
(define UFO-WIDTH 18)
(define UFO-HEIGHT 2)
(define UFO-DIAMETER 4)
(define TANK-WIDTH 12)
(define TANK-HEIGHT 6)
(define SHOT-SIZE 8)
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
; A UFO is a structure:
(define-struct ufo [position direction])
; (make-ufo Posn String)
(define ufo0 (make-ufo (make-posn (/ WIDTH 2) (* HEIGHT 0.20)) "left"))
; interpretation: the position of the UFO in the scene, and which direction in the X axis it is going to
;
; A UFOArmy is a [NEList-of UFO], and thus either:
; - (cons UFO '())
; - (cons UFO UFOArmy)
(define ufoarmy0 (list
                  ufo0
                  (make-ufo (make-posn (/ WIDTH 4) (* HEIGHT 0.15)) "right")
                  (make-ufo (make-posn (/ WIDTH 6) (* HEIGHT 0.30)) "left")))
; interpretation: a collection of many UFOs in space
; A Tank is a structure:
(define-struct tank [position direction])
; (make-tank Posn String)
(define tank0 (make-tank (make-posn (/ WIDTH 2) (* HEIGHT 0.90)) "right"))
; interpretation: the position of the tank in the scene, and which direction in the X axis it is going to
;
; A ShotList is a [List-of Posn], and thus either:
; - '()
; - (cons Posn ShotList)
(define shotlist0 (list (make-posn 40 100) (make-posn 80 100)))
; interpretation: the position of the shots in space
;
; A SpaceWar is a structure:
(define-struct sw [ufoarmy tank shotlist])
; (make-sw Posn Tank ShotList)
(define sw0 (make-sw ufo0 tank0 shotlist0))
; interpretation: the full state of the space war