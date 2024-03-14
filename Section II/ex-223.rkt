;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname ex-223) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/universe)
(require 2htdp/image)

;; Constants
(define HEIGHT 210)
(define WIDTH 110) ; # of blocks, horizontally 
(define SIZE 10) ; blocks are squares
(define SCENE-SIZE (* WIDTH SIZE))
(define BLOCK ; red squares with black rims
  (overlay
   (square (- SIZE 1) "solid" "red")
   (square SIZE "outline" "black")))
(define BACKGROUND (empty-scene WIDTH HEIGHT))
(define RATE 0.75)

;; Data definitions
(define-struct tetris [block landscape])
(define-struct block [x y])
; 
; A Tetris is a structure:
;   (make-tetris Block Landscape)
; (make-tetris b0 (list b1 b2 ...))
; interpretation: b0 is the dropping block, while b1, b2, and ... are resting
;
; A Landscape is one of: 
; – '() 
; – (cons Block Landscape)
; interpretation: the blocks that are already in the scene
;
; A Block is a structure:
;   (make-block N N)
; (make-block x y)
; interpretation: depicts a block whose left corner is (* x SIZE) pixels from the left and (* y SIZE) pixels from the top

;; Data collections
(define block-dropping0 (make-block 4 1))
(define block-landed (make-block 4 20))
(define block-on-block (make-block 2 (- HEIGHT 2)))
(define block-on-block-on-block (make-block 0 (- HEIGHT 3)))
(define landscape0 (list (make-block 4 10) (make-block 2 10) block-landed))
(define tetris0 (make-tetris block-dropping0 landscape0))
(define tetris0-drop (make-tetris '() landscape0))

;; Helper functions
; Landscape -> Image
; renders a landscape
(define (render-landscape landscape)
  (cond
    [(empty? landscape) BACKGROUND]
    [else (place-image
           BLOCK
           (* (block-x (first landscape)) SIZE)
           (* (block-y (first landscape)) SIZE)
           (render-landscape (rest landscape)))]))

; Block -> Image
; renders a block
(define (render-block block)
  (place-image
   BLOCK
   (* (block-x block) SIZE)
   (* (block-y block) SIZE)
   BACKGROUND))

; Block -> Block
; moves a block
(define (move-block block ke)
  (cond
    [(key=? "down" ke) (make-block (block-x block) (add1 (block-y block)))]
    [(key=? "left" ke) (make-block (sub1 (block-x block)) (block-y block))]
    [(key=? "right" ke) (make-block (add1 (block-x block)) (block-y block))]
    [else block]
    ))

; Tetris -> Boolean
; checks wether a block has landed somewhere
(define (block-landed? tetris)
  (or (block-grounded? (tetris-block tetris)) (block-on-block? (tetris-block tetris) (tetris-landscape tetris))))

; Tetris -> Boolean
; checks wether a block has hit a vertical limit
(define (block-hit? tetris ke)
  (or
   (block-at-width? (tetris-block tetris))
   (block-against-block? (tetris-block tetris) (tetris-landscape tetris) ke)))

; Block -> Boolean
; checks wether a block landed on the ground
(define (block-grounded? block)
  (if (>= (block-y block) (- (/ HEIGHT SIZE) 1)) #true #false)) ; beware of magic number here

; Block Block -> Boolean
; checks wether a block landed on another block
(define (block-on-block? block landscape)
  (member? (make-block (block-x block) (add1 (block-y block))) landscape))

; Block -> Boolean
; checks wether a block touched the limits of the scene
(define (block-at-width? block)
  (or (equal? (block-x block) SIZE) (equal? (block-x block) 1)))

; Block Block -> Boolean
; checks wether block is against the side of another
(define (block-against-block? block landscape direction)
  (or (and (key=? "right" direction) (member? (make-block (add1 (block-x block)) (block-y block)) landscape))
      (and (key=? "left" direction) (member? (make-block (sub1 (block-x block)) (block-y block)) landscape))))

; Block -> Block
; ??? (adapted from food-create on ex 219)
(check-satisfied (block-generate (make-block 1 1)) not=-1-1?)
(define (block-generate block)
  (block-check-generate
   block (make-block (list-ref (range 1 SIZE 1) (random (- SIZE 1))) 1)))

; Block Block -> Block
; generative recursion
; ???
(define (block-check-generate block candidate)
  (if (equal? block candidate) (block-generate block) candidate))

; Block -> Boolean
; use for testing only
(define (not=-1-1? block)
  (not (and (= (block-x block) 1) (= (block-y block) 1))))

; Tetris -> Boolean
; checks wether the end of the game has been reached
(define (end? tetris)
  (member? (make-block (block-x (tetris-block tetris)) 1) (tetris-landscape tetris)))

;; World functions
; Tetris -> Tetris
; updates the state of a Tetris game per CPU clock tick
(define (tetris-tock tetris)
  (cond
    [(block-landed? tetris) (make-tetris (block-generate (tetris-block tetris)) (cons (tetris-block tetris) (tetris-landscape tetris)))]
    [else (make-tetris (move-block (tetris-block tetris) "down") (tetris-landscape tetris))])
  )

; Tetris -> Image
; renders a tetris instance
(define (tetris-render tetris)
  (place-image
   BLOCK
   (* (block-x (tetris-block tetris)) SIZE)
   (* (block-y (tetris-block tetris)) SIZE)
   (render-landscape (tetris-landscape tetris))))

; Tetris KeyEvent -> Tetris
; updates the state of a Tetris game after an arrow key press
(define (tetris-key-h tetris ke)
  (cond
    [(block-hit? tetris ke) tetris]
    [else (make-tetris (move-block (tetris-block tetris) ke) (tetris-landscape tetris))]))

; WorldState -> WorldState
; world program
(define (tetris-main rate)
  (big-bang tetris0
    [on-tick tetris-tock rate]
    [on-draw tetris-render]
    [on-key tetris-key-h]
    [stop-when end?]
    [state #t]
    ))