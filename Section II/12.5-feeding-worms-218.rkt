;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname 12.5-feeding-worms-218) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
;; Ex 218

;; Constants
(define WIDTH 280)
(define HEIGHT 80)
(define MAX (* WIDTH HEIGHT))
(define WWT-X 15)
(define WWT-Y 30)
(define WWT-DIR "down")
(define DIAMETER 6)
(define PIECE (circle DIAMETER "solid" "red"))
(define BACKGROUND (empty-scene WIDTH HEIGHT))
(define RATE 2)

;; Data definitions
;; A Worm-with-tails is either:
;; - '()
;; - (cons Worm Worm-with-tails) 

;; A Direction is one of:
;; - "up"
;; - "down"
;; - "left"
;; - "right"

;; A WormWorld (ww) is a structure
(define-struct ww [worm direction])
;; (make-ww Worm-with-tails String)
;; interpretation: the position of the worm and its current direction

(define WWT1
  (make-ww
   (list (make-posn WWT-X WWT-Y) (make-posn (+ WWT-X 1) WWT-Y) (make-posn (+ WWT-X 2) WWT-Y) (make-posn (+ WWT-X 3) WWT-Y) (make-posn (+ WWT-X 4) WWT-Y))
   WWT-DIR))

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

; WormState -> WormState
; produces the amount of pieces to render based on the amount of Posns 
(define (pieces-to-render cw)
  (cond
    [(empty? (ww-worm cw)) '()]
    [else (cons PIECE (pieces-to-render (make-ww (rest (ww-worm cw)) (ww-direction cw))))]))

(define (move-tail cw)
  (cond
    [(empty? (rest (ww-worm cw))) '()]
    [else (cons
           (make-posn (posn-x (first (ww-worm cw))) (posn-y (first (ww-worm cw))))
           (move-tail (make-ww (rest (ww-worm cw)) (ww-direction cw))))]
    ))

;; World functions
; WormState -> Image 
; renders the worm based on the current WormState
; TODO don't overlap pieces
(define (render cw) (place-images (pieces-to-render cw) (ww-worm cw) BACKGROUND))

; WorldState -> WorldState  
; updates the state of the world after each CPU clock tick
(define (tock cw)
  (cond
    [(key=? (ww-direction cw) "up") (make-ww
                                     (append (list (make-posn (posn-x (first (ww-worm cw))) (sub1 (posn-y (first (ww-worm cw))))))
                                             (move-tail cw)) "up")]
    [(key=? (ww-direction cw) "down") (make-ww
                                       (append (list (make-posn (posn-x (first (ww-worm cw))) (add1 (posn-y (first (ww-worm cw))))))
                                               (move-tail cw))
                                       "down")]
    [(key=? (ww-direction cw) "left") (make-ww
                                     (append (list (make-posn (sub1 (posn-x (first (ww-worm cw))))  (posn-y (first (ww-worm cw)))))
                                             (move-tail cw)) "left")]
    [(key=? (ww-direction cw) "right") (make-ww
                                        (append (list (make-posn (add1 (posn-x (first (ww-worm cw)))) (posn-y (first (ww-worm cw)))))
                                             (move-tail cw)) "right")]
    [else cw]
    ))


; KeyEvent Worm -> Worm
; updates the state of the worm upon a KeyEvent
(define (ke-h cw ke)
  (cond
    [(key=? (ww-direction cw) "up") (make-ww
                                     (append (list (make-posn (posn-x (first (ww-worm cw))) (sub1 (posn-y (first (ww-worm cw))))))
                                             (move-tail cw)) ke)]
    [(key=? (ww-direction cw) "down") (make-ww
                                       (append (list (make-posn (posn-x (first (ww-worm cw))) (add1 (posn-y (first (ww-worm cw))))))
                                               (move-tail cw))
                                       ke)]
    [(key=? (ww-direction cw) "left") (make-ww
                                     (append (list (make-posn (sub1 (posn-x (first (ww-worm cw))))  (posn-y (first (ww-worm cw)))))
                                             (move-tail cw)) ke )]
    [(key=? (ww-direction cw) "right") (make-ww
                                        (append (list (make-posn (add1 (posn-x (first (ww-worm cw)))) (posn-y (first (ww-worm cw)))))
                                             (move-tail cw)) ke)]
    [else cw]

    ))

                                        


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
    (pieces-to-render cw)
    (list (text "worm hit border" 14 "red")))
   (append
    (ww-worm cw)
    (list (make-posn (/ WIDTH 2) (/ HEIGHT 2))))
   BACKGROUND))

(define (main-worm cw)
 (big-bang cw
  [on-key ke-h]
  [on-tick tock 1]
  [on-draw render]
  [stop-when end? render-end]
  ))