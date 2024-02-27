;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname ex219-worm-with-random-food) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
;; Constants
(define DIAMETER 8)
(define PIECE (circle DIAMETER "solid" "crimson"))
(define FOOD-PIECE (circle (+ 1 DIAMETER) "solid" "lime green"))
(define SEPARATION (* 2 DIAMETER))
(define HEIGHT 200)
(define WIDTH 200)
(define BACKGROUND-CENTER-POSN (make-posn (/ HEIGHT 2) (/ WIDTH 2)))
(define BACKGROUND (empty-scene HEIGHT WIDTH))
(define RATE 0.2)

;; Data definitions
;
; A Direction is one of:
; - "up"
; - "down"
; - "left"
; - "right"
; interpretation: where the worm is headed
;
; A Worm is a NEList-of-Posn, and thus either:
; - (cons Worm '())
; - (cons Worm WWT)
; interpretation: the position of WWT in space
;
; A Worm World (WW) is a structure:
(define-struct ww [food worm direction])
; (make-ww Posn NEList-of-Posn String)
(define WW0 (make-ww
             (make-posn (random WIDTH) (random HEIGHT))
             (list     
              (make-posn (/ WIDTH 2) (/ HEIGHT 2))
              (make-posn (/ WIDTH 2) (+ SEPARATION  (/ HEIGHT 2)))
              (make-posn (/ WIDTH 2) (+ (* 2 SEPARATION) (/ HEIGHT 2)))
              (make-posn (/ WIDTH 2) (+ (* 3 SEPARATION) (/ HEIGHT 2))))
             "up")) 
(define WW1 (make-ww
             (make-posn (random WIDTH) (random HEIGHT))
             (list     
              (make-posn (/ WIDTH 2) (/ HEIGHT 2))
              (make-posn (/ WIDTH 2) (+ SEPARATION  (/ HEIGHT 2)))
              (make-posn (/ WIDTH 2) (+ (* 2 SEPARATION) (/ HEIGHT 2)))
              (make-posn (/ WIDTH 2) (+ (* 3 SEPARATION) (/ HEIGHT 2))))
             "down")) 
(define WW2 (make-ww
             (make-posn (random WIDTH) (random HEIGHT))
             (list
              (make-posn (/ WIDTH 2) (/ HEIGHT 2))
              (make-posn (+ SEPARATION (/ WIDTH 2)) (/ HEIGHT 2))
              (make-posn (+ (* 2 SEPARATION) (/ WIDTH 2)) (/ HEIGHT 2))
              (make-posn (+ (* 3 SEPARATION) (/ WIDTH 2)) (/ HEIGHT 2)))
             "left"))
(define WW3 (make-ww
             (make-posn (random WIDTH) (random HEIGHT))
             (list
              (make-posn (/ WIDTH 2) (/ HEIGHT 2))
              (make-posn (+ SEPARATION (/ WIDTH 2)) (/ HEIGHT 2))
              (make-posn (+ (* 2 SEPARATION) (/ WIDTH 2)) (/ HEIGHT 2))
              (make-posn (+ (* 3 SEPARATION) (/ WIDTH 2)) (/ HEIGHT 2)))
             "right"))
(define WW4 (make-ww
             (make-posn (random WIDTH) (random HEIGHT))
             (list (make-posn (random HEIGHT) (random WIDTH)))
             (list-ref (list "up" "down" "left" "right") (random 3))))
(define WW-LIST (list WW0 WW1 WW2 WW3 WW4))
; interpretation: the total state of the world; the position of the food, the worm and towards where is it moving at any point in time and space

;; Helper functions
; Posn -> Posn 
; ???
(check-satisfied (food-create (make-posn 1 1)) not=-1-1?)
(define (food-create p)
  (food-check-create
     p (make-posn (random (- WIDTH 5)) (random (- HEIGHT 5)))))
 
; Posn Posn -> Posn 
; generative recursion 
; ???
(define (food-check-create p candidate)
  (if (equal? p candidate) (food-create p) candidate))
 
; Posn -> Boolean
; use for testing only 
(define (not=-1-1? p)
  (not (and (= (posn-x p) 1) (= (posn-y p) 1))))

; Worm -> Worm
; moves the worm
(define (move-worm worm direction)
  (cons (move-head worm direction) (move-tail worm)))

; Worm -> Worm
; moves the worm's head
(define (move-head worm direction)
  (cond
    [(key=? direction "up") (make-posn (posn-x (first worm)) (sub1 (posn-y (first worm))))]
    [(key=? direction "down") (make-posn (posn-x (first worm)) (add1 (posn-y (first worm)))) ]
    [(key=? direction "left") (make-posn (sub1 (posn-x (first worm))) (posn-y (first worm))) ]
    [(key=? direction "right") (make-posn (add1 (posn-x (first worm))) (posn-y (first worm))) ]
    [else worm]))

; Worm -> Worm
; moves a worm's tail based off the head's movement
(define (move-tail worm)
  (cond
    [(empty? (rest worm)) '()]
    [else (cons (first worm) (move-tail (rest worm)))]))

; WW -> Image
; renders the final world
(define (render-end cw)
  (place-image
   (if (member? (first (ww-worm cw)) (rest (ww-worm cw)))
       (text "worm crashed upon itself" 14 "crimson" )
       (text "worm hit border" 14 "crimson" ))
   (posn-x BACKGROUND-CENTER-POSN)
   (posn-y BACKGROUND-CENTER-POSN)
   (render cw))
   )

; List-of-worms -> Image
; recursively renders the worm
(define (render-worm worm)
  (cond
    [(empty? worm) BACKGROUND]
    [else (place-image/align
           PIECE
           (posn-x (first worm))
           (posn-y (first worm))
           "left" "top"
           (render-worm (rest worm)))]))

; Posn List-of-worms -> List-of-worms
; update the worm when it has eaten a food piece
(define (eat-food food worm)
  (cons food worm))



;; World functions
; WW -> WW
; updates the state of the WW after each CPU clock tick
(define (tock cw)
  (cond
    [(equal? (first (ww-worm cw)) (ww-food cw)) (make-ww (food-create (ww-food cw)) (eat-food (ww-food cw) (ww-worm cw)) (ww-direction cw))]
    [else (make-ww (ww-food cw) (move-worm (ww-worm cw) (ww-direction cw)) (ww-direction cw))]
    ))

; WW KeyEvent -> WW
; updates the state of the WW upon a Key Event
(define (key-h cw ke)
  (cond
    [(key=? ke "up") (if (not (key=? (ww-direction cw) "down")) (make-ww (ww-food cw) (ww-worm cw) ke) cw)]
    [(key=? ke "down") (if (not (key=? (ww-direction cw) "up")) (make-ww (ww-food cw) (ww-worm cw) ke) cw)]
    [(key=? ke "left") (if (not (key=? (ww-direction cw) "right")) (make-ww (ww-food cw) (ww-worm cw) ke) cw)]
    [(key=? ke "right") (if (not (key=? (ww-direction cw) "left")) (make-ww (ww-food cw) (ww-worm cw) ke) cw)]
    [else cw]))

; WW -> Image
; renders the current state of the WW
(define (render cw)
  (place-image
   FOOD-PIECE
   (posn-x (ww-food cw))
   (posn-y (ww-food cw))
   (render-worm (ww-worm cw))
   ))

; WW -> Boolen
; determines if the final state of the world has been reached
(define (end? cw)
  (cond
    [(or (>= (posn-x (first (ww-worm cw))) WIDTH) (<= (posn-x (first (ww-worm cw))) 0)) #true]
    [(or (>= (posn-y (first (ww-worm cw))) HEIGHT) (<= (posn-y (first (ww-worm cw))) 0)) #true]
    [(member? (first (ww-worm cw)) (rest (ww-worm cw))) #true]
    [else #false]
    ))

(define (main-worm rate)
  (big-bang
      WW3
      ;(list-ref WW-LIST (random (length WW-LIST)))
    [on-tick tock]
    [on-draw render]
    [on-key key-h]
    [stop-when end? render-end]
    ))