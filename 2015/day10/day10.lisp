(defun string-to-int-list-map (str)
  (map 'list #'(lambda (c) (- (char-code c) (char-code #\0))) str))

(defun group-repeating (lst)
  (let ((result '())
        (current lst))
    (loop while current do
          (let ((current-value (car current))
                (count 0))
            (loop while (and current (= (car current) current-value)) do
                  (setq count (1+ count))
                  (setq current (cdr current)))
            (push count result)
            (push current-value result)))
    (nreverse result)))

(defun iterate-n-times (func initial-value n)
  (loop for i from 1 to n
        with result = initial-value
        do (setf result (funcall func result))
        finally (return result)))

(defun p1 (line)
    (let ((ints (string-to-int-list-map line)))
      (print (length (iterate-n-times #'group-repeating ints 40)))))

(defun p2 (line)
    (let ((ints (string-to-int-list-map line)))
      (print (length (iterate-n-times #'group-repeating ints 50)))))

(let ((line (read-line)))
  (p1 line)
  (p2 line))
