* Encoding: UTF-8.
** helemaal runnen. Hij geeft (soms) foutmelding (the second argument to the ....), dit negeren.


STRING med1_dosis_T3 (A20).
STRING med1_eenheid_T3 (A20).
STRING med2_dosis_T3 (A20).
STRING med2_eenheid_T3 (A20).
STRING med3_dosis_T3 (A20).
STRING med3_eenheid_T3 (A20).
STRING med4_dosis_T3 (A20).
STRING med4_eenheid_T3 (A20).
STRING med5_dosis_T3 (A20).
STRING med5_eenheid_T3 (A20).
STRING med6_dosis_T3 (A20).
STRING med6_eenheid_T3 (A20).
STRING med7_dosis_T3 (A20).
STRING med7_eenheid_T3 (A20).
STRING med8_dosis_T3 (A20).
STRING med8_eenheid_T3 (A20).
STRING med9_dosis_T3 (A20).
STRING med9_eenheid_T3 (A20).
STRING med10_dosis_T3 (A20).
STRING med10_eenheid_T3 (A20).

VARIABLE WIDTH med1_eenheid_T3 med2_eenheid_T3  med3_eenheid_T3 med4_eenheid_T3 med5_eenheid_T3 med6_eenheid_T3
med7_eenheid_T3 med8_eenheid_T3 med9_eenheid_T3 med10_eenheid_T3  (7).
VARIABLE WIDTH med1_dosis_T3 med2_dosis_T3  med3_dosis_T3 med4_dosis_T3 med5_dosis_T3 med6_dosis_T3
med7_dosis_T3 med8_dosis_T3 med9_dosis_T3 med10_dosis_T3 (10).


**ATC V01AA02.
IF  (atc1_T3='V01AA02') med1_eenheid_T3='iE'.
IF  (atc1_T3='V01AA02' and med1_dosering_T3='') med1_dosis_T3='300'.
**ATC R06AE07.
IF  (atc1_T3='R06AE07') med1_eenheid_T3='mg'.
IF  (atc1_T3='R06AE07' and CHAR.INDEX(med1_dosering_T3,'10')>0 ) med1_dosis_T3='10'.
IF  (atc2_T3='R06AE07') med2_eenheid_T3='mg'.
IF  (atc2_T3='R06AE07' and CHAR.INDEX(med2_dosering_T3,'10')>0 ) med2_dosis_T3='10'.
IF  (atc3_T3='R06AE07') med3_eenheid_T3='mg'.
IF  (atc3_T3='R06AE07' and CHAR.INDEX(med3_dosering_T3,'10')>0 ) med3_dosis_T3='10'.
IF  (atc5_T3='R06AE07') med5_eenheid_T3='mg'.
IF  (atc5_T3='R06AE07' and CHAR.INDEX(med5_dosering_T3,'20')>0 ) med5_dosis_T3='2x10'.
**ATC R06AX27.- Aereus.
IF  (atc2_T3='R06AX27') med2_eenheid_T3='mg'.
IF  (atc2_T3='R06AX27' and CHAR.INDEX(med2_dosering_T3,'5')>0 ) med2_dosis_T3='5'.
IF  (atc3_T3='R06AX27') med3_eenheid_T3='mg'.
IF  (atc3_T3='R06AX27' and CHAR.INDEX(med3_dosering_T3,'10')>0 ) med3_dosis_T3=''.
IF  (atc3_T3='R06AX27' and CHAR.INDEX(med3_dosering_T3,'20')>0 ) med3_dosis_T3=''.
IF  (atc4_T3='R06AX27') med4_eenheid_T3='mg'.
IF  (atc4_T3='R06AX27' and CHAR.INDEX(med4_dosering_T3,'')>0 ) med4_dosis_T3=''.
**ATC R06AX25.
IF  (atc5_T3='R06AX25') med5_eenheid_T3='mg'.
IF  (atc5_T3='R06AX25' and CHAR.INDEX(med5_dosering_T3,'10')>0 ) med5_dosis_T3='10'.
**ATC R06AX13.
IF  (atc1_T3='R06AX13') med1_eenheid_T3='mg'.
IF  (atc1_T3='R06AX13' and CHAR.INDEX(med1_dosering_T3,'10')>0 ) med1_dosis_T3='10'.
**ATC R05DA04 - codeine.
IF  (atc3_T3='R05DA04') med3_eenheid_T3='mg'.
IF  (atc3_T3='R05DA04' and CHAR.INDEX(med3_dosering_T3,'10')>0 ) med3_dosis_T3='10'.
**ATC R05CB02 - broomhexine.
IF  (atc4_T3='R05CB02' and med4_vorm_T3='vloeistof') med4_eenheid_T3='mg/ml'.
IF  (atc4_T3='R05CB02' and med4_vorm_T3='vloeistof') med4_dosis_T3='drankje'.
**ATC R05CB01 - fluimicil.
IF  (atc1_T3='R05CB01' and med1_vorm_T3='tablet') med1_eenheid_T3='mg'.
IF  (atc1_T3='R05CB01' and med1_vorm_T3='bruistablet') med1_eenheid_T3='mg'.
IF  (atc2_T3='R05CB01' and CHAR.INDEX(med2_dosering_T3,'600')>0 ) med2_eenheid_T3='mg'.
IF  (atc2_T3='R05CB01' and CHAR.INDEX(med2_dosering_T3,'600')>0 ) med2_dosis_T3='600'.
**ATC R03DC03 - montelukast .
IF  (atc7_T3='R03DC03') med7_eenheid_T3='mg'.
IF  (atc7_T3='R03DC03' and CHAR.INDEX(med7_dosering_T3,'10')>0 ) med7_dosis_T3='10'.
**ATC R03CC02 - salbutamol - ventolin.
IF  (atc1_T3='R03CC02') med1_eenheid_T3='ug/dosis'.
IF  (atc1_T3='R03CC02' and CHAR.INDEX(med1_dosering_T3,'100')>0 ) med1_dosis_T3='100'.
IF  (atc1_T3='R03CC02' and CHAR.INDEX(med1_dosering_T3,'250')>0 ) med1_dosis_T3='250'.
IF  (atc1_T3='R03CC02' and CHAR.INDEX(med1_dosering_T3,'200')>0 ) med1_dosis_T3='200'.
IF  (atc2_T3='R03CC02') med2_eenheid_T3='ug/dosis of per ml'.
IF  (atc2_T3='R03CC02' and CHAR.INDEX(med2_dosering_T3,'250')>0 ) med2_dosis_T3='250'.
IF  (atc2_T3='R03CC02' and CHAR.INDEX(med2_dosering_T3,'200')>0 ) med2_dosis_T3='200'.
IF  (atc2_T3='R03CC02' and CHAR.INDEX(med2_dosering_T3,'100')>0 ) med2_dosis_T3='100'.
IF  (atc2_T3='R03CC02' and CHAR.INDEX(med2_dosering_T3,'5')>0 ) med2_dosis_T3='5 (vloeistof)'.
IF  (atc3_T3='R03CC02') med3_eenheid_T3='ug/dosis'.
IF  (atc3_T3='R03CC02' and CHAR.INDEX(med3_dosering_T3,'200')>0 ) med3_dosis_T3='200'.
IF  (atc4_T3='R03CC02') med4_eenheid_T3='ug/dosis'.
IF  (atc4_T3='R03CC02' and CHAR.INDEX(med4_dosering_T3,'200')>0 ) med4_dosis_T3='200'.
IF  (atc5_T3='R03CC02') med5_eenheid_T3='ug/dosis'.
**ATC R03BB04 - spiriva.
IF  (atc1_T3='R03BB04') med1_eenheid_T3='ug'.
IF  (atc1_T3='R03BB04' and CHAR.INDEX(med1_dosering_T3,'18')>0 ) med1_dosis_T3='18'.
IF  (atc2_T3='R03BB04') med2_eenheid_T3='ug'.
IF  (atc2_T3='R03BB04' and CHAR.INDEX(med2_dosering_T3,'18')>0 ) med2_dosis_T3='18'.
IF  (atc2_T3='R03BB04' and CHAR.INDEX(med2_dosering_T3,'5')>0 ) med2_dosis_T3='2x2,5 vloeistof'.
IF  (atc3_T3='R03BB04') med3_eenheid_T3='ug'.
IF  (atc3_T3='R03BB04' and CHAR.INDEX(med3_dosering_T3,'18')>0 ) med3_dosis_T3='18'.
IF  (atc4_T3='R03BB04') med4_eenheid_T3='ug'.
IF  (atc4_T3='R03BB04' and CHAR.INDEX(med4_dosering_T3,'18')>0 ) med4_dosis_T3='18'.
**ATC R03BB01 - atrovent.
IF  (atc3_T3='R03BB01') med3_eenheid_T3='mg'.
**ATC R03BA05 - flixotide/fluticason.
IF  (atc2_T3='R03BA05') med2_eenheid_T3='ug/dosis'.
IF  (atc3_T3='R03BA05') med3_eenheid_T3='ug/dosis'.
IF  (atc3_T3='R03BA05' and CHAR.INDEX(med3_dosering_T3,'250')>0 ) med3_dosis_T3='250'.
**ATC R03BA02 - pulmicort.
IF  (atc1_T3='R03BA02') med1_eenheid_T3='ug/dosis'.
IF  (atc1_T3='R03BA02' and CHAR.INDEX(med1_dosering_T3,'50')>0 ) med1_dosis_T3='200'.
**ATC R03BA01 - beclamethason.
IF  (atc1_T3='R03BA01') med1_eenheid_T3='ug/dosis'.
IF  (atc1_T3='R03BA01' and CHAR.INDEX(med1_dosering_T3,'150')>0 ) med1_dosis_T3='50'.
IF  (atc2_T3='R03BA01') med2_eenheid_T3='ug/dosis'.
IF  (atc2_T3='R03BA01' and CHAR.INDEX(med2_dosering_T3,'50')>0 ) med2_dosis_T3='50'.
IF  (atc3_T3='R03BA01') med3_eenheid_T3='ug/dosis'.
IF  (atc3_T3='R03BA01' and CHAR.INDEX(med3_dosering_T3,'50')>0 ) med3_dosis_T3='50'.
IF  (atc8_T3='R03BA01') med8_eenheid_T3='ug/dosis'.
IF  (atc8_T3='R03BA01' and CHAR.INDEX(med8_dosering_T3,'0,2')>0 ) med8_dosis_T3='200 (poeder)'.
**ATC R03AK10 Relvar.
IF  (atc1_T3='R03AK10') med1_eenheid_T3='ug/dosis'.
IF  (atc1_T3='R03AK10' and CHAR.INDEX(med1_dosering_T3,'92/22')>0 ) med1_dosis_T3='92/22'.
IF  (atc2_T3='R03AK10') med2_eenheid_T3='ug/dosis'.
IF  (atc2_T3='R03AK10' and CHAR.INDEX(med2_dosering_T3,'92/22')>0 ) med2_dosis_T3='92/22'.
IF  (atc7_T3='R03AK10') med7_eenheid_T3='ug/dosis'.
IF  (atc7_T3='R03AK10' and CHAR.INDEX(med6_dosering_T3,'175')>0 ) med6_dosis_T3=' '.
**ATC R03AK08-foster.
IF  (atc1_T3='R03AK08') med1_eenheid_T3='ug/dosis'.
IF  (atc1_T3='R03AK08' and CHAR.INDEX(med1_dosering_T3,'1')>0 ) med1_dosis_T3=''.
**ATC R03AK07-symbicort.
IF  (atc1_T3='R03AK07') med1_eenheid_T3='ug/dosis'.
IF  (atc1_T3='R03AK07' and CHAR.INDEX(med1_dosering_T3,'12')>0 ) med1_dosis_T3='400/12'.
IF  (atc2_T3='R03AK07') med2_eenheid_T3='ug/dosis'.
IF  (atc2_T3='R03AK07' and CHAR.INDEX(med2_dosering_T3,'100')>0 ) med2_dosis_T3='100/6'.
IF  (atc3_T3='R03AK07') med3_eenheid_T3='ug/dosis'.
IF  (atc3_T3='R03AK07' and CHAR.INDEX(med3_dosering_T3,'200')>0 ) med3_dosis_T3='200/6'.
**ATC R03AK06 - seretide (salmeterol/fluticason).
IF  (atc1_T3='R03AK06') med1_eenheid_T3='ug/dosis'.
IF  (atc1_T3='R03AK06' and CHAR.INDEX(med1_dosering_T3,'50')>0 ) med1_dosis_T3='50/?'.
IF  (atc1_T3='R03AK06' and CHAR.INDEX(med1_dosering_T3,'500/50')>0 ) med1_dosis_T3='50/500'.
IF  (atc1_T3='R03AK06' and ID_code=2512 ) med1_dosis_T3='25/250'.
IF  (atc2_T3='R03AK06') med2_eenheid_T3='ug/dosis'.
IF  (atc2_T3='R03AK06' and CHAR.INDEX(med2_dosering_T3,'50/500')>0 ) med2_dosis_T3='50/500'.
IF  (atc3_T3='R03AK06') med3_eenheid_T3='ug/dosis'.
IF  (atc3_T3='R03AK06' and CHAR.INDEX(med3_dosering_T3,'500')>0 ) med3_dosis_T3='50/500'.
IF  (atc4_T3='R03AK06') med4_eenheid_T3='ug/dosis'.
IF  (atc4_T3='R03AK06' and CHAR.INDEX(med4_dosering_T3,'25 mg 2 pufjes')>0 ) med4_dosis_T3='2x25/125'.
**ATC R03AC13.
IF  (atc1_T3='R03AC13') med1_eenheid_T3='ug/dosis'.
IF  (atc1_T3='R03AC13' and CHAR.INDEX(med1_dosering_T3,'24')>0 ) med1_dosis_T3='12'.
IF  (atc2_T3='R03AC13') med2_eenheid_T3='ug/dosis'.
IF  (atc2_T3='R03AC13' and CHAR.INDEX(med2_dosering_T3,'0.12')>0 ) med2_dosis_T3='12'.
**ATC R03AC12- salmeterol.
IF  (atc5_T3='R03AC12') med5_eenheid_T3='ug/dosis'.
IF  (atc5_T3='R03AC12' and CHAR.INDEX(med5_dosering_T3,'25/250')>0 ) med5_dosis_T3='12'.
**ATC R03AC02 - ventolin/salbutamol.
IF  (atc1_T3='R03AC02') med1_eenheid_T3='ug'.
IF  (atc1_T3='R03AC02' and CHAR.INDEX(med1_dosering_T3,'200')>0 ) med1_dosis_T3='200'.
IF  (atc1_T3='R03AC02' and CHAR.INDEX(med1_dosering_T3,'100')>0 ) med1_dosis_T3='100'.
IF  (atc1_T3='R03AC02' and CHAR.INDEX(med1_dosering_T3,'300')>0 ) med1_dosis_T3='100'.
IF  (atc2_T3='R03AC02') med2_eenheid_T3='ug'.
IF  (atc2_T3='R03AC02' and CHAR.INDEX(med2_dosering_T3,'125')>0 ) med2_dosis_T3=''.
IF  (atc2_T3='R03AC02' and CHAR.INDEX(med2_dosering_T3,'50')>0 ) med2_dosis_T3=''.
IF  (atc3_T3='R03AC02') med3_eenheid_T3='ug'.
IF  (atc3_T3='R03AC02' and CHAR.INDEX(med3_dosering_T3,'100')>0 ) med3_dosis_T3='100'.
IF  (atc4_T3='R03AC02') med4_eenheid_T3='ug'.
IF  (atc4_T3='R03AC02' and CHAR.INDEX(med4_dosering_T3,'100')>0 ) med4_dosis_T3='100'.
IF  (atc4_T3='R03AC02' and CHAR.INDEX(med4_dosering_T3,'200')>0 ) med4_dosis_T3='200'.
**ATC R03AC03.
IF  (atc2_T3='R03AC03' and CHAR.INDEX(med2_dosering_T3,'100')>0 ) med2_dosis_T3='500'.
**ATC R02AX01- .
IF  (atc3_T3='R02AX01') med3_eenheid_T3='mg'.
IF  (atc3_T3='R02AX01' and CHAR.INDEX(med3_dosering_T3,'8,75')>0 ) med3_dosis_T3='8,75'.
**ATC R02AA03- strepsils.
IF  (atc1_T3='R02AA03') med1_eenheid_T3='mg'.
* dosering1= 1 tablet, is altijd 0,6/1,2 mg.
IF  (atc1_T3='R02AA03' and CHAR.INDEX(med1_dosering_T3,'1')>0 ) med1_dosis_T3='0,6/1,2'.
**ATC R01AX06- .
IF  (atc1_T3='R01AX06') med1_eenheid_T3='mg/g'.
IF  (atc1_T3='R01AX06') med1_dosis_T3='20'.
**ATC R01AD12.
IF  (atc1_T3='R01AD12') med1_eenheid_T3='ug/dosis'.
IF  (atc1_T3='R01AD12' and CHAR.INDEX(med1_dosering_T3,'27,5')>0 ) med1_dosis_T3='27.5'.
**ATC R01AD08 - fluticason.
IF  (atc2_T3='R01AD08') med2_eenheid_T3='ug/dosis'.
IF  (atc2_T3='R01AD08' and CHAR.INDEX(med2_dosering_T3,'50')>0 ) med2_dosis_T3='50 (spray)'.
IF  (atc5_T3='R01AD08') med5_eenheid_T3='ug/dosis'.
IF  (atc5_T3='R01AD08' and CHAR.INDEX(med5_dosering_T3,'50')>0 ) med5_dosis_T3='50 (spray)'.
**ATC R01AD05 - budesonide.
IF  (atc2_T3='R01AD05') med2_eenheid_T3='ug/dosis'.
IF  (atc2_T3='R01AD05' and CHAR.INDEX(med2_dosering_T3,'100')>0 ) med2_dosis_T3='100 (spray)'.
**ATC S01AA01 - .
IF  (atc1_T3='S01AA01') med1_eenheid_T3='mg/ml'.
IF  (atc1_T3='S01AA01' and CHAR.INDEX(med1_dosering_T3,'4')>0 ) med1_dosis_T3='4'.
IF  (atc2_T3='S01AA01') med2_eenheid_T3='mg/g'.
IF  (atc2_T3='S01AA01' and CHAR.INDEX(med2_dosering_T3,'10')>0 ) med2_dosis_T3='10'.
**ATC P01AB01.
IF  (atc3_T3='P01AB01') med3_eenheid_T3='mg'.
IF  (atc3_T3='P01AB01' and CHAR.INDEX(med3_dosering_T3,'500')>0 ) med3_dosis_T3='500'.
** ATC N07XX09-.
IF  (atc2_T3='N07XX09') med2_eenheid_T3='mg'.
IF  (atc2_T3='N07XX09' and CHAR.INDEX(med2_dosering_T3,'x')>0 ) med2_dosis_T3='2x120'.
** ATC N07BA03- champix.
IF  (atc1_T3='N07BA03') med1_eenheid_T3='mg'.
IF  (atc1_T3='N07BA03' and CHAR.INDEX(med1_dosering_T3,'1')>0 ) med1_dosis_T3='1'.
IF  (atc1_T3='N07BA03' and CHAR.INDEX(med1_dosering_T3,'10mg')>0 ) med1_dosis_T3='1'.
IF  (atc1_T3='N07BA03' and CHAR.INDEX(med1_dosering_T3,'100mg')>0 ) med1_dosis_T3='1'.
IF  (atc1_T3='N07BA03' and med1_dosering_T3='2') med1_dosis_T3='2x1'.
* geeft al aan 2x per dag:.
IF  (ID_Code=7107 and atc1_T3='N07BA03' and med1_dosering_T3='2 per dag') med1_dosis_T3=''.
IF  (atc1_T3='N07BA03' and med1_dosering_T3='2mg') med1_dosis_T3='2x1'.
IF  (atc1_T3='N07BA03' and med1_dosering_T3='2mp') med1_dosis_T3='2x1'.
IF  (atc1_T3='N07BA03' and med1_dosering_T3='2 mg') med1_dosis_T3='2x1'.
IF  (atc1_T3='N07BA03' and med1_dosering_T3='200') med1_dosis_T3='2x1'.
IF  (atc1_T3='N07BA03' and CHAR.INDEX(med1_dosering_T3,'2 x1mg p/d')>0 ) med1_dosis_T3='2x1'.
IF  (atc1_T3='N07BA03' and CHAR.INDEX(med1_dosering_T3,'0,5')>0 ) med1_dosis_T3='0.5'.
IF  (atc1_T3='N07BA03' and CHAR.INDEX(med1_dosering_T3,'5')>0 ) med1_dosis_T3='0.5'.
* geeft al aan 2x per dag:.
IF  (ID_Code=1405 and atc1_T3='N07BA03' and CHAR.INDEX(med1_dosering_T3,'4')>0 ) med1_dosis_T3='2x1'.
IF  (atc1_T3='N07BA03' and CHAR.INDEX(med1_dosering_T3,'2x')>0 ) med1_dosis_T3=' '.
IF  (atc1_T3='N07BA03' and CHAR.INDEX(med1_dosering_T3,'200')>0 ) med1_dosis_T3=' '.
IF  (atc1_T3='N07BA03' and CHAR.INDEX(med1_dosering_T3,'0.5')>0 ) med1_dosis_T3='0.5'.
IF  (atc2_T3='N07BA03') med2_eenheid_T3='mg'.
IF  (atc2_T3='N07BA03' and CHAR.INDEX(med2_dosering_T3,'1')>0 ) med2_dosis_T3='1'.
IF  (atc2_T3='N07BA03' and CHAR.INDEX(med2_dosering_T3,'2')>0) med2_dosis_T3='2x1'.
IF  (atc2_T3='N07BA03' and CHAR.INDEX(med2_dosering_T3,'5')>0) med2_dosis_T3='0.5'.
IF  (atc3_T3='N07BA03') med3_eenheid_T3='mg'.
IF  (atc3_T3='N07BA03' and CHAR.INDEX(med3_dosering_T3,'1')>0 ) med3_dosis_T3='1'.
IF  (atc3_T3='N07BA03' and CHAR.INDEX(med3_dosering_T3,'2')>0) med3_dosis_T3='2x1'.
IF  (atc3_T3='N07BA03' and CHAR.INDEX(med3_dosering_T3,'5')>0) med3_dosis_T3='0.5'.
IF  (atc4_T3='N07BA03') med4_eenheid_T3='mg'.
IF  (atc4_T3='N07BA03' and CHAR.INDEX(med4_dosering_T3,'1')>0 ) med4_dosis_T3='1'.
IF  (atc4_T3='N07BA03' and CHAR.INDEX(med4_dosering_T3,'2')>0) med4_dosis_T3='2x1'.
IF  (atc6_T3='N07BA03') med6_eenheid_T3='mg'.
IF  (atc6_T3='N07BA03' and CHAR.INDEX(med6_dosering_T3,'1')>0 ) med6_dosis_T3='1'.
IF  (atc8_T3='N07BA03') med8_eenheid_T3='mg'.
IF  (atc8_T3='N07BA03' and CHAR.INDEX(med8_dosering_T3,'0.5')>0 ) med8_dosis_T3='0.5'.
IF  (atc8_T3='N07BA03' and CHAR.INDEX(med8_dosering_T3,'1')>0 ) med8_dosis_T3='1'.
** ATC N06BA04 - ritalin/concerta.
IF  (atc4_T3='N06BA04') med4_eenheid_T3='mg'.
IF  (atc4_T3='N06BA04' and CHAR.INDEX(med4_dosering_T3,'10')>0 ) med4_dosis_T3='10'.
** ATC N06BA02 - .
IF  (atc1_T3='N06BA02') med1_eenheid_T3='mg'.
IF  (atc1_T3='N06BA02' and CHAR.INDEX(med1_dosering_T3,'7,5')>0 ) med1_dosis_T3='halve van 15'.
** ATC N06AX21.
IF  (atc3_T3='N06AX21') med3_eenheid_T3='mg'.
IF  (atc3_T3='N06AX21' and CHAR.INDEX(med3_dosering_T3,'60')>0 ) med3_dosis_T3='60'.
** ATC N06AX16.
IF  (atc1_T3='N06AX16') med1_eenheid_T3='mg'.
IF  (atc1_T3='N06AX16' and CHAR.INDEX(med1_dosering_T3,'150/37,5 afgebouwd')>0 ) med1_dosis_T3='37,5'.
IF  (atc1_T3='N06AX16' and CHAR.INDEX(med1_dosering_T3,'75')>0 ) med1_dosis_T3='75'.
IF  (atc2_T3='N06AX16') med2_eenheid_T3='mg'.
IF  (atc2_T3='N06AX16' and CHAR.INDEX(med2_dosering_T3,'37,5')>0 ) med2_dosis_T3='37,5'.
IF  (atc2_T3='N06AX16' and CHAR.INDEX(med2_dosering_T3,'75')>0 ) med2_dosis_T3='75'.
** ATC N06AX12.
IF  (atc1_T3='N06AX12') med1_eenheid_T3='mg'.
IF  (atc1_T3='N06AX12' and CHAR.INDEX(med1_dosering_T3,'150')>0 ) med1_dosis_T3='150'.
IF  (atc1_T3='N06AX12' and CHAR.INDEX(med1_dosering_T3,'1')>0 ) med1_dosis_T3='150'.
** ATC N06AB10.
IF  (atc1_T3='N06AB10') med1_eenheid_T3='mg'.
IF  (atc1_T3='N06AB10' and CHAR.INDEX(med1_dosering_T3,'5')>0 ) med1_dosis_T3='5'.
IF  (atc2_T3='N06AB10') med2_eenheid_T3='mg'.
IF  (atc2_T3='N06AB10' and CHAR.INDEX(med2_dosering_T3,'10')>0 ) med2_dosis_T3='10'.
IF  (atc2_T3='N06AB10' and CHAR.INDEX(med2_dosering_T3,'15')>0 ) med2_dosis_T3='15'.
** ATC N06AB06.
IF  (atc1_T3='N06AB06') med1_eenheid_T3='mg'.
IF  (atc1_T3='N06AB06' and CHAR.INDEX(med1_dosering_T3,'50')>0 ) med1_dosis_T3='50'.
IF  (atc1_T3='N06AB06' and CHAR.INDEX(med1_dosering_T3,'100')>0 ) med1_dosis_T3='100'.
IF  (atc3_T3='N06AB06') med3_eenheid_T3='mg'.
IF  (atc3_T3='N06AB06' and CHAR.INDEX(med3_dosering_T3,'50')>0 ) med3_dosis_T3='50'.
** ATC N06AB05 - paroxetine.
IF  (atc1_T3='N06AB05') med1_eenheid_T3='mg'.
IF  (atc1_T3='N06AB05' and CHAR.INDEX(med1_dosering_T3,'10')>0 ) med1_dosis_T3='10'.
IF  (atc1_T3='N06AB05' and CHAR.INDEX(med1_dosering_T3,'20')>0 ) med1_dosis_T3='20'.
IF  (atc1_T3='N06AB05' and CHAR.INDEX(med1_dosering_T3,'30')>0 ) med1_dosis_T3='30'.
IF  (atc1_T3='N06AB05' and CHAR.INDEX(med1_dosering_T3,'2 pil 20 Mg')>0 ) med1_dosis_T3='2x20'.
IF  (atc2_T3='N06AB05') med2_eenheid_T3='mg'.
IF  (atc2_T3='N06AB05' and CHAR.INDEX(med2_dosering_T3,'10')>0 ) med2_dosis_T3='10'.
IF  (atc2_T3='N06AB05' and CHAR.INDEX(med2_dosering_T3,'20')>0 ) med2_dosis_T3='20'.
IF  (atc2_T3='N06AB05' and CHAR.INDEX(med2_dosering_T3,'30')>0 ) med2_dosis_T3='30'.
IF  (atc3_T3='N06AB05') med3_eenheid_T3='mg'.
IF  (atc3_T3='N06AB05' and CHAR.INDEX(med3_dosering_T3,'40')>0 ) med3_dosis_T3='2x20'.
IF  (atc4_T3='N06AB05') med4_eenheid_T3='mg'.
IF  (atc4_T3='N06AB05' and CHAR.INDEX(med4_dosering_T3,'20')>0 ) med4_dosis_T3='20'.
IF  (atc6_T3='N06AB05') med6_eenheid_T3='mg'.
IF  (atc6_T3='N06AB05' and CHAR.INDEX(med6_dosering_T3,'40')>0 ) med6_dosis_T3='2x20'.
** ATC N06AB04 - citalopram.
IF  (atc1_T3='N06AB04') med1_eenheid_T3='mg'.
IF  (atc1_T3='N06AB04' and CHAR.INDEX(med1_dosering_T3,'10')>0 ) med1_dosis_T3='10'.
IF  (atc2_T3='N06AB04') med2_eenheid_T3='mg'.
IF  (atc2_T3='N06AB04' and CHAR.INDEX(med2_dosering_T3,'10')>0 ) med2_dosis_T3='10'.
IF  (atc2_T3='N06AB04' and CHAR.INDEX(med2_dosering_T3,'20')>0 ) med2_dosis_T3='20'.
IF  (atc5_T3='N06AB04') med5_eenheid_T3='mg'.
IF  (atc5_T3='N06AB04' and CHAR.INDEX(med5_dosering_T3,'40')>0 ) med5_dosis_T3='40'.
IF  (atc7_T3='N06AB04') med7_eenheid_T3='mg'.
IF  (atc7_T3='N06AB04' and CHAR.INDEX(med7_dosering_T3,'10')>0 ) med7_dosis_T3='10'.
** ATC N06AB03 - .
IF  (atc1_T3='N06AB03') med1_eenheid_T3='mg'.
IF  (atc1_T3='N06AB03' and CHAR.INDEX(med1_dosering_T3,'20')>0 ) med1_dosis_T3='20'.
IF  (atc2_T3='N06AB03') med2_eenheid_T3='mg'.
IF  (atc2_T3='N06AB03' and CHAR.INDEX(med2_dosering_T3,'2')>0 ) med2_dosis_T3='20'.
** ATC N06AA10 .
IF  (atc1_T3='N06AA10') med1_eenheid_T3='mg'.
IF  (atc1_T3='N06AA10' and CHAR.INDEX(med1_dosering_T3,'10')>0 ) med1_dosis_T3='10'.
IF  (atc2_T3='N06AA10') med2_eenheid_T3='mg'.
IF  (atc2_T3='N06AA10' and CHAR.INDEX(med2_dosering_T3,'25')>0 ) med2_dosis_T3='25'.
IF  (atc9_T3='N06AA10') med9_eenheid_T3='mg'.
IF  (atc9_T3='N06AA10' and CHAR.INDEX(med9_dosering_T3,'20')>0 ) med9_dosis_T3='2x10'.
** ATC N06AA09 amitriptiline.
IF  (atc1_T3='N06AA09') med1_eenheid_T3='mg'.
IF  (atc1_T3='N06AA09' and CHAR.INDEX(med1_dosering_T3,'25')>0 ) med1_dosis_T3='25'.
IF  (atc2_T3='N06AA09') med2_eenheid_T3='mg'.
IF  (atc2_T3='N06AA09' and CHAR.INDEX(med2_dosering_T3,'25')>0 ) med2_dosis_T3='25'.
IF  (atc6_T3='N06AA09') med6_eenheid_T3='mg'.
IF  (atc6_T3='N06AA09' and CHAR.INDEX(med6_dosering_T3,'1')>0 ) med6_dosis_T3=''.
** ATC N06AA04.
IF  (atc1_T3='N06AA04') med1_eenheid_T3='mg'.
IF  (atc1_T3='N06AA04' and CHAR.INDEX(med1_dosering_T3,'75')>0 ) med1_dosis_T3='75'.
IF  (atc2_T3='N06AA04') med2_eenheid_T3='mg'.
IF  (atc2_T3='N06AA04' and CHAR.INDEX(med2_dosering_T3,'150')>0 ) med2_dosis_T3='2x75'.
IF  (atc2_T3='N06AA04' and CHAR.INDEX(med2_dosering_T3,'1')>0 ) med2_dosis_T3='75'.
*** ATC N05CM09.
IF  (atc5_T3='N05CM09') med5_eenheid_T3='mg'.
IF  (atc5_T3='N05CM09' and CHAR.INDEX(med5_dosering_T3,'15')>0 ) med5_dosis_T3='45'.
*** ATC N05CF01.
IF  (atc1_T3='N05CF01') med1_eenheid_T3='mg'.
IF  (atc1_T3='N05CF01' and CHAR.INDEX(med1_dosering_T3,'1')>0 ) med1_dosis_T3=''.
** ATC N05CH01.
IF  (atc2_T3='N05CH01') med2_eenheid_T3='mg'.
IF  (atc2_T3='N05CH01' and CHAR.INDEX(med2_dosering_T3,'0,5')>0 ) med2_dosis_T3='0.5'.
** ATC N05CF02 - .
IF  (atc2_T3='N05CF02') med2_eenheid_T3='mg'.
IF  (atc2_T3='N05CF02' and CHAR.INDEX(med2_dosering_T3,'10')>0 ) med2_dosis_T3='10'.
** ATC N05CD07 - temazepam.
IF  (atc2_T3='N05CD07') med2_eenheid_T3='mg'.
IF  (atc2_T3='N05CD07' and CHAR.INDEX(med2_dosering_T3,'10')>0 ) med2_dosis_T3='10'.
IF  (atc4_T3='N05CD07') med4_eenheid_T3='mg'.
IF  (atc4_T3='N05CD07' and CHAR.INDEX(med4_dosering_T3,'20')>0 ) med4_dosis_T3='20'.
** ATC N05BB01.
IF  (atc1_T3='N05BB01') med1_eenheid_T3='mg'.
IF  (atc1_T3='N05BB01' and CHAR.INDEX(med1_dosering_T3,'25')>0 ) med1_dosis_T3='25'.
** ATC N05BA04 - oxazepam.
IF  (atc1_T3='N05BA04') med1_eenheid_T3='mg'.
IF  (atc1_T3='N05BA04' and CHAR.INDEX(med1_dosering_T3,'10')>0 ) med1_dosis_T3='10'.
IF  (atc1_T3='N05BA04' and CHAR.INDEX(med1_dosering_T3,'halve tablet van 10 mg')>0 ) med1_dosis_T3='halve van 10'.
IF  (atc2_T3='N05BA04') med2_eenheid_T3='mg'.
IF  (atc2_T3='N05BA04' and CHAR.INDEX(med2_dosering_T3,'10')>0 ) med2_dosis_T3='10'.
IF  (atc3_T3='N05BA04') med3_eenheid_T3='mg'.
IF  (atc3_T3='N05BA04' and CHAR.INDEX(med3_dosering_T3,'5')>0 ) med3_dosis_T3='5'.
** ATC N05BA01 - diazepam/valium.
IF  (atc1_T3='N05BA01') med1_eenheid_T3='mg'.
IF  (atc1_T3='N05BA01' and CHAR.INDEX(med1_dosering_T3,'10')>0 ) med1_dosis_T3='10'.
IF  (atc2_T3='N05BA01') med2_eenheid_T3='mg'.
IF  (atc2_T3='N05BA01' and CHAR.INDEX(med2_dosering_T3,'5')>0 ) med2_dosis_T3='5'.
IF  (atc2_T3='N05BA01' and CHAR.INDEX(med2_dosering_T3,'8oo mg')>0 ) med2_dosis_T3=''.
IF  (atc5_T3='N05BA01') med5_eenheid_T3='mg'.
IF  (atc5_T3='N05BA01' and CHAR.INDEX(med5_dosering_T3,'5')>0 ) med5_dosis_T3='5'.
** ATC N05AX08.
IF  (atc1_T3='N05AX08') med1_eenheid_T3='mg'.
IF  (atc1_T3='N05AX08' and CHAR.INDEX(med1_dosering_T3,'1')>0 ) med1_dosis_T3='1'.
IF  (atc1_T3='N05AX08' and CHAR.INDEX(med1_dosering_T3,'3')>0 ) med1_dosis_T3='3'.
** ATC N05AN01.
IF  (atc1_T3='N05AN01') med1_eenheid_T3='mg'.
IF  (atc1_T3='N05AN01' and CHAR.INDEX(med1_dosering_T3,'600')>0 ) med1_dosis_T3='600'.
** ATC N05AH04 -Quetiapine.
IF  (atc1_T3='N05AH04') med1_eenheid_T3='mg'.
IF  (atc1_T3='N05AH04' and CHAR.INDEX(med1_dosering_T3,'50')>0 ) med1_dosis_T3='50'.
IF  (atc1_T3='N05AH04' and CHAR.INDEX(med1_dosering_T3,'300')>0 ) med1_dosis_T3='300'.
IF  (atc2_T3='N05AH04') med2_eenheid_T3='mg'.
IF  (atc2_T3='N05AH04' and CHAR.INDEX(med2_dosering_T3,'10')>0 ) med2_dosis_T3=''.
IF  (atc4_T3='N05AH04') med4_eenheid_T3='mg'.
** ATC N04BC05.
IF  (atc3_T3='N04BC05') med3_eenheid_T3='mg'.
IF  (atc3_T3='N04BC05' and CHAR.INDEX(med3_dosering_T3,'3')>0 ) med3_dosis_T3='3'.
** ATC N04BC04.
IF  (atc1_T3='N04BC04') med1_eenheid_T3='mg'.
IF  (atc1_T3='N04BC04' and CHAR.INDEX(med1_dosering_T3,'14')>0 ) med1_dosis_T3='2x5 en 1x4'.
** ATC N03AX16 - Lyrica.
IF  (atc2_T3='N03AX16') med2_eenheid_T3='mg'.
IF  (atc2_T3='N03AX16' and CHAR.INDEX(med2_dosering_T3,'150')>0 ) med2_dosis_T3='150'.
IF  (atc4_T3='N03AX16') med4_eenheid_T3='mg'.
IF  (atc4_T3='N03AX16' and CHAR.INDEX(med4_dosering_T3,'75')>0 ) med4_dosis_T3='75'.
** ATC N03AX14.
IF  (atc1_T3='N03AX14') med1_eenheid_T3='mg'.
IF  (atc1_T3='N03AX14' and CHAR.INDEX(med1_dosering_T3,'1500')>0 ) med1_dosis_T3='500 en 1000'.
** ATC N03AX12.
IF  (atc2_T3='N03AX12') med2_eenheid_T3='mg'.
IF  (atc2_T3='N03AX12' and CHAR.INDEX(med2_dosering_T3,'100')>0 ) med2_dosis_T3='100'.
** ATC N03AX11.
IF  (atc1_T3='N03AX11') med1_eenheid_T3='mg'.
IF  (atc2_T3='N03AX11') med2_eenheid_T3='mg'.
IF  (atc2_T3='N03AX11' and CHAR.INDEX(med2_dosering_T3,'75')>0 ) med2_dosis_T3='25 en 50'.
** ATC N03AF01.
IF  (atc2_T3='N03AF01') med2_eenheid_T3='mg'.
IF  (atc2_T3='N03AF01' and CHAR.INDEX(med2_dosering_T3,'400')>0 ) med2_dosis_T3='400'.
** ATC N03AE01.
IF  (atc1_T3='N03AE01') med1_eenheid_T3='mg'.
IF  (atc1_T3='N03AE01' and CHAR.INDEX(med1_dosering_T3,'0,5')>0 ) med1_dosis_T3='0.5'.
IF  (atc2_T3='N03AE01') med2_eenheid_T3='mg'.
IF  (atc2_T3='N03AE01' and CHAR.INDEX(med2_dosering_T3,'1')>0 ) med2_dosis_T3='2x0,5'.
IF  (atc4_T3='N03AE01') med4_eenheid_T3='mg'.
IF  (atc4_T3='N03AE01' and CHAR.INDEX(med4_dosering_T3,'2')>0 ) med4_dosis_T3='2'.
** ATC N02CC06.
IF  (atc3_T3='N02CC06') med3_eenheid_T3='mg'.
IF  (atc3_T3='N02CC06' and ID_Code=5112) med3_dosis_T3='25'.
** ATC N02CC03.
IF  (atc3_T3='N02CC03') med3_eenheid_T3='mg'.
IF  (atc3_T3='N02CC03' and CHAR.INDEX(med3_dosering_T3,'2,5')>0 ) med3_dosis_T3='2,5'.
** ATC N02CC01 Imigram.
IF  (atc2_T3='N02CC01') med2_eenheid_T3='mg'.
IF  (atc2_T3='N02CC01' and CHAR.INDEX(med2_dosering_T3,'20')>0 ) med2_dosis_T3='20 (spray)'.
IF  (atc3_T3='N02CC01') med3_eenheid_T3='ml'.
IF  (atc3_T3='N02CC01' and CHAR.INDEX(med3_vorm_T3,'neusspray')>0 ) med3_dosis_T3='neusspray'.
IF  (atc4_T3='N02CC01') med4_eenheid_T3='mg'.
IF  (atc4_T3='N02CC01' and CHAR.INDEX(med4_dosering_T3,'100')>0 ) med4_dosis_T3='100'.
** ATC N02BE51 - paracetamol/coffeine.
IF  (atc1_T3='N02BE51') med1_eenheid_T3='mg'.
IF  (atc1_T3='N02BE51' and CHAR.INDEX(med1_dosering_T3,'565')>0 ) med1_dosis_T3='500/65'.
IF  (atc3_T3='N02BE51') med3_eenheid_T3='mg'.
IF  (atc3_T3='N02BE51' and CHAR.INDEX(med3_T3,'citrosan')>0 ) med3_dosis_T3='500/50 poeder'.
IF  (atc3_T3='N02BE51' and CHAR.INDEX(med3_T3,'Hot Coldrex')>0 ) med3_dosis_T3='500/30 poeder'.
** ATC N02BE01 - paracetamol.
IF  (atc1_T3='N02BE01') med1_eenheid_T3='mg'.
IF  (atc1_T3='N02BE01' and med1_dosering_T3='1') med1_dosis_T3='500'.
IF  (atc1_T3='N02BE01' and med1_dosering_T3='1000') med1_dosis_T3='1000'.
IF  (atc1_T3='N02BE01' and med1_dosering_T3='1000mg') med1_dosis_T3='1000'.
IF  (atc1_T3='N02BE01' and med1_dosering_T3='1000 mg') med1_dosis_T3='1000'.
IF  (atc1_T3='N02BE01' and med1_dosering_T3= '100') med1_dosis_T3='100'.
IF  (atc1_T3='N02BE01' and med1_dosering_T3= '100 mg') med1_dosis_T3='100'.
IF  (atc1_T3='N02BE01' and CHAR.INDEX(med1_dosering_T3,'500')>0 ) med1_dosis_T3='500'.
IF  (atc1_T3='N02BE01' and CHAR.INDEX(med1_dosering_T3,'200')>0 ) med1_dosis_T3='200'.
IF  (atc1_T3='N02BE01' and CHAR.INDEX(med1_dosering_T3,'400')>0 ) med1_dosis_T3='400'.
IF  (atc1_T3='N02BE01' and CHAR.INDEX(med1_dosering_T3,'400')>0 ) med1_dosis_T3='400'.
*2: bedoelt 2 tabletten van 500 mg.
IF  (ID_code=4508 and atc1_T3='N02BE01' and med1_dosering_T3='2') med1_dosis_T3='2x500'.
IF  (atc2_T3='N02BE01') med2_eenheid_T3='mg'.
IF  (atc2_T3='N02BE01' and med2_dosering_T3='1000mg') med2_dosis_T3='1000'.
IF  (atc2_T3='N02BE01' and med2_dosering_T3='1000 mg') med2_dosis_T3='1000'.
IF  (atc2_T3='N02BE01' and CHAR.INDEX(med2_dosering_T3,'500')>0 ) med2_dosis_T3='500'.
IF  (atc2_T3='N02BE01' and CHAR.INDEX(med2_dosering_T3,'375')>0 ) med2_dosis_T3='1,5 x 250'.
IF  (atc2_T3='N02BE01' and CHAR.INDEX(med2_dosering_T3,'250')>0 ) med2_dosis_T3='250'.
IF  (atc2_T3='N02BE01' and CHAR.INDEX(med2_dosering_T3,'200')>0 ) med2_dosis_T3='200'.
IF  (atc2_T3='N02BE01' and CHAR.INDEX(med2_dosering_T3,'375')>0 ) med2_dosis_T3='1,5 x 250'.
IF  (atc3_T3='N02BE01') med3_eenheid_T3='mg'.
IF  (atc3_T3='N02BE01' and CHAR.INDEX(med3_dosering_T3,'1000')>0 ) med3_dosis_T3='1000'.
IF  (atc3_T3='N02BE01' and med3_dosering_T3='2') med3_dosis_T3='2x500'.
IF  (atc3_T3='N02BE01' and CHAR.INDEX(med3_dosering_T3,'500')>0 ) med3_dosis_T3='500'.
IF  (atc3_T3='N02BE01' and CHAR.INDEX(med3_dosering_T3,'2x 500 mg')>0 ) med3_dosis_T3='2x500'.
IF  (atc4_T3='N02BE01') med4_eenheid_T3='mg'.
IF  (atc4_T3='N02BE01' and CHAR.INDEX(med4_dosering_T3,'500')>0 ) med4_dosis_T3='500'.
IF  (atc4_T3='N02BE01' and CHAR.INDEX(med4_dosering_T3,'2x')>0 ) med4_dosis_T3='2x500'.
IF  (atc4_T3='N02BE01' and CHAR.INDEX(med4_dosering_T3,'1000')>0 ) med4_dosis_T3='1000'.
IF  (atc5_T3='N02BE01') med5_eenheid_T3='mg'.
IF  (atc5_T3='N02BE01' and CHAR.INDEX(med5_dosering_T3,'500')>0 ) med5_dosis_T3='500'.
IF  (atc5_T3='N02BE01' and CHAR.INDEX(med5_dosering_T3,'1000')>0 ) med5_dosis_T3='1000'.
IF  (atc6_T3='N02BE01') med6_eenheid_T3='mg'.
IF  (atc6_T3='N02BE01' and CHAR.INDEX(med6_dosering_T3,'500')>0 ) med6_dosis_T3='500'.
IF  (atc7_T3='N02BE01') med7_eenheid_T3='mg'.
IF  (atc7_T3='N02BE01' and CHAR.INDEX(med7_dosering_T3,'500')>0 ) med7_dosis_T3='500'.
IF  (atc7_T3='N02BE01' and CHAR.INDEX(med7_dosering_T3,'1000')>0 ) med7_dosis_T3='1000'.
IF  (atc8_T3='N02BE01') med8_eenheid_T3='mg'.
IF  (atc8_T3='N02BE01' and CHAR.INDEX(med8_dosering_T3,'500')>0 ) med8_dosis_T3='500'.
** ATC N02AJ13 - tramadol/paracetamol. 
IF  (atc2_T3='N02AJ13') med2_eenheid_T3='mg'.
IF  (atc2_T3='N02AJ13' and CHAR.INDEX(med2_dosering_T3,'37,5/325')>0 ) med2_dosis_T3='37,5/325'.
** ATC N02AJ06 paracetamol/codeine.
IF  (atc1_T3='N02AJ06') med1_eenheid_T3='mg'.
IF  (atc1_T3='N02AJ06' and CHAR.INDEX(med1_dosering_T3,'530')>0 ) med1_dosis_T3='500/30'.
IF  (atc2_T3='N02AJ06') med2_eenheid_T3='mg'.
IF  (atc2_T3='N02AJ06' and CHAR.INDEX(med2_dosering_T3,'500-10')>0 ) med2_dosis_T3='500/10'.
** ATC N02AX02 - tramadol.
IF  (atc1_T3='N02AX02') med1_eenheid_T3='mg'.
IF  (atc1_T3='N02AX02' and CHAR.INDEX(med1_dosering_T3,'150')>0 ) med1_dosis_T3='150'.
IF  (atc2_T3='N02AX02') med2_eenheid_T3='mg'.
IF  (atc2_T3='N02AX02' and CHAR.INDEX(med2_dosering_T3,'50')>0 ) med2_dosis_T3='50'.
IF  (atc2_T3='N02AX02' and CHAR.INDEX(med2_dosering_T3,'100')>0 ) med2_dosis_T3='100'.
IF  (atc4_T3='N02AX02') med4_eenheid_T3='mg'.
IF  (atc4_T3='N02AX02' and CHAR.INDEX(med4_dosering_T3,'50')>0 ) med4_dosis_T3='50'.
** ATC N02AA05.
IF  (atc2_T3='N02AA05') med2_eenheid_T3='mg'.
IF  (atc2_T3='N02AA05' and CHAR.INDEX(med2_dosering_T3,'20')>0 ) med2_dosis_T3='20'.
IF  (atc2_T3='N02AA05' and CHAR.INDEX(med2_dosering_T3,'5')>0 ) med2_dosis_T3='5'.
IF  (atc3_T3='N02AA05') med3_eenheid_T3='mg'.
IF  (atc3_T3='N02AA05' and CHAR.INDEX(med3_dosering_T3,'20')>0 ) med3_dosis_T3='20'.
IF  (atc4_T3='N02AA05') med4_eenheid_T3='mg'.
IF  (atc4_T3='N02AA05' and CHAR.INDEX(med4_dosering_T3,'5')>0 ) med4_dosis_T3='5'.
IF  (atc4_T3='N02AA05' and CHAR.INDEX(med4_dosering_T3,'10')>0 ) med4_dosis_T3='10'.
IF  (atc8_T3='N02AA05') med8_eenheid_T3='mg'.
IF  (atc8_T3='N02AA05' and CHAR.INDEX(med8_T3,'5')>0 ) med8_dosis_T3='5'.
** ATC N02AA01-morfine.
IF  (atc2_T3='N02AA01') med2_eenheid_T3='mg'.
IF  (atc2_T3='N02AA01' and CHAR.INDEX(med2_dosering_T3,'10')>0 ) med2_dosis_T3='10'.
IF  (atc6_T3='N02AA01') med6_eenheid_T3='mg'.
IF  (atc6_T3='N02AA01' and CHAR.INDEX(med6_dosering_T3,'10')>0 ) med6_dosis_T3='10'.
** ATC M05BA08 - zometa infuus.
IF  (atc5_T3='M05BA08') med5_eenheid_T3='mg/ml'.
IF  (atc5_T3='M05BA08' and CHAR.INDEX(med5_dosering_T3,'infuus')>0 ) med5_dosis_T3='1 infuus'.
** ATC M05BA04 alendrolinezuur.
IF  (atc1_T3='M05BA04') med1_eenheid_T3='mg'.
IF  (atc1_T3='M05BA04' and CHAR.INDEX(med1_dosering_T3,'70')>0 ) med1_dosis_T3='70'.
IF  (atc2_T3='M05BA04') med2_eenheid_T3='mg'.
IF  (atc2_T3='M05BA04' and CHAR.INDEX(med2_dosering_T3,'70')>0 ) med2_dosis_T3='70'.
IF  (atc4_T3='M05BA04') med4_eenheid_T3='mg'.
IF  (atc4_T3='M05BA04' and CHAR.INDEX(med4_dosering_T3,'70')>0 ) med4_dosis_T3='70'.
** ATC M04AC01 - colchicine.
IF  (atc5_T3='M04AC01') med5_eenheid_T3='mg'.
IF  (atc5_T3='M04AC01' and CHAR.INDEX(med5_dosering_T3,'0,5')>0 ) med5_dosis_T3='0.5'.
IF  (atc7_T3='M04AC01') med7_eenheid_T3='mg'.
IF  (atc7_T3='M04AC01' and CHAR.INDEX(med7_dosering_T3,'1')>0 ) med7_dosis_T3='2x0,5'.
** ATC M04AA01 - allopurinol.
IF  (atc1_T3='M04AA01') med1_eenheid_T3='mg'.
IF  (atc1_T3='M04AA01' and CHAR.INDEX(med1_dosering_T3,'300')>0 ) med1_dosis_T3='300'.
IF  (atc4_T3='M04AA01') med4_eenheid_T3='mg'.
IF  (atc4_T3='M04AA01' and CHAR.INDEX(med4_dosering_T3,'300')>0 ) med4_dosis_T3='300'.
** ATC M01AH05 - arcoxia.
IF  (atc1_T3='M01AH05') med1_eenheid_T3='mg'.
IF  (atc1_T3='M01AH05' and CHAR.INDEX(med1_dosering_T3,'120')>0 ) med1_dosis_T3='120'.
IF  (atc2_T3='M01AH05') med2_eenheid_T3='mg'.
IF  (atc2_T3='M01AH05' and CHAR.INDEX(med2_dosering_T3,'90')>0 ) med2_dosis_T3='90'.
IF  (atc5_T3='M01AH05') med5_eenheid_T3='mg'.
IF  (atc5_T3='M01AH05' and CHAR.INDEX(med5_dosering_T3,'60')>0 ) med5_dosis_T3='60'.
IF  (atc6_T3='M01AH05') med6_eenheid_T3='mg'.
IF  (atc6_T3='M01AH05' and CHAR.INDEX(med6_dosering_T3,'90')>0 ) med6_dosis_T3='90'.
** ATC M01AH01 - celebrex.
IF  (atc1_T3='M01AH01') med1_eenheid_T3='mg'.
IF  (atc1_T3='M01AH01' and CHAR.INDEX(med1_dosering_T3,'100')>0 ) med1_dosis_T3='100'.
IF  (atc2_T3='M01AH01') med2_eenheid_T3='mg'.
IF  (atc2_T3='M01AH01' and CHAR.INDEX(med2_dosering_T3,'100')>0 ) med2_dosis_T3='100'.
IF  (atc3_T3='M01AH01') med3_eenheid_T3='mg'.
IF  (atc3_T3='M01AH01' and CHAR.INDEX(med3_dosering_T3,'200')>0 ) med3_dosis_T3='200'.
** ATC M01AE02- naproxen.
IF  (atc1_T3='M01AE02') med1_eenheid_T3='mg'.
IF  (atc1_T3='M01AE02' and CHAR.INDEX(med1_dosering_T3,'500')>0 ) med1_dosis_T3='500'.
IF  (atc1_T3='M01AE02' and CHAR.INDEX(med1_dosering_T3,'250')>0 ) med1_dosis_T3='250'.
IF  (atc2_T3='M01AE02') med2_eenheid_T3='mg'.
IF  (atc2_T3='M01AE02' and CHAR.INDEX(med2_dosering_T3,'500')>0 ) med2_dosis_T3='500'.
IF  (atc3_T3='M01AE02') med3_eenheid_T3='mg'.
IF  (atc3_T3='M01AE02' and CHAR.INDEX(med3_dosering_T3,'250')>0 ) med3_dosis_T3='250'.
IF  (atc3_T3='M01AE02' and CHAR.INDEX(med3_dosering_T3,'500')>0 ) med3_dosis_T3='500'.
IF  (atc4_T3='M01AE02') med4_eenheid_T3='mg'.
IF  (atc4_T3='M01AE02' and CHAR.INDEX(med4_dosering_T3,'500')>0 ) med4_dosis_T3='500'.
IF  (atc4_T3='M01AE02' and ID_code=2404 ) med4_dosis_T3='250'.
IF  (atc5_T3='M01AE02') med5_eenheid_T3='mg'.
IF  (atc5_T3='M01AE02' and CHAR.INDEX(med5_dosering_T3,'500')>0 ) med5_dosis_T3='500'.
IF  (atc6_T3='M01AE02') med6_eenheid_T3='mg'.
IF  (atc6_T3='M01AE02' and CHAR.INDEX(med6_dosering_T3,'500')>0 ) med6_dosis_T3='500'.
** ATC M01AE01 - ibuprofen.
IF  (atc1_T3='M01AE01') med1_eenheid_T3='mg'.
IF  (atc1_T3='M01AE01' and CHAR.INDEX(med1_dosering_T3,'600')>0 ) med1_dosis_T3='600'.
IF  (atc1_T3='M01AE01' and CHAR.INDEX(med1_dosering_T3,'100')>0 ) med1_dosis_T3='100'.
IF  (atc1_T3='M01AE01' and CHAR.INDEX(med1_dosering_T3,'200')>0 ) med1_dosis_T3='200'.
IF  (atc1_T3='M01AE01' and CHAR.INDEX(med1_dosering_T3,'400')>0 ) med1_dosis_T3='400'.
IF  (atc1_T3='M01AE01' and CHAR.INDEX(med1_dosering_T3,'800')>0 ) med1_dosis_T3='800'.
IF  (atc1_T3='M01AE01' and CHAR.INDEX(med1_dosering_T3,'500')>0 ) med1_dosis_T3=' '.
IF  (atc1_T3='M01AE01' and CHAR.INDEX(med1_T3,'600')>0 ) med1_dosis_T3='600'.
IF  (atc2_T3='M01AE01') med2_eenheid_T3='mg'.
IF  (atc2_T3='M01AE01' and CHAR.INDEX(med2_dosering_T3,'600')>0 ) med2_dosis_T3='600'.
IF  (atc2_T3='M01AE01' and CHAR.INDEX(med2_dosering_T3,'100')>0 ) med2_dosis_T3='100'.
IF  (atc2_T3='M01AE01' and CHAR.INDEX(med2_dosering_T3,'200')>0 ) med2_dosis_T3='200'.
IF  (atc2_T3='M01AE01' and CHAR.INDEX(med2_dosering_T3,'400')>0 ) med2_dosis_T3='400'.
IF  (atc2_T3='M01AE01' and CHAR.INDEX(med2_dosering_T3,'800')>0 ) med2_dosis_T3='800'.
IF  (atc2_T3='M01AE01' and CHAR.INDEX(med2_T3,'500')>0 ) med2_dosis_T3=''.
* 60 mg bestaat niet, moet waarschijnlijk 600 zijn'.
IF  (atc2_T3='M01AE01' and CHAR.INDEX(med2_dosering_T3,'60')>0 ) med2_dosis_T3='600'.
IF  (atc3_T3='M01AE01') med3_eenheid_T3='mg'.
IF  (atc3_T3='M01AE01' and CHAR.INDEX(med3_dosering_T3,'200')>0 ) med3_dosis_T3='200'.
IF  (atc3_T3='M01AE01' and CHAR.INDEX(med3_dosering_T3,'400')>0 ) med3_dosis_T3='400'.
IF  (atc3_T3='M01AE01' and CHAR.INDEX(med3_dosering_T3,'800')>0 ) med3_dosis_T3='800'.
IF  (atc4_T3='M01AE01') med4_eenheid_T3='mg'.
IF  (atc4_T3='M01AE01' and CHAR.INDEX(med4_dosering_T3,'1200')>0 ) med4_dosis_T3='2x600'.
IF  (atc5_T3='M01AE01') med5_eenheid_T3='mg'.
IF  (atc5_T3='M01AE01' and CHAR.INDEX(med5_dosering_T3,'400')>0 ) med5_dosis_T3='400'.
IF  (atc6_T3='M01AE01') med6_eenheid_T3='mg'.
IF  (atc6_T3='M01AE01' and CHAR.INDEX(med6_dosering_T3,'400')>0 ) med6_dosis_T3='400'.
IF  (atc8_T3='M01AE01') med8_eenheid_T3='mg'.
IF  (atc8_T3='M01AE01' and CHAR.INDEX(med8_dosering_T3,'400')>0 ) med8_dosis_T3='400'.
** ATC M01AC06.
IF  (atc2_T3='M01AC06') med2_eenheid_T3='mg'.
IF  (atc2_T3='M01AC06' and CHAR.INDEX(med2_dosering_T3,'7,5')>0 ) med2_dosis_T3='7.5'.
** ATC M01AB55.
IF  (atc2_T3='M01AB55') med2_eenheid_T3='mg'.
IF  (atc2_T3='M01AB55' and CHAR.INDEX(med2_dosering_T3,'75/0,2')>0 ) med2_dosis_T3='75/0,2'.
** ATC M01AB05 - diclofenac.
IF  (atc1_T3='M01AB05') med1_eenheid_T3='mg'.
IF  (atc1_T3='M01AB05' and CHAR.INDEX(med1_dosering_T3,'50')>0 ) med1_dosis_T3='50'.
IF  (atc1_T3='M01AB05' and CHAR.INDEX(med1_dosering_T3,'25')>0 ) med1_dosis_T3='25'.
IF  (atc1_T3='M01AB05' and CHAR.INDEX(med1_dosering_T3,'75')>0 ) med1_dosis_T3='75'.
IF  (atc1_T3='M01AB05' and CHAR.INDEX(med1_dosering_T3,'200')>0 ) med1_dosis_T3='2x100'.
IF  (atc2_T3='M01AB05') med2_eenheid_T3='mg'.
IF  (atc2_T3='M01AB05' and CHAR.INDEX(med2_dosering_T3,'50')>0 ) med2_dosis_T3='50'.
IF  (atc2_T3='M01AB05' and CHAR.INDEX(med2_dosering_T3,'75')>0 ) med2_dosis_T3='75'.
IF  (atc3_T3='M01AB05') med3_eenheid_T3='mg'.
IF  (atc3_T3='M01AB05' and CHAR.INDEX(med3_dosering_T3,'50')>0 ) med3_dosis_T3='50'.
IF  (atc4_T3='M01AB05') med4_eenheid_T3='mg'.
IF  (atc4_T3='M01AB05' and CHAR.INDEX(med4_dosering_T3,'50')>0 ) med4_dosis_T3='50'.
IF  (atc5_T3='M01AB05') med5_eenheid_T3='mg'.
IF  (atc5_T3='M01AB05' and CHAR.INDEX(med5_dosering_T3,'50')>0 ) med5_dosis_T3='50'.
IF  (atc6_T3='M01AB05') med6_eenheid_T3='mg'.
IF  (atc6_T3='M01AB05' and CHAR.INDEX(med6_dosering_T3,'75')>0 ) med6_dosis_T3='75'.
** ATC L02BA01 - tamoxifen.
IF  (atc1_T3='L02BA01') med1_eenheid_T3='mg'.
IF  (atc1_T3='L02BA01' and CHAR.INDEX(med1_dosering_T3,'20')>0 ) med1_dosis_T3='20'.
IF  (atc7_T3='L02BA01') med7_eenheid_T3='mg'.
IF  (atc7_T3='L02BA01' and CHAR.INDEX(med7_dosering_T3,'40')>0 ) med7_dosis_T3='40'.
** ATC L04AX03 - methotrexaat.
IF  (atc1_T3='L04AX03' and med1_vorm_T3='vloeistof') med1_eenheid_T3='mg/ml'.
IF  (atc1_T3='L04AX03' and med1_vorm_T3='vloeistof' and CHAR.INDEX(med1_dosering_T3,'25')>0 ) med1_dosis_T3='25'.
IF  (atc2_T3='L04AX03' and med2_vorm_T3='pil') med2_eenheid_T3='mg'.
IF  (atc2_T3='L04AX03' and med2_vorm_T3='pil'  and CHAR.INDEX(med2_dosering_T3,'2,5')>0 ) med2_dosis_T3='2,5'.
** ATC L04AD02 - infliximab.
IF  (atc1_T3='L04AD02') med1_eenheid_T3='mg'.
IF  (atc1_T3='L04AD02' and CHAR.INDEX(med1_dosering_T3,'3')>0 ) med1_dosis_T3='3'.
IF  (atc2_T3='L04AD02') med2_eenheid_T3='mg'.
IF  (atc2_T3='L04AD02' and CHAR.INDEX(med2_dosering_T3,'3')>0 ) med2_dosis_T3='3'.
** ATC L04AB04 humira.
IF  (atc1_T3='L04AB04') med1_eenheid_T3='mg/ml'.
IF  (atc1_T3='L04AB04' and CHAR.INDEX(med1_dosering_T3,'40')>0 ) med1_dosis_T3=''.
IF  (atc3_T3='L04AB04') med3_eenheid_T3='mg/ml'.
IF  (atc3_T3='L04AB04' and CHAR.INDEX(med3_dosering_T3,'40')>0 ) med3_dosis_T3=''.
** ATC L04AB02 .
IF  (atc4_T3='L04AB02') med4_eenheid_T3='mg/ml'.
IF  (atc4_T3='L04AB02' and CHAR.INDEX(med4_dosering_T3,'40')>0 ) med4_dosis_T3='40'.
** ATC L04AA13.
IF  (atc3_T3='L04AA13') med3_eenheid_T3='mg'.
IF  (atc3_T3='L04AA13' and CHAR.INDEX(med3_dosering_T3,'20')>0 ) med3_dosis_T3='20'.
** ATC L02BG04.
IF  (atc2_T3='L02BG04') med2_eenheid_T3='mg'.
IF  (atc2_T3='L02BG04' and CHAR.INDEX(med2_dosering_T3,'2,5')>0 ) med2_dosis_T3='2,5'.
** ATC L02BG03.
IF  (atc1_T3='L02BG03') med1_eenheid_T3='mg'.
IF  (atc1_T3='L02BG03' and CHAR.INDEX(med1_dosering_T3,'1')>0 ) med1_dosis_T3='1'.
** ATC L01BB03.
IF  (atc4_T3='L01BB03') med4_eenheid_T3='mg'.
IF  (atc4_T3='L01BB03' and CHAR.INDEX(med4_dosering_T3,'10')>0 ) med4_dosis_T3='10'.
IF  (atc5_T3='L01BB03') med5_eenheid_T3='mg'.
IF  (atc5_T3='L01BB03' and CHAR.INDEX(med5_dosering_T3,'25')>0 ) med5_dosis_T3='40'.
** ATC J02AC02.
IF  (atc6_T3='J02AC02') med6_eenheid_T3='mg'.
IF  (atc6_T3='J02AC02' and CHAR.INDEX(med6_dosering_T3,'1')>0 ) med6_dosis_T3='100'.
** ATC J01XE01.
IF  (atc4_T3='J01XE01') med4_eenheid_T3='mg'.
IF  (atc4_T3='J01XE01' and CHAR.INDEX(med4_dosering_T3,'100')>0 ) med4_dosis_T3='100'.
** ATC J01MA02.
IF  (atc3_T3='J01MA02') med3_eenheid_T3='mg'.
IF  (atc3_T3='J01MA02' and CHAR.INDEX(med3_dosering_T3,'500')>0 ) med3_dosis_T3='500'.
** ATC J01FA09.
IF  (atc2_T3='J01FA09') med2_eenheid_T3='mg'.
IF  (atc2_T3='J01FA09' and CHAR.INDEX(med2_dosering_T3,'500')>0 ) med2_dosis_T3='500'.
** ATC J01CR02.
IF  (atc2_T3='J01CR02') med2_eenheid_T3='mg'.
IF  (atc2_T3='J01CR02' and CHAR.INDEX(med2_dosering_T3,'625')>0 ) med2_dosis_T3='125/500'.
** ATC J01CF05.
IF  (atc2_T3='J01CF05') med2_eenheid_T3='mg'.
IF  (atc2_T3='J01CF05' and CHAR.INDEX(med2_dosering_T3,'500')>0 ) med2_dosis_T3='500'.
IF  (atc5_T3='J01CF05') med5_eenheid_T3='mg'.
IF  (atc5_T3='J01CF05' and CHAR.INDEX(med5_dosering_T3,'500')>0 ) med5_dosis_T3='500'.
** ATC J01CA04 - amoxicicline.
IF  (atc1_T3='J01CA04') med1_eenheid_T3='mg'.
IF  (atc1_T3='J01CA04' and CHAR.INDEX(med1_dosering_T3,'500')>0 ) med1_dosis_T3='500'.
IF  (atc2_T3='J01CA04') med2_eenheid_T3='mg'.
IF  (atc2_T3='J01CA04' and CHAR.INDEX(med2_dosering_T3,'500')>0 ) med2_dosis_T3='500'.
IF  (atc3_T3='J01CA04') med3_eenheid_T3='mg'.
IF  (atc3_T3='J01CA04' and CHAR.INDEX(med3_dosering_T3,'500')>0 ) med3_dosis_T3='500'.
** ATC J01AA02 - doxycycline .
IF  (atc1_T3='J01AA02') med1_eenheid_T3='mg'.
IF  (atc1_T3='J01AA02' and med1_dosering_T3='') med1_dosis_T3='100'.
IF  (atc2_T3='J01AA02') med2_eenheid_T3='mg'.
IF  (atc2_T3='J01AA02' and med2_dosering_T3='100') med2_dosis_T3='100'.
IF  (atc5_T3='J01AA02') med5_eenheid_T3='mg'.
IF  (atc5_T3='J01AA02') and CHAR.INDEX(med5_dosering_T3,'100') med5_dosis_T3='100'.
** ATC H03AA01 - levothyroxine.
IF  (atc1_T3='H03AA01') med1_eenheid_T3='ug'.
IF  (atc1_T3='H03AA01' and CHAR.INDEX(med1_dosering_T3,'50')>0 ) med1_dosis_T3='50'.
IF  (atc1_T3='H03AA01' and CHAR.INDEX(med1_dosering_T3,'75')>0 ) med1_dosis_T3='75'.
IF  (atc1_T3='H03AA01' and CHAR.INDEX(med1_dosering_T3,'88')>0 ) med1_dosis_T3='88'.
IF  (atc1_T3='H03AA01' and CHAR.INDEX(med1_dosering_T3,'100')>0 ) med1_dosis_T3='100'.
IF  (atc1_T3='H03AA01' and CHAR.INDEX(med1_dosering_T3,'112,5')>0 ) med1_dosis_T3='112'.
IF  (atc1_T3='H03AA01' and CHAR.INDEX(med1_dosering_T3,'150')>0 ) med1_dosis_T3='150'.
IF  (atc1_T3='H03AA01' and med1_dosering_T3='50microgram') med1_dosis_T3='50'.
IF  (atc1_T3='H03AA01' and med1_dosering_T3='0,1 mg') med1_dosis_T3='100'.
IF  (atc1_T3='H03AA01' and med1_dosering_T3='1.5 mg') med1_dosis_T3='150'.
IF  (atc2_T3='H03AA01') med2_eenheid_T3='ug'.
IF  (atc2_T3='H03AA01' and CHAR.INDEX(med2_dosering_T3,'75')>0 ) med2_dosis_T3='75'.
IF  (atc2_T3='H03AA01' and CHAR.INDEX(med2_dosering_T3,'150')>0 ) med2_dosis_T3='150'.
IF  (atc2_T3='H03AA01' and CHAR.INDEX(med2_dosering_T3,'125')>0 ) med2_dosis_T3='125'.
IF  (atc3_T3='H03AA01') med3_eenheid_T3='ug'.
IF  (atc3_T3='H03AA01' and CHAR.INDEX(med3_dosering_T3,'25')>0 ) med3_dosis_T3='25'.
IF  (atc5_T3='H03AA01') med5_eenheid_T3='ug'.
IF  (atc5_T3='H03AA01' and CHAR.INDEX(med5_dosering_T3,'75')>0 ) med5_dosis_T3='75'.
** ATC H02AB07- prednison.
IF  (atc1_T3='H02AB07') med1_eenheid_T3='mg'.
IF  (atc1_T3='H02AB07' and CHAR.INDEX(med1_dosering_T3,'30')>0 ) med1_dosis_T3='30'.
IF  (atc4_T3='H02AB07') med4_eenheid_T3='mg'.
IF  (atc4_T3='H02AB07' and CHAR.INDEX(med4_dosering_T3,'30')>0 ) med4_dosis_T3='30'.
** ATC H02AB06- prednisolon.
IF  (atc1_T3='H02AB06') med1_eenheid_T3='mg'.
IF  (atc1_T3='H02AB06' and CHAR.INDEX(med1_dosering_T3,'5')>0 ) med1_dosis_T3='5'.
IF  (atc2_T3='H02AB06') med2_eenheid_T3='mg'.
IF  (atc2_T3='H02AB06' and CHAR.INDEX(med2_dosering_T3,'5')>0 ) med2_dosis_T3='5'.
IF  (atc3_T3='H02AB06') med3_eenheid_T3='mg'.
IF  (atc3_T3='H02AB06' and CHAR.INDEX(med3_dosering_T3,'7,5')>0 ) med3_dosis_T3='5 en 2.5'.
** ATC H02AB01- betamethason.
IF  (atc1_T3='H02AB01' and med1_vorm_T3='tablet') med1_eenheid_T3='mg'.
IF  (atc1_T3='H02AB01' and med1_vorm_T3='tablet' and med1_dosering_T3='1x d ?') med1_dosis_T3='0.5'.
** ATC H02AB07.
IF  (atc1_T3='H02AB07') med1_eenheid_T3='mg'.
IF  (atc1_T3='H02AB07' and CHAR.INDEX(med1_dosering_T3,'7,5')>0 ) med1_dosis_T3='1,5x5'.
** ATC G04CB01- finasteride.
IF  (atc2_T3='G04CB01') med2_eenheid_T3='mg'.
IF  (atc2_T3='G04CB01' and CHAR.INDEX(med2_dosering_T3,'1.25mg')>0 ) med2_dosis_T3='1,25'.
** ATC G04CA02 - tamsulosine.
IF  (atc2_T3='G04CA02') med2_eenheid_T3='mg'.
IF  (atc2_T3='G04CA02' and CHAR.INDEX(med2_dosering_T3,'0.4')>0 ) med2_dosis_T3='0,4'.
IF  (atc3_T3='G04CA02') med3_eenheid_T3='mg'.
IF  (atc3_T3='G04CA02' and CHAR.INDEX(med3_dosering_T3,'0,4')>0 ) med3_dosis_T3='0,4'.
IF  (atc4_T3='G04CA02') med4_eenheid_T3='mg'.
IF  (atc4_T3='G04CA02' and CHAR.INDEX(med4_dosering_T3,'4')>0 ) med4_dosis_T3='0,4'.
IF  (atc4_T3='G04CA02' and CHAR.INDEX(med4_dosering_T3,'5')>0 ) med4_dosis_T3='0,4'.
IF  (atc5_T3='G04CA02') med5_eenheid_T3='mg'.
IF  (atc5_T3='G04CA02' and CHAR.INDEX(med5_dosering_T3,'?')>0 ) med5_dosis_T3='0,4'.
IF  (atc7_T3='G04CA02') med7_eenheid_T3='mg'.
IF  (atc7_T3='G04CA02' and CHAR.INDEX(med7_dosering_T3,'10')>0 ) med7_dosis_T3='0,4'.
** ATC G04BD08 - vesicare.
IF  (atc1_T3='G04BD08') med1_eenheid_T3='mg'.
IF  (atc1_T3='G04BD08' and CHAR.INDEX(med1_dosering_T3,'150')>0 ) med1_dosis_T3=''.
IF  (atc3_T3='G04BD08') med3_eenheid_T3='mg'.
IF  (atc3_T3='G04BD08' and CHAR.INDEX(med3_dosering_T3,'10')>0 ) med3_dosis_T3='10'.
** ATC G03CX01.
IF  (atc3_T3='G03CX01') med3_eenheid_T3='mg'.
IF  (atc3_T3='G03CX01' and CHAR.INDEX(med3_dosering_T3,'2')>0 ) med3_dosis_T3='2,5'.
IF  (atc8_T3='G03CX01') med8_eenheid_T3='mg'.
IF  (atc8_T3='G03CX01' and CHAR.INDEX(med8_dosering_T3,'5')>0 ) med8_dosis_T3='5'.
** ATC G03CA04.
IF  (atc9_T3='G03CA04') med9_eenheid_T3='mg'.
IF  (atc9_T3='G03CA04' and CHAR.INDEX(med9_dosering_T3,'zetpil')>0 ) med9_dosis_T3='0,5'.
** ATC G02CB03.
IF  (atc1_T3='G02CB03') med1_eenheid_T3='mg'.
IF  (atc1_T3='G02CB03' and CHAR.INDEX(med1_dosering_T3,'halve tablet')>0 ) med1_dosis_T3='halve van 0.5'.
** ATC D11AH01.
IF  (atc2_T3='D11AH01') med2_eenheid_T3='mg/g'.
** ATC D07AD01.
IF  (atc3_T3='D07AD01') med3_eenheid_T3='mg/g'.
IF  (atc3_T3='D07AD01' and CHAR.INDEX(med3_dosering_T3,'3')>0 ) med3_dosis_T3=''.
** ATC D07AC17.
IF  (atc3_T3='D07AC17') med3_eenheid_T3='mg/g'.
IF  (atc3_T3='D07AC17' and CHAR.INDEX(med3_dosering_T3,'0,5')>0 ) med3_dosis_T3='0,5'.
** ATC D07AC01.
IF  (atc1_T3='D07AC01') med1_eenheid_T3='mg/ml'.
IF  (atc1_T3='D07AC01' and CHAR.INDEX(med1_dosering_T3,'1')>0 ) med1_dosis_T3='1'.
** ATC D05BB02.
IF  (atc2_T3='D05BB02') med2_eenheid_T3='mg'.
IF  (atc2_T3='D05BB02' and CHAR.INDEX(med2_dosering_T3,'10')>0 ) med2_dosis_T3='10'.
** ATC C10AX14 - .
IF  (atc8_T3='C10AX14') med8_eenheid_T3='mg/ml'.
IF  (atc8_T3='C10AX14' and CHAR.INDEX(med8_dosering_T3,'75')>0 ) med8_dosis_T3='75'.
** ATC C10AX09 - ezetimibe.
IF  (atc4_T3='C10AX09') med4_eenheid_T3='mg'.
IF  (atc4_T3='C10AX09' and CHAR.INDEX(med4_dosering_T3,'1')>0 ) med4_dosis_T3='10'.
IF  (atc9_T3='C10AX09') med9_eenheid_T3='mg'.
IF  (atc9_T3='C10AX09' and CHAR.INDEX(med9_dosering_T3,'10')>0 ) med9_dosis_T3='10'.
IF  (atc10_T3='C10AX09') med10_eenheid_T3='mg'.
IF  (atc10_T3='C10AX09' and CHAR.INDEX(med10_dosering_T3,'10')>0 ) med10_dosis_T3='10'.
*wordt bedoelt 1 tablet, is alleen in 10 mg.
IF  (atc9_T3='C10AX09') med9_eenheid_T3='mg'.
IF  (atc9_T3='C10AX09' and CHAR.INDEX(med9_dosering_T3,'10')>0 ) med9_dosis_T3='10'.
** ATC C10AA07 crestor/rosuvastatine.
IF  (atc1_T3='C10AA07') med1_eenheid_T3='mg'.
IF  (atc1_T3='C10AA07' and CHAR.INDEX(med1_dosering_T3,'5')>0 ) med1_dosis_T3='5'.
IF  (atc1_T3='C10AA07' and CHAR.INDEX(med1_dosering_T3,'10')>0 ) med1_dosis_T3='10'.
IF  (atc1_T3='C10AA07' and CHAR.INDEX(med1_dosering_T3,'20')>0 ) med1_dosis_T3='20'.
IF  (atc1_T3='C10AA07' and CHAR.INDEX(med1_dosering_T3,'40')>0 ) med1_dosis_T3='40'.
IF  (atc2_T3='C10AA07') med2_eenheid_T3='mg'.
IF  (atc2_T3='C10AA07' and CHAR.INDEX(med2_dosering_T3,'5')>0 ) med2_dosis_T3='5'.
IF  (atc3_T3='C10AA07') med3_eenheid_T3='mg'.
IF  (atc3_T3='C10AA07' and CHAR.INDEX(med3_dosering_T3,'5')>0 ) med3_dosis_T3='5'.
IF  (atc4_T3='C10AA07') med4_eenheid_T3='mg'.
IF  (atc4_T3='C10AA07' and CHAR.INDEX(med4_dosering_T3,'5')>0 ) med4_dosis_T3='5'.
IF  (atc4_T3='C10AA07' and CHAR.INDEX(med4_dosering_T3,'10')>0 ) med4_dosis_T3='10'.
IF  (atc4_T3='C10AA07' and CHAR.INDEX(med4_dosering_T3,'40')>0 ) med4_dosis_T3='40'.
IF  (atc5_T3='C10AA07') med5_eenheid_T3='mg'.
IF  (atc5_T3='C10AA07' and CHAR.INDEX(med5_dosering_T3,'5')>0 ) med5_dosis_T3='5'.
IF  (atc5_T3='C10AA07' and CHAR.INDEX(med5_dosering_T3,'10')>0 ) med5_dosis_T3='10'.
IF  (atc5_T3='C10AA07' and CHAR.INDEX(med5_dosering_T3,'20')>0 ) med5_dosis_T3='20'.
IF  (atc6_T3='C10AA07') med6_eenheid_T3='mg'.
IF  (atc6_T3='C10AA07' and CHAR.INDEX(med6_dosering_T3,'10')>0 ) med6_dosis_T3='10'.
IF  (atc6_T3='C10AA07' and CHAR.INDEX(med6_dosering_T3,'20')>0 ) med6_dosis_T3='20'.
IF  (atc8_T3='C10AA07') med8_eenheid_T3='mg'.
IF  (atc8_T3='C10AA07' and CHAR.INDEX(med8_dosering_T3,'40')>0 ) med8_dosis_T3='40'.
** ATC C10AA05 - lipitor/atorvastatine.
IF  (atc1_T3='C10AA05') med1_eenheid_T3='mg'.
IF  (atc1_T3='C10AA05' and CHAR.INDEX(med1_dosering_T3,'40')>0 ) med1_dosis_T3='40'.
IF  (atc1_T3='C10AA05' and CHAR.INDEX(med1_dosering_T3,'10')>0 ) med1_dosis_T3='10'.
IF  (atc1_T3='C10AA05' and CHAR.INDEX(med1_T3,'10 mg')>0 ) med1_dosis_T3='10'.
IF  (atc1_T3='C10AA05' and CHAR.INDEX(med1_T3,'10mg')>0 ) med1_dosis_T3='10'.
IF  (atc2_T3='C10AA05') med2_eenheid_T3='mg'.
IF  (atc2_T3='C10AA05' and CHAR.INDEX(med2_dosering_T3,'10')>0 ) med2_dosis_T3='10'.
IF  (atc2_T3='C10AA05' and CHAR.INDEX(med2_dosering_T3,'20')>0 ) med2_dosis_T3='20'.
IF  (atc2_T3='C10AA05' and CHAR.INDEX(med2_dosering_T3,'40')>0 ) med2_dosis_T3='40'.
IF  (atc3_T3='C10AA05') med3_eenheid_T3='mg'.
IF  (atc3_T3='C10AA05' and CHAR.INDEX(med3_dosering_T3,'20')>0 ) med3_dosis_T3='20'.
IF  (atc3_T3='C10AA05' and CHAR.INDEX(med3_dosering_T3,'40')>0 ) med3_dosis_T3='40'.
IF  (atc4_T3='C10AA05') med4_eenheid_T3='mg'.
IF  (atc4_T3='C10AA05' and CHAR.INDEX(med4_dosering_T3,'20')>0 ) med4_dosis_T3='20'.
IF  (atc4_T3='C10AA05' and CHAR.INDEX(med4_dosering_T3,'40')>0 ) med4_dosis_T3='40'.
IF  (atc5_T3='C10AA05') med5_eenheid_T3='mg'.
IF  (atc5_T3='C10AA05' and CHAR.INDEX(med5_dosering_T3,'20')>0 ) med5_dosis_T3='20'.
IF  (atc5_T3='C10AA05' and CHAR.INDEX(med5_dosering_T3,'40')>0 ) med5_dosis_T3='40'.
IF  (atc5_T3='C10AA05' and CHAR.INDEX(med5_dosering_T3,'80')>0 ) med5_dosis_T3='80'.
IF  (atc6_T3='C10AA05') med6_eenheid_T3='mg'.
IF  (atc6_T3='C10AA05' and CHAR.INDEX(med6_dosering_T3,'20')>0 ) med6_dosis_T3='20'.
IF  (atc7_T3='C10AA05') med7_eenheid_T3='mg'.
IF  (atc7_T3='C10AA05' and CHAR.INDEX(med7_dosering_T3,'20')>0 ) med7_dosis_T3='20'.
IF  (atc9_T3='C10AA05') med9_eenheid_T3='mg'.
IF  (atc9_T3='C10AA05' and CHAR.INDEX(med9_dosering_T3,'20')>0 ) med9_dosis_T3='20'.
** ATC C10AA04 - fluvastatine.
IF  (atc3_T3='C10AA04') med3_eenheid_T3='mg'.
IF  (atc3_T3='C10AA04' and CHAR.INDEX(med3_dosering_T3,'20')>0 ) med3_dosis_T3='20'.
** ATC C10AA03 - pravastatine.
IF  (atc5_T3='C10AA03') med5_eenheid_T3='mg'.
IF  (atc5_T3='C10AA03' and CHAR.INDEX(med5_dosering_T3,'20')>0 ) med5_dosis_T3='20'.
** ATC C10AA01 - simvastatine.
IF  (atc1_T3='C10AA01') med1_eenheid_T3='mg'.
IF  (atc1_T3='C10AA01' and CHAR.INDEX(med1_dosering_T3,'1')>0 ) med1_dosis_T3=''.
IF  (atc1_T3='C10AA01' and CHAR.INDEX(med1_dosering_T3,'40')>0 ) med1_dosis_T3='40'.
IF  (atc1_T3='C10AA01' and CHAR.INDEX(med1_dosering_T3,'20')>0 ) med1_dosis_T3='20'.
IF  (atc1_T3='C10AA01' and CHAR.INDEX(med1_T3,'40')>0 ) med1_dosis_T3='40'.
IF  (atc2_T3='C10AA01') med2_eenheid_T3='mg'.
IF  (atc2_T3='C10AA01' and CHAR.INDEX(med2_dosering_T3,'30')>0 ) med2_dosis_T3='1.5 x 20'.
IF  (atc2_T3='C10AA01' and CHAR.INDEX(med2_dosering_T3,'20')>0 ) med2_dosis_T3='20'.
IF  (atc3_T3='C10AA01') med3_eenheid_T3='mg'.
IF  (atc3_T3='C10AA01' and CHAR.INDEX(med3_dosering_T3,'20')>0 ) med3_dosis_T3='20'.
IF  (atc4_T3='C10AA01') med4_eenheid_T3='mg'.
IF  (atc4_T3='C10AA01' and CHAR.INDEX(med4_dosering_T3,'40')>0 ) med4_dosis_T3='40'.
IF  (atc4_T3='C10AA01' and CHAR.INDEX(med4_dosering_T3,'10')>0 ) med4_dosis_T3='10'.
IF  (atc5_T3='C10AA01') med5_eenheid_T3='mg'.
IF  (atc5_T3='C10AA01' and CHAR.INDEX(med5_dosering_T3,'40')>0 ) med5_dosis_T3='40'.
IF  (atc6_T3='C10AA01') med6_eenheid_T3='mg'.
IF  (atc6_T3='C10AA01' and CHAR.INDEX(med6_dosering_T3,'20')>0 ) med6_dosis_T3='20'.
IF  (atc6_T3='C10AA01' and CHAR.INDEX(med6_dosering_T3,'40')>0 ) med6_dosis_T3='40'.
** ATC C09DA04 irbesartan/HCT.
IF  (atc1_T3='C09DA04') med1_eenheid_T3='mg'.
IF  (atc1_T3='C09DA04' and CHAR.INDEX(med1_dosering_T3,'300')>0 ) med1_dosis_T3='300/?'.
IF  (atc1_T3='C09DA04' and CHAR.INDEX(med1_dosering_T3,'300mg/12,5mg')>0 ) med1_dosis_T3='300/12.5'.
** ATC C09DA03 valsartan/HCT.
IF  (atc1_T3='C09DA03') med1_eenheid_T3='mg'.
IF  (atc1_T3='C09DA03' and CHAR.INDEX(med1_dosering_T3,'80/12,5')>0 ) med1_dosis_T3='80/12.5'.
** ATC C09CA07.
IF  (atc1_T3='C09CA07') med1_eenheid_T3='mg'.
IF  (atc1_T3='C09CA07' and CHAR.INDEX(med1_dosering_T3,'80')>0 ) med1_dosis_T3='80'.
** ATC C09CA06 candesartan.
IF  (atc1_T3='C09CA06') med1_eenheid_T3='mg'.
IF  (atc1_T3='C09CA06' and CHAR.INDEX(med1_dosering_T3,'16')>0 ) med1_dosis_T3='16'.
** ATC C09CA04 - irbesartan.
IF  (atc1_T3='C09CA04') med1_eenheid_T3='mg'.
IF  (atc1_T3='C09CA04' and CHAR.INDEX(med1_dosering_T3,'200')>0 ) med1_dosis_T3='300'.
IF  (atc3_T3='C09CA04') med3_eenheid_T3='mg'.
IF  (atc3_T3='C09CA04' and CHAR.INDEX(med3_dosering_T3,'75')>0 ) med3_dosis_T3='75'.
IF  (atc5_T3='C09CA04') med5_eenheid_T3='mg'.
IF  (atc5_T3='C09CA04' and CHAR.INDEX(med5_dosering_T3,'150')>0 ) med5_dosis_T3='150'.
*(bedoelt 1 tablet, gem dosering, laagste prijs aangehouden).
IF  (atc4_T3='C09CA04') med4_eenheid_T3='mg'.
IF  (atc4_T3='C09CA04' and CHAR.INDEX(med4_dosering_T3,'150')>0 ) med4_dosis_T3='150'.
** ATC C09CA03 - valsartan.
IF  (atc1_T3='C09CA03') med1_eenheid_T3='mg'.
IF  (atc1_T3='C09CA03' and CHAR.INDEX(med1_dosering_T3,'40')>0 ) med1_dosis_T3='40'.
IF  (atc2_T3='C09CA03') med2_eenheid_T3='mg'.
IF  (atc2_T3='C09CA03' and CHAR.INDEX(med2_dosering_T3,'40')>0 ) med2_dosis_T3='40'.
** ATC C09CA01 - losartan.
IF  (atc1_T3='C09CA01') med1_eenheid_T3='mg'.
IF  (atc1_T3='C09CA01' and CHAR.INDEX(med1_dosering_T3,'50')>0 ) med1_dosis_T3='50'.
IF  (atc1_T3='C09CA01' and CHAR.INDEX(med1_dosering_T3,'100')>0 ) med1_dosis_T3='100'.
IF  (atc2_T3='C09CA01') med2_eenheid_T3='mg'.
IF  (atc2_T3='C09CA01' and CHAR.INDEX(med2_dosering_T3,'50')>0 ) med2_dosis_T3='50'.
IF  (atc3_T3='C09CA01') med3_eenheid_T3='mg'.
IF  (atc3_T3='C09CA01' and CHAR.INDEX(med3_T3,'50')>0 ) med3_dosis_T3='50'.
IF  (atc3_T3='C09CA01' and CHAR.INDEX(med3_dosering_T3,'50')>0 ) med3_dosis_T3='50'.
** ATC C09BA03 - valsartan/HCT.
IF  (atc2_T3='C09BA03') med2_eenheid_T3='mg'.
IF  (atc2_T3='C09BA03' and CHAR.INDEX(med2_dosering_T3,'20')>0 ) med2_dosis_T3='20/12.5'.
** ATC C09AA06 - quinapril.
IF  (atc1_T3='C09AA06') med1_eenheid_T3='mg'.
IF  (atc1_T3='C09AA06' and CHAR.INDEX(med1_dosering_T3,'20')>0 ) med1_dosis_T3='20'.
IF  (atc2_T3='C09AA06') med2_eenheid_T3='mg'.
IF  (atc2_T3='C09AA06' and CHAR.INDEX(med2_dosering_T3,'20')>0 ) med2_dosis_T3='20'.
IF  (atc3_T3='C09AA06') med3_eenheid_T3='mg'.
IF  (atc3_T3='C09AA06' and CHAR.INDEX(med3_dosering_T3,'12.5')>0 ) med3_dosis_T3=''.
IF  (atc4_T3='C09AA06') med4_eenheid_T3='mg'.
IF  (atc4_T3='C09AA06' and CHAR.INDEX(med4_dosering_T3,'10')>0 ) med4_dosis_T3='10'.
IF  (atc5_T3='C09AA06') med5_eenheid_T3='mg'.
IF  (atc5_T3='C09AA06' and CHAR.INDEX(med5_dosering_T3,'10')>0 ) med5_dosis_T3='10'.
** ATC C09AA05 ramipril.
IF  (atc1_T3='C09AA05') med1_eenheid_T3='mg'.
IF  (atc1_T3='C09AA05' and CHAR.INDEX(med1_dosering_T3,'5')>0 ) med1_dosis_T3='5'.
IF  (atc1_T3='C09AA05' and CHAR.INDEX(med1_dosering_T3,'2,5')>0 ) med1_dosis_T3='2,5'.
IF  (atc2_T3='C09AA05') med2_eenheid_T3='mg'.
IF  (atc2_T3='C09AA05' and CHAR.INDEX(med2_dosering_T3,'2.5')>0 ) med2_dosis_T3='2,5'.
IF  (atc3_T3='C09AA05') med3_eenheid_T3='mg'.
IF  (atc3_T3='C09AA05' and CHAR.INDEX(med3_dosering_T3,'5')>0 ) med3_dosis_T3='5'.
** ATC C09AA04- perindopril.
IF  (atc1_T3='C09AA04') med1_eenheid_T3='mg'.
IF  (atc1_T3='C09AA04' and CHAR.INDEX(med1_dosering_T3,'8')>0 ) med1_dosis_T3='8'.
IF  (atc1_T3='C09AA04' and CHAR.INDEX(med1_dosering_T3,'20')>0 ) med1_dosis_T3='2x10'.
IF  (atc2_T3='C09AA04') med2_eenheid_T3='mg'.
IF  (atc2_T3='C09AA04' and CHAR.INDEX(med2_dosering_T3,'20')>0 ) med2_dosis_T3='2x10'.
IF  (atc2_T3='C09AA04' and CHAR.INDEX(med2_dosering_T3,'5')>0 ) med2_dosis_T3='5'.
IF  (atc3_T3='C09AA04') med3_eenheid_T3='mg'.
IF  (atc3_T3='C09AA04' and CHAR.INDEX(med3_dosering_T3,'4')>0 ) med3_dosis_T3='4'.
IF  (atc3_T3='C09AA04' and CHAR.INDEX(med3_dosering_T3,'6')>0 ) med3_dosis_T3='2 en 4'.
IF  (atc4_T3='C09AA04') med4_eenheid_T3='mg'.
IF  (atc4_T3='C09AA04' and CHAR.INDEX(med4_dosering_T3,'4')>0 ) med4_dosis_T3='4'.
IF  (atc4_T3='C09AA04' and CHAR.INDEX(med4_dosering_T3,'6')>0 ) med4_dosis_T3='1,5x4'.
IF  (atc4_T3='C09AA04' and CHAR.INDEX(med4_T3,'4')>0 ) med4_dosis_T3='4'.
IF  (atc4_T3='C09AA04' and CHAR.INDEX(med4_dosering_T3,'10')>0 ) med4_dosis_T3='10'.
IF  (atc5_T3='C09AA04') med5_eenheid_T3='mg'.
IF  (atc5_T3='C09AA04' and CHAR.INDEX(med5_dosering_T3,'2')>0 ) med5_dosis_T3='2'.
IF  (atc6_T3='C09AA04') med6_eenheid_T3='mg'.
IF  (atc6_T3='C09AA04' and CHAR.INDEX(med6_dosering_T3,'1')>0 ) med6_dosis_T3='10'.
** ATC C09AA03 - lisinopril.
IF  (atc1_T3='C09AA03') med1_eenheid_T3='mg'.
IF  (atc1_T3='C09AA03' and CHAR.INDEX(med1_dosering_T3,'20')>0 ) med1_dosis_T3='20'.
IF  (atc1_T3='C09AA03' and CHAR.INDEX(med1_dosering_T3,'10')>0 ) med1_dosis_T3='10'.
IF  (atc3_T3='C09AA03') med3_eenheid_T3='mg'.
IF  (atc3_T3='C09AA03' and CHAR.INDEX(med3_dosering_T3,'5')>0 ) med3_dosis_T3='5'.
** ATC C09AA02 - enalapril.
IF  (atc1_T3='C09AA02') med1_eenheid_T3='mg'.
IF  (atc1_T3='C09AA02' and CHAR.INDEX(med1_dosering_T3,'20')>0 ) med1_dosis_T3='20'.
IF  (atc2_T3='C09AA02') med2_eenheid_T3='mg'.
IF  (atc2_T3='C09AA02' and CHAR.INDEX(med2_dosering_T3,'20')>0 ) med2_dosis_T3='20'.
IF  (atc3_T3='C09AA02') med3_eenheid_T3='mg'.
IF  (atc3_T3='C09AA02' and CHAR.INDEX(med3_dosering_T3,'5')>0 ) med3_dosis_T3='5'.
IF  (atc4_T3='C09AA02') med4_eenheid_T3='mg'.
IF  (atc4_T3='C09AA02' and CHAR.INDEX(med4_T3,'10')>0 ) med4_dosis_T3='10'.
IF  (atc4_T3='C09AA02' and CHAR.INDEX(med4_dosering_T3,'20')>0 ) med4_dosis_T3='20'.
IF  (atc6_T3='C09AA02') med6_eenheid_T3='mg'.
IF  (atc6_T3='C09AA02' and CHAR.INDEX(med6_dosering_T3,'10')>0 ) med6_dosis_T3='10'.
** ATC C08DB01.
IF  (atc1_T3='C08DB01') med1_eenheid_T3='mg'.
IF  (atc1_T3='C08DB01' and CHAR.INDEX(med1_dosering_T3,'200')>0 ) med1_dosis_T3='200'.
** ATC C08DA01.
IF  (atc2_T3='C08DA01') med2_eenheid_T3='mg'.
IF  (atc2_T3='C08DA01' and CHAR.INDEX(med2_dosering_T3,'3')>0 ) med2_dosis_T3=''.
IF  (atc4_T3='C08DA01') med4_eenheid_T3='mg'.
IF  (atc4_T3='C08DA01' and CHAR.INDEX(med4_dosering_T3,'100')>0 ) med4_dosis_T3=''.
** ATC C08CA13.
IF  (atc2_T3='C08CA13') med2_eenheid_T3='mg'.
IF  (atc2_T3='C08CA13' and CHAR.INDEX(med2_dosering_T3,'10')>0 ) med2_dosis_T3='10'.
** ATC C08CA05 - nifidepine.
IF  (atc2_T3='C08CA05') med2_eenheid_T3='mg'.
IF  (atc2_T3='C08CA05' and CHAR.INDEX(med2_dosering_T3,'60')>0 ) med2_dosis_T3='60'.
IF  (atc3_T3='C08CA05') med3_eenheid_T3='mg'.
IF  (atc3_T3='C08CA05' and CHAR.INDEX(med3_dosering_T3,'30')>0 ) med3_dosis_T3='30'.
IF  (atc4_T3='C08CA05') med4_eenheid_T3='mg'.
IF  (atc4_T3='C08CA05' and CHAR.INDEX(med4_dosering_T3,'60')>0 ) med4_dosis_T3='60'.
IF  (atc5_T3='C08CA05') med5_eenheid_T3='mg'.
IF  (atc5_T3='C08CA05' and CHAR.INDEX(med5_dosering_T3,'30')>0 ) med5_dosis_T3='30'.
** ATC C08CA01- amlodipine.
IF  (atc1_T3='C08CA01') med1_eenheid_T3='mg'.
IF  (atc1_T3='C08CA01' and CHAR.INDEX(med1_dosering_T3,'5')>0 ) med1_dosis_T3='5'.
IF  (atc1_T3='C08CA01' and CHAR.INDEX(med1_dosering_T3,'10')>0 ) med1_dosis_T3='10'.
IF  (atc2_T3='C08CA01') med2_eenheid_T3='mg'.
IF  (atc2_T3='C08CA01' and CHAR.INDEX(med2_dosering_T3,'5')>0 ) med2_dosis_T3='5'.
IF  (atc2_T3='C08CA01' and CHAR.INDEX(med2_dosering_T3,'10')>0 ) med2_dosis_T3='10'.
IF  (atc3_T3='C08CA01') med3_eenheid_T3='mg'.
IF  (atc3_T3='C08CA01' and CHAR.INDEX(med3_dosering_T3,'5')>0 ) med3_dosis_T3='5'.
IF  (atc3_T3='C08CA01' and CHAR.INDEX(med3_dosering_T3,'10')>0 ) med3_dosis_T3='10'.
* 2x5 maar geeft ook al 2x per dag aan.
IF  (atc3_T3='C08CA01' and CHAR.INDEX(med3_dosering_T3,'2 x 5 mg')>0 ) med3_dosis_T3='5'.
IF  (atc5_T3='C08CA01') med5_eenheid_T3='mg'.
IF  (atc5_T3='C08CA01' and CHAR.INDEX(med5_dosering_T3,'10')>0 ) med5_dosis_T3='10'.
IF  (atc6_T3='C08CA01') med6_eenheid_T3='mg'.
IF  (atc6_T3='C08CA01' and CHAR.INDEX(med6_dosering_T3,'8')>0 ) med6_dosis_T3=''.
** ATC D07XC01.
IF  (atc1_T3='D07XC01') med1_eenheid_T3='mg/g'.
IF  (atc2_T3='D07XC01') med2_eenheid_T3='mg/g'.
** ATC D01BA02.
IF  (atc1_T3='D01BA02') med1_eenheid_T3='mg'.
IF  (atc1_T3='D01BA02' and CHAR.INDEX(med1_dosering_T3,'250')>0 ) med1_dosis_T3='250'.
** ATC C07BB02.
IF  (atc1_T3='C07BB02') med1_eenheid_T3='mg'.
IF  (atc1_T3='C07BB02' and CHAR.INDEX(med1_T3,'95/12,5')>0 ) med1_dosis_T3='95/12,5'.
** ATC C07AB12- nebivolol.
IF  (atc4_T3='C07AB12') med4_eenheid_T3='mg'.
IF  (atc4_T3='C07AB12' and CHAR.INDEX(med4_dosering_T3,'2.5') and CHAR.INDEX(med4_T3,'5') >0 ) med4_dosis_T3='halve 5'.
** ATC C07AB07- bisoprolol.
IF  (atc3_T3='C07AB07') med3_eenheid_T3='mg'.
IF  (atc3_T3='C07AB07' and CHAR.INDEX(med3_dosering_T3,'5')>0 ) med3_dosis_T3='5'.
IF  (atc4_T3='C07AB07') med4_eenheid_T3='mg'.
IF  (atc4_T3='C07AB07' and CHAR.INDEX(med4_dosering_T3,'5')>0 ) med4_dosis_T3='5'.
IF  (atc5_T3='C07AB07') med5_eenheid_T3='mg'.
IF  (atc5_T3='C07AB07' and CHAR.INDEX(med5_dosering_T3,'5')>0 ) med5_dosis_T3='5'.
IF  (atc7_T3='C07AB07') med7_eenheid_T3='mg'.
IF  (atc7_T3='C07AB07' and CHAR.INDEX(med7_dosering_T3,'5')>0 ) med7_dosis_T3='5'.
** ATC C07AB02- metoprolol.
IF  (atc1_T3='C07AB02') med1_eenheid_T3='mg'.
IF  (atc1_T3='C07AB02' and CHAR.INDEX(med1_dosering_T3,'50')>0 ) med1_dosis_T3='50'.
IF  (atc1_T3='C07AB02' and CHAR.INDEX(med1_dosering_T3,'100')>0 ) med1_dosis_T3='100'.
IF  (atc2_T3='C07AB02') med2_eenheid_T3='mg'.
IF  (atc2_T3='C07AB02' and CHAR.INDEX(med2_dosering_T3,'25')>0 ) med2_dosis_T3='25'.
IF  (atc2_T3='C07AB02' and CHAR.INDEX(med2_dosering_T3,'50')>0 ) med2_dosis_T3='50'.
IF  (atc3_T3='C07AB02') med3_eenheid_T3='mg'.
* 2,5 bestaat niet, op T0 100 .
IF  (atc3_T3='C07AB02' and CHAR.INDEX(med3_dosering_T3,'2,5')>0 ) med3_dosis_T3='100'.
IF  (atc3_T3='C07AB02' and CHAR.INDEX(med3_dosering_T3,'25')>0 ) med3_dosis_T3='25'.
IF  (atc3_T3='C07AB02' and CHAR.INDEX(med3_dosering_T3,'50')>0 ) med3_dosis_T3='50'.
IF  (atc3_T3='C07AB02' and CHAR.INDEX(med3_dosering_T3,'100')>0 ) med3_dosis_T3='100'.
IF  (atc3_T3='C07AB02' and CHAR.INDEX(med3_dosering_T3,'100 + 50')>0 ) med3_dosis_T3='100+50'.
IF  (atc4_T3='C07AB02') med4_eenheid_T3='mg'.
IF  (atc4_T3='C07AB02' and CHAR.INDEX(med4_dosering_T3,'25')>0 ) med4_dosis_T3='25'.
** ATC C07AA07 sotalol.
IF  (atc1_T3='C07AA07') med1_eenheid_T3='mg'.
IF  (atc1_T3='C07AA07' and CHAR.INDEX(med1_dosering_T3,'80')>0 ) med1_dosis_T3='80'.
** ATC C03DA01- spironolacton.
IF  (atc2_T3='C03DA01') med2_eenheid_T3='mg'.
IF  (atc2_T3='C03DA01' and CHAR.INDEX(med2_dosering_T3,'0,5')>0 ) med2_dosis_T3='halve van 25'.
IF  (atc5_T3='C03DA01') med5_eenheid_T3='mg'.
IF  (atc5_T3='C03DA01' and CHAR.INDEX(med5_dosering_T3,'25')>0 ) med5_dosis_T3='25'.
** ATC C03CA01 - furosemide.
IF  (atc1_T3='C03CA01') med1_eenheid_T3='mg'.
IF  (atc1_T3='C03CA01' and CHAR.INDEX(med1_dosering_T3,'80')>0 ) med1_dosis_T3='2x40'.
IF  (atc2_T3='C03CA01') med2_eenheid_T3='mg'.
IF  (atc2_T3='C03CA01' and CHAR.INDEX(med2_dosering_T3,'40')>0 ) med2_dosis_T3='40'.
IF  (atc3_T3='C03CA01') med3_eenheid_T3='mg'.
IF  (atc3_T3='C03CA01' and CHAR.INDEX(med3_dosering_T3,'40')>0 ) med3_dosis_T3='40'.
** ATC C03BA04.
IF  (atc1_T3='C03BA04') med1_eenheid_T3='mg'.
IF  (atc1_T3='C03BA04' and CHAR.INDEX(med1_dosering_T3,'12,5')>0 ) med1_dosis_T3='12,5'.
** ATC C03AA03 hydrochloorthiazide.
IF  (atc1_T3='C03AA03') med1_eenheid_T3='mg'.
IF  (atc1_T3='C03AA03' and CHAR.INDEX(med1_dosering_T3,'12,5')>0 ) med1_dosis_T3='12,5'.
IF  (atc1_T3='C03AA03' and CHAR.INDEX(med1_T3,'12.5')>0 ) med1_dosis_T3='12,5'.
IF  (atc2_T3='C03AA03') med2_eenheid_T3='mg'.
IF  (atc2_T3='C03AA03' and CHAR.INDEX(med2_dosering_T3,'25')>0 ) med2_dosis_T3='25'.
IF  (atc2_T3='C03AA03' and CHAR.INDEX(med2_dosering_T3,'12.5')>0 ) med2_dosis_T3='12,5'.
IF  (atc3_T3='C03AA03') med3_eenheid_T3='mg'.
IF  (atc3_T3='C03AA03' and CHAR.INDEX(med3_dosering_T3,'12.5')>0 ) med3_dosis_T3='12.5'.
IF  (atc4_T3='C03AA03') med4_eenheid_T3='mg'.
IF  (atc4_T3='C03AA03' and CHAR.INDEX(med4_dosering_T3,'25')>0 ) med4_dosis_T3='25'.
IF  (atc4_T3='C03AA03' and CHAR.INDEX(med4_dosering_T3,'12,5')>0 ) med4_dosis_T3='12,5'.
IF  (atc5_T3='C03AA03') med5_eenheid_T3='mg'.
IF  (atc5_T3='C03AA03' and CHAR.INDEX(med5_dosering_T3,'10')>0 ) med5_dosis_T3='12.5'.
IF  (atc6_T3='C03AA03') med6_eenheid_T3='mg'.
IF  (atc6_T3='C03AA03' and CHAR.INDEX(med6_dosering_T3,'5')>0 ) med6_dosis_T3='12,5'.
IF  (atc6_T3='C03AA03' and CHAR.INDEX(med6_dosering_T3,'25')>0 ) med6_dosis_T3='25'.
IF  (atc8_T3='C03AA03') med8_eenheid_T3='mg'.
IF  (atc8_T3='C03AA03' and CHAR.INDEX(med8_dosering_T3,'5')>0 ) med8_dosis_T3='5'.
** ATC C02.
IF  (atc1_T3='C02') med1_eenheid_T3='mg'.
IF  (atc1_T3='C02' and CHAR.INDEX(med1_dosering_T3,'75')>0 ) med1_dosis_T3='75'.
IF  (atc1_T3='C02' and CHAR.INDEX(med1_dosering_T3,'200')>0 ) med1_dosis_T3='200'.
IF  (atc1_T3='C02' and CHAR.INDEX(med1_dosering_T3,'100')>0 ) med1_dosis_T3='100'.
IF  (atc1_T3='C02' and CHAR.INDEX(med1_dosering_T3,'105')>0 ) med1_dosis_T3='105'.
IF  (atc1_T3='C02' and CHAR.INDEX(med1_dosering_T3,'160')>0 ) med1_dosis_T3='160'.
** ATC C01DA14.
IF  (atc2_T3='C01DA14') med2_eenheid_T3='mg'.
IF  (atc2_T3='C01DA14' and CHAR.INDEX(med2_T3,'25')>0 ) med2_dosis_T3='25'.
IF  (atc4_T3='C01DA14') med4_eenheid_T3='mg'.
IF  (atc4_T3='C01DA14' and CHAR.INDEX(med4_dosering_T3,'100')>0 ) med4_dosis_T3='100'.
IF  (atc5_T3='C01DA14') med5_eenheid_T3='mg'.
IF  (atc5_T3='C01DA14' and CHAR.INDEX(med5_dosering_T3,'1xdaags')>0 ) med5_dosis_T3='100'.
IF  (atc6_T3='C01DA14') med6_eenheid_T3='mg'.
IF  (atc6_T3='C01DA14' and CHAR.INDEX(med6_dosering_T3,'30')>0 ) med6_dosis_T3='30'.
IF  (atc7_T3='C01DA14') med7_eenheid_T3='mg'.
IF  (atc7_T3='C01DA14' and CHAR.INDEX(med7_dosering_T3,'25')>0 ) med7_dosis_T3='25'.

** ATC C01DA08.
IF  (atc10_T3='C01DA08') med10_eenheid_T3='mg'.
IF  (atc10_T3='C01DA08' and CHAR.INDEX(med10_dosering_T3,'5')>0 ) med10_dosis_T3='5'.

** ATC B03BB01 - foliumzuur.
IF  (atc1_T3='B03BB01') med1_eenheid_T3='mg'.
IF  (atc1_T3='B03BB01' and CHAR.INDEX(med1_dosering_T3,'10')>0 ) med1_dosis_T3='2x5'.
IF  (atc2_T3='B03BB01') med2_eenheid_T3='mg'.
IF  (atc2_T3='B03BB01' and CHAR.INDEX(med2_dosering_T3,'5')>0 ) med2_dosis_T3='5'.
IF  (atc5_T3='B03BB01') med5_eenheid_T3='mg'.
IF  (atc5_T3='B03BB01' and CHAR.INDEX(med5_dosering_T3,'2,5')>0 ) med5_dosis_T3='halve van 5'.
** ATC B03BA03 - vit B12 injectie. Zijn altijd ampullen van 2 ml.
IF  (atc2_T3='B03BA03') med2_eenheid_T3='ml'.
IF  (atc2_T3='B03BA03' and CHAR.INDEX(med2_dosering_T3,'2')>0 ) med2_dosis_T3='2'.
** ATC B01.
IF  (atc1_T3='B01') med1_eenheid_T3='mg'.
IF  (atc1_T3='B01' and CHAR.INDEX(med1_dosering_T3,'80')>0 ) med1_dosis_T3='80'.
IF  (atc2_T3='B01') med2_eenheid_T3='mg'.
IF  (atc2_T3='B01' and CHAR.INDEX(med2_dosering_T3,'80')>0 ) med2_dosis_T3='80'.
IF  (atc2_T3='B01' and CHAR.INDEX(med2_dosering_T3,'100')>0 ) med2_dosis_T3='100'.
** ATC B01AF01.
IF  (atc3_T3='B01AF01') med3_eenheid_T3='mg'.
IF  (atc3_T3='B01AF01' and CHAR.INDEX(med3_dosering_T3,'20')>0 ) med3_dosis_T3='20'.
** ATC B01AC08 - carbasalaatcalcium/ascal.
* poeder of tablet van 100 mg maakt niet uit voor kosten.
IF  (atc1_T3='B01AC08') med1_eenheid_T3='mg'.
IF  (atc1_T3='B01AC08' and CHAR.INDEX(med1_dosering_T3,'100')>0 ) med1_dosis_T3='100'.
IF  (atc1_T3='B01AC08' and CHAR.INDEX(med1_dosering_T3,'2x per dag')>0 ) med1_dosis_T3='100'.
IF  (atc2_T3='B01AC08') med2_eenheid_T3='mg'.
IF  (atc2_T3='B01AC08' and CHAR.INDEX(med2_dosering_T3,'100')>0 ) med2_dosis_T3='100'.
IF  (atc3_T3='B01AC08') med3_eenheid_T3='mg'.
IF  (atc3_T3='B01AC08' and CHAR.INDEX(med3_dosering_T3,'100')>0 ) med3_dosis_T3='100'.
IF  (atc3_T3='B01AC08' and CHAR.INDEX(med3_dosering_T3,'zakje')>0 ) med3_dosis_T3='100'.
IF  (atc4_T3='B01AC08') med4_eenheid_T3='mg'.
IF  (atc4_T3='B01AC08' and CHAR.INDEX(med4_dosering_T3,'80')>0 ) med4_dosis_T3='100'.
IF  (atc4_T3='B01AC08' and CHAR.INDEX(med4_dosering_T3,'25')>0 ) med4_dosis_T3='100'.
IF  (atc4_T3='B01AC08' and CHAR.INDEX(med4_dosering_T3,'100')>0 ) med4_dosis_T3='100'.
IF  (atc5_T3='B01AC08') med5_eenheid_T3='mg'.
IF  (atc5_T3='B01AC08' and CHAR.INDEX(med5_dosering_T3,'100')>0 ) med5_dosis_T3='100'.
IF  (atc5_T3='B01AC08' and CHAR.INDEX(med5_dosering_T3,'10')>0 ) med5_dosis_T3='100'.
IF  (atc6_T3='B01AC08') med6_eenheid_T3='mg'.
IF  (atc6_T3='B01AC08' and CHAR.INDEX(med6_dosering_T3,'100')>0 ) med6_dosis_T3='100'.
IF  (atc6_T3='B01AC08' and CHAR.INDEX(med6_dosering_T3,'80')>0 ) med6_dosis_T3='100'.
** ATC B01AC07- dipyridamol.
IF  (atc1_T3='B01AC07') med1_eenheid_T3='mg'.
IF  (atc1_T3='B01AC07' and CHAR.INDEX(med1_dosering_T3,'200')>0 ) med1_dosis_T3='200'.
IF  (atc3_T3='B01AC07') med3_eenheid_T3='mg'.
IF  (atc3_T3='B01AC07' and CHAR.INDEX(med3_dosering_T3,'200')>0 ) med3_dosis_T3='200'.
IF  (atc5_T3='B01AC07') med5_eenheid_T3='mg'.
IF  (atc5_T3='B01AC07' and CHAR.INDEX(med5_dosering_T3,'400')>0 ) med5_dosis_T3='400'.
** ATC B01AC06 - acetylsalicylzuur.
IF  (atc1_T3='B01AC06') med1_eenheid_T3='mg'.
IF  (atc1_T3='B01AC06' and CHAR.INDEX(med1_dosering_T3,'80')>0 ) med1_dosis_T3='80'.
IF  (atc1_T3='B01AC06' and CHAR.INDEX(med1_dosering_T3,'1x')>0 ) med1_dosis_T3='80'.
IF  (atc2_T3='B01AC06') med2_eenheid_T3='mg'.
IF  (atc2_T3='B01AC06' and med2_vorm_T3='poeder' and CHAR.INDEX(med2_dosering_T3,'1')>0 ) med2_dosis_T3='500'.
IF  (atc2_T3='B01AC06' and CHAR.INDEX(med2_dosering_T3,'80')>0 ) med2_dosis_T3='80'.
IF  (atc3_T3='B01AC06') med3_eenheid_T3='mg'.
IF  (atc3_T3='B01AC06' and CHAR.INDEX(med3_dosering_T3,'80')>0 ) med3_dosis_T3='80'.
IF  (atc4_T3='B01AC06') med4_eenheid_T3='mg'.
IF  (atc4_T3='B01AC06' and CHAR.INDEX(med4_dosering_T3,'12,5')>0 ) med4_dosis_T3='80'.
IF  (atc7_T3='B01AC06') med7_eenheid_T3='mg'.
IF  (atc7_T3='B01AC06' and CHAR.INDEX(med7_dosering_T3,'80')>0 ) med7_dosis_T3='80'.
** ATC B01AC04 - clopidogrel.
IF  (atc2_T3='B01AC04') med2_eenheid_T3='mg'.
IF  (atc2_T3='B01AC04' and CHAR.INDEX(med2_dosering_T3,'75')>0 ) med2_dosis_T3='75'.
IF  (atc6_T3='B01AC04') med6_eenheid_T3='mg'.
IF  (atc6_T3='B01AC04' and CHAR.INDEX(med6_dosering_T3,'75')>0 ) med6_dosis_T3='75'.
** ATC B01AB06 - clopidogrel.
IF  (atc2_T3='B01AB06') med2_eenheid_T3='ml'.
IF  (atc2_T3='B01AB06' and CHAR.INDEX(med2_dosering_T3,'0,3')>0 ) med2_dosis_T3='0.3'.
** ATC B01AA07.
IF  (atc1_T3='B01AA07') med1_eenheid_T3='mg'.
IF  (atc1_T3='B01AA07' and CHAR.INDEX(med1_dosering_T3,'6')>0 ) med1_dosis_T3='6x1'.
IF  (atc4_T3='B01AA07') med4_eenheid_T3='mg'.
IF  (atc4_T3='B01AA07' and CHAR.INDEX(med4_dosering_T3,'5')>0 ) med4_dosis_T3='5x1'.
** ATC B01AA04 fenprocoumon.
IF  (atc2_T3='B01AA04') med2_eenheid_T3='mg'.
IF  (atc2_T3='B01AA04' and CHAR.INDEX(med2_dosering_T3,'1')>0 ) med2_dosis_T3='3'.
* bedoelt 1 tablet, is alleen in 3 mg.
IF  (atc4_T3='B01AA04') med4_eenheid_T3='mg'.
IF  (atc4_T3='B01AA04' and CHAR.INDEX(med4_dosering_T3,'3')>0 ) med4_dosis_T3='3'.
** ATC B01.
IF  (atc2_T3='B01') med2_eenheid_T3='mg'.
IF  (atc2_T3='B01' and CHAR.INDEX(med2_dosering_T3,'80')>0 ) med2_dosis_T3='80'.
IF  (atc2_T3='B01' and CHAR.INDEX(med2_dosering_T3,'100')>0 ) med2_dosis_T3='100'.
** ATC A12BA01.
IF  (atc3_T3='A12BA01') med3_eenheid_T3='mg'.
IF  (atc3_T3='A12BA01' and CHAR.INDEX(med3_dosering_T3,'500')>0 ) med3_dosis_T3=''.
** ATC A12AA04.
IF  (atc1_T3='A12AA04') med1_eenheid_T3='mg'.
IF  (atc1_T3='A12AA04' and CHAR.INDEX(med1_dosering_T3,'500')>0 ) med1_dosis_T3='500'.
IF  (atc4_T3='A12AA04') med4_eenheid_T3='mg'.
IF  (atc4_T3='A12AA04' and CHAR.INDEX(med4_dosering_T3,'500')>0 ) med4_dosis_T3='500'.
** ATC A11GA01-  ascorbinezuur.
IF  (atc3_T3='A11GA01') med3_eenheid_T3='mg'.
IF  (atc3_T3='A11GA01' and CHAR.INDEX(med3_dosering_T3,'5')>0 ) med3_dosis_T3='5'.
** ATC A11CC - .
IF  (atc2_T3='A11CC') med2_eenheid_T3='IE'.
IF  (atc2_T3='A11CC' and CHAR.INDEX(med2_dosering_T3,'800')>0 ) med2_dosis_T3='800'.
** ATC A11CC05 - vit D.
IF  (atc2_T3='A11CC05') med2_eenheid_T3='IE'.
IF  (atc2_T3='A11CC05' and CHAR.INDEX(med2_dosering_T3,'800')>0 ) med2_dosis_T3='800'.
IF  (atc4_T3='A11CC05') med4_eenheid_T3='IE'.
IF  (atc4_T3='A11CC05' and CHAR.INDEX(med4_dosering_T3,'800')>0 ) med4_dosis_T3='800'.
IF  (atc5_T3='A11CC05') med5_eenheid_T3='IE'.
IF  (atc5_T3='A11CC05' and CHAR.INDEX(med5_dosering_T3,'800')>0 ) med5_dosis_T3='800'.
** ATC A11CC03.
IF  (atc2_T3='A11CC03') med2_eenheid_T3='ug'.
IF  (atc2_T3='A11CC03' and CHAR.INDEX(med2_dosering_T3,'0,25')>0 ) med2_dosis_T3='0,25'.
** ATC A10BD08.
IF  (atc1_T3='A10BD08') med1_eenheid_T3='mg'.
IF  (atc1_T3='A10BD08' and CHAR.INDEX(med1_T3,'mo/850')>0 ) med1_dosis_T3='50/850'.
IF  (atc2_T3='A10BD08') med2_eenheid_T3='mg'.
IF  (atc2_T3='A10BD08' and CHAR.INDEX(med2_T3,'50/850')>0 ) med2_dosis_T3='50/850'.
** ATC A10BB12.
IF  (atc2_T3='A10BB12') med2_eenheid_T3='mg'.
IF  (atc2_T3='A10BB12' and CHAR.INDEX(med2_dosering_T3,'3')>0 ) med2_dosis_T3='3'.
** ATC A10BB09 - gliclazide.
IF  (atc1_T3='A10BB09') med1_eenheid_T3='mg'.
IF  (atc1_T3='A10BB09' and CHAR.INDEX(med1_dosering_T3,'80')>0 ) med1_dosis_T3='80'.
IF  (atc3_T3='A10BB09') med3_eenheid_T3='mg'.
IF  (atc3_T3='A10BB09' and CHAR.INDEX(med3_dosering_T3,'30')>0 ) med3_dosis_T3='30'.
IF  (atc7_T3='A10BB09') med7_eenheid_T3='mg'.
IF  (atc7_T3='A10BB09' and CHAR.INDEX(med7_dosering_T3,'')>0 ) med7_dosis_T3=''.
** ATC A10BB03.
IF  (atc2_T3='A10BB03') med2_eenheid_T3='mg'.
IF  (atc2_T3='A10BB03' and CHAR.INDEX(med2_dosering_T3,'1000')>0 ) med2_dosis_T3='1000'.
** ATC A10BA02- metformine.
IF  (atc1_T3='A10BA02') med1_eenheid_T3='mg'.
IF  (atc1_T3='A10BA02' and CHAR.INDEX(med1_dosering_T3,'850')>0 ) med1_dosis_T3='850'.
IF  (atc1_T3='A10BA02' and CHAR.INDEX(med1_dosering_T3,'1000')>0 ) med1_dosis_T3='1000'.
IF  (atc1_T3='A10BA02' and CHAR.INDEX(med1_dosering_T3,'500')>0 ) med1_dosis_T3='500'.
IF  (atc1_T3='A10BA02' and ID_code=1704 ) med1_dosis_T3='1000'.
IF  (atc2_T3='A10BA02') med2_eenheid_T3='mg'.
IF  (atc2_T3='A10BA02' and CHAR.INDEX(med2_dosering_T3,'850')>0 ) med2_dosis_T3='850'.
IF  (atc2_T3='A10BA02' and CHAR.INDEX(med2_dosering_T3,'1')>0 ) med2_dosis_T3='1000'.
IF  (atc2_T3='A10BA02' and CHAR.INDEX(med2_dosering_T3,'500')>0 ) med2_dosis_T3='500'.
IF  (atc3_T3='A10BA02') med3_eenheid_T3='mg'.
IF  (atc3_T3='A10BA02' and CHAR.INDEX(med3_dosering_T3,'500')>0 ) med3_dosis_T3='500'.
IF  (atc3_T3='A10BA02' and ID_code=2512 ) med3_dosis_T3='500'.
IF  (atc5_T3='A10BA02') med5_eenheid_T3='mg'.
IF  (atc5_T3='A10BA02' and CHAR.INDEX(med5_dosering_T3,'20')>0 ) med5_dosis_T3='500'.
IF  (atc5_T3='A10BA02' and CHAR.INDEX(med5_dosering_T3,'500')>0 ) med5_dosis_T3='500'.
IF  (atc7_T3='A10BA02') med7_eenheid_T3='mg'.
IF  (atc7_T3='A10BA02' and CHAR.INDEX(med7_dosering_T3,'850')>0 ) med7_dosis_T3='850'.
** ATC A10AE04- insuline glargine/lantus.
IF  (atc1_T3='A10AE04') med1_eenheid_T3='IE'.
IF  (atc1_T3='A10AE04' and CHAR.INDEX(med1_dosering_T3,'34')>0 ) med1_dosis_T3='34'.
IF  (atc7_T3='A10AE04') med7_eenheid_T3='IE'.
IF  (atc7_T3='A10AE04' and CHAR.INDEX(med7_dosering_T3,'48')>0 ) med7_dosis_T3='48'.
** ATC A10AD05- .
IF  (atc1_T3='A10AD05') med1_eenheid_T3='IE/ml'.
IF  (atc1_T3='A10AD05' and CHAR.INDEX(med1_dosering_T3,'50')>0 ) med1_dosis_T3='50'.
** ATC A10AB05- insuline aspart.
IF  (atc6_T3='A10AB05') med6_eenheid_T3='IE'.
IF  (atc6_T3='A10AB05' and CHAR.INDEX(med6_dosering_T3,'60')>0 ) med6_dosis_T3='60'.
** ATC A09AA02 -.
IF  (atc9_T3='A09AA02') med9_eenheid_T3='FE'.
IF  (atc9_T3='A09AA02' and CHAR.INDEX(med9_T3,'2500')>0 ) med9_dosis_T3='22500/25000/1250'.
** ATC A07EA06.
IF  (atc1_T3='A07EA06') med1_eenheid_T3='mg'.
IF  (atc1_T3='A07EA06' and CHAR.INDEX(med1_dosering_T3,'3')>0 ) med1_dosis_T3='3'.
** ATC A07DA03.
IF  (atc1_T3='A07DA03') med1_eenheid_T3='mg'.
IF  (atc1_T3='A07DA03' and CHAR.INDEX(med1_dosering_T3,'2 per dag')>0 ) med1_dosis_T3='2'.
** ATC A06AG11 - .
IF  (atc4_T3='A06AG11') med4_eenheid_T3='ml'.
IF  (atc4_T3='A06AG11' and CHAR.INDEX(med4_dosering_T3,'5')>0 ) med4_dosis_T3='5'.
** ATC A06AD65 - macrogol/electrolyten.
IF  (atc1_T3='A06AD65') med1_eenheid_T3='g'.
IF  (atc1_T3='A06AD65' and CHAR.INDEX(med1_dosering_T3,'45 zakjes')>0 ) med1_dosis_T3='13,7'.
** ATC A06AD15.- macrogol.
IF  (atc3_T3='A06AD15') med3_eenheid_T3='g'.
IF  (atc3_T3='A06AD15' and CHAR.INDEX(med3_T3,'10 G')>0 ) med3_dosis_T3='10'.
IF  (atc5_T3='A06AD15') med5_eenheid_T3='g'.
IF  (atc5_T3='A06AD15' and CHAR.INDEX(med5_dosering_T3,'130mg')>0 ) med5_dosis_T3='13'.
IF  (atc7_T3='A06AD15') med7_eenheid_T3='g'.
IF  (atc7_T3='A06AD15' and CHAR.INDEX(med7_dosering_T3,'20')>0 ) med7_dosis_T3='2x10'.
** ATC A06AD11.- lactuose.
IF  (atc7_T3='A06AD11') med7_eenheid_T3='g'.
IF  (atc7_T3='A06AD11' and CHAR.INDEX(med7_dosering_T3,'12')>0 ) med7_dosis_T3='12'.
** ATC A06AB02 - bisacodyl.
IF  (atc1_T3='A06AB02') med1_eenheid_T3='mg'.
IF  (atc1_T3='A06AB02' and CHAR.INDEX(med1_dosering_T3,'5')>0 ) med1_dosis_T3='5'.
IF  (atc2_T3='A06AB02') med2_eenheid_T3='mg'.
IF  (atc2_T3='A06AB02' and CHAR.INDEX(med2_dosering_T3,'5')>0 ) med2_dosis_T3='5'.
IF  (atc5_T3='A06AB02') med5_eenheid_T3='mg'.
IF  (atc5_T3='A06AB02' and CHAR.INDEX(med5_dosering_T3,'5')>0 ) med5_dosis_T3='5'.
** ATC A03FA03 - domperidon.
IF  (atc1_T3='A03FA03') med1_eenheid_T3='mg'.
IF  (atc1_T3='A03FA03' and CHAR.INDEX(med1_dosering_T3,'5')>0 ) med1_dosis_T3='halve 10'.
** ATC A03FA01 - .
IF  (atc3_T3='A03FA01') med3_eenheid_T3='mg'.
IF  (atc3_T3='A03FA01' and CHAR.INDEX(med3_dosering_T3,'30')>0 ) med3_dosis_T3='10'.
** ATC A03AA04 - duspatal.
IF  (atc1_T3='A03AA04') med1_eenheid_T3='mg'.
IF  (atc1_T3='A03AA04' and CHAR.INDEX(med1_dosering_T3,'200')>0 ) med1_dosis_T3='200'.
** ATC A02BX13 - .
IF  (atc7_T3='A02BX13') med7_eenheid_T3='mg'.
IF  (atc7_T3='A02BX13' and CHAR.INDEX(med7_dosering_T3,'250')>0 ) med7_dosis_T3='250'.
** ATC A02BC05 - esomeprazol.
IF  (atc2_T3='A02BC05') med2_eenheid_T3='mg'.
IF  (atc2_T3='A02BC05' and CHAR.INDEX(med2_dosering_T3,'40')>0 ) med2_dosis_T3='40'.
IF  (atc3_T3='A02BC05') med3_eenheid_T3='mg'.
IF  (atc3_T3='A02BC05' and CHAR.INDEX(med3_dosering_T3,'20')>0 ) med3_dosis_T3='20'.
** ATC A02BC02- pantoprazaol.
IF  (atc1_T3='A02BC02') med1_eenheid_T3='mg'.
IF  (atc1_T3='A02BC02' and CHAR.INDEX(med1_dosering_T3,'20')>0 ) med1_dosis_T3='20'.
IF  (atc1_T3='A02BC02' and CHAR.INDEX(med1_dosering_T3,'40')>0 ) med1_dosis_T3='40'.
IF  (atc2_T3='A02BC02') med2_eenheid_T3='mg'.
IF  (atc2_T3='A02BC02' and CHAR.INDEX(med2_dosering_T3,'40')>0 ) med2_dosis_T3='40'.
IF  (atc3_T3='A02BC02') med3_eenheid_T3='mg'.
IF  (atc3_T3='A02BC02' and CHAR.INDEX(med3_dosering_T3,'20')>0 ) med3_dosis_T3='20'.
IF  (atc4_T3='A02BC02') med4_eenheid_T3='mg'.
IF  (atc4_T3='A02BC02' and CHAR.INDEX(med4_dosering_T3,'20')>0 ) med4_dosis_T3='20'.
IF  (atc4_T3='A02BC02' and CHAR.INDEX(med4_dosering_T3,'80')>0 ) med4_dosis_T3='2x40'.
IF  (atc5_T3='A02BC02') med5_eenheid_T3='mg'.
IF  (atc5_T3='A02BC02' and CHAR.INDEX(med5_dosering_T3,'40')>0 ) med5_dosis_T3='40'.
IF  (atc6_T3='A02BC02') med6_eenheid_T3='mg'.
IF  (atc6_T3='A02BC02' and CHAR.INDEX(med6_dosering_T3,'40')>0 ) med6_dosis_T3='40'.
** ATC A02BC01- omeprazol.
IF  (atc1_T3='A02BC01') med1_eenheid_T3='mg'.
IF  (atc1_T3='A02BC01' and CHAR.INDEX(med1_dosering_T3,'40')>0 ) med1_dosis_T3='40'.
IF  (atc1_T3='A02BC01' and CHAR.INDEX(med1_dosering_T3,'20')>0 ) med1_dosis_T3='20'.
IF  (atc1_T3='A02BC01' and CHAR.INDEX(med1_dosering_T3,'10')>0 ) med1_dosis_T3='10'.
IF  (atc1_T3='A02BC01' and ID_code=2404 ) med1_dosis_T3='20'.
IF  (atc2_T3='A02BC01') med2_eenheid_T3='mg'.
IF  (atc2_T3='A02BC01' and CHAR.INDEX(med2_dosering_T3,'40')>0 ) med2_dosis_T3='40'.
IF  (atc2_T3='A02BC01' and CHAR.INDEX(med2_dosering_T3,'20')>0 ) med2_dosis_T3='20'.
IF  (atc2_T3='A02BC01' and CHAR.INDEX(med2_dosering_T3,'10')>0 ) med2_dosis_T3='10'.
IF  (atc3_T3='A02BC01') med3_eenheid_T3='mg'.
IF  (atc3_T3='A02BC01' and CHAR.INDEX(med3_dosering_T3,'40')>0 ) med3_dosis_T3='40'.
IF  (atc3_T3='A02BC01' and CHAR.INDEX(med3_dosering_T3,'20')>0 ) med3_dosis_T3='20'.
IF  (atc4_T3='A02BC01') med4_eenheid_T3='mg'.
IF  (atc4_T3='A02BC01' and CHAR.INDEX(med4_dosering_T3,'40')>0 ) med4_dosis_T3='40'.
IF  (atc4_T3='A02BC01' and CHAR.INDEX(med4_dosering_T3,'20')>0 ) med4_dosis_T3='20'.
IF  (atc6_T3='A02BC01') med6_eenheid_T3='mg'.
IF  (atc6_T3='A02BC01' and CHAR.INDEX(med6_dosering_T3,'40')>0 ) med6_dosis_T3='40'.
IF  (atc8_T3='A02BC01') med8_eenheid_T3='mg'.
IF  (atc8_T3='A02BC01' and CHAR.INDEX(med8_dosering_T3,'40')>0 ) med8_dosis_T3='40'.
** ATC A02BA02.
IF  (atc1_T3='A02BA02') med1_eenheid_T3='mg'.
IF  (atc1_T3='A02BA02' and CHAR.INDEX(med1_dosering_T3,'300')>0 ) med1_dosis_T3='300'.
IF  (atc2_T3='A02BA02') med2_eenheid_T3='mg'.
IF  (atc2_T3='A02BA02' and CHAR.INDEX(med2_dosering_T3,'300')>0 ) med2_dosis_T3='300'.
** ATC A02AD01.
IF  (atc2_T3='A02AD01') med2_eenheid_T3='mg'.
IF  (atc2_T3='A02AD01' and CHAR.INDEX(med2_dosering_T3,'1-2')>0 ) med2_dosis_T3='680/80'.
** ATC A02.
IF  (atc1_T3='A02') med1_eenheid_T3='mg'.
IF  (atc1_T3='A02' and CHAR.INDEX(med1_dosering_T3,'40')>0 ) med1_dosis_T3='40'.
EXECUTE.



