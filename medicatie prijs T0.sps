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
MISSING VALUES med1_ppp med2_ppp med3_ppp med4_ppp med5_ppp med6_ppp med7_ppp med8_ppp med9_ppp med10_ppp (999).

**ATC V03AE01.
IF  (atc6_T0='V03AE01') med6_recept=0.
IF  (atc6_T0='V03AE01' and med6_dosis_T0='15') med6_ppp=0.67.

**ATC S01BA04.
IF  (atc3_T0='S01BA04') med3_recept=1.
IF  (atc3_T0='S01BA04' and med3_dosis_T0='') med3_ppp=$SYSMIS.
**ATC R06AX27 - Aereus.
IF  (atc2_T0='R06AX27') med2_recept=1.
IF  (atc2_T0='R06AX27' and med2_dosis_T0='') med2_ppp=0.03.
IF  (atc2_T0='R06AX27' and med2_dosis_T0='5') med2_ppp=0.03.
IF  (atc3_T0='R06AX27') med3_recept=1.
IF  (atc3_T0='R06AX27' and med3_dosis_T0='5') med3_ppp=0.03.
IF  (atc4_T0='R06AX27') med4_recept=1.
IF  (atc4_T0='R06AX27' and med4_dosis_T0='2,5') med4_ppp=0.25.
**ATC R06AX25 - Mizolastine.
IF  (atc9_T0='R06AX25') med9_recept=1.
IF  (atc9_T0='R06AX25' and med9_dosis_T0='10') med9_ppp=0.29.
**ATC R06AE07.
IF  (atc1_T0='R06AE07') med1_recept=0.
IF  (atc1_T0='R06AE07' and med1_dosis_T0='10') med1_ppp=0.18.
**ATC R05DA04 codeine.
IF  (atc2_T0='R05DA04') med2_recept=1.
IF  (atc2_T0='R05DA04' and med2_dosis_T0='') med2_ppp=0.21.
**ATC R03DC03 .
IF  (atc4_T0='R03DC03') med4_recept=1.
IF  (atc4_T0='R03DC03' and med4_dosis_T0='10') med4_ppp=0.04.
**ATC R03BB04 -Spiriva.
IF  (atc1_T0='R03BB04') med1_recept=1.
IF  (atc1_T0='R03BB04' and med1_dosis_T0='18') med1_ppp=1.34.
IF  (atc2_T0='R03BB04') med2_recept=1.
IF  (atc2_T0='R03BB04' and med2_dosis_T0='2x2,5 vloeistof') med2_ppp=1.14.
IF  (atc2_T0='R03BB04' and med2_dosis_T0='18') med2_ppp=1.34.
IF  (atc6_T0='R03BB04') med6_recept=1.
IF  (atc6_T0='R03BB04' and med6_dosis_T0='18') med6_ppp=1.34.
**ATC R03BB01.
IF  (atc3_T0='R03BB01') med3_recept=1.
IF  (atc3_T0='R03BB01' and Id_code=2512) med3_keerperdag_T0=2.
IF  (atc3_T0='R03BB01' and med3_dosis_T0=' ') med3_ppp=0.03.
**ATC R03BA05 flixotide.
IF  (atc2_T0='R03BA05') med2_recept=1.
IF  (atc2_T0='R03BA05' and med2_dosis_T0=' ') med2_ppp=0.07.
IF  (atc3_T0='R03BA05') med3_recept=1.
IF  (atc3_T0='R03BA05' and med3_dosis_T0=' ') med3_ppp=0.07.
IF  (atc3_T0='R03BA05' and med3_dosis_T0='250') med3_ppp=0.27.
IF  (atc5_T0='R03BA05') med5_recept=1.
IF  (atc5_T0='R03BA05' and med5_dosis_T0='100') med5_ppp=0.15.
**ATC R03BA02- pulmicort.
IF  (atc1_T0='R03BA02') med1_recept=1.
IF  (atc1_T0='R03BA02' and med1_dosis_T0='100') med1_ppp=0.07.
IF  (atc2_T0='R03BA02') med2_recept=1.
IF  (atc2_T0='R03BA02' and med2_dosis_T0='') med2_ppp=0.07.
IF  (atc8_T0='R03BA02') med8_recept=1.
IF  (atc8_T0='R03BA02' and med8_dosis_T0='200 (poeder)') med8_ppp=0.09.
**ATC R03BA01- beclomethason.
IF  (atc1_T0='R03BA01') med1_recept=1.
IF  (atc1_T0='R03BA01' and med1_dosis_T0='100') med1_ppp=0.07.
IF  (atc2_T0='R03BA01') med2_recept=1.
IF  (atc2_T0='R03BA01' and med2_dosis_T0=' ') med2_ppp=0.03.
IF  (atc2_T0='R03BA01' and med2_dosis_T0='50') med2_ppp=0.03.
IF  (atc3_T0='R03BA01') med3_recept=1.
IF  (atc3_T0='R03BA01' and med3_dosis_T0=' ') med3_ppp=0.03.
IF  (atc3_T0='R03BA01' and med3_dosis_T0='50') med3_ppp=0.03.
IF  (atc8_T0='R03BA01') med8_recept=1.
IF  (atc8_T0='R03BA01' and med8_dosis_T0='200 (poeder)') med8_ppp=0.10.
**ATC R03AK10.
IF  (atc2_T0='R03AK10') med2_recept=1.
IF  (atc2_T0='R03AK10' and med2_dosis_T0='92/22') med2_ppp=1.07.
IF  (atc6_T0='R03AK10') med6_recept=1.
IF  (atc6_T0='R03AK10' and med6_dosis_T0='') med6_ppp=1.07.
**ATC R03AK07 symbicort (poeder en inhalator is hetzelfde).
IF  (atc1_T0='R03AK07') med1_recept=1.
IF  (atc1_T0='R03AK07' and med1_dosis_T0='400/12') med1_ppp=0.66.
IF  (atc1_T0='R03AK07' and med1_dosis_T0='100/6') med1_ppp=0.34.
IF  (atc2_T0='R03AK07') med2_recept=1.
IF  (atc2_T0='R03AK07' and med2_dosis_T0=' ') med2_ppp=0.32.
**ATC R03AK06 seretide.
IF  (atc1_T0='R03AK06') med1_recept=1.
IF  (atc1_T0='R03AK06' and med1_dosis_T0='50/250') med1_ppp=0.59.
IF  (atc1_T0='R03AK06' and med1_dosis_T0='50/?') med1_ppp=0.41.
IF  (atc2_T0='R03AK06') med2_recept=1.
IF  (atc2_T0='R03AK06' and med2_dosis_T0=' ') med2_ppp=0.41.
IF  (atc2_T0='R03AK06' and med2_dosis_T0='250/?') med2_ppp=0.59.
IF  (atc3_T0='R03AK06') med3_recept=1.
IF  (atc3_T0='R03AK06' and med3_dosis_T0=' ') med3_ppp=0.41.
IF  (atc5_T0='R03AK06') med5_recept=1.
IF  (atc5_T0='R03AK06' and med5_dosis_T0='25/250') med5_ppp=0.27.
**ATC R03AC13 - formoterol.
IF  (atc1_T0='R03AC13') med1_recept=1.
IF  (atc1_T0='R03AC13' and med1_dosis_T0='12') med1_ppp=0.23.
**ATC R03AC12- salmeterol.
IF  (atc5_T0='R03AC12') med5_recept=1.
IF  (atc5_T0='R03AC12' and med5_dosis_T0='25') med5_ppp=0.23.
**ATC R03AC03.
IF  (atc3_T0='R03AC03') med3_recept=1.
IF  (atc3_T0='R03AC03' and med3_dosis_T0='500') med3_ppp=0.07.
**ATC R03AC02 - ventolin/salbutamol.
IF  (atc1_T0='R03AC02') med1_recept=1.
IF  (atc1_T0='R03AC02' and med1_dosering_T0='3 per dag') med1_keerperdag_T0=3.
IF  (atc1_T0='R03AC02' and med1_dosis_T0='200') med1_ppp=0.05.
IF  (atc1_T0='R03AC02' and med1_dosis_T0='') med1_ppp=0.02.
IF  (atc2_T0='R03AC02') med2_recept=1.
IF  (atc2_T0='R03AC02' and med2_dosis_T0='') med2_ppp=0.02.
IF  (atc2_T0='R03AC02' and med2_dosis_T0='200') med2_ppp=0.05.
IF  (atc2_T0='R03AC02' and med2_dosis_T0='100') med2_ppp=0.02.
IF  (atc2_T0='R03AC02' and med2_dosis_T0='5 (vloeistof)') med2_ppp=0.17.
IF  (atc3_T0='R03AC02') med3_recept=1.
IF  (atc3_T0='R03AC02' and med3_dosis_T0='') med3_ppp=0.02.
IF  (atc4_T0='R03AC02') med4_recept=1.
IF  (atc4_T0='R03AC02' and med4_dosis_T0='200') med4_ppp=0.05.
IF  (atc5_T0='R03AC02') med5_recept=1.
IF  (atc5_T0='R03AC02' and med5_dosis_T0='') med5_ppp=0.02.
**ATC R01AD12.
IF  (atc1_T0='R01AD12') med1_recept=1.
IF  (atc1_T0='R01AD12' and med1_dosis_T0='27.5') med1_ppp=0.07.
IF  (atc7_T0='R01AD12') med7_recept=1.
IF  (atc7_T0='R01AD12' and med7_dosis_T0='27.5') med7_ppp=0.07.
**ATC R01AD08- fluticason.
IF  (atc5_T0='R01AD08') med5_recept=1.
IF  (atc5_T0='R01AD08' and med5_dosis_T0='100') med5_ppp=0.01.
**ATC R01AD05- budesonide.
IF  (atc4_T0='R01AD05') med4_recept=1.
IF  (atc4_T0='R01AD05' and med4_dosis_T0='100 (spray)') med4_ppp=0.03.
**ATC P01BB51- malaria.
IF  (atc7_T0='P01BB51') med7_recept=1.
IF  (atc7_T0='P01BB51' and med7_dosis_T0='250/100') med7_ppp=2.23.
**ATC P01AB01.
IF  (atc1_T0='P01AB01') med1_recept=1.
IF  (atc1_T0='P01AB01' and med1_dosis_T0='500') med1_ppp=0.22.
**ATC N07XX09.
IF  (atc7_T0='N07XX09') med7_recept=1.
IF  (atc7_T0='N07XX09' and med7_dosis_T0='240') med7_ppp=2.30.
**ATC N07BC02 - metahdon.
IF  (atc6_T0='N07BC02') med6_recept=1.
IF  (atc6_T0='N07BC02' and med6_dosis_T0='0,8' and Med6_vorm_T0='drank') med6_ppp=1.32.
**ATC N07BA03 Champix.
IF  (atc1_T0='N07BA03') med1_recept=1.
IF  (atc1_T0='N07BA03' and med1_dosis_T0='1') med1_ppp=1.71.
IF  (atc2_T0='N07BA03') med2_recept=1.
IF  (atc2_T0='N07BA03' and med2_dosis_T0='') med2_ppp=1.71.
**ATC N06BA04 ritalin.
IF  (atc3_T0='N06BA04') med3_recept=1.
IF  (atc3_T0='N06BA04' and med3_dosis_T0='10') med3_ppp=0.05.
IF  (atc3_T0='N06BA04' and med3_dosis_T0='30') med3_ppp=0.45.
IF  (atc4_T0='N06BA04') med4_recept=1.
IF  (atc4_T0='N06BA04' and med4_dosis_T0='27') med4_ppp=1.14.
IF  (atc7_T0='N06BA04') med7_recept=1.
IF  (atc7_T0='N06BA04' and med7_dosis_T0='10') med7_ppp=0.05.
**ATC N06AX21.
IF  (atc1_T0='N06AX21') med1_recept=1.
IF  (atc1_T0='N06AX21' and med1_dosis_T0='30') med1_ppp=0.08.
**ATC N06AX16- venlafaxine.
IF  (atc1_T0='N06AX16') med1_recept=1.
IF  (atc1_T0='N06AX16' and med1_dosis_T0='75') med1_ppp=0.04.
IF  (atc1_T0='N06AX16' and med1_dosis_T0='150') med1_ppp=0.06.
IF  (atc2_T0='N06AX16') med2_recept=1.
IF  (atc2_T0='N06AX16' and med2_dosis_T0='150') med2_ppp=0.06.
**ATC N06AX12.
IF  (atc1_T0='N06AX12') med1_recept=1.
IF  (atc1_T0='N06AX12' and med1_dosis_T0='100') med1_ppp=0.66.
**ATC N06AB10.
IF  (atc1_T0='N06AB10') med1_recept=1.
IF  (atc1_T0='N06AB10' and med1_dosis_T0='10') med1_ppp=0.03.
IF  (atc4_T0='N06AB10') med4_recept=1.
IF  (atc4_T0='N06AB10' and med4_dosis_T0='10') med4_ppp=0.03.
**ATC N06AB04.
IF  (atc3_T0='N06AB04') med3_recept=1.
IF  (atc3_T0='N06AB04' and med3_dosis_T0='10') med3_ppp=0.05.
IF  (atc7_T0='N06AB04') med7_recept=1.
IF  (atc7_T0='N06AB04' and med7_dosis_T0='10') med7_ppp=0.05.
**ATC N06AB06.
IF  (atc1_T0='N06AB06') med1_recept=1.
IF  (atc1_T0='N06AB06' and med1_dosis_T0='50') med1_ppp=0.04.
IF  (atc2_T0='N06AB06') med2_recept=1.
IF  (atc2_T0='N06AB06' and med2_dosis_T0='100') med2_ppp=0.10.
IF  (atc2_T0='N06AB06' and med2_dosis_T0='50') med2_ppp=0.04.
**ATC N06AB05.
IF  (atc1_T0='N06AB05') med1_recept=1.
IF  (atc1_T0='N06AB05' and med1_dosis_T0='10') med1_ppp=0.15.
IF  (atc1_T0='N06AB05' and med1_dosis_T0='20') med1_ppp=0.03.
IF  (atc1_T0='N06AB05' and med1_dosis_T0='2,5x20') med1_ppp=0.08.
IF  (atc2_T0='N06AB05') med2_recept=1.
IF  (atc2_T0='N06AB05' and med2_dosis_T0='10') med2_ppp=0.15.
IF  (atc2_T0='N06AB05' and med2_dosis_T0='20') med2_ppp=0.03.
IF  (atc2_T0='N06AB05' and med2_dosis_T0='30') med2_ppp=0.04.
IF  (atc2_T0='N06AB05' and med2_dosis_T0='') med2_ppp=0.03.
**ATC N06AB03.
IF  (atc5_T0='N06AB03') med5_recept=1.
IF  (atc5_T0='N06AB03' and med5_dosis_T0='2x20') med5_ppp=0.06.
**ATC N06AA10.
IF  (atc1_T0='N06AA10') med1_recept=1.
IF  (atc1_T0='N06AA10' and med1_dosis_T0='') med1_ppp=0.08.
**ATC N06AA09.
IF  (atc1_T0='N06AA09') med1_recept=1.
IF  (atc1_T0='N06AA09' and med1_dosis_T0='25') med1_ppp=0.03.
IF  (atc4_T0='N06AA09') med4_recept=1.
IF  (atc4_T0='N06AA09' and med4_dosis_T0='25') med4_ppp=0.03.
**ATC N06AA04.
IF  (atc1_T0='N06AA04') med1_recept=1.
IF  (atc1_T0='N06AA04' and med1_dosis_T0='75') med1_ppp=0.11.
**ATC N05CM09.
IF  (atc1_T0='N05CM09') med1_recept=0.
IF  (atc1_T0='N05CM09' and med1_dosis_T0='450') med1_ppp=0.37.
**ATC N05CH01.
IF  (atc1_T0='N05CH01') med1_recept=0.
IF  (atc1_T0='N05CH01' and med1_dosis_T0='0.5') med1_ppp=0.27.
**ATC N05CF01 - zoplicon.
IF  (atc3_T0='N05CF01') med3_recept=1.
IF  (atc3_T0='N05CF01' and med3_dosis_T0='7.5') med3_ppp=0.04.
**ATC N05CD07 - temazepam.
IF  (atc2_T0='N05CD07') med2_recept=1.
IF  (atc2_T0='N05CD07' and med2_dosis_T0='10') med2_ppp=0.05.
IF  (atc4_T0='N05CD07') med4_recept=1.
IF  (atc4_T0='N05CD07' and med4_dosis_T0='10') med4_ppp=0.05.
**ATC N05BB01.
IF  (atc1_T0='N05BB01') med1_recept=1.
IF  (atc1_T0='N05BB01' and med1_dosis_T0='25') med1_ppp=0.08.
**ATC N05BA06 - lorazepam.
IF  (atc2_T0='N05BA06') med2_recept=1.
IF  (atc2_T0='N05BA06' and med2_dosis_T0='0,5') med2_ppp=0.23.
IF  (atc5_T0='N05BA06') med5_recept=1.
IF  (atc5_T0='N05BA06' and med5_dosis_T0='1') med5_ppp=0.05.
**ATC N05BA04 - oxazepam.
IF  (atc1_T0='N05BA04') med1_recept=1.
IF  (atc1_T0='N05BA04' and med1_dosis_T0='10') med1_ppp=0.02.
IF  (atc3_T0='N05BA04') med3_recept=1.
IF  (atc3_T0='N05BA04' and med3_dosis_T0='10') med3_ppp=0.02.
IF  (atc3_T0='N05BA04' and med3_dosis_T0='') med3_ppp=0.02.
IF  (atc4_T0='N05BA04') med4_recept=1.
IF  (atc4_T0='N05BA04' and med4_dosis_T0='10') med4_ppp=0.02.
**ATC N05BA01 - diazepam.
IF  (atc3_T0='N05BA01') med3_recept=1.
IF  (atc3_T0='N05BA01' and med3_dosis_T0='2') med3_ppp=0.03.
IF  (atc3_T0='N05BA01' and med3_dosis_T0='5') med3_ppp=0.02.
IF  (atc4_T0='N05BA01') med4_recept=1.
IF  (atc4_T0='N05BA01' and med4_dosis_T0='5') med4_ppp=0.02.
**ATC N05AX08.
IF  (atc1_T0='N05AX08') med1_recept=1.
IF  (atc1_T0='N05AX08' and med1_dosis_T0='1.5') med1_ppp=0.05.
**ATC N05AH04 - Quetiapine.
IF  (atc1_T0='N05AH04') med1_recept=1.
IF  (atc1_T0='N05AH04' and med1_dosis_T0='300') med1_ppp=0.08.
IF  (atc2_T0='N05AH04') med2_recept=1.
IF  (atc2_T0='N05AH04' and med2_dosis_T0='100') med2_ppp=0.04.
IF  (atc2_T0='N05AH04' and med2_dosis_T0='25') med2_ppp=0.02.
**ATC N05AF01.
IF  (atc4_T0='N05AF01') med4_recept=1.
IF  (atc4_T0='N05AF01' and med4_dosis_T0='1') med4_ppp=0.08.
**ATC N05.
IF  (atc2_T0='N05') med2_recept=1.
**ATC N04BC05 - pramipexol.
IF  (atc3_T0='N04BC05') med3_recept=1.
IF  (atc3_T0='N04BC05' and med3_dosis_T0='0,25') med3_ppp=0.04.
**ATC N04BC04 - .
IF  (atc1_T0='N04BC04') med1_recept=1.
IF  (atc1_T0='N04BC04' and med1_dosis_T0='8') med1_ppp=0.13.
IF  (atc1_T0='N04BC04' and med1_dosis_T0='0.5') med1_ppp=0.06.
**ATC N04AA02.
IF  (atc3_T0='N04AA02') med3_recept=1.
IF  (atc3_T0='N04AA02' and med3_dosis_T0='2') med3_ppp=0.05.
**ATC N03AX16 - Lyrica.
IF  (atc1_T0='N03AX16') med1_recept=1.
IF  (atc1_T0='N03AX16' and med1_dosis_T0='75') med1_ppp=0.06.
IF  (atc2_T0='N03AX16') med2_recept=1.
IF  (atc2_T0='N03AX16' and med2_dosis_T0='2x25 en 2x75') med2_ppp=0.21.
**ATC N03AX14.
IF  (atc2_T0='N03AX14') med2_recept=1.
IF  (atc2_T0='N03AX14' and med2_dosis_T0='500 en 1000') med2_ppp=0.15.
**ATC N03AX11.
IF  (atc1_T0='N03AX11') med1_recept=1.
IF  (atc1_T0='N03AX11' and med1_dosis_T0='25') med1_ppp=0.02.
IF  (atc1_T0='N03AX11' and med1_dosis_T0='75') med1_ppp=0.06.
**ATC N03AE01- rivotril.
IF  (atc1_T0='N03AE01') med1_recept=1.
IF  (atc1_T0='N03AE01' and med1_dosis_T0='0.5') med1_ppp=0.04.
IF  (atc2_T0='N03AE01') med2_recept=1.
IF  (atc2_T0='N03AE01' and med2_dosis_T0='2x0,5') med2_ppp=0.08.
**ATC N02CC03 .
IF  (atc3_T0='N02CC03') med3_recept=1.
IF  (atc3_T0='N02CC03' and med3_dosis_T0='2,5') med3_ppp=0.13.
**ATC N02CC01 Imigran.
IF  (atc2_T0='N02CC01') med2_recept=1.
IF  (atc2_T0='N02CC01' and med2_dosis_T0='20 (spray)') med2_ppp=999.
IF  (atc3_T0='N02CC01') med3_recept=1.
IF  (atc3_T0='N02CC01' and med3_dosis_T0='0,5 (injectie)') med3_ppp=14.26.
IF  (atc4_T0='N02CC01') med4_recept=1.
IF  (atc4_T0='N02CC01' and med4_dosis_T0='25 (zetpil)') med4_ppp=4.53.
**ATC N02BE51 Paracetamol/codeine.
IF  (atc1_T0='N02BE51') med1_recept=0.
IF  (atc1_T0='N02BE51' and med1_dosis_T0='500/65') med1_ppp=0.12.
IF  (atc1_T0='N02BE51' and med1_dosis_T0='500/30 poeder') med1_ppp=0.64.
IF  (atc1_T0='N02BE51' and med1_dosis_T0='250/250/65') med1_ppp=0.50.
**ATC N02BE01 Paracetamol.
IF  (atc1_T0='N02BE01') med1_recept=0.
IF  (atc1_T0='N02BE01' and med1_dosis_T0='500') med1_ppp=0.02.
IF  (atc1_T0='N02BE01' and med1_dosis_T0='2x500') med1_ppp=0.04.
IF  (atc1_T0='N02BE01' and med1_dosis_T0='1000') med1_ppp=0.03.
IF  (atc1_T0='N02BE01' and med1_dosis_T0='100') med1_ppp=0.10.
IF  (atc1_T0='N02BE01' and med1_dosis_T0='') med1_ppp=0.02.
IF  (atc2_T0='N02BE01') med2_recept=0.
IF  (atc2_T0='N02BE01' and med2_dosis_T0='500') med2_ppp=0.02.
IF  (atc2_T0='N02BE01' and med2_dosis_T0='1000') med2_ppp=0.03.
IF  (atc2_T0='N02BE01' and med2_dosis_T0='100') med2_ppp=0.10.
IF  (atc2_T0='N02BE01' and med2_dosis_T0='1,5 x 250') med2_ppp=0.24.
IF  (atc2_T0='N02BE01' and med2_dosis_T0='250') med2_ppp=0.16.
IF  (atc2_T0='N02BE01' and med2_dosis_T0='200') med2_ppp=0.02.
IF  (atc2_T0='N02BE01' and med2_dosis_T0='') med2_ppp=0.02.
IF  (atc3_T0='N02BE01') med3_recept=0.
IF  (atc3_T0='N02BE01' and med3_dosis_T0='500') med3_ppp=0.02.
IF  (atc3_T0='N02BE01' and med3_dosis_T0='1000') med3_ppp=0.03.
IF  (atc4_T0='N02BE01') med4_recept=0.
IF  (atc4_T0='N02BE01' and med4_dosis_T0='500') med4_ppp=0.02.
IF  (atc4_T0='N02BE01' and med4_dosis_T0='1000') med4_ppp=0.03.
IF  (atc4_T0='N02BE01' and med4_dosis_T0='2x500') med4_ppp=0.04.
IF  (atc5_T0='N02BE01') med5_recept=0.
IF  (atc5_T0='N02BE01' and med5_dosis_T0='500') med5_ppp=0.02.
IF  (atc5_T0='N02BE01' and med5_dosis_T0='1000') med5_ppp=0.03.
IF  (atc5_T0='N02BE01' and med5_dosis_T0='250') med5_ppp=0.16.
IF  (atc6_T0='N02BE01') med6_recept=0.
IF  (atc6_T0='N02BE01' and med6_dosis_T0='500') med6_ppp=0.02.
IF  (atc6_T0='N02BE01' and med6_dosis_T0='') med6_ppp=0.02.
IF  (atc7_T0='N02BE01') med7_recept=0.
IF  (atc7_T0='N02BE01' and med7_dosis_T0='500') med7_ppp=0.02.
IF  (atc7_T0='N02BE01' and med7_dosis_T0='1000') med7_ppp=0.03.
IF  (atc8_T0='N02BE01') med8_recept=0.
IF  (atc8_T0='N02BE01' and med8_dosis_T0='500') med8_ppp=0.02.
**ATC N02BA15 - carbasalaatcalcium bij pijn.
IF  (atc2_T0='N02BA15') med2_recept=1.
IF  (atc2_T0='N02BA15' and med2_dosis_T0='600') med2_ppp=0.13.
**ATC N02AX02 - tramadol.
IF  (atc1_T0='N02AX02') med1_recept=1.
IF  (atc1_T0='N02AX02' and med1_dosis_T0='150') med1_ppp=0.10.
IF  (atc1_T0='N02AX02' and med1_dosis_T0='') med1_ppp=0.03.
IF  (atc2_T0='N02AX02') med2_recept=1.
IF  (atc2_T0='N02AX02' and med2_dosis_T0='100') med2_ppp=0.06.
IF  (atc3_T0='N02AX02') med3_recept=1.
IF  (atc3_T0='N02AX02' and med3_dosis_T0='50') med3_ppp=0.03.
IF  (atc3_T0='N02AX02' and med3_dosis_T0='37,5') med3_ppp=999.
**ATC N02AJ13 tramadol/paracetamol. 
IF  (atc2_T0='N02AJ13') med2_recept=1.
IF  (atc2_T0='N02AJ13' and med2_dosis_T0='37,5/325') med2_ppp=0.07.
IF  (atc3_T0='N02AJ13') med3_recept=1.
IF  (atc3_T0='N02AJ13' and med3_dosis_T0='37,5/325') med3_ppp=0.07.
**ATC N02AJ06 paracetamol/codeine.
IF  (atc1_T0='N02AJ06') med1_recept=0.
IF  (atc1_T0='N02AJ06' and med1_dosis_T0='500/30') med1_ppp=0.06.
IF  (atc2_T0='N02AJ06') med2_recept=0.
IF  (atc2_T0='N02AJ06' and med2_dosis_T0='500/10') med2_ppp=0.04.
**ATC N02AA05 - oxycodon.
IF  (atc2_T0='N02AA05') med2_recept=1.
IF  (atc2_T0='N02AA05' and med2_dosis_T0='10') med2_ppp=0.05.
**ATC M05BX04.
IF  (atc2_T0='M05BX04') med2_recept=1.
IF  (atc2_T0='M05BX04' and med2_dosis_T0='') med2_ppp=214.93.
**ATC M05BB05.
IF  (atc3_T0='M05BB05') med3_recept=1.
IF  (atc3_T0='M05BB05' and med3_dosis_T0='') med3_ppp=0.98.
**ATC M05BA08.
IF  (atc5_T0='M05BA08') med5_recept=1.
IF  (atc5_T0='M05BA08' and med5_dosis_T0='1 infuus') med5_ppp=167.01.
**ATC M05BA04- alendrolinezuur.
IF  (atc1_T0='M05BA04') med1_recept=1.
IF  (atc1_T0='M05BA04' and med1_dosis_T0='70') med1_ppp=0.11.
IF  (atc6_T0='M05BA04') med6_recept=1.
IF  (atc6_T0='M05BA04' and med6_dosis_T0='') med6_ppp=0.15.
**ATC M04AC01- colchicine.
IF  (atc5_T0='M04AC01') med5_recept=1.
IF  (atc5_T0='M04AC01' and med5_dosis_T0='0.5') med5_ppp=0.08.
IF  (atc7_T0='M04AC01') med7_recept=1.
IF  (atc7_T0='M04AC01' and med7_dosis_T0='2x0,5') med7_ppp=0.16.
**ATC M04AA01- allopurinol.
IF  (atc1_T0='M04AA01') med1_recept=1.
IF  (atc1_T0='M04AA01' and med1_dosis_T0='300') med1_ppp=0.06.
IF  (atc4_T0='M04AA01') med4_recept=1.
IF  (atc4_T0='M04AA01' and med4_dosis_T0='300') med4_ppp=0.06.
**ATC M01AH05.
IF  (atc1_T0='M01AH05') med1_recept=1.
IF  (atc1_T0='M01AH05' and med1_dosis_T0='120') med1_ppp=1.23.
IF  (atc4_T0='M01AH05') med4_recept=1.
IF  (atc4_T0='M01AH05' and med4_dosis_T0='90') med4_ppp=1.01.
**ATC M01AH01-celebrex.
IF  (atc1_T0='M01AH01') med1_recept=1.
IF  (atc1_T0='M01AH01' and med1_dosis_T0='2x200') med1_ppp=0.10.
IF  (atc2_T0='M01AH01') med2_recept=1.
IF  (atc2_T0='M01AH01' and med2_dosis_T0='100') med2_ppp=0.04.
IF  (atc3_T0='M01AH01') med3_recept=1.
IF  (atc3_T0='M01AH01' and med3_dosis_T0='100') med3_ppp=0.04.
**ATC M01AE02- naproxen.
IF  (atc1_T0='M01AE02') med1_recept=1.
IF  (atc1_T0='M01AE02' and med1_dosis_T0='250') med1_ppp=0.03.
IF  (atc1_T0='M01AE02' and med1_dosis_T0='500') med1_ppp=0.04.
IF  (atc2_T0='M01AE02') med2_recept=1.
IF  (atc2_T0='M01AE02' and med2_dosis_T0='500') med2_ppp=0.04.
IF  (atc3_T0='M01AE02') med3_recept=1.
IF  (atc3_T0='M01AE02' and med3_dosis_T0='250') med3_ppp=0.03.
IF  (atc3_T0='M01AE02' and med3_dosis_T0='500') med3_ppp=0.04.
IF  (atc4_T0='M01AE02') med4_recept=1.
IF  (atc4_T0='M01AE02' and med4_dosis_T0='500') med4_ppp=0.04.
IF  (atc5_T0='M01AE02') med5_recept=1.
IF  (atc5_T0='M01AE02' and med5_dosis_T0='500') med5_ppp=0.04.
**ATC M01AE01- ibuprofen.
IF  (atc1_T0='M01AE01' and med1_dosis_T0='100') med1_recept=0.
IF  (atc1_T0='M01AE01' and med1_dosis_T0='200') med1_recept=0.
IF  (atc1_T0='M01AE01' and med1_dosis_T0='400') med1_recept=0.
IF  (atc1_T0='M01AE01' and med1_dosis_T0='500') med1_recept=0.
IF  (atc1_T0='M01AE01' and med1_dosis_T0='600') med1_recept=1.
IF  (atc1_T0='M01AE01' and med1_dosis_T0='800') med1_recept=1.
IF  (atc1_T0='M01AE01' and med1_dosis_T0='') med1_recept=0.
IF  (atc1_T0='M01AE01' and med1_dosis_T0='100') med1_ppp=0.44.
IF  (atc1_T0='M01AE01' and med1_dosis_T0='200') med1_ppp=0.04.
IF  (atc1_T0='M01AE01' and med1_dosis_T0='400') med1_ppp=0.06.
IF  (atc1_T0='M01AE01' and med1_dosis_T0='500') med1_ppp=0.04.
IF  (atc1_T0='M01AE01' and med1_dosis_T0='600') med1_ppp=0.04.
IF  (atc1_T0='M01AE01' and med1_dosis_T0='800') med1_ppp=0.13.
IF  (atc1_T0='M01AE01' and med1_dosis_T0='') med1_ppp=0.04.
IF  (atc2_T0='M01AE01' and med2_dosis_T0='100') med2_recept=0.
IF  (atc2_T0='M01AE01' and med2_dosis_T0='200') med2_recept=0.
IF  (atc2_T0='M01AE01' and med2_dosis_T0='400') med2_recept=0.
IF  (atc2_T0='M01AE01' and med2_dosis_T0='500') med2_recept=0.
IF  (atc2_T0='M01AE01' and med2_dosis_T0='600') med2_recept=1.
IF  (atc2_T0='M01AE01' and med2_dosis_T0='800') med2_recept=1.
IF  (atc2_T0='M01AE01' and med2_dosis_T0='100') med2_ppp=0.44.
IF  (atc2_T0='M01AE01' and med2_dosis_T0='200') med2_ppp=0.04.
IF  (atc2_T0='M01AE01' and med2_dosis_T0='400') med2_ppp=0.06.
IF  (atc2_T0='M01AE01' and med2_dosis_T0='500') med2_ppp=0.04.
IF  (atc2_T0='M01AE01' and med2_dosis_T0='600') med2_ppp=0.04.
IF  (atc2_T0='M01AE01' and med2_dosis_T0='800') med2_ppp=0.13.
IF  (atc3_T0='M01AE01' and med3_dosis_T0='100') med1_recept=0.
IF  (atc3_T0='M01AE01' and med3_dosis_T0='200') med3_recept=0.
IF  (atc3_T0='M01AE01' and med3_dosis_T0='400') med3_recept=0.
IF  (atc3_T0='M01AE01' and med3_dosis_T0='600') med3_recept=1.
IF  (atc3_T0='M01AE01' and med3_dosis_T0='800') med3_recept=1.
IF  (atc3_T0='M01AE01' and med3_dosis_T0='100') med3_ppp=0.44.
IF  (atc3_T0='M01AE01' and med3_dosis_T0='200') med3_ppp=0.04.
IF  (atc3_T0='M01AE01' and med3_dosis_T0='400') med3_ppp=0.06.
IF  (atc3_T0='M01AE01' and med3_dosis_T0='600') med3_ppp=0.04.
IF  (atc3_T0='M01AE01' and med3_dosis_T0='800') med3_ppp=0.13.
IF  (atc4_T0='M01AE01' and med4_dosis_T0='400') med4_recept=0.
IF  (atc4_T0='M01AE01' and med4_dosis_T0='500') med4_recept=1.
IF  (atc4_T0='M01AE01' and med4_dosis_T0='600') med4_recept=1.
IF  (atc4_T0='M01AE01' and med4_dosis_T0='800') med4_recept=1.
IF  (atc4_T0='M01AE01' and med4_dosis_T0='400') med4_ppp=0.06.
IF  (atc4_T0='M01AE01' and med4_dosis_T0='500') med4_ppp=0.04.
IF  (atc4_T0='M01AE01' and med4_dosis_T0='600') med4_ppp=0.04.
IF  (atc4_T0='M01AE01' and med4_dosis_T0='800') med4_ppp=0.13.
IF  (atc6_T0='M01AE01' and med6_dosis_T0='400') med6_recept=0.
IF  (atc6_T0='M01AE01' and med6_dosis_T0='400') med6_ppp=0.06.
IF  (atc8_T0='M01AE01' and med8_dosis_T0='400') med8_recept=0.
IF  (atc8_T0='M01AE01' and med8_dosis_T0='400') med8_ppp=0.06.
**ATC M01AB55 diclofenac/misoprostol.
IF  (atc2_T0='M01AB55') med2_recept=1.
IF  (atc2_T0='M01AB55' and med2_dosis_T0='75/0,2') med2_ppp=0.75.
**ATC M01AB05 - diclofenac.
IF  (atc1_T0='M01AB05' and med1_dosis_T0='25') med1_recept=0.
IF  (atc1_T0='M01AB05' and med1_dosis_T0='50') med1_recept=1.
IF  (atc1_T0='M01AB05' and med1_dosis_T0='60') med1_recept=1.
IF  (atc1_T0='M01AB05' and med1_dosis_T0='75') med1_recept=1.
IF  (atc1_T0='M01AB05' and med1_dosis_T0='') med1_recept=0.
IF  (atc1_T0='M01AB05' and med1_dosis_T0='25') med1_ppp=0.03.
IF  (atc1_T0='M01AB05' and med1_dosis_T0='50') med1_ppp=0.02.
IF  (atc1_T0='M01AB05' and med1_dosis_T0='') med1_ppp=0.02.
IF  (atc1_T0='M01AB05' and med1_dosis_T0='75') med1_ppp=0.04.
IF  (atc2_T0='M01AB05' and med2_dosis_T0='50') med2_recept=1.
IF  (atc2_T0='M01AB05' and med2_dosis_T0='75') med2_recept=1.
IF  (atc2_T0='M01AB05' and med2_dosis_T0='50') med2_ppp=0.02.
IF  (atc2_T0='M01AB05' and med2_dosis_T0='75') med2_ppp=0.04.
IF  (atc3_T0='M01AB05' and med3_dosis_T0='50') med3_recept=1.
IF  (atc3_T0='M01AB05' and med3_dosis_T0='50') med3_ppp=0.02.
IF  (atc4_T0='M01AB05' and med4_dosis_T0='50') med4_recept=1.
IF  (atc4_T0='M01AB05' and med4_dosis_T0='50') med4_ppp=0.02.
IF  (atc5_T0='M01AB05' and med5_dosis_T0='50') med5_recept=1.
IF  (atc5_T0='M01AB05' and med5_dosis_T0='50') med5_ppp=0.02.
IF  (atc6_T0='M01AB05' and med6_dosis_T0='50') med6_recept=1.
IF  (atc6_T0='M01AB05' and med6_dosis_T0='50') med6_ppp=0.02.
**ATC L04AX03- methotrexaat.
IF  (atc1_T0='L04AX03') med1_recept=1.
IF  (atc1_T0='L04AX03' and med1_dosis_T0='25' and med1_eenheid_T0='mg/ml') med1_ppp=10.00.
IF  (atc3_T0='L04AX03') med3_recept=1.
IF  (atc3_T0='L04AX03' and med3_dosis_T0='2,5' and med3_eenheid_T0='mg') med3_ppp=0.17.
**ATC L04AD02-.
IF  (atc2_T0='L04AD02') med2_recept=1.
IF  (atc2_T0='L04AD02' and med2_dosis_T0='3') med2_ppp=6.52.
**ATC L04AB04-humira.
IF  (atc1_T0='L04AB04') med1_recept=1.
IF  (atc1_T0='L04AB04' and med1_dosis_T0='40') med1_ppp=582.50.
IF  (atc2_T0='L04AB04') med2_recept=1.
IF  (atc2_T0='L04AB04' and med2_dosis_T0='40') med2_ppp=582.50.
**ATC L04AB02-.
IF  (atc3_T0='L04AB02') med3_recept=1.
IF  (atc3_T0='L04AB02' and med3_dosis_T0='') med3_ppp=$SYSMIS.
**ATC L04AA13.
IF  (atc2_T0='L04AA13') med2_recept=1.
IF  (atc2_T0='L04AA13' and med2_dosis_T0='20') med2_ppp=1.13.
**ATC L02BG04.
IF  (atc2_T0='L02BG04') med2_recept=1.
IF  (atc2_T0='L02BG04' and med2_dosis_T0='2,5') med2_ppp=0.05.
**ATC L02BG03.
IF  (atc1_T0='L02BG03') med1_recept=1.
IF  (atc1_T0='L02BG03' and med1_dosis_T0='1') med1_ppp=0.03.
**ATC L02BA01.
IF  (atc4_T0='L02BA01') med4_recept=1.
IF  (atc4_T0='L02BA01' and med4_dosis_T0='') med4_ppp=0.11.
**ATC J01XE01 - nitrofuratoine.
IF  (atc3_T0='J01XE01') med3_recept=1.
IF  (atc3_T0='J01XE01' and med3_dosis_T0='50') med3_ppp=0.08.
**ATC J01MA02.
IF  (atc3_T0='J01MA02') med3_recept=1.
IF  (atc3_T0='J01MA02' and med3_dosis_T0='500') med3_ppp=0.08.
**ATC J01FA09.
IF  (atc2_T0='J01FA09') med2_recept=1.
IF  (atc2_T0='J01FA09' and med2_dosis_T0='500') med2_ppp=0.20.
**ATC J01CR02 - .
IF  (atc3_T0='J01CR02') med3_recept=1.
IF  (atc3_T0='J01CR02' and med3_dosis_T0='500/125') med3_ppp=0.10.
**ATC J01CA04 - amoxicilline.
IF  (atc1_T0='J01CA04') med1_recept=1.
IF  (atc1_T0='J01CA04' and med1_dosis_T0='500') med1_ppp=0.06.
IF  (atc3_T0='J01CA04') med3_recept=1.
IF  (atc3_T0='J01CA04' and med3_dosis_T0='500') med3_ppp=0.06.
**ATC H03AA01 - Thyrax.
IF  (atc1_T0='H03AA01') med1_recept=1.
IF  (atc1_T0='H03AA01' and med1_dosis_T0='50') med1_ppp=0.02.
IF  (atc1_T0='H03AA01' and med1_dosis_T0='75') med1_ppp=0.06.
IF  (atc1_T0='H03AA01' and med1_dosis_T0='100') med1_ppp=0.03.
IF  (atc1_T0='H03AA01' and med1_dosis_T0='150') med1_ppp=0.06.
IF  (atc1_T0='H03AA01' and med1_dosis_T0='125') med1_ppp=0.06.
IF  (atc1_T0='H03AA01' and med1_dosis_T0='137,5') med1_ppp=0.06.
IF  (atc1_T0='H03AA01' and med1_dosis_T0='150') med1_ppp=0.06.
IF  (atc1_T0='H03AA01' and med1_dosis_T0='175') med1_ppp=0.07.
IF  (atc2_T0='H03AA01') med2_recept=1.
IF  (atc2_T0='H03AA01' and med2_dosis_T0='50') med2_ppp=0.02.
IF  (atc3_T0='H03AA01') med3_recept=1.
IF  (atc3_T0='H03AA01' and med3_dosis_T0='1x75 en 1x12.5') med3_ppp=0.44.
IF  (atc7_T0='H03AA01') med7_recept=1.
IF  (atc7_T0='H03AA01' and med7_dosis_T0='25') med7_ppp=0.02.
**ATC H02AB07.
IF  (atc1_T0='H02AB07') med1_recept=1.
IF  (atc1_T0='H02AB07' and med1_dosis_T0='1,5x5') med1_ppp=0.08.
**ATC H02AB06 - prednisolon.
IF  (atc4_T0='H02AB06') med4_recept=1.
IF  (atc4_T0='H02AB06' and med4_dosis_T0='10') med4_ppp=0.17.
**ATC G04CB01 - finasteride.
IF  (atc1_T0='G04CB01') med1_recept=1.
IF  (atc1_T0='G04CB01' and med1_dosis_T0='1') med1_ppp=0.60.
**ATC G04CA02 - tamsulosine.
IF  (atc1_T0='G04CA02') med1_recept=1.
IF  (atc1_T0='G04CA02' and med1_dosis_T0='0,4') med1_ppp=0.04.
IF  (atc2_T0='G04CA02') med2_recept=1.
IF  (atc2_T0='G04CA02' and med2_dosis_T0='0,4') med2_ppp=0.04.
IF  (atc3_T0='G04CA02') med3_recept=1.
IF  (atc3_T0='G04CA02' and med3_dosis_T0='0,4') med3_ppp=0.04.
IF  (atc3_T0='G04CA02' and med3_dosis_T0='') med3_ppp=0.04.
IF  (atc5_T0='G04CA02') med5_recept=1.
IF  (atc5_T0='G04CA02' and med5_dosis_T0=' ') med5_ppp=0.04.
**ATC G04BD08 .
IF  (atc3_T0='G04BD08') med3_recept=1.
IF  (atc3_T0='G04BD08' and med3_dosis_T0='1,5x10') med3_ppp=1.83.
**ATC G03CX01 .
IF  (atc3_T0='G03CX01') med3_recept=1.
IF  (atc3_T0='G03CX01' and med3_dosis_T0='2,5') med3_ppp=0.55.
**ATC G03AA07 .
IF  (atc3_T0='G03AA07') med3_recept=1.
IF  (atc3_T0='G03AA07' and med3_dosis_T0='') med3_ppp=999.
**ATC G02CB03 .
IF  (atc2_T0='G02CB03') med2_recept=1.
IF  (atc2_T0='G02CB03' and med2_dosis_T0='halve 0,5') med2_ppp=2.37.
**ATC D11AH01 .
IF  (atc2_T0='D11AH01') med2_recept=1.
IF  (atc2_T0='D11AH01' and med2_dosis_T0='') med2_ppp=999.
**ATC D07XC01 .
IF  (atc2_T0='D07XC01') med2_recept=1.
IF  (atc2_T0='D07XC01' and med2_dosis_T0='') med2_ppp=999.
**ATC D07AD01 .
IF  (atc3_T0='D07AD01') med3_recept=1.
IF  (atc3_T0='D07AD01' and med3_dosis_T0='') med3_ppp=$SYSMIS.
**ATC D07AC17 .
IF  (atc3_T0='D07AC17') med3_recept=1.
IF  (atc3_T0='D07AC17' and med3_dosis_T0='0,5') med3_ppp=$SYSMIS.
**ATC D07AC01/12 betamethason lotion.
IF  (atc2_T0='D07AC01/12') med2_recept=1.
IF  (atc2_T0='D07AC01/12' and med2_dosis_T0='lotion') med2_ppp=999.
**ATC C10AX09 - ezetimibe.
IF  (atc2_T0='C10AX09') med2_recept=1.
IF  (atc2_T0='C10AX09' and med2_dosis_T0='10') med2_ppp=0.80.
IF  (atc5_T0='C10AX09') med5_recept=1.
IF  (atc5_T0='C10AX09' and med5_dosis_T0='10') med5_ppp=0.80.
IF  (atc9_T0='C10AX09') med9_recept=1.
IF  (atc9_T0='C10AX09' and med9_dosis_T0='10') med9_ppp=0.80.
**ATC C10AA07 - crestor / rosuvastatine.
IF  (atc1_T0='C10AA07') med1_recept=1.
IF  (atc1_T0='C10AA07' and med1_dosis_T0='10') med1_ppp=0.78.
IF  (atc4_T0='C10AA07') med4_recept=1.
IF  (atc4_T0='C10AA07' and med4_dosis_T0='5') med4_ppp=0.70.
IF  (atc4_T0='C10AA07' and med4_dosis_T0='40') med4_ppp=1.59.
IF  (atc5_T0='C10AA07') med5_recept=1.
IF  (atc5_T0='C10AA07' and med5_dosis_T0='20') med5_ppp=1.13.
IF  (atc6_T0='C10AA07') med6_recept=1.
IF  (atc6_T0='C10AA07' and med6_dosis_T0='10') med6_ppp=0.78.
IF  (atc8_T0='C10AA07') med8_recept=1.
IF  (atc8_T0='C10AA07' and med8_dosis_T0='40') med8_ppp=1.59.
**ATC C10AA05 - atorvastatine.
IF  (atc1_T0='C10AA05') med1_recept=1.
IF  (atc1_T0='C10AA05' and med1_dosis_T0='10') med1_ppp=0.02.
IF  (atc1_T0='C10AA05' and med1_dosis_T0='20') med1_ppp=0.03.
IF  (atc1_T0='C10AA05' and med1_dosis_T0='40') med1_ppp=0.05.
IF  (atc3_T0='C10AA05') med3_recept=1.
IF  (atc3_T0='C10AA05' and med3_dosis_T0='10') med3_ppp=0.02.
IF  (atc3_T0='C10AA05' and med3_dosis_T0='20') med3_ppp=0.03.
IF  (atc3_T0='C10AA05' and med3_dosis_T0='40') med3_ppp=0.05.
IF  (atc4_T0='C10AA05') med4_recept=1.
IF  (atc4_T0='C10AA05' and med4_dosis_T0='20') med4_ppp=1.22.
IF  (atc4_T0='C10AA05' and med4_dosis_T0='80') med4_ppp=0.13.
IF  (atc5_T0='C10AA05') med5_recept=1.
IF  (atc5_T0='C10AA05' and med5_dosis_T0='40') med5_ppp=0.05.
IF  (atc6_T0='C10AA05') med6_recept=1.
IF  (atc6_T0='C10AA05' and med6_dosis_T0='10') med6_ppp=0.02.
**ATC C10AA03 - pravastatine.
IF  (atc4_T0='C10AA03') med4_recept=1.
IF  (atc4_T0='C10AA03' and med4_dosis_T0='') med4_ppp=0.03.
**ATC C10AA01 - simvastatine.
IF  (atc1_T0='C10AA01') med1_recept=1.
IF  (atc1_T0='C10AA01' and med1_dosis_T0='20') med1_ppp=0.02.
IF  (atc1_T0='C10AA01' and med1_dosis_T0='40') med1_ppp=0.02.
IF  (atc1_T0='C10AA01' and med1_dosis_T0='') med1_ppp=0.02.
IF  (atc2_T0='C10AA01') med2_recept=1.
IF  (atc2_T0='C10AA01' and med2_dosis_T0='20') med2_ppp=0.02.
IF  (atc2_T0='C10AA01' and med2_dosis_T0='40') med2_ppp=0.02.
IF  (atc2_T0='C10AA01' and med2_dosis_T0='') med2_ppp=0.02.
IF  (atc3_T0='C10AA01') med3_recept=1.
IF  (atc3_T0='C10AA01' and med3_dosis_T0='20') med3_ppp=0.02.
IF  (atc3_T0='C10AA01' and med3_dosis_T0='40') med3_ppp=0.02.
IF  (atc4_T0='C10AA01') med4_recept=1.
IF  (atc4_T0='C10AA01' and med4_dosis_T0='20') med4_ppp=0.02.
IF  (atc4_T0='C10AA01' and med4_dosis_T0='') med4_ppp=0.02.
IF  (atc5_T0='C10AA01') med5_recept=1.
IF  (atc5_T0='C10AA01' and med5_dosis_T0='40') med5_ppp=0.02.
**ATC C09DA04 - co-aproval.
IF  (atc7_T0='C09DA04') med7_recept=1.
IF  (atc7_T0='C09DA04' and med7_dosis_T0='') med7_ppp=0.04.
**ATC C09DA03 - valsartan/hydrochloorthiazide.
IF  (atc1_T0='C09DA03') med1_recept=1.
IF  (atc1_T0='C09DA03' and med1_dosis_T0='80/12.5') med1_ppp=0.02.
**ATC C09CA07 - telmisartan.
IF  (atc1_T0='C09CA07') med1_recept=1.
IF  (atc1_T0='C09CA07' and med1_dosis_T0='80') med1_ppp=0.04.
**ATC C09CA06 - candesartan.
IF  (atc4_T0='C09CA06') med4_recept=1.
IF  (atc4_T0='C09CA06' and med4_dosis_T0='4') med4_ppp=0.02.
**ATC C09CA04 - irbesartan.
IF  (atc1_T0='C09CA04') med1_recept=1.
IF  (atc1_T0='C09CA04' and med1_dosis_T0='300') med1_ppp=0.05.
IF  (atc1_T0='C09CA04' and med1_dosis_T0='150') med1_ppp=0.03.
IF  (atc1_T0='C09CA04' and med1_dosis_T0='75') med1_ppp=0.03.
IF  (atc3_T0='C09CA04') med3_recept=1.
IF  (atc3_T0='C09CA04' and med3_dosis_T0='150') med3_ppp=0.03.
IF  (atc3_T0='C09CA04' and med3_dosis_T0='') med3_ppp=0.03.
IF  (atc4_T0='C09CA04') med4_recept=1.
IF  (atc4_T0='C09CA04' and med4_dosis_T0='150') med4_ppp=0.03.
IF  (atc4_T0='C09CA04' and med4_dosis_T0='300') med4_ppp=0.05.
**ATC C09CA03 - valsartan.
IF  (atc1_T0='C09CA03') med1_recept=1.
IF  (atc1_T0='C09CA03' and med1_dosis_T0='160') med1_ppp=0.04.
IF  (atc2_T0='C09CA03') med2_recept=1.
IF  (atc2_T0='C09CA03' and med2_dosis_T0='40') med2_ppp=0.04.
IF  (atc5_T0='C09CA03') med5_recept=1.
IF  (atc5_T0='C09CA03' and med5_dosis_T0='160') med5_ppp=0.04.
**ATC C09CA01 - losartan.
IF  (atc1_T0='C09CA01') med1_recept=1.
IF  (atc1_T0='C09CA01' and med1_dosis_T0='50') med1_ppp=0.01.
IF  (atc2_T0='C09CA01') med2_recept=1.
IF  (atc2_T0='C09CA01' and med2_dosis_T0='50') med2_ppp=0.01.
IF  (atc3_T0='C09CA01') med3_recept=1.
IF  (atc3_T0='C09CA01' and med3_dosis_T0='50') med3_ppp=0.01.
IF  (atc3_T0='C09CA01' and med3_dosis_T0='') med3_ppp=999.
IF  (atc5_T0='C09CA01') med5_recept=1.
IF  (atc5_T0='C09CA01' and med5_dosis_T0='50') med5_ppp=0.01.
**ATC C09BA03 - .
IF  (atc2_T0='C09BA03') med2_recept=1.
IF  (atc2_T0='C09BA03' and med2_dosis_T0='20/12.5') med2_ppp=0.07.
**ATC C09AA06 - quinapril.
IF  (atc1_T0='C09AA06') med1_recept=1.
IF  (atc1_T0='C09AA06' and med1_dosis_T0='20') med1_ppp=0.11.
IF  (atc2_T0='C09AA06') med2_recept=1.
IF  (atc2_T0='C09AA06' and med2_dosis_T0='') med2_ppp=0.07.
IF  (atc4_T0='C09AA06') med4_recept=1.
IF  (atc4_T0='C09AA06' and med4_dosis_T0='10') med4_ppp=0.08.
**ATC C09AA05- ramipril.
IF  (atc1_T0='C09AA05') med1_recept=1.
IF  (atc1_T0='C09AA05' and med1_dosis_T0='2,5') med1_ppp=0.04.
**ATC C09AA04- perindopril.
IF  (atc1_T0='C09AA04') med1_recept=1.
IF  (atc1_T0='C09AA04' and med1_dosis_T0='2x10') med1_ppp=0.77.
IF  (atc2_T0='C09AA04') med2_recept=1.
IF  (atc2_T0='C09AA04' and med2_dosis_T0='4') med2_ppp=0.02.
IF  (atc2_T0='C09AA04' and med2_dosis_T0='8') med2_ppp=0.04.
IF  (atc3_T0='C09AA04') med3_recept=1.
IF  (atc3_T0='C09AA04' and med3_dosis_T0='8') med3_ppp=0.04.
IF  (atc4_T0='C09AA04') med4_recept=1.
IF  (atc4_T0='C09AA04' and med4_dosis_T0='4') med4_ppp=0.02.
IF  (atc4_T0='C09AA04' and med4_dosis_T0='1,5x4') med4_ppp=0.03.
IF  (atc5_T0='C09AA04') med5_recept=1.
IF  (atc5_T0='C09AA04' and med5_dosis_T0='2') med5_ppp=0.02.
IF  (atc6_T0='C09AA04') med6_recept=1.
IF  (atc6_T0='C09AA04' and med6_dosis_T0='8') med6_ppp=0.04.
**ATC C09AA03- lisinopril.
IF  (atc1_T0='C09AA03') med1_recept=1.
IF  (atc1_T0='C09AA03' and med1_dosis_T0='20') med1_ppp=0.02.
IF  (atc1_T0='C09AA03' and med1_dosis_T0='10') med1_ppp=0.02.
IF  (atc2_T0='C09AA03') med2_recept=1.
IF  (atc2_T0='C09AA03' and med2_dosis_T0='20') med2_ppp=0.02.
IF  (atc2_T0='C09AA03' and med2_dosis_T0='10') med2_ppp=0.02.
**ATC C09AA02- enalapril.
IF  (atc1_T0='C09AA02') med1_recept=1.
IF  (atc1_T0='C09AA02' and med1_dosis_T0='20') med1_ppp=0.02.
IF  (atc3_T0='C09AA02') med3_recept=1.
IF  (atc3_T0='C09AA02' and med3_dosis_T0='5') med3_ppp=0.02.
IF  (atc4_T0='C09AA02') med4_recept=1.
IF  (atc4_T0='C09AA02' and med4_dosis_T0='10') med4_ppp=0.02.
**ATC C08DB01- diltiazem.
IF  (atc1_T0='C08DB01') med1_recept=1.
IF  (atc1_T0='C08DB01' and med1_dosis_T0='200') med1_ppp=0.10.
IF  (atc1_T0='C08DB01' and med1_dosis_T0='') med1_ppp=0.03.
**ATC C08CA13- lercandipine.
IF  (atc2_T0='C08CA13') med2_recept=1.
IF  (atc2_T0='C08CA13' and med2_dosis_T0='10') med2_ppp=0.05.
**ATC C08CA12.
IF  (atc4_T0='C08CA12') med4_recept=1.
IF  (atc4_T0='C08CA12' and med4_dosis_T0='10') med4_ppp=0.69.
**ATC C08CA05- nefidipine.
IF  (atc2_T0='C08CA05') med2_recept=1.
IF  (atc2_T0='C08CA05' and med2_dosis_T0='60') med2_ppp=0.14.
IF  (atc3_T0='C08CA05') med3_recept=1.
IF  (atc3_T0='C08CA05' and med3_dosis_T0='30') med3_ppp=0.14.
**ATC C08CA01- amlodipine.
IF  (atc1_T0='C08CA01') med1_recept=1.
IF  (atc1_T0='C08CA01' and med1_dosis_T0='5') med1_ppp=0.02.
IF  (atc1_T0='C08CA01' and med1_dosis_T0='10') med1_ppp=0.02.
IF  (atc2_T0='C08CA01') med2_recept=1.
IF  (atc2_T0='C08CA01' and med2_dosis_T0='5') med2_ppp=0.02.
IF  (atc2_T0='C08CA01' and med2_dosis_T0='10') med2_ppp=0.02.
IF  (atc3_T0='C08CA01') med3_recept=1.
IF  (atc3_T0='C08CA01' and med3_dosis_T0='5') med3_ppp=0.02.
IF  (atc3_T0='C08CA01' and med3_dosis_T0='10') med3_ppp=0.02.
IF  (atc5_T0='C08CA01') med5_recept=1.
IF  (atc5_T0='C08CA01' and med5_dosis_T0='10') med5_ppp=0.02.
IF  (atc6_T0='C08CA01') med6_recept=1.
IF  (atc6_T0='C08CA01' and med6_dosis_T0='5') med6_ppp=0.02.
**ATC C07BB02- metoprolol/HCT.
IF  (atc2_T0='C07BB02') med2_recept=1.
IF  (atc2_T0='C07BB02' and med2_dosis_T0='100/12,5') med2_ppp=0.24.
**ATC C07AB12- nebivolol.
IF  (atc4_T0='C07AB12') med4_recept=1.
IF  (atc4_T0='C07AB12' and med4_dosis_T0='halve 5') med4_ppp=0.02.
**ATC C07AB07- bisoprolol.
IF  (atc3_T0='C07AB07') med3_recept=1.
IF  (atc3_T0='C07AB07' and med3_dosis_T0='5') med3_ppp=0.02.
IF  (atc5_T0='C07AB07') med5_recept=1.
IF  (atc5_T0='C07AB07' and med5_dosis_T0='5') med5_ppp=0.02.
**ATC C07AB02- metoprolol.
IF  (atc1_T0='C07AB02') med1_recept=1.
IF  (atc1_T0='C07AB02' and med1_dosis_T0='25') med1_ppp=0.03.
IF  (atc1_T0='C07AB02' and med1_dosis_T0='50') med1_ppp=0.02.
IF  (atc1_T0='C07AB02' and med1_dosis_T0='100') med1_ppp=0.02.
IF  (atc2_T0='C07AB02') med2_recept=1.
IF  (atc2_T0='C07AB02' and med2_dosis_T0='200') med2_ppp=0.05.
IF  (atc2_T0='C07AB02' and med2_dosis_T0='100+50') med2_ppp=0.04.
IF  (atc3_T0='C07AB02') med3_recept=1.
IF  (atc3_T0='C07AB02' and med3_dosis_T0='0,5x25') med3_ppp=0.02.
IF  (atc3_T0='C07AB02' and med3_dosis_T0='25') med3_ppp=0.03.
IF  (atc3_T0='C07AB02' and med3_dosis_T0='100') med3_ppp=0.02.
IF  (atc7_T0='C07AB02') med7_recept=1.
IF  (atc7_T0='C07AB02' and med7_dosis_T0='100') med7_ppp=0.02.
**ATC C07AA07- sotalol.
IF  (atc1_T0='C07AA07') med1_recept=1.
IF  (atc1_T0='C07AA07' and med1_dosis_T0='80') med1_ppp=0.04.
IF  (atc7_T0='C07AA07') med7_recept=1.
IF  (atc7_T0='C07AA07' and med7_dosis_T0='80 en 40') med7_ppp=0.10.
**ATC C03DA01- .
IF  (atc5_T0='C03DA01') med5_recept=1.
IF  (atc5_T0='C03DA01' and med5_dosis_T0='25') med5_ppp=0.03.
**ATC C03CA01- furosemide.
IF  (atc3_T0='C03CA01') med3_recept=1.
IF  (atc3_T0='C03CA01' and med3_dosis_T0='40') med3_ppp=0.02.
IF  (atc4_T0='C03CA01') med4_recept=1.
IF  (atc4_T0='C03CA01' and med4_dosis_T0='40') med4_ppp=0.02.
**ATC C03BA04- chloortalidon.
IF  (atc1_T0='C03BA04') med1_recept=1.
IF  (atc1_T0='C03BA04' and med1_dosis_T0='12,5') med1_ppp=0.07.
**ATC C03AA03- hydrochloorthiazide.
IF  (atc1_T0='C03AA03') med1_recept=1.
IF  (atc1_T0='C03AA03' and med1_dosis_T0='12,5') med1_ppp=0.03.
IF  (atc1_T0='C03AA03' and med1_dosis_T0='25') med1_ppp=0.02.
IF  (atc2_T0='C03AA03') med2_recept=1.
IF  (atc2_T0='C03AA03' and med2_dosis_T0='12,5') med2_ppp=0.03.
IF  (atc2_T0='C03AA03' and med2_dosis_T0='25') med2_ppp=0.02.
IF  (atc3_T0='C03AA03') med3_recept=1.
IF  (atc3_T0='C03AA03' and med3_dosis_T0='12,5') med3_ppp=0.03.
IF  (atc3_T0='C03AA03' and med3_dosis_T0='25') med3_ppp=0.02.
IF  (atc5_T0='C03AA03') med5_recept=1.
IF  (atc5_T0='C03AA03' and med5_dosis_T0='25') med5_ppp=0.02.
IF  (atc6_T0='C03AA03') med6_recept=1.
IF  (atc6_T0='C03AA03' and med6_dosis_T0='25') med6_ppp=0.02.
IF  (atc9_T0='C03AA03') med9_recept=1.
IF  (atc9_T0='C03AA03' and med9_dosis_T0='12,5') med9_ppp=0.03.
**ATC C01DA14- isosorbide mononitraat.
IF  (atc2_T0='C01DA14') med2_recept=1.
IF  (atc2_T0='C01DA14' and med2_dosis_T0='25') med2_ppp=0.24.
IF  (atc6_T0='C01DA14') med6_recept=1.
IF  (atc6_T0='C01DA14' and med6_dosis_T0='30') med6_ppp=0.29.
**ATC C01DA08- isosorbide dinitraat.
IF  (atc10_T0='C01DA08') med10_recept=1.
IF  (atc10_T0='C01DA08' and med10_dosis_T0='5') med10_ppp=0.03.
**ATC B03BB01- foliumzuur.
IF  (atc2_T0='B03BB01') med2_recept=0.
IF  (atc2_T0='B03BB01' and med2_dosis_T0='5') med2_ppp=0.03.
IF  (atc3_T0='B03BB01') med3_recept=0.
IF  (atc3_T0='B03BB01' and med3_dosis_T0='5') med3_ppp=0.03.
IF  (atc5_T0='B03BB01') med5_recept=0.
IF  (atc5_T0='B03BB01' and med5_dosis_T0='2x5') med5_ppp=0.06.
**ATC B03BA03- vit B12 injectie.
IF  (atc2_T0='B03BA03') med2_recept=1.
IF  (atc2_T0='B03BA03' and med2_dosis_T0='2') med2_ppp=0.70.
**ATC B01AC08- ascal.(100 gr maakt niet uit of het poeder of tablet is, is even duur).
IF  (atc1_T0='B01AC08') med1_recept=1.
IF  (atc1_T0='B01AC08' and med1_dosis_T0='100') med1_ppp=0.06.
IF  (atc2_T0='B01AC08') med2_recept=1.
IF  (atc2_T0='B01AC08' and med2_dosis_T0='100') med2_ppp=0.06.
IF  (atc2_T0='B01AC08' and med2_dosis_T0='') med2_ppp=999.
IF  (atc3_T0='B01AC08') med3_recept=1.
IF  (atc3_T0='B01AC08' and med3_dosis_T0='100') med3_ppp=0.06.
IF  (atc4_T0='B01AC08') med4_recept=1.
IF  (atc4_T0='B01AC08' and med4_dosis_T0='100') med4_ppp=0.06.
IF  (atc5_T0='B01AC08') med5_recept=1.
IF  (atc5_T0='B01AC08' and med5_dosis_T0='100') med5_ppp=0.06.
**ATC B01AC07- persantin .
IF  (atc1_T0='B01AC07') med1_recept=1.
IF  (atc1_T0='B01AC07' and med1_dosis_T0='200') med1_ppp=0.18.
IF  (atc3_T0='B01AC07') med3_recept=1.
IF  (atc3_T0='B01AC07' and med3_dosis_T0='200') med3_ppp=0.18.
**ATC B01AA07- acenocoumarol .
IF  (atc1_T0='B01AA07') med1_recept=1.
IF  (atc1_T0='B01AA07' and med1_dosis_T0='6x1') med1_ppp=0.11.
**ATC B01AC06- acetylsalisylzuur.
IF  (atc1_T0='B01AC06' and med1_dosis_T0='80') med1_recept=1.
IF  (atc1_T0='B01AC06' and med1_dosis_T0='80') med1_ppp=0.03.
IF  (atc1_T0='B01AC06' and med1_dosis_T0='') med1_ppp=0.03.
IF  (atc2_T0='B01AC06' and med2_dosis_T0='80') med2_recept=1.
IF  (atc2_T0='B01AC06' and med2_dosis_T0='80') med2_ppp=0.03.
IF  (atc3_T0='B01AC06' and med3_dosis_T0='80') med3_recept=1.
IF  (atc3_T0='B01AC06' and med3_dosis_T0='80') med3_ppp=0.03.
IF  (atc5_T0='B01AC06' and med5_dosis_T0='80') med5_recept=1.
IF  (atc5_T0='B01AC06' and med5_dosis_T0='80') med5_ppp=0.03.
IF  (atc6_T0='B01AC06' and med6_dosis_T0='80') med6_recept=1.
IF  (atc6_T0='B01AC06' and med6_dosis_T0='80') med6_ppp=0.03.
**ATC B01AA04- fenprocoumon .
IF  (atc4_T0='B01AA04') med4_recept=1.
IF  (atc4_T0='B01AA04' and med4_dosis_T0='3') med4_ppp=0.07.
**ATC B01AA04-  .
IF  (atc2_T0='B01AA04') med2_recept=1.
IF  (atc2_T0='B01AA04' and med2_dosis_T0='3') med2_ppp=0.07.
**ATC A12AX- Calciumcarbonaat.
IF  (atc1_T0='A12AX') med1_recept=1.
IF  (atc1_T0='A12AX' and med1_dosis_T0='1000/880') med1_ppp=0.08.
**ATC A12AA04- Calciumcarbonaat.
IF  (atc2_T0='A12AA04') med2_recept=1.
IF  (atc2_T0='A12AA04' and med2_dosis_T0='500') med2_ppp=0.13.
IF  (atc3_T0='A12AA04') med3_recept=1.
IF  (atc3_T0='A12AA04' and med3_dosis_T0='1000') med3_ppp=0.46.
**ATC A11GA01 ascorbinezuur.
IF  (atc3_T0='A11GA01') med3_recept=0.
IF  (atc3_T0='A11GA01' and med3_dosis_T0='') med3_ppp=0.05.
**ATC A11CC05 colecalciferol -Vit D.
IF  (atc2_T0='A11CC05') med2_recept=1.
IF  (atc2_T0='A11CC05' and med2_dosis_T0='800') med2_ppp=0.05.
IF  (atc4_T0='A11CC05') med4_recept=1.
IF  (atc4_T0='A11CC05' and med4_dosis_T0='400') med4_ppp=0.11.
IF  (atc5_T0='A11CC05') med5_recept=1.
IF  (atc5_T0='A11CC05' and med5_dosis_T0='800') med5_ppp=0.05.
**ATC A11CC03 alfacalcidol .
IF  (atc2_T0='A11CC03') med2_recept=1.
IF  (atc2_T0='A11CC03' and med2_dosis_T0='0,25') med2_ppp=0.17.
**ATC A10BD08 .
IF  (atc1_T0='A10BD08') med1_recept=1.
IF  (atc1_T0='A10BD08' and med1_dosis_T0='50/850') med1_ppp=0.74.
**ATC A10BB09 - gliclazide .
IF  (atc3_T0='A10BB09') med3_recept=1.
IF  (atc3_T0='A10BB09' and med3_dosis_T0='80') med3_ppp=0.04.
IF  (atc4_T0='A10BB09') med4_recept=1.
IF  (atc4_T0='A10BB09' and med4_dosis_T0='') med4_ppp=0.04.
IF  (atc6_T0='A10BB09') med6_recept=1.
IF  (atc6_T0='A10BB09' and med6_dosis_T0='80') med6_ppp=0.04.
**ATC A10BA02 - metformine.
IF  (atc1_T0='A10BA02') med1_recept=1.
IF  (atc1_T0='A10BA02' and med1_dosis_T0='500') med1_ppp=0.01.
IF  (atc1_T0='A10BA02' and med1_dosis_T0='850') med1_ppp=0.02.
IF  (atc1_T0='A10BA02' and med1_dosis_T0='1000') med1_ppp=0.03.
IF  (atc2_T0='A10BA02') med2_recept=1.
IF  (atc2_T0='A10BA02' and med2_dosis_T0='500') med2_ppp=0.01.
IF  (atc3_T0='A10BA02') med3_recept=1.
IF  (atc3_T0='A10BA02' and med3_dosis_T0='500') med3_ppp=0.01.
IF  (atc5_T0='A10BA02') med5_recept=1.
IF  (atc5_T0='A10BA02' and med5_dosis_T0='500') med5_ppp=0.01.
**ATC A10AE04 insuline glargine.
IF  (atc8_T0='A10AE04') med8_recept=1.
IF  (atc8_T0='A10AE04' and med8_dosis_T0='15') med8_ppp=0.45.
**ATC A10AB05 insuline aspart.
IF  (atc7_T0='A10AB05') med7_recept=1.
IF  (atc7_T0='A10AB05' and med7_dosis_T0='5') med7_ppp=0.10.
**ATC A10A insuline.
IF  (atc1_T0='A10A') med1_recept=1.
IF  (atc1_T0='A10A' and med1_dosis_T0='24') med1_ppp=0.48.
IF  (atc1_T0='A10A' and med1_dosis_T0='34') med1_ppp=0.68.
IF  (atc2_T0='A10A') med2_recept=1.
IF  (atc2_T0='A10A' and med2_dosis_T0='10') med2_ppp=0.20.
**ATC A09AA02 .
IF  (atc9_T0='A09AA02') med9_recept=1.
IF  (atc9_T0='A09AA02' and med9_dosis_T0='22500/25000/1250') med9_ppp=1.07.
**ATC A07EC02  .
IF  (atc2_T0='A07EC02') med2_recept=1.
IF  (atc2_T0='A07EC02' and med1_dosis_T0='') med2_ppp=0.03.
**ATC A07DA03 loperamide .
IF  (atc1_T0='A07DA03') med1_recept=0.
IF  (atc1_T0='A07DA03' and med1_dosis_T0='') med1_ppp=0.10.
**ATC A06AD65 macrogol/electrolyten .
IF  (atc3_T0='A06AD65') med3_recept=1.
IF  (atc3_T0='A06AD65' and med3_dosis_T0='13,8') med3_ppp=0.12.
IF  (atc5_T0='A06AD65') med5_recept=1.
IF  (atc5_T0='A06AD65' and med5_dosis_T0='13,7') med5_ppp=0.12.
**ATC A06AD15 macrogol .
IF  (atc3_T0='A06AD15') med3_recept=1.
IF  (atc3_T0='A06AD15' and med3_dosis_T0='10') med3_ppp=0.61.
IF  (atc5_T0='A06AD15') med5_recept=1.
IF  (atc5_T0='A06AD15' and med5_dosis_T0='13') med5_ppp=0.69.
**ATC A06AB02 bisacodyl .
IF  (atc2_T0='A06AB02') med2_recept=1.
IF  (atc2_T0='A06AB02' and med2_dosis_T0='5') med2_ppp=0.04.
IF  (atc6_T0='A06AB02') med6_recept=1.
IF  (atc6_T0='A06AB02' and med6_dosis_T0='5') med6_ppp=0.04.
**ATC A03AA04 duspatal .
IF  (atc5_T0='A03AA04') med5_recept=1.
IF  (atc5_T0='A03AA04' and med5_dosis_T0='200') med5_ppp=0.20.
**ATC A02BX13 .
IF  (atc7_T0='A02BX13') med7_recept=1.
IF  (atc7_T0='A02BX13' and med7_dosis_T0='250') med7_ppp=0.21.
**ATC A02BC05 nexium .
IF  (atc2_T0='A02BC05') med2_recept=1.
IF  (atc2_T0='A02BC05' and med2_dosis_T0='40') med2_ppp=0.08.
IF  (atc5_T0='A02BC05') med5_recept=1.
IF  (atc5_T0='A02BC05' and med5_dosis_T0='20') med5_ppp=0.06.
**ATC A02BC02 pantoprazol .
IF  (atc1_T0='A02BC02') med1_recept=1.
IF  (atc1_T0='A02BC02' and med1_dosis_T0='20') med1_ppp=0.03.
IF  (atc1_T0='A02BC02' and med1_dosis_T0='40') med1_ppp=0.03.
IF  (atc2_T0='A02BC02') med2_recept=1.
IF  (atc2_T0='A02BC02' and med2_dosis_T0='40') med2_ppp=0.03.
IF  (atc3_T0='A02BC02') med3_recept=1.
IF  (atc3_T0='A02BC02' and med3_dosis_T0='20') med3_ppp=0.03.
IF  (atc4_T0='A02BC02') med4_recept=1.
IF  (atc4_T0='A02BC02' and med4_dosis_T0='20') med4_ppp=0.03.
IF  (atc4_T0='A02BC02' and med4_dosis_T0='40') med4_ppp=0.03.
IF  (atc5_T0='A02BC02') med5_recept=1.
IF  (atc5_T0='A02BC02' and med5_dosis_T0='40') med5_ppp=0.03.
IF  (atc6_T0='A02BC02') med6_recept=1.
IF  (atc6_T0='A02BC02' and med6_dosis_T0='40') med6_ppp=0.03.
**ATC A02BC01 omeprazol .
IF  (atc1_T0='A02BC01') med1_recept=1.
IF  (atc1_T0='A02BC01' and med1_dosis_T0='10') med1_ppp=0.02.
IF  (atc1_T0='A02BC01' and med1_dosis_T0='20') med1_ppp=0.02.
IF  (atc1_T0='A02BC01' and med1_dosis_T0='40') med1_ppp=0.03.
IF  (atc1_T0='A02BC01' and med1_dosis_T0='') med1_ppp=0.02.
IF  (atc2_T0='A02BC01') med2_recept=1.
IF  (atc2_T0='A02BC01' and med2_dosis_T0='20') med2_ppp=0.02.
IF  (atc2_T0='A02BC01' and med2_dosis_T0='40') med2_ppp=0.03.
IF  (atc2_T0='A02BC01' and med2_dosis_T0='') med2_ppp=0.02.
IF  (atc3_T0='A02BC01') med3_recept=1.
IF  (atc3_T0='A02BC01' and med3_dosis_T0='20') med3_ppp=0.02.
IF  (atc3_T0='A02BC01' and med3_dosis_T0='40') med3_ppp=0.03.
IF  (atc4_T0='A02BC01') med4_recept=1.
IF  (atc4_T0='A02BC01' and med4_dosis_T0='20') med4_ppp=0.02.
IF  (atc4_T0='A02BC01' and med4_dosis_T0='40') med4_ppp=0.03.
IF  (atc6_T0='A02BC01') med6_recept=1.
IF  (atc6_T0='A02BC01' and med6_dosis_T0='40') med6_ppp=0.03.
IF  (atc8_T0='A02BC01') med8_recept=1.
IF  (atc8_T0='A02BC01' and med8_dosis_T0='20') med8_ppp=0.02.
IF  (atc8_T0='A02BC01' and med8_dosis_T0='40') med8_ppp=0.03.
**ATC A02BA02 ranitidine .
IF  (atc1_T0='A02BA02') med1_recept=1.
IF  (atc1_T0='A02BA02' and med1_dosis_T0='300') med1_ppp=0.03.
IF  (atc2_T0='A02BA02') med2_recept=1.
IF  (atc2_T0='A02BA02' and med2_dosis_T0='75') med2_ppp=0.60.
**ATC A02AD01 rennie .
IF  (atc3_T0='A02AD01') med3_recept=0.
IF  (atc3_T0='A02AD01' and med3_dosis_T0='680/80') med3_ppp=0.12.
IF  (atc6_T0='A02AD01') med6_recept=0.
IF  (atc6_T0='A02AD01' and med6_dosis_T0='680/80') med6_ppp=0.12.

** geen (volledige) ATC*******************************.
* indien medicijn volledig onbekend: 1 cent per pil (conservatieve schatting).
IF  (ID_Code=6408 and atc1_T0='') med1_recept=1.
IF  (ID_Code=6408 and atc1_T0='') med1_ppp=0.01.
IF  (ID_Code=2010 and atc1_T0='') med1_recept=0.
IF  (ID_Code=2010 and atc1_T0='') med1_ppp=0.01.
IF  (ID_Code=2012 and atc2_T0='') med2_recept=0.
IF  (ID_Code=2012 and atc2_T0='') med2_ppp=0.01.
IF  (ID_Code=1606 and atc2_T0='') med2_recept=0.
IF  (ID_Code=1606 and atc2_T0='') med2_ppp=0.01.
IF  (ID_Code=1111 and atc2_T0='') med2_recept=0.
IF  (ID_Code=1111 and atc2_T0='') med2_ppp=0.01.
IF  (ID_Code=2012 and atc3_T0='') med3_recept=0.
IF  (ID_Code=2012 and atc3_T0='') med3_ppp=0.01.
IF  (ID_Code=2108 and atc3_T0='') med3_recept=0.
IF  (ID_Code=2108 and atc3_T0='') med3_ppp=0.01.
IF  (ID_Code=7102 and atc4_T0='') med4_recept=1.
IF  (ID_Code=7102 and atc4_T0='') med4_ppp=0.01.
EXECUTE.

*** ATC A02 - maagbeschermers.(40 mg = 3 cent).
IF (atc2_T0='A02') med2_recept=1.
IF  (ID_Code=5310 and atc2_T0='A02') med2_ppp=0.02.
IF  (ID_Code=2009 and atc2_T0='A02') med2_ppp=0.03.
IF  (ID_Code=2702 and atc2_T0='A02') med2_ppp=0.03.
IF (atc3_T0='A02') med3_recept=1.
IF  (ID_Code=1810 and atc3_T0='A02') med3_ppp=0.02.
IF  (ID_Code=3504 and atc3_T0='A02') med3_ppp=0.02.
IF  (ID_Code=3905 and atc3_T0='A02') med3_ppp=0.02.

*** ATC A06 - klysma.- conservatieve schatting.
IF (ID_Code=4009 and med5_T0='klysma') med5_recept=1.
IF (ID_Code=4009 and med5_T0='klysma') med5_ppp=0.01.


*** ATC B01 - bloedverdunners.
*100 mg is waarschijnlijk carbasalaatcalcium of acetylsalisylzuur (beide 0.06).
* goedkoopste 0.03.
IF  (atc1_T0='B01') med1_recept=1.
IF  (atc1_T0='B01' and med1_dosis_T0='40') med1_ppp=0.03.
IF  (atc1_T0='B01' and med1_dosis_T0='100') med1_ppp=0.06.
IF  (atc2_T0='B01') med2_recept=1.
IF  (atc2_T0='B01' and med2_dosis_T0='') med2_ppp=0.03.
IF  (atc2_T0='B01' and med2_dosis_T0='100') med2_ppp=0.06.
IF  (atc5_T0='B01') med5_recept=1.
IF  (atc5_T0='B01' and med5_dosis_T0='') med5_ppp=0.03.

*** ATC C02 - bloeddrukverlagers.
IF  (atc1_T0='C02') med1_recept=1.
IF  (atc1_T0='C02' and med1_dosis_T0='100') med1_ppp=0.02.
IF  (atc1_T0='C02' and med1_dosis_T0='75') med1_ppp=0.03.
IF  (atc1_T0='C02' and med1_dosis_T0='') med1_ppp=0.02.
IF  (atc2_T0='C02') med2_recept=1.
IF  (atc2_T0='C02' and med2_dosis_T0='20') med2_ppp=0.02.
IF  (atc2_T0='C02' and med2_dosis_T0='') med2_ppp=0.02.
IF  (atc3_T0='C02') med3_recept=1.
IF  (atc3_T0='C02' and med3_dosis_T0='75') med3_ppp=0.03.

*** ATC C03 - plaspil.
IF  (atc3_T0='C03') med3_recept=1.
IF  (atc3_T0='C03' and med3_dosis_T0='') med3_ppp=0.02.

*** ATC C07 - betablokkers.
IF  (atc2_T0='C07') med2_recept=1.
IF  (atc2_T0='C07' and med2_dosis_T0='100') med2_ppp=0.02.

*** ATC C10 cholesterolverlagers
goedkoopste=simvastatine in 10,20 of 40 mg, allen 2 cent.
*5 mg is rosuvastatiene: 0.70.
IF  (atc1_T0='C10') med1_recept=1.
IF  (atc1_T0='C10' and med1_dosis_T0='') med1_ppp=0.02.
IF  (atc1_T0='C10' and med1_dosis_T0='10') med1_ppp=0.02.
IF  (atc2_T0='C10') med2_recept=1.
IF  (atc2_T0='C10' and med2_dosis_T0='') med2_ppp=0.02.
IF  (atc2_T0='C10' and med2_dosis_T0='20') med2_ppp=0.02.
IF  (atc2_T0='C10' and med2_dosis_T0='10 + 20') med2_ppp=0.04.
IF  (atc3_T0='C10') med3_recept=1.
IF  (atc3_T0='C10' and med3_dosis_T0='') med3_ppp=0.02.
IF  (atc4_T0='C10') med4_recept=1.
IF  (atc4_T0='C10' and med4_dosis_T0='5') med4_ppp=0.70.
IF  (atc4_T0='C10' and med4_dosis_T0='') med4_ppp=0.02.

**ATC J01 - antibiotica zonder specificatie.
IF  (atc1_T0='J01') med1_recept=1.
IF  (atc1_T0='J01' and med1_dosis_T0='250') med1_ppp=0.13.
IF  (atc1_T0='J01' and med1_dosis_T0='500') med1_ppp=0.06.
* 3x daags, 10 dagen: waarschijnlijk amoxicilinne (is ook goedkoopste).
IF  (ID_Code=5506 and atc1_T0='J01') med1_ppp=0.06.
* 3x daags, 7 dagen: waarschijnlijk amoxicilinne (is ook goedkoopste).
IF  (ID_Code=7012 and atc1_T0='J01') med1_ppp=0.06.
IF  (atc2_T0='J01') med2_recept=1.
IF  (atc2_T0='J01' and med2_dosis_T0='500') med2_ppp=0.06.

*** ATC N02C - migraine.
*goedkoopste.
IF  (atc2_T0='N02C') med2_recept=1.
IF  (atc2_T0='N02C' and med2_dosis_T0='') med2_ppp=0.13.

*** ATC N05 - psychofarmaca.
*5812	Med 2 Slaapmedicatie 10 mg: oxazepam=2 cent.
IF  (ID_Code=5812 and atc2_T0='N05') med2_ppp=0.02.

*** ATC N06 - antidepressiva.
IF  (atc4_T0='N06') med4_recept=1.
IF  (atc4_T0='N06' and med4_dosis_T0='10') med4_ppp=0.02.

*** ATC R03 - pufjes.
*Goedkoopste in ons bestand is salbutamol, 0.05 per dosis. Dit aanhouden.
IF  (atc1_T0='R03') med1_recept=1.
IF  (atc1_T0='R03' and med1_dosis_T0='') med1_ppp=0.05.
IF  (atc3_T0='R03') med3_recept=1.
IF  (atc3_T0='R03' and med3_dosis_T0='') med3_ppp=0.05.

*** ATC V01 - antiallergie. Conservatieve schatting.
IF  (atc4_T0='V01') med4_recept=0.
IF  (ID_Code=2009 and atc4_T0='V01') med4_ppp=0.01.
EXECUTE.

** ID 2904 Chemo: 400 mg 2d tablet gedurende 91 dagen. Verder geen med. Wel onder behandeling van oncoloog en chemo genoemd bij dagbehandeling. 
* Geen T1. Wordt ook genoemd op T2. Van alle chemotherapie in tabletvorm, vind ik er maar 1 die in 400 mg is en 2x daags wordt gegeven: imatinib.
IF  (ID_Code=2904 and med1_T0='Chemo') med1_ppp=36.65.
IF  (ID_Code=2904 and med1_T0='Chemo') med1_recept=1.
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
VARIABLE LABELS med10_ppp 'med10 prijs per pil' / med10_recept 'med10 op recept'.




******************************************************************************************************************************************************************************************.
************ Totaal aantal pillen uitrekenen: aantal per dag x aantal dagen ***************************************************************************************************************.
******************************************************************************************************************************************************************************************.

** Aantal per dag en/of aantal dagen missing.Voor chronische med 1d1 90 dagen, voor pijnstillers en slaapmedicatie 1d1 1 dag.
** indien keerperdag = 0: individueel bekijken, indien aannemelijk wordt het 1.
DO IF (atc1_T0='C02').
RECODE med1_keerperdag_T0 (SYSMIS=1).
RECODE med1_aantdagen_T0 (SYSMIS=90).
END IF.
DO IF (atc1_T0='C10AA01').
RECODE med1_keerperdag_T0 (SYSMIS=1).
RECODE med1_aantdagen_T0 (SYSMIS=90).
END IF.
DO IF (atc1_T0='N02BE01').
RECODE med1_keerperdag_T0 (SYSMIS=1).
RECODE med1_keerperdag_T0 (0=1).
RECODE med1_aantdagen_T0 (SYSMIS=1).
END IF.
DO IF (atc1_T0='N05BA04').
RECODE med1_keerperdag_T0 (0=1).
END IF.
DO IF (atc1_T0='R03AC02').
RECODE med1_keerperdag_T0 (0=1).
END IF.
DO IF (atc2_T0='C10').
RECODE med2_keerperdag_T0 (SYSMIS=1).
RECODE med2_aantdagen_T0 (SYSMIS=90).
END IF.
DO IF (atc2_T0='M01AE01').
RECODE med2_keerperdag_T0 (SYSMIS=1).
RECODE med2_aantdagen_T0 (SYSMIS=1).
END IF.
DO IF (atc2_T0='N02BE01').
RECODE med2_keerperdag_T0 (SYSMIS=1).
RECODE med2_keerperdag_T0 (0=1).
RECODE med2_aantdagen_T0 (SYSMIS=1).
END IF.
DO IF (atc2_T0='N05').
RECODE med2_keerperdag_T0 (SYSMIS=1).
RECODE med2_aantdagen_T0 (SYSMIS=1).
END IF.
DO IF (atc2_T0='N07BA03').
RECODE med2_keerperdag_T0 (SYSMIS=1).
END IF.
DO IF (atc2_T0='M05BX04').
RECODE med2_keerperdag_T0 (0=1).
END IF.
DO IF (atc2_T0='R03AC02').
RECODE med2_keerperdag_T0 (0=1).
END IF.
DO IF (atc2_T0='R03AC02').
RECODE med2_keerperdag_T0 (SYSMIS=1).
RECODE med2_aantdagen_T0 (SYSMIS=90).
END IF.
DO IF (atc3_T0='M05BB05').
RECODE med3_keerperdag_T0 (0=1).
END IF.
DO IF (atc3_T0='N05BA04').
RECODE med3_keerperdag_T0 (0=1).
END IF.
DO IF (atc3_T0='N02AJ13').
RECODE med3_keerperdag_T0 (SYSMIS=1).
RECODE med3_aantdagen_T0 (SYSMIS=1).
END IF.
DO IF (atc3_T0='N05BA04').
RECODE med3_keerperdag_T0 (SYSMIS=1).
RECODE med3_aantdagen_T0 (SYSMIS=1).
END IF.
DO IF (atc3_T0='N02BE01').
RECODE med3_keerperdag_T0 (SYSMIS=1).
RECODE med3_keerperdag_T0 (0=1).
RECODE med3_aantdagen_T0 (SYSMIS=1).
END IF.
DO IF (atc4_T0='N05CD07').
RECODE med4_keerperdag_T0 (SYSMIS=1).
RECODE med4_aantdagen_T0 (SYSMIS=1).
END IF.
DO IF (atc4_T0='M01AE01').
RECODE med4_keerperdag_T0 (SYSMIS=1).
RECODE med4_aantdagen_T0 (SYSMIS=1).
END IF.
DO IF (atc4_T0='M01AB05').
RECODE med4_keerperdag_T0 (SYSMIS=1).
RECODE med4_aantdagen_T0 (SYSMIS=1).
END IF.
DO IF (atc5_T0='C09CA01').
RECODE med5_keerperdag_T0 (SYSMIS=1).
RECODE med5_aantdagen_T0 (SYSMIS=90).
END IF.
DO IF (atc5_T0='N02BE01').
RECODE med5_keerperdag_T0 (SYSMIS=1).
RECODE med5_keerperdag_T0 (0=1).
RECODE med5_aantdagen_T0 (SYSMIS=1).
END IF.
DO IF (atc6_T0='M01AB05').
RECODE med6_keerperdag_T0 (SYSMIS=1).
RECODE med6_aantdagen_T0 (SYSMIS=1).
END IF.
DO IF (atc6_T0='N02BE01').
RECODE med6_keerperdag_T0 (0=1).
END IF.
DO IF (atc6_T0='M01AE01').
RECODE med6_keerperdag_T0 (0=1).
END IF.
DO IF (atc7_T0='M04AC01').
RECODE med7_keerperdag_T0 (SYSMIS=1).
RECODE med7_aantdagen_T0 (SYSMIS=90).
END IF.
DO IF (atc8_T0='N02BE01').
RECODE med8_keerperdag_T0 (0=1).
END IF.
DO IF (atc8_T0='A02BC01').
RECODE med8_keerperdag_T0 (SYSMIS=1).
RECODE med8_aantdagen_T0 (SYSMIS=90).
END IF.
DO IF (atc10_T0='C01DA08').
RECODE med10_keerperdag_T0 (0=1).
RECODE med10_aantdagen_T0 (0=1).
END IF.

**ID 3505 med 1 100x per dag  veranderd naar 1x per dag. 
DO IF (ID_code=3505).
RECODE med1_keerperdag_T0 (100=1).
END IF.

**ID 1815 med 1: 150x per dag. Betreft cholesterolverlagers op basis van visolie. Veranderen naar 1x per dag.
DO IF (ID_code=1815).
RECODE med1_keerperdag_T0 (150=1).
END IF.

** ID 2111 med 1. cholesterol 10x per dag (is zelfde als dosis 10 mg)  veranderd naar 1x per dag.
DO IF (ID_code=2111).
RECODE med1_keerperdag_T0 (10=1).
END IF.

** ID 3505 	Med 2: cabergoline: Bij keer per week in 25 ingevuld (=zelfde als dosering). Med wordt gewoonlijk 1x per week genomen, 
dit staat ook op T1  veranderen in 1 per dag (aantal dagen is 2).
DO IF (ID_code=3505).
RECODE med2_keerperdag_T0 (25=1).
END IF.

**ID 3505 med 3: keer per dag=13,8. Dit is de dosering, med wordt 1d genomen..
DO IF (ID_code=3505).
RECODE med3_keerperdag_T0 (SYSMIS=1).
END IF.

** ID 3905 Med 3: maagbeschermers. 7x per dag. Maagbeschermes meestal 1x per dag. Op T1 geen medicatie -->1 per dag.
DO IF (ID_code=3905).
RECODE med3_keerperdag_T0 (7=1).
END IF.

**ID 4109 med 2 200x per dag  veranderd naar 2x per dag. 
DO IF (ID_code=4109).
RECODE med2_keerperdag_T0 (200=2).
END IF.


** ID 4904 Aantal dagen bij alle medicijnen veel te veel
Med 1 metoprolol 30 dagen kan kloppen, staat ook op T1
Med 2 symbicort 1825 dagen? staat niet op T1, wel chronische medicatie --> 90 dagen
Med 3 atorvastatine 7300 dagen, staat ook op T1 --> 90 dagen
Med 4 irbesartan 10950 dagen, staat ook op T1 --> 90 dagen.
DO IF (ID_code=4904).
RECODE med2_aantdagen_T0 (1825=90).
RECODE med3_aantdagen_T0 (7300=90).
RECODE med4_aantdagen_T0 (10950=90).
END IF.

** ID 5103 med 4 en 5: 365 dagen --> 90 dagen.
DO IF (ID_code=5103).
RECODE med4_aantdagen_T0 (365=90).
RECODE med5_aantdagen_T0 (365=90).
END IF.

** ID 5608 med 2 injectie 0 dagen, 1 per dag: heeft er 1 gehad.
DO IF (ID_code=5608).
RECODE med2_keerperdag_T0 (0=1).
END IF.

COMPUTE med1_tot_aant_T0=med1_keerperdag_T0 * med1_aantdagen_T0.
COMPUTE med2_tot_aant_T0=med2_keerperdag_T0 * med2_aantdagen_T0.
COMPUTE med3_tot_aant_T0=med3_keerperdag_T0 * med3_aantdagen_T0.
COMPUTE med4_tot_aant_T0=med4_keerperdag_T0 * med4_aantdagen_T0.
COMPUTE med5_tot_aant_T0=med5_keerperdag_T0 * med5_aantdagen_T0.
COMPUTE med6_tot_aant_T0=med6_keerperdag_T0 * med6_aantdagen_T0.
COMPUTE med7_tot_aant_T0=med7_keerperdag_T0 * med7_aantdagen_T0.
COMPUTE med8_tot_aant_T0=med8_keerperdag_T0 * med8_aantdagen_T0.
COMPUTE med9_tot_aant_T0=med9_keerperdag_T0 * med9_aantdagen_T0.
COMPUTE med10_tot_aant_T0=med10_keerperdag_T0 * med10_aantdagen_T0.
EXECUTE.

FORMATS  med1_tot_aant_T0  med2_tot_aant_T0  med3_tot_aant_T0   
med4_tot_aant_T0 med5_tot_aant_T0 med6_tot_aant_T0 med7_tot_aant_T0 med8_tot_aant_T0 med9_tot_aant_T0 med10_tot_aant_T0 (F4.0).

******************************************************************************************************************************************************************************************.
** Totale kosten per medicijn.
******************************************************************************************************************************************************************************************.

*Med 1
* niet op recept.
DO IF med1_recept=0.
COMPUTE med1_tot_kosten_T0 = med1_tot_aant_T0 * med1_ppp.
END IF.
* chronisch op  recept.
DO IF med1_recept=1.
COMPUTE med1_tot_kosten_T0 = (med1_tot_aant_T0 * med1_ppp)+7.
END IF.
* niet chronisch op recept (antibiotica).
DO IF (CHAR.INDEX(atc1_T0,'J01')>0).
COMPUTE med1_tot_kosten_T0 = (med1_tot_aant_T0 * med1_ppp)+14.
END IF.
EXECUTE.

*Med 2
* niet op recept.
DO IF med2_recept=0.
COMPUTE med2_tot_kosten_T0 = med2_tot_aant_T0 * med2_ppp.
END IF.
* chronisch op  recept.
DO IF med2_recept=1.
COMPUTE med2_tot_kosten_T0 = (med2_tot_aant_T0 * med2_ppp)+7.
END IF.
* niet chronisch op recept (antibiotica).
DO IF (CHAR.INDEX(atc2_T0,'J01')>0).
COMPUTE med2_tot_kosten_T0 = (med2_tot_aant_T0 * med2_ppp)+14.
END IF.
EXECUTE.

*Med 3
* niet op recept.
DO IF med3_recept=0.
COMPUTE med3_tot_kosten_T0 = med3_tot_aant_T0 * med3_ppp.
END IF.
* chronisch op  recept.
DO IF med3_recept=1.
COMPUTE med3_tot_kosten_T0 = (med3_tot_aant_T0 * med3_ppp)+7.
END IF.
* niet chronisch op recept (antibiotica).
DO IF (CHAR.INDEX(atc3_T0,'J01')>0).
COMPUTE med3_tot_kosten_T0 = (med3_tot_aant_T0 * med3_ppp)+14.
END IF.
EXECUTE.

*Med 4
* niet op recept.
DO IF med4_recept=0.
COMPUTE med4_tot_kosten_T0 = med4_tot_aant_T0 * med4_ppp.
END IF.
* chronisch op  recept.
DO IF med4_recept=1.
COMPUTE med4_tot_kosten_T0 = (med4_tot_aant_T0 * med4_ppp)+7.
END IF.
* niet chronisch op recept (antibiotica).
DO IF (CHAR.INDEX(atc4_T0,'J01')>0).
COMPUTE med4_tot_kosten_T0 = (med4_tot_aant_T0 * med4_ppp)+14.
END IF.
EXECUTE.

*Med 5
* niet op recept.
DO IF med5_recept=0.
COMPUTE med5_tot_kosten_T0 = med5_tot_aant_T0 * med5_ppp.
END IF.
* chronisch op  recept.
DO IF med5_recept=1.
COMPUTE med5_tot_kosten_T0 = (med5_tot_aant_T0 * med5_ppp)+7.
END IF.
* niet chronisch op recept (antibiotica).
DO IF (CHAR.INDEX(atc5_T0,'J01')>0).
COMPUTE med5_tot_kosten_T0 = (med5_tot_aant_T0 * med5_ppp)+14.
END IF.
EXECUTE.

*Med 6
* niet op recept.
DO IF med6_recept=0.
COMPUTE med6_tot_kosten_T0 = med6_tot_aant_T0 * med6_ppp.
END IF.
* chronisch op  recept.
DO IF med6_recept=1.
COMPUTE med6_tot_kosten_T0 = (med6_tot_aant_T0 * med6_ppp)+7.
END IF.
* niet chronisch op recept (antibiotica).
DO IF (CHAR.INDEX(atc6_T0,'J01')>0).
COMPUTE med6_tot_kosten_T0 = (med6_tot_aant_T0 * med6_ppp)+14.
END IF.
EXECUTE.

*Med 7
* niet op recept.
DO IF med7_recept=0.
COMPUTE med7_tot_kosten_T0 = med7_tot_aant_T0 * med7_ppp.
END IF.
* chronisch op  recept.
DO IF med7_recept=1.
COMPUTE med7_tot_kosten_T0 = (med7_tot_aant_T0 * med7_ppp)+7.
END IF.
* niet chronisch op recept (antibiotica).
DO IF (CHAR.INDEX(atc7_T0,'J01')>0).
COMPUTE med7_tot_kosten_T0 = (med7_tot_aant_T0 * med7_ppp)+14.
END IF.
EXECUTE.

*Med 8
* niet op recept.
DO IF med8_recept=0.
COMPUTE med8_tot_kosten_T0 = med8_tot_aant_T0 * med8_ppp.
END IF.
* chronisch op  recept.
DO IF med8_recept=1.
COMPUTE med8_tot_kosten_T0 = (med8_tot_aant_T0 * med8_ppp)+7.
END IF.
* niet chronisch op recept (antibiotica).
DO IF (CHAR.INDEX(atc8_T0,'J01')>0).
COMPUTE med8_tot_kosten_T0 = (med8_tot_aant_T0 * med8_ppp)+14.
END IF.
EXECUTE.

*Med 9
* niet op recept.
DO IF med9_recept=0.
COMPUTE med9_tot_kosten_T0 = med9_tot_aant_T0 * med9_ppp.
END IF.
* chronisch op  recept.
DO IF med9_recept=1.
COMPUTE med9_tot_kosten_T0 = (med9_tot_aant_T0 * med9_ppp)+7.
END IF.
* niet chronisch op recept (antibiotica).
DO IF (CHAR.INDEX(atc9_T0,'J01')>0).
COMPUTE med9_tot_kosten_T0 = (med9_tot_aant_T0 * med9_ppp)+14.
END IF.
EXECUTE.

*Med 10
* niet op recept.
DO IF med10_recept=0.
COMPUTE med10_tot_kosten_T0 = med10_tot_aant_T0 * med10_ppp.
END IF.
* chronisch op  recept.
DO IF med10_recept=1.
COMPUTE med10_tot_kosten_T0 = (med10_tot_aant_T0 * med10_ppp)+7.
END IF.
* niet chronisch op recept (antibiotica).
DO IF (CHAR.INDEX(atc10_T0,'J01')>0).
COMPUTE med10_tot_kosten_T0 = (med10_tot_aant_T0 * med10_ppp)+14.
END IF.
EXECUTE.

** stoppen met roken medicatie wordt appart berekend: Bij totale med prijs=0.
** Champix N07BA03 en Zyban N06AX12.

DO IF (atc1_T0='N07BA03' or atc1_T0='N06AX12').
COMPUTE med1_tot_kosten_T0=0.
COMPUTE med1_roken_kosten_T0= (med1_tot_aant_T0 * med1_ppp)+14.
END IF.
DO IF (atc2_T0='N07BA03' or atc2_T0='N06AX12').
COMPUTE med2_tot_kosten_T0 =0.
COMPUTE med2_roken_kosten_T0= (med2_tot_aant_T0 * med2_ppp)+14.
END IF.
DO IF (atc3_T0='N07BA03' or atc3_T0='N06AX12').
COMPUTE med3_tot_kosten_T0 =0.
COMPUTE med3_roken_kosten_T0= (med3_tot_aant_T0 * med3_ppp)+14.
END IF.
DO IF (atc4_T0='N07BA03' or atc4_T0='N06AX12').
COMPUTE med4_tot_kosten_T0 = 0.
COMPUTE med4_roken_kosten_T0= (med4_tot_aant_T0 * med4_ppp)+14.
END IF.
DO IF (atc5_T0='N07BA03' or atc5_T0='N06AX12').
COMPUTE med5_tot_kosten_T0 = 0.
COMPUTE med5_roken_kosten_T0= (med5_tot_aant_T0 * med5_ppp)+14.
END IF.
DO IF (atc6_T0='N07BA03' or atc6_T0='N06AX12').
COMPUTE med6_tot_kosten_T0 = 0.
COMPUTE med6_roken_kosten_T0= (med6_tot_aant_T0 * med6_ppp)+14.
END IF.
DO IF (atc7_T0='N07BA03' or atc7_T0='N06AX12').
COMPUTE med7_tot_kosten_T0 = 0.
COMPUTE med7_roken_kosten_T0= (med7_tot_aant_T0 * med7_ppp)+14.
END IF.
DO IF (atc8_T0='N07BA03' or atc8_T0='N06AX12').
COMPUTE med8_tot_kosten_T0 = 0.
COMPUTE med8_roken_kosten_T0= (med8_tot_aant_T0 * med8_ppp)+14.
END IF.
DO IF (atc9_T0='N07BA03' or atc9_T0='N06AX12').
COMPUTE med9_tot_kosten_T0 = 0.
COMPUTE med9_roken_kosten_T0= (med9_tot_aant_T0 * med9_ppp)+14.
END IF.
DO IF (atc10_T0='N07BA03' or atc10_T0='N06AX12').
COMPUTE med10_tot_kosten_T0 = 0.
COMPUTE med10_roken_kosten_T0= (med10_tot_aant_T0 * med10_ppp)+14.
END IF.
EXECUTE.


*** Invullen totale kosten voor medicijnen waar dit niet berekend kon worden. Bij totaal zit ook al dan niet afleverkosten.

DO IF (med1_T0='cholesterol verlagers op basis van visolie').
RECODE med1_tot_kosten_T0 (SYSMIS=5.99).
RECODE med1_recept (SYSMIS=0).
END IF.
DO IF (med2_T0='Medicijn tegen zonneallergie').
RECODE med2_tot_kosten_T0 (SYSMIS=10.00).
RECODE med2_recept (SYSMIS=0).
END IF.
DO IF (med2_T0='creme').
RECODE med2_tot_kosten_T0 (SYSMIS=3.00).
RECODE med2_recept (SYSMIS=0).
END IF.
DO IF (med2_T0='bethamethason').
RECODE med2_tot_kosten_T0 (SYSMIS=9.88).
RECODE med2_recept (SYSMIS=1).
END IF.
DO IF (med2_T0='Diprosalic Betamethason').
RECODE med2_tot_kosten_T0 (SYSMIS=9.06).
RECODE med2_recept (SYSMIS=1).
END IF.
DO IF (med2_T0='PROTOPIC zalf').
RECODE med2_tot_kosten_T0 (SYSMIS=31.77).
RECODE med2_recept (SYSMIS=1).
END IF.
DO IF (med2_T0='Amigran').
RECODE med2_tot_kosten_T0 (SYSMIS=14.91).
RECODE med2_recept (SYSMIS=1).
END IF.
DO IF (med3_T0='Stediril 30').
RECODE med3_tot_kosten_T0 (SYSMIS=13.30).
RECODE med3_recept (SYSMIS=1).
END IF.
DO IF (med3_T0='oordruppels').
RECODE med3_tot_kosten_T0 (SYSMIS=5.50).
RECODE med3_recept (SYSMIS=0).
END IF.
DO IF (med3_T0='Neusdruppels').
RECODE med3_tot_kosten_T0 (SYSMIS=2.69).
RECODE med3_recept (SYSMIS=0).
END IF.
DO IF (med3_T0='dermovate').
RECODE med3_tot_kosten_T0 (SYSMIS=10.83).
RECODE med3_recept (SYSMIS=1).
END IF.
DO IF (med3_T0='Cutivate creme').
RECODE med3_tot_kosten_T0 (SYSMIS=11.07).
RECODE med3_recept (SYSMIS=1).
END IF.
DO IF (med3_T0='anti conceptie').
RECODE med3_tot_kosten_T0 (SYSMIS=13.30).
RECODE med3_recept (SYSMIS=1).
END IF.
DO IF (med4_T0='hydrofiele creme').
RECODE med4_tot_kosten_T0 (SYSMIS=2.99).
RECODE med4_recept (SYSMIS=0).
END IF.
DO IF (med5_T0='nicotinespre').
RECODE med5_tot_kosten_T0 (SYSMIS=28.57).
RECODE med5_recept (SYSMIS=0).
END IF.
DO IF (med5_T0='De pil').
RECODE med5_tot_kosten_T0 (SYSMIS=13.30).
RECODE med5_recept (SYSMIS=1).
END IF.
DO IF (med7_T0='q10').
RECODE med7_tot_kosten_T0 (SYSMIS=9.99).
RECODE med7_recept (SYSMIS=0).
END IF.

DO IF (atc1_T0='A11CC').
RECODE med1_tot_kosten_T0 (SYSMIS=2.50).
RECODE med1_recept (SYSMIS=0).
END IF.
DO IF (atc2_T0='A11CC').
RECODE med2_tot_kosten_T0 (SYSMIS=2.50).
RECODE med2_recept (SYSMIS=0).
END IF.
DO IF (atc2_T0='A11').
RECODE med2_tot_kosten_T0 (SYSMIS=3.50).
RECODE med2_recept (SYSMIS=0).
END IF.
DO IF (med3_T0='vitamines').
RECODE med3_tot_kosten_T0 (SYSMIS=3.50).
RECODE med3_recept (SYSMIS=0).
END IF.
DO IF (atc3_T0='A11').
RECODE med3_tot_kosten_T0 (SYSMIS=3.50).
RECODE med3_recept (SYSMIS=0).
END IF.
DO IF (atc4_T0='A11CC').
RECODE med4_tot_kosten_T0 (SYSMIS=2.50).
RECODE med4_recept (SYSMIS=0).
END IF.
DO IF (atc4_T0='A11').
RECODE med4_tot_kosten_T0 (SYSMIS=3.50).
RECODE med4_recept (SYSMIS=0).
END IF.
DO IF (atc5_T0='A11CC').
RECODE med5_tot_kosten_T0 (SYSMIS=2.50).
RECODE med5_recept (SYSMIS=0).
END IF.
DO IF (atc6_T0='A11CC').
RECODE med6_tot_kosten_T0 (SYSMIS=2.50).
RECODE med6_recept (SYSMIS=0).
END IF.

DO IF (atc1_T0='C02').
RECODE med1_tot_kosten_T0 (SYSMIS=8.80).
END IF.

DO IF (atc1_T0='J01').
RECODE med1_tot_kosten_T0 (SYSMIS=15.26).
END IF.
DO IF (atc2_T0='J01').
RECODE med2_tot_kosten_T0 (SYSMIS=15.26).
END IF.
DO IF (atc3_T0='J01').
RECODE med3_tot_kosten_T0 (SYSMIS=15.26).
END IF.
DO IF (atc4_T0='J01').
RECODE med4_tot_kosten_T0 (SYSMIS=15.26).
END IF.
DO IF (atc5_T0='J01').
RECODE med5_tot_kosten_T0 (SYSMIS=15.26).
END IF.
DO IF (atc8_T0='J01').
RECODE med8_tot_kosten_T0 (SYSMIS=15.26).
END IF.
DO IF (atc9_T0='J01').
RECODE med9_tot_kosten_T0 (SYSMIS=15.26).
END IF.
EXECUTE.

DO IF (atc3_T0='S01BA04').
RECODE med3_tot_kosten_T0 (SYSMIS=7.82).
RECODE med3_recept (SYSMIS=1).
END IF.
EXECUTE.

*ID 3902. Ingevuld 1x per dag, 2 dagen,  2 injecties gehad (worden doorgaans om de 6-8 weken gegeven). 
*Prijs: 1 injectieflacon van 100 mg kost 545,39 euro.
DO IF (ID_code=3902).
RECODE med3_tot_kosten_T0 (SYSMIS=1097.78).
RECODE med3_recept (SYSMIS=1).
END IF.
EXECUTE.


**** totale medicatie kosten***************************************************************************************************************************************.

COMPUTE kosten_med_tot_T0=SUM(med1_tot_kosten_T0,med2_tot_kosten_T0,med3_tot_kosten_T0, med4_tot_kosten_T0,
  med5_tot_kosten_T0,med6_tot_kosten_T0,med7_tot_kosten_T0,med8_tot_kosten_T0, med9_tot_kosten_T0,med10_tot_kosten_T0).
EXECUTE.

COMPUTE kosten_med_roken_T0=SUM(med1_roken_kosten_T0,  med2_roken_kosten_T0, med3_roken_kosten_T0, med4_roken_kosten_T0,
 med5_roken_kosten_T0,  med6_roken_kosten_T0,  med7_roken_kosten_T0,  med8_roken_kosten_T0,  med9_roken_kosten_T0,  med10_roken_kosten_T0).
EXECUTE.


*Indien Medicatie=missing.
DO IF MISSING(medicatie_T0)=1.
RECODE kosten_med_tot_T0 kosten_med_roken_T0 (SYSMIS=99999).
END IF.
EXECUTE.
* Indien alleen andere mediciatie en geen stoppen met roken medicatie.
DO IF kosten_med_tot_T0>0.
RECODE kosten_med_roken_T0 (SYSMIS=0).
END IF.
EXECUTE.
*Indien Medicatie=ja, maar geen medicijnen ingevuld: kosten = missing.
DO IF medicatie_T0=2 and med1_T0=''.
RECODE kosten_med_tot_T0 kosten_med_roken_T0 (SYSMIS=99999).
END IF.
EXECUTE.
* Indien geen medicatie: kosten=0.
DO IF medicatie_T0=1.
RECODE kosten_med_tot_T0 kosten_med_roken_T0 (SYSMIS=0).
END IF.
EXECUTE.

MISSING VALUES kosten_med_tot_T0  kosten_med_roken_T0 (99999).
VARIABLE WIDTH kosten_med_tot_T0  kosten_med_roken_T0 (8).

DELETE VARIABLES med1_roken_kosten_T0  med2_roken_kosten_T0 med3_roken_kosten_T0 med4_roken_kosten_T0
 med5_roken_kosten_T0 med6_roken_kosten_T0 med7_roken_kosten_T0 med8_roken_kosten_T0 med9_roken_kosten_T0  med10_roken_kosten_T0.


