;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname ex-224-full-space-war) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
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
; A Tank is a structure:
(define-struct tank [position direction])
; (make-tank Posn String)
(define tank0 (make-tank (make-posn (/ WIDTH 2) (* HEIGHT 0.90)) "right"))
; interpretation: the position of the tank in the scene, and which direction in the X axis it is going to
;
; A ShotList is a List-of-Posn, and thus either:
; - '()
; - (cons Posn '())
; - (cons Posn ShotList)
(define shotlist0 (list (make-posn 40 100) (make-posn 80 100)))
; interpretation: the position of the shots in space
;
; A SpaceWar is a structure:
(define-struct sw [ufo tank shotlist])
; (make-sw Posn Tank ShotList)
(define sw0 (make-sw ufo0 tank0 shotlist0))
; interpretation: the full state of the space war

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

; Tank -> Boolean
; checks whether the tank is at scene limit
(define (tank-against-width? tank) (or
                                    (equal? (+ (posn-x (tank-position tank)) (add1 (/ TANK-WIDTH 2))) WIDTH)
                                    (equal? (- (posn-x (tank-position tank)) (sub1(/ TANK-WIDTH 2))) 0)))

; UFO ShotList -> Boolean
; checks whether the UFO has been shot down
(check-expect (ufo-destroyed? ufo0 shotlist0) #false)
(define (ufo-destroyed? ufo shotlist)
  (cond
    [(empty? shotlist) #false]
    [else (if
           (within-hit-range? ufo (first shotlist))
           #true
           (ufo-destroyed? ufo (rest shotlist)))]))

(check-expect (within-hit-range? ufo0 (first shotlist0)) #false)
(check-expect (within-hit-range? ufo0 (second shotlist0)) #false)
(check-expect (within-hit-range? ufo0 (make-posn (add1 (posn-x ufo0)) (add1 (posn-y ufo0)))) #true)
(check-expect (within-hit-range? ufo0 (make-posn (+ 3 (posn-x ufo0)) (+ 3 (posn-y ufo0)))) #true)
(check-expect (within-hit-range? ufo0 (make-posn (+ 5 (posn-x ufo0)) (+ 3 (posn-y ufo0)))) #false)
(define (within-hit-range? ufo shot) 
  (and
   (and
    (>= (posn-x shot) (- (posn-x ufo) (/ UFO-WIDTH 2)))
    (<= (posn-x shot) (+ (posn-x ufo) (/ UFO-WIDTH 2))))
   (<= (posn-y shot) (+ (posn-y ufo) (+ (/ UFO-HEIGHT 2) (/ UFO-DIAMETER 2))))))
   

; Posn -> Posn 
; ???
(check-satisfied (ufo-create (make-posn 1 1)) not=-1-1?)
(define (ufo-create p)
  (ufo-check-create
     p (make-posn (random (- WIDTH 20)) (random (- HEIGHT 20)))))
 
; Posn Posn -> Posn 
; generative recursion 
; ???
(define (ufo-check-create p candidate)
  (if (equal? p candidate) (ufo-create p) candidate))
 
; Posn -> Boolean
; use for testing only 
(define (not=-1-1? p)
  (not (and (= (posn-x p) 1) (= (posn-y p) 1))))

; UFO -> UFO
; oscillate between a range in the UFO's horizontal plane
(define (ufo-vibrate ufo) (make-posn (posn-x ... (posn-y ufo))))

; UFO -> UFO
; moves the UFO
(define (move-ufo ufo) (make-posn (posn-x ufo) (add1 (posn-y ufo))))

; Tank KeyEvent -> Tank
; moves the tank
(define (move-tank tank ke)
  (cond
    [(and (tank-against-width? tank) (key=? "right" (tank-direction tank))) (make-tank (make-posn (sub1 (posn-x (tank-position tank))) (posn-y (tank-position tank))) "left")]
    [(and (tank-against-width? tank) (key=? "left" (tank-direction tank))) (make-tank (make-posn (add1 (posn-x (tank-position tank))) (posn-y (tank-position tank))) "right")]
    [(key=? "right" ke) (make-tank (make-posn (add1 (posn-x (tank-position tank))) (posn-y (tank-position tank))) ke)]
    [(key=? "left" ke) (make-tank (make-posn (sub1 (posn-x (tank-position tank))) (posn-y (tank-position tank))) ke)]
    [else tank]
    ))

; ShotList -> ShotList
; moves the shot shots in space
(check-expect (move-shotlist '()) '())
(check-expect (move-shotlist shotlist0) (list (make-posn 40 99) (make-posn 80 99)))
(define (move-shotlist shotlist)
  (cond
    [(empty? shotlist) '()]
    [else (cons (make-posn (posn-x (first shotlist)) (sub1 (posn-y (first shotlist)))) (move-shotlist (rest shotlist)))]))

; ShotList -> ShotList
; shoots a shot and adds it to the list of shot shots
(check-expect (shoot tank0 '()) (list (make-posn (posn-x (tank-position tank0)) (posn-y (tank-position tank0)))))
(define (shoot tank shotlist) (cons (make-posn (posn-x (tank-position tank)) (- (posn-y (tank-position tank)) (/ TANK-HEIGHT 2) (/ SHOT-SIZE 2))) shotlist))

;; World functions
; SpaceWar -> SpaceWar
; update the SpaceWar upon CPU clock tick
(define (tock sw) (make-sw (move-ufo (sw-ufo sw)) (sw-tank sw) (move-shotlist (sw-shotlist sw))))

; SpaceWar -> Image
; renders the SpaceWar
(define (render sw) (place-images (list UFO TANK) (list (sw-ufo sw) (tank-position (sw-tank sw))) (render-shotlist (sw-shotlist sw))))

; SpaceWar KeyEvent -> SpaceWar
; updates the SpaceWar upon a KeyEvent
(define (key-h sw ke)
  (cond
    [(key=? "right" ke) (make-sw (sw-ufo sw) (move-tank (sw-tank sw) ke) (sw-shotlist sw))]
    [(key=? "left" ke) (make-sw (sw-ufo sw) (move-tank (sw-tank sw) ke) (sw-shotlist sw))]
    [(key=? " " ke) (make-sw (sw-ufo sw) (sw-tank sw) (shoot (sw-tank sw) (sw-shotlist sw)))]
    [else sw]))

; SpaceWar -> Boolean
; determines whether the game has reached its final state
(define (end? sw)
  (cond
    [(ufo-destroyed? (sw-ufo sw) (sw-shotlist sw)) #true]
    [(ufo-breached? (sw-ufo sw) (sw-tank sw)) #true]
    [else #false]))

; SpaceWar -> Image
; render the final SpaceWar state
(define (render-end sw) (place-images (list UFO TANK (text "game over" 18 "crimson")) (list (sw-ufo sw) (tank-position (sw-tank sw)) (make-posn (/ WIDTH 2) (/ HEIGHT 2))) (render-shotlist (sw-shotlist sw))))

; SpaceWar -> Image
; main game
(define (space-war rate)
  (big-bang sw0
    [on-tick tock rate]
    [on-draw render]
    [on-key key-h]
    [stop-when end? render-end]
    [state #t]))