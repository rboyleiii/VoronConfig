;; In order to consolidate motor current and physics settings,
;; and to enable switching between full- and low-current profiles,
;; these motor settings live in this related set of macros.
;;
;; The "fullcurrent" files specify normal operating values.
;;
;; *ADJUST* all values. What works for you will depend on your build size,
;; motors, and the material of your printed printer parts.

M913 X100 Y100          ; restore motor current percentage to 100%
M906 X1300 Y1300        ; motor drive current

;M203 X21000 Y21000      ; maximum speed (mm/min)
M203 X18000 Y18000      ; maximum speed (mm/min)

M201 X3600 Y3200        ; maximum acceleration (mm/s²)
;M201 X2000 Y2000        ; maximum acceleration (mm/s²)

M566 X1100 900          ; instantaneous speed change / jerk (mm/min) 
;M566 X240 Y240          ; instantaneous speed change / jerk (mm/min)

;M593 F57                ; Dynamic Accelaration : filter 57Hz 
M593 F75               ; Dynamic Accelaration : filter 57Hz 
