;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname ex-226) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
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
