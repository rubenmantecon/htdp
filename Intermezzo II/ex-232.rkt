#lang racket
(list 1 "a" 2 #false 3 "c")
(list (list "alan" (* 2 500))
      (list "barb" 2000)
      (list (string-append "carl" " , the great") 1500)
      (list "dawn" 2300))
(define title "ratings")
(list 'html
      (list 'head (list 'title "ratings"))
      (list 'body (list 'h1 "ratings"))
      (list 'p "A second web page"))
