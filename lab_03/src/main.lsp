#(
  "Task 1"
  (equal 3 (abs -3))
  (equal (+ 1 2) 3)
  (equal (* 4 7) 21)
  (equal (* 2 3) (+ 7 2))
  (equal (- 7 3) (* 3 2))
  (equal (abs (- 2 4)) 3)
  )

(defun calc-triangle-hyp (a b)
  "Task 2"
  (let* ((a-square (* a a))
         (b-square (* b b))
         (square-sum (+ a-square b-square)))
    (sqrt s)))

(defun calc-par-vol (a b h)
  "Task 3"
  (* a b h))

#(
  "Task 4"
  (list 'a 'b c)                  ; -> the variable C is unbound
  (cons 'a (b c))                 ; -> the variable C is unbound
  (cons 'a '(b c))                ; -> (a b c)
  (caddr (1 2 3 4 5))             ; -> illegal function call
  (cons 'a 'b 'c)                 ; -> invalid number of arguments: 3
  (list 'a (b c))                 ; -> the variable C is unbound
  (list a '(b c))                 ; -> the variable A is unbound
  (list (+ 1 '(length '(1 2 3)))) ; -> the value (LENGTH '(1 2 3)) is not of type NUMBER
  )

(defun longer-than (a b)
  "Task 5"
  (let ((len-a (length a))
        (len-b (length b)))
    (> len-a len-b)))

#(
  "Task 6"
  (cons 3 (list 5 6))                           ; -> (3 5 6)
  (list 3 'from 9 'gives (- 9 3))               ; -> (3 from 9 gives 6)
  (+ (length '(1 foo 2 too)) (car '(21 22 23))) ; -> 25
  (cdr '(cons is short for ans))                ; -> (is short for ans)
  (car (list one two))                          ; -> variable ONE is unbound
  (cons 3 '(list 5 6))                          ; -> (3 list 5 6)
  (car (list 'one 'two))                        ; -> one

  (defun mystery (x)
    (list (second x) (first x)))

  (mystery '(one two))       ; -> (two one)
  (mystery 'free)            ; -> the value FREE is not of type LIST
  (mystery (last 'one 'two)) ; -> the value ONE is not of type LIST when binding LIST
  (mystery 'one 'two)        ; -> invalid number of arguments: 2
  )

(defun f-to-c (temp)
  "Task 7"
  (float (* (- temp 32) (/ 5 9))))

#(
  "Task 8"
  (list 'cons T Nil)               ; -> (cons T Nil)
  (eval (eval (list 'cons T Nil))) ; -> undefined function
  (apply #'cons '(T Nil))          ; -> (T)
  (list 'eval Nil)                 ; -> (eval Nil)
  (eval (list 'cons T Nil))        ; -> (T)
  (eval Nil)                       ; -> Nil
  (eval (list 'eval Nil))          ; -> Nil
  )

(defun find-triangle-side (hyp side)
  "Extra 1"
  (let* ((hyp-square (* hyp hyp))
         (side-square (* side side))
         (square-sub (- hyp-square side-square)))
    (sqrt square-sub)))

