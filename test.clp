; (defrule main-loop
;    (not (done))
;    =>
;    (printout t "Welcome to the expert system for diagnosing diseases designed by Benaya Imanuela." crlf)
;    (printout t "Do you have headache? (yes/no) ")
;    (bind ?headache (read))
;    (if (eq ?headache yes)
;       then
;       (printout t "Give a range of your headache (0.1 - 1.0): ")
;       (bind ?headache-range (read))
;       (bind ?cf-DBD (* 0.3 ?headache-range))
;       (bind ?prior-cf-DBD (+ 0.4 (* ?cf-DBD (- 1 0.4))))
;       (modify (diagnosis (name "DBD")) (certainty-factor ?prior-cf-DBD))
;    (assert (done))
; )

; (defrule main-loop
;    (not (done))
;    =>
;    (printout t "Welcome to the expert system for diagnosing diseases designed by Benaya Imanuela." crlf)
;    (printout t "Do you have headache? (yes/no) ")
;    (bind ?headache (read))
;    (if (eq ?headache yes)
;       then
;       (printout t "Give a range of your headache (0.1 - 1.0): ")
;       (bind ?headache-range (read))
;       (bind ?cf-DBD (* 0.3 ?headache-range))
;       (bind ?prior-cf-DBD (+ 0.4 (* ?cf-DBD (- 1 0.4))))
;       (modify ?f <- (diagnosis (name "DBD")) (certainty-factor ?cf-DBD)
;          => 
;          (bind ?f (replace-instance ?f (certainty-factor ?prior-cf-DBD)))
;       )
;    (assert (done))
; )

(deftemplate Diagnosis
    (slot disease)
    (slot certainty-factor (type NUMBER))
)

(defrule main-loop
   (not (done))
   =>
   (printout t "Welcome to the expert system for diagnosing diseases designed by Benaya Imanuela." crlf)
   (printout t "Do you have headache? (yes/no) ")
   (bind ?headache (read))
   (if (eq ?headache yes)
      then
      (printout t "Give a range of your headache (0.1 - 1.0): ")
      (bind ?headache-range (read))
      (bind ?cf-DBD (* 0.3 ?headache-range))
      (bind ?prior-cf-DBD (+ 0.4 (* ?cf-DBD (- 1 0.4))))
      (assert (Diagnosis (disease "DBD") (certainty-factor ?prior-cf-DBD))))
   (assert (done))
)


