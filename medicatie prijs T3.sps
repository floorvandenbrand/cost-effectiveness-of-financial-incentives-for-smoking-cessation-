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
IF  (atc6_T3='V03AE01') med6_recept=0.
IF  (atc6_T3='V03AE01' and med6_dosis_T3='15') med6_ppp=0.67.
**ATC V03AB33.
IF  (atc2_T3='V03AB33') med2_recept=0.
IF  (atc2_T3='V03AB33' and med2_dosis_T3='1 injectie') med2_ppp=0.70.
**ATC V01AA02.
IF  (atc1_T3='V01AA02') med1_recept=1.
IF  (atc1_T3='V01AA02' and med1_dosis_T3='300')  med1_ppp=3.32.
**ATC S01BA04.
IF  (atc3_T3='S01BA04') med3_recept=1.
**ATC R06AX27 - Aereus.
IF  (atc2_T3='R06AX27') med2_recept=1.
IF  (atc2_T3='R06AX27' and med2_dosis_T3='') med2_ppp=0.03.
IF  (atc2_T3='R06AX27' and med2_dosis_T3='5') med2_ppp=0.03.
IF  (atc3_T3='R06AX27') med3_recept=1.
IF  (atc3_T3='R06AX27' and med3_dosis_T3='') med3_ppp=0.03.
IF  (atc4_T3='R06AX27') med4_recept=1.
IF  (atc4_T3='R06AX27' and med4_dosis_T3='') med4_ppp=0.03.
IF  (atc6_T3='R06AX27') med6_recept=1.
IF  (atc6_T3='R06AX27' and med6_dosis_T3='5') med6_ppp=0.03.
IF  (atc6_T3='R06AX27' and med6_dosis_T3='') med6_ppp=0.03.
IF  (atc7_T3='R06AX27') med7_recept=1.
IF  (atc7_T3='R06AX27' and med7_dosis_T3='') med7_ppp=0.03.
**ATC R06AX25 - Mizolastine.
IF  (atc5_T3='R06AX25') med5_recept=1.
IF  (atc5_T3='R06AX25' and med5_dosis_T3='10') med5_ppp=0.29.
**ATC R06AX13 - .
IF  (atc1_T3='R06AX13') med1_recept=1.
IF  (atc1_T3='R06AX13' and med1_dosis_T3='10') med1_ppp=0.20.
**ATC R06AE07.
IF  (atc1_T3='R06AE07') med1_recept=0.
IF  (atc1_T3='R06AE07' and med1_dosis_T3='10') med1_ppp=0.18.
IF  (atc2_T3='R06AE07') med2_recept=0.
IF  (atc2_T3='R06AE07' and med2_dosis_T3='10') med2_ppp=0.18.
IF  (atc3_T3='R06AE07') med3_recept=0.
IF  (atc3_T3='R06AE07' and med3_dosis_T3='10') med3_ppp=0.18.
IF  (atc5_T3='R06AE07') med5_recept=0.
IF  (atc5_T3='R06AE07' and med5_dosis_T3='2x10') med5_ppp=0.36.
**ATC R05DA04 codeine.
IF  (atc2_T3='R05DA04') med2_recept=1.
IF  (atc2_T3='R05DA04' and med2_dosis_T3='') med2_ppp=0.21.
IF  (atc3_T3='R05DA04') med3_recept=1.
IF  (atc3_T3='R05DA04' and med3_dosis_T3='10') med3_ppp=0.21.
**ATC R05CB01.
IF  (atc1_T3='R05CB01') med1_recept=1.
IF  (atc1_T3='R05CB01' and med1_dosis_T3='600') med1_ppp=0.34.
IF  (atc1_T3='R05CB01' and med1_dosis_T3='') med1_ppp=0.25.
IF  (atc2_T3='R05CB01') med2_recept=1.
IF  (atc2_T3='R05CB01' and med2_dosis_T3='600') med2_ppp=0.34.
**ATC R03DC03 .
IF  (atc4_T3='R03DC03') med4_recept=1.
IF  (atc4_T3='R03DC03' and med4_dosis_T3='10') med4_ppp=0.04.
IF  (atc7_T3='R03DC03') med7_recept=1.
IF  (atc7_T3='R03DC03' and med7_dosis_T3='10') med7_ppp=0.04.
**ATC R03CC02 Salbutamol/ Ventolin.
IF  (atc1_T3='R03CC02') med1_recept=1.
IF  (atc1_T3='R03CC02' and med1_dosis_T3='200') med1_ppp=999.
IF  (atc1_T3='R03CC02' and med1_dosis_T3='250') med1_ppp=999.
IF  (atc1_T3='R03CC02' and med1_dosis_T3='') med1_ppp=999.
IF  (atc2_T3='R03CC02') med2_recept=1.
IF  (atc2_T3='R03CC02' and med2_dosis_T3='200') med2_ppp=999.
IF  (atc2_T3='R03CC02' and med2_dosis_T3='250') med2_ppp=999.
IF  (atc2_T3='R03CC02' and med2_dosis_T3='100') med2_ppp=999.
IF  (atc2_T3='R03CC02' and med2_dosis_T3='5 (vloeistof)') med2_ppp=999.
IF  (atc2_T3='R03CC02' and med2_dosis_T3='') med2_ppp=999.
IF  (atc3_T3='R03CC02') med3_recept=1.
IF  (atc3_T3='R03CC02' and med3_dosis_T3='') med3_ppp=999.
IF  (atc4_T3='R03CC02') med4_recept=1.
IF  (atc4_T3='R03CC02' and med4_dosis_T3='200') med4_ppp=999.
IF  (atc5_T3='R03CC02') med5_recept=1.
IF  (atc5_T3='R03CC02' and med5_dosis_T3='') med5_ppp=999.
**ATC R03BB04 -Spiriva.
IF  (atc1_T3='R03BB04') med1_recept=1.
IF  (atc1_T3='R03BB04' and med1_dosis_T3='18') med1_ppp=1.34.
IF  (atc2_T3='R03BB04') med2_recept=1.
IF  (atc2_T3='R03BB04' and med2_dosis_T3='2x2,5 vloeistof') med2_ppp=1.14.
IF  (atc2_T3='R03BB04' and med2_dosis_T3='18') med2_ppp=1.34.
IF  (atc3_T3='R03BB04') med3_recept=1.
IF  (atc3_T3='R03BB04' and med3_dosis_T3='18') med3_ppp=1.34.
IF  (atc4_T3='R03BB04') med4_recept=1.
IF  (atc4_T3='R03BB04' and med4_dosis_T3='18') med4_ppp=1.34.
**ATC R03BB01.
IF  (atc2_T3='R03BB01') med2_recept=1.
IF  (atc2_T3='R03BB01' and med2_dosis_T3=' ') med2_ppp=0.03.
IF  (atc7_T3='R03BB01') med7_recept=1.
IF  (atc7_T3='R03BB01' and med7_dosis_T3=' ') med7_ppp=0.03.
**ATC R03BA05 flixotide.
IF  (atc2_T3='R03BA05') med2_recept=1.
IF  (atc2_T3='R03BA05' and med2_dosis_T3=' ') med2_ppp=0.07.
IF  (atc3_T3='R03BA05') med3_recept=1.
IF  (atc3_T3='R03BA05' and med3_dosis_T3=' ') med3_ppp=0.07.
IF  (atc3_T3='R03BA05' and med3_dosis_T3='250') med3_ppp=0.27.
IF  (atc5_T3='R03BA05') med5_recept=1.
IF  (atc5_T3='R03BA05' and med5_dosis_T3='100') med5_ppp=0.15.
**ATC R03BA02- pulmicort.
IF  (atc1_T3='R03BA02') med1_recept=1.
IF  (atc1_T3='R03BA02' and med1_dosis_T3='200') med1_ppp=0.12.
IF  (atc3_T3='R03BA02') med3_recept=1.
IF  (atc3_T3='R03BA02' and med3_dosis_T3='') med3_ppp=0.07.
IF  (atc5_T3='R03BA02') med5_recept=1.
IF  (atc5_T3='R03BA02' and med5_dosis_T3='') med5_ppp=0.07.
**ATC R03BA01-  beclomethason.
IF  (atc1_T3='R03BA01') med1_recept=1.
IF  (atc1_T3='R03BA01' and med1_dosis_T3='50') med1_ppp=0.03.
IF  (atc2_T3='R03BA01') med2_recept=1.
IF  (atc2_T3='R03BA01' and med2_dosis_T3=' ') med2_ppp=0.03.
IF  (atc2_T3='R03BA01' and med2_dosis_T3='50') med2_ppp=0.03.
IF  (atc3_T3='R03BA01') med3_recept=1.
IF  (atc3_T3='R03BA01' and med3_dosis_T3=' ') med3_ppp=0.03.
IF  (atc3_T3='R03BA01' and med3_dosis_T3='50') med3_ppp=0.03.
IF  (atc8_T3='R03BA01') med8_recept=1.
IF  (atc8_T3='R03BA01' and med8_dosis_T3='200 (poeder)') med8_ppp=0.10.
IF  (atc1_T3='R03BA01' and med1_dosis_T3='100') med1_ppp=0.07.
**ATC R03AK10.
IF  (atc1_T3='R03AK10') med1_recept=1.
IF  (atc1_T3='R03AK10' and med1_dosis_T3='92/22') med1_ppp=1.07.
IF  (atc2_T3='R03AK10') med2_recept=1.
IF  (atc2_T3='R03AK10' and med2_dosis_T3='92/22') med2_ppp=1.07.
IF  (atc7_T3='R03AK10') med7_recept=1.
IF  (atc7_T3='R03AK10' and med7_dosis_T3='') med7_ppp=1.07.
**ATC R03AK08- foster.
IF  (atc1_T3='R03AK08') med1_recept=1.
IF  (atc1_T3='R03AK08' and med1_dosis_T3='') med1_ppp=0.33.
IF  (atc6_T3='R03AK08') med6_recept=1.
IF  (atc6_T3='R03AK08' and med6_dosis_T3='') med6_ppp=0.33.
IF  (atc8_T3='R03AK08') med8_recept=1.
IF  (atc8_T3='R03AK08' and med8_dosis_T3='') med8_ppp=0.33.
**ATC R03AK07 symbicort (poeder en inhalator is hetzelfde).
IF  (atc1_T3='R03AK07') med1_recept=1.
IF  (atc1_T3='R03AK07' and med1_dosis_T3='400/12') med1_ppp=0.65.
IF  (atc2_T3='R03AK07') med2_recept=1.
IF  (atc2_T3='R03AK07' and med2_dosis_T3='100/6') med2_ppp=0.34.
IF  (atc3_T3='R03AK07') med3_recept=1.
IF  (atc3_T3='R03AK07' and med3_dosis_T3='200/6') med3_ppp=0.33.
**ATC R03AK06 seretide.
IF  (atc1_T3='R03AK06') med1_recept=1.
IF  (atc1_T3='R03AK06' and med1_dosis_T3='50/500') med1_ppp=0.73.
IF  (atc1_T3='R03AK06' and med1_dosis_T3='50/?') med1_ppp=0.41.
IF  (atc1_T3='R03AK06' and med1_dosis_T3='25/250') med1_ppp=0.27.
IF  (atc2_T3='R03AK06') med2_recept=1.
IF  (atc2_T3='R03AK06' and med2_dosis_T3='') med2_ppp=0.27.
IF  (atc3_T3='R03AK06') med3_recept=1.
IF  (atc3_T3='R03AK06' and med3_dosis_T3='50/500') med3_ppp=0.73.
IF  (atc4_T3='R03AK06') med4_recept=1.
IF  (atc4_T3='R03AK06' and med4_dosis_T3='2x25/125') med4_ppp=0.36.
**ATC R03AC13 - formoterol.
IF  (atc1_T3='R03AC13') med1_recept=1.
IF  (atc1_T3='R03AC13' and med1_dosis_T3='12') med1_ppp=0.23.
IF  (atc2_T3='R03AC13') med2_recept=1.
IF  (atc2_T3='R03AC13' and med2_dosis_T3='12') med2_ppp=0.23.
IF  (atc3_T3='R03AC13') med3_recept=1.
IF  (atc3_T3='R03AC13' and med3_dosis_T3='') med3_ppp=0.23.
**ATC R03AC12- salmeterol.
IF  (atc5_T3='R03AC12') med5_recept=1.
IF  (atc5_T3='R03AC12' and med5_dosis_T3='25') med5_ppp=0.23.
**ATC R03AC03.
IF  (atc2_T3='R03AC03') med2_recept=1.
IF  (atc2_T3='R03AC03' and med2_dosis_T3='500') med2_ppp=0.07.
IF  (atc2_T3='R03AC03' and med2_dosis_T3='') med2_ppp=0.07.
IF  (atc5_T3='R03AC03') med5_recept=1.
IF  (atc5_T3='R03AC03' and med5_dosis_T3='500') med5_ppp=0.07.
**ATC R03AC02 - ventolin/salbutamol.
IF  (atc1_T3='R03AC02') med1_recept=1.
IF  (atc1_T3='R03AC02' and med1_dosis_T3='100') med1_ppp=0.02.
IF  (atc1_T3='R03AC02' and med1_dosis_T3='200') med1_ppp=0.05.
IF  (atc1_T3='R03AC02' and med1_dosis_T3='') med1_ppp=0.02.
IF  (atc2_T3='R03AC02') med2_recept=1.
IF  (atc2_T3='R03AC02' and med2_dosis_T3='') med2_ppp=0.02.
IF  (atc2_T3='R03AC02' and med2_dosis_T3='200') med2_ppp=0.05.
IF  (atc2_T3='R03AC02' and med2_dosis_T3='100') med2_ppp=0.02.
IF  (atc2_T3='R03AC02' and med2_dosis_T3='5 (vloeistof)') med2_ppp=0.17.
IF  (atc3_T3='R03AC02') med3_recept=1.
IF  (atc3_T3='R03AC02' and med3_dosis_T3='100') med3_ppp=0.02.
IF  (atc4_T3='R03AC02') med4_recept=1.
IF  (atc4_T3='R03AC02' and med4_dosis_T3='') med4_ppp=0.02.
IF  (atc4_T3='R03AC02' and med4_dosis_T3='100') med4_ppp=0.02.
IF  (atc4_T3='R03AC02' and med4_dosis_T3='200') med4_ppp=0.05.
IF  (atc5_T3='R03AC02') med5_recept=1.
IF  (atc5_T3='R03AC02' and med5_dosis_T3='') med5_ppp=0.02.
**ATC R02AX01.
IF  (atc3_T3='R02AX01') med3_recept=1.
IF  (atc3_T3='R02AX01' and med3_dosis_T3='8,75') med3_ppp=0.33.
**ATC R02AA03.
IF  (atc1_T3='R02AA03') med1_recept=1.
IF  (atc1_T3='R02AA03' and med1_dosis_T3='0,6/1,2') med1_ppp=0.23.
**ATC R01AX06.
IF  (atc1_T3='R01AX06') med1_recept=1.
IF  (atc1_T3='R01AX06' and med1_dosis_T3='20') med1_ppp=999.
**ATC R01AD12.
IF  (atc1_T3='R01AD12') med1_recept=1.
IF  (atc1_T3='R01AD12' and med1_dosis_T3='') med1_ppp=0.07.
IF  (atc7_T3='R01AD12') med7_recept=1.
IF  (atc7_T3='R01AD12' and med7_dosis_T3='27.5') med7_ppp=0.07.
**ATC R01AD08 - fluticason.
IF  (atc2_T3='R01AD08') med2_recept=1.
IF  (atc2_T3='R01AD08' and med2_dosis_T3='50 (spray)') med2_ppp=0.01.
IF  (atc3_T3='R01AD08') med3_recept=1.
IF  (atc3_T3='R01AD08' and med3_dosis_T3='spray') med3_ppp=0.01.
IF  (atc5_T3='R01AD08') med5_recept=1.
IF  (atc5_T3='R01AD08' and med5_dosis_T3='50 (spray)') med5_ppp=0.01.
**ATC R01AD05- budesonide.
IF  (atc2_T3='R01AD05') med2_recept=1.
IF  (atc2_T3='R01AD05' and med2_dosis_T3='100 (spray)') med2_ppp=0.03.
IF  (atc6_T3='R01AD05') med6_recept=1.
IF  (atc6_T3='R01AD05' and med6_vorm_T3='Spray') med6_ppp=0.03.
**ATC P01BB51- malaria.
IF  (atc7_T3='P01BB51') med7_recept=1.
IF  (atc7_T3='P01BB51' and med7_dosis_T3='250/100') med7_ppp=2.23.
**ATC P01AB01.
IF  (atc3_T3='P01AB01') med3_recept=1.
IF  (atc3_T3='P01AB01' and med3_dosis_T3='500') med3_ppp=0.22.
**ATC N07XX09.
IF  (atc2_T3='N07XX09') med2_recept=1.
IF  (atc2_T3='N07XX09' and med2_dosis_T3='2x120') med2_ppp=2.30.
**ATC N07BC02 - metahdon.
IF  (atc6_T3='N07BC02') med6_recept=1.
IF  (atc6_T3='N07BC02' and med6_dosis_T3='' and Med6_vorm_T3='drank') med6_ppp=1.32.
**ATC N07BA03 Champix.
IF  (atc1_T3='N07BA03') med1_recept=1.
IF  (atc1_T3='N07BA03' and med1_dosis_T3='0.5') med1_ppp=1.71.
IF  (atc1_T3='N07BA03' and med1_dosis_T3='1') med1_ppp=1.71.
IF  (atc1_T3='N07BA03' and med1_dosis_T3='2x1') med1_ppp=3.41.
IF  (atc1_T3='N07BA03' and med1_dosis_T3='') med1_ppp=1.71.
IF  (atc2_T3='N07BA03') med2_recept=1.
IF  (atc2_T3='N07BA03' and med2_dosis_T3='') med2_ppp=1.71.
IF  (atc2_T3='N07BA03' and med2_dosis_T3='0.5') med2_ppp=1.71.
IF  (atc2_T3='N07BA03' and med2_dosis_T3='1') med2_ppp=1.71.
IF  (atc2_T3='N07BA03' and med2_dosis_T3='2x1') med2_ppp=3.41.
IF  (atc3_T3='N07BA03') med3_recept=1.
IF  (atc3_T3='N07BA03' and med3_dosis_T3='1') med3_ppp=1.71.
IF  (atc4_T3='N07BA03') med4_recept=1.
IF  (atc4_T3='N07BA03' and med4_dosis_T3='1') med4_ppp=1.71.
IF  (atc4_T3='N07BA03' and med4_dosis_T3='2x1') med4_ppp=3.41.
IF  (atc4_T3='N07BA03' and med4_dosis_T3='') med4_ppp=1.71.
IF  (atc5_T3='N07BA03') med5_recept=1.
IF  (atc5_T3='N07BA03' and med5_dosis_T3='1') med5_ppp=1.71.
IF  (atc5_T3='N07BA03' and med5_dosis_T3='') med5_ppp=1.71.
IF  (atc6_T3='N07BA03') med6_recept=1.
IF  (atc6_T3='N07BA03' and med6_dosis_T3='1') med6_ppp=1.71.
IF  (atc8_T3='N07BA03') med8_recept=1.
IF  (atc8_T3='N07BA03' and med8_dosis_T3='0.5') med8_ppp=1.71.
IF  (atc8_T3='N07BA03' and med8_dosis_T3='1') med8_ppp=1.71.
**ATC N06BA04 ritalin.
IF  (atc1_T3='N06BA04') med1_recept=1.
IF  (atc1_T3='N06BA04' and med1_dosis_T3='18') med1_ppp=0.75.
IF  (atc2_T3='N06BA04') med2_recept=1.
IF  (atc2_T3='N06BA04' and med2_dosis_T3='27') med2_ppp=1.14.
IF  (atc3_T3='N06BA04') med3_recept=1.
IF  (atc3_T3='N06BA04' and med3_dosis_T3='10') med3_ppp=0.05.
IF  (atc3_T3='N06BA04' and med3_dosis_T3='30') med3_ppp=0.45.
IF  (atc4_T3='N06BA04') med4_recept=1.
IF  (atc4_T3='N06BA04' and med4_dosis_T3='10') med4_ppp=0.05.
**ATC N06BA02.
IF  (atc1_T3='N06BA02') med1_recept=1.
IF  (atc1_T3='N06BA02' and med1_dosis_T3='halve van 15') med1_ppp=0.30.
**ATC N06AX21.
IF  (atc3_T3='N06AX21') med3_recept=1.
IF  (atc3_T3='N06AX21' and med3_dosis_T3='60') med3_ppp=0.18.
**ATC N06AX16- venlafaxine.
IF  (atc1_T3='N06AX16') med1_recept=1.
IF  (atc1_T3='N06AX16' and med1_dosis_T3='75') med1_ppp=0.04.
IF  (atc1_T3='N06AX16' and med1_dosis_T3='37,5') med1_ppp=0.03.
IF  (atc2_T3='N06AX16') med2_recept=1.
IF  (atc2_T3='N06AX16' and med2_dosis_T3='75') med2_ppp=0.04.
IF  (atc2_T3='N06AX16' and med2_dosis_T3='37,5') med2_ppp=0.03.
IF  (atc4_T3='N06AX16') med4_recept=1.
IF  (atc4_T3='N06AX16' and med4_dosis_T3='75') med4_ppp=0.04.
**ATC N06AX12.
IF  (atc1_T3='N06AX12') med1_recept=1.
IF  (atc1_T3='N06AX12' and med1_dosis_T3='150') med1_ppp=0.66.
**ATC N06AB10.
IF  (atc1_T3='N06AB10') med1_recept=1.
IF  (atc1_T3='N06AB10' and med1_dosis_T3='5') med1_ppp=0.14.
IF  (atc2_T3='N06AB10') med2_recept=1.
IF  (atc2_T3='N06AB10' and med2_dosis_T3='15') med2_ppp=0.05.
IF  (atc2_T3='N06AB10' and med2_dosis_T3='10') med2_ppp=0.03.
**ATC N06AB04.
IF  (atc1_T3='N06AB04') med1_recept=1.
IF  (atc1_T3='N06AB04' and med1_dosis_T3='10') med1_ppp=0.05.
IF  (atc2_T3='N06AB04') med2_recept=1.
IF  (atc2_T3='N06AB04' and med2_dosis_T3='10') med2_ppp=0.05.
IF  (atc2_T3='N06AB04' and med2_dosis_T3='20') med2_ppp=0.03.
IF  (atc7_T3='N06AB04') med7_recept=1.
IF  (atc7_T3='N06AB04' and med7_dosis_T3='10') med7_ppp=0.05.
**ATC N06AB06.
IF  (atc1_T3='N06AB06') med1_recept=1.
IF  (atc1_T3='N06AB06' and med1_dosis_T3='50') med1_ppp=0.04.
IF  (atc1_T3='N06AB06' and med1_dosis_T3='100') med1_ppp=0.10.
IF  (atc2_T3='N06AB06') med2_recept=1.
IF  (atc2_T3='N06AB06' and med2_dosis_T3='100') med2_ppp=0.10.
IF  (atc2_T3='N06AB06' and med2_dosis_T3='50') med2_ppp=0.04.
IF  (atc3_T3='N06AB06') med3_recept=1.
IF  (atc3_T3='N06AB06' and med3_dosis_T3='50') med3_ppp=0.04.
**ATC N06AB05.
IF  (atc1_T3='N06AB05') med1_recept=1.
IF  (atc1_T3='N06AB05' and med1_dosis_T3='10') med1_ppp=0.15.
IF  (atc1_T3='N06AB05' and med1_dosis_T3='20') med1_ppp=0.03.
IF  (atc1_T3='N06AB05' and med1_dosis_T3='30') med1_ppp=0.04.
IF  (atc1_T3='N06AB05' and med1_dosis_T3='2x20') med1_ppp=0.06.
IF  (atc2_T3='N06AB05') med2_recept=1.
IF  (atc2_T3='N06AB05' and med2_dosis_T3='10') med2_ppp=0.15.
IF  (atc2_T3='N06AB05' and med2_dosis_T3='20') med2_ppp=0.03.
IF  (atc2_T3='N06AB05' and med2_dosis_T3='30') med2_ppp=0.04.
IF  (atc2_T3='N06AB05' and med2_dosis_T3='') med2_ppp=0.03.
IF  (atc3_T3='N06AB05') med3_recept=1.
IF  (atc3_T3='N06AB05' and med3_dosis_T3='2x20') med3_ppp=0.07.
IF  (atc4_T3='N06AB05') med4_recept=1.
IF  (atc4_T3='N06AB05' and med4_dosis_T3='20') med4_ppp=0.03.
IF  (atc6_T3='N06AB05') med6_recept=1.
IF  (atc6_T3='N06AB05' and med6_dosis_T3='2x20') med6_ppp=0.07.
**ATC N06AB04.
IF  (atc5_T3='N06AB04') med5_recept=1.
IF  (atc5_T3='N06AB04' and med5_dosis_T3='40') med5_ppp=0.05.
**ATC N06AB03.
IF  (atc1_T3='N06AB03') med1_recept=1.
IF  (atc1_T3='N06AB03' and med1_dosis_T3='20') med1_ppp=0.03.
IF  (atc2_T3='N06AB03') med2_recept=1.
IF  (atc2_T3='N06AB03' and med2_dosis_T3='20') med2_ppp=0.03.
**ATC N06AA10.
IF  (atc1_T3='N06AA10') med1_recept=1.
IF  (atc1_T3='N06AA10' and med1_dosis_T3='') med1_ppp=0.08.
IF  (atc1_T3='N06AA10' and med1_dosis_T3='10') med1_ppp=0.08.
IF  (atc2_T3='N06AA10') med2_recept=1.
IF  (atc2_T3='N06AA10' and med2_dosis_T3='25') med2_ppp=0.16.
IF  (atc9_T3='N06AA10') med9_recept=1.
IF  (atc9_T3='N06AA10' and med9_dosis_T3='2x10') med9_ppp=0.16.
**ATC N06AA09.
IF  (atc1_T3='N06AA09') med1_recept=1.
IF  (atc1_T3='N06AA09' and med1_dosis_T3='25') med1_ppp=0.03.
IF  (atc2_T3='N06AA09') med2_recept=1.
IF  (atc2_T3='N06AA09' and med2_dosis_T3='25') med2_ppp=0.03.
IF  (atc6_T3='N06AA09') med6_recept=1.
IF  (atc6_T3='N06AA09' and med6_dosis_T3='') med6_ppp=0.02.
**ATC N06AA04.
IF  (atc1_T3='N06AA04') med1_recept=1.
IF  (atc1_T3='N06AA04' and med1_dosis_T3='75') med1_ppp=0.11.
IF  (atc2_T3='N06AA04') med2_recept=1.
IF  (atc2_T3='N06AA04' and med2_dosis_T3='75') med2_ppp=0.11.
**ATC N05CM09.
IF  (atc1_T3='N05CM09') med1_recept=0.
IF  (atc1_T3='N05CM09' and med1_dosis_T3='450') med1_ppp=0.37.
IF  (atc5_T3='N05CM09') med5_recept=0.
IF  (atc5_T3='N05CM09' and med5_dosis_T3='45') med5_ppp=0.10.
**ATC N05CH01.
IF  (atc2_T3='N05CH01') med2_recept=1.
IF  (atc2_T3='N05CH01' and med2_dosis_T3='0.5') med2_ppp=0.27.
**ATC N05CF02 - zolpidem.
IF  (atc2_T3='N05CF02') med2_recept=1.
IF  (atc2_T3='N05CF02' and med2_dosis_T3='10') med2_ppp=0.04.
**ATC N05CF01 - zoplicon.
IF  (atc1_T3='N05CF01') med1_recept=1.
IF  (atc1_T3='N05CF01' and med1_dosis_T3='7.5') med1_ppp=0.04.
IF  (atc1_T3='N05CF01' and med1_dosis_T3='') med1_ppp=0.04.
**ATC N05CD07 - temazepam.
IF  (atc2_T3='N05CD07') med2_recept=1.
IF  (atc2_T3='N05CD07' and med2_dosis_T3='10') med2_ppp=0.05.
IF  (atc4_T3='N05CD07') med4_recept=1.
IF  (atc4_T3='N05CD07' and med4_dosis_T3='20') med4_ppp=0.07.
**ATC N05BB01.
IF  (atc1_T3='N05BB01') med1_recept=1.
IF  (atc1_T3='N05BB01' and med1_dosis_T3='25') med1_ppp=0.08.
**ATC N05BA06 - lorazepam.
IF  (atc2_T3='N05BA06') med2_recept=1.
IF  (atc2_T3='N05BA06' and med2_dosis_T3='0,5') med2_ppp=0.23.
IF  (atc5_T3='N05BA06') med5_recept=1.
IF  (atc5_T3='N05BA06' and med5_dosis_T3='1') med5_ppp=0.05.
**ATC N05BA04 - oxazepam.
IF  (atc1_T3='N05BA04') med1_recept=1.
IF  (atc1_T3='N05BA04' and med1_dosis_T3='10') med1_ppp=0.02.
IF  (atc1_T3='N05BA04' and med1_dosis_T3='') med1_ppp=0.02.
IF  (atc2_T3='N05BA04') med2_recept=1.
IF  (atc2_T3='N05BA04' and med2_dosis_T3='10') med2_ppp=0.02.
IF  (atc3_T3='N05BA04') med3_recept=1.
IF  (atc3_T3='N05BA04' and med3_dosis_T3='') med3_ppp=0.02.
IF  (atc3_T3='N05BA04' and med3_dosis_T3='5') med3_ppp=0.14.
**ATC N05BA01 - diazepam.
IF  (atc1_T3='N05BA01') med1_recept=1.
IF  (atc1_T3='N05BA01' and med1_dosis_T3='10') med1_ppp=0.04.
IF  (atc2_T3='N05BA01') med2_recept=1.
IF  (atc2_T3='N05BA01' and med2_dosis_T3='5') med2_ppp=0.02.
IF  (atc2_T3='N05BA01' and med2_dosis_T3='') med2_ppp=0.02.
IF  (atc5_T3='N05BA01') med5_recept=1.
IF  (atc5_T3='N05BA01' and med5_dosis_T3='') med5_ppp=0.02.
**ATC N05AX08.
IF  (atc1_T3='N05AX08') med1_recept=1.
IF  (atc1_T3='N05AX08' and med1_dosis_T3='1') med1_ppp=0.02.
IF  (atc1_T3='N05AX08' and med1_dosis_T3='3') med1_ppp=0.04.
**ATC N05AN01.
IF  (atc1_T3='N05AN01') med1_recept=1.
IF  (atc1_T3='N05AN01' and med1_dosis_T3='600') med1_ppp=0.08.
**ATC N05AH04 - Quetiapine.
IF  (atc1_T3='N05AH04') med1_recept=1.
IF  (atc1_T3='N05AH04' and med1_dosis_T3='50') med1_ppp=0.07.
IF  (atc1_T3='N05AH04' and med1_dosis_T3='300') med1_ppp=0.08.
IF  (atc2_T3='N05AH04') med2_recept=1.
IF  (atc2_T3='N05AH04' and med2_dosis_T3='') med2_ppp=0.02.
IF  (atc4_T3='N05AH04') med4_recept=1.
IF  (atc4_T3='N05AH04' and med4_dosis_T3='') med4_ppp=0.02.
**ATC N05AF01.
IF  (atc4_T3='N05AF01') med4_recept=1.
IF  (atc4_T3='N05AF01' and med4_dosis_T3='1') med4_ppp=0.08.
**ATC N04BC05 - pramipexol.
IF  (atc3_T3='N04BC05') med3_recept=1.
IF  (atc3_T3='N04BC05' and med3_dosis_T3='3') med3_ppp=4.37.
**ATC N04BC04 - .
IF  (atc1_T3='N04BC04') med1_recept=1.
IF  (atc1_T3='N04BC04' and med1_dosis_T3='2x5 en 1x4') med1_ppp=3.18.
**ATC N04AA02.
IF  (atc3_T3='N04AA02') med3_recept=1.
IF  (atc3_T3='N04AA02' and med3_dosis_T3='2') med3_ppp=0.05.
**ATC N03AX16 - Lyrica.
IF  (atc1_T3='N03AX16') med1_recept=1.
IF  (atc1_T3='N03AX16' and med1_dosis_T3='150 en 75') med1_ppp=0.17.
IF  (atc2_T3='N03AX16') med2_recept=1.
IF  (atc2_T3='N03AX16' and med2_dosis_T3='150') med2_ppp=0.11.
IF  (atc3_T3='N03AX16') med3_recept=1.
IF  (atc3_T3='N03AX16' and med3_dosis_T3='75') med3_ppp=0.06.
IF  (atc4_T3='N03AX16') med4_recept=1.
IF  (atc4_T3='N03AX16' and med4_dosis_T3='75') med4_ppp=0.06.
IF  (atc7_T3='N03AX16') med7_recept=1.
IF  (atc7_T3='N03AX16' and med7_dosis_T3='75') med7_ppp=0.06.
**ATC N03AX14.
IF  (atc1_T3='N03AX14') med1_recept=1.
IF  (atc1_T3='N03AX14' and med1_dosis_T3='500 en 1000') med1_ppp=0.15.
**ATC N03AX12.
IF  (atc2_T3='N03AX12') med2_recept=1.
IF  (atc2_T3='N03AX12' and med2_dosis_T3='100') med2_ppp=0.04.
**ATC N03AX11.
IF  (atc1_T3='N03AX11') med1_recept=1.
IF  (atc1_T3='N03AX11' and med1_dosis_T3='') med1_ppp=0.02.
IF  (atc2_T3='N03AX11') med2_recept=1.
IF  (atc2_T3='N03AX11' and med2_dosis_T3='25 en 50') med2_ppp=0.05.
**ATC N03AF01.
IF  (atc2_T3='N03AF01') med2_recept=1.
IF  (atc2_T3='N03AF01' and med2_dosis_T3='400') med2_ppp=0.15.
**ATC N03AE01- rivotril.
IF  (atc1_T3='N03AE01') med1_recept=1.
IF  (atc1_T3='N03AE01' and med1_dosis_T3='0.5') med1_ppp=0.04.
IF  (atc4_T3='N03AE01') med4_recept=1.
IF  (atc4_T3='N03AE01' and med4_dosis_T3='2') med4_ppp=0.10.
**ATC N02CC06.
IF  (atc3_T3='N02CC06') med3_recept=1.
IF  (atc3_T3='N02CC06' and med3_dosis_T3='25') med3_ppp=4.90.
**ATC N02CC03 .
IF  (atc3_T3='N02CC03') med3_recept=1.
IF  (atc3_T3='N02CC03' and med3_dosis_T3='2,5') med3_ppp=0.13.
**ATC N02CC01 Imigran.
IF  (atc2_T3='N02CC01') med2_recept=1.
IF  (atc2_T3='N02CC01' and med2_dosis_T3='20 (spray)') med2_ppp=999.
IF  (atc3_T3='N02CC01') med3_recept=1.
IF  (atc3_T3='N02CC01' and med3_dosis_T3='0,5 (injectie)') med3_ppp=14.26.
IF  (atc4_T3='N02CC01') med4_recept=1.
IF  (atc4_T3='N02CC01' and med4_dosis_T3='100') med4_ppp=0.25.
**ATC N02BE51 Paracetamol/codeine.
IF  (atc1_T3='N02BE51') med1_recept=0.
IF  (atc1_T3='N02BE51' and med1_dosis_T3='500/65') med1_ppp=0.12.
IF  (atc1_T3='N02BE51' and med1_dosis_T3='500/30 poeder') med1_ppp=0.64.
IF  (atc1_T3='N02BE51' and med1_dosis_T3='250/250/65') med1_ppp=0.50.
IF  (atc3_T3='N02BE51') med3_recept=0.
IF  (atc3_T3='N02BE51' and med3_dosis_T3='500/50 poeder') med3_ppp=0.20.
IF  (atc3_T3='N02BE51' and med3_dosis_T3='500/30 poeder') med3_ppp=0.64.
**ATC N02BE01 Paracetamol.
IF  (atc1_T3='N02BE01') med1_recept=0.
IF  (atc1_T3='N02BE01' and med1_dosis_T3='500') med1_ppp=0.02.
IF  (atc1_T3='N02BE01' and med1_dosis_T3='2x500') med1_ppp=0.04.
IF  (atc1_T3='N02BE01' and med1_dosis_T3='') med1_ppp=0.02.
IF  (atc1_T3='N02BE01' and med1_dosis_T3='200') med1_ppp=0.02.
IF  (atc1_T3='N02BE01' and med1_dosis_T3='1000') med1_ppp=0.03.
IF  (atc1_T3='N02BE01' and med1_dosis_T3='100') med1_ppp=0.10.
IF  (atc1_T3='N02BE01' and med1_dosis_T3='400') med1_ppp=0.02.
IF  (atc2_T3='N02BE01') med2_recept=0.
IF  (atc2_T3='N02BE01' and med2_dosis_T3='500') med2_ppp=0.02.
IF  (atc2_T3='N02BE01' and med2_dosis_T3='1000') med2_ppp=0.03.
IF  (atc2_T3='N02BE01' and med2_dosis_T3='100') med2_ppp=0.10.
IF  (atc2_T3='N02BE01' and med2_dosis_T3='1,5 x 250') med2_ppp=0.24.
IF  (atc2_T3='N02BE01' and med2_dosis_T3='250') med2_ppp=0.16.
IF  (atc2_T3='N02BE01' and med2_dosis_T3='200') med2_ppp=0.02.
IF  (atc2_T3='N02BE01' and med2_dosis_T3='') med2_ppp=0.02.
IF  (atc3_T3='N02BE01') med3_recept=0.
IF  (atc3_T3='N02BE01' and med3_dosis_T3='500') med3_ppp=0.02.
IF  (atc3_T3='N02BE01' and med3_dosis_T3='2x500') med3_ppp=0.04.
IF  (atc3_T3='N02BE01' and med3_dosis_T3='1000') med3_ppp=0.03.
IF  (atc4_T3='N02BE01') med4_recept=0.
IF  (atc4_T3='N02BE01' and med4_dosis_T3='500') med4_ppp=0.02.
IF  (atc4_T3='N02BE01' and med4_dosis_T3='1000') med4_ppp=0.03.
IF  (atc4_T3='N02BE01' and med4_dosis_T3='2x500') med4_ppp=0.04.
IF  (atc4_T3='N02BE01' and med4_dosis_T3='') med4_ppp=0.02.
IF  (atc5_T3='N02BE01') med5_recept=0.
IF  (atc5_T3='N02BE01' and med5_dosis_T3='500') med5_ppp=0.02.
IF  (atc5_T3='N02BE01' and med5_dosis_T3='1000') med5_ppp=0.03.
IF  (atc5_T3='N02BE01' and med5_dosis_T3='') med5_ppp=0.02.
IF  (atc6_T3='N02BE01') med6_recept=0.
IF  (atc6_T3='N02BE01' and med6_dosis_T3='500') med6_ppp=0.02.
IF  (atc7_T3='N02BE01') med7_recept=0.
IF  (atc7_T3='N02BE01' and med7_dosis_T3='') med7_ppp=0.02.
IF  (atc7_T3='N02BE01' and med7_dosis_T3='1000') med7_ppp=0.03.
IF  (atc8_T3='N02BE01') med8_recept=0.
IF  (atc8_T3='N02BE01' and med8_dosis_T3='') med8_ppp=0.02.
**ATC N02BA15 - carbasalaatcalcium- pijnstillend.
IF  (atc2_T3='N02BA15') med2_recept=1.
IF  (atc2_T3='N02BA15' and med2_dosis_T3='600') med2_ppp=0.14.
**ATC N02BA01 - asperine- pijnstillend.
IF  (atc2_T3='N02BA01' and med2_dosis_T3='500') med2_recept=0.
IF  (atc2_T3='N02BA01' and med2_dosis_T3='500') med2_ppp=0.14.
**ATC N02AX02 - tramadol.
IF  (atc1_T3='N02AX02') med1_recept=1.
IF  (atc1_T3='N02AX02' and med1_dosis_T3='150') med1_ppp=0.10.
IF  (atc1_T3='N02AX02' and med1_dosis_T3='') med1_ppp=0.03.
IF  (atc2_T3='N02AX02') med2_recept=1.
IF  (atc2_T3='N02AX02' and med2_dosis_T3='') med2_ppp=0.03.
IF  (atc2_T3='N02AX02' and med2_dosis_T3='50') med2_ppp=0.03.
IF  (atc3_T3='N02AX02') med3_recept=1.
IF  (atc3_T3='N02AX02' and med3_dosis_T3='50') med3_ppp=0.03.
IF  (atc4_T3='N02AX02') med4_recept=1.
IF  (atc4_T3='N02AX02' and med4_dosis_T3='50') med4_ppp=0.03.
**ATC N02AX52 - zaldiar.
IF  (atc6_T3='N02AX52') med6_recept=1.
IF  (atc6_T3='N02AX52' and med6_dosis_T3='') med6_ppp=0.07.
**ATC N02AJ13 tramadol/paracetamol. 
IF  (atc2_T3='N02AJ13') med2_recept=1.
IF  (atc2_T3='N02AJ13' and med2_dosis_T3='37,5/325') med2_ppp=0.07.
IF  (atc3_T3='N02AJ13') med3_recept=1.
IF  (atc3_T3='N02AJ13' and med3_dosis_T3='37,5/325') med3_ppp=0.07.
**ATC N02AJ06 paracetamol/codeine.
IF  (atc1_T3='N02AJ06') med1_recept=0.
IF  (atc1_T3='N02AJ06' and med1_dosis_T3='500/30') med1_ppp=999.
IF  (atc2_T3='N02AJ06') med2_recept=0.
IF  (atc2_T3='N02AJ06' and med2_dosis_T3='500/10') med2_ppp=0.04.
**ATC N02AA05 - oxycodon.
IF  (atc1_T3='N02AA05') med1_recept=1.
IF  (atc1_T3='N02AA05' and med1_dosis_T3='') med1_ppp=0.03.
IF  (atc2_T3='N02AA05') med2_recept=1.
IF  (atc2_T3='N02AA05' and med2_dosis_T3='5') med2_ppp=0.03.
IF  (atc2_T3='N02AA05' and med2_dosis_T3='20') med2_ppp=0.06.
IF  (atc3_T3='N02AA05') med3_recept=1.
IF  (atc3_T3='N02AA05' and med3_dosis_T3='20') med3_ppp=0.06.
IF  (atc4_T3='N02AA05') med4_recept=1.
IF  (atc4_T3='N02AA05' and med4_dosis_T3='5') med4_ppp=0.03.
IF  (atc4_T3='N02AA05' and med4_dosis_T3='10') med4_ppp=0.05.
IF  (atc7_T3='N02AA05') med7_recept=1.
IF  (atc7_T3='N02AA05' and med7_dosis_T3='10') med7_ppp=0.05.
IF  (atc8_T3='N02AA05') med8_recept=1.
IF  (atc8_T3='N02AA05' and med8_dosis_T3='5') med8_ppp=0.03.
**ATC N02AA01 - morfine.
IF  (atc1_T3='N02AA01') med1_recept=1.
IF  (atc1_T3='N02AA01' and med1_dosis_T3='') med1_ppp=0.14.
IF  (atc2_T3='N02AA01') med2_recept=1.
IF  (atc2_T3='N02AA01' and med2_dosis_T3='10') med2_ppp=0.14.
IF  (atc5_T3='N02AA01') med5_recept=1.
IF  (atc5_T3='N02AA01' and med5_dosis_T3='') med5_ppp=0.14.
IF  (atc6_T3='N02AA01') med6_recept=1.
IF  (atc6_T3='N02AA01' and med6_dosis_T3='10') med6_ppp=0.14.
**ATC N01BB02.
IF  (atc6_T3='N01BB02') med6_recept=1.
IF  (atc6_T3='N01BB02' and med6_dosis_T3='') med6_ppp=0.85.
**ATC M05BA08.
IF  (atc5_T3='M05BA08') med5_recept=1.
IF  (atc5_T3='M05BA08' and med5_dosis_T3='1 infuus') med5_ppp=167.01.
**ATC M05BA04- alendrolinezuur.
IF  (atc1_T3='M05BA04') med1_recept=1.
IF  (atc1_T3='M05BA04' and med1_dosis_T3='70') med1_ppp=0.11.
IF  (atc1_T3='M05BA04' and med1_dosis_T3='') med1_ppp=0.11.
IF  (atc2_T3='M05BA04') med2_recept=1.
IF  (atc2_T3='M05BA04' and med2_dosis_T3='70') med2_ppp=0.11.
IF  (atc2_T3='M05BA04' and med2_dosis_T3='') med2_ppp=0.11.
IF  (atc4_T3='M05BA04') med4_recept=1.
IF  (atc4_T3='M05BA04' and med4_dosis_T3='70') med4_ppp=0.11.
**ATC M04AC01- colchicine.
IF  (atc5_T3='M04AC01') med5_recept=1.
IF  (atc5_T3='M04AC01' and med5_dosis_T3='0.5') med5_ppp=0.08.
IF  (atc7_T3='M04AC01') med7_recept=1.
IF  (atc7_T3='M04AC01' and med7_dosis_T3='2x0,5') med7_ppp=0.16.
**ATC M04AA01- allopurinol.
IF  (atc1_T3='M04AA01') med1_recept=1.
IF  (atc1_T3='M04AA01' and med1_dosis_T3='300') med1_ppp=0.06.
IF  (atc2_T3='M04AA01') med2_recept=1.
IF  (atc2_T3='M04AA01' and med2_dosis_T3='') med2_ppp=0.06.
IF  (atc4_T3='M04AA01') med4_recept=1.
IF  (atc4_T3='M04AA01' and med4_dosis_T3='300') med4_ppp=0.06.
**ATC M03AX01.
IF  (atc1_T3='M03AX01') med1_recept=1.
IF  (atc1_T3='M03AX01' and med1_dosis_T3='') med1_ppp=132.50.
**ATC M01AX05.
IF  (atc2_T3='M01AX05') med2_recept=1.
IF  (atc2_T3='M01AX05' and med2_dosis_T3='') med2_ppp=0.22.
**ATC M01AH05.
IF  (atc1_T3='M01AH05') med1_recept=1.
IF  (atc1_T3='M01AH05' and med1_dosis_T3='120') med1_ppp=1.23.
IF  (atc2_T3='M01AH05') med2_recept=1.
IF  (atc2_T3='M01AH05' and med2_dosis_T3='90') med2_ppp=1.01.
IF  (atc5_T3='M01AH05') med5_recept=1.
IF  (atc5_T3='M01AH05' and med5_dosis_T3='60') med5_ppp=0.08.
IF  (atc6_T3='M01AH05') med6_recept=1.
IF  (atc6_T3='M01AH05' and med6_dosis_T3='90') med6_ppp=1.01.
**ATC M01AH01-celebrex.
IF  (atc1_T3='M01AH01') med1_recept=1.
IF  (atc1_T3='M01AH01' and med1_dosis_T3='100') med1_ppp=0.04.
IF  (atc1_T3='M01AH01' and med1_dosis_T3='2x200') med1_ppp=0.10.
IF  (atc2_T3='M01AH01') med2_recept=1.
IF  (atc2_T3='M01AH01' and med2_dosis_T3='100') med2_ppp=0.04.
IF  (atc3_T3='M01AH01') med3_recept=1.
IF  (atc3_T3='M01AH01' and med3_dosis_T3='200') med3_ppp=0.05.
**ATC M01AE02- naproxen.
IF  (atc1_T3='M01AE02') med1_recept=1.
IF  (atc1_T3='M01AE02' and med1_dosis_T3='') med1_ppp=0.03.
IF  (atc1_T3='M01AE02' and med1_dosis_T3='500') med1_ppp=0.04.
IF  (atc2_T3='M01AE02') med2_recept=1.
IF  (atc2_T3='M01AE02' and med2_dosis_T3='500') med2_ppp=0.04.
IF  (atc3_T3='M01AE02') med3_recept=1.
IF  (atc3_T3='M01AE02' and med3_dosis_T3='250') med3_ppp=0.03.
IF  (atc3_T3='M01AE02' and med3_dosis_T3='500') med3_ppp=0.04.
IF  (atc3_T3='M01AE02' and med3_dosis_T3='') med3_ppp=0.03.
IF  (atc4_T3='M01AE02') med4_recept=1.
IF  (atc4_T3='M01AE02' and med4_dosis_T3='500') med4_ppp=0.04.
IF  (atc5_T3='M01AE02') med5_recept=1.
IF  (atc5_T3='M01AE02' and med5_dosis_T3='500') med5_ppp=0.04.
IF  (atc6_T3='M01AE02') med6_recept=1.
IF  (atc6_T3='M01AE02' and med6_dosis_T3='500') med6_ppp=0.04.
**ATC M01AE01- ibuprofen.
IF  (atc1_T3='M01AE01' and med1_dosis_T3='100') med1_recept=0.
IF  (atc1_T3='M01AE01' and med1_dosis_T3='200') med1_recept=0.
IF  (atc1_T3='M01AE01' and med1_dosis_T3='400') med1_recept=0.
IF  (atc1_T3='M01AE01' and med1_dosis_T3='500') med1_recept=9.
IF  (atc1_T3='M01AE01' and med1_dosis_T3='600') med1_recept=1.
IF  (atc1_T3='M01AE01' and med1_dosis_T3='800') med1_recept=1.
IF  (atc1_T3='M01AE01' and med1_dosis_T3='') med1_recept=0.
IF  (atc1_T3='M01AE01' and med1_dosis_T3='100') med1_ppp=0.44.
IF  (atc1_T3='M01AE01' and med1_dosis_T3='200') med1_ppp=0.04.
IF  (atc1_T3='M01AE01' and med1_dosis_T3='400') med1_ppp=0.06.
IF  (atc1_T3='M01AE01' and med1_dosis_T3='500') med1_ppp=999.
IF  (atc1_T3='M01AE01' and med1_dosis_T3='600') med1_ppp=0.04.
IF  (atc1_T3='M01AE01' and med1_dosis_T3='800') med1_ppp=0.13.
IF  (atc1_T3='M01AE01' and med1_dosis_T3='') med1_ppp=0.04.
IF  (atc2_T3='M01AE01' and med2_dosis_T3='100') med2_recept=0.
IF  (atc2_T3='M01AE01' and med2_dosis_T3='200') med2_recept=0.
IF  (atc2_T3='M01AE01' and med2_dosis_T3='400') med2_recept=0.
IF  (atc2_T3='M01AE01' and med2_dosis_T3='500') med2_recept=9.
IF  (atc2_T3='M01AE01' and med2_dosis_T3='600') med2_recept=1.
IF  (atc2_T3='M01AE01' and med2_dosis_T3='800') med2_recept=1.
IF  (atc2_T3='M01AE01' and med2_dosis_T3='') med2_recept=0.
IF  (atc2_T3='M01AE01' and med2_dosis_T3='100') med2_ppp=0.44.
IF  (atc2_T3='M01AE01' and med2_dosis_T3='200') med2_ppp=0.04.
IF  (atc2_T3='M01AE01' and med2_dosis_T3='400') med2_ppp=0.06.
IF  (atc2_T3='M01AE01' and med2_dosis_T3='500') med2_ppp=999.
IF  (atc2_T3='M01AE01' and med2_dosis_T3='600') med2_ppp=0.04.
IF  (atc2_T3='M01AE01' and med2_dosis_T3='800') med2_ppp=0.13.
IF  (atc2_T3='M01AE01' and med2_dosis_T3='') med2_ppp=0.04.
IF  (atc3_T3='M01AE01' and med3_dosis_T3='100') med1_recept=0.
IF  (atc3_T3='M01AE01' and med3_dosis_T3='200') med3_recept=0.
IF  (atc3_T3='M01AE01' and med3_dosis_T3='400') med3_recept=0.
IF  (atc3_T3='M01AE01' and med3_dosis_T3='600') med3_recept=1.
IF  (atc3_T3='M01AE01' and med3_dosis_T3='800') med3_recept=1.
IF  (atc3_T3='M01AE01' and med3_dosis_T3='') med3_recept=0.
IF  (atc3_T3='M01AE01' and med3_dosis_T3='100') med3_ppp=0.44.
IF  (atc3_T3='M01AE01' and med3_dosis_T3='200') med3_ppp=0.04.
IF  (atc3_T3='M01AE01' and med3_dosis_T3='400') med3_ppp=0.06.
IF  (atc3_T3='M01AE01' and med3_dosis_T3='600') med3_ppp=0.04.
IF  (atc3_T3='M01AE01' and med3_dosis_T3='800') med3_ppp=0.13.
IF  (atc3_T3='M01AE01' and med3_dosis_T3='') med3_ppp=0.04.
IF  (atc4_T3='M01AE01' and med4_dosis_T3='') med4_recept=0.
IF  (atc4_T3='M01AE01' and med4_dosis_T3='2x600') med4_recept=1.
IF  (atc4_T3='M01AE01' and med4_dosis_T3='2x600') med4_ppp=0.08.
IF  (atc4_T3='M01AE01' and med4_dosis_T3='') med4_ppp=0.04.
IF  (atc5_T3='M01AE01' and med5_dosis_T3='400') med5_recept=0.
IF  (atc5_T3='M01AE01' and med5_dosis_T3='400') med5_ppp=0.06.
IF  (atc6_T3='M01AE01' and med6_dosis_T3='400') med6_recept=0.
IF  (atc6_T3='M01AE01' and med6_dosis_T3='400') med6_ppp=0.06.
IF  (atc8_T3='M01AE01' and med8_dosis_T3='400') med8_recept=0.
IF  (atc8_T3='M01AE01' and med8_dosis_T3='400') med8_ppp=0.06.
**ATC M01AC06 meloxicam.
IF  (atc2_T3='M01AC06') med2_recept=1.
IF  (atc2_T3='M01AC06' and med2_dosis_T3='7.5') med2_ppp=0.03.
**ATC M01AB55 diclofenac/misoprostol.
IF  (atc2_T3='M01AB55') med2_recept=1.
IF  (atc2_T3='M01AB55' and med2_dosis_T3='75/0,2') med2_ppp=0.75.
**ATC M01AB05 - diclofenac.
IF  (atc1_T3='M01AB05' and med1_dosis_T3='25') med1_recept=0.
IF  (atc1_T3='M01AB05' and med1_dosis_T3='50') med1_recept=1.
IF  (atc1_T3='M01AB05' and med1_dosis_T3='75') med1_recept=1.
IF  (atc1_T3='M01AB05' and med1_dosis_T3='2x100') med1_recept=1.
IF  (atc1_T3='M01AB05' and med1_dosis_T3='') med1_recept=0.
IF  (atc1_T3='M01AB05' and med1_dosis_T3='25') med1_ppp=0.03.
IF  (atc1_T3='M01AB05' and med1_dosis_T3='50') med1_ppp=0.02.
IF  (atc1_T3='M01AB05' and med1_dosis_T3='') med1_ppp=0.02.
IF  (atc1_T3='M01AB05' and med1_dosis_T3='75') med1_ppp=0.04.
IF  (atc1_T3='M01AB05' and med1_dosis_T3='2x100') med1_ppp=0.10.
IF  (atc2_T3='M01AB05' and med2_dosis_T3='50') med2_recept=1.
IF  (atc2_T3='M01AB05' and med2_dosis_T3='75') med2_recept=1.
IF  (atc2_T3='M01AB05' and med2_dosis_T3='') med2_recept=0.
IF  (atc2_T3='M01AB05' and med2_dosis_T3='50') med2_ppp=0.02.
IF  (atc2_T3='M01AB05' and med2_dosis_T3='75') med2_ppp=0.04.
IF  (atc2_T3='M01AB05' and med2_dosis_T3='') med2_ppp=0.02.
IF  (atc3_T3='M01AB05' and med3_dosis_T3='50') med3_recept=1.
IF  (atc3_T3='M01AB05' and med3_dosis_T3='') med3_recept=0.
IF  (atc3_T3='M01AB05' and med3_dosis_T3='50') med3_ppp=0.02.
IF  (atc3_T3='M01AB05' and med3_dosis_T3='') med3_ppp=0.02.
IF  (atc4_T3='M01AB05' and med4_dosis_T3='50') med4_recept=1.
IF  (atc4_T3='M01AB05' and med4_dosis_T3='75') med4_recept=1.
IF  (atc4_T3='M01AB05' and med4_dosis_T3='50') med4_ppp=0.02.
IF  (atc4_T3='M01AB05' and med4_dosis_T3='75') med4_ppp=0.04.
IF  (atc5_T3='M01AB05' and med5_dosis_T3='50') med5_recept=1.
IF  (atc5_T3='M01AB05' and med5_dosis_T3='50') med5_ppp=0.02.
IF  (atc6_T3='M01AB05' and med6_dosis_T3='75') med6_recept=1.
IF  (atc6_T3='M01AB05' and med6_dosis_T3='75') med6_ppp=0.04.
IF  (atc6_T3='M01AB05' and med6_dosis_T3='') med6_recept=0.
IF  (atc6_T3='M01AB05' and med6_dosis_T3='') med6_ppp=0.02.
**ATC L04AX03- methotrexaat.
IF  (atc1_T3='L04AX03') med1_recept=1.
IF  (atc1_T3='L04AX03' and med1_dosis_T3='25' and med1_eenheid_T3='mg/ml') med1_ppp=10.00.
IF  (atc1_T3='L04AX03' and med1_dosis_T3='10x2,5' and med1_eenheid_T3='mg') med1_ppp=1.70.
IF  (atc1_T3='L04AX03' and med1_dosis_T3='2,5' and med1_eenheid_T3='mg') med1_ppp=0.17.
IF  (atc1_T3='L04AX03' and med1_dosis_T3='' and med1_eenheid_T3='mg') med1_ppp=0.17.
IF  (atc2_T3='L04AX03') med2_recept=1.
IF  (atc2_T3='L04AX03' and med2_dosis_T3='2,5' and med2_eenheid_T3='mg') med2_ppp=0.17.
**ATC L04AD02-.
IF  (atc2_T3='L04AD02') med2_recept=1.
IF  (atc2_T3='L04AD02' and med2_dosis_T3='3') med2_ppp=6.52.
**ATC L04AB04-humira.
IF  (atc1_T3='L04AB04') med1_recept=1.
IF  (atc1_T3='L04AB04' and med1_dosis_T3='') med1_ppp=582.50.
IF  (atc3_T3='L04AB04') med3_recept=1.
IF  (atc3_T3='L04AB04' and med3_dosis_T3='') med3_ppp=582.50.
**ATC L04AA13.
IF  (atc3_T3='L04AA13') med3_recept=1.
IF  (atc3_T3='L04AA13' and med3_dosis_T3='20') med3_ppp=1.13.
**ATC L02BG04.
IF  (atc2_T3='L02BG04') med2_recept=1.
IF  (atc2_T3='L02BG04' and med2_dosis_T3='') med2_ppp=0.05.
**ATC L02BG03.
IF  (atc1_T3='L02BG03') med1_recept=1.
IF  (atc1_T3='L02BG03' and med1_dosis_T3='1') med1_ppp=0.03.
IF  (atc8_T3='L02BG03') med8_recept=1.
IF  (atc8_T3='L02BG03' and med8_dosis_T3='') med8_ppp=0.03.
**ATC L01BB03.
IF  (atc5_T3='L01BB03') med5_recept=1.
IF  (atc5_T3='L01BB03' and med5_dosis_T3='40') med5_ppp=2.77.
**ATC L02BA01.
IF  (atc1_T3='L02BA01') med1_recept=1.
IF  (atc1_T3='L02BA01' and med1_dosis_T3='20') med1_ppp=0.17.
IF  (atc7_T3='L02BA01') med7_recept=1.
IF  (atc7_T3='L02BA01' and med7_dosis_T3='40') med7_ppp=0.84.
**ATC J02AC02.
IF  (atc6_T3='J02AC02') med6_recept=1.
IF  (atc6_T3='J02AC02' and med6_dosis_T3='100') med6_ppp=0.36.
**ATC J01XX01 - monuril.
IF  (atc5_T3='J01XX01') med5_recept=1.
IF  (atc5_T3='J01XX01' and med5_dosis_T3='') med5_ppp=4.93.
**ATC J01XE01 - nitrofuratoine.
IF  (atc3_T3='J01XE01') med3_recept=1.
IF  (atc3_T3='J01XE01' and med3_dosis_T3='') med3_ppp=0.07.
IF  (atc4_T3='J01XE01') med4_recept=1.
IF  (atc4_T3='J01XE01' and med4_dosis_T3='100') med4_ppp=0.07.
**ATC J01MA02.
IF  (atc3_T3='J01MA02') med3_recept=1.
IF  (atc3_T3='J01MA02' and med3_dosis_T3='500') med3_ppp=0.08.
**ATC J01FA09.
IF  (atc2_T3='J01FA09') med2_recept=1.
IF  (atc2_T3='J01FA09' and med2_dosis_T3='500') med2_ppp=0.20.
**ATC J01CR02 - .
IF  (atc2_T3='J01CR02') med2_recept=1.
IF  (atc2_T3='J01CR02' and med2_dosis_T3='125/500') med2_ppp=0.10.
**ATC J01CF05 - .
IF  (atc2_T3='J01CF05') med2_recept=1.
IF  (atc2_T3='J01CF05' and med2_dosis_T3='500') med2_ppp=0.11.
IF  (atc5_T3='J01CF05') med5_recept=1.
IF  (atc5_T3='J01CF05' and med5_dosis_T3='500') med5_ppp=0.11.
**ATC J01CA04 - amoxicilline.
IF  (atc1_T3='J01CA04') med1_recept=1.
IF  (atc1_T3='J01CA04' and med1_dosis_T3='') med1_ppp=0.06.
IF  (atc2_T3='J01CA04') med2_recept=1.
IF  (atc2_T3='J01CA04' and med2_dosis_T3='500') med2_ppp=0.06.
IF  (atc3_T3='J01CA04') med3_recept=1.
IF  (atc3_T3='J01CA04' and med3_dosis_T3='500') med3_ppp=0.06.
IF  (atc3_T3='J01CA04' and med3_dosis_T3='') med3_ppp=0.06.
**ATC J01AA02 - doxyicilline.
IF  (atc1_T3='J01AA02') med1_recept=1.
IF  (atc1_T3='J01AA02' and med1_dosis_T3='100') med1_ppp=0.10.
IF  (atc2_T3='J01AA02') med2_recept=1.
IF  (atc2_T3='J01AA02' and med2_dosis_T3='100') med2_ppp=0.10.
IF  (atc5_T3='J01AA02') med5_recept=1.
IF  (atc5_T3='J01AA02' and med5_dosis_T3='100') med5_ppp=0.10.
**ATC H03BB02 - .
IF  (atc3_T3='H03BB02') med3_recept=1.
IF  (atc3_T3='H03BB02' and med3_dosis_T3='') med3_ppp=0.04.
**ATC H03AA01 - Thyrax.
IF  (atc1_T3='H03AA01') med1_recept=1.
IF  (atc1_T3='H03AA01' and med1_dosis_T3='112') med1_ppp=0.05.
IF  (atc1_T3='H03AA01' and med1_dosis_T3='150') med1_ppp=0.06.
IF  (atc1_T3='H03AA01' and med1_dosis_T3='125') med1_ppp=0.06.
IF  (atc1_T3='H03AA01' and med1_dosis_T3='100') med1_ppp=0.03.
IF  (atc1_T3='H03AA01' and med1_dosis_T3='50') med1_ppp=0.02.
IF  (atc1_T3='H03AA01' and med1_dosis_T3='') med1_ppp=0.02.
IF  (atc1_T3='H03AA01' and med1_dosis_T3='75') med1_ppp=0.03.
IF  (atc1_T3='H03AA01' and med1_dosis_T3='88') med1_ppp=0.04.
IF  (atc1_T3='H03AA01' and med1_dosis_T3='200 en 175') med1_ppp=0.15.
IF  (atc2_T3='H03AA01') med2_recept=1.
IF  (atc2_T3='H03AA01' and med2_dosis_T3='') med2_ppp=0.02.
IF  (atc2_T3='H03AA01' and med2_dosis_T3='75') med2_ppp=0.03.
IF  (atc2_T3='H03AA01' and med2_dosis_T3='125') med2_ppp=0.06.
IF  (atc2_T3='H03AA01' and med2_dosis_T3='150') med2_ppp=0.06.
IF  (atc3_T3='H03AA01') med3_recept=1.
IF  (atc3_T3='H03AA01' and med3_dosis_T3='25') med3_ppp=0.02.
IF  (atc5_T3='H03AA01') med5_recept=1.
IF  (atc5_T3='H03AA01' and med5_dosis_T3='75') med5_ppp=0.03.
**ATC H02AB07-prednison.
IF  (atc1_T3='H02AB07') med1_recept=1.
IF  (atc1_T3='H02AB07' and med1_dosis_T3='30') med1_ppp=0.61.
IF  (atc2_T3='H02AB07') med2_recept=1.
IF  (atc2_T3='H02AB07' and med2_dosering_T3='kuur') med2_ppp=0.05.
IF  (atc4_T3='H02AB07') med4_recept=1.
IF  (atc4_T3='H02AB07' and med4_dosis_T3='30') med4_ppp=0.61.
IF  (atc8_T3='H02AB07') med8_recept=1.
IF  (atc8_T3='H02AB07' and med8_dosis_T3='') med8_ppp=0.05.
**ATC H02AB06 - prednisolon.
IF  (atc1_T3='H02AB06') med1_recept=1.
IF  (atc1_T3='H02AB06' and med1_dosis_T3='5') med1_ppp=0.03.
IF  (atc2_T3='H02AB06') med2_recept=1.
IF  (atc2_T3='H02AB06' and med2_dosis_T3='5') med2_ppp=0.03.
IF  (atc3_T3='H02AB06') med3_recept=1.
IF  (atc3_T3='H02AB06' and med3_dosis_T3='5 en 2.5') med3_ppp=0.30.
**ATC H02AB01 - .
IF  (atc1_T3='H02AB01') med1_recept=1.
IF  (atc1_T3='H02AB01' and med1_dosis_T3='0.5') med1_ppp=0.77.
**ATC G04CB01 - finasteride.
IF  (atc1_T3='G04CB01') med1_recept=1.
IF  (atc1_T3='G04CB01' and med1_dosis_T3='1') med1_ppp=0.60.
IF  (atc2_T3='G04CB01') med2_recept=1.
IF  (atc2_T3='G04CB01' and med2_dosis_T3='1,25') med2_ppp=0.60.
**ATC G04CA02 - tamsulosine.
IF  (atc1_T3='G04CA02') med1_recept=1.
IF  (atc1_T3='G04CA02' and med1_dosis_T3='0,4') med1_ppp=0.04.
IF  (atc2_T3='G04CA02') med2_recept=1.
IF  (atc2_T3='G04CA02' and med2_dosis_T3='0,4') med2_ppp=0.04.
IF  (atc3_T3='G04CA02') med3_recept=1.
IF  (atc3_T3='G04CA02' and med3_dosis_T3='0,4') med3_ppp=0.04.
IF  (atc3_T3='G04CA02' and med3_dosis_T3='') med3_ppp=0.04.
IF  (atc4_T3='G04CA02') med4_recept=1.
IF  (atc4_T3='G04CA02' and med4_dosis_T3='0,4') med4_ppp=0.04.
IF  (atc5_T3='G04CA02') med5_recept=1.
IF  (atc5_T3='G04CA02' and med5_dosis_T3='0,4') med5_ppp=0.04.
IF  (atc7_T3='G04CA02') med7_recept=1.
IF  (atc7_T3='G04CA02' and med7_dosis_T3='0,4') med7_ppp=0.04.
**ATC G04BD08 .
IF  (atc1_T3='G04BD08') med1_recept=1.
IF  (atc1_T3='G04BD08' and med1_dosis_T3='') med1_ppp=0.88.
IF  (atc3_T3='G04BD08') med3_recept=1.
IF  (atc3_T3='G04BD08' and med3_dosis_T3='10') med3_ppp=1.22.
**ATC G03CX01 .
IF  (atc8_T3='G03CX01') med8_recept=1.
IF  (atc8_T3='G03CX01' and med8_dosis_T3='5') med8_ppp=1.10.
**ATC G03CA04 .
IF  (atc7_T3='G03CA04') med7_recept=1.
IF  (atc7_T3='G03CA04' and med7_dosis_T3='') med7_ppp=0.13.
IF  (atc9_T3='G03CA04') med9_recept=1.
IF  (atc9_T3='G03CA04' and med9_dosis_T3='0,5') med9_ppp=0.49.
**ATC G03AA10 .
IF  (atc1_T3='G03AA10') med1_recept=1.
IF  (atc1_T3='G03AA10' and med1_dosis_T3='') med1_ppp=0.07.
**ATC G03AA07 .
IF  (atc7_T3='G03AA07') med7_recept=1.
IF  (atc7_T3='G03AA07' and med7_dosis_T3='') med7_ppp=0.01.
**ATC G02CB03 .
IF  (atc1_T3='G02CB03') med1_recept=1.
IF  (atc1_T3='G02CB03' and med1_dosis_T3='halve van 0.5') med1_ppp=2.37.
**ATC D07XC01.
IF  (atc1_T3='D07XC01') med1_recept=1.
IF  (atc1_T3='D07XC01' and med1_dosis_T3='') med1_ppp=999.
**ATC D07AD01 .
IF  (atc3_T3='D07AD01') med3_recept=1.
IF  (atc3_T3='D07AD01' and med3_dosis_T3='') med3_ppp=999.
**ATC D07AC17 .
IF  (atc3_T3='D07AC17') med3_recept=1.
IF  (atc3_T3='D07AC17' and med3_dosis_T3='0,5') med3_ppp=999.
**ATC D07AC01 betamethason.
IF  (atc1_T3='D07AC01') med1_recept=1.
IF  (atc1_T3='D07AC01' and med1_dosis_T3='1') med1_ppp=999.
**ATC D05BB02 .
IF  (atc2_T3='D05BB02') med2_recept=1.
IF  (atc2_T3='D05BB02' and med2_dosis_T3='10') med2_ppp=0.63.
**ATC D01BA02 .
IF  (atc1_T3='D01BA02') med1_recept=1.
IF  (atc1_T3='D01BA02' and med1_dosis_T3='250') med1_ppp=0.07.
**ATC C10AX14 - .
IF  (atc8_T3='C10AX14') med8_recept=1.
IF  (atc8_T3='C10AX14' and med8_dosis_T3='75') med8_ppp=230.02.
**ATC C10AX09 - ezetimib.
IF  (atc4_T3='C10AX09') med4_recept=1.
IF  (atc4_T3='C10AX09' and med4_dosis_T3='10') med4_ppp=0.80.
IF  (atc9_T3='C10AX09') med9_recept=1.
IF  (atc9_T3='C10AX09' and med9_dosis_T3='10') med9_ppp=0.80.
IF  (atc10_T3='C10AX09') med10_recept=1.
IF  (atc10_T3='C10AX09' and med10_dosis_T3='10') med10_ppp=0.80.
**ATC C10AA07 - crestor / rosuvastatine.
IF  (atc1_T3='C10AA07') med1_recept=1.
IF  (atc1_T3='C10AA07' and med1_dosis_T3='5') med1_ppp=0.70.
IF  (atc1_T3='C10AA07' and med1_dosis_T3='20') med1_ppp=1.13.
IF  (atc1_T3='C10AA07' and med1_dosis_T3='40') med1_ppp=1.59.
IF  (atc2_T3='C10AA07') med2_recept=1.
IF  (atc2_T3='C10AA07' and med2_dosis_T3='5') med2_ppp=0.70.
IF  (atc2_T3='C10AA07' and med2_dosis_T3='40') med2_ppp=1.59.
IF  (atc3_T3='C10AA07') med3_recept=1.
IF  (atc3_T3='C10AA07' and med3_dosis_T3='5') med3_ppp=0.70.
IF  (atc3_T3='C10AA07' and med3_dosis_T3='') med3_ppp=0.70.
IF  (atc4_T3='C10AA07') med4_recept=1.
IF  (atc4_T3='C10AA07' and med4_dosis_T3='5') med4_ppp=0.70.
IF  (atc4_T3='C10AA07' and med4_dosis_T3='10') med4_ppp=0.78.
IF  (atc4_T3='C10AA07' and med4_dosis_T3='40') med4_ppp=1.59.
IF  (atc4_T3='C10AA07' and med4_dosis_T3='') med4_ppp=0.70.
IF  (atc5_T3='C10AA07') med5_recept=1.
IF  (atc5_T3='C10AA07' and med5_dosis_T3='10') med5_ppp=0.78.
IF  (atc8_T3='C10AA07') med8_recept=1.
IF  (atc8_T3='C10AA07' and med8_dosis_T3='40') med8_ppp=1.59.
**ATC C10AA05 - atorvastatine.
IF  (atc1_T3='C10AA05') med1_recept=1.
IF  (atc1_T3='C10AA05' and med1_dosis_T3='10') med1_ppp=0.02.
IF  (atc1_T3='C10AA05' and med1_dosis_T3='20') med1_ppp=0.03.
IF  (atc1_T3='C10AA05' and med1_dosis_T3='40') med1_ppp=0.05.
IF  (atc2_T3='C10AA05') med2_recept=1.
IF  (atc2_T3='C10AA05' and med2_dosis_T3='10') med2_ppp=0.02.
IF  (atc2_T3='C10AA05' and med2_dosis_T3='20') med2_ppp=0.03.
IF  (atc2_T3='C10AA05' and med2_dosis_T3='40') med2_ppp=0.05.
IF  (atc3_T3='C10AA05') med3_recept=1.
IF  (atc3_T3='C10AA05' and med3_dosis_T3='40') med3_ppp=0.05.
IF  (atc4_T3='C10AA05') med4_recept=1.
IF  (atc4_T3='C10AA05' and med4_dosis_T3='20') med4_ppp=0.03.
IF  (atc4_T3='C10AA05' and med4_dosis_T3='40') med4_ppp=0.05.
IF  (atc5_T3='C10AA05') med5_recept=1.
IF  (atc5_T3='C10AA05' and med5_dosis_T3='20') med5_ppp=0.03.
IF  (atc5_T3='C10AA05' and med5_dosis_T3='40') med5_ppp=0.05.
IF  (atc5_T3='C10AA05' and med5_dosis_T3='80') med5_ppp=0.13.
IF  (atc6_T3='C10AA05') med6_recept=1.
IF  (atc6_T3='C10AA05' and med6_dosis_T3='20') med6_ppp=0.03.
IF  (atc7_T3='C10AA05') med7_recept=1.
IF  (atc7_T3='C10AA05' and med7_dosis_T3='20') med7_ppp=0.03.
IF  (atc9_T3='C10AA05') med9_recept=1.
IF  (atc9_T3='C10AA05' and med9_dosis_T3='20') med9_ppp=0.03.
**ATC C10AA04 - fluvastatine.
IF  (atc3_T3='C10AA04') med3_recept=1.
IF  (atc3_T3='C10AA04' and med3_dosis_T3='20') med3_ppp=0.07.
**ATC C10AA03 - pravastatine.
IF  (atc4_T3='C10AA03') med4_recept=1.
IF  (atc4_T3='C10AA03' and med4_dosis_T3='') med4_ppp=0.03.
IF  (atc5_T3='C10AA03') med5_recept=1.
IF  (atc5_T3='C10AA03' and med5_dosis_T3='20') med5_ppp=0.04.
**ATC C10AA01 - simvastatine.
IF  (atc1_T3='C10AA01') med1_recept=1.
IF  (atc1_T3='C10AA01' and med1_dosis_T3='20') med1_ppp=0.02.
IF  (atc1_T3='C10AA01' and med1_dosis_T3='40') med1_ppp=0.02.
IF  (atc1_T3='C10AA01' and med1_dosis_T3='') med1_ppp=0.02.
IF  (atc2_T3='C10AA01') med2_recept=1.
IF  (atc2_T3='C10AA01' and med2_dosis_T3='') med2_ppp=0.02.
IF  (atc2_T3='C10AA01' and med2_dosis_T3='20') med2_ppp=0.02.
IF  (atc2_T3='C10AA01' and med2_dosis_T3='1.5 x 20') med2_ppp=0.03.
IF  (atc3_T3='C10AA01') med3_recept=1.
IF  (atc3_T3='C10AA01' and med3_dosis_T3='20') med3_ppp=0.02.
IF  (atc3_T3='C10AA01' and med3_dosis_T3='') med3_ppp=0.02.
IF  (atc4_T3='C10AA01') med4_recept=1.
IF  (atc4_T3='C10AA01' and med4_dosis_T3='40') med4_ppp=0.02.
IF  (atc4_T3='C10AA01' and med4_dosis_T3='10') med4_ppp=0.02.
IF  (atc5_T3='C10AA01') med5_recept=1.
IF  (atc5_T3='C10AA01' and med5_dosis_T3='40') med5_ppp=0.02.
IF  (atc6_T3='C10AA01') med6_recept=1.
IF  (atc6_T3='C10AA01' and med6_dosis_T3='40') med6_ppp=0.02.
IF  (atc6_T3='C10AA01' and med6_dosis_T3='20') med6_ppp=0.02.
IF  (atc8_T3='C10AA01') med8_recept=1.
IF  (atc8_T3='C10AA01' and med8_dosis_T3='') med8_ppp=0.02.
**ATC C09DA04 - co-aproval.
IF  (atc1_T3='C09DA04') med1_recept=1.
IF  (atc1_T3='C09DA04' and med1_dosis_T3='300/12.5') med1_ppp=0.06.
IF  (atc1_T3='C09DA04') med1_recept=1.
IF  (atc1_T3='C09DA04' and med1_dosis_T3='300/?') med1_ppp=0.05.
**ATC C09DA03 - valsartan/hydrochloorthiazide.
IF  (atc1_T3='C09DA03') med1_recept=1.
IF  (atc1_T3='C09DA03' and med1_dosis_T3='80/12.5') med1_ppp=0.02.
**ATC C09CA07 - telmisartan.
IF  (atc1_T3='C09CA07') med1_recept=1.
IF  (atc1_T3='C09CA07' and med1_dosis_T3='80') med1_ppp=0.04.
**ATC C09CA06 - candesartan.
IF  (atc1_T3='C09CA06') med1_recept=1.
IF  (atc1_T3='C09CA06' and med1_dosis_T3='4') med1_ppp=0.02.
IF  (atc1_T3='C09CA06' and med1_dosis_T3='16') med1_ppp=0.03.
IF  (atc2_T3='C09CA06') med2_recept=1.
IF  (atc2_T3='C09CA06' and med2_dosis_T3='') med2_ppp=0.02.
**ATC C09CA04 - irbesartan.
IF  (atc1_T3='C09CA04') med1_recept=1.
IF  (atc1_T3='C09CA04' and med1_dosis_T3='300') med1_ppp=0.05.
IF  (atc1_T3='C09CA04' and med1_dosis_T3='150') med1_ppp=0.03.
IF  (atc1_T3='C09CA04' and med1_dosis_T3='') med1_ppp=0.03.
IF  (atc3_T3='C09CA04') med3_recept=1.
IF  (atc3_T3='C09CA04' and med3_dosis_T3='75') med3_ppp=0.03.
IF  (atc4_T3='C09CA04') med4_recept=1.
IF  (atc4_T3='C09CA04' and med4_dosis_T3='150') med4_ppp=0.03.
IF  (atc4_T3='C09CA04' and med4_dosis_T3='300') med4_ppp=0.05.
IF  (atc5_T3='C09CA04') med5_recept=1.
IF  (atc5_T3='C09CA04' and med5_dosis_T3='150') med5_ppp=0.03.
**ATC C09CA03 - valsartan.
IF  (atc1_T3='C09CA03') med1_recept=1.
IF  (atc1_T3='C09CA03' and med1_dosis_T3='40') med1_ppp=0.04.
IF  (atc2_T3='C09CA03') med2_recept=1.
IF  (atc2_T3='C09CA03' and med2_dosis_T3='40') med2_ppp=0.04.
IF  (atc5_T3='C09CA03') med5_recept=1.
IF  (atc5_T3='C09CA03' and med5_dosis_T3='160') med5_ppp=0.04.
**ATC C09CA01 - losartan.
IF  (atc1_T3='C09CA01') med1_recept=1.
IF  (atc1_T3='C09CA01' and med1_dosis_T3='50') med1_ppp=0.01.
IF  (atc1_T3='C09CA01' and med1_dosis_T3='100') med1_ppp=0.03.
IF  (atc2_T3='C09CA01') med2_recept=1.
IF  (atc2_T3='C09CA01' and med2_dosis_T3='50') med2_ppp=0.01.
IF  (atc3_T3='C09CA01') med3_recept=1.
IF  (atc3_T3='C09CA01' and med3_dosis_T3='50') med3_ppp=0.01.
IF  (atc5_T3='C09CA01') med5_recept=1.
IF  (atc5_T3='C09CA01' and med5_dosis_T3='50') med5_ppp=0.01.
**ATC C09BA03 - .
IF  (atc2_T3='C09BA03') med2_recept=1.
IF  (atc2_T3='C09BA03' and med2_dosis_T3='20/12.5') med2_ppp=0.07.
**ATC C09AA06 - quinapril.
IF  (atc1_T3='C09AA06') med1_recept=1.
IF  (atc1_T3='C09AA06' and med1_dosis_T3='20') med1_ppp=0.11.
IF  (atc2_T3='C09AA06') med2_recept=1.
IF  (atc2_T3='C09AA06' and med2_dosis_T3='') med2_ppp=0.07.
IF  (atc2_T3='C09AA06' and med2_dosis_T3='20') med2_ppp=0.11.
IF  (atc3_T3='C09AA06') med3_recept=1.
IF  (atc3_T3='C09AA06' and med3_dosis_T3='') med3_ppp=0.07.
IF  (atc4_T3='C09AA06') med4_recept=1.
IF  (atc4_T3='C09AA06' and med4_dosis_T3='10') med4_ppp=0.08.
IF  (atc5_T3='C09AA06') med5_recept=1.
IF  (atc5_T3='C09AA06' and med5_dosis_T3='10') med5_ppp=0.08.
**ATC C09AA05- ramipril.
IF  (atc1_T3='C09AA05') med1_recept=1.
IF  (atc1_T3='C09AA05' and med1_dosis_T3='2,5') med1_ppp=0.04.
IF  (atc1_T3='C09AA05' and med1_dosis_T3='5') med1_ppp=0.04.
IF  (atc2_T3='C09AA05') med2_recept=1.
IF  (atc2_T3='C09AA05' and med2_dosis_T3='2,5') med2_ppp=0.04.
IF  (atc3_T3='C09AA05') med3_recept=1.
IF  (atc3_T3='C09AA05' and med3_dosis_T3='5') med3_ppp=0.04.
**ATC C09AA04- perindopril.
IF  (atc1_T3='C09AA04') med1_recept=1.
IF  (atc1_T3='C09AA04' and med1_dosis_T3='8') med1_ppp=0.04.
IF  (atc1_T3='C09AA04' and med1_dosis_T3='2x10') med1_ppp=0.77.
IF  (atc2_T3='C09AA04') med2_recept=1.
IF  (atc2_T3='C09AA04' and med2_dosis_T3='5') med2_ppp=0.28.
IF  (atc2_T3='C09AA04' and med2_dosis_T3='2x10') med2_ppp=0.77.
IF  (atc3_T3='C09AA04') med3_recept=1.
IF  (atc3_T3='C09AA04' and med3_dosis_T3='4') med3_ppp=0.02.
IF  (atc3_T3='C09AA04' and med3_dosis_T3='2 en 4') med3_ppp=0.04.
IF  (atc4_T3='C09AA04') med4_recept=1.
IF  (atc4_T3='C09AA04' and med4_dosis_T3='4') med4_ppp=0.02.
IF  (atc4_T3='C09AA04' and med4_dosis_T3='1,5x4') med4_ppp=0.03.
IF  (atc4_T3='C09AA04' and med4_dosis_T3='10') med4_ppp=0.39.
IF  (atc5_T3='C09AA04') med5_recept=1.
IF  (atc5_T3='C09AA04' and med5_dosis_T3='2') med5_ppp=0.02.
IF  (atc6_T3='C09AA04') med6_recept=1.
IF  (atc6_T3='C09AA04' and med6_dosis_T3='10') med6_ppp=0.39.
**ATC C09AA03- lisinopril.
IF  (atc1_T3='C09AA03') med1_recept=1.
IF  (atc1_T3='C09AA03' and med1_dosis_T3='20') med1_ppp=0.02.
IF  (atc1_T3='C09AA03' and med1_dosis_T3='10') med1_ppp=0.02.
IF  (atc2_T3='C09AA03') med2_recept=1.
IF  (atc2_T3='C09AA03' and med2_dosis_T3='') med2_ppp=0.02.
IF  (atc3_T3='C09AA03') med3_recept=1.
IF  (atc3_T3='C09AA03' and med3_dosis_T3='5') med3_ppp=0.02.
**ATC C09AA02- enalapril.
IF  (atc1_T3='C09AA02') med1_recept=1.
IF  (atc1_T3='C09AA02' and med1_dosis_T3='20') med1_ppp=0.02.
IF  (atc2_T3='C09AA02') med2_recept=1.
IF  (atc2_T3='C09AA02' and med2_dosis_T3='20') med2_ppp=0.02.
IF  (atc3_T3='C09AA02') med3_recept=1.
IF  (atc3_T3='C09AA02' and med3_dosis_T3='5') med3_ppp=0.02.
IF  (atc4_T3='C09AA02') med4_recept=1.
IF  (atc4_T3='C09AA02' and med4_dosis_T3='10') med4_ppp=0.02.
IF  (atc4_T3='C09AA02' and med4_dosis_T3='20') med4_ppp=0.02.
IF  (atc6_T3='C09AA02') med6_recept=1.
IF  (atc6_T3='C09AA02' and med6_dosis_T3='10') med6_ppp=0.02.
**ATC C08DB01- diltiazem.
IF  (atc1_T3='C08DB01') med1_recept=1.
IF  (atc1_T3='C08DB01' and med1_dosis_T3='200') med1_ppp=0.10.
IF  (atc1_T3='C08DB01' and med1_dosis_T3='') med1_ppp=0.03.
**ATC C08DA01- verapamil.
IF  (atc2_T3='C08DA01') med2_recept=1.
IF  (atc2_T3='C08DA01' and med2_dosis_T3='') med2_ppp=0.03.
IF  (atc4_T3='C08DA01') med4_recept=1.
IF  (atc4_T3='C08DA01' and med4_dosis_T3='') med4_ppp=0.03.
**ATC C08CA13- lercandipine.
IF  (atc2_T3='C08CA13') med2_recept=1.
IF  (atc2_T3='C08CA13' and med2_dosis_T3='10') med2_ppp=0.05.
**ATC C08CA12.
IF  (atc4_T3='C08CA12') med4_recept=1.
IF  (atc4_T3='C08CA12' and med4_dosis_T3='10') med4_ppp=0.69.
**ATC C08CA05- nefidipine.
IF  (atc2_T3='C08CA05') med2_recept=1.
IF  (atc2_T3='C08CA05' and med2_dosis_T3='60') med2_ppp=0.14.
IF  (atc3_T3='C08CA05') med3_recept=1.
IF  (atc3_T3='C08CA05' and med3_dosis_T3='30') med3_ppp=0.14.
IF  (atc4_T3='C08CA05') med4_recept=1.
IF  (atc4_T3='C08CA05' and med4_dosis_T3='60') med4_ppp=0.14.
IF  (atc5_T3='C08CA05') med5_recept=1.
IF  (atc5_T3='C08CA05' and med5_dosis_T3='30') med5_ppp=0.14.
**ATC C08CA01- amlodipine.
IF  (atc1_T3='C08CA01') med1_recept=1.
IF  (atc1_T3='C08CA01' and med1_dosis_T3='5') med1_ppp=0.02.
IF  (atc1_T3='C08CA01' and med1_dosis_T3='10') med1_ppp=0.02.
IF  (atc2_T3='C08CA01') med2_recept=1.
IF  (atc2_T3='C08CA01' and med2_dosis_T3='') med2_ppp=0.02.
IF  (atc2_T3='C08CA01' and med2_dosis_T3='10') med2_ppp=0.02.
IF  (atc3_T3='C08CA01') med3_recept=1.
IF  (atc3_T3='C08CA01' and med3_dosis_T3='10') med3_ppp=0.02.
IF  (atc5_T3='C08CA01') med5_recept=1.
IF  (atc5_T3='C08CA01' and med5_dosis_T3='10') med5_ppp=0.02.
IF  (atc6_T3='C08CA01') med6_recept=1.
IF  (atc6_T3='C08CA01' and med6_dosis_T3='5') med6_ppp=0.02.
**ATC C07BB02- metoprolol/HCT.
IF  (atc1_T3='C07BB02') med1_recept=1.
IF  (atc1_T3='C07BB02' and med1_dosis_T3='95/12,5') med1_ppp=0.24.
**ATC C07AB12- nebivolol.
IF  (atc4_T3='C07AB12') med4_recept=1.
IF  (atc4_T3='C07AB12' and med4_dosis_T3='halve 5') med4_ppp=0.02.
**ATC C07AB07- bisoprolol.
IF  (atc1_T3='C07AB07') med1_recept=1.
IF  (atc1_T3='C07AB07' and med1_dosis_T3='') med1_ppp=0.02.
IF  (atc2_T3='C07AB07') med2_recept=1.
IF  (atc2_T3='C07AB07' and med2_dosis_T3='') med2_ppp=0.02.
IF  (atc3_T3='C07AB07') med3_recept=1.
IF  (atc3_T3='C07AB07' and med3_dosis_T3='5') med3_ppp=0.02.
IF  (atc5_T3='C07AB07') med5_recept=1.
IF  (atc5_T3='C07AB07' and med5_dosis_T3='5') med5_ppp=0.02.
IF  (atc7_T3='C07AB07') med7_recept=1.
IF  (atc7_T3='C07AB07' and med7_dosis_T3='5') med7_ppp=0.02.
**ATC C07AB02- metoprolol.
IF  (atc1_T3='C07AB02') med1_recept=1.
IF  (atc1_T3='C07AB02' and med1_dosis_T3='') med1_ppp=0.02.
IF  (atc2_T3='C07AB02') med2_recept=1.
IF  (atc2_T3='C07AB02' and med2_dosis_T3='25') med2_ppp=0.03.
IF  (atc2_T3='C07AB02' and med2_dosis_T3='50') med2_ppp=0.02.
IF  (atc3_T3='C07AB02') med3_recept=1.
IF  (atc3_T3='C07AB02' and med3_dosis_T3='50') med3_ppp=0.02.
IF  (atc3_T3='C07AB02' and med3_dosis_T3='100') med3_ppp=0.02.
IF  (atc3_T3='C07AB02' and med3_dosis_T3='100+50') med3_ppp=0.04.
IF  (atc3_T3='C07AB02' and med3_dosis_T3='25') med3_ppp=0.03.
IF  (atc3_T3='C07AB02' and med3_dosis_T3='') med3_ppp=0.02.
IF  (atc4_T3='C07AB02') med4_recept=1.
IF  (atc4_T3='C07AB02' and med4_dosis_T3='') med4_ppp=0.02.
IF  (atc4_T3='C07AB02' and med4_dosis_T3='25') med4_ppp=0.03.
IF  (atc5_T3='C07AB02') med5_recept=1.
IF  (atc5_T3='C07AB02' and med5_dosis_T3='') med5_ppp=0.02.
**ATC C07AA07- sotalol.
IF  (atc1_T3='C07AA07') med1_recept=1.
IF  (atc1_T3='C07AA07' and med1_dosis_T3='80') med1_ppp=0.04.
IF  (atc2_T3='C07AA07') med2_recept=1.
IF  (atc2_T3='C07AA07' and med2_dosis_T3='80') med2_ppp=0.04.
IF  (atc6_T3='C07AA07') med6_recept=1.
IF  (atc6_T3='C07AA07' and med6_dosis_T3='160+40') med6_ppp=0.13.
**ATC C03DA01- .
IF  (atc2_T3='C03DA01') med2_recept=1.
IF  (atc2_T3='C03DA01' and med2_dosis_T3='halve van 25') med2_ppp=0.02.
IF  (atc5_T3='C03DA01') med5_recept=1.
IF  (atc5_T3='C03DA01' and med5_dosis_T3='25') med5_ppp=0.04.
**ATC C03CA02- furosemide.
IF  (atc3_T3='C03CA02') med3_recept=1.
IF  (atc3_T3='C03CA02' and med3_dosis_T3='') med3_ppp=0.03.
**ATC C03CA01- furosemide.
IF  (atc1_T3='C03CA01') med1_recept=1.
IF  (atc1_T3='C03CA01' and med1_dosis_T3='60') med1_ppp=0.12.
IF  (atc1_T3='C03CA01' and med1_dosis_T3='2x40') med1_ppp=0.04.
IF  (atc2_T3='C03CA01') med2_recept=1.
IF  (atc2_T3='C03CA01' and med2_dosis_T3='40') med2_ppp=0.02.
IF  (atc3_T3='C03CA01') med3_recept=1.
IF  (atc3_T3='C03CA01' and med3_dosis_T3='40') med3_ppp=0.02.
**ATC C03BA04- chloortalidon.
IF  (atc1_T3='C03BA04') med1_recept=1.
IF  (atc1_T3='C03BA04' and med1_dosis_T3='12,5') med1_ppp=0.07.
**ATC C03AA03- hydrochloorthiazide.
IF  (atc1_T3='C03AA03') med1_recept=1.
IF  (atc1_T3='C03AA03' and med1_dosis_T3='12,5') med1_ppp=0.03.
IF  (atc1_T3='C03AA03' and med1_dosis_T3='25') med1_ppp=0.02.
IF  (atc2_T3='C03AA03') med2_recept=1.
IF  (atc2_T3='C03AA03' and med2_dosis_T3='12,5') med2_ppp=0.03.
IF  (atc2_T3='C03AA03' and med2_dosis_T3='25') med2_ppp=0.02.
IF  (atc3_T3='C03AA03') med3_recept=1.
IF  (atc3_T3='C03AA03' and med3_dosis_T3='12.5') med3_ppp=0.03.
IF  (atc4_T3='C03AA03') med4_recept=1.
IF  (atc4_T3='C03AA03' and med4_dosis_T3='25') med4_ppp=0.02.
IF  (atc4_T3='C03AA03' and med4_dosis_T3='12,5') med4_ppp=0.03.
IF  (atc5_T3='C03AA03') med5_recept=1.
IF  (atc5_T3='C03AA03' and med5_dosis_T3='12.5') med5_ppp=0.03.
IF  (atc6_T3='C03AA03') med6_recept=1.
IF  (atc6_T3='C03AA03' and med6_dosis_T3='25') med6_ppp=0.02.
IF  (atc6_T3='C03AA03' and med6_dosis_T3='12,5') med6_ppp=0.03.
IF  (atc7_T3='C03AA03') med7_recept=1.
IF  (atc7_T3='C03AA03' and med7_dosis_T3='12.5') med7_ppp=0.03.
IF  (atc8_T3='C03AA03') med8_recept=1.
IF  (atc8_T3='C03AA03' and med8_dosis_T3='5') med8_ppp=5.53.
**ATC C01DA14- isosorbide mononitraat.
IF  (atc2_T3='C01DA14') med2_recept=1.
IF  (atc2_T3='C01DA14' and med2_dosis_T3='25') med2_ppp=0.24.
IF  (atc4_T3='C01DA14') med4_recept=1.
IF  (atc4_T3='C01DA14' and med4_dosis_T3='100') med4_ppp=0.96.
IF  (atc5_T3='C01DA14') med5_recept=1.
IF  (atc5_T3='C01DA14' and med5_dosis_T3='100') med5_ppp=0.96.
IF  (atc6_T3='C01DA14') med6_recept=1.
IF  (atc6_T3='C01DA14' and med6_dosis_T3='30') med6_ppp=0.29.
IF  (atc7_T3='C01DA14') med7_recept=1.
IF  (atc7_T3='C01DA14' and med7_dosis_T3='25') med7_ppp=0.24.
**ATC C01DA08- isosorbide dinitraat.
IF  (atc10_T3='C01DA08') med10_recept=1.
IF  (atc10_T3='C01DA08' and med10_dosis_T3='5') med10_ppp=0.03.
**ATC B03BB01- foliumzuur.
IF  (atc1_T3='B03BB01') med1_recept=0.
IF  (atc1_T3='B03BB01' and med1_dosis_T3='2x5') med1_ppp=0.06.
IF  (atc2_T3='B03BB01') med2_recept=0.
IF  (atc2_T3='B03BB01' and med2_dosis_T3='5') med2_ppp=0.03.
IF  (atc4_T3='B03BB01') med4_recept=0.
IF  (atc4_T3='B03BB01' and med4_dosis_T3='2x5') med4_ppp=0.06.
IF  (atc5_T3='B03BB01') med5_recept=0.
IF  (atc5_T3='B03BB01' and med5_dosis_T3='halve van 5') med5_ppp=0.02.
IF  (atc7_T3='B03BB01') med7_recept=0.
IF  (atc7_T3='B03BB01' and med7_dosis_T3='') med7_ppp=0.03.
**ATC B03BA03- vit B12 injectie.
IF  (atc2_T3='B03BA03') med2_recept=1.
IF  (atc2_T3='B03BA03' and med2_dosis_T3='2') med2_ppp=0.70.
IF  (atc3_T3='B03BA03') med3_recept=1.
IF  (atc3_T3='B03BA03' and med3_dosis_T3='2') med3_ppp=0.70.
**ATC B01AF01- .
IF  (atc3_T3='B01AF01') med3_recept=1.
IF  (atc3_T3='B01AF01' and med3_dosis_T3='20') med3_ppp=2.29.
**ATC B01AC08- ascal.(100 gr maakt niet uit of het poeder of tablet is, is even duur).
IF  (atc1_T3='B01AC08') med1_recept=1.
IF  (atc1_T3='B01AC08' and med1_dosis_T3='100') med1_ppp=0.06.
IF  (atc1_T3='B01AC08' and med1_dosis_T3='') med1_ppp=0.06.
IF  (atc2_T3='B01AC08') med2_recept=1.
IF  (atc2_T3='B01AC08' and med2_dosis_T3='100') med2_ppp=0.06.
IF  (atc2_T3='B01AC08' and med2_dosis_T3='') med2_ppp=0.06.
IF  (atc3_T3='B01AC08') med3_recept=1.
IF  (atc3_T3='B01AC08' and med3_dosis_T3='100') med3_ppp=0.06.
IF  (atc4_T3='B01AC08') med4_recept=1.
IF  (atc4_T3='B01AC08' and med4_dosis_T3='100') med4_ppp=0.06.
IF  (atc5_T3='B01AC08') med5_recept=1.
IF  (atc5_T3='B01AC08' and med5_dosis_T3='100') med5_ppp=0.06.
IF  (atc6_T3='B01AC08') med6_recept=1.
IF  (atc6_T3='B01AC08' and med6_dosis_T3='100') med6_ppp=0.06.
**ATC B01AC07- persantin .
IF  (atc1_T3='B01AC07') med1_recept=1.
IF  (atc1_T3='B01AC07' and med1_dosis_T3='200') med1_ppp=0.18.
IF  (atc3_T3='B01AC07') med3_recept=1.
IF  (atc3_T3='B01AC07' and med3_dosis_T3='200') med3_ppp=0.18.
IF  (atc4_T3='B01AC07') med4_recept=1.
IF  (atc4_T3='B01AC07' and med4_dosis_T3='200') med4_ppp=0.18.
IF  (atc5_T3='B01AC07') med5_recept=1.
IF  (atc5_T3='B01AC07' and med5_dosis_T3='400') med5_ppp=0.36.
**ATC B01AA07- acenocoumarol .
IF  (atc1_T3='B01AA07') med1_recept=1.
IF  (atc1_T3='B01AA07' and med1_dosis_T3='6x1') med1_ppp=0.11.
IF  (atc3_T3='B01AA07') med3_recept=1.
IF  (atc3_T3='B01AA07' and med3_dosis_T3='5x1') med3_ppp=0.09.
IF  (atc4_T3='B01AA07') med4_recept=1.
IF  (atc4_T3='B01AA07' and med4_dosis_T3='5x1') med4_ppp=0.09.
**ATC B01AB- trombosespuit .
IF  (atc1_T3='B01AB') med1_recept=1.
IF  (atc1_T3='B01AB' and med1_dosis_T3='') med1_ppp=1.63.
**ATC B01AC06- acetylsalisylzuur /aspirine cardio.
IF  (atc1_T3='B01AC06') med1_recept=1.
IF  (atc1_T3='B01AC06' and med1_dosis_T3='80') med1_ppp=0.03.
IF  (atc1_T3='B01AC06' and med1_dosis_T3='') med1_ppp=0.03.
IF  (atc2_T3='B01AC06') med2_recept=1.
IF  (atc2_T3='B01AC06' and med2_dosis_T3='80') med2_ppp=0.03.
IF  (atc3_T3='B01AC06') med3_recept=1.
IF  (atc3_T3='B01AC06' and med3_dosis_T3='') med3_ppp=0.03.
IF  (atc4_T3='B01AC06' ) med4_recept=1.
IF  (atc4_T3='B01AC06' and med4_dosis_T3='') med4_ppp=0.03.
IF  (atc4_T3='B01AC06' and med4_dosis_T3='80') med4_ppp=0.03.
IF  (atc6_T3='B01AC06' ) med6_recept=1.
IF  (atc6_T3='B01AC06' and med6_dosis_T3='80') med6_ppp=0.03.
IF  (atc7_T3='B01AC06' ) med7_recept=1.
IF  (atc7_T3='B01AC06' and med7_dosis_T3='80') med7_ppp=0.03.
**ATC B01AC04- clopidogrel .
IF  (atc2_T3='B01AC04') med2_recept=1.
IF  (atc2_T3='B01AC04' and med2_dosis_T3='') med2_ppp=0.04.
IF  (atc6_T3='B01AC04') med6_recept=1.
IF  (atc6_T3='B01AC04' and med6_dosis_T3='75') med6_ppp=0.04.
**ATC B01AB06-  .
IF  (atc2_T3='B01AB06') med2_recept=1.
IF  (atc2_T3='B01AB06' and med2_dosis_T3='0.3') med2_ppp=1.88.
**ATC B01AA04- fenprocoumon .
IF  (atc4_T3='B01AA04') med4_recept=1.
IF  (atc4_T3='B01AA04' and med4_dosis_T3='3') med4_ppp=0.07.
**ATC B01AA04-  .
IF  (atc2_T3='B01AA04') med2_recept=1.
IF  (atc2_T3='B01AA04' and med2_dosis_T3='3') med2_ppp=0.07.
**ATC A12BA01- Kalium.
IF  (atc3_T3='A12BA01') med3_recept=1.
IF  (atc3_T3='A12BA01' and med3_dosis_T3='') med3_ppp=0.21.
**ATC A12AA04- Calciumcarbonaat.
IF  (atc1_T3='A12AA04') med1_recept=1.
IF  (atc1_T3='A12AA04' and med1_dosis_T3='500') med1_ppp=0.13.
IF  (atc4_T3='A12AA04') med4_recept=1.
IF  (atc4_T3='A12AA04' and med4_dosis_T3='500') med4_ppp=0.13.
**ATC A11GA01 ascorbinezuur.
IF  (atc3_T3='A11GA01') med3_recept=0.
IF  (atc3_T3='A11GA01' and med3_dosis_T3='') med3_ppp=0.05.
**ATC A11CC05 colecalciferol -Vit D.
IF  (atc2_T3='A11CC05') med2_recept=1.
IF  (atc2_T3='A11CC05' and med2_dosis_T3='800') med2_ppp=0.05.
IF  (atc4_T3='A11CC05') med4_recept=1.
IF  (atc4_T3='A11CC05' and med4_dosis_T3='') med4_ppp=0.05.
IF  (atc5_T3='A11CC05') med5_recept=1.
IF  (atc5_T3='A11CC05' and med5_dosis_T3='800') med5_ppp=0.05.
**ATC A11CC03 alfacalcidol .
IF  (atc2_T3='A11CC03') med2_recept=1.
IF  (atc2_T3='A11CC03' and med2_dosis_T3='0,25') med2_ppp=0.17.
**ATC A10BD08 .
IF  (atc1_T3='A10BD08') med1_recept=1.
IF  (atc1_T3='A10BD08' and med1_dosis_T3='50/850') med1_ppp=0.74.
IF  (atc2_T3='A10BD08') med2_recept=1.
IF  (atc2_T3='A10BD08' and med2_dosis_T3='50/850') med2_ppp=0.74.
**ATC A10BB12 - glimepiride .
IF  (atc2_T3='A10BB12') med2_recept=1.
IF  (atc2_T3='A10BB12' and med2_dosis_T3='') med2_ppp=0.02.
**ATC A10BB09 - gliclazide .
IF  (atc1_T3='A10BB09') med1_recept=1.
IF  (atc1_T3='A10BB09' and med1_dosis_T3='80') med1_ppp=0.04.
IF  (atc2_T3='A10BB09') med2_recept=1.
IF  (atc2_T3='A10BB09' and med2_dosis_T3='') med2_ppp=0.04.
IF  (atc3_T3='A10BB09') med3_recept=1.
IF  (atc3_T3='A10BB09' and med3_dosis_T3='30') med3_ppp=0.04.
IF  (atc7_T3='A10BB09') med7_recept=1.
IF  (atc7_T3='A10BB09' and med7_dosis_T3='') med7_ppp=0.04.
**ATC A10BB03 - tolbutamine .
IF  (atc2_T3='A10BB03') med2_recept=1.
IF  (atc2_T3='A10BB03' and med2_dosis_T3='1000') med2_ppp=0.08.
**ATC A10BA02 - metformine.
IF  (atc1_T3='A10BA02') med1_recept=1.
IF  (atc1_T3='A10BA02' and med1_dosis_T3='500') med1_ppp=0.01.
IF  (atc1_T3='A10BA02' and med1_dosis_T3='850') med1_ppp=0.02.
IF  (atc1_T3='A10BA02' and med1_dosis_T3='1000') med1_ppp=0.03.
IF  (atc1_T3='A10BA02' and med1_dosis_T3='') med1_ppp=0.01.
IF  (atc2_T3='A10BA02') med2_recept=1.
IF  (atc2_T3='A10BA02' and med2_dosis_T3='500') med2_ppp=0.01.
IF  (atc2_T3='A10BA02' and med2_dosis_T3='850') med2_ppp=0.02.
IF  (atc2_T3='A10BA02' and med2_dosis_T3='1000') med2_ppp=0.03.
IF  (atc3_T3='A10BA02') med3_recept=1.
IF  (atc3_T3='A10BA02' and med3_dosis_T3='500') med3_ppp=0.01.
IF  (atc5_T3='A10BA02') med5_recept=1.
IF  (atc5_T3='A10BA02' and med5_dosis_T3='500') med5_ppp=0.01.
IF  (atc7_T3='A10BA02') med7_recept=1.
IF  (atc7_T3='A10BA02' and med7_dosis_T3='850') med7_ppp=0.02.
**ATC A10AE04 lantus/insuline glargine.
IF  (atc1_T3='A10AE04') med1_recept=1.
IF  (atc1_T3='A10AE04' and med1_dosis_T3='34') med1_ppp=1.02.
IF  (atc7_T3='A10AE04') med7_recept=1.
IF  (atc7_T3='A10AE04' and med7_dosis_T3='48') med7_ppp=1.44.
**ATC A10AD05 novomix.
IF  (atc1_T3='A10AD05') med1_recept=1.
IF  (atc1_T3='A10AD05' and med1_dosis_T3='50') med1_ppp=7.04.
**ATC A10AB05 insuline aspart.
IF  (atc6_T3='A10AB05') med6_recept=1.
IF  (atc6_T3='A10AB05' and med6_dosis_T3='60') med6_ppp=1.20.
**ATC A10A insuline.
IF  (atc1_T3='A10A') med1_recept=1.
IF  (atc1_T3='A10A' and med1_dosis_T3='30') med1_ppp=0.60.
**ATC A09AA02 .
IF  (atc9_T3='A09AA02') med9_recept=1.
IF  (atc9_T3='A09AA02' and med9_dosis_T3='22500/25000/1250') med9_ppp=1.07.
**ATC A07EC02  .
IF  (atc2_T3='A07EC02') med2_recept=1.
IF  (atc2_T3='A07EC02' and med2_dosis_T3='') med2_ppp=999.
**ATC A07EA06  .
IF  (atc1_T3='A07EA06') med1_recept=1.
IF  (atc1_T3='A07EA06' and med1_dosis_T3='3') med1_ppp=1.01.
**ATC A07DA03 loperamide .
IF  (atc1_T3='A07DA03') med1_recept=0.
IF  (atc1_T3='A07DA03' and med1_dosis_T3='2') med1_ppp=0.10.
IF  (atc2_T3='A07DA03') med2_recept=0.
IF  (atc2_T3='A07DA03' and med2_dosis_T3='2') med2_ppp=0.10.
**ATC A06AG11 microlax .
IF  (atc2_T3='A06AG11') med2_recept=1.
IF  (atc2_T3='A06AG11' and med2_dosis_T3='') med2_ppp=1.85.
**ATC A06AD65 macrogol/electrolyten .
IF  (atc1_T3='A06AD65') med1_recept=1.
IF  (atc1_T3='A06AD65' and med1_dosis_T3='13,7') med1_ppp=0.12.
IF  (atc5_T3='A06AD65') med5_recept=1.
IF  (atc5_T3='A06AD65' and med5_dosis_T3='13,7') med5_ppp=0.12.
**ATC A06AD11 lactulose .
IF  (atc3_T3='A06AD11') med3_recept=1.
IF  (atc3_T3='A06AD11' and med3_dosis_T3='') med3_ppp=0.19.
IF  (atc7_T3='A06AD11') med7_recept=1.
IF  (atc7_T3='A06AD11' and med7_dosis_T3='12') med7_ppp=0.29.
**ATC A06AD15 macrogol .
IF  (atc1_T3='A06AD15') med1_recept=1.
IF  (atc1_T3='A06AD15' and med1_dosis_T3='') med1_ppp=0.05.
IF  (atc3_T3='A06AD15') med3_recept=1.
IF  (atc3_T3='A06AD15' and med3_dosis_T3='10') med3_ppp=0.61.
IF  (atc5_T3='A06AD15') med5_recept=1.
IF  (atc5_T3='A06AD15' and med5_dosis_T3='13') med5_ppp=0.69.
IF  (atc7_T3='A06AD15') med7_recept=1.
IF  (atc7_T3='A06AD15' and med7_dosis_T3='2x10') med7_ppp=1.22.
**ATC A06AB02 bisacodyl .
IF  (atc1_T3='A06AB02') med1_recept=1.
IF  (atc1_T3='A06AB02' and med1_dosis_T3='5') med1_ppp=0.04.
IF  (atc2_T3='A06AB02') med2_recept=1.
IF  (atc2_T3='A06AB02' and med2_dosis_T3='5') med2_ppp=0.04.
IF  (atc5_T3='A06AB02') med5_recept=1.
IF  (atc5_T3='A06AB02' and med5_dosis_T3='5') med5_ppp=0.04.
**ATC A03FA03 domperidon .
IF  (atc1_T3='A03FA03') med1_recept=1.
IF  (atc1_T3='A03FA03' and med1_dosis_T3='halve 10') med1_ppp=0.04.
**ATC A03FA01  .
IF  (atc3_T3='A03FA01') med3_recept=1.
IF  (atc3_T3='A03FA01' and med3_dosis_T3='10' and med3_vorm_T3='zetpil') med3_ppp=0.17.
**ATC A03AA04 duspatal .
IF  (atc1_T3='A03AA04') med1_recept=1.
IF  (atc1_T3='A03AA04' and med1_dosis_T3='200') med1_ppp=0.20.
**ATC A02BX13 .
IF  (atc7_T3='A02BX13') med7_recept=1.
IF  (atc7_T3='A02BX13' and med7_dosis_T3='250') med7_ppp=0.21.
**ATC A02BC05 nexium .
IF  (atc2_T3='A02BC05') med2_recept=1.
IF  (atc2_T3='A02BC05' and med2_dosis_T3='40') med2_ppp=0.08.
IF  (atc3_T3='A02BC05') med3_recept=1.
IF  (atc3_T3='A02BC05' and med3_dosis_T3='20') med3_ppp=0.06.
**ATC A02BC02 pantoprazol .
IF  (atc1_T3='A02BC02') med1_recept=1.
IF  (atc1_T3='A02BC02' and med1_dosis_T3='20') med1_ppp=0.03.
IF  (atc1_T3='A02BC02' and med1_dosis_T3='40') med1_ppp=0.03.
IF  (atc2_T3='A02BC02') med2_recept=1.
IF  (atc2_T3='A02BC02' and med2_dosis_T3='40') med2_ppp=0.03.
IF  (atc3_T3='A02BC02') med3_recept=1.
IF  (atc3_T3='A02BC02' and med3_dosis_T3='20') med3_ppp=0.03.
IF  (atc3_T3='A02BC02' and med3_dosis_T3='40') med3_ppp=0.03.
IF  (atc4_T3='A02BC02') med4_recept=1.
IF  (atc4_T3='A02BC02' and med4_dosis_T3='') med4_ppp=0.03.
IF  (atc4_T3='A02BC02' and med4_dosis_T3='20') med4_ppp=0.03.
IF  (atc4_T3='A02BC02' and med4_dosis_T3='2x40') med4_ppp=0.06.
IF  (atc5_T3='A02BC02') med5_recept=1.
IF  (atc5_T3='A02BC02' and med5_dosis_T3='') med5_ppp=0.03.
IF  (atc6_T3='A02BC02') med6_recept=1.
IF  (atc6_T3='A02BC02' and med6_dosis_T3='') med6_ppp=0.03.
IF  (atc8_T3='A02BC02') med8_recept=1.
IF  (atc8_T3='A02BC02' and med8_dosis_T3='') med8_ppp=0.03.
**ATC A02BC01 omeprazol .
IF  (atc1_T3='A02BC01') med1_recept=1.
IF  (atc1_T3='A02BC01' and med1_dosis_T3='10') med1_ppp=0.02.
IF  (atc1_T3='A02BC01' and med1_dosis_T3='20') med1_ppp=0.02.
IF  (atc1_T3='A02BC01' and med1_dosis_T3='40') med1_ppp=0.03.
IF  (atc1_T3='A02BC01' and med1_dosis_T3='') med1_ppp=0.02.
IF  (atc2_T3='A02BC01') med2_recept=1.
IF  (atc2_T3='A02BC01' and med2_dosis_T3='20') med2_ppp=0.02.
IF  (atc2_T3='A02BC01' and med2_dosis_T3='40') med2_ppp=0.03.
IF  (atc2_T3='A02BC01' and med2_dosis_T3='') med2_ppp=0.02.
IF  (atc3_T3='A02BC01') med3_recept=1.
IF  (atc3_T3='A02BC01' and med3_dosis_T3='20') med3_ppp=0.02.
IF  (atc3_T3='A02BC01' and med3_dosis_T3='40') med3_ppp=0.03.
IF  (atc4_T3='A02BC01') med4_recept=1.
IF  (atc4_T3='A02BC01' and med4_dosis_T3='20') med4_ppp=0.02.
IF  (atc4_T3='A02BC01' and med4_dosis_T3='40') med4_ppp=0.03.
IF  (atc6_T3='A02BC01') med6_recept=1.
IF  (atc6_T3='A02BC01' and med6_dosis_T3='40') med6_ppp=0.03.
IF  (atc6_T3='A02BC01' and med6_dosis_T3='') med6_ppp=0.02.
IF  (atc8_T3='A02BC01') med8_recept=1.
IF  (atc8_T3='A02BC01' and med8_dosis_T3='40') med8_ppp=0.03.
**ATC A02BA02 ranitidine .
IF  (atc1_T3='A02BA02') med1_recept=1.
IF  (atc1_T3='A02BA02' and med1_dosis_T3='300') med1_ppp=0.03.
IF  (atc2_T3='A02BA02') med2_recept=1.
IF  (atc2_T3='A02BA02' and med2_dosis_T3='300') med2_ppp=0.03.
**ATC A02AD01 rennie .
IF  (atc2_T3='A02AD01') med2_recept=0.
IF  (atc2_T3='A02AD01' and med2_dosis_T3='680/80') med2_ppp=0.12.
IF  (atc3_T3='A02AD01') med3_recept=0.
IF  (atc3_T3='A02AD01' and med3_dosis_T3='') med3_ppp=0.12.
IF  (atc4_T3='A02AD01') med4_recept=0.
IF  (atc4_T3='A02AD01' and med4_dosis_T3='') med4_ppp=0.12.
IF  (atc5_T3='A02AD01') med5_recept=0.
IF  (atc5_T3='A02AD01' and med5_dosis_T3='') med5_ppp=0.12.
EXECUTE.

**** Geen volledige ATC********************************************

*** ATC A02 - maagbeschermers.(goedkoopste=2 cent, 40 mg = 3 cent).
IF (atc1_T3='A02') med1_recept=1.
IF (atc1_T3='A02' and med1_dosis_T3='') med1_ppp=0.02.
IF (atc1_T3='A02' and med1_dosis_T3='40') med1_ppp=0.03.

IF (atc2_T3='A02') med2_recept=1.
IF (atc2_T3='A02' and med2_dosis_T3='') med2_ppp=0.02.
IF (atc3_T3='A02') med3_recept=1.
IF (atc3_T3='A02' and med3_dosis_T3='') med3_ppp=0.02.
IF (atc4_T3='A02') med4_recept=1.
IF (atc4_T3='A02' and med4_dosis_T3='') med4_ppp=0.02.

*** ATC B01 - bloedverdunners.
*100 mg is waarschijnlijk carbasalaatcalcium of acetylsalisylzuur (beide 0.06).
* 80 mg is waarschijnlijk acetylsalicylzuur (0.03)
* goedkoopste 0.03.
IF  (atc1_T3='B01') med1_recept=1.
IF  (atc1_T3='B01' and med1_dosis_T3='80') med1_ppp=0.03.
IF  (atc1_T3='B01' and med1_dosis_T3='') med1_ppp=0.03.
IF  (atc2_T3='B01') med2_recept=1.
IF  (atc2_T3='B01' and med2_dosis_T3='') med2_ppp=0.03.
IF  (atc3_T3='B01') med3_recept=1.
IF  (atc3_T3='B01' and med3_dosis_T3='') med3_ppp=0.03.
IF  (atc4_T3='B01') med4_recept=1.
IF  (atc4_T3='B01' and med4_dosis_T3='') med4_ppp=0.03.
IF  (atc5_T3='B01') med5_recept=1.
IF  (atc5_T3='B01' and med5_dosis_T3='') med5_ppp=0.03.

*** ATC C02 - bloeddrukverlagers.
IF  (atc1_T3='C02') med1_recept=1.
IF  (atc1_T3='C02' and med1_dosis_T3='100') med1_ppp=0.02.
IF  (atc1_T3='C02' and med1_dosis_T3='75') med1_ppp=0.03.
IF  (atc1_T3='C02' and med1_dosis_T3='105') med1_ppp=0.02.
IF  (atc1_T3='C02' and med1_dosis_T3='200') med1_ppp=0.02.
IF  (atc1_T3='C02' and med1_dosis_T3='160') med1_ppp=0.02.
IF  (atc1_T3='C02' and med1_dosis_T3='') med1_ppp=0.02.
IF  (atc2_T3='C02') med2_recept=1.
IF  (atc2_T3='C02' and med2_dosis_T3='') med2_ppp=0.02.
IF  (atc3_T3='C02') med3_recept=1.
IF  (atc3_T3='C02' and med3_dosis_T3='') med3_ppp=0.02.
IF  (atc5_T3='C02') med5_recept=1.
IF  (atc5_T3='C02' and med5_dosis_T3='') med5_ppp=0.02.

*** ATC C03 - plaspil.
IF  (atc3_T3='C03') med3_recept=1.
IF  (atc3_T3='C03' and med3_dosis_T3='') med3_ppp=0.02.
IF  (atc5_T3='C03') med5_recept=1.
IF  (atc5_T3='C03' and med5_dosis_T3='') med5_ppp=0.02.

*** ATC C07 - betablokkers.
IF  (atc1_T3='C07') med1_recept=1.
IF  (atc1_T3='C07' and med1_dosis_T3='') med1_ppp=0.02.
IF  (atc2_T3='C07') med2_recept=1.
IF  (atc2_T3='C07' and med2_dosis_T3='') med2_ppp=0.02.

*** ATC C10 cholesterolverlagers
goedkoopste=simvastatine in 10,20 of 40 mg, allen 2 cent.
*5 mg is rosuvastatiene: 0.70.
IF  (atc1_T3='C10') med1_recept=1.
IF  (atc1_T3='C10' and med1_dosis_T3='') med1_ppp=0.02.
IF  (atc2_T3='C10') med2_recept=1.
IF  (atc2_T3='C10' and med2_dosis_T3='') med2_ppp=0.02.
IF  (atc3_T3='C10') med3_recept=1.
IF  (atc3_T3='C10' and med3_dosis_T3='') med3_ppp=0.02.
IF  (atc4_T3='C10') med4_recept=1.
IF  (atc4_T3='C10' and med4_dosis_T3='5') med4_ppp=0.70.
IF  (atc4_T3='C10' and med4_dosis_T3='') med4_ppp=0.02.

** hart.
IF  (Med6_T3='hart') med6_recept=1.
IF  (Med6_T3='hart') med6_ppp=0.02.

*** ATC H03 - schildklier. 
*Is meestal levothyroxine, goedkoopste 0.02.
IF  (atc1_T3='H03') med1_recept=1.
IF  (atc1_T3='H03' and med1_dosis_T3='') med1_ppp=0.02.
IF  (atc2_T3='H03') med2_recept=1.
IF  (atc2_T3='H03' and med2_dosis_T3='') med2_ppp=0.02.

**ATC J01 - antibiotica zonder specificatie.
IF  (atc1_T3='J01') med1_recept=1.
IF  (atc1_T3='J01' and med1_dosis_T3='') med1_ppp=0.06.
IF  (atc2_T3='J01') med2_recept=1.
IF  (atc2_T3='J01' and med2_dosis_T3='') med2_ppp=0.06.
IF  (atc3_T3='J01') med3_recept=1.
IF  (atc3_T3='J01' and med3_dosis_T3='') med3_ppp=0.06.
IF  (atc4_T3='J01') med4_recept=1.
IF  (atc4_T3='J01' and med4_dosis_T3='') med4_ppp=0.06.

** ATC M01 - ontstekingsremmers.
IF  (atc2_T3='M01') med2_recept=1.
IF  (atc2_T3='M01' and med2_dosis_T3='') med2_ppp=0.02.
IF  (atc4_T3='M01') med4_recept=1.
IF  (atc4_T3='M01' and med4_dosis_T3='') med4_ppp=0.02.

*** ATC N02 - pijnstiller.
IF  (atc1_T3='N02') med1_recept=0.
IF  (atc1_T3='N02' and med1_dosis_T3='') med1_ppp=0.02.
IF  (atc2_T3='N02') med2_recept=0.
IF  (atc2_T3='N02' and med2_dosis_T3='') med2_ppp=0.02.

*** ATC N06 - antidepressiva.
IF  (atc1_T3='N06') med1_recept=1.
IF  (atc1_T3='N06' and med1_dosis_T3='') med1_ppp=0.02.
IF  (atc2_T3='N06') med2_recept=1.
IF  (atc2_T3='N06' and med2_dosis_T3='') med2_ppp=0.02.

*** ATC R03 - pufjes.
*Goedkoopste in ons bestand is salbutamol, 0.05 per dosis. Dit aanhouden.
IF  (atc1_T3='R03') med1_recept=1.
IF  (atc1_T3='R03' and med1_dosis_T3='') med1_ppp=0.05.
IF  (atc2_T3='R03') med2_recept=1.
IF  (atc2_T3='R03' and med2_dosis_T3='') med2_ppp=0.05.
IF  (atc5_T3='R03') med5_recept=1.
IF  (atc5_T3='R03' and med5_dosis_T3='') med5_ppp=0.05.
IF  (atc8_T3='R03') med8_recept=1.
IF  (atc8_T3='R03' and med8_dosis_T3='') med8_ppp=0.05.

**ATC V01 -allergiepil. Conservatieve schatting.
IF  (atc1_T3='V01') med1_recept=1.
IF  (atc1_T3='V01') med1_ppp=0.01.
IF  (atc2_T3='V01') med2_recept=1.
IF  (atc2_T3='V01')  med2_ppp=0.01.
IF  (atc4_T3='V01') med4_recept=1.
IF  (atc4_T3='V01') med4_ppp=0.01.
IF  (atc5_T3='V01') med5_recept=1.
IF  (atc5_T3='V01') med5_ppp=0.01.

** voor suikerziekte: onbekend medicijn--> 1 cent.
IF  (ID_code=3109) med1_recept=1.
IF  (ID_code=3109) med1_ppp=0.01.
EXECUTE.

** ocipine: onbekend medicijn--> 1 cent.
IF  (med4_T3='Ocipine') med4_recept=0.
IF  (med4_T3='Ocipine') med4_ppp=0.01.
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
DO IF (atc1_T3='V01AA02').
RECODE med1_aantdagen_T3 (SYSMIS=90).
END IF.
DO IF (atc1_T3='R05CB01').
RECODE med1_aantdagen_T3 (SYSMS=1).
END IF.
DO IF (atc1_T3='R03AK06').
RECODE med1_aantdagen_T3 (SYSMIS=90).
END IF.
DO IF (atc1_T3='R03AC13').
RECODE med1_aantdagen_T3 (SYSMIS=90).
END IF.
DO IF (atc1_T3='R03AC02').
RECODE med1_aantdagen_T3 (SYSMIS=90).
END IF.
DO IF (atc1_T3='N06AX12').
RECODE med1_aantdagen_T3 (SYSMIS=90).
END IF.
DO IF (atc1_T3='N06AB06').
RECODE med1_aantdagen_T3 (SYSMIS=90).
END IF.
** op T2 90 dagen.
DO IF (ID_code=1910).
RECODE med1_aantdagen_T3 (SYSMIS=90).
END IF.
DO IF (atc1_T3='N05BA04').
RECODE med1_aantdagen_T3 (SYSMIS=1).
RECODE med1_keerperdag_T3 (SYSMIS=1).
END IF.
DO IF (atc1_T3='N05AX08').
RECODE med1_aantdagen_T3 (SYSMIS=90).
END IF.
DO IF (atc1_T3='N05AH04').
RECODE med1_aantdagen_T3 (SYSMIS=90).
END IF.
DO IF (atc1_T3='N04BC04').
RECODE med1_aantdagen_T3 (SYSMIS=90).
END IF.
* Op T2 2xdaags, alle dagen.
DO IF (atc1_T3='N03AX11').
RECODE med1_aantdagen_T3 (SYSMIS=90).
RECODE med1_keerperdag_T3 (SYSMIS=2).
END IF.
DO IF (atc1_T3='N02BE01').
RECODE med1_keerperdag_T3 (SYSMIS=1).
RECODE med1_aantdagen_T3 (SYSMIS=1).
END IF.
DO IF (atc1_T3='N02AA01').
RECODE med1_aantdagen_T3 (SYSMIS=1).
END IF.
DO IF (atc1_T3='M01AE01').
RECODE med1_aantdagen_T3 (SYSMIS=1).
END IF.
DO IF (atc1_T3='M01AB05').
RECODE med1_aantdagen_T3 (SYSMIS=1).
END IF.
DO IF (atc1_T3='L02BG03').
RECODE med1_aantdagen_T3 (SYSMIS=90).
END IF.
DO IF (atc1_T3='J01').
RECODE med1_aantdagen_T3 (SYSMIS=5).
END IF.
DO IF (atc1_T3='H03AA01').
RECODE med1_aantdagen_T3 (SYSMIS=90).
END IF.
DO IF (atc1_T3='H03').
RECODE med1_aantdagen_T3 (SYSMIS=90).
END IF.
* Is meestal stootkuur van minimaal 5 dagen 5 dagen aanhouden.
DO IF (atc1_T3='H02AB07').
RECODE med1_aantdagen_T3 (SYSMIS=5).
END IF.
DO IF (atc1_T3='G02CB03').
RECODE med1_aantdagen_T3 (SYSMIS=90).
END IF.
DO IF (atc1_T3='C10AA07').
RECODE med1_aantdagen_T3 (SYSMIS=90).
END IF.
DO IF (atc1_T3='C10AA01').
RECODE med1_aantdagen_T3 (SYSMIS=90).
END IF.
DO IF (atc1_T3='C02').
RECODE med1_aantdagen_T3 (SYSMIS=90).
END IF.
DO IF (atc1_T3='C10').
RECODE med1_aantdagen_T3 (SYSMIS=90).
END IF.
DO IF (atc1_T3='C09DA04').
RECODE med1_aantdagen_T3 (SYSMIS=90).
END IF.
DO IF (atc1_T3='C09AA05').
RECODE med1_aantdagen_T3 (SYSMIS=90).
END IF.
DO IF (atc1_T3='C09AA03').
RECODE med1_aantdagen_T3 (SYSMIS=90).
END IF.
DO IF (atc1_T3='C09AA02').
RECODE med1_aantdagen_T3 (SYSMIS=90).
END IF.
DO IF (atc1_T3='C08CA01').
RECODE med1_aantdagen_T3 (SYSMIS=90).
END IF.
DO IF (atc1_T3='C07AA07').
RECODE med1_aantdagen_T3 (SYSMIS=90).
END IF.
DO IF (atc1_T3='C03CA01').
RECODE med1_aantdagen_T3 (SYSMIS=90).
END IF.
DO IF (atc1_T3='C03AA03').
RECODE med1_aantdagen_T3 (SYSMIS=90).
END IF.
DO IF (atc1_T3='B01AC08').
RECODE med1_aantdagen_T3 (SYSMIS=90).
END IF.
DO IF (atc1_T3='B01AC06').
RECODE med1_keerperdag_T3 (SYSMIS=1).
END IF.
DO IF (atc1_T3='B01').
RECODE med1_aantdagen_T3 (SYSMIS=90).
END IF.
DO IF (atc1_T3='A12AA04').
RECODE med1_aantdagen_T3 (SYSMIS=90).
END IF.
DO IF (atc1_T3='A10BA02').
RECODE med1_aantdagen_T3 (SYSMIS=90).
END IF.
DO IF (atc1_T3='A10AE04').
RECODE med1_aantdagen_T3 (SYSMIS=90).
END IF.
DO IF (atc1_T3='A02BC02').
RECODE med1_aantdagen_T3 (SYSMIS=90).
END IF.
DO IF (atc1_T3='A02BC01').
RECODE med1_aantdagen_T3 (SYSMIS=90).
END IF.
**T2: 15 dagen, T1 10 dagen, T0 20 dagen.--> conservatieve schatting 10 dagen.
DO IF (atc1_T3='A02BA02').
RECODE med1_aantdagen_T3 (SYSMIS=10).
END IF.
DO IF (atc1_T3='A02').
RECODE med1_aantdagen_T3 (SYSMIS=90).
RECODE med1_keerperdag_T3 (SYSMIS=1).
END IF.
* serotide 0.1 per dag. Op T2 1d, waarsch tikfout hier ook 1d.
DO IF (ID_code=3218).
RECODE med1_keerperdag_T3 (0.1=1).
END IF.
DO IF  (ID_code=3109).
RECODE med1_aantdagen_T3 (SYSMIS=90).
END IF.


DO IF (atc2_T3='C10').
RECODE med2_aantdagen_T3 (SYSMIS=90).
RECODE med2_keerperdag_T3 (SYSMIS=1).
END IF.
DO IF (atc2_T3='R06AX27').
RECODE med2_aantdagen_T3 (SYSMIS=90).
END IF.
DO IF (atc2_T3='R03BB01').
RECODE med2_keerperdag_T3 (SYSMIS=1).
END IF.
DO IF (atc2_T3='R03AC02').
RECODE med2_aantdagen_T3 (SYSMIS=90).
END IF.
DO IF (atc2_T3='R01AD05').
RECODE med2_aantdagen_T3 (SYSMIS=90).
END IF.
DO IF (atc2_T3='N06AB10').
RECODE med2_aantdagen_T3 (SYSMIS=90).
END IF.
DO IF (atc2_T3='N06AB05').
RECODE med2_aantdagen_T3 (SYSMIS=90).
END IF.
DO IF (atc2_T3='N06AB04').
RECODE med2_aantdagen_T3 (SYSMIS=90).
END IF.
DO IF (atc2_T3='N06AB03').
RECODE med2_aantdagen_T3 (SYSMIS=90).
END IF.
DO IF (atc2_T3='N06AA09').
RECODE med2_aantdagen_T3 (SYSMIS=90).
END IF.
DO IF (atc2_T3='N05CH01').
RECODE med2_aantdagen_T3 (SYSMIS=90).
END IF.
DO IF (atc2_T3='N06AB05').
RECODE med2_aantdagen_T3 (SYSMIS=90).
END IF.
DO IF (atc2_T3='N02BE01').
RECODE med2_aantdagen_T3 (SYSMIS=1).
END IF.
DO IF (atc2_T3='N02AX02').
RECODE med2_aantdagen_T3 (SYSMIS=1).
END IF.
DO IF (atc2_T3='M05BA04').
RECODE med2_aantdagen_T3 (SYSMIS=90).
END IF.
DO IF (atc2_T3='M01AE01').
RECODE med2_aantdagen_T3 (SYSMIS=1).
END IF.
DO IF (atc2_T3='M01AB05').
RECODE med2_aantdagen_T3 (SYSMIS=1).
END IF.
DO IF (atc2_T3='L04AD02').
RECODE med2_aantdagen_T3 (SYSMIS=90).
END IF.
DO IF (atc2_T3='H03AA01').
RECODE med2_aantdagen_T3 (SYSMIS=90).
END IF.
DO IF (atc2_T3='H03').
RECODE med2_aantdagen_T3 (SYSMIS=90).
END IF.
DO IF (atc2_T3='C10AA05').
RECODE med2_aantdagen_T3 (SYSMIS=90).
END IF.
DO IF (atc2_T3='C10AA01').
RECODE med2_aantdagen_T3 (SYSMIS=90).
END IF.
DO IF (atc2_T3='C09CA06').
RECODE med2_aantdagen_T3 (SYSMIS=90).
RECODE med2_keerperdag_T3 (SYSMIS=1).
END IF.
DO IF (atc2_T3='C09CA03').
RECODE med2_aantdagen_T3 (SYSMIS=90).
END IF.
DO IF (atc2_T3='C09CA01').
RECODE med2_aantdagen_T3 (SYSMIS=90).
END IF.
DO IF (atc2_T3='C09AA05').
RECODE med2_aantdagen_T3 (SYSMIS=90).
END IF.
DO IF (atc2_T3='C09AA04').
RECODE med2_aantdagen_T3 (SYSMIS=90).
END IF.
DO IF (atc2_T3='C09AA03').
RECODE med2_aantdagen_T3 (SYSMIS=90).
END IF.
DO IF (atc2_T3='C03AA03').
RECODE med2_aantdagen_T3 (SYSMIS=90).
END IF.
DO IF (atc2_T3='C02').
RECODE med2_aantdagen_T3 (SYSMIS=90).
END IF.
DO IF (atc2_T3='B03BA03').
RECODE med2_aantdagen_T3 (SYSMIS=1).
END IF.
DO IF (atc2_T3='B01AC08').
RECODE med2_aantdagen_T3 (SYSMIS=90).
END IF.
DO IF (atc2_T3='B01AB06').
RECODE med2_aantdagen_T3 (SYSMIS=1).
END IF.
DO IF (atc2_T3='A11CC05').
RECODE med2_aantdagen_T3 (SYSMIS=90).
END IF.
DO IF (atc2_T3='A10BB09').
RECODE med2_aantdagen_T3 (SYSMIS=90).
END IF.
DO IF (atc2_T3='A10BB12').
RECODE med2_aantdagen_T3 (SYSMIS=90).
END IF.
DO IF (atc2_T3='A10BA02').
RECODE med2_aantdagen_T3 (SYSMIS=90).
END IF.
DO IF (atc2_T3='A06AB02').
RECODE med2_aantdagen_T3 (SYSMIS=1).
END IF.
DO IF (atc2_T3='A02BC02').
RECODE med2_aantdagen_T3 (SYSMIS=90).
END IF.

DO IF (atc3_T3='R06AX27').
RECODE med3_aantdagen_T3 (SYSMIS=90).
END IF.
DO IF (atc3_T3='N05BA04').
RECODE med3_aantdagen_T3 (SYSMIS=1).
END IF.
DO IF (atc3_T3='N02CC06').
RECODE med3_keerperdag_T3 (SYSMIS=1).
RECODE med3_aantdagen_T3 (SYSMIS=1).
END IF.
DO IF (atc3_T3='N02BE01').
RECODE med3_keerperdag_T3 (SYSMIS=1).
RECODE med3_aantdagen_T3 (SYSMIS=1).
END IF.
DO IF (atc3_T3='M01AE02').
RECODE med3_aantdagen_T3 (SYSMIS=1).
END IF.
DO IF (atc3_T3='M01AE01').
RECODE med3_aantdagen_T3 (SYSMIS=1).
END IF.
DO IF (atc3_T3='G04BD08').
RECODE med3_aantdagen_T3 (SYSMIS=90).
END IF.
DO IF (atc3_T3='C10').
RECODE med3_aantdagen_T3 (SYSMIS=90).
END IF.
DO IF (atc3_T3='C09CA01').
RECODE med3_aantdagen_T3 (SYSMIS=90).
END IF.
DO IF (atc3_T3='C09AA04').
RECODE med3_aantdagen_T3 (SYSMIS=90).
END IF.
DO IF (atc3_T3='C09AA02').
RECODE med3_aantdagen_T3 (SYSMIS=90).
END IF.
DO IF (atc3_T3='C07AB07').
RECODE med3_aantdagen_T3 (SYSMIS=90).
END IF.
DO IF (atc3_T3='C07AB02').
RECODE med3_aantdagen_T3 (SYSMIS=90).
END IF.
DO IF (atc3_T3='C03CA01').
RECODE med3_aantdagen_T3 (SYSMIS=90).
END IF.
DO IF (atc3_T3='C03AA03').
RECODE med3_aantdagen_T3 (SYSMIS=90).
END IF.
DO IF (atc3_T3='A02BC05').
RECODE med3_aantdagen_T3 (SYSMIS=90).
END IF.
DO IF (atc3_T3='A02BC01').
RECODE med3_aantdagen_T3 (SYSMIS=90).
END IF.
DO IF (atc3_T3='A02').
RECODE med3_aantdagen_T3 (SYSMIS=90).
END IF.

DO IF (atc4_T3='V01').
RECODE med4_aantdagen_T3 (SYSMIS=1).
END IF.
DO IF (atc4_T3='R06AX27').
RECODE med4_aantdagen_T3 (SYSMIS=90).
END IF.
DO IF (atc4_T3='N03AE01').
RECODE med4_aantdagen_T3 (SYSMIS=90).
END IF.
DO IF (atc4_T3='N02BE01').
RECODE med4_aantdagen_T3 (SYSMIS=1).
RECODE med4_keerperdag_T3 (SYSMIS=1).
END IF.
DO IF (atc4_T3='N02AX02').
RECODE med4_aantdagen_T3 (SYSMIS=1).
END IF.
DO IF (atc4_T3='N02AA05').
RECODE med4_aantdagen_T3 (SYSMIS=1).
END IF.
DO IF (atc4_T3='C10AA07').
RECODE med4_aantdagen_T3 (SYSMIS=90).
END IF.
DO IF (atc4_T3='C10AA05').
RECODE med4_aantdagen_T3 (SYSMIS=90).
END IF.
DO IF (atc4_T3='C10AA01').
RECODE med4_aantdagen_T3 (SYSMIS=90).
END IF.
DO IF (atc4_T3='B01AA07').
RECODE med4_aantdagen_T3 (SYSMIS=90).
END IF.
DO IF (atc4_T3='A12AA04').
RECODE med4_aantdagen_T3 (SYSMIS=90).
END IF.
DO IF (atc4_T3='A11CC05').
RECODE med4_aantdagen_T3 (SYSMIS=90).
END IF.
DO IF (atc4_T3='A02BC02').
RECODE med4_aantdagen_T3 (SYSMIS=90).
END IF.

DO IF (atc5_T3='R06AE07').
RECODE med5_aantdagen_T3 (SYSMIS=90).
END IF.
DO IF (atc5_T3='N05BA01').
RECODE med5_aantdagen_T3 (SYSMIS=1).
END IF.
DO IF (atc5_T3='J01AA02').
RECODE med5_aantdagen_T3 (SYSMIS=5).
END IF.
DO IF (atc5_T3='C10AA07').
RECODE med5_aantdagen_T3 (SYSMIS=90).
END IF.
DO IF (atc5_T3='B01AC08').
RECODE med5_aantdagen_T3 (SYSMIS=90).
END IF.
DO IF (atc5_T3='A10BA02').
RECODE med5_aantdagen_T3 (SYSMIS=90).
END IF.
DO IF (atc5_T3='A02AD01').
RECODE med5_aantdagen_T3 (SYSMIS=1).
END IF.

DO IF (atc6_T3='M01AE01').
RECODE med6_keerperdag_T3 (SYSMIS=1).
RECODE med6_aantdagen_T3 (SYSMIS=1).
END IF.
DO IF (atc6_T3='B01AC08').
RECODE med6_aantdagen_T3 (SYSMIS=90).
END IF.
EXECUTE.

DO IF (atc7_T3='N02BE01').
RECODE med7_keerperdag_T3 (SYSMIS=1).
RECODE med7_aantdagen_T3 (SYSMIS=1).
END IF.
DO IF (atc7_T3='B03BB01').
RECODE med7_aantdagen_T3 (SYSMIS=90).
END IF.
EXECUTE.

DO IF (atc8_T3='R03').
RECODE med8_aantdagen_T3 (SYSMIS=90).
END IF.
EXECUTE.
DO IF (atc8_T3='N02BE01').
RECODE med8_keerperdag_T3 (SYSMIS=1).
RECODE med8_aantdagen_T3 (SYSMIS=1).
END IF.
EXECUTE.

DO IF (atc9_T3='R03BB01').
RECODE med9_keerperdag_T3 (SYSMIS=1).
RECODE med9_aantdagen_T3 (SYSMIS=90).
END IF.
EXECUTE.



COMPUTE med1_tot_aant_T3=med1_keerperdag_T3 * med1_aantdagen_T3.
COMPUTE med2_tot_aant_T3=med2_keerperdag_T3 * med2_aantdagen_T3.
COMPUTE med3_tot_aant_T3=med3_keerperdag_T3 * med3_aantdagen_T3.
COMPUTE med4_tot_aant_T3=med4_keerperdag_T3 * med4_aantdagen_T3.
COMPUTE med5_tot_aant_T3=med5_keerperdag_T3 * med5_aantdagen_T3.
COMPUTE med6_tot_aant_T3=med6_keerperdag_T3 * med6_aantdagen_T3.
COMPUTE med7_tot_aant_T3=med7_keerperdag_T3 * med7_aantdagen_T3.
COMPUTE med8_tot_aant_T3=med8_keerperdag_T3 * med8_aantdagen_T3.
COMPUTE med9_tot_aant_T3=med9_keerperdag_T3 * med9_aantdagen_T3.
COMPUTE med10_tot_aant_T3=med10_keerperdag_T3 * med10_aantdagen_T3.
EXECUTE.

FORMATS  med1_tot_aant_T3  med2_tot_aant_T3  med3_tot_aant_T3   
med4_tot_aant_T3 med5_tot_aant_T3 med6_tot_aant_T3 med7_tot_aant_T3 med8_tot_aant_T3 med9_tot_aant_T3 med10_tot_aant_T3 (F4.0).
VARIABLE LEVEL med1_tot_aant_T3  med2_tot_aant_T3  med3_tot_aant_T3   
med4_tot_aant_T3 med5_tot_aant_T3 med6_tot_aant_T3 med7_tot_aant_T3 med8_tot_aant_T3 med9_tot_aant_T3 med10_tot_aant_T3  (SCALE).
VARIABLE WIDTH med1_tot_aant_T3  med2_tot_aant_T3  med3_tot_aant_T3   
med4_tot_aant_T3 med5_tot_aant_T3 med6_tot_aant_T3 med7_tot_aant_T3 med8_tot_aant_T3 med9_tot_aant_T3 med10_tot_aant_T3 (6).

******************************************************************************************************************************************************************************************.
** Totale kosten per medicijn.
******************************************************************************************************************************************************************************************.

*Med 1
* niet op recept.
DO IF med1_recept=0.
COMPUTE med1_tot_kosten_T3 = med1_tot_aant_T3 * med1_ppp.
END IF.
* chronisch op  recept.
DO IF med1_recept=1.
COMPUTE med1_tot_kosten_T3 = (med1_tot_aant_T3 * med1_ppp)+7.
END IF.
* niet chronisch op recept (antibiotica).
DO IF (CHAR.INDEX(atc1_T3,'J01')>0).
COMPUTE med1_tot_kosten_T3 = (med1_tot_aant_T3 * med1_ppp)+14.
END IF.
EXECUTE.

*Med 2
* niet op recept.
DO IF med2_recept=0.
COMPUTE med2_tot_kosten_T3 = med2_tot_aant_T3 * med2_ppp.
END IF.
* chronisch op  recept.
DO IF med2_recept=1.
COMPUTE med2_tot_kosten_T3 = (med2_tot_aant_T3 * med2_ppp)+7.
END IF.
* niet chronisch op recept (antibiotica).
DO IF (CHAR.INDEX(atc2_T3,'J01')>0).
COMPUTE med2_tot_kosten_T3 = (med2_tot_aant_T3 * med2_ppp)+14.
END IF.
EXECUTE.

*Med 3
* niet op recept.
DO IF med3_recept=0.
COMPUTE med3_tot_kosten_T3 = med3_tot_aant_T3 * med3_ppp.
END IF.
* chronisch op  recept.
DO IF med3_recept=1.
COMPUTE med3_tot_kosten_T3 = (med3_tot_aant_T3 * med3_ppp)+7.
END IF.
* niet chronisch op recept (antibiotica).
DO IF (CHAR.INDEX(atc3_T3,'J01')>0).
COMPUTE med3_tot_kosten_T3 = (med3_tot_aant_T3 * med3_ppp)+14.
END IF.
EXECUTE.

*Med 4
* niet op recept.
DO IF med4_recept=0.
COMPUTE med4_tot_kosten_T3 = med4_tot_aant_T3 * med4_ppp.
END IF.
* chronisch op  recept.
DO IF med4_recept=1.
COMPUTE med4_tot_kosten_T3 = (med4_tot_aant_T3 * med4_ppp)+7.
END IF.
* niet chronisch op recept (antibiotica).
DO IF (CHAR.INDEX(atc4_T3,'J01')>0).
COMPUTE med4_tot_kosten_T3 = (med4_tot_aant_T3 * med4_ppp)+14.
END IF.
EXECUTE.

*Med 5
* niet op recept.
DO IF med5_recept=0.
COMPUTE med5_tot_kosten_T3 = med5_tot_aant_T3 * med5_ppp.
END IF.
* chronisch op  recept.
DO IF med5_recept=1.
COMPUTE med5_tot_kosten_T3 = (med5_tot_aant_T3 * med5_ppp)+7.
END IF.
* niet chronisch op recept (antibiotica).
DO IF (CHAR.INDEX(atc5_T3,'J01')>0).
COMPUTE med5_tot_kosten_T3 = (med5_tot_aant_T3 * med5_ppp)+14.
END IF.
EXECUTE.

*Med 6
* niet op recept.
DO IF med6_recept=0.
COMPUTE med6_tot_kosten_T3 = med6_tot_aant_T3 * med6_ppp.
END IF.
* chronisch op  recept.
DO IF med6_recept=1.
COMPUTE med6_tot_kosten_T3 = (med6_tot_aant_T3 * med6_ppp)+7.
END IF.
* niet chronisch op recept (antibiotica).
DO IF (CHAR.INDEX(atc6_T3,'J01')>0).
COMPUTE med6_tot_kosten_T3 = (med6_tot_aant_T3 * med6_ppp)+14.
END IF.
EXECUTE.

*Med 7
* niet op recept.
DO IF med7_recept=0.
COMPUTE med7_tot_kosten_T3 = med7_tot_aant_T3 * med7_ppp.
END IF.
* chronisch op  recept.
DO IF med7_recept=1.
COMPUTE med7_tot_kosten_T3 = (med7_tot_aant_T3 * med7_ppp)+7.
END IF.
* niet chronisch op recept (antibiotica).
DO IF (CHAR.INDEX(atc7_T3,'J01')>0).
COMPUTE med7_tot_kosten_T3 = (med7_tot_aant_T3 * med7_ppp)+14.
END IF.
EXECUTE.

*Med 8
* niet op recept.
DO IF med8_recept=0.
COMPUTE med8_tot_kosten_T3 = med8_tot_aant_T3 * med8_ppp.
END IF.
* chronisch op  recept.
DO IF med8_recept=1.
COMPUTE med8_tot_kosten_T3 = (med8_tot_aant_T3 * med8_ppp)+7.
END IF.
* niet chronisch op recept (antibiotica).
DO IF (CHAR.INDEX(atc8_T3,'J01')>0).
COMPUTE med8_tot_kosten_T3 = (med8_tot_aant_T3 * med8_ppp)+14.
END IF.
EXECUTE.

*Med 9
* niet op recept.
DO IF med9_recept=0.
COMPUTE med9_tot_kosten_T3 = med9_tot_aant_T3 * med9_ppp.
END IF.
* chronisch op  recept.
DO IF med9_recept=1.
COMPUTE med9_tot_kosten_T3 = (med9_tot_aant_T3 * med9_ppp)+7.
END IF.
* niet chronisch op recept (antibiotica).
DO IF (CHAR.INDEX(atc9_T3,'J01')>0).
COMPUTE med9_tot_kosten_T3 = (med9_tot_aant_T3 * med9_ppp)+14.
END IF.
EXECUTE.

*Med 10
* niet op recept.
DO IF med10_recept=0.
COMPUTE med10_tot_kosten_T3 = med10_tot_aant_T3 * med10_ppp.
END IF.
* chronisch op  recept.
DO IF med10_recept=1.
COMPUTE med10_tot_kosten_T3 = (med10_tot_aant_T3 * med10_ppp)+7.
END IF.
* niet chronisch op recept (antibiotica).
DO IF (CHAR.INDEX(atc10_T3,'J01')>0).
COMPUTE med10_tot_kosten_T3 = (med10_tot_aant_T3 * med10_ppp)+14.
END IF.
EXECUTE.

** stoppen met roken medicatie wordt appart berekend: Bij totale med prijs=0.
** Champix N07BA03 en Zyban N06AX12.

DO IF (atc1_T3='N07BA03' or atc1_T3='N06AX12').
COMPUTE med1_tot_kosten_T3=0.
COMPUTE med1_roken_kosten_T3= (med1_tot_aant_T3 * med1_ppp)+14.
END IF.
DO IF (atc2_T3='N07BA03' or atc2_T3='N06AX12').
COMPUTE med2_tot_kosten_T3 =0.
COMPUTE med2_roken_kosten_T3= (med2_tot_aant_T3 * med2_ppp)+14.
END IF.
DO IF (atc3_T3='N07BA03' or atc3_T3='N06AX12').
COMPUTE med3_tot_kosten_T3 =0.
COMPUTE med3_roken_kosten_T3= (med3_tot_aant_T3 * med3_ppp)+14.
END IF.
DO IF (atc4_T3='N07BA03' or atc4_T3='N06AX12').
COMPUTE med4_tot_kosten_T3 = 0.
COMPUTE med4_roken_kosten_T3= (med4_tot_aant_T3 * med4_ppp)+14.
END IF.
DO IF (atc5_T3='N07BA03' or atc5_T3='N06AX12').
COMPUTE med5_tot_kosten_T3 = 0.
COMPUTE med5_roken_kosten_T3= (med5_tot_aant_T3 * med5_ppp)+14.
END IF.
DO IF (atc6_T3='N07BA03' or atc6_T3='N06AX12').
COMPUTE med6_tot_kosten_T3 = 0.
COMPUTE med6_roken_kosten_T3= (med6_tot_aant_T3 * med6_ppp)+14.
END IF.
DO IF (atc7_T3='N07BA03' or atc7_T3='N06AX12').
COMPUTE med7_tot_kosten_T3 = 0.
COMPUTE med7_roken_kosten_T3= (med7_tot_aant_T3 * med7_ppp)+14.
END IF.
DO IF (atc8_T3='N07BA03' or atc8_T3='N06AX12').
COMPUTE med8_tot_kosten_T3 = 0.
COMPUTE med8_roken_kosten_T3= (med8_tot_aant_T3 * med8_ppp)+14.
END IF.
DO IF (atc9_T3='N07BA03' or atc9_T3='N06AX12').
COMPUTE med9_tot_kosten_T3 = 0.
COMPUTE med9_roken_kosten_T3= (med9_tot_aant_T3 * med9_ppp)+14.
END IF.
DO IF (atc10_T3='N07BA03' or atc10_T3='N06AX12').
COMPUTE med10_tot_kosten_T3 = 0.
COMPUTE med10_roken_kosten_T3= (med10_tot_aant_T3 * med10_ppp)+14.
END IF.
EXECUTE.


*** Invullen totale kosten voor medicijnen waar dit niet berekend kon worden. Bij totaal zit ook al dan niet afleverkosten.

DO IF (atc1_T3='S01AA01').
RECODE med1_tot_kosten_T3 (SYSMIS=10.52).
RECODE med1_recept (SYSMIS=1).
END IF.
DO IF (atc1_T3='R01AX06').
RECODE med1_tot_kosten_T3 (SYSMIS=50.78).
END IF.
DO IF (atc1_T3='A11').
RECODE med1_tot_kosten_T3 (SYSMIS=3.50).
RECODE med1_recept (SYSMIS=0).
END IF.
DO IF (ID_code=4704).
RECODE med1_tot_kosten_T3 (SYSMIS=50.20).
RECODE med1_recept (SYSMIS=1).
END IF.
DO IF (med1_T3='Hoestdrank').
RECODE med1_tot_kosten_T3 (SYSMIS=3.39).
RECODE med1_recept (SYSMIS=0).
END IF.
EXECUTE.
DO IF (med1_T3='kalktabletten').
RECODE med1_tot_kosten_T3 (SYSMIS=2.79).
RECODE med1_recept (SYSMIS=0).
END IF.
EXECUTE.
DO IF (atc1_T3='L04AB02').
RECODE med1_tot_kosten_T3 (SYSMIS=545.39).
RECODE med1_recept (SYSMIS=1).
END IF.
EXECUTE.
DO IF (med1_T3='Neusspray').
RECODE med1_tot_kosten_T3 (SYSMIS=2.69).
RECODE med1_recept (SYSMIS=0).
END IF.
DO IF (med1_T3='Diprosalic').
RECODE med1_tot_kosten_T3 (SYSMIS=9.06).
END IF.
DO IF (atc1_T3='D07AC01' and med1_vorm_T3 ='vloeistof').
RECODE med1_tot_kosten_T3 (SYSMIS=8.32).
END IF.

DO IF (med2_T3='overgangstabletten kruidvat').
RECODE med2_tot_kosten_T3 (SYSMIS=7.99).
RECODE med2_recept (SYSMIS=0).
END IF.
DO IF (med2_T3='Zalf').
RECODE med2_tot_kosten_T3 (SYSMIS=4.05).
RECODE med2_recept (SYSMIS=0).
END IF.
DO IF (med2_T3='Neusspray').
RECODE med2_tot_kosten_T3 (SYSMIS=2.69).
RECODE med2_recept (SYSMIS=0).
END IF.

DO IF (med3_T3='cranberry capsules').
RECODE med3_tot_kosten_T3 (SYSMIS=8.99).
RECODE med3_recept (SYSMIS=0).
END IF.
DO IF (atc3_T3='A10BJ02').
RECODE med3_tot_kosten_T3 (SYSMIS=203.95).
RECODE med3_recept (SYSMIS=1).
END IF.
DO IF (atc3_T3='A11').
RECODE med3_tot_kosten_T3 (SYSMIS=2.19).
RECODE med3_recept (SYSMIS=0).
END IF.
DO IF (med3_T3='Neusspray').
RECODE med3_tot_kosten_T3 (SYSMIS=2.69).
RECODE med3_recept (SYSMIS=0).
END IF.
EXECUTE.
DO IF (med3_T3='Vit D').
RECODE med3_tot_kosten_T3 (SYSMIS=2.50).
RECODE med3_recept (SYSMIS=0).
END IF.
DO IF (med3_T3='anti conceptie').
RECODE med3_tot_kosten_T3 (SYSMIS=13.30).
RECODE med3_recept (SYSMIS=1).
END IF.
DO IF (med3_T3='Calcium').
RECODE med3_tot_kosten_T3 (SYSMIS=2.79).
RECODE med3_recept (SYSMIS=0).
END IF.
DO IF (med2_T3='Nasumel').
RECODE med2_tot_kosten_T3 (SYSMIS=14.80).
RECODE med2_recept (SYSMIS=0).
END IF.

DO IF (atc3_T3='S02AA10').
RECODE med3_tot_kosten_T3 (SYSMIS=7.24).
RECODE med3_recept (SYSMIS=1).
END IF.
DO IF (atc3_T3='S01BA04').
RECODE med3_tot_kosten_T3 (SYSMIS=7.82).
RECODE med3_recept (SYSMIS=1).
END IF.
DO IF (med3_T3='Neusdruppels').
RECODE med3_tot_kosten_T3 (SYSMIS=2.69).
RECODE med3_recept (SYSMIS=0).
END IF.
EXECUTE.



DO IF (atc4_T3='G03').
RECODE med4_tot_kosten_T3 (SYSMIS=13.30).
RECODE med4_recept (SYSMIS=1).
END IF.
DO IF (atc4_T3='A11CC').
RECODE med4_tot_kosten_T3 (SYSMIS=2.50).
RECODE med4_recept (SYSMIS=0).
END IF.
DO IF (atc4_T3='A11').
RECODE med4_tot_kosten_T3 (SYSMIS=3.50).
RECODE med4_recept (SYSMIS=0).
END IF.
DO IF (med4_T3='neusspray').
RECODE med4_tot_kosten_T3 (SYSMIS=2.69).
RECODE med4_recept (SYSMIS=0).
END IF.
EXECUTE.
DO IF (med4_T3='granufink femina').
RECODE med4_tot_kosten_T3 (SYSMIS=29.99).
RECODE med4_recept (SYSMIS=0).
END IF.
EXECUTE.
DO IF (med4_T3='triple kuur').
RECODE med4_tot_kosten_T3 (SYSMIS=9.72).
RECODE med4_recept (SYSMIS=1).
END IF.
EXECUTE.

DO IF (med5_T3='rennies').
RECODE med5_tot_kosten_T3 (SYSMIS=3.29).
RECODE med5_recept (SYSMIS=0).
END IF.
DO IF (med5_T3='A-z vitamine').
RECODE med5_tot_kosten_T3 (SYSMIS=3.50).
RECODE med5_recept (SYSMIS=0).
END IF.
EXECUTE.

DO IF (med6_T3='wls forte').
RECODE med6_tot_kosten_T3 (SYSMIS=29.85).
RECODE med6_recept (SYSMIS=0).
END IF.
EXECUTE.
DO IF (med6_T3='De pil').
RECODE med6_tot_kosten_T3 (SYSMIS=13.30).
RECODE med6_recept (SYSMIS=1).
END IF.
EXECUTE.

DO IF (med7_T3='Vitamine B-conmplex').
RECODE med7_tot_kosten_T3 (SYSMIS=4.99).
RECODE med7_recept (SYSMIS=0).
END IF.
DO IF (med7_T3='vitamine D').
RECODE med7_tot_kosten_T3 (SYSMIS=2.50).
RECODE med7_recept (SYSMIS=0).
END IF.

DO IF (med8_T3='hoestdrank').
RECODE med8_tot_kosten_T3 (SYSMIS=3.39).
RECODE med8_recept (SYSMIS=0).
END IF.
EXECUTE.

DO IF (med9_T3='extra vitamienen').
RECODE med9_tot_kosten_T3 (SYSMIS=3.50).
RECODE med9_recept (SYSMIS=0).
END IF.
EXECUTE.

*******************************************************************************************************************
** totaalkosten medicatie**
*******************************************************************************************************************.


COMPUTE kosten_med_tot_T3=SUM(med1_tot_kosten_T3,med2_tot_kosten_T3,med3_tot_kosten_T3, med4_tot_kosten_T3,
  med5_tot_kosten_T3,med6_tot_kosten_T3,med7_tot_kosten_T3,med8_tot_kosten_T3, med9_tot_kosten_T3,med10_tot_kosten_T3).
EXECUTE.

COMPUTE kosten_med_roken_T3=SUM(med1_roken_kosten_T3,  med2_roken_kosten_T3, med3_roken_kosten_T3, med4_roken_kosten_T3,
 med5_roken_kosten_T3,  med6_roken_kosten_T3,  med7_roken_kosten_T3,  med8_roken_kosten_T3,  med9_roken_kosten_T3,  med10_roken_kosten_T3).
EXECUTE.


*Indien Medicatie=missing.
DO IF MISSING(medicatie_T3)=1.
RECODE kosten_med_tot_T3 kosten_med_roken_T3 (SYSMIS=99999).
END IF.
EXECUTE.
* Indien alleen andere mediciatie en geen stoppen met roken medicatie.
DO IF kosten_med_tot_T3>0.
RECODE kosten_med_roken_T3 (SYSMIS=0).
END IF.
EXECUTE.
*Indien Medicatie=ja, maar geen medicijnen ingevuld: kosten = missing.
DO IF medicatie_T3=2.
RECODE kosten_med_tot_T3 kosten_med_roken_T3 (SYSMIS=99999).
END IF.
EXECUTE.
* Indien geen medicatie: kosten=0.
DO IF medicatie_T3=1.
RECODE kosten_med_tot_T3 kosten_med_roken_T3 (SYSMIS=0).
END IF.
EXECUTE.
* Indien de verkorte papieren vragenlijst is ingevuld, is er alleen naar stoppen met roken medicatie gevraagd--> gewone medicatie is missing.
DO IF papier_T3=2.
RECODE kosten_med_tot_T3 (0=99999).
END IF.
EXECUTE.


MISSING VALUES kosten_med_tot_T3  kosten_med_roken_T3 (99999).
VARIABLE WIDTH kosten_med_tot_T3  kosten_med_roken_T3 (8).

DELETE VARIABLES med1_tot_kosten_T3 med2_tot_kosten_T3 med3_tot_kosten_T3 med4_tot_kosten_T3
 med5_tot_kosten_T3 med6_tot_kosten_T3 med7_tot_kosten_T3 med8_tot_kosten_T3 med9_tot_kosten_T3 med10_tot_kosten_T3
 med1_roken_kosten_T3  med2_roken_kosten_T3 med3_roken_kosten_T3 med4_roken_kosten_T3
 med5_roken_kosten_T3 med6_roken_kosten_T3 med7_roken_kosten_T3 med8_roken_kosten_T3 med9_roken_kosten_T3  med10_roken_kosten_T3.

