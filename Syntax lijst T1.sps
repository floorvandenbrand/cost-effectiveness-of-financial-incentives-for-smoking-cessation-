* Encoding: UTF-8.
Gebruik de file met doktersvelden.

* Encoding: UTF-8.
* Om te zorgen dat decimalen met een punt worden geschreven (van belang bij omzetten string naar numeriek).
SET LOCALE = 'en_US'.


*ID_code (voornaam) is hierin samengevoegd met achternaam************************************************************************************************************.

STRING  temp (A40). 
COMPUTE temp=CHAR.LPAD(V3,40). 
EXECUTE.

STRING  ID_code (A4). 
COMPUTE ID_code=CHAR.SUBSTR(temp,37). 
EXECUTE.

ALTER TYPE ID_code (F4.0).

***RecordedDate************************************************************************************************************************************************************.
FORMATS V8 (DATE11).
RENAME VARIABLES V8= Invuldatum_T1.
VARIABLE LABELS Invuldatum_T1.

***Dubbelen opsporen******************************************************************************************************************************************************************.
* Identify Duplicate Cases.
SORT CASES BY ID_code(A).
MATCH FILES
  /FILE=*
  /BY ID_code
  /FIRST=PrimaryFirst
  /LAST=PrimaryLast.
DO IF (PrimaryFirst).
COMPUTE  MatchSequence=1-PrimaryLast.
ELSE.
COMPUTE  MatchSequence=MatchSequence+1.
END IF.
LEAVE  MatchSequence.
FORMATS  MatchSequence (f7).
COMPUTE  InDupGrp=MatchSequence>0.
SORT CASES InDupGrp(D).
MATCH FILES
  /FILE=*
  /DROP=PrimaryFirst InDupGrp MatchSequence.
VARIABLE LABELS  PrimaryLast 'Indicator of each last matching case as Primary'.
VALUE LABELS  PrimaryLast 0 'Duplicate Case' 1 'Primary Case'.
VARIABLE LEVEL  PrimaryLast (ORDINAL).
FREQUENCIES VARIABLES=PrimaryLast.
EXECUTE.

*Handmatig dubbele cases controleren adhv diverse antwoorden. Indien inderdaad dubbel, de eerste en meest compleet ingevuld bewaren.
*Indien het niet dezelfde persoon is, checken bij Floor en aanpassen.

FILTER OFF.
USE ALL.
SELECT IF (V1 ~= 'R_3Mh73289S2RDBDL' and V1 ~= 'R_1LTp6ep6TnDu6AI' and V1 ~= 'R_2YDtktcXXLAY4F9'
and V1 ~= 'R_2Si7D7llC6ze9RY' and V1 ~='R_24NnnsWF2QZwatb' and V1 ~='R_2tfEzq7nAzNfEA5' ).
EXECUTE.

** 6 cases zijn helemaal leeg, deze verwijderen.
FILTER OFF.
USE ALL.
SELECT IF (ID_code ~= 2709 and ID_code ~= 6901 and ID_code ~= 3605 and ID_code ~= 1103 and ID_code ~= 1208).
EXECUTE.

** Toevoegen variabele die aangeeft of vragenlijst op papier is ingevuld.
IF  (ID_code=4903 or ID_code=4907 or ID_code=4912 or ID_code=4917) papier_T1=1.
IF  (ID_code=2001 or ID_code = 2003 or ID_code= 2005 or ID_code=2007
or ID_code= 2009 or ID_code=2010 or ID_code=2012 or ID_code=2013
or ID_code=2101 or ID_code=2103 or ID_code= 2105 or ID_code=2108
or ID_code= 2109 or ID_code=2112 or ID_code=2114 or ID_code=2611) papier_T1=2.
EXECUTE.
RECODE papier_T1 (SYSMIS=0).
EXECUTE.
FORMATS papier_T1 (F1.0).
VALUE LABELS papier_T1 0  'digitaal ingevuld' 1 'volledige lijst op papier' 2 'verkorte lijst op papier'.
VARIABLE LABELS papier_T1 'lijst is op papier ingevuld T1' .



** bij invullen op papier wordt automatisch als invuldatum de datum van invoeren op HAG gegenereerd. Dit corrigeren met datum op vragenlijst.

IF (ID_Code=2001) Invuldatum_T1=Date.dmy(06,12,2016).
IF (ID_Code=2003) Invuldatum_T1=Date.dmy(06,12,2016).
IF (ID_Code=2005) Invuldatum_T1=Date.dmy(06,12,2016).
IF (ID_Code=2007) Invuldatum_T1=Date.dmy(06,12,2016).
IF (ID_Code=2009) Invuldatum_T1=Date.dmy(06,12,2016).
IF (ID_Code=2010) Invuldatum_T1=Date.dmy(06,12,2016).
IF (ID_Code=2012) Invuldatum_T1=Date.dmy(06,12,2016).
IF (ID_Code=2013) Invuldatum_T1=Date.dmy(06,12,2016).
IF (ID_Code=2101) Invuldatum_T1=Date.dmy(07,12,2016).
IF (ID_Code=2103) Invuldatum_T1=Date.dmy(06,12,2016).
IF (ID_Code=2105) Invuldatum_T1=Date.dmy(06,11,2016).
IF (ID_Code=2108) Invuldatum_T1=Date.dmy(06,12,2016).
IF (ID_Code=2109) Invuldatum_T1=Date.dmy(06,12,2016).
IF (ID_Code=2112) Invuldatum_T1=Date.dmy(06,12,2016).
IF (ID_Code=2114) Invuldatum_T1=Date.dmy(07,12,2016).
** ID 2611 datum ontbreekt, gemiddelde van bedrijf 26 aanhouden.
IF (ID_Code=2611) Invuldatum_T1=Date.dmy(20,12,2016).
IF (ID_Code=4903) Invuldatum_T1=Date.dmy(10,04,2017).
** ID 4907 datum ontbreekt: datum van 4903 aanhouden.
IF (ID_Code=4907) Invuldatum_T1=Date.dmy(10,04,2017).
IF (ID_Code=4912) Invuldatum_T1=Date.dmy(13,04,2017).
IF (ID_Code=4917) Invuldatum_T1=Date.dmy(11,04,2017).
EXECUTE.

** een code is niet volledig ingevuld: 610 moet zijn 6103.
RECODE ID_code (610=6103).
EXECUTE.

RENAME VARIABLES V10=Finished.

*** privacy gevoelige variabelen deleten*.
DELETE VARIABLES V1  V2 V3 V4 V5 V6 V7 V9 Q111 Q1 Q7 LocationLatitude LocationLongitude LocationAccuracy temp PrimaryLast.

*enkele variabelen zijn geen vraag, maar toelichting, is voor iedereen 1 --> verwijderen.
DELETE VARIABLES Q29 Q35 Q37 Q41 Q48 Q54 Q64 Q62 Q75 Q80 Q81 Q113 Q135.


*** Deelnemers in analyse selecteren.
*** Bestand mergen met 'deelnemers analyse.sav. Optie 0ne-to-many, Selected look up table = in analyse.sav.
FILTER OFF.
USE ALL.
SELECT IF (in_analyse=1).
EXECUTE.


*** roken*******************************************************************************************************************************************************************.
RENAME VARIABLES Q114=stoppoging_T1 / Q129=gerookt_T1 / Q129_TEXT=gerookt_aant_sig_T1.
VARIABLE LABELS stoppoging_T1 'stoppoging sinds begin cursus' gerookt_T1 'gerookt sinds stoppoging' gerookt_aant_sig_T1 'aant sig gerookt sinds stoppoging'.

** stoppoging onlogische codering: hercoderen.
RECODE stoppoging_T1 (3=1).
VALUE LABELS stoppoging_T1 gerookt_T1 1 'nee' 2 'ja' .
EXECUTE.

** nieuwe variabele maken voor meer dan 5 sig gerookt.
IF (gerookt_aant_sig_T1='Weer volledig') gerookt_md_5sig_T1=1.
IF (gerookt_aant_sig_T1='normale aantal per dag') gerookt_md_5sig_T1=1.
IF (gerookt_aant_sig_T1='Na 15 dagen weer gestart') gerookt_md_5sig_T1=1.
IF (gerookt_aant_sig_T1='geen idee wel veel minder als normaal wel proberen af e bouwen') gerookt_md_5sig_T1=1.
IF (gerookt_aant_sig_T1='ca. 100') gerookt_md_5sig_T1=1.
IF (gerookt_aant_sig_T1='c.a 15') gerookt_md_5sig_T1=1.
IF (gerookt_aant_sig_T1='8 per dag') gerookt_md_5sig_T1=1.
IF (gerookt_aant_sig_T1='60') gerookt_md_5sig_T1=1.
IF (gerookt_aant_sig_T1='6') gerookt_md_5sig_T1=1.
IF (gerookt_aant_sig_T1='57') gerookt_md_5sig_T1=1.
IF (gerookt_aant_sig_T1='50') gerookt_md_5sig_T1=1.
IF (gerookt_aant_sig_T1='5 per dag') gerookt_md_5sig_T1=1.
IF (gerookt_aant_sig_T1='450') gerookt_md_5sig_T1=1.
IF (gerookt_aant_sig_T1='40 per dag') gerookt_md_5sig_T1=1.
IF (gerookt_aant_sig_T1='40 ongeveer') gerookt_md_5sig_T1=1.
IF (gerookt_aant_sig_T1='4 / dag') gerookt_md_5sig_T1=1.
IF (gerookt_aant_sig_T1='38') gerookt_md_5sig_T1=1.
IF (gerookt_aant_sig_T1='300') gerookt_md_5sig_T1=1.
IF (gerookt_aant_sig_T1='30') gerookt_md_5sig_T1=1.
IF (gerookt_aant_sig_T1='3 per dag') gerookt_md_5sig_T1=1.
IF (gerookt_aant_sig_T1='26') gerookt_md_5sig_T1=1.
IF (gerookt_aant_sig_T1='23') gerookt_md_5sig_T1=1.
IF (gerookt_aant_sig_T1='25') gerookt_md_5sig_T1=1.
IF (gerookt_aant_sig_T1='20-30') gerookt_md_5sig_T1=1.
IF (gerookt_aant_sig_T1='20') gerookt_md_5sig_T1=1.
IF (gerookt_aant_sig_T1='15') gerookt_md_5sig_T1=1.
IF (gerookt_aant_sig_T1='100') gerookt_md_5sig_T1=1.
IF (gerookt_aant_sig_T1='10-12') gerookt_md_5sig_T1=1.
IF (gerookt_aant_sig_T1='10') gerookt_md_5sig_T1=1.
EXECUTE.
IF (gerookt_T1=1)  gerookt_md_5sig_T1=0.
IF (gerookt_aant_sig_T1='1') gerookt_md_5sig_T1=0.
IF (gerookt_aant_sig_T1='2') gerookt_md_5sig_T1=0.
IF (gerookt_aant_sig_T1='3') gerookt_md_5sig_T1=0.
IF (gerookt_aant_sig_T1='4') gerookt_md_5sig_T1=0.
IF (gerookt_aant_sig_T1='5') gerookt_md_5sig_T1=0.
EXECUTE.

*Indeling op basis van rookgegevens tussen bijeenkomsten.
IF (ID_Code=6406)  gerookt_md_5sig_T1=1.
IF (ID_Code=5807)  gerookt_md_5sig_T1=1.
IF (ID_Code=2901)  gerookt_md_5sig_T1=1.
IF (ID_Code=4801)  gerookt_md_5sig_T1=1.
IF (ID_Code=3807)  gerookt_md_5sig_T1=1.
IF (ID_Code=4807)  gerookt_md_5sig_T1=1.
IF (ID_Code=1903)  gerookt_md_5sig_T1=9.
IF (ID_Code=6504)  gerookt_md_5sig_T1=1.
IF (ID_Code=4919)  gerookt_md_5sig_T1=1.
IF (ID_Code=3701)  gerookt_md_5sig_T1=0.
IF (ID_Code=6502)  gerookt_md_5sig_T1=1.
IF (ID_Code=3103)  gerookt_md_5sig_T1=1.
IF (ID_Code=5616)  gerookt_md_5sig_T1=1.
IF (ID_Code=5606)  gerookt_md_5sig_T1=1.
IF (ID_Code=5610)  gerookt_md_5sig_T1=9.
IF (ID_Code=4909)  gerookt_md_5sig_T1=1.
IF (ID_Code=5118)  gerookt_md_5sig_T1=1.
IF (ID_Code=2703)  gerookt_md_5sig_T1=1.
IF (ID_Code=2809)  gerookt_md_5sig_T1=0.
IF (ID_Code=2501)  gerookt_md_5sig_T1=1.
IF (ID_Code=5117)  gerookt_md_5sig_T1=1.
IF (ID_Code=4205)  gerookt_md_5sig_T1=1.
IF (ID_Code=7114)  gerookt_md_5sig_T1=0.
IF (ID_Code=5802)  gerookt_md_5sig_T1=1.
IF (ID_Code=2109)  gerookt_md_5sig_T1=1.
IF (ID_Code=4913)  gerookt_md_5sig_T1=9.
IF (ID_Code=1701)  gerookt_md_5sig_T1=9.
EXECUTE.

VARIABLE LABELS gerookt_md_5sig_T1 'meer dan 5 sig gerookt'.
VALUE LABELS gerookt_md_5sig_T1 0 '0-5 sig gerookt' 1 'meer dan 5 sig gerookt' .
FORMATS gerookt_md_5sig_T1 (F1.0).
MISSING VALUES gerookt_md_5sig_T1 (9).

RENAME VARIABLES Q123_1_1 = gerookt_bijeenkomst1_2 / Q123_1_2 = gerookt_bijeenkomst2_3 / Q123_1_3 = gerookt_bijeenkomst3_4 / 
Q123_1_4 = gerookt_bijeenkomst4_5 / Q123_1_5 = gerookt_bijeenkomst5_6 /  Q123_1_6 = gerookt_bijeenkomst6_7 / Q123_1_7 = gerookt_bijeenkomst_na7/
Q130_1_TEXT = gerookt_bijeenkomst3_4_aant_sig / Q130_2_TEXT = gerookt_bijeenkomst4_5_aant_sig.
VARIABLE LABELS  gerookt_bijeenkomst1_2 / gerookt_bijeenkomst2_3 / gerookt_bijeenkomst3_4 / 
gerookt_bijeenkomst4_5 / gerookt_bijeenkomst5_6 /  gerookt_bijeenkomst6_7 / gerookt_bijeenkomst_na7 / gerookt_bijeenkomst3_4_aant_sig 'aant sig tussen bijeenkomst 3 en 4' /
gerookt_bijeenkomst4_5_aant_sig 'aant sig tussen bijeenkomst 4 en 5'.

VALUE LABELS gerookt_bijeenkomst1_2  gerookt_bijeenkomst2_3  gerookt_bijeenkomst3_4  gerookt_bijeenkomst4_5  gerookt_bijeenkomst5_6   
gerookt_bijeenkomst6_7  gerookt_bijeenkomst_na7 1 'gerookt' 2 'helemaal niet gerookt' 3 'enkele sigaretten gerookt'.

*** aantal sigaretten tussen bijeenkomst 3 en 4 en 4 en 5. We willen alleen weten of er in totaal tussen bijeenkomst 3 en 5 meer dan 5 sigaretten zijn gerookt.
* omzetten van string naar numeriek.
*eerst diverse aanpassingen.
RECODE gerookt_bijeenkomst3_4_aant_sig ('Zoals ik voorheen deed'='105').
RECODE gerookt_bijeenkomst3_4_aant_sig ('Regulier'='154').
RECODE gerookt_bijeenkomst3_4_aant_sig ('10 p/d'='70').
RECODE gerookt_bijeenkomst3_4_aant_sig ('10 pd'='70').
RECODE gerookt_bijeenkomst4_5_aant_sig ('Zoals ik voorheen deed'='105').
RECODE gerookt_bijeenkomst4_5_aant_sig ('Regulier'='154').
RECODE gerookt_bijeenkomst4_5_aant_sig ('10 p/d'='70').
RECODE gerookt_bijeenkomst4_5_aant_sig ('4-5 pd'='35').
EXECUTE.
ALTER TYPE gerookt_bijeenkomst3_4_aant_sig gerookt_bijeenkomst4_5_aant_sig (F4.0).

IF  (SUM(gerookt_bijeenkomst3_4_aant_sig,gerookt_bijeenkomst4_5_aant_sig)>5)  gerookt_bijeenkomst3_5=1.
IF  (SUM(gerookt_bijeenkomst3_4_aant_sig,gerookt_bijeenkomst4_5_aant_sig)<=5)  gerookt_bijeenkomst3_5=0.
IF  (gerookt_bijeenkomst3_4=2 and gerookt_bijeenkomst4_5=2)  gerookt_bijeenkomst3_5=0.
IF  (gerookt_bijeenkomst3_4=1 or gerookt_bijeenkomst4_5=1)  gerookt_bijeenkomst3_5=1.
EXECUTE.
* de rest is missing.
RECODE gerookt_bijeenkomst3_5 (SYSMIS=9).
EXECUTE.
FORMATS gerookt_bijeenkomst3_5 (F1.0).
VARIABLE LABELS  gerookt_bijeenkomst3_5  'tussen bijeenk 3 en 5 meer of minder dan 5 sig gerookt'.
VALUE LABELS  gerookt_bijeenkomst3_5 0 '0-5 sig gerookt' 1 'meer dan 5 sig gerookt' .
MISSING VALUES  gerookt_bijeenkomst3_5 (9).

RENAME VARIABLES Q116=gerookt_7d_T1/ Q116.0=stoppen7_T1.
VARIABLE LABELS gerookt_7d_T1 'afgelopen 7 dagen gerookt'.
** onlogische codering.
RECODE gerookt_7d_T1 (3=2).
VALUE LABELS gerookt_7d_T1 1 'ja' 2 'nee' .
EXECUTE.

* Indien Q116 (gerookt) nee is, moet Q116.0 (van plan te stoppen) nvt zijn.
* Nieuwe code 6 ‘nvt’. 
DO IF  gerookt_7d_T1=2.
COMPUTE stoppen7_T1=6.
END IF.
EXECUTE.
VALUE LABELS stoppen7_T1 1 'binnen nu en een maand' 2 'binnen 6 maanden'  3 'in de toekomst maar niet binnen 6 maanden' 4 'nee,nooit' 5 'weet niet'  6 'nvt'.

RENAME VARIABLES Q117=roken7_T1 / Q117.0=stoppen1a_T1 / Q118=stoppen2a_T1 / Q119=stoppen3a_T1 / Q124=stoppen1b_T1 / Q125=stoppen2b_T1 / Q126=stoppen3b_T1.

** stoppen1a en b en 3 a en b zijn onlogisch gecodeerd (anders dan bij T0).

RECODE stoppen1a_T1 stoppen1b_T1 stoppen3a_T1 stoppen3b_T1 (4=1) (5=2) (6=3) (7=4) (8=5).
EXECUTE.
VALUE LABELS stoppen1a_T1 stoppen1b_T1 1 'zeer verstandig' 2 'verstandig' 3 'niet verstandig, maar ook niet onverstandig' 4 'onverstandig' 5 'zeer onverstandig'.
VALUE LABELS stoppen3a_T1 stoppen3b_T1 1 'zeer positief' 2 'positief' 3 'niet positief, maar ook niet negatief' 4 'negatief' 5 'zeer negatief'.

** Indien afgelopen dagen gerookt (gerookt_7d_T1)=nee de vragen ‘blijvend’ aanhouden, indien afgelopen dagen gerookt=ja de vragen ‘binnen 3 maanden’ aanhouden, 
deze combineren tot 1 variabele.

DO IF gerookt_7d_T1=2.
COMPUTE stoppen1_T1=stoppen1a_T1.
COMPUTE stoppen2_T1=stoppen2a_T1.
COMPUTE stoppen3_T1=stoppen3a_T1.
END IF.
DO IF gerookt_7d_T1=1.
COMPUTE stoppen1_T1=stoppen1b_T1.
COMPUTE stoppen2_T1=stoppen2b_T1.
COMPUTE stoppen3_T1=stoppen3b_T1.
END IF.
EXECUTE.

VALUE LABELS stoppen1_T1  1 'zeer verstandig' 2 'verstandig' 3 'niet verstandig, maar ook niet onverstandig' 4 'onverstandig' 5 'zeer onverstandig'.
VALUE LABELS stoppen2_T1  1 'zeer plezierig' 2 'plezierig' 3 'niet plezierig, maar ook niet onplezierig' 4 'onplezierig' 5 'zeer onplezierig'.
VALUE LABELS stoppen3_T1  1 'zeer positief' 2 'positief' 3 'niet positief, maar ook niet negatief' 4 'negatief' 5 'zeer negatief'.
VARIABLE LABELS stoppen1_T1 'Als u blijvend niet rookt/binnen 3 mnd stopt, is dat verstandig/onverstandig'.
VARIABLE LABELS stoppen2_T1 'Als u blijvend niet rookt/binnen 3 mnd stopt, is dat plezierig/onplezierig'.
VARIABLE LABELS stoppen3_T1 'Als u blijvend niet rookt/binnen 3 mnd stopt, is dat positief/negatief'.
FORMATS stoppen1_T1 stoppen2_T1 stoppen3_T1 (F1.0).

DELETE VARIABLES stoppen1a_T1 stoppen1b_T1 stoppen2a_T1 stoppen2b_T1 stoppen3a_T1 stoppen3b_T1.

RENAME VARIABLES Q127=stoppen4_T1 / Q128=stoppen5_T1 / Q129.0=stoppen6_T1.
** stoppen4 en 5 zijn onlogisch gecodeerd (anders dan bij T0).
RECODE stoppen4_T1 (4=1) (5=2) (6=3) (7=4).
RECODE stoppen5_T1 (4=1) (5=2) (6=3) (7=4) (8=5).
VALUE LABELS stoppen4_T1 1 'nooit' 2 'soms' 3 'vaak' 4 '(bijna) altijd' .
VALUE LABELS stoppen5_T1 1 '(bijna) allemaal positief' 2 'meestal positief' 3 'even vaak positief als negatief' 4 'meestal negatief' 5 '(bijna) allemaal negatief'.

*Indien stoppen4 =1 (nooit), dan moet stoppen5 missing zijn.
USE ALL.
COMPUTE filter_$=(stoppen4_T1=1).
VARIABLE LABELS filter_$ 'stoppen4_T1=1 (FILTER)'.
VALUE LABELS filter_$ 0 'Not Selected' 1 'Selected'.
FORMATS filter_$ (f1.0).
FILTER BY filter_$.
EXECUTE.
FREQUENCIES VARIABLES=stoppen5_T1
  /ORDER=ANALYSIS.
USE ALL.

** deze missing wordt nvt (nieuwe code).
IF  (stoppen4_T1=1) stoppen5_T1=6.
EXECUTE.
VALUE LABELS stoppen5_T1 1 '(bijna) allemaal positief' 2 'meestal positief'  3 'even vaak positief als negatief' 4 'meestal negatief' 5 '(bijna) allemaal negatief' 6 'nvt'. 

RENAME VARIABLES Q130_1=stoppen7a1_T1 /  Q130_2=stoppen7b1_T1 /  Q130_3=stoppen7c1_T1 / Q130_4=stoppen7d1_T1 / Q130_5=stoppen7e1_T1 /
Q131_1=stoppen7a2_T1 /  Q131_2=stoppen7b2_T1 /  Q131_3=stoppen7c2_T1 / Q131_4=stoppen7d2_T1 / Q131_5=stoppen7e2_T1. 
VARIABLE LABELS 
stoppen7a1_T1 'stoppen binnen 3 mnd: lukt het te stoppen als u net wakker bent' 
stoppen7b1_T1 'stoppen binnen 3 mnd: lukt het te stoppen als u iets vervelends heeft meegemaakt' 
stoppen7c1_T1 'stoppen binnen 3 mnd: lukt het te stoppen als u koffie of thee drinkt'
stoppen7d1_T1 'stoppen binnen 3 mnd: lukt het te stoppen als u alcohol drinkt'
stoppen7e1_T1 'stoppen binnen 3 mnd: lukt het te stoppen als u een sigaret wordt aangeboden'
stoppen7a2_T1 'gestopt: lukt het blijvend niet te roken als u net wakker bent' 
stoppen7b2_T1 'gestopt: lukt het blijvend niet te roken als u iets vervelends heeft meegemaakt' 
stoppen7c2_T1 'gestopt: lukt het blijvend niet te roken als u koffie of thee drinkt'
stoppen7d2_T1 'gestopt: lukt het blijvend niet te roken als u alcohol drinkt'
stoppen7e2_T1 'gestopt: lukt het blijvend niet te roken als u een sigaret wordt aangeboden' .


*** Q133: gewicht van string naar numeriek************************************************************************************************************************************************.
* tekst verwijderen, decimaal met komma.
FREQUENCIES VARIABLES=Q133
  /ORDER=ANALYSIS.

STRING temp1 (A20).
COMPUTE temp1=REPLACE(Q133, 'kg','').
EXECUTE.

STRING temp2 (A20).
COMPUTE temp2=REPLACE(temp1,'kilo','').
EXECUTE.

STRING temp3 (A20).
COMPUTE temp3=REPLACE(temp2,'?','').
EXECUTE.

STRING temp4 (A20).
COMPUTE temp4=REPLACE(temp3,',','.').
EXECUTE.

RECODE temp4 ('Tachtig'='80') ('X'='').

*controle.
FREQUENCIES VARIABLES=temp4
  /ORDER=ANALYSIS.

RENAME VARIABLES temp4=gewicht_T1.
ALTER TYPE gewicht_T1 (F3.0).

DELETE VARIABLES temp1 temp2 temp3.

* Controle reeele getallen.
FREQUENCIES gewicht_T1.

** gewicht 0 en 2 kg --> missing.
RECODE gewicht_T1 (0=9999) (2=9999) (SYSMIS=9999).
EXECUTE.
MISSING VALUES gewicht_T1 (9999).
VARIABLE WIDTH  gewicht_T1 (9).
VARIABLE LEVEL  gewicht_T1 (SCALE).

*** Q30/Q36: EQ5D **************************************************************************************************************************************************************************.
RENAME VARIABLES Q30=EQ5D_1_T1 / Q31=EQ5D_2_T1 / Q32=EQ5D_3_T1 / Q33=EQ5D_4_T1 / Q34=EQ5D_5_T1.
VARIABLE LABELS EQ5D_1_T1 'EQ5D mobiliteit T1' EQ5D_2_T1 'EQ5D zelfzorg T1' 
EQ5D_3_T1 'EQ5D ADL T1' EQ5D_4_T1 'EQ5D pijn/ongemak T1' EQ5D_5_T1 'EQ5D angst/somberheid T1'.

RENAME VARIABLES Q36=EQ5D_VAS_T1.
VARIABLE LABELS EQ5D_VAS_T1 'EQ5D gezondheid T1'.
FORMATS EQ5D_VAS_T1 (F3.0).

*** totaalscore EQ.
* Based on the following publication: Versteegh, M. M., Vermeulen, K. M., Evers, S. M., de Wit, G. A., Prenger, R., & Stolk, E. A. (2016). Dutch Tariff for the Five-Level Version of EQ-5D. Value in Health, 2016. doi:10.1016/j.jval.2016.01.003 

COMPUTE EQ5D_T1 = 1.
DO IF (NVALID(EQ5D_1_T1, EQ5D_2_T1, EQ5D_3_T1, EQ5D_4_T1, EQ5D_5_T1) < 5).
RECODE EQ5D_T1 (1 = SYSMIS).
END IF.
IF (max(EQ5D_1_T1, EQ5D_2_T1, EQ5D_3_T1, EQ5D_4_T1, EQ5D_5_T1)>1)EQ5D_T1 = EQ5D_T1 - .0469233.
IF (EQ5D_1_T1 = 2) EQ5D_T1 = EQ5D_T1 - .0354544.
IF (EQ5D_1_T1 = 3) EQ5D_T1 = EQ5D_T1 - .0565962.
IF (EQ5D_1_T1 = 4) EQ5D_T1 = EQ5D_T1 - .166003.
IF (EQ5D_1_T1 = 5) EQ5D_T1 = EQ5D_T1 - .2032975.

IF (EQ5D_2_T1 = 2) EQ5D_T1 = EQ5D_T1 - .0381079.
IF (EQ5D_2_T1 = 3) EQ5D_T1 = EQ5D_T1 - .0605347.
IF (EQ5D_2_T1 = 4) EQ5D_T1 = EQ5D_T1 - .1677852.
IF (EQ5D_2_T1 = 5) EQ5D_T1 = EQ5D_T1 - .1677852.

IF (EQ5D_3_T1 = 2) EQ5D_T1 = EQ5D_T1 - .0391539.
IF (EQ5D_3_T1 = 3) EQ5D_T1 = EQ5D_T1 - .0867559.
IF (EQ5D_3_T1 = 4) EQ5D_T1 = EQ5D_T1 - .1924631.
IF (EQ5D_3_T1 = 5) EQ5D_T1 = EQ5D_T1 - .1924631.

IF (EQ5D_4_T1 = 2) EQ5D_T1 = EQ5D_T1 - .0658959.
IF (EQ5D_4_T1 = 3) EQ5D_T1 = EQ5D_T1 - .0919619.
IF (EQ5D_4_T1 = 4) EQ5D_T1 = EQ5D_T1 - .35993.
IF (EQ5D_4_T1 = 5) EQ5D_T1 = EQ5D_T1 - .4152142.

IF (EQ5D_5_T1 = 2) EQ5D_T1 = EQ5D_T1 - .069622.
IF (EQ5D_5_T1 = 3) EQ5D_T1 = EQ5D_T1 - .1445222.
IF (EQ5D_5_T1 = 4) EQ5D_T1 = EQ5D_T1 - .3563913.
IF (EQ5D_5_T1 = 5) EQ5D_T1 = EQ5D_T1 - .4206361.
EXECUTE.

* missings.
RECODE EQ5D_1_T1 EQ5D_2_T1 EQ5D_3_T1 EQ5D_4_T1 EQ5D_5_T1 EQ5D_T1  (SYSMIS=99).
RECODE EQ5D_VAS_T1  (SYSMIS=999).
EXECUTE.
MISSING VALUES EQ5D_1_T1 EQ5D_2_T1 EQ5D_3_T1 EQ5D_4_T1 EQ5D_5_T1 EQ5D_T1 (99) EQ5D_VAS_T1 (999).
VARIABLE LABELS EQ5D_T1 'EQ5D tot score T1'.
VARIABLE LEVEL  EQ5D_1_T1 EQ5D_2_T1 EQ5D_3_T1 EQ5D_4_T1 EQ5D_5_T1 (ORDINAL).
VARIABLE WIDTH  EQ5D_1_T1 EQ5D_2_T1 EQ5D_3_T1 EQ5D_4_T1 EQ5D_5_T1 (5).


** Q38/39/40: CCQ***************************************************************************************************************************************************************.
RENAME VARIABLES Q38_1=CCQ1_T1 / Q38_2=CCQ2_T1 / Q38_3=CCQ3_T1 / Q38_4=CCQ4_T1 / Q39_1=CCQ5_T1 / Q39_2=CCQ6_T1 / 
Q40_1=CCQ7_T1 / Q40_2=CCQ8_T1 / Q40_3=CCQ9_T1 / Q40_4=CCQ10_T1.
VARIABLE LABELS CCQ1_T1 'CCQ kortademig rust T1' CCQ2_T1 'CCQ kortademig lich inspanning T1' CCQ3_T1 'CCQ angstig/bezorgd T1' CCQ4_T1 'CCQ neerslachtig T1' 
CCQ5_T1 'CCQ gehoest T1' CCQ6_T1 'CCQ slijm opgehoest T1' CCQ7_T1 'CCQ beperkt bij zware lich activiteit T1' CCQ8_T1 'CCQ beperkt bij matige lich activiteit T1' 
CCQ9_T1 'CCQ beperkt bij dagelijkse activiteiten T1' CCQ10_T1 'CCQ beperkt bij sociale activiteiten T1'. 

*** CCQ totaalscores.
'minimum aantal missings??.
COMPUTE CCQ_tot_T1=MEAN(CCQ1_T1,CCQ2_T1,CCQ3_T1,CCQ4_T1,CCQ5_T1,CCQ6_T1,CCQ7_T1,CCQ8_T1,CCQ9_T1, CCQ10_T1).
COMPUTE CCQ_klachten_T1=MEAN(CCQ1_T1,CCQ2_T1,CCQ5_T1,CCQ6_T1).
COMPUTE CCQ_emoties_T1=MEAN(CCQ3_T1,CCQ4_T1).
COMPUTE CCQ_conditie_T1=MEAN(CCQ7_T1,CCQ8_T1,CCQ9_T1, CCQ10_T1).
EXECUTE.

** missings.
RECODE CCQ1_T1 CCQ2_T1 CCQ3_T1 CCQ4_T1 CCQ5_T1 CCQ6_T1 CCQ7_T1 CCQ8_T1 CCQ9_T1 CCQ10_T1 (SYSMIS=99).
RECODE CCQ_tot_T1 CCQ_klachten_T1 CCQ_emoties_T1 CCQ_conditie_T1 (SYSMIS=99).
EXECUTE.
MISSING VALUES CCQ1_T1 CCQ2_T1 CCQ3_T1 CCQ4_T1 CCQ5_T1 CCQ6_T1 CCQ7_T1 CCQ8_T1 CCQ9_T1 CCQ10_T1
 CCQ_tot_T1 CCQ_klachten_T1 CCQ_emoties_T1 CCQ_conditie_T1 (99).
VARIABLE LEVEL CCQ1_T1 CCQ2_T1 CCQ3_T1 CCQ4_T1 CCQ5_T1 CCQ6_T1 CCQ7_T1 CCQ8_T1 CCQ9_T1 CCQ10_T1 (ORDINAL).
VARIABLE WIDTH CCQ1_T1 CCQ2_T1 CCQ3_T1 CCQ4_T1 CCQ5_T1 CCQ6_T1 CCQ7_T1 CCQ8_T1 CCQ9_T1 CCQ10_T1 (4).
VARIABLE WIDTH CCQ_tot_T1 CCQ_klachten_T1 CCQ_emoties_T1 CCQ_conditie_T1 (9).

*** Q42/43/44: aan roken gerelateerde ziektes************************************************************************************************************************************.
RENAME VARIABLES Q42=rokersziektes1a_T1 / Q120=rokersziekte1b_T1 / Q43=rokersziektes2a_T1 /Q121=rokersziekte2b_T1 / Q44=rokersziektes3_T1.
* In de papieren versie staat steeds 1 vraag over ‘blijf roken of weer ga roken’.
*In de elektronische versie is deze opgesplitst naar 2 vragen.
*Samenvoegen naar 1 variabele.
RENAME VARIABLES rokersziektes1a_T1=rokersziektes1_T1.
DO IF SYSMIS(rokersziektes1_T1)=1.
COMPUTE rokersziektes1_T1=rokersziekte1b_T1.
END IF.
RENAME VARIABLES rokersziektes2a_T1=rokersziektes2_T1.
DO IF SYSMIS(rokersziektes2_T1)=1.
COMPUTE rokersziektes2_T1=rokersziekte2b_T1.
END IF.
EXECUTE.
DELETE VARIABLES rokersziekte1b_T1 rokersziekte2b_T1.
VARIABLE LABELS rokersziektes1_T1 'Als ik blijf roken/weer ga roken dan is de kans dat ik hierdoor op een bepaald punt in mijn leven een ziekte krijg T1'/
rokersziektes2_T1 'Als ik blijf roken/weer ga roken ben ik bang om hierdoor op een bepaald punt in mijn leven een ziekte te krijgen T1' /
rokersziektes3_T1 'Ten opzichte van andere ziektes zijn de gevolgen van roken-gerelateerde ziektes: T1'.

** missings.
RECODE rokersziektes1_T1 rokersziektes2_T1 rokersziektes3_T1 (SYSMIS=99).
MISSING VALUES rokersziektes1_T1 rokersziektes2_T1 rokersziektes3_T1 (99).
EXECUTE.
VARIABLE WIDTH  rokersziektes1_T1 rokersziektes2_T1 rokersziektes3_T1 (5).
VARIABLE LEVEL  rokersziektes1_T1 rokersziektes2_T1 rokersziektes3_T1 (ORDINAL).

***Q46: stress********************************************************************************************************************************************************************.
RENAME VARIABLES Q46_1=stress1_T1 / Q46_2=stress2_T1 / Q46_3=stress3_T1 / Q46_4=stress4_T1 / Q46_5=stress5_T1.
VARIABLE LABELS stress1_T1 'Hoe vaak heeft u het gevoel gehad dat u geen controle had over de belangrijke dingen in uw leven? T1'
stress2_T1 'Hoe vaak heeft u zich er zeker van gevoeld dat u in staat was om persoonlijke problemen aan te kunnen? T1'
stress3_T1 'Hoe vaak heeft u het gevoel gehad dat alles liep zoals u wilde? T1'
stress4_T1 'Hoe vaak heeft u het gevoel gehad dat de problemen zich zo hoog opstapelden dat u ze niet kon overwinnen? T1'
stress5_T1 'Hoe vaak bent u aangeslagen geweest door gebeurtenissen in de wereld? T1'.


** missings.
RECODE stress1_T1 stress2_T1 stress3_T1 stress4_T1 stress5_T1  (SYSMIS=99).
MISSING VALUES stress1_T1 stress2_T1 stress3_T1 stress4_T1 stress5_T1 (99).
EXECUTE.
VARIABLE WIDTH  stress1_T1 stress2_T1 stress3_T1 stress4_T1 stress5_T1 (5).
VARIABLE LEVEL   stress1_T1 stress2_T1 stress3_T1 stress4_T1 stress5_T1 (ORDINAL).

***Q49/50/51/52/119/120: sociale omgeving*************************************************************************************************************************************.
RENAME VARIABLES Q49=soc_omgeving1_T1 /  Q50=soc_omgeving2_T1 /  Q51=soc_omgeving3_T1 /  Q52=soc_omgeving4_T1 /  Q112=soc_omgeving5_T1 . 
** soc_omgeving3 is onlogisch gecodeerd (anders dan bij T0).
RECODE soc_omgeving3_T1 (1=1) (2=2) (4=3) (6=4).
VALUE LABELS soc_omgeving3_T1 1 'veel steun' 2 'niet veel/niet weinig steun' 3 'weinig steun' 4 'weet niet'.
** soc_omgeving5 is onlogisch gecodeerd (anders dan bij T0).
RECODE soc_omgeving5_T1 (4=1) (6=2) (7=3) (10=4).
VALUE LABELS soc_omgeving5_T1 1 'veel steun' 2 'niet veel/niet weinig steun' 3 'weinig steun' 4 'weet niet'.
EXECUTE.

VARIABLE LABELS soc_omgeving1_T1  'Rookt uw partner? T1' /
soc_omgeving2_T1 'Is uw partner in de afgelopen 2 maanden succesvol gestopt met roken? T1' /
soc_omgeving3_T1 'Hoeveel steun heeft u gekregen van uw partner bij het (proberen te) stoppen met roken T1'/
soc_omgeving4_T1 'Hoeveel van de vijf meest nabije vrienden, bekenden of collegas waar u regelmatig tijd mee doorbrengt zijn roker? T1'/
soc_omgeving5_T1 'Hoeveel steun heeft u gekregen van uw vrienden en familieleden bij het (proberen te) stoppen met roken T1'.

* ID 2114  invoerfout. Is een verkorte lijst dus dezevraag ontbreekt, maar is wel ingevuld.
DO IF ID_code=2114.
RECODE soc_omgeving3_T1 (4=99).
END IF.

RECODE soc_omgeving1_T1 soc_omgeving2_T1 soc_omgeving3_T1 soc_omgeving4_T1 soc_omgeving5_T1 (SYSMIS=99).
EXECUTE.
MISSING VALUES soc_omgeving1_T1 soc_omgeving2_T1 soc_omgeving3_T1 soc_omgeving4_T1 soc_omgeving5_T1 (99).
VARIABLE WIDTH soc_omgeving1_T1 soc_omgeving2_T1 soc_omgeving3_T1 soc_omgeving4_T1 soc_omgeving5_T1 (5).
VARIABLE LEVEL soc_omgeving1_T1 soc_omgeving2_T1 soc_omgeving3_T1 soc_omgeving4_T1 soc_omgeving5_T1 (NOMINAL).

***Q55/Q60: roken op werk******************************************************************************************************************************************************.
RENAME VARIABLES Q55_1=roken_op_werk1_T1 /  Q55_2=roken_op_werk2_T1 / Q55_4=roken_op_werk3_T1 / Q55_5=roken_op_werk4_T1 /
Q56=roken_op_werk5_T1 / Q57=roken_op_werk6_T1 / Q59=soc_omgeving6a_T1 / Q134=soc_omgeving6b_T1.
VARIABLE LABELS roken_op_werk1_T1 'Is het toegestaan om te roken op het werk? T1' 
roken_op_werk2_T1 'Bent u vrij om rookpauzes te nemen wanneer u wilt? T1' 
roken_op_werk3_T1 'Zijn er op het werk speciale rookplekken binnen? T1'
roken_op_werk4_T1 'Zijn er op het werk speciale rookplekken buiten? T1'
roken_op_werk5_T1 'Roken wordt ontmoedigd op het werk T1'
roken_op_werk6_T1 'Op het werk wordt het normaal gevonden dat er collegas roken T1'
soc_omgeving6a_T1 'Hoeveel steun heeft u gekregen van uw collegas die niet meededen aan de stoppen-met-rokencursus T1'
soc_omgeving6b_T1 'Hoeveel steun heeft u gekregen van uw collegas die wel meededen aan de stoppen-met-rokencursus T1'.

* soc_omgeving6a_T1 en 6b_T1 heeft onlogische codering: hercoderen.
RECODE  soc_omgeving6a_T1 (2=1) (3=2) (4=3) (6=4).
RECODE  soc_omgeving6b_T1 (2=1) (3=2) (4=3) (6=4).
EXECUTE.
VALUE LABELS soc_omgeving6a_T1 soc_omgeving6b_T1 1 'veel steun' 2  'niet veel/niet weing steun' 3 'weinig steun' 4  'weet niet' . 

* roken_op_werk5_T1 heeft onlogische codering: hercoderen.
RECODE roken_op_werk5_T1 (1=1) (2=2) (3=3) (4=4) (5=5) (7=6).
EXECUTE.
VALUE LABELS roken_op_werk5_T1 1 'Helemaal mee oneens' 2  'Mee oneens' 3 'Niet mee oneens, niet mee eens' 4  'Mee eens'  5  'Helemaal mee eens' 6 'Weet niet'. 

* missings.
RECODE roken_op_werk1_T1 roken_op_werk2_T1 roken_op_werk3_T1 roken_op_werk4_T1 roken_op_werk5_T1 roken_op_werk6_T1 soc_omgeving6a_T1 soc_omgeving6b_T1 (SYSMIS=99).
EXECUTE.
MISSING VALUES roken_op_werk1_T1 roken_op_werk2_T1 roken_op_werk3_T1 roken_op_werk4_T1  (99) roken_op_werk5_T1 roken_op_werk6_T1 (6,99)  
soc_omgeving6a_T1 soc_omgeving6b_T1 (4,99).
VARIABLE LEVEL roken_op_werk1_T1 roken_op_werk2_T1 roken_op_werk3_T1 roken_op_werk4_T1  (NOMINAL). 
VARIABLE LEVEL roken_op_werk5_T1 roken_op_werk6_T1 soc_omgeving6a_T1 soc_omgeving6b_T1 (ORDINAL).
VARIABLE WIDTH roken_op_werk1_T1 roken_op_werk2_T1 roken_op_werk3_T1 roken_op_werk4_T1 roken_op_werk5_T1 roken_op_werk6_T1  soc_omgeving6a_T1 soc_omgeving6b_T1 (7).



*** Q64: werkuren*************************************************************************************************************************************************************.
* van string naar numeriek.
FREQUENCIES VARIABLES=Q64
  /ORDER=ANALYSIS.

STRING temp1 (A20).
COMPUTE temp1=REPLACE(Q64, 'uur','').
EXECUTE.

STRING temp2 (A20).
COMPUTE temp2=REPLACE(temp1,'37/38','38').
EXECUTE.

STRING temp3 (A20).
COMPUTE temp3=REPLACE(temp2,'40 tot 45','43').
EXECUTE.

STRING temp4 (A20).
COMPUTE temp4=REPLACE(temp3,'36-40','38').
EXECUTE. 

STRING temp5 (A20).
COMPUTE temp5=REPLACE(temp4,',','.').
EXECUTE.

STRING temp6 (A20).
COMPUTE temp6=REPLACE(temp5,'Achtendertig','38').
EXECUTE.

STRING temp7 (A20).
COMPUTE temp7=REPLACE(temp6,'uu','').
EXECUTE.

STRING temp8 (A20).
COMPUTE temp8=REPLACE(temp7,'24 tot 32','28').
EXECUTE.

STRING temp9 (A20).
COMPUTE temp9=REPLACE(temp8,'22 1/2','22.5').
EXECUTE.

*controle.
FREQUENCIES VARIABLES=temp9
  /ORDER=ANALYSIS.

RENAME VARIABLES temp9=werktijd1_T1.
ALTER TYPE werktijd1_T1 (F3.1).

DELETE VARIABLES temp1 temp2 temp3 temp4 temp5 temp6 temp7 temp8.

** ID 4914: 32555 uur moet zijn 32 (ook op T0).
DO IF ID_code=4914.
RECODE werktijd1_T1 (32555=32).
END IF.
EXECUTE.

** missings.
RECODE werktijd1_T1 (SYSMIS=999).
EXECUTE.
MISSING VALUES werktijd1_T1 (999).

*** Q65: werkdagen*************************************************************************************************************************************************************.
* van string naar numeriek.
FREQUENCIES VARIABLES=Q65
  /ORDER=ANALYSIS.

STRING temp1 (A20).
COMPUTE temp1=REPLACE(Q65, 'dagen','').
EXECUTE.

STRING temp2 (A20).
COMPUTE temp2=REPLACE(temp1,'3 tot 4','3.5').
EXECUTE.

STRING temp3 (A20).
COMPUTE temp3=REPLACE(temp2,'3 a 4','3.5').
EXECUTE.

STRING temp4 (A20).
COMPUTE temp4=REPLACE(temp3,'3-4','3.5').
EXECUTE. 

STRING temp5 (A20).
COMPUTE temp5=REPLACE(temp4,',','.').
EXECUTE.

STRING temp6 (A20).
COMPUTE temp6=REPLACE(temp5,'5/6','5.5').
EXECUTE.

STRING temp7 (A20).
COMPUTE temp7=REPLACE(temp6,'Vijf','5').
EXECUTE.

STRING temp8 (A20).
COMPUTE temp8=REPLACE(temp7,'vier','4').
EXECUTE.

STRING temp9 (A20).
COMPUTE temp9=REPLACE(temp8,'5 a 6','5.5').
EXECUTE.

STRING temp10 (A20).
COMPUTE temp10=REPLACE(temp9,'2 presentaties pw','2').
EXECUTE.

*controle.
FREQUENCIES VARIABLES=temp10
  /ORDER=ANALYSIS.

RENAME VARIABLES temp10=werktijd2_T1.
ALTER TYPE werktijd2_T1 (F3.1).

DELETE VARIABLES temp1 temp2 temp3 temp4 temp5 temp6 temp7 temp8 temp9.

** Enkele onmogelijke waarden, nakijken bij T0 en aanpassen indien mogelijk.
DO IF ID_code=3603.
RECODE werktijd1_T1 (0.8=32).
END IF.
DO IF ID_code=5208.
RECODE werktijd2_T1 (52=5).
END IF.
DO IF ID_code=5612.
RECODE werktijd2_T1 (43=4).
END IF.
DO IF ID_code=3701.
RECODE werktijd2_T1 (40=5).
END IF.
DO IF ID_code=5702.
RECODE werktijd2_T1 (32=3).
END IF.
DO IF ID_code=2610.
RECODE werktijd2_T1 (22=5).
END IF.
DO IF ID_code=4917.
RECODE werktijd2_T1 (40=5).
END IF.
DO IF ID_code=4903.
RECODE werktijd1_T1 (40=8).
END IF.
EXECUTE.

VARIABLE LABELS werktijd1_T1 'aantal werkuren per week T1' / werktijd2_T1 'aantal werkdagen per week T1'.

** missings.
RECODE werktijd2_T1 (SYSMIS=999).
EXECUTE.
MISSING VALUES werktijd2_T1 (999).

**Aantal werkuur per dag berekenen.

** 7 personen geven uur per dag op ipv tot aantal uur. Aanpassen.
DO IF (ID_Code=1608 or ID_Code=7104 or ID_Code=1903 or ID_Code=4915 or ID_code=6703 or ID_code=1815 or ID_code=5604).
RECODE werktijd1_T1 (8=40) (9=45).
END IF.
EXECUTE.

COMPUTE werkuur_per_dag_T1=werktijd1_T1 / werktijd2_T1.
EXECUTE.

RECODE werkuur_per_dag_T1 (SYSMIS=999).
EXECUTE. 
MISSING VALUES werkuur_per_dag_T1 (999).
VARIABLE WIDTH werktijd1_T1  werktijd2_T1 werkuur_per_dag_T1 (8).
VARIABLE LEVEL werktijd1_T1  werktijd2_T1 werkuur_per_dag_T1 (SCALE).


*Q67/Q68: pauze******************************************************************************************************************************************************************.
*Q67 van string naar numeriek.

FREQUENCIES VARIABLES=Q67
  /ORDER=ANALYSIS.

STRING temp1 (A20).
COMPUTE temp1=REPLACE(Q67, 'x','').
EXECUTE.

STRING temp2 (A20).
COMPUTE temp2=REPLACE(temp1,'keer','').
EXECUTE.

STRING temp3 (A20).
COMPUTE temp3=REPLACE(temp2,'3/4','4').
EXECUTE.

STRING temp4 (A20).
COMPUTE temp4=REPLACE(temp3,'1 uur','').
EXECUTE. 

STRING temp5 (A20).
COMPUTE temp5=REPLACE(temp4,'45 min','').
EXECUTE.

STRING temp6 (A20).
COMPUTE temp6=REPLACE(temp5,'Half uur','').
EXECUTE.

STRING temp7 (A20).
COMPUTE temp7=REPLACE(temp6,'Drie','3').
EXECUTE.

STRING temp8 (A20).
COMPUTE temp8=REPLACE(temp7,'??','').
EXECUTE.

*controle.
FREQUENCIES VARIABLES=temp8
  /ORDER=ANALYSIS.

RENAME VARIABLES temp8=pauzes_aantal_T1.
ALTER TYPE pauzes_aantal_T1 (F3.0).

DELETE VARIABLES temp1 temp2 temp3 temp4 temp5 temp6 temp7.

*** Enkele cases met aantal pauzes 0 en wel uren en/of minuten. Aantal wordt missing.
DO IF ID_Code= 2701 or ID_Code=6109  or ID_Code=4204  or ID_Code=4708  or ID_Code=1104.
RECODE pauzes_aantal_T1 (0=99).
END IF.
EXECUTE.

RENAME VARIABLES Q68_2_TEXT=pauzes_uren_T1 / Q68_1_TEXT=pauzes_minuten_T1.
VARIABLE LABELS pauzes_aantal_T1 'aantal pauzes op meest recente werkdag T1' pauzes_minuten_T1 'aantal min pauze T1' pauzes_uren_T1 'aantal uur pauze T1'.

** Als wel aantal uur en/of minuten is ingevuld, maar niet aantal keer, dan is aantal keer missing (99).
DO IF  SYSMIS(pauzes_minuten_T1)=0 or SYSMIS(pauzes_uren_T1)=0.
RECODE pauzes_aantal_T1 (SYSMIS=99).
END IF.
EXECUTE.

MISSING VALUES pauzes_aantal_T1 (99).

** als aantal pauzes>0 of missing en aantal minuten is ingevuld en aantal uren niet, dan is aantal uren 0.
DO IF ((pauzes_aantal_T1>0 or MISSING(pauzes_aantal_T1)=1) and pauzes_minuten_T1>0).
RECODE pauzes_uren_T1 (SYSMIS=0).
END IF.
EXECUTE.
** als aantal pauzes>0 of missing en aantal uren is ingevuld en aantal min niet, dan is aantal min 0.
DO IF  ((pauzes_aantal_T1>0 or MISSING(pauzes_aantal_T1)=1) and pauzes_uren_T1>0).
RECODE pauzes_minuten_T1 (SYSMIS=0).
END IF.
EXECUTE.

*** CONTROLE: enkele zeer onwaarschijnlijke aantal uren en minuten!!!.
*correcties.

DO IF (pauzes_minuten_T1=90).
RECODE pauzes_uren_T1 (1.5=0).
END IF.
DO IF (pauzes_minuten_T1=60).
RECODE pauzes_uren_T1 (1=0).
END IF.
DO IF (pauzes_minuten_T1=30).
RECODE pauzes_uren_T1 (0.5=0).
END IF.
DO IF (pauzes_minuten_T1=45).
RECODE pauzes_uren_T1 (0.75=0).
END IF.
EXECUTE.

* soms geven deelnemers meerdere pauzes aan met een totale tijd van 5 minuten. Er wordt vanuit gegaan dat ze 5 minuten per pauze bedoelen:.
DO IF (ID_Code=3901). 
RECODE pauzes_minuten_T1 (5=20).
END IF.
DO IF (ID_Code=5505). 
RECODE pauzes_minuten_T1 (5=15).
END IF.
DO IF (ID_Code=6210). 
RECODE pauzes_minuten_T1 (5=15).
END IF.
DO IF (ID_Code=2703). 
RECODE pauzes_minuten_T1 (5=10).
END IF.
EXECUTE.

* ingevuld 60 uur, 0 minuten. Is waarschijnlijk andersom.
DO IF (ID_Code=1805 or ID_Code=1901). 
RECODE pauzes_minuten_T1 (0=60).
RECODE pauzes_uren_T1 (60=0).
END IF.
EXECUTE.

* ingevuld 10 uur, 1 minuten. Is waarschijnlijk andersom.
DO IF (ID_Code=4304 or ID_code=6307). 
RECODE pauzes_minuten_T1 (1=10).
RECODE pauzes_uren_T1 (10=1).
END IF.
EXECUTE.

* ingevuld 0 uur, 1 minuten. Is waarschijnlijk andersom.
DO IF (ID_Code=4806). 
RECODE pauzes_minuten_T1 (1=0).
RECODE pauzes_uren_T1 (0=1).
END IF.
EXECUTE.

* ingevuld 3 uur en 5 min en onduidelijk aantal keer --> missing.
DO IF (ID_Code=4915). 
RECODE pauzes_aantal_T1 (99=SYSMIS).
RECODE pauzes_minuten_T1 (5=SYSMIS).
RECODE pauzes_uren_T1 (3=SYSMIS).
END IF.
EXECUTE.

* ingevuld 3 uur --> missing.
DO IF (ID_Code=1102). 
RECODE pauzes_minuten_T1 (0=SYSMIS).
RECODE pauzes_uren_T1 (3=SYSMIS).
END IF.
EXECUTE.

* ingevuld 25 uur en 35 min --> missing.
DO IF (ID_Code=1116). 
RECODE pauzes_minuten_T1 (35=SYSMIS).
RECODE pauzes_uren_T1 (25=SYSMIS).
END IF.
EXECUTE.

* ingevuld 10 pauzes, 7,5 uur --> wordt 10x 7.5 min=75 min.
DO IF (ID_Code=1907). 
RECODE pauzes_minuten_T1 (0=75).
RECODE pauzes_uren_T1 (7.50=0).
END IF.
EXECUTE.

* ingevuld 5 uur en 7 min --> missing.
DO IF (ID_Code=4705). 
RECODE pauzes_minuten_T1 (7=SYSMIS).
RECODE pauzes_uren_T1 (5=SYSMIS).
END IF.
EXECUTE.

** als aantal pauzes 0 is, worden missende uren en minuten ook 0.
DO IF (pauzes_aantal_T1=0).
RECODE pauzes_minuten_T1 pauzes_uren_T1 (SYSMIS=0).
END IF.
EXECUTE.

** missings.
RECODE pauzes_aantal_T1 (SYSMIS=99).
RECODE pauzes_uren_T1 pauzes_minuten_T1 (SYSMIS=999).
EXECUTE.
MISSING VALUES pauzes_aantal_T1 (99) pauzes_uren_T1 pauzes_minuten_T1 (999).
VARIABLE LEVEL pauzes_aantal_T1 pauzes_uren_T1 pauzes_minuten_T1 (SCALE).
VARIABLE WIDTH  pauzes_aantal_T1 pauzes_uren_T1 pauzes_minuten_T1 (10).

** Q69 - Q78: ziekteverzuim**************************************************************************************************************************************************************************.
* Q69_2_TEXT van string naar numeriek.

RENAME VARIABLES Q69=ziekteverzuim1_T1 / Q69_TEXT=ziekteverzuim2_T1 / Q70=ziekteverzuim3_T1.
VARIABLE LABELS ziekteverzuim1_T1 'verlof wegens ziekte afgelopen 3 mnd T1' ziekteverzuim2_T1  'aantal dagen verzuim T1' 
ziekteverzuim3_T1 'langer dan 3 maanden verlof wegens ziekte T1'.
VALUE LABELS ziekteverzuim1_T1 1 'nee' 2 'ja'.

* ziekteverzuim2_T1 (aantal dagen) numeriek maken.
FREQUENCIES VARIABLES= ziekteverzuim2_T1
  /ORDER=ANALYSIS.

DO IF (ID_Code=4006). 
RECODE ziekteverzuim2_T1 ('Geen'='').
RECODE ziekteverzuim1_T1 (2=1).
END IF.
EXECUTE.

DO IF (ID_Code=4915). 
RECODE ziekteverzuim2_T1 ('Nee'='').
RECODE ziekteverzuim1_T1 (2=1).
END IF.
EXECUTE.

RECODE ziekteverzuim2_T1 ('twee'='2') ('1.5'='1,5') ('1 0'='10') ('1x'='1') ('2 dagen'='2') ('16 dagen'='16') ('Volledig ziekgemeld vanwege stressklachten'='60')
 (ELSE=COPY).
EXECUTE.
FREQUENCIES VARIABLES= ziekteverzuim2_T1
  /ORDER=ANALYSIS.
ALTER TYPE ziekteverzuim2_T1 (F3.1).

*Indien ziekteverzuim1 =1 (nee), dan moet ziekteverzuim2 leeg zijn.
USE ALL.
COMPUTE filter_$=(ziekteverzuim1_T1=1).
VARIABLE LABELS filter_$ 'ziekteverzuim1_T1=1 (FILTER)'.
VALUE LABELS filter_$ 0 'Not Selected' 1 'Selected'.
FORMATS filter_$ (f1.0).
FILTER BY filter_$.
EXECUTE.
FREQUENCIES VARIABLES=ziekteverzuim2_T1
  /ORDER=ANALYSIS.
USE ALL.


*** Langer dan 3 mnd ziek ************************************************************************************************************************************************.

* Q71 van string naar date.
STRING temp1 (A20).
COMPUTE temp1=REPLACE(Q71,'-','').
EXECUTE.

STRING  temp2 (A20).
COMPUTE temp2=REPLACE(temp1,'/','').
EXECUTE.

STRING  temp3 (A20).
COMPUTE temp3=REPLACE(temp2,'jan','01').
EXECUTE.

COMPUTE aantalplaatsen=LENGTH(temp3).
EXECUTE.
FORMATS aantalplaatsen (F1.0).

DO IF aantalplaatsen=8.
* Date and Time Wizard:.
COMPUTE  ziekteverzuim4_T1=date.dmy(number(substr(ltrim(temp3),1,2),f2.0), number(substr(ltrim(temp3),3,2),f2.0), number(substr(ltrim(temp3),5),f4.0)).
VARIABLE LEVEL   ziekteverzuim4_T1 (SCALE).
FORMATS  ziekteverzuim4_T1 (DATE11).
VARIABLE WIDTH   ziekteverzuim4_T1(11).
END IF.
EXECUTE.

VARIABLE LABELS  ziekteverzuim4_T1 'datum ziekmelding T1'.
DELETE VARIABLES  temp1 temp2 temp3 aantalplaatsen.


*Q71 (datum ziekmelding) moet minimaal 2 maanden (8 weken) voor invuldatum liggen.
* Date and Time Wizard: d_datum_ziekmelding_invuldatum.
COMPUTE  d_datum_ziekmelding_invuldatum_T1=DATEDIF( ziekteverzuim4_T1, Invuldatum_T1, "weeks").
VARIABLE LABELS  d_datum_ziekmelding_invuldatum_T1 "verschil in weken invuldatum-ziekmelddatum T1".
VARIABLE LEVEL  d_datum_ziekmelding_invuldatum_T1 (SCALE).
FORMATS  d_datum_ziekmelding_invuldatum_T1 (F5.0).
VARIABLE WIDTH  d_datum_ziekmelding_invuldatum_T1(5).
EXECUTE.
FREQUENCIES VARIABLES=d_datum_ziekmelding_invuldatum_T1
  /ORDER=ANALYSIS.

** aanpassingen.
** 3414	Langdurig ziek sinds 5 weken voor invullen vragenlijst, 30 dagen ziek Gegevens langdurig weghalen, 30 dagen ziek.
DO IF ID_code=3414.
RECODE ziekteverzuim3_T1 (2=1).
RECODE Q71 ('23/jan/2017'=' ').
COMPUTE ziekteverzuim4_T1=$SYSMIS.
END IF.
** 2909	Langdurig ziek sinds 2 weken voorinvullen vragenlijst. Ook 4 dagen ziek en 10 dagen ziek op werk. OP T2 geen ziekmelding  Gegevens langdurig weghalen, 4 dagen ziek.
DO IF ID_code=2909.
RECODE ziekteverzuim3_T1 (2=1).
RECODE Q71 ('14/12/2016'=' ').
COMPUTE ziekteverzuim4_T1=$SYSMIS.
END IF.
** 6703	Langdurig ziek sinds 4 weken voor invullen vragenlijst. Ook 15 dagen ziek en 10 dagen ziek op werk. T2: 15 dagen ziek en 25 ziek op werk, niet langdurig 
 Gegevens langdurig weghalen, 15 dagen ziek.
DO IF ID_code=6703.
RECODE ziekteverzuim3_T1 (2=1).
RECODE Q71 ('10-04-2017'=' ').
COMPUTE ziekteverzuim4_T1=$SYSMIS.
END IF.
EXECUTE.

* Ziekteverzuim1_T1 (=afgelopen 3 mnd) hercoderen: 1=nee, 2 =ja , 3=langdurig (dus indien ziekteverzuim3_T0=2).
DO IF ziekteverzuim3_T1=2.
RECODE ziekteverzuim1_T1 (2=3).
END IF.
VALUE LABELS ziekteverzuim1_T1 1 'nee' 2 'ja' 3 'langdurig >3 mnd' .
* Indien ziekteverzuim is langdurig: aantal dagen missing maken (is niet van belang, advies Sylvia).
DO IF ziekteverzuim3_T1=2.
COMPUTE  ziekteverzuim2_T1=$SYSMIS.
END IF.
EXECUTE.

* 3213	geen datum ingevuld, kortdurend verzuim missing (dus alleen langdurig verzuim ja, en ziek op werk: nee). Op T0 geen verzuim, T2 missing.--> ziekteverzuim1_T1 93.
DO IF ID_code=3213.
RECODE ziekteverzuim1_T1 (MISSING=3) (9=3).
COMPUTE ziekteverzuim2_T1=888.
END IF.

* Missing en nvt toevoegen.
DO IF (ziekteverzuim1_T1=1).
RECODE ziekteverzuim2_T1 (SYSMIS=888).
RECODE ziekteverzuim3_T1 (SYSMIS=1).
END IF.
DO IF (ziekteverzuim1_T1=2).
RECODE ziekteverzuim2_T1 (SYSMIS=999).
END IF.
DO IF (ziekteverzuim1_T1=3).
RECODE ziekteverzuim2_T1 (SYSMIS=888).
END IF.
RECODE ziekteverzuim1_T1 (SYSMIS=9).
RECODE ziekteverzuim3_T1 (SYSMIS=9).
DO IF (ziekteverzuim1_T1=9).
RECODE ziekteverzuim2_T1 (SYSMIS=999).
END IF.
EXECUTE.

MISSING VALUES ziekteverzuim1_T1 ziekteverzuim3_T1 (9) ziekteverzuim2_T1 (888,999).
VARIABLE LEVEL  ziekteverzuim1_T1 ziekteverzuim3_T1 (NOMINAL) ziekteverzuim2_T1 (SCALE).

*Als afwezig=ja en aantal dagen =0.  Aantal dagen wordt 1 (conservatieve schatting).
DO IF ziekteverzuim1_T1=2.
RECODE ziekteverzuim2_T1 (0=1).
END IF.
EXECUTE.

*** Q72 t/m 74: ziek op het werk************************************************************************************************************************************.
RENAME VARIABLES Q72=ziekteverzuim5_T1 / Q73=ziekteverzuim6_T1 / Q74_1=ziekteverzuim7_T1.
VARIABLE LABELS ziekteverzuim5_T1 'ziek op het werk afgelopen 2 maanden T1' ziekteverzuim6_T1 'ziek op werk: aantal dagen T1'
ziekteverzuim7_T1 'ziek op werk: hoeveel werk verricht T1'.
FORMATS ziekteverzuim6_T1 (F3.0).

*Indien ziekteverzuim5 =1 (nee), dan moeten ziekteverzuim6 en 7  leeg zijn.
USE ALL.
COMPUTE filter_$=(ziekteverzuim5_T1=1).
VARIABLE LABELS filter_$ 'ziekteverzuim5_T0=1 (FILTER)'.
VALUE LABELS filter_$ 0 'Not Selected' 1 'Selected'.
FORMATS filter_$ (f1.0).
FILTER BY filter_$.
EXECUTE.
FREQUENCIES VARIABLES=ziekteverzuim6_T1 ziekteverzuim7_T1
  /ORDER=ANALYSIS.
USE ALL.

* =Indien ziekteverzuim3 (langer dan 2 mnd ziek) ja is, kan ziekteverzuim5 niet ja zijn (want ze hebben niet gewerkt).
CROSSTABS
  /TABLES=ziekteverzuim3_T1 BY ziekteverzuim5_T1
  /FORMAT=AVALUE TABLES
  /CELLS=COUNT
  /COUNT ROUND CELL.

* Komt toch voor: in dat geval 'ziek op werk' verwijderen.
DO IF ID_code=6007 or ID_Code=2411.
RECODE ziekteverzuim5_T1 (2=1).
COMPUTE ziekteverzuim6_T1=888.
COMPUTE ziekteverzuim7_T1=888.
END IF.

* Controle ziekteverzuim6 (aantal werkdagen).
FREQUENCIES VARIABLES=ziekteverzuim6_T1
 /ORDER=ANALYSIS.
*Als aantal dagen 0 is --> wordt 1 (conservatieve schatting).
DO IF ziekteverzuim5_T1=2.
RECODE ziekteverzuim6_T1 (0=1).
END IF.

* ziekteverzuim7_T0 rare codering: {1, ik kon op deze dagen niets doen: 0}...tot '11, ik kon net zoveel doen als normaal: 10.
*Hercoderen.
RECODE ziekteverzuim7_T1 (1=0) (2=1) (3=2) (4=3) (5=4) (6=5) (7=6) (8=7) (9=8) (10=9) (11=10).
EXECUTE.
VALUE LABELS ziekteverzuim7_T1.

* Indien wel ziek op werk en aantal dagenis missing: 1 (conservatieve schatting).
DO IF (ziekteverzuim5_T1=2).
RECODE ziekteverzuim6_T1 (SYSMIS=1).
END IF.

*ID 6012.
DO IF ID_Code=6012.
RECODE ziekteverzuim5_T1 (SYSMIS=1).
RECODE ziekteverzuim6_T1 (0=888).
RECODE ziekteverzuim7_T1 (10=888).
END IF.

*ID 5201.
DO IF ID_Code=5201.
RECODE ziekteverzuim7_T1 (0=999).
END IF.

* Missing en nvt toevoegen.
DO IF (ziekteverzuim5_T1=1).
RECODE ziekteverzuim6_T1 (SYSMIS=888).
RECODE ziekteverzuim7_T1 (SYSMIS=888).
END IF.
DO IF (ziekteverzuim5_T1=2).
RECODE ziekteverzuim6_T1 (SYSMIS=999).
RECODE ziekteverzuim7_T1 (SYSMIS=999).
END IF.
RECODE ziekteverzuim5_T1 (SYSMIS=9).
DO IF (ziekteverzuim5_T1=9).
RECODE ziekteverzuim6_T1 (SYSMIS=999).
RECODE ziekteverzuim7_T1 (SYSMIS=999).
END IF.
EXECUTE.

MISSING VALUES ziekteverzuim5_T1 (9) ziekteverzuim6_T1 ziekteverzuim7_T1 (888,999).
VARIABLE LEVEL ziekteverzuim5_T1 (NOMINAL) ziekteverzuim6_T1 ziekteverzuim7_T1 (SCALE).

*** Q76 t/m 78: ziek mbt onbetaald werk************************************************************************************************************************************.
RENAME VARIABLES Q76=ziekteverzuim8_T1 / Q77=ziekteverzuim9_T1 / Q78=ziekteverzuim10_T1.
VARIABLE LABELS ziekteverzuim8_T1 'verzuim onbetaald werk T1' ziekteverzuim9_T1 'verzuim onbetaald aantal dagen T1' ziekteverzuim10_T1 'verzuim onbetaald uren vervanging T1'.
FORMATS ziekteverzuim9_T1 (F3.0).

*Indien ziekteverzuim8 =1 (nee), dan moeten ziekteverzuim9 en 10  leeg zijn.
USE ALL.
COMPUTE filter_$=(ziekteverzuim8_T1=1).
VARIABLE LABELS filter_$ 'ziekteverzuim8_T1=1 (FILTER)'.
VALUE LABELS filter_$ 0 'Not Selected' 1 'Selected'.
FORMATS filter_$ (f1.0).
FILTER BY filter_$.
EXECUTE.
FREQUENCIES VARIABLES=ziekteverzuim9_T1 ziekteverzuim10_T1
  /ORDER=ANALYSIS.
USE ALL.

* Controle ziekteverzuim9_T1 (aantal dagen).
FREQUENCIES VARIABLES=ziekteverzuim9_T1
  /ORDER=ANALYSIS.

* Controle ziekteverzuim10_T1 (aantal uur). 
FREQUENCIES VARIABLES=ziekteverzuim10_T1
  /ORDER=ANALYSIS.
* aantal onwaarschijnlijk, aanpassen:.
DO IF ID_Code=1405.
RECODE ziekteverzuim10_T1 (60=1).
END IF.
DO IF ID_Code=6703.
RECODE ziekteverzuim10_T1 (50=5).
END IF.
DO IF ID_Code=3916.
RECODE ziekteverzuim10_T1 (40=2.5).
END IF.
DO IF ID_Code=5312.
RECODE ziekteverzuim10_T1 (40=2).
END IF.
DO IF ID_Code=1901.
RECODE ziekteverzuim10_T1 (40=0.7).
END IF.
DO IF ID_Code=5606.
RECODE ziekteverzuim10_T1 (28=2).
END IF.
DO IF ID_Code=7109.
RECODE ziekteverzuim10_T1 (20=6.7).
END IF.
DO IF ID_Code=4902.
RECODE ziekteverzuim10_T1 (20=0.3).
END IF.
DO IF ID_Code=2504.
RECODE ziekteverzuim10_T1 (16=4).
END IF.
DO IF ID_Code=3603.
RECODE ziekteverzuim10_T1 (16=2).
END IF.
DO IF ID_Code=5111.
RECODE ziekteverzuim10_T1 (15=3).
END IF.
DO IF ID_Code=5204.
RECODE ziekteverzuim10_T1 (15=1.5).
END IF.
DO IF ID_Code=1704.
RECODE ziekteverzuim10_T1 (15=1).
END IF.
DO IF ID_Code=6204.
RECODE ziekteverzuim10_T1 (14=2).
END IF.
DO IF ID_Code=3908.
RECODE ziekteverzuim10_T1 (12=1).
END IF.
DO IF ID_Code=3904.
RECODE ziekteverzuim10_T1 (11=1.8).
END IF.
DO IF ID_Code=7104.
RECODE ziekteverzuim10_T1 (10=2).
END IF.
DO IF ID_Code=5703.
RECODE ziekteverzuim10_T1 (10=1).
END IF.
DO IF ID_Code=4704.
RECODE ziekteverzuim10_T1 (10=2).
END IF.
DO IF ID_Code=4905.
RECODE ziekteverzuim10_T1 (8=2).
END IF.
DO IF ID_Code=5506.
RECODE ziekteverzuim9_T1 (SYSMIS=10).
RECODE ziekteverzuim10_T1 (10=1).
END IF.
EXECUTE.

DO IF ID_Code=1115.
RECODE ziekteverzuim10_T1 (280=999).
END IF.
DO IF ID_Code=7102.
RECODE ziekteverzuim10_T1 (140=999).
END IF.
DO IF ID_Code=1107.
RECODE ziekteverzuim10_T1 (100=999).
END IF.
DO IF ID_Code=7005.
RECODE ziekteverzuim10_T1 (72=999).
END IF.
DO IF ID_Code=3302.
RECODE ziekteverzuim10_T1 (30=999).
END IF.
DO IF ID_Code=5308.
RECODE ziekteverzuim10_T1 (8=999).
END IF.
EXECUTE.

** indien ja en aantal uur en aantal dagen= 0 of missing ; veranderen in 1 (conservatieve schatting).
DO IF ziekteverzuim8_T1=2.
RECODE ziekteverzuim9_T1 ziekteverzuim10_T1 (0=1) (SYSMIS=1).
END IF.
EXECUTE.

* Missing en nvt toevoegen.
DO IF (ziekteverzuim8_T1=1).
RECODE ziekteverzuim9_T1 (SYSMIS=888).
RECODE ziekteverzuim10_T1 (SYSMIS=888).
END IF.
DO IF (ziekteverzuim8_T1=2).
RECODE ziekteverzuim9_T1 (SYSMIS=999).
RECODE ziekteverzuim10_T1 (SYSMIS=999).
END IF.
RECODE ziekteverzuim8_T1 (SYSMIS=9).
DO IF (ziekteverzuim8_T1=9).
RECODE ziekteverzuim9_T1 (SYSMIS=999).
RECODE ziekteverzuim10_T1 (SYSMIS=999).
END IF.
EXECUTE.

MISSING VALUES ziekteverzuim8_T1 (9) ziekteverzuim9_T1 ziekteverzuim10_T1 (888,999).
VARIABLE LEVEL ziekteverzuim8_T1 (NOMINAL) ziekteverzuim9_T1 ziekteverzuim10_T1 (SCALE).

********************************************************************************************************************************************************************************
***ZORGKOSTEN*************************************************************************************************************************************************************
*********************************************************************************************************************************************************************************
** eerst helemaal runnen, daarna pas syntax kosten zorggebruik runnen.



*** Q82_1 t/m _14 ******************************************************************************************************************************************************.
RENAME VARIABLES Q82_1_TEXT=consult1_T1 / Q82_2_TEXT=consult2_T1 /  Q82_3_TEXT=consult3_T1 /  Q82_4_TEXT=consult4_T1 /  Q82_5_TEXT=consult5_T1 /  
 Q82_6_TEXT=consult6_T1 /  Q82_7_TEXT=consult7_T1 /  Q82_8_TEXT=consult8_T1 /  Q82_9_TEXT=consult9_T1 /  Q82_10_TEXT=consult10_T1 /  Q82_11_TEXT=consult11_T1 / 
 Q82_12_TEXT=consult12_T1 /  Q82_13_TEXT=consult13_T1 /  Q82_14_TEXT=consult14_T1 .

VARIABLE LABELS consult1_T1 'consult HA T1' 
consult2_T1 'consult POH T1' 
consult3_T1 'consult maatsch. werker T1' 
consult4_T1 'consult bedrijfsarts T1'
consult5_T1 'consult ergotherapeut T1' 
consult6_T1 'consult diëtist T1' 
consult7_T1 'consult stoppen met roken begeleider T1'  
consult8_T1 'consult tandarts T1' 
consult9_T1 'consult logopedist T1' 
consult10_T1 'consult homeopaat etc T1'
consult11_T1 'consult fysio etc T1' 
consult12_T1 'consult psycholoog etc T1'  
consult13_T1 'consult huidtherapeut/mondhygienist T1' 
consult14_T1 'consult manicure/pedicure T1'. 
FORMATS  consult1_T1 to consult14_T1 (F2.0).

** Als er minimaal 1 is ingevuld en de rest missing, zijn die missings 0 (geen consult).
DO IF (NVALID(consult1_T1,consult2_T1,consult3_T1,consult4_T1,consult5_T1,consult6_T1,consult7_T1,
    consult8_T1,consult9_T1,consult10_T1,consult11_T1,consult12_T1,consult13_T1,consult14_T1)>=1).
RECODE consult1_T1 consult2_T1 consult3_T1 consult4_T1 consult5_T1 consult6_T1 consult7_T1 consult8_T1 consult9_T1 
    consult10_T1 consult11_T1 consult12_T1 consult13_T1 consult14_T1 (SYSMIS=0).
END IF.
EXECUTE.

** Als er helemaal niets is ingevuld, maar de vragenlijst is wel  'gefinished', dan zijn de missings 0 (geen consult).
DO IF (NVALID(consult1_T1,consult2_T1,consult3_T1,consult4_T1,consult5_T1,consult6_T1,consult7_T1,
    consult8_T1,consult9_T1,consult10_T1,consult11_T1,consult12_T1,consult13_T1,consult14_T1)=0 and  Finished=1).
RECODE consult1_T1 consult2_T1 consult3_T1 consult4_T1 consult5_T1 consult6_T1 consult7_T1 consult8_T1 consult9_T1 
    consult10_T1 consult11_T1 consult12_T1 consult13_T1 consult14_T1 (SYSMIS=0).
END IF.
EXECUTE.

** Als er helemaal niets is ingevuld, en de vragenlijst is niet  'gefinished', dan zijn de missings 999 (echt missing).
DO IF (NVALID(consult1_T1,consult2_T1,consult3_T1,consult4_T1,consult5_T1,consult6_T1,consult7_T1,
    consult8_T1,consult9_T1,consult10_T1,consult11_T1,consult12_T1,consult13_T1,consult14_T1)=0 and  Finished=0).
RECODE consult1_T1 consult2_T1 consult3_T1 consult4_T1 consult5_T1 consult6_T1 consult7_T1 consult8_T1 consult9_T1 
    consult10_T1 consult11_T1 consult12_T1 consult13_T1 consult14_T1 (SYSMIS=999).
END IF.
EXECUTE.
MISSING VALUES consult1_T1 consult2_T1 consult3_T1 consult4_T1 consult5_T1 consult6_T1 consult7_T1 consult8_T1 consult9_T1 
    consult10_T1 consult11_T1 consult12_T1 consult13_T1 consult14_T1 (999).

**Indien de verkorte vragenlijst is ingevuld , is alleen consult 7 (stoppen met roken begeleider) ingevuld. Rest wordt missing.
DO IF (papier_T1=2).
RECODE consult1_T1 consult2_T1 consult3_T1 consult4_T1 consult5_T1 consult6_T1 consult8_T1 consult9_T1 
    consult10_T1 consult11_T1 consult12_T1 consult13_T1 consult14_T1 (0=999).
END IF.
EXECUTE.

** extreme waarden aanpassen.
DO IF ID_Code=7114.
RECODE consult11_T1 (180=18).
END IF.
DO IF ID_Code=2307.
RECODE consult11_T1 (120=12).
END IF.
EXECUTE.

*** Q83 Thuiszorg *******************************************************************************************************************************************************.
RENAME VARIABLES Q83=thuiszorg_T1 / Q84_1=thuiszorg_hh_T1 / Q84_2=thuiszorg_verzorging_T1 / Q84_3=thuiszorg_verpleging_T1 / 
Q85_X1_TEXT=thuiszorg_hh_weken_T1 / Q85_X2_TEXT=thuiszorg_verzorging_weken_T1 / Q85_X3_TEXT=thuiszorg_verpleging_weken_T1 / 
Q86_X1_TEXT=thuiszorg_hh_uur_T1 / Q86_X2_TEXT=thuiszorg_verzorging_uur_T1 / Q86_X3_TEXT=thuiszorg_verpleging_uur_T1. 

VARIABLE LABELS thuiszorg_T1 'thuiszorg ja/nee T1'
thuiszorg_hh_T1 'thuiszorg huishouden ja/nee T1'
thuiszorg_verzorging_T1 'thuiszorg verzorging ja/nee T1'
thuiszorg_verpleging_T1 'thuiszorg verpleging ja/nee T1'
thuiszorg_hh_weken_T1 'thuiszorg huishouden aant weken T1'
thuiszorg_verzorging_weken_T1 'thuiszorg verzorging aant weken T1'
thuiszorg_verpleging_weken_T1  'thuiszorg verpleging aant weken T1'
thuiszorg_hh_uur_T1 'thuiszorg huishouden aant uur/wk T1'
thuiszorg_verzorging_uur_T1 'thuiszorg verzorging aant uur/wk T1'
thuiszorg_verpleging_uur_T1 'thuiszorg verpleging aant uur/wk T1'. 

VALUE LABELS thuiszorg_T1 1 'nee' 2 'ja'.

*Indien thuiszorg_T0 =1 (nee), dan moeten thuiszorg_hh_T0, thuiszorg_verzorging_T0 en thuiszorg_verpleging_T0 0 zijn.
USE ALL.
COMPUTE filter_$=( thuiszorg_T1=1).
VARIABLE LABELS filter_$ ' thuiszorg_T1=1 (FILTER)'.
VALUE LABELS filter_$ 0 'Not Selected' 1 'Selected'.
FORMATS filter_$ (f1.0).
FILTER BY filter_$.
EXECUTE.
FREQUENCIES VARIABLES= thuiszorg_hh_T1 thuiszorg_verzorging_T1 thuiszorg_verpleging_T1 
  /ORDER=ANALYSIS.
USE ALL.

* visueel in database nakijken: als thuiszorg_T0 ergens 1 is, dan moet er ook wat staan bij de bijbehorende weken en uren. (descending sorteren op thuiszorg_T0)

*aantal weken kan max 13 zijn.
* controle of er geen tekst is ingevuld.
FREQUENCIES VARIABLES=thuiszorg_hh_weken_T1 thuiszorg_verzorging_weken_T1 thuiszorg_verpleging_weken_T1  
thuiszorg_hh_uur_T1 thuiszorg_verzorging_uur_T1 thuiszorg_verpleging_uur_T1 
  /ORDER=ANALYSIS.

* omzetten string naar numeriek.
ALTER TYPE thuiszorg_hh_weken_T1 thuiszorg_verzorging_weken_T1 thuiszorg_verpleging_weken_T1  (F2.0).
ALTER TYPE thuiszorg_hh_uur_T1 thuiszorg_verzorging_uur_T1 thuiszorg_verpleging_uur_T1 (F3.1).


**Indien thuiszorg_T1 =1 (nee), rest hercoderen naar 0.
DO IF thuiszorg_T1=1.
RECODE thuiszorg_hh_weken_T1 thuiszorg_verzorging_weken_T1 thuiszorg_verpleging_weken_T1
 thuiszorg_hh_uur_T1 thuiszorg_verzorging_uur_T1 thuiszorg_verpleging_uur_T1 (SYSMIS=0).
END IF.
DO IF SYSMIS(thuiszorg_hh_T1) =1 and thuiszorg_T1=2.
RECODE thuiszorg_hh_T1 thuiszorg_hh_weken_T1  thuiszorg_hh_uur_T1 (SYSMIS=0).
END IF.
DO IF SYSMIS(thuiszorg_verzorging_T1)=1  and thuiszorg_T1=2.
RECODE thuiszorg_verzorging_T1 thuiszorg_verzorging_weken_T1  thuiszorg_verzorging_uur_T1 (SYSMIS=0).
END IF.
DO IF SYSMIS(thuiszorg_verpleging_T1)=1  and thuiszorg_T1=2.
RECODE thuiszorg_verpleging_T1 thuiszorg_verpleging_weken_T1  thuiszorg_verpleging_uur_T1 (SYSMIS=0).
END IF.
DO IF thuiszorg_T1=1.
RECODE thuiszorg_hh_T1 thuiszorg_verzorging_T1 thuiszorg_verpleging_T1  (SYSMIS=0).
END IF.
EXECUTE. 

** missings toevoegen.
RECODE thuiszorg_T1 (SYSMIS=9).
DO IF (thuiszorg_T1 =9).
RECODE thuiszorg_hh_T1 thuiszorg_verzorging_T1 thuiszorg_verpleging_T1  (SYSMIS=9).
RECODE  thuiszorg_hh_weken_T1 thuiszorg_verzorging_weken_T1 thuiszorg_verpleging_weken_T1
 thuiszorg_hh_uur_T1 thuiszorg_verzorging_uur_T1 thuiszorg_verpleging_uur_T1 (SYSMIS=999).
END IF.
EXECUTE.

MISSING VALUES  thuiszorg_T1 thuiszorg_hh_T1 thuiszorg_verzorging_T1 thuiszorg_verpleging_T1  (9)
thuiszorg_hh_weken_T1 thuiszorg_verzorging_weken_T1 thuiszorg_verpleging_weken_T1
 thuiszorg_hh_uur_T1 thuiszorg_verzorging_uur_T1 thuiszorg_verpleging_uur_T1 (999).

*** Q87: gebruik nicotinevervangers afgelopen 2 mnd ****************************************************************************************************************************.

RENAME VARIABLES Q87=nicotinevervangers_T1 / Q88_1=nicotinepleisters_T1 / Q88_2=nicotinekauwgom_T1 / Q88_3=nicotine_microtabs_T1 / Q88_4=nicotine_zuigtabletten_T1 /
Q88_5=nicotine_mondspray_T1 / Q88_6=nicotine_inhaler_T1 / Q88_7=nicotine_anders_T1 / Q88_7_TEXT=nicotine_anders_nl_T1. 

VARIABLE LABELS nicotinevervangers_T1 'nicotinevervangers: ja/nee' /
nicotinepleisters_T1 'nicotinevervangers: pleister ja/nee' /
nicotinekauwgom_T1 'nicotinevervangers: kauwgom ja/nee' /
nicotine_microtabs_T1 'nicotinevervangers: microtabs ja/nee' /
nicotine_zuigtabletten_T1  'nicotinevervangers: zuigtabletten ja/nee' /
nicotine_mondspray_T1 'nicotinevervangers: mondspray ja/nee' /
nicotine_inhaler_T1 'nicotinevervangers: inhaler ja/nee' /
nicotine_anders_T1 'nicotinevervangers: anders ja/nee' /
nicotine_anders_nl_T1 'nicotinevervangers: anders nl.'.

VALUE LABELS nicotinevervangers_T1 2 'ja' 1 'nee' /nicotinepleisters_T1 nicotinekauwgom_T1 nicotine_microtabs_T1 nicotine_zuigtabletten_T1 
nicotine_mondspray_T1 nicotine_inhaler_T1 nicotine_anders_T1  0 'nee'1 'ja'.

* Indien nicotinevervangers_T1 niet missing is, moeten de verschillende soorten missings 0 zijn.
DO IF (nicotinevervangers_T1=1 or nicotinevervangers_T1=2).
RECODE nicotinepleisters_T1 nicotinekauwgom_T1 nicotine_microtabs_T1 nicotine_zuigtabletten_T1 nicotine_mondspray_T1 nicotine_inhaler_T1 nicotine_anders_T1 (SYSMIS=0).
END IF.
EXECUTE.

* missing toevoegen (rest van sysmis is missing).
RECODE nicotinevervangers_T1 nicotinepleisters_T1 nicotinekauwgom_T1 nicotine_microtabs_T1 nicotine_zuigtabletten_T1 nicotine_mondspray_T1 nicotine_inhaler_T1 
nicotine_anders_T1 (SYSMIS=9).
MISSING VALUES nicotinevervangers_T1 nicotinepleisters_T1 nicotinekauwgom_T1 nicotine_microtabs_T1 nicotine_zuigtabletten_T1 nicotine_mondspray_T1 nicotine_inhaler_T1 
nicotine_anders_T1 (9).
EXECUTE.


RENAME VARIABLES Q106_X1_TEXT=nicotinepleisters_stuks_T1 / Q106_X2_TEXT=nicotinekauwgom_stuks_T1 / Q106_X3_TEXT=nicotine_microtabs_stuks_T1 / 
Q106_X4_TEXT=nicotine_zuigtabletten_stuks_T1 / Q106_X5_TEXT=nicotine_mondspray_keer_T1 / Q106_X6_TEXT=nicotine_inhaler_keer_T1 / 
Q106_X7_TEXT=nicotine_anders_stuks_T1 / 
Q107_X1_TEXT=nicotinepleisters_dagen_T1 / Q107_X2_TEXT=nicotinekauwgom_dagen_T1 / Q107_X3_TEXT=nicotine_microtabs_dagen_T1 / 
Q107_X4_TEXT=nicotine_zuigtabletten_dagen_T1 / Q107_X5_TEXT=nicotine_mondspray_dagen_T1 / Q107_X6_TEXT=nicotine_inhaler_dagen_T1 / 
Q107_X7_TEXT=nicotine_anders_dagen_T1.

VARIABLE LABELS nicotinepleisters_stuks_T1 'nicotinevervangers: pleister aantal stuks/dag' /
nicotinekauwgom_stuks_T1  'nicotinevervangers: kauwgom aantal stuks/dag' /
nicotine_microtabs_stuks_T1 'nicotinevervangers: microtabs aantal stuks/dag' /
nicotine_zuigtabletten_stuks_T1 'nicotinevervangers: zuigtabletten aantal stuks/dag' /
nicotine_mondspray_keer_T1 'nicotinevervangers: mondspray aantal keer/dag' /
nicotine_inhaler_keer_T1 'nicotinevervangers: inhaler aantal keer/dag' /
nicotine_anders_stuks_T1 'nicotinevervangers: anders aantal stuks/dag'.

VARIABLE LABELS nicotinepleisters_dagen_T1  'nicotinevervangers: pleister aantal dagen' /
nicotinekauwgom_dagen_T1 'nicotinevervangers: kauwgom aantal dagen' /
nicotine_microtabs_dagen_T1 'nicotinevervangers: microtabs aantal dagen' /
nicotine_zuigtabletten_dagen_T1 'nicotinevervangers: zuigtabletten aantal dagen' /
nicotine_mondspray_dagen_T1 'nicotinevervangers: mondspray aantal dagen' /
nicotine_inhaler_dagen_T1 'nicotinevervangers: inhaler aantal dagen' /
nicotine_anders_dagen_T1 'nicotinevervangers: anders aantal dagen'.

VARIABLE WIDTH nicotinepleisters_stuks_T1 nicotinekauwgom_stuks_T1 nicotine_microtabs_stuks_T1 
    nicotine_zuigtabletten_stuks_T1 nicotine_mondspray_keer_T1 nicotine_inhaler_keer_T1 
    nicotine_anders_stuks_T1 nicotinepleisters_dagen_T1 nicotinekauwgom_dagen_T1 
    nicotine_microtabs_dagen_T1 nicotine_zuigtabletten_dagen_T1 nicotine_mondspray_dagen_T1 
    nicotine_inhaler_dagen_T1 nicotine_anders_dagen_T1 (10).

** antwoorden in categorie 'anders' gelijk maken.
RECODE nicotine_anders_nl_T1 ('zybann'='Zyban').
RECODE nicotine_anders_nl_T1 ('Sampex'='Champix').
RECODE nicotine_anders_nl_T1 ('Chimpics'='Champix').
RECODE nicotine_anders_nl_T1 ('Champix medicijn'='Champix').
RECODE nicotine_anders_nl_T1 ('champix'='Champix').
RECODE nicotine_anders_nl_T1 ('Champex'='Champix').
RECODE nicotine_anders_nl_T1 ('champic'='Champix').
RECODE nicotine_anders_nl_T1 ('esmoker'='E sigaret').
RECODE nicotine_anders_nl_T1 ('E-sigeret'='E sigaret').
RECODE nicotine_anders_nl_T1 ('E-sigaret'='E sigaret').
RECODE nicotine_anders_nl_T1 ('e-sigaret'='E sigaret').
RECODE nicotine_anders_nl_T1 ('e sigaret'='E sigaret').
RECODE nicotine_anders_nl_T1 ('E smoker'='E sigaret').
RECODE nicotine_anders_nl_T1 ('e smoker'='E sigaret').
EXECUTE.

* aantal stuks en aantal dagen van string naar numeriek.
* controle geen tekst.
FREQUENCIES VARIABLES= nicotinepleisters_stuks_T1 nicotinekauwgom_stuks_T1 nicotine_microtabs_stuks_T1 
    nicotine_zuigtabletten_stuks_T1 nicotine_mondspray_keer_T1 nicotine_inhaler_keer_T1 
    nicotine_anders_stuks_T1 nicotinepleisters_dagen_T1 nicotinekauwgom_dagen_T1 
    nicotine_microtabs_dagen_T1 nicotine_zuigtabletten_dagen_T1 nicotine_mondspray_dagen_T1 
    nicotine_inhaler_dagen_T1 nicotine_anders_dagen_T1
  /ORDER=ANALYSIS.

RECODE nicotinepleisters_stuks_T1 ('0,5'='1').
RECODE nicotinepleisters_stuks_T1 ('1/2'='1').
* 131 ->1 omdat bij aantal dagen 31 staat, dus typefout.
RECODE nicotinepleisters_stuks_T1 ('131'='1'). 
* 7 ->1 omdat aantal dagen=7 en 7 per dag is onwaarschijnlijk.
RECODE nicotinepleisters_stuks_T1 ('7'='1'). 
* 8 ->1 omdat aantal dagen=8 en 8 per dag is onwaarschijnlijk.
RECODE nicotinepleisters_stuks_T1 ('8'='1'). 
* 10 ->1 omdat aantal dagen=10 en 10 per dag is onwaarschijnlijk.
RECODE nicotinepleisters_stuks_T1 ('10'='1'). 
* 15 ->1 omdat aantal dagen=15 en 15 per dag is onwaarschijnlijk.
RECODE nicotinepleisters_stuks_T1 ('15'='1'). 
* 18 ->1 omdat aantal dagen=18 en 18 per dag is onwaarschijnlijk.
RECODE nicotinepleisters_stuks_T1 ('18'='1').
RECODE nicotine_microtabs_stuks_T1 ('2/3'='2').
RECODE nicotine_microtabs_stuks_T1 ('2)'='2').

* bij stuks1: 'beiden volgens de voorschriften geprobeerd, maar was niet lekker.' Beide 1 maken.
DO IF ID_code=2013.
RECODE nicotinepleisters_stuks_T1 ('beiden volgens de voorschriften geprobeerd, maar was niet lekker.'='1').
RECODE nicotinekauwgom_stuks_T1 (''='1').
END IF.


** 7 juni en nog: invuldatum 12 juli dus 25 dagen.
RECODE nicotinepleisters_dagen_T1 ('7juni en nog'='25').
RECODE nicotinepleisters_dagen_T1 ('Elke dag'='60').
RECODE nicotinepleisters_dagen_T1 ('elke dag'='60').
RECODE nicotinepleisters_dagen_T1 ('alle dagen'='60').
RECODE nicotinepleisters_dagen_T1 ('alle'='60').
RECODE nicotinekauwgom_dagen_T1 ('alle dagen'='60').
RECODE nicotine_mondspray_dagen_T1 ('Dagelijks'='60').
RECODE nicotine_microtabs_dagen_T1 ('90'='60').
RECODE nicotine_zuigtabletten_dagen_T1 ('96'='60').
RECODE nicotine_anders_dagen_T1 ('Dagelijks'='60').
RECODE nicotine_anders_dagen_T1 ('elke dag'='60').
RECODE nicotine_anders_dagen_T1 ('alle dagen'='60').
RECODE nicotine_anders_dagen_T1 ('alle'='60').
RECODE nicotine_anders_dagen_T1 ('5 weken'='35').
RECODE nicotine_anders_dagen_T1 ('49 dagen'='49').

ALTER TYPE nicotinepleisters_stuks_T1 nicotinekauwgom_stuks_T1 nicotine_microtabs_stuks_T1 
    nicotine_zuigtabletten_stuks_T1 nicotine_mondspray_keer_T1 nicotine_inhaler_keer_T1 
    nicotine_anders_stuks_T1 nicotinepleisters_dagen_T1 nicotinekauwgom_dagen_T1 
    nicotine_microtabs_dagen_T1 nicotine_zuigtabletten_dagen_T1 nicotine_mondspray_dagen_T1 
    nicotine_inhaler_dagen_T1 nicotine_anders_dagen_T1 (F3.0).

* bij anders ingevuld: mini zuigtablet = microtabs.
DO IF ID_code=5111.
RECODE nicotine_microtabs_T1 (0=1).
RECODE nicotine_anders_T1 (1=0).
RECODE nicotine_anders_nl_T1 ('nicotine mini zuigtablet'='').
COMPUTE nicotine_microtabs_stuks_T1=3. 
COMPUTE nicotine_anders_stuks_T1=888. 
COMPUTE nicotine_microtabs_dagen_T1=49. 
COMPUTE nicotine_anders_dagen_T1=888. 
END IF.

* controle reele getallen.
FREQUENCIES VARIABLES= nicotinepleisters_stuks_T1 nicotinekauwgom_stuks_T1 nicotine_microtabs_stuks_T1 
    nicotine_zuigtabletten_stuks_T1 nicotine_mondspray_keer_T1 nicotine_inhaler_keer_T1 
    nicotine_anders_stuks_T1 nicotinepleisters_dagen_T1 nicotinekauwgom_dagen_T1 
    nicotine_microtabs_dagen_T1 nicotine_zuigtabletten_dagen_T1 nicotine_mondspray_dagen_T1 
    nicotine_inhaler_dagen_T1 nicotine_anders_dagen_T1
  /ORDER=ANALYSIS.

* Als een van de middelen ja is, en aantal stuks en/of aantal dagen =0 of missing: 	Conservatieve schatting: 1.
DO IF (nicotinepleisters_T1=1).
RECODE nicotinepleisters_stuks_T1 (SYSMIS=1) (0=1).
RECODE nicotinepleisters_dagen_T1 (SYSMIS=1) (0=1).
END IF.
DO IF (nicotinekauwgom_T1=1).
RECODE nicotinekauwgom_stuks_T1 (SYSMIS=1) (0=1).
RECODE nicotinekauwgom_dagen_T1 (SYSMIS=1) (0=1).
END IF.
DO IF ( nicotine_microtabs_T1=1).
RECODE nicotine_microtabs_stuks_T1 (SYSMIS=1) (0=1).
RECODE nicotine_microtabs_dagen_T1(SYSMIS=1) (0=1).
END IF.
DO IF ( nicotine_zuigtabletten_T1=1).
RECODE nicotine_zuigtabletten_stuks_T1 (SYSMIS=1) (0=1).
RECODE nicotine_zuigtabletten_dagen_T1(SYSMIS=1) (0=1).
END IF.
DO IF ( nicotine_inhaler_T1=1).
RECODE nicotine_inhaler_keer_T1 (SYSMIS=1) (0=1).
RECODE nicotine_inhaler_dagen_T1(SYSMIS=1) (0=1).
END IF.
DO IF ( nicotine_anders_T1=1).
RECODE nicotine_anders_stuks_T1 (SYSMIS=1) (0=1).
RECODE nicotine_anders_dagen_T1(SYSMIS=1) (0=1).
END IF.

*** nvt toevoegen.
DO IF (nicotinepleisters_T1=0).
RECODE nicotinepleisters_stuks_T1 (SYSMIS=888).
RECODE nicotinepleisters_dagen_T1 (SYSMIS=888).
END IF.
DO IF (nicotinekauwgom_T1=0).
RECODE nicotinekauwgom_stuks_T1 (SYSMIS=888).
RECODE nicotinekauwgom_dagen_T1 (SYSMIS=888).
END IF.
DO IF (nicotine_microtabs_T1=0).
RECODE nicotine_microtabs_stuks_T1 (SYSMIS=888).
RECODE nicotine_microtabs_dagen_T1 (SYSMIS=888).
END IF.
DO IF (nicotine_zuigtabletten_T1=0).
RECODE nicotine_zuigtabletten_stuks_T1 (SYSMIS=888).
RECODE nicotine_zuigtabletten_dagen_T1 (SYSMIS=888).
END IF.
EXECUTE.
DO IF (nicotine_mondspray_T1=0).
RECODE nicotine_mondspray_keer_T1 (SYSMIS=888).
RECODE nicotine_mondspray_dagen_T1 (SYSMIS=888).
END IF.
EXECUTE.
DO IF (nicotine_inhaler_T1=0).
RECODE nicotine_inhaler_keer_T1 (SYSMIS=888).
RECODE nicotine_inhaler_dagen_T1 (SYSMIS=888).
END IF.
DO IF (nicotine_anders_T1=0).
RECODE nicotine_anders_stuks_T1 (SYSMIS=888).
RECODE nicotine_anders_dagen_T1 (SYSMIS=888).
END IF.
EXECUTE.


** Degene die nu nog sysmis zijn zijn echt missing (worden wel gebruikt maar geen aantal ingevuld).
RECODE nicotinepleisters_stuks_T1 nicotinekauwgom_stuks_T1 nicotine_microtabs_stuks_T1 
    nicotine_zuigtabletten_stuks_T1 nicotine_mondspray_keer_T1 nicotine_inhaler_keer_T1 
    nicotine_anders_stuks_T1 nicotinepleisters_dagen_T1 nicotinekauwgom_dagen_T1 
    nicotine_microtabs_dagen_T1 nicotine_zuigtabletten_dagen_T1 nicotine_mondspray_dagen_T1 
    nicotine_inhaler_dagen_T1 nicotine_anders_dagen_T1 (SYSMIS=999).
EXECUTE.

MISSING VALUES nicotinepleisters_stuks_T1 nicotinekauwgom_stuks_T1 nicotine_microtabs_stuks_T1 
    nicotine_zuigtabletten_stuks_T1 nicotine_mondspray_keer_T1 nicotine_inhaler_keer_T1 
    nicotine_anders_stuks_T1 nicotinepleisters_dagen_T1 nicotinekauwgom_dagen_T1 
    nicotine_microtabs_dagen_T1 nicotine_zuigtabletten_dagen_T1 nicotine_mondspray_dagen_T1 
    nicotine_inhaler_dagen_T1 nicotine_anders_dagen_T1 (888,  999) nicotinepleisters_T1 nicotinekauwgom_T1 nicotine_microtabs_T1 
    nicotine_zuigtabletten_T1 nicotine_mondspray_T1 nicotine_inhaler_T1 nicotine_anders_T1 (9).

VARIABLE LEVEL nicotinevervangers_T1 nicotinepleisters_T1 nicotinekauwgom_T1 nicotine_microtabs_T1 
    nicotine_zuigtabletten_T1 nicotine_mondspray_T1 nicotine_inhaler_T1 nicotine_anders_T1 (NOMINAL).
VARIABLE LEVEL nicotinepleisters_stuks_T1 nicotinekauwgom_stuks_T1 nicotine_microtabs_stuks_T1 
    nicotine_zuigtabletten_stuks_T1 nicotine_mondspray_keer_T1 nicotine_inhaler_keer_T1 
    nicotine_anders_stuks_T1 nicotinepleisters_dagen_T1 nicotinekauwgom_dagen_T1 
    nicotine_microtabs_dagen_T1 nicotine_zuigtabletten_dagen_T1 nicotine_mondspray_dagen_T1 
    nicotine_inhaler_dagen_T1 nicotine_anders_dagen_T1 (SCALE).




*** Q89: gebruik electronische sigaretten ****************************************************************************************************************************.
RENAME VARIABLES Q89 =Esigaret_T1 / Q90_1=Esigaret_met_nicotine_T1 / Q90_2=Esigaret_zonder_nicotine_T1.
VARIABLE LABELS Esigaret_T1 'E-sigaret gebruikt: ja/nee'
Esigaret_met_nicotine_T1  'E-sigaret met nicotine: ja/nee' 
Esigaret_zonder_nicotine_T1  'E-sigaret zonder nicotine: ja/nee'.
VALUE LABELS Esigaret_met_nicotine_T1 Esigaret_zonder_nicotine_T1 0 'nee'1 'ja' .

RENAME VARIABLES Q108_1_x1_1_TEXT= Esigaret_met_nicotine_stuks_T1 / Q108_1_x2_1_TEXT =Esigaret_zonder_nicotine_stuks_T1/
Q108_2_x1_1_TEXT=Esigaret_met_nicotine_dagen_T1 / Q108_2_x2_1_TEXT=Esigaret_zonder_nicotine_dagen_T1.
VARIABLE LABELS  Esigaret_met_nicotine_stuks_T1 'E-sigaret met nicotine: aantal stuks/dag T1' / Esigaret_zonder_nicotine_stuks_T1 'E-sigaret zonder nicotine: aantal stuks/dag T1'.
VARIABLE LABELS Esigaret_met_nicotine_dagen_T1 'E-sigaret met nicotine: aantal dagen T1' / Esigaret_zonder_nicotine_dagen_T1 'E-sigaret zonder nicotine: aantal dagen T1'.

*stuks en dagen van string naar numeriek.
* controle geen tekst.
FREQUENCIES VARIABLES=  Esigaret_met_nicotine_stuks_T1 Esigaret_zonder_nicotine_stuks_T1 Esigaret_met_nicotine_dagen_T1 Esigaret_zonder_nicotine_dagen_T1
  /ORDER=ANALYSIS.

ALTER TYPE Esigaret_met_nicotine_stuks_T1 Esigaret_zonder_nicotine_stuks_T1 Esigaret_met_nicotine_dagen_T1 Esigaret_zonder_nicotine_dagen_T1 (F3.0).

* controle reele getallen.
FREQUENCIES VARIABLES=Esigaret_met_nicotine_stuks_T1 Esigaret_zonder_nicotine_stuks_T1 Esigaret_met_nicotine_dagen_T1 Esigaret_zonder_nicotine_dagen_T1
  /ORDER=ANALYSIS.

* Indien Esigaret1_T0 Nee is, moet missing  0 zijn.
DO IF (Esigaret_T1=1).
RECODE Esigaret_met_nicotine_T1 Esigaret_zonder_nicotine_T1  
Esigaret_met_nicotine_stuks_T1 Esigaret_zonder_nicotine_stuks_T1 Esigaret_met_nicotine_dagen_T1 Esigaret_zonder_nicotine_dagen_T1 (SYSMIS=0).
END IF.
EXECUTE.

* Indien Esigaret1_T0 2 (ja) is, moet Esigaret_met_nicotine_T1 of Esigaret_zonder_nicotine_T1 1 (ja) zijn, indien beide missing: missing. Indien 1 ingevuld en andere missing: andere=0.
DO IF (Esigaret_T1=2) and SYSMIS (Esigaret_met_nicotine_T1 )=1 and SYSMIS (Esigaret_zonder_nicotine_T1 )=1.
RECODE   Esigaret_met_nicotine_T1 Esigaret_zonder_nicotine_T1 (SYSMIS=9).
END IF.
DO IF Esigaret_T1=2.
RECODE   Esigaret_met_nicotine_T1 Esigaret_zonder_nicotine_T1 (SYSMIS=0).
END IF.
MISSING VALUES Esigaret_met_nicotine_T1 Esigaret_zonder_nicotine_T1 (9).

*** Q91 medicatie *******************************************************************************************************************************************************.
RENAME VARIABLES Q91=medicatie_T1 / Q114_1_TEXT = med1_T1 / Q114_2_TEXT = med2_T1 /Q114_3_TEXT = med3_T1 /Q114_4_TEXT = med4_T1 /Q114_5_TEXT = med5_T1 /
Q114_6_TEXT = med6_T1 /Q114_7_TEXT = med7_T1 /Q114_8_TEXT = med8_T1 /Q114_9_TEXT = med9_T1 /Q114_10_TEXT = med10_T1. 

VARIABLE LABELS medicatie_T1 'medicatie ja/nee T1' med1_T1 'med naam 1 T1'  med2_T1 'med naam 2 T1'  med3_T1 'med naam 3 T1'  med4_T1 'med naam 4 T1'
 med5_T1 'med naam 5 T1'  med6_T1 'med naam 6 T1'  med7_T1 'med naam 7 T1'  med8_T1 'med naam 8 T1'  med9_T1 'med naam 9 T1'  med10_T1 'med naam 10 T1'.

RENAME VARIABLES Q113_x1_TEXT =med1_dosering_T1 / Q113_x2_TEXT =med2_dosering_T1 / Q113_x3_TEXT =med3_dosering_T1 
/ Q113_x4_TEXT =med4_dosering_T1 / Q113_x5_TEXT =med5_dosering_T1 / Q113_x6_TEXT =med6_dosering_T1 
/ Q113_x7_TEXT =med7_dosering_T1 / Q113_x8_TEXT =med8_dosering_T1 / Q113_x9_TEXT =med9_dosering_T1 / Q113_x10_TEXT =med10_dosering_T1.

VARIABLE LABELS  med1_dosering_T1 / med2_dosering_T1 / med3_dosering_T1 / med4_dosering_T1 / med5_dosering_T1 / med6_dosering_T1 / med7_dosering_T1 / 
    med8_dosering_T1 / med9_dosering_T1 / med10_dosering_T1.

RENAME VARIABLES Q112_x1_TEXT =med1_keerperdag_T1 / Q112_x2_TEXT =med2_keerperdag_T1 / Q112_x3_TEXT =med3_keerperdag_T1 / 
Q112_x4_TEXT =med4_keerperdag_T1 / Q112_x5_TEXT =med5_keerperdag_T1 / Q112_x6_TEXT =med6_keerperdag_T1 / 
Q112_x7_TEXT =med7_keerperdag_T1 / Q112_x8_TEXT =med8_keerperdag_T1 / Q112_x9_TEXT =med9_keerperdag_T1 / 
Q112_x10_TEXT =med10_keerperdag_T1 .

VARIABLE LABELS  med1_keerperdag_T1 / med2_keerperdag_T1 / med3_keerperdag_T1 / med4_keerperdag_T1 / med5_keerperdag_T1 / 
    med6_keerperdag_T1 / med7_keerperdag_T1 / med8_keerperdag_T1 / med9_keerperdag_T1 / med10_keerperdag_T1.

RENAME VARIABLES Q122_x1_TEXT =med1_aantdagen_T1 / Q122_x2_TEXT =med2_aantdagen_T1 / Q122_x3_TEXT =med3_aantdagen_T1 / 
Q122_x4_TEXT =med4_aantdagen_T1 / Q122_x5_TEXT =med5_aantdagen_T1 / Q122_x6_TEXT =med6_aantdagen_T1 / 
Q122_x7_TEXT =med7_aantdagen_T1 / Q122_x8_TEXT =med8_aantdagen_T1 / Q122_x9_TEXT =med9_aantdagen_T1 /
Q122_x10_TEXT =med10_aantdagen_T1.

VARIABLE LABELS   med1_aantdagen_T1 / med2_aantdagen_T1 / med3_aantdagen_T1  / med4_aantdagen_T1 / med5_aantdagen_T1 /
    med6_aantdagen_T1 / med7_aantdagen_T1 / med8_aantdagen_T1 / med9_aantdagen_T1 / med10_aantdagen_T1.

RENAME VARIABLES Q115_x1_TEXT =med1_vorm_T1 / Q115_x2_TEXT =med2_vorm_T1 / Q115_x3_TEXT =med3_vorm_T1 / 
Q115_x4_TEXT =med4_vorm_T1 / Q115_x5_TEXT =med5_vorm_T1 / Q115_x6_TEXT =med6_vorm_T1 / 
Q115_x7_TEXT =med7_vorm_T1 / Q115_x8_TEXT =med8_vorm_T1 / Q115_x9_TEXT =med9_vorm_T1 / Q115_x10_TEXT =med10_vorm_T1.

VARIABLE LABELS  med1_vorm_T1 / med2_vorm_T1 / med3_vorm_T1 / med4_vorm_T1 / med5_vorm_T1 / med6_vorm_T1 / med7_vorm_T1 / 
    med8_vorm_T1 / med9_vorm_T1 / med10_vorm_T1.


** als medicatie_T1=1 (nee) of missing: med1_T1 moet leeg zijn.
USE ALL.
COMPUTE filter_$=(medicatie_T1=1 or MISSING(medicatie_T1)=1).
VARIABLE LABELS filter_$ 'medicatie_T1=1 of missing (FILTER)'.
VALUE LABELS filter_$ 0 'Not Selected' 1 'Selected'.
FORMATS filter_$ (f1.0).
FILTER BY filter_$.
EXECUTE.
FREQUENCIES VARIABLES=med1_T1
  /ORDER=ANALYSIS.
USE ALL.

*ID 3909 medicatie_T1 is missing, wel medicatie genoemd:  wordt 2.
DO IF ID_code=3909.
RECODE medicatie_T1 (SYSMIS=2).
END IF.
EXECUTE.

** ID 4909 heeft medicatie=ja en vervolgens overal 0.Hercoderen naar missing.
DO IF (ID_code=4909).
RECODE  med1_T1 to med10_T1 ('0' =' ').
RECODE  med1_dosering_T1 to med10_dosering_T1 ('0' =' ').
RECODE  med1_vorm_T1 to med10_vorm_T1 ('0' =' ').
RECODE  med1_keerperdag_T1 to med10_keerperdag_T1 ('0' =' ').
RECODE  med1_aantdagen_T1 to med10_aantdagen_T1 ('0' =' ').
END IF.

** ID 1301. Alleen med5 ingevuld: nicotinepleister en bloeddrukverlager. Verderlen over med 1 en 2.
DO IF (ID_code=1301).
RECODE  med1_T1 ('' ='nicotinepleister').
RECODE  med2_T1 (''='bloeddrukverlagers').
RECODE  med5_T1 ('nicotinepleister en bloeddrukverlagers' ='').
RECODE  med1_dosering_T1 ('' ='20').
RECODE  med5_dosering_T1 ('20' =' ').
RECODE  med1_keerperdag_T1 ('' ='1').
RECODE  med2_keerperdag_T1 ('' ='1').
RECODE  med5_keerperdag_T1 ('1' ='').
RECODE  med1_aantdagen_T1 ('' ='62').
RECODE  med2_aantdagen_T1 ('' ='62').
RECODE  med5_aantdagen_T1 ('62' ='').
RECODE  med1_vorm_T1 ('' ='pleister').
RECODE  med1_vorm_T1 ('' ='tablet').
RECODE  med1_vorm_T1 ('' ='pil en pleisters').
END IF.
EXECUTE.

*aantal keer per dag van string naar numeriek.
* controle op tekst en decimalen moeten met punt.
*Q115 (aantal dagen) van string naar numeriek.
* controle op tekst en decimalen moeten met komma.


RECODE med1_aantdagen_T1 ('alle'='61').
RECODE med1_aantdagen_T1 ('49?'='49').
RECODE med1_aantdagen_T1 ('380'='61').
RECODE med1_aantdagen_T1 ('110'='61').
RECODE med1_aantdagen_T1 ('120'='61').

RECODE med1_keerperdag_T1 ('Conform'='').
*geeft ook aan 5 dagen.
RECODE med1_keerperdag_T1 ('Incidenteel'='1').
RECODE med1_keerperdag_T1 ('nvt'='').
RECODE med1_keerperdag_T1 ('10.ML'='').
RECODE med1_keerperdag_T1 ('0,5'='0.5').
RECODE med1_keerperdag_T1 ('1x'='1').
RECODE med1_keerperdag_T1 ('1 x'='1').
RECODE med1_keerperdag_T1 ('1 keer per dag'='1').
RECODE med1_keerperdag_T1 ('1x pd'='1').
RECODE med1_keerperdag_T1 ('1/2'='1').
RECODE med1_keerperdag_T1 ('1-2x'='1').
RECODE med1_keerperdag_T1 ('1-2'='1').
RECODE med1_keerperdag_T1 ('2x per dag'='2').
RECODE med1_keerperdag_T1 ('2X'='2').
RECODE med1_keerperdag_T1 ('2x'='2').
RECODE med1_keerperdag_T1 ('2 x per dag'='2').
RECODE med1_keerperdag_T1 ('2 x'='2').
RECODE med1_keerperdag_T1 ('3x'='3').
RECODE med1_aantdagen_T1 ('14 dgn'='14').
RECODE med1_aantdagen_T1 ('?'='').

DO IF ID_Code=4805.
RECODE med1_keerperdag_T1 ('2x1 mgr'='2').
RECODE med1_dosering_T1 ('2 mgr'='1 mg').
END IF.
* keer per dag: o,5, bedoelt waarschijnlijk dosering. Keer per dag wordt 1.
DO IF ID_Code=2205.
RECODE med1_keerperdag_T1 ('0,5'='1').
END IF.
* Thyrax is altijd 1xd.
DO IF ID_Code=2705.
RECODE med1_keerperdag_T1 ('125mg'='1').
END IF.
* neemt halve tablet van 10 mg.
DO IF ID_Code=3007.
RECODE med1_keerperdag_T1 ('0,5'='1').
RECODE med1_dosering_T1 ('10mg'='halve tablet van 10 mg').
END IF.
* dosering is 1x per week maar geeft ook aan 4 dagen (waarschijnlijk dus 1 maand, 1x per week). --> keerperdag=1.
DO IF ID_Code=5113.
RECODE med1_keerperdag_T1 ('1x per week'='1').
END IF.
* neemt 10x2,5 mg 1x per week gedurende 8 weken:.
DO IF ID_Code=2901.
RECODE med1_keerperdag_T1 ('10'='0.14').
RECODE med1_aantdagen_T1 ('8'='56').
END IF.
*injectie is 1x per week gedurende 8 weken:.
DO IF ID_Code=6009.
RECODE med1_keerperdag_T1 ('1x per wee'='1').
END IF.
*injectie is 1x per week gedurende 8 weken:.
DO IF ID_Code=4105.
RECODE med1_keerperdag_T1 ('1 pw'='1').
END IF.
* aantalkeer per dag =80. Medicijn wordt altijd 1x per 2 weken toegediend:0.07. 4 dagen is dus 8 weken.
DO IF ID_Code=5006.
RECODE med1_keerperdag_T1 ('80'='0.07').
RECODE med1_aantdagen_T1 ('4'='56').
END IF.
* aantal keer per dag= 1x2, hetzelfde staat bij dosering.--> 2x per dag, dosering missing.
DO IF ID_Code=7007.
RECODE med1_keerperdag_T1 ('1×2'='2').
RECODE med1_dosering_T1 ('1×2'='').
END IF.


RECODE med2_aantdagen_T1 ('alle'='61').
RECODE med2_aantdagen_T1 ('zo nodig'='').
RECODE med2_aantdagen_T1 ('?'='').
RECODE med2_aantdagen_T1 ('120'='61').

RECODE med2_keerperdag_T1 ('Meer'='').
RECODE med2_keerperdag_T1 ('kuur'='').
RECODE med2_keerperdag_T1 ('Indien nodig'='').
RECODE med2_keerperdag_T1 ('?'='').
RECODE med2_keerperdag_T1 ('4 indien nodig'='4').
RECODE med2_keerperdag_T1 ('om de dag'='0.45').
RECODE med2_keerperdag_T1 ('1x'='1').
RECODE med2_keerperdag_T1 ('1 x'='1').
RECODE med2_keerperdag_T1 ('2x'='2').
RECODE med2_keerperdag_T1 ('3-4'='3').
* Simvastatine is altijd 1xd.
DO IF ID_Code=2705.
RECODE med2_keerperdag_T1 ('20mg'='1').
END IF.
* aantal keer per dag= 1x2, hetzelfde staat bij dosering.--> 2x per dag, dosering missing.
DO IF ID_Code=7007.
RECODE med2_keerperdag_T1 ('1×2'='2').
RECODE med2_dosering_T1 ('1×2'='').
END IF.
* 150x per dag kan niet --> uitgaan van conservatieve schatting: 1x.
DO IF ID_Code=5006.
RECODE med2_keerperdag_T1 ('150'='1').
END IF.
* 1x per 14 dagen, geeft ook al 4 dagen.
DO IF ID_Code=6009.
RECODE med1_keerperdag_T1 ('1x per 14 dagen'='1').
END IF.

RECODE med3_keerperdag_T1 ('Alleen bij hooikoorts'='').
RECODE med3_keerperdag_T1 ('-'='').
* aantal dagen is al aangepast.
RECODE med3_keerperdag_T1 ('1x per week'='1').
* aantal dagen is al aangepast.
RECODE med3_keerperdag_T1 ('2x per week'='1').
RECODE med3_keerperdag_T1 ('1x'='1').
RECODE med3_keerperdag_T1 ('1×1'='1').
RECODE med3_keerperdag_T1 ('2-3'='2').
RECODE med3_keerperdag_T1 ('2 x'='2').
RECODE med3_keerperdag_T1 ('3 á 4'='3').
RECODE med3_keerperdag_T1 ('4-5'='4').
* Vesicare is altijd 1xd.
DO IF ID_Code=2705.
RECODE med3_keerperdag_T1 ('10mg'='1').
END IF.
* 60x per dag kan niet --> uitgaan van conservatieve schatting: 1x.
DO IF ID_Code=5006.
RECODE med3_keerperdag_T1 ('60'='1').
END IF.
* 160x per dag kan niet --> uitgaan van conservatieve schatting: 1x.
DO IF ID_Code=1816.
RECODE med3_keerperdag_T1 ('160'='1').
END IF.

RECODE med4_keerperdag_T1 ('soms'='').
* 2xper maand, 2 dagen: dus waarschijnlijk afgelopen periode 2 dagen 1 paracetamol genomen.
RECODE med4_keerperdag_T1 ('2 keer per maand'='1').
RECODE med4_keerperdag_T1 ('1 x per dag'='1').
RECODE med4_keerperdag_T1 ('1 x'='1').
RECODE med4_keerperdag_T1 ('2x'='2').
RECODE med4_keerperdag_T1 ('3 á 4'='3').
* 1 x 2 betekent 1 d 2 pufjes.
DO IF ID_Code=6407.
RECODE med4_keerperdag_T1 ('1 x 2'='1').
RECODE med4_dosering_T1 ('25 mg'='25 mg 2 pufjes').
END IF.
EXECUTE.

RECODE med5_aantdagen_T1 ('?'='').
RECODE med6_aantdagen_T1 ('?'='').
RECODE med5_keerperdag_T1 ('zn'='').
RECODE med5_keerperdag_T1 ('10-1'='').
RECODE med5_keerperdag_T1 ('1x'='1').
RECODE med5_keerperdag_T1 ('1 x per dag'='1').

RECODE med6_keerperdag_T1 ('zn'='').
RECODE med6_keerperdag_T1 ('3 x'='3').
RECODE med6_keerperdag_T1 ('1 x per dag'='1').

RECODE med7_keerperdag_T1 ('1x per dag'='1').
* aantal dagen is al aangepast.
RECODE med7_keerperdag_T1 ('2pw'='1').

RECODE med8_keerperdag_T1 ('1 x per dag'='1').

ALTER TYPE med1_keerperdag_T1 med2_keerperdag_T1 med3_keerperdag_T1 med4_keerperdag_T1 med5_keerperdag_T1 
    med6_keerperdag_T1 med7_keerperdag_T1 med8_keerperdag_T1 med9_keerperdag_T1 med10_keerperdag_T1 (F3.2).

** Max aant dagen = 61 (2 maanden).
RECODE med1_aantdagen_T1 ('80'='61') ('62'='61').
RECODE med2_aantdagen_T1 ('84'='61') ('80'='61') ('62'='61').
EXECUTE.

ALTER TYPE med1_aantdagen_T1 med2_aantdagen_T1 med3_aantdagen_T1 med4_aantdagen_T1 med5_aantdagen_T1 
    med6_aantdagen_T1 med7_aantdagen_T1 med8_aantdagen_T1 med9_aantdagen_T1 med10_aantdagen_T1  (F3.0).

** missing invullen.
RECODE medicatie_T1 (SYSMIS=9).
MISSING VALUES  medicatie_T1 (9).
EXECUTE.

*** Vorm hetzelfde noemen.
FREQUENCIES VARIABLES=med1_vorm_T1 med2_vorm_T1 med3_vorm_T1 med4_vorm_T1 med5_vorm_T1 med6_vorm_T1 
    med7_vorm_T1 med8_vorm_T1 med9_vorm_T1 med10_vorm_T1
  /ORDER=ANALYSIS.

RECODE med1_vorm_T1 ('pi'='tablet').
RECODE med1_vorm_T1 ('p'='tablet').
RECODE med1_vorm_T1 ('pil'='tablet').
RECODE med1_vorm_T1 ('Pil'='tablet').
RECODE med1_vorm_T1 ('pillen'='tablet').
RECODE med1_vorm_T1 ('Pillen'='tablet').
RECODE med1_vorm_T1 ('pi'='tablet').
RECODE med1_vorm_T1 ('PIL'='tablet').
RECODE med1_vorm_T1 ('Pilletje'='tablet').
RECODE med1_vorm_T1 ('capsules'='tablet').
RECODE med1_vorm_T1 ('capsule'='tablet').
RECODE med1_vorm_T1 ('Capsules'='tablet').
RECODE med1_vorm_T1 ('Tablet'='tablet').
RECODE med1_vorm_T1 ('Tabl'='tablet').
RECODE med1_vorm_T1 ('bruis'='tablet').
RECODE med1_vorm_T1 ('Bruistablet'='bruistablet').
RECODE med1_vorm_T1 ('bruis'='bruistablet').
RECODE med1_vorm_T1 ('Bruis'='bruistablet').
RECODE med1_vorm_T1 ('inhaler'='inhalator').
RECODE med1_vorm_T1 ('Inhaler'='inhalator').
RECODE med1_vorm_T1 ('Inhalator'='inhalator').
RECODE med1_vorm_T1 ('inhalatie'='inhalator').
RECODE med1_vorm_T1 ('puffer'='inhalator').
RECODE med1_vorm_T1 ('Puffer'='inhalator').
RECODE med1_vorm_T1 ('pufjes'='inhalator').
RECODE med1_vorm_T1 ('pufje'='inhalator').
RECODE med1_vorm_T1 ('Injectie'='injectie').
RECODE med1_vorm_T1 ('Poeder'='poeder').
RECODE med1_vorm_T1 ('Pleister'='pleister').
RECODE med1_vorm_T1 ('pleiser'='pleister').
RECODE med1_vorm_T1 ('Vloeistof'='vloeistof').
RECODE med1_vorm_T1 ('Vloestof'='vloeistof').
RECODE med1_vorm_T1 ('vloeistof, kan dat anders dan?????'='vloeistof').
RECODE med1_vorm_T1 ('VLOEISTOF'='vloeistof').
RECODE med1_vorm_T1 ('Zalf'='zalf').


RECODE med2_vorm_T1 ('pil'='tablet').
RECODE med2_vorm_T1 ('Pil'='tablet').
RECODE med2_vorm_T1 ('p'='tablet').
RECODE med2_vorm_T1 ('pillen'='tablet').
RECODE med2_vorm_T1 ('PIL'='tablet').
RECODE med2_vorm_T1 ('pillenb'='tablet').
RECODE med2_vorm_T1 ('Pillen'='tablet').
RECODE med2_vorm_T1 ('pilletje'='tablet').
RECODE med2_vorm_T1 ('Pilletje'='tablet').
RECODE med2_vorm_T1 ('Tabletten'='tablet').
RECODE med2_vorm_T1 ('Tablet'='tablet').
RECODE med2_vorm_T1 ('TABLET'='tablet').
RECODE med2_vorm_T1 ('Tabl'='tablet').
RECODE med2_vorm_T1 ('zuigtablet'='tablet').
RECODE med2_vorm_T1 ('capsule'='tablet').
RECODE med2_vorm_T1 ('caps'='tablet').
RECODE med2_vorm_T1 ('Zetpil'='zetpil').
RECODE med2_vorm_T1 ('verstuiver pompje'='verstuiver').
RECODE med2_vorm_T1 ('inhaleren'='inhalator').
RECODE med2_vorm_T1 ('Inhaler'='inhalator').
RECODE med2_vorm_T1 ('inhalatie'='inhalator').
RECODE med2_vorm_T1 ('inhalor'='inhalator').
RECODE med2_vorm_T1 ('pufjes'='inhalator').
RECODE med2_vorm_T1 ('Pufje'='inhalator').
RECODE med2_vorm_T1 ('Puf'='inhalator').
RECODE med2_vorm_T1 ('Puffer'='inhalator').
RECODE med2_vorm_T1 ('puf'='inhalator').
RECODE med2_vorm_T1 ('pompje'='inhalator').
RECODE med2_vorm_T1 ('Poeder'='poeder').
RECODE med2_vorm_T1 ('poedervorm'='poeder').
RECODE med2_vorm_T1 ('Pleister'='pleister').
RECODE med2_vorm_T1 ('Druppels'='druppels').
RECODE med2_vorm_T1 ('0'='').

RECODE med3_vorm_T1 ('pil'='tablet').
RECODE med3_vorm_T1 ('pillen'='tablet').
RECODE med3_vorm_T1 ('Pillen'='tablet').
RECODE med3_vorm_T1 ('pil'='tablet').
RECODE med3_vorm_T1 ('Pil'='tablet').
RECODE med3_vorm_T1 ('pilletje'='tablet').
RECODE med3_vorm_T1 ('Pilletje'='tablet').
RECODE med3_vorm_T1 ('piul'='tablet').
RECODE med3_vorm_T1 ('p'='tablet').
RECODE med3_vorm_T1 ('smelttablet'='tablet').
RECODE med3_vorm_T1 ('Smelttablet'='tablet').
RECODE med3_vorm_T1 ('Tabl'='tablet').
RECODE med3_vorm_T1 ('capsule'='tablet').
RECODE med3_vorm_T1 ('Capsule'='tablet').
RECODE med3_vorm_T1 ('capcule'='tablet').
RECODE med3_vorm_T1 ('Inhalator'='inhalator').
RECODE med3_vorm_T1 ('Innalatie'='inhalator').
RECODE med3_vorm_T1 ('inhalinging'='inhalator').
RECODE med3_vorm_T1 ('inhalatie'='inhalator').
RECODE med3_vorm_T1 ('inhalor'='inhalator').
RECODE med3_vorm_T1 ('Inhaler'='inhalator').
RECODE med3_vorm_T1 ('puffer'='inhalator').
RECODE med3_vorm_T1 ('puf'='inhalator').
RECODE med3_vorm_T1 ('pompje'='inhalator').
RECODE med3_vorm_T1 ('Pleister'='pleister').
RECODE med3_vorm_T1 ('Poeder'='poeder').
RECODE med3_vorm_T1 ('snuif'='verstuiver').
RECODE med3_vorm_T1 ('Injectie'='injectie').
RECODE med3_vorm_T1 ('intraveneus'='injectie').
RECODE med3_vorm_T1 ('Druppels'='druppels').
RECODE med3_vorm_T1 ('droppels'='druppels').
RECODE med3_vorm_T1 ('Vloeistof'='vloeistof').

RECODE med4_vorm_T1 ('pil'='tablet').
RECODE med4_vorm_T1 ('pillen'='tablet').
RECODE med4_vorm_T1 ('Pilletje'='tablet').
RECODE med4_vorm_T1 ('Pillen'='tablet').
RECODE med4_vorm_T1 ('Pil'='tablet').
RECODE med4_vorm_T1 ('capsule'='tablet').
RECODE med4_vorm_T1 ('Zetpil'='zetpil').
RECODE med4_vorm_T1 ('Inhalator'='inhalator').
RECODE med4_vorm_T1 ('Poeder'='poeder').
RECODE med4_vorm_T1 ('Vloeistof'='vloeistof').

RECODE med5_vorm_T1 ('Pil'='tablet').
RECODE med5_vorm_T1 ('pil'='tablet').
RECODE med5_vorm_T1 ('puffertje'='inhalator').
RECODE med5_vorm_T1 ('Poeder'='poeder').

RECODE med6_vorm_T1 ('puf'='inhalator').
RECODE med6_vorm_T1 ('Pil'='tablet').
RECODE med6_vorm_T1 ('pil'='tablet').

RECODE med7_vorm_T1 ('pil'='tablet').
RECODE med7_vorm_T1 ('Pil'='tablet').
RECODE med7_vorm_T1 ('capsule'='tablet').
RECODE med7_vorm_T1 ('pillen'='tablet').
RECODE med7_vorm_T1 ('spuit'='injectie').
RECODE med7_vorm_T1 ('Pillen'='tablet').
RECODE med7_vorm_T1 ('Neusspray'='verstuiver').

RECODE med8_vorm_T1 ('pil'='tablet').
RECODE med8_vorm_T1 ('Pil'='tablet').
RECODE med8_vorm_T1 ('Capsule'='tablet').

RECODE med9_vorm_T1 ('pil'='tablet').
EXECUTE.

FREQUENCIES VARIABLES=med1_vorm_T1 med2_vorm_T1 med3_vorm_T1 med4_vorm_T1 med5_vorm_T1 med6_vorm_T1 
    med7_vorm_T1 med8_vorm_T1 med9_vorm_T1 med10_vorm_T1
  /ORDER=ANALYSIS.

*** ID 6001 Vult bij med naam 1 in.
DO IF ID_code=6001.
RECODE med1_T1 ('1'='').
RECODE med1_dosering_T1 ('200mg'='').
RECODE med2_T1 ('1'='').
END IF.

*** ID 4308. Vult in bij Med1: zie vorige vragen lijst. Overnemen uit T0:.
DO IF ID_Code=4308.
RECODE med1_T1 ('zie vorige vragen lijst'='atorvastitiene 10 mg').
RECODE med1_dosering_T1 (''='10 mg').
RECODE med1_keerperdag_T1 (SYSMIS=1).
RECODE med1_aantdagen_T1 (SYSMIS=60).
RECODE med2_T1 (' '='mono- cedocard 25 mg').
RECODE med2_dosering_T1 (''='25 mg').
RECODE med2_keerperdag_T1 (SYSMIS=1).
RECODE med2_aantdagen_T1 (SYSMIS=60).
RECODE med3_T1 (''='metoprolosuccinaat 100').
RECODE med3_dosering_T1 (''='100 mg').
RECODE med3_keerperdag_T1 (SYSMIS=1).
RECODE med3_aantdagen_T1 (SYSMIS=60).
RECODE med4_T1 (''='enalaprilmaleaat 10 mg').
RECODE med4_dosering_T1 (''='10 mg').
RECODE med4_keerperdag_T1 (SYSMIS=1).
RECODE med4_aantdagen_T1 (SYSMIS=60).
RECODE med5_T1 (''='carbasalaatcalciuum 100').
RECODE med5_dosering_T1 (''='100 mg').
RECODE med5_keerperdag_T1 (SYSMIS=1).
RECODE med5_aantdagen_T1 (SYSMIS=60).
RECODE med6_T1 (''='hydrochloorthiazide  25 mg').
RECODE med6_dosering_T1 (''='25 mg').
RECODE med6_keerperdag_T1 (SYSMIS=1).
RECODE med6_aantdagen_T1 (SYSMIS=60).
END IF.

*** ID 7102. Vult in bij Med1: zie eerdere enquete. Overnemen uit T0:.
DO IF ID_Code=7102.
RECODE med1_T1 ('zie eerdere enquete'='Naproxen').
RECODE med1_dosering_T1 ('idem'='500').
RECODE med1_keerperdag_T1 (SYSMIS=2).
RECODE med1_aantdagen_T1 (SYSMIS=60).
RECODE med2_T1 (' '='Aspirine').
RECODE med2_dosering_T1 (''='80').
RECODE med2_keerperdag_T1 (SYSMIS=1).
RECODE med2_aantdagen_T1 (SYSMIS=60).
RECODE med3_T1 (''='Omeprazol').
RECODE med3_dosering_T1 (''='20').
RECODE med3_keerperdag_T1 (SYSMIS=1).
RECODE med3_aantdagen_T1 (SYSMIS=60).
RECODE med4_T1 (''='Ocipine').
RECODE med4_dosering_T1 (''='10').
RECODE med4_keerperdag_T1 (SYSMIS=1).
RECODE med4_aantdagen_T1 (SYSMIS=60).
RECODE med5_T1 (''='Bisoprololfumaraat').
RECODE med5_dosering_T1 (''='5').
RECODE med5_keerperdag_T1 (SYSMIS=1).
RECODE med5_aantdagen_T1 (SYSMIS=60).
RECODE med6_T1 (''='promocard').
RECODE med6_dosering_T1 (''='30').
RECODE med6_keerperdag_T1 (SYSMIS=1).
RECODE med6_aantdagen_T1 (SYSMIS=60).
RECODE med7_T1 (''='Citalopram').
RECODE med7_dosering_T1 (''='10').
RECODE med7_keerperdag_T1 (SYSMIS=1).
RECODE med7_aantdagen_T1 (SYSMIS=60).
RECODE med8_T1 (''='Crestor').
RECODE med8_dosering_T1 (''='40').
RECODE med8_keerperdag_T1 (SYSMIS=1).
RECODE med8_aantdagen_T1 (SYSMIS=60).
RECODE med9_T1 (''='Ezetrol').
RECODE med9_dosering_T1 (''='10').
RECODE med9_keerperdag_T1 (SYSMIS=1).
RECODE med9_aantdagen_T1 (SYSMIS=60).
RECODE med10_T1 (''='Isordil').
RECODE med10_dosering_T1 (''='5').
RECODE med10_keerperdag_T1 (SYSMIS=1).
RECODE med10_aantdagen_T1 (SYSMIS=60).
END IF.


*** ID 1506. Vult in bij Med2: overige medicatie is hetzelfde gebleven. Overnemen uit T0:.
DO IF ID_Code=1506.
RECODE med2_T1 ('Overige medicatie is hetzelfde gebleven'='Perindopril').
RECODE med2_dosering_T1 (''='20mg').
RECODE med2_keerperdag_T1 (SYSMIS=1).
RECODE med2_aantdagen_T1 (SYSMIS=60).
RECODE med3_T1 (''='Metoprololsuccinaat').
RECODE med3_dosering_T1 (''='100 + 50 mg').
RECODE med3_keerperdag_T1 (SYSMIS=1).
RECODE med3_aantdagen_T1 (SYSMIS=60).
RECODE med4_T1 (''='Pantozol').
RECODE med4_dosering_T1 (''='20 mg').
RECODE med4_keerperdag_T1 (SYSMIS=1).
RECODE med4_aantdagen_T1 (SYSMIS=60).
RECODE med5_T1 (''='Lipitor').
RECODE med5_dosering_T1 (''='80 mg').
RECODE med5_keerperdag_T1 (SYSMIS=1).
RECODE med5_aantdagen_T1 (SYSMIS=60).
RECODE med6_T1 (''='carbasalaatcalcium').
RECODE med6_dosering_T1 (''='100 mg').
RECODE med6_keerperdag_T1 (SYSMIS=1).
RECODE med6_aantdagen_T1 (SYSMIS=60).
END IF.
EXECUTE.

*** ID 4903. Op papier ingevuld en niet volledig ingevoerd:.
DO IF ID_Code=4903.
RECODE med3_T1 (''='praluent').
RECODE med3_dosering_T1 (''='75 mg/ml').
RECODE med3_keerperdag_T1 (SYSMIS=0.14).
RECODE med3_aantdagen_T1 (SYSMIS=60).
RECODE med3_vorm_T1 ('' ='injectie').
RECODE med4_T1 (''='legendal').
RECODE med4_dosering_T1 (''='12 g').
RECODE med4_keerperdag_T1 (SYSMIS=1).
RECODE med4_aantdagen_T1 (SYSMIS=60).
RECODE med4_vorm_T1 (' '='granulaat').
RECODE med5_T1 (''='quinapril').
RECODE med5_dosering_T1 (''='10 mg').
RECODE med5_keerperdag_T1 (SYSMIS=1).
RECODE med5_aantdagen_T1 (SYSMIS=60).
RECODE med6_T1 (''='atorvastatine').
RECODE med6_dosering_T1 (''='40 mg').
RECODE med6_keerperdag_T1 (SYSMIS=1).
RECODE med6_aantdagen_T1 (SYSMIS=60).
RECODE med7_T1 (''='ezetrol').
RECODE med7_dosering_T1 (''='10 mg').
RECODE med7_keerperdag_T1 (SYSMIS=1).
RECODE med7_aantdagen_T1 (SYSMIS=60).
RECODE med8_T1 (''='clopidogrel').
RECODE med8_dosering_T1 (''='75 mg').
RECODE med8_keerperdag_T1 (SYSMIS=1).
RECODE med8_aantdagen_T1 (SYSMIS=60).
END IF.
EXECUTE.


*** aparte syntaxen ATC code, dosering en kosten runnen. 

** Na runnen ATC>.

* Nicotinevervangers (N07BA01) worden uit de medicatie gehaald. Controle of ze bij vraag over nicotinevervangers worden genoemd. Zo nee, daar aanvullen.
DO IF atc1_T1='N07BA01'.
COMPUTE med1_T1=' '.
COMPUTE med1_dosering_T1=' '.
COMPUTE med1_keerperdag_T1=$SYSMIS.
COMPUTE med1_aantdagen_T1=$SYSMIS.
COMPUTE med1_vorm_T1=' '.
END IF.
RECODE atc1_T1 ('N07BA01'=' ').
EXECUTE.

DO IF atc2_T1='N07BA01'.
COMPUTE med2_T1=' '.
COMPUTE med2_dosering_T1=' '.
COMPUTE med2_keerperdag_T1=$SYSMIS.
COMPUTE med2_aantdagen_T1=$SYSMIS.
COMPUTE med2_vorm_T1=' '.
END IF.
RECODE atc2_T1 ('N07BA01'=' ').
EXECUTE.

DO IF atc3_T1='N07BA01'.
COMPUTE med3_T1=' '.
COMPUTE med3_dosering_T1=' '.
COMPUTE med3_keerperdag_T1=$SYSMIS.
COMPUTE med3_aantdagen_T1=$SYSMIS.
COMPUTE med3_vorm_T1=' '.
END IF.
RECODE atc3_T1 ('N07BA01'=' ').
EXECUTE.

DO IF atc4_T1='N07BA01'.
COMPUTE med4_T1=' '.
COMPUTE med4_dosering_T1=' '.
COMPUTE med4_keerperdag_T1=$SYSMIS.
COMPUTE med4_aantdagen_T1=$SYSMIS.
COMPUTE med4_vorm_T1=' '.
END IF.
RECODE atc4_T1 ('N07BA01'=' ').
EXECUTE.

DO IF atc5_T1='N07BA01'.
COMPUTE med5_T1=' '.
COMPUTE med5_dosering_T1=' '.
COMPUTE med5_keerperdag_T1=$SYSMIS.
COMPUTE med5_aantdagen_T1=$SYSMIS.
COMPUTE med5_vorm_T1=' '.
END IF.
RECODE atc5_T1 ('N07BA01'=' ').
EXECUTE.

DO IF atc7_T1='N07BA01'.
COMPUTE med7_T1=' '.
COMPUTE med7_dosering_T1=' '.
COMPUTE med7_keerperdag_T1=$SYSMIS.
COMPUTE med7_aantdagen_T1=$SYSMIS.
COMPUTE med7_vorm_T1=' '.
END IF.
RECODE atc7_T1 ('N07BA01'=' ').
EXECUTE.


* Nieuwe variabele: Champix gebruikt.
IF (MISSING(medicatie_T1)=1) Champix=9.
IF  (atc1_T1='N07BA03'  or atc2_T1='N07BA03' or atc3_T1='N07BA03'  or atc4_T1='N07BA03'  or atc5_T1='N07BA03'  or atc6_T1='N07BA03'  or atc7_T1='N07BA03'  or atc8_T1='N07BA03'  or
atc9_T1='N07BA03'  or atc10_T1='N07BA03') Champix=1.
EXECUTE.
RECODE Champix (SYSMIS=0).
EXECUTE.
FORMATS Champix (F1.0).
VARIABLE LEVEL Champix (NOMINAL).
VARIABLE LABELS Champix ' Champix gebruikt'.
VALUE LABELS Champix 0 'geen Champix gebruikt' 1 'Champix gebruikt'. 
MISSING VALUES Champix (9).

* Nieuwe variabele: Zyban gebruikt.
IF (MISSING(medicatie_T1)=1) Zyban=9.
IF  (atc1_T1='N06AX12'  or atc2_T1='N06AX12' or atc3_T1='N06AX12'  or atc4_T1='N06AX12'  or atc5_T1='N06AX12'  or atc6_T1='N06AX12'  or atc7_T1='N06AX12'  or atc8_T1='N06AX12'  or
atc9_T1='N06AX12'  or atc10_T1='N06AX12') Zyban=1.
EXECUTE.
RECODE Zyban (SYSMIS=0).
EXECUTE.
FORMATS Zyban (F1.0).
VARIABLE LEVEL Zyban (NOMINAL).
VARIABLE LABELS Zyban ' Zyban gebruikt'.
VALUE LABELS Zyban 0 'geen Zyban gebruikt' 1 'Zyban gebruikt'. 
MISSING VALUES Zyban (9).


*** Q93: EHBO********************************************************************************************************************************************.
RENAME VARIABLES Q93=EHBO_T1 / Q93_TEXT=EHBO_aant_keer_T1.
VARIABLE LABELS EHBO_T1 'EHBO ja/nee T1' EHBO_aant_keer_T1 'EHBO aantal keer T1'.
VALUE LABELS EHBO_T1 1 'nee' 2 'ja'.
* aantal keer van string naar numeriek.
* controle op tekst.
FREQUENCIES VARIABLES=EHBO_aant_keer_T1
  /ORDER=ANALYSIS.
ALTER TYPE EHBO_aant_keer_T1 (F3.0).

* wel naar EHBO en aant keer missing: conservatieve schatting.
DO IF EHBO_T1=2.
RECODE EHBO_aant_keer_T1 (SYSMIS=1).
END IF.
* wel naar EHBO en aant keer =0: conservatieve schatting.
DO IF EHBO_T1=2.
RECODE EHBO_aant_keer_T1 (0=1).
END IF.
EXECUTE.
* niet naar EHBO: aantal dagen =0.
DO IF (EHBO_T1=1).
RECODE EHBO_aant_keer_T1 (SYSMIS=0).
END IF.
* missings invullen.
RECODE EHBO_T1 (SYSMIS=9).
EXECUTE.
DO IF (EHBO_T1=9).
RECODE EHBO_aant_keer_T1 (SYSMIS=99).
END IF.
EXECUTE.
MISSING VALUES EHBO_T1 (9) EHBO_aant_keer_T1 (99).
VARIABLE LEVEL  EHBO_T1 (NOMINAL) EHBO_aant_keer_T1 (SCALE).
VARIABLE WIDTH  EHBO_T1 (4) EHBO_aant_keer_T1 (7).

*** Q94: ambulance********************************************************************************************************************************************.
RENAME VARIABLES Q94=ambulance_T1 / Q94_TEXT=ambulance_aant_keer_T1.
VARIABLE LABELS ambulance_T1 'ambulance ja/nee T1' ambulance_aant_keer_T1 'ambulance aantal keer T0'.
VALUE LABELS ambulance_T1 1 'nee' 2 'ja'.

* aantal keer van string naar numeriek.
* controle op tekst.
FREQUENCIES VARIABLES=ambulance_aant_keer_T1
  /ORDER=ANALYSIS.
ALTER TYPE ambulance_aant_keer_T1 (F3.0).

DO IF ambulance_T1=2.
RECODE ambulance_aant_keer_T1 (SYSMIS=1).
END IF.
DO IF ambulance_T1=1.
RECODE ambulance_aant_keer_T1 (SYSMIS=0).
END IF.
EXECUTE.
MISSING VALUES ambulance_aant_keer_T1 (99).
RECODE ambulance_T1 (SYSMIS=9).
EXECUTE.
DO IF (ambulance_T1=9).
RECODE ambulance_aant_keer_T1 (SYSMIS=99).
END IF.
EXECUTE.
MISSING VALUES ambulance_T1 (9) ambulance_aant_keer_T1 (99).
VARIABLE LEVEL ambulance_T1 (NOMINAL) ambulance_aant_keer_T1 (SCALE).

*** Q95: poli********************************************************************************************************************************************.
RENAME VARIABLES Q95=poli_T1.
VARIABLE LABELS poli_T1 'bezoek poli: ja/nee T1'.
VALUE LABELS poli_T1 1 'nee' 2 'ja'.

*missing toevoegen.
RECODE poli_T1 (SYSMIS=9).
MISSING VALUES poli_T1 (9).
EXECUTE.

*Q96_1_1_TEXT is excact hetzelfde als Q96_2_1_TEXT (specialisme, inclusief zelfde spelfouten) --> Q96_2 verwijderen.
DELETE VARIABLES  Q96_2_1_TEXT Q96_2_2_TEXT Q96_2_3_TEXT Q96_2_7_TEXT Q96_2_8_TEXT Q96_2_9_TEXT.

RENAME VARIABLES  Q96_1_1_TEXT=specialisme1_T1 /  Q96_1_2_TEXT=specialisme2_T1 /   Q96_1_3_TEXT=specialisme3_T1 / 
  Q96_1_7_TEXT=specialisme4_T1 /   Q96_1_8_TEXT=specialisme5_T1 /   Q96_1_9_TEXT=specialisme6_T1. 
RENAME VARIABLES  Q96_1_1_1_TEXT=ziekenhuis1_T1 / Q96_1_2_1_TEXT=ziekenhuis2_T1 / Q96_1_3_1_TEXT=ziekenhuis3_T1 / 
Q96_1_7_1_TEXT=ziekenhuis4_T1 / Q96_1_8_1_TEXT=ziekenhuis5_T1 / Q96_1_9_1_TEXT=ziekenhuis6_T1. 
RENAME VARIABLES  Q96_2_1_1_TEXT=spec1_aant_keer_T1 / Q96_2_2_1_TEXT=spec2_aant_keer_T1 / Q96_2_3_1_TEXT=spec3_aant_keer_T1 /
Q96_2_7_1_TEXT=spec4_aant_keer_T1 /Q96_2_8_1_TEXT=spec5_aant_keer_T1 /Q96_2_9_1_TEXT=spec6_aant_keer_T1.

VARIABLE LABELS specialisme1_T1 / specialisme2_T1 / specialisme3_T1 / specialisme4_T1 / specialisme5_T1 / specialisme6_T1. 
VARIABLE LABELS ziekenhuis1_T1 / ziekenhuis2_T1 / ziekenhuis3_T1 / ziekenhuis4_T1 / ziekenhuis5_T1 / ziekenhuis6_T1. 
VARIABLE LABELS  spec1_aant_keer_T1 / spec2_aant_keer_T1 / spec3_aant_keer_T1 /  spec4_aant_keer_T1 /spec5_aant_keer_T1 /spec6_aant_keer_T1.

*Ziekenhuis 5 en 6 zijn leeg: verwijderen.
DELETE VARIABLES  specialisme5_T1 specialisme6_T1  ziekenhuis5_T1  ziekenhuis6_T1 spec5_aant_keer_T1 spec6_aant_keer_T1.


** ID 5111 poli mustaertstichting - psycholoog. Dit is geen ziekenhuis. Consult psycholoog staat ook al bijconsulten eerste lijn, hier verwijderen.
DO IF ID_Code=5111.
RECODE ziekenhuis2_T1 ('mutsaerstichting'='').
RECODE specialisme2_T1 ('psycholoog'='').
RECODE spec2_aant_keer_T1 ('1'='').
END IF.
EXECUTE.

** specialisatie hetzelfde noemen.
** Is op T0 gedaan maar wordt verder niets mee gedaan. Hier voorlopig zo laten.

** ziekenhuizen hetzelfde noemen.
FREQUENCIES VARIABLES= ziekenhuis1_T1  ziekenhuis2_T1  ziekenhuis3_T1  ziekenhuis4_T1 
  /ORDER=ANALYSIS.

RECODE ziekenhuis1_T1  ('azm'='Maastricht UMC').
RECODE ziekenhuis1_T1  ('AZM'='Maastricht UMC').
RECODE ziekenhuis1_T1  ('Asz'='ASZ').
RECODE ziekenhuis1_T1  ('bravis'='Bravis').
RECODE ziekenhuis1_T1  ('Bravis Bergen op Zoom'='Bravis').
RECODE ziekenhuis1_T1  ('Bravis bergen op zoom'='Bravis').
RECODE ziekenhuis1_T1  ('bravis bergen op zoom'='Bravis').
RECODE ziekenhuis1_T1  ('CWZ'='Canisius-Wilhelmina ziekenhuis').
RECODE ziekenhuis1_T1  ('diagnosecentrum Lommel'='Diagnosecentrum Lommel').
RECODE ziekenhuis1_T1  ('elkerliek deurne'='Elkerliek').
RECODE ziekenhuis1_T1  ('franciscus rotterdam'='Franciscus Rotterdam').
RECODE ziekenhuis1_T1  ('Gelre apeldoorn'='Gelre').
RECODE ziekenhuis1_T1  ('Isala ziekenhuis Zwolle'='Isala Zwolle').
RECODE ziekenhuis1_T1  ('Isala klinieken'='Isala Zwolle').
RECODE ziekenhuis1_T1  ('Isala'='Isala Zwolle').
RECODE ziekenhuis1_T1  ('meander'='MeanderMC').
RECODE ziekenhuis1_T1  ('maxima medisch centrum'='MMC').
RECODE ziekenhuis1_T1  ('MMC Eindhoven'='MMC').
RECODE ziekenhuis1_T1  ('radboudumc'='Radboud').
RECODE ziekenhuis1_T1  ('Radboudumc'='Radboud').
RECODE ziekenhuis1_T1  ('radboudziekenhuis'='Radboud').
RECODE ziekenhuis1_T1  ('Radboudziekenhuis Nijmegen'='Radboud').
RECODE ziekenhuis1_T1  ('radbout'='Radboud').
RECODE ziekenhuis1_T1  ('rddg'='Reinier de Graaf').
RECODE ziekenhuis1_T1  ('Rijnstate arnhem'='Rijnstate').
RECODE ziekenhuis1_T1  ('SJG Weert'='Weert').
RECODE ziekenhuis1_T1  ('spaarne'='Spaarne Gasthuis').
RECODE ziekenhuis1_T1  ('Snt Lucas Andreas'='Sint Lucas Andreas').
RECODE ziekenhuis1_T1  ('Twwes steden'='Elisabeth - TweeSteden Ziekehuis').
RECODE ziekenhuis1_T1  ('Umc maastricht'='Maastricht UMC').
RECODE ziekenhuis1_T1  ('Maastricht umc'='Maastricht UMC').
RECODE ziekenhuis1_T1  ('Maastricht'='Maastricht UMC').
RECODE ziekenhuis1_T1  ('maastricht'='Maastricht UMC').
RECODE ziekenhuis1_T1  ('UMCM'='Universitair Medisch Centrum Utrecht').
RECODE ziekenhuis1_T1  ('viasana'='Viasana').
RECODE ziekenhuis1_T1  ('VieCuri'='Viecurie').
RECODE ziekenhuis1_T1  ('viecuri'='Viecurie').
RECODE ziekenhuis1_T1  ('zevenaar'='Rijnstate').
RECODE ziekenhuis1_T1  ('heerlen'='Zuyderland').
RECODE ziekenhuis1_T1  ('Heerlen'='Zuyderland').
RECODE ziekenhuis1_T1  ('zuyderland'='Zuyderland').
EXECUTE.

RECODE ziekenhuis2_T1  ('AZM'='Maastricht UMC').
RECODE ziekenhuis2_T1  ('bravis bergen op zoom'='Bravis').
RECODE ziekenhuis2_T1  ('CWZ'='Canisius-Wilhelmina ziekenhuis').
RECODE ziekenhuis2_T1  ('Gelre apeldoorn'='Gelre').
RECODE ziekenhuis2_T1  ('Isala'='Isala Zwolle').
RECODE ziekenhuis2_T1  ('maastricht'='Maastricht UMC').
RECODE ziekenhuis2_T1  ('mutsaerstichting'='Reinier de Graaf').
RECODE ziekenhuis2_T1  ('rddg'='Reinier de Graaf').
RECODE ziekenhuis2_T1  ('SJG Weert'='Weert').
RECODE ziekenhuis2_T1  ('spaarne'='Spaarne Gasthuis').
RECODE ziekenhuis2_T1  ('viecuri'='Viecurie').
RECODE ziekenhuis2_T1  ('zuyderland'='Zuyderland').
EXECUTE.

RECODE ziekenhuis3_T1  ('rddg'='Reinier de Graaf').
RECODE ziekenhuis3_T1  ('maastricht'='Maastricht UMC').
RECODE ziekenhuis3_T1  ('Isala'='Isala Zwolle').
EXECUTE.

RECODE ziekenhuis4_T1  ('rddg'='Reinier de Graaf').
EXECUTE.

** als ziekenhuis niet is ingevuld wordt het  onbekend'.
DO IF poli_T1=2.
RECODE ziekenhuis1_T1('*'='onbekend') (''='onbekend').
END IF.
DO IF poli_T1=2 and specialisme2_T1~= ''.
RECODE ziekenhuis2_T1(''='onbekend').
END IF.
DO IF poli_T1=2 and specialisme3_T1~= ''.
RECODE ziekenhuis3_T1(''='onbekend').
END IF.
EXECUTE.



** Ziekenhuis algemeen of academisch. 

RECODE ziekenhuis1_T1 ziekenhuis2_T1 ziekenhuis3_T1 ziekenhuis4_T1 (CONVERT) ('onbekend'=2)
('Aken'=1) ('Alrijne'=2) ('AMC Amsterdam'=1) ('Amphia'=2) ('Anthoniushove'=2) ('Antonie van Leeuwenhoek'=2) 
('ASZ'=2) ('AZM'=1) ('Bernhoven'=2) ('Bravis'=2) ('Canisius-Wilhelmina ziekenhuis'=2) 
('Catharina'=2) ('CWZ Nijmegen'=2) ('Dekkerswald'=2) ('Deventer'=2)  ('Diakonessenhuis'=2)  ('Diagnosecentrum Lommel'=2) 
('Elisabeth - TweeSteden Ziekehuis'=2) ('Elkerliek'=2) ('Erasmus'=1)  ('Franciscus Rotterdam'=2) ('Gelre'=2) ('Helmond'=2)
 ('Hoofddorp'=2) ('Ijsselland'=2) ('Ikazia'=2) ('Isala Zwolle'=2) ('Kliniek Lange VoorhouT'=2)
('Langeland'=2) ('Laurentius'=2) ('Linge polikliniek'=2) ('LUMC'=1) ('Maartenskliniek'=2) ('MeanderMC'=2) ('MMC'=2) ('Medisch centum alkmaar'=2) 
('Maasstad'=2)  ('Maastricht UMC'=1)  ('Mariaziekenhuis Overpelt'=2)
('MC Zuiderzee'=2) ('MCL Leeuwarden'=2) ('Meander'=2) ('MMC Veldhoven'=2) ('OLVG'=2) 
('Polikliniek Kampen'=2) ('Poli kanoën'=2) ('Radboud'=1) ('Reinier de Graaf'=2) ('Reinaert Kliniek'=2)
('Rijnstate'=2) ('Scheper'=2) ('Slotervaart'=2) ('SMT Enschede'=2) ('Sophia'=2) ('Spaarne Gasthuis'=2) 
('Spijkenisse MC'=2) ('St.jans'=2) ('st Anna Geldrop'=2) ('Sint Lucas Andreas'=2)  ('Sint maarten'=2)
('SZE'=2) ('UMCG'=1) ('Universitair Medisch Centrum Utrecht'=1) ('Viasana'=2)  ('Viecurie'=2) 
('Weert'=2) ('Westfries Gasthuis'=2) ('Zuyderland'=2) INTO ZH1_type_T1 ZH2_type_T1 ZH3_type_T1 ZH4_type_T1.
EXECUTE.

FORMATS ZH1_type_T1 ZH2_type_T1 ZH3_type_T1 ZH4_type_T1 (F1.0).
VALUE LABELS ZH1_type_T1 ZH2_type_T1 ZH3_type_T1 ZH4_type_T1 1  'academisch' 2 'algemeen'.  

** aantal keer van string naar numeriek.
* controle op tekst.
FREQUENCIES VARIABLES=spec1_aant_keer_T1 spec2_aant_keer_T1 spec3_aant_keer_T1 spec4_aant_keer_T1
  /ORDER=ANALYSIS.
ALTER TYPE spec1_aant_keer_T1 spec2_aant_keer_T1 spec3_aant_keer_T1 spec4_aant_keer_T1  (F2.0).

*Als het aantal keer missing is wordt het 1 (conservatieve schatting).
DO IF poli_T1=2.
RECODE spec1_aant_keer_T1 (SYSMIS=1).
END IF.
EXECUTE.


*** Q97: dagbehandeling ***************************************************************************************************************************************.
RENAME VARIABLES Q97=dagbehandeling_T1.
VARIABLE LABELS dagbehandeling_T1 'Dagbehandeling: ja/nee'.

RENAME VARIABLES Q98_1_TEXT =Dagbehandeling1_T1 / Q98_2_TEXT =Dagbehandeling2_T1 / Q98_3_TEXT =Dagbehandeling3_T1 / Q98_4_TEXT =Dagbehandeling4_T1 / 
Q98_5_TEXT =Dagbehandeling5_T1 / Q98_6_TEXT =Dagbehandeling6_T1.

* teksten verwijderen die niets zijn.
RECODE Dagbehandeling2_T1  ('o'='').
RECODE Dagbehandeling2_T1  ('-'='').
RECODE Dagbehandeling3_T1 ('0'='').
RECODE Dagbehandeling3_T1 ('-'='').
RECODE Dagbehandeling3_T1 ('nvt'='').
RECODE Dagbehandeling4_T1 ('0'='').
RECODE Dagbehandeling4_T1 ('-'='').
RECODE Dagbehandeling4_T1 ('nvt'='').
RECODE Dagbehandeling5_T1 ('0'='').
RECODE Dagbehandeling5_T1 ('-'='').
RECODE Dagbehandeling5_T1 ('nvt'='').
RECODE Dagbehandeling6_T1 ('0'='').
RECODE Dagbehandeling6_T1 ('-'='').
RECODE Dagbehandeling6_T1 ('nvt'='').
EXECUTE.

RENAME VARIABLES Q99_x1_TEXT=Dagbehandeling1_aant_keer_T1 / Q99_x2_TEXT =Dagbehandeling2_aant_keer_T1 / Q99_x3_TEXT =Dagbehandeling3_aant_keer_T1 / 
Q99_x4_TEXT =Dagbehandeling4_aant_keer_T1 / Q99_x5_TEXT =Dagbehandeling5_aant_keer_T1 / Q99_x6_TEXT =Dagbehandeling6_aant_keer_T1.
FORMATS Dagbehandeling1_aant_keer_T1 Dagbehandeling2_aant_keer_T1 Dagbehandeling3_aant_keer_T1 Dagbehandeling4_aant_keer_T1 
Dagbehandeling5_aant_keer_T1  Dagbehandeling6_aant_keer_T1 (F1.0).

* Indien aantal keer=0 --> 1 (conservatieve schatting).
RECODE  Dagbehandeling1_aant_keer_T1 Dagbehandeling2_aant_keer_T1 Dagbehandeling3_aant_keer_T1 Dagbehandeling4_aant_keer_T1 
Dagbehandeling5_aant_keer_T1  Dagbehandeling6_aant_keer_T1  (0=1).
EXECUTE.

* Indien aantal keer=missing --> 1 (conservatieve schatting).
DO IF Dagbehandeling1_T1 ~=  ''.
RECODE Dagbehandeling1_aant_keer_T1 (SYSMIS=1).
END IF.
DO IF Dagbehandeling2_T1 ~=  ''.
RECODE Dagbehandeling2_aant_keer_T1 (SYSMIS=1).
END IF.
DO IF Dagbehandeling3_T1 ~=  ''.
RECODE Dagbehandeling3_aant_keer_T1 (SYSMIS=1).
END IF.
DO IF Dagbehandeling4_T1 ~=  ''.
RECODE Dagbehandeling4_aant_keer_T1 (SYSMIS=1).
END IF.
DO IF Dagbehandeling5_T1 ~=  ''.
RECODE Dagbehandeling5_aant_keer_T1 (SYSMIS=1).
END IF.
DO IF Dagbehandeling6_T1 ~=  ''.
RECODE Dagbehandeling6_aant_keer_T1 (SYSMIS=1).
END IF.

* missings.
RECODE dagbehandeling_T1 (SYSMIS=9).
EXECUTE.
MISSING VALUES  dagbehandeling_T1 (9).
VARIABLE LEVEL   dagbehandeling_T1 (NOMINAL).
VARIABLE WIDTH   dagbehandeling_T1 (7).

VARIABLE LABELS Dagbehandeling1_T1 / Dagbehandeling2_T1 / Dagbehandeling3_T1 / Dagbehandeling4_T1 / Dagbehandeling5_T1 / Dagbehandeling6_T1 /
Dagbehandeling1_aant_keer_T1 / Dagbehandeling2_aant_keer_T1 / Dagbehandeling3_aant_keer_T1 / 
Dagbehandeling4_aant_keer_T1 / Dagbehandeling5_aant_keer_T1/  Dagbehandeling6_aant_keer_T1.

***Q100: opnames************************************************************************************************************************************************************************.
RENAME VARIABLES Q100_1_1=opname_ZH_T1 / Q100_2_1_1_TEXT = opname_ZH_aant_keer_T1 / Q100_3_1_1_TEXT = opname_ZH_aant_dagen_T1 . 
RENAME VARIABLES Q100_1_2=opname_rev_T1 / Q100_2_2_1_TEXT = opname_rev_aant_keer_T1 / Q100_3_2_1_TEXT = opname_rev_aant_dagen_T1. 
RENAME VARIABLES Q100_1_3=opname_psy_T1 / Q100_2_3_1_TEXT = opname_psy_aant_keer_T1 / Q100_3_3_1_TEXT = opname_psy_aant_dagen_T1.

VARIABLE LABELS opname_ZH_T1 'opname ziekenhuis: ja/nee T1'  opname_ZH_aant_dagen_T1 'opname ziekenhuis aantal dagen T1' 
opname_ZH_aant_keer_T1 'opname ziekenhuis aantal keer T1'  
 opname_rev_T1 'opname revalidatie: ja/nee T1'  opname_rev_aant_dagen_T1 'opname revalidatie aantal dagen T1' 
opname_rev_aant_keer_T1 'opname revalidatie aantal keer T1'  
 opname_psy_T1 'opname psychiatrie: ja/nee T1'  opname_psy_aant_dagen_T1 'opname psychiatrie aantal dagen T1' 
opname_psy_aant_keer_T1 'opname psychiatrie aantal keer T1' .

** aantal dagen en aantal keer van string naar numeriek.
* controle tekst.
FREQUENCIES VARIABLES=opname_ZH_aant_dagen_T1 opname_rev_aant_dagen_T1 opname_psy_aant_dagen_T1 
    opname_ZH_aant_keer_T1 opname_rev_aant_keer_T1 opname_psy_aant_keer_T1
  /ORDER=ANALYSIS.

ALTER TYPE opname_ZH_aant_dagen_T1 opname_rev_aant_dagen_T1 opname_psy_aant_dagen_T1 
    opname_ZH_aant_keer_T1 opname_rev_aant_keer_T1 opname_psy_aant_keer_T1 (F3.0).

** Als de vragenlijst ‘gefinished’ is de korte lijst is niet ingevuld (daarop staan geen vragen over opnames) , dan is een niet-ingevulde opname (missing) = geen opname (0).
DO IF ( Finished=1 and papier_T1<>2).
RECODE  opname_ZH_T1  opname_rev_T1 opname_psy_T1(SYSMIS=2).
END IF.
EXECUTE.

** ID 6708 heeft overal ja, en verder niets ingevuld -> ja wordt nee..
DO IF (ID_code=6708).
RECODE opname_ZH_T1 opname_rev_T1 opname_psy_T1 (1=2) .
END IF.
EXECUTE.

** als opname=ja, en aantal dagen missing: wordt 1 .
DO IF (opname_ZH_T1=1).
RECODE  opname_ZH_aant_dagen_T1  opname_ZH_aant_keer_T1 (SYSMIS=1).
END IF.
DO IF (opname_rev_T1=1).
RECODE  opname_rev_aant_dagen_T1  opname_rev_aant_keer_T1 (SYSMIS=1).
END IF.
DO IF (opname_psy_T1=1).
RECODE  opname_psy_aant_dagen_T1  opname_psy_aant_keer_T1 (SYSMIS=1).
END IF.

** ID 5308 heeft geen opname maar overal 0 ingevuld.
DO IF ID_code=5308.
RECODE opname_ZH_aant_dagen_T1  opname_ZH_aant_keer_T1 opname_rev_aant_dagen_T1  
opname_rev_aant_keer_T1 opname_psy_aant_dagen_T1  opname_psy_aant_keer_T1 (0=SYSMIS).
RECODE  Q100_4_1_1_TEXT  Q100_4_2_1_TEXT  Q100_4_3_1_TEXT ('00-00-0000'='').
END IF.


*** Datum omzetten van string naar date.
* streepjes etc verwijderen met als resultaat bv 01012001. Voorlopig alleen voor ziekenhuisopname, de rest komt niet voor.
RECODE Q100_4_1_1_TEXT ('23-3'='23032017') ('15-10-2016'= '15102016') ('28-04-2017'='28042017') ('30 okt'='30112016') ('10-11-2016'='10112016')
('25/10/16'='25102016') ('21-12-2016'='21122016') ('23jan'='23012016') ('07-04-2017'='07042017') ('10-02-2017'='10022017').
RECODE  Q100_4_3_1_TEXT ('14 juni'='14072016').
EXECUTE.

* Date and Time Wizard: opname_ZH_datum_T1. ** hij geeft foutmelding - negeren.
COMPUTE opname_ZH_datum_T1=date.dmy(number(substr(ltrim(Q100_4_1_1_TEXT),1,2),f2.0), 
    number(substr(ltrim(Q100_4_1_1_TEXT),3,2),f2.0), number(substr(ltrim(Q100_4_1_1_TEXT),5),f4.0)).
VARIABLE LABELS opname_ZH_datum_T1 'opname ZH datum T1'.
VARIABLE LEVEL  opname_ZH_datum_T1 (SCALE).
FORMATS opname_ZH_datum_T1 (EDATE10).
VARIABLE WIDTH  opname_ZH_datum_T1(10).
EXECUTE.

* opname revalidatie komt niet voor:.
RENAME VARIABLES (Q100_4_2_1_TEXT=opname_rev_datum_T1).

* Date and Time Wizard: opname_ZH_datum_T1.** hij geeft foutmelding - negeren.
COMPUTE opname_psy_datum_T1=date.dmy(number(substr(ltrim(Q100_4_3_1_TEXT),1,2),f2.0), 
    number(substr(ltrim(Q100_4_3_1_TEXT),3,2),f2.0), number(substr(ltrim(Q100_4_3_1_TEXT),5),f4.0)).
VARIABLE LABELS opname_psy_datum_T1 'opname psy datum T1'.
VARIABLE LEVEL  opname_psy_datum_T1 (SCALE).
FORMATS opname_psy_datum_T1 (EDATE10).
VARIABLE WIDTH  opname_psy_datum_T1(10).
EXECUTE.

DELETE VARIABLES Q100_4_1_1_TEXT Q100_4_3_1_TEXT.

*** opnamedatum moet maximaal 2 maanden voor invuldatum liggen.
* Date and Time Wizard: d_opnamedatum_invuldatum.
COMPUTE  d_opnamedatum_invuldatum_ZH=DATEDIF(opname_ZH_datum_T1, Invuldatum_T1, "weeks").
VARIABLE LABELS  d_opnamedatum_invuldatum_ZH "verschil opnamedatum ZH en invuldatum in weken".
VARIABLE LEVEL  d_opnamedatum_invuldatum_ZH (SCALE).
FORMATS  d_opnamedatum_invuldatum_ZH (F5.0).
VARIABLE WIDTH  d_opnamedatum_invuldatum_ZH(5).
EXECUTE.
COMPUTE  d_opnamedatum_invuldatum_psy=DATEDIF(opname_psy_datum_T1, Invuldatum_T1, "weeks").
VARIABLE LABELS  d_opnamedatum_invuldatum_psy "verschil opnamedatum psy en invuldatum in weken".
VARIABLE LEVEL  d_opnamedatum_invuldatum_psy (SCALE).
FORMATS  d_opnamedatum_invuldatum_psy (F5.0).
VARIABLE WIDTH  d_opnamedatum_invuldatum_psy(5).
EXECUTE.

* ID 1115	opname psychiatrie na invullen vragenlijst (invuldatum 16 juni 16, opnamedatum 14 juli 16), 5x opgenomen, 2 dagen. --> opnamedatum is waarschijnlijk 14 juni
5x kan niet kloppen, maar wordt ook niets mee gedaan, 2 dagen blijftgewoon staan.
DO IF ID_code=1115.
COMPUTE opname_ZH_datum_T1=Date.dmy(14,06,2016).
END IF.

* ID 1602	3 dagen opname ZH na invullen vragenlijst (invuldatum 8-11, opnamedatum 30-11)
Op T2 ingevuld: 2 dagen, 31-10  vergissing oktober/november? Op T1 veranderen in 30-10, op T2 geen opname.
DO IF ID_code=1602.
COMPUTE opname_ZH_datum_T1=Date.dmy(30,10,2016).
END IF.

* ID 4808	3 opnames, 5 dagen, datum 5 maanden voor invuldatum --> weg.
DO IF ID_code=4808.
RECODE opname_ZH_T1 (1=2).
RECODE opname_ZH_aant_keer_T1 (3=SYSMIS).
RECODE opname_ZH_aant_dagen_T1 (5=SYSMIS).
COMPUTE opname_ZH_datum_T1=$SYSMIS.
END IF.

*ID 3414	1 opname, 3 dagen, 47 weken voor invuldatum (invuldatum 2-3-17, opnamedatum 23-1-16)
	T0: geen opname   vergissing 2016 ingevuld ipv 2017.
DO IF ID_code=3414.
COMPUTE opname_ZH_datum_T1=Date.dmy(23,01,2017).
END IF.
EXECUTE.

*Nieuwe controle opnamedatum.
*** opnamedatum moet maximaal 2 maanden voor invuldatum liggen.
* Date and Time Wizard: d_opnamedatum_invuldatum.
COMPUTE  d_opnamedatum_invuldatum_ZH=DATEDIF(opname_ZH_datum_T1, Invuldatum_T1, "weeks").
VARIABLE LABELS  d_opnamedatum_invuldatum_ZH "verschil opnamedatum ZH en invuldatum in weken".
VARIABLE LEVEL  d_opnamedatum_invuldatum_ZH (SCALE).
FORMATS  d_opnamedatum_invuldatum_ZH (F5.0).
VARIABLE WIDTH  d_opnamedatum_invuldatum_ZH(5).
EXECUTE.
COMPUTE  d_opnamedatum_invuldatum_psy=DATEDIF(opname_psy_datum_T1, Invuldatum_T1, "weeks").
VARIABLE LABELS  d_opnamedatum_invuldatum_psy "verschil opnamedatum psy en invuldatum in weken".
VARIABLE LEVEL  d_opnamedatum_invuldatum_psy (SCALE).
FORMATS  d_opnamedatum_invuldatum_psy (F5.0).
VARIABLE WIDTH  d_opnamedatum_invuldatum_psy(5).
EXECUTE.

** Missings.
RECODE opname_ZH_T1  opname_rev_T1 opname_psy_T1  (SYSMIS=9).
EXECUTE.
MISSING VALUES opname_ZH_T1  opname_rev_T1 opname_psy_T1 (9).


*** NU syntax kosten zorggebruik T1 draaien***



*Q103 en verder: inkomen ****************************************************************************************************************************************************************.
RENAME VARIABLES Q103=netto_inkomen_T1  / Q104= omvang_huishouden_T1 / Q104_TEXT=huishouden_aant_pers_T1 / Q129.1=huishouden_aant_kinderen_T1 /
Q105 = inkomen_rondkomen_T1.
VALUE LABELS omvang_huishouden_T1 1 'één persoon' 2 'meer dan één persoon'.
**huishouden_aant_pers_T1 van string naar numeriek.
* controle op tekst.
RECODE huishouden_aant_pers_T1 ('4 bijna 5'='5') ('3,5'='4') .
EXECUTE.
ALTER TYPE huishouden_aant_pers_T1 (F3.0).

**huishouden_aant_kinderen_T1 van string naar numeriek.
* controle op tekst.
RECODE huishouden_aant_kinderen_T1 ('geen'='0') ('Geen'='0') ('2 ,bijna 3'='3') ('1,5'='2') .
EXECUTE.
ALTER TYPE huishouden_aant_kinderen_T1 (F3.0).

VARIABLE LABELS huishouden_aant_pers_T1 'aantal personen in huishouden T1'.
VARIABLE LABELS  huishouden_aant_kinderen_T1 'aantal minderjarigen in huishouden T1'.
VARIABLE LABELS  netto_inkomen_T1 'netto gezinsinkomen T1'.
VARIABLE LABELS omvang_huishouden_T1 'een-of meerpersoons huishouden T1'.
FORMATS huishouden_aant_kinderen_T1 (F2.0).

**Als omvang_huishouden=1 , dan is aantal personen dus 1 en aantal kinderen 0 (nu missing).
DO IF (omvang_huishouden_T1=1).
RECODE huishouden_aant_pers_T1 (SYSMIS=1).
RECODE huishouden_aant_kinderen_T1 (SYSMIS=0).
END IF.
EXECUTE.

** Als omvang huishouden= meer dan 1 en aantal=1 --> omvang huishouden veranderen in eenpersoons.
DO IF (huishouden_aant_pers_T1=1).
RECODE omvang_huishouden_T1 (2=1).
END IF.
EXECUTE.

** Als omvang huishouden= meer dan 1 en aantal=0 --> omvang huishouden veranderen in eenpersoons en aantal=1.
DO IF (huishouden_aant_pers_T1=0).
RECODE omvang_huishouden_T1 (2=1).
RECODE huishouden_aant_pers_T1 (0=1).
END IF.
EXECUTE.

** berekenen individueel inkomen.
RECODE netto_inkomen_T1 (1=375) (2=875) (3=1125) (4=1375) (5=1750) (6=2250) (7=2750) (8=3250) (9=3750) (10=4250) (11=4750) (12=5250) (13=5750)
INTO netto_inkomen_continu_T1.
COMPUTE ind_inkomen_T1=netto_inkomen_continu_T1/SQRT(huishouden_aant_pers_T1).
VARIABLE LABELS  ind_inkomen_T1 'individueel inkomen T1'.
EXECUTE.

** Missings.
RECODE netto_inkomen_T1 omvang_huishouden_T1 huishouden_aant_pers_T1 huishouden_aant_kinderen_T1 inkomen_rondkomen_T1 (SYSMIS=99).
RECODE netto_inkomen_continu_T1 ind_inkomen_T1 (SYSMIS=9999).
EXECUTE.

MISSING VALUES netto_inkomen_T1 (14,99) omvang_huishouden_T1 huishouden_aant_pers_T1 huishouden_aant_kinderen_T1 (99) inkomen_rondkomen_T1 (7,99)
netto_inkomen_continu_T1 ind_inkomen_T1 (9999).

VARIABLE LEVEL netto_inkomen_T1 inkomen_rondkomen_T1 (ORDINAL) omvang_huishouden_T1 (NOMINAL).


*Q136 en verder: evaluatie groepstraining *************************************************************************************************************************************************.


RENAME VARIABLES Q136_4=eval_vr_a / Q136_5=eval_vr_b / Q136_6=eval_vr_c / Q136_7=eval_vr_d / Q136_8=eval_vr_e / Q136_9=eval_vr_f / 
Q136_10=eval_vr_g / Q136_11=eval_vr_h / Q136_12=eval_vr_i / Q136_13=eval_vr_j / Q136_14=eval_vr_k / Q136_15=eval_vr_l / Q136_16=eval_vr_m / 
Q136_17=eval_vr_n / Q136_18=eval_vr_o / Q136_19=eval_vr_p. 

VARIABLE LABELS 
eval_vr_a 'Ik vond het programma interessant' 
eval_vr_b 'Ik vond het programma leerzaam'
eval_vr_c 'Ik vond het programma  duidelijk'
eval_vr_d 'Ik vond het programma  leuk'
eval_vr_e 'Ik heb voldoende informatie over stoppen met roken ontvangen'
eval_vr_f 'Meedoen aan het  programma kostte mij veel moeite'
eval_vr_g 'Meedoen met het programma nam veel tijd in beslag'
eval_vr_h 'Ik vond de totale tijdsduur van het programma goed'
eval_vr_i 'Het programma heeft aan mijn behoeften voldaan'
eval_vr_j 'Ik zal het aanraden om aan de training mee te doen, als iemand mij dat vraagt'
eval_vr_k 'Ik ben tevreden over de kwaliteit van het  programma'
eval_vr_l 'Ik ben tevreden over de soort hulp die ik via het programma heb ontvangen'
eval_vr_m 'De communicatie tijdens het programma tussen mijn coach en mij verliep goed'
eval_vr_n 'Doordat ik met het programma heb meegedaan weet ik hoe ik kan voorkomen dat ik terugval in mijn oude rookgewoonten'
eval_vr_o 'Doordat ik met het programma heb meegedaan weet ik hoe ik kan omgaan met lastige situaties'
eval_vr_p 'Doordat ik met het programma heb meegedaan heb ik er vertrouwen in dat ik kan stoppen met roken'.

MISSING VALUES  eval_vr_a eval_vr_b eval_vr_c eval_vr_d eval_vr_e eval_vr_f eval_vr_g eval_vr_h eval_vr_i 
    eval_vr_j eval_vr_k eval_vr_l eval_vr_m eval_vr_n eval_vr_0 eval_vr_p (6).

RENAME VARIABLES Q137=toelichting_med Q139=toelichting_nicotineverv.
VALUE LABELS toelichting_med toelichting_nicotineverv  1 '1' 2  '2' 3  '3' 4 '4' 5 '5' 6 '6' 7 '7' 8 '8' 9 '9' 10 '10' 11 'weet niet'.
MISSING VALUES toelichting_med toelichting_nicotineverv (11).

RENAME VARIABLES Q138_4= belang_buddy Q138_5=belang_weddenschap Q138_6=belang_belofte Q138_7=belang_boekje Q138_8= belang_COmeting 
Q138_9=belang_med_nictverv Q138_10=belang_groep Q138_11=belang_certificaat Q140=cijfer_training.
VALUE LABELS  belang_buddy belang_weddenschap belang_belofte belang_boekje belang_COmeting belang_med_nictverv belang_groep belang_certificaat
1 '1' 2  '2' 3  '3' 4 '4' 5 '5' 6 '6' 7 '7' 8 '8' 9 '9' 10 '10' 11 'weet niet'.
VARIABLE LABELS  belang_buddy 'belang van het buddy-en' belang_weddenschap 'belang van de weddenschap' belang_belofte 'belang van de belofte'
belang_boekje 'belang van het boekje' belang_COmeting 'belang van de CO-meting' belang_med_nictverv 'belang van het gebruik van medicatie/nicotinevervangers'
belang_groep 'belang van het samen stoppen in een groep' belang_certificaat 'belang van het certificaat (tijdens de laatste bijeenkomst)'.
MISSING VALUES  belang_buddy belang_weddenschap belang_belofte belang_boekje belang_COmeting belang_med_nictverv belang_groep belang_certificaat (11).

RENAME VARIABLES Q141_4=training_werk1  Q141_5=training_werk2   Q141_6=training_werk3  Q141_7=training_werk4  Q141_8=training_werk5.
MISSING VALUES training_werk1 training_werk2 training_werk3 training_werk4 training_werk5 (6).
VARIABLE LABELS training_werk1 'Ik vind het goed dat mijn bedrijf aanbiedt om een stoppen-met-roken training te volgen'
training_werk2 'Ik vond het prettig om het programma samen met collegas te volgen'
training_werk3 'De mogelijkheid om de training binnen het bedrijf te volgen gaf mij een extra stimulans om te stoppen met roken'
training_werk4 'Als mijn bedrijf geen stoppen-met-roken training had mogelijk gemaakt was ik nu ook gestopt met roken'
training_werk5 'Ik zou liever een stoppen-met-roken cursus buiten mijn werk om hebben gevolgd'.


RENAME VARIABLES Q142=training_werk6  Q143=training_werk7  Q144=training_werk8  Q145=training_werk9  Q146=training_werk10  Q147=training_werk11.
* training_werk10 is vreemd gecodeerd: omcoderen.
RECODE training_werk10 (4=1) (11=2) (12=3) (13=4).
VALUE LABELS training_werk10 1 '(Bijna) nooit' 2 'Soms' 3 'Vaak' 4 '(Bijna) altijd'.

*** Variabelen verwijderen die omgezet zijn naar numeriek.
DELETE VARIABLES Q133 Q64 Q65 Q67 Q71.
EXECUTE.

















