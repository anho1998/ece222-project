** Designing Full Audio Amplifier**

Vdd VDD GND 12V
Vee VEE GND -12V
Vin input GND AC 0.3V

** First Stage **
XAMP1 Vpos1 Vneg1 VDD VEE out1 OPA2134
C1 2 Vpos1 0.47uF
R1 input 2 1k
R2 Vpos1 GND 9.1k
R3 Vneg1 GND 1k
R4 Vneg1 out1 30k
R5 out1 Vpos2 1.3k
C2 Vpos2 GND 15nF
R6 Vpos2 GND 10k

**Second Stage**
XAMP2 Vpos2 Vneg2 VDD VEE output flag OPA551
Rneg  Vneg2 GND 1k
Rload output GND 200


**Analysis
.op
.option post

.AC DEC 100 1 100kHz

**.PROBE AC VoltageGain1 = PAR('V(out1)/V(input)')
**.PROBE AC VoltageGain1_db = PAR('db(V(out1)/V(input))')

**.MEAS AC VoltageGainEnd = PARAM('V(output)/V(input)');
**.MEAS AC VoltageGainEnd_dB = PARAM('db(V(output)/V(input))')

**.PROBE AC CurrentGain1 = PAR('/(i(R5)-i(R6)-i(C2))')

**.MEAS AC in1_max max V(input)
**.MEAS AC out1_max max V(vpos2)
**.MEAS AC out2_max max V(output)

**.MEAS AC vgain1_max PARAM = ('out1_max/in1_max')
**.MEAS AC vgain2_max PARAM = ('out2_max/in1_max')

**.MEAS AC f1 WHEN PAR('VoltageGain1')='vgain_max/2'
**.MEAS AC f2 WHEN PAR('VoltageGainEnd')='vgain2_max/2'

**.PROBE AC Rin=PAR('V(input)/( i(R1)-i(R2))')
**.PROBE AC Rout=PAR('V(output)/(i(XAMP2.R02))') This needs to be double-checked

**.PROBE AC Pload = PAR('i(Rload)*i(Rload)*Rload')

.include 'OPA2134.LIB'
.include 'OPA551.LIB'
.include 'sedra_mod_lib'

.END
