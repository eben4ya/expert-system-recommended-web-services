; Expert System for Recommended IT Major
; Benaya Imanuela
; 22/494790/TK/54313


; Inital Facts
; (deffacts user-preferences
;     (preference software)
;     (preference data)
;     (preference cyber-security)
; )

; Greet
(defrule main
    (not (done))
    =>
    (printout t "Welcome to the IT Major Recommendation System by Benaya Imanuela" crlf)
    (printout t "Please specify your preference (software/data/cyber-security): ")
    (bind ?res (read))
    (assert (preference ?res))
    (assert (done))
)


; Rules
; ! Add another condition


; Recommendations
(defrule recommend-software
    (preference software)
    => 
    (printout t "Based on your preferences, we recommend considering a major in Software Engineering." crlf)
)

(defrule recommend-data
    (preference data)
    =>
    (printout t "Based on your preferences, we recommend considering a major in Data Science." crlf)
)

(defrule recommend-cyber-security
    (preference cyber-security)
    =>
     (printout t "Based on your preferences, we recommend considering a major in Cyber Security." crlf)
)

(defrule no-preference 
    (not (preference software))
    (not (preference data))
    (not (preference cyber-security))
    => 
    (printout t "It seems you haven't specified a preference. Consider exploring majors in Software, Data, or Cyber Security." crlf)
)
