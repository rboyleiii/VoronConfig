var cur_x = {move.axes[0].userPosition}
var cur_y = {move.axes[1].userPosition}

if global.klicky_debug = true
	echo "current userPosition position",{move.axes[0].userPosition},{move.axes[1].userPosition},{move.axes[2].userPosition}

; Home if needed
M98 P"0:/macros/Home/Home_xy"
M98 P"0:/macros/Home/Home_z"

; Macro to load klicky
M98 P"/macros/klicky/update_state.g" ;update state

if global.klicky_deployed = false
	; approach the dock
	G91                ; relative positioning
	G1 Z{global.klicky_z_hop} F{global.klicky_load_speed}
	G90
	G1 Y{global.klicky_pickup_y-50}
	G1 X{global.klicky_pickup_x}
	G1 Y{global.klicky_pickup_y}
	G4 P200 ; wait for 200ms
	G1 Y{global.klicky_pickup_y-50}
	
	;;check attached, if not abort
	
	G1 X{var.cur_x}
	G1 Y{var.cur_y}
	G91
	G1 Z{0-global.klicky_z_hop}
	G90
	M400
	
M98 P"/macros/klicky/update_state.g" ;update state	
if global.klicky_deployed = true 
	if global.klicky_debug = true
		echo "klicky_load.g - Probe Attached"
else
	echo "***Klicky Error*** klicky_load.g - probe not attached - aborting"
	abort
	
; finish	