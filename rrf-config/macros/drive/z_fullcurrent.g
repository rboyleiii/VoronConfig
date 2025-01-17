;; In order to consolidate motor current and physics settings,
;; and to enable switching between full- and low-current profiles,
;; these motor settings live in this related set of macros.
;;
;; The "fullcurrent" files specify normal operating values.
;;
;; *ADJUST* all values

M913 Z100       ; restore motor current percentage to 100%
M906 Z1100       ; motor drive current
M203 Z8000      ; maximum speed (mm/min)
M201 Z500       ; maximum acceleration (mm^2/s)
M566 Z120       ; instantaneous speed change (mm/min)