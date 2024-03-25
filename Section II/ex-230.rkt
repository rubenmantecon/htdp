;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname ex-230) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/universe)
(require 2htdp/image)

(define SQUARE-SIDE 150)

; A Transition.v3 is a structure:
(define-struct transition [current key next])
; (make-transition FSM-State KeyEvent FSM-State)
(define transition0 (make-transition "white" "a" "yellow"))
(define transition1 (make-transition "yellow" "b" "yellow"))
(define transition2 (make-transition "yellow" "c" "yellow"))
(define transition3 (make-transition "yellow" "d" "red"))

; A LOT is one of: 
; – '() 
; – (cons Transition.v3 LOT)
(define lot0 (list transition0 transition1 transition2 transition3))

; An FSM.v2 is a structure:
(define-struct fsm [initial transitions final])
; (make-fsm FSM-State LOT FSM-State)
(define fsm0 (make-fsm transition0 lot0 transition3))

; Transition.v3 -> Transition.v3
; make the next transition
(check-expect (next-state (make-transition "white" "a" "yellow") "a") (make-transition "yellow" "b" "yellow"))
(check-expect (next-state (make-transition "white" "a" "yellow") "d") (make-transition "red" "d" "red"))
(check-expect (next-state (make-transition "yellow" "b" "yellow") "b") (make-transition "yellow" "b" "yellow"))
(check-expect (next-state (make-transition "yellow" "b" "yellow") "c") (make-transition "yellow" "c" "yellow"))
(check-expect (next-state (make-transition "yellow" "c" "yellow") "b") (make-transition "yellow" "b" "yellow"))
(check-expect (next-state (make-transition "yellow" "c" "yellow") "c") (make-transition "yellow" "c" "yellow"))
(check-expect (next-state (make-transition "yellow" "b" "yellow") "d") (make-transition "red" "d" "red"))
(check-expect (next-state (make-transition "yellow" "c" "yellow") "d") (make-transition "red" "d" "red"))
(define (next-state transition ke)
    (cond
      [(and (key=? ke "a") (string=? (transition-current transition) "white")) (make-transition (transition-next transition) "b" "yellow")]
      [(and (or (key=? ke "b") (key=? ke "c")) (string=? (transition-current transition) "yellow")) (make-transition (transition-next transition) ke "yellow")]
      [else (make-transition "red" ke "red")]
      ))

; Transition.v3 -> Image
; render the current state
(define (render-state transition) (square SQUARE-SIDE "solid" (transition-current transition)))

; Transition.v3 -> Boolean
; check whether the final state has been reached
(define (final-state? transition) (if
                                   (or
                                    (string=? "red" (transition-current transition))
                                    (string=? "red" (transition-next transition)))
                                   #true
                                   #false))

; Transition.v3 -> Image
; render the final state
(define (render-final-state transition)
  (place-image
   (text "safe state reached" 12 "black")
   (/ SQUARE-SIDE 2)
   (/ SQUARE-SIDE 2)
   (render-state transition)))

; FSM.v2 -> FSM.v2
; main program
(define (fsm-simulate fsm.v2)
  (big-bang (fsm-initial fsm.v2)
    [to-draw render-state]
    [on-key next-state]
    [stop-when final-state? render-final-state]))