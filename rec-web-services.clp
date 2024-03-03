; Expert System for Recommended Web Services
; Benaya Imanuela
; 22/494790/TK/54313

; ; ! Facts
; (deffacts user-choice
;     (greeting-done)
;     (asking-web-design-done)
;     (asking-database-done)
;     (require-design)
;     (require-database)
;     (budget-limit)
;     (not-require-design)
;     (not-require-database)
;     (not-budget-limit)
; )

; ! Greet
(defrule main
    (not (greeting-done))
    =>
    (printout t "Welcome to the Arachnova Web Services Recommendation System by Benaya Imanuela" crlf)
    (printout t "Please specify your type of website service you want : " crlf)
    (assert (greeting-done))
)

; ! Rules

; Web Design Question
(defrule ask-web-design
    (greeting-done)
    => 
    (printout t "Do you need website design ? (yes/no) " crlf)
    (bind ?res (read))
    (if (eq ?res yes)
        then 
        (assert (require-design))
        (assert (asking-web-design-done))
        else
        (assert (not-require-design))
        (assert (asking-web-design-done))
    )
)

; Database Question
(defrule ask-database
    (asking-web-design-done)
    => 
    (printout t "Do you need database ? (yes/no) " crlf)
    (bind ?res (read))
    (if (eq ?res yes)
        then 
        (assert (require-database))
        (assert (asking-database-done))
        else
        (assert (not-require-database))
        (assert (asking-database-done))
    )
)

; Budget Limitation Question
(defrule ask-budget-limitation
    (asking-database-done)
    => 
    (printout t "Do you have limitation in budget ? (yes/no) " crlf)
    (bind ?res (read))
    (if (eq ?res yes)
        then 
        (assert (budget-limit))
        else
        (assert (not-budget-limit))
    )
)

; Recommendations

; no design, no db, no budget limit
(defrule recommend-!design-!db-!limit
    (not-require-design)
    (not-require-database)
    (not-budget-limit)
    => 
    (printout t "Based on your preferences, we recommend Online Branding Page website application." crlf)
)

; no design, no db, budget limit yes
(defrule recommend-!design-!db-limit
    (not-require-design)
    (not-require-database)
    (budget-limit)
    => 
    (printout t "Based on your preferences, we recommend Event Landing Page website application." crlf)
)

; no design, db yes, budget limit yes
(defrule recommend-!design-db-limit
    (not-require-design)
    (require-database)
    (budget-limit)
    => 
    (printout t "Based on your preferences, we recommend PKM website application." crlf)
)

; no design, db yes, no budget limit
(defrule recommend-!design-db-!limit
    (not-require-design)
    (require-database)
    (not-budget-limit)
    => 
    (printout t "Based on your preferences, we recommend Organization / Agency website application." crlf)
)

; design yes, no db, no budget limit
(defrule recommend-design-!db-!limit
    (require-design)
    (not-require-database)
    (not-budget-limit)
    => 
    (printout t "Based on your preferences, we recommend Online Branding Page website application with website design." crlf)
)

; design yes, no db, budget limit yes
(defrule recommend-design-!db-limit
    (require-design)
    (not-require-database)
    (budget-limit)
    => 
    (printout t "Based on your preferences, we recommend Event Landing Page website application with website design." crlf)
)

; design yes, db yes, budget limit yes
(defrule recommend-design-db-limit
    (require-design)
    (require-database)
    (budget-limit)
    => 
    (printout t "Based on your preferences, we recommend PKM website application with website design." crlf)
)

; design yes, db yes, no budget limit
(defrule recommend-design-db-!limit
    (require-design)
    (require-database)
    (not-budget-limit)
    => 
    (printout t "Based on your preferences, we recommend Organization / Agency website application with website design." crlf)
)


