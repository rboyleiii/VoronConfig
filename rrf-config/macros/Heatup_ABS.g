; Home and Level the gantry so we can park the carriage in the middle of the bed
G28
G32
M98 P"/macros/print_scripts/goto_bed_center.g"
M291 P"Heating up the bed and hotend..." R"Heat Up" T5
;M190 S100 ; wait
M140 S100 ; dont wait

; Set the hotend to 240C
;M291 P"Heating up the hotend..." R"Bed Mesh" T5
G10 P0 C200 S240
M116 ;wait for all
