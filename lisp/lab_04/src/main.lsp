#(
  (setf lst1 '(a b))
  (setf lst2 '(c d))
  (cons lst1 lst2)   ; ((a b) c d)
  (list lst1 lst2)   ; ((a b) (c d))
  (append lst1 lst2) ; (a b c d)
)

#(
  (reverse ())         ; nil
  (last ())            ; nil
  (reverse '(a))       ; (a)
  (last '(a))          ; (a)
  (reverse '((a b c))) ; ((a b c))
)

(defun last-recursive (lst)
  (if (cdr lst)
       (last-recursive (cdr lst))
       (car lst)))

(defun int-last-recursive-2 (lst el)
  (if (eql nil lst)
      el
      (last-recursive-2 (cdr lst) (car lst))))
(defun my-last-recursive-2 (lst)
  (int-last-recursive-2 lst nil))

(defun last-reduce (lst)
  (reduce #'(lambda (acc e) e) lst))

(defun no-last-int (lst acc)
  (if (cdr lst)
      (no-last-int (cdr lst) (cons (car lst) acc))
      (nreverse acc)))

(defun no-last (lst)
  (and lst (no-last-int lst nil)))

(defun no-last-kernel (lst)
  (and lst (nreverse (cdr (reverse lst)))))
