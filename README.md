# htdp
## Tools at my disposal
- The MVC model
- Recursion for lists and much more
- Predicates and function specification
- Higher order functions: map, filter, fold, andmap, andor. Terrific for typical yet complex behavior on lists.
- Passing functions as values, allowing for abstraction. I can now 'transport' the name of a function as a symbol when defining a function, and then be interpreted as a function on runtime.
- Anonymous functions. Good for one-liners in higher-order functions, or currying
- Scope. With this, I can:
  - Curry a function (including a predicate)
  - Increase performance via local definitions
- For/... loops for parallel processing of 1 to n lists. Depending on the construct used, its either until the shortest one is exhausted, or essentially doing a sort of cartesian product and then folding everything in a single list
  - The use of ranges and generators of natural numbers in order to traverse a list at a specific 'stepping rhythm', or to keep generating numbers for as long as a I iterate
- Pattern matching. Hella useful for structures, and a time saver if it's a list of them. You only need to match the contour of the thing you want to check. The iteration gets taken care of with a loop. See:
```scheme
;[List-of [List-of String]] -> [List-of Number]
(check-expect (words-on-line (list (list "a" "b" "c") (list "d" "e") (list "f"))) (list 3 2 1))
(define (words-on-line llos)
  (for/list ([l llos])
    (match l
      [los (length los)])))
```
