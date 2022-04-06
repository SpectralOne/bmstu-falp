(defun my-reverse (lst &optional (acc nil))
  (if (null lst)
      acc
      (my-reverse (rest lst) (cons (first lst) acc))))

(defun first-sublist (lst)
  (and lst (if (listp (car lst))
               (car lst)
               (first-sublist (cdr lst)))))

(defun select-between (from to lst &optional (acc nil))
  (if (null lst)
      (sort acc #'<)
      (let ((head (car lst)))
        (if (and (< head to) (> head from))
            (select-between from to (cdr lst) (cons head acc))
            (select-between from to (cdr lst) acc)))))

(defun rec-add (lst &optional (acc 0))
  (if (null lst)
      acc
      (rec-add (cdr lst) (+ acc (car lst)))))

(defun recnth (n lst)
  (and lst (if (zerop n)
               (car lst)
               (recnth (- n 1) (cdr lst)))))

(defun allodd (lst)
  (or (null lst)
      (and (oddp (car lst))
           (allodd (cdr lst)))))

(defun square (lst)
  (and lst (cons ((lambda (x) (* x x)) (car lst))
                 (square (cdr lst)))))
