;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname 12.5-feeding-worms-219) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
;; Ex 218

;; Constants
(define WIDTH 280)
(define HEIGHT 280)
(define MAX 280)
(define WW-X 15)
(define WW-Y 30)
(define WW-DIR "down")
(define WW-FOOD (make-posn (random WIDTH) (random HEIGHT)))
(define DIAMETER 6)
(define PIECE (circle DIAMETER "solid" "red"))
(define BACKGROUND (empty-scene WIDTH HEIGHT))
(define RATE 2)


;; Data definitions
;; A Worm is a Posn
;;
;; A Worm-with-tails is either:
;; - '()
;; - (cons Worm Worm-with-tails) 
;;
;; A Direction is one of:
;; - "up"
;; - "down"
;; - "left"
;; - "right"
;;
;; A Food is a Posn
;;
;; A WormWorld (ww) is a structure
(define-struct ww [worm food direction])
;; (make-ww Worm-with-tails Posn String)
;; interpretation: the position of the worm the food and the current direction of the worm

(define WW1
  (make-ww
   (list (make-posn WW-X WW-Y) (make-posn (+ WW-X 1) WW-Y) (make-posn (+ WW-X 2) WW-Y) (make-posn (+ WW-X 3) WW-Y) (make-posn (+ WW-X 4) WW-Y))
   WW-FOOD
   WW-DIR))

; Posn -> Posn 
; ???
(check-satisfied (food-create (make-posn 1 1)) not=-1-1?)
(define (food-create p)
  (food-check-create
     p (make-posn (random MAX) (random MAX))))
 
; Posn Posn -> Posn 
; generative recursion 
; ???
(define (food-check-create p candidate)
  (if (equal? p candidate) (food-create p) candidate))
 
; Posn -> Boolean
; use for testing only 
(define (not=-1-1? p)
  (not (and (= (posn-x p) 1) (= (posn-y p) 1))))

; WormState -> Listof[Image]
; produces the amount of pieces to render based on the amount of Posns 
(define (worm-pieces cw)
  (cond
    [(empty? (ww-worm cw)) '()]
    [else (cons PIECE
                (worm-pieces (make-ww (rest (ww-worm cw)) (ww-food cw) (ww-direction cw))))]))

; WormState -> WormState
; moves the worm tail by moving each piece to where the previous one was
(define (move-tail cw)
  (cond
    [(empty? (rest (ww-worm cw))) '()]
    [(equal? (first (ww-worm cw)) (ww-food cw)) 
                                                 
                                                 (move-tail (make-ww (cons (ww-food cw)(rest (ww-worm cw))) (food-create (ww-food cw)) (ww-direction cw)))]
    [else (cons
           (first (ww-worm cw))
           (move-tail (make-ww (rest (ww-worm cw)) (ww-food cw) (ww-direction cw))))]
    ))

;; World functions
; WormState -> Image 
; renders the current WormState
; TODO don't overlap pieces
(define (render cw)
    (place-images
           (append (worm-pieces cw) (list PIECE))
           (append (ww-worm cw) (list (ww-food cw)))
           BACKGROUND)
    )

; WorldState -> WorldState  
; updates the state of the world after each CPU clock tick
(define (tock cw)
  (cond
    [(key=? (ww-direction cw) "up") (make-ww
                                     (append (list (make-posn (posn-x (first (ww-worm cw))) (sub1 (posn-y (first (ww-worm cw))))))
                                             (move-tail cw))
                                     (ww-food cw)
                                     "up")]
    [(key=? (ww-direction cw) "down") (make-ww
                                       (append (list (make-posn (posn-x (first (ww-worm cw))) (add1 (posn-y (first (ww-worm cw))))))
                                               (move-tail cw))
                                       (ww-food cw)
                                       "down")]
    [(key=? (ww-direction cw) "left") (make-ww
                                     (append (list (make-posn (sub1 (posn-x (first (ww-worm cw))))  (posn-y (first (ww-worm cw)))))
                                             (move-tail cw))
                                     (ww-food cw)
                                     "left")]
    [(key=? (ww-direction cw) "right") (make-ww
                                        (append (list (make-posn (add1 (posn-x (first (ww-worm cw)))) (posn-y (first (ww-worm cw)))))
                                             (move-tail cw))
                                        (ww-food cw)
                                        "right")]
    [else cw]
    )
  )


; KeyEvent Worm -> Worm
; updates the state of the worm upon a KeyEvent
(define (ke-h cw ke)
  (cond
    [(key=? (ww-direction cw) "up") (make-ww
                                     (append (list (make-posn (posn-x (first (ww-worm cw))) (sub1 (posn-y (first (ww-worm cw))))))
                                             (move-tail cw))
                                     (ww-food cw)
                                     ke)]
    [(key=? (ww-direction cw) "down") (make-ww
                                       (append (list (make-posn (posn-x (first (ww-worm cw))) (add1 (posn-y (first (ww-worm cw))))))
                                               (move-tail cw))
                                       (ww-food cw)
                                       ke)]
    [(key=? (ww-direction cw) "left") (make-ww
                                       (append (list (make-posn (sub1 (posn-x (first (ww-worm cw))))  (posn-y (first (ww-worm cw)))))
                                             (move-tail cw))
                                       (ww-food cw)
                                       ke)]
    [(key=? (ww-direction cw) "right") (make-ww
                                        (append (list (make-posn (add1 (posn-x (first (ww-worm cw)))) (posn-y (first (ww-worm cw)))))
                                             (move-tail cw))
                                        (ww-food cw)
                                        ke)]
    [else cw]
    )
  )
                     
;; WorldState -> Boolean
;; evaluates, after each event, if the conditions to stop the program are satisifed
(define (end? cw)
  (if
   (or
    (or
     (<= (posn-x (first (ww-worm cw))) 0)
     (>= (posn-x (first (ww-worm cw))) WIDTH)
     (member? (first (ww-worm cw)) (rest (ww-worm cw))))
    (or
     (<= (posn-y (first (ww-worm cw))) 0)
     (>= (posn-y (first (ww-worm cw))) HEIGHT)
     (member? (first (ww-worm cw)) (rest (ww-worm cw)))))
   #true
   #false))

(define (render-end cw)
  (place-images
   (append
    (worm-pieces cw)
    (cond
      [(member? (first (ww-worm cw)) (rest (ww-worm cw))) (list (text "worm hit itself" 14 "red"))]
      [else (list (text "worm hit border" 14 "red"))]))
   (append
    (ww-worm cw)
    (list (make-posn (/ WIDTH 2) (/ HEIGHT 2))))
   BACKGROUND))

(define (main-worm cw)
 (big-bang cw
  [on-key ke-h]
  [on-tick tock 0.1]
  [on-draw render]
  [stop-when end? render-end]
  [state #f]
  ))