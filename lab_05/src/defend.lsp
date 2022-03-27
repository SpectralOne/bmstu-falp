(ql:quickload "fiveam")

(in-package :cl-user)
(defpackage defend
  (:use :cl
   :fiveam))
(in-package :defend)

(defun my-reverse (lst &optional (reversed '()))
  (if (endp lst)
      reversed
      (my-reverse (rest lst)
                  (list* (first lst)
                         reversed))))

(defun swap-two (n1 n2 lst &optional (f nil) (s nil))
  (cond ((null lst) lst)
        ((null f) (swap-two n1 n2 lst (nth n1 lst)))
        ((null s) (swap-two n1 n2 lst (nth n1 lst) (nth n2 lst)))
        (T (progn
             (setf (nth n1 lst) s)
             (setf (nth n2 lst) f)
             lst))))

(defmacro ->> (initial-form &rest forms)
  (reduce #'(lambda (acc next)
              (if (listp next)
                  (append next (list acc))
                  (list next acc)))
          forms
          :initial-value initial-form))

(defun solve (players)
  (and players
       (if (< (length players) 3)
           (->> (sort players #'< :key #'(lambda (x) (cadr x)))
                last
                cadar)
           (let* ((sorted (sort players #'< :key #'(lambda (x) (cadr x))))
                  (speeds (map 'list #'cadr sorted))
                  (cnt (length speeds))
                  (idxes (loop for i from (1- cnt) downto 1 by 2 collect i))
                  (delta (if (= 1 (car (last idxes)))
                             (nth 1 speeds)
                             (+ (nth 0 speeds) (nth 1 speeds) (nth 2 speeds)))))
             (->> (butlast idxes)
                  (mapcar #'(lambda (i)
                              (min (+ (nth i speeds) (nth (1- i) speeds) (* 2 (nth 0 speeds)))
                                   (+ (nth i speeds) (nth 0 speeds) (* 2 (nth 1 speeds))))))
                  (reduce #'+)
                  (+ delta))))))

(test defend
  (is (equal 17
             (solve '(("1" 2) ("2" 10) ("3" 5)))))

  (is (equal nil (solve '())))

  (is (equal 2
             (solve '(("1" 1) ("2" 2)))))

  (is (equal 1
             (solve '(("1" 1)))))

  (is (equal 106
             (solve '(("1" 1) ("2" 2) ("3" 99) ("4" 99))))))

(run! 'defend)
