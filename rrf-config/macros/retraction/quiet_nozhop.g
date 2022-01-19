;; Pressure Advance can make seams really pretty.
;; It's super noisy though, so I don't use it all the time.
;; This file configures simple retraction instead.
;;
;; *ADJUST* based on your retraction tuning WITHOUT pressure advance

;M207 S5 R0.0 F3600 T3600 Z0.00 ;Set retract length
;	Pn Tool number (optional, supported in RRF 3.01 and later only)
;	Snnn positive length to retract, in mm
;	Rnnn positive or negative additional length to un-retract, in mm, default zero
;	Fnnn retraction feedrate, in mm/min
;	Tnnn feedrate for un-retraction if different from retraction, mm/min (RepRapFirmware 1.16 and later only)
;	Znnn additional zlift/hop

M207 S0.4 R0.0 F3600 T3600 Z0.00

;M572 D0 S0.00 ;Set or report extruder pressure advance
;	Dnnn Extruder number(s)
;	Snnn Pressure advance amount (in seconds) to use for that extruder or extruders

M572 D0 S0.00