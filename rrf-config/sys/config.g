; Configuration file for Duet 3 Mini 5+ (w/+2) (firmware version 3)
; executed by the firmware on start-up

;Global Vars
global LEDBrightness = 127
global bed_temp = 0
global hotend_temp = 0
global chamber_temp = 0

; General preferences
G90                                             ; send absolute coordinates...
M83                                             ; ...but relative extruder moves
M550 P"VORON2"                              	; set printer name
M669 K1 										; switch to CoreXY mode

; Network
M552 S1                                         ; enable network
M586 P0 S1                                      ; enable HTTP
M586 P1 S1                                       ; disable FTP
M586 P2 S0                                      ; disable Telnet

; Drives
M569 P0 S1 D2; Z 
M569 P1 S0 D2; Z2
M569 P2 S1 D2; Z3
M569 P3 S0 D2; Z4
M569 P4 S1 D2; Extruder
M569 P5 S1 D2; A
M569 P6 S1 D2; B

; Motor mapping and steps per mm
M584 X6 Y5 Z0:1:2:3 E4
M350 X16 Y16 Z16:16:16:16 E16 I1                   	; Use 1/16 microstepping with interpolation everywhere
M92 X80 Y80 Z400 E420								; Set XYZ steps per mm (1.8deg motors)

; Drive currents
M906 X1300 Y1300 Z1100 E900 I60 				; XYZ and E current @ 60%
M84 S100 ; Idle timeout

; Accelerations and speed
M566 X1100 Y900 Z120 E3000          			; instantaneous speed change / jerk (mm/min) 
M203 X18000 Y18000 Z5000 E5000 					; Set maximum speeds (mm/min)
M201 X3600 Y3200 Z500 E4000         			; maximum acceleration (mm/s²)
M204 P1500 T2000 								; Set printing acceleration and travel accelerations

M593 F75               							; Dynamic Accelaration : filter 57Hz 

; Axis Limits
M208 X0 Y0 Z-1.7 S1.   	    					; S1 = set axes minima
M208 X300 Y307 Z265 S0  					 	; S0 = set axes maxima

; Endstops
M574 X2 S1 P"io1.in"                            ; configure active-high endstop for high end on X via pin io0.in
M574 Y2 S1 P"io2.in"                            ; configure active-high endstop for high end on Y via pin io1.in
M574 Z0 P"nil" 									; No endstop

; Bed probe (inductive probe)
M558 K0 P8 C"io0.in" I0 H10 F1000:250 T18000 A5 S0.01  R0.2 B0
G31 K0 P1000 X0 Y25 Z7.745 ; klicky ---inductive probe offset, not critical, only used for coarse homing

; Tool probe (switch)
M558 K1 P8 C"io3.in" I0 H1 F250:25 T18000 A5 S0.01 R0.2 B0
G31 K1 P1000 X0 Y0 Z0.970	

; Bed leveling params
M671 X-58:-58:358:358 Y8:370:370:8 S20	        ; Z leadscrews positions
M557 X10:290 Y30:290 S20 						; define mesh grid

;; firmware retraction and pressure advance-------------------------------------
M207 S2 R0.0 F9000 Z0.00						; Z0 = nohop, S retract
M572 D0 S0.06

;Bed heater dual thermistor setup
M308 S0 P"temp0" Y"thermistor" T100000 B3950 A"Bed Pad"   ; configure sensor 0 as thermistor on pin bedtemp (pad sensor)
M308 S2 P"temp2" Y"thermistor" T100000 B3950 A"Bed Plate"  ; configure sensor 2 as thermistor on pin e1temp (plate sensor)
M950 H0 C"out0" T2 Q10                                      ; create bed heater output on out0 and map it to sensor 2 (plate sensor). Set PWM frequency to 10Hz
M140 P0 H0                                                  ; Mark heater H0 as bed heater (for DWC)
M143 H0 P1 T0 A2 S118 C0                                    ; Regulate (A2) bed heater (H0) to have pad sensor (T0) below 110°C. Use Heater monitor 1 for it
M143 H0 P2 T0 A1 S125 C0                                    ; Shut off (A1) bed heater (H0) if pad sensor (T0) exceeds 120°C. Use Heater monitor 2 for it
M143 H0 S120                                                ; Set bed heater max temperature to 110°C, use implict monitor 0 which is implicitly configured for heater fault
M307 H0 B1 S0.6                                             ; Enable Bang Bang mode and set PWM to 60% to avoid warping

;HotEnd
M308 S1 P"temp1" Y"thermistor" T100000 B4725 C7.060000e-8 A"Hotend" 			; configure sensor 1 as thermistor (ATC Semitec 104GT2)
M950 H1 C"out1" T1                                        	; create nozzle heater output on e0heat and map it to sensor 1
M143 H1 S285                                               	; set temperature limit for heater 1 to 300°C
;M307 H1 R1.716 C253.2:196.4 D6.86 S1.00 B0 V24.2
M307 H1 R1.768 K0.341:0.092 D6.41 E1.35 S1.00 B0 V24.2 ; tuned to E3D V6

; Define MCU sensors which will be available in DWC Extra View
M308 S3 Y"mcu-temp" A"MCU"

; temp daughter board
M308 S4 P"spi.cs1" Y"rtd-max31865" A"Chamber Temp"; create sensor number 4 as a PT100 sensor in the first position on the Duet 3 mini 5+ daughter board connector
;M308 S5 P"spi.cs2" Y"rtd-max31865" ; create sensor number 5 as a PT100 sensor in the second position on the Duet 3 mini 5+ daughter board connector

;FANS----------------------------------------------------
;part cooler
M950 F0 C"out6" Q20               ; part cooler, set to 20Hz PWM
M106 P0 C"PartCooler" H-1            ; Name it "PartCooler"
;Hot End
M950 F1 C"out5" Q20               ; hotend fan, set to 20Hz PWM
M106 P1 T50:70 H1 C"ToolFan"         ; attach hotend fan to heater 1 and set activation temperature to 60°C
;controller / electronics fan
M950 F2 C"out4" Q20            ; electronics compartment fan on duex, set to 20Hz PWM
M106 P2 H3 T35:50 C"ElectronicsFan" ; fan is activated when MCU reports 35°C; runs on full speed from 50°C on
; chamber Fan
M950 F3 C"out3" Q20          ; chamber fan on duex, set to 20Hz PWM
M106 P3 T40:46 H4 C"ChamberFan"   ; Chamberfan is activated when bed plate reaches 40°C; runs on full speed from 45°C on

; Tools
M563 P0 D0 H1 
G10 P0 X0 Y0 Z0                                 ; set tool 0 axis offsets
G10 P0 R0 S0                                    ; set initial tool 0 active and standby temperatures to 0C

; define accelerometer
M955 P0 C"io4.out+io4.in"

;Miscellaneous---------------------------------------------------
;;cold extrusion
;M302 ; Report current state
;M302 P1 ; Allow cold extrusion
;M302 S120 R110 ; Allow extrusion starting from 120°C and retractions already from 110°C

;LCD
M918 P2 E4 F2000000  					; Fysetc 12864mini
M150 X2 R255 U0 B255 P225 S1 F1           ; display led
M150 X2 R255 U0 B255 P127 S1 F1	         ; left encoder led
M150 X2 R255 U0 B255 P127 S1 F0           ; right encoder led

;LED Init state
M150 X1 Q3000000           ; set LED type to NeoPixel and set SPI frequency to 3MHz
M150 R255 U0   B0  P127 S7 F1  ;back red  
M150 R255 U255 B255 P127 S7 F1   ;left side white
M150 R255 U255 B255 P127 S7 F1   ; front white
M150 R255 U255 B255 P127 S7   ; right side white F0=done

;Disable Homing and below 0 moves
;M564 S0 H0										;Limit Axis Hnnn H1 = forbid h0 = allow movement of axes that have not been homed, Snnn S1 = limit movement within axis boundaries, S0 = allow movement outside boundaries
M564 H0 ; allow axis to move without homeing

M98 P"/macros/klicky/klicky_config.g"