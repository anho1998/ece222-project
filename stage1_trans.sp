.op
.option post

**CIRCUIT DESCRIPTION**
Vdd VDD GND 500V
Vee VEE GND -500V

*Vin 1 GND AC 0.3V
Vin 1 GND SIN (0 0.9V 500Hz)

** COMPONENTS **
XAMP1 Vpos Vneg VDD VEE out OPA2134
C1 2 Vpos .47uF
R1 1 2 1k
R2 Vpos GND 9.1k
R3 Vneg GND 1k
R4 Vneg out 35k
R5 out next 1.3k
C2 next GND 15nF
R6 next GND 10k

**ANALYSIS **
*.DC Vin 0 3.3 0.1 
*.AC DEC 100 0.1 100kHz 
.TRAN 1ns 10ms 
**OUTPUT
**.PLOT i(MNQ2) 

*.PLOT DC gain=PAR('i(MNQ2)/i(MNQ1)')
*.PROBE AC rout=PAR('v(Vout)/i(R5)')
*.PROBE AC gain=PAR('v(out)/v(1)')
*.PROBE AC gain_db=PAR('db(v(out)/v(1))')
*.MEAS AC fh WHEN PAR('gain_db')=-3 
*.MEAS DC gain_var PARAM = 'v(out)/v(1)'
**.MEAS DC v FIND v(out) WHEN PAR('gain') = 10
**.MEAS DC id FIND i(MNQ2) WHEN v(out)= 0.6
**
**.MEAS DC dev1 DERIV I(MNQ2) WHEN V(out) = 0.6
**.MEAS DC Rout1 PARAM = '1/dev1'
**
**.MEAS DC dev2 DERIV I(MNQ2) WHEN V(out) = 1
**.MEAS DC Rout2 PARAM = '1/dev2'

**.MEAS DC dev3 DERIV I(MNQ2) WHEN V(out) = 0.7
**.PLOT DC ro3=PAR('1/dev3')

** MODELS **
.include 'OPA2134.LIB'
.include 'sedra_mod_lib'
*.include 'OPA134.lib'
.END

