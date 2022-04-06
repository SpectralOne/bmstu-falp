(defvar LOL '((a a a) (b b b) (c c c)))

(defun zip-test (lol)
  (apply #'mapcar #'list lol))

(defun my-mapcar (fn list &rest lists)
  (apply #'map-into (make-list (length list)) fn list lists))

(defun zip (lol)
  (apply #'my-mapcar #'list lol))
