;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname ex-221-tetris-main) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/universe)
(require 2htdp/image)

;; Constants
(define HEIGHT 100)
(define WIDTH 10) ; # of blocks, horizontally 
(define SIZE 10) ; blocks are squares
(define SCENE-SIZE (* WIDTH SIZE))
(define BLOCK ; red squares with black rims
  (overlay
   (square (- SIZE 1) "solid" "red")
   (square SIZE "outline" "black")))
(define BACKGROUND (empty-scene WIDTH HEIGHT))
(define RATE 0.5)

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
(define block-dropping0 (make-block 1 1))
(define block-landed (make-block 1 (- HEIGHT 1)))
(define block-on-block (make-block 2 (- HEIGHT 2)))
(define block-on-block-on-block (make-block 0 (- HEIGHT 3)))
(define landscape0 (list (make-block 4 10) (make-block 2 10) block-landed))
(define tetris0 (make-tetris block-dropping0 landscape0))
(define tetris0-drop (make-tetris '() landscape0))

;; Helper functions
; TODO: for now, blocks are rendered outside of the scene.
; Mechanisms must be put in place to avoid errors in rendering: no half blocks, etc
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
    ))

; Tetris -> Boolean
; checks wether a block has landed
(define (block-landed? tetris)
  (block-landed-on-landscape? (tetris-block tetris) (tetris-landscape tetris)))

; Block Landscape -> Boolen
; checks wether a block has landed on the landscape
(define (block-landed-on-landscape? block landscape)
  (or (block-grounded? block) (block-on-block? block landscape)))

; Block -> Boolean
; checks wether a block landed on the ground
(define (block-grounded? block)
  (if (>= (block-y block) (- (- HEIGHT (/ SIZE 2)) 1)) #true #false)) ; beware of magic number here

; Block Block -> Boolean
; checks wether a block landed on another block
(define (block-on-block? block landscape)
  (member? (make-block (block-x block) (+ (+ (block-y block) SIZE) 1)) landscape)) ; beware of magic number here

; Block -> Block
; ??? (adapted from food-create on ex 219)
(check-satisfied (block-generate (make-block 1 1)) not=-1-1?)
(define (block-generate block)
  (block-check-generate
   block (make-block (random WIDTH) 0)))

; Block Block -> Block
; generative recursion
; ???
(define (block-check-generate block candidate)
  (if (equal? block candidate) (block-generate block) candidate))

; Block -> Boolean
; use for testing only
(define (not=-1-1? block)
  (not (and (= (block-x block) 1) (= (block-y block) 1))))

;; World functions
; Tetris -> Tetris
; updates the state of a Tetris game per CPU clock tick
(define (tetris-tock tetris)
  (if (block-landed? tetris)
      (make-tetris (block-generate (tetris-block tetris)) (cons (tetris-block tetris) (tetris-landscape tetris)))
      (make-tetris (make-block (block-x (tetris-block tetris)) (add1 (block-y (tetris-block tetris)))) (tetris-landscape tetris))))

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
    [(or (key=? "right" ke) (key=? "left" ke) (key=? "down" ke)) (make-tetris (move-block (tetris-block tetris) ke) (tetris-landscape tetris))]
    [else tetris]))

; WorldState -> WorldState
; world program
(define (tetris-main rate)
  (big-bang tetris0
    [on-tick tetris-tock rate]
    [on-draw tetris-render]
    [on-key tetris-key-h]
    [state #t]
    ))