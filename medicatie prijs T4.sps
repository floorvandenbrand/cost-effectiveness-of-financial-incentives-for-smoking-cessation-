
* Encoding: UTF-8.


** om de variabelen op volgorde te hebben staan, eerst variabelen aanmaken.
COMPUTE  med1_recept=$SYSMIS.
COMPUTE  med1_ppp=$SYSMIS.
COMPUTE  med2_recept=$SYSMIS.
COMPUTE  med2_ppp=$SYSMIS.
COMPUTE  med3_recept=$SYSMIS.
COMPUTE  med3_ppp=$SYSMIS.
COMPUTE  med4_recept=$SYSMIS.
COMPUTE  med4_ppp=$SYSMIS.
COMPUTE  med5_recept=$SYSMIS.
COMPUTE  med5_ppp=$SYSMIS.
COMPUTE  med6_recept=$SYSMIS.
COMPUTE  med6_ppp=$SYSMIS.
COMPUTE  med7_recept=$SYSMIS.
COMPUTE  med7_ppp=$SYSMIS.
COMPUTE  med8_recept=$SYSMIS.
COMPUTE  med8_ppp=$SYSMIS.
COMPUTE  med9_recept=$SYSMIS.
COMPUTE  med9_ppp=$SYSMIS.
COMPUTE  med10_recept=$SYSMIS.
COMPUTE  med10_ppp=$SYSMIS.
EXECUTE.
FORMATS med1_recept med2_recept med3_recept med4_recept med5_recept med6_recept  med7_recept  med8_recept med9_recept med10_recept (F1.0). 
MISSING VALUES med1_ppp med2_ppp med3_ppp med4_ppp med5_ppp med6_ppp med7_ppp med8_ppp med9_ppp med10_recept(999).
VARIABLE LEVEL med1_ppp med2_ppp med3_ppp med4_ppp med5_ppp med6_ppp med7_ppp med8_ppp med9_ppp med10_recept(SCALE).
VARIABLE WIDTH  med1_ppp med2_ppp med3_ppp med4_ppp med5_ppp med6_ppp med7_ppp med8_ppp med9_ppp med10_recept (7).
VARIABLE WIDTH med1_recept med2_recept med3_recept med4_recept med5_recept med6_recept  med7_recept  med8_recept med9_recept med10_recept (4). 

**ATC V03AE01.
IF  (atc6_T4='V03AE01') med6_recept=0.
IF  (atc6_T4='V03AE01' and med6_dosis_T4='15') med6_ppp=0.67.
**ATC V03AB33.
IF  (atc2_T4='V03AB33') med2_recept=0.
IF  (atc2_T4='V03AB33' and med2_dosis_T4='1 injectie') med2_ppp=0.70.
**ATC V01AA02.
IF  (atc1_T4='V01AA02') med1_recept=1.
IF  (atc1_T4='V01AA02' and med1_dosis_T4='300')  med1_ppp=3.32.
**ATC S01EC01.
IF  (atc1_T4='S01EC01') med1_recept=1.
IF  (atc1_T4='S01EC01' and med1_dosis_T4='250') med1_ppp=0.21.
**ATC S01BA04.
IF  (atc3_T4='S01BA04') med3_recept=1.
**ATC R06AX27 - Aereus.
IF  (atc2_T4='R06AX27') med2_recept=1.
IF  (atc2_T4='R06AX27' and med2_dosis_T4='') med2_ppp=0.03.
IF  (atc2_T4='R06AX27' and med2_dosis_T4='5') med2_ppp=0.03.
IF  (atc3_T4='R06AX27') med3_recept=1.
IF  (atc3_T4='R06AX27' and med3_dosis_T4='5') med3_ppp=0.03.
IF  (atc4_T4='R06AX27') med4_recept=1.
IF  (atc4_T4='R06AX27' and med4_dosis_T4='') med4_ppp=0.03.
IF  (atc5_T4='R06AX27') med5_recept=1.
IF  (atc5_T4='R06AX27' and med5_dosis_T4='') med5_ppp=0.03.
IF  (atc7_T4='R06AX27') med7_recept=1.
IF  (atc7_T4='R06AX27' and med7_dosis_T4='') med7_ppp=0.03.
IF  (atc9_T4='R06AX27') med9_recept=1.
IF  (atc9_T4='R06AX27' and med9_dosis_T4='') med9_ppp=0.03.
**ATC R06AX25 - Mizolastine.
IF  (atc4_T4='R06AX25') med4_recept=1.
IF  (atc4_T4='R06AX25' and med4_dosis_T4='') med4_ppp=0.29.
IF  (atc5_T4='R06AX25') med5_recept=1.
IF  (atc5_T4='R06AX25' and med5_dosis_T4='10') med5_ppp=0.29.
**ATC R06AX13 - .
IF  (atc1_T4='R06AX13') med1_recept=1.
IF  (atc1_T4='R06AX13' and med1_dosis_T4='10') med1_ppp=0.20.
**ATC R06AE07.
IF  (atc1_T4='R06AE07') med1_recept=0.
IF  (atc1_T4='R06AE07' and med1_dosis_T4='10') med1_ppp=0.18.
IF  (atc2_T4='R06AE07') med2_recept=0.
IF  (atc2_T4='R06AE07' and med2_dosis_T4='10') med2_ppp=0.18.
IF  (atc3_T4='R06AE07') med3_recept=0.
IF  (atc3_T4='R06AE07' and med3_dosis_T4='') med3_ppp=0.18.
IF  (atc5_T4='R06AE07') med5_recept=0.
IF  (atc5_T4='R06AE07' and med5_dosis_T4='2x10') med5_ppp=0.36.
**ATC R05DA04 codeine.
IF  (atc2_T4='R05DA04') med2_recept=1.
IF  (atc2_T4='R05DA04' and med2_dosis_T4='') med2_ppp=0.21.
IF  (atc3_T4='R05DA04') med3_recept=1.
IF  (atc3_T4='R05DA04' and med3_dosis_T4='10') med3_ppp=0.21.
IF  (atc8_T4='R05DA04') med8_recept=1.
IF  (atc8_T4='R05DA04' and med8_dosis_T4='20') med8_ppp=0.34.
**ATC R05CB01.
IF  (atc1_T4='R05CB01') med1_recept=1.
IF  (atc1_T4='R05CB01' and med1_dosis_T4='600') med1_ppp=0.34.
IF  (atc1_T4='R05CB01' and med1_dosis_T4='') med1_ppp=0.25.
IF  (atc2_T4='R05CB01') med2_recept=1.
IF  (atc2_T4='R05CB01' and med2_dosis_T4='600') med2_ppp=0.34.
**ATC R03DC03 .
IF  (atc4_T4='R03DC03') med4_recept=1.
IF  (atc4_T4='R03DC03' and med4_dosis_T4='10') med4_ppp=0.04.
IF  (atc7_T4='R03DC03') med7_recept=1.
IF  (atc7_T4='R03DC03' and med7_dosis_T4='10') med7_ppp=0.04.
**ATC R03CC02 Salbutamol/ Ventolin.
IF  (atc1_T4='R03CC02') med1_recept=1.
IF  (atc1_T4='R03CC02' and med1_dosis_T4='200') med1_ppp=999.
IF  (atc1_T4='R03CC02' and med1_dosis_T4='250') med1_ppp=999.
IF  (atc1_T4='R03CC02' and med1_dosis_T4='') med1_ppp=999.
IF  (atc2_T4='R03CC02') med2_recept=1.
IF  (atc2_T4='R03CC02' and med2_dosis_T4='200') med2_ppp=999.
IF  (atc2_T4='R03CC02' and med2_dosis_T4='250') med2_ppp=999.
IF  (atc2_T4='R03CC02' and med2_dosis_T4='100') med2_ppp=999.
IF  (atc2_T4='R03CC02' and med2_dosis_T4='5 (vloeistof)') med2_ppp=999.
IF  (atc2_T4='R03CC02' and med2_dosis_T4='') med2_ppp=999.
IF  (atc3_T4='R03CC02') med3_recept=1.
IF  (atc3_T4='R03CC02' and med3_dosis_T4='') med3_ppp=999.
IF  (atc4_T4='R03CC02') med4_recept=1.
IF  (atc4_T4='R03CC02' and med4_dosis_T4='200') med4_ppp=999.
IF  (atc5_T4='R03CC02') med5_recept=1.
IF  (atc5_T4='R03CC02' and med5_dosis_T4='') med5_ppp=999.
**ATC R03BB04 -Spiriva.
IF  (atc1_T4='R03BB04') med1_recept=1.
IF  (atc1_T4='R03BB04' and med1_dosis_T4='18') med1_ppp=1.34.
IF  (atc2_T4='R03BB04') med2_recept=1.
IF  (atc2_T4='R03BB04' and med2_dosis_T4='2x2,5 vloeistof') med2_ppp=1.14.
IF  (atc2_T4='R03BB04' and med2_dosis_T4='18') med2_ppp=1.34.
IF  (atc3_T4='R03BB04') med3_recept=1.
IF  (atc3_T4='R03BB04' and med3_dosis_T4='18') med3_ppp=1.34.
IF  (atc4_T4='R03BB04') med4_recept=1.
IF  (atc4_T4='R03BB04' and med4_dosis_T4='18') med4_ppp=1.34.
**ATC R03BB01.
IF  (atc2_T4='R03BB01') med2_recept=1.
IF  (atc2_T4='R03BB01' and med2_dosis_T4=' ') med2_ppp=0.03.
IF  (atc7_T4='R03BB01') med7_recept=1.
IF  (atc7_T4='R03BB01' and med7_dosis_T4=' ') med7_ppp=0.03.
**ATC R03BA05 flixotide.
IF  (atc1_T4='R03BA05') med1_recept=1.
IF  (atc1_T4='R03BA05' and med1_dosis_T4=' ') med1_ppp=0.07.
IF  (atc3_T4='R03BA05') med3_recept=1.
IF  (atc3_T4='R03BA05' and med3_dosis_T4=' ') med3_ppp=0.07.
IF  (atc3_T4='R03BA05' and med3_dosis_T4='250') med3_ppp=0.27.
IF  (atc5_T4='R03BA05') med5_recept=1.
IF  (atc5_T4='R03BA05' and med5_dosis_T4='100') med5_ppp=0.15.
IF  (atc8_T4='R03BA05') med8_recept=1.
IF  (atc8_T4='R03BA05' and med8_dosis_T4='50') med8_ppp=0.07.
IF  (atc8_T4='R03BA05' and med8_dosis_T4='') med8_ppp=0.07.
**ATC R03BA02- pulmicort.
IF  (atc1_T4='R03BA02') med1_recept=1.
IF  (atc1_T4='R03BA02' and med1_dosis_T4='200') med1_ppp=0.12.
IF  (atc1_T4='R03BA02' and med1_dosis_T4='') med1_ppp=0.07.
IF  (atc3_T4='R03BA02') med3_recept=1.
IF  (atc3_T4='R03BA02' and med3_dosis_T4='') med3_ppp=0.07.
IF  (atc5_T4='R03BA02') med5_recept=1.
IF  (atc5_T4='R03BA02' and med5_dosis_T4='') med5_ppp=0.07.
**ATC R03BA01-  beclomethason.
IF  (atc1_T4='R03BA01') med1_recept=1.
IF  (atc1_T4='R03BA01' and med1_dosis_T4='') med1_ppp=0.03.
IF  (atc2_T4='R03BA01') med2_recept=1.
IF  (atc2_T4='R03BA01' and med2_dosis_T4=' ') med2_ppp=0.03.
IF  (atc2_T4='R03BA01' and med2_dosis_T4='50') med2_ppp=0.03.
IF  (atc3_T4='R03BA01') med3_recept=1.
IF  (atc3_T4='R03BA01' and med3_dosis_T4=' ') med3_ppp=0.03.
IF  (atc3_T4='R03BA01' and med3_dosis_T4='50') med3_ppp=0.03.
IF  (atc8_T4='R03BA01') med8_recept=1.
IF  (atc8_T4='R03BA01' and med8_dosis_T4='200 (poeder)') med8_ppp=0.10.
IF  (atc1_T4='R03BA01' and med1_dosis_T4='100') med1_ppp=0.07.
**ATC R03AK10.
IF  (atc1_T4='R03AK10') med1_recept=1.
IF  (atc1_T4='R03AK10' and med1_dosis_T4='92/22') med1_ppp=1.07.
IF  (atc2_T4='R03AK10') med2_recept=1.
IF  (atc2_T4='R03AK10' and med2_dosis_T4='92/22') med2_ppp=1.07.
IF  (atc4_T4='R03AK10') med4_recept=1.
IF  (atc4_T4='R03AK10' and med4_dosis_T4='') med4_ppp=1.07.
**ATC R03AK08- foster.
IF  (atc1_T4='R03AK08') med1_recept=1.
IF  (atc1_T4='R03AK08' and med1_dosis_T4='') med1_ppp=0.33.
IF  (atc2_T4='R03AK08') med2_recept=1.
IF  (atc2_T4='R03AK08' and med2_dosis_T4='') med2_ppp=0.33.
IF  (atc6_T4='R03AK08') med6_recept=1.
IF  (atc6_T4='R03AK08' and med6_dosis_T4='') med6_ppp=0.33.
IF  (atc8_T4='R03AK08') med8_recept=1.
IF  (atc8_T4='R03AK08' and med8_dosis_T4='') med8_ppp=0.33.
**ATC R03AK07 symbicort (poeder en inhalator is hetzelfde).
IF  (atc1_T4='R03AK07') med1_recept=1.
IF  (atc1_T4='R03AK07' and med1_dosis_T4='400/12') med1_ppp=0.65.
IF  (atc2_T4='R03AK07') med2_recept=1.
IF  (atc2_T4='R03AK07' and med2_dosis_T4='') med2_ppp=0.33.
IF  (atc2_T4='R03AK07' and med2_dosis_T4='100/6') med2_ppp=0.34.
IF  (atc3_T4='R03AK07') med3_recept=1.
IF  (atc3_T4='R03AK07' and med3_dosis_T4='200/6') med3_ppp=0.33.
IF  (atc6_T4='R03AK07') med6_recept=1.
IF  (atc6_T4='R03AK07' and med6_dosis_T4='200/6') med6_ppp=0.33.
**ATC R03AK06 seretide.
IF  (atc1_T4='R03AK06') med1_recept=1.
IF  (atc1_T4='R03AK06' and med1_dosis_T4='') med1_ppp=0.27.
IF  (atc1_T4='R03AK06' and med1_dosis_T4='50/?') med1_ppp=0.41.
IF  (atc1_T4='R03AK06' and med1_dosis_T4='25/250') med1_ppp=0.27.
IF  (atc2_T4='R03AK06') med2_recept=1.
IF  (atc2_T4='R03AK06' and med2_dosis_T4='') med2_ppp=0.27.
IF  (atc3_T4='R03AK06') med3_recept=1.
IF  (atc3_T4='R03AK06' and med3_dosis_T4='50/500') med3_ppp=0.73.
IF  (atc4_T4='R03AK06') med4_recept=1.
IF  (atc4_T4='R03AK06' and med4_dosis_T4='2x25/125') med4_ppp=0.36.
IF  (atc4_T4='R03AK06' and med4_dosis_T4='25/250') med4_ppp=0.27.
IF  (atc5_T4='R03AK06') med5_recept=1.
IF  (atc5_T4='R03AK06' and med5_dosis_T4='') med5_ppp=0.27.
**ATC R03AC13 - formoterol.
IF  (atc1_T4='R03AC13') med1_recept=1.
IF  (atc1_T4='R03AC13' and med1_dosis_T4='12') med1_ppp=0.23.
IF  (atc2_T4='R03AC13') med2_recept=1.
IF  (atc2_T4='R03AC13' and med2_dosis_T4='12') med2_ppp=0.23.
IF  (atc3_T4='R03AC13') med3_recept=1.
IF  (atc3_T4='R03AC13' and med3_dosis_T4='') med3_ppp=0.23.
**ATC R03AC12- salmeterol.
IF  (atc5_T4='R03AC12') med5_recept=1.
IF  (atc5_T4='R03AC12' and med5_dosis_T4='25') med5_ppp=0.23.
**ATC R03AC03.
IF  (atc2_T4='R03AC03') med2_recept=1.
IF  (atc2_T4='R03AC03' and med2_dosis_T4='500') med2_ppp=0.07.
IF  (atc2_T4='R03AC03' and med2_dosis_T4='') med2_ppp=0.07.
IF  (atc5_T4='R03AC03') med5_recept=1.
IF  (atc5_T4='R03AC03' and med5_dosis_T4='500') med5_ppp=0.07.
**ATC R03AC02 - ventolin/salbutamol.
IF  (atc1_T4='R03AC02') med1_recept=1.
IF  (atc1_T4='R03AC02' and med1_dosis_T4='100') med1_ppp=0.02.
IF  (atc1_T4='R03AC02' and med1_dosis_T4='200') med1_ppp=0.05.
IF  (atc1_T4='R03AC02' and med1_dosis_T4='') med1_ppp=0.02.
IF  (atc2_T4='R03AC02') med2_recept=1.
IF  (atc2_T4='R03AC02' and med2_dosis_T4='') med2_ppp=0.02.
IF  (atc2_T4='R03AC02' and med2_dosis_T4='200') med2_ppp=0.05.
IF  (atc2_T4='R03AC02' and med2_dosis_T4='100') med2_ppp=0.02.
IF  (atc2_T4='R03AC02' and med2_dosis_T4='5 (vloeistof)') med2_ppp=0.17.
IF  (atc3_T4='R03AC02') med3_recept=1.
IF  (atc3_T4='R03AC02' and med3_dosis_T4='') med3_ppp=0.02.
IF  (atc4_T4='R03AC02') med4_recept=1.
IF  (atc4_T4='R03AC02' and med4_dosis_T4='') med4_ppp=0.02.
IF  (atc4_T4='R03AC02' and med4_dosis_T4='100') med4_ppp=0.02.
IF  (atc4_T4='R03AC02' and med4_dosis_T4='200') med4_ppp=0.05.
IF  (atc5_T4='R03AC02') med5_recept=1.
IF  (atc5_T4='R03AC02' and med5_dosis_T4='') med5_ppp=0.02.
IF  (atc6_T4='R03AC02') med6_recept=1.
IF  (atc6_T4='R03AC02' and med6_dosis_T4='') med6_ppp=0.02.
**ATC R02AX01.
IF  (atc3_T4='R02AX01') med3_recept=1.
IF  (atc3_T4='R02AX01' and med3_dosis_T4='8,75') med3_ppp=0.33.
**ATC R02AA03.
IF  (atc1_T4='R02AA03') med1_recept=1.
IF  (atc1_T4='R02AA03' and med1_dosis_T4='0,6/1,2') med1_ppp=0.23.
**ATC R01AX06.
IF  (atc1_T4='R01AX06') med1_recept=1.
IF  (atc1_T4='R01AX06' and med1_dosis_T4='20') med1_ppp=999.
**ATC R01AD12.
IF  (atc1_T4='R01AD12') med1_recept=1.
IF  (atc1_T4='R01AD12' and med1_dosis_T4='') med1_ppp=0.07.
IF  (atc4_T4='R01AD12') med4_recept=1.
IF  (atc4_T4='R01AD12' and med4_dosis_T4='') med4_ppp=0.07.
**ATC R01AD08 - fluticason.
IF  (atc2_T4='R01AD08') med2_recept=1.
IF  (atc2_T4='R01AD08' and med2_dosis_T4='') med2_ppp=0.01.
IF  (atc3_T4='R01AD08') med3_recept=1.
IF  (atc3_T4='R01AD08' and med3_dosis_T4='50 (spray)') med3_ppp=0.01.
IF  (atc5_T4='R01AD08') med5_recept=1.
IF  (atc5_T4='R01AD08' and med5_dosis_T4='50 (spray)') med5_ppp=0.01.
**ATC R01AD05- budesonide.
IF  (atc2_T4='R01AD05') med2_recept=1.
IF  (atc2_T4='R01AD05' and med2_dosis_T4='100 (spray)') med2_ppp=0.03.
IF  (atc3_T4='R01AD05') med3_recept=1.
IF  (atc3_T4='R01AD05' and med3_dosis_T4='') med3_ppp=0.03.
IF  (atc6_T4='R01AD05') med6_recept=1.
IF  (atc6_T4='R01AD05' and med6_vorm_T4='Spray') med6_ppp=0.03.
**ATC P01BB51- malaria.
IF  (atc7_T4='P01BB51') med7_recept=1.
IF  (atc7_T4='P01BB51' and med7_dosis_T4='250/100') med7_ppp=2.23.
**ATC P01AB01.
IF  (atc3_T4='P01AB01') med3_recept=1.
IF  (atc3_T4='P01AB01' and med3_dosis_T4='500') med3_ppp=0.22.
**ATC P01BA02.
IF  (atc2_T4='P01BA02') med2_recept=1.
IF  (atc2_T4='P01BA02' and med2_dosis_T4='200') med2_ppp=0.13.
**ATC N07XX09.
IF  (atc2_T4='N07XX09') med2_recept=1.
IF  (atc2_T4='N07XX09' and med2_dosis_T4='2x120') med2_ppp=2.30.
**ATC N07BC02 - metahdon.
IF  (atc6_T4='N07BC02') med6_recept=1.
IF  (atc6_T4='N07BC02' and med6_dosis_T4='' and Med6_vorm_T4='drank') med6_ppp=1.32.
**ATC N07BA03 Champix.
IF  (atc1_T4='N07BA03') med1_recept=1.
IF  (atc1_T4='N07BA03' and med1_dosis_T4='0.5') med1_ppp=1.71.
IF  (atc1_T4='N07BA03' and med1_dosis_T4='1') med1_ppp=1.71.
IF  (atc1_T4='N07BA03' and med1_dosis_T4='2x1') med1_ppp=3.41.
IF  (atc1_T4='N07BA03' and med1_dosis_T4='') med1_ppp=1.71.
IF  (atc2_T4='N07BA03') med2_recept=1.
IF  (atc2_T4='N07BA03' and med2_dosis_T4='') med2_ppp=1.71.
IF  (atc2_T4='N07BA03' and med2_dosis_T4='0.5') med2_ppp=1.71.
IF  (atc2_T4='N07BA03' and med2_dosis_T4='1') med2_ppp=1.71.
IF  (atc2_T4='N07BA03' and med2_dosis_T4='2x1') med2_ppp=3.41.
IF  (atc3_T4='N07BA03') med3_recept=1.
IF  (atc3_T4='N07BA03' and med3_dosis_T4='') med3_ppp=1.71.
IF  (atc4_T4='N07BA03') med4_recept=1.
IF  (atc4_T4='N07BA03' and med4_dosis_T4='1') med4_ppp=1.71.
IF  (atc4_T4='N07BA03' and med4_dosis_T4='2x1') med4_ppp=3.41.
IF  (atc4_T4='N07BA03' and med4_dosis_T4='') med4_ppp=1.71.
IF  (atc5_T4='N07BA03') med5_recept=1.
IF  (atc5_T4='N07BA03' and med5_dosis_T4='1') med5_ppp=1.71.
IF  (atc5_T4='N07BA03' and med5_dosis_T4='') med5_ppp=1.71.
IF  (atc6_T4='N07BA03') med6_recept=1.
IF  (atc6_T4='N07BA03' and med6_dosis_T4='1') med6_ppp=1.71.
IF  (atc8_T4='N07BA03') med8_recept=1.
IF  (atc8_T4='N07BA03' and med8_dosis_T4='0.5') med8_ppp=1.71.
IF  (atc8_T4='N07BA03' and med8_dosis_T4='1') med8_ppp=1.71.
**ATC N06BA04 ritalin.
IF  (atc1_T4='N06BA04') med1_recept=1.
IF  (atc1_T4='N06BA04' and med1_dosis_T4='18') med1_ppp=0.75.
IF  (atc2_T4='N06BA04') med2_recept=1.
IF  (atc2_T4='N06BA04' and med2_dosis_T4='27') med2_ppp=1.14.
IF  (atc3_T4='N06BA04') med3_recept=1.
IF  (atc3_T4='N06BA04' and med3_dosis_T4='10') med3_ppp=0.05.
IF  (atc3_T4='N06BA04' and med3_dosis_T4='30') med3_ppp=0.45.
IF  (atc4_T4='N06BA04') med4_recept=1.
IF  (atc4_T4='N06BA04' and med4_dosis_T4='10') med4_ppp=0.05.
IF  (atc5_T4='N06BA04') med5_recept=1.
IF  (atc5_T4='N06BA04' and med5_dosis_T4='10') med5_ppp=0.05.
**ATC N06BA02.
IF  (atc1_T4='N06BA02') med1_recept=1.
IF  (atc1_T4='N06BA02' and med1_dosis_T4='halve van 15') med1_ppp=0.30.
**ATC N06AX21.
IF  (atc1_T4='N06AX21') med1_recept=1.
IF  (atc1_T4='N06AX21' and med1_dosis_T4='30') med1_ppp=0.06.
IF  (atc3_T4='N06AX21') med3_recept=1.
IF  (atc3_T4='N06AX21' and med3_dosis_T4='60') med3_ppp=0.18.
**ATC N06AX16- venlafaxine.
IF  (atc1_T4='N06AX16') med1_recept=1.
IF  (atc1_T4='N06AX16' and med1_dosis_T4='75') med1_ppp=0.04.
IF  (atc1_T4='N06AX16' and med1_dosis_T4='37,5') med1_ppp=0.03.
IF  (atc2_T4='N06AX16') med2_recept=1.
IF  (atc2_T4='N06AX16' and med2_dosis_T4='75') med2_ppp=0.04.
IF  (atc2_T4='N06AX16' and med2_dosis_T4='37,5') med2_ppp=0.03.
IF  (atc4_T4='N06AX16') med4_recept=1.
IF  (atc4_T4='N06AX16' and med4_dosis_T4='75') med4_ppp=0.04.
**ATC N06AX12.
IF  (atc1_T4='N06AX12') med1_recept=1.
IF  (atc1_T4='N06AX12' and med1_dosis_T4='150') med1_ppp=0.66.
IF  (atc1_T4='N06AX12' and med1_dosis_T4='300') med1_ppp=1.13.
**ATC N06AB10.
IF  (atc1_T4='N06AB10') med1_recept=1.
IF  (atc1_T4='N06AB10' and med1_dosis_T4='5') med1_ppp=0.14.
IF  (atc2_T4='N06AB10') med2_recept=1.
IF  (atc2_T4='N06AB10' and med2_dosis_T4='15') med2_ppp=0.05.
IF  (atc2_T4='N06AB10' and med2_dosis_T4='10') med2_ppp=0.03.
**ATC N06AB04.
IF  (atc1_T4='N06AB04') med1_recept=1.
IF  (atc1_T4='N06AB04' and med1_dosis_T4='10') med1_ppp=0.05.
IF  (atc1_T4='N06AB04' and med1_dosis_T4='40') med1_ppp=0.05.
IF  (atc2_T4='N06AB04') med2_recept=1.
IF  (atc2_T4='N06AB04' and med2_dosis_T4='10') med2_ppp=0.05.
IF  (atc2_T4='N06AB04' and med2_dosis_T4='20') med2_ppp=0.03.
IF  (atc3_T4='N06AB04') med3_recept=1.
IF  (atc3_T4='N06AB04' and med3_dosis_T4='') med3_ppp=0.03.
IF  (atc6_T4='N06AB04') med6_recept=1.
IF  (atc6_T4='N06AB04' and med6_dosis_T4='10') med6_ppp=0.05.
IF  (atc10_T4='N06AB04') med10_recept=1.
IF  (atc10_T4='N06AB04' and med10_dosis_T4='20') med10_ppp=0.03.
**ATC N06AB06.
IF  (atc1_T4='N06AB06') med1_recept=1.
IF  (atc1_T4='N06AB06' and med1_dosis_T4='50') med1_ppp=0.04.
IF  (atc1_T4='N06AB06' and med1_dosis_T4='100') med1_ppp=0.10.
IF  (atc2_T4='N06AB06') med2_recept=1.
IF  (atc2_T4='N06AB06' and med2_dosis_T4='100') med2_ppp=0.10.
IF  (atc2_T4='N06AB06' and med2_dosis_T4='50') med2_ppp=0.04.
IF  (atc3_T4='N06AB06') med3_recept=1.
IF  (atc3_T4='N06AB06' and med3_dosis_T4='50') med3_ppp=0.04.
IF  (atc5_T4='N06AB06') med5_recept=1.
IF  (atc5_T4='N06AB06' and med5_dosis_T4='100') med5_ppp=0.10.
**ATC N06AB05.
IF  (atc1_T4='N06AB05') med1_recept=1.
IF  (atc1_T4='N06AB05' and med1_dosis_T4='10') med1_ppp=0.15.
IF  (atc1_T4='N06AB05' and med1_dosis_T4='20') med1_ppp=0.03.
IF  (atc1_T4='N06AB05' and med1_dosis_T4='30') med1_ppp=0.04.
IF  (atc1_T4='N06AB05' and med1_dosis_T4='2x20') med1_ppp=0.06.
IF  (atc2_T4='N06AB05') med2_recept=1.
IF  (atc2_T4='N06AB05' and med2_dosis_T4='10') med2_ppp=0.15.
IF  (atc2_T4='N06AB05' and med2_dosis_T4='20') med2_ppp=0.03.
IF  (atc2_T4='N06AB05' and med2_dosis_T4='30') med2_ppp=0.04.
IF  (atc2_T4='N06AB05' and med2_dosis_T4='2x20') med2_ppp=0.06.
IF  (atc2_T4='N06AB05' and med2_dosis_T4='') med2_ppp=0.03.
IF  (atc3_T4='N06AB05') med3_recept=1.
IF  (atc3_T4='N06AB05' and med3_dosis_T4='2x20') med3_ppp=0.07.
IF  (atc4_T4='N06AB05') med4_recept=1.
IF  (atc4_T4='N06AB05' and med4_dosis_T4='20') med4_ppp=0.03.
IF  (atc5_T4='N06AB05') med5_recept=1.
IF  (atc5_T4='N06AB05' and med5_dosis_T4='20') med5_ppp=0.03.
IF  (atc6_T4='N06AB05') med6_recept=1.
IF  (atc6_T4='N06AB05' and med6_dosis_T4='2x20') med6_ppp=0.07.
**ATC N06AB04.
IF  (atc5_T4='N06AB04') med5_recept=1.
IF  (atc5_T4='N06AB04' and med5_dosis_T4='40') med5_ppp=0.05.
**ATC N06AB03.
IF  (atc1_T4='N06AB03') med1_recept=1.
IF  (atc1_T4='N06AB03' and med1_dosis_T4='20') med1_ppp=0.03.
IF  (atc2_T4='N06AB03') med2_recept=1.
IF  (atc2_T4='N06AB03' and med2_dosis_T4='20') med2_ppp=0.03.
**ATC N06AA10.
IF  (atc1_T4='N06AA10') med1_recept=1.
IF  (atc1_T4='N06AA10' and med1_dosis_T4='') med1_ppp=0.08.
IF  (atc1_T4='N06AA10' and med1_dosis_T4='10') med1_ppp=0.08.
IF  (atc2_T4='N06AA10') med2_recept=1.
IF  (atc2_T4='N06AA10' and med2_dosis_T4='25') med2_ppp=0.16.
IF  (atc9_T4='N06AA10') med9_recept=1.
IF  (atc9_T4='N06AA10' and med9_dosis_T4='2x10') med9_ppp=0.16.
**ATC N06AA09.
IF  (atc1_T4='N06AA09') med1_recept=1.
IF  (atc1_T4='N06AA09' and med1_dosis_T4='25') med1_ppp=0.03.
IF  (atc2_T4='N06AA09') med2_recept=1.
IF  (atc2_T4='N06AA09' and med2_dosis_T4='50') med2_ppp=0.11.
IF  (atc6_T4='N06AA09') med6_recept=1.
IF  (atc6_T4='N06AA09' and med6_dosis_T4='') med6_ppp=0.02.
**ATC N06AA04.
IF  (atc1_T4='N06AA04') med1_recept=1.
IF  (atc1_T4='N06AA04' and med1_dosis_T4='75') med1_ppp=0.11.
IF  (atc2_T4='N06AA04') med2_recept=1.
IF  (atc2_T4='N06AA04' and med2_dosis_T4='75') med2_ppp=0.11.
**ATC N05CM09.
IF  (atc1_T4='N05CM09') med1_recept=0.
IF  (atc1_T4='N05CM09' and med1_dosis_T4='450') med1_ppp=0.37.
IF  (atc5_T4='N05CM09') med5_recept=0.
IF  (atc5_T4='N05CM09' and med5_dosis_T4='45') med5_ppp=0.10.
**ATC N05CH01.
IF  (atc2_T4='N05CH01') med2_recept=1.
IF  (atc2_T4='N05CH01' and med2_dosis_T4='0.5') med2_ppp=0.27.
IF  (atc5_T4='N05CH01') med5_recept=1.
IF  (atc5_T4='N05CH01' and med5_dosis_T4='1') med5_ppp=0.28.
**ATC N05CF02 - zolpidem.
IF  (atc2_T4='N05CF02') med2_recept=1.
IF  (atc2_T4='N05CF02' and med2_dosis_T4='10') med2_ppp=0.04.
**ATC N05CF01 - zoplicon.
IF  (atc1_T4='N05CF01') med1_recept=1.
IF  (atc1_T4='N05CF01' and med1_dosis_T4='7.5') med1_ppp=0.04.
IF  (atc1_T4='N05CF01' and med1_dosis_T4='') med1_ppp=0.04.
IF  (atc4_T4='N05CF01') med4_recept=1.
IF  (atc4_T4='N05CF01' and med4_dosis_T4='7.5') med4_ppp=0.04.
**ATC N05CD07 - temazepam.
IF  (atc2_T4='N05CD07') med2_recept=1.
IF  (atc2_T4='N05CD07' and med2_dosis_T4='10') med2_ppp=0.05.
IF  (atc2_T4='N05CD07' and med2_dosis_T4='20') med2_ppp=0.07.
IF  (atc3_T4='N05CD07') med3_recept=1.
IF  (atc3_T4='N05CD07' and med3_dosis_T4='20') med3_ppp=0.07.
IF  (atc4_T4='N05CD07') med4_recept=1.
IF  (atc4_T4='N05CD07' and med4_dosis_T4='20') med4_ppp=0.07.
**ATC N05BB01.
IF  (atc1_T4='N05BB01') med1_recept=1.
IF  (atc1_T4='N05BB01' and med1_dosis_T4='25') med1_ppp=0.08.
**ATC N05BA12 - .
IF  (atc1_T4='N05BA12') med1_recept=1.
IF  (atc1_T4='N05BA12' and med1_dosis_T4='0.25') med1_ppp=0.03.
**ATC N05BA06 - lorazepam.
IF  (atc2_T4='N05BA06') med2_recept=1.
IF  (atc2_T4='N05BA06' and med2_dosis_T4='0,5') med2_ppp=0.23.
IF  (atc5_T4='N05BA06') med5_recept=1.
IF  (atc5_T4='N05BA06' and med5_dosis_T4='1') med5_ppp=0.05.
**ATC N05BA04 - oxazepam.
IF  (atc1_T4='N05BA04') med1_recept=1.
IF  (atc1_T4='N05BA04' and med1_dosis_T4='10') med1_ppp=0.02.
IF  (atc1_T4='N05BA04' and med1_dosis_T4='') med1_ppp=0.02.
IF  (atc2_T4='N05BA04') med2_recept=1.
IF  (atc2_T4='N05BA04' and med2_dosis_T4='') med2_ppp=0.02.
IF  (atc2_T4='N05BA04' and med2_dosis_T4='10') med2_ppp=0.02.
IF  (atc3_T4='N05BA04') med3_recept=1.
IF  (atc3_T4='N05BA04' and med3_dosis_T4='') med3_ppp=0.02.
IF  (atc3_T4='N05BA04' and med3_dosis_T4='5') med3_ppp=0.14.
**ATC N05BA01 - diazepam.
IF  (atc1_T4='N05BA01') med1_recept=1.
IF  (atc1_T4='N05BA01' and med1_dosis_T4='10') med1_ppp=0.04.
IF  (atc2_T4='N05BA01') med2_recept=1.
IF  (atc2_T4='N05BA01' and med2_dosis_T4='5') med2_ppp=0.02.
IF  (atc2_T4='N05BA01' and med2_dosis_T4='') med2_ppp=0.02.
IF  (atc5_T4='N05BA01') med5_recept=1.
IF  (atc5_T4='N05BA01' and med5_dosis_T4='') med5_ppp=0.02.
**ATC N05AX12.
IF  (atc1_T4='N05AX12') med1_recept=1.
IF  (atc1_T4='N05AX12' and med1_dosis_T4='10') med1_ppp=0.04.
**ATC N05AX08.
IF  (atc1_T4='N05AX08') med1_recept=1.
IF  (atc1_T4='N05AX08' and med1_dosis_T4='1') med1_ppp=0.02.
IF  (atc1_T4='N05AX08' and med1_dosis_T4='3') med1_ppp=0.04.
IF  (atc2_T4='N05AX08') med2_recept=1.
IF  (atc2_T4='N05AX08' and med2_dosis_T4='2') med2_ppp=0.02.
**ATC N05AN01.
IF  (atc1_T4='N05AN01') med1_recept=1.
IF  (atc1_T4='N05AN01' and med1_dosis_T4='600') med1_ppp=0.08.
**ATC N05AH04 - Quetiapine.
IF  (atc1_T4='N05AH04') med1_recept=1.
IF  (atc1_T4='N05AH04' and med1_dosis_T4='25') med1_ppp=0.02.
IF  (atc1_T4='N05AH04' and med1_dosis_T4='50') med1_ppp=0.07.
IF  (atc1_T4='N05AH04' and med1_dosis_T4='300') med1_ppp=0.08.
IF  (atc2_T4='N05AH04') med2_recept=1.
IF  (atc2_T4='N05AH04' and med2_dosis_T4='') med2_ppp=0.02.
IF  (atc3_T4='N05AH04') med3_recept=1.
IF  (atc3_T4='N05AH04' and med3_dosis_T4='25') med3_ppp=0.02.
IF  (atc4_T4='N05AH04') med4_recept=1.
IF  (atc4_T4='N05AH04' and med4_dosis_T4='') med4_ppp=0.02.
**ATC N05AF01.
IF  (atc4_T4='N05AF01') med4_recept=1.
IF  (atc4_T4='N05AF01' and med4_dosis_T4='1') med4_ppp=0.08.
**ATC N04BC05 - pramipexol.
IF  (atc3_T4='N04BC05') med3_recept=1.
IF  (atc3_T4='N04BC05' and med3_dosis_T4='3') med3_ppp=4.37.
IF  (atc4_T4='N04BC05') med4_recept=1.
IF  (atc4_T4='N04BC05' and med4_dosis_T4='0,25') med4_ppp=0.10.
**ATC N04BC04 - .
IF  (atc1_T4='N04BC04') med1_recept=1.
IF  (atc1_T4='N04BC04' and med1_dosis_T4='1') med1_ppp=0.11.
**ATC N04AA02.
IF  (atc3_T4='N04AA02') med3_recept=1.
IF  (atc3_T4='N04AA02' and med3_dosis_T4='2') med3_ppp=0.05.
**ATC N03AX16 - Lyrica.
IF  (atc1_T4='N03AX16') med1_recept=1.
IF  (atc1_T4='N03AX16' and med1_dosis_T4='150') med1_ppp=0.06.
IF  (atc2_T4='N03AX16') med2_recept=1.
IF  (atc2_T4='N03AX16' and med2_dosis_T4='150') med2_ppp=0.11.
IF  (atc3_T4='N03AX16') med3_recept=1.
IF  (atc3_T4='N03AX16' and med3_dosis_T4='75') med3_ppp=0.06.
IF  (atc4_T4='N03AX16') med4_recept=1.
IF  (atc4_T4='N03AX16' and med4_dosis_T4='75') med4_ppp=0.06.
IF  (atc7_T4='N03AX16') med7_recept=1.
IF  (atc7_T4='N03AX16' and med7_dosis_T4='75') med7_ppp=0.06.
**ATC N03AX14.
IF  (atc2_T4='N03AX14') med2_recept=1.
IF  (atc2_T4='N03AX14' and med2_dosis_T4='500 en 1000') med2_ppp=0.15.
**ATC N03AX12.
IF  (atc2_T4='N03AX12') med2_recept=1.
IF  (atc2_T4='N03AX12' and med2_dosis_T4='100') med2_ppp=0.04.
**ATC N03AX11.
IF  (atc1_T4='N03AX11') med1_recept=1.
IF  (atc1_T4='N03AX11' and med1_dosis_T4='3x25') med1_ppp=0.12.
**ATC N03AF01.
IF  (atc2_T4='N03AF01') med2_recept=1.
IF  (atc2_T4='N03AF01' and med2_dosis_T4='400') med2_ppp=0.15.
**ATC N03AE01- rivotril.
IF  (atc1_T4='N03AE01') med1_recept=1.
IF  (atc1_T4='N03AE01' and med1_dosis_T4='0.5') med1_ppp=0.04.
IF  (atc4_T4='N03AE01') med4_recept=1.
IF  (atc4_T4='N03AE01' and med4_dosis_T4='2x0,5') med4_ppp=0.08.
**ATC N02CC06.
IF  (atc3_T4='N02CC06') med3_recept=1.
IF  (atc3_T4='N02CC06' and med3_dosis_T4='25') med3_ppp=4.90.
**ATC N02CC03 .
IF  (atc3_T4='N02CC03') med3_recept=1.
IF  (atc3_T4='N02CC03' and med3_dosis_T4='2,5') med3_ppp=0.13.
**ATC N02CC01 Imigran.
IF  (atc2_T4='N02CC01') med2_recept=1.
IF  (atc2_T4='N02CC01' and med2_dosis_T4='') med2_ppp=0.22.
IF  (atc2_T4='N02CC01' and med2_dosis_T4='100') med2_ppp=0.25.
IF  (atc3_T4='N02CC01') med3_recept=1.
IF  (atc3_T4='N02CC01' and med3_dosis_T4='6 mg injectie') med3_ppp=14.26.
IF  (atc4_T4='N02CC01') med4_recept=1.
IF  (atc4_T4='N02CC01' and med4_dosis_T4='100') med4_ppp=0.25.
**ATC N02BE51 Paracetamol/codeine.
IF  (atc1_T4='N02BE51') med1_recept=0.
IF  (atc1_T4='N02BE51' and med1_dosis_T4='500/65') med1_ppp=0.12.
IF  (atc1_T4='N02BE51' and med1_dosis_T4='500/30 poeder') med1_ppp=0.64.
IF  (atc1_T4='N02BE51' and med1_dosis_T4='250/250/65') med1_ppp=0.50.
IF  (atc3_T4='N02BE51') med3_recept=0.
IF  (atc3_T4='N02BE51' and med3_dosis_T4='500/50 poeder') med3_ppp=0.20.
IF  (atc3_T4='N02BE51' and med3_dosis_T4='500/30 poeder') med3_ppp=0.64.
**ATC N02BE01 Paracetamol.
IF  (atc1_T4='N02BE01') med1_recept=0.
IF  (atc1_T4='N02BE01' and med1_dosis_T4='500') med1_ppp=0.02.
IF  (atc1_T4='N02BE01' and med1_dosis_T4='2x500') med1_ppp=0.04.
IF  (atc1_T4='N02BE01' and med1_dosis_T4='') med1_ppp=0.02.
IF  (atc1_T4='N02BE01' and med1_dosis_T4='200') med1_ppp=0.02.
IF  (atc1_T4='N02BE01' and med1_dosis_T4='1000') med1_ppp=0.03.
IF  (atc1_T4='N02BE01' and med1_dosis_T4='100') med1_ppp=0.10.
IF  (atc1_T4='N02BE01' and med1_dosis_T4='400') med1_ppp=0.02.
IF  (atc2_T4='N02BE01') med2_recept=0.
IF  (atc2_T4='N02BE01' and med2_dosis_T4='500') med2_ppp=0.02.
IF  (atc2_T4='N02BE01' and med2_dosis_T4='1000') med2_ppp=0.03.
IF  (atc2_T4='N02BE01' and med2_dosis_T4='100') med2_ppp=0.10.
IF  (atc2_T4='N02BE01' and med2_dosis_T4='1,5 x 250') med2_ppp=0.24.
IF  (atc2_T4='N02BE01' and med2_dosis_T4='250') med2_ppp=0.16.
IF  (atc2_T4='N02BE01' and med2_dosis_T4='200') med2_ppp=0.02.
IF  (atc2_T4='N02BE01' and med2_dosis_T4='') med2_ppp=0.02.
IF  (atc2_T4='N02BE01' and med2_dosis_T4='2x500') med2_ppp=0.04.
IF  (atc3_T4='N02BE01') med3_recept=0.
IF  (atc3_T4='N02BE01' and med3_dosis_T4='500') med3_ppp=0.02.
IF  (atc3_T4='N02BE01' and med3_dosis_T4='') med3_ppp=0.02.
IF  (atc3_T4='N02BE01' and med3_dosis_T4='2x500') med3_ppp=0.04.
IF  (atc3_T4='N02BE01' and med3_dosis_T4='1000') med3_ppp=0.03.
IF  (atc4_T4='N02BE01') med4_recept=0.
IF  (atc4_T4='N02BE01' and med4_dosis_T4='500') med4_ppp=0.02.
IF  (atc4_T4='N02BE01' and med4_dosis_T4='1000') med4_ppp=0.03.
IF  (atc4_T4='N02BE01' and med4_dosis_T4='2x500') med4_ppp=0.04.
IF  (atc4_T4='N02BE01' and med4_dosis_T4='') med4_ppp=0.02.
IF  (atc5_T4='N02BE01') med5_recept=0.
IF  (atc5_T4='N02BE01' and med5_dosis_T4='500') med5_ppp=0.02.
IF  (atc5_T4='N02BE01' and med5_dosis_T4='1000') med5_ppp=0.03.
IF  (atc5_T4='N02BE01' and med5_dosis_T4='') med5_ppp=0.02.
IF  (atc6_T4='N02BE01') med6_recept=0.
IF  (atc6_T4='N02BE01' and med6_dosis_T4='2x500') med6_ppp=0.04.
IF  (atc6_T4='N02BE01' and med6_dosis_T4='500') med6_ppp=0.02.
IF  (atc7_T4='N02BE01') med7_recept=0.
IF  (atc7_T4='N02BE01' and med7_dosis_T4='') med7_ppp=0.02.
IF  (atc7_T4='N02BE01' and med7_dosis_T4='1000') med7_ppp=0.03.
IF  (atc8_T4='N02BE01') med8_recept=0.
IF  (atc8_T4='N02BE01' and med8_dosis_T4='') med8_ppp=0.02.
IF  (atc8_T4='N02BE01' and med8_dosis_T4='1000') med8_ppp=0.03.
**ATC N02BA15 - carbasalaatcalcium- pijnstillend.
IF  (atc2_T4='N02BA15') med2_recept=1.
IF  (atc2_T4='N02BA15' and med2_dosis_T4='600') med2_ppp=0.14.
**ATC N02BA01 - asperine- pijnstillend.
IF  (atc2_T4='N02BA01' and med2_dosis_T4='500') med2_recept=0.
IF  (atc2_T4='N02BA01' and med2_dosis_T4='500') med2_ppp=0.14.
**ATC N02AX02 - tramadol.
IF  (atc1_T4='N02AX02') med1_recept=1.
IF  (atc1_T4='N02AX02' and med1_dosis_T4='50') med1_ppp=0.03.
IF  (atc1_T4='N02AX02' and med1_dosis_T4='150') med1_ppp=0.10.
IF  (atc1_T4='N02AX02' and med1_dosis_T4='') med1_ppp=0.03.
IF  (atc2_T4='N02AX02') med2_recept=1.
IF  (atc2_T4='N02AX02' and med2_dosis_T4='') med2_ppp=0.03.
IF  (atc2_T4='N02AX02' and med2_dosis_T4='50') med2_ppp=0.03.
IF  (atc3_T4='N02AX02') med3_recept=1.
IF  (atc3_T4='N02AX02' and med3_dosis_T4='50') med3_ppp=0.03.
IF  (atc3_T4='N02AX02' and med3_dosis_T4='') med3_ppp=0.03.
IF  (atc4_T4='N02AX02') med4_recept=1.
IF  (atc4_T4='N02AX02' and med4_dosis_T4='50') med4_ppp=0.03.
**ATC N02AX52 - zaldiar.
IF  (atc5_T4='N02AX52') med5_recept=1.
IF  (atc5_T4='N02AX52' and med5_dosis_T4='') med5_ppp=0.07.
IF  (atc6_T4='N02AX52') med6_recept=1.
IF  (atc6_T4='N02AX52' and med6_dosis_T4='') med6_ppp=0.07.
**ATC N02AJ13 tramadol/paracetamol. 
IF  (atc2_T4='N02AJ13') med2_recept=1.
IF  (atc2_T4='N02AJ13' and med2_dosis_T4='37,5/325') med2_ppp=0.07.
IF  (atc3_T4='N02AJ13') med3_recept=1.
IF  (atc3_T4='N02AJ13' and med3_dosis_T4='37,5/325') med3_ppp=0.07.
**ATC N02AJ06 paracetamol/codeine.
IF  (atc1_T4='N02AJ06') med1_recept=0.
IF  (atc1_T4='N02AJ06' and med1_dosis_T4='500/30') med1_ppp=999.
IF  (atc2_T4='N02AJ06') med2_recept=0.
IF  (atc2_T4='N02AJ06' and med2_dosis_T4='500/10') med2_ppp=0.04.
**ATC N02AA05 - oxycodon.
IF  (atc1_T4='N02AA05') med1_recept=1.
IF  (atc1_T4='N02AA05' and med1_dosis_T4='') med1_ppp=0.03.
IF  (atc2_T4='N02AA05') med2_recept=1.
IF  (atc2_T4='N02AA05' and med2_dosis_T4='5') med2_ppp=0.03.
IF  (atc2_T4='N02AA05' and med2_dosis_T4='20') med2_ppp=0.06.
IF  (atc2_T4='N02AA05' and med2_dosis_T4='10') med2_ppp=0.05.
IF  (atc3_T4='N02AA05') med3_recept=1.
IF  (atc3_T4='N02AA05' and med3_dosis_T4='5') med3_ppp=0.03.
IF  (atc3_T4='N02AA05' and med3_dosis_T4='20') med3_ppp=0.06.
IF  (atc4_T4='N02AA05') med4_recept=1.
IF  (atc4_T4='N02AA05' and med4_dosis_T4='5') med4_ppp=0.03.
IF  (atc4_T4='N02AA05' and med4_dosis_T4='10') med4_ppp=0.05.
IF  (atc7_T4='N02AA05') med7_recept=1.
IF  (atc7_T4='N02AA05' and med7_dosis_T4='10') med7_ppp=0.05.
IF  (atc8_T4='N02AA05') med8_recept=1.
IF  (atc8_T4='N02AA05' and med8_dosis_T4='5') med8_ppp=0.03.
**ATC N02AA01 - morfine.
IF  (atc1_T4='N02AA01') med1_recept=1.
IF  (atc1_T4='N02AA01' and med1_dosis_T4='') med1_ppp=0.14.
IF  (atc2_T4='N02AA01') med2_recept=1.
IF  (atc2_T4='N02AA01' and med2_dosis_T4='10') med2_ppp=0.14.
IF  (atc2_T4='N02AA01' and med2_dosis_T4='50') med2_ppp=1.87.
IF  (atc5_T4='N02AA01') med5_recept=1.
IF  (atc5_T4='N02AA01' and med5_dosis_T4='') med5_ppp=0.14.
IF  (atc6_T4='N02AA01') med6_recept=1.
IF  (atc6_T4='N02AA01' and med6_dosis_T4='10') med6_ppp=0.14.
**ATC N01BB02.
IF  (atc6_T4='N01BB02') med6_recept=1.
IF  (atc6_T4='N01BB02' and med6_dosis_T4='') med6_ppp=0.85.
**ATC M05BX04.
IF  (atc3_T4='M05BX04') med3_recept=1.
IF  (atc3_T4='M05BX04' and med3_dosis_T4='60') med3_ppp=214.80.
**ATC M05BA08.
IF  (atc5_T4='M05BA08') med5_recept=1.
IF  (atc5_T4='M05BA08' and med5_dosis_T4='1 infuus') med5_ppp=167.01.
**ATC M05BA04- alendrolinezuur.
IF  (atc1_T4='M05BA04') med1_recept=1.
IF  (atc1_T4='M05BA04' and med1_dosis_T4='70') med1_ppp=0.11.
IF  (atc1_T4='M05BA04' and med1_dosis_T4='') med1_ppp=0.11.
IF  (atc2_T4='M05BA04') med2_recept=1.
IF  (atc2_T4='M05BA04' and med2_dosis_T4='70') med2_ppp=0.11.
IF  (atc2_T4='M05BA04' and med2_dosis_T4='') med2_ppp=0.11.
IF  (atc3_T4='M05BA04') med3_recept=1.
IF  (atc3_T4='M05BA04' and med3_dosis_T4='70') med3_ppp=0.11.
IF  (atc4_T4='M05BA04') med4_recept=1.
IF  (atc4_T4='M05BA04' and med4_dosis_T4='70') med4_ppp=0.11.
**ATC M04AC01- colchicine.
IF  (atc5_T4='M04AC01') med5_recept=1.
IF  (atc5_T4='M04AC01' and med5_dosis_T4='0.5') med5_ppp=0.08.
IF  (atc7_T4='M04AC01') med7_recept=1.
IF  (atc7_T4='M04AC01' and med7_dosis_T4='2x0,5') med7_ppp=0.16.
**ATC M04AA01- allopurinol.
IF  (atc1_T4='M04AA01') med1_recept=1.
IF  (atc1_T4='M04AA01' and med1_dosis_T4='300') med1_ppp=0.06.
IF  (atc2_T4='M04AA01') med2_recept=1.
IF  (atc2_T4='M04AA01' and med2_dosis_T4='') med2_ppp=0.06.
IF  (atc2_T4='M04AA01' and med2_dosis_T4='300') med2_ppp=0.06.
IF  (atc4_T4='M04AA01') med4_recept=1.
IF  (atc4_T4='M04AA01' and med4_dosis_T4='300') med4_ppp=0.06.
**ATC M03AX01.
IF  (atc1_T4='M03AX01') med1_recept=1.
IF  (atc1_T4='M03AX01' and med1_dosis_T4='') med1_ppp=132.50.
**ATC M01AX05.
IF  (atc2_T4='M01AX05') med2_recept=1.
IF  (atc2_T4='M01AX05' and med2_dosis_T4='') med2_ppp=0.22.
**ATC M01AH05.
IF  (atc1_T4='M01AH05') med1_recept=1.
IF  (atc1_T4='M01AH05' and med1_dosis_T4='120') med1_ppp=1.23.
IF  (atc2_T4='M01AH05') med2_recept=1.
IF  (atc2_T4='M01AH05' and med2_dosis_T4='90') med2_ppp=1.01.
IF  (atc5_T4='M01AH05') med5_recept=1.
IF  (atc5_T4='M01AH05' and med5_dosis_T4='60') med5_ppp=0.08.
IF  (atc6_T4='M01AH05') med6_recept=1.
IF  (atc6_T4='M01AH05' and med6_dosis_T4='90') med6_ppp=1.01.
**ATC M01AH01-celebrex.
IF  (atc1_T4='M01AH01') med1_recept=1.
IF  (atc1_T4='M01AH01' and med1_dosis_T4='100') med1_ppp=0.04.
IF  (atc1_T4='M01AH01' and med1_dosis_T4='2x200') med1_ppp=0.10.
IF  (atc2_T4='M01AH01') med2_recept=1.
IF  (atc2_T4='M01AH01' and med2_dosis_T4='100') med2_ppp=0.04.
IF  (atc2_T4='M01AH01' and med2_dosis_T4='2x200') med2_ppp=0.09.
IF  (atc3_T4='M01AH01') med3_recept=1.
IF  (atc3_T4='M01AH01' and med3_dosis_T4='200') med3_ppp=0.05.
**ATC M01AE02- naproxen.
IF  (atc1_T4='M01AE02') med1_recept=1.
IF  (atc1_T4='M01AE02' and med1_dosis_T4='') med1_ppp=0.03.
IF  (atc2_T4='M01AE02') med2_recept=1.
IF  (atc2_T4='M01AE02' and med2_dosis_T4='500') med2_ppp=0.04.
IF  (atc3_T4='M01AE02') med3_recept=1.
IF  (atc3_T4='M01AE02' and med3_dosis_T4='250') med3_ppp=0.03.
IF  (atc3_T4='M01AE02' and med3_dosis_T4='500') med3_ppp=0.04.
IF  (atc3_T4='M01AE02' and med3_dosis_T4='') med3_ppp=0.03.
IF  (atc4_T4='M01AE02') med4_recept=1.
IF  (atc4_T4='M01AE02' and med4_dosis_T4='500') med4_ppp=0.04.
IF  (atc5_T4='M01AE02') med5_recept=1.
IF  (atc5_T4='M01AE02' and med5_dosis_T4='500') med5_ppp=0.04.
IF  (atc6_T4='M01AE02') med6_recept=1.
IF  (atc6_T4='M01AE02' and med6_dosis_T4='500') med6_ppp=0.04.
**ATC M01AE01- ibuprofen.
IF  (atc1_T4='M01AE01' and med1_dosis_T4='100') med1_recept=0.
IF  (atc1_T4='M01AE01' and med1_dosis_T4='200') med1_recept=0.
IF  (atc1_T4='M01AE01' and med1_dosis_T4='400') med1_recept=0.
IF  (atc1_T4='M01AE01' and med1_dosis_T4='500') med1_recept=9.
IF  (atc1_T4='M01AE01' and med1_dosis_T4='600') med1_recept=1.
IF  (atc1_T4='M01AE01' and med1_dosis_T4='800') med1_recept=1.
IF  (atc1_T4='M01AE01' and med1_dosis_T4='') med1_recept=0.
IF  (atc1_T4='M01AE01' and med1_dosis_T4='100') med1_ppp=0.44.
IF  (atc1_T4='M01AE01' and med1_dosis_T4='200') med1_ppp=0.04.
IF  (atc1_T4='M01AE01' and med1_dosis_T4='400') med1_ppp=0.06.
IF  (atc1_T4='M01AE01' and med1_dosis_T4='500') med1_ppp=999.
IF  (atc1_T4='M01AE01' and med1_dosis_T4='600') med1_ppp=0.04.
IF  (atc1_T4='M01AE01' and med1_dosis_T4='800') med1_ppp=0.13.
IF  (atc1_T4='M01AE01' and med1_dosis_T4='') med1_ppp=0.04.
IF  (atc2_T4='M01AE01' and med2_dosis_T4='100') med2_recept=0.
IF  (atc2_T4='M01AE01' and med2_dosis_T4='200') med2_recept=0.
IF  (atc2_T4='M01AE01' and med2_dosis_T4='400') med2_recept=0.
IF  (atc2_T4='M01AE01' and med2_dosis_T4='500') med2_recept=9.
IF  (atc2_T4='M01AE01' and med2_dosis_T4='600') med2_recept=1.
IF  (atc2_T4='M01AE01' and med2_dosis_T4='800') med2_recept=1.
IF  (atc2_T4='M01AE01' and med2_dosis_T4='') med2_recept=0.
IF  (atc2_T4='M01AE01' and med2_dosis_T4='100') med2_ppp=0.44.
IF  (atc2_T4='M01AE01' and med2_dosis_T4='200') med2_ppp=0.04.
IF  (atc2_T4='M01AE01' and med2_dosis_T4='400') med2_ppp=0.06.
IF  (atc2_T4='M01AE01' and med2_dosis_T4='500') med2_ppp=999.
IF  (atc2_T4='M01AE01' and med2_dosis_T4='600') med2_ppp=0.04.
IF  (atc2_T4='M01AE01' and med2_dosis_T4='800') med2_ppp=0.13.
IF  (atc2_T4='M01AE01' and med2_dosis_T4='') med2_ppp=0.04.
IF  (atc3_T4='M01AE01' and med3_dosis_T4='100') med1_recept=0.
IF  (atc3_T4='M01AE01' and med3_dosis_T4='200') med3_recept=0.
IF  (atc3_T4='M01AE01' and med3_dosis_T4='400') med3_recept=0.
IF  (atc3_T4='M01AE01' and med3_dosis_T4='600') med3_recept=1.
IF  (atc3_T4='M01AE01' and med3_dosis_T4='800') med3_recept=1.
IF  (atc3_T4='M01AE01' and med3_dosis_T4='') med3_recept=0.
IF  (atc3_T4='M01AE01' and med3_dosis_T4='100') med3_ppp=0.44.
IF  (atc3_T4='M01AE01' and med3_dosis_T4='200') med3_ppp=0.04.
IF  (atc3_T4='M01AE01' and med3_dosis_T4='400') med3_ppp=0.06.
IF  (atc3_T4='M01AE01' and med3_dosis_T4='600') med3_ppp=0.04.
IF  (atc3_T4='M01AE01' and med3_dosis_T4='800') med3_ppp=0.13.
IF  (atc3_T4='M01AE01' and med3_dosis_T4='') med3_ppp=0.04.
IF  (atc4_T4='M01AE01' and med4_dosis_T4='') med4_recept=0.
IF  (atc4_T4='M01AE01' and med4_dosis_T4='2x600') med4_recept=1.
IF  (atc4_T4='M01AE01' and med4_dosis_T4='2x600') med4_ppp=0.08.
IF  (atc4_T4='M01AE01' and med4_dosis_T4='') med4_ppp=0.04.
IF  (atc5_T4='M01AE01' and med5_dosis_T4='400') med5_recept=0.
IF  (atc5_T4='M01AE01' and med5_dosis_T4='400') med5_ppp=0.06.
IF  (atc6_T4='M01AE01' and med6_dosis_T4='400') med6_recept=0.
IF  (atc6_T4='M01AE01' and med6_dosis_T4='400') med6_ppp=0.06.
IF  (atc8_T4='M01AE01' and med8_dosis_T4='400') med8_recept=0.
IF  (atc8_T4='M01AE01' and med8_dosis_T4='400') med8_ppp=0.06.
IF  (atc9_T4='M01AE01' and med9_dosis_T4='400') med9_recept=0.
IF  (atc9_T4='M01AE01' and med9_dosis_T4='400') med9_ppp=0.06.
**ATC M01AC06 meloxicam.
IF  (atc1_T4='M01AC06') med1_recept=1.
IF  (atc1_T4='M01AC06' and med1_dosis_T4='7.5') med1_ppp=0.03.
**ATC M01AB55 diclofenac/misoprostol.
IF  (atc1_T4='M01AB55') med1_recept=1.
IF  (atc1_T4='M01AB55' and med1_dosis_T4='50/0,2') med1_ppp=0.24.
**ATC M01AB05 - diclofenac.
IF  (atc1_T4='M01AB05' and med1_dosis_T4='25') med1_recept=0.
IF  (atc1_T4='M01AB05' and med1_dosis_T4='50') med1_recept=1.
IF  (atc1_T4='M01AB05' and med1_dosis_T4='75') med1_recept=1.
IF  (atc1_T4='M01AB05' and med1_dosis_T4='2x100') med1_recept=1.
IF  (atc1_T4='M01AB05' and med1_dosis_T4='') med1_recept=0.
IF  (atc1_T4='M01AB05' and med1_dosis_T4='25') med1_ppp=0.03.
IF  (atc1_T4='M01AB05' and med1_dosis_T4='50') med1_ppp=0.02.
IF  (atc1_T4='M01AB05' and med1_dosis_T4='') med1_ppp=0.02.
IF  (atc1_T4='M01AB05' and med1_dosis_T4='75') med1_ppp=0.04.
IF  (atc1_T4='M01AB05' and med1_dosis_T4='2x100') med1_ppp=0.10.
IF  (atc2_T4='M01AB05' and med2_dosis_T4='50') med2_recept=1.
IF  (atc2_T4='M01AB05' and med2_dosis_T4='75') med2_recept=1.
IF  (atc2_T4='M01AB05' and med2_dosis_T4='') med2_recept=0.
IF  (atc2_T4='M01AB05' and med2_dosis_T4='50') med2_ppp=0.02.
IF  (atc2_T4='M01AB05' and med2_dosis_T4='75') med2_ppp=0.04.
IF  (atc2_T4='M01AB05' and med2_dosis_T4='') med2_ppp=0.02.
IF  (atc3_T4='M01AB05' and med3_dosis_T4='50') med3_recept=1.
IF  (atc3_T4='M01AB05' and med3_dosis_T4='') med3_recept=0.
IF  (atc3_T4='M01AB05' and med3_dosis_T4='50') med3_ppp=0.02.
IF  (atc3_T4='M01AB05' and med3_dosis_T4='') med3_ppp=0.02.
IF  (atc4_T4='M01AB05' and med4_dosis_T4='50') med4_recept=1.
IF  (atc4_T4='M01AB05' and med4_dosis_T4='75') med4_recept=1.
IF  (atc4_T4='M01AB05' and med4_dosis_T4='50') med4_ppp=0.02.
IF  (atc4_T4='M01AB05' and med4_dosis_T4='75') med4_ppp=0.04.
IF  (atc5_T4='M01AB05' and med5_dosis_T4='50') med5_recept=1.
IF  (atc5_T4='M01AB05' and med5_dosis_T4='50') med5_ppp=0.02.
IF  (atc6_T4='M01AB05' and med6_dosis_T4='75') med6_recept=1.
IF  (atc6_T4='M01AB05' and med6_dosis_T4='75') med6_ppp=0.04.
IF  (atc6_T4='M01AB05' and med6_dosis_T4='') med6_recept=0.
IF  (atc6_T4='M01AB05' and med6_dosis_T4='') med6_ppp=0.02.
IF  (atc7_T4='M01AB05' and med7_dosis_T4='2x75') med7_recept=1.
IF  (atc7_T4='M01AB05' and med7_dosis_T4='2x75') med7_ppp=0.08.
**ATC L04AX03- methotrexaat.
IF  (atc1_T4='L04AX03') med1_recept=1.
IF  (atc1_T4='L04AX03' and med1_dosis_T4='25' and med1_eenheid_T4='mg/ml') med1_ppp=10.00.
IF  (atc1_T4='L04AX03' and med1_dosis_T4='10x2.5' and med1_eenheid_T4='mg') med1_ppp=1.70.
IF  (atc1_T4='L04AX03' and med1_dosis_T4='10' and med1_eenheid_T4='mg') med1_ppp=0.73.
IF  (atc1_T4='L04AX03' and med1_dosis_T4='' and med1_eenheid_T4='mg') med1_ppp=0.17.
IF  (atc2_T4='L04AX03') med2_recept=1.
IF  (atc2_T4='L04AX03' and med2_dosis_T4='2,5' and med2_eenheid_T4='mg') med2_ppp=0.17.
**ATC L04AD02-.
IF  (atc1_T4='L04AD02') med1_recept=1.
IF  (atc1_T4='L04AD02' and med1_dosis_T4='1') med1_ppp=1.24.
**ATC L04AB04-humira.
IF  (atc1_T4='L04AB04') med1_recept=1.
IF  (atc1_T4='L04AB04' and med1_dosis_T4='') med1_ppp=582.50.
IF  (atc2_T4='L04AB04') med2_recept=1.
IF  (atc2_T4='L04AB04' and med2_dosis_T4='') med2_ppp=582.50.
IF  (atc3_T4='L04AB04') med3_recept=1.
IF  (atc3_T4='L04AB04' and med3_dosis_T4='') med3_ppp=582.50.
IF  (atc4_T4='L04AB04') med4_recept=1.
IF  (atc4_T4='L04AB04' and med4_dosis_T4='') med4_ppp=582.50.
**ATC L04AA13.
IF  (atc3_T4='L04AA13') med3_recept=1.
IF  (atc3_T4='L04AA13' and med3_dosis_T4='20') med3_ppp=1.13.
**ATC J04AB02-.
IF  (atc1_T4='J04AB02') med1_recept=1.
IF  (atc1_T4='J04AB02' and med1_dosis_T4='150+300') med1_ppp=0.81.
**ATC L02BG04.
IF  (atc1_T4='L02BG04') med1_recept=1.
IF  (atc1_T4='L02BG04' and med1_dosis_T4='2,5') med1_ppp=0.05.
IF  (atc2_T4='L02BG04') med2_recept=1.
IF  (atc2_T4='L02BG04' and med2_dosis_T4='') med2_ppp=0.05.
**ATC L02BG03.
IF  (atc1_T4='L02BG03') med1_recept=1.
IF  (atc1_T4='L02BG03' and med1_dosis_T4='1') med1_ppp=0.03.
IF  (atc8_T4='L02BG03') med8_recept=1.
IF  (atc8_T4='L02BG03' and med8_dosis_T4='') med8_ppp=0.03.
**ATC L01BB03.
IF  (atc5_T4='L01BB03') med5_recept=1.
IF  (atc5_T4='L01BB03' and med5_dosis_T4='40') med5_ppp=2.77.
**ATC L02BA01.
IF  (atc1_T4='L02BA01') med1_recept=1.
IF  (atc1_T4='L02BA01' and med1_dosis_T4='20') med1_ppp=0.17.
IF  (atc7_T4='L02BA01') med7_recept=1.
IF  (atc7_T4='L02BA01' and med7_dosis_T4='40') med7_ppp=0.84.
**ATC J02AC02.
IF  (atc6_T4='J02AC02') med6_recept=1.
IF  (atc6_T4='J02AC02' and med6_dosis_T4='100') med6_ppp=0.36.
**ATC J01XX01 - monuril.
IF  (atc5_T4='J01XX01') med5_recept=1.
IF  (atc5_T4='J01XX01' and med5_dosis_T4='') med5_ppp=4.93.
**ATC J01XE01 - nitrofuratoine.
IF  (atc1_T4='J01XE01') med1_recept=1.
IF  (atc1_T4='J01XE01' and med1_dosis_T4='50') med1_ppp=0.13.
IF  (atc4_T4='J01XE01') med4_recept=1.
IF  (atc4_T4='J01XE01' and med4_dosis_T4='100') med4_ppp=0.07.
IF  (atc5_T4='J01XE01') med5_recept=1.
IF  (atc5_T4='J01XE01' and med5_dosis_T4='100') med5_ppp=0.07.
**ATC J01MA02.
IF  (atc2_T4='J01MA02') med2_recept=1.
IF  (atc2_T4='J01MA02' and med2_dosis_T4='500') med2_ppp=0.08.
**ATC J01FA09.
IF  (atc2_T4='J01FA09') med2_recept=1.
IF  (atc2_T4='J01FA09' and med2_dosis_T4='500') med2_ppp=0.20.
**ATC J01DB04 - .
IF  (atc4_T4='J01DB04') med4_recept=1.
IF  (atc4_T4='J01DB04' and med4_dosis_T4='1000') med4_ppp=7.44.
**ATC J01CR02 - .
IF  (atc2_T4='J01CR02') med2_recept=1.
IF  (atc2_T4='J01CR02' and med2_dosis_T4='125/500') med2_ppp=0.10.
**ATC J01CF05 - .
IF  (atc2_T4='J01CF05') med2_recept=1.
IF  (atc2_T4='J01CF05' and med2_dosis_T4='500') med2_ppp=0.11.
IF  (atc5_T4='J01CF05') med5_recept=1.
IF  (atc5_T4='J01CF05' and med5_dosis_T4='500') med5_ppp=0.11.
**ATC J01CA04 - amoxicilline.
IF  (atc1_T4='J01CA04') med1_recept=1.
IF  (atc1_T4='J01CA04' and med1_dosis_T4='') med1_ppp=0.06.
IF  (atc2_T4='J01CA04') med2_recept=1.
IF  (atc2_T4='J01CA04' and med2_dosis_T4='500') med2_ppp=0.06.
IF  (atc3_T4='J01CA04') med3_recept=1.
IF  (atc3_T4='J01CA04' and med3_dosis_T4='500') med3_ppp=0.06.
IF  (atc3_T4='J01CA04' and med3_dosis_T4='') med3_ppp=0.06.
IF  (atc7_T4='J01CA04') med7_recept=1.
IF  (atc7_T4='J01CA04' and med7_dosis_T4='') med7_ppp=0.06.
**ATC J01AA02 - doxyicilline.
IF  (atc1_T4='J01AA02') med1_recept=1.
IF  (atc1_T4='J01AA02' and med1_dosis_T4='100') med1_ppp=0.10.
IF  (atc2_T4='J01AA02') med2_recept=1.
IF  (atc2_T4='J01AA02' and med2_dosis_T4='100') med2_ppp=0.10.
IF  (atc5_T4='J01AA02') med5_recept=1.
IF  (atc5_T4='J01AA02' and med5_dosis_T4='100') med5_ppp=0.10.
**ATC H03BB02 - .
IF  (atc3_T4='H03BB02') med3_recept=1.
IF  (atc3_T4='H03BB02' and med3_dosis_T4='') med3_ppp=0.04.
**ATC H03AA01 - Thyrax.
IF  (atc1_T4='H03AA01') med1_recept=1.
IF  (atc1_T4='H03AA01' and med1_dosis_T4='112') med1_ppp=0.05.
IF  (atc1_T4='H03AA01' and med1_dosis_T4='150') med1_ppp=0.06.
IF  (atc1_T4='H03AA01' and med1_dosis_T4='125') med1_ppp=0.06.
IF  (atc1_T4='H03AA01' and med1_dosis_T4='100') med1_ppp=0.03.
IF  (atc1_T4='H03AA01' and med1_dosis_T4='50') med1_ppp=0.02.
IF  (atc1_T4='H03AA01' and med1_dosis_T4='') med1_ppp=0.02.
IF  (atc1_T4='H03AA01' and med1_dosis_T4='75') med1_ppp=0.03.
IF  (atc1_T4='H03AA01' and med1_dosis_T4='88') med1_ppp=0.04.
IF  (atc1_T4='H03AA01' and med1_dosis_T4='200 en 175') med1_ppp=0.15.
IF  (atc2_T4='H03AA01') med2_recept=1.
IF  (atc2_T4='H03AA01' and med2_dosis_T4='75') med2_ppp=0.03.
IF  (atc2_T4='H03AA01' and med2_dosis_T4='125') med2_ppp=0.06.
IF  (atc2_T4='H03AA01' and med2_dosis_T4='150') med2_ppp=0.06.
IF  (atc2_T4='H03AA01' and med2_dosis_T4='112') med2_ppp=0.05.
IF  (atc2_T4='H03AA01' and med2_dosis_T4='175') med2_ppp=0.07.
IF  (atc3_T4='H03AA01') med3_recept=1.
IF  (atc3_T4='H03AA01' and med3_dosis_T4='75') med3_ppp=0.03.
IF  (atc4_T4='H03AA01') med4_recept=1.
IF  (atc4_T4='H03AA01' and med4_dosis_T4='125') med4_ppp=0.06.
**ATC H02AB09- hydrocortison.
IF  (atc4_T4='H02AB09') med4_recept=1.
IF  (atc4_T4='H02AB09' and med4_dosis_T4='20 en 10') med4_ppp=0.36.
**ATC H02AB07-prednison.
IF  (atc1_T4='H02AB07') med1_recept=1.
IF  (atc1_T4='H02AB07' and med1_dosis_T4='30') med1_ppp=0.61.
IF  (atc1_T4='H02AB07' and med1_dosis_T4='2.5 en 5') med1_ppp=0.39.
IF  (atc2_T4='H02AB07') med2_recept=1.
IF  (atc2_T4='H02AB07' and med2_dosis_T4='') med2_ppp=0.05.
IF  (atc4_T4='H02AB07') med4_recept=1.
IF  (atc4_T4='H02AB07' and med4_dosis_T4='30') med4_ppp=0.61.
IF  (atc8_T4='H02AB07') med8_recept=1.
IF  (atc8_T4='H02AB07' and med8_dosis_T4='') med8_ppp=0.05.
IF  (atc10_T4='H02AB07') med10_recept=1.
IF  (atc10_T4='H02AB07' and med10_dosis_T4='') med10_ppp=0.05.
**ATC H02AB06 - prednisolon.
IF  (atc1_T4='H02AB06') med1_recept=1.
IF  (atc1_T4='H02AB06' and med1_dosis_T4='5') med1_ppp=0.03.
IF  (atc2_T4='H02AB06') med2_recept=1.
IF  (atc2_T4='H02AB06' and med2_dosis_T4='5') med2_ppp=0.03.
IF  (atc2_T4='H02AB06' and med2_dosis_T4='') med2_ppp=0.03.
IF  (atc3_T4='H02AB06') med3_recept=1.
IF  (atc3_T4='H02AB06' and med3_dosis_T4='5 en 2.5') med3_ppp=0.30.
**ATC H02AB01 - .
IF  (atc1_T4='H02AB01') med1_recept=1.
IF  (atc1_T4='H02AB01' and med1_dosis_T4='0.5') med1_ppp=0.77.
**ATC G04CB01 - finasteride.
IF  (atc1_T4='G04CB01') med1_recept=1.
IF  (atc1_T4='G04CB01' and med1_dosis_T4='1') med1_ppp=0.60.
IF  (atc2_T4='G04CB01') med2_recept=1.
IF  (atc2_T4='G04CB01' and med2_dosis_T4='1,25') med2_ppp=0.60.
**ATC G04CA02 - tamsulosine.
IF  (atc1_T4='G04CA02') med1_recept=1.
IF  (atc1_T4='G04CA02' and med1_dosis_T4='0,4') med1_ppp=0.04.
IF  (atc2_T4='G04CA02') med2_recept=1.
IF  (atc2_T4='G04CA02' and med2_dosis_T4='0,4') med2_ppp=0.04.
IF  (atc3_T4='G04CA02') med3_recept=1.
IF  (atc3_T4='G04CA02' and med3_dosis_T4='0,4') med3_ppp=0.04.
IF  (atc3_T4='G04CA02' and med3_dosis_T4='') med3_ppp=0.04.
IF  (atc4_T4='G04CA02') med4_recept=1.
IF  (atc4_T4='G04CA02' and med4_dosis_T4='0,4') med4_ppp=0.04.
IF  (atc5_T4='G04CA02') med5_recept=1.
IF  (atc5_T4='G04CA02' and med5_dosis_T4='0,4') med5_ppp=0.04.
IF  (atc7_T4='G04CA02') med7_recept=1.
IF  (atc7_T4='G04CA02' and med7_dosis_T4='0,4') med7_ppp=0.04.
**ATC G04BD08 .
IF  (atc1_T4='G04BD08') med1_recept=1.
IF  (atc1_T4='G04BD08' and med1_dosis_T4='') med1_ppp=0.88.
IF  (atc3_T4='G04BD08') med3_recept=1.
IF  (atc3_T4='G04BD08' and med3_dosis_T4='10') med3_ppp=1.22.
**ATC G03CX01 .
IF  (atc8_T4='G03CX01') med8_recept=1.
IF  (atc8_T4='G03CX01' and med8_dosis_T4='2.5') med8_ppp=0.55.
**ATC G03CA04 .
IF  (atc6_T4='G03CA04') med6_recept=1.
IF  (atc6_T4='G03CA04' and med6_dosis_T4='') med6_ppp=0.13.
IF  (atc9_T4='G03CA04') med9_recept=1.
IF  (atc9_T4='G03CA04' and med9_dosis_T4='0,5') med9_ppp=0.49.
**ATC G03AA10 .
IF  (atc1_T4='G03AA10') med1_recept=1.
IF  (atc1_T4='G03AA10' and med1_dosis_T4='') med1_ppp=0.07.
**ATC G03AA07 .
IF  (atc7_T4='G03AA07') med7_recept=1.
IF  (atc7_T4='G03AA07' and med7_dosis_T4='') med7_ppp=0.01.
**ATC G02CB03 .
IF  (atc1_T4='G02CB03') med1_recept=1.
IF  (atc1_T4='G02CB03' and med1_dosis_T4='0.5') med1_ppp=4.74.
IF  (atc6_T4='G02CB03') med6_recept=1.
IF  (atc6_T4='G02CB03' and med6_dosis_T4='1,5 tablet van 0.5') med6_ppp=7.10.
**ATC D07AD01 .
IF  (atc3_T4='D07AD01') med3_recept=1.
IF  (atc3_T4='D07AD01' and med3_dosis_T4='') med3_ppp=999.
**ATC D07AC17 .
IF  (atc3_T4='D07AC17') med3_recept=1.
IF  (atc3_T4='D07AC17' and med3_dosis_T4='0,5') med3_ppp=999.
**ATC D07AC01 betamethason.
IF  (atc1_T4='D07AC01') med1_recept=1.
IF  (atc1_T4='D07AC01' and med1_dosis_T4='1') med1_ppp=999.
**ATC D05BB02 .
IF  (atc1_T4='D05BB02') med1_recept=1.
IF  (atc1_T4='D05BB02' and med1_dosis_T4='10') med1_ppp=0.63.
**ATC D01BA02 .
IF  (atc1_T4='D01BA02') med1_recept=1.
IF  (atc1_T4='D01BA02' and med1_dosis_T4='250') med1_ppp=0.07.
IF  (atc3_T4='D01BA02') med3_recept=1.
IF  (atc3_T4='D01BA02' and med3_dosis_T4='250') med3_ppp=0.07.
**ATC C10AX14 - .
IF  (atc8_T4='C10AX14') med8_recept=1.
IF  (atc8_T4='C10AX14' and med8_dosis_T4='75') med8_ppp=230.02.
**ATC C10AX09 - ezetimibe.
IF  (atc4_T4='C10AX09') med4_recept=1.
IF  (atc4_T4='C10AX09' and med4_dosis_T4='10') med4_ppp=0.80.
IF  (atc5_T4='C10AX09') med5_recept=1.
IF  (atc5_T4='C10AX09' and med5_dosis_T4='') med5_ppp=0.80.
IF  (atc7_T4='C10AX09') med7_recept=1.
IF  (atc7_T4='C10AX09' and med7_dosis_T4='') med7_ppp=0.80.
IF  (atc8_T4='C10AX09') med8_recept=1.
IF  (atc8_T4='C10AX09' and med8_dosis_T4='10') med8_ppp=0.80.
**ATC C10AA07 - crestor / rosuvastatine.
IF  (atc1_T4='C10AA07') med1_recept=1.
IF  (atc1_T4='C10AA07' and med1_dosis_T4='5') med1_ppp=0.70.
IF  (atc1_T4='C10AA07' and med1_dosis_T4='20') med1_ppp=1.13.
IF  (atc1_T4='C10AA07' and med1_dosis_T4='40') med1_ppp=1.59.
IF  (atc2_T4='C10AA07') med2_recept=1.
IF  (atc2_T4='C10AA07' and med2_dosis_T4='5') med2_ppp=0.70.
IF  (atc2_T4='C10AA07' and med2_dosis_T4='40') med2_ppp=1.59.
IF  (atc3_T4='C10AA07') med3_recept=1.
IF  (atc3_T4='C10AA07' and med3_dosis_T4='5') med3_ppp=0.70.
IF  (atc3_T4='C10AA07' and med3_dosis_T4='') med3_ppp=0.70.
IF  (atc4_T4='C10AA07') med4_recept=1.
IF  (atc4_T4='C10AA07' and med4_dosis_T4='5') med4_ppp=0.70.
IF  (atc4_T4='C10AA07' and med4_dosis_T4='10') med4_ppp=0.78.
IF  (atc4_T4='C10AA07' and med4_dosis_T4='40') med4_ppp=1.59.
IF  (atc4_T4='C10AA07' and med4_dosis_T4='') med4_ppp=0.70.
IF  (atc5_T4='C10AA07') med5_recept=1.
IF  (atc5_T4='C10AA07' and med5_dosis_T4='10') med5_ppp=0.78.
IF  (atc6_T4='C10AA07') med6_recept=1.
IF  (atc6_T4='C10AA07' and med6_dosis_T4='') med6_ppp=0.70.
IF  (atc9_T4='C10AA07') med9_recept=1.
IF  (atc9_T4='C10AA07' and med9_dosis_T4='40') med9_ppp=1.59.
**ATC C10AA05 - atorvastatine.
IF  (atc1_T4='C10AA05') med1_recept=1.
IF  (atc1_T4='C10AA05' and med1_dosis_T4='10') med1_ppp=0.02.
IF  (atc1_T4='C10AA05' and med1_dosis_T4='20') med1_ppp=0.03.
IF  (atc1_T4='C10AA05' and med1_dosis_T4='40') med1_ppp=0.05.
IF  (atc2_T4='C10AA05') med2_recept=1.
IF  (atc2_T4='C10AA05' and med2_dosis_T4='10') med2_ppp=0.02.
IF  (atc2_T4='C10AA05' and med2_dosis_T4='20') med2_ppp=0.03.
IF  (atc2_T4='C10AA05' and med2_dosis_T4='40') med2_ppp=0.05.
IF  (atc3_T4='C10AA05') med3_recept=1.
IF  (atc3_T4='C10AA05' and med3_dosis_T4='40') med3_ppp=0.05.
IF  (atc4_T4='C10AA05') med4_recept=1.
IF  (atc4_T4='C10AA05' and med4_dosis_T4='20') med4_ppp=0.03.
IF  (atc4_T4='C10AA05' and med4_dosis_T4='40') med4_ppp=0.05.
IF  (atc5_T4='C10AA05') med5_recept=1.
IF  (atc5_T4='C10AA05' and med5_dosis_T4='20') med5_ppp=0.03.
IF  (atc5_T4='C10AA05' and med5_dosis_T4='40') med5_ppp=0.05.
IF  (atc5_T4='C10AA05' and med5_dosis_T4='80') med5_ppp=0.13.
IF  (atc6_T4='C10AA05') med6_recept=1.
IF  (atc6_T4='C10AA05' and med6_dosis_T4='') med6_ppp=0.02.
IF  (atc7_T4='C10AA05') med7_recept=1.
IF  (atc7_T4='C10AA05' and med7_dosis_T4='20') med7_ppp=0.03.
IF  (atc8_T4='C10AA05') med8_recept=1.
IF  (atc8_T4='C10AA05' and med8_dosis_T4='20') med8_ppp=0.03.
IF  (atc9_T4='C10AA05') med9_recept=1.
IF  (atc9_T4='C10AA05' and med9_dosis_T4='20') med9_ppp=0.03.
**ATC C10AA04 - fluvastatine.
IF  (atc2_T4='C10AA04') med2_recept=1.
IF  (atc2_T4='C10AA04' and med2_dosis_T4='20') med2_ppp=0.07.
**ATC C10AA03 - pravastatine.
IF  (atc4_T4='C10AA03') med4_recept=1.
IF  (atc4_T4='C10AA03' and med4_dosis_T4='') med4_ppp=0.03.
IF  (atc5_T4='C10AA03') med5_recept=1.
IF  (atc5_T4='C10AA03' and med5_dosis_T4='20') med5_ppp=0.04.
**ATC C10AA01 - simvastatine.
IF  (atc1_T4='C10AA01') med1_recept=1.
IF  (atc1_T4='C10AA01' and med1_dosis_T4='20') med1_ppp=0.02.
IF  (atc1_T4='C10AA01' and med1_dosis_T4='40') med1_ppp=0.02.
IF  (atc1_T4='C10AA01' and med1_dosis_T4='') med1_ppp=0.02.
IF  (atc2_T4='C10AA01') med2_recept=1.
IF  (atc2_T4='C10AA01' and med2_dosis_T4='20') med2_ppp=0.02.
IF  (atc2_T4='C10AA01' and med2_dosis_T4='40') med2_ppp=0.02.
IF  (atc3_T4='C10AA01') med3_recept=1.
IF  (atc3_T4='C10AA01' and med3_dosis_T4='40') med3_ppp=0.02.
IF  (atc3_T4='C10AA01' and med3_dosis_T4='20') med3_ppp=0.02.
IF  (atc3_T4='C10AA01' and med3_dosis_T4='') med3_ppp=0.02.
IF  (atc4_T4='C10AA01') med4_recept=1.
IF  (atc4_T4='C10AA01' and med4_dosis_T4='40') med4_ppp=0.02.
IF  (atc4_T4='C10AA01' and med4_dosis_T4='') med4_ppp=0.02.
IF  (atc5_T4='C10AA01') med5_recept=1.
IF  (atc5_T4='C10AA01' and med5_dosis_T4='40') med5_ppp=0.02.
IF  (atc6_T4='C10AA01') med6_recept=1.
IF  (atc6_T4='C10AA01' and med6_dosis_T4='40') med6_ppp=0.02.
IF  (atc6_T4='C10AA01' and med6_dosis_T4='20') med6_ppp=0.02.
IF  (atc7_T4='C10AA01') med7_recept=1.
IF  (atc7_T4='C10AA01' and med7_dosis_T4='') med7_ppp=0.02.
IF  (atc8_T4='C10AA01') med8_recept=1.
IF  (atc8_T4='C10AA01' and med8_dosis_T4='') med8_ppp=0.02.
**ATC C09DA04 - co-aproval.
IF  (atc1_T4='C09DA04') med1_recept=1.
IF  (atc1_T4='C09DA04' and med1_dosis_T4='300/12.5') med1_ppp=0.06.
IF  (atc1_T4='C09DA04') med1_recept=1.
IF  (atc1_T4='C09DA04' and med1_dosis_T4='300/?') med1_ppp=0.05.
**ATC C09DA03 - valsartan/hydrochloorthiazide.
IF  (atc1_T4='C09DA03') med1_recept=1.
IF  (atc1_T4='C09DA03' and med1_dosis_T4='80/12.5') med1_ppp=0.02.
**ATC C09CA07 - telmisartan.
IF  (atc1_T4='C09CA07') med1_recept=1.
IF  (atc1_T4='C09CA07' and med1_dosis_T4='80') med1_ppp=0.04.
**ATC C09CA06 - candesartan.
IF  (atc1_T4='C09CA06') med1_recept=1.
IF  (atc1_T4='C09CA06' and med1_dosis_T4='4') med1_ppp=0.02.
IF  (atc1_T4='C09CA06' and med1_dosis_T4='16') med1_ppp=0.03.
IF  (atc2_T4='C09CA06') med2_recept=1.
IF  (atc2_T4='C09CA06' and med2_dosis_T4='') med2_ppp=0.02.
**ATC C09CA04 - irbesartan.
IF  (atc1_T4='C09CA04') med1_recept=1.
IF  (atc1_T4='C09CA04' and med1_dosis_T4='300') med1_ppp=0.05.
IF  (atc1_T4='C09CA04' and med1_dosis_T4='150') med1_ppp=0.03.
IF  (atc1_T4='C09CA04' and med1_dosis_T4='') med1_ppp=0.03.
IF  (atc2_T4='C09CA04') med2_recept=1.
IF  (atc2_T4='C09CA04' and med2_dosis_T4='') med2_ppp=0.03.
IF  (atc3_T4='C09CA04') med3_recept=1.
IF  (atc3_T4='C09CA04' and med3_dosis_T4='75') med3_ppp=0.03.
IF  (atc4_T4='C09CA04') med4_recept=1.
IF  (atc4_T4='C09CA04' and med4_dosis_T4='150') med4_ppp=0.03.
IF  (atc4_T4='C09CA04' and med4_dosis_T4='300') med4_ppp=0.05.
IF  (atc5_T4='C09CA04') med5_recept=1.
IF  (atc5_T4='C09CA04' and med5_dosis_T4='150') med5_ppp=0.03.
**ATC C09CA03 - valsartan.
IF  (atc1_T4='C09CA03') med1_recept=1.
IF  (atc1_T4='C09CA03' and med1_dosis_T4='40') med1_ppp=0.04.
IF  (atc2_T4='C09CA03') med2_recept=1.
IF  (atc2_T4='C09CA03' and med2_dosis_T4='40') med2_ppp=0.04.
IF  (atc5_T4='C09CA03') med5_recept=1.
IF  (atc5_T4='C09CA03' and med5_dosis_T4='160') med5_ppp=0.04.
**ATC C09CA01 - losartan.
IF  (atc1_T4='C09CA01') med1_recept=1.
IF  (atc1_T4='C09CA01' and med1_dosis_T4='50') med1_ppp=0.01.
IF  (atc1_T4='C09CA01' and med1_dosis_T4='100') med1_ppp=0.03.
IF  (atc2_T4='C09CA01') med2_recept=1.
IF  (atc2_T4='C09CA01' and med2_dosis_T4='') med2_ppp=0.01.
IF  (atc2_T4='C09CA01' and med2_dosis_T4='50') med2_ppp=0.01.
IF  (atc2_T4='C09CA01' and med2_dosis_T4='100') med2_ppp=0.03.
IF  (atc3_T4='C09CA01') med3_recept=1.
IF  (atc3_T4='C09CA01' and med3_dosis_T4='50') med3_ppp=0.01.
IF  (atc5_T4='C09CA01') med5_recept=1.
IF  (atc5_T4='C09CA01' and med5_dosis_T4='50') med5_ppp=0.01.
**ATC C09BA03 - .
IF  (atc1_T4='C09BA03') med1_recept=1.
IF  (atc1_T4='C09BA03' and med1_dosis_T4='20/12.5') med1_ppp=0.07.
**ATC C09AA06 - quinapril.
IF  (atc1_T4='C09AA06') med1_recept=1.
IF  (atc1_T4='C09AA06' and med1_dosis_T4='') med1_ppp=0.07.
IF  (atc1_T4='C09AA06' and med1_dosis_T4='20') med1_ppp=0.11.
IF  (atc2_T4='C09AA06') med2_recept=1.
IF  (atc2_T4='C09AA06' and med2_dosis_T4='') med2_ppp=0.07.
IF  (atc2_T4='C09AA06' and med2_dosis_T4='20') med2_ppp=0.11.
IF  (atc3_T4='C09AA06') med3_recept=1.
IF  (atc3_T4='C09AA06' and med3_dosis_T4='') med3_ppp=0.07.
IF  (atc4_T4='C09AA06') med4_recept=1.
IF  (atc4_T4='C09AA06' and med4_dosis_T4='10') med4_ppp=0.08.
IF  (atc5_T4='C09AA06') med5_recept=1.
IF  (atc5_T4='C09AA06' and med5_dosis_T4='10') med5_ppp=0.08.
**ATC C09AA05- ramipril.
IF  (atc1_T4='C09AA05') med1_recept=1.
IF  (atc1_T4='C09AA05' and med1_dosis_T4='2,5') med1_ppp=0.04.
IF  (atc1_T4='C09AA05' and med1_dosis_T4='5') med1_ppp=0.04.
IF  (atc2_T4='C09AA05') med2_recept=1.
IF  (atc2_T4='C09AA05' and med2_dosis_T4='2,5') med2_ppp=0.04.
IF  (atc3_T4='C09AA05') med3_recept=1.
IF  (atc3_T4='C09AA05' and med3_dosis_T4='5') med3_ppp=0.04.
**ATC C09AA04- perindopril.
IF  (atc1_T4='C09AA04') med1_recept=1.
IF  (atc1_T4='C09AA04' and med1_dosis_T4='8') med1_ppp=0.04.
IF  (atc1_T4='C09AA04' and med1_dosis_T4='4') med1_ppp=0.02.
IF  (atc1_T4='C09AA04' and med1_dosis_T4='2x10') med1_ppp=0.77.
IF  (atc2_T4='C09AA04') med2_recept=1.
IF  (atc2_T4='C09AA04' and med2_dosis_T4='8') med2_ppp=0.04.
IF  (atc2_T4='C09AA04' and med2_dosis_T4='5') med2_ppp=0.28.
IF  (atc2_T4='C09AA04' and med2_dosis_T4='2x10') med2_ppp=0.77.
IF  (atc3_T4='C09AA04') med3_recept=1.
IF  (atc3_T4='C09AA04' and med3_dosis_T4='4') med3_ppp=0.02.
IF  (atc3_T4='C09AA04' and med3_dosis_T4='2 en 4') med3_ppp=0.04.
IF  (atc4_T4='C09AA04') med4_recept=1.
IF  (atc4_T4='C09AA04' and med4_dosis_T4='2') med4_ppp=0.02.
IF  (atc5_T4='C09AA04') med5_recept=1.
IF  (atc5_T4='C09AA04' and med5_dosis_T4='2') med5_ppp=0.02.
IF  (atc6_T4='C09AA04') med6_recept=1.
IF  (atc6_T4='C09AA04' and med6_dosis_T4='10') med6_ppp=0.39.
**ATC C09AA03- lisinopril.
IF  (atc1_T4='C09AA03') med1_recept=1.
IF  (atc1_T4='C09AA03' and med1_dosis_T4='20') med1_ppp=0.02.
IF  (atc1_T4='C09AA03' and med1_dosis_T4='10') med1_ppp=0.02.
IF  (atc2_T4='C09AA03') med2_recept=1.
IF  (atc2_T4='C09AA03' and med2_dosis_T4='') med2_ppp=0.02.
IF  (atc2_T4='C09AA03' and med2_dosis_T4='20') med2_ppp=0.02.
IF  (atc3_T4='C09AA03') med3_recept=1.
IF  (atc3_T4='C09AA03' and med3_dosis_T4='5') med3_ppp=0.02.
IF  (atc7_T4='C09AA03') med7_recept=1.
IF  (atc7_T4='C09AA03' and med7_dosis_T4='10') med7_ppp=0.02.
**ATC C09AA02- enalapril.
IF  (atc1_T4='C09AA02') med1_recept=1.
IF  (atc1_T4='C09AA02' and med1_dosis_T4='20') med1_ppp=0.02.
IF  (atc1_T4='C09AA02' and med1_dosis_T4='') med1_ppp=0.02.
IF  (atc2_T4='C09AA02') med2_recept=1.
IF  (atc2_T4='C09AA02' and med2_dosis_T4='20') med2_ppp=0.02.
IF  (atc3_T4='C09AA02') med3_recept=1.
IF  (atc3_T4='C09AA02' and med3_dosis_T4='5') med3_ppp=0.02.
IF  (atc4_T4='C09AA02') med4_recept=1.
IF  (atc4_T4='C09AA02' and med4_dosis_T4='10') med4_ppp=0.02.
IF  (atc4_T4='C09AA02' and med4_dosis_T4='') med4_ppp=0.02.
IF  (atc5_T4='C09AA02') med5_recept=1.
IF  (atc5_T4='C09AA02' and med5_dosis_T4='') med5_ppp=0.02.
**ATC C08DB01- diltiazem.
IF  (atc1_T4='C08DB01') med1_recept=1.
IF  (atc1_T4='C08DB01' and med1_dosis_T4='200') med1_ppp=0.10.
IF  (atc1_T4='C08DB01' and med1_dosis_T4='') med1_ppp=0.03.
**ATC C08DA01- verapamil.
IF  (atc2_T4='C08DA01') med2_recept=1.
IF  (atc2_T4='C08DA01' and med2_dosis_T4='') med2_ppp=0.03.
IF  (atc4_T4='C08DA01') med4_recept=1.
IF  (atc4_T4='C08DA01' and med4_dosis_T4='') med4_ppp=0.03.
**ATC C08CA13- lercandipine.
IF  (atc2_T4='C08CA13') med2_recept=1.
IF  (atc2_T4='C08CA13' and med2_dosis_T4='10') med2_ppp=0.05.
**ATC C08CA12.
IF  (atc2_T4='C08CA12') med2_recept=1.
IF  (atc2_T4='C08CA12' and med2_dosis_T4='10') med2_ppp=0.69.
IF  (atc4_T4='C08CA12') med4_recept=1.
IF  (atc4_T4='C08CA12' and med4_dosis_T4='10') med4_ppp=0.69.
**ATC C08CA05- nefidipine.
IF  (atc1_T4='C08CA05') med1_recept=1.
IF  (atc1_T4='C08CA05' and med1_dosis_T4='60') med1_ppp=0.14.
IF  (atc2_T4='C08CA05') med2_recept=1.
IF  (atc2_T4='C08CA05' and med2_dosis_T4='60') med2_ppp=0.14.
IF  (atc3_T4='C08CA05') med3_recept=1.
IF  (atc3_T4='C08CA05' and med3_dosis_T4='30') med3_ppp=0.14.
IF  (atc4_T4='C08CA05') med4_recept=1.
IF  (atc4_T4='C08CA05' and med4_dosis_T4='60') med4_ppp=0.14.
IF  (atc5_T4='C08CA05') med5_recept=1.
IF  (atc5_T4='C08CA05' and med5_dosis_T4='30') med5_ppp=0.14.
**ATC C08CA01- amlodipine.
IF  (atc1_T4='C08CA01') med1_recept=1.
IF  (atc1_T4='C08CA01' and med1_dosis_T4='2x5') med1_ppp=0.04.
IF  (atc2_T4='C08CA01') med2_recept=1.
IF  (atc2_T4='C08CA01' and med2_dosis_T4='') med2_ppp=0.02.
IF  (atc2_T4='C08CA01' and med2_dosis_T4='10') med2_ppp=0.02.
IF  (atc2_T4='C08CA01' and med2_dosis_T4='5') med2_ppp=0.02.
IF  (atc3_T4='C08CA01') med3_recept=1.
IF  (atc3_T4='C08CA01' and med3_dosis_T4='10') med3_ppp=0.02.
IF  (atc5_T4='C08CA01') med5_recept=1.
IF  (atc5_T4='C08CA01' and med5_dosis_T4='10') med5_ppp=0.02.
IF  (atc6_T4='C08CA01') med6_recept=1.
IF  (atc6_T4='C08CA01' and med6_dosis_T4='5') med6_ppp=0.02.
IF  (atc6_T4='C08CA01' and med6_dosis_T4='10') med6_ppp=0.02.
**ATC C07BB02- metoprolol/HCT.
IF  (atc1_T4='C07BB02') med1_recept=1.
IF  (atc1_T4='C07BB02' and med1_dosis_T4='95/12,5') med1_ppp=0.24.
**ATC C07AB12- nebivolol.
IF  (atc4_T4='C07AB12') med4_recept=1.
IF  (atc4_T4='C07AB12' and med4_dosis_T4='halve 5') med4_ppp=0.02.
**ATC C07AB07- bisoprolol.
IF  (atc2_T4='C07AB07') med2_recept=1.
IF  (atc2_T4='C07AB07' and med2_dosis_T4='') med2_ppp=0.02.
IF  (atc3_T4='C07AB07') med3_recept=1.
IF  (atc3_T4='C07AB07' and med3_dosis_T4='') med3_ppp=0.02.
IF  (atc3_T4='C07AB07' and med3_dosis_T4='5') med3_ppp=0.02.
IF  (atc5_T4='C07AB07') med5_recept=1.
IF  (atc5_T4='C07AB07' and med5_dosis_T4='5') med5_ppp=0.02.
IF  (atc7_T4='C07AB07') med7_recept=1.
IF  (atc7_T4='C07AB07' and med7_dosis_T4='5') med7_ppp=0.02.
**ATC C07AB02- metoprolol.
IF  (atc1_T4='C07AB02') med1_recept=1.
IF  (atc1_T4='C07AB02' and med1_dosis_T4='50') med1_ppp=0.02.
IF  (atc1_T4='C07AB02' and med1_dosis_T4='25') med1_ppp=0.03.
IF  (atc2_T4='C07AB02') med2_recept=1.
IF  (atc2_T4='C07AB02' and med2_dosis_T4='25') med2_ppp=0.03.
IF  (atc2_T4='C07AB02' and med2_dosis_T4='50') med2_ppp=0.02.
IF  (atc2_T4='C07AB02' and med2_dosis_T4='') med2_ppp=0.02.
IF  (atc3_T4='C07AB02') med3_recept=1.
IF  (atc3_T4='C07AB02' and med3_dosis_T4='50') med3_ppp=0.02.
IF  (atc3_T4='C07AB02' and med3_dosis_T4='100') med3_ppp=0.02.
IF  (atc3_T4='C07AB02' and med3_dosis_T4='100+50') med3_ppp=0.04.
IF  (atc3_T4='C07AB02' and med3_dosis_T4='25') med3_ppp=0.03.
IF  (atc3_T4='C07AB02' and med3_dosis_T4='') med3_ppp=0.02.
IF  (atc4_T4='C07AB02') med4_recept=1.
IF  (atc4_T4='C07AB02' and med4_dosis_T4='') med4_ppp=0.02.
IF  (atc4_T4='C07AB02' and med4_dosis_T4='25') med4_ppp=0.03.
IF  (atc5_T4='C07AB02') med5_recept=1.
IF  (atc5_T4='C07AB02' and med5_dosis_T4='') med5_ppp=0.02.
IF  (atc9_T4='C07AB02') med9_recept=1.
IF  (atc9_T4='C07AB02' and med9_dosis_T4='') med9_ppp=0.02.
**ATC C07AA07- sotalol.
IF  (atc1_T4='C07AA07') med1_recept=1.
IF  (atc1_T4='C07AA07' and med1_dosis_T4='80') med1_ppp=0.04.
IF  (atc2_T4='C07AA07') med2_recept=1.
IF  (atc2_T4='C07AA07' and med2_dosis_T4='80') med2_ppp=0.04.
IF  (atc6_T4='C07AA07') med6_recept=1.
IF  (atc6_T4='C07AA07' and med6_dosis_T4='160+40') med6_ppp=0.13.
**ATC C03DA01- .
IF  (atc2_T4='C03DA01') med2_recept=1.
IF  (atc2_T4='C03DA01' and med2_dosis_T4='halve van 25') med2_ppp=0.02.
IF  (atc5_T4='C03DA01') med5_recept=1.
IF  (atc5_T4='C03DA01' and med5_dosis_T4='25') med5_ppp=0.04.
**ATC C03CA02- furosemide.
IF  (atc3_T4='C03CA02') med3_recept=1.
IF  (atc3_T4='C03CA02' and med3_dosis_T4='') med3_ppp=0.03.
**ATC C03CA01- furosemide.
IF  (atc1_T4='C03CA01') med1_recept=1.
IF  (atc1_T4='C03CA01' and med1_dosis_T4='60') med1_ppp=0.12.
IF  (atc1_T4='C03CA01' and med1_dosis_T4='2x40') med1_ppp=0.04.
IF  (atc2_T4='C03CA01') med2_recept=1.
IF  (atc2_T4='C03CA01' and med2_dosis_T4='2x40') med2_ppp=0.04.
IF  (atc3_T4='C03CA01') med3_recept=1.
IF  (atc3_T4='C03CA01' and med3_dosis_T4='40') med3_ppp=0.02.
**ATC C03BA04- chloortalidon.
IF  (atc1_T4='C03BA04') med1_recept=1.
IF  (atc1_T4='C03BA04' and med1_dosis_T4='25') med1_ppp=0.04.
**ATC C03AA03- hydrochloorthiazide.
IF  (atc1_T4='C03AA03') med1_recept=1.
IF  (atc1_T4='C03AA03' and med1_dosis_T4='12,5') med1_ppp=0.03.
IF  (atc1_T4='C03AA03' and med1_dosis_T4='25') med1_ppp=0.02.
IF  (atc1_T4='C03AA03' and med1_dosis_T4='') med1_ppp=0.02.
IF  (atc2_T4='C03AA03') med2_recept=1.
IF  (atc2_T4='C03AA03' and med2_dosis_T4='') med2_ppp=0.02.
IF  (atc2_T4='C03AA03' and med2_dosis_T4='') med2_ppp=0.02.
IF  (atc2_T4='C03AA03' and med2_dosis_T4='12.5') med2_ppp=0.03.
IF  (atc3_T4='C03AA03') med3_recept=1.
IF  (atc3_T4='C03AA03' and med3_dosis_T4='12.5') med3_ppp=0.03.
IF  (atc4_T4='C03AA03') med4_recept=1.
IF  (atc4_T4='C03AA03' and med4_dosis_T4='25') med4_ppp=0.02.
IF  (atc4_T4='C03AA03' and med4_dosis_T4='') med4_ppp=0.02.
IF  (atc5_T4='C03AA03') med5_recept=1.
IF  (atc5_T4='C03AA03' and med5_dosis_T4='25') med5_ppp=0.02.
IF  (atc6_T4='C03AA03') med6_recept=1.
IF  (atc6_T4='C03AA03' and med6_dosis_T4='25') med6_ppp=0.02.
IF  (atc6_T4='C03AA03' and med6_dosis_T4='12,5') med6_ppp=0.03.
IF  (atc7_T4='C03AA03') med7_recept=1.
IF  (atc7_T4='C03AA03' and med7_dosis_T4='12.5') med7_ppp=0.03.
IF  (atc8_T4='C03AA03') med8_recept=1.
IF  (atc8_T4='C03AA03' and med8_dosis_T4='5') med8_ppp=5.53.
**ATC C01DA08- .
IF  (atc10_T4='C01DA08') med10_recept=1.
IF  (atc10_T4='C01DA08' and med10_dosis_T4='5') med10_ppp=0.03.
**ATC C01DA14- isosorbide mononitraat.
IF  (atc2_T4='C01DA14') med2_recept=1.
IF  (atc2_T4='C01DA14' and med2_dosis_T4='25') med2_ppp=0.24.
IF  (atc4_T4='C01DA14') med4_recept=1.
IF  (atc4_T4='C01DA14' and med4_dosis_T4='30') med4_ppp=0.29.
IF  (atc4_T4='C01DA14' and med4_dosis_T4='100') med4_ppp=0.96.
IF  (atc5_T4='C01DA14') med5_recept=1.
IF  (atc5_T4='C01DA14' and med5_dosis_T4='100') med5_ppp=0.96.
IF  (atc7_T4='C01DA14') med7_recept=1.
IF  (atc7_T4='C01DA14' and med7_dosis_T4='25') med7_ppp=0.24.
**ATC B03BB01- foliumzuur.
IF  (atc1_T4='B03BB01') med1_recept=0.
IF  (atc1_T4='B03BB01' and med1_dosis_T4='2x5') med1_ppp=0.06.
IF  (atc2_T4='B03BB01') med2_recept=0.
IF  (atc2_T4='B03BB01' and med2_dosis_T4='5') med2_ppp=0.03.
IF  (atc3_T4='B03BB01') med3_recept=0.
IF  (atc3_T4='B03BB01' and med3_dosis_T4='5') med3_ppp=0.03.
IF  (atc4_T4='B03BB01') med4_recept=0.
IF  (atc4_T4='B03BB01' and med4_dosis_T4='5') med4_ppp=0.03.
IF  (atc5_T4='B03BB01') med5_recept=0.
IF  (atc5_T4='B03BB01' and med5_dosis_T4='halve van 5') med5_ppp=0.02.
IF  (atc7_T4='B03BB01') med7_recept=0.
IF  (atc7_T4='B03BB01' and med7_dosis_T4='') med7_ppp=0.03.
IF  (atc9_T4='B03BB01') med9_recept=0.
IF  (atc9_T4='B03BB01' and med9_dosis_T4='') med9_ppp=0.03.
**ATC B03BA03- vit B12 injectie.
IF  (atc2_T4='B03BA03') med2_recept=1.
IF  (atc2_T4='B03BA03' and med2_dosis_T4='2') med2_ppp=0.70.
IF  (atc2_T4='B03BA03' and med2_dosis_T4='') med2_ppp=0.70.
IF  (atc3_T4='B03BA03') med3_recept=1.
IF  (atc3_T4='B03BA03' and med3_dosis_T4='2') med3_ppp=0.70.
**ATC B01AF02- .
IF  (atc3_T4='B01AF02') med3_recept=1.
IF  (atc3_T4='B01AF02' and med3_dosis_T4='5') med3_ppp=1.09.
IF  (atc3_T4='B01AF02' and med3_dosis_T4='2x5') med3_ppp=2.18.
**ATC B01AF01- .
IF  (atc3_T4='B01AF01') med3_recept=1.
IF  (atc3_T4='B01AF01' and med3_dosis_T4='20') med3_ppp=2.29.
IF  (atc4_T4='B01AF01') med4_recept=1.
IF  (atc4_T4='B01AF01' and med4_dosis_T4='20') med4_ppp=2.29.
**ATC B01AC08- ascal.(100 gr maakt niet uit of het poeder of tablet is, is even duur).
IF  (atc1_T4='B01AC08') med1_recept=1.
IF  (atc1_T4='B01AC08' and med1_dosis_T4='100') med1_ppp=0.06.
IF  (atc1_T4='B01AC08' and med1_dosis_T4='') med1_ppp=0.06.
IF  (atc2_T4='B01AC08') med2_recept=1.
IF  (atc2_T4='B01AC08' and med2_dosis_T4='100') med2_ppp=0.06.
IF  (atc2_T4='B01AC08' and med2_dosis_T4='') med2_ppp=0.06.
IF  (atc3_T4='B01AC08') med3_recept=1.
IF  (atc3_T4='B01AC08' and med3_dosis_T4='100') med3_ppp=0.06.
IF  (atc3_T4='B01AC08' and med3_dosis_T4='') med3_ppp=0.06.
IF  (atc4_T4='B01AC08') med4_recept=1.
IF  (atc4_T4='B01AC08' and med4_dosis_T4='100') med4_ppp=0.06.
IF  (atc4_T4='B01AC08' and med4_dosis_T4='') med4_ppp=0.06.
IF  (atc5_T4='B01AC08') med5_recept=1.
IF  (atc5_T4='B01AC08' and med5_dosis_T4='100') med5_ppp=0.06.
IF  (atc6_T4='B01AC08') med6_recept=1.
IF  (atc6_T4='B01AC08' and med6_dosis_T4='100') med6_ppp=0.06.
**ATC B01AC07- persantin .
IF  (atc1_T4='B01AC07') med1_recept=1.
IF  (atc1_T4='B01AC07' and med1_dosis_T4='200') med1_ppp=0.18.
IF  (atc3_T4='B01AC07') med3_recept=1.
IF  (atc3_T4='B01AC07' and med3_dosis_T4='200') med3_ppp=0.18.
IF  (atc4_T4='B01AC07') med4_recept=1.
IF  (atc4_T4='B01AC07' and med4_dosis_T4='200') med4_ppp=0.18.
IF  (atc5_T4='B01AC07') med5_recept=1.
IF  (atc5_T4='B01AC07' and med5_dosis_T4='400') med5_ppp=0.36.
**ATC B01AA07- acenocoumarol .
IF  (atc1_T4='B01AA07') med1_recept=1.
IF  (atc1_T4='B01AA07' and med1_dosis_T4='1') med1_ppp=0.02.
IF  (atc3_T4='B01AA07') med3_recept=1.
IF  (atc3_T4='B01AA07' and med3_dosis_T4='1') med3_ppp=0.02.
IF  (atc4_T4='B01AA07') med4_recept=1.
IF  (atc4_T4='B01AA07' and med4_dosis_T4='5x1') med4_ppp=0.09.
**ATC B01AB- trombosespuit .
IF  (atc1_T4='B01AB') med1_recept=1.
IF  (atc1_T4='B01AB' and med1_dosis_T4='') med1_ppp=1.63.
**ATC B01AC06- acetylsalisylzuur /aspirine cardio.
IF  (atc1_T4='B01AC06') med1_recept=1.
IF  (atc1_T4='B01AC06' and med1_dosis_T4='80') med1_ppp=0.03.
IF  (atc1_T4='B01AC06' and med1_dosis_T4='') med1_ppp=0.03.
IF  (atc2_T4='B01AC06') med2_recept=1.
IF  (atc2_T4='B01AC06' and med2_dosis_T4='80') med2_ppp=0.03.
IF  (atc2_T4='B01AC06' and med2_dosis_T4='') med2_ppp=0.03.
IF  (atc3_T4='B01AC06') med3_recept=1.
IF  (atc3_T4='B01AC06' and med3_dosis_T4='80') med3_ppp=0.03.
IF  (atc4_T4='B01AC06' ) med4_recept=1.
IF  (atc4_T4='B01AC06' and med4_dosis_T4='') med4_ppp=0.03.
IF  (atc4_T4='B01AC06' and med4_dosis_T4='80') med4_ppp=0.03.
IF  (atc6_T4='B01AC06' ) med6_recept=1.
IF  (atc6_T4='B01AC06' and med6_dosis_T4='80') med6_ppp=0.03.
IF  (atc7_T4='B01AC06' ) med7_recept=1.
IF  (atc7_T4='B01AC06' and med7_dosis_T4='80') med7_ppp=0.03.
IF  (atc8_T4='B01AC06' ) med8_recept=1.
IF  (atc8_T4='B01AC06' and med8_dosis_T4='') med8_ppp=0.03.
**ATC B01AC04- clopidogrel .
IF  (atc1_T4='B01AC04') med1_recept=1.
IF  (atc1_T4='B01AC04' and med1_dosis_T4='75') med1_ppp=0.04.
IF  (atc2_T4='B01AC04') med2_recept=1.
IF  (atc2_T4='B01AC04' and med2_dosis_T4='') med2_ppp=0.04.
IF  (atc3_T4='B01AC04') med3_recept=1.
IF  (atc3_T4='B01AC04' and med3_dosis_T4='') med3_ppp=0.04.
IF  (atc4_T4='B01AC04') med4_recept=1.
IF  (atc4_T4='B01AC04' and med4_dosis_T4='75') med4_ppp=0.04.
IF  (atc6_T4='B01AC04') med6_recept=1.
IF  (atc6_T4='B01AC04' and med6_dosis_T4='75') med6_ppp=0.04.
**ATC B01AB06-  .
IF  (atc1_T4='B01AB06') med1_recept=1.
IF  (atc1_T4='B01AB06' and med1_dosis_T4='') med1_ppp=1.88.
IF  (atc2_T4='B01AB06') med2_recept=1.
IF  (atc2_T4='B01AB06' and med2_dosis_T4='0.3') med2_ppp=1.88.
**ATC B01AA04- fenprocoumon .
IF  (atc4_T4='B01AA04') med4_recept=1.
IF  (atc4_T4='B01AA04' and med4_dosis_T4='3') med4_ppp=0.07.
IF  (atc7_T4='B01AA04') med7_recept=1.
IF  (atc7_T4='B01AA04' and med7_dosis_T4='') med7_ppp=0.07.
**ATC B01AA04-  .
IF  (atc2_T4='B01AA04') med2_recept=1.
IF  (atc2_T4='B01AA04' and med2_dosis_T4='3') med2_ppp=0.07.
**ATC B01- (75 mg=clopidogrel) .
IF  (atc1_T4='B01') med1_recept=1.
IF  (atc1_T4='B01' and med1_dosis_T4='75') med1_ppp=0.04.
**ATC B01- (100 mg is waarschijnlijk carbasalaatcalcium of acetylsalisylzuur (beide 0.06)) .
IF  (atc2_T4='B01') med2_recept=1.
IF  (atc2_T4='B01' and med2_dosis_T4='100') med2_ppp=0.06.
**ATC A12BA01- Kalium.
IF  (atc3_T4='A12BA01') med3_recept=1.
IF  (atc3_T4='A12BA01' and med3_dosis_T4='') med3_ppp=0.21.
**ATC A12AA04- Calciumcarbonaat.
IF  (atc1_T4='A12AA04') med1_recept=1.
IF  (atc1_T4='A12AA04' and med1_dosis_T4='500') med1_ppp=0.13.
IF  (atc2_T4='A12AA04') med2_recept=1.
IF  (atc2_T4='A12AA04' and med2_dosis_T4='500') med2_ppp=0.13.
IF  (atc2_T4='A12AA04' and med2_dosis_T4='') med2_ppp=0.13.
**ATC A11GA01 ascorbinezuur.
IF  (atc3_T4='A11GA01') med3_recept=0.
IF  (atc3_T4='A11GA01' and med3_dosis_T4='') med3_ppp=0.05.
**ATC A11CC05 colecalciferol -Vit D.
IF  (atc1_T4='A11CC05') med1_recept=1.
IF  (atc1_T4='A11CC05' and med1_dosis_T4='') med1_ppp=2.25.
IF  (atc2_T4='A11CC05') med2_recept=1.
IF  (atc2_T4='A11CC05' and med2_dosis_T4='800') med2_ppp=0.05.
IF  (atc2_T4='A11CC05' and med2_dosis_T4='50.000') med2_ppp=0.20.
IF  (atc3_T4='A11CC05') med3_recept=1.
IF  (atc3_T4='A11CC05' and med3_dosis_T4='800') med3_ppp=0.05.
IF  (atc4_T4='A11CC05') med4_recept=1.
IF  (atc4_T4='A11CC05' and med4_dosis_T4='') med4_ppp=0.05.
IF  (atc5_T4='A11CC05') med5_recept=1.
IF  (atc5_T4='A11CC05' and med5_dosis_T4='') med5_ppp=0.05.
IF  (atc5_T4='A11CC05') med5_recept=1.
IF  (atc5_T4='A11CC05' and med5_dosis_T4='800') med5_ppp=0.05.
**ATC A11CC03 alfacalcidol .
IF  (atc2_T4='A11CC03') med2_recept=1.
IF  (atc2_T4='A11CC03' and med2_dosis_T4='0,25') med2_ppp=0.17.
**ATC A10BD08 .
IF  (atc1_T4='A10BD08') med1_recept=1.
IF  (atc1_T4='A10BD08' and med1_dosis_T4='50/850') med1_ppp=0.74.
IF  (atc2_T4='A10BD08') med2_recept=1.
IF  (atc2_T4='A10BD08' and med2_dosis_T4='50/850') med2_ppp=0.74.
**ATC A10BB12 - glimepiride .
IF  (atc2_T4='A10BB12') med2_recept=1.
IF  (atc2_T4='A10BB12' and med2_dosis_T4='') med2_ppp=0.02.
**ATC A10BB09 - gliclazide .
IF  (atc1_T4='A10BB09') med1_recept=1.
IF  (atc1_T4='A10BB09' and med1_dosis_T4='80') med1_ppp=0.04.
IF  (atc2_T4='A10BB09') med2_recept=1.
IF  (atc2_T4='A10BB09' and med2_dosis_T4='') med2_ppp=0.04.
IF  (atc2_T4='A10BB09' and med2_dosis_T4='2x60') med2_ppp=0.35.
IF  (atc2_T4='A10BB09' and med2_dosis_T4='30') med2_ppp=0.04.
IF  (atc2_T4='A10BB09' and med2_dosis_T4='80') med2_ppp=0.04.
IF  (atc3_T4='A10BB09') med3_recept=1.
IF  (atc3_T4='A10BB09' and med3_dosis_T4='30') med3_ppp=0.04.
IF  (atc7_T4='A10BB09') med7_recept=1.
IF  (atc7_T4='A10BB09' and med7_dosis_T4='') med7_ppp=0.04.
**ATC A10BB03 - tolbutamine .
IF  (atc2_T4='A10BB03') med2_recept=1.
IF  (atc2_T4='A10BB03' and med2_dosis_T4='1000') med2_ppp=0.08.
**ATC A10BA02 - metformine.
IF  (atc1_T4='A10BA02') med1_recept=1.
IF  (atc1_T4='A10BA02' and med1_dosis_T4='500') med1_ppp=0.01.
IF  (atc1_T4='A10BA02' and med1_dosis_T4='850') med1_ppp=0.02.
IF  (atc1_T4='A10BA02' and med1_dosis_T4='2x1000') med1_ppp=0.06.
IF  (atc1_T4='A10BA02' and med1_dosis_T4='2x500') med1_ppp=0.02.
IF  (atc1_T4='A10BA02' and med1_dosis_T4='') med1_ppp=0.01.
IF  (atc1_T4='A10BA02' and med1_dosis_T4='1000') med1_ppp=0.03.
IF  (atc2_T4='A10BA02') med2_recept=1.
IF  (atc2_T4='A10BA02' and med2_dosis_T4='500') med2_ppp=0.01.
IF  (atc2_T4='A10BA02' and med2_dosis_T4='850') med2_ppp=0.02.
IF  (atc2_T4='A10BA02' and med2_dosis_T4='1000') med2_ppp=0.03.
IF  (atc3_T4='A10BA02') med3_recept=1.
IF  (atc3_T4='A10BA02' and med3_dosis_T4='500') med3_ppp=0.01.
IF  (atc3_T4='A10BA02' and med3_dosis_T4='') med3_ppp=0.01.
IF  (atc4_T4='A10BA02') med4_recept=1.
IF  (atc4_T4='A10BA02' and med4_dosis_T4='') med4_ppp=0.01.
IF  (atc5_T4='A10BA02') med5_recept=1.
IF  (atc5_T4='A10BA02' and med5_dosis_T4='500') med5_ppp=0.01.
IF  (atc7_T4='A10BA02') med7_recept=1.
IF  (atc7_T4='A10BA02' and med7_dosis_T4='500') med7_ppp=0.01.
**ATC A10AE06 lantus/insuline glargine.
IF  (atc4_T4='A10AE06') med4_recept=1.
IF  (atc4_T4='A10AE06' and med4_dosis_T4='48') med4_ppp=2.98.
**ATC A10AE04 lantus/insuline glargine.
IF  (atc1_T4='A10AE04') med1_recept=1.
IF  (atc1_T4='A10AE04' and med1_dosis_T4='38') med1_ppp=1.14.
IF  (atc7_T4='A10AE04') med7_recept=1.
IF  (atc7_T4='A10AE04' and med7_dosis_T4='48') med7_ppp=1.44.
**ATC A10AD05 novomix.
IF  (atc1_T4='A10AD05') med1_recept=1.
IF  (atc1_T4='A10AD05' and med1_dosis_T4='50') med1_ppp=7.04.
**ATC A10AB05 insuline aspart.
IF  (atc6_T4='A10AB05') med6_recept=1.
IF  (atc6_T4='A10AB05' and med6_dosis_T4='60') med6_ppp=1.20.
**ATC A10A insuline.
IF  (atc1_T4='A10A') med1_recept=1.
IF  (atc1_T4='A10A' and med1_dosis_T4='12') med1_ppp=0.24.
**ATC A09AA02 .
IF  (atc9_T4='A09AA02') med9_recept=1.
IF  (atc9_T4='A09AA02' and med9_dosis_T4='22500/25000/1250') med9_ppp=1.07.
**ATC A07EC02  .
IF  (atc2_T4='A07EC02') med2_recept=1.
IF  (atc2_T4='A07EC02' and med2_dosis_T4='') med2_ppp=999.
**ATC A07EA06  .
IF  (atc1_T4='A07EA06') med1_recept=1.
IF  (atc1_T4='A07EA06' and med1_dosis_T4='3') med1_ppp=1.01.
**ATC A07DA03 loperamide .
IF  (atc1_T4='A07DA03') med1_recept=0.
IF  (atc1_T4='A07DA03' and med1_dosis_T4='2') med1_ppp=0.10.
IF  (atc2_T4='A07DA03') med2_recept=0.
IF  (atc2_T4='A07DA03' and med2_dosis_T4='2') med2_ppp=0.10.
IF  (atc4_T4='A07DA03') med4_recept=0.
IF  (atc4_T4='A07DA03' and med4_dosis_T4='2') med4_ppp=0.10.
**ATC A06AG11 microlax .
IF  (atc2_T4='A06AG11') med2_recept=1.
IF  (atc2_T4='A06AG11' and med2_dosis_T4='') med2_ppp=1.85.
**ATC A06AD65 macrogol/electrolyten .
IF  (atc1_T4='A06AD65') med1_recept=1.
IF  (atc1_T4='A06AD65' and med1_dosis_T4='13,7') med1_ppp=0.12.
IF  (atc5_T4='A06AD65') med5_recept=1.
IF  (atc5_T4='A06AD65' and med5_dosis_T4='') med5_ppp=0.12.
**ATC A06AD11 lactulose .
IF  (atc3_T4='A06AD11') med3_recept=1.
IF  (atc3_T4='A06AD11' and med3_dosis_T4='') med3_ppp=0.19.
IF  (atc7_T4='A06AD11') med7_recept=1.
IF  (atc7_T4='A06AD11' and med7_dosis_T4='12') med7_ppp=0.29.
**ATC A06AD15 macrogol .
IF  (atc1_T4='A06AD15') med1_recept=1.
IF  (atc1_T4='A06AD15' and med1_dosis_T4='') med1_ppp=0.05.
IF  (atc3_T4='A06AD15') med3_recept=1.
IF  (atc3_T4='A06AD15' and med3_dosis_T4='10') med3_ppp=0.61.
IF  (atc5_T4='A06AD15') med5_recept=1.
IF  (atc5_T4='A06AD15' and med5_dosis_T4='13') med5_ppp=0.69.
IF  (atc7_T4='A06AD15') med7_recept=1.
IF  (atc7_T4='A06AD15' and med7_dosis_T4='2x10') med7_ppp=1.22.
**ATC A06AB02 bisacodyl .
IF  (atc1_T4='A06AB02') med1_recept=1.
IF  (atc1_T4='A06AB02' and med1_dosis_T4='5') med1_ppp=0.04.
IF  (atc2_T4='A06AB02') med2_recept=1.
IF  (atc2_T4='A06AB02' and med2_dosis_T4='5') med2_ppp=0.04.
IF  (atc5_T4='A06AB02') med5_recept=1.
IF  (atc5_T4='A06AB02' and med5_dosis_T4='5') med5_ppp=0.04.
IF  (atc6_T4='A06AB02') med6_recept=1.
IF  (atc6_T4='A06AB02' and med6_dosis_T4='5') med6_ppp=0.04.
**ATC A03FA03 domperidon .
IF  (atc1_T4='A03FA03') med1_recept=1.
IF  (atc1_T4='A03FA03' and med1_dosis_T4='halve 10') med1_ppp=0.04.
**ATC A03FA01  .
IF  (atc3_T4='A03FA01') med3_recept=1.
IF  (atc3_T4='A03FA01' and med3_dosis_T4='10' and med3_vorm_T4='zetpil') med3_ppp=0.17.
**ATC A03BB01 duspatal .
IF  (atc2_T4='A03BB01') med2_recept=1.
IF  (atc2_T4='A03BB01' and med2_dosis_T4='10') med2_ppp=0.23.
**ATC A03AA04 duspatal .
IF  (atc1_T4='A03AA04') med1_recept=1.
IF  (atc1_T4='A03AA04' and med1_dosis_T4='200') med1_ppp=0.20.
IF  (atc3_T4='A03AA04') med3_recept=1.
IF  (atc3_T4='A03AA04' and med3_dosis_T4='200') med3_ppp=0.20.
**ATC A02BX13 .
IF  (atc7_T4='A02BX13') med7_recept=1.
IF  (atc7_T4='A02BX13' and med7_dosis_T4='250') med7_ppp=0.21.
**ATC A02BC05 nexium .
IF  (atc2_T4='A02BC05') med2_recept=1.
IF  (atc2_T4='A02BC05' and med2_dosis_T4='') med2_ppp=0.06.
IF  (atc2_T4='A02BC05' and med2_dosis_T4='40') med2_ppp=0.08.
IF  (atc3_T4='A02BC05') med3_recept=1.
IF  (atc3_T4='A02BC05' and med3_dosis_T4='20') med3_ppp=0.06.
IF  (atc4_T4='A02BC05') med4_recept=1.
IF  (atc4_T4='A02BC05' and med4_dosis_T4='20') med4_ppp=0.06.
**ATC A02BC02 pantoprazol .
IF  (atc1_T4='A02BC02') med1_recept=1.
IF  (atc1_T4='A02BC02' and med1_dosis_T4='') med1_ppp=0.03.
IF  (atc1_T4='A02BC02' and med1_dosis_T4='20') med1_ppp=0.03.
IF  (atc1_T4='A02BC02' and med1_dosis_T4='40') med1_ppp=0.03.
IF  (atc2_T4='A02BC02') med2_recept=1.
IF  (atc2_T4='A02BC02' and med2_dosis_T4='') med2_ppp=0.03.
IF  (atc3_T4='A02BC02') med3_recept=1.
IF  (atc3_T4='A02BC02' and med3_dosis_T4='20') med3_ppp=0.03.
IF  (atc3_T4='A02BC02' and med3_dosis_T4='') med3_ppp=0.03.
IF  (atc4_T4='A02BC02') med4_recept=1.
IF  (atc4_T4='A02BC02' and med4_dosis_T4='') med4_ppp=0.03.
IF  (atc4_T4='A02BC02' and med4_dosis_T4='20') med4_ppp=0.03.
IF  (atc4_T4='A02BC02' and med4_dosis_T4='2x40') med4_ppp=0.06.
IF  (atc5_T4='A02BC02') med5_recept=1.
IF  (atc5_T4='A02BC02' and med5_dosis_T4='') med5_ppp=0.03.
IF  (atc5_T4='A02BC02' and med5_dosis_T4='40') med5_ppp=0.03.
IF  (atc6_T4='A02BC02') med6_recept=1.
IF  (atc6_T4='A02BC02' and med6_dosis_T4='40') med6_ppp=0.03.
IF  (atc8_T4='A02BC02') med8_recept=1.
IF  (atc8_T4='A02BC02' and med8_dosis_T4='') med8_ppp=0.03.
**ATC A02BC01 omeprazol .
IF  (atc1_T4='A02BC01') med1_recept=1.
IF  (atc1_T4='A02BC01' and med1_dosis_T4='') med1_ppp=0.02.
IF  (atc1_T4='A02BC01' and med1_dosis_T4='10') med1_ppp=0.02.
IF  (atc1_T4='A02BC01' and med1_dosis_T4='20') med1_ppp=0.02.
IF  (atc1_T4='A02BC01' and med1_dosis_T4='40') med1_ppp=0.03.
IF  (atc1_T4='A02BC01' and med1_dosis_T4='80') med1_ppp=0.06.
IF  (atc2_T4='A02BC01') med2_recept=1.
IF  (atc2_T4='A02BC01' and med2_dosis_T4='20') med2_ppp=0.02.
IF  (atc2_T4='A02BC01' and med2_dosis_T4='40') med2_ppp=0.03.
IF  (atc2_T4='A02BC01' and med2_dosis_T4='') med2_ppp=0.02.
IF  (atc3_T4='A02BC01') med3_recept=1.
IF  (atc3_T4='A02BC01' and med3_dosis_T4='20') med3_ppp=0.02.
IF  (atc3_T4='A02BC01' and med3_dosis_T4='40') med3_ppp=0.03.
IF  (atc4_T4='A02BC01') med4_recept=1.
IF  (atc4_T4='A02BC01' and med4_dosis_T4='20') med4_ppp=0.02.
IF  (atc4_T4='A02BC01' and med4_dosis_T4='40') med4_ppp=0.03.
IF  (atc6_T4='A02BC01') med6_recept=1.
IF  (atc6_T4='A02BC01' and med6_dosis_T4='10 en 20') med6_ppp=0.04.
IF  (atc6_T4='A02BC01' and med6_dosis_T4='') med6_ppp=0.02.
IF  (atc6_T4='A02BC01' and med6_dosis_T4='40') med6_ppp=0.03.
IF  (atc7_T4='A02BC01') med7_recept=1.
IF  (atc7_T4='A02BC01' and med7_dosis_T4='20') med7_ppp=0.02.
IF  (atc8_T4='A02BC01') med8_recept=1.
IF  (atc8_T4='A02BC01' and med8_dosis_T4='40') med8_ppp=0.03.
**ATC A02BA02 ranitidine .
IF  (atc1_T4='A02BA02') med1_recept=1.
IF  (atc1_T4='A02BA02' and med1_dosis_T4='300') med1_ppp=0.03.
IF  (atc2_T4='A02BA02') med2_recept=1.
IF  (atc2_T4='A02BA02' and med2_dosis_T4='300') med2_ppp=0.03.
IF  (atc7_T4='A02BA02') med7_recept=1.
IF  (atc7_T4='A02BA02' and med7_dosis_T4='150') med7_ppp=0.02.
**ATC A02AD01 rennie .
IF  (atc2_T4='A02AD01') med2_recept=0.
IF  (atc2_T4='A02AD01' and med2_dosis_T4='680/80') med2_ppp=0.12.
IF  (atc3_T4='A02AD01') med3_recept=0.
IF  (atc3_T4='A02AD01' and med3_dosis_T4='') med3_ppp=0.12.
IF  (atc4_T4='A02AD01') med4_recept=0.
IF  (atc4_T4='A02AD01' and med4_dosis_T4='') med4_ppp=0.12.
IF  (atc5_T4='A02AD01') med5_recept=0.
IF  (atc5_T4='A02AD01' and med5_dosis_T4='') med5_ppp=0.12.
EXECUTE.

**** Geen volledige ATC********************************************

*** ATC A02 - maagbeschermers.(goedkoopste=2 cent, 40 mg = 3 cent).
IF (atc1_T4='A02') med1_recept=1.
IF (atc1_T4='A02' and med1_dosis_T4='') med1_ppp=0.02.
IF (atc1_T4='A02' and med1_dosis_T4='40') med1_ppp=0.03.
IF (atc2_T4='A02') med2_recept=1.
IF (atc2_T4='A02' and med2_dosis_T4='') med2_ppp=0.02.
IF (atc2_T4='A02' and med2_dosis_T4='40') med2_ppp=0.03.
IF (atc3_T4='A02') med3_recept=1.
IF (atc3_T4='A02' and med3_dosis_T4='50') med3_ppp=0.02.
IF (atc4_T4='A02') med4_recept=1.
IF (atc4_T4='A02' and med4_dosis_T4='') med4_ppp=0.02.
IF (atc6_T4='A02') med6_recept=1.
IF (atc6_T4='A02' and med6_dosis_T4='') med6_ppp=0.02.
*** ATC B01 - bloedverdunners.
*100 mg is waarschijnlijk carbasalaatcalcium of acetylsalisylzuur (beide 0.06).
* 80 mg is waarschijnlijk acetylsalicylzuur (0.03)
* goedkoopste 0.03.
IF  (atc1_T4='B01') med1_recept=1.
IF  (atc1_T4='B01' and med1_dosis_T4='80') med1_ppp=0.03.
IF  (atc1_T4='B01' and med1_dosis_T4='') med1_ppp=0.03.
IF  (atc2_T4='B01') med2_recept=1.
IF  (atc2_T4='B01' and med2_dosis_T4='') med2_ppp=0.03.
IF  (atc2_T4='B01' and med2_dosis_T4='20') med2_ppp=0.03.
IF  (atc3_T4='B01') med3_recept=1.
IF  (atc3_T4='B01' and med3_dosis_T4='40') med3_ppp=0.03.
IF  (atc4_T4='B01') med4_recept=1.
IF  (atc4_T4='B01' and med4_dosis_T4='') med4_ppp=0.03.
IF  (atc5_T4='B01') med5_recept=1.
IF  (atc5_T4='B01' and med5_dosis_T4='') med5_ppp=0.03.

*** ATC C02 - bloeddrukverlagers.
IF  (atc1_T4='C02') med1_recept=1.
IF  (atc1_T4='C02' and med1_dosis_T4='100') med1_ppp=0.02.
IF  (atc1_T4='C02' and med1_dosis_T4='75') med1_ppp=0.03.
IF  (atc1_T4='C02' and med1_dosis_T4='105') med1_ppp=0.02.
IF  (atc1_T4='C02' and med1_dosis_T4='200') med1_ppp=0.02.
IF  (atc1_T4='C02' and med1_dosis_T4='160') med1_ppp=0.02.
IF  (atc1_T4='C02' and med1_dosis_T4='') med1_ppp=0.02.
IF  (atc2_T4='C02') med2_recept=1.
IF  (atc2_T4='C02' and med2_dosis_T4='') med2_ppp=0.02.
IF  (atc2_T4='C02' and med2_dosis_T4='100') med2_ppp=0.02.
IF  (atc3_T4='C02') med3_recept=1.
IF  (atc3_T4='C02' and med3_dosis_T4='') med3_ppp=0.02.
IF  (atc4_T4='C02') med4_recept=1.
IF  (atc4_T4='C02' and med4_dosis_T4='') med4_ppp=0.02.
IF  (atc5_T4='C02') med5_recept=1.
IF  (atc5_T4='C02' and med5_dosis_T4='') med5_ppp=0.02.

*** ATC C03 - plaspil.
IF  (atc3_T4='C03') med3_recept=1.
IF  (atc3_T4='C03' and med3_dosis_T4='') med3_ppp=0.02.
IF  (atc5_T4='C03') med5_recept=1.
IF  (atc5_T4='C03' and med5_dosis_T4='') med5_ppp=0.02.

*** ATC C07 - betablokkers.
IF  (atc1_T4='C07') med1_recept=1.
IF  (atc1_T4='C07' and med1_dosis_T4='') med1_ppp=0.02.
IF  (atc2_T4='C07') med2_recept=1.
IF  (atc2_T4='C07' and med2_dosis_T4='') med2_ppp=0.02.

*** ATC C10 cholesterolverlagers
goedkoopste=simvastatine in 10,20 of 40 mg, allen 2 cent.
*5 mg is rosuvastatine: 0.70.
IF  (atc1_T4='C10') med1_recept=1.
IF  (atc1_T4='C10' and med1_dosis_T4='') med1_ppp=0.02.
IF  (atc2_T4='C10') med2_recept=1.
IF  (atc2_T4='C10' and med2_dosis_T4='') med2_ppp=0.02.
IF  (atc3_T4='C10') med3_recept=1.
IF  (atc3_T4='C10' and med3_dosis_T4='') med3_ppp=0.02.
IF  (atc3_T4='C10' and med3_dosis_T4='50') med3_ppp=0.02.
IF  (atc4_T4='C10') med4_recept=1.
IF  (atc4_T4='C10' and med4_dosis_T4='5') med4_ppp=0.70.
IF  (atc4_T4='C10' and med4_dosis_T4='') med4_ppp=0.02.
IF  (atc5_T4='C10') med5_recept=1.
IF  (atc5_T4='C10' and med5_dosis_T4='') med5_ppp=0.02.

** hart.
IF  (Med6_T4='hart') med6_recept=1.
IF  (Med6_T4='hart') med6_ppp=0.02.

*** ATC H03 - schildklier. 
*Is meestal levothyroxine, goedkoopste 0.02.
IF  (atc1_T4='H03') med1_recept=1.
IF  (atc1_T4='H03' and med1_dosis_T4='') med1_ppp=0.02.
IF  (atc2_T4='H03') med2_recept=1.
IF  (atc2_T4='H03' and med2_dosis_T4='') med2_ppp=0.02.

**ATC J01 - antibiotica zonder specificatie.
IF  (atc1_T4='J01') med1_recept=1.
IF  (atc1_T4='J01' and med1_dosis_T4='') med1_ppp=0.06.
IF  (atc2_T4='J01') med2_recept=1.
IF  (atc2_T4='J01' and med2_dosis_T4='') med2_ppp=0.06.
IF  (atc3_T4='J01') med3_recept=1.
IF  (atc3_T4='J01' and med3_dosis_T4='') med3_ppp=0.06.
IF  (atc4_T4='J01') med4_recept=1.
IF  (atc4_T4='J01' and med4_dosis_T4='') med4_ppp=0.06.

** ATC M01 - ontstekingsremmers.
IF  (atc1_T4='M01') med1_recept=1.
IF  (atc1_T4='M01' and med1_dosis_T4='') med1_ppp=0.02.
IF  (atc2_T4='M01') med2_recept=1.
IF  (atc2_T4='M01' and med2_dosis_T4='') med2_ppp=0.02.
IF  (atc4_T4='M01') med4_recept=1.
IF  (atc4_T4='M01' and med4_dosis_T4='') med4_ppp=0.02.

*** ATC N02 - pijnstiller.
IF  (atc1_T4='N02') med1_recept=0.
IF  (atc1_T4='N02' and med1_dosis_T4='') med1_ppp=0.02.
IF  (atc2_T4='N02') med2_recept=0.
IF  (atc2_T4='N02' and med2_dosis_T4='') med2_ppp=0.02.

*** ATC N06 - antidepressiva.
IF  (atc1_T4='N06') med1_recept=1.
IF  (atc1_T4='N06' and med1_dosis_T4='') med1_ppp=0.02.
IF  (atc2_T4='N06') med2_recept=1.
IF  (atc2_T4='N06' and med2_dosis_T4='') med2_ppp=0.02.

*** ATC R03 - pufjes.
*Goedkoopste in ons bestand is salbutamol, 0.05 per dosis. Dit aanhouden.
IF  (atc1_T4='R03') med1_recept=1.
IF  (atc1_T4='R03' and med1_dosis_T4='') med1_ppp=0.05.
IF  (atc2_T4='R03') med2_recept=1.
IF  (atc2_T4='R03' and med2_dosis_T4='') med2_ppp=0.05.
IF  (atc3_T4='R03') med3_recept=1.
IF  (atc3_T4='R03' and med3_dosis_T4='') med3_ppp=0.05.
IF  (atc8_T4='R03') med8_recept=1.
IF  (atc8_T4='R03' and med8_dosis_T4='') med8_ppp=0.05.

**ATC V01 -allergiepil. Conservatieve schatting.
IF  (atc1_T4='V01') med1_recept=1.
IF  (atc1_T4='V01') med1_ppp=0.01.
IF  (atc2_T4='V01') med2_recept=1.
IF  (atc2_T4='V01')  med2_ppp=0.01.
IF  (atc4_T4='V01') med4_recept=1.
IF  (atc4_T4='V01') med4_ppp=0.01.
IF  (atc5_T4='V01') med5_recept=1.
IF  (atc5_T4='V01') med5_ppp=0.01.

** voor suikerziekte: onbekend medicijn--> 1 cent.
IF  (ID_code=3109) med1_recept=1.
IF  (ID_code=3109) med1_ppp=0.01.
EXECUTE.

**medisch geheim--> 1 cent.
IF  (med1_T4='Medisch geheim') med1_recept=1.
IF  (med1_T4='Medisch geheim') med1_ppp=0.01.
EXECUTE.

** sandoz: onbekend medicijn--> 1 cent.
IF  (med2_T4='sandoz') med2_recept=1.
IF  (med2_T4='sandoz') med2_ppp=0.01.
EXECUTE.

** accord 40m: onbekend medicijn--> 1 cent.
IF  (med3_T4='accord 40m') med3_recept=1.
IF  (med3_T4='accord 40m') med3_ppp=0.01.
EXECUTE.

VARIABLE LABELS med1_ppp 'med1 prijs per pil' / med1_recept 'med1 op recept'.
VARIABLE LABELS med2_ppp 'med2 prijs per pil' / med2_recept 'med2 op recept'.
VARIABLE LABELS med3_ppp 'med3 prijs per pil' / med3_recept 'med3 op recept'.
VARIABLE LABELS med4_ppp 'med4 prijs per pil' / med4_recept 'med4 op recept'.
VARIABLE LABELS med5_ppp 'med5 prijs per pil' / med5_recept 'med5 op recept'.
VARIABLE LABELS med6_ppp 'med6 prijs per pil' / med6_recept 'med6 op recept'.
VARIABLE LABELS med7_ppp 'med7 prijs per pil' / med7_recept 'med7 op recept'.
VARIABLE LABELS med8_ppp 'med8 prijs per pil' / med8_recept 'med8 op recept'.
VARIABLE LABELS med9_ppp 'med9 prijs per pil' / med9_recept 'med9 op recept'.
EXECUTE.
FORMATS med1_recept med2_recept med3_recept med4_recept med5_recept med6_recept  med7_recept  med8_recept med9_recept (F1.0). 
MISSING VALUES med1_ppp med2_ppp med3_ppp med4_ppp med5_ppp med6_ppp med7_ppp med8_ppp med9_ppp (999).



******************************************************************************************************************************************************************************************.
************ Totaal aantal pillen uitrekenen: aantal per dag x aantal dagen ***************************************************************************************************************.
******************************************************************************************************************************************************************************************.

** Aantal per dag en/of aantal dagen missing.Voor chronische med 1d1 90 dagen, voor pijnstillers en slaapmedicatie 1d1 1 dag.
** voor antibiotica minstens 5 dagen 1d.
** indien keerperdag = 0: individueel bekijken, indien aannemelijk wordt het 1.
DO IF (atc1_T4='L04AX03').
RECODE med1_aantdagen_T4 (SYSMIS=180).
RECODE med1_keerperdag_T4 (SYSMIS=1).
END IF.
DO IF (atc1_T4='L02BA01').
RECODE med1_aantdagen_T4 (SYSMS=180).
END IF.
DO IF (atc1_T4='A10BA02').
RECODE med1_aantdagen_T4 (SYSMIS=180).
END IF.

DO IF (atc2_T4='M05BA04').
RECODE med2_keerperdag_T4 (SYSMIS=1).
END IF.
* prednisolon, slikt dit altijd maar niet dagelijks, gem om de dag--> hier 90 dagen.
DO IF (atc2_T4='H02AB06').
RECODE med2_aantdagen_T4 (SYSMIS=90).
RECODE med2_keerperdag_T4 (SYSMIS=1).
END IF.
DO IF (atc2_T4='C09AA03').
RECODE med2_aantdagen_T4 (SYSMIS=180).
RECODE med2_keerperdag_T4 (SYSMIS=1).
END IF.
DO IF (atc2_T4='C09CA04').
RECODE med2_aantdagen_T4 (SYSMIS=180).
END IF.

DO IF (atc3_T4='N02CC01').
RECODE med3_aantdagen_T4 (0=1).
END IF.
DO IF (atc3_T4='G04CA02').
RECODE med3_aantdagen_T4 (SYSMIS=180).
RECODE med3_keerperdag_T4 (SYSMIS=1).
END IF.

DO IF (atc4_T4='C03AA03').
RECODE med4_aantdagen_T4 (SYSMIS=180).
END IF.
DO IF (atc4_T4='C10AA03').
RECODE med4_aantdagen_T4 (SYSMIS=180).
END IF.

DO IF (atc5_T4='C07AB02').
RECODE med5_aantdagen_T4 (SYSMIS=180).
END IF.
DO IF (atc5_T4='C10AX09').
RECODE med5_aantdagen_T4 (SYSMIS=180).
END IF.

DO IF (atc6_T4='C10AA05').
RECODE med6_aantdagen_T4 (SYSMIS=180).
END IF.

DO IF (atc7_T4='C10AX09').
RECODE med7_aantdagen_T4 (SYSMIS=190).
END IF.
DO IF (atc7_T4='B01AA04').
RECODE med7_aantdagen_T4 (SYSMIS=190).
END IF.

DO IF (atc8_T4='B01AC06').
RECODE med8_aantdagen_T4 (SYSMIS=180).
END IF.

DO IF (atc9_T4='B03BB01').
RECODE med9_aantdagen_T4 (SYSMIS=180).
RECODE med9_keerperdag_T4 (SYSMIS=1).
END IF.
EXECUTE.

COMPUTE med1_tot_aant_T4=med1_keerperdag_T4 * med1_aantdagen_T4.
COMPUTE med2_tot_aant_T4=med2_keerperdag_T4 * med2_aantdagen_T4.
COMPUTE med3_tot_aant_T4=med3_keerperdag_T4 * med3_aantdagen_T4.
COMPUTE med4_tot_aant_T4=med4_keerperdag_T4 * med4_aantdagen_T4.
COMPUTE med5_tot_aant_T4=med5_keerperdag_T4 * med5_aantdagen_T4.
COMPUTE med6_tot_aant_T4=med6_keerperdag_T4 * med6_aantdagen_T4.
COMPUTE med7_tot_aant_T4=med7_keerperdag_T4 * med7_aantdagen_T4.
COMPUTE med8_tot_aant_T4=med8_keerperdag_T4 * med8_aantdagen_T4.
COMPUTE med9_tot_aant_T4=med9_keerperdag_T4 * med9_aantdagen_T4.
COMPUTE med10_tot_aant_T4=med10_keerperdag_T4 * med10_aantdagen_T4.
EXECUTE.

FORMATS  med1_tot_aant_T4  med2_tot_aant_T4  med3_tot_aant_T4   
med4_tot_aant_T4 med5_tot_aant_T4 med6_tot_aant_T4 med7_tot_aant_T4 med8_tot_aant_T4 med9_tot_aant_T4 med10_tot_aant_T4 (F4.0).
VARIABLE LEVEL med1_tot_aant_T4  med2_tot_aant_T4  med3_tot_aant_T4   
med4_tot_aant_T4 med5_tot_aant_T4 med6_tot_aant_T4 med7_tot_aant_T4 med8_tot_aant_T4 med9_tot_aant_T4 med10_tot_aant_T4  (SCALE).
VARIABLE WIDTH med1_tot_aant_T4  med2_tot_aant_T4  med3_tot_aant_T4   
med4_tot_aant_T4 med5_tot_aant_T4 med6_tot_aant_T4 med7_tot_aant_T4 med8_tot_aant_T4 med9_tot_aant_T4 med10_tot_aant_T4 (6).

******************************************************************************************************************************************************************************************.
** Totale kosten per medicijn.
******************************************************************************************************************************************************************************************.


*Med 1
* niet op recept.
DO IF med1_recept=0.
COMPUTE med1_tot_kosten_T4 = med1_tot_aant_T4 * med1_ppp.
END IF.
* chronisch op  recept.
DO IF med1_recept=1.
COMPUTE med1_tot_kosten_T4 = (med1_tot_aant_T4 * med1_ppp)+7.
END IF.
* niet chronisch op recept (antibiotica).
DO IF (CHAR.INDEX(atc1_T4,'J01')>0).
COMPUTE med1_tot_kosten_T4 = (med1_tot_aant_T4 * med1_ppp)+14.
END IF.
EXECUTE.

*Med 2
* niet op recept.
DO IF med2_recept=0.
COMPUTE med2_tot_kosten_T4 = med2_tot_aant_T4 * med2_ppp.
END IF.
* chronisch op  recept.
DO IF med2_recept=1.
COMPUTE med2_tot_kosten_T4 = (med2_tot_aant_T4 * med2_ppp)+7.
END IF.
* niet chronisch op recept (antibiotica).
DO IF (CHAR.INDEX(atc2_T4,'J01')>0).
COMPUTE med2_tot_kosten_T4 = (med2_tot_aant_T4 * med2_ppp)+14.
END IF.
EXECUTE.

*Med 3
* niet op recept.
DO IF med3_recept=0.
COMPUTE med3_tot_kosten_T4 = med3_tot_aant_T4 * med3_ppp.
END IF.
* chronisch op  recept.
DO IF med3_recept=1.
COMPUTE med3_tot_kosten_T4 = (med3_tot_aant_T4 * med3_ppp)+7.
END IF.
* niet chronisch op recept (antibiotica).
DO IF (CHAR.INDEX(atc3_T4,'J01')>0).
COMPUTE med3_tot_kosten_T4 = (med3_tot_aant_T4 * med3_ppp)+14.
END IF.
EXECUTE.

*Med 4
* niet op recept.
DO IF med4_recept=0.
COMPUTE med4_tot_kosten_T4 = med4_tot_aant_T4 * med4_ppp.
END IF.
* chronisch op  recept.
DO IF med4_recept=1.
COMPUTE med4_tot_kosten_T4 = (med4_tot_aant_T4 * med4_ppp)+7.
END IF.
* niet chronisch op recept (antibiotica).
DO IF (CHAR.INDEX(atc4_T4,'J01')>0).
COMPUTE med4_tot_kosten_T4 = (med4_tot_aant_T4 * med4_ppp)+14.
END IF.
EXECUTE.

*Med 5
* niet op recept.
DO IF med5_recept=0.
COMPUTE med5_tot_kosten_T4 = med5_tot_aant_T4 * med5_ppp.
END IF.
* chronisch op  recept.
DO IF med5_recept=1.
COMPUTE med5_tot_kosten_T4 = (med5_tot_aant_T4 * med5_ppp)+7.
END IF.
* niet chronisch op recept (antibiotica).
DO IF (CHAR.INDEX(atc5_T4,'J01')>0).
COMPUTE med5_tot_kosten_T4 = (med5_tot_aant_T4 * med5_ppp)+14.
END IF.
EXECUTE.

*Med 6
* niet op recept.
DO IF med6_recept=0.
COMPUTE med6_tot_kosten_T4 = med6_tot_aant_T4 * med6_ppp.
END IF.
* chronisch op  recept.
DO IF med6_recept=1.
COMPUTE med6_tot_kosten_T4 = (med6_tot_aant_T4 * med6_ppp)+7.
END IF.
* niet chronisch op recept (antibiotica).
DO IF (CHAR.INDEX(atc6_T4,'J01')>0).
COMPUTE med6_tot_kosten_T4 = (med6_tot_aant_T4 * med6_ppp)+14.
END IF.
EXECUTE.

*Med 7
* niet op recept.
DO IF med7_recept=0.
COMPUTE med7_tot_kosten_T4 = med7_tot_aant_T4 * med7_ppp.
END IF.
* chronisch op  recept.
DO IF med7_recept=1.
COMPUTE med7_tot_kosten_T4 = (med7_tot_aant_T4 * med7_ppp)+7.
END IF.
* niet chronisch op recept (antibiotica).
DO IF (CHAR.INDEX(atc7_T4,'J01')>0).
COMPUTE med7_tot_kosten_T4 = (med7_tot_aant_T4 * med7_ppp)+14.
END IF.
EXECUTE.

*Med 8
* niet op recept.
DO IF med8_recept=0.
COMPUTE med8_tot_kosten_T4 = med8_tot_aant_T4 * med8_ppp.
END IF.
* chronisch op  recept.
DO IF med8_recept=1.
COMPUTE med8_tot_kosten_T4 = (med8_tot_aant_T4 * med8_ppp)+7.
END IF.
* niet chronisch op recept (antibiotica).
DO IF (CHAR.INDEX(atc8_T4,'J01')>0).
COMPUTE med8_tot_kosten_T4 = (med8_tot_aant_T4 * med8_ppp)+14.
END IF.
EXECUTE.

*Med 9
* niet op recept.
DO IF med9_recept=0.
COMPUTE med9_tot_kosten_T4 = med9_tot_aant_T4 * med9_ppp.
END IF.
* chronisch op  recept.
DO IF med9_recept=1.
COMPUTE med9_tot_kosten_T4 = (med9_tot_aant_T4 * med9_ppp)+7.
END IF.
* niet chronisch op recept (antibiotica).
DO IF (CHAR.INDEX(atc9_T4,'J01')>0).
COMPUTE med9_tot_kosten_T4 = (med9_tot_aant_T4 * med9_ppp)+14.
END IF.
EXECUTE.

*Med 10
* niet op recept.
DO IF med10_recept=0.
COMPUTE med10_tot_kosten_T4 = med10_tot_aant_T4 * med10_ppp.
END IF.
* chronisch op  recept.
DO IF med10_recept=1.
COMPUTE med10_tot_kosten_T4 = (med10_tot_aant_T4 * med10_ppp)+7.
END IF.
* niet chronisch op recept (antibiotica).
DO IF (CHAR.INDEX(atc10_T4,'J01')>0).
COMPUTE med10_tot_kosten_T4 = (med10_tot_aant_T4 * med10_ppp)+14.
END IF.
EXECUTE.

** stoppen met roken medicatie wordt appart berekend: Bij totale med prijs=0.
** Champix N07BA03 en Zyban N06AX12.

DO IF (atc1_T4='N07BA03' or atc1_T4='N06AX12').
COMPUTE med1_tot_kosten_T4=0.
COMPUTE med1_roken_kosten_T4= (med1_tot_aant_T4 * med1_ppp)+14.
END IF.
DO IF (atc2_T4='N07BA03' or atc2_T4='N06AX12').
COMPUTE med2_tot_kosten_T4 =0.
COMPUTE med2_roken_kosten_T4= (med2_tot_aant_T4 * med2_ppp)+14.
END IF.
DO IF (atc3_T4='N07BA03' or atc3_T4='N06AX12').
COMPUTE med3_tot_kosten_T4 =0.
COMPUTE med3_roken_kosten_T4= (med3_tot_aant_T4 * med3_ppp)+14.
END IF.
DO IF (atc4_T4='N07BA03' or atc4_T4='N06AX12').
COMPUTE med4_tot_kosten_T4 = 0.
COMPUTE med4_roken_kosten_T4= (med4_tot_aant_T4 * med4_ppp)+14.
END IF.
DO IF (atc5_T4='N07BA03' or atc5_T4='N06AX12').
COMPUTE med5_tot_kosten_T4 = 0.
COMPUTE med5_roken_kosten_T4= (med5_tot_aant_T4 * med5_ppp)+14.
END IF.
DO IF (atc6_T4='N07BA03' or atc6_T4='N06AX12').
COMPUTE med6_tot_kosten_T4 = 0.
COMPUTE med6_roken_kosten_T4= (med6_tot_aant_T4 * med6_ppp)+14.
END IF.
DO IF (atc7_T4='N07BA03' or atc7_T4='N06AX12').
COMPUTE med7_tot_kosten_T4 = 0.
COMPUTE med7_roken_kosten_T4= (med7_tot_aant_T4 * med7_ppp)+14.
END IF.
DO IF (atc8_T4='N07BA03' or atc8_T4='N06AX12').
COMPUTE med8_tot_kosten_T4 = 0.
COMPUTE med8_roken_kosten_T4= (med8_tot_aant_T4 * med8_ppp)+14.
END IF.
DO IF (atc9_T4='N07BA03' or atc9_T4='N06AX12').
COMPUTE med9_tot_kosten_T4 = 0.
COMPUTE med9_roken_kosten_T4= (med9_tot_aant_T4 * med9_ppp)+14.
END IF.
DO IF (atc10_T4='N07BA03' or atc10_T4='N06AX12').
COMPUTE med10_tot_kosten_T4 = 0.
COMPUTE med10_roken_kosten_T4= (med10_tot_aant_T4 * med10_ppp)+14.
END IF.
EXECUTE.


*** Invullen totale kosten voor medicijnen waar dit niet berekend kon worden. Bij totaal zit ook al dan niet afleverkosten.
* kosten uit lijstje worddocument x 2 omdat dit 6 maanden zijn ipv 3.

DO IF (atc1_T4='L04AB02').
RECODE med1_tot_kosten_T4 (SYSMIS=545.39).
RECODE med1_recept (SYSMIS=1).
END IF.
DO IF (atc1_T4='A11CC').
RECODE med1_tot_kosten_T4 (SYSMIS=5.00).
RECODE med1_recept (SYSMIS=0).
END IF.
DO IF (med1_T4='Hormonen').
RECODE med1_tot_kosten_T4 (SYSMIS=15.20).
RECODE med1_recept (SYSMIS=1).
END IF.
DO IF (atc1_T4='D06AX01').
RECODE med1_tot_kosten_T4 (SYSMIS=17.43).
RECODE med1_recept (SYSMIS=1).
END IF.
DO IF (med1_T4='CBD olie').
RECODE med1_tot_kosten_T4 (SYSMIS=19.98).
RECODE med1_recept (SYSMIS=0).
END IF.
DO IF (med1_T4='Vitamine B2').
RECODE med1_tot_kosten_T4 (SYSMIS=9.98).
RECODE med1_recept (SYSMIS=0).
END IF.
EXECUTE.
DO IF (med1_T4='Foliumzuur ivm zwangerschap. Momenteel 26 weken zwanger').
RECODE med1_tot_kosten_T4 (SYSMIS=4.78).
RECODE med1_recept (SYSMIS=0).
END IF.
* 4704	Med 1 insuline, verder geen gegevens zelfde kosten als op T0 aanhouden .
DO IF (med1_T4='INSULINE').
RECODE med1_tot_kosten_T4 (SYSMIS=100.40).
RECODE med1_recept (SYSMIS=0).
END IF.


DO IF (atc2_T4='A10BJ02').
RECODE med2_tot_kosten_T4 (SYSMIS=407.90).
RECODE med2_recept (SYSMIS=1).
END IF.
DO IF (atc2_T4='S01BA04').
RECODE med2_tot_kosten_T4 (SYSMIS=15.64).
RECODE med2_recept (SYSMIS=1).
END IF.
DO IF (med2_T4='Otrivin').
RECODE med2_tot_kosten_T4 (SYSMIS=10.18).
RECODE med2_recept (SYSMIS=0).
END IF.
DO IF (med2_T4='neusspray').
RECODE med2_tot_kosten_T4 (SYSMIS=5.38).
RECODE med2_recept (SYSMIS=0).
END IF.
DO IF (med2_T4='Neusdruppels').
RECODE med2_tot_kosten_T4 (SYSMIS=5.38).
RECODE med2_recept (SYSMIS=0).
END IF.
DO IF (atc2_T4='D06AX01').
RECODE med2_tot_kosten_T4 (SYSMIS=17.42).
RECODE med2_recept (SYSMIS=1).
END IF.
DO IF (med2_T4='hoestsiroop').
RECODE med2_tot_kosten_T4 (SYSMIS=6.78).
RECODE med2_recept (SYSMIS=0).
END IF.
EXECUTE.

DO IF (med3_T4='oordruppels').
RECODE med3_tot_kosten_T4 (SYSMIS=11.00).
RECODE med3_recept (SYSMIS=0).
END IF.
DO IF (med3_T4='Hoestdrank').
RECODE med3_tot_kosten_T4 (SYSMIS=6.78).
RECODE med3_recept (SYSMIS=0).
END IF.
DO IF (med3_T4='dakarin' and med3_vorm_T4='gel').
RECODE med3_tot_kosten_T4 (SYSMIS=20.70).
RECODE med3_recept (SYSMIS=1).
END IF.
DO IF (med3_T4='accord 40m').
RECODE med3_tot_kosten_T4 (SYSMIS=15.90).
RECODE med3_recept (SYSMIS=1).
END IF.
DO IF (med3_T4='zoutoplossingneusspray').
RECODE med3_tot_kosten_T4 (SYSMIS=5.38).
RECODE med3_recept (SYSMIS=0).
END IF.
DO IF (med3_T4='Neusdruppels').
RECODE med3_tot_kosten_T4 (SYSMIS=5.38).
RECODE med3_recept (SYSMIS=0).
END IF.
DO IF (med3_T4='broncostop').
RECODE med3_tot_kosten_T4 (SYSMIS=16.18).
RECODE med3_recept (SYSMIS=0).
END IF.
DO IF (med3_T4='Renies').
RECODE med3_tot_kosten_T4 (SYSMIS=3.29).
RECODE med3_recept (SYSMIS=0).
END IF.
DO IF (med3_T4='PLEDIGRY').
RECODE med3_tot_kosten_T4 (SYSMIS=3783.61).
RECODE med3_recept (SYSMIS=1).
END IF.
DO IF (med3_T4='Hypromellose').
RECODE med3_tot_kosten_T4 (SYSMIS=18.94).
RECODE med3_recept (SYSMIS=1).
END IF.
EXECUTE.

DO IF (atc4_T4='D07XC01').
RECODE med4_tot_kosten_T4 (SYSMIS=18.12).
RECODE med4_recept (SYSMIS=1).
END IF.
DO IF (med5_T4='qlenmark').
RECODE med5_tot_kosten_T4 (SYSMIS=15.80).
RECODE med5_recept (SYSMIS=1).
END IF.
DO IF (med5_T4='mulivitamine').
RECODE med5_tot_kosten_T4 (SYSMIS=7.00).
RECODE med5_recept (SYSMIS=0).
END IF.

DO IF (med6_T4='neusspray').
RECODE med6_tot_kosten_T4 (SYSMIS=5.38).
RECODE med6_recept (SYSMIS=0).
END IF.
DO IF (med6_T4='VITAMINE D').
RECODE med6_tot_kosten_T4 (SYSMIS=5.00).
RECODE med6_recept (SYSMIS=0).
END IF.

DO IF (med7_T4='Voltaren').
RECODE med7_tot_kosten_T4 (SYSMIS=21.98).
RECODE med7_recept (SYSMIS=0).
END IF.
DO IF (med7_T4='Vitamine B-conmplex').
RECODE med7_tot_kosten_T4 (SYSMIS=9.98).
RECODE med7_recept (SYSMIS=1).
END IF.
DO IF (med7_T4='hoestdrank').
RECODE med7_tot_kosten_T4 (SYSMIS=6.78).
RECODE med7_recept (SYSMIS=0).
END IF.
DO IF (med7_T4='Fenugreek').
RECODE med7_tot_kosten_T4 (SYSMIS=13.80).
RECODE med7_recept (SYSMIS=0).
END IF.

DO IF (med10_T4='vitamine D3').
RECODE med10_tot_kosten_T4 (SYSMIS=18.10).
RECODE med10_recept (SYSMIS=0).
END IF.


*******************************************************************************************************************
** totaalkosten medicatie**
*******************************************************************************************************************.

COMPUTE kosten_med_tot_T4=SUM(med1_tot_kosten_T4,med2_tot_kosten_T4,med3_tot_kosten_T4, med4_tot_kosten_T4,
  med5_tot_kosten_T4,med6_tot_kosten_T4,med7_tot_kosten_T4,med8_tot_kosten_T4, med9_tot_kosten_T4,med10_tot_kosten_T4).
EXECUTE.

COMPUTE kosten_med_roken_T4=SUM(med1_roken_kosten_T4,  med2_roken_kosten_T4, med3_roken_kosten_T4, med4_roken_kosten_T4,
 med5_roken_kosten_T4,  med6_roken_kosten_T4,  med7_roken_kosten_T4,  med8_roken_kosten_T4,  med9_roken_kosten_T4,  med10_roken_kosten_T4).
EXECUTE.


*Indien Medicatie=missing.
DO IF MISSING(medicatie_T4)=1.
RECODE kosten_med_tot_T4 kosten_med_roken_T4 (SYSMIS=99999).
END IF.
EXECUTE.
* Indien alleen andere mediciatie en geen stoppen met roken medicatie.
DO IF kosten_med_tot_T4>0.
RECODE kosten_med_roken_T4 (SYSMIS=0).
END IF.
EXECUTE.
*Indien Medicatie=ja, maar geen medicijnen ingevuld: kosten = missing.
DO IF medicatie_T4=2.
RECODE kosten_med_tot_T4 kosten_med_roken_T4 (SYSMIS=99999).
END IF.
EXECUTE.
* Indien geen medicatie: kosten=0.
DO IF medicatie_T4=1.
RECODE kosten_med_tot_T4 kosten_med_roken_T4 (SYSMIS=0).
END IF.
EXECUTE.
* Indien de verkorte papieren vragenlijst is ingevuld, is er alleen naar stoppen met roken medicatie gevraagd--> gewone medicatie is missing.
DO IF papier_T4=2.
RECODE kosten_med_tot_T4 (0=99999).
END IF.
EXECUTE.


MISSING VALUES kosten_med_tot_T4  kosten_med_roken_T4 (99999).
VARIABLE WIDTH kosten_med_tot_T4  kosten_med_roken_T4 (8).

DELETE VARIABLES med1_tot_kosten_T4 med2_tot_kosten_T4 med3_tot_kosten_T4 med4_tot_kosten_T4
 med5_tot_kosten_T4 med6_tot_kosten_T4 med7_tot_kosten_T4 med8_tot_kosten_T4 med9_tot_kosten_T4 med10_tot_kosten_T4
 med1_roken_kosten_T4  med2_roken_kosten_T4 med3_roken_kosten_T4 med4_roken_kosten_T4
 med5_roken_kosten_T4 med6_roken_kosten_T4 med7_roken_kosten_T4 med8_roken_kosten_T4 med9_roken_kosten_T4  med10_roken_kosten_T4.


