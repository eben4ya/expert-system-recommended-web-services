(deftemplate Diagnosis
    (slot disease)
    (slot certainty-factor (type NUMBER))
)

(deffacts initial-facts
    (Diagnosis (disease "DBD") (certainty-factor 0.4))
    (Diagnosis (disease "Malaria") (certainty-factor 0.35))
    (Diagnosis (disease "Tifus") (certainty-factor 0.25))
)

(defrule main-loop
    (not (done))
    =>
    ; ! Ask the user
    (printout t "Welcome to the expert system for diagnosing diseases design by Benaya Imanuela." crlf)
    (printout t "Are you have headache? (yes/no) ")
    (bind ?headache (read))
    (if (eq ?headache yes)
        then 
        (printout t "give an range of your headache (0.1 - 1.0) ") 
        (bind ?headache-range (read))
        ; calculate cf
        (bind ?cf-DBD-headache (* 0.3 ?headache-range)) 
        (bind ?cf-durkin-DBD-headache (+ 0.4 (* ?cf-DBD-headache (- 1 0.4)))) ; durkin's rule when cf1 and cf2 positive 
        (assert (Diagnosis (disease "DBD") (certainty-factor ?cf-durkin-DBD-headache)))
        (printout t "Temporary diagnosis for DBD cause by headache: " ?cf-durkin-DBD-headache crlf)
        (bind ?cf-Malaria-headache (* 0.8 ?headache-range))
        (bind ?cf-durkin-Malaria-headache (+ 0.35 (* ?cf-Malaria-headache (- 1 0.35)))) ; durkin's rule when cf1 and cf2 positive
        (assert (Diagnosis (disease "Malaria") (certainty-factor ?cf-durkin-Malaria-headache)))
        (printout t "Temporary diagnosis for Malaria cause by headache: " ?cf-durkin-Malaria-headache crlf)
        (bind ?cf-Tifus-headache (* 0.5 ?headache-range))
        (bind ?cf-durkin-Tifus-headache (+ 0.25 (* ?cf-Tifus-headache (- 1 0.25)))) ; durkin's rule when cf1 and cf2 positive
        (assert (Diagnosis (disease "Tifus") (certainty-factor ?cf-durkin-Tifus-headache)))
        (printout t "Temporary diagnosis for Tifus cause by headache: " ?cf-durkin-Tifus-headache crlf)

        ; printout diagnosis sementara (2) = done
    )
    (printout t "Are you have diarrhea? (yes/no) ")
    (bind ?diarrhea (read))
    (if (eq ?diarrhea yes and ?headache yes)
        then 
        (printout t "give an range of your diarrhea (0.1 - 1.0) ")
        (bind ?diarrhea-range (read))
        ; calculate cf, use min because the rule is AND (conjuction)
        (bind ?cf-DBD-diarrhea-y (* 0.9 (min  ?headache-range ?diarrhea-range )))
        (bind ?cf-durkin-DBD-diarrhea-y (+ ?cf-durkin-DBD-headache (* ?cf-DBD-diarrhea-y (- 1 ?cf-durkin-DBD-headache)))) ; durkin's rule when cf1 and cf2 positive 
        (assert (Diagnosis (disease "DBD") (certainty-factor ?cf-durkin-DBD-diarrhea-y)))
        (printout t "Temporary diagnosis for DBD cause by headache and diarrhea: " ?cf-durkin-DBD-diarrhea-y crlf)
        (bind ?cf-Malaria-diarrhea-y (* 0 (min  ?headache-range ?diarrhea-range )))
        (bind ?cf-durkin-Malaria-diarrhea-y (+ ?cf-durkin-Malaria-headache (* ?cf-Malaria-diarrhea-y (- 1 ?cf-durkin-Malaria-headache)))) ; durkin's rule when cf1 and cf2 positive 
        (assert (Diagnosis (disease "Malaria") (certainty-factor ?cf-durkin-Malaria-diarrhea-y)))
        (printout t "Temporary diagnosis for Malaria cause by headache and diarrhea: " ?cf-durkin-Malaria-diarrhea-y crlf)
        (bind ?cf-Tifus-diarrhea-y (* 0.7 (min  ?headache-range ?diarrhea-range )))
        (bind ?cf-durkin-Tifus-diarrhea-y (+ ?cf-durkin-Tifus-headache (* ?cf-Tifus-diarrhea-y (- 1 ?cf-durkin-Tifus-headache)))) ; durkin's rule when cf1 and cf2 positive 
        (assert (Diagnosis (disease "Tifus") (certainty-factor ?cf-durkin-Tifus-diarrhea-y)))
        (printout t "Temporary diagnosis for Tifus cause by headache and diarrhea: " ?cf-durkin-Tifus-diarrhea-y crlf)
    )
    ; selesaiin ini dulu (done)
    (if (eq ?diarrhea yes and ?headache no)
        then 
        (printout t "give an range of your diarrhea (0.1 - 1.0) ")
        (bind ?diarrhea-range (read))
        ; calculate cf
        (bind ?cf-DBD-diarrhea-n (* 0.9 ?diarrhea-range ))
        (bind ?cf-durkin-DBD-diarrhea-n (+ 0.4 (* ?cf-DBD-diarrhea-n (- 1 0.4)))) ; durkin's rule when cf1 and cf2 positive 
        (assert (Diagnosis (disease "DBD") (certainty-factor ?cf-durkin-DBD-diarrhea-n)))
        (printout t "Temporary d   iagnosis for DBD cause by diarrhea: " ?cf-durkin-DBD-diarrhea-n crlf)
        (bind ?cf-Malaria-diarrhea-n (* 0 ?diarrhea-range ))
        (bind ?cf-durkin-Malaria-diarrhea-n (+ 0.35 (* ?cf-Malaria-diarrhea-n (- 1 0.35)))) ; durkin's rule when cf1 and cf2 positive 
        (assert (Diagnosis (disease "Malaria") (certainty-factor ?cf-durkin-Malaria-diarrhea-y)))
        (printout t "Temporary diagnosis for Malaria cause by diarrhea: " ?cf-durkin-Malaria-diarrhea-y crlf)
        (bind ?cf-Tifus-diarrhea-n (* 0.7 ?diarrhea-range ))
        (bind ?cf-durkin-Tifus-diarrhea-n (+ 0.25 (* ?cf-Tifus-diarrhea-n (- 1 0.25)))) ; durkin's rule when cf1 and cf2 positive 
        (assert (Diagnosis (disease "Tifus") (certainty-factor ?cf-Tifus-diarrhea-n)))
        (printout t "Temporary diagnosis for Tifus cause by diarrhea: " ?cf-Tifus-diarrhea-n crlf)
    )
    ; compile dulu apakah bisa ambil variabel di dalam fungsi lain (1) (done, pakai assert aja)
    ; if no diarrhea (3) (done)
    ; dst
    
    (printout t "Are you have nauseous? (yes/no) ")
    (bind ?nauseous (read))
    (if (eq ?nauseous yes and ?headache yes and ?diarrhea and yes)
        then 
        (printout t "give an range of your nauseous (0.1 - 1.0) ")
        (bind ?nauseous-range (read))
        ; calculate cf
        (bind ?cf-DBD-nauseous-y (* 0.6 (min ?headache-range ?diarrhea-range ?nauseous-range)))
        (bind ?cf-durkin-DBD-nauseous-yyy (+ ?cf-durkin-DBD-diarrhea-y (* ?cf-DBD-nauseous-y (- 1 ?cf-durkin-DBD-diarrhea-y)))) ; durkin's rule when cf1 and cf2 positive
        (assert (Diagnosis (disease "DBD") (certainty-factor ?cf-durkin-DBD-nauseous-yyy)))
        (printout t "Your are diagnosed with DBD cause by headache, diarrhea, and nauseous: " ?cf-durkin-DBD-nauseous-yyy crlf)
        (bind ?cf-Malaria-nauseous-y (* 0.7 (min ?headache-range ?diarrhea-range ?nauseous-range)))
        (bind ?cf-durkin-Malaria-nauseous-yyy (+ ?cf-durkin-Malaria-diarrhea-y (* ?cf-Malaria-nauseous-y (- 1 ?cf-durkin-Malaria-diarrhea-y)))) ; durkin's rule when cf1 and cf2 positive
        (assert (Diagnosis (disease "Malaria") (certainty-factor ?cf-durkin-Malaria-nauseous-yyy)))
        (printout t "Your are diagnosed with Malaria cause by headache, diarrhea, and nauseous: " ?cf-durkin-Malaria-nauseous-yyy crlf)
        (bind ?cf-Tifus-nauseous-y (* 0.9 (min ?headache-range ?diarrhea-range ?nauseous-range)))
        (bind ?cf-durkin-Tifus-nauseous-yyy (+ ?cf-durkin-Tifus-diarrhea-y (* ?cf-Tifus-nauseous-y (- 1 ?cf-durkin-Tifus-diarrhea-y)))) ; durkin's rule when cf1 and cf2 positive
        (assert (Diagnosis (disease "Tifus") (certainty-factor ?cf-durkin-Tifus-nauseous-yyy)))
        (printout t "Your are diagnosed with Tifus cause by headache, diarrhea, and nauseous: " ?cf-durkin-Tifus-nauseous-yyy crlf)

    )
    
    (if (eq ?nauseous yes and ?headache yes and ?diarrhea no)
        then 
        (printout t "give an range of your nauseous (0.1 - 1.0) ")
        (bind ?nauseous-range (read))
        ; calculate cf
        (bind ?cf-DBD-nauseous-y (* 0.6 (min ?headache-range ?nauseous-range)))
        (bind ?cf-durkin-DBD-nauseous-yyn (+ ?cf-durkin-DBD-headache (* ?cf-DBD-nauseous-y (- 1 ?cf-durkin-DBD-headache)))) ; durkin's rule when cf1 and cf2 positive
        (assert (Diagnosis (disease "DBD") (certainty-factor ?cf-durkin-DBD-nauseous-yyn)))
        (printout t "Your are diagnosed with DBD cause by headache and nauseous: " ?cf-durkin-DBD-nauseous-yyn crlf)
        (bind ?cf-Malaria-nauseous-y (* 0.7 (min ?headache-range ?nauseous-range)))
        (bind ?cf-durkin-Malaria-nauseous-yyn (+ ?cf-durkin-Malaria-headache (* ?cf-Malaria-nauseous-y (- 1 ?cf-durkin-Malaria-headache)))) ; durkin's rule when cf1 and cf2 positive
        (assert (Diagnosis (disease "Malaria") (certainty-factor ?cf-durkin-Malaria-nauseous-yyn)))
        (printout t "Your are diagnosed with Malaria cause by headache and nauseous: " ?cf-durkin-Malaria-nauseous-yyn crlf)
        (bind ?cf-Tifus-nauseous-y (* 0.9 (min ?headache-range ?nauseous-range)))
        (bind ?cf-durkin-Tifus-nauseous-yyn (+ ?cf-durkin-Tifus-headache (* ?cf-Tifus-nauseous-y (- 1 ?cf-durkin-Tifus-headache)))) ; durkin's rule when cf1 and cf2 positive
        (assert (Diagnosis (disease "Tifus") (certainty-factor ?cf-durkin-Tifus-nauseous-yyn)))
        (printout t "Your are diagnosed with Tifus cause by headache and nauseous: " ?cf-durkin-Tifus-nauseous-yyn crlf)
    )

    (if (eq ?nauseous yes and ?headache no and ?diarrhea yes)
        then 
        (printout t "give an range of your nauseous (0.1 - 1.0) ")
        (bind ?nauseous-range (read))
        ; calculate cf
        (bind ?cf-DBD-nauseous-y (* 0.6 (min ?diarrhea-range ?nauseous-range)))
        (bind ?cf-durkin-DBD-nauseous-yny (+ ?cf-durkin-DBD-diarrhea-n (* ?cf-DBD-nauseous-y (- 1 ?cf-durkin-DBD-diarrhea-n)))) ; durkin's rule when cf1 and cf2 positive
        (assert (Diagnosis (disease "DBD") (certainty-factor ?cf-durkin-DBD-nauseous-yny)))
        (printout t "Your are diagnosed with DBD cause by diarrhea and nauseous: " ?cf-durkin-DBD-nauseous-yny crlf)
        (bind ?cf-Malaria-nauseous-y (* 0.7 (min ?diarrhea-range ?nauseous-range)))
        (bind ?cf-durkin-Malaria-nauseous-yny (+ ?cf-durkin-Malaria-diarrhea-n (* ?cf-Malaria-nauseous-y (- 1 ?cf-durkin-Malaria-diarrhea-n)))) ; durkin's rule when cf1 and cf2 positive
        (assert (Diagnosis (disease "Malaria") (certainty-factor ?cf-durkin-Malaria-nauseous-yny)))
        (printout t "Your are diagnosed with Malaria cause by diarrhea and nauseous: " ?cf-durkin-Malaria-nauseous-yny crlf)
        (bind ?cf-Tifus-nauseous-y (* 0.9 (min ?diarrhea-range ?nauseous-range)))
        (bind ?cf-durkin-Tifus-nauseous-yny (+ ?cf-durkin-Tifus-diarrhea-n (* ?cf-Tifus-nauseous-y (- 1 ?cf-durkin-Tifus-diarrhea-n)))) ; durkin's rule when cf1 and cf2 positive
        (assert (Diagnosis (disease "Tifus") (certainty-factor ?cf-durkin-Tifus-nauseous-yny)))
        (printout t "Your are diagnosed with Tifus cause by diarrhea and nauseous: " ?cf-durkin-Tifus-nauseous-yny crlf)

    )
    (if (eq ?nauseous yes and ?headache no and ?diarrhea no)
        then 
        (printout t "give an range of your nauseous (0.1 - 1.0) ")
        (bind ?nauseous-range (read))
        ; calculate cf
        (bind ?cf-DBD-nauseous-y (* 0.6 ?nauseous-range))
        (bind ?cf-durkin-DBD-nauseous-ynn (+ 0.4 (* ?cf-DBD-nauseous-y (- 1 0.4)))) ; durkin's rule when cf1 and cf2 positive
        (assert (Diagnosis (disease "DBD") (certainty-factor ?cf-durkin-DBD-nauseous-ynn)))
        (printout t "Your are diagnosed with DBD cause by nauseous: " ?cf-durkin-DBD-nauseous-ynn crlf)
        (bind ?cf-Malaria-nauseous-y (* 0.7 ?nauseous-range))
        (bind ?cf-durkin-Malaria-nauseous-ynn (+ 0.35 (* ?cf-Malaria-nauseous-y (- 1 0.35)))) ; durkin's rule when cf1 and cf2 positive
        (assert (Diagnosis (disease "Malaria") (certainty-factor ?cf-durkin-Malaria-nauseous-ynn)))
        (printout t "Your are diagnosed with Malaria cause by nauseous: " ?cf-durkin-Malaria-nauseous-ynn crlf)
        (bind ?cf-Tifus-nauseous-y (* 0.9 ?nauseous-range))
        (bind ?cf-durkin-Tifus-nauseous-ynn (+ 0.25 (* ?cf-Tifus-nauseous-y (- 1 0.25)))) ; durkin's rule when cf1 and cf2 positive
        (assert (Diagnosis (disease "Tifus") (certainty-factor ?cf-durkin-Tifus-nauseous-ynn)))
        (printout t "Your are diagnosed with Tifus cause by nauseous: " ?cf-durkin-Tifus-nauseous-ynn crlf)
    )
    (if (eq ?nauseous no and ?headache yes and ?diarrhea yes)
        then 
        (printout t "You are diagnosed with DBD cause by headache and diarrhea: " ?cf-durkin-DBD-diarrhea-y  crlf)
        (printout t "You are diagnosed with Malaria cause by headache and diarrhea: " ?cf-durkin-Malaria-diarrhea-y  crlf)
        (printout t "You are diagnosed with Tifus cause by headache and diarrhea: " ?cf-durkin-Tifus-diarrhea-y  crlf)
    )
    (if (eq ?nauseous no and ?headache yes and ?diarrhea no)
        then 
        (printout t "You are diagnosed with DBD cause by headache: " ?cf-durkin-DBD-headache  crlf)
        (printout t "You are diagnosed with Malaria cause by headache: " ?cf-durkin-Malaria-headache  crlf)
        (printout t "You are diagnosed with Tifus cause by headache: " ?cf-durkin-Tifus-headache  crlf)

    )
    (if (eq ?nauseous no and ?headache no and ?diarrhea yes)
        then 
        (printout t "You are diagnosed with DBD cause by diarrhea: " ?cf-durkin-DBD-diarrhea-n  crlf)
        (printout t "You are diagnosed with Malaria cause by diarrhea: " ?cf-durkin-Malaria-diarrhea-n  crlf)
        (printout t "You are diagnosed with Tifus cause by diarrhea: " ?cf-durkin-Tifus-diarrhea-n  crlf)

    )
    (if (eq ?nauseous no and ?headache no and ?diarrhea no)
        then 
        (printout t " You are diagnosed with DBD: " 0.4  crlf)
        (printout t " You are diagnosed with Malaria: " 0.35  crlf)
        (printout t " You are diagnosed with Tifus: " 0.25  crlf)
    )
    

    ; if no nauseous (4)
    ; dst
    

    ; ntaran aja kalau udah bisa dicompile dan fungsi berjalan, baru di pisah tiap rule (5)
    ; ; ! Rules 
    ; (if (eq ?headache yes) (eq ?diarrhea yes) (eq ?nauseous yes) 
    ;     then
    ;     (bind ?cf-DBD (* 0.3 (min ( ?headache-range ?diarrhea-range ?nauseous-range ))))
    ;     (modify (Diagnosis (disease "DBD") (certainty-factor ?cf-DBD)))
    ;     (bind ?cf-Malaria (* 0.3 (min ( ?headache-range ?diarrhea-range ?nauseous-range ))))
    ;     (modify (Diagnosis (disease "Malaria") (certainty-factor ?cf-Malaria)))
    ;     (bind ?cf-Tifus (* 0.3 (min ( ?headache-range ?diarrhea-range ?nauseous-range ))))
    ;     (modify (Diagnosis (disease "Tifus") (certainty-factor ?cf-Tifus)))
    ; )
    ; (if (eq ?headache yes) (eq ?diarrhea yes) (eq ?nauseous no) 
    ;     then
    ;     (modify (Diagnosis (disease "DBD") (certainty-factor 0.4)))
    ;     (modify (Diagnosis (disease "Malaria") (certainty-factor 0.3)))
    ;     (modify (Diagnosis (disease "Tifus") (certainty-factor 0.3)))
    ; )
    ; (if (eq ?headache yes) (eq ?diarrhea no) (eq ?nauseous yes) 
    ;     then
    ;     (modify (Diagnosis (disease "DBD") (certainty-factor 0.4)))
    ;     (modify (Diagnosis (disease "Malaria") (certainty-factor 0.3)))
    ;     (modify (Diagnosis (disease "Tifus") (certainty-factor 0.3)))
    ; )
    ; (if (eq ?headache yes) (eq ?diarrhea no) (eq ?nauseous no) 
    ;     then
    ;     (modify (Diagnosis (disease "DBD") (certainty-factor 0.4)))
    ;     (modify (Diagnosis (disease "Malaria") (certainty-factor 0.3)))
    ;     (modify (Diagnosis (disease "Tifus") (certainty-factor 0.3)))
    ; )
    ; (if (eq ?headache no) (eq ?diarrhea yes) (eq ?nauseous yes) 
    ;     then
    ;     (modify (Diagnosis (disease "DBD") (certainty-factor 0.4)))
    ;     (modify (Diagnosis (disease "Malaria") (certainty-factor 0.3)))
    ;     (modify (Diagnosis (disease "Tifus") (certainty-factor 0.3)))
    ; )
    ; (if (eq ?headache no) (eq ?diarrhea yes) (eq ?nauseous no) 
    ;     then
    ;     (modify (Diagnosis (disease "DBD") (certainty-factor 0.4)))
    ;     (modify (Diagnosis (disease "Malaria") (certainty-factor 0.3)))
    ;     (modify (Diagnosis (disease "Tifus") (certainty-factor 0.3)))
    ; )
    ; (if (eq ?headache no) (eq ?diarrhea no) (eq ?nauseous yes) 
    ;     then
    ;     (modify (Diagnosis (disease "DBD") (certainty-factor 0.4)))
    ;     (modify (Diagnosis (disease "Malaria") (certainty-factor 0.3)))
    ;     (modify (Diagnosis (disease "Tifus") (certainty-factor 0.3)))
    ; )
    ; (if (eq ?headache no) (eq ?diarrhea no) (eq ?nauseous no) 
    ;     then
    ;     (modify (Diagnosis (disease "DBD") (certainty-factor 0.4)))
    ;     (modify (Diagnosis (disease "Malaria") (certainty-factor 0.3)))
    ;     (modify (Diagnosis (disease "Tifus") (certainty-factor 0.3)))
    ; )
    (assert (done))
)

; (defrule print-recommendation
;    (Diagnosis (disease ?disease) (certainty-factor ?certainty-factor))
;    =>
;    (printout t "Diagnosis: " ?disease " (Certainty Factor: " ?certainty-factor ")" crlf)
; )
