if global.klicky_deployed = false 
	echo "***Probe Bed Error*** called without probe attached - aborting"
	abort

;;probe bed center and update klicky probe height
g1 z15 f4000
M98 P"/macros/print/goto_bed_center_xy.g"
g30 s-3
g1 z15 f4000