#(
  (list 'a c)                     ; unbound variable : 'c
  (cons 'a (b c))                 ; unbound variable : '(b c)
  (cons 'a '(b c))                ; (A B C)
  (caddy (1 2 3 4 5))             ; illegal funtion call
  (cons 'a 'b' c)                 ; invalid number of arguments 3
  (list 'a (b c))                 ; unbound variable : 'b
  (list a '(b c))                 ; unbound variable : 'a
  (list (+ 1 '(length '(1 2 3)))) ; -> type error
)

(defun calc-triangle-hyp (x y)
  (sqrt (+ (* x x) (* y y))))

(defun calc-par-vol (x y z)
  (* x y z))

(defun longer-then (a b)
  (> (length a) (length b)))

#(
  (cons 3 (list 5 6))                             ; (3 5 6)
  (list 3 'from 9 'gives (- 9 3))                 ; (3 FROM 9 GIVES 6)
  (+ (length '(1 foo 2 too)) (car '(21 22 23)))   ; 25
  (cdr '(cons is short for ans))                  ; (IS SHORT FOR ANS)
  (car (list one two))                            ; VARIABLE ONE IS UNBOUND
  (cons 3 '(list 5 6))                            ; (3 LIST 5 6)
  (car (list 'one 'two))                          ; ONE
) 

(defun mystery (x)
  (list (second x) (first x)))

#(
  (mystery '(one two))        ; (TWO ONE)
  (mystery 'free)             ; The value FREE is not of type LIST
  (mystery (last 'one 'two))  ; The value ONE is not of type LIST when binding LIST
  (mystery 'one 'two)         ; INVALID NUMBER OF ARGUMENTS: 2
)

(defun f-to-c (temp) 
  (* (/ 5 9) (- temp 32.0)))

#(
  (list 'cons t NIL)                  ; (CONS T NIL)
  (eval (eval (list 'cons t NIL)))    ; The function T is undefined, and its name is reserved by ANSI CL
  (apply #'cons '(t NIL))             ; (T)
  (list 'eval NIL)                    ; (EVAL NIL)
  (eval (list 'cons t NIL))           ; (T)
  (eval NIL)                          ; NIL
  (eval (list 'eval NIL))             ; NIL
)

(defun calc-cathet (hyp cath)
  (sqrt (- (* hyp hyp) (* cath cath))))

(defun calc-trapezium-square (a b h)
  (* (/ (+ a b) 2.0) h))

