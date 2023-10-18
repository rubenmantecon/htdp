;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname 12.2-real-world-data-itunes) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp")) #f)))
; 12.2 Real-World Data: iTunes
 
; An LTracks is one of:
; – '()
; – (cons Track LTracks)

(define ITUNES-LOCATION "itunes-summarized.xml")
 
; LTracks
(define itunes-tracks
  (read-itunes-as-tracks ITUNES-LOCATION))

; LLists
(define itunes-lists
  (read-itunes-as-lists ITUNES-LOCATION))

; Ex 199

(define LINUX-EPOCH (create-date 1970 1 1 0 0 0))
(define TODAY (create-date 2023 10 16 9 15 34))
(define SOMEDAY (create-date 2022 1 22 23 02 17))
(define TIME (create-track "Time" "Pink Floyd" "The Dark Side of the Moon" 413000 4 SOMEDAY 27 TODAY))
(define MONEY (create-track "Money" "Pink Floyd" "The Dark Side of the Moon" 382000 6 SOMEDAY 19 TODAY))
(define SELFLESS (create-track "Selfless" "The New Abnormal" "The Strokes" 222000 3 SOMEDAY 34 TODAY))
(define LTRACKS (list TIME MONEY SELFLESS))

; Ex 200

; LTracks -> Number
; consumes an element of LTracks and computes the total play time of it
(define (total-time ltracks)
  (cond
    [(empty? ltracks) 0]
    [else (+ (track-time (first ltracks)) (total-time (rest ltracks)))]))

(check-expect (total-time LTRACKS) (+ 413000 382000 222000))

; Ex 201
; LTracks -> List-of-strings
(define (select-all-album-titles ltracks)
  (cond
    [(empty? ltracks) '()]
    [else (cons (track-album (first ltracks)) (select-all-album-titles (rest ltracks)))]))

(check-expect (select-all-album-titles LTRACKS) (list
                                                 "The Dark Side of the Moon"
                                                 "The Dark Side of the Moon"
                                                 "The Strokes"))

; List-of-string -> List-of-strings
; constructs a List-of-string that contains every String from the given list, exactly once
(define (create-set los)
  (cond
    [(empty? los) '()]
    [else (if (member? (first los) (rest los))
              (create-set (rest los))
              (cons (first los) (create-set (rest los))))]))

(check-expect (create-set (list "well" "hello" "there")) (list "well" "hello" "there"))
(check-expect (create-set (list "well" "hello" "there" "hello")) (list "well" "there" "hello"))

; LTracks -> List-of-strings
; produce a list of unique album titles
(define (select-album-titles/unique ltracks)
  (cond
    [(empty? ltracks) '()]
    [else (if (member? (first ltracks) (rest ltracks))
              (select-album-titles/unique (rest ltracks))
              (cons (first ltracks) (select-album-titles/unique (rest ltracks))))]))

(check-expect (select-album-titles/unique LTRACKS) LTRACKS)
(check-expect (select-album-titles/unique (list TIME SELFLESS TIME MONEY TIME MONEY)) (list SELFLESS TIME MONEY))

;; Ex 202

; String LTracks -> List-of-strings
; Given an album title, it extracts from an LTracks a list of its tracks
(define (select-album title ltracks)
  (cond
    [(empty? ltracks) '()]
    [else (if (string=? title (track-album (first ltracks)))
              (cons (first ltracks) (select-album title (rest ltracks)))
              (select-album title (rest ltracks)))]))

(check-expect (select-album "A Day Without Rain" itunes-tracks) (list
                                                                 (create-track
                                                                  "Wild Child"
                                                                  "Enya"
                                                                  "A Day Without Rain"
                                                                  227996
                                                                  2
                                                                  (create-date 2002 7 17 3 55 14)
                                                                  20
                                                                  (create-date 2011 5 17 17 35 13))
                                                                 (create-track
                                                                  "Only Time"
                                                                  "Enya"
                                                                  "A Day Without Rain"
                                                                  218096
                                                                  3
                                                                  (create-date 2002 7 17 3 55 42)
                                                                  18
                                                                  (create-date 2011 5 17 17 38 47))
                                                                 (create-track
                                                                  "Tempus Vernum"
                                                                  "Enya"
                                                                  "A Day Without Rain"
                                                                  144326
                                                                  4
                                                                  (create-date 2002 7 17 3 56 33)
                                                                  19
                                                                  (create-date 2011 5 17 17 41 6))))

;; Ex 203

; String Date LTracks
; extracts the list of tracks that belong to the given album and have been played after the given date
(define (select-album-date title date ltracks)
  (cond
    [(empty? ltracks) '()]
    [else (if (date<? date (track-played (first ltracks)))
              (cons (first ltracks) (select-album-date title date (rest ltracks)))
              (select-album-date title date (rest ltracks)))]))

(check-expect (select-album-date "A Day Without Rain" TODAY itunes-tracks) '())
(check-expect (select-album-date "A Day Without Rain" LINUX-EPOCH itunes-tracks) (list
                                                                                  (create-track
                                                                                   "Wild Child"
                                                                                   "Enya"
                                                                                   "A Day Without Rain"
                                                                                   227996
                                                                                   2
                                                                                   (create-date 2002 7 17 3 55 14)
                                                                                   20
                                                                                   (create-date 2011 5 17 17 35 13))
                                                                                  (create-track
                                                                                   "Only Time"
                                                                                   "Enya"
                                                                                   "A Day Without Rain"
                                                                                   218096
                                                                                   3
                                                                                   (create-date 2002 7 17 3 55 42)
                                                                                   18
                                                                                   (create-date 2011 5 17 17 38 47))
                                                                                  (create-track
                                                                                   "Tempus Vernum"
                                                                                   "Enya"
                                                                                   "A Day Without Rain"
                                                                                   144326
                                                                                   4
                                                                                   (create-date 2002 7 17 3 56 33)
                                                                                   19
                                                                                   (create-date 2011 5 17 17 41 6))))

; Date Date -> Boolean
; determine whether the first date occurs before the second
(define (date<? d1 d2)
  (cond
    [(and
      (< (date-year d1) (date-year d2))
      (< (date-month d1) (date-month d2))
      (< (date-day d1) (date-day d2))
      (< (date-hour d1) (date-hour d2))
      (< (date-minute d1) (date-hour d2))
      (< (date-second d1) (date-second d2))
      ) #true]
    [else #false]))
    

(check-expect (date<? LINUX-EPOCH TODAY) #true)
(check-expect (date<? TODAY SOMEDAY) #false)

;; Ex 204

; LTracks -> List-of-LTracks
; produces a list of LTracks, one per album
(define (select-albums* ltracks)
  (cond
    [(empty? ltracks) '()]
    [else (select-albums (select-all-album-titles ltracks) ltracks)]))

; List-of-strings LTracks -> LTracks
; takes a list of album titles, a list of tracks, and produces a list of LTracks, one list per album
(define (select-albums los ltracks)
  (cond
    [(empty? ltracks) '()]
    [(empty? los) '()]
    [else (if (string=? (first los) (track-album (first ltracks)))
              (cons (first ltracks) (select-albums los (rest ltracks)))
              (select-albums (rest los) ltracks))]))
;;(define-struct track
;;  [name artist album time track# added play# played])

;; Ex 205
(define LASSOC1 (list
                 (list "Name" "Song 1")
                 (list "Artist" "Artist 1")
                 (list "Album" "Album 1 from Artist 1")
                 (list "Total Time" 589000)
                 (list "Track#" 1)
                 (list "Added" (create-date 2022 7 12 9 12 16))
                 (list "Play#" 13)
                 (list "Played" (create-date 2023 1 1 23 59 59))
                 (list "Favorite?" #true)))

(define LASSOC2 (list
                 (list "Name" "Song 2")
                 (list "Artist" "Artist 1")
                 (list "Album" "Album 1 from Artist 1")
                 (list "Total Time" 288000)
                 (list "Track#" 2)
                 (list "Added" (create-date 2022 7 12 9 12 16))
                 (list "Play#" 9)
                 (list "Played" (create-date 2023 1 2 12 13 37))
                 (list "Favorite?" #false)))

(define LASSOC3 '(("Name" "Song 9")
                  ("Artist" "Artist 2")
                  ("Album" "Album 1 from Artist 2")
                  ("Total Time" 367000)
                  ("Track" 9)
                  ("Added" (create-date 2021 9 23 15 2 34))
                  ("Play#" 28)
                  ("Played" (create-date 2022 6 19 20 14 1))
                  ("Starred?" #false)
                  ))

(define LASSOC4 '(("Name" "Song 10")
                  ("Artist" "Artist 2")
                  ("Album" "Album 1 from Artist 2")
                  ("Total Time" 987000)
                  ("Track" 10)
                  ("Added" (create-date 2021 9 23 15 2 34))
                  ("Play#" 28)
                  ("Played" (create-date 2022 6 20 21 14 14))
                  ("Starred?" #true)
                  ))

(define LLISTS1 (list LASSOC1 LASSOC2))
(define LLISTS2 (list LASSOC3 LASSOC4))
(define LLISTS3 (list LASSOC1 LASSOC2 LASSOC3 LASSOC4))

;; Ex 206

; String LAssoc Any -> AssociationOrAny
; produces the first Association from LAssoc whose first item is String, or produces Any
(define (find-association key lassoc default)
  (cond
    [(empty? lassoc) default]
    [else (if (string=? key (first (first lassoc)))
              (first lassoc)
              (find-association key (rest lassoc) default))]))

(check-expect (find-association "Track" '() "Not found") "Not found")
(check-expect (find-association "Name" LASSOC4 #false) '("Name" "Song 10"))
(check-expect (find-association "neim" LASSOC4 #false) #false)
(check-expect (find-association "Track" LASSOC4 "Not found") '("Track" 10))
(check-expect (find-association "track" LASSOC4 "Not found") "Not found")

;; Ex 207

; LLists -> Number
; produce the total play time for a list of albums
(define (total-time/lists llists)
  (cond
    [(empty? llists) 0]
    [else  (+ (second (assoc "Total Time" (first llists))) (total-time/lists (rest llists)))]))

(check-expect (total-time/lists LLISTS1) (+ 589000 288000) )
(check-expect (total-time/lists LLISTS3) (+ 589000 288000 367000 987000))

;; Ex 208

; LLists -> List-of-strings
; produce a list of unique strings that contain that are associated with a Boolean attribute
(define (boolean-attributes llists)
  (cond
    [(empty? llists) '()]
    [else  (create-set (cons (first (boolean-attributes/inner (first llists))) (boolean-attributes (rest llists))))]))

(check-expect (boolean-attributes LLISTS1) '("Favorite?"))
(check-expect (boolean-attributes LLISTS2) '("Starred?"))
(check-expect (boolean-attributes LLISTS3) '("Favorite?" "Starred?"))

; LAssoc -> List-of-strings
; produce a list of strings that contain that are associated with a Boolean attribute
(define (boolean-attributes/inner lassoc)
  (cond
    [(empty? lassoc) '()]
    [else (if (boolean? (second (first lassoc)))
              (cons (first (first lassoc)) (cons (second (first lassoc)) (boolean-attributes/inner (rest lassoc))))
              (boolean-attributes/inner (rest lassoc)))]))

(check-expect (boolean-attributes/inner LASSOC1) '("Favorite?" #true))

; LAssoc -> Track
; Convert an LAssoc to Track when possible
(define (track-as-struct track lassoc) '())