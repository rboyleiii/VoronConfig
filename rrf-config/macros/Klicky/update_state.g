; macro to check the magprobe triggered status
; global.klicky_deployed , true/false

M400

if sensors.probes[0].value[0] = 0
	set global.klicky_deployed = true
elif sensors.probes[0].value[0] = 1000
	set global.klicky_deployed = false

if global.klicky_debug = true
	echo "update_state.g - probe trigger value : " , sensors.probes[0].value[0]
	echo "update_state.g - klicky_deployed : " , global.klicky_deployed
