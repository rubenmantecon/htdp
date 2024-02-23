;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname ex-217-worm-with-tail) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
;; Constants
(define DIAMETER 8)
(define PIECE (circle DIAMETER "solid" "crimson"))
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
; interpretation where the worm is headed
;
; A Worm is a NEList-of-Posn, and thus either:
; - (cons Worm '())
; - (cons Worm WWT)
; interpretation the position of WWT in space
;
;
; A Worm World (WW) is a structure:
(define-struct ww [worm direction])
; (make-ww NEList-of-Posn String)
(define WW0 (make-ww (list
                      (make-posn (/ WIDTH 2) (/ HEIGHT 2))
                      (make-posn (/ WIDTH 2) (+ SEPARATION  (/ HEIGHT 2)))
                      (make-posn (/ WIDTH 2) (+ (* 2 SEPARATION) (/ HEIGHT 2)))
                      (make-posn (/ WIDTH 2) (+ (* 3 SEPARATION) (/ HEIGHT 2)))
                      )
                     "up")) ; Wait a second, this actually is incorrect. You can't be having this disposition of pieces, and this direction. It would crash on itself
(define WW1 (make-ww (list
                      (make-posn (/ WIDTH 2) (/ HEIGHT 2))
                      (make-posn (/ WIDTH 2) (+ SEPARATION  (/ HEIGHT 2)))
                      (make-posn (/ WIDTH 2) (+ (* 2 SEPARATION) (/ HEIGHT 2)))
                      (make-posn (/ WIDTH 2) (+ (* 3 SEPARATION) (/ HEIGHT 2)))
                      )
                     "down")) 
(define WW2 (make-ww (list
                      (make-posn (/ HEIGHT 2) (/ WIDTH 4))
                      (make-posn (+ (/ HEIGHT 2) 1) (/ WIDTH 4))
                      (make-posn (+ (/ HEIGHT 2) 2) (/ WIDTH 4))
                      (make-posn (+ (/ HEIGHT 2) 3) (/ WIDTH 4)))
                     "left"))
(define WW3 (make-ww (list
                      (make-posn (/ HEIGHT 2) (/ WIDTH 4))
                      (make-posn (+ (/ HEIGHT 2) 1) (/ WIDTH 4))
                      (make-posn (+ (/ HEIGHT 2) 2) (/ WIDTH 4))
                      (make-posn (+ (/ HEIGHT 2) 3) (/ WIDTH 4)))
                     "right"))
(define WW4 (make-ww
             (list (make-posn (random HEIGHT) (random WIDTH)))
             (list-ref (list "up" "down" "left" "right") (random 3))))
(define WW5 (make-ww
             (list (make-posn (random HEIGHT) (random WIDTH)))
             (list-ref (list "up" "down" "left" "right") (random 3))))
(define WW6 (make-ww
             (list (make-posn (random HEIGHT) (random WIDTH)))
             (list-ref (list "up" "down" "left" "right") (random 3))))

; interpretation the total state of the world; the position of the worm and towards where is it moving at any point in time and space

;; Helper functions
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

; WW -> WW
; moves the worm
(define (move-worm cw)
  (cond
    [(empty? (rest worm) worm)]
    [(key=? (ww-direction cw) "up") (make-ww ...) ]
    [(key=? (ww-direction cw) "down") (make-ww ...) ]
    [(key=? (ww-direction cw) "left") (make-ww ...) ]
    [(key=? (ww-direction cw) "right") (make-ww ...) ]
    [else cw]))

;; World functions
; WW -> WW
; updates the state of the WW after each CPU clock tick
(define (tock cw)
  (cond
    [(key=? (ww-direction cw) "up") ... ]
    [(key=? (ww-direction cw) "down") ... ]
    [(key=? (ww-direction cw) "left") ... ]
    [(key=? (ww-direction cw) "right") ... ]
    [else cw]))

; WW KeyEvent -> WW
; updates the state of the WW upon a Key Event
(define (key-h cw ke)
  (cond
    [(key=? ke "up") (if (not (key=? (ww-direction cw) "down")) (make-ww (ww-worm cw) ke) cw)]
    [(key=? ke "down") (if (not (key=? (ww-direction cw) "up")) (make-ww (ww-worm cw) ke) cw)]
    [(key=? ke "left") (if (not (key=? (ww-direction cw) "right")) (make-ww (ww-worm cw) ke) cw)]
    [(key=? ke "right") (if (not (key=? (ww-direction cw) "left")) (make-ww (ww-worm cw) ke) cw)]
    [else cw]))

; WW -> Image
; renders the current state of the WW
(define (render cw) (render-worm (ww-worm cw)))

(define (main-worm rate)
  (big-bang WW1
    [on-tick tock]
    [on-draw render]
    [on-key key-h]
    ))