* Encoding: UTF-8.
STRING med1_dosis_T0 (A20).
STRING med1_eenheid_T0 (A20).
STRING med2_dosis_T0 (A20).
STRING med2_eenheid_T0 (A20).
STRING med3_dosis_T0 (A20).
STRING med3_eenheid_T0 (A20).
STRING med4_dosis_T0 (A20).
STRING med4_eenheid_T0 (A20).
STRING med5_dosis_T0 (A20).
STRING med5_eenheid_T0 (A20).
STRING med6_dosis_T0 (A20).
STRING med6_eenheid_T0 (A20).
STRING med7_dosis_T0 (A20).
STRING med7_eenheid_T0 (A20).
STRING med8_dosis_T0 (A20).
STRING med8_eenheid_T0 (A20).
STRING med9_dosis_T0 (A20).
STRING med9_eenheid_T0 (A20).
STRING med10_dosis_T0 (A20).
STRING med10_eenheid_T0 (A20).

**ATC V03AE01.
IF  (atc6_T0='V03AE01') med6_eenheid_T0='g'.
IF  (atc6_T0='V03AE01' and CHAR.INDEX(med6_dosering_T0,'15')>0 ) med6_dosis_T0='15'.
**ATC V03AB33.
IF  (atc2_T0='V03AB33') med2_eenheid_T0='mg/ml'.
IF  (atc2_T0='V03AB33' and CHAR.INDEX(med2_dosering_T0,'1 mg/2 ml')>0 ) med2_dosis_T0='1 injectie'.
**ATC R06AE07.
IF  (atc1_T0='R06AE07') med1_eenheid_T0='mg'.
IF  (atc1_T0='R06AE07' and CHAR.INDEX(med1_dosering_T0,'10')>0 ) med1_dosis_T0='10'.
**ATC R06AX27.
IF  (atc2_T0='R06AX27') med2_eenheid_T0='mg'.
IF  (atc2_T0='R06AX27' and CHAR.INDEX(med2_dosering_T0,'1')>0 ) med2_dosis_T0=''.
IF  (atc2_T0='R06AX27' and CHAR.INDEX(med2_dosering_T0,'5')>0 ) med2_dosis_T0='5'.
IF  (atc3_T0='R06AX27') med3_eenheid_T0='mg'.
IF  (atc3_T0='R06AX27' and CHAR.INDEX(med3_dosering_T0,'5')>0 ) med3_dosis_T0='5'.
IF  (atc4_T0='R06AX27') med4_eenheid_T0='mg'.
IF  (atc4_T0='R06AX27' and CHAR.INDEX(med4_dosering_T0,'25')>0 ) med4_dosis_T0='2,5'.
**ATC R06AX25.
IF  (atc9_T0='R06AX25') med9_eenheid_T0='mg'.
IF  (atc9_T0='R06AX25' and CHAR.INDEX(med9_dosering_T0,'10')>0 ) med9_dosis_T0='10'.
**ATC R05DA04 - codeine.
IF  (atc2_T0='R05DA04') med2_eenheid_T0='mg'.
**ATC R03DC03 - montelukast .
IF  (atc4_T0='R03DC03') med4_eenheid_T0='mg'.
IF  (atc4_T0='R03DC03' and CHAR.INDEX(med4_dosering_T0,'10')>0 ) med4_dosis_T0='10'.
**ATC R03BB04 - spiriva.
IF  (atc1_T0='R03BB04') med1_eenheid_T0='ug'.
IF  (atc1_T0='R03BB04' and CHAR.INDEX(med1_dosering_T0,'1 x perdag')>0 ) med1_dosis_T0='18'.
IF  (atc2_T0='R03BB04') med2_eenheid_T0='ug'.
IF  (atc2_T0='R03BB04' and CHAR.INDEX(med2_dosering_T0,'18')>0 ) med2_dosis_T0='18'.
IF  (atc2_T0='R03BB04' and CHAR.INDEX(med2_dosering_T0,'5')>0 ) med2_dosis_T0='2x2,5 vloeistof'.
IF  (atc3_T0='R03BB04') med3_eenheid_T0='ug'.
IF  (atc3_T0='R03BB04' and CHAR.INDEX(med3_dosering_T0,'18')>0 ) med3_dosis_T0='18'.
IF  (atc6_T0='R03BB04') med6_eenheid_T0='ug'.
IF  (atc6_T0='R03BB04' and CHAR.INDEX(med6_dosering_T0,'18')>0 ) med6_dosis_T0='18'.
**ATC R03BB01 - atrovent.
IF  (atc3_T0='R03BB01') med3_eenheid_T0='mg'.
**ATC R03BA05 - flixotide/fluticason.
IF  (atc2_T0='R03BA05') med2_eenheid_T0='ug/dosis'.
IF  (atc3_T0='R03BA05') med3_eenheid_T0='ug/dosis'.
IF  (atc3_T0='R03BA05' and CHAR.INDEX(med3_dosering_T0,'250')>0 ) med3_dosis_T0='250'.
IF  (atc5_T0='R03BA05') med5_eenheid_T0='ug/dosis'.
IF  (atc5_T0='R03BA05' and CHAR.INDEX(med5_dosering_T0,'100')>0 ) med5_dosis_T0='100'.
**ATC R03BA02 - .
IF  (atc1_T0='R03BA02') med1_eenheid_T0='ug/dosis'.
IF  (atc1_T0='R03BA02' and CHAR.INDEX(med1_dosering_T0,'?')>0 ) med1_dosis_T0='100'.
IF  (atc8_T0='R03BA02') med8_eenheid_T0='ug/dosis'.
IF  (atc8_T0='R03BA02' and CHAR.INDEX(med8_dosering_T0,'0,2')>0 ) med8_dosis_T0='200 (poeder)'.
**ATC R03BA01 - .
IF  (atc1_T0='R03BA01') med1_eenheid_T0='ug/dosis'.
IF  (atc1_T0='R03BA01' and ID_code=5119) med1_dosis_T0='100'.
IF  (atc2_T0='R03BA01') med2_eenheid_T0='ug/dosis'.
IF  (atc2_T0='R03BA01' and CHAR.INDEX(med2_dosering_T0,'50')>0 ) med2_dosis_T0='50'.
IF  (atc3_T0='R03BA01') med3_eenheid_T0='ug/dosis'.
IF  (atc3_T0='R03BA01' and CHAR.INDEX(med3_dosering_T0,'50')>0 ) med3_dosis_T0='50'.
IF  (atc8_T0='R03BA01') med8_eenheid_T0='ug/dosis'.
IF  (atc8_T0='R03BA01' and CHAR.INDEX(med8_dosering_T0,'0,2')>0 ) med8_dosis_T0='200 (poeder)'.
**ATC R03AK10 Relvar.
IF  (atc2_T0='R03AK10') med2_eenheid_T0='ug/dosis'.
IF  (atc2_T0='R03AK10' and CHAR.INDEX(med2_dosering_T0,'92/22')>0 ) med2_dosis_T0='92/22'.
IF  (atc6_T0='R03AK10') med6_eenheid_T0='ug/dosis'.
IF  (atc6_T0='R03AK10' and CHAR.INDEX(med6_dosering_T0,'0,22')>0 ) med6_dosis_T0=' '.
**ATC R03AK07-symbicort.
IF  (atc1_T0='R03AK07') med1_eenheid_T0='ug/dosis'.
IF  (atc1_T0='R03AK07' and CHAR.INDEX(med1_dosering_T0,'400')>0 ) med1_dosis_T0='400/12'.
IF  (atc1_T0='R03AK07' and CHAR.INDEX(med1_dosering_T0,'100')>0 ) med1_dosis_T0='100/6'.
IF  (atc2_T0='R03AK07') med2_eenheid_T0='ug/dosis'.
**ATC R03AK06 - seretide (salmeterol/fluticason).
IF  (atc1_T0='R03AK06') med1_eenheid_T0='ug/dosis'.
IF  (atc1_T0='R03AK06' and CHAR.INDEX(med1_dosering_T0,'50')>0 ) med1_dosis_T0='50/?'.
IF  (atc1_T0='R03AK06' and CHAR.INDEX(med1_dosering_T0,'250')>0 ) med1_dosis_T0='50/250'.
IF  (atc2_T0='R03AK06') med2_eenheid_T0='ug/dosis'.
IF  (atc2_T0='R03AK06' and CHAR.INDEX(med2_dosering_T0,'250')>0 ) med2_dosis_T0='250/?'.
IF  (atc3_T0='R03AK06') med3_eenheid_T0='ug/dosis'.
IF  (atc5_T0='R03AK06') med5_eenheid_T0='ug/dosis'.
IF  (atc5_T0='R03AK06' and CHAR.INDEX(med5_dosering_T0,'25/250')>0 ) med5_dosis_T0='25/250'.
**ATC R03AC13.
IF  (atc1_T0='R03AC13') med1_eenheid_T0='ug/dosis'.
IF  (atc1_T0='R03AC13' and CHAR.INDEX(med1_dosering_T0,'12')>0 ) med1_dosis_T0='12'.
**ATC R03AC12- salmeterol.
IF  (atc5_T0='R03AC12') med5_eenheid_T0='ug/dosis'.
IF  (atc5_T0='R03AC12' and CHAR.INDEX(med5_dosering_T0,'25/250')>0 ) med5_dosis_T0='25'.
**ATC R03AC02 - salbutamol - ventolin.
IF  (atc1_T0='R03AC02') med1_eenheid_T0='ug/dosis'.
IF  (atc1_T0='R03AC02' and CHAR.INDEX(med1_dosering_T0,'250')>0 ) med1_dosis_T0='200'.
IF  (atc1_T0='R03AC02' and CHAR.INDEX(med1_dosering_T0,'200')>0 ) med1_dosis_T0='200'.
IF  (atc2_T0='R03AC02') med2_eenheid_T0='ug/dosis'.
IF  (atc2_T0='R03AC02' and med2_vorm_T0='verstuiver') med2_eenheid_T0='ug/ml'.
IF  (atc2_T0='R03AC02' and CHAR.INDEX(med2_dosering_T0,'250')>0 ) med2_dosis_T0='250'.
IF  (atc2_T0='R03AC02' and CHAR.INDEX(med2_dosering_T0,'200')>0 ) med2_dosis_T0='200'.
IF  (atc2_T0='R03AC02' and CHAR.INDEX(med2_dosering_T0,'100')>0 ) med2_dosis_T0='100'.
IF  (atc2_T0='R03AC02' and med2_dosering_T0='5') med2_dosis_T0='5 (vloeistof)'.
IF  (atc3_T0='R03AC02') med3_eenheid_T0='ug/dosis'.
IF  (atc3_T0='R03AC02' and CHAR.INDEX(med3_dosering_T0,'200')>0 ) med3_dosis_T0='200'.
IF  (atc4_T0='R03AC02') med4_eenheid_T0='ug/dosis'.
IF  (atc4_T0='R03AC02' and CHAR.INDEX(med4_dosering_T0,'200')>0 ) med4_dosis_T0='200'.
IF  (atc5_T0='R03AC02') med5_eenheid_T0='ug/dosis'.
**ATC R03AC03.
IF  (atc3_T0='R03AC03') med3_eenheid_T0='ug/dosis'.
IF  (atc3_T0='R03AC03' and CHAR.INDEX(med3_dosering_T0,'500')>0 ) med3_dosis_T0='500'.
**ATC R01AD12.
IF  (atc1_T0='R01AD12') med1_eenheid_T0='ug/dosis'.
IF  (atc1_T0='R01AD12' and CHAR.INDEX(med1_dosering_T0,'27,5')>0 ) med1_dosis_T0='27.5'.
IF  (atc7_T0='R01AD12') med7_eenheid_T0='ug/dosis'.
IF  (atc7_T0='R01AD12' and CHAR.INDEX(med7_dosering_T0,'0,275')>0 ) med7_dosis_T0='27.5'.
**ATC R01AD08 - fluticason.
IF  (atc5_T0='R01AD08') med5_eenheid_T0='ug/dosis'.
IF  (atc5_T0='R01AD08' and CHAR.INDEX(med5_dosering_T0,'100')>0 ) med5_dosis_T0='100'.
**ATC R01AD05 - budesonide.
IF  (atc4_T0='R01AD05') med4_eenheid_T0='ug/dosis'.
IF  (atc4_T0='R01AD05' and CHAR.INDEX(med4_dosering_T0,'100')>0 ) med4_dosis_T0='100 (spray)'.
**ATC P01BB51 - mallerone.
IF  (atc7_T0='P01BB51') med7_eenheid_T0='mg'.
IF  (atc7_T0='P01BB51' and CHAR.INDEX(med7_dosering_T0,'?')>0 ) med7_dosis_T0='250/100'.
**ATC P01AB01.
IF  (atc1_T0='P01AB01') med1_eenheid_T0='mg'.
IF  (atc1_T0='P01AB01' and CHAR.INDEX(med1_dosering_T0,'500')>0 ) med1_dosis_T0='500'.
** ATC N07XX09-.
IF  (atc7_T0='N07XX09') med7_eenheid_T0='mg'.
IF  (atc7_T0='N07XX09' and CHAR.INDEX(med7_dosering_T0,'2')>0 ) med7_dosis_T0='240'.
** ATC N07BC02.
IF  (atc6_T0='N07BC02') med6_eenheid_T0='ml'.
IF  (atc6_T0='N07BC02' and CHAR.INDEX(med6_dosering_T0,'0,8')>0 ) med6_dosis_T0='0,8'.
** ATC N07BA03- champix.
IF  (atc1_T0='N07BA03') med1_eenheid_T0='mg'.
IF  (atc1_T0='N07BA03' and CHAR.INDEX(med1_dosering_T0,'1 ')>0 ) med1_dosis_T0='1'.
IF  (atc1_T0='N07BA03' and CHAR.INDEX(med1_dosering_T0,'1mg')>0 ) med1_dosis_T0='1'.
IF  (atc1_T0='N07BA03' and CHAR.INDEX(med1_dosering_T0,'100')>0 ) med1_dosis_T0='1'.
IF  (atc2_T0='N07BA03') med2_eenheid_T0='mg'.
** ATC N06BA04 - ritalin.
IF  (atc3_T0='N06BA04') med3_eenheid_T0='mg'.
IF  (atc3_T0='N06BA04' and CHAR.INDEX(med3_dosering_T0,'10')>0 ) med3_dosis_T0='10'.
IF  (atc3_T0='N06BA04' and CHAR.INDEX(med3_dosering_T0,'30')>0 ) med3_dosis_T0='30'.
IF  (atc4_T0='N06BA04') med4_eenheid_T0='mg'.
IF  (atc4_T0='N06BA04' and CHAR.INDEX(med4_dosering_T0,'27')>0 ) med4_dosis_T0='27'.
IF  (atc7_T0='N06BA04') med7_eenheid_T0='mg'.
IF  (atc7_T0='N06BA04' and CHAR.INDEX(med7_dosering_T0,'10')>0 ) med7_dosis_T0='10'.
** ATC N06AX21.
IF  (atc1_T0='N06AX21') med1_eenheid_T0='mg'.
IF  (atc1_T0='N06AX21' and CHAR.INDEX(med1_dosering_T0,'30')>0 ) med1_dosis_T0='30'.
** ATC N06AX16.
IF  (atc1_T0='N06AX16') med1_eenheid_T0='mg'.
IF  (atc1_T0='N06AX16' and CHAR.INDEX(med1_dosering_T0,'150')>0 ) med1_dosis_T0='150'.
IF  (atc1_T0='N06AX16' and CHAR.INDEX(med1_dosering_T0,'75')>0 ) med1_dosis_T0='75'.
IF  (atc2_T0='N06AX16') med2_eenheid_T0='mg'.
IF  (atc2_T0='N06AX16' and CHAR.INDEX(med2_dosering_T0,'150')>0 ) med2_dosis_T0='150'.
** ATC N06AX12.
IF  (atc1_T0='N06AX12') med1_eenheid_T0='mg'.
IF  (atc1_T0='N06AX12' and CHAR.INDEX(med1_dosering_T0,'100')>0 ) med1_dosis_T0='100'.
** ATC N06AB10.
IF  (atc1_T0='N06AB10') med1_eenheid_T0='mg'.
IF  (atc1_T0='N06AB10' and CHAR.INDEX(med1_dosering_T0,'10')>0 ) med1_dosis_T0='10'.
IF  (atc4_T0='N06AB10') med4_eenheid_T0='mg'.
IF  (atc4_T0='N06AB10' and CHAR.INDEX(med4_dosering_T0,'10')>0 ) med4_dosis_T0='10'.
** ATC N06AB06.
IF  (atc1_T0='N06AB06') med1_eenheid_T0='mg'.
IF  (atc1_T0='N06AB06' and CHAR.INDEX(med1_dosering_T0,'50')>0 ) med1_dosis_T0='50'.
IF  (atc2_T0='N06AB06') med2_eenheid_T0='mg'.
IF  (atc2_T0='N06AB06' and CHAR.INDEX(med2_dosering_T0,'100')>0 ) med2_dosis_T0='100'.
IF  (atc2_T0='N06AB06' and CHAR.INDEX(med2_dosering_T0,'1')>0  and Id_code=4914) med2_dosis_T0='50'.
** ATC N06AB05 - paroxetine.
IF  (atc1_T0='N06AB05') med1_eenheid_T0='mg'.
IF  (atc1_T0='N06AB05' and CHAR.INDEX(med1_dosering_T0,'10')>0 ) med1_dosis_T0='10'.
IF  (atc1_T0='N06AB05' and CHAR.INDEX(med1_dosering_T0,'20')>0 ) med1_dosis_T0='20'.
IF  (atc1_T0='N06AB05' and CHAR.INDEX(med1_dosering_T0,'50')>0 ) med1_dosis_T0='2,5x20'.
IF  (atc2_T0='N06AB05') med2_eenheid_T0='mg'.
IF  (atc2_T0='N06AB05' and CHAR.INDEX(med2_dosering_T0,'10')>0 ) med2_dosis_T0='10'.
IF  (atc2_T0='N06AB05' and CHAR.INDEX(med2_dosering_T0,'20')>0 ) med2_dosis_T0='20'.
IF  (atc2_T0='N06AB05' and CHAR.INDEX(med2_dosering_T0,'30')>0 ) med2_dosis_T0='30'.
** ATC N06AB04 - citalopram.
IF  (atc3_T0='N06AB04') med3_eenheid_T0='mg'.
IF  (atc3_T0='N06AB04' and CHAR.INDEX(med3_dosering_T0,'10')>0 ) med3_dosis_T0='10'.
IF  (atc7_T0='N06AB04') med7_eenheid_T0='mg'.
IF  (atc7_T0='N06AB04' and CHAR.INDEX(med7_dosering_T0,'10')>0 ) med7_dosis_T0='10'.
** ATC N06AB03 .
IF  (atc5_T0='N06AB03') med5_eenheid_T0='mg'.
IF  (atc5_T0='N06AB03' and CHAR.INDEX(med5_dosering_T0,'40')>0 ) med5_dosis_T0='2x20'.
** ATC N06AA09 amitriptiline.
IF  (atc1_T0='N06AA09') med1_eenheid_T0='mg'.
IF  (atc1_T0='N06AA09' and CHAR.INDEX(med1_dosering_T0,'25')>0 ) med1_dosis_T0='25'.
IF  (atc4_T0='N06AA09') med4_eenheid_T0='mg'.
IF  (atc4_T0='N06AA09' and CHAR.INDEX(med4_T0,'25')>0 ) med4_dosis_T0='25'.
** ATC N06AA04.
IF  (atc1_T0='N06AA04') med1_eenheid_T0='mg'.
IF  (atc1_T0='N06AA04' and CHAR.INDEX(med1_dosering_T0,'75')>0 ) med1_dosis_T0='75'.
** ATC N06.
IF  (atc4_T0='N06') med4_eenheid_T0='mg'.
IF  (atc4_T0='N06' and CHAR.INDEX(med4_dosering_T0,'10')>0 ) med4_dosis_T0='10'.
** ATC N05CM09 valdispert.
IF  (atc1_T0='N05CM09') med1_eenheid_T0='mg'.
IF  (atc1_T0='N05CM09' and CHAR.INDEX(med1_dosering_T0,'forte')>0 ) med1_dosis_T0='450'.
** ATC N05CH01.
IF  (atc1_T0='N05CH01') med1_eenheid_T0='mg'.
IF  (atc1_T0='N05CH01' and CHAR.INDEX(med1_dosering_T0,'0.5')>0 ) med1_dosis_T0='0.5'.
** ATC N05CF01 zoplicon.
IF  (atc3_T0='N05CF01') med3_eenheid_T0='mg'.
IF  (atc3_T0='N05CF01' and CHAR.INDEX(med3_dosering_T0,'?')>0 ) med3_dosis_T0='7.5'.
** ATC N05CD07 - temazepam.
IF  (atc2_T0='N05CD07') med2_eenheid_T0='mg'.
IF  (atc2_T0='N05CD07' and CHAR.INDEX(med2_dosering_T0,'10')>0 ) med2_dosis_T0='10'.
IF  (atc4_T0='N05CD07') med4_eenheid_T0='mg'.
IF  (atc4_T0='N05CD07' and CHAR.INDEX(med4_dosering_T0,'10')>0 ) med4_dosis_T0='10'.
** ATC N05BB01.
IF  (atc1_T0='N05BB01') med1_eenheid_T0='mg'.
IF  (atc1_T0='N05BB01' and CHAR.INDEX(med1_dosering_T0,'25')>0 ) med1_dosis_T0='25'.
** ATC N05BA06 - lorazepam.
IF  (atc2_T0='N05BA06') med2_eenheid_T0='mg'.
IF  (atc2_T0='N05BA06' and CHAR.INDEX(med2_dosering_T0,'0,5')>0 ) med2_dosis_T0='0,5'.
IF  (atc5_T0='N05BA06') med5_eenheid_T0='mg'.
IF  (atc5_T0='N05BA06' and CHAR.INDEX(med5_dosering_T0,'1')>0 ) med5_dosis_T0='1'.
** ATC N05BA04 - oxazepam.
IF  (atc1_T0='N05BA04') med1_eenheid_T0='mg'.
IF  (atc1_T0='N05BA04' and CHAR.INDEX(med1_dosering_T0,'10')>0 ) med1_dosis_T0='10'.
IF  (atc3_T0='N05BA04') med3_eenheid_T0='mg'.
IF  (atc3_T0='N05BA04' and CHAR.INDEX(med3_dosering_T0,'10')>0 ) med3_dosis_T0='10'.
IF  (atc4_T0='N05BA04') med4_eenheid_T0='mg'.
IF  (atc4_T0='N05BA04' and CHAR.INDEX(med4_dosering_T0,'10')>0 ) med4_dosis_T0='10'.
** ATC N05BA01 - diazepam/valium.
IF  (atc3_T0='N05BA01') med3_eenheid_T0='mg'.
IF  (atc3_T0='N05BA01' and CHAR.INDEX(med3_dosering_T0,'2')>0 ) med3_dosis_T0='2'.
IF  (atc3_T0='N05BA01' and CHAR.INDEX(med3_dosering_T0,'5')>0 ) med3_dosis_T0='5'.
IF  (atc4_T0='N05BA01') med4_eenheid_T0='mg'.
IF  (atc4_T0='N05BA01' and CHAR.INDEX(med4_dosering_T0,'5')>0 ) med4_dosis_T0='5'.
** ATC N05AX08.
IF  (atc1_T0='N05AX08') med1_eenheid_T0='mg'.
IF  (atc1_T0='N05AX08' and CHAR.INDEX(med1_dosering_T0,'1,5')>0 ) med1_dosis_T0='1.5'.
** ATC N05AH04 -Quetiapine.
IF  (atc1_T0='N05AH04') med1_eenheid_T0='mg'.
IF  (atc1_T0='N05AH04' and CHAR.INDEX(med1_dosering_T0,'300')>0 ) med1_dosis_T0='300'.
IF  (atc2_T0='N05AH04') med2_eenheid_T0='mg'.
IF  (atc2_T0='N05AH04' and CHAR.INDEX(med2_dosering_T0,'100')>0 ) med2_dosis_T0='100'.
IF  (atc2_T0='N05AH04' and CHAR.INDEX(med2_dosering_T0,'25')>0 ) med2_dosis_T0='25'.
** ATC N05AF01.
IF  (atc4_T0='N05AF01') med4_eenheid_T0='mg'.
IF  (atc4_T0='N05AF01' and CHAR.INDEX(med4_dosering_T0,'1')>0 ) med4_dosis_T0='1'.
** ATC N04BC05.
IF  (atc3_T0='N04BC05') med3_eenheid_T0='mg'.
IF  (atc3_T0='N04BC05' and CHAR.INDEX(med3_dosering_T0,'0, 240 mg')>0 ) med3_dosis_T0='0,25'.
** ATC N04BC04.
IF  (atc1_T0='N04BC04') med1_eenheid_T0='mg'.
IF  (atc1_T0='N04BC04' and CHAR.INDEX(med1_dosering_T0,'8')>0 ) med1_dosis_T0='8'.
IF  (atc1_T0='N04BC04' and CHAR.INDEX(med1_dosering_T0,'0,5')>0 ) med1_dosis_T0='0.5'.
** ATC N04AA02.
IF  (atc3_T0='N04AA02') med3_eenheid_T0='mg'.
IF  (atc3_T0='N04AA02' and CHAR.INDEX(med3_dosering_T0,'2')>0 ) med3_dosis_T0='2'.
** ATC N03AX16 - Lyrica.
IF  (atc1_T0='N03AX16') med1_eenheid_T0='mg'.
IF  (atc1_T0='N03AX16' and CHAR.INDEX(med1_dosering_T0,'75')>0 ) med1_dosis_T0='75'.
IF  (atc2_T0='N03AX16') med2_eenheid_T0='mg'.
IF  (atc2_T0='N03AX16' and CHAR.INDEX(med2_dosering_T0,'200')>0 ) med2_dosis_T0='2x25 en 2x75'.
** ATC N03AX14.
IF  (atc2_T0='N03AX14') med2_eenheid_T0='mg'.
IF  (atc2_T0='N03AX14' and CHAR.INDEX(med2_dosering_T0,'1500')>0 ) med2_dosis_T0='500 en 1000'.
** ATC N03AX11.
IF  (atc1_T0='N03AX11') med1_eenheid_T0='mg'.
IF  (atc1_T0='N03AX11' and CHAR.INDEX(med1_dosering_T0,'75')>0 ) med1_dosis_T0='75'.
IF  (atc1_T0='N03AX11' and CHAR.INDEX(med1_dosering_T0,'25')>0 ) med1_dosis_T0='25'.
** ATC N03AE01.
IF  (atc1_T0='N03AE01') med1_eenheid_T0='mg'.
IF  (atc1_T0='N03AE01' and CHAR.INDEX(med1_dosering_T0,'0,5')>0 ) med1_dosis_T0='0.5'.
IF  (atc2_T0='N03AE01') med2_eenheid_T0='mg'.
IF  (atc2_T0='N03AE01' and CHAR.INDEX(med2_dosering_T0,'1')>0 ) med2_dosis_T0='2x0,5'.
** ATC N02CC03.
IF  (atc3_T0='N02CC03') med3_eenheid_T0='mg'.
IF  (atc3_T0='N02CC03' and CHAR.INDEX(med3_dosering_T0,'2,5')>0 ) med3_dosis_T0='2,5'.
** ATC N02CC01 Imigram.
IF  (atc2_T0='N02CC01') med2_eenheid_T0='mg'.
IF  (atc2_T0='N02CC01' and CHAR.INDEX(med2_dosering_T0,'20')>0 ) med2_dosis_T0='20 (spray)'.
IF  (atc3_T0='N02CC01') med3_eenheid_T0='ml'.
IF  (atc3_T0='N02CC01' and CHAR.INDEX(med3_dosering_T0,'0.5')>0 ) med3_dosis_T0='0,5 (injectie)'.
IF  (atc4_T0='N02CC01') med4_eenheid_T0='mg'.
IF  (atc4_T0='N02CC01' and CHAR.INDEX(med4_dosering_T0,'25')>0 ) med4_dosis_T0='25 (zetpil)'.
** ATC N02BE51 - paracetamol/vit C en/of caffeine.
IF  (atc1_T0='N02BE51') med1_eenheid_T0='mg'.
IF  (atc1_T0='N02BE51' and (med1_T0='Excedrin')) med1_dosis_T0='250/250/65'.
IF  (atc1_T0='N02BE51' and CHAR.INDEX(med1_dosering_T0,'500')>0 ) med1_dosis_T0='500/30 poeder'.
** ATC N02BE01 - paracetamol.
IF  (atc1_T0='N02BE01') med1_eenheid_T0='mg'.
IF  (atc1_T0='N02BE01' and med1_dosering_T0='1') med1_dosis_T0='500'.
*2: bedoelt 2 tabletten, staat ook al bij aantal per dag, we gaan uit van 500 mg.
IF  (ID_code=4914 and atc1_T0='N02BE01' and med1_dosering_T0='2') med1_dosis_T0='500'.
*2: bedoelt 2 tabletten, aantal per dag=1, dus 1x2 tabletten, we gaan uit van 500 mg.
IF  (ID_code=2909 and atc1_T0='N02BE01' and med1_dosering_T0='2') med1_dosis_T0='2x500'.
IF  (atc1_T0='N02BE01' and med1_dosering_T0='1000') med1_dosis_T0='1000'.
IF  (atc1_T0='N02BE01' and med1_dosering_T0='1000mg') med1_dosis_T0='1000'.
IF  (atc1_T0='N02BE01' and med1_dosering_T0='1000 mg') med1_dosis_T0='1000'.
IF  (atc1_T0='N02BE01' and med1_dosering_T0= '100') med1_dosis_T0='100'.
IF  (atc1_T0='N02BE01' and med1_dosering_T0= '100 mg') med1_dosis_T0='100'.
IF  (atc1_T0='N02BE01' and CHAR.INDEX(med1_dosering_T0,'500')>0 ) med1_dosis_T0='500'.
IF  (atc1_T0='N02BE01' and CHAR.INDEX(med1_dosering_T0,'200')>0 ) med1_dosis_T0=''.
IF  (atc1_T0='N02BE01' and CHAR.INDEX(med1_dosering_T0,'400')>0 ) med1_dosis_T0=''.
IF  (atc2_T0='N02BE01') med2_eenheid_T0='mg'.
IF  (atc2_T0='N02BE01' and med2_dosering_T0='1000mg') med2_dosis_T0='1000'.
IF  (atc2_T0='N02BE01' and med2_dosering_T0='1000') med2_dosis_T0='1000'.
IF  (atc2_T0='N02BE01' and CHAR.INDEX(med2_dosering_T0,'500')>0 ) med2_dosis_T0='500'.
IF  (atc2_T0='N02BE01' and CHAR.INDEX(med2_dosering_T0,'375')>0 ) med2_dosis_T0='1,5 x 250'.
IF  (atc2_T0='N02BE01' and CHAR.INDEX(med2_dosering_T0,'250')>0 ) med2_dosis_T0='250'.
IF  (atc2_T0='N02BE01' and CHAR.INDEX(med2_dosering_T0,'200')>0 ) med2_dosis_T0='200'.
IF  (atc2_T0='N02BE01' and CHAR.INDEX(med2_dosering_T0,'375')>0 ) med2_dosis_T0='1,5 x 250'.
IF  (atc3_T0='N02BE01') med3_eenheid_T0='mg'.
IF  (atc3_T0='N02BE01' and med3_dosering_T0='1000mg') med3_dosis_T0='1000'.
IF  (atc3_T0='N02BE01' and med3_dosering_T0='1 tablet') med3_dosis_T0='500'.
IF  (atc3_T0='N02BE01' and CHAR.INDEX(med3_dosering_T0,'500')>0 ) med3_dosis_T0='500'.
IF  (atc4_T0='N02BE01') med4_eenheid_T0='mg'.
IF  (atc4_T0='N02BE01' and CHAR.INDEX(med4_dosering_T0,'500')>0 ) med4_dosis_T0='500'.
IF  (atc4_T0='N02BE01' and CHAR.INDEX(med4_dosering_T0,'2x')>0 ) med4_dosis_T0='2x500'.
IF  (atc4_T0='N02BE01' and CHAR.INDEX(med4_dosering_T0,'1000')>0 ) med4_dosis_T0='1000'.
IF  (atc5_T0='N02BE01') med5_eenheid_T0='mg'.
IF  (atc5_T0='N02BE01' and CHAR.INDEX(med5_dosering_T0,'250')>0 ) med5_dosis_T0='250'.
IF  (atc5_T0='N02BE01' and CHAR.INDEX(med5_dosering_T0,'1000')>0 ) med5_dosis_T0='1000'.
IF  (atc6_T0='N02BE01') med6_eenheid_T0='mg'.
IF  (atc6_T0='N02BE01' and CHAR.INDEX(med6_dosering_T0,'500')>0 ) med6_dosis_T0='500'.
IF  (atc7_T0='N02BE01') med7_eenheid_T0='mg'.
IF  (atc7_T0='N02BE01' and CHAR.INDEX(med7_dosering_T0,'500')>0 ) med7_dosis_T0='500'.
IF  (atc7_T0='N02BE01' and CHAR.INDEX(med7_dosering_T0,'1000')>0 ) med7_dosis_T0='1000'.
IF  (atc8_T0='N02BE01') med8_eenheid_T0='mg'.
IF  (atc8_T0='N02BE01' and CHAR.INDEX(med8_dosering_T0,'500')>0 ) med8_dosis_T0='500'.
** ATC N02BA15 - .
IF  (atc2_T0='N02BA15') med2_eenheid_T0='mg'.
IF  (atc2_T0='N02BA15' and CHAR.INDEX(med2_dosering_T0,'600')>0 ) med2_dosis_T0='600'.
** ATC N02AX02 - tramadol.
IF  (atc1_T0='N02AX02') med1_eenheid_T0='mg'.
IF  (atc1_T0='N02AX02' and CHAR.INDEX(med1_dosering_T0,'150')>0 ) med1_dosis_T0='150'.
IF  (atc2_T0='N02AX02') med2_eenheid_T0='mg'.
IF  (atc2_T0='N02AX02' and CHAR.INDEX(med2_dosering_T0,'100')>0 ) med2_dosis_T0='100'.
IF  (atc3_T0='N02AX02') med3_eenheid_T0='mg'.
IF  (atc3_T0='N02AX02' and CHAR.INDEX(med3_dosering_T0,'50')>0 ) med3_dosis_T0='50'.
IF  (atc3_T0='N02AX02' and CHAR.INDEX(med3_dosering_T0,'37.5')>0 ) med3_dosis_T0='37,5'.
** ATC N02AJ13 - tramadol/paracetamol. 
IF  (atc2_T0='N02AJ13') med2_eenheid_T0='mg'.
IF  (atc2_T0='N02AJ13' and CHAR.INDEX(med2_dosering_T0,'37,5/325')>0 ) med2_dosis_T0='37,5/325'.
IF  (atc3_T0='N02AJ13') med3_eenheid_T0='mg'.
IF  (atc3_T0='N02AJ13' and CHAR.INDEX(med3_dosering_T0,'37.5')>0 ) med3_dosis_T0='37,5/325'.
** ATC N02AJ06 paracetamol/codeine.
IF  (atc1_T0='N02AJ06') med1_eenheid_T0='mg'.
IF  (atc1_T0='N02AJ06' and CHAR.INDEX(med1_dosering_T0,'530')>0 ) med1_dosis_T0='500/30'.
IF  (atc2_T0='N02AJ06') med2_eenheid_T0='mg'.
IF  (atc2_T0='N02AJ06' and CHAR.INDEX(med2_dosering_T0,'500-10')>0 ) med2_dosis_T0='500/10'.
** ATC N02AA05.
IF  (atc2_T0='N02AA05') med2_eenheid_T0='mg'.
IF  (atc2_T0='N02AA05' and CHAR.INDEX(med2_dosering_T0,'10')>0 ) med2_dosis_T0='10'.
** ATC M05BA08 - zometa infuus.
IF  (atc5_T0='M05BA08') med5_eenheid_T0='mg/ml'.
IF  (atc5_T0='M05BA08' and CHAR.INDEX(med5_dosering_T0,'infuus')>0 ) med5_dosis_T0='1 infuus'.
** ATC M05BA04 alendrolinezuur.
IF  (atc1_T0='M05BA04') med1_eenheid_T0='mg'.
IF  (atc1_T0='M05BA04' and CHAR.INDEX(med1_dosering_T0,'70')>0 ) med1_dosis_T0='70'.
IF  (atc6_T0='M05BA04') med6_eenheid_T0='mg'.
IF  (atc6_T0='M05BA04' and CHAR.INDEX(med6_dosering_T0,'60')>0 ) med6_dosis_T0=''.
** ATC M04AC01 - colchicine.
IF  (atc5_T0='M04AC01') med5_eenheid_T0='mg'.
IF  (atc5_T0='M04AC01' and CHAR.INDEX(med5_dosering_T0,'0,5')>0 ) med5_dosis_T0='0.5'.
IF  (atc7_T0='M04AC01') med7_eenheid_T0='mg'.
IF  (atc7_T0='M04AC01' and CHAR.INDEX(med7_dosering_T0,'1')>0 ) med7_dosis_T0='2x0,5'.
** ATC M04AA01 - allopurinol.
IF  (atc1_T0='M04AA01') med1_eenheid_T0='mg'.
IF  (atc1_T0='M04AA01' and CHAR.INDEX(med1_dosering_T0,'300')>0 ) med1_dosis_T0='300'.
IF  (atc4_T0='M04AA01') med4_eenheid_T0='mg'.
IF  (atc4_T0='M04AA01' and CHAR.INDEX(med4_dosering_T0,'300')>0 ) med4_dosis_T0='300'.
** ATC M01AH05 - arcoxia.
IF  (atc1_T0='M01AH05') med1_eenheid_T0='mg'.
IF  (atc1_T0='M01AH05' and CHAR.INDEX(med1_dosering_T0,'120')>0 ) med1_dosis_T0='120'.
IF  (atc4_T0='M01AH05') med4_eenheid_T0='mg'.
IF  (atc4_T0='M01AH05' and CHAR.INDEX(med4_dosering_T0,'90')>0 ) med4_dosis_T0='90'.
** ATC M01AH01 - celebrex.
IF  (atc1_T0='M01AH01') med1_eenheid_T0='mg'.
IF  (atc1_T0='M01AH01' and CHAR.INDEX(med1_dosering_T0,'400')>0 ) med1_dosis_T0='2x200'.
IF  (atc2_T0='M01AH01') med2_eenheid_T0='mg'.
IF  (atc2_T0='M01AH01' and CHAR.INDEX(med2_dosering_T0,'100')>0 ) med2_dosis_T0='100'.
IF  (atc3_T0='M01AH01') med3_eenheid_T0='mg'.
IF  (atc3_T0='M01AH01' and CHAR.INDEX(med3_dosering_T0,'100')>0 ) med3_dosis_T0='100'.
** ATC M01AE02- naproxen.
IF  (atc1_T0='M01AE02') med1_eenheid_T0='mg'.
IF  (atc1_T0='M01AE02' and CHAR.INDEX(med1_dosering_T0,'500')>0 ) med1_dosis_T0='500'.
IF  (atc1_T0='M01AE02' and CHAR.INDEX(med1_dosering_T0,'250')>0 ) med1_dosis_T0='250'.
IF  (atc2_T0='M01AE02') med2_eenheid_T0='mg'.
IF  (atc2_T0='M01AE02' and CHAR.INDEX(med2_dosering_T0,'500')>0 ) med2_dosis_T0='500'.
IF  (atc3_T0='M01AE02') med3_eenheid_T0='mg'.
IF  (atc3_T0='M01AE02' and CHAR.INDEX(med3_dosering_T0,'250')>0 ) med3_dosis_T0='250'.
IF  (atc3_T0='M01AE02' and CHAR.INDEX(med3_dosering_T0,'500')>0 ) med3_dosis_T0='500'.
IF  (atc4_T0='M01AE02') med4_eenheid_T0='mg'.
IF  (atc4_T0='M01AE02' and CHAR.INDEX(med4_dosering_T0,'500')>0 ) med4_dosis_T0='500'.
IF  (atc5_T0='M01AE02') med5_eenheid_T0='mg'.
IF  (atc5_T0='M01AE02' and CHAR.INDEX(med5_dosering_T0,'500')>0 ) med5_dosis_T0='500'.
** ATC M01AE01 - ibuprofen.
IF  (atc1_T0='M01AE01') med1_eenheid_T0='mg'.
IF  (atc1_T0='M01AE01' and CHAR.INDEX(med1_dosering_T0,'600')>0 ) med1_dosis_T0='600'.
IF  (atc1_T0='M01AE01' and CHAR.INDEX(med1_dosering_T0,'100')>0 ) med1_dosis_T0='100'.
IF  (atc1_T0='M01AE01' and CHAR.INDEX(med1_dosering_T0,'200')>0 ) med1_dosis_T0='200'.
IF  (atc1_T0='M01AE01' and CHAR.INDEX(med1_dosering_T0,'400')>0 ) med1_dosis_T0='400'.
IF  (atc1_T0='M01AE01' and CHAR.INDEX(med1_dosering_T0,'800')>0 ) med1_dosis_T0='800'.
IF  (atc1_T0='M01AE01' and CHAR.INDEX(med1_dosering_T0,'500')>0 ) med1_dosis_T0=' '.
IF  (atc1_T0='M01AE01' and CHAR.INDEX(med1_T0,'600')>0 ) med1_dosis_T0='600'.
IF  (atc1_T0='M01AE01' and med1_T0='Sarexell') med1_dosis_T0=' '.
IF  (atc2_T0='M01AE01') med2_eenheid_T0='mg'.
IF  (atc2_T0='M01AE01' and CHAR.INDEX(med2_dosering_T0,'600')>0 ) med2_dosis_T0='600'.
IF  (atc2_T0='M01AE01' and CHAR.INDEX(med2_dosering_T0,'100')>0 ) med2_dosis_T0='100'.
IF  (atc2_T0='M01AE01' and CHAR.INDEX(med2_dosering_T0,'200')>0 ) med2_dosis_T0='200'.
IF  (atc2_T0='M01AE01' and CHAR.INDEX(med2_dosering_T0,'400')>0 ) med2_dosis_T0='400'.
IF  (atc2_T0='M01AE01' and CHAR.INDEX(med2_dosering_T0,'500')>0 ) med2_dosis_T0='500'.
* 60 mg bestaat niet, moet waarschijnlijk 600 zijn'.
IF  (atc2_T0='M01AE01' and CHAR.INDEX(med2_dosering_T0,'60')>0 ) med2_dosis_T0='600'.
IF  (atc3_T0='M01AE01') med3_eenheid_T0='mg'.
IF  (atc3_T0='M01AE01' and CHAR.INDEX(med3_dosering_T0,'600')>0 ) med3_dosis_T0='600'.
IF  (atc3_T0='M01AE01' and CHAR.INDEX(med3_dosering_T0,'200')>0 ) med3_dosis_T0='200'.
IF  (atc3_T0='M01AE01' and CHAR.INDEX(med3_dosering_T0,'400')>0 ) med3_dosis_T0='400'.
IF  (atc3_T0='M01AE01' and CHAR.INDEX(med3_dosering_T0,'800')>0 ) med3_dosis_T0='800'.
IF  (atc4_T0='M01AE01') med4_eenheid_T0='mg'.
IF  (atc4_T0='M01AE01' and CHAR.INDEX(med4_dosering_T0,'500')>0 ) med4_dosis_T0='500'.
IF  (atc4_T0='M01AE01' and CHAR.INDEX(med4_dosering_T0,'400')>0 ) med4_dosis_T0='400'.
IF  (atc4_T0='M01AE01' and CHAR.INDEX(med4_dosering_T0,'800')>0 ) med4_dosis_T0='800'.
IF  (atc6_T0='M01AE01') med6_eenheid_T0='mg'.
IF  (atc6_T0='M01AE01' and CHAR.INDEX(med6_dosering_T0,'400')>0 ) med6_dosis_T0='400'.
IF  (atc8_T0='M01AE01') med8_eenheid_T0='mg'.
IF  (atc8_T0='M01AE01' and CHAR.INDEX(med8_dosering_T0,'400')>0 ) med8_dosis_T0='400'.
** ATC M01AB55.
IF  (atc2_T0='M01AB55') med2_eenheid_T0='mg'.
IF  (atc2_T0='M01AB55' and CHAR.INDEX(med2_dosering_T0,'75/0,2')>0 ) med2_dosis_T0='75/0,2'.
** ATC M01AB05 - diclofenac.
IF  (atc1_T0='M01AB05') med1_eenheid_T0='mg'.
IF  (atc1_T0='M01AB05' and CHAR.INDEX(med1_dosering_T0,'50')>0 ) med1_dosis_T0='50'.
IF  (atc1_T0='M01AB05' and CHAR.INDEX(med1_dosering_T0,'60')>0 ) med1_dosis_T0=''.
IF  (atc1_T0='M01AB05' and CHAR.INDEX(med1_dosering_T0,'75')>0 ) med1_dosis_T0='75'.
IF  (atc2_T0='M01AB05') med2_eenheid_T0='mg'.
IF  (atc2_T0='M01AB05' and CHAR.INDEX(med2_dosering_T0,'50')>0 ) med2_dosis_T0='50'.
IF  (atc2_T0='M01AB05' and CHAR.INDEX(med2_dosering_T0,'75')>0 ) med2_dosis_T0='75'.
IF  (atc3_T0='M01AB05') med3_eenheid_T0='mg'.
IF  (atc3_T0='M01AB05' and CHAR.INDEX(med3_dosering_T0,'50')>0 ) med3_dosis_T0='50'.
IF  (atc4_T0='M01AB05') med4_eenheid_T0='mg'.
IF  (atc4_T0='M01AB05' and CHAR.INDEX(med4_dosering_T0,'50')>0 ) med4_dosis_T0='50'.
IF  (atc5_T0='M01AB05') med5_eenheid_T0='mg'.
IF  (atc5_T0='M01AB05' and CHAR.INDEX(med5_dosering_T0,'50')>0 ) med5_dosis_T0='50'.
IF  (atc6_T0='M01AB05') med6_eenheid_T0='mg'.
IF  (atc6_T0='M01AB05' and CHAR.INDEX(med6_dosering_T0,'50')>0 ) med6_dosis_T0='50'.
** ATC L02BA01 - tamoxifen.
IF  (atc4_T0='L02BA01') med4_eenheid_T0='mg'.
IF  (atc4_T0='L02BA01' and CHAR.INDEX(med4_dosering_T0,'1')>0 ) med4_dosis_T0=''.
** ATC L04AX03 - methotrexaat.
IF  (atc1_T0='L04AX03' and med1_vorm_T0='injectie') med1_eenheid_T0='mg/ml'.
IF  (atc1_T0='L04AX03' and med1_vorm_T0='') med1_eenheid_T0='mg/ml'.
IF  (atc1_T0='L04AX03' and CHAR.INDEX(med1_dosering_T0,'25')>0 ) med1_dosis_T0='25'.
IF  (atc3_T0='L04AX03' and med3_vorm_T0='tablet') med3_eenheid_T0='mg'.
IF  (atc3_T0='L04AX03' and CHAR.INDEX(med3_dosering_T0,'2,5')>0 ) med3_dosis_T0='2,5'.
** ATC L04AD02 - infliximab.
IF  (atc2_T0='L04AD02') med2_eenheid_T0='mg'.
IF  (atc2_T0='L04AD02' and CHAR.INDEX(med2_dosering_T0,'1')>0 and ID_code=1916 ) med2_dosis_T0='3'.
IF  (atc3_T0='L04AD02') med3_eenheid_T0='mg'.
IF  (atc3_T0='L04AD02' and CHAR.INDEX(med3_dosering_T0,'1')>0) med3_dosis_T0=''.
** ATC L04AB04 humira.
IF  (atc1_T0='L04AB04') med1_eenheid_T0='mg/ml'.
IF  (atc1_T0='L04AB04' and CHAR.INDEX(med1_dosering_T0,'40')>0 ) med1_dosis_T0='40'.
IF  (atc2_T0='L04AB04') med2_eenheid_T0='mg/ml'.
IF  (atc2_T0='L04AB04' and CHAR.INDEX(med2_dosering_T0,'40')>0 ) med2_dosis_T0='40'.
** ATC L04AA13.
IF  (atc2_T0='L04AA13') med2_eenheid_T0='mg'.
IF  (atc2_T0='L04AA13' and CHAR.INDEX(med2_dosering_T0,'20')>0 ) med2_dosis_T0='20'.
** ATC L02BG04.
IF  (atc2_T0='L02BG04') med2_eenheid_T0='mg'.
IF  (atc2_T0='L02BG04' and CHAR.INDEX(med2_dosering_T0,'2,5')>0 ) med2_dosis_T0='2,5'.
** ATC L02BG03.
IF  (atc1_T0='L02BG03') med1_eenheid_T0='mg'.
IF  (atc1_T0='L02BG03' and CHAR.INDEX(med1_dosering_T0,'1')>0 ) med1_dosis_T0='1'.
** ATC J01XE01.
IF  (atc3_T0='J01XE01') med3_eenheid_T0='mg'.
IF  (atc3_T0='J01XE01' and CHAR.INDEX(med3_dosering_T0,'50')>0 ) med3_dosis_T0='50'.
** ATC J01MA02.
IF  (atc3_T0='J01MA02') med3_eenheid_T0='mg'.
IF  (atc3_T0='J01MA02' and CHAR.INDEX(med3_dosering_T0,'500')>0 ) med3_dosis_T0='500'.
** ATC J01FA09.
IF  (atc2_T0='J01FA09') med2_eenheid_T0='mg'.
IF  (atc2_T0='J01FA09' and CHAR.INDEX(med2_dosering_T0,'500')>0 ) med2_dosis_T0='500'.
** ATC J01CR02 - augmentin.
IF  (atc3_T0='J01CR02') med3_eenheid_T0='mg'.
IF  (atc3_T0='J01CR02' and CHAR.INDEX(med3_dosering_T0,'500-125')>0 ) med3_dosis_T0='500/125'.
** ATC J01CA04 - amoxicicline.
IF  (atc1_T0='J01CA04') med1_eenheid_T0='mg'.
IF  (atc1_T0='J01CA04' and CHAR.INDEX(med1_dosering_T0,'500')>0 ) med1_dosis_T0='500'.
IF  (atc3_T0='J01CA04') med3_eenheid_T0='mg'.
IF  (atc3_T0='J01CA04' and CHAR.INDEX(med3_dosering_T0,'500')>0 ) med3_dosis_T0='500'.
** ATC J01 - antibiotoca.
IF  (atc1_T0='J01') med1_eenheid_T0='mg'.
IF  (atc1_T0='J01' and CHAR.INDEX(med1_dosering_T0,'250')>0 ) med1_dosis_T0='250'.
IF  (atc1_T0='J01' and CHAR.INDEX(med1_dosering_T0,'500')>0 ) med1_dosis_T0='500'.
IF  (atc2_T0='J01') med2_eenheid_T0='mg'.
IF  (atc2_T0='J01' and CHAR.INDEX(med2_dosering_T0,'250')>0 ) med2_dosis_T0='250'.
IF  (atc2_T0='J01' and CHAR.INDEX(med2_dosering_T0,'500')>0 ) med2_dosis_T0='500'.
** ATC H03AA01 - levothyroxine.
IF  (atc1_T0='H03AA01') med1_eenheid_T0='ug'.
IF  (atc1_T0='H03AA01' and CHAR.INDEX(med1_dosering_T0,'100')>0 ) med1_dosis_T0='100'.
IF  (atc1_T0='H03AA01' and CHAR.INDEX(med1_dosering_T0,'150')>0 ) med1_dosis_T0='150'.
IF  (atc1_T0='H03AA01' and CHAR.INDEX(med1_dosering_T0,'137,5')>0 ) med1_dosis_T0='137,5'.
IF  (atc1_T0='H03AA01' and CHAR.INDEX(med1_dosering_T0,'1,25')>0 ) med1_dosis_T0='125'.
IF  (atc1_T0='H03AA01' and CHAR.INDEX(med1_dosering_T0,'1.25')>0 ) med1_dosis_T0='125'.
IF  (atc1_T0='H03AA01' and med1_dosering_T0='175') med1_dosis_T0='175'.
IF  (atc1_T0='H03AA01' and med1_dosering_T0='75mg') med1_dosis_T0='75'.
IF  (atc1_T0='H03AA01' and med1_dosering_T0='50mg') med1_dosis_T0='50'.
IF  (atc1_T0='H03AA01' and med1_dosering_T0='0,150mg') med1_dosis_T0='150'.
IF  (atc1_T0='H03AA01' and med1_dosering_T0='150 mg') med1_dosis_T0='150'.
IF  (atc2_T0='H03AA01') med2_eenheid_T0='ug'.
IF  (atc2_T0='H03AA01' and CHAR.INDEX(med2_dosering_T0,'50')>0 ) med2_dosis_T0='50'.
IF  (atc3_T0='H03AA01') med3_eenheid_T0='ug'.
IF  (atc3_T0='H03AA01' and CHAR.INDEX(med3_dosering_T0,'0.90')>0 ) med3_dosis_T0='1x75 en 1x12.5'.
IF  (atc7_T0='H03AA01') med7_eenheid_T0='ug'.
IF  (atc7_T0='H03AA01' and CHAR.INDEX(med7_dosering_T0,'25')>0 ) med7_dosis_T0='25'.
** ATC H02AB06- prednisolon.
IF  (atc4_T0='H02AB06') med4_eenheid_T0='mg'.
IF  (atc4_T0='H02AB06' and CHAR.INDEX(med4_dosering_T0,'10')>0 ) med4_dosis_T0='10'.
** ATC H02AB07.
IF  (atc1_T0='H02AB07') med1_eenheid_T0='mg'.
IF  (atc1_T0='H02AB07' and CHAR.INDEX(med1_dosering_T0,'7,5')>0 ) med1_dosis_T0='1,5x5'.
** ATC G04CB01.
IF  (atc1_T0='G04CB01') med1_eenheid_T0='mg'.
IF  (atc1_T0='G04CB01' and CHAR.INDEX(med1_dosering_T0,'1')>0 ) med1_dosis_T0='1'.
** ATC G04CA02 - tamsulosine.
IF  (atc2_T0='G04CA02') med2_eenheid_T0='mg'.
IF  (atc2_T0='G04CA02' and CHAR.INDEX(med2_dosering_T0,'0.4')>0 ) med2_dosis_T0='0,4'.
IF  (atc3_T0='G04CA02') med3_eenheid_T0='mg'.
IF  (atc3_T0='G04CA02' and CHAR.INDEX(med3_dosering_T0,'0.4')>0 ) med3_dosis_T0='0,4'.
IF  (atc3_T0='G04CA02' and CHAR.INDEX(med3_dosering_T0,'0,4')>0 ) med3_dosis_T0='0,4'.
IF  (atc5_T0='G04CA02') med5_eenheid_T0='mg'.
IF  (atc5_T0='G04CA02' and CHAR.INDEX(med5_dosering_T0,'5')>0 ) med5_dosis_T0=' '.
** ATC G04BD08 - vesicare.
IF  (atc3_T0='G04BD08') med3_eenheid_T0='mg'.
IF  (atc3_T0='G04BD08' and CHAR.INDEX(med3_dosering_T0,'15')>0 ) med3_dosis_T0='1,5x10'.
** ATC G03CX01.
IF  (atc3_T0='G03CX01') med3_eenheid_T0='mg'.
IF  (atc3_T0='G03CX01' and CHAR.INDEX(med3_dosering_T0,'2')>0 ) med3_dosis_T0='2,5'.
* 2 mg bestaat niet, is alleen in 2,5 mg.
** ATC G03AA07.
IF  (atc3_T0='G03AA07') med3_eenheid_T0='ug'.
IF  (atc3_T0='G03AA07' and CHAR.INDEX(med3_dosering_T0,'?')>0 ) med3_dosis_T0='30/150'.
** ATC G02CB03.
IF  (atc2_T0='G02CB03') med2_eenheid_T0='mg'.
IF  (atc2_T0='G02CB03' and CHAR.INDEX(med2_dosering_T0,'25')>0 ) med2_dosis_T0='halve 0,5'.
** ATC D11AH01.
IF  (atc2_T0='D11AH01') med2_eenheid_T0='mg/g'.
** ATC D07AD01.
IF  (atc3_T0='D07AD01') med3_eenheid_T0='mg/g'.
IF  (atc3_T0='D07AD01' and CHAR.INDEX(med3_dosering_T0,'3')>0 ) med3_dosis_T0=''.
** ATC D07AC17.
IF  (atc3_T0='D07AC17') med3_eenheid_T0='mg/g'.
IF  (atc3_T0='D07AC17' and CHAR.INDEX(med3_dosering_T0,'0,5')>0 ) med3_dosis_T0='0,5'.
** ATC D07AC01/12.
IF  (atc2_T0='D07AC01/12') med2_eenheid_T0='ml'.
IF  (atc2_T0='D07AC01/12' and CHAR.INDEX(med2_dosering_T0,'1')>0 ) med2_dosis_T0='lotion'.
** ATC C10AX09 - ezetimib.
IF  (atc2_T0='C10AX09') med2_eenheid_T0='mg'.
IF  (atc2_T0='C10AX09' and CHAR.INDEX(med2_dosering_T0,'1')>0 ) med2_dosis_T0='10'.
IF  (atc5_T0='C10AX09') med5_eenheid_T0='mg'.
IF  (atc5_T0='C10AX09' and CHAR.INDEX(med5_dosering_T0,'1')>0 ) med5_dosis_T0='10'.
*wordt bedoelt 1 tablet, is alleen in 10 mg.
IF  (atc9_T0='C10AX09') med9_eenheid_T0='mg'.
IF  (atc9_T0='C10AX09' and CHAR.INDEX(med9_dosering_T0,'10')>0 ) med9_dosis_T0='10'.
** ATC C10AA07 crestor/rosuvastatine.
IF  (atc1_T0='C10AA07') med1_eenheid_T0='mg'.
IF  (atc1_T0='C10AA07' and CHAR.INDEX(med1_dosering_T0,'10')>0 ) med1_dosis_T0='10'.
IF  (atc4_T0='C10AA07') med4_eenheid_T0='mg'.
IF  (atc4_T0='C10AA07' and CHAR.INDEX(med4_dosering_T0,'5')>0 ) med4_dosis_T0='5'.
IF  (atc4_T0='C10AA07' and CHAR.INDEX(med4_dosering_T0,'40')>0 ) med4_dosis_T0='40'.
IF  (atc5_T0='C10AA07') med5_eenheid_T0='mg'.
IF  (atc5_T0='C10AA07' and CHAR.INDEX(med5_dosering_T0,'20')>0 ) med5_dosis_T0='20'.
IF  (atc6_T0='C10AA07') med6_eenheid_T0='mg'.
IF  (atc6_T0='C10AA07' and CHAR.INDEX(med6_dosering_T0,'10')>0 ) med6_dosis_T0='10'.
IF  (atc8_T0='C10AA07') med8_eenheid_T0='mg'.
IF  (atc8_T0='C10AA07' and CHAR.INDEX(med8_dosering_T0,'40')>0 ) med8_dosis_T0='40'.
** ATC C10AA05 - lipitor/atorvastatine.
IF  (atc1_T0='C10AA05') med1_eenheid_T0='mg'.
IF  (atc1_T0='C10AA05' and CHAR.INDEX(med1_dosering_T0,'40')>0 ) med1_dosis_T0='40'.
IF  (atc1_T0='C10AA05' and CHAR.INDEX(med1_T0,'10 mg')>0 ) med1_dosis_T0='10'.
IF  (atc3_T0='C10AA05') med3_eenheid_T0='mg'.
IF  (atc3_T0='C10AA05' and CHAR.INDEX(med3_dosering_T0,'20')>0 ) med3_dosis_T0='20'.
IF  (atc3_T0='C10AA05' and CHAR.INDEX(med3_dosering_T0,'40')>0 ) med3_dosis_T0='40'.
* 50 bestaat niet, op T1 is 40 ingevuld.
IF  (atc3_T0='C10AA05' and CHAR.INDEX(med3_dosering_T0,'50')>0 ) med3_dosis_T0='40'.
IF  (atc4_T0='C10AA05') med4_eenheid_T0='mg'.
IF  (atc4_T0='C10AA05' and CHAR.INDEX(med4_dosering_T0,'20')>0 ) med4_dosis_T0='20'.
IF  (atc4_T0='C10AA05' and CHAR.INDEX(med4_dosering_T0,'80')>0 ) med4_dosis_T0='80'.
IF  (atc5_T0='C10AA05') med5_eenheid_T0='mg'.
IF  (atc5_T0='C10AA05' and CHAR.INDEX(med5_dosering_T0,'40')>0 ) med5_dosis_T0='40'.
IF  (atc6_T0='C10AA05') med6_eenheid_T0='mg'.
IF  (atc6_T0='C10AA05' and CHAR.INDEX(med6_dosering_T0,'10')>0 ) med6_dosis_T0='10'.
** ATC C10AA03 - pravastatine.
IF  (atc4_T0='C10AA03') med4_eenheid_T0='mg'.
IF  (atc4_T0='C10AA03' and CHAR.INDEX(med4_dosering_T0,'1')>0 ) med4_dosis_T0=''.
** ATC C10AA01 - simvastatine.
IF  (atc1_T0='C10AA01') med1_eenheid_T0='mg'.
IF  (atc1_T0='C10AA01' and CHAR.INDEX(med1_dosering_T0,'40')>0 ) med1_dosis_T0='40'.
IF  (atc1_T0='C10AA01' and CHAR.INDEX(med1_dosering_T0,'20')>0 ) med1_dosis_T0='20'.
IF  (atc2_T0='C10AA01') med2_eenheid_T0='mg'.
IF  (atc2_T0='C10AA01' and CHAR.INDEX(med2_dosering_T0,'40')>0 ) med2_dosis_T0='40'.
IF  (atc2_T0='C10AA01' and CHAR.INDEX(med2_dosering_T0,'20')>0 ) med2_dosis_T0='20'.
IF  (atc3_T0='C10AA01') med3_eenheid_T0='mg'.
IF  (atc3_T0='C10AA01' and CHAR.INDEX(med3_dosering_T0,'40')>0 ) med3_dosis_T0='40'.
IF  (atc3_T0='C10AA01' and CHAR.INDEX(med3_dosering_T0,'20')>0 ) med3_dosis_T0='20'.
IF  (atc4_T0='C10AA01') med4_eenheid_T0='mg'.
IF  (atc4_T0='C10AA01' and CHAR.INDEX(med4_dosering_T0,'40')>0 ) med4_dosis_T0='40'.
IF  (atc4_T0='C10AA01' and CHAR.INDEX(med4_dosering_T0,'20')>0 ) med4_dosis_T0='20'.
IF  (atc5_T0='C10AA01') med5_eenheid_T0='mg'.
IF  (atc5_T0='C10AA01' and CHAR.INDEX(med5_dosering_T0,'40')>0 ) med5_dosis_T0='40'.
** ATC C10 - cholesterolverlagers.
IF  (atc1_T0='C10') med1_eenheid_T0='mg'.
IF  (atc1_T0='C10' and CHAR.INDEX(med1_dosering_T0,'10')>0 ) med1_dosis_T0='10'.
IF  (atc2_T0='C10') med2_eenheid_T0='mg'.
IF  (atc2_T0='C10' and CHAR.INDEX(med2_dosering_T0,'20')>0 ) med2_dosis_T0='20'.
IF  (atc2_T0='C10' and CHAR.INDEX(med2_dosering_T0,'30')>0 ) med2_dosis_T0='10 + 20'.
IF  (atc4_T0='C10') med4_eenheid_T0='mg'.
IF  (atc4_T0='C10' and CHAR.INDEX(med4_dosering_T0,'5')>0 ) med4_dosis_T0='5'.
** ATC C09DA03 valsartan/HCT.
IF  (atc1_T0='C09DA03') med1_eenheid_T0='mg'.
IF  (atc1_T0='C09DA03' and CHAR.INDEX(med1_dosering_T0,'80/12,5')>0 ) med1_dosis_T0='80/12.5'.
** ATC C09CA07.
IF  (atc1_T0='C09CA07') med1_eenheid_T0='mg'.
IF  (atc1_T0='C09CA07' and CHAR.INDEX(med1_dosering_T0,'80')>0 ) med1_dosis_T0='80'.
** ATC C09CA06 candesartan.
IF  (atc4_T0='C09CA06') med4_eenheid_T0='mg'.
IF  (atc4_T0='C09CA06' and CHAR.INDEX(med4_dosering_T0,'4')>0 ) med4_dosis_T0='4'.
** ATC C09CA04 - irbesartan.
IF  (atc1_T0='C09CA04') med1_eenheid_T0='mg'.
IF  (atc1_T0='C09CA04' and CHAR.INDEX(med1_dosering_T0,'300')>0 ) med1_dosis_T0='300'.
IF  (atc1_T0='C09CA04' and CHAR.INDEX(med1_dosering_T0,'150')>0 ) med1_dosis_T0='150'.
IF  (atc1_T0='C09CA04' and CHAR.INDEX(med1_dosering_T0,'75')>0 ) med1_dosis_T0='75'.
IF  (atc3_T0='C09CA04') med3_eenheid_T0='mg'.
IF  (atc3_T0='C09CA04' and CHAR.INDEX(med3_dosering_T0,'1')>0 ) med3_dosis_T0=''.
*(bedoelt 1 tablet, gem dosering, laagste prijs aangehouden).
IF  (atc4_T0='C09CA04') med4_eenheid_T0='mg'.
IF  (atc4_T0='C09CA04' and CHAR.INDEX(med4_dosering_T0,'150')>0 ) med4_dosis_T0='150'.
IF  (atc4_T0='C09CA04' and CHAR.INDEX(med4_dosering_T0,'300')>0 ) med4_dosis_T0='300'.
** ATC C09CA03 - valsartan.
IF  (atc1_T0='C09CA03') med1_eenheid_T0='mg'.
IF  (atc1_T0='C09CA03' and CHAR.INDEX(med1_dosering_T0,'160')>0 ) med1_dosis_T0='160'.
IF  (atc2_T0='C09CA03') med2_eenheid_T0='mg'.
IF  (atc2_T0='C09CA03' and CHAR.INDEX(med2_dosering_T0,'40')>0 ) med2_dosis_T0='40'.
IF  (atc5_T0='C09CA03') med5_eenheid_T0='mg'.
IF  (atc5_T0='C09CA03' and CHAR.INDEX(med5_dosering_T0,'160')>0 ) med5_dosis_T0='160'.
** ATC C09CA01 - losartan.
IF  (atc1_T0='C09CA01') med1_eenheid_T0='mg'.
IF  (atc1_T0='C09CA01' and CHAR.INDEX(med1_dosering_T0,'50')>0 ) med1_dosis_T0='50'.
IF  (atc2_T0='C09CA01') med2_eenheid_T0='mg'.
IF  (atc2_T0='C09CA01' and CHAR.INDEX(med2_dosering_T0,'50')>0 ) med2_dosis_T0='50'.
IF  (atc3_T0='C09CA01') med3_eenheid_T0='mg'.
IF  (atc3_T0='C09CA01' and CHAR.INDEX(med3_dosering_T0,'50')>0 ) med3_dosis_T0='50'.
IF  (atc3_T0='C09CA01' and CHAR.INDEX(med3_dosering_T0,'1')>0 and Id_code=1916) med3_dosis_T0='50'.
IF  (atc5_T0='C09CA01') med5_eenheid_T0='mg'.
IF  (atc5_T0='C09CA01' and CHAR.INDEX(med5_dosering_T0,'50')>0 ) med5_dosis_T0='50'.
** ATC C09BA03 - valsartan/HCT.
IF  (atc2_T0='C09BA03') med2_eenheid_T0='mg'.
IF  (atc2_T0='C09BA03' and CHAR.INDEX(med2_dosering_T0,'20')>0 ) med2_dosis_T0='20/12.5'.
** ATC C09AA06 - quinapril.
IF  (atc1_T0='C09AA06') med1_eenheid_T0='mg'.
IF  (atc1_T0='C09AA06' and CHAR.INDEX(med1_dosering_T0,'20')>0 ) med1_dosis_T0='20'.
IF  (atc2_T0='C09AA06') med2_eenheid_T0='mg'.
IF  (atc2_T0='C09AA06' and CHAR.INDEX(med2_dosering_T0,'12.5')>0 ) med2_dosis_T0=''.
IF  (atc4_T0='C09AA06') med4_eenheid_T0='mg'.
IF  (atc4_T0='C09AA06' and CHAR.INDEX(med4_dosering_T0,'10')>0 ) med4_dosis_T0='10'.
** ATC C09AA05.
IF  (atc1_T0='C09AA05') med1_eenheid_T0='mg'.
IF  (atc1_T0='C09AA05' and CHAR.INDEX(med1_dosering_T0,'2,5')>0 ) med1_dosis_T0='2,5'.
** ATC C09AA04- perindopril.
IF  (atc1_T0='C09AA04') med1_eenheid_T0='mg'.
IF  (atc1_T0='C09AA04' and CHAR.INDEX(med1_dosering_T0,'20')>0 ) med1_dosis_T0='2x10'.
IF  (atc2_T0='C09AA04') med2_eenheid_T0='mg'.
IF  (atc2_T0='C09AA04' and CHAR.INDEX(med2_dosering_T0,'4')>0 ) med2_dosis_T0='4'.
IF  (atc2_T0='C09AA04' and CHAR.INDEX(med2_dosering_T0,'8')>0 ) med2_dosis_T0='8'.
IF  (atc3_T0='C09AA04') med3_eenheid_T0='mg'.
IF  (atc3_T0='C09AA04' and CHAR.INDEX(med3_dosering_T0,'8')>0 ) med3_dosis_T0='8'.
IF  (atc4_T0='C09AA04') med4_eenheid_T0='mg'.
IF  (atc4_T0='C09AA04' and CHAR.INDEX(med4_dosering_T0,'4')>0 ) med4_dosis_T0='4'.
IF  (atc4_T0='C09AA04' and CHAR.INDEX(med4_dosering_T0,'6')>0 ) med4_dosis_T0='1,5x4'.
IF  (atc5_T0='C09AA04') med5_eenheid_T0='mg'.
IF  (atc5_T0='C09AA04' and CHAR.INDEX(med5_dosering_T0,'2')>0 ) med5_dosis_T0='2'.
IF  (atc6_T0='C09AA04') med6_eenheid_T0='mg'.
IF  (atc6_T0='C09AA04' and CHAR.INDEX(med6_dosering_T0,'8')>0 ) med6_dosis_T0='8'.
** ATC C09AA03 - lisinopril.
IF  (atc1_T0='C09AA03') med1_eenheid_T0='mg'.
IF  (atc1_T0='C09AA03' and CHAR.INDEX(med1_dosering_T0,'20')>0 ) med1_dosis_T0='20'.
IF  (atc1_T0='C09AA03' and CHAR.INDEX(med1_dosering_T0,'10')>0 ) med1_dosis_T0='10'.
IF  (atc2_T0='C09AA03') med2_eenheid_T0='mg'.
IF  (atc2_T0='C09AA03' and CHAR.INDEX(med2_dosering_T0,'10')>0 ) med2_dosis_T0='10'.
IF  (atc2_T0='C09AA03' and CHAR.INDEX(med2_dosering_T0,'20')>0 ) med2_dosis_T0='20'.
** ATC C09AA02 - enalapril.
IF  (atc1_T0='C09AA02') med1_eenheid_T0='mg'.
IF  (atc1_T0='C09AA02' and CHAR.INDEX(med1_dosering_T0,'20')>0 ) med1_dosis_T0='20'.
IF  (atc3_T0='C09AA02') med3_eenheid_T0='mg'.
IF  (atc3_T0='C09AA02' and CHAR.INDEX(med3_dosering_T0,'5')>0 ) med3_dosis_T0='5'.
IF  (atc4_T0='C09AA02') med4_eenheid_T0='mg'.
IF  (atc4_T0='C09AA02' and CHAR.INDEX(med4_T0,'10')>0 ) med4_dosis_T0='10'.
** ATC C08DB01.
IF  (atc1_T0='C08DB01') med1_eenheid_T0='mg'.
IF  (atc1_T0='C08DB01' and CHAR.INDEX(med1_dosering_T0,'200')>0 ) med1_dosis_T0='200'.
** ATC C08CA13.
IF  (atc2_T0='C08CA13') med2_eenheid_T0='mg'.
IF  (atc2_T0='C08CA13' and CHAR.INDEX(med2_dosering_T0,'10')>0 ) med2_dosis_T0='10'.
** ATC C08CA12.
IF  (atc4_T0='C08CA12') med4_eenheid_T0='mg'.
IF  (atc4_T0='C08CA12' and CHAR.INDEX(med4_dosering_T0,'10')>0 ) med4_dosis_T0='10'.
** ATC C08CA05 - nifidepine.
IF  (atc2_T0='C08CA05') med2_eenheid_T0='mg'.
IF  (atc2_T0='C08CA05' and CHAR.INDEX(med2_dosering_T0,'60')>0 ) med2_dosis_T0='60'.
IF  (atc3_T0='C08CA05') med3_eenheid_T0='mg'.
IF  (atc3_T0='C08CA05' and CHAR.INDEX(med3_dosering_T0,'30')>0 ) med3_dosis_T0='30'.
** ATC C08CA01- amlodipine.
IF  (atc1_T0='C08CA01') med1_eenheid_T0='mg'.
IF  (atc1_T0='C08CA01' and CHAR.INDEX(med1_dosering_T0,'5')>0 ) med1_dosis_T0='5'.
IF  (atc1_T0='C08CA01' and CHAR.INDEX(med1_dosering_T0,'10')>0 ) med1_dosis_T0='10'.
IF  (atc2_T0='C08CA01') med2_eenheid_T0='mg'.
IF  (atc2_T0='C08CA01' and CHAR.INDEX(med2_dosering_T0,'5')>0 ) med2_dosis_T0='5'.
IF  (atc2_T0='C08CA01' and CHAR.INDEX(med2_dosering_T0,'10')>0 ) med2_dosis_T0='10'.
IF  (atc3_T0='C08CA01') med3_eenheid_T0='mg'.
IF  (atc3_T0='C08CA01' and CHAR.INDEX(med3_dosering_T0,'5')>0 ) med3_dosis_T0='5'.
IF  (atc3_T0='C08CA01' and CHAR.INDEX(med3_dosering_T0,'10')>0 ) med3_dosis_T0='10'.
IF  (atc5_T0='C08CA01') med5_eenheid_T0='mg'.
IF  (atc5_T0='C08CA01' and CHAR.INDEX(med5_dosering_T0,'10')>0 ) med5_dosis_T0='10'.
IF  (atc6_T0='C08CA01') med6_eenheid_T0='mg'.
IF  (atc6_T0='C08CA01' and CHAR.INDEX(med6_dosering_T0,'8')>0 ) med6_dosis_T0='5'.
** ATC D07XC01.
IF  (atc2_T0='D07XC01') med2_eenheid_T0='mg/g'.
** ATC C07BB02.
IF  (atc2_T0='C07BB02') med2_eenheid_T0='mg'.
IF  (atc2_T0='C07BB02' and CHAR.INDEX(med2_dosering_T0,'05')>0 ) med2_dosis_T0='100/12,5'.
** ATC C07AB12- nebivolol.
IF  (atc4_T0='C07AB12') med4_eenheid_T0='mg'.
IF  (atc4_T0='C07AB12' and CHAR.INDEX(med4_dosering_T0,'2.5') and CHAR.INDEX(med4_T0,'5') >0 ) med4_dosis_T0='halve 5'.
** ATC C07AB07- bisoprolol.
IF  (atc3_T0='C07AB07') med3_eenheid_T0='mg'.
IF  (atc3_T0='C07AB07' and CHAR.INDEX(med3_dosering_T0,'5')>0 ) med3_dosis_T0='5'.
IF  (atc5_T0='C07AB07') med5_eenheid_T0='mg'.
IF  (atc5_T0='C07AB07' and CHAR.INDEX(med5_dosering_T0,'5')>0 ) med5_dosis_T0='5'.
** ATC C07AB02- metoprolol.
IF  (atc1_T0='C07AB02') med1_eenheid_T0='mg'.
IF  (atc1_T0='C07AB02' and CHAR.INDEX(med1_dosering_T0,'25')>0 ) med1_dosis_T0='25'.
IF  (atc1_T0='C07AB02' and CHAR.INDEX(med1_dosering_T0,'50')>0 ) med1_dosis_T0='50'.
IF  (atc1_T0='C07AB02' and CHAR.INDEX(med1_dosering_T0,'100')>0 ) med1_dosis_T0='100'.
IF  (atc2_T0='C07AB02') med2_eenheid_T0='mg'.
* dosering waarschijnlijk omgedraaid met med3.
IF  (atc2_T0='C07AB02' and CHAR.INDEX(med2_dosering_T0,'20')>0 and Id_code=1506 ) med2_dosis_T0='100+50'.
IF  (atc2_T0='C07AB02' and CHAR.INDEX(med2_dosering_T0,'200')>0 ) med2_dosis_T0='200'.
IF  (atc3_T0='C07AB02') med3_eenheid_T0='mg'.
IF  (atc3_T0='C07AB02' and med3_dosering_T0='12,5' and CHAR.INDEX(med3_T0,'25')>0) med3_dosis_T0='0,5x25'.
IF  (atc3_T0='C07AB02' and CHAR.INDEX(med3_T0,'100')>0 ) med3_dosis_T0='100'.
IF  (atc3_T0='C07AB02' and CHAR.INDEX(med3_dosering_T0,'25')>0 ) med3_dosis_T0='25'.
IF  (atc3_T0='C07AB02' and CHAR.INDEX(med3_dosering_T0,'100')>0 ) med3_dosis_T0='100'.
IF  (atc7_T0='C07AB02') med7_eenheid_T0='mg'.
IF  (atc7_T0='C07AB02' and CHAR.INDEX(med7_dosering_T0,'100')>0 ) med7_dosis_T0='100'.
** ATC C07AA07 sotalol.
IF  (atc1_T0='C07AA07') med1_eenheid_T0='mg'.
IF  (atc1_T0='C07AA07' and CHAR.INDEX(med1_dosering_T0,'80')>0 ) med1_dosis_T0='80'.
IF  (atc7_T0='C07AA07') med7_eenheid_T0='mg'.
IF  (atc7_T0='C07AA07' and CHAR.INDEX(med7_dosering_T0,'80 mg 40mg')>0 ) med7_dosis_T0='80 en 40'.
** ATC C07 betablokkers.
IF  (atc2_T0='C07') med2_eenheid_T0='mg'.
IF  (atc2_T0='C07' and CHAR.INDEX(med2_dosering_T0,'100')>0 ) med2_dosis_T0='100'.
** ATC C03DA01- spironolacton.
IF  (atc5_T0='C03DA01') med5_eenheid_T0='mg'.
IF  (atc5_T0='C03DA01' and CHAR.INDEX(med5_dosering_T0,'25')>0 ) med5_dosis_T0='25'.
** ATC C03CA01 - furosemide.
IF  (atc3_T0='C03CA01') med3_eenheid_T0='mg'.
IF  (atc3_T0='C03CA01' and CHAR.INDEX(med3_dosering_T0,'40')>0 ) med3_dosis_T0='40'.
IF  (atc4_T0='C03CA01') med4_eenheid_T0='mg'.
IF  (atc4_T0='C03CA01' and CHAR.INDEX(med4_dosering_T0,'40')>0 ) med4_dosis_T0='40'.
** ATC C03BA04.
IF  (atc1_T0='C03BA04') med1_eenheid_T0='mg'.
IF  (atc1_T0='C03BA04' and CHAR.INDEX(med1_dosering_T0,'12,5')>0 ) med1_dosis_T0='12,5'.
** ATC C03AA03 hydrochloorthiazide.
IF  (atc1_T0='C03AA03') med1_eenheid_T0='mg'.
IF  (atc1_T0='C03AA03' and CHAR.INDEX(med1_dosering_T0,'12,5')>0 ) med1_dosis_T0='12,5'.
IF  (atc2_T0='C03AA03') med2_eenheid_T0='mg'.
IF  (atc2_T0='C03AA03' and CHAR.INDEX(med2_dosering_T0,'12,5')>0 ) med2_dosis_T0='12,5'.
IF  (atc2_T0='C03AA03' and CHAR.INDEX(med2_dosering_T0,'13')>0 ) med2_dosis_T0='12,5'.
IF  (atc2_T0='C03AA03' and CHAR.INDEX(med2_dosering_T0,'25')>0 ) med2_dosis_T0='25'.
IF  (atc3_T0='C03AA03') med3_eenheid_T0='mg'.
IF  (atc3_T0='C03AA03' and CHAR.INDEX(med3_dosering_T0,'10')>0 ) med3_dosis_T0='25'.
IF  (atc3_T0='C03AA03' and CHAR.INDEX(med3_dosering_T0,'25')>0 ) med3_dosis_T0='25'.
IF  (atc5_T0='C03AA03') med5_eenheid_T0='mg'.
IF  (atc5_T0='C03AA03' and CHAR.INDEX(med5_dosering_T0,'25')>0 ) med5_dosis_T0='25'.
IF  (atc6_T0='C03AA03') med6_eenheid_T0='mg'.
IF  (atc6_T0='C03AA03' and CHAR.INDEX(med6_T0,'25')>0 ) med6_dosis_T0='25'.
IF  (atc9_T0='C03AA03') med9_eenheid_T0='mg'.
IF  (atc9_T0='C03AA03' and CHAR.INDEX(med9_dosering_T0,'12,5')>0 ) med9_dosis_T0='12,5'.
** ATC C02.
IF  (atc1_T0='C02') med1_eenheid_T0='mg'.
IF  (atc1_T0='C02' and CHAR.INDEX(med1_dosering_T0,'75')>0 ) med1_dosis_T0='75'.
IF  (atc1_T0='C02' and CHAR.INDEX(med1_dosering_T0,'100')>0 ) med1_dosis_T0='100'.
IF  (atc2_T0='C02') med1_eenheid_T0='mg'.
IF  (atc2_T0='C02' and CHAR.INDEX(med2_dosering_T0,'20')>0 ) med2_dosis_T0='20'.
IF  (atc3_T0='C02') med1_eenheid_T0='mg'.
IF  (atc3_T0='C02' and CHAR.INDEX(med3_dosering_T0,'75')>0 ) med3_dosis_T0='75'.
** ATC C01DA14.
IF  (atc2_T0='C01DA14') med2_eenheid_T0='mg'.
IF  (atc2_T0='C01DA14' and CHAR.INDEX(med2_T0,'25')>0 ) med2_dosis_T0='25'.
IF  (atc6_T0='C01DA14') med6_eenheid_T0='mg'.
IF  (atc6_T0='C01DA14' and CHAR.INDEX(med6_dosering_T0,'30')>0 ) med6_dosis_T0='30'.
** ATC C01DA08.
IF  (atc10_T0='C01DA08') med10_eenheid_T0='mg'.
IF  (atc10_T0='C01DA08' and CHAR.INDEX(med10_dosering_T0,'5')>0 ) med10_dosis_T0='5'.
** ATC B03BB01 - foliumzuur.
IF  (atc2_T0='B03BB01') med2_eenheid_T0='mg'.
IF  (atc2_T0='B03BB01' and CHAR.INDEX(med2_dosering_T0,'5')>0 ) med2_dosis_T0='5'.
IF  (atc3_T0='B03BB01') med3_eenheid_T0='mg'.
IF  (atc3_T0='B03BB01' and CHAR.INDEX(med3_dosering_T0,'5')>0 ) med3_dosis_T0='5'.
IF  (atc3_T0='B03BB01') med3_eenheid_T0='mg'.
IF  (atc3_T0='B03BB01' and CHAR.INDEX(med3_dosering_T0,'5')>0 ) med3_dosis_T0='5'.
IF  (atc5_T0='B03BB01') med5_eenheid_T0='mg'.
IF  (atc5_T0='B03BB01' and CHAR.INDEX(med5_dosering_T0,'10')>0 ) med5_dosis_T0='2x5'.
** ATC B03BA03 - vit B12 injectie. Zijn altijd ampullen van 2 ml.
IF  (atc2_T0='B03BA03') med2_eenheid_T0='ml'.
IF  (atc2_T0='B03BA03' and CHAR.INDEX(med2_dosering_T0,'0.5')>0 ) med2_dosis_T0='2'.
IF  (atc2_T0='B03BA03' and CHAR.INDEX(med2_dosering_T0,'1 mg/2 ml')>0 ) med2_dosis_T0='2'.
** ATC B01AC08 - carbasalaatcalcium/ascal.
* poeder of tablet van 100 mg maakt niet uit voor kosten.
IF  (atc1_T0='B01AC08') med1_eenheid_T0='mg'.
IF  (atc1_T0='B01AC08' and CHAR.INDEX(med1_dosering_T0,'100')>0 ) med1_dosis_T0='100'.
IF  (atc2_T0='B01AC08') med2_eenheid_T0='mg'.
IF  (atc2_T0='B01AC08' and CHAR.INDEX(med2_dosering_T0,'100')>0 ) med2_dosis_T0='100'.
IF  (atc3_T0='B01AC08') med3_eenheid_T0='mg'.
IF  (atc3_T0='B01AC08' and CHAR.INDEX(med3_dosering_T0,'100')>0 ) med3_dosis_T0='100'.
IF  (atc3_T0='B01AC08' and CHAR.INDEX(med3_dosering_T0,'zakje')>0 ) med3_dosis_T0='100'.
IF  (atc4_T0='B01AC08') med4_eenheid_T0='mg'.
IF  (atc4_T0='B01AC08' and CHAR.INDEX(med4_dosering_T0,'100')>0 ) med4_dosis_T0='100'.
IF  (atc5_T0='B01AC08') med5_eenheid_T0='mg'.
IF  (atc5_T0='B01AC08' and CHAR.INDEX(med5_dosering_T0,'100')>0 ) med5_dosis_T0='100'.
IF  (atc5_T0='B01AC08' and CHAR.INDEX(med5_T0,'100')>0 ) med5_dosis_T0='100'.
** ATC B01AC07.
IF  (atc1_T0='B01AC07') med1_eenheid_T0='mg'.
IF  (atc1_T0='B01AC07' and CHAR.INDEX(med1_dosering_T0,'200')>0 ) med1_dosis_T0='200'.
IF  (atc3_T0='B01AC07') med3_eenheid_T0='mg'.
IF  (atc3_T0='B01AC07' and CHAR.INDEX(med3_dosering_T0,'200')>0 ) med3_dosis_T0='200'.
** ATC B01AC06 - acetylsalicylzuur.
IF  (atc1_T0='B01AC06') med1_eenheid_T0='mg'.
IF  (atc1_T0='B01AC06' and CHAR.INDEX(med1_dosering_T0,'80')>0 ) med1_dosis_T0='80'.
IF  (atc2_T0='B01AC06') med2_eenheid_T0='mg'.
IF  (atc2_T0='B01AC06' and CHAR.INDEX(med2_dosering_T0,'80')>0 ) med2_dosis_T0='80'.
IF  (atc3_T0='B01AC06') med3_eenheid_T0='mg'.
IF  (atc3_T0='B01AC06' and CHAR.INDEX(med3_dosering_T0,'80')>0 ) med3_dosis_T0='80'.
IF  (atc3_T0='B01AC06' and CHAR.INDEX(med3_dosering_T0,'1x per dag')>0 ) med3_dosis_T0='80'.
IF  (atc5_T0='B01AC06') med5_eenheid_T0='mg'.
IF  (atc5_T0='B01AC06' and CHAR.INDEX(med5_dosering_T0,'80')>0 ) med5_dosis_T0='80'.
IF  (atc6_T0='B01AC06') med6_eenheid_T0='mg'.
IF  (atc6_T0='B01AC06' and CHAR.INDEX(med6_dosering_T0,'80')>0 ) med6_dosis_T0='80'.
** ATC B01AA07.
IF  (atc1_T0='B01AA07') med1_eenheid_T0='mg'.
IF  (atc1_T0='B01AA07' and CHAR.INDEX(med1_dosering_T0,'6')>0 ) med1_dosis_T0='6x1'.
** ATC B01AA04 fenprocoumon.
IF  (atc2_T0='B01AA04') med2_eenheid_T0='mg'.
IF  (atc2_T0='B01AA04' and CHAR.INDEX(med2_dosering_T0,'1')>0 ) med2_dosis_T0='3'.
* bedoelt 1 tablet, is alleen in 3 mg.
IF  (atc4_T0='B01AA04') med4_eenheid_T0='mg'.
IF  (atc4_T0='B01AA04' and CHAR.INDEX(med4_dosering_T0,'3')>0 ) med4_dosis_T0='3'.
** ATC B01- bloedverdunners.
IF  (atc1_T0='B01') med1_eenheid_T0='mg'.
IF  (atc1_T0='B01' and CHAR.INDEX(med1_dosering_T0,'40')>0 ) med1_dosis_T0='40'.
IF  (atc1_T0='B01' and CHAR.INDEX(med1_dosering_T0,'100')>0 ) med1_dosis_T0='100'.
IF  (atc2_T0='B01') med2_eenheid_T0='mg'.
IF  (atc2_T0='B01' and CHAR.INDEX(med2_dosering_T0,'10')>0 ) med2_dosis_T0=''.
IF  (atc2_T0='B01' and CHAR.INDEX(med2_dosering_T0,'100')>0 ) med2_dosis_T0='100'.
** ATC A12AX.
IF  (atc1_T0='A12AX') med1_eenheid_T0='mg IE'.
IF  (atc1_T0='A12AX' and CHAR.INDEX(med1_dosering_T0,'880')>0 ) med1_dosis_T0='1000/880'.
** ATC A12AA04.
IF  (atc2_T0='A12AA04') med2_eenheid_T0='mg'.
IF  (atc2_T0='A12AA04' and CHAR.INDEX(med2_dosering_T0,'500')>0 ) med2_dosis_T0='500'.
IF  (atc3_T0='A12AA04') med3_eenheid_T0='mg'.
IF  (atc3_T0='A12AA04' and CHAR.INDEX(med3_dosering_T0,'1000')>0 ) med3_dosis_T0='1000'.
** ATC A11GA01-  ascorbinezuur.
IF  (atc3_T0='A11GA01') med3_eenheid_T0='mg'.
IF  (atc3_T0='A11GA01' and CHAR.INDEX(med3_dosering_T0,'5')>0 ) med3_dosis_T0=''.
** ATC A11CC05 - vit D.
IF  (atc2_T0='A11CC05') med2_eenheid_T0='IE'.
IF  (atc2_T0='A11CC05' and CHAR.INDEX(med2_dosering_T0,'800')>0 ) med2_dosis_T0='800'.
IF  (atc4_T0='A11CC05') med4_eenheid_T0='IE'.
IF  (atc4_T0='A11CC05' and CHAR.INDEX(med4_dosering_T0,'400')>0 ) med4_dosis_T0='400'.
IF  (atc5_T0='A11CC05') med5_eenheid_T0='IE'.
IF  (atc5_T0='A11CC05' and CHAR.INDEX(med5_dosering_T0,'800')>0 ) med5_dosis_T0='800'.
** ATC A11CC03.
IF  (atc2_T0='A11CC03') med2_eenheid_T0='ug'.
IF  (atc2_T0='A11CC03' and CHAR.INDEX(med2_dosering_T0,'0,25')>0 ) med2_dosis_T0='0,25'.
** ATC A10BD08.
IF  (atc1_T0='A10BD08') med1_eenheid_T0='mg'.
IF  (atc1_T0='A10BD08' and CHAR.INDEX(med1_T0,'mo/850')>0 ) med1_dosis_T0='50/850'.
** ATC A10BB09 - gliclazide.
IF  (atc3_T0='A10BB09') med3_eenheid_T0='mg'.
IF  (atc3_T0='A10BB09' and CHAR.INDEX(med3_dosering_T0,'80')>0 ) med3_dosis_T0='80'.
IF  (atc4_T0='A10BB09') med4_eenheid_T0='mg'.
IF  (atc4_T0='A10BB09' and CHAR.INDEX(med4_dosering_T0,'1 tablet')>0 ) med4_dosis_T0=' '.
IF  (atc6_T0='A10BB09') med6_eenheid_T0='mg'.
IF  (atc6_T0='A10BB09' and CHAR.INDEX(med6_dosering_T0,'80')>0 ) med6_dosis_T0='80'.
** ATC A10BA02- metformine.
IF  (atc1_T0='A10BA02') med1_eenheid_T0='mg'.
IF  (atc1_T0='A10BA02' and CHAR.INDEX(med1_dosering_T0,'850')>0 ) med1_dosis_T0='850'.
IF  (atc1_T0='A10BA02' and CHAR.INDEX(med1_dosering_T0,'1000')>0 ) med1_dosis_T0='1000'.
IF  (atc1_T0='A10BA02' and CHAR.INDEX(med1_dosering_T0,'500')>0 ) med1_dosis_T0='500'.
IF  (atc2_T0='A10BA02') med2_eenheid_T0='mg'.
IF  (atc2_T0='A10BA02' and CHAR.INDEX(med2_dosering_T0,'850')>0 ) med2_dosis_T0='850'.
IF  (atc2_T0='A10BA02' and CHAR.INDEX(med2_dosering_T0,'1000')>0 ) med2_dosis_T0='1000'.
IF  (atc2_T0='A10BA02' and CHAR.INDEX(med2_dosering_T0,'500')>0 ) med2_dosis_T0='500'.
IF  (atc3_T0='A10BA02') med3_eenheid_T0='mg'.
IF  (atc3_T0='A10BA02' and CHAR.INDEX(med3_dosering_T0,'500')>0 ) med3_dosis_T0='500'.
IF  (atc5_T0='A10BA02') med5_eenheid_T0='mg'.
IF  (atc5_T0='A10BA02' and CHAR.INDEX(med5_dosering_T0,'500')>0 ) med5_dosis_T0='500'.
** A10AE04.
IF  (atc8_T0='A10AE04') med8_eenheid_T0='IE'.
IF  (atc8_T0='A10AE04' and CHAR.INDEX(med8_dosering_T0,'15')>0 ) med8_dosis_T0='15'.
** A10 AB05.
IF  (atc7_T0='A10AB05') med7_eenheid_T0='IE'.
IF  (atc7_T0='A10AB05' and CHAR.INDEX(med7_dosering_T0,'5-5-5')>0 ) med7_dosis_T0='5'.
** A10A.
IF  (atc1_T0='A10A') med1_eenheid_T0='IE'.
IF  (atc1_T0='A10A' and CHAR.INDEX(med1_dosering_T0,'34')>0 ) med1_dosis_T0='34'.
*ID 4704 bedoelt met 24x per dag waarschijnlijk 24 IE per dag.
IF (ID_Code=4704 and atc1_T0='A10A') med1_dosis_T0='24'. 
IF (ID_Code=4704 and atc1_T0='A10A') med1_keerperdag_T0=1. 
IF  (atc2_T0='A10A') med2_eenheid_T0='IE'.
IF  (atc2_T0='A10A' and CHAR.INDEX(med2_dosering_T0,'10')>0 ) med2_dosis_T0='10'.
** ATC A09AA02 -.
IF  (atc9_T0='A09AA02') med9_eenheid_T0='FE'.
IF  (atc9_T0='A09AA02' and CHAR.INDEX(med9_T0,'2500')>0 ) med9_dosis_T0='22500/25000/1250'.
** ATC A06AD65 - macrogol/electrolyten.
IF  (atc3_T0='A06AD65') med3_eenheid_T0='g'.
IF  (atc3_T0='A06AD65' and CHAR.INDEX(med3_dosering_T0,'13.8')>0 ) med3_dosis_T0='13,8'.
IF  (atc5_T0='A06AD65') med5_eenheid_T0='g'.
IF  (atc5_T0='A06AD65' and CHAR.INDEX(med5_dosering_T0,'13,7')>0 ) med5_dosis_T0='13,7'.
** ATC A06AD15.- macrogol.
IF  (atc3_T0='A06AD15') med3_eenheid_T0='g'.
IF  (atc3_T0='A06AD15' and CHAR.INDEX(med3_T0,'10 G')>0 ) med3_dosis_T0='10'.
IF  (atc5_T0='A06AD15') med5_eenheid_T0='g'.
IF  (atc5_T0='A06AD15' and CHAR.INDEX(med5_dosering_T0,'130mg')>0 ) med5_dosis_T0='13'.
** ATC A06AB02 - bisacodyl.
IF  (atc2_T0='A06AB02') med2_eenheid_T0='mg'.
IF  (atc2_T0='A06AB02' and CHAR.INDEX(med2_dosering_T0,'5')>0 ) med2_dosis_T0='5'.
IF  (atc6_T0='A06AB02') med6_eenheid_T0='mg'.
IF  (atc6_T0='A06AB02' and CHAR.INDEX(med6_dosering_T0,'5')>0 ) med6_dosis_T0='5'.
** ATC A07DA03 - loperamide.
IF  (atc1_T0='A07DA03') med1_eenheid_T0='mg'.
IF  (atc1_T0='A07DA03' and CHAR.INDEX(med1_dosering_T0,'50')>0 ) med1_dosis_T0=''.
** ATC A03AA04 - duspatal.
IF  (atc5_T0='A03AA04') med5_eenheid_T0='mg'.
IF  (atc5_T0='A03AA04' and CHAR.INDEX(med5_dosering_T0,'200')>0 ) med5_dosis_T0='200'.
** ATC A02BX13 - .
IF  (atc7_T0='A02BX13') med7_eenheid_T0='mg'.
IF  (atc7_T0='A02BX13' and CHAR.INDEX(med7_dosering_T0,'250')>0 ) med7_dosis_T0='250'.
** ATC A02BC05 - esomeprazol.
IF  (atc2_T0='A02BC05') med2_eenheid_T0='mg'.
IF  (atc2_T0='A02BC05' and CHAR.INDEX(med2_dosering_T0,'40')>0 ) med2_dosis_T0='40'.
IF  (atc5_T0='A02BC05') med5_eenheid_T0='mg'.
IF  (atc5_T0='A02BC05' and CHAR.INDEX(med5_dosering_T0,'20')>0 ) med5_dosis_T0='20'.
** ATC A02BC02- pantoprazaol.
IF  (atc1_T0='A02BC02') med1_eenheid_T0='mg'.
IF  (atc1_T0='A02BC02' and CHAR.INDEX(med1_dosering_T0,'40')>0 ) med1_dosis_T0='40'.
IF  (atc2_T0='A02BC02') med2_eenheid_T0='mg'.
IF  (atc2_T0='A02BC02' and CHAR.INDEX(med2_dosering_T0,'40')>0 ) med2_dosis_T0='40'.
IF  (atc3_T0='A02BC02') med3_eenheid_T0='mg'.
* dosering omgedraaid met med2.
IF  (atc3_T0='A02BC02' and CHAR.INDEX(med3_dosering_T0,'150')>0 and Id_code=1506 ) med3_dosis_T0='20'.
IF  (atc4_T0='A02BC02') med4_eenheid_T0='mg'.
IF  (atc4_T0='A02BC02' and CHAR.INDEX(med4_dosering_T0,'20')>0 ) med4_dosis_T0='20'.
IF  (atc4_T0='A02BC02' and CHAR.INDEX(med4_dosering_T0,'40')>0 ) med4_dosis_T0='40'.
IF  (atc5_T0='A02BC02') med5_eenheid_T0='mg'.
IF  (atc5_T0='A02BC02' and CHAR.INDEX(med5_dosering_T0,'40')>0 ) med5_dosis_T0='40'.
IF  (atc6_T0='A02BC02') med6_eenheid_T0='mg'.
IF  (atc6_T0='A02BC02' and CHAR.INDEX(med6_dosering_T0,'40')>0 ) med6_dosis_T0='40'.
** ATC A02BC01- omeprazol.
IF  (atc1_T0='A02BC01') med1_eenheid_T0='mg'.
IF  (atc1_T0='A02BC01' and CHAR.INDEX(med1_dosering_T0,'40')>0 ) med1_dosis_T0='40'.
IF  (atc1_T0='A02BC01' and CHAR.INDEX(med1_dosering_T0,'20')>0 ) med1_dosis_T0='20'.
IF  (atc1_T0='A02BC01' and CHAR.INDEX(med1_dosering_T0,'10')>0 ) med1_dosis_T0='10'.
IF  (atc2_T0='A02BC01') med2_eenheid_T0='mg'.
IF  (atc2_T0='A02BC01' and CHAR.INDEX(med2_dosering_T0,'40')>0 ) med2_dosis_T0='40'.
IF  (atc2_T0='A02BC01' and CHAR.INDEX(med2_dosering_T0,'20')>0 ) med2_dosis_T0='20'.
IF  (atc2_T0='A02BC01' and CHAR.INDEX(med2_dosering_T0,'10')>0 ) med2_dosis_T0='10'.
IF  (atc3_T0='A02BC01') med3_eenheid_T0='mg'.
IF  (atc3_T0='A02BC01' and CHAR.INDEX(med3_dosering_T0,'40')>0 ) med3_dosis_T0='40'.
IF  (atc3_T0='A02BC01' and CHAR.INDEX(med3_dosering_T0,'20')>0 ) med3_dosis_T0='20'.
IF  (atc4_T0='A02BC01') med4_eenheid_T0='mg'.
IF  (atc4_T0='A02BC01' and CHAR.INDEX(med4_dosering_T0,'40')>0 ) med4_dosis_T0='40'.
IF  (atc4_T0='A02BC01' and CHAR.INDEX(med4_dosering_T0,'20')>0 ) med4_dosis_T0='20'.
IF  (atc6_T0='A02BC01') med6_eenheid_T0='mg'.
IF  (atc6_T0='A02BC01' and CHAR.INDEX(med6_dosering_T0,'40')>0 ) med6_dosis_T0='40'.
IF  (atc8_T0='A02BC01') med8_eenheid_T0='mg'.
IF  (atc8_T0='A02BC01' and CHAR.INDEX(med8_dosering_T0,'40')>0 ) med8_dosis_T0='40'.
IF  (atc8_T0='A02BC01' and CHAR.INDEX(med8_dosering_T0,'20')>0 ) med8_dosis_T0='20'.
** ATC A02BA02.
IF  (atc1_T0='A02BA02') med1_eenheid_T0='mg'.
IF  (atc1_T0='A02BA02' and CHAR.INDEX(med1_dosering_T0,'300')>0 ) med1_dosis_T0='300'.
IF  (atc2_T0='A02BA02') med2_eenheid_T0='mg'.
IF  (atc2_T0='A02BA02' and CHAR.INDEX(med2_dosering_T0,'75')>0 ) med2_dosis_T0='75'.
** ATC A02AD01- Rennie.
IF  (atc3_T0='A02AD01') med3_eenheid_T0='mg'.
IF  (atc3_T0='A02AD01' and CHAR.INDEX(med3_dosering_T0,'?')>0 ) med3_dosis_T0='680/80'.
IF  (atc6_T0='A02AD01') med6_eenheid_T0='mg'.
IF  (atc6_T0='A02AD01' and med6_dosering_T0='') med6_dosis_T0='680/80'.
EXECUTE.




