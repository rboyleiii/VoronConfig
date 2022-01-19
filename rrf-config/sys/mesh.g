; mesh.g
; called before G29 is executed
; Home, but only if homing is needed
;if !move.axes[0].homed || !move.axes[1].homed ;home xy if needed,'
;	G28 XY
;G28 Z ; always home z

G32

; Ensure Z is higher than inductive probe trigger height
G1 Z15

while global.klicky_deployed=false
	M98 P"/macros/klicky/klicky_load.g"
	
M98 P"/macros/Probe_bed_center.g"

G29 S0

while global.klicky_deployed=true
	M98 P"/macros/klicky/klicky_park.g"

; Done, move to center and turn off heat
M98 P"/macros/print/goto_bed_center_xy.g"

; called after G29 is executed
G28 Z