(defun make-matrix (n m contents)
  (make-array (list n m) :initial-contents contents))

(defun make-constant-matrix (n m &optional (v 0))
  (make-array (list n m) :initial-element v))

(defun make-identity-matrix (n)
  (let ((initial (make-constant-matrix n n)))
    (loop for i from 0 to (1- n) do
      (setf (aref initial i i) 1))
    initial))

(defun make-identity (n v)
  (let ((initial (make-constant-matrix n n)))
    (loop for i from 0 to (1- n) do
      (setf (aref initial i i)
            v))
    initial))

(defun make-identityv (n v)
  (let ((initial (make-constant-matrix n n)))
    (loop for i from 0 to (1- n) do
      (setf (aref initial i i)
            (aref v i)))
    initial))

(defun mscale (m coeff)
  (let ((rows (array-dimension m 0)))
    (loop for i from 0 to (1- rows) do
      (loop for j from 0 to (1- rows) do
        (setf (aref m i j)
              (* (aref m i j) coeff))))
    m))

(defun get-minor (matrix del-row del-col)
  (let* ((rows   (array-dimension matrix 0))
         (cols   (array-dimension matrix 1))
         (nrows  (if del-row (1- rows) rows))
         (ncols  (if del-col (1- cols) cols))
         (newmat (make-constant-matrix nrows ncols)))
    (if (or (< nrows 1) (< ncols 1))
     (make-constant-matrix 1 1)
     (dotimes (row nrows newmat)
      (dotimes (col ncols)
        (setf (aref newmat row col)
              (aref matrix
                    (if (and del-row (>= row del-row)) (1+ row) row)
                    (if (and del-col (>= col del-col)) (1+ col) col))))))))

(defun det (matrix &optional (rows (array-dimension matrix 0)) &aux (acc 0))
  (cond
    ((eq rows 1)
     (aref matrix 0 0))

    ((eq rows 2)
     (let ((main-diag-prod (* (aref matrix 0 0)
                              (aref matrix 1 1)))
           (sec-diag-prod (* (aref matrix 1 0)
                             (aref matrix 0 1))))
       (- main-diag-prod sec-diag-prod)))

    (T
     (dotimes (row rows acc)
       (let ((minor (get-minor matrix 0 row))
             (sign (if (zerop (mod row 2)) 1 -1)))
         (setq acc (+ acc (* sign
                             (aref matrix 0 row)
                             (det minor)))))))))

(defun adj (matrix)
  (let* ((rows (array-dimension matrix 0))
         (adjoint (make-constant-matrix rows rows 1)))
    (if (= rows 1)
      adjoint
      (dotimes (row rows adjoint)
        (dotimes (col rows)
          (let* ((minor (get-minor matrix row col))
                 (sign (if (zerop (mod (+ row col) 2)) 1 -1))
                 (determinant (det minor)))
              (setf (aref adjoint col row)
                    (* sign determinant))))))))

(defun inv (matrix)
  (let* ((rows (array-dimension matrix 0))
         (inverse (make-constant-matrix rows rows))
         (adjoint (adj matrix))
         (determinant (det matrix)))
    (dotimes (row rows inverse)
      (dotimes (col rows)
        (setf (aref inverse row col)
              (/ (aref adjoint row col) determinant))))))

(defun mmul (A B)
  (let* ((m (array-dimension A 0))
         (n (array-dimension A 1))
         (l (array-dimension B 1))
         (C (make-constant-matrix m l)))
    (loop for i from 0 to (- m 1) do
      (loop for k from 0 to (- l 1) do
        (setf (aref C i k)
              (loop for j from 0 to (- n 1)
                    sum (* (aref A i j)
                           (aref B j k))))))
    C))

(defun mtrace (m &optional (start 0))
  (let ((sum 0))
    (loop for i from start to (1- (array-dimension m 0))
          sum (+ sum (aref m i i)))))

(defun copy-matrix (m)
  (let* ((size (array-dimension m 0))
         (new-m (make-constant-matrix size size)))
    (dotimes (row size new-m)
      (dotimes (col size)
        (setf (aref new-m row col)
              (aref m row col))))))

(defun copy-matrix-g (m)
  (let* ((size (array-dimension m 0))
         (new-m (make-constant-matrix size (1+ size))))
    (dotimes (row size new-m)
      (dotimes (col size)
        (setf (aref new-m row col)
              (aref m row col))))))


(defun substract-matrix (&rest matrices)
  (labels ((subtract-two (m1 m2)
             (let* ((rows (array-dimension m1 0))
                    (cols (array-dimension m1 1))
                    (result (make-constant-matrix rows cols)))
               (dotimes (row rows result)
                 (dotimes (col cols)
                   (setf (aref result row col)
                         (- (aref m1 row col)
                            (aref m2 row col))))))))
    (when matrices                      ; Empty arguments check
      (reduce #'subtract-two matrices))))

(defun polynomial-coeffs (matrix)
  (let* ((rows (array-dimension matrix 0))
         (cpoly (make-array (1+ rows) :initial-element 1)))
    (loop for i from 0 upto rows
          for tr = 1 then (mtrace b)
          for p = -1 then (/ tr i)
          for b = (copy-matrix matrix) then (mmul matrix
                                                  (substract-matrix b
                                                                    (mscale (make-identity-matrix rows) p)))
          do (setf (aref cpoly i) (- p)))
    cpoly))

(defun polynom (d x c)
  (let ((s 1.0))
    (loop for i from (1- d) downto 0 do
      (setq s
            (+ (* s x) (aref c i))))
    s))

(defun array-slice (arr row)
  (make-array (array-dimension arr 1) 
              :displaced-to arr 
              :displaced-index-offset (* row (array-dimension arr 1))))

(defun dihot (d l r c)
  (let ((copy-l l)
        (copy-r r))
    (loop do
      (let ((x (* 0.5 (+ copy-l copy-r))))
        (if (or (= x copy-r) (= x copy-l))
            (return x)
            (if (< (polynom d x c) 0)
                (setq copy-l x)
                (setq copy-r x)))))))

(defun step-up (l a b cnt)
  (let ((major (+ 1.0 (reduce #'(lambda (x y) (max (abs x) (abs y))) (array-slice a l))))
        (_ (setf (aref cnt l) 0)))
    (declare (ignorable _))
    (dotimes (i (1+ (aref cnt (1- l))) cnt)
      (let* ((edge-left (if (zerop i) (- major) (aref b (1- l) (1- i))))
             (rb (polynom l edge-left (array-slice a l))))
        (if (zerop rb)
            (progn
              (setf (aref b l (aref cnt l)) edge-left)
              (incf (aref cnt l)))
            (let* ((sign-left (if (> rb 0) 1 -1))
                   (edge-right (if (= i (aref cnt (1- l))) major (aref b (1- l) i)))
                   (rb (polynom l edge-right (array-slice a l))))
              (if (zerop rb)
                  (progn
                    (setf (aref b l (aref cnt l)) edge-right)
                    (incf (aref cnt l)))
                  (let ((sign-right (if (> rb 0) 1 -1)))
                    (when (not (= sign-right sign-left))
                      (let ((edge-pos (if (< sign-left 0) edge-right edge-left))
                            (edge-neg (if (< sign-left 0) edge-left edge-right)))
                        (progn
                          (setf (aref b l (aref cnt l))
                                (dihot l edge-neg edge-pos (array-slice a l)))
                          (incf (aref cnt l)))))))))))))

(defun normalize (d a c)
  (loop for i from 0 upto (1- d) do
    (setf (aref a d i)
          (/ (aref c i) (aref c d))))
  a)

(defun calc-derivatives (d a)
  (loop for i from (1- d) downto 1
        for i1 = d then (1+ i) do
          (loop for j from (1- i) downto 0
                for j1 = i then (1+ j) do
                  (setf (aref a i j)
                        (/ (* (aref a i1 j1) j1) i1))))
  a)

(defun roots (d c)
  (let* ((dd (1+ d))
         (a (make-constant-matrix dd dd))
         (b (make-constant-matrix dd dd))
         (r (make-array d))
         (cnt (make-array dd :initial-element 1))
         (1_ (normalize d a c))
         (2_ (calc-derivatives d a))
         (3_ (setf (aref cnt 1) 1))
         (4_ (setf (aref b 1 0) (- (aref a 1 0)))))
    (declare (ignorable 1_ 2_ 3_ 4_))
    (progn
      (loop for i from 2 upto d do
        (step-up i a b cnt))
      (loop for i from 0 upto (1- (aref cnt d)) do
        (setf (aref r i)
              (round (aref b d i))))
      r)))

(declaim (inline row-dimension column-dimension))

(defun row-dimension (a)
  (array-dimension a 0))

(defun column-dimension (a)
  (array-dimension a 1))

(defun switch-rows (a i j)
  (dotimes (k (column-dimension a) a)
    (psetf (aref a i k) (aref a j k)
           (aref a j k) (aref a i k))))

(defun multiply-row (a i alpha)
  (dotimes (k (column-dimension a) a)
    (setf (aref a i k) (* (aref a i k) alpha))))

(defun add-row (a i j alpha)
  (dotimes (k (column-dimension a) a)
    (incf (aref a i k) (* (aref a j k) alpha))))

(defun eliminate-column-below (a i j)
  (loop for k from (+ i 1) below (array-dimension a 0)
        do (add-row a k i (- (/ (aref a k j) (aref a i j))))
        finally (return a)))

(defun eliminate-column-above (a i j)
  (loop for k below i
        do (add-row a k i (- (/ (aref a k j) (aref a i j))))
        finally (return a)))

(defun find-pivot-row (a i j)
  (loop for k from i below (row-dimension a)
        unless (zerop (aref a k j))
          do (return k)
        finally (return nil)))

(defun find-pivot-column (a i j)
  (loop for k from j below (column-dimension a)
        unless (zerop (aref a i k))
          do (return k)
        finally (return nil)))

(defun row-echelon (a)
  (loop with row-dimension = (row-dimension a)
        with column-dimension = (column-dimension a)
        with current-row = 0
        with current-col = 0
        while (and (< current-row row-dimension)
                   (< current-col column-dimension))
        for pivot-row = (find-pivot-row a current-row current-col)
        do (when pivot-row
             (unless (= pivot-row current-row)
               (switch-rows a pivot-row current-row))
             (eliminate-column-below a current-row current-col)
             (incf current-row))
        do (incf current-col)
        finally (return a)))

(defun reduce-row-echelon (a)
  (loop for i below (row-dimension a)
        for j = (find-pivot-column a i 0) then (find-pivot-column a i j)
        while j
        unless (= 1 (aref a i j))
        do (multiply-row a i (/ 1 (aref a i j)))
        do (eliminate-column-above a i j)
        finally (return a)))

(defun reduced-row-echelon (a)
  (reduce-row-echelon (row-echelon a)))

(defun form-col (m)
  (let* ((rows (array-dimension m 0))
         (result (make-array rows :initial-element 1)))
    (loop for i from 0 upto (- rows 2) do
      (setf (aref result i)
            (/ (- (aref m i (1- rows)))
               (if (zerop (aref m i 0))
                   1
                   (aref m i 0)))))
    result))

(defun eigen-v (m root)
  (let* ((mc (copy-matrix m))
         (rows (array-dimension mc 0))
         (identity (make-identity rows root))
         (gauss (reduced-row-echelon (copy-matrix-g (substract-matrix mc identity)))))
    (form-col gauss)))

(defun mtp (A)
  (let* ((m (array-dimension A 0))
         (n (array-dimension A 1))
         (B (make-array `(,n ,m) :initial-element 0)))
    (loop for i from 0 below m do
      (loop for j from 0 below n do
        (setf (aref B j i)
              (aref A i j))))
    B))

(defun eigen-m (matrix)
  (let* ((n (array-dimension matrix 1))
         (poly-coeffs (polynomial-coeffs matrix))
         (r (reverse (roots n (reverse poly-coeffs))))
         (vectors (loop for i from 0 to (1- n)
                        collect (eigen-v matrix (aref r i)))))
    (mtp (make-matrix n n (reverse vectors)))))

(defun diagonal (m)
  (let* ((n (array-dimension m 0))
         (poly-coeffs (polynomial-coeffs m))
         (r (roots n (reverse poly-coeffs))))
    (make-identityv n r)))

; #2A((-26 -33 -25) (31 42 23) (-11 -15 -4))
; #2A((-1 3 -1) (-3 5 -1) (-3 3 1))

