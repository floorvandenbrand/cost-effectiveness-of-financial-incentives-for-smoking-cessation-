* Encoding: UTF-8.
* Encoding: .
* Om te zorgen dat decimalen met een punt worden geschreven (van belang bij omzetten string naar numeriek).
SET LOCALE = 'en_US'.

***RecordedDate************************************************************************************************************************************************************.
FORMATS V8 (DATE11).
RENAME VARIABLES V8 = Invuldatum_T4.
VARIABLE LABELS Invuldatum_T4.

*ID_code (voornaam) is hierin samengevoegd met achternaam************************************************************************************************************.

STRING  temp (A40). 
COMPUTE temp=CHAR.LPAD(V3,40). 
EXECUTE.

STRING  ID_code (A4). 
COMPUTE ID_code=CHAR.SUBSTR(temp,37). 
EXECUTE.

ALTER TYPE ID_code (F4.0).

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

*Handmatig dubbele cases controleren adhv diverse antwoorden. Indien inderdaad dubbel, de meest compleet ingevuld bewaren.
*Indien het niet dezelfde persoon is, checken bij Floor en aanpassen.

FILTER OFF.
USE ALL.
SELECT IF (V1~= 'R_2q2WQbBeIAAoPKt' and V1~='R_3PIT2mfZxlP9Cbn' and V1~='R_2rpb3lTNwX3jlBs').
EXECUTE.

 *** Toevoegen variabele die aangeeft of vragenlijst op papier is ingevuld.
IF  (ID_code=2013 or ID_code=2102 or ID_code= 2103 or ID_code= 2104 or ID_code= 2105
or ID_code=2108 or ID_code= 2109 or ID_code= 2114 or ID_code=4903 or ID_code=4908 or ID_code=4909  or ID_code=4917 or ID_code=4919)  papier_T4=2.
IF (ID_code= 1508 or ID_code= 2906 or ID_code= 2907 or ID_code=3606  or ID_code=4916 or ID_code=6810) papier_T4=1.
EXECUTE.
RECODE papier_T4 (SYSMIS=0).
EXECUTE.
FORMATS papier_T4 (F1.0).
VALUE LABELS papier_T4 0  'digitaal ingevuld' 1 'volledige lijst op papier' 2 'verkorte lijst op papier'.
VARIABLE LABELS papier_T4 'lijst is op papier ingevuld T4' .

** bij invullen op papier wordt automatisch als invuldatum de datum van invoeren op HAG gegenereerd. Dit corrigeren met datum op vragenlijst.
IF (ID_Code=1508) Invuldatum_T4=Date.dmy(25,11,2017).
* ID 2013 datum niet ingevuld: zelfde als rest van 20.
IF (ID_Code=2013) Invuldatum_T4=Date.dmy(24,10,2017).
IF (ID_Code=2102) Invuldatum_T4=Date.dmy(28,11,2017).
IF (ID_Code=2103) Invuldatum_T4=Date.dmy(28,11,2017).
IF (ID_Code=2104) Invuldatum_T4=Date.dmy(28,11,2017).
IF (ID_Code=2105) Invuldatum_T4=Date.dmy(28,11,2017).
IF (ID_Code=2108) Invuldatum_T4=Date.dmy(28,11,2017).
IF (ID_Code=2109) Invuldatum_T4=Date.dmy(28,11,2017).
* ID 2114 datum niet ingevuld: zelfde als rest van 21.
IF (ID_Code=2114) Invuldatum_T4=Date.dmy(28,11,2017).
IF (ID_Code=2906) Invuldatum_T4=Date.dmy(06,12,2017).
* ID 2907 datum niet ingevuld: zelfde als 2906.
IF (ID_Code=2907) Invuldatum_T4=Date.dmy(06,12,2017).
IF (ID_Code=3606) Invuldatum_T4=Date.dmy(11,01,2018).
IF (ID_Code=4903) Invuldatum_T4=Date.dmy(31,03,2018).
IF (ID_Code=4908) Invuldatum_T4=Date.dmy(31,03,2018).
IF (ID_Code=4909) Invuldatum_T4=Date.dmy(31,03,2018).
IF (ID_Code=4916) Invuldatum_T4=Date.dmy(05,04,2018).
IF (ID_Code=4917) Invuldatum_T4=Date.dmy(21,03,2018).
IF (ID_Code=4919) Invuldatum_T4=Date.dmy(06,04,2018).
* ID 6810 datum niet ingevuld, zelfde als 4916 (tegelijk binnen gekomen).
IF (ID_Code=6810) Invuldatum_T4=Date.dmy(05,04,2018).
EXECUTE.

*lege records: deze verwijderen.
USE ALL.
SELECT IF (ID_Code ne 2001).
EXECUTE.

** een code is niet volledig ingevuld: 610 moet zijn 6103.
RECODE ID_code (610=6103).
EXECUTE.

RENAME VARIABLES V10=Finished.
VARIABLE LEVEL Finished (NOMINAL).

*** Deelnemers in analyse selecteren.
*** Bestand mergen met 'deelnemers analyse.sav. Optie 0ne-to-many, Selected look up table = in analyse.sav.
FILTER OFF.
USE ALL.
SELECT IF (in_analyse=1).
EXECUTE.

** Enkele variabelen zijn alleen toelichting (voor iedereen 1).
DELETE VARIABLES Q1 Q2 Q20 Q26 Q28 Q32 Q37 Q43 Q49 Q60 Q64 Q65 Q87 Q97 Q117.


****************************************************************************************************************************************************************************
*** roken*******************************************************************************************************************************************************************.
RENAME VARIABLES  Q3=gerookt_T4 / Q3_TEXT=gerookt_aant_sig_T4.
VARIABLE LABELS gerookt_T4 'gerookt afgelopen 6 mnd T4' gerookt_aant_sig_T4 'aant sig gerookt afgelopen 6 mnd T4'.
VARIABLE LEVEL gerookt_T4 (NOMINAL).
VARIABLE WIDTH gerookt_T4 (7).
VALUE LABELS gerookt_T4 1 'Nee' 2 'Ja' .


** aant sigaretten van string naar numeriek.
** controle tekst.
FREQUENCIES VARIABLES=gerookt_aant_sig_T4
  /ORDER=ANALYSIS.

* ID 6901. geeft aan: e-sigaret --> roken=nee.
DO IF ID_code=6901.
RECODE gerookt_T4 (2=1).
RECODE gerookt_aant_sig_T4 ('e sigaret' = '  ').
END IF.
EXECUTE.

** omzetten naar numeriek, eerst div aanpassingen.
* gaat over 6 maanden=26 weken.
RECODE gerookt_aant_sig_T4 ('veel'='99999').
RECODE gerookt_aant_sig_T4 ('te veel'='99999').
RECODE gerookt_aant_sig_T4 ('Ontelbaar'='99999').
RECODE gerookt_aant_sig_T4 ('geen idee'='99999').
RECODE gerookt_aant_sig_T4 ('elke dag weer'='99999').
RECODE gerookt_aant_sig_T4 ('Ben helaas weer begonnen'='99999').
RECODE gerookt_aant_sig_T4 ('?'='99999').
RECODE gerookt_aant_sig_T4 ('af en toe 1'='99999').
RECODE gerookt_aant_sig_T4 ('onbekend'='99999').
RECODE gerookt_aant_sig_T4 ('Teveel'='99999').
RECODE gerookt_aant_sig_T4 ('teveel'='99999').
RECODE gerookt_aant_sig_T4 ('heel veel'='99999').
RECODE gerookt_aant_sig_T4 ('Meerdere pakjes'='99999').
RECODE gerookt_aant_sig_T4 ('niet geteld'='99999').
RECODE gerookt_aant_sig_T4 ('Gedampt'='99999').
RECODE gerookt_aant_sig_T4 ('weet niet'='99999').
RECODE gerookt_aant_sig_T4 ('sigaartjes'='99999').
RECODE gerookt_aant_sig_T4 ('Niet gestopt'='99999').
RECODE gerookt_aant_sig_T4 ('sinds 1 augustus'='99999').
RECODE gerookt_aant_sig_T4 ('∞'='99999').
RECODE gerookt_aant_sig_T4 ('ja'='99999').
RECODE gerookt_aant_sig_T4 ('Dagelijks'='99999').
RECODE gerookt_aant_sig_T4 ('Meer dan 20'='99999').
RECODE gerookt_aant_sig_T4 ('Nee'='0').
RECODE gerookt_aant_sig_T4 ('1 sigaret ...eenmalig zwakte moment...'='1').
RECODE gerookt_aant_sig_T4 ('3 stuks'='3').
RECODE gerookt_aant_sig_T4 ('Ja 12'='12').
RECODE gerookt_aant_sig_T4 ('Pakje'='20').
RECODE gerookt_aant_sig_T4 ('20 x.'='20').
RECODE gerookt_aant_sig_T4 ('&gt;20'='20').
RECODE gerookt_aant_sig_T4 ('2 maanden a 8 sigaretten per dag'='112').
RECODE gerookt_aant_sig_T4 ('200+'='200').
RECODE gerookt_aant_sig_T4 ('3 sigaretten per dag'='546').
RECODE gerookt_aant_sig_T4 ('600 (laatste 3 maanden)'='600').
RECODE gerookt_aant_sig_T4 ('4 per dag'='784').
RECODE gerookt_aant_sig_T4 ('3 tot 5 pd'='784').
RECODE gerookt_aant_sig_T4 ('1000?'='1000').
RECODE gerookt_aant_sig_T4 ('5 per dag'='910').
RECODE gerookt_aant_sig_T4 ('5 p.d.'='910').
RECODE gerookt_aant_sig_T4 ('plusminus 5 p/d'='910').
RECODE gerookt_aant_sig_T4 ('6 per dag'='1092').
RECODE gerookt_aant_sig_T4 ('+/- 7 per dag'='1274').
RECODE gerookt_aant_sig_T4 ('8 per dag'='1456').
RECODE gerookt_aant_sig_T4 ('10 per dag'='1820').
RECODE gerookt_aant_sig_T4 ('+/-10per dag'='1820').
RECODE gerookt_aant_sig_T4 ('half pakje per dag'='1820').
RECODE gerookt_aant_sig_T4 ('1/2 pakje p.dag'='1820').
RECODE gerookt_aant_sig_T4 ('10 per dag of meer'='1820').
RECODE gerookt_aant_sig_T4 ('10 pd'='1820').
RECODE gerookt_aant_sig_T4 ('10/dag'='1820').
RECODE gerookt_aant_sig_T4 ('dagelijks 10 sigaretten'='1820').
RECODE gerookt_aant_sig_T4 ('10 perdag'='1820').
RECODE gerookt_aant_sig_T4 ('10 pdag'='1820').
RECODE gerookt_aant_sig_T4 ('10 p.d.'='1820').
RECODE gerookt_aant_sig_T4 ('Dagelijks, 10 tot 15'='1820').
RECODE gerookt_aant_sig_T4 ('12 per dag'='2184').
RECODE gerookt_aant_sig_T4 ('13 pd'='2366').
RECODE gerookt_aant_sig_T4 ('15 per dag'='2730').
RECODE gerookt_aant_sig_T4 ('15 pd'='2730').
RECODE gerookt_aant_sig_T4 ('15 p.d'='2730').
RECODE gerookt_aant_sig_T4 ('Gemiddeld 15 per dag'='2730').
RECODE gerookt_aant_sig_T4 ('15 p/dag'='2730').
RECODE gerookt_aant_sig_T4 ('15-20 per dag'='2730').
RECODE gerookt_aant_sig_T4 ('16 per dag'='2912').
RECODE gerookt_aant_sig_T4 ('Wekelijks 4 pakjes a 20 sigaretten'='2080').
RECODE gerookt_aant_sig_T4 ('+/- 3600'='3640').
RECODE gerookt_aant_sig_T4 ('20 per dag'='3640').
RECODE gerookt_aant_sig_T4 ('20 p/d'='3640').
RECODE gerookt_aant_sig_T4 ('20 pd'='3640').
RECODE gerookt_aant_sig_T4 ('+- 20per dag'='3640').
RECODE gerookt_aant_sig_T4 ('+- 20 per dag'='3640').
RECODE gerookt_aant_sig_T4 ('pakje per dag'='3640').
RECODE gerookt_aant_sig_T4 ('Een pakje shag in 2 dagen'='3640').
RECODE gerookt_aant_sig_T4 ('25 per dag'='4550').
RECODE gerookt_aant_sig_T4 ('27 pd'='4914').
RECODE gerookt_aant_sig_T4 ('30 per dag'='5460').
EXECUTE.

*indien gerookt is ja en aantal sig is niet ingevuld.
DO IF gerookt_T4=2.
RECODE gerookt_aant_sig_T4 (''='99999').
END IF.
EXECUTE.

ALTER TYPE gerookt_aant_sig_T4 (F5.0).

MISSING VALUES gerookt_aant_sig_T4 (99999).
VARIABLE LEVEL gerookt_aant_sig_T4 (SCALE).
VARIABLE WIDTH gerookt_aant_sig_T4 (8).

RENAME VARIABLES Q8=stoppoging_T4/ Q4=gerookt_7d_T4/ Q5=stoppen_T4.
VARIABLE LABELS stoppoging_T4 'afgelopen 3 mnd stoppoging gedaan'.
VARIABLE LABELS gerookt_7d_T4 'afgelopen 7 dagen gerookt'.
VARIABLE LABELS stoppen_T4 'voornemen te stoppen'.

** stoppoging onlogische codering: hercoderen.
RECODE stoppoging_T4 (2=1) (3=2).
EXECUTE.
* Missings en nvt toevoegen.
DO IF gerookt_T4=2.
RECODE stoppoging_T4 (SYSMIS=9).
END IF.
DO IF gerookt_T4=1.
RECODE stoppoging_T4 (SYSMIS=8).
END IF.
EXECUTE.
VALUE LABELS stoppoging_T4 1 'Ja' 2 'Nee' 8 'nvt'.
MISSING VALUES stoppoging_T4 (9).

** gerookt 7 dagen is onlogisch gecodeerd.
RECODE gerookt_7d_T4 (1=1) (3=2).
EXECUTE.
VALUE LABELS gerookt_7d_T4 1 'Ja' 2 'Nee'.

** stoppen_T4 onlogische codering: hercoderen.
RECODE stoppen_T4 (4=1) (5=2) (6=3) (7=4) (8=5).
EXECUTE.

* Missings en nvt toevoegen.
DO IF gerookt_7d_T4=2.
RECODE stoppen_T4 (SYSMIS=8).
END IF.
DO IF gerookt_7d_T4=1.
RECODE stoppen_T4 (SYSMIS=9).
END IF.
EXECUTE.
VALUE LABELS stoppen_T4 1 'binnen nu en een maand' 2 'binnen 6 maanden'  3 'in de toekomst maar niet binnen 6 maanden' 4 'nee,nooit' 5 'weet niet'  8 'nvt'.
VARIABLE LEVEL stoppoging_T4 gerookt_7d_T4 stoppen_T4 (NOMINAL).

RENAME VARIABLES Q6=roken7_T4 / Q7=stoppen1a_T4 / Q9=stoppen2a_T4 / Q10=stoppen3a_T4 / Q11=stoppen1b_T4 / Q12=stoppen2b_T4 / Q13=stoppen3b_T4.
VARIABLE LEVEL roken7_T4 (NOMINAL).

** stoppen1a en b en 3 a en b zijn onlogisch gecodeerd (anders dan bij T0).
RECODE stoppen1a_T4 stoppen1b_T4  stoppen3a_T4 stoppen3b_T4 (4=1) (5=2) (6=3) (7=4) (8=5).
EXECUTE.

** Indien afgelopen dagen gerookt (gerookt_7d_T4)=nee de vragen ‘blijvend’ aanhouden, indien afgelopen dagen gerookt=ja de vragen ‘binnen 3 maanden’ aanhouden, 
deze combineren tot 1 variabele.

DO IF gerookt_7d_T4=2.
COMPUTE stoppen1_T4=stoppen1a_T4.
COMPUTE stoppen2_T4=stoppen2a_T4.
COMPUTE stoppen3_T4=stoppen3a_T4.
END IF.
DO IF gerookt_7d_T4=1.
COMPUTE stoppen1_T4=stoppen1b_T4.
COMPUTE stoppen2_T4=stoppen2b_T4.
COMPUTE stoppen3_T4=stoppen3b_T4.
END IF.
EXECUTE.

VALUE LABELS stoppen1_T4  1 'zeer verstandig' 2 'verstandig' 3 'niet verstandig, maar ook niet onverstandig' 4 'onverstandig' 5 'zeer onverstandig'.
VALUE LABELS stoppen2_T4  1 'zeer plezierig' 2 'plezierig' 3 'niet plezierig, maar ook niet onplezierig' 4 'onplezierig' 5 'zeer onplezierig'.
VALUE LABELS stoppen3_T4  1 'zeer positief' 2 'positief' 3 'niet positief, maar ook niet negatief' 4 'negatief' 5 'zeer negatief'.
VARIABLE LABELS stoppen1_T4 'Als u blijvend niet rookt/binnen 3 mnd stopt, is dat verstandig/onverstandig'.
VARIABLE LABELS stoppen2_T4 'Als u blijvend niet rookt/binnen 3 mnd stopt, is dat plezierig/onplezierig'.
VARIABLE LABELS stoppen3_T4 'Als u blijvend niet rookt/binnen 3 mnd stopt, is dat positief/negatief'.
FORMATS stoppen1_T4 stoppen2_T4 stoppen3_T4 (F1.0).
VARIABLE WIDTH stoppen1_T4 stoppen2_T4 stoppen3_T4 (7).

DELETE VARIABLES stoppen1a_T4 stoppen1b_T4 stoppen2a_T4 stoppen2b_T4 stoppen3a_T4 stoppen3b_T4.

RENAME VARIABLES Q14=stoppen4_T4 / Q15=stoppen5_T4.
VARIABLE WIDTH stoppen4_T4 stoppen5_T4 (7).
*Stoppen4_T4 en stoppen5_T4 zijn onlogisch gecodeerd.
RECODE stoppen4_T4 (4=1) (6=2) (7=3) (8=4).
RECODE stoppen5_T4 (4=1) (5=2) (6=3) (7=4) (8=5).
EXECUTE.
VALUE LABELS stoppen4_T4 1 'nooit' 2 'soms' 3 'vaak' 4 '(bijna) altijd'. 
VALUE LABELS stoppen5_T4 1 '(Bijna) allemaal positief' 2 'meestal positief' 3 'Even vaak positief als negatief' 4 'meestal negatief' 5  '(Bijna) allemaal negatief'. 

*Indien stoppen4 =1 (nooit), dan moet stoppen5 missing zijn.

USE ALL.
COMPUTE filter_$=(stoppen4_T4=1).
VARIABLE LABELS filter_$ 'stoppen4_T4=1 (FILTER)'.
VALUE LABELS filter_$ 0 'Not Selected' 1 'Selected'.
FORMATS filter_$ (f1.0).
FILTER BY filter_$.
EXECUTE.
FREQUENCIES VARIABLES=stoppen5_T4
  /ORDER=ANALYSIS.
USE ALL.

** deze missing wordt nvt (nieuwe code).
IF  (stoppen4_T4=1) stoppen5_T4=8.
EXECUTE.
VALUE LABELS stoppen5_T4 1 '(bijna) allemaal positief' 2 'meestal positief'  3 'even vaak positief als negatief' 4 'meestal negatief' 5 '(bijna) allemaal negatief' 8 'nvt'. 

RENAME VARIABLES Q16=stoppen6_T4. 
VARIABLE LABELS stoppen6_T4 'Hoe denkt u dat de meeste mensen die belangrijk voor u zijn het zouden vinden als u de komende 3 maanden niet rookt/stopt met roken'.

RENAME VARIABLES Q17_1=stoppen7a1_T4 /  Q17_2=stoppen7b1_T4 /  Q17_3=stoppen7c1_T4 / Q17_4=stoppen7d1_T4 / Q17_5=stoppen7e1_T4 /
Q18_1=stoppen7a2_T4 /  Q18_2=stoppen7b2_T4 /  Q18_3=stoppen7c2_T4 / Q18_4=stoppen7d2_T4 / Q18_5=stoppen7e2_T4. 

VARIABLE WIDTH  stoppen7a1_T4 stoppen7b1_T4 stoppen7c1_T4 stoppen7d1_T4 stoppen7e1_T4 stoppen7a2_T4 stoppen7b2_T4 stoppen7c2_T4 stoppen7d2_T4 stoppen7e2_T4 (7). 
VARIABLE LEVEL  stoppen7a1_T4 stoppen7b1_T4 stoppen7c1_T4 stoppen7d1_T4 stoppen7e1_T4 stoppen7a2_T4 stoppen7b2_T4 stoppen7c2_T4 stoppen7d2_T4 stoppen7e2_T4 (ORDINAL). 

*** Q19: gewicht van string naar numeriek************************************************************************************************************************************************.
* tekst verwijderen, decimaal met komma.
STRING temp1 (A20).
COMPUTE temp1=REPLACE(Q19, 'kg','').
EXECUTE.

STRING temp2 (A20).
COMPUTE temp2=REPLACE(temp1, 'kilogram','').
EXECUTE.

STRING temp3 (A20).
COMPUTE temp3=REPLACE(temp2,',','.').
EXECUTE.

STRING temp4 (A20).
COMPUTE temp4=REPLACE(temp3,'kilo','').
EXECUTE.

STRING temp5 (A20).
COMPUTE temp5=REPLACE(temp4,'ongeveer','').
EXECUTE.

STRING temp6 (A20).
COMPUTE temp6=REPLACE(temp5,'circa','').
EXECUTE.

STRING temp7 (A20).
COMPUTE temp7=REPLACE(temp6,'N.v.t.','').
EXECUTE.

STRING temp8 (A20).
COMPUTE temp8=REPLACE(temp7,'....','').
EXECUTE.

STRING temp9 (A20).
COMPUTE temp9=REPLACE(temp8,'Tussen de 60 en de 8','70').
EXECUTE.

STRING temp10 (A20).
COMPUTE temp10=REPLACE(temp9,' 66','66').
EXECUTE.

*controle.
FREQUENCIES VARIABLES=temp10
  /ORDER=ANALYSIS.

RENAME VARIABLES temp10=gewicht_T4.
ALTER TYPE gewicht_T4 (F3.2).


DELETE VARIABLES temp1 temp2 temp3 temp4 temp5 temp6 temp7 temp8 temp9.

* Controle reeele getallen.
FREQUENCIES gewicht_T4.

DO IF ID_code=4802.
RECODE gewicht_T4 (23=9999).
END IF.
DO IF ID_code=7111.
RECODE gewicht_T4 (0=9999).
END IF.
EXECUTE.

RECODE gewicht_T4 (SYSMIS=9999).
EXECUTE.
MISSING VALUES gewicht_T4 (9999).
VARIABLE WIDTH gewicht_T4 (7).
VARIABLE LEVEL gewicht_T4 (SCALE).

** nieuwe variabele indien gewicht is toegemonen, maar exact gewicht is missing.
DO IF (Q19='te veel').
COMPUTE gewicht_aangekomen_T4=1.
END IF.
EXECUTE.
VARIABLE WIDTH gewicht_T4 gewicht_aangekomen_T4 (7).
VARIABLE LEVEL gewicht_T4 gewicht_aangekomen_T4 (NOMINAL).
FORMATS gewicht_aangekomen_T4 (F1.0).

*** Q21/Q25: EQ5D **************************************************************************************************************************************************************************.
RENAME VARIABLES Q21=EQ5D_1_T4 / Q22=EQ5D_2_T4 / Q23=EQ5D_3_T4 / Q24=EQ5D_4_T4 / Q25=EQ5D_5_T4.
VARIABLE LABELS EQ5D_1_T4 'EQ5D mobiliteit T4' EQ5D_2_T4 'EQ5D zelfzorg T4' 
EQ5D_3_T4 'EQ5D ADL T4' EQ5D_4_T4 'EQ5D pijn/ongemak T4' EQ5D_5_T4 'EQ5D angst/somberheid T4'.

RENAME VARIABLES Q27=EQ5D_VAS_T4.
VARIABLE LABELS EQ5D_VAS_T4 'EQ5D gezondheid T4'.
FORMATS EQ5D_VAS_T4 (F3.0).

* Dutch tariff for EQ-5D-
* Based on the following publication: Versteegh, M. M., Vermeulen, K. M., Evers, S. M., de Wit, G. A., Prenger, R., & Stolk, E. A. (2016). Dutch Tariff for the Five-Level Version of EQ-5D. Value in Health, 2016. doi:10.1016/j.jval.2016.01.003 

COMPUTE EQ5D_T4 = 1.

DO IF (nvalid(EQ5D_1_T4, EQ5D_2_T4, EQ5D_3_T4, EQ5D_4_T4, EQ5D_5_T4) < 5).
RECODE EQ5D_T4 (1 = SYSMIS).
END IF.

IF (max(EQ5D_1_T4, EQ5D_2_T4, EQ5D_3_T4, EQ5D_4_T4, EQ5D_5_T4)>1)EQ5D_T4 = EQ5D_T4 - .0469233.
IF (EQ5D_1_T4 = 2) EQ5D_T4 = EQ5D_T4 - .0354544.
IF (EQ5D_1_T4 = 3) EQ5D_T4 = EQ5D_T4 - .0565962.
IF (EQ5D_1_T4 = 4) EQ5D_T4 = EQ5D_T4 - .166003.
IF (EQ5D_1_T4 = 5) EQ5D_T4 = EQ5D_T4 - .2032975.

IF (EQ5D_2_T4 = 2) EQ5D_T4 = EQ5D_T4 - .0381079.
IF (EQ5D_2_T4 = 3) EQ5D_T4 = EQ5D_T4 - .0605347.
IF (EQ5D_2_T4 = 4) EQ5D_T4 = EQ5D_T4 - .1677852.
IF (EQ5D_2_T4 = 5) EQ5D_T4 = EQ5D_T4 - .1677852.

IF (EQ5D_3_T4 = 2) EQ5D_T4 = EQ5D_T4 - .0391539.
IF (EQ5D_3_T4 = 3) EQ5D_T4 = EQ5D_T4 - .0867559.
IF (EQ5D_3_T4 = 4) EQ5D_T4 = EQ5D_T4 - .1924631.
IF (EQ5D_3_T4 = 5) EQ5D_T4 = EQ5D_T4 - .1924631.

IF (EQ5D_4_T4 = 2) EQ5D_T4 = EQ5D_T4 - .0658959.
IF (EQ5D_4_T4 = 3) EQ5D_T4 = EQ5D_T4 - .0919619.
IF (EQ5D_4_T4 = 4) EQ5D_T4 = EQ5D_T4 - .35993.
IF (EQ5D_4_T4 = 5) EQ5D_T4 = EQ5D_T4 - .4152142.

IF (EQ5D_5_T4 = 2) EQ5D_T4 = EQ5D_T4 - .069622.
IF (EQ5D_5_T4 = 3) EQ5D_T4 = EQ5D_T4 - .1445222.
IF (EQ5D_5_T4 = 4) EQ5D_T4 = EQ5D_T4 - .3563913.
IF (EQ5D_5_T4 = 5) EQ5D_T4 = EQ5D_T4 - .4206361.
EXECUTE.

* missings.
RECODE EQ5D_1_T4 EQ5D_2_T4 EQ5D_3_T4 EQ5D_4_T4 EQ5D_5_T4 EQ5D_T4  (SYSMIS=99).
RECODE EQ5D_VAS_T4  (SYSMIS=999).
EXECUTE.
MISSING VALUES EQ5D_1_T4 EQ5D_2_T4 EQ5D_3_T4 EQ5D_4_T4 EQ5D_5_T4 EQ5D_T4 (99) EQ5D_VAS_T4 (999).
VARIABLE LABELS EQ5D_T4 'EQ5D tot score T4'.
VARIABLE LEVEL  EQ5D_1_T4 EQ5D_2_T4 EQ5D_3_T4 EQ5D_4_T4 EQ5D_5_T4 (ORDINAL).
VARIABLE WIDTH  EQ5D_1_T4 EQ5D_2_T4 EQ5D_3_T4 EQ5D_4_T4 EQ5D_5_T4 (5).

** Q29/30/31: CCQ***************************************************************************************************************************************************************.
RENAME VARIABLES Q29_1=CCQ1_T4 / Q29_2=CCQ2_T4 / Q29_3=CCQ3_T4 / Q29_4=CCQ4_T4 / 
Q30_1=CCQ5_T4 / Q30_2=CCQ6_T4 / Q31_1=CCQ7_T4 / Q31_2=CCQ8_T4 / Q31_3=CCQ9_T4 / Q31_4=CCQ10_T4.
VARIABLE LABELS CCQ1_T4 'CCQ kortademig rust T4' CCQ2_T4 'CCQ kortademig lich inspanning T4' CCQ3_T4 'CCQ angstig/bezorgd T4' CCQ4_T4 'CCQ neerslachtig T4' 
CCQ5_T4 'CCQ gehoest T4' CCQ6_T4 'CCQ slijm opgehoest T4' CCQ7_T4 'CCQ beperkt bij zware lich activiteit T4' CCQ8_T4 'CCQ beperkt bij matige lich activiteit T4' 
CCQ9_T4 'CCQ beperkt bij dagelijkse activiteiten T4' CCQ10_T4 'CCQ beperkt bij sociale activiteiten T4'. 

*** CCQ totaalscores.
'minimum aantal missings??.
COMPUTE CCQ_tot_T4=MEAN(CCQ1_T4,CCQ2_T4,CCQ3_T4,CCQ4_T4,CCQ5_T4,CCQ6_T4,CCQ7_T4,CCQ8_T4,CCQ9_T4, CCQ10_T4).
COMPUTE CCQ_klachten_T4=MEAN(CCQ1_T4,CCQ2_T4,CCQ5_T4,CCQ6_T4).
COMPUTE CCQ_emoties_T4=MEAN(CCQ3_T4,CCQ4_T4).
COMPUTE CCQ_conditie_T4=MEAN(CCQ7_T4,CCQ8_T4,CCQ9_T4, CCQ10_T4).
EXECUTE.

** missings.
RECODE CCQ1_T4 CCQ2_T4 CCQ3_T4 CCQ4_T4 CCQ5_T4 CCQ6_T4 CCQ7_T4 CCQ8_T4 CCQ9_T4 CCQ10_T4 (SYSMIS=99).
RECODE CCQ_tot_T4 CCQ_klachten_T4 CCQ_emoties_T4 CCQ_conditie_T4 (SYSMIS=99).
EXECUTE.
MISSING VALUES CCQ1_T4 CCQ2_T4 CCQ3_T4 CCQ4_T4 CCQ5_T4 CCQ6_T4 CCQ7_T4 CCQ8_T4 CCQ9_T4 CCQ10_T4
 CCQ_tot_T4 CCQ_klachten_T4 CCQ_emoties_T4 CCQ_conditie_T4 (99).
VARIABLE LEVEL CCQ1_T4 CCQ2_T4 CCQ3_T4 CCQ4_T4 CCQ5_T4 CCQ6_T4 CCQ7_T4 CCQ8_T4 CCQ9_T4 CCQ10_T4 (ORDINAL).
VARIABLE WIDTH CCQ1_T4 CCQ2_T4 CCQ3_T4 CCQ4_T4 CCQ5_T4 CCQ6_T4 CCQ7_T4 CCQ8_T4 CCQ9_T4 CCQ10_T4 (6).
VARIABLE WIDTH CCQ_tot_T4 CCQ_klachten_T4 CCQ_emoties_T4 CCQ_conditie_T4 (9).

*** Q33-Q35: aan roken gerelateerde ziektes************************************************************************************************************************************.
RENAME VARIABLES Q33=rokersziektes1a_T4 / Q114=rokersziekte1b_T4 / Q34=rokersziektes2a_T4 /Q115=rokersziekte2b_T4 / Q35=rokersziektes3_T4.
* In de papieren versie staat steeds 1 vraag over ‘blijf roken of weer ga roken’.
*In de elektronische versie is deze opgesplitst naar 2 vragen.
*Samenvoegen naar 1 variabele.
RENAME VARIABLES rokersziektes1a_T4=rokersziektes1_T4.
DO IF SYSMIS(rokersziektes1_T4)=1.
COMPUTE rokersziektes1_T4=rokersziekte1b_T4.
END IF.
RENAME VARIABLES rokersziektes2a_T4=rokersziektes2_T4.
DO IF SYSMIS(rokersziektes2_T4)=1.
COMPUTE rokersziektes2_T4=rokersziekte2b_T4.
END IF.
EXECUTE.
DELETE VARIABLES rokersziekte1b_T4 rokersziekte2b_T4.
VARIABLE LABELS rokersziektes1_T4 'Als ik blijf roken/weer ga roken dan is de kans dat ik hierdoor op een bepaald punt in mijn leven een ziekte krijg T4'/
rokersziektes2_T4 'Als ik blijf roken/weer ga roken ben ik bang om hierdoor op een bepaald punt in mijn leven een ziekte te krijgen T4'/
rokersziektes3_T4 'Ten opzichte van andere ziektes zijn de gevolgen van roken-gerelateerde ziektes:T4'.

** missings.
RECODE rokersziektes1_T4 rokersziektes2_T4 rokersziektes3_T4 (SYSMIS=99).
MISSING VALUES rokersziektes1_T4 rokersziektes2_T4 rokersziektes3_T4 (99).
EXECUTE.
VARIABLE WIDTH  rokersziektes1_T4 rokersziektes2_T4 rokersziektes3_T4 (6).
VARIABLE LEVEL  rokersziektes1_T4 rokersziektes2_T4 rokersziektes3_T4 (ORDINAL).

***Q36: stress********************************************************************************************************************************************************************.
RENAME VARIABLES Q36_1=stress1_T4 / Q36_2=stress2_T4 / Q36_3=stress3_T4 / Q36_4=stress4_T4 / Q36_5=stress5_T4.
VARIABLE LABELS stress1_T4 'Hoe vaak heeft u het gevoel gehad dat u geen controle had over de belangrijke dingen in uw leven? T4'
stress2_T4 'Hoe vaak heeft u zich er zeker van gevoeld dat u in staat was om persoonlijke problemen aan te kunnen? T4'
stress3_T4 'Hoe vaak heeft u het gevoel gehad dat alles liep zoals u wilde? T4'
stress4_T4 'Hoe vaak heeft u het gevoel gehad dat de problemen zich zo hoog opstapelden dat u ze niet kon overwinnen? T4'
stress5_T4 'Hoe vaak bent u aangeslagen geweest door gebeurtenissen in de wereld? T4'.

** missings.
RECODE stress1_T4 stress2_T4 stress3_T4 stress4_T4 stress5_T4  (SYSMIS=99).
MISSING VALUES stress1_T4 stress2_T4 stress3_T4 stress4_T4 stress5_T4 (99).
EXECUTE.
VARIABLE WIDTH  stress1_T4 stress2_T4 stress3_T4 stress4_T4 stress5_T4 (6).
VARIABLE LEVEL   stress1_T4 stress2_T4 stress3_T4 stress4_T4 stress5_T4 (ORDINAL).

***Q38-Q42: sociale omgeving*************************************************************************************************************************************.
RENAME VARIABLES Q38=soc_omgeving1_T4 /  Q39=soc_omgeving2_T4 /  Q40=soc_omgeving3_T4 /  Q41=soc_omgeving4_T4 /  Q42=soc_omgeving5_T4 . 
** soc_omgeving3 is onlogisch gecodeerd.
RECODE soc_omgeving3_T4 (2=1) (3=2) (4=3) (6=4).
VALUE LABELS soc_omgeving3_T4 1 'veel steun' 2 'niet veel/niet weinig steun' 3 'weinig steun' 4 'weet niet'.
EXECUTE.

VARIABLE LABELS soc_omgeving1_T4  'Rookt uw partner? T4' /
soc_omgeving2_T4 'Is uw partner in de afgelopen 2 maanden succesvol gestopt met roken? T4' /
soc_omgeving3_T4 'Hoeveel steun heeft u gekregen van uw partner bij het (proberen te) stoppen met roken T4'/
soc_omgeving4_T4 'Hoeveel van de vijf meest nabije vrienden, bekenden of collegas waar u regelmatig tijd mee doorbrengt zijn roker? T4'/
soc_omgeving5_T4 'Hoeveel steun heeft u gekregen van uw vrienden en familieleden bij het (proberen te) stoppen met roken T4'.

RECODE soc_omgeving1_T4 soc_omgeving2_T4 soc_omgeving3_T4 soc_omgeving4_T4 soc_omgeving5_T4 (SYSMIS=99).
EXECUTE.
MISSING VALUES soc_omgeving1_T4 soc_omgeving2_T4 soc_omgeving3_T4 soc_omgeving4_T4 soc_omgeving5_T4 (99).
VARIABLE WIDTH soc_omgeving1_T4 soc_omgeving2_T4 soc_omgeving3_T4 soc_omgeving4_T4 soc_omgeving5_T4 (8).
VARIABLE LEVEL soc_omgeving1_T4 soc_omgeving2_T4 soc_omgeving3_T4 soc_omgeving4_T4 soc_omgeving5_T4 (NOMINAL).

***Q44/Q48: roken op werk******************************************************************************************************************************************************.
RENAME VARIABLES Q44_1=roken_op_werk1_T4 /  Q44_2=roken_op_werk2_T4 / Q44_4=roken_op_werk3_T4 / Q44_5=roken_op_werk4_T4 /
Q45=roken_op_werk5_T4 / Q46=roken_op_werk6_T4 / Q47=soc_omgeving6a_T4 / Q48=soc_omgeving6b_T4.
VARIABLE LABELS roken_op_werk1_T4 'Is het toegestaan om te roken op het werk? T4' 
roken_op_werk2_T4 'Bent u vrij om rookpauzes te nemen wanneer u wilt? T4' 
roken_op_werk3_T4 'Zijn er op het werk speciale rookplekken binnen? T4'
roken_op_werk4_T4 'Zijn er op het werk speciale rookplekken buiten? T4'
roken_op_werk5_T4 'Roken wordt ontmoedigd op het werk T4'
roken_op_werk6_T4 'Op het werk wordt het normaal gevonden dat er collegas roken T4'
soc_omgeving6a_T4 'Hoeveel steun heeft u gekregen van uw collegas die niet meededen aan de stoppen-met-rokencursus T4'
soc_omgeving6b_T4 'Hoeveel steun heeft u gekregen van uw collegas die wel meededen aan de stoppen-met-rokencursus T4'.

* soc_omgeving6a_T4 en 6b_T4 heeft onlogische codering: hercoderen.
RECODE  soc_omgeving6a_T4 (2=1) (3=2) (4=3) (6=4).
RECODE  soc_omgeving6b_T4 (2=1) (3=2) (4=3) (6=4).
VALUE LABELS soc_omgeving6a_T4 soc_omgeving6b_T4 1 'veel steun' 2  'niet veel/niet weing steun' 3 'weinig steun' 4  'weet niet' . 
EXECUTE.

* missings.
RECODE roken_op_werk1_T4 roken_op_werk2_T4 roken_op_werk3_T4 roken_op_werk4_T4 roken_op_werk5_T4 roken_op_werk6_T4 soc_omgeving6a_T4 soc_omgeving6b_T4 (SYSMIS=99).
EXECUTE.
MISSING VALUES roken_op_werk1_T4 roken_op_werk2_T4 roken_op_werk3_T4 roken_op_werk4_T4  (99) roken_op_werk5_T4 roken_op_werk6_T4 (6,99)  
soc_omgeving6a_T4 soc_omgeving6b_T4 (4,99).
VARIABLE LEVEL roken_op_werk1_T4 roken_op_werk2_T4 roken_op_werk3_T4 roken_op_werk4_T4  (NOMINAL). 
VARIABLE LEVEL roken_op_werk5_T4 roken_op_werk6_T4 soc_omgeving6a_T4 soc_omgeving6b_T4 (ORDINAL).
VARIABLE WIDTH roken_op_werk1_T4 roken_op_werk2_T4 roken_op_werk3_T4 roken_op_werk4_T4 roken_op_werk5_T4 roken_op_werk6_T4  soc_omgeving6a_T4 soc_omgeving6b_T4 (9).

*** Q50/51: werkuren/werkdagen*************************************************************************************************************************************************************.
RENAME VARIABLES Q50=werktijd1_T4 / Q51=werktijd2_T4.

VARIABLE WIDTH werktijd1_T4 werktijd2_T4 (8).
VARIABLE LEVEL werktijd1_T4 werktijd2_T4 (SCALE).
VARIABLE LABELS werktijd1_T4 'aantal werkuren per week T4' / werktijd2_T4 'aantal werkdagen per week T4'.

** aanpassingen.
** personen die uur per dag opgeven ipv tot aantal uur. Aanpassen.
DO IF (ID_Code=3603 or ID_Code=3105  or ID_Code=3708 or ID_Code=5603).
RECODE werktijd1_T4 (8=40) (9=45).
END IF.
EXECUTE.
DO IF (ID_Code=5603).
RECODE werktijd1_T4 (9=36).
END IF.
EXECUTE.

* ID 1914	1 uur, 1 dag	Op T1 16 uur, 2 dagen  hier ook.
DO IF  ID_code=1914.
RECODE werktijd1_T4 (1=16).
RECODE werktijd2_T4 (1=2).
END IF.

* ID 2904	1 uur, 1 dag	Andere lijsten 24 uur, 3 dagen hier ook.
DO IF  ID_code=2904.
RECODE werktijd1_T4 (1=24).
RECODE werktijd2_T4 (1=3).
END IF.

* ID 3507	1 uur, 1 dag	Op T3,T2,T1 5 dagen, 35 uur  hier ook.
DO IF  ID_code=3507.
RECODE werktijd1_T4 (1=35).
RECODE werktijd2_T4 (1=5).
END IF.

* ID 4205	1 uur, 1 dag	Op T3,T2  36 uur, 5 dagen  hier ook.
DO IF  ID_code=4205.
RECODE werktijd1_T4 (1=36).
RECODE werktijd2_T4 (1=5).
END IF.

* ID 4607	6 uur, 2 dagen Op T3,T2,T1: 40 uur, 5 dagen: nu 60 dagen ziek.--> 40 uur 5 dagen.
DO IF  ID_code=4607.
RECODE werktijd1_T4 (6=40).
RECODE werktijd2_T4 (2=5).
END IF.

* ID 4915	8 uur, 7 dagen Op T3,T2,T1  40 uur, 5 dagen--> hier 7x8 uur.
DO IF  ID_code=4915.
RECODE werktijd1_T4 (8=56).
END IF.

* ID 6506	1 uur, 1 dag	Op T3,T2 32 uur, 4 dagen  hier ook.
DO IF  ID_code=6506.
RECODE werktijd1_T4 (1=32).
RECODE werktijd2_T4 (1=4).
END IF.

* ID 1210    16 uur, dagen missing  Op T3 16 uur, 2 dagen T2 en T1 niet ingevuld, T0 20 uur 2 dagen  2 dagen ervan maken.
DO IF  ID_code=1210.
RECODE werktijd2_T4 (SYSMIS=2).
END IF.
EXECUTE.

**Aantal werkuur per dag berekenen.
COMPUTE werkuur_per_dag_T4=werktijd1_T4 / werktijd2_T4.
EXECUTE.

RECODE werktijd1_T4 werktijd2_T4 werkuur_per_dag_T4 (SYSMIS=999).
EXECUTE.
MISSING VALUES werktijd1_T4 werktijd2_T4 werkuur_per_dag_T4 (999).

VARIABLE WIDTH werktijd1_T4  werktijd2_T4 werkuur_per_dag_T4 (8).
VARIABLE LEVEL werktijd1_T4  werktijd2_T4 werkuur_per_dag_T4 (SCALE).

'PAUZE moet nog
*Q52/Q53: pauze******************************************************************************************************************************************************************.
RENAME VARIABLES Q52=pauzes_aantal_T4.
FORMATS pauzes_aantal_T4 (F2.0).

*Q53_1_TEXT (aant min pauze) van string naar numeriek.
RECODE Q53_1_TEXT ( '5 ik sta niet stil ik werk gewoon door ook met sigarett in mijn hand'='5') ('45 min'='45').
EXECUTE.
RENAME VARIABLES Q53_1_TEXT=pauzes_minuten_T4.
ALTER TYPE pauzes_minuten_T4 (F3.0).

*Q53_2_TEXT (aant uren pauze) van string naar numeriek.
RECODE Q53_2_TEXT ( '0,5'='0.5') ('0,75'='0.75') ('0,9'='0.9') ('1 uur' = '1') ('1/2'='0.5') ('1/3'='0.33') ('half uur'='0.5') .
EXECUTE.
RENAME VARIABLES Q53_2_TEXT=pauzes_uren_T4.
ALTER TYPE pauzes_uren_T4 (F3.1).

VARIABLE LABELS pauzes_aantal_T4 'aantal pauzes op meest recente werkdag T4' pauzes_minuten_T4 'aantal min pauze T4' pauzes_uren_T4 'aantal uur pauze T4'.
VARIABLE WIDTH pauzes_aantal_T4 pauzes_minuten_T4 pauzes_uren_T4 (5).

** Als wel aantal uur en/of minuten is ingevuld, maar niet aantal keer, dan is aantal keer missing (99).
DO IF  SYSMIS(pauzes_minuten_T4)=0 or SYSMIS(pauzes_uren_T4)=0.
RECODE pauzes_aantal_T4 (SYSMIS=99).
END IF.
EXECUTE.

** als aantal pauzes>0 en aantal minuten is ingevuld en aantal uren niet, dan is aantal uren 0.
DO IF (pauzes_aantal_T4>0 and pauzes_minuten_T4>0).
RECODE pauzes_uren_T4 (SYSMIS=0).
END IF.
EXECUTE.
** als aantal pauzes>0 en aantal uren is ingevuld en aantal min niet, dan is aantal min 0.
DO IF (pauzes_aantal_T4>0 and pauzes_uren_T4>0).
RECODE pauzes_minuten_T4 (SYSMIS=0).
END IF.
EXECUTE.
** als aantal pauzes= dan is aantal uren en min ook 0.
DO IF (pauzes_aantal_T4=0).
RECODE pauzes_minuten_T4 (SYSMIS=0).
RECODE pauzes_uren_T4 (SYSMIS=0).
END IF.
EXECUTE.

*CONTROLE: enkele zeer onwaarschijnlijke aantal uren en minuten!!!.

DO IF (pauzes_minuten_T4=90).
RECODE pauzes_uren_T4 (1.5=0).
END IF.
DO IF (pauzes_minuten_T4=60).
RECODE pauzes_uren_T4 (1=0).
END IF.
DO IF (pauzes_minuten_T4=30).
RECODE pauzes_uren_T4 (0.5=0).
END IF.
DO IF (pauzes_minuten_T4=45).
RECODE pauzes_uren_T4 (0.75=0).
END IF.
DO IF (pauzes_minuten_T4=120).
RECODE pauzes_uren_T4 (2=0).
END IF.
EXECUTE.

* soms geven deelnemers meerdere pauzes aan met een totale tijd van 5 minuten. Er wordt vanuit gegaan dat ze 5 minuten per pauze bedoelen:.
IF (pauzes_uren_T4=0 and pauzes_minuten_T4=5) pauzes_minuten_T4=(pauzes_minuten_T4*pauzes_aantal_T4).
EXECUTE.

* onmogelijke waarden die ook niet te corrigeren zijn adhv gezond verstand of eerdere lijsten--> missing.
DO IF (ID_code=1907 or ID_code=2009 or ID_code=2003 or ID_code=2207 or ID_code=3219 or ID_code=4109 or ID_code=4404 or ID_code=4509 or ID_code=5606 or ID_code=6106 or ID_code=6504). 
COMPUTE pauzes_aantal_T4=$SYSMIS.
COMPUTE pauzes_minuten_T4=$SYSMIS.
COMPUTE pauzes_uren_T4=$SYSMIS.
END IF.


* ID 1211 ingevuld 50 uur, 0 minuten. Is waarschijnlijk andersom.
DO IF (ID_Code=1211). 
RECODE pauzes_minuten_T4 (0=50).
RECODE pauzes_uren_T4 (50=0).
END IF.
EXECUTE.

* ID 1401 ingevuld 0.8 uur, 50 minuten. bedoelt met 0.8 uur waarsch ook 50 min.
DO IF (ID_Code=1401). 
RECODE pauzes_uren_T4 (0.8=0).
END IF.
EXECUTE.

* ID 2603 ingevuld 0.9 uur, 50 minuten. bedoelt met 0.9 uur waarsch ook 50 min.
DO IF (ID_Code=2603). 
RECODE pauzes_uren_T4 (0.9=0).
END IF.
EXECUTE.

* ID 2703 ingevuld 5 pauzes en 4 min, rookt nog, is waarschijnlijk 5 pauzes van 4 min=20 min.
DO IF (ID_Code=2703). 
RECODE pauzes_minuten_T4 (4=20).
END IF.
EXECUTE.

* ID 5113 ingevuld 60 uur, 0 minuten. Is waarschijnlijk andersom.
DO IF (ID_Code=5113). 
RECODE pauzes_minuten_T4 (0=60).
RECODE pauzes_uren_T4 (60=0).
END IF.
EXECUTE.

* ID 5308 ingevuld 10 pauzes, 0 min en 5 uur-->  10 pauzes van ieder 5 min = 50 min.
DO IF (ID_Code=5308). 
RECODE pauzes_minuten_T4 (0=50).
RECODE pauzes_uren_T4 (5=0).
END IF.
EXECUTE.

* ID 5507 ingevuld 15 uur, 1 minuten. Is waarschijnlijk andersom.
DO IF (ID_Code=5507). 
RECODE pauzes_minuten_T4 (1=15).
RECODE pauzes_uren_T4 (15=1).
END IF.
EXECUTE.

* ID 6709 ingevuld 15 uur, 1 minuten. Is waarschijnlijk andersom.
DO IF (ID_Code=6709). 
RECODE pauzes_minuten_T4 (1=15).
RECODE pauzes_uren_T4 (15=1).
END IF.
EXECUTE.

* ID 7102  ingevuld  8 pauzes 40 uur, 5 minuten. T 3: 6 pauzes, 30 min. Bedoelt hier waarschijnlijk 8 pauzes van 5 min=40 totaal.
DO IF (ID_Code=7102). 
RECODE pauzes_minuten_T4 (5=40).
RECODE pauzes_uren_T4 (40=0).
END IF.
EXECUTE.

* ID 7112 ingevuld 1.3 uur, 90 minuten. bedoelt met 1.3 uur waarsch ook 90 min.
DO IF (ID_Code=7112). 
RECODE pauzes_uren_T4 (1.3=0).
END IF.
EXECUTE.

** missings.
RECODE pauzes_aantal_T4 (SYSMIS=99).
RECODE pauzes_uren_T4 pauzes_minuten_T4 (SYSMIS=999).
EXECUTE.
MISSING VALUES pauzes_aantal_T4 (99) pauzes_uren_T4 pauzes_minuten_T4 (999).
VARIABLE LEVEL pauzes_aantal_T4 pauzes_uren_T4 pauzes_minuten_T4 (SCALE).
VARIABLE WIDTH  pauzes_aantal_T4 pauzes_uren_T4 pauzes_minuten_T4 (10).

** totale pauzetijd.
COMPUTE pauzes_tot_T4 = pauzes_uren_T4 * 60 + pauzes_minuten_T4.
EXECUTE.
VARIABLE LABELS pauzes_tot_T4 'tot aant min pauze per dag T4'.
VARIABLE WIDTH  pauzes_tot_T4 (7).
VARIABLE LEVEL  pauzes_tot_T4 (SCALE).

* missings.
RECODE pauzes_tot_T4 (SYSMIS=99999).
EXECUTE.
MISSING VALUES pauzes_tot_T4 (99999).

** Q54 - Q66: ziekteverzuim*******************************************************************************************************************************************************************.

RENAME VARIABLES Q54=ziekteverzuim1_T4 / Q54_TEXT=ziekteverzuim2_T4 / Q55=ziekteverzuim3_T4.
VARIABLE LABELS ziekteverzuim1_T4 'verlof wegens ziekte afgelopen 6 mnd T4' ziekteverzuim2_T4  'aantal dagen verzuim T4' 
ziekteverzuim3_T4 'langer dan 6 maanden verlof wegens ziekte T4'.
VALUE LABELS ziekteverzuim1_T4 1 'nee' 2 'ja'.
VARIABLE WIDTH ziekteverzuim1_T4 ziekteverzuim2_T4 ziekteverzuim3_T4 (9).

* ziekteverzuim2_T4 (aantal dagen) numeriek maken.
FREQUENCIES VARIABLES= ziekteverzuim2_T4
  /ORDER=ANALYSIS.

*2601 aantal dagen: nee  ziekteverzuim wordt nee.
*3501 aantal dagen: geen 1  ziekteverzuim wordt nee.
*4915 aantal dagen: geen  ziekteverzuim wordt nee.
*5601 aantal dagen: nvt  ziekteverzuim wordt nee. 

DO IF (ID_code=2601 or ID_Code=3501 or ID_code=4915 or ID_code=5601).
RECODE ziekteverzuim1_T4 (2=1).
RECODE ziekteverzuim2_T4 ('Nee'=' ') ('geen 1'=' ') ('geen'=' ')('nvt'=' ').
END IF.

RECODE ziekteverzuim2_T4 ('50 (ziek geopereerd)'='50') ('4 dagen'='4') ('3 dagen'='3') ('2 dagen'='2') ('16 dagen'='16') (' 20 halve dagen'='10').

* 3910	Alle dagen--> wordt langdurig.
DO IF (ID_code=3910).
RECODE ziekteverzuim1_T4 (2=3).
RECODE ziekteverzuim2_T4 ('Alle dagen'='').
RECODE ziekteverzuim3_T4 (1=2).
END IF.

*4802	Alle 3 maanden. Werkt 4 dagen per week  26x4=104 dagen.
DO IF (ID_code=4802).
RECODE ziekteverzuim2_T4 ('Alle 3 maanden'='104').
END IF.
*2702	Ben ziekgeworden op 21-9 en ben net weer begonnen met halve dagen. Werkt 4d/wk. 
*	Schatting:  6 weken a 4 dagen= 6x4=24 dagen.
DO IF (ID_code=2702).
RECODE ziekteverzuim2_T4 ('Ben ziekgeworden op 21-9 en ben net weer begonnen met halve dagen.'='24').
END IF.
*3106	Alle. Werkt 5 d/week 26x5=130 dagen.
DO IF (ID_code=3106).
RECODE ziekteverzuim2_T4 ('alle'='130').
END IF.
*7007	aantal dagen: ja  1 (conservatieve schatting).
DO IF (ID_code=7007).
RECODE ziekteverzuim2_T4 ('Ja'='1').
END IF.
*5911	aantal dagen: griep 1 (conservatieve schatting).
DO IF (ID_code=5911).
RECODE ziekteverzuim2_T4 ('griep'='1').
END IF.
*4912	aantal dagen: Blessure heb opgelopen heeft niet met roken te maken  1 (conservatieve schatting).
DO IF (ID_code=4912).
RECODE ziekteverzuim2_T4 ('Blessure heb opgelopen heeft niet met roken te maken'='1').
END IF.
*6412	3maanden half gewerkt. Werkt 5 dagen/week  13 (weken) x 2.5 dagen = 32.5 dagen.
DO IF (ID_code=6412).
RECODE ziekteverzuim2_T4 ('3maanden half gewerkt'='32.5').
END IF.
*3102	2 maanden. Werkt 4 dagen/week  8x4=32 dagen.
DO IF (ID_code=3102).
RECODE ziekteverzuim2_T4 ('2 maanden'='24').
END IF.
EXECUTE.
* 6808	aantal dagen: vanaf oktober 2 mnd daarna langzaam weer opgebouwd burn out ivm met hoofdzaak prive problemen. 
* Heeft ook langdurig vanaf 24-10-17 8 weken volledig verzuim (korter dan frictieperiode), daarna ca 3 maanden parttime werk, werkt normaal 8 uur per dag, 5 dagen 
*  aanhouden 8x5 dagen (volledig) + 12 x 4 dagen (gedeeltelijk) =  88 dagen verlof? En langdurig weg.
DO IF (ID_code=6808).
RECODE ziekteverzuim1_T4 (3=2).
RECODE ziekteverzuim2_T4 ('vanaf oktober 2 mnd daarna langzaam weer opgebouwd burn out ivm met hoofdzaak prive problemen'='88').
RECODE ziekteverzuim3_T4 (2=1).
RECODE ziekteverzuim4_T4 ('24-10-217'='').
END IF.
EXECUTE.

ALTER TYPE ziekteverzuim2_T4 (F3.1).
VARIABLE WIDTH ziekteverzuim1_T4  ziekteverzuim2_T4  ziekteverzuim3_T4 (10).

* Als afwezig=ja en aantal dagen =0.  Aantal dagen wordt 1 (conservatieve schatting).
DO IF ziekteverzuim1_T4=2.
RECODE ziekteverzuim2_T4 (0=1) (SYSMIS=1).
END IF.
EXECUTE.

*Indien ziekteverzuim1 =1 (nee), dan moet ziekteverzuim2 leeg zijn.
USE ALL.
COMPUTE filter_$=(ziekteverzuim1_T4=1).
VARIABLE LABELS filter_$ 'ziekteverzuim1_T4=1 (FILTER)'.
VALUE LABELS filter_$ 0 'Not Selected' 1 'Selected'.
FORMATS filter_$ (f1.0).
FILTER BY filter_$.
EXECUTE.
FREQUENCIES VARIABLES=ziekteverzuim2_T4
  /ORDER=ANALYSIS.
USE ALL.


*** Langer dan 3 mnd ziek ************************************************************************************************************************************************.

* Q56 van string naar date.
RENAME VARIABLES (Q56=ziekteverzuim4_T4).
RECODE ziekteverzuim4_T4 ('23/102/2017'='23/10/2017') ('20 mei'='20/05/2017') ('17/03/17'='17/03/2017') ('13-02-2017'='13/02/2017') ('28-04-2017'='28/04/2017')
('13-06-2017'='13/06/2017') ('28 augustus 2017'='28/08/2017').
EXECUTE.
VARIABLE LABELS  ziekteverzuim4_T4 'datum ziekmelding T4'.
ALTER TYPE ziekteverzuim4_T4 (EDATE10).
EXECUTE.
 

* (datum ziekmelding) moet minimaal 6 maanden (26 weken) voor invuldatum liggen.
* Date and Time Wizard: d_datum_ziekmelding_invuldatum.

COMPUTE  d_datum_ziekmelding_invuldatum_T4=DATEDIF( Invuldatum_T4, ziekteverzuim4_T4, "weeks").
EXECUTE.

VARIABLE LABELS  d_datum_ziekmelding_invuldatum_T4 "verschil in weken invuldatum-ziekmelddatum T4".
VARIABLE LEVEL  d_datum_ziekmelding_invuldatum_T4 (SCALE).
FORMATS  d_datum_ziekmelding_invuldatum_T4 (F5.0).
VARIABLE WIDTH  d_datum_ziekmelding_invuldatum_T4(11).
EXECUTE.
FREQUENCIES VARIABLES=d_datum_ziekmelding_invuldatum_T4
  /ORDER=ANALYSIS.

** 3218 en 2411 aanpassen minder dan 26 weken langdurig weghalen (geeft zelf ook al kortdurend ziekteverlof).
IF (ID_code=3218 or ID_code=2411) ziekteverzuim3_T4=1.
IF (ID_code=3218 or ID_code=2411) ziekteverzuim4_T4=$SYSMIS.
IF (ID_code=3218 or ID_code=2411) d_datum_ziekmelding_invuldatum_T4=$SYSMIS.
EXECUTE.
** 4808: 23 weken, maar geeft maar 1 dag kortdurend op. Deze langdurende aanhouden.

* Missing en nvt toevoegen.
DO IF (ziekteverzuim1_T4=1).
RECODE ziekteverzuim2_T4 (SYSMIS=888).
RECODE ziekteverzuim3_T4 (SYSMIS=1).
END IF.
DO IF (ziekteverzuim1_T4=2).
RECODE ziekteverzuim2_T4 (SYSMIS=999).
END IF.
DO IF (ziekteverzuim1_T4=3).
RECODE ziekteverzuim2_T4 (SYSMIS=888).
END IF.
RECODE ziekteverzuim1_T4 (SYSMIS=9).
RECODE ziekteverzuim3_T4 (SYSMIS=9).
DO IF (ziekteverzuim1_T4=9).
RECODE ziekteverzuim2_T4 (SYSMIS=999).
END IF.
EXECUTE.

MISSING VALUES ziekteverzuim1_T4 ziekteverzuim3_T4 (9) ziekteverzuim2_T4 (888,999).

* Ziekteverzuim1_T4 (=afgelopen 3 mnd) hercoderen: 1=nee, 2 =ja , 3=langdurig (dus indien ziekteverzuim3_T4=2).
DO IF ziekteverzuim3_T4=2.
RECODE ziekteverzuim1_T4 (2=3).
END IF.
VALUE LABELS ziekteverzuim1_T4 1 'nee' 2 'ja' 3 'langdurig >6 mnd' .
* Indien ziekteverzuim is langdurig: aantal dagen missing maken (is niet van belang, advies Sylvia).
DO IF ziekteverzuim3_T4=2.
COMPUTE  ziekteverzuim2_T4=$SYSMIS.
END IF.
EXECUTE.


*** Q57 t/m 59: ziek op het werk************************************************************************************************************************************.
RENAME VARIABLES Q57=ziekteverzuim5_T4 / Q58=ziekteverzuim6_T4 / Q59_1=ziekteverzuim7_T4.
VARIABLE LABELS ziekteverzuim5_T4 'ziek op het werk afgelopen 6 maanden T4' ziekteverzuim6_T4 'ziek op werk: aantal dagen T4'
ziekteverzuim7_T4 'ziek op werk: hoeveel werk verricht T4'.
FORMATS ziekteverzuim6_T4 (F3.0).


*Indien ziekteverzuim5 =1 (nee), dan moeten ziekteverzuim6 en 7  leeg zijn.
USE ALL.
COMPUTE filter_$=(ziekteverzuim5_T4=1).
VARIABLE LABELS filter_$ 'ziekteverzuim5_T0=1 (FILTER)'.
VALUE LABELS filter_$ 0 'Not Selected' 1 'Selected'.
FORMATS filter_$ (f1.0).
FILTER BY filter_$.
EXECUTE.
FREQUENCIES VARIABLES=ziekteverzuim6_T4 ziekteverzuim7_T4
  /ORDER=ANALYSIS.
USE ALL.

* =Indien ziekteverzuim3 (langer dan 6 mnd ziek) ja is, kan ziekteverzuim5 niet ja zijn (want ze hebben niet gewerkt).
CROSSTABS
  /TABLES=ziekteverzuim3_T4 BY ziekteverzuim5_T4
  /FORMAT=AVALUE TABLES
  /CELLS=COUNT
  /COUNT ROUND CELL.

* Komt toch voor: in dat geval 'ziek op werk' verwijderen.

DO IF ID_code=3106 or ID_code=3111 or ID_code=4508 or ID_code=4802 or  ID_code=4808  or ID_code=4607 or ID_code=4902 or ID_code=5909 or ID_code=6808 or ID_code=6412. 
RECODE ziekteverzuim5_T4 (2=1).
COMPUTE ziekteverzuim6_T4=888.
COMPUTE ziekteverzuim7_T4=888.
END IF.
DO IF ID_code=6505.
COMPUTE ziekteverzuim5_T4=1.
COMPUTE ziekteverzuim6_T4=888.
COMPUTE ziekteverzuim7_T4=888.
END IF.
EXECUTE.

* Indien ziek op werk= ja en aantal dagen=0 of missing--> wordt 1 (conservatieve schatting).
DO IF ziekteverzuim5_T4=2.
RECODE ziekteverzuim6_T4 (0=1) (SYSMIS=1).
END IF.
EXECUTE.

* Indien ziek op werk= ja en % werk verricht = missing--> wordt 9 (conservatieve schatting).
DO IF ziekteverzuim5_T4=2.
RECODE ziekteverzuim7_T4 (SYSMIS=9).
END IF.
EXECUTE.

* Controle ziekteverzuim6 (aantal werkdagen).
FREQUENCIES VARIABLES=ziekteverzuim6_T4
  /ORDER=ANALYSIS.

* ziekteverzuim7_T0 rare codering: {1, ik kon op deze dagen niets doen: 0}...tot '11, ik kon net zoveel doen als normaal: 10.
*Hercoderen.
RECODE ziekteverzuim7_T4 (1=0) (2=1) (3=2) (4=3) (5=4) (6=5) (7=6) (8=7) (9=8) (10=9) (11=10).
EXECUTE.
VALUE LABELS ziekteverzuim7_T4.

* Missing en nvt toevoegen.
DO IF (ziekteverzuim5_T4=1).
RECODE ziekteverzuim6_T4 (SYSMIS=888).
RECODE ziekteverzuim7_T4 (SYSMIS=888).
END IF.
DO IF (ziekteverzuim5_T4=2).
RECODE ziekteverzuim6_T4 (SYSMIS=999).
RECODE ziekteverzuim7_T4 (SYSMIS=999).
END IF.
RECODE ziekteverzuim5_T4 (SYSMIS=9).
DO IF (ziekteverzuim5_T4=9).
RECODE ziekteverzuim6_T4 (SYSMIS=999).
RECODE ziekteverzuim7_T4 (SYSMIS=999).
END IF.
EXECUTE.

MISSING VALUES ziekteverzuim5_T4 (9) ziekteverzuim6_T4 ziekteverzuim7_T4 (888,999).
VARIABLE WIDTH ziekteverzuim5_T4 ziekteverzuim6_T4 ziekteverzuim7_T4 (9).
VARIABLE LEVEL ziekteverzuim5_T4 (ORDINAL).


'dit nog doen.
*** Q61 t/m 63: ziek mbt onbetaald werk************************************************************************************************************************************.
RENAME VARIABLES Q61=ziekteverzuim8_T4 / Q62=ziekteverzuim9_T4 / Q63=ziekteverzuim10_T4.
VARIABLE LABELS ziekteverzuim8_T4 'verzuim onbetaald werk T4' ziekteverzuim9_T4 'verzuim onbetaald aantal dagen T4' ziekteverzuim10_T4 'verzuim onbetaald uren vervanging T4'.
FORMATS ziekteverzuim9_T4 (F3.0).

*Indien ziekteverzuim8 =1 (nee), dan moeten ziekteverzuim9 en 10  leeg zijn.
USE ALL.
COMPUTE filter_$=(ziekteverzuim8_T4=1).
VARIABLE LABELS filter_$ 'ziekteverzuim8_T4=1 (FILTER)'.
VALUE LABELS filter_$ 0 'Not Selected' 1 'Selected'.
FORMATS filter_$ (f1.0).
FILTER BY filter_$.
EXECUTE.
FREQUENCIES VARIABLES=ziekteverzuim9_T4 ziekteverzuim10_T4
  /ORDER=ANALYSIS.
USE ALL.

* Controle ziekteverzuim9_T4 (aantal dagen).
FREQUENCIES VARIABLES=ziekteverzuim9_T4
  /ORDER=ANALYSIS.

** aantal dagen max 182.
RECODE ziekteverzuim9_T4 (9000=182).
EXECUTE.
** ID 4804 902 dagen. Ook 90 dagen ziek geweest --> veranderen in 90.
DO IF ID_code=4804.
RECODE ziekteverzuim9_T4 (902=90).
END IF.
EXECUTE.

* Controle ziekteverzuim10_T4 (aantal uur). 
FREQUENCIES VARIABLES=ziekteverzuim10_T4
  /ORDER=ANALYSIS.

** indien ja en aantal uur / aantal dagen = 0 of missing ; veranderen in 1 (conservatieve schatting).
DO IF ziekteverzuim8_T4=2.
RECODE ziekteverzuim9_T4 (0=1) (SYSMIS=1).
RECODE ziekteverzuim10_T4 (0=1) (SYSMIS=1).
END IF.
EXECUTE.

* aantal onwaarschijnlijk, aanpassen:.
DO IF ID_Code=3201.
RECODE ziekteverzuim10_T4 (600=10).
END IF.
DO IF ID_Code=3916.
RECODE ziekteverzuim10_T4 (216=3).
END IF.
DO IF ID_Code=7102.
RECODE ziekteverzuim10_T4 (150=1).
END IF.
DO IF ID_Code=2404.
RECODE ziekteverzuim10_T4 (100=1.3).
END IF.
DO IF ID_Code=3407.
RECODE ziekteverzuim10_T4 (100=1.4).
END IF.
DO IF ID_Code=5506.
RECODE ziekteverzuim10_T4 (80=4).
END IF.
DO IF ID_Code=6412.
RECODE ziekteverzuim10_T4 (80=1.5).
END IF.
DO IF ID_Code=5606.
RECODE ziekteverzuim10_T4 (80=8).
END IF.
DO IF ID_Code=1117.
RECODE ziekteverzuim10_T4 (65=1).
END IF.
DO IF ID_Code=2909.
RECODE ziekteverzuim10_T4 (50=5).
END IF.
DO IF ID_Code=5910.
RECODE ziekteverzuim10_T4 (50=2).
END IF.
DO IF ID_Code=4806.
RECODE ziekteverzuim10_T4 (45=1.8).
END IF.
DO IF ID_Code=2504.
RECODE ziekteverzuim10_T4 (40=0.6).
END IF.
DO IF ID_Code=4803.
RECODE ziekteverzuim10_T4 (40=4).
END IF.
DO IF ID_Code=7107.
RECODE ziekteverzuim10_T4 (40=2).
END IF.
DO IF ID_Code=6408.
RECODE ziekteverzuim10_T4 (25=1.25).
END IF.
DO IF ID_Code=3908.
RECODE ziekteverzuim10_T4 (20=1.3).
END IF.
DO IF ID_Code=1605.
RECODE ziekteverzuim10_T4 (20=3.3).
END IF.
DO IF ID_Code=1211.
RECODE ziekteverzuim9_T4 (0=20).
RECODE ziekteverzuim10_T4 (20=1).
END IF.
DO IF ID_Code=3308.
RECODE ziekteverzuim10_T4 (15=0.5).
END IF.
DO IF ID_Code=4201.
RECODE ziekteverzuim10_T4 (15=1).
END IF.
DO IF ID_Code=2410.
RECODE ziekteverzuim10_T4 (10=0.5).
END IF.
DO IF ID_Code=6901.
RECODE ziekteverzuim10_T4 (10=0.16).
END IF.
DO IF ID_Code=2810.
RECODE ziekteverzuim10_T4 (10=1).
END IF.
EXECUTE.

* Missing en nvt toevoegen.
DO IF (ziekteverzuim8_T4=1).
RECODE ziekteverzuim9_T4 (SYSMIS=888).
RECODE ziekteverzuim10_T4 (SYSMIS=888).
END IF.
DO IF (ziekteverzuim8_T4=2).
RECODE ziekteverzuim9_T4 (SYSMIS=999).
RECODE ziekteverzuim10_T4 (SYSMIS=999).
END IF.
RECODE ziekteverzuim8_T4 (SYSMIS=9).
DO IF (ziekteverzuim8_T4=9).
RECODE ziekteverzuim9_T4 (SYSMIS=999).
RECODE ziekteverzuim10_T4 (SYSMIS=999).
END IF.
EXECUTE.

MISSING VALUES ziekteverzuim8_T4 (9) ziekteverzuim9_T4 ziekteverzuim10_T4 (888,999).
VARIABLE LEVEL ziekteverzuim1_T4 ziekteverzuim3_T4 ziekteverzuim5_T4 ziekteverzuim8_T4 (NOMINAL).
VARIABLE LEVEL ziekteverzuim2_T4 ziekteverzuim4_T4 ziekteverzuim6_T4 ziekteverzuim7_T4  ziekteverzuim9_T4   ziekteverzuim10_T4 (SCALE).
VARIABLE WIDTH ziekteverzuim9_T4 ziekteverzuim9_T4 ziekteverzuim5_T4 ziekteverzuim10_T4 (9).

*** Q66_1 t/m _14 ******************************************************************************************************************************************************.
RENAME VARIABLES  Q66_1_TEXT=consult1_T4 / Q66_2_TEXT=consult2_T4 /  Q66_3_TEXT=consult3_T4 /  Q66_4_TEXT=consult4_T4 /  Q66_5_TEXT=consult5_T4 /  Q66_6_TEXT=consult6_T4 / 
 Q66_7_TEXT=consult7_T4 /  Q66_8_TEXT=consult8_T4 /  Q66_9_TEXT=consult9_T4 /  Q66_10_TEXT=consult10_T4 /  Q66_11_TEXT=consult11_T4 /  Q66_12_TEXT=consult12_T4 / 
 Q66_13_TEXT=consult13_T4 /  Q66_14_TEXT=consult14_T4 .

VARIABLE LABELS consult1_T4 'consult HA T4' 
consult2_T4 'consult POH T4' 
consult3_T4 'consult maatsch. werker T4' 
consult4_T4 'consult bedrijfsarts T4'
consult5_T4 'consult ergotherapeut T4' 
consult6_T4 'consult dietist T4' 
consult7_T4 'consult stoppen met roken begeleider T4'  
consult8_T4 'consult tandarts T4' 
consult9_T4 'consult logopedist T4' 
consult10_T4 'consult homeopaat etc T4'
consult11_T4 'consult fysio etc T4' 
consult12_T4 'consult psycholoog etc T4'  
consult13_T4 'consult huidtherapeut/mondhygienist T4' 
consult14_T4 'consult manicure/pedicure T4'. 

* van string naar numeriek. Controle.
FREQUENCIES VARIABLES=consult1_T4 consult2_T4 consult3_T4 consult4_T4 consult5_T4 consult6_T4 
    consult7_T4 consult8_T4 consult9_T4 consult10_T4 consult11_T4 consult12_T4 consult13_T4 consult14_T4    
  /ORDER=ANALYSIS.

RECODE consult1_T4 to consult14_T4 ('O'='0').
RECODE consult1_T4 ('w'='2').
RECODE consult2_T4 ('2maal'='2').
RECODE consult12_T4 ('tine wastiels'='1').
RECODE consult4_T4 ('nyrstar'='1').
RECODE consult7_T4 ('nee'='0').
RECODE consult11_T4 ('P'='1').
EXECUTE.
ALTER TYPE consult1_T4 to consult14_T4 (F2.0).

** Als er minimaal 1 is ingevuld en de rest missing, zijn die missings 0 (geen consult).
DO IF (NVALID(consult1_T4,consult2_T4,consult3_T4,consult4_T4,consult5_T4,consult6_T4,consult7_T4,
    consult8_T4,consult9_T4,consult10_T4,consult11_T4,consult12_T4,consult13_T4,consult14_T4)>=1).
RECODE consult1_T4 consult2_T4 consult3_T4 consult4_T4 consult5_T4 consult6_T4 consult7_T4 consult8_T4 consult9_T4 
    consult10_T4 consult11_T4 consult12_T4 consult13_T4 consult14_T4 (SYSMIS=0).
END IF.
EXECUTE.

** Als er helemaal niets is ingevuld, maar de vragenlijst is wel  'gefinished', dan zijn de missings 0 (geen consult).
DO IF (NVALID(consult1_T4,consult2_T4,consult3_T4,consult4_T4,consult5_T4,consult6_T4,consult7_T4,
    consult8_T4,consult9_T4,consult10_T4,consult11_T4,consult12_T4,consult13_T4,consult14_T4)=0 and  Finished=1).
RECODE consult1_T4 consult2_T4 consult3_T4 consult4_T4 consult5_T4 consult6_T4 consult7_T4 consult8_T4 consult9_T4 
    consult10_T4 consult11_T4 consult12_T4 consult13_T4 consult14_T4 (SYSMIS=0).
END IF.
EXECUTE.

** Als er helemaal niets is ingevuld, en de vragenlijst is niet  'gefinished', dan zijn de missings 999 (echt missing).
DO IF (NVALID(consult1_T4,consult2_T4,consult3_T4,consult4_T4,consult5_T4,consult6_T4,consult7_T4,
    consult8_T4,consult9_T4,consult10_T4,consult11_T4,consult12_T4,consult13_T4,consult14_T4)=0 and  Finished=0).
RECODE consult1_T4 consult2_T4 consult3_T4 consult4_T4 consult5_T4 consult6_T4 consult7_T4 consult8_T4 consult9_T4 
    consult10_T4 consult11_T4 consult12_T4 consult13_T4 consult14_T4 (SYSMIS=999).
END IF.
EXECUTE.

**Indien de verkorte vragenlijst is ingevuld , is alleen consult 7 (stoppen met roken begeleider) ingevuld. Rest wordt missing.
DO IF (papier_T4=2).
RECODE consult1_T4 consult2_T4 consult3_T4 consult4_T4 consult5_T4 consult6_T4 consult8_T4 consult9_T4 
    consult10_T4 consult11_T4 consult12_T4 consult13_T4 consult14_T4 (0=999).
END IF.
EXECUTE.

MISSING VALUES consult1_T4 consult2_T4 consult3_T4 consult4_T4 consult5_T4 consult6_T4 consult7_T4 consult8_T4 consult9_T4 
    consult10_T4 consult11_T4 consult12_T4 consult13_T4 consult14_T4 (999).

VARIABLE WIDTH consult1_T4 consult2_T4 consult3_T4 consult4_T4 consult5_T4 consult6_T4 consult7_T4 consult8_T4 consult9_T4 
    consult10_T4 consult11_T4 consult12_T4 consult13_T4 consult14_T4 (6).


*** Q67-Q70 Thuiszorg *******************************************************************************************************************************************************.
RENAME VARIABLES Q67=thuiszorg_T4 / Q68_1=thuiszorg_hh_T4 / Q68_2=thuiszorg_verzorging_T4 / Q68_3=thuiszorg_verpleging_T4 / 
Q69_X1_TEXT=thuiszorg_hh_weken_T4 / Q69_X2_TEXT=thuiszorg_verzorging_weken_T4 / Q69_X3_TEXT=thuiszorg_verpleging_weken_T4 / 
Q70_X1_TEXT=thuiszorg_hh_uur_T4 / Q70_X2_TEXT=thuiszorg_verzorging_uur_T4 / Q70_X3_TEXT=thuiszorg_verpleging_uur_T4. 

VARIABLE LABELS thuiszorg_T4 'thuiszorg ja/nee T4'
thuiszorg_hh_T4 'thuiszorg huishouden ja/nee T4'
thuiszorg_verzorging_T4 'thuiszorg verzorging ja/nee T4'
thuiszorg_verpleging_T4 'thuiszorg verpleging ja/nee T4'
thuiszorg_hh_weken_T4 'thuiszorg huishouden aant weken T4'
thuiszorg_verzorging_weken_T4 'thuiszorg verzorging aant weken T4'
thuiszorg_verpleging_weken_T4  'thuiszorg verpleging aant weken T4'
thuiszorg_hh_uur_T4 'thuiszorg huishouden aant uur/wk T4'
thuiszorg_verzorging_uur_T4 'thuiszorg verzorging aant uur/wk T4'
thuiszorg_verpleging_uur_T4 'thuiszorg verpleging aant uur/wk T4'. 

*Indien thuiszorg_T0 =1 (nee), dan moeten thuiszorg_hh_T0, thuiszorg_verzorging_T0 en thuiszorg_verpleging_T0 sysmis zijn.
USE ALL.
COMPUTE filter_$=( thuiszorg_T4=1).
VARIABLE LABELS filter_$ ' thuiszorg_T4=1 (FILTER)'.
VALUE LABELS filter_$ 0 'Not Selected' 1 'Selected'.
FORMATS filter_$ (f1.0).
FILTER BY filter_$.
EXECUTE.
FREQUENCIES VARIABLES= thuiszorg_hh_T4 thuiszorg_verzorging_T4 thuiszorg_verpleging_T4 
  /ORDER=ANALYSIS.
USE ALL.

* visueel in database nakijken: als thuiszorg_T4 ergens 2 is, dan moet er ook wat staan bij de bijbehorende weken en uren. (descending sorteren op thuiszorg_T0)

* controle of er geen tekst is ingevuld.
FREQUENCIES VARIABLES=thuiszorg_hh_weken_T4 thuiszorg_verzorging_weken_T4 thuiszorg_verpleging_weken_T4  
thuiszorg_hh_uur_T4 thuiszorg_verzorging_uur_T4 thuiszorg_verpleging_uur_T4 
  /ORDER=ANALYSIS.

* omzetten string naar numeriek.
ALTER TYPE thuiszorg_hh_weken_T4 thuiszorg_verzorging_weken_T4 thuiszorg_verpleging_weken_T4  (F2.0).
ALTER TYPE thuiszorg_hh_uur_T4 thuiszorg_verzorging_uur_T4 thuiszorg_verpleging_uur_T4 (F3.1).

VARIABLE WIDTH thuiszorg_hh_weken_T4 thuiszorg_verzorging_weken_T4 thuiszorg_verpleging_weken_T4  
thuiszorg_hh_uur_T4 thuiszorg_verzorging_uur_T4 thuiszorg_verpleging_uur_T4 (8).

VARIABLE LEVEL  thuiszorg_T4 thuiszorg_hh_T4 thuiszorg_verzorging_T4 thuiszorg_verpleging_T4 (NOMINAL).
VARIABLE LEVEL  thuiszorg_hh_weken_T4 thuiszorg_verzorging_weken_T4 thuiszorg_verpleging_weken_T4  
thuiszorg_hh_uur_T4 thuiszorg_verzorging_uur_T4 thuiszorg_verpleging_uur_T4 (SCALE).


**Indien thuiszorg_T4 =1 (nee), rest hercoderen naar 0.
DO IF thuiszorg_T4=1.
RECODE thuiszorg_hh_weken_T4 thuiszorg_verzorging_weken_T4 thuiszorg_verpleging_weken_T4
 thuiszorg_hh_uur_T4 thuiszorg_verzorging_uur_T4 thuiszorg_verpleging_uur_T4 (SYSMIS=0).
END IF.
DO IF SYSMIS(thuiszorg_hh_T4) =1 and thuiszorg_T4=2.
RECODE thuiszorg_hh_T4 thuiszorg_hh_weken_T4  thuiszorg_hh_uur_T4 (SYSMIS=0).
END IF.
DO IF SYSMIS(thuiszorg_verzorging_T4)=1  and thuiszorg_T4=2.
RECODE thuiszorg_verzorging_T4 thuiszorg_verzorging_weken_T4  thuiszorg_verzorging_uur_T4 (SYSMIS=0).
END IF.
DO IF SYSMIS(thuiszorg_verpleging_T4)=1  and thuiszorg_T4=2.
RECODE thuiszorg_verpleging_T4 thuiszorg_verpleging_weken_T4  thuiszorg_verpleging_uur_T4 (SYSMIS=0).
END IF.
DO IF thuiszorg_T4=1.
RECODE thuiszorg_hh_T4 thuiszorg_verzorging_T4 thuiszorg_verpleging_T4  (SYSMIS=0).
END IF.
EXECUTE. 

** missings toevoegen.
RECODE thuiszorg_T4 (SYSMIS=9).
DO IF (thuiszorg_T4 =9).
RECODE thuiszorg_hh_T4 thuiszorg_verzorging_T4 thuiszorg_verpleging_T4  (SYSMIS=9).
RECODE  thuiszorg_hh_weken_T4 thuiszorg_verzorging_weken_T4 thuiszorg_verpleging_weken_T4
 thuiszorg_hh_uur_T4 thuiszorg_verzorging_uur_T4 thuiszorg_verpleging_uur_T4 (SYSMIS=999).
END IF.
EXECUTE.

MISSING VALUES  thuiszorg_T4 thuiszorg_hh_T4 thuiszorg_verzorging_T4 thuiszorg_verpleging_T4  (9)
thuiszorg_hh_weken_T4 thuiszorg_verzorging_weken_T4 thuiszorg_verpleging_weken_T4
 thuiszorg_hh_uur_T4 thuiszorg_verzorging_uur_T4 thuiszorg_verpleging_uur_T4 (999).

'nog doen
*** Q71: gebruik nicotinevervangers afgelopen 3 mnd ****************************************************************************************************************************.

RENAME VARIABLES Q71=nicotinevervangers_T4 / Q72_1=nicotinepleisters_T4 / Q72_2=nicotinekauwgom_T4 / Q72_3=nicotine_microtabs_T4 / Q72_4=nicotine_zuigtabletten_T4 /
Q72_5=nicotine_mondspray_T4 / Q72_6=nicotine_inhaler_T4 / Q72_7=nicotine_anders_T4 / Q72_7_TEXT=nicotine_anders_nl_T4. 

VARIABLE LABELS nicotinevervangers_T4 'nicotinevervangers: ja/nee T4' /
nicotinepleisters_T4 'nicotinevervangers: pleister ja/nee T4' /
nicotinekauwgom_T4 'nicotinevervangers: kauwgom ja/nee T4' /
nicotine_microtabs_T4 'nicotinevervangers: microtabs ja/nee T4' /
nicotine_zuigtabletten_T4  'nicotinevervangers: zuigtabletten ja/nee T4' /
nicotine_mondspray_T4 'nicotinevervangers: mondspray ja/nee T4' /
nicotine_inhaler_T4 'nicotinevervangers: inhaler ja/nee T4' /
nicotine_anders_T4 'nicotinevervangers: anders ja/nee T4' /
nicotine_anders_nl_T4 'nicotinevervangers: anders nl. T4'.

VALUE LABELS nicotinevervangers_T4 2 'ja' 1 'nee' /nicotinepleisters_T4 nicotinekauwgom_T4 nicotine_microtabs_T4 nicotine_zuigtabletten_T4 
nicotine_mondspray_T4 nicotine_inhaler_T4 nicotine_anders_T4  0 'nee'1 'ja'.

** ID 1708: wel nicotinevervangers gebruikt, maar vult bij anders in: geen.
DO IF ID_code=1708.
RECODE nicotinevervangers_T4 (2=1).
RECODE nicotine_anders_T4 (1=SYSMIS).
RECODE nicotine_anders_nl_T4 ('Geen'=' ').
END IF.
EXECUTE.

* Indien nicotinevervangers_T4 niet missing is, moeten de verschillende soorten missings 0 zijn.
DO IF (nicotinevervangers_T4=1 or nicotinevervangers_T4=2).
RECODE nicotinepleisters_T4 nicotinekauwgom_T4 nicotine_microtabs_T4 nicotine_zuigtabletten_T4 nicotine_mondspray_T4 nicotine_inhaler_T4 nicotine_anders_T4 (SYSMIS=0).
END IF.
EXECUTE.

* missing toevoegen (rest van sysmis is missing).
RECODE nicotinevervangers_T4 nicotinepleisters_T4 nicotinekauwgom_T4 nicotine_microtabs_T4 nicotine_zuigtabletten_T4 nicotine_mondspray_T4 nicotine_inhaler_T4 
nicotine_anders_T4 (SYSMIS=9).
MISSING VALUES nicotinevervangers_T4 nicotinepleisters_T4 nicotinekauwgom_T4 nicotine_microtabs_T4 nicotine_zuigtabletten_T4 nicotine_mondspray_T4 nicotine_inhaler_T4 
nicotine_anders_T4 (9).
EXECUTE.

RENAME VARIABLES Q73_x1_TEXT=nicotinepleisters_stuks_T4 / Q73_x2_TEXT=nicotinekauwgom_stuks_T4 / Q73_x3_TEXT=nicotine_microtabs_stuks_T4 / 
Q73_x4_TEXT=nicotine_zuigtabletten_stuks_T4 / Q73_x5_TEXT=nicotine_mondspray_keer_T4 / Q73_x6_TEXT=nicotine_inhaler_keer_T4 / Q73_x7_TEXT=nicotine_anders_stuks_T4 / 
Q74_x1_TEXT=nicotinepleisters_dagen_T4 / Q74_x2_TEXT=nicotinekauwgom_dagen_T4 / Q74_x3_TEXT=nicotine_microtabs_dagen_T4 / 
Q74_x4_TEXT=nicotine_zuigtabletten_dagen_T4 / Q74_x5_TEXT=nicotine_mondspray_dagen_T4 / Q74_x6_TEXT=nicotine_inhaler_dagen_T4 / Q74_x7_TEXT=nicotine_anders_dagen_T4.

VARIABLE LABELS nicotinepleisters_stuks_T4 'nicotinevervangers: pleister aantal stuks/dag T4' /
nicotinekauwgom_stuks_T4  'nicotinevervangers: kauwgom aantal stuks/dag T4' /
nicotine_microtabs_stuks_T4 'nicotinevervangers: microtabs aantal stuks/dag T4' /
nicotine_zuigtabletten_stuks_T4 'nicotinevervangers: zuigtabletten aantal stuks/dag T4' /
nicotine_mondspray_keer_T4 'nicotinevervangers: mondspray aantal keer/dag T4' /
nicotine_inhaler_keer_T4 'nicotinevervangers: inhaler aantal keer/dag T4' /
nicotine_anders_stuks_T4 'nicotinevervangers: anders aantal stuks/dag T4'.

VARIABLE LABELS nicotinepleisters_dagen_T4  'nicotinevervangers: pleister aantal dagen T4' /
nicotinekauwgom_dagen_T4 'nicotinevervangers: kauwgom aantal dagen T4' /
nicotine_microtabs_dagen_T4 'nicotinevervangers: microtabs aantal dagen T4' /
nicotine_zuigtabletten_dagen_T4 'nicotinevervangers: zuigtabletten aantal dagen T4' /
nicotine_mondspray_dagen_T4 'nicotinevervangers: mondspray aantal dagen T4' /
nicotine_inhaler_dagen_T4 'nicotinevervangers: inhaler aantal dagen T4' /
nicotine_anders_dagen_T4 'nicotinevervangers: anders aantal dagen T4'.

* aantal stuks en aantal dagen van string naar numeriek.
* controle geen tekst.
FREQUENCIES VARIABLES= nicotinepleisters_stuks_T4 nicotinekauwgom_stuks_T4 nicotine_microtabs_stuks_T4 
    nicotine_zuigtabletten_stuks_T4 nicotine_mondspray_keer_T4 nicotine_inhaler_keer_T4 
    nicotine_anders_stuks_T4 nicotinepleisters_dagen_T4 nicotinekauwgom_dagen_T4 
    nicotine_microtabs_dagen_T4 nicotine_zuigtabletten_dagen_T4 nicotine_mondspray_dagen_T4 
    nicotine_inhaler_dagen_T4 nicotine_anders_dagen_T4
  /ORDER=ANALYSIS.

RECODE nicotine_anders_stuks_T4 ('3ml a 12mg/ml'='').
RECODE nicotine_anders_stuks_T4 ('3 weken'='').
RECODE nicotine_anders_dagen_T4 ('3 weken'='21').
RECODE nicotine_microtabs_dagen_T4 ('Alle'='182').
RECODE nicotinekauwgom_dagen_T4 ('allemaal'='182').
RECODE nicotine_anders_dagen_T4 ('Alle'='182').
RECODE nicotine_anders_dagen_T4 ('alle'='182').
RECODE nicotine_anders_dagen_T4 ('iedere dag'='182').
EXECUTE.

ALTER TYPE nicotinepleisters_stuks_T4 nicotinekauwgom_stuks_T4 nicotine_microtabs_stuks_T4 
    nicotine_zuigtabletten_stuks_T4 nicotine_mondspray_keer_T4 nicotine_inhaler_keer_T4 
    nicotine_anders_stuks_T4 nicotinepleisters_dagen_T4 nicotinekauwgom_dagen_T4 
    nicotine_microtabs_dagen_T4 nicotine_zuigtabletten_dagen_T4 nicotine_mondspray_dagen_T4 
    nicotine_inhaler_dagen_T4 nicotine_anders_dagen_T4 (F3.0).

* controle reele getallen.
FREQUENCIES VARIABLES= nicotinepleisters_stuks_T4 nicotinekauwgom_stuks_T4 nicotine_microtabs_stuks_T4 
    nicotine_zuigtabletten_stuks_T4 nicotine_mondspray_keer_T4 nicotine_inhaler_keer_T4 
    nicotine_anders_stuks_T4 nicotinepleisters_dagen_T4 nicotinekauwgom_dagen_T4 
    nicotine_microtabs_dagen_T4 nicotine_zuigtabletten_dagen_T4 nicotine_mondspray_dagen_T4 
    nicotine_inhaler_dagen_T4 nicotine_anders_dagen_T4
  /ORDER=ANALYSIS.

** correcties.
* pleisters is altijd 1 per dag.
RECODE nicotinepleisters_stuks_T4 (6=1).
RECODE nicotinepleisters_stuks_T4 (2=1).
* kauwgom = ja: 0 wordt 1 (conservatieve schatting).
RECODE nicotinekauwgom_stuks_T4 (0=1).
* aant dagen is max 182.
RECODE nicotine_zuigtabletten_dagen_T4 (250=182).
EXECUTE.

** antwoorden in categorie 'anders' gelijk maken.
RECODE nicotine_anders_nl_T4 ('champix'='Champix').
RECODE nicotine_anders_nl_T4 ('esmoker'='E sigaret').
RECODE nicotine_anders_nl_T4 ('Esigaret'='E sigaret').
RECODE nicotine_anders_nl_T4 ('electrische sigaret'='E sigaret').
RECODE nicotine_anders_nl_T4 ('e-sigaret'='E sigaret').
RECODE nicotine_anders_nl_T4 ('elektrisch roken'='E sigaret').
RECODE nicotine_anders_nl_T4 ('E smoker'='E sigaret').
RECODE nicotine_anders_nl_T4 ('E sigaret'='E sigaret').
RECODE nicotine_anders_nl_T4 ('e.c. sigaret'='E sigaret').
RECODE nicotine_anders_nl_T4 ('pille'='pillen').
EXECUTE.

*** nvt toevoegen.
DO IF (nicotinepleisters_T4=0).
RECODE nicotinepleisters_stuks_T4 (SYSMIS=888).
RECODE nicotinepleisters_dagen_T4 (SYSMIS=888).
END IF.
EXECUTE.
DO IF (nicotinekauwgom_T4=0).
RECODE nicotinekauwgom_stuks_T4 (SYSMIS=888).
RECODE nicotinekauwgom_dagen_T4 (SYSMIS=888).
END IF.
EXECUTE.
DO IF (nicotine_microtabs_T4=0).
RECODE nicotine_microtabs_stuks_T4 (SYSMIS=888).
RECODE nicotine_microtabs_dagen_T4 (SYSMIS=888).
END IF.
EXECUTE.
DO IF (nicotine_zuigtabletten_T4=0).
RECODE nicotine_zuigtabletten_stuks_T4 (SYSMIS=888).
RECODE nicotine_zuigtabletten_dagen_T4 (SYSMIS=888).
END IF.
EXECUTE.
DO IF (nicotine_mondspray_T4=0).
RECODE nicotine_mondspray_keer_T4 (SYSMIS=888).
RECODE nicotine_mondspray_dagen_T4 (SYSMIS=888).
END IF.
EXECUTE.
DO IF (nicotine_inhaler_T4=0).
RECODE nicotine_inhaler_keer_T4 (SYSMIS=888).
RECODE nicotine_inhaler_dagen_T4 (SYSMIS=888).
END IF.
EXECUTE.
DO IF (nicotine_anders_T4=0).
RECODE nicotine_anders_stuks_T4 (SYSMIS=888).
RECODE nicotine_anders_dagen_T4 (SYSMIS=888).
END IF.
EXECUTE.

** Degene die nu nog sysmis zijn zijn echt missing (worden wel gebruikt maar geen aantal ingevuld).
RECODE nicotinepleisters_stuks_T4 nicotinekauwgom_stuks_T4 nicotine_microtabs_stuks_T4 
    nicotine_zuigtabletten_stuks_T4 nicotine_mondspray_keer_T4 nicotine_inhaler_keer_T4 
    nicotine_anders_stuks_T4 nicotinepleisters_dagen_T4 nicotinekauwgom_dagen_T4 
    nicotine_microtabs_dagen_T4 nicotine_zuigtabletten_dagen_T4 nicotine_mondspray_dagen_T4 
    nicotine_inhaler_dagen_T4 nicotine_anders_dagen_T4 (SYSMIS=999).
EXECUTE.

MISSING VALUES nicotinepleisters_stuks_T4 nicotinekauwgom_stuks_T4 nicotine_microtabs_stuks_T4 
    nicotine_zuigtabletten_stuks_T4 nicotine_mondspray_keer_T4 nicotine_inhaler_keer_T4 
    nicotine_anders_stuks_T4 nicotinepleisters_dagen_T4 nicotinekauwgom_dagen_T4 
    nicotine_microtabs_dagen_T4 nicotine_zuigtabletten_dagen_T4 nicotine_mondspray_dagen_T4 
    nicotine_inhaler_dagen_T4 nicotine_anders_dagen_T4 (888,999) nicotinepleisters_T4 nicotinekauwgom_T4 nicotine_microtabs_T4 
    nicotine_zuigtabletten_T4 nicotine_mondspray_T4 nicotine_inhaler_T4 nicotine_anders_T4 (9).

VARIABLE LEVEL nicotinevervangers_T4 nicotinepleisters_T4 nicotinekauwgom_T4 nicotine_microtabs_T4 
    nicotine_zuigtabletten_T4 nicotine_mondspray_T4 nicotine_inhaler_T4 nicotine_anders_T4 (NOMINAL).
VARIABLE LEVEL nicotinepleisters_stuks_T4 nicotinekauwgom_stuks_T4 nicotine_microtabs_stuks_T4 
    nicotine_zuigtabletten_stuks_T4 nicotine_mondspray_keer_T4 nicotine_inhaler_keer_T4 
    nicotine_anders_stuks_T4 nicotinepleisters_dagen_T4 nicotinekauwgom_dagen_T4 
    nicotine_microtabs_dagen_T4 nicotine_zuigtabletten_dagen_T4 nicotine_mondspray_dagen_T4 
    nicotine_inhaler_dagen_T4 nicotine_anders_dagen_T4 (SCALE).


*** Q75: gebruik electronische sigaretten ****************************************************************************************************************************.
RENAME VARIABLES Q75 =Esigaret_T4 / Q76_1=Esigaret_met_nicotine_T4 / Q76_2=Esigaret_zonder_nicotine_T4.
VARIABLE LABELS Esigaret_T4 'E-sigaret gebruikt: ja/nee T4'
Esigaret_met_nicotine_T4  'E-sigaret met nicotine: ja/nee T4' 
Esigaret_zonder_nicotine_T4  'E-sigaret zonder nicotine: ja/nee T4'.
VALUE LABELS Esigaret_met_nicotine_T4 Esigaret_zonder_nicotine_T4 0 'nee' 1 'ja' .

RENAME VARIABLES Q77_1_x1_1_TEXT= Esigaret_met_nicotine_stuks_T4 / Q77_1_x2_1_TEXT =Esigaret_zonder_nicotine_stuks_T4/
Q77_2_x1_1_TEXT=Esigaret_met_nicotine_dagen_T4 / Q77_2_x2_1_TEXT=Esigaret_zonder_nicotine_dagen_T4.
VARIABLE LABELS  Esigaret_met_nicotine_stuks_T4 'E-sigaret met nicotine: aantal stuks/dag T4' / Esigaret_zonder_nicotine_stuks_T4 'E-sigaret zonder nicotine: aantal stuks/dag T4'.
VARIABLE LABELS Esigaret_met_nicotine_dagen_T4 'E-sigaret met nicotine: aantal dagen T4' / Esigaret_zonder_nicotine_dagen_T4 'E-sigaret zonder nicotine: aantal dagen T4'.

VARIABLE LEVEL Esigaret_T4 Esigaret_met_nicotine_T4 Esigaret_zonder_nicotine_T4 (NOMINAL).

* Indien Esigaret1_T4 Nee is, moet missing  0 zijn.
DO IF (Esigaret_T4=1).
RECODE Esigaret_met_nicotine_T4 Esigaret_zonder_nicotine_T4 (SYSMIS=0).
END IF.
EXECUTE.

* Indien Esigaret1_T0 2 (ja) is, moet Esigaret_met_nicotine_T1 of Esigaret_zonder_nicotine_T1 1 (ja) zijn, indien beide missing: missing. Indien 1 ingevuld en andere missing: andere=0.
DO IF (Esigaret_T4=2) and SYSMIS (Esigaret_met_nicotine_T4 )=1 and SYSMIS (Esigaret_zonder_nicotine_T4 )=1.
RECODE   Esigaret_met_nicotine_T4 Esigaret_zonder_nicotine_T4 (SYSMIS=9).
END IF.
DO IF Esigaret_T4=2.
RECODE   Esigaret_met_nicotine_T4 Esigaret_zonder_nicotine_T4 (SYSMIS=0).
END IF.
MISSING VALUES Esigaret_met_nicotine_T4 Esigaret_zonder_nicotine_T4 (9).
EXECUTE.

** Missing toevoegen (overige sysmis=missing).
RECODE Esigaret_T4 Esigaret_met_nicotine_T4 Esigaret_zonder_nicotine_T4 (SYSMIS=9).
MISSING VALUES Esigaret_T4 Esigaret_met_nicotine_T4 Esigaret_zonder_nicotine_T4 (9).
EXECUTE.

*stuks en dagen wordt voorlopig niet mee gerekend. Als string laten staan.


*** Q80 medicatie *******************************************************************************************************************************************************.
RENAME VARIABLES Q78=medicatie_T4 / Q79_1_TEXT = med1_T4 /  Q79_2_TEXT  = med2_T4 /  Q79_3_TEXT  = med3_T4 /  Q79_4_TEXT  = med4_T4 /  Q79_5_TEXT  = med5_T4 /
 Q79_6_TEXT  = med6_T4 / Q79_7_TEXT  = med7_T4 / Q79_8_TEXT  = med8_T4 /  Q79_9_TEXT  = med9_T4 /  Q79_10_TEXT  = med10_T4. 

VARIABLE LABELS medicatie_T4 'medicatie ja/nee T4' med1_T4 'med naam 1 T4'  med2_T4 'med naam 2 T4'  med3_T4 'med naam 3 T4'  med4_T4 'med naam 4 T4'
 med5_T4 'med naam 5 T4'  med6_T4 'med naam 6 T4'  med7_T4 'med naam 7 T4'  med8_T4 'med naam 8 T4'  med9_T4 'med naam 9 T4'  med10_T4 'med naam 10 T4'.

RENAME VARIABLES Q80_x1_TEXT =med1_dosering_T4 / Q80_x2_TEXT =med2_dosering_T4 / Q80_x3_TEXT =med3_dosering_T4 
/ Q80_x4_TEXT =med4_dosering_T4 / Q80_x5_TEXT =med5_dosering_T4 / Q80_x6_TEXT =med6_dosering_T4 
/ Q80_x7_TEXT =med7_dosering_T4 / Q80_x8_TEXT =med8_dosering_T4 / Q80_x9_TEXT =med9_dosering_T4 / Q80_x10_TEXT =med10_dosering_T4.

VARIABLE LABELS  med1_dosering_T4 / med2_dosering_T4 / med3_dosering_T4 / med4_dosering_T4 / med5_dosering_T4 / med6_dosering_T4 / med7_dosering_T4 / 
    med8_dosering_T4 / med9_dosering_T4 / med10_dosering_T4.

RENAME VARIABLES Q81_x1_TEXT =med1_keerperdag_T4 / Q81_x2_TEXT  =med2_keerperdag_T4 /  Q81_x3_TEXT  =med3_keerperdag_T4 / 
 Q81_x4_TEXT  =med4_keerperdag_T4 /  Q81_x5_TEXT  =med5_keerperdag_T4 /  Q81_x6_TEXT  =med6_keerperdag_T4 / 
 Q81_x7_TEXT  =med7_keerperdag_T4 /  Q81_x8_TEXT  =med8_keerperdag_T4 /  Q81_x9_TEXT  =med9_keerperdag_T4 / 
 Q81_x10_TEXT =med10_keerperdag_T4 .

VARIABLE LABELS  med1_keerperdag_T4 / med2_keerperdag_T4 / med3_keerperdag_T4 / med4_keerperdag_T4 / med5_keerperdag_T4 / 
    med6_keerperdag_T4 / med7_keerperdag_T4 / med8_keerperdag_T4 / med9_keerperdag_T4 / med10_keerperdag_T4.

RENAME VARIABLES Q82_x1_TEXT =med1_aantdagen_T4 / Q82_x2_TEXT =med2_aantdagen_T4 / Q82_x3_TEXT =med3_aantdagen_T4 / 
Q82_x4_TEXT =med4_aantdagen_T4 / Q82_x5_TEXT =med5_aantdagen_T4 / Q82_x6_TEXT =med6_aantdagen_T4 / 
Q82_x7_TEXT =med7_aantdagen_T4 / Q82_x8_TEXT =med8_aantdagen_T4 / Q82_x9_TEXT =med9_aantdagen_T4 /
Q82_x10_TEXT =med10_aantdagen_T4.

VARIABLE LABELS   med1_aantdagen_T4 / med2_aantdagen_T4 / med3_aantdagen_T4  / med4_aantdagen_T4 / med5_aantdagen_T4 /
    med6_aantdagen_T4 / med7_aantdagen_T4 / med8_aantdagen_T4 / med9_aantdagen_T4 / med10_aantdagen_T4.

RENAME VARIABLES  Q83_x1_TEXT =med1_vorm_T4 / Q83_x2_TEXT =med2_vorm_T4 / Q83_x3_TEXT =med3_vorm_T4 / 
Q83_x4_TEXT =med4_vorm_T4 /Q83_x5_TEXT =med5_vorm_T4 /Q83_x6_TEXT =med6_vorm_T4 / 
Q83_x7_TEXT =med7_vorm_T4 / Q83_x8_TEXT =med8_vorm_T4 /Q83_x9_TEXT =med9_vorm_T4 /Q83_x10_TEXT =med10_vorm_T4.

VARIABLE LABELS  med1_vorm_T4 / med2_vorm_T4 / med3_vorm_T4 / med4_vorm_T4 / med5_vorm_T4 / med6_vorm_T4 / med7_vorm_T4 / 
    med8_vorm_T4 / med9_vorm_T4 / med10_vorm_T4.


** als medicatie_T4=1 (nee) of missing: med1_T4 moet leeg zijn.
USE ALL.
COMPUTE filter_$=(medicatie_T4=1 or MISSING(medicatie_T4)=1).
VARIABLE LABELS filter_$ 'medicatie_T4=1 of missing (FILTER)'.
VALUE LABELS filter_$ 0 'Not Selected' 1 'Selected'.
FORMATS filter_$ (f1.0).
FILTER BY filter_$.
EXECUTE.
FREQUENCIES VARIABLES=med1_T4
  /ORDER=ANALYSIS.
USE ALL.

** missing invullen.
RECODE medicatie_T4 (SYSMIS=9).
MISSING VALUES  medicatie_T4 (9).
EXECUTE.

*aantal keer per dag en aantal dagen van string naar numeriek.
* controle op tekst en decimalen moeten met punt.
FREQUENCIES VARIABLES= med1_keerperdag_T4 med2_keerperdag_T4 med3_keerperdag_T4 med4_keerperdag_T4 med5_keerperdag_T4 
    med6_keerperdag_T4 med7_keerperdag_T4 med8_keerperdag_T4 med9_keerperdag_T4 
 /ORDER=ANALYSIS.
FREQUENCIES VARIABLES= med1_aantdagen_T4 med2_aantdagen_T4 med3_aantdagen_T4 med4_aantdagen_T4 med5_aantdagen_T4 
    med6_aantdagen_T4 med7_aantdagen_T4 med8_aantdagen_T4 med9_aantdagen_T4  
 /ORDER=ANALYSIS.

** 1x per week wordt 1/7=0.14 indien aantal dagen volledige periode bestrijkt.
** indien aantal dagen al is aangepast, wordt het 1.

RECODE med1_keerperdag_T4 ('3x'='3').
RECODE med1_keerperdag_T4 ('3x per dag'='3').
RECODE med1_keerperdag_T4 ('2x per dag'='2').
RECODE med1_keerperdag_T4 ('2 x per dag'='2').
RECODE med1_keerperdag_T4 ('2x'='2').
RECODE med1_keerperdag_T4 ('2x3'='2').
RECODE med1_keerperdag_T4 ('1x'='1').
RECODE med1_keerperdag_T4 ('1x1'='1').
RECODE med1_keerperdag_T4 ('1x per dagvspuiten'='1').
RECODE med1_keerperdag_T4 ('1a2'='1.5').
RECODE med1_keerperdag_T4 ('1,5'='1.5').
RECODE med1_keerperdag_T4 ('0'='1').
RECODE med1_keerperdag_T4 (' 1x per dag'='1').
RECODE med1_aantdagen_T4 ('alle'='182').
RECODE med1_aantdagen_T4 ('Alle dagen'='182').
RECODE med1_aantdagen_T4 ('elke dag'='182').
RECODE med1_aantdagen_T4 ('iedere dag'='182').
RECODE med1_aantdagen_T4 ('dagelijks'='182').
RECODE med1_aantdagen_T4 ('Iedere dag'='182').
RECODE med1_aantdagen_T4 ('alle dagen'='182').
RECODE med1_aantdagen_T4 ('10 dagen'='10').
RECODE med1_aantdagen_T4 ('193'='182').
RECODE med1_aantdagen_T4 ('183'='182').
RECODE med1_aantdagen_T4 ('214'='182').
RECODE med1_aantdagen_T4 ('240'='182').
RECODE med1_aantdagen_T4 ('350'='182').
RECODE med1_aantdagen_T4 ('540'='182').
DO IF ID_code=2703.
RECODE med1_keerperdag_T4 ('1x pw'='0.14').
END IF.
DO IF ID_code=2901.
RECODE med1_keerperdag_T4 ('1 x per week'='1').
END IF.
DO IF ID_code=7114.
RECODE med1_keerperdag_T4 ('1pw'='1').
END IF.
DO IF ID_code=3902.
RECODE med1_keerperdag_T4 ('1x per 8 wk'='1').
RECODE med1_aantdagen_T4 ('Depot'='3').
END IF.
* dosering=2 p/mnd.
DO IF ID_code=3806.
RECODE med1_keerperdag_T4 ('30'='1').
RECODE med1_aantdagen_T4 ('30'='12').
END IF.
EXECUTE.

RECODE med2_keerperdag_T4 ('4x per dag'='4').
RECODE med2_keerperdag_T4 ('3x'='3').
RECODE med2_keerperdag_T4 ('2x'='2').
RECODE med2_keerperdag_T4 ('2xpd'='2').
RECODE med2_keerperdag_T4 ('2x3'='2').
RECODE med2_keerperdag_T4 ('1x per dag'='1').
RECODE med2_keerperdag_T4 ('1x'='1').
RECODE med2_keerperdag_T4 ('0'='1').
RECODE med2_aantdagen_T4 ('elke dag'='182').
RECODE med2_aantdagen_T4 ('iedere dag'='182').
RECODE med2_aantdagen_T4 ('dagelijks'='182').
RECODE med2_aantdagen_T4 ('Iedere dag'='182').
RECODE med2_aantdagen_T4 ('alle'='182').
RECODE med2_aantdagen_T4 ('193'='182').
RECODE med2_aantdagen_T4 ('183'='182').
RECODE med2_aantdagen_T4 ('14 dagen'='14').
RECODE med2_aantdagen_T4 ('9 dagen'='9').
DO IF ID_code=1914.
RECODE med1_T4 ('neusspray'='xylometazoline neusspray').
END IF.
DO IF ID_code=2703.
RECODE med2_keerperdag_T4 ('2x pw'='0.28').
END IF.
* dosering=1 p/2 mnd.
DO IF ID_code=3806.
RECODE med2_keerperdag_T4 ('60'='1').
RECODE med2_aantdagen_T4 ('60'='3').
END IF.
EXECUTE.

RECODE med3_keerperdag_T4 ('6x'='6').
RECODE med3_keerperdag_T4 ('3x'='3').
RECODE med3_keerperdag_T4 ('2x'='2').
RECODE med3_keerperdag_T4 ('2xpd'='2').
RECODE med3_keerperdag_T4 ('2x pd'='2').
RECODE med3_keerperdag_T4 ('1x per dag'='1').
RECODE med3_keerperdag_T4 ('1x'='1').
RECODE med3_keerperdag_T4 ('0'='1').
RECODE med3_aantdagen_T4 ('3 dagen'='3').
RECODE med3_aantdagen_T4 ('elke dag'='182').
RECODE med3_aantdagen_T4 ('iedere dag'='182').
RECODE med3_aantdagen_T4 ('dagelijks'='182').
RECODE med3_aantdagen_T4 ('alle'='182').
RECODE med3_aantdagen_T4 ('193'='182').
RECODE med3_aantdagen_T4 ('183'='182').
DO IF ID_code=4905.
RECODE med3_keerperdag_T4 ('1 keer per week'='1').
END IF.
DO IF ID_code=4704.
RECODE med3_keerperdag_T4 ('1X P14'='0.07').
END IF.
EXECUTE.

RECODE med4_keerperdag_T4 ('3x'='3').
RECODE med4_keerperdag_T4 ('1x pd'='1').
RECODE med4_keerperdag_T4 ('1pd'='1').
RECODE med4_keerperdag_T4 ('1x'='1').
RECODE med4_keerperdag_T4 ('0,1'='1').
RECODE med4_aantdagen_T4 ('soms'='1').
RECODE med4_aantdagen_T4 ('dagelijks'='182').
RECODE med4_aantdagen_T4 ('193'='182').
RECODE med4_aantdagen_T4 ('183'='182').
EXECUTE.

RECODE med5_keerperdag_T4 ('1x'='1').
RECODE med5_keerperdag_T4 ('1-2'='1.5').
RECODE med5_keerperdag_T4 ('2pd'='2').
RECODE med5_keerperdag_T4 ('3x'='3').
RECODE med5_aantdagen_T4 ('193'='182').
RECODE med5_aantdagen_T4 ('183'='182').
RECODE med5_aantdagen_T4 ('dagelijks'='182').
EXECUTE.

RECODE med6_keerperdag_T4 ('1x'='1').
RECODE med6_keerperdag_T4 ('1pd'='1').
RECODE med6_keerperdag_T4 ('Nvt'='1').
RECODE med6_keerperdag_T4 ('1x'='1').
RECODE med6_aantdagen_T4 ('dagelijks'='182').
DO IF ID_code=5606.
RECODE med6_keerperdag_T4 ('2xper week'='2').
END IF.
EXECUTE.

RECODE med7_keerperdag_T4 ('1 TOT 1,5 PD'='1').
RECODE med7_keerperdag_T4 ('3x'='3').
RECODE med7_keerperdag_T4 ('2x'='2').
RECODE med7_keerperdag_T4 ('6pd'='6').
RECODE med7_aantdagen_T4 ('dagelijks'='182').
EXECUTE.

RECODE med8_keerperdag_T4 ('1x'='1').
RECODE med8_keerperdag_T4 ('zn'='1').
RECODE med8_keerperdag_T4 ('4x'='1').
RECODE med8_aantdagen_T4 ('dagelijks'='182').
EXECUTE.

RECODE med9_keerperdag_T4 ('1x'='1').
RECODE med9_keerperdag_T4 ('zn'='1').
RECODE med9_aantdagen_T4 ('dagelijks'='182').
EXECUTE.

RECODE med10_keerperdag_T4 ('eenmaalig 1 week'='1').
DO IF ID_Code=7102.
RECODE med10_keerperdag_T4 ('incidenteel'='1').
RECODE med10_aantdagen_T4 ('0'='1').
END IF.
EXECUTE.

** ID 6808 Bij aantal dagen med 1: 15/4 over vanaf 30-8-2017 en bij med 2: 15/8 over vanaf 30-8-2017. Zijn zelfde soort medicijnen en op T3 geen medicatie.
* er van uitgaan dat er is overgestapt van ene op andere mediicijn, beide helft van periode meerekenen= 90 dagen.
RECODE med1_aantdagen_T4 ('15/4 over vanaf 30-8-2017'='90').
RECODE med2_aantdagen_T4 ('15/8 over vanaf 30-8-2017'='90').
EXECUTE.

ALTER TYPE med1_keerperdag_T4 med2_keerperdag_T4 med3_keerperdag_T4 med4_keerperdag_T4 med5_keerperdag_T4 
    med6_keerperdag_T4 med7_keerperdag_T4 med8_keerperdag_T4 med9_keerperdag_T4 med10_keerperdag_T4 (F3.2).
VARIABLE WIDTH  med1_keerperdag_T4 med2_keerperdag_T4 med3_keerperdag_T4 med4_keerperdag_T4 med5_keerperdag_T4 
    med6_keerperdag_T4 med7_keerperdag_T4 med8_keerperdag_T4 med9_keerperdag_T4 med10_keerperdag_T4 (7).

ALTER TYPE med1_aantdagen_T4 med2_aantdagen_T4 med3_aantdagen_T4 med4_aantdagen_T4 med5_aantdagen_T4 
    med6_aantdagen_T4 med7_aantdagen_T4 med8_aantdagen_T4 med9_aantdagen_T4  med10_aantdagen_T4 (F3.0).
VARIABLE WIDTH  med1_aantdagen_T4 med2_aantdagen_T4 med3_aantdagen_T4 med4_aantdagen_T4 med5_aantdagen_T4 
    med6_aantdagen_T4 med7_aantdagen_T4 med8_aantdagen_T4 med9_aantdagen_T4  med10_aantdagen_T4 (7).



*** Diverse aanpassingen*****************************************************************************************************************************************************.


*** ID 1506. Vult in bij Med1: Ongewijzigd zie vorige vragenlijst. Overnemen uit T3:.
DO IF ID_Code=1506.
RECODE med1_T4 ('Ongewijzigd zie vorige vragenlijst'='Champix').
RECODE med1_dosering_T4 (''='1 mg').
RECODE med1_keerperdag_T4 (SYSMIS=2).
RECODE med1_aantdagen_T4 (SYSMIS=182).
RECODE med2_T4 (''='Perindopril').
RECODE med2_dosering_T4 (''='20mg').
RECODE med2_keerperdag_T4 (SYSMIS=1).
RECODE med2_aantdagen_T4 (SYSMIS=182).
RECODE med3_T4 (''='Metoprololsuccinaat').
RECODE med3_dosering_T4 (''='100 + 50 mg').
RECODE med3_keerperdag_T4 (SYSMIS=1).
RECODE med3_aantdagen_T4 (SYSMIS=182).
RECODE med4_T4 (''='Pantozol').
RECODE med4_dosering_T4 (''='20 mg').
RECODE med4_keerperdag_T4 (SYSMIS=1).
RECODE med4_aantdagen_T4 (SYSMIS=182).
RECODE med5_T4 (''='Lipitor').
RECODE med5_dosering_T4 (''='80 mg').
RECODE med5_keerperdag_T4 (SYSMIS=1).
RECODE med5_aantdagen_T4 (SYSMIS=182).
RECODE med6_T4 (''='carbasalaatcalcium').
RECODE med6_dosering_T4 (''='100 mg').
RECODE med6_keerperdag_T4 (SYSMIS=1).
RECODE med6_aantdagen_T4 (SYSMIS=182).
END IF.
EXECUTE.


*** ID 1703 med 2 Ayuahuasca: is een drug/thee, moet in een ceremonie worden genomen  hier weg.
DO IF ID_Code=1703.
RECODE med2_T4 ('Ayuahuasca'='').
RECODE med2_dosering_T4 ('20'='').
RECODE med2_keerperdag_T4 (1=SYSMIS).
RECODE med2_aantdagen_T4 (2=SYSMIS).
END IF.

*** ID 1915. Vult in bij doseringMed1: zelfde als voorheen. Overnemen uit T3:.
DO IF ID_Code=1915.
RECODE med1_T4 ('tegen hoge bloeddruk'='Enalapril').
RECODE med1_dosering_T4 ('zelfde als voorheen'='20 mg').
END IF.

*** ID 2206. zie eerdere lijst.
DO IF ID_Code=2206.
RECODE med1_T4 ('1'='Metoprololsuccinaat/Hydrochloorthiazide 95/12,5').
RECODE med1_dosering_T4 ('zie eerdere lijst'='95/12,5').
RECODE med1_keerperdag_T4 (SYSMIS=1).
RECODE med1_aantdagen_T4 (SYSMIS=182).
RECODE med2_T4 ('1'='Eucreas 50/850').
RECODE med2_dosering_T4 (''='50/850').
RECODE med2_keerperdag_T4 (SYSMIS=1).
RECODE med2_aantdagen_T4 (SYSMIS=182).
RECODE med3_T4 ('1'='Amplodine 10 mg').
RECODE med3_dosering_T4 (''='10 mg').
RECODE med3_keerperdag_T4 (SYSMIS=1).
RECODE med3_aantdagen_T4 (SYSMIS=182).
RECODE med4_T4 ('1'='Quinaprikl Aurobindo 10 mg').
RECODE med4_dosering_T4 (''='10 mg').
RECODE med4_keerperdag_T4 (SYSMIS=1).
RECODE med4_aantdagen_T4 (SYSMIS=182).
RECODE med5_T4 ('1'='Atorvastine Ranbaxy 20 mg').
RECODE med5_dosering_T4 (''='20 mg').
RECODE med5_keerperdag_T4 (SYSMIS=1).
RECODE med5_aantdagen_T4 (SYSMIS=182).
RECODE med6_T4 ('1'='Champis').
RECODE med6_dosering_T4 (''='1').
RECODE med6_keerperdag_T4 (SYSMIS=1).
RECODE med6_aantdagen_T4 (SYSMIS=182).
RECODE med7_T4 (''='Vitamine B-conmplex').
RECODE med7_dosering_T4 (''='1').
RECODE med7_keerperdag_T4 (SYSMIS=1).
RECODE med7_aantdagen_T4 (SYSMIS=182).
RECODE med8_T4 (''='Paracetamol').
RECODE med8_dosering_T4 (''='').
RECODE med8_keerperdag_T4 (SYSMIS=1).
RECODE med8_aantdagen_T4 (SYSMIS=1).
END IF.
EXECUTE.

*** ID 3005. Vult in bij Med1: zie vorige opgave, ben naam kwijt. Overnemen uit T3:.
DO IF ID_Code=3005.
RECODE med1_T4 ('zie vorige opgave, ben naam kwijt'='wellbutrin').
END IF.
EXECUTE.

***ID 3208. Bij medicatie overal 0.
DO IF ID_Code=3208.
RECODE med1_T4 med2_T4 med3_T4 med4_T4 med5_T4 med6_T4 med7_T4 med8_T4 med9_T4 med10_T4 ('0'='').
END IF.

*** ID 4308. Vult in bij Med1: Zie vorige lijsten. Overnemen uit T3:.
DO IF ID_Code=4308.
RECODE med1_T4 (''='atorvastitiene 10 mg').
RECODE med1_dosering_T4 (''='10mg').
RECODE med1_keerperdag_T4 (SYSMIS=1).
RECODE med1_aantdagen_T4 (SYSMIS=182).
RECODE med2_T4 (' '='mono- cedocard 25 mg').
RECODE med2_dosering_T4 (''='25 mg').
RECODE med2_keerperdag_T4 (SYSMIS=1).
RECODE med2_aantdagen_T4 (SYSMIS=182).
RECODE med3_T4 (''='metoprolosuccinaat 100').
RECODE med3_dosering_T4 (''='100 mg').
RECODE med3_keerperdag_T4 (SYSMIS=1).
RECODE med3_aantdagen_T4 (SYSMIS=182).
RECODE med4_T4 (''='enalaprilmaleaat 10 mg').
RECODE med4_dosering_T4 (''='10 mg').
RECODE med4_keerperdag_T4 (SYSMIS=1).
RECODE med4_aantdagen_T4 (SYSMIS=60).
RECODE med5_T4 (''='carbasalaatcalciuum 100').
RECODE med5_dosering_T4 (''='100 mg').
RECODE med5_keerperdag_T4 (SYSMIS=1).
RECODE med5_aantdagen_T4 (SYSMIS=182).
RECODE med6_T4 (''='hydrochloorthiazide  25 mg').
RECODE med6_dosering_T4 (''='25 mg').
RECODE med6_keerperdag_T4 (SYSMIS=1).
RECODE med6_aantdagen_T4 (SYSMIS=182).
END IF.
EXECUTE.


*** ID 4904. Vult in bij Med1: kijk naar vorig formulier er is niks veranderd.. Overnemen uit T2:.
DO IF ID_Code=4904.
RECODE med1_T4 ('kijk naar vorig formulier er is niks veranderd.'='Irbesart/hct').
RECODE med1_dosering_T4 (''='300').
RECODE med1_keerperdag_T4 (SYSMIS=1).
RECODE med1_aantdagen_T4 (SYSMIS=90).
RECODE med2_T4 (' '='Atorvastatine 40').
RECODE med2_dosering_T4 (''='40 mg').
RECODE med2_keerperdag_T4 (SYSMIS=1).
RECODE med2_aantdagen_T4 (SYSMIS=90).
RECODE med3_T4 (''='metoprolosuccinaat').
RECODE med3_dosering_T4 (''='50 mg').
RECODE med3_keerperdag_T4 (SYSMIS=1).
RECODE med3_aantdagen_T4 (SYSMIS=90).
RECODE med4_T4 (''='Champix').
RECODE med4_dosering_T4 (''='1 mg').
RECODE med4_keerperdag_T4 (SYSMIS=1).
RECODE med4_aantdagen_T4 (SYSMIS=60).
END IF.
EXECUTE.

*** aparte syntaxen ATC code, dosering en kosten runnen. 

* runnen na syntax ATC>.
* Nicotinevervangers (N07BA01) worden uit de medicatie gehaald. Controle of ze bij vraag over nicotinevervangers worden genoemd. Zo nee, daar aanvullen.
*alleen med2 3x.


DO IF atc2_T4='N07BA01'.
COMPUTE med2_T4=' '.
COMPUTE med2_dosering_T4=' '.
COMPUTE med2_keerperdag_T4=$SYSMIS.
COMPUTE med2_aantdagen_T4=$SYSMIS.
COMPUTE med2_vorm_T4=' '.
END IF.
RECODE atc2_T4 ('N07BA01'=' ').
EXECUTE.


*** Q84: EHBO********************************************************************************************************************************************.
RENAME VARIABLES Q84=EHBO_T4 / Q84_TEXT=EHBO_aant_keer_T4.
VARIABLE LABELS EHBO_T4 'EHBO ja/nee T4' EHBO_aant_keer_T4 'EHBO aantal keer T4'.
VALUE LABELS EHBO_T4 1 'nee' 2 'ja'.
* aantal keer van string naar numeriek.
* controle op tekst.
FREQUENCIES VARIABLES=EHBO_aant_keer_T4
  /ORDER=ANALYSIS.

RECODE EHBO_aant_keer_T4 ('2x'='2')  .
EXECUTE.
*ID 4308: aantal keer=zie een jaar geleden hier is het dus nee.
DO IF ID_code=4308.
RECODE EHBO_aant_keer_T4 ('Zie een jaar geleden'=$SYSMIS) . 
RECODE EHBO_T4 (2=1).
END IF.
EXECUTE.
ALTER TYPE EHBO_aant_keer_T4 (F3.0).

* wel naar EHBO en aant keer missing: conservatieve schatting.
DO IF EHBO_T4=2.
RECODE EHBO_aant_keer_T4 (SYSMIS=1).
END IF.
* wel naar EHBO en aant keer =0: conservatieve schatting.
DO IF EHBO_T4=2.
RECODE EHBO_aant_keer_T4 (0=1).
END IF.
EXECUTE.
* niet naar EHBO: aantal keer =0.
DO IF (EHBO_T4=1).
RECODE EHBO_aant_keer_T4 (SYSMIS=0).
END IF.
EXECUTE.
* missings invullen.
RECODE EHBO_T4 (SYSMIS=9).
EXECUTE.
DO IF (EHBO_T4=9).
RECODE EHBO_aant_keer_T4 (SYSMIS=99).
END IF.
EXECUTE.
MISSING VALUES EHBO_T4 (9) EHBO_aant_keer_T4 (99).
VARIABLE LEVEL  EHBO_T4 (NOMINAL) EHBO_aant_keer_T4 (SCALE).
VARIABLE WIDTH  EHBO_T4 (4) EHBO_aant_keer_T4 (9).

*** Q85: ambulance********************************************************************************************************************************************.
RENAME VARIABLES Q85=ambulance_T4 / Q85_TEXT=ambulance_aant_keer_T4.
VARIABLE LABELS ambulance_T4 'ambulance ja/nee T4' ambulance_aant_keer_T4 'ambulance aantal keer T4'.
VALUE LABELS ambulance_T4 1 'nee' 2 'ja'.

* aantal keer van string naar numeriek.
* controle op tekst.
FREQUENCIES VARIABLES=ambulance_aant_keer_T4
  /ORDER=ANALYSIS.

RECODE ambulance_aant_keer_T4 ('1x'='1').
EXECUTE.
ALTER TYPE ambulance_aant_keer_T4 (F3.0).

* wel ambulance en aant keer =0: conservatieve schatting.
DO IF ambulance_T4=2.
RECODE ambulance_aant_keer_T4 (0=1).
END IF.
* niet ambulance: aantal dagen =0.
DO IF ambulance_T4=1.
RECODE ambulance_aant_keer_T4 (SYSMIS=0).
END IF.
EXECUTE.
* missings invullen.
MISSING VALUES ambulance_aant_keer_T4 (99).
RECODE ambulance_T4 (SYSMIS=9).
EXECUTE.
DO IF (ambulance_T4=9).
RECODE ambulance_aant_keer_T4 (SYSMIS=99).
END IF.
EXECUTE.
MISSING VALUES ambulance_T4 (9) ambulance_aant_keer_T4 (99).
VARIABLE LEVEL ambulance_T4 (NOMINAL) ambulance_aant_keer_T4 (SCALE).
VARIABLE WIDTH  ambulance_T4 (4) ambulance_aant_keer_T4 (9).

*** Q86: poli********************************************************************************************************************************************.
RENAME VARIABLES Q86=poli_T4.
VARIABLE LABELS poli_T4 'bezoek poli: ja/nee T4'.
VALUE LABELS poli_T4 1 'nee' 2 'ja'.
*missing toevoegen.
RECODE poli_T4 (SYSMIS=9).
MISSING VALUES poli_T4 (9).
EXECUTE.

*Q88_1_1_TEXT t/m 6 is excact hetzelfde als Q88_2_1_TEXT t/m 6 (specialisme, inclusief zelfde spelfouten) --> Q91_2 verwijderen.
DELETE VARIABLES  Q88_2_1_TEXT Q88_2_2_TEXT Q88_2_3_TEXT Q88_2_4_TEXT Q88_2_5_TEXT Q88_2_6_TEXT.
RENAME VARIABLES  Q88_1_1_TEXT=specialisme1_T4 /  Q88_1_2_TEXT=specialisme2_T4 /   Q88_1_3_TEXT=specialisme3_T4 / 
  Q88_1_4_TEXT=specialisme4_T4 /   Q88_1_5_TEXT=specialisme5_T4 /   Q88_1_6_TEXT=specialisme6_T4. 
RENAME VARIABLES  Q88_1_1_1_TEXT=ziekenhuis1_T4 / Q88_1_2_1_TEXT=ziekenhuis2_T4 / Q88_1_3_1_TEXT=ziekenhuis3_T4 / 
Q88_1_4_1_TEXT=ziekenhuis4_T4 / Q88_1_5_1_TEXT=ziekenhuis5_T4 / Q88_1_6_1_TEXT=ziekenhuis6_T4. 
RENAME VARIABLES  Q88_2_1_1_TEXT=spec1_aant_keer_T4 / Q88_2_2_1_TEXT=spec2_aant_keer_T4 / Q88_2_3_1_TEXT=spec3_aant_keer_T4 /
Q88_2_4_1_TEXT=spec4_aant_keer_T4/Q88_2_5_1_TEXT=spec5_aant_keer_T4 /Q88_2_6_1_TEXT=spec6_aant_keer_T4 .

VARIABLE LABELS specialisme1_T4 / specialisme2_T4 / specialisme3_T4 / specialisme4_T4 / specialisme5_T4 / specialisme6_T4. 
VARIABLE LABELS ziekenhuis1_T4 / ziekenhuis2_T4 / ziekenhuis3_T4 / ziekenhuis4_T4 / ziekenhuis5_T4 / ziekenhuis6_T4. 
VARIABLE LABELS  spec1_aant_keer_T4 / spec2_aant_keer_T4 / spec3_aant_keer_T4 /  spec4_aant_keer_T4.

** specialisatie hetzelfde noemen.
FREQUENCIES VARIABLES=specialisme1_T4 specialisme2_T4 specialisme3_T4 specialisme4_T4 specialisme5_T4 specialisme6_T4
  /ORDER=ANALYSIS.

RECODE specialisme1_T4 ('cardioloog'='Cardioloog').
RECODE specialisme1_T4 ('cardiooog'='Cardioloog').
RECODE specialisme1_T4 ('Chrurig'='Chirurg').
RECODE specialisme1_T4 ('chirurgie'='Chirurg').
RECODE specialisme1_T4 ('chirurg'='Chirurg').
RECODE specialisme1_T4 ('dermatologie'='Dermatoloog').
RECODE specialisme1_T4 ('dieetiste'='Diëtiest').
RECODE specialisme1_T4 ('endocrinoloog'='Endocrinoloog').
RECODE specialisme1_T4 ('gynaecoloog'='Gynaecoloog').
RECODE specialisme1_T4 ('gynecoloog'='Gynaecoloog').
RECODE specialisme1_T4 ('internist'='Internist').
RECODE specialisme1_T4 ('Kno arts'='KNO').
RECODE specialisme1_T4 ('KNO arts'='KNO').
RECODE specialisme1_T4 ('KNO-arts'='KNO').
RECODE specialisme1_T4 ('Kno'='KNO').
RECODE specialisme1_T4 ('kno'='KNO').
RECODE specialisme1_T4 ('longarts'='Longarts').
RECODE specialisme1_T4 ('Birkelmans'='Longarts').
RECODE specialisme1_T4 ('MDL (maag-, darm- leverarts'='MDL arts').
RECODE specialisme1_T4 ('Darm en lever'='MDL arts').
RECODE specialisme1_T4 ('MDL'='MDL arts').
RECODE specialisme1_T4 ('MLD-arts'='MDL arts').
RECODE specialisme1_T4 ('mdl arts'='MDL arts').
RECODE specialisme1_T4 ('Maag, darm, lever arts'='MDL arts').
RECODE specialisme1_T4 ('internist mld'='MDL arts').
RECODE specialisme1_T4 ('neuroloog'='Neuroloog').
RECODE specialisme1_T4 ('oogarts'='Oogarts').
RECODE specialisme1_T4 ('Plastisch Chirurg'='Plastisch chirurg').
RECODE specialisme1_T4 ('Zuur'='Oncoloog').
RECODE specialisme1_T4 ('Kam orthopeed'='Orthopeed').
RECODE specialisme1_T4 ('dr Wassink'='Orthopeed').
RECODE specialisme1_T4 ('Orthopedie'='Orthopeed').
RECODE specialisme1_T4 ('orthopeed'='Orthopeed').
RECODE specialisme1_T4 ('orthopeet'='Orthopeed').
RECODE specialisme1_T4 ('Orthopeet'='Orthopeed').
RECODE specialisme1_T4 ('Ortopeed'='Orthopeed').
RECODE specialisme1_T4 ('radioloog'='Radioloog').
RECODE specialisme1_T4 ('radiotherapeut'='Radioloog').
RECODE specialisme1_T4 ('reumatoloog'='Reumatoloog').
RECODE specialisme1_T4 ('uroloog'='Uroloog').
RECODE specialisme1_T4 ('vaatchirurg'='Vaatchirurg').
EXECUTE.

RECODE specialisme2_T4 ('uroloog'='Uroloog').
RECODE specialisme2_T4 ('rheumatoloog'='Reumatoloog').
RECODE specialisme2_T4 ('reumatoloog'='Reumatoloog').
RECODE specialisme2_T4 ('revalidatie arts'='Revalidatie arts').
RECODE specialisme2_T4 ('radiotherapeut'='Radiotherapeut').
RECODE specialisme2_T4 ('orthopedisch chirurg'='Orthopedisch chirurg').
RECODE specialisme2_T4 ('oogarts'='Oogarts').
RECODE specialisme2_T4 ('neuroloog'='Neuroloog').
RECODE specialisme2_T4 ('Joosten'='Longarts').
RECODE specialisme2_T4 ('oncoloog'='Oncoloog').
RECODE specialisme2_T4 ('Kno'='KNO').
RECODE specialisme2_T4 ('kno'='KNO').
RECODE specialisme2_T4 ('kaakchirurg'='Kaakchirurg').
RECODE specialisme2_T4 ('internist'='Internist').
RECODE specialisme2_T4 ('Endoctroloog'='Endocrinoloog').
RECODE specialisme2_T4 ('chirurgie'='Chirurg').
RECODE specialisme2_T4 ('chirurg'='Chirurg').
RECODE specialisme2_T4 ('0'='').
EXECUTE.

RECODE specialisme3_T4 ('uroloog'='Uroloog').
RECODE specialisme3_T4 ('Orthopaedie'='Orthopeed').
RECODE specialisme3_T4 ('Orthopeet'='Orthopeed').
RECODE specialisme3_T4 ('oogarts'='Oogarts').
RECODE specialisme3_T4 ('oogheelkunde'='Oogarts').
RECODE specialisme3_T4 ('neurloloog'='Neuroloog').
RECODE specialisme3_T4 ('internist'='Internist').
RECODE specialisme3_T4 ('arts assistent chirurgie'='Chirurg').
RECODE specialisme3_T4 ('0'='').
EXECUTE.

RECODE specialisme4_T4 ('uroloog'='Uroloog').
RECODE specialisme4_T4 ('cardioloog'='Cardioloog').
RECODE specialisme4_T4 ('0'='').
RECODE specialisme5_T4 ('0'='').
EXECUTE.

** Aanpassingen.
** ID 2502 fysiotherapie: verplaatsen naar consult fysio.
DO IF ID_code=2502.
RECODE poli_T4 (2=1).
RECODE ziekenhuis1_T4 ('waterland ziekenhuis'='').
RECODE specialisme1_T4 ('fysiotherapeut'='').
RECODE spec1_aant_keer_T4 ('3'='').
RECODE consult11_T4 (0=3).
END IF.
EXECUTE.

** ID 1604 fysiotherapie: staat al bij  consult fysio.
DO IF ID_code=1604.
RECODE ziekenhuis2_T4 ('Catharina'='').
RECODE specialisme2_T4 ('Fysiotherapie'='').
RECODE spec2_aant_keer_T4 ('1'='').
END IF.
EXECUTE.

** ID 6210 arts DEH: staat al bij  ehbo.
DO IF ID_code=6210.
RECODE ziekenhuis1_T4 ('Tweesteden Tilburg'='').
RECODE specialisme1_T4 ('Arts SEH'='').
RECODE spec2_aant_keer_T4 ('1'='').
END IF.
EXECUTE.

** ID 2703 huisarts 3x: staat al 2x bij consult ha. --> 3x van maken.
DO IF ID_code=2703.
RECODE ziekenhuis3_T4 ('huisarts'='').
RECODE specialisme3_T4 ('suikerartsdiabeet'='').
RECODE spec3_aant_keer_T4 ('3'='').
RECODE consult1_T4 (2=3).
END IF.
EXECUTE.


** ziekenhuizen hetzelfde noemen.

RECODE ziekenhuis1_T4  ('Amc'='AMC Amsterdam').
RECODE ziekenhuis1_T4  ('avl'='Antonie van Leeuwenhoek').
RECODE ziekenhuis1_T4  ('Antonius'='Antonie van Leeuwenhoek').
RECODE ziekenhuis1_T4  ('Antonie van LEeuwenhoek'='Antonie van Leeuwenhoek').
RECODE ziekenhuis1_T4  ('azm'='AZM').
RECODE ziekenhuis1_T4  ('Azm'='AZM').
RECODE ziekenhuis1_T4  ('MUMC'='AZM').
RECODE ziekenhuis1_T4  ('UMCM'='AZM').
RECODE ziekenhuis1_T4  ('Academische ziekenhuis Maastricht'='AZM').
RECODE ziekenhuis1_T4  ('academisch ziekenhuis maastricht'='AZM').
RECODE ziekenhuis1_T4  ('maastricht'='AZM').
RECODE ziekenhuis1_T4  ('mst'='AZM').
RECODE ziekenhuis1_T4  ('academisch ziekenhuis Maastricht'='AZM').
RECODE ziekenhuis1_T4  ('Asz'='Albert Schweitzer ziekenhuis').
RECODE ziekenhuis1_T4  ('Albert schweitser'='Albert Schweitzer ziekenhuis').
RECODE ziekenhuis1_T4  ('AZU'='UMC Utrecht').
RECODE ziekenhuis1_T4  ('bravis'='Bravis').
RECODE ziekenhuis1_T4  ('Bravis Roosendaal'='Bravis').
RECODE ziekenhuis1_T4  ('Bravis BoZ'='Bravis').
RECODE ziekenhuis1_T4  ('Bravis bergen op Zoom'='Bravis').
RECODE ziekenhuis1_T4  ('Catherine ziekenhuis'='Catharina').
RECODE ziekenhuis1_T4  ('Catharina eindhoven'='Catharina').
RECODE ziekenhuis1_T4  ('catharina eindhoven'='Catharina').
RECODE ziekenhuis1_T4  ('Catharinaziekenhuis'='Catharina').
RECODE ziekenhuis1_T4  ('Catharinaziekenhuis Eindhoven'='Catharina').
RECODE ziekenhuis1_T4  ('Cwz'='Canisius-Wilhelmina').
RECODE ziekenhuis1_T4  ('cwz'='Canisius-Wilhelmina').
RECODE ziekenhuis1_T4  ('CWZ'='Canisius-Wilhelmina').
RECODE ziekenhuis1_T4  ('CWZ Nijmegen'='Canisius-Wilhelmina').
RECODE ziekenhuis1_T4  ('diakonessenhuis utrecht'='Diakonessenhuis').
RECODE ziekenhuis1_T4  ('Diakonesse Utrecht'='Diakonessenhuis').
RECODE ziekenhuis1_T4  ('elkerliek'='Elkerliek').
RECODE ziekenhuis1_T4  ('emmen'='Emmen').
RECODE ziekenhuis1_T4  ('sze'='Emmen').
RECODE ziekenhuis1_T4  ('franciscus rotterdam'='Sint Franciscus Gasthuis').
RECODE ziekenhuis1_T4  ('Geleen/Sittard'='Zuyderland').
RECODE ziekenhuis1_T4  ('Zuyderland Geleen/Sittard'='Zuyderland').
RECODE ziekenhuis1_T4  ('Sittard'='Zuyderland').
RECODE ziekenhuis1_T4  ('Gelre ziekehuis'='Gelre').
RECODE ziekenhuis1_T4  ('Gelre Apeldoorn'='Gelre').
RECODE ziekenhuis1_T4  ('hoorn'='Hoorn').
RECODE ziekenhuis1_T4  ('IJsseland'='IJsselland').
RECODE ziekenhuis1_T4  ('Ikazia/Erasmus MC'='Erasmus').
RECODE ziekenhuis1_T4  ('Erasmus MC'='Erasmus').
RECODE ziekenhuis1_T4  ('isala'='Isala').
RECODE ziekenhuis1_T4  ('Isala Klinieken'='Isala').
RECODE ziekenhuis1_T4  ('Isala, Zwolle'='Isala').
RECODE ziekenhuis1_T4  ('Isala kliniek'='Isala').
RECODE ziekenhuis1_T4  ('laurentius'='Laurentius').
RECODE ziekenhuis1_T4  ('Laurentius Roermonf'='Laurentius').
RECODE ziekenhuis1_T4  ('Laurentius Ziekenhuis'='Laurentius').
RECODE ziekenhuis1_T4  ('Laurentius Ziekenhuis Roermond'='Laurentius').
RECODE ziekenhuis1_T4  ('Roermond'='Laurentius').
RECODE ziekenhuis1_T4  ('Lumc'='LUMC').
RECODE ziekenhuis1_T4  ('maasstad'='Maasstad').
RECODE ziekenhuis1_T4  ('Maximaal medisch centrum'='Maxima Medisch Centrum').
RECODE ziekenhuis1_T4  ('mcl'='MCL').
RECODE ziekenhuis1_T4  ('Noord west ziekenhuis groep'='Noordwest Ziekenhuisgroep').
RECODE ziekenhuis1_T4  ('overpelt'='Overpelt').
RECODE ziekenhuis1_T4  ('OLVG West'='Onze Lieve Vrouwe Gasthuis').
RECODE ziekenhuis1_T4  ('Poli kampen'='Polikliniek Kampen').
RECODE ziekenhuis1_T4  ('radboud'='Radboud').
RECODE ziekenhuis1_T4  ('Radboudumc'='Radboud').
RECODE ziekenhuis1_T4  ('radboud umc'='Radboud').
RECODE ziekenhuis1_T4  ('Umcn'='Radboud').
RECODE ziekenhuis1_T4  ('rijnland'='Alrijne').
RECODE ziekenhuis1_T4  ('reinier de graaf'='Reinier de Graaf').
RECODE ziekenhuis1_T4  ('reinier de graaf delft'='Reinier de Graaf').
RECODE ziekenhuis1_T4  ('roermond'='Laurentius').
RECODE ziekenhuis1_T4  ('St. Anna Ziekenhuis'='st Anna Geldrop').
RECODE ziekenhuis1_T4  ('St Anna Geldrop'='st Anna Geldrop').
RECODE ziekenhuis1_T4  ('Sint Maartenskliniek Nijmegen'='Sint Maartens kliniek').
RECODE ziekenhuis1_T4  ('St maartens kliniek'='Sint Maartens kliniek').
RECODE ziekenhuis1_T4  ('Sint jansgasthuis weert'='Sint Jans Gasthuis').
RECODE ziekenhuis1_T4  ('Sj gasthuis'='Sint Jans Gasthuis').
RECODE ziekenhuis1_T4  ('venlo'='VieCuri').
RECODE ziekenhuis1_T4  ('Venlo'='VieCuri').
RECODE ziekenhuis1_T4  ('viecuri'='VieCuri').
RECODE ziekenhuis1_T4  ('Viecuri'='VieCuri').
RECODE ziekenhuis1_T4  ('Viecurie'='VieCuri').
RECODE ziekenhuis1_T4  ('vie curi'='VieCuri').
RECODE ziekenhuis1_T4  ('weert'='Sint Jans Gasthuis').
RECODE ziekenhuis1_T4  ('Westfries Gasthuis'='Westfriesgasthuis').
RECODE ziekenhuis1_T4  ('waterland ziekenhuis'='Waterland').
RECODE ziekenhuis1_T4  ('WFG'='Westfriesgasthuis').
RECODE ziekenhuis1_T4  ('Zuiderland'='Zuyderland').
RECODE ziekenhuis1_T4  ('Zuyderland heerlen'='Zuyderland').
RECODE ziekenhuis1_T4  ('Heerlen'='Zuyderland').
RECODE ziekenhuis1_T4  ('1'='Onbekend').
EXECUTE.

RECODE ziekenhuis2_T4  ('Zuyderland Sittard'='Zuyderland').
RECODE ziekenhuis2_T4  ('Ziekenhuis'='Onbekend').
RECODE ziekenhuis2_T4  ('Zaansmedisch Centrum'='Zaans Medisch Centrum').
RECODE ziekenhuis2_T4  ('WFG'='Westfriesgasthuis').
RECODE ziekenhuis2_T4  ('Viecuri'='VieCuri').
RECODE ziekenhuis2_T4  ('viecuri'='VieCuri').
RECODE ziekenhuis2_T4  ('venlo'='VieCuri').
RECODE ziekenhuis2_T4  ('sze'='Emmen').
RECODE ziekenhuis2_T4  ('roermond'='Laurentius').
RECODE ziekenhuis2_T4  ('emmen'='Emmen').
RECODE ziekenhuis2_T4  ('SJG Weert'='Sint Jans Gasthuis').
RECODE ziekenhuis2_T4  ('reinier de graaf'='Reinier de Graaf').
RECODE ziekenhuis2_T4  ('radboud'='Radboud').
RECODE ziekenhuis2_T4  ('Radboudumc'='Radboud').
RECODE ziekenhuis2_T4  ('St Anna Geldrop'='st Anna Geldrop').
RECODE ziekenhuis2_T4  ('overpelt'='Overpelt').
RECODE ziekenhuis2_T4  ('obesitas eindhoven'='Catharina').
RECODE ziekenhuis2_T4  ('OLVG West'='Onze Lieve Vrouwe Gasthuis').
RECODE ziekenhuis2_T4  ('maasstad'='Maasstad').
RECODE ziekenhuis2_T4  ('Máxima medische centrum'='Maxima Medisch Centrum').
RECODE ziekenhuis2_T4  ('mcl'='MCL').
RECODE ziekenhuis2_T4  ('Laurentius Ziekenhuis Roermond'='Laurentius').
RECODE ziekenhuis2_T4  ('Lumc, Leiden'='LUMC').
RECODE ziekenhuis2_T4  ('lelystad / emmeloord'='MC Zuiderzee').
RECODE ziekenhuis2_T4  ('Isala kliniek'='Isala').
RECODE ziekenhuis2_T4  ('isala'='Isala').
RECODE ziekenhuis2_T4  ('Heerlen'='Zuyderland').
RECODE ziekenhuis2_T4  ('Gelre ziekenhuis Apeldoorn'='Gelre').
RECODE ziekenhuis2_T4  ('franciscus rotterdam'='Sint Franciscus Gasthuis').
RECODE ziekenhuis2_T4  ('Erasmus MC'='Erasmus').
RECODE ziekenhuis2_T4  ('cwz'='Canisius-Wilhelmina').
RECODE ziekenhuis2_T4  ('Catharina zkh ehv'='Catharina').
RECODE ziekenhuis2_T4  ('annatomie'='Annatommie Rijswijk').
RECODE ziekenhuis2_T4  ('0'='').
EXECUTE.

RECODE ziekenhuis3_T4  ('Ziekenhuis'='Onbekend').
RECODE ziekenhuis3_T4  ('WFG'='Westfriesgasthuis').
RECODE ziekenhuis3_T4  ('Viecuri'='VieCuri').
RECODE ziekenhuis3_T4  ('venlo'='VieCuri').
RECODE ziekenhuis3_T4  ('SJG Weert'='Sint Jans Gasthuis').
RECODE ziekenhuis3_T4  ('St Anna Geldrop'='st Anna Geldrop').
RECODE ziekenhuis3_T4  ('reinier de graaf'='Reinier de Graaf').
RECODE ziekenhuis3_T4  ('radboud'='Radboud').
RECODE ziekenhuis3_T4  ('radboudumc'='Radboud').
RECODE ziekenhuis3_T4  ('overpelt'='Overpelt').
RECODE ziekenhuis3_T4  ('mch westeinde'='HMC Westeinde').
RECODE ziekenhuis3_T4  ('Máxima medisch centrum'='Maxima Medisch Centrum').
RECODE ziekenhuis3_T4  ('maasstad'='Maasstad').
RECODE ziekenhuis3_T4  ('Heerlen'='Zuyderland').
RECODE ziekenhuis3_T4  ('Gelre ziekenhuis Apeldoorn'='Gelre').
RECODE ziekenhuis3_T4  ('Catarina'='Catharina').
RECODE ziekenhuis3_T4  ('Catharina zkh ehv'='Catharina').
RECODE ziekenhuis3_T4  ('0'='').
EXECUTE.

RECODE ziekenhuis4_T4  ('venlo'='VieCuri').
RECODE ziekenhuis4_T4  ('reinier de graaf'='Reinier de Graaf').
RECODE ziekenhuis4_T4  ('Heerlen'='Zuyderland').
RECODE ziekenhuis4_T4  ('Catarina'='Catharina').
RECODE ziekenhuis4_T4  ('0'='').
EXECUTE.

RECODE ziekenhuis5_T4  ('Heerlen'='Zuyderland').
RECODE ziekenhuis5_T4  ('0'='').
EXECUTE.


** ziekenhuis 6 is leeg.
DELETE VARIABLES ziekenhuis6_T4 specialisme6_T4 spec6_aant_keer_T4.

** Ziekenhuis algemeen of academisch. 

RECODE ziekenhuis1_T4 ziekenhuis2_T4 ziekenhuis3_T4 ziekenhuis4_T4 ziekenhuis5_T4 (CONVERT) ('onbekend'=2)
('Albert Schweitzer ziekenhuis'=2) ('Aken'=1) ('Alrijne'=2) ('AMC Amsterdam'=1) ('Amphia'=2) ('Anthoniushove'=2) ('Antonius'=2) ('Antonie van Leeuwenhoek'=2) 
('Annatommie Rijswijk'=2) ('ASZ'=2) ('AZM'=1) ('Bernhoven'=2) ('Bravis'=2) ('Canisius-Wilhelmina'=2) 
('Catharina'=2) ('CWZ Nijmegen'=2) ('Dekkerswald'=2) ('Deventer'=2)  ('Diakonessenhuis'=2)  ('Diagnosecentrum Lommel'=2) 
('Elisabeth - TweeSteden Ziekehuis'=2) ('Elkerliek'=2) ('Emmen'=2)   ('Erasmus'=1)  ('Franciscus Rotterdam'=2) ('Gelre'=2) ('Haga'=2) ('Helmond'=2) ('Hoorn'=2)
('Hoofddorp'=2) ('HMC Westeinde'=2) ('IJsselland'=2) ('Ikazia'=2) ('Isala'=2) ('Kampen'=2)
('Langeland'=2) ('Lange Voorhout kliniek'=2) ('Laurentius'=2) ('Linge polikliniek'=2) ('LUMC'=1) ('Maartenskliniek'=2) ('MeanderMC'=2) ('MMC'=2) ('Medisch centum alkmaar'=2) 
('Maas en Kempen Bree'=2) ('Maasstad'=2)  ('Maastricht UMC'=1)  ('Mariaziekenhuis Overpelt'=2)
('MC Zuiderzee'=2) ('MCL'=2) ('Meander'=2) ('Maxima Medisch Centrum'=2) ('Noordwest Ziekenhuisgroep'=2) ('Onbekend'=2)
('Onze Lieve Vrouwe Gasthuis'=2)  ('Overpelt'=2)
('Polikliniek'=2) ('Polikliniek Kampen'=2) ('Poli kanoën'=2) ('Radboud'=1) ('Reinier de Graaf'=2) ('Reinaart Kliniek'=2)
('Rijnstate'=2) ('Scheper'=2) ('Slotervaart'=2) ('SMT Enschede'=2) ('Sophia'=2) ('Spaarne Gasthuis'=2) 
('Spijkenisse MC'=2) ('Stadskanaal'=2) ('St.jans'=2) ('Sint Jans Gasthuis'=2) ('st Anna Geldrop'=2) ('Sint Lucas Andreas'=2)  ('Sint Maartens kliniek '=2) ('Sint Franciscus Gasthuis'=2)
('SZE'=2) ('UMCG'=1) ('UZ Leuven'=1) ('UMC Utrecht'=1) ('Viasana'=2)  ('VieCuri'=2) ('vlietland'=2) ('Waterland'=2)
('Weert'=2) ('Westfriesgasthuis'=2)  ('Zaans Medisch Centrum'=2) ('Zuyderland'=2) INTO ZH1_type_T4 ZH2_type_T4 ZH3_type_T4 ZH4_type_T4 ZH5_type_T4.
EXECUTE.

FORMATS ZH1_type_T4 ZH2_type_T4 ZH3_type_T4 ZH4_type_T4 ZH5_type_T4 (F1.0).
VARIABLE WIDTH ZH1_type_T4 ZH2_type_T4 ZH3_type_T4 ZH4_type_T4 ZH5_type_T4 (6).
VALUE LABELS ZH1_type_T4 ZH2_type_T4 ZH3_type_T4 ZH4_type_T4 ZH5_type_T4 1  'academisch' 2 'algemeen'.  

** aantal keer van string naar numeriek.
* controle op tekst.

RECODE spec1_aant_keer_T4  ('2x'='2').
RECODE spec1_aant_keer_T4  ('10x'='10').
EXECUTE.

ALTER TYPE spec1_aant_keer_T4 spec2_aant_keer_T4 spec3_aant_keer_T4 spec4_aant_keer_T4 spec5_aant_keer_T4 (F2.0).
VARIABLE WIDTH spec1_aant_keer_T4 spec2_aant_keer_T4 spec3_aant_keer_T4 spec4_aant_keer_T4 spec5_aant_keer_T4 (9).
VARIABLE LEVEL spec1_aant_keer_T4 spec2_aant_keer_T4 spec3_aant_keer_T4 spec4_aant_keer_T4 spec5_aant_keer_T4 (SCALE).

*Als het aantal keer missing is wordt het 1 (conservatieve schatting). 
DO IF (SYSMIS(ZH1_type_T4)=0).
RECODE spec1_aant_keer_T4 (SYSMIS=1).
END IF. 
DO IF (SYSMIS(ZH2_type_T4)=0).
RECODE spec2_aant_keer_T4 (SYSMIS=1).
END IF. 
EXECUTE.
 
* 4x ja, verder niets ingevuld.
DO IF (ID_code=1117 or ID_code=3808  or ID_code=6210  or ID_code=5908).
RECODE ZH1_type_T4 (SYSMIS=2).
RECODE ziekenhuis1_T4 (''='Onbekend').
RECODE spec1_aant_keer_T4 (SYSMIS=1).
END IF.
EXECUTE.

VARIABLE LEVEL poli_T4 (NOMINAL).


*** Q89: dagbehandeling ***************************************************************************************************************************************.
RENAME VARIABLES Q89=dagbehandeling_T4.
VARIABLE LABELS dagbehandeling_T4 'Dagbehandeling: ja/nee T4'.
VARIABLE LEVEL dagbehandeling_T4 (NOMINAL).

RENAME VARIABLES Q90_1_TEXT =Dagbehandeling1_T4 / Q90_2_TEXT =Dagbehandeling2_T4 / Q90_3_TEXT=Dagbehandeling3_T4 / Q90_4_TEXT =Dagbehandeling4_T4 / 
Q90_5_TEXT =Dagbehandeling5_T4 / Q90_6_TEXT=Dagbehandeling6_T4.

RENAME VARIABLES Q91_x1_TEXT=Dagbehandeling1_aant_keer_T4 / Q91_x2_TEXT =Dagbehandeling2_aant_keer_T4 / Q91_x3_TEXT =Dagbehandeling3_aant_keer_T4 / 
Q91_x4_TEXT =Dagbehandeling4_aant_keer_T4 / Q91_x5_TEXT =Dagbehandeling5_aant_keer_T4 / Q91_x6_TEXT =Dagbehandeling6_aant_keer_T4.

** aantal keer van string naar numeriek.
** ID 3902. Toediening infuus 3x.
DO IF ID_code=3902.
RECODE dagbehandeling2_T4 ('Toediening infuus'='').
RECODE dagbehandeling3_T4 ('Toediening infuus'='').
RECODE dagbehandeling1_aant_keer_T4 ('Sept'='3').
RECODE dagbehandeling2_aant_keer_T4 ('Nov'='').
RECODE dagbehandeling3_aant_keer_T4 ('Jan'='').
END IF.

** ID 1111 Bij aantal keer staat  'maagband verwijderen'.
DO IF ID_code=1111.
RECODE dagbehandeling1_T4 ('operatie'='maagband verwijderen').
RECODE dagbehandeling1_aant_keer_T4 ('maagband verwijderen'='1').
END IF.
EXECUTE.

** dagbehandeling 5 en 6 zijn leeg.
DELETE VARIABLES dagbehandeling5_T4 dagbehandeling6_T4 Dagbehandeling5_aant_keer_T4  Dagbehandeling6_aant_keer_T4.

ALTER TYPE Dagbehandeling1_aant_keer_T4 Dagbehandeling2_aant_keer_T4 Dagbehandeling3_aant_keer_T4 Dagbehandeling4_aant_keer_T4  (F2.0).

VARIABLE LABELS Dagbehandeling1_T4 / Dagbehandeling2_T4 / Dagbehandeling3_T4 / Dagbehandeling4_T4 / 
Dagbehandeling1_aant_keer_T4 / Dagbehandeling2_aant_keer_T4 / Dagbehandeling3_aant_keer_T4 / Dagbehandeling4_aant_keer_T4  .

* missings.
RECODE dagbehandeling_T4 (SYSMIS=9).
EXECUTE.
MISSING VALUES  dagbehandeling_T4 (9).
VARIABLE LEVEL   dagbehandeling_T4 (NOMINAL).
VARIABLE WIDTH   dagbehandeling_T4 (7).

VARIABLE WIDTH Dagbehandeling1_aant_keer_T4 Dagbehandeling2_aant_keer_T4 Dagbehandeling3_aant_keer_T4 Dagbehandeling4_aant_keer_T4 (13).
VARIABLE LEVEL Dagbehandeling1_aant_keer_T4 Dagbehandeling2_aant_keer_T4 Dagbehandeling3_aant_keer_T4 Dagbehandeling4_aant_keer_T4 (SCALE).

***Q92: opnames************************************************************************************************************************************************************************.
RENAME VARIABLES Q92_3_1=opname_ZH_T4 / Q92_2_1_1_TEXT = opname_ZH_aant_dagen_T4 / Q92_1_1_1_TEXT = opname_ZH_aant_keer_T4. 
RENAME VARIABLES Q92_3_2=opname_rev_T4 / Q92_2_2_1_TEXT = opname_rev_aant_dagen_T4 / Q92_1_2_1_TEXT = opname_rev_aant_keer_T4. 
RENAME VARIABLES Q92_3_3=opname_psy_T4 / Q92_2_3_1_TEXT = opname_psy_aant_dagen_T4 / Q92_1_3_1_TEXT = opname_psy_aant_keer_T4.

VARIABLE LABELS opname_ZH_T4 'opname ziekenhuis: ja/nee T4'  opname_ZH_aant_dagen_T4 'opname ziekenhuis aantal dagen T4' 
opname_ZH_aant_keer_T4 'opname ziekenhuis aantal keer T4'
 opname_rev_T4 'opname revalidatie: ja/nee T4'  opname_rev_aant_dagen_T4 'opname revalidatie aantal dagen T4' 
opname_rev_aant_keer_T4 'opname revalidatie aantal keer T4' 
 opname_psy_T4 'opname psychiatrie: ja/nee T4'  opname_psy_aant_dagen_T4 'opname psychiatrie aantal dagen T4' 
opname_psy_aant_keer_T4 'opname psychiatrie aantal keer T4' .

VARIABLE LEVEL opname_ZH_T4 opname_rev_T4 opname_psy_T4 (NOMINAL).

** aantal dagen en aantal keer van string naar numeriek.
* controle tekst.
FREQUENCIES VARIABLES=opname_ZH_aant_dagen_T4 opname_rev_aant_dagen_T4 opname_psy_aant_dagen_T4 
    opname_ZH_aant_keer_T4 opname_rev_aant_keer_T4 opname_psy_aant_keer_T4
  /ORDER=ANALYSIS.

ALTER TYPE opname_ZH_aant_dagen_T4 opname_rev_aant_dagen_T4 opname_psy_aant_dagen_T4 
    opname_ZH_aant_keer_T4 opname_rev_aant_keer_T4 opname_psy_aant_keer_T4 (F3.0).
VARIABLE WIDTH opname_ZH_aant_dagen_T4 opname_rev_aant_dagen_T4 opname_psy_aant_dagen_T4 
    opname_ZH_aant_keer_T4 opname_rev_aant_keer_T4 opname_psy_aant_keer_T4 (11).

* opname ZH aantal dagen is 0 --> wordt 1 (conservatieve schatting).
IF (ID_code=3003) opname_ZH_aant_dagen_T4=1.
EXECUTE.

** als opname ziekenhuis=ja en andere twee missing--> missing wordt nee.
DO IF (opname_ZH_T4=1).
RECODE  opname_psy_T4 opname_rev_T4 (SYSMIS=2).
END IF.
EXECUTE.

** Als de vragenlijst ‘gefinished’ is de korte lijst is niet ingevuld (daarop staan geen vragen over opnames) , dan is een niet-ingevulde opname (missing) = geen opname (0).
DO IF ( Finished=1 and papier_T4<>2).
RECODE  opname_ZH_T4  opname_rev_T4 opname_psy_T4 (SYSMIS=2).
END IF.
EXECUTE.

** als opname=nee, dan wordt aantal keer en aantal dagen 0=missing.
DO IF (opname_ZH_T4=2).
RECODE  opname_ZH_aant_dagen_T4  opname_ZH_aant_keer_T4 (0=SYSMIS).
END IF.
DO IF (opname_rev_T4=2).
RECODE  opname_rev_aant_dagen_T4  opname_rev_aant_keer_T4 (0=SYSMIS).
END IF.
DO IF (opname_psy_T4=2).
RECODE  opname_psy_aant_dagen_T4  opname_psy_aant_keer_T4 (0=SYSMIS).
END IF.
EXECUTE.


*** Datum omzetten van string naar date.
RECODE Q92_4_1_1_TEXT ('31/05/2017'= '31052017') ('30-05-2017'='30052017') ('28-05-2017'='28052017')  ('22/11/2017'='22112017') ('21/09/2017'='21092017') ('17-11-1983'='17111983')
 ('15/03/2017'='15032017')  ('13-09-2017'='13092017') ('10-10-2017'='10102017')  ('07-12-2017'='07122017') ('29-01-2018'='29012018') ('19-12-2017'='19122017') ('03/11/2017'='03112017')
('22-01-2018'='22012018') ('28-08-2017'='28082017') ('05-02-2018'='05022018') ('24/04/2018'='24042018') ('21-09-2017'='21092017') ('07-05-2018'='07052018') .
EXECUTE.
RECODE Q92_4_2_1_TEXT ('05/05/2017'= '05052017').
EXECUTE.
RECODE Q92_4_3_1_TEXT ('10/01/2018'= '10012018').
EXECUTE.

** ID 5308 vult overal nee in maar  wel overal datum 1-8-18 --> verwijderen.
DO IF (ID_code=5308).
RECODE  Q92_4_1_1_TEXT Q92_4_2_1_TEXT Q92_4_3_1_TEXT ('01/01/2018'='').
END IF.
EXECUTE.

* Date and Time Wizard: opname_datum.
COMPUTE opname_ZH_datum_T4=date.dmy(number(substr(ltrim(Q92_4_1_1_TEXT),1,2),f2.0), 
    number(substr(ltrim(Q92_4_1_1_TEXT),3,2),f2.0), number(substr(ltrim(Q92_4_1_1_TEXT),5),f4.0)).
VARIABLE LEVEL   opname_ZH_datum_T4 (SCALE).
FORMATS  opname_ZH_datum_T4 (EDATE10).
VARIABLE WIDTH   opname_ZH_datum_T4(10).
EXECUTE.
* hij geeft foutmeldingen maar doet het wel goed.

* Date and Time Wizard: opname_datum.
COMPUTE opname_rev_datum_T4=date.dmy(number(substr(ltrim(Q92_4_2_1_TEXT),1,2),f2.0), 
    number(substr(ltrim(Q92_4_2_1_TEXT),3,2),f2.0), number(substr(ltrim(Q92_4_2_1_TEXT),5),f4.0)).
VARIABLE LEVEL  opname_rev_datum_T4 (SCALE).
FORMATS opname_rev_datum_T4 (EDATE10).
VARIABLE WIDTH  opname_rev_datum_T4(10).
EXECUTE.
* hij geeft foutmeldingen maar doet het wel goed.

* Date and Time Wizard: opname_datum.
COMPUTE opname_psy_datum_T4=date.dmy(number(substr(ltrim(Q92_4_3_1_TEXT),1,2),f2.0), 
    number(substr(ltrim(Q92_4_3_1_TEXT),3,2),f2.0), number(substr(ltrim(Q92_4_3_1_TEXT),5),f4.0)).
VARIABLE LEVEL  opname_psy_datum_T4 (SCALE).
FORMATS opname_psy_datum_T4 (EDATE10).
VARIABLE WIDTH  opname_psy_datum_T4(10).
EXECUTE.
* hij geeft foutmeldingen maar doet het wel goed.

VARIABLE LABELS  opname_ZH_datum_T4 'opname ziekenhuis datum T4' opname_rev_datum_T4 'opname revalidatie datum T4' opname_psy_datum_T4 'opname psychiatrie datum T4'.


*** opnamedatum moet maximaal 6 maanden (26 weken) voor invuldatum liggen.
* ZH: Date and Time Wizard: d_opnamedatum_invuldatum.
COMPUTE  d_opnamedatum_invuldatum=DATEDIF(opname_ZH_datum_T4, invuldatum_T4, "weeks").
VARIABLE LABELS  d_opnamedatum_invuldatum "verschil opnamedatum en invuldatum in weken".
VARIABLE LEVEL  d_opnamedatum_invuldatum (SCALE).
FORMATS  d_opnamedatum_invuldatum (F5.0).
VARIABLE WIDTH  d_opnamedatum_invuldatum(5).
EXECUTE.
** Er is 1 opname psychiatrie:verschil klopt.

* ID 1117	heeft geboortedatum ingevuld. Op T3 geen opname er van uit gaan dat deze opname klopt.

* ID 3417	opname 32 weken verschil, en wordt ook al op T3 genoemd  hier weg.
DO IF ID_code=3417.
RECODE opname_ZH_T4 (1=2).
RECODE opname_ZH_aant_dagen_T4 (1=SYSMIS).
RECODE opname_ZH_aant_keer_T4 (1=SYSMIS).
COMPUTE  opname_ZH_datum_T4 = $SYSMIS.
COMPUTE d_opnamedatum_invuldatum=$SYSMIS.
END IF.
EXECUTE.

* ID 3202	opname 27 weken verschil, en wordt ook al op T3 genoemd  hier weg.
DO IF ID_code=3202.
RECODE opname_ZH_T4 (1=2).
RECODE opname_ZH_aant_dagen_T4 (2=SYSMIS).
RECODE opname_ZH_aant_keer_T4 (1=SYSMIS).
COMPUTE  opname_ZH_datum_T4 = $SYSMIS.
COMPUTE d_opnamedatum_invuldatum=$SYSMIS.
END IF.
EXECUTE.

* ID 4607	opname revalidatie, ook al genoemd op T3  hier weg.
DO IF ID_code=4607.
RECODE opname_rev_T4 (1=2).
RECODE opname_rev_aant_dagen_T4 (56=SYSMIS).
RECODE opname_rev_aant_keer_T4 (1=SYSMIS).
COMPUTE  opname_rev_datum_T4 = $SYSMIS.
END IF.
EXECUTE.

* 5114 opname 34 weken verschil datum 28-8-17, 2 dagen 
Op T3 (ingevuld op 2-10-17, dus na de vermeldde opname op T4) ook 2 dagen, op 27-7. Waarschijnlijk zelfde  hier weg.
DO IF ID_code=5114.
RECODE opname_ZH_T4 (1=2).
RECODE opname_ZH_aant_dagen_T4 (2=SYSMIS).
RECODE opname_ZH_aant_keer_T4 (1=SYSMIS).
COMPUTE  opname_ZH_datum_T4 = $SYSMIS.
COMPUTE d_opnamedatum_invuldatum=$SYSMIS.
END IF.
EXECUTE.


* 6412 opname 32 weken verschil, ook al genoemd op T3  hier weg.
DO IF ID_code=6412.
RECODE opname_ZH_T4 (1=2).
RECODE opname_ZH_aant_dagen_T4 (10=SYSMIS).
RECODE opname_ZH_aant_keer_T4 (1=SYSMIS).
COMPUTE  opname_ZH_datum_T4 = $SYSMIS.
COMPUTE d_opnamedatum_invuldatum=$SYSMIS.
END IF.
EXECUTE.

** Missings.
RECODE opname_ZH_T4  opname_rev_T4 opname_psy_T4  (SYSMIS=9).
EXECUTE.
MISSING VALUES opname_ZH_T4  opname_rev_T4 opname_psy_T4 (9).


*Q93 en verder: inkomen ****************************************************************************************************************************************************************.
RENAME VARIABLES Q93=netto_inkomen_T4  / Q94= omvang_huishouden_T4 / Q94_TEXT=huishouden_aant_pers_T4/ Q95 = huishouden_aant_kinderen_T4 
/ Q96 = inkomen_rondkomen_T4.
VALUE LABELS omvang_huishouden_T4 1 'een persoon' 2 'meer dan een persoon'.

VARIABLE LABELS huishouden_aant_pers_T4 'aantal personen in huishouden T4'.
VARIABLE LABELS  huishouden_aant_kinderen_T4 'aantal minderjarigen in huishouden T4'.
VARIABLE LABELS  netto_inkomen_T4 'netto gezinsinkomen T4'.
VARIABLE LABELS omvang_huishouden_T4 'een-of meerpersoons huishouden T4'.
VARIABLE LABELS inkomen_rondkomen_T4 'Hoe goed kunt u rondkomen met uw inkomen? T4'.

**huishouden_aant_pers_T4 van string naar numeriek.
* controle op tekst.
FREQUENCIES VARIABLES=huishouden_aant_pers_T4 
  /ORDER=ANALYSIS.
RECODE huishouden_aant_pers_T4 ('6 personen'='6') ('1,5'='1.5').
EXECUTE.
** ID 1903	aant pers: nvt T3 + T2 + T1  missing; T0 4 pers, 2 kind  aant pers 4.
DO IF ID_code=1903.
RECODE huishouden_aant_pers_T4 ('nvt'='4').
END IF.
** ID 3916	aant pers: nvt T3 + T2 3 personen, 0 kind; T1 3 personen, 1 kind, T0 missing  aant pers 3.
DO IF ID_code=3916.
RECODE huishouden_aant_pers_T4 ('nvt.'='3').
END IF.
** ID 4504	aant pers 2-10, 4 kinderen opm kinderen eten 1-2 keer per week mee 
T3 3 pers, 0 kind T2 en T1  2 pers, missing kind, T0 4 pers, 0 kind  4 pers, 0 kind.
DO IF ID_code=4504.
RECODE huishouden_aant_pers_T4 ('2 tot 10 (kinderen eten 1als 2 x per week  mee'='4').
RECODE huishouden_aant_kinderen_T4 (4=0).
END IF.
EXECUTE.


ALTER TYPE huishouden_aant_pers_T4 huishouden_aant_kinderen_T4 (F3.0).

** ID 4011: 29 kinderen=typefout, wordt 2 (net als op T3).
DO IF ID_code=4011.
RECODE huishouden_aant_kinderen_T4 (29=2).
END IF.
EXECUTE.

**Als omvang_huishouden=1 , dan is aantal personen dus 1 en aantal kinderen 0 (nu missing).
DO IF (omvang_huishouden_T4=1).
RECODE huishouden_aant_pers_T4 (SYSMIS=1).
RECODE huishouden_aant_kinderen_T4 (SYSMIS=0).
END IF.
EXECUTE.

** Als omvang huishouden= meer dan 1 en aantal=1 --> omvang huishouden veranderen in eenpersoons.
DO IF (huishouden_aant_pers_T4=1).
RECODE omvang_huishouden_T4 (2=1).
END IF.
EXECUTE.

** Als omvang huishouden= meer dan 1 en aantal=0 --> omvang huishouden veranderen in eenpersoons en aantal=1.
DO IF (huishouden_aant_pers_T4=0).
RECODE omvang_huishouden_T4 (2=1).
RECODE huishouden_aant_pers_T4 (0=1).
END IF.
EXECUTE.

VARIABLE WIDTH netto_inkomen_T4 omvang_huishouden_T4 (7).

* berekenen individueel inkomen.
RECODE netto_inkomen_T4 (1=375) (2=875) (3=1125) (4=1375) (5=1750) (6=2250) (7=2750) (8=3250) (9=3750) (10=4250) (11=4750) (12=5250) (13=5750)
INTO netto_inkomen_continu_T4.
COMPUTE ind_inkomen_T4=netto_inkomen_continu_T4/SQRT(huishouden_aant_pers_T4).
VARIABLE LABELS  ind_inkomen_T4 'individueel inkomen T4'.
EXECUTE.

VARIABLE LEVEL netto_inkomen_T4 omvang_huishouden_T4 inkomen_rondkomen_T4 (NOMINAL).
VARIABLE WIDTH netto_inkomen_T4 ind_inkomen_T4 inkomen_rondkomen_T4 (9).

** Missings.
RECODE netto_inkomen_T4 omvang_huishouden_T4 huishouden_aant_pers_T4 huishouden_aant_kinderen_T4 inkomen_rondkomen_T4 (SYSMIS=99).
RECODE netto_inkomen_continu_T4 ind_inkomen_T4 (SYSMIS=9999).
EXECUTE.

MISSING VALUES netto_inkomen_T4 (14,99) omvang_huishouden_T4 huishouden_aant_pers_T4 huishouden_aant_kinderen_T4 (99) inkomen_rondkomen_T4 (7,99)
netto_inkomen_continu_T4 ind_inkomen_T4 (9999).

VARIABLE LEVEL netto_inkomen_T4 inkomen_rondkomen_T4 (ORDINAL) omvang_huishouden_T4 (NOMINAL).

VARIABLE LEVEL netto_inkomen_T4 omvang_huishouden_T4 inkomen_rondkomen_T4 (NOMINAL).
VARIABLE WIDTH netto_inkomen_continu_T4 (12) ind_inkomen_T4 netto_inkomen_T4 inkomen_rondkomen_T4 (10).

*** Variabelen verwijderen die omgezet zijn naar numeriek.
DELETE VARIABLES Q20   Q56_1_TEXT Q56_2_TEXT  Q59 Q95_4_1_1_TEXT Q95_4_2_1_TEXT.

'nog doen
*Q98 en verder: cadeaubonnen ****************************************************************************************************************************************************************.

RENAME VARIABLES Q98_4=cadeaubon1 / Q98_5=cadeaubon2 / Q98_6=cadeaubon3 / Q98_7=cadeaubon4 /  Q98_8=cadeaubon5 / Q98_9=cadeaubon6 / Q98_10=cadeaubon7 /
/ Q99_1=cadeaubon8 / Q99_2=cadeaubon9 / Q100=cadeaubon10.

VARIABLE LABELS 
cadeaubon1 'Ik vond de cadeaubonnen leuk'/
cadeaubon2 'De cadeaubonnen hebben mij geholpen om niet te roken'/
cadeaubon3 'Als het moeilijk werd om niet te roken, heb ik aan de beloning in het vooruitzicht gedacht'/
cadeaubon4 'De cadeaubonnen hebben geen invloed gehad op of ik rookte of niet'/
cadeaubon5 'De waarde van de cadeaubonnen was te laag om een beloning voor mij te zijn'/
cadeaubon6 'Ik ben door de cadeaubonnen gezonder gaan eten'/
cadeaubon7 'Ik ben door de cadeaubonnen meer gaan bewegen'/
cadeaubon8 'Heeft u wel eens positieve reacties gehad van uw collega?'/
cadeaubon9 'Heeft u wel eens negatieve reacties gehad van uw collega?'/
cadeaubon10 'Opmerkingen cadeaubonnen'.
 






