(defun first-even (n)
  "Task 1"
  (if (evenp n)
      n
      (+ num 1)))

(defun abs-greater (n)
  "Task 2"
  (if (> n 0)
      (+ n 1)
      (- n 1)))

(defun asc-pair-list (n1 n2)
  "Task 3 list"
  (if (> n1 n2)
      (list n1 n2)
      (list n2 n1)))

(defun asc-pair-cons (n1 n2)
  "Task 3 cons"
  (if (> n1 n2)
      (cons n1 (cons n2 nil))
      (cons n2 (const n1 nil))))

(defun is-mid (n1 n2 n3)
  "Task 4"
  (if (< n2 n1)
      (> n3 n1)
      (< n3 n1)))

#(
  "Task 5"
  (and 'fee 'fie 'foe)            ; -> FOE
  (or 'fee 'fie 'foe)             ; -> FEE
  (and (equal 'abc 'abc) 'yes)    ; -> YES
  (or nil 'fie 'foe)              ; -> FIE
  (and nil 'fie 'foe)             ; -> nil
  (or (equal 'abc 'abc) 'yes)     ; -> T
  )

(defun pred-is-ge (n1 n2)
  "Task 6"
  (>= n1 n2))

(defun pred1 (x)
  "Task 7 good"
  (and (numberp x) (plusp x)))

(defun pred2 (x)
  "Task 7 bad"
  (and (plusp x) (numberp x)))

(defun is-between-if (a b c)
  "Task 8 if"
  (if (and (> a b)
           (< a c))
      T
      Nil))

(defun is-between-cond (a b c)
  "Task 8 cond"
  (cond ((and (> a b)
              (< a c))
         T)
        (T Nil)))

(defun is-between-andor (a b c)
  "Task 8 and/or"
  (and (> a b)
       (< a c)))

(defun how-alike-cond (x y)
  "Task 9 cond"
  (cond ((or (= x y)
             (equal x y)) 'the_same)
        ((and (oddp x)
              (oddp y)) 'both_odd)
        ((and (evenp x)
              (evenp y)) 'both_even)
        (T 'difference)))

(defun how-alike-if (x y)
  "Task 9 if"
  (if (if (= x y)
          (equal x y))
      'the_same
 (if (if (oddp x)
         (oddp y))
     'both_odd
     (if (if (evenp x)
             (evenp y))
         'both_even
         'difference))))

(defun how-alike-andor (x y)
  "Task 9 andor"
  (or (and (or (= x y)
               (equal x y))
           'the_same)
      (and (oddp x)
           (oddp y)
           'both_odd)
      (and (evenp x)
           (evenp y)
           'both_even)
      'difference))
