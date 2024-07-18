;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname ex-298) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
;; Exercise 298. Design my-animate.
;; Recall that the animate function consumes the representation of a stream of images, one per natural number.
;; Since streams are infinitely long, ordinary compound data cannot represent them. Instead, we use functions: 
;
; An ImageStream is a function: 
;   [N -> Image]
; interpretation a stream s denotes a series of images

; ImageStream
(define (create-square-scene height)
  (place-image (square 10 10 "red") 50 height (empty-scene 60 60)))

; Number -> Number
(define (tock height) (add1 height))

; Number -> Boolean
(define (end? height) (= height 50))

; ImageStream
(define (render-end height) (place-image (text "End State" 12 "red") 30 30 (create-square-scene height)))

(define (my-animate n)
  (big-bang 10
    [on-draw create-square-scene]
    [on-tick tock]
    [stop-when end? render-end]
    ))

; I'm unsure I've grasped it correctly, in all honesty