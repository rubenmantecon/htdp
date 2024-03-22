;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname ex-228) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/universe)
(require 2htdp/image)

; An FSM is one of:
;   – '()
;   – (cons Transition FSM)
 
(define-struct transition [current next])
; A Transition is a structure:
;   (make-transition FSM-State FSM-State)
 
; FSM-State is a Color.
 
; interpretation An FSM represents the transitions that a
; finite state machine can take from one state to another 
; in reaction to keystrokes

(define fsm-traffic
  (list (make-transition "red" "green")
        (make-transition "green" "yellow")
        (make-transition "yellow" "red")))

; Transition -> Boolean
; checks if both FSM-State/Colors of a Transition are equal
(check-expect (state=? (make-transition "red" "green")) #false)
(check-expect (state=? (make-transition "green" "yellow")) #false)
(check-expect (state=? (make-transition "yellow" "red")) #false)
(check-expect (state=? (make-transition "red" "red")) #true)
(check-expect (state=? (make-transition "yellow" "yellow")) #true)
(check-expect (state=? (make-transition "green" "green")) #true)
(define (state=? transition) (string=? (transition-current transition) (transition-next transition)))


; A BW-Machine is one of:
; - '()
; - (cons BW-FSM-State BW-Machine)
; interpretation: a FSM that flips between black and white
;
; A BW-FSM-State is one of two Colors:
; - "Black"
; - "White"

(define-struct fs [fsm current])
; A SimulationState.v2 is a structure: 
;   (make-fs FSM FSM-State)

; SimulationState.v2 -> Image 
; renders current world state as a colored square 
(check-expect (state-as-colored-square
                (make-fs fsm-traffic "red"))
              (square 100 "solid" "red"))
(define (state-as-colored-square an-fsm)
  (square 100 "solid" (fs-current an-fsm)))


; SimulationState.v2 KeyEvent -> SimulationState.v2
; finds the next state from an-fsm and ke
(check-expect
  (find-next-state (make-fs fsm-traffic "red") "n")
  (make-fs fsm-traffic "green"))
(check-expect
  (find-next-state (make-fs fsm-traffic "red") "a")
  (make-fs fsm-traffic "green"))
(check-expect
  (find-next-state (make-fs fsm-traffic "green") "q")
  (make-fs fsm-traffic "yellow"))
(check-expect
 (find-next-state (make-fs fsm-traffic "yellow") "z")
 (make-fs fsm-traffic "red"))
(define (find-next-state an-fsm ke)
  (make-fs
    (fs-fsm an-fsm)
    (find (fs-fsm an-fsm) (fs-current an-fsm))))

; FSM FSM-State -> FSM-State
; finds the state representing current in transitions
; and retrieves the next field 
(check-expect (find fsm-traffic "red") "green")
(check-expect (find fsm-traffic "green") "yellow")
(check-error (find fsm-traffic "black")
             "not found: black")
(check-error (find fsm-traffic "white")
             "not found: white")
(define (find transitions current)
  (cond
    [(empty? transitions) (error (format "not found: ~a" current))]
    [else (if (equal? current (transition-current (first transitions)))
              (transition-next (first transitions))
              (find (rest transitions) current))]))

; FSM FSM-State -> SimulationState.v2 
; match the keys pressed with the given FSM 
(define (simulate.v2 an-fsm s0)
  (big-bang (make-fs an-fsm s0)
    [to-draw state-as-colored-square]
    [on-key find-next-state]))