;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname ex-272) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp")) #f)))
; [List-of Number] [List-of Number] -> [List-of Number]
; append the second list to the first
(check-expect (append-from-foldr '(1 2 3) '(4 5 6)) (list 1 2 3 4 5 6))
(check-expect (append-from-foldr '(1 2 3) '()) (list 1 2 3))
(define (append-from-foldr l1 l2)
  (foldr cons l2 l1))

; [List-of Number] [List-of Number] -> [List-of Number]
; append the second list to the first
(check-expect (append-from-foldl '(1 2 3) '(4 5 6)) (list 3 2 1 4 5 6))
(check-expect (append-from-foldl '(1 2 3) '()) (list 3 2 1))
(check-expect (append-from-foldl '(1 2 3) '(5)) (list 3 2 1 5))
(define (append-from-foldl l1 l2)
  (foldl cons l2 l1))

; [List-of Number] [List-of Number] -> [List-of Number]
; compute the sum of a list of numbers
(check-expect (sum-from-foldl '(1 2 3 4 5)) (+ 1 2 3 4 5))
(define (sum-from-foldl l)
  (foldl + 0 l))

; [List-of Number] [List-of Number] -> [List-of Number]
; compute the sum of a list of numbers
(check-expect (product-from-foldl '(1 2 3 4 5)) (* 1 2 3 4 5))
(define (product-from-foldl l)
  (foldl * 1 l))

; [List-of Image] -> Image
; horizontally compose a list of Images
(check-expect
 (beside-from-fold
               (list (ellipse 20 70 "solid" "gray")
                     (ellipse 20 50 "solid" "darkgray")
                     (ellipse 20 30 "solid" "dimgray")
                     (ellipse 20 10 "solid" "black")))
 (beside (ellipse 20 70 "solid" "gray")
                      (ellipse 20 50 "solid" "darkgray")
                      (ellipse 20 30 "solid" "dimgray")
                      (ellipse 20 10 "solid" "black")))
(define (beside-from-fold l)
  (foldr beside empty-image l))

; [List-of Image] -> Image
; vertically compose a list of Images
(check-expect (above-from-fold
               (list (ellipse 70 20 "solid" "gray")
                     (ellipse 50 20 "solid" "darkgray")
                     (ellipse 30 20 "solid" "dimgray")
                     (ellipse 10 20 "solid" "black")))
              (above (ellipse 70 20 "solid" "gray")
                     (ellipse 50 20 "solid" "darkgray")
                     (ellipse 30 20 "solid" "dimgray")
                     (ellipse 10 20 "solid" "black")))
(define (above-from-fold l)
  (foldr above empty-image l))