; ; Implement Expert System with certainly factors

; ; ! Rules

; (defrule rule1 (today-is-rain)
;     => 
;      (assert (tommorow-is-rain 0.5))
;      (printout t "What is the rainfall today? (low/high)" crlf)
;      ; just consider user always answer low 
;      (bind ?res (read))
     
;      (if (eq ?res low)
;         then 
;         (assert (rainfall-is-low))
;         (printout t "To what degree do you believe the rainfall is low. Enter a numeric certainty between 0 and 1.0 inclusive." crlf)
;         (bind ?res (read))
        
;         else
;         (assert (rainfall-is-high))
;         (printout t "To what degree do you believe the rainfall is high. Enter a numeric certainty between 0 and 1.0 inclusive." crlf)
;         (bind ?res (read))
;      )

; )

; (defrule rule2 (today-is-dry)
;     => 
;     (assert (today-is-dry 0.5))
;     (printout t "What is the rainfall today? (low/high)" crlf)
;     ; just consider user always answer low 
;     (bind ?res (read))
   
;     (if (eq ?res low)
;         then 
;         (assert (rainfall-is-low))
;         (printout t "To what degree do you believe the rainfall is low. Enter a numeric certainty between 0 and 1.0 inclusive." crlf)
;         (bind ?res (read))
;         else
;         (assert (rainfall-is-high))
;          (printout t "To what degree do you believe the rainfall is high. Enter a numeric certainty between 0 and 1.0 inclusive." crlf)
;         (bind ?res (read))
;     )

; )

; (defrule rule3 (today-is-rain) (rainfall-is-low)
;     =>
;     (assert (tommorow-is-dry 0.6))
; )

; (defrule rule4 (today-is-rain) (rainfall-is-low) (temperature-is-cold)
;     =>
;     (assert (tommorow-is-dry 0.7))
; )

; (defrule rule5 (today-is-dry) (temperature-is-warm)
;     =>
;     (assert (tommorow-is-rain 0.65))
; )

; (defrule rule6 (today-is-dry) (temperature-is-warm) (sky-is-overcast)
;     =>
;     (assert (tommorow-is-rain 0.55))
; )

; ; ! Greet

; (defrule main (not (greeting-done))
;     =>
;     (printout t "Hello, I am an expert system to predict the weather. Please answer the following questions." crlf)
;     (printout t "What is the weather today? (rain/dry)" crlf)
;     (bind ?res (read))
;     (if (eq ?res rain)
;         then 
;         (assert (today-is-rain))
;         (assert (greeting-done))
;         else 
;         (assert (today-is-dry))
;         (assert (greeting-done))
;     )
; )

(deftemplate Weather 
    (slot temperature)
    (slot humidity)
)

(deftemplate Recommendation
    (slot forecast)
    (slot certainty-factor (type NUMBER))
)

(defrule main-lop
    (not (done))
    => 
    
)