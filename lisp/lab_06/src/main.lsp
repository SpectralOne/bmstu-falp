(defun substract-10 (lst)
  (mapcar #'(lambda (x) (- x 10)) lst))

(defun mult-all (multiplier lst)
  (mapcar #'(lambda (x) (* x multiplier)) lst))

(defun mult-all-nested (multiplier lst)
  (mapcar #'(lambda (x)
              (if (listp x)
                  (mult-all-nested multiplier x)
                  (* x multiplier)))
          lst))

(defun squares (lst)
  (mapcar #'(lambda (x) (* x x)) lst))

(defun select-between (from to lst)
  (sort (mapcan #'(lambda (x)
                    (and (>= x from) (<= x to) (list x)))
                lst)
         #'<))

(defun decart-mult (a b)
  (mapcan #'(lambda (outer)
              (mapcar #'(lambda (inner)
                          (count outer inner))
                      b))
          a))

(defun length! (lol)
  (reduce #'(lambda (acc x)
              (+ acc (length x)))
          (cons 0 lol)))
