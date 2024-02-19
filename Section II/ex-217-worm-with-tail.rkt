;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname ex-217-worm-with-tail) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
;; Constants
(define DIAMETER 8)
(define PIECE (circle DIAMETER "solid" "crimson"))
(define HEIGHT 100)
(define WIDTH 100)
(define BACKGROUND-CENTER-POSN (make-posn (/ HEIGHT 2) (/ WIDTH 2)))
(define BACKGROUND (empty-scene HEIGHT WIDTH))
(define RATE 0.2)

;; Data definitions
; A Worm is a Posn
; (make-posn Number Number)
; interpretation the position of the worm in space
;
; A Direction is one of:
; - "up"
; - "down"
; - "left"
; - "right"
; interpretation where the worm is headed
;
; A Worm With Tail (WWT) is a NEList-of-Posn, and thus either:
; - (cons Worm '())
; - (cons Worm WWT)
; interpretation the position of WWT in space
;
;
; A Worm World (WW) is a structure:
(define-struct ww [worm direction])
; (make-ww NEList-of-Posn String)
(define WW0 (make-ww (list (make-posn (/ HEIGHT 2) (/ WIDTH 2))
                           (make-posn (/ HEIGHT 2) (+ (/ WIDTH 2) 1))
                           (make-posn (/ HEIGHT 2) (+ (/ WIDTH 2) 2))
                           (make-posn (/ HEIGHT 2) (+ (/ WIDTH 2) 3))) "up"))
(define WW1 (make-ww (list (make-posn (/ HEIGHT 2) (/ WIDTH 2))
                           (make-posn (/ HEIGHT 2) (+ (/ WIDTH 2) 1))
                           (make-posn (/ HEIGHT 2) (+ (/ WIDTH 2) 2))
                           (make-posn (/ HEIGHT 2) (+ (/ WIDTH 2) 3))) "up"))
(define WW2 (make-ww (list (make-posn (/ HEIGHT 2) (/ WIDTH 4))) "left"))
(define WW3 (make-ww (list (make-posn (/ HEIGHT 2) (/ WIDTH 8))) "right"))
(define WW4 (make-ww (list (make-posn (random HEIGHT) (random WIDTH))) (list-ref (list "up" "down" "left" "right") (random 3))))
(define WW5 (make-ww (list (make-posn (random HEIGHT) (random WIDTH))) (list-ref (list "up" "down" "left" "right") (random 3))))
(define WW6 (make-ww (list (make-posn (random HEIGHT) (random WIDTH))) (list-ref (list "up" "down" "left" "right") (random 3))))

; interpretation the total state of the world; the position of the worm and towards where is it moving at any point in time and space

;; Helper functions
; WW Direction -> WW
; moves the worm in

;; World functions
; WW -> WW
; updates the state of the WW after each CPU clock tick
(define (tock cw)
  (cond
    [(key=? (ww-direction cw) "up") ...]
    [(key=? (ww-direction cw) "down") ...]
    [(key=? (ww-direction cw) "left") ...]
    [(key=? (ww-direction cw) "right") (make-ww
                                        (make-posn (add1 (posn-x (ww-worm cw))) (posn-y (ww-worm cw)))
                                        (ww-direction cw))]
    [else cw]))

; WW KeyEvent -> WW
; updates the state of the WW upon a Key Event
(define (key-h cw ke)
  (cond
    [(key=? ke "up") (make-ww
                      (make-posn (posn-x (ww-worm cw)) (posn-y (ww-worm cw)))
                      "up")]
    [(key=? ke "down") (make-ww
                      (make-posn (posn-x (ww-worm cw)) (posn-y (ww-worm cw)))
                      "down")]
    [(key=? ke "left") (make-ww
                      (make-posn (posn-x (ww-worm cw)) (posn-y (ww-worm cw)))
                      "left")]
    [(key=? ke "right") (make-ww
                      (make-posn (posn-x (ww-worm cw)) (posn-y (ww-worm cw)))
                      "right")]
    [else cw]))

(define (main-worm rate)
  (big-bang WW1
    [on-tick tock]
    [on-draw render]
    [on-key key-h]
    ))