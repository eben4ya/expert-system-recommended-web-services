; Expert System for Diagnosing Diseases: DBD, Malaria, Tifus based on symptoms
; Benaya Imanuela - 22/494790/TK/54313

; ! Template for Diagnosis
(deftemplate Diagnosis
    (slot disease)
    (slot certainty-factor (type NUMBER))
)

; ! Template for Symptom
(deftemplate Symptom
    (slot name)
    (slot range (type NUMBER))
)

; ! Initial Facts
(deffacts initial-facts
    (Diagnosis (disease "Initial_DBD") (certainty-factor 0.4))
    (Diagnosis (disease "Initial_Malaria") (certainty-factor 0.35))
    (Diagnosis (disease "Initial_Tifus") (certainty-factor 0.25))
)

;! Asking Question

; Ask Headache
(defrule ask-headache 
    (not (ask-headache-done))
    =>
    (printout t "Welcome to the expert system for diagnosing diseases design by Benaya Imanuela." crlf)
    (printout t "first of all, we need to ask you some question to diagnose your disease." crlf)
    (printout t "Are you have headache? (yes/no) ")
    (bind ?headache (read))
    (if (eq ?headache yes)
        then
        (printout t "give an range of your headache (0.1 - 1.0) ")
        (bind ?headache-range (read))
        (assert (Symptom (name "headache") (range ?headache-range)))
        (assert (headache-yes))
        else 
        (assert (headache-no))
    )
    (assert (ask-headache-done))
)

; Ask Diarrhea
(defrule ask-diarrhea
    (not (ask-diarrhea-done))
    =>
    (printout t "Are you have diarrhea? (yes/no) ")
    (bind ?diarrhea (read))
    (if (eq ?diarrhea yes)
        then
        (printout t "give an range of your diarrhea (0.1 - 1.0) ")
        (bind ?diarrhea-range (read))
        (assert (Symptom (name "diarrhea") (range ?diarrhea-range)))
        (assert (diarrhea-yes))
        else
        (assert (diarrhea-no))
    )
    (assert (ask-diarrhea-done))
)

; Ask Nauseous
(defrule ask-nauseous
    (not (ask-nauseous-done))
    =>
    (printout t "Are you have nauseous? (yes/no) ")
    (bind ?nauseous (read))
    (if (eq ?nauseous yes)
        then
        (printout t "give an range of your nauseous (0.1 - 1.0) ")
        (bind ?nauseous-range (read))
        (assert (Symptom (name "nauseous") (range ?nauseous-range)))
        (assert (nauseous-yes))
        else
        (assert (nauseous-no))
    )
    (assert (ask-nauseous-done))
)

; ! Calculate CF & Result

; if the patient have headache and not have diarrhea and not have nauseous
(defrule calculate-cf-ynn
    (headache-yes)
    (diarrhea-no)
    (nauseous-no)
    (Symptom (name "headache") (range ?headache-range))
    (Diagnosis (disease "Initial_DBD") (certainty-factor ?initial-cf-DBD))
    (Diagnosis (disease "Initial_Malaria") (certainty-factor ?initial-cf-Malaria))
    (Diagnosis (disease "Initial_Tifus") (certainty-factor ?initial-cf-Tifus))
    =>
  
    (bind ?cf-Malaria-headache (* 0.5 ?headache-range))
    (bind ?cf-durkin-Malaria-headache (+ ?initial-cf-Malaria (* ?cf-Malaria-headache (- 1 ?initial-cf-Malaria)))) ; durkin's rule when cf1 and cf2 positive
    (assert (Diagnosis (disease "Malaria-ynn") (certainty-factor ?cf-durkin-Malaria-headache)))
    (printout t "You are diagnosed with DBD: " ?initial-cf-DBD crlf)
    (printout t "You are diagnosed with Malaria: " ?cf-durkin-Malaria-headache crlf)
    (printout t "You are diagnosed with Tifus: " ?initial-cf-Tifus crlf)
)

; if the patient have diarrhea and not have headache and not have nauseous
(defrule calculate-cf-nyn
    (headache-no)
    (diarrhea-yes)
    (nauseous-no)
    (Symptom (name "diarrhea") (range ?diarrhea-range))
    (Diagnosis (disease "Initial_DBD") (certainty-factor ?initial-cf-DBD))
    (Diagnosis (disease "Initial_Malaria") (certainty-factor ?initial-cf-Malaria))
    (Diagnosis (disease "Initial_Tifus") (certainty-factor ?initial-cf-Tifus))
    =>
    (bind ?cf-DBD-diarrhea (* 0.5 ?diarrhea-range  ))
    (bind ?cf-durkin-DBD-diarrhea (+ ?initial-cf-DBD (* ?cf-DBD-diarrhea (- 1 ?initial-cf-DBD)))) ; durkin's rule when cf1 and cf2 positive
    (assert (Diagnosis (disease "DBD-nyn") (certainty-factor ?cf-durkin-DBD-diarrhea)))
    (printout t "You are diagnosed with DBD: " ?cf-durkin-DBD-diarrhea crlf)
    (printout t "You are diagnosed with Malaria: " ?initial-cf-Malaria crlf)
    (printout t "You are diagnosed with Tifus: " ?initial-cf-Tifus crlf)
   
)

; if the patient have nauseous and not have headache and not have diarrhea
(defrule calculate-cf-nny
    (headache-no)
    (diarrhea-no)
    (nauseous-yes)
    (Symptom (name "nauseous") (range ?nauseous-range))
    (Diagnosis (disease "Initial_DBD") (certainty-factor ?initial-cf-DBD))
    (Diagnosis (disease "Initial_Malaria") (certainty-factor ?initial-cf-Malaria))
    (Diagnosis (disease "Initial_Tifus") (certainty-factor ?initial-cf-Tifus))
    =>
   
    (bind ?cf-Tifus-nauseous (* 0.5 ?nauseous-range))
    (bind ?cf-durkin-Tifus-nauseous (+ ?initial-cf-Tifus (* ?cf-Tifus-nauseous (- 1 ?initial-cf-Tifus)))) ; durkin's rule when cf1 and cf2 positive
    (assert (Diagnosis (disease "Tifus-nny") (certainty-factor ?cf-durkin-Tifus-nauseous)))
    (printout t "You are diagnosed with DBD: " ?initial-cf-DBD crlf)
    (printout t "You are diagnosed with Malaria: " ?initial-cf-Malaria crlf)
    (printout t "You are diagnosed with Tifus: " ?cf-durkin-Tifus-nauseous crlf)
)

; if the patient have headache and have diarrhea and have nauseous
(defrule calculate-cf-yyy
    (headache-yes)
    (diarrhea-yes)
    (nauseous-yes)
    (Symptom (name "headache") (range ?headache-range))
    (Symptom (name "diarrhea") (range ?diarrhea-range))
    (Symptom (name "nauseous") (range ?nauseous-range))
    (Diagnosis (disease "Initial_DBD") (certainty-factor ?initial-cf-DBD))
    (Diagnosis (disease "Initial_Malaria") (certainty-factor ?initial-cf-Malaria))
    (Diagnosis (disease "Initial_Tifus") (certainty-factor ?initial-cf-Tifus))
    =>
   
    (bind ?cf-Tifus-yyy (* 0.7 (min ?headache-range ?diarrhea-range ?nauseous-range)))
    (bind ?cf-durkin-Tifus-yyy (+ ?initial-cf-Tifus (* ?cf-Tifus-yyy (- 1 ?initial-cf-Tifus)))) ; durkin's rule when cf1 and cf2 positive
    (assert (Diagnosis (disease "Tifus-yyy") (certainty-factor ?cf-durkin-Tifus-yyy)))
    (printout t "You are diagnosed with DBD: " ?initial-cf-DBD crlf)
    (printout t "You are diagnosed with Malaria: " ?initial-cf-Malaria crlf)
    (printout t "You are diagnosed with Tifus: " ?cf-durkin-Tifus-yyy crlf)
)

; if the patient have headache and have diarrhea and not have nauseous
(defrule calculate-cf-yyn
    (headache-yes)
    (diarrhea-yes)
    (nauseous-no)
    (Symptom (name "headache") (range ?headache-range))
    (Symptom (name "diarrhea") (range ?diarrhea-range))
    (Diagnosis (disease "Initial_DBD") (certainty-factor ?initial-cf-DBD))
    (Diagnosis (disease "Initial_Malaria") (certainty-factor ?initial-cf-Malaria))
    (Diagnosis (disease "Initial_Tifus") (certainty-factor ?initial-cf-Tifus))
    =>
    (bind ?cf-DBD-yyn (* 0.6 (min ?headache-range ?diarrhea-range)))
    (bind ?cf-durkin-DBD-yyn (+ ?initial-cf-DBD (* ?cf-DBD-yyn (- 1 ?initial-cf-DBD)))) ; durkin's rule when cf1 and cf2 positive
    (assert (Diagnosis (disease "DBD-yyn") (certainty-factor ?cf-durkin-DBD-yyn)))
    (printout t "You are diagnosed with DBD: " ?cf-durkin-DBD-yyn crlf)
    (printout t "You are diagnosed with Malaria: " ?initial-cf-Malaria crlf)
    (printout t "You are diagnosed with Tifus: " ?initial-cf-Tifus crlf)
)

; if the patient have headache and not have diarrhea and have nauseous
(defrule calculate-cf-yny
    (headache-yes)
    (diarrhea-no)
    (nauseous-yes)
    (Symptom (name "headache") (range ?headache-range))
    (Symptom (name "nauseous") (range ?nauseous-range))
    (Diagnosis (disease "Initial_DBD") (certainty-factor ?initial-cf-DBD))
    (Diagnosis (disease "Initial_Malaria") (certainty-factor ?initial-cf-Malaria))
    (Diagnosis (disease "Initial_Tifus") (certainty-factor ?initial-cf-Tifus))
    =>
    (bind ?cf-Malaria-yny (* 0.6 (min ?headache-range ?nauseous-range)))
    (bind ?cf-durkin-Malaria-yny (+ ?initial-cf-Malaria (* ?cf-Malaria-yny (- 1 ?initial-cf-Malaria)))) ; durkin's rule when cf1 and cf2 positive
    (assert (Diagnosis (disease "DBD-yny") (certainty-factor ?cf-durkin-Malaria-yny)))
    (printout t "You are diagnosed with DBD: " ?initial-cf-DBD crlf)
    (printout t "You are diagnosed with Malaria: " ?cf-durkin-Malaria-yny crlf)
    (printout t "You are diagnosed with Tifus: " ?initial-cf-Tifus crlf)
)

; if the patient have not have headache and have diarrhea and have nauseous
(defrule calculate-cf-nyy 
    (headache-no)
    (diarrhea-yes)
    (nauseous-yes)
    (Symptom (name "diarrhea") (range ?diarrhea-range))
    (Symptom (name "nauseous") (range ?nauseous-range))
    (Diagnosis (disease "Initial_DBD") (certainty-factor ?initial-cf-DBD))
    (Diagnosis (disease "Initial_Malaria") (certainty-factor ?initial-cf-Malaria))
    (Diagnosis (disease "Initial_Tifus") (certainty-factor ?initial-cf-Tifus))
    =>
    (bind ?cf-Tifus-nyy (* 0.6 (min ?diarrhea-range ?nauseous-range)))
    (bind ?cf-durkin-Tifus-nyy (+ ?initial-cf-Tifus (* ?cf-Tifus-nyy (- 1 ?initial-cf-Tifus)))) ; durkin's rule when cf1 and cf2 positive
    (assert (Diagnosis (disease "DBD-nyy") (certainty-factor ?cf-durkin-Tifus-nyy)))
    (printout t "You are diagnosed with DBD: " ?initial-cf-DBD crlf)
    (printout t "You are diagnosed with Malaria: " ?initial-cf-Malaria crlf)
    (printout t "You are diagnosed with Tifus: " ?cf-durkin-Tifus-nyy crlf)
)

; if the patient have not have headache and not have diarrhea and not have nauseous
(defrule calculate-cf-nnn
    (headache-no)
    (diarrhea-no)
    (nauseous-no)
    (Diagnosis (disease "Initial_DBD") (certainty-factor ?initial-cf-DBD))
    (Diagnosis (disease "Initial_Malaria") (certainty-factor ?initial-cf-Malaria))
    (Diagnosis (disease "Initial_Tifus") (certainty-factor ?initial-cf-Tifus))
    =>
    (printout t "You are diagnosed with DBD: " ?initial-cf-DBD crlf)
    (printout t "You are diagnosed with Malaria: " ?initial-cf-Malaria crlf)
    (printout t "You are diagnosed with Tifus: " ?initial-cf-Tifus crlf)
)



