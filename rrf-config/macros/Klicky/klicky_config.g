;; Define and set variable and states.
if !exists(global.klicky_pickup_x)
	global klicky_pickup_x = 40 ; abs coord
if !exists(global.klicky_pickup_y)
	global klicky_pickup_y = 307 ; abs coord
if !exists(global.klicky_z_hop)
	global klicky_z_hop = 15 ; relative distance
if !exists(global.klicky_load_speed)
	global klicky_load_speed = 6000 ; relative distance
if !exists(global.klicky_debug) ; print debug info
	global klicky_debug = true

;; End of user config. No need to edit below

if !exists(global.klicky_deployed)
	global klicky_deployed = false ; init to false but we will need to check and actual state below
	
M98 P"/macros/klicky/update_state.g"; 


if global.klicky_debug = true
	echo "global.klicky_deployed defined. Value : " , global.klicky_deployed
	echo "global.klicky_debug defined. Value : " , global.klicky_debug
	echo "global.klicky_pickup_x defined. Value : " , global.klicky_pickup_x
	echo "global.klicky_pickup_y defined. Value : " , global.klicky_pickup_y
	echo "global.klicky_z_hop defined. Value : " , global.klicky_z_hop
	echo "global.klicky_load_speed defined. Value : " , global.klicky_load_speed

;; remove below

;if !exists(global.derack);
;	global derack = false

;if !exists(global.qgl)
;	global qgl = false

;if !exists(global.clicky_status)
;	global clicky_status = "none"

;if !exists(global.job_completion)
;	global job_completion = 0

; output current values
;echo "global.bed_temp defined. Value : " , global.bed_temp
;echo "global.hotend_temp defined. Value : " , global.hotend_temp
;echo "global.clicky_status defined. Value : " , global.clicky_status
;echo "global.job_completion defined. Value : " , global.job_completion
;echo "global.debug_mode defined. Value : " , global.debug_mode