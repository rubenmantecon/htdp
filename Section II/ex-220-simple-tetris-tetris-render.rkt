;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname ex-220-simple-tetris-tetris-render) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
;; Constants
(define HEIGHT 200)
(define WIDTH 150) ; # of blocks, horizontally 
(define SIZE 15) ; blocks are squares
(define SCENE-SIZE (* WIDTH SIZE))
(define BLOCK ; red squares with black rims
  (overlay
    (square (- SIZE 1) "solid" "red")
    (square SIZE "outline" "black")))
(define BACKGROUND (empty-scene WIDTH HEIGHT))

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
(define landscape0 (list (make-block 0 (- HEIGHT)) (make-block (/ SIZE 2) (- HEIGHT (* 2 SIZE))) (make-block (/ SIZE 2) (- HEIGHT (* 3 SIZE)))))
(define block-dropping0 (make-block 2 2))
(define tetris0 (make-tetris block-dropping0 landscape0))
(define tetris0-drop (make-tetris '() landscape0))
(define block-landed (make-block 0 (- HEIGHT 1)))
(define block-on-block (make-block 0 (- HEIGHT 2)))
(define block-on-block-on-block (make-block 0 (- HEIGHT 3)))

;; Helper functions
; Tetris -> Image
; renders a tetris instance
(define (tetris-render tetris)
  (place-image
   BLOCK
   (* (block-x (tetris-block tetris)) SIZE)
   (* (block-y (tetris-block tetris)) SIZE)
   (render-landscape (tetris-landscape tetris))))

; Landscape -> Image
; renders a landscape
(define (render-landscape landscape)
  (cond
    [(empty? landscape) BACKGROUND]
    [else (place-image
           BLOCK
           (block-x (first landscape))
           (block-y (first landscape))
           (render-landscape (rest landscape)))]))

; Block -> Image
; renders a block
(define (render-block block)
  (place-image
   BLOCK
   (* (block-x block) SIZE)
   (* (block-y block) SIZE)
   BACKGROUND))

;; World functions