;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 10.4-a-graphical-editor-revisited) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
; 10.4 A Graphical Editor, Revisited

(define-struct editor [pre post])
; An Editor is a structure:
;   (make-editor Lo1S Lo1S)

; An Lo1S is one of: 
; – '()
; – (cons 1String Lo1S)

; Lo1s -> Lo1s 
; produces a reverse version of the given list 
(check-expect
 (rev (cons "a" (cons "b" (cons "c" '()))))
 (cons "c" (cons "b" (cons "a" '()))))
 
(define (rev l)
  (cond
    [(empty? l) '()]
    [else  (add-at-end (rev (rest l)) (first l))]))

; Lo1s 1String -> Lo1s
; creates a new list by adding s to the end of l
(check-expect
 (add-at-end (cons "c" (cons "b" '())) "a")
 (cons "c" (cons "b" (cons "a" '()))))

(check-expect (add-at-end '() "") (cons "" '()))
 
(define (add-at-end l s)
  (cond
    [(empty? l) (cons s '())]
    [(cons? l) (cons (first l) (add-at-end (rest l) s))]))

; Ex 177

(define HEIGHT 20) ; the height of the editor 
(define WIDTH 200) ; its width 
(define FONT-SIZE 16) ; the font size 
(define FONT-COLOR "black") ; the font color 
 
(define MT (empty-scene WIDTH HEIGHT))
(define CURSOR (rectangle 1 HEIGHT "solid" "red"))

; String String -> Editor
; produce and Editor whose fields are s1 and s2
(define (create-editor s1 s2)
  (make-editor (rev (explode s1))  (explode s2)))

; Lo1s -> Image
; renders a list of 1Strings as a text image 
(define (editor-text s)
  (text (implode s) FONT-SIZE FONT-COLOR))

; Editor -> Image
; renders an editor as an image of the two texts 
; separated by the cursor 
(define (editor-render e)
  (place-image/align
    (beside (editor-text (editor-pre e))
            CURSOR
            (editor-text (editor-post e)))
    1 1
    "left" "top"
    MT))

; Editor KeyEvent -> Editor
; deals with a key event, given some editor
(define (editor-kh ed k)
  (cond
    [(key=? k "left") (editor-left ed)]
    [(key=? k "right") (editor-right ed)]
    [(key=? k "\b") (editor-del ed)]
    [(key=? k "\t") ed]
    [(key=? k "\r") ed]
    [(= (string-length k) 1) (editor-ins ed k)]
    [else ed]))

; Editor -> Editor
; produces an editor with the cursor shifted one position to the right,
; if possible
(define (editor-right ed)
  (cond
    [(empty? (editor-post ed)) ed]
    [else (make-editor (add-at-end (editor-pre ed) (first (editor-post ed)))
                       (rest (editor-post ed)))]
    ))

(check-expect (editor-right (make-editor (cons "hey, joe" '()) '()))
              (make-editor (cons "hey, joe" '()) '()))


(check-expect (editor-right (make-editor (cons "h" (cons "e" (cons "y" '())))
                                         (cons "J" (cons "o" (cons "e" '())))))
              (make-editor (cons "h" (cons "e" (cons "y" (cons "J" '()))))
                           (cons "o" (cons "e" '()))))



; Editor -> Editor
; produces an editor with the cursor shifted one position to the left,
; if possible
(define (editor-left ed)
  (cond
    [(empty? (editor-pre ed)) ed]
    [else (make-editor (rev (rest (rev (editor-pre ed))))
                       (cons (first (rev (editor-pre ed))) (editor-post ed)))]))

(check-expect (editor-left (make-editor '()
                                        (cons "hey, joe" '())))
              (make-editor '()
                           (cons "hey, joe" '())))

(check-expect (editor-left (make-editor (cons "h" (cons "e" (cons "y" '())))
                                        (cons "J" (cons "o" (cons "e" '())))) )
              (make-editor (cons "h" (cons "e" '()))
                           (cons "y" (cons "J" (cons "o" (cons "e" '()))))))
 

; Editor -> Editor
; deletes one character at the cursor position
(define (editor-del ed)
  (cond
    [(empty? (editor-pre ed)) ed]
    [else (make-editor (rev (rest (rev (editor-pre ed)))) (editor-post ed))]))


(check-expect (editor-del (make-editor (cons "h" (cons "e" (cons "y" '())))
                                        (cons "J" (cons "o" (cons "e" '())))) )
              (make-editor (cons "h" (cons "e" '()))
                           (cons "J" (cons "o" (cons "e" '())))))

; Editor 1String -> Editor
; inserts the 1String in (editor-post ed)
(define (editor-ins ed k)
  (make-editor (cons k (editor-pre ed))
               (editor-post ed)))

(check-expect
 (editor-ins (make-editor '() '()) "e")
 (make-editor (cons "e" '()) '()))
 
(check-expect
 (editor-ins
  (make-editor (cons "d" '())
               (cons "f" (cons "g" '())))
  "e")
 (make-editor (cons "e" (cons "d" '()))
              (cons "f" (cons "g" '()))))


; Ex 180
(define (editor-text-ni s)
  (text ...))

; main : String -> Editor
; launches the editor given some initial string 
(define (main s)
  (big-bang (create-editor s "")
    [on-key editor-kh]
    [to-draw editor-render]))

