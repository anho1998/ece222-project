** Designing Full Audio Amplifier**

.op
.option post

Vdd VDD GND 12V
Vee VEE GND -12V
Vin input GND AC 0.3V

**Second Stage**
XAMP2 input Vneg2 VDD VEE output GND OPA551
R7 Vneg2 GND 1k
Rload output GND 200


**Analysis
.AC DEC 100 1 100kHz

.MEAS AC VoltageGainEnd = PARAM('V(output)/V(input)');
.MEAS AC VoltageGainEnd_dB = PARAM('db(V(output)/V(input))')

.MEAS AC in1_max max V(input)
.MEAS AC out2_max max V(output)
.MEAS AC vgain2_max PARAM = ('out2_max/in1_max')
.MEAS AC f2 WHEN PAR('VoltageGainEnd')='vgain2_max/2'

**.PROBE AC Pload = PAR('i(Rload)*i(Rload)*Rload')

.include 'OPA2134.LIB'
.include 'OPA551.LIB'
.include 'sedra_mod_lib'
