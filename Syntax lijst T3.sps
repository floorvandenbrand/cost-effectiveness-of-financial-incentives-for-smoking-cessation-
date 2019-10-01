* Encoding: UTF-8.
* Om te zorgen dat decimalen met een punt worden geschreven (van belang bij omzetten string naar numeriek).
SET LOCALE = 'en_US'.

***RecordedDate************************************************************************************************************************************************************.
FORMATS V8 (DATE11).
RENAME VARIABLES V8 = Invuldatum_T3.
VARIABLE LABELS Invuldatum_T3.

*ID_code (voornaam) is hierin samengevoegd met achternaam************************************************************************************************************.

STRING  temp (A40). 
COMPUTE temp=CHAR.LPAD(V3,40). 
EXECUTE.

STRING  ID_code (A4). 
COMPUTE ID_code=CHAR.SUBSTR(temp,37). 
EXECUTE.

ALTER TYPE ID_code (F4.0).

*ID 1115: veel rare antwoorden, blijkt maar wat te hebben ingevuld net als bij T3.  lijst verwijderen.
USE ALL.
SELECT IF (ID_Code ne 1115).
EXECUTE.

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
SELECT IF (V1~= 'R_3kCksUa80yvPNcw' and V1 ~= 'R_1JRQgyeTZ87omLG').
EXECUTE.

 *** Toevoegen variabele die aangeeft of vragenlijst op papier is ingevuld.
IF  (ID_code=1101 or ID_code=1115 or ID_code=2012 or ID_code=2013 or ID_code=2103 or ID_code= 2105 or ID_code=2108 or ID_code=3201
or ID_code=4913 or ID_code=4916 or ID_code=4917 or ID_code=4919 or ID_code=4920)  papier_T3=2.
IF (ID_code= 1508 or ID_code=3606  or ID_code=4903 or ID_code=4908  or ID_code=4909 or ID_code=6810) papier_T3=1.
EXECUTE.
RECODE papier_T3 (SYSMIS=0).
EXECUTE.
FORMATS papier_T3 (F1.0).
VALUE LABELS papier_T3 0  'digitaal ingevuld' 1 'volledige lijst op papier' 2 'verkorte lijst op papier'.
VARIABLE LABELS papier_T3 'lijst is op papier ingevuld T3' .

** bij invullen op papier wordt automatisch als invuldatum de datum van invoeren op HAG gegenereerd. Dit corrigeren met datum op vragenlijst.

IF (ID_Code=1101) Invuldatum_T3=Date.dmy(30,11,2016).
* ID 1115 geen datum ingevuld: zelfde als 1101 aanhouden.
IF (ID_Code=1115) Invuldatum_T3=Date.dmy(30,11,2016).
IF (ID_Code=1508) Invuldatum_T3=Date.dmy(11,05,2017).
IF (ID_Code=2012) Invuldatum_T3=Date.dmy(20,06,2017).
* ID 2013 geen datum ingevuld: zelfde als 2012 aanhouden.
IF (ID_Code=2013) Invuldatum_T3=Date.dmy(20,06,2017).
IF (ID_Code=2103) Invuldatum_T3=Date.dmy(23,05,2017).
IF (ID_Code=2105) Invuldatum_T3=Date.dmy(23,05,2017).
IF (ID_Code=2108) Invuldatum_T3=Date.dmy(23,05,2017).
IF (ID_Code=3201) Invuldatum_T3=Date.dmy(11,08,2017).
IF (ID_Code=3606) Invuldatum_T3=Date.dmy(21,08,2017).
IF (ID_Code=4903) Invuldatum_T3=Date.dmy(16,10,2017).
IF (ID_Code=4908) Invuldatum_T3=Date.dmy(18,10,2017).
IF (ID_Code=4909) Invuldatum_T3=Date.dmy(18,10,2017).
IF (ID_Code=4913) Invuldatum_T3=Date.dmy(01,11,2017).
IF (ID_Code=4916) Invuldatum_T3=Date.dmy(24,10,2017).
IF (ID_Code=4917) Invuldatum_T3=Date.dmy(18,10,2017).
* ID 4919 geen datum ingevuld: gen van bedrijf 49 aanhouden.
IF (ID_Code=4919) Invuldatum_T3=Date.dmy(18,10,2017).
IF (ID_Code=4920) Invuldatum_T3=Date.dmy(30,11,2017).
IF (ID_Code=6810) Invuldatum_T3=Date.dmy(15,12,2017).
EXECUTE.

** een code is niet volledig ingevuld: 610 moet zijn 6103.
RECODE ID_code (610=6103).
EXECUTE.

** 2 codes zijn verwisseld (echtpaar met zelfde email adres).
RECODE ID_code (2903=2904).
EXECUTE.

*5 lege records: deze verwijderen.
USE ALL.
SELECT IF (ID_Code ne 1907 and  ID_Code ne 2505 and ID_Code ne 3103 and ID_Code ne 4706  and ID_Code ne 6413 ).
EXECUTE.

RENAME VARIABLES V10=Finished.
VARIABLE LEVEL Finished (NOMINAL).

** Enkele variabelen zijn alleen toelichting (voor iedereen 1).
DELETE VARIABLES Q1 Q2 Q21 Q27 Q29  Q33 Q40 Q46 Q52 Q63 Q67 Q68 Q90 Q100.


*** Deelnemers in analyse selecteren.
*** Bestand mergen met 'deelnemers analyse.sav. Optie 0ne-to-many, Selected look up table = in analyse.sav.
FILTER OFF.
USE ALL.
SELECT IF (in_analyse=1).
EXECUTE.


****************************************************************************************************************************************************************************
*** roken*******************************************************************************************************************************************************************.
RENAME VARIABLES  Q3=gerookt_T3 / Q3_TEXT=gerookt_aant_sig_T3.
VARIABLE LABELS gerookt_T3 'gerookt afgelopen 3 mnd' gerookt_aant_sig_T3 'aant sig gerookt afgelopen 3 mnd'.
VARIABLE LEVEL gerookt_T3 (NOMINAL).
VALUE LABELS gerookt_T3 1 'Nee' 2 'Ja' .

** aant sigaretten van string naar numeriek.
** controle tekst.
FREQUENCIES VARIABLES=gerookt_aant_sig_T3
  /ORDER=ANALYSIS.

** omzetten naar numeriek, eerst div aanpassingen.
RECODE gerookt_aant_sig_T3 ('Helaas weer begonnen met roken'='99999').
RECODE gerookt_aant_sig_T3 ('veel'='99999').
RECODE gerookt_aant_sig_T3 ('te veel'='99999').
RECODE gerookt_aant_sig_T3 ('Veel'='99999').
RECODE gerookt_aant_sig_T3 ('geen idee'='99999').
RECODE gerookt_aant_sig_T3 ('Geen idee hoeveel'='99999').
RECODE gerookt_aant_sig_T3 ('?'='99999').
RECODE gerookt_aant_sig_T3 ('Ja'='99999').
RECODE gerookt_aant_sig_T3 ('af en toe 1'='99999').
RECODE gerookt_aant_sig_T3 ('onbekend'='99999').
RECODE gerookt_aant_sig_T3 ('Teveel'='99999').
RECODE gerookt_aant_sig_T3 ('teveel'='99999').
RECODE gerookt_aant_sig_T3 ('heel veel'='99999').
RECODE gerookt_aant_sig_T3 ('Meerdere pakjes'='99999').
RECODE gerookt_aant_sig_T3 ('niet geteld'='99999').
RECODE gerookt_aant_sig_T3 ('Gedampt'='99999').
RECODE gerookt_aant_sig_T3 ('weet niet'='99999').
RECODE gerookt_aant_sig_T3 ('sinds 1 augustus'='99999').
RECODE gerookt_aant_sig_T3 ('∞'='99999').
RECODE gerookt_aant_sig_T3 ('halve'='1').
RECODE gerookt_aant_sig_T3 ('2 trekjes meende dat het rust zou geven'='1').
RECODE gerookt_aant_sig_T3 ('3 sigaren'='3').
RECODE gerookt_aant_sig_T3 ('Stuk of 6'='6').
RECODE gerookt_aant_sig_T3 ('100?'='100').
RECODE gerookt_aant_sig_T3 ('laatste drie weken oude niveau'='500').
RECODE gerookt_aant_sig_T3 ('afgelopen maand 6-8 per dag'='210').
RECODE gerookt_aant_sig_T3 ('ja weer begonnen 3 pakjes per week'='720').
RECODE gerookt_aant_sig_T3 ('28 per week'='364').
RECODE gerookt_aant_sig_T3 ('1 per dag'='90').
RECODE gerookt_aant_sig_T3 ('3 per dag'='270').
RECODE gerookt_aant_sig_T3 ('4 per dag'='360').
RECODE gerookt_aant_sig_T3 ('5 per dag'='450').
RECODE gerookt_aant_sig_T3 ('5a10per dag'='450').
RECODE gerookt_aant_sig_T3 ('Ongeveer 6 per dag'='540').
RECODE gerookt_aant_sig_T3 ('6 per dag'='540').
RECODE gerookt_aant_sig_T3 ('8 per dag'='720').
RECODE gerookt_aant_sig_T3 ('Pakje op 3 dagen'='600').
RECODE gerookt_aant_sig_T3 ('10 per dag'='900').
RECODE gerookt_aant_sig_T3 ('10 pd'='900').
RECODE gerookt_aant_sig_T3 ('10 / dag'='900').
RECODE gerookt_aant_sig_T3 ('10/dag'='900').
RECODE gerookt_aant_sig_T3 ('dagelijks 10'='900').
RECODE gerookt_aant_sig_T3 ('10per dag'='900').
RECODE gerookt_aant_sig_T3 ('nu op 10 sig per dag'='900').
RECODE gerookt_aant_sig_T3 ('iedere dag 10st'='900').
RECODE gerookt_aant_sig_T3 ('10 tot 15'='900').
RECODE gerookt_aant_sig_T3 ('10 of 15 per dag'='900').
RECODE gerookt_aant_sig_T3 ('15 per dag'='1350').
RECODE gerookt_aant_sig_T3 ('Gem 15 per dag'='1350').
RECODE gerookt_aant_sig_T3 ('15 pd'='1350').
RECODE gerookt_aant_sig_T3 ('20 per dag'='1800').
RECODE gerookt_aant_sig_T3 ('20 per dag.'='1800').
RECODE gerookt_aant_sig_T3 ('Pak per dag'='1800').
RECODE gerookt_aant_sig_T3 ('pakje per dag'='1800').
RECODE gerookt_aant_sig_T3 ('25 per dag'='2250').
RECODE gerookt_aant_sig_T3 ('wat ik voorheen ook deed 25 per dag'='2250').
EXECUTE.

*indien gerookt is ja en aantal sig is niet ingevuld.
DO IF gerookt_T3=2.
RECODE gerookt_aant_sig_T3 (''='99999').
END IF.
EXECUTE.

ALTER TYPE gerookt_aant_sig_T3 (F5.0).

MISSING VALUES gerookt_aant_sig_T3 (99999).
VARIABLE LEVEL gerookt_aant_sig_T3 (SCALE).

RENAME VARIABLES Q4=stoppoging_T3/ Q5=gerookt_7d_T3/ Q6=stoppen_T3.
VARIABLE LABELS stoppoging_T3 'afgelopen 3 mnd stoppoging gedaan'.
VARIABLE LABELS gerookt_7d_T3 'afgelopen 7 dagen gerookt'.
VARIABLE LABELS stoppen_T3 'voornemen te stoppen'.

** stoppoging onlogische codering: hercoderen.
RECODE stoppoging_T3 (4=1) (5=2).
EXECUTE.
* Missings en nvt toevoegen.
DO IF gerookt_T3=2.
RECODE stoppoging_T3 (SYSMIS=9).
END IF.
DO IF gerookt_T3=1.
RECODE stoppoging_T3 (SYSMIS=8).
END IF.
EXECUTE.
VALUE LABELS gerookt_T3 1 'Nee' 2 'Ja' 8 'nvt'.
VALUE LABELS stoppoging_T3 gerookt_T3 1 'Ja' 2 'Nee' 8 'nvt'.
MISSING VALUES stoppoging_T3 (9).

** stoppen_T3 onlogische codering: hercoderen.
RECODE stoppen_T3 (4=1) (5=2) (6=3) (7=4) (8=5).
EXECUTE.

* Missings en nvt toevoegen.
DO IF gerookt_7d_T3=2.
RECODE stoppen_T3 (SYSMIS=9).
END IF.
DO IF gerookt_7d_T3=1.
RECODE stoppen_T3 (SYSMIS=8).
END IF.
EXECUTE.
VALUE LABELS stoppen_T3 1 'binnen nu en een maand' 2 'binnen 6 maanden'  3 'in de toekomst maar niet binnen 6 maanden' 4 'nee,nooit' 5 'weet niet'  8 'nvt'.
VARIABLE LEVEL stoppoging_T3 gerookt_7d_T3 stoppen_T3 (NOMINAL).


RENAME VARIABLES Q7=roken7_T3 / Q8=stoppen1a_T3 / Q9=stoppen2a_T3 / Q10=stoppen3a_T3 / Q11=stoppen1b_T3 / Q12=stoppen2b_T3 / Q13=stoppen3b_T3.
VARIABLE LEVEL roken7_T3 (NOMINAL).

** stoppen1a en b en 3 a en b zijn onlogisch gecodeerd (anders dan bij T0).
RECODE stoppen1b_T3 stoppen2b_T3 stoppen3b_T3 (4=1) (5=2) (6=3) (7=4) (8=5).
EXECUTE.

** Indien afgelopen dagen gerookt (gerookt_7d_T3)=nee de vragen ‘blijvend’ aanhouden, indien afgelopen dagen gerookt=ja de vragen ‘binnen 3 maanden’ aanhouden, 
deze combineren tot 1 variabele.

DO IF gerookt_7d_T3=2.
COMPUTE stoppen1_T3=stoppen1a_T3.
COMPUTE stoppen2_T3=stoppen2a_T3.
COMPUTE stoppen3_T3=stoppen3a_T3.
END IF.
DO IF gerookt_7d_T3=1.
COMPUTE stoppen1_T3=stoppen1b_T3.
COMPUTE stoppen2_T3=stoppen2b_T3.
COMPUTE stoppen3_T3=stoppen3b_T3.
END IF.
EXECUTE.

VALUE LABELS stoppen1_T3  1 'zeer verstandig' 2 'verstandig' 3 'niet verstandig, maar ook niet onverstandig' 4 'onverstandig' 5 'zeer onverstandig'.
VALUE LABELS stoppen2_T3  1 'zeer plezierig' 2 'plezierig' 3 'niet plezierig, maar ook niet onplezierig' 4 'onplezierig' 5 'zeer onplezierig'.
VALUE LABELS stoppen3_T3  1 'zeer positief' 2 'positief' 3 'niet positief, maar ook niet negatief' 4 'negatief' 5 'zeer negatief'.
VARIABLE LABELS stoppen1_T3 'Als u blijvend niet rookt/binnen 3 mnd stopt, is dat verstandig/onverstandig'.
VARIABLE LABELS stoppen2_T3 'Als u blijvend niet rookt/binnen 3 mnd stopt, is dat plezierig/onplezierig'.
VARIABLE LABELS stoppen3_T3 'Als u blijvend niet rookt/binnen 3 mnd stopt, is dat positief/negatief'.
FORMATS stoppen1_T3 stoppen2_T3 stoppen3_T3 (F1.0).
VARIABLE WIDTH stoppen1_T3 stoppen2_T3 stoppen3_T3 (6).

DELETE VARIABLES stoppen1a_T3 stoppen1b_T3 stoppen2a_T3 stoppen2b_T3 stoppen3a_T3 stoppen3b_T3.

RENAME VARIABLES Q14=stoppen4_T3 / Q15=stoppen5_T3.
VARIABLE WIDTH stoppen4_T3 stoppen5_T3 (6).

*Indien stoppen4 =1 (nooit), dan moet stoppen5 missing zijn.

USE ALL.
COMPUTE filter_$=(stoppen4_T3=1).
VARIABLE LABELS filter_$ 'stoppen4_T3=1 (FILTER)'.
VALUE LABELS filter_$ 0 'Not Selected' 1 'Selected'.
FORMATS filter_$ (f1.0).
FILTER BY filter_$.
EXECUTE.
FREQUENCIES VARIABLES=stoppen5_T3
  /ORDER=ANALYSIS.
USE ALL.

** deze missing wordt nvt (nieuwe code).
IF  (stoppen4_T3=1) stoppen5_T3=8.
EXECUTE.
VALUE LABELS stoppen5_T3 1 '(bijna) allemaal positief' 2 'meestal positief'  3 'even vaak positief als negatief' 4 'meestal negatief' 5 '(bijna) allemaal negatief' 8 'nvt'. 

RENAME VARIABLES Q16=stoppen6a_T3 / Q17=stoppen6b_T3.
VARIABLE LABELS stoppen6a_T3 'Hoe denkt u dat de meeste mensen die belangrijk voor u zijn het zouden vinden als u de komende 3 maanden niet rookt'
stoppen6b_T3 'Hoe denkt u dat de mensen die belangrijk voor u zijn het zouden vinden als u binnen de komende 3 maanden stopt met roken'.

RECODE stoppen6b_T3 (4=1) (5=2) (6=3) (7=4) (8=5).
VALUE LABELS stoppen6b_T3 1 'sterk afkeurend' 2  'afkeurend' 3 'neutraal' 4 'goedkeurend' 5 'sterk goedkeurend' .

RENAME VARIABLES Q18_1=stoppen7a1_T3 /  Q18_2=stoppen7b1_T3 /  Q18_3=stoppen7c1_T3 / Q18_4=stoppen7d1_T3 / Q18_5=stoppen7e1_T3 /
Q19_1=stoppen7a2_T3 /  Q19_2=stoppen7b2_T3 /  Q19_3=stoppen7c2_T3 / Q19_4=stoppen7d2_T3 / Q19_5=stoppen7e2_T3. 


*** Q19: gewicht van string naar numeriek************************************************************************************************************************************************.
* tekst verwijderen, decimaal met komma.
STRING temp1 (A20).
COMPUTE temp1=REPLACE(Q20, 'kg','').
EXECUTE.

STRING temp2 (A20).
COMPUTE temp2=REPLACE(temp1, 'kilo','').
EXECUTE.

STRING temp3 (A20).
COMPUTE temp3=REPLACE(temp2,',','.').
EXECUTE.

STRING temp4 (A20).
COMPUTE temp4=REPLACE(temp3,'??','').
EXECUTE.

STRING temp5 (A20).
COMPUTE temp5=REPLACE(temp4,'+','').
EXECUTE.

STRING temp6 (A20).
COMPUTE temp6=REPLACE(temp5,'vet door stoppen','').
EXECUTE.

STRING temp7 (A20).
COMPUTE temp7=REPLACE(temp6,'te zwaar. flink aang','').
EXECUTE.

STRING temp8 (A20).
COMPUTE temp8=REPLACE(temp7,'Te veel','').
EXECUTE.

*controle.
FREQUENCIES VARIABLES=temp8
  /ORDER=ANALYSIS.

RENAME VARIABLES temp8=gewicht_T3.
ALTER TYPE gewicht_T3 (F3.2).

DELETE VARIABLES temp1 temp2 temp3 temp4 temp5 temp6 temp7.

* Controle reeele getallen.
FREQUENCIES gewicht_T3.

RECODE gewicht_T3 (SYSMIS=9999).
EXECUTE.
MISSING VALUES gewicht_T3 (9999).
VARIABLE WIDTH gewicht_T3 (7).
VARIABLE LEVEL gewicht_T3 (SCALE).

** nieuwe variabele indien gewicht is toegemonen, maar exact gewicht is missing.
DO IF (Q20='vet door stoppen' or Q20= 'te zwaar, flink aangekomen, nu weight watchers' or Q20='Te veel').
COMPUTE gewicht_aangekomen_T3=1.
END IF.
EXECUTE.
FORMATS gewicht_aangekomen_T3 (F1.0).
VARIABLE WIDTH gewicht_aangekomen_T3 (7).
VARIABLE LEVEL gewicht_aangekomen_T3 (NOMINAL).
VALUE LABEL gewicht_aangekomen_T3 1 'aangekomen'.

*** Q22/Q26: EQ5D **************************************************************************************************************************************************************************.
RENAME VARIABLES Q22=EQ5D_1_T3 / Q23=EQ5D_2_T3 / Q24=EQ5D_3_T3 / Q25=EQ5D_4_T3 / Q26=EQ5D_5_T3.
VARIABLE LABELS EQ5D_1_T3 'EQ5D mobiliteit T3' EQ5D_2_T3 'EQ5D zelfzorg T3' 
EQ5D_3_T3 'EQ5D ADL T3' EQ5D_4_T3 'EQ5D pijn/ongemak T3' EQ5D_5_T3 'EQ5D angst/somberheid T3'.

RENAME VARIABLES Q28=EQ5D_VAS_T3.
VARIABLE LABELS EQ5D_VAS_T3 'EQ5D gezondheid T3'.
FORMATS EQ5D_VAS_T3 (F3.0).

* Dutch tariff for EQ-5D-
* Based on the following publication: Versteegh, M. M., Vermeulen, K. M., Evers, S. M., de Wit, G. A., Prenger, R., & Stolk, E. A. (2016). Dutch Tariff for the Five-Level Version of EQ-5D. Value in Health, 2016. doi:10.1016/j.jval.2016.01.003 

COMPUTE EQ5D_T3 = 1.

DO IF (nvalid(EQ5D_1_T3, EQ5D_2_T3, EQ5D_3_T3, EQ5D_4_T3, EQ5D_5_T3) < 5).
RECODE EQ5D_T3 (1 = SYSMIS).
END IF.

IF (max(EQ5D_1_T3, EQ5D_2_T3, EQ5D_3_T3, EQ5D_4_T3, EQ5D_5_T3)>1)EQ5D_T3 = EQ5D_T3 - .0469233.
IF (EQ5D_1_T3 = 2) EQ5D_T3 = EQ5D_T3 - .0354544.
IF (EQ5D_1_T3 = 3) EQ5D_T3 = EQ5D_T3 - .0565962.
IF (EQ5D_1_T3 = 4) EQ5D_T3 = EQ5D_T3 - .166003.
IF (EQ5D_1_T3 = 5) EQ5D_T3 = EQ5D_T3 - .2032975.

IF (EQ5D_2_T3 = 2) EQ5D_T3 = EQ5D_T3 - .0381079.
IF (EQ5D_2_T3 = 3) EQ5D_T3 = EQ5D_T3 - .0605347.
IF (EQ5D_2_T3 = 4) EQ5D_T3 = EQ5D_T3 - .1677852.
IF (EQ5D_2_T3 = 5) EQ5D_T3 = EQ5D_T3 - .1677852.

IF (EQ5D_3_T3 = 2) EQ5D_T3 = EQ5D_T3 - .0391539.
IF (EQ5D_3_T3 = 3) EQ5D_T3 = EQ5D_T3 - .0867559.
IF (EQ5D_3_T3 = 4) EQ5D_T3 = EQ5D_T3 - .1924631.
IF (EQ5D_3_T3 = 5) EQ5D_T3 = EQ5D_T3 - .1924631.

IF (EQ5D_4_T3 = 2) EQ5D_T3 = EQ5D_T3 - .0658959.
IF (EQ5D_4_T3 = 3) EQ5D_T3 = EQ5D_T3 - .0919619.
IF (EQ5D_4_T3 = 4) EQ5D_T3 = EQ5D_T3 - .35993.
IF (EQ5D_4_T3 = 5) EQ5D_T3 = EQ5D_T3 - .4152142.

IF (EQ5D_5_T3 = 2) EQ5D_T3 = EQ5D_T3 - .069622.
IF (EQ5D_5_T3 = 3) EQ5D_T3 = EQ5D_T3 - .1445222.
IF (EQ5D_5_T3 = 4) EQ5D_T3 = EQ5D_T3 - .3563913.
IF (EQ5D_5_T3 = 5) EQ5D_T3 = EQ5D_T3 - .4206361.
EXECUTE.

* missings.
RECODE EQ5D_1_T3 EQ5D_2_T3 EQ5D_3_T3 EQ5D_4_T3 EQ5D_5_T3 EQ5D_T3  (SYSMIS=99).
RECODE EQ5D_VAS_T3  (SYSMIS=999).
EXECUTE.
MISSING VALUES EQ5D_1_T3 EQ5D_2_T3 EQ5D_3_T3 EQ5D_4_T3 EQ5D_5_T3 EQ5D_T3 (99) EQ5D_VAS_T3 (999).
VARIABLE LABELS EQ5D_T3 'EQ5D tot score T3'.
VARIABLE LEVEL  EQ5D_1_T3 EQ5D_2_T3 EQ5D_3_T3 EQ5D_4_T3 EQ5D_5_T3 (ORDINAL).
VARIABLE WIDTH  EQ5D_1_T3 EQ5D_2_T3 EQ5D_3_T3 EQ5D_4_T3 EQ5D_5_T3 (5).

** Q30/31/32: CCQ***************************************************************************************************************************************************************.
RENAME VARIABLES Q30_1=CCQ1_T3 / Q30_2=CCQ2_T3 / Q30_3=CCQ3_T3 / Q30_4=CCQ4_T3 / Q31_1=CCQ5_T3 / Q31_2=CCQ6_T3 / 
Q32_1=CCQ7_T3 / Q32_2=CCQ8_T3 / Q32_3=CCQ9_T3 / Q32_4=CCQ10_T3.
VARIABLE LABELS CCQ1_T3 'CCQ kortademig rust T3' CCQ2_T3 'CCQ kortademig lich inspanning T3' CCQ3_T3 'CCQ angstig/bezorgd T3' CCQ4_T3 'CCQ neerslachtig T3' 
CCQ5_T3 'CCQ gehoest T3' CCQ6_T3 'CCQ slijm opgehoest T3' CCQ7_T3 'CCQ beperkt bij zware lich activiteit T3' CCQ8_T3 'CCQ beperkt bij matige lich activiteit T3' 
CCQ9_T3 'CCQ beperkt bij dagelijkse activiteiten T3' CCQ10_T3 'CCQ beperkt bij sociale activiteiten T3'. 

*** CCQ totaalscores.
'minimum aantal missings??.
COMPUTE CCQ_tot_T3=MEAN(CCQ1_T3,CCQ2_T3,CCQ3_T3,CCQ4_T3,CCQ5_T3,CCQ6_T3,CCQ7_T3,CCQ8_T3,CCQ9_T3, CCQ10_T3).
COMPUTE CCQ_klachten_T3=MEAN(CCQ1_T3,CCQ2_T3,CCQ5_T3,CCQ6_T3).
COMPUTE CCQ_emoties_T3=MEAN(CCQ3_T3,CCQ4_T3).
COMPUTE CCQ_conditie_T3=MEAN(CCQ7_T3,CCQ8_T3,CCQ9_T3, CCQ10_T3).
EXECUTE.

** missings.
RECODE CCQ1_T3 CCQ2_T3 CCQ3_T3 CCQ4_T3 CCQ5_T3 CCQ6_T3 CCQ7_T3 CCQ8_T3 CCQ9_T3 CCQ10_T3 (SYSMIS=99).
RECODE CCQ_tot_T3 CCQ_klachten_T3 CCQ_emoties_T3 CCQ_conditie_T3 (SYSMIS=99).
EXECUTE.
MISSING VALUES CCQ1_T3 CCQ2_T3 CCQ3_T3 CCQ4_T3 CCQ5_T3 CCQ6_T3 CCQ7_T3 CCQ8_T3 CCQ9_T3 CCQ10_T3
 CCQ_tot_T3 CCQ_klachten_T3 CCQ_emoties_T3 CCQ_conditie_T3 (99).
VARIABLE LEVEL CCQ1_T3 CCQ2_T3 CCQ3_T3 CCQ4_T3 CCQ5_T3 CCQ6_T3 CCQ7_T3 CCQ8_T3 CCQ9_T3 CCQ10_T3 (ORDINAL).
VARIABLE WIDTH CCQ1_T3 CCQ2_T3 CCQ3_T3 CCQ4_T3 CCQ5_T3 CCQ6_T3 CCQ7_T3 CCQ8_T3 CCQ9_T3 CCQ10_T3 (4).
VARIABLE WIDTH CCQ_tot_T3 CCQ_klachten_T3 CCQ_emoties_T3 CCQ_conditie_T3 (9).

*** Q34-Q38: aan roken gerelateerde ziektes************************************************************************************************************************************.
RENAME VARIABLES Q34=rokersziektes1a_T3 / Q35=rokersziekte1b_T3 / Q36=rokersziektes2a_T3 /Q37=rokersziekte2b_T3 / Q38=rokersziektes3_T3.
* In de papieren versie staat steeds 1 vraag over ‘blijf roken of weer ga roken’.
*In de elektronische versie is deze opgesplitst naar 2 vragen.
*Samenvoegen naar 1 variabele.
RENAME VARIABLES rokersziektes1a_T3=rokersziektes1_T3.
DO IF SYSMIS(rokersziektes1_T3)=1.
COMPUTE rokersziektes1_T3=rokersziekte1b_T3.
END IF.
RENAME VARIABLES rokersziektes2a_T3=rokersziektes2_T3.
DO IF SYSMIS(rokersziektes2_T3)=1.
COMPUTE rokersziektes2_T3=rokersziekte2b_T3.
END IF.
EXECUTE.
DELETE VARIABLES rokersziekte1b_T3 rokersziekte2b_T3.
VARIABLE LABELS rokersziektes1_T3 'Als ik blijf roken/weer ga roken dan is de kans dat ik hierdoor op een bepaald punt in mijn leven een ziekte krijg'/
rokersziektes2_T3 'Als ik blijf roken/weer ga roken ben ik bang om hierdoor op een bepaald punt in mijn leven een ziekte te krijgen'/
rokersziektes3_T3 'Ten opzichte van andere ziektes zijn de gevolgen van roken-gerelateerde ziektes:T3'.

** missings.
RECODE rokersziektes1_T3 rokersziektes2_T3 rokersziektes3_T3 (SYSMIS=99).
MISSING VALUES rokersziektes1_T3 rokersziektes2_T3 rokersziektes3_T3 (99).
EXECUTE.
VARIABLE WIDTH  rokersziektes1_T3 rokersziektes2_T3 rokersziektes3_T3 (5).
VARIABLE LEVEL  rokersziektes1_T3 rokersziektes2_T3 rokersziektes3_T3 (ORDINAL).

***Q39: stress********************************************************************************************************************************************************************.
RENAME VARIABLES Q39_1=stress1_T3 / Q39_2=stress2_T3 / Q39_3=stress3_T3 / Q39_4=stress4_T3 / Q39_5=stress5_T3.
VARIABLE LABELS stress1_T3 'Hoe vaak heeft u het gevoel gehad dat u geen controle had over de belangrijke dingen in uw leven? T3'
stress2_T3 'Hoe vaak heeft u zich er zeker van gevoeld dat u in staat was om persoonlijke problemen aan te kunnen? T3'
stress3_T3 'Hoe vaak heeft u het gevoel gehad dat alles liep zoals u wilde? T3'
stress4_T3 'Hoe vaak heeft u het gevoel gehad dat de problemen zich zo hoog opstapelden dat u ze niet kon overwinnen? T3'
stress5_T3 'Hoe vaak bent u aangeslagen geweest door gebeurtenissen in de wereld? T3'.

** missings.
RECODE stress1_T3 stress2_T3 stress3_T3 stress4_T3 stress5_T3  (SYSMIS=99).
MISSING VALUES stress1_T3 stress2_T3 stress3_T3 stress4_T3 stress5_T3 (99).
EXECUTE.
VARIABLE WIDTH  stress1_T3 stress2_T3 stress3_T3 stress4_T3 stress5_T3 (5).
VARIABLE LEVEL stress1_T3 stress2_T3 stress3_T3 stress4_T3 stress5_T3 (ORDINAL).

***Q41-Q45: sociale omgeving*************************************************************************************************************************************.
RENAME VARIABLES Q41=soc_omgeving1_T3 /  Q42=soc_omgeving2_T3 /  Q43=soc_omgeving3_T3 /  Q44=soc_omgeving4_T3 /  Q45=soc_omgeving5_T3 . 
** soc_omgeving3 is onlogisch gecodeerd (anders dan bij T1).
RECODE soc_omgeving3_T3 (2=1) (3=2) (4=3) (6=4).
VALUE LABELS soc_omgeving3_T3 1 'veel steun' 2 'niet veel/niet weinig steun' 3 'weinig steun' 4 'weet niet'.
** soc_omgeving5 is onlogisch gecodeerd (anders dan bij T1).
RECODE soc_omgeving5_T3 (4=1) (6=2) (7=3) (10=4).
VALUE LABELS soc_omgeving5_T3 1 'veel steun' 2 'niet veel/niet weinig steun' 3 'weinig steun' 4 'weet niet'.
EXECUTE.

VARIABLE LABELS soc_omgeving1_T3  'Rookt uw partner? T3' /
soc_omgeving2_T3 'Is uw partner in de afgelopen 2 maanden succesvol gestopt met roken? T3' /
soc_omgeving3_T3 'Hoeveel steun heeft u gekregen van uw partner bij het (proberen te) stoppen met roken T3'/
soc_omgeving4_T3 'Hoeveel van de vijf meest nabije vrienden, bekenden of collegas waar u regelmatig tijd mee doorbrengt zijn roker? T3'/
soc_omgeving5_T3 'Hoeveel steun heeft u gekregen van uw vrienden en familieleden bij het (proberen te) stoppen met roken T3'.

RECODE soc_omgeving1_T3 soc_omgeving2_T3 soc_omgeving3_T3 soc_omgeving4_T3 soc_omgeving5_T3 (SYSMIS=99).
EXECUTE.
MISSING VALUES soc_omgeving1_T3 soc_omgeving2_T3 soc_omgeving3_T3 soc_omgeving4_T3 soc_omgeving5_T3 (99).
VARIABLE WIDTH soc_omgeving1_T3 soc_omgeving2_T3 soc_omgeving3_T3 soc_omgeving4_T3 soc_omgeving5_T3 (5).
VARIABLE LEVEL soc_omgeving1_T3 soc_omgeving2_T3 soc_omgeving3_T3 soc_omgeving4_T3 soc_omgeving5_T3 (NOMINAL).

***Q47/Q51: roken op werk******************************************************************************************************************************************************.
RENAME VARIABLES Q47_1=roken_op_werk1_T3 /  Q47_2=roken_op_werk2_T3 / Q47_4=roken_op_werk3_T3 / Q47_5=roken_op_werk4_T3 /
Q48=roken_op_werk5_T3 / Q49=roken_op_werk6_T3 / Q50=soc_omgeving6a_T3 / Q51=soc_omgeving6b_T3.
VARIABLE LABELS roken_op_werk1_T3 'Is het toegestaan om te roken op het werk? T3' 
roken_op_werk2_T3 'Bent u vrij om rookpauzes te nemen wanneer u wilt? T3' 
roken_op_werk3_T3 'Zijn er op het werk speciale rookplekken binnen? T3'
roken_op_werk4_T3 'Zijn er op het werk speciale rookplekken buiten? T3'
roken_op_werk5_T3 'Roken wordt ontmoedigd op het werk T3'
roken_op_werk6_T3 'Op het werk wordt het normaal gevonden dat er collegas roken T3'
soc_omgeving6a_T3 'Hoeveel steun heeft u gekregen van uw collegas die niet meededen aan de stoppen-met-rokencursus T3'
soc_omgeving6b_T3 'Hoeveel steun heeft u gekregen van uw collegas die wel meededen aan de stoppen-met-rokencursus T3'.

* roken_op_werk5_T3 heeft onlogische codering: hercoderen.
RECODE roken_op_werk5_T3 (1=1) (2=2) (3=3) (4=4) (5=5) (7=6).
VALUE LABELS roken_op_werk5_T3 1 'Helemaal mee oneens' 2  'Mee oneens' 3 'Niet mee oneens, niet mee eens' 4  'Mee eens'  5  'Helemaal mee eens' 6 'Weet niet'. 
* soc_omgeving6a_T3 en 6b_T3 heeft onlogische codering: hercoderen.
RECODE  soc_omgeving6a_T3 (2=1) (3=2) (4=3) (6=4).
RECODE  soc_omgeving6b_T3 (2=1) (3=2) (4=3) (6=4).
VALUE LABELS soc_omgeving6a_T3 soc_omgeving6b_T3 1 'veel steun' 2  'niet veel/niet weing steun' 3 'weinig steun' 4  'weet niet' . 
EXECUTE.

* missings.
RECODE roken_op_werk1_T3 roken_op_werk2_T3 roken_op_werk3_T3 roken_op_werk4_T3 roken_op_werk5_T3 roken_op_werk6_T3 soc_omgeving6a_T3 soc_omgeving6b_T3 (SYSMIS=99).
EXECUTE.
MISSING VALUES roken_op_werk1_T3 roken_op_werk2_T3 roken_op_werk3_T3 roken_op_werk4_T3  (99) roken_op_werk5_T3 roken_op_werk6_T3 (6,99)  
soc_omgeving6a_T3 soc_omgeving6b_T3 (4,99).
VARIABLE LEVEL roken_op_werk1_T3 roken_op_werk2_T3 roken_op_werk3_T3 roken_op_werk4_T3  (NOMINAL). 
VARIABLE LEVEL roken_op_werk5_T3 roken_op_werk6_T3 soc_omgeving6a_T3 soc_omgeving6b_T3 (ORDINAL).
VARIABLE WIDTH roken_op_werk1_T3 roken_op_werk2_T3 roken_op_werk3_T3 roken_op_werk4_T3 roken_op_werk5_T3 roken_op_werk6_T3  soc_omgeving6a_T3 soc_omgeving6b_T3 (7).


*** Q53/54: werkuren/werkdagen*************************************************************************************************************************************************************.
RENAME VARIABLES Q53=werktijd1_T3 / Q54=werktijd2_T3.

VARIABLE WIDTH werktijd1_T3 werktijd2_T3 (5).
VARIABLE LEVEL werktijd1_T3 werktijd2_T3 (SCALE).
VARIABLE LABELS werktijd1_T3 'aantal werkuren per week T3' / werktijd2_T3 'aantal werkdagen per week T3'.


** aanpassingen.
** 4 personen geven uur per dag op ipv tot aantal uur. Aanpassen.
DO IF (ID_Code=3705 or ID_Code=1915 or ID_Code=4305 or ID_Code=6605).
RECODE werktijd1_T3 (8=40) (9=45).
END IF.
EXECUTE.

* ID 3417	1 uur, 1 dag	Op T0 en T1 40 uur, 5 dagen hier ook.
DO IF  ID_code=3417.
RECODE werktijd1_T3 (1=40).
RECODE werktijd2_T3 (1=5).
END IF.

* ID 1914	1 uur, 1 dag	Op T1 16 uur, 2 dagen  hier ook.
DO IF  ID_code=1914.
RECODE werktijd1_T3 (1=16).
RECODE werktijd2_T3 (1=2).
END IF.
 
* ID 4009	1 uur, 1 dag	Op T1 en T0 38 uur, 5 dagen  hier ook.
DO IF  ID_code=4009.
RECODE werktijd1_T3 (1=38).
RECODE werktijd2_T3 (1=5).
END IF.

* ID 5206	1 uur, 1 dag	Op T0 36 uur 5 dagen  hier ook.
DO IF  ID_code=5206.
RECODE werktijd1_T3 (1=36).
RECODE werktijd2_T3 (1=5).
END IF.

* ID 4205	1 uur, 1 dag	Op T2 36 uur, 5 dagen  hier ook.
DO IF  ID_code=4205.
RECODE werktijd1_T3 (1=36).
RECODE werktijd2_T3 (1=5).
END IF.
EXECUTE.



**Aantal werkuur per dag berekenen.
COMPUTE werkuur_per_dag_T3=werktijd1_T3 / werktijd2_T3.
EXECUTE.

** missings.
RECODE werktijd1_T3 werktijd2_T3 werkuur_per_dag_T3 (SYSMIS=999).
EXECUTE.
MISSING VALUES werktijd1_T3 werktijd2_T3 werkuur_per_dag_T3 (999).

FORMATS werktijd1_T3 werktijd2_T3 (F5.1).

VARIABLE WIDTH werktijd1_T3  werktijd2_T3 werkuur_per_dag_T3 (8).
VARIABLE LEVEL werktijd1_T3  werktijd2_T3 werkuur_per_dag_T3 (SCALE).


*Q55/Q56: pauze******************************************************************************************************************************************************************.
*Q55 (aantal pauzes) van string naar numeriek.

FREQUENCIES VARIABLES=Q55
  /ORDER=ANALYSIS.

RENAME VARIABLES Q55=pauzes_aantal_T3.
ALTER TYPE pauzes_aantal_T3 (F3.0).

*Q55_1_TEXT (aant min pauze) van string naar numeriek.
STRING temp1 (A20).
COMPUTE temp1=REPLACE(Q56_1_TEXT,'minuten','').
EXECUTE.
STRING temp2 (A20).
COMPUTE temp2=REPLACE(temp1,'min','').
EXECUTE.

RENAME VARIABLES temp2=pauzes_minuten_T3.
ALTER TYPE pauzes_minuten_T3 (F3.0).
DELETE VARIABLES temp1.

*Q55_2_TEXT (aant uren pauze) van string naar numeriek.
STRING temp1 (A20).
COMPUTE temp1=REPLACE(Q56_2_TEXT,',','.').
EXECUTE.
STRING temp2 (A20).
COMPUTE temp2=REPLACE(temp1,'Nvt','').
EXECUTE.
STRING temp3 (A20).
COMPUTE temp3=REPLACE(temp2,'nvt','').
EXECUTE.
STRING temp4 (A20).
COMPUTE temp4=REPLACE(temp3,'1\2','0.5').
EXECUTE.
STRING temp5 (A20).
COMPUTE temp5=REPLACE(temp4,'1 uur','1').
EXECUTE.
*controle.
FREQUENCIES VARIABLES=temp5
  /ORDER=ANALYSIS.
RENAME VARIABLES temp5=pauzes_uren_T3.
ALTER TYPE pauzes_uren_T3 (F3.0).
DELETE VARIABLES temp1 temp2 temp3 temp4.

VARIABLE LABELS pauzes_aantal_T3 'aantal pauzes op meest recente werkdag T3' pauzes_minuten_T3 'aantal min pauze T3' pauzes_uren_T3 'aantal uur pauze T3'.
VARIABLE WIDTH pauzes_aantal_T3 pauzes_minuten_T3 pauzes_uren_T3 (5).

** Als wel aantal uur en/of minuten is ingevuld, maar niet aantal keer, dan is aantal keer missing (99).
DO IF  SYSMIS(pauzes_minuten_T3)=0 or SYSMIS(pauzes_uren_T3)=0.
RECODE pauzes_aantal_T3 (SYSMIS=99).
END IF.
EXECUTE.

** als aantal pauzes>0 en aantal minuten is ingevuld en aantal uren niet, dan is aantal uren 0.
DO IF (pauzes_aantal_T3>0 and pauzes_minuten_T3>0).
RECODE pauzes_uren_T3 (SYSMIS=0).
END IF.
EXECUTE.
** als aantal pauzes>0 en aantal uren is ingevuld en aantal min niet, dan is aantal min 0.
DO IF (pauzes_aantal_T3>0 and pauzes_uren_T3>0).
RECODE pauzes_minuten_T3 (SYSMIS=0).
END IF.
EXECUTE.

*CONTROLE: enkele zeer onwaarschijnlijke aantal uren en minuten!!!.

DO IF (pauzes_minuten_T3=90).
RECODE pauzes_uren_T3 (1.5=0).
END IF.
DO IF (pauzes_minuten_T3=60).
RECODE pauzes_uren_T3 (1=0).
END IF.
DO IF (pauzes_minuten_T3=30).
RECODE pauzes_uren_T3 (0.5=0).
END IF.
DO IF (pauzes_minuten_T3=45).
RECODE pauzes_uren_T3 (0.75=0).
END IF.
EXECUTE.

* soms geven deelnemers meerdere pauzes aan met een totale tijd van 5 minuten. Er wordt vanuit gegaan dat ze 5 minuten per pauze bedoelen:.
IF (pauzes_uren_T3=0 and pauzes_minuten_T3=5) pauzes_minuten_T3=(pauzes_minuten_T3*pauzes_aantal_T3).
EXECUTE.

* ingevuld 10 uur, 1 minuten. Is waarschijnlijk andersom.
DO IF (ID_Code=5912). 
RECODE pauzes_minuten_T3 (1=10).
RECODE pauzes_uren_T3 (10=1).
END IF.
EXECUTE.

** missings.
RECODE pauzes_aantal_T3 (SYSMIS=99).
RECODE pauzes_uren_T3 pauzes_minuten_T3 (SYSMIS=999).
EXECUTE.
MISSING VALUES pauzes_aantal_T3 (99) pauzes_uren_T3 pauzes_minuten_T3 (999).
VARIABLE LEVEL pauzes_aantal_T3 pauzes_uren_T3 pauzes_minuten_T3 (SCALE).
VARIABLE WIDTH  pauzes_aantal_T3 pauzes_uren_T3 pauzes_minuten_T3 (10).

** Q57 - Q66: ziekteverzuim**************************************************************************************************************************************************************************.

RENAME VARIABLES Q57=ziekteverzuim1_T3 / Q57_TEXT=ziekteverzuim2_T3 / Q58=ziekteverzuim3_T3.
VARIABLE LABELS ziekteverzuim1_T3 'verlof wegens ziekte afgelopen 3 mnd T3' ziekteverzuim2_T3  'aantal dagen verzuim T3' 
ziekteverzuim3_T3 'langer dan 3 maanden verlof wegens ziekte T3'.
VALUE LABELS ziekteverzuim1_T3 1 'nee' 2 'ja'.
VARIABLE WIDTH ziekteverzuim1_T3 ziekteverzuim2_T3 ziekteverzuim3_T3 (9).

* ziekteverzuim2_T3 (aantal dagen) numeriek maken.
FREQUENCIES VARIABLES= ziekteverzuim2_T3
  /ORDER=ANALYSIS.

*6803	aantal dagen: niet  ziekteverzuim wordt nee.
*5115	aantal dagen: nee  ziekteverzuim wordt nee.
DO IF (ID_code=6803 or ID_Code=5112 or ID_code=4915).
RECODE ziekteverzuim1_T3 (2=1).
RECODE ziekteverzuim2_T3 ('nee'=' ') ('Niet'=' ') (' geen'=' ').
END IF.

RECODE ziekteverzuim2_T3 ('volledig'='75') ('O'= '1') ('7weken'='35') ('46 dagen'='46') ('3 dagen'='3') ('2-3'='2') 
('10uur per week 1 maand lang ivm burn out'='8') ('1 dag. stem kwijt'='1') ('1,5'= '1.5') ('0 dagen'='0') (ELSE=COPY).
EXECUTE.

ALTER TYPE ziekteverzuim2_T3 (F3.1).

FREQUENCIES VARIABLES= ziekteverzuim2_T3
  /ORDER=ANALYSIS.


* Als afwezig=ja en aantal dagen =0.  Aantal dagen wordt 1 (conservatieve schatting).
DO IF ziekteverzuim1_T3=2.
RECODE ziekteverzuim2_T3 (0=1) (SYSMIS=1).
END IF.


*Indien ziekteverzuim1 =1 (nee), dan moet ziekteverzuim2 leeg zijn.
USE ALL.
COMPUTE filter_$=(ziekteverzuim1_T3=1).
VARIABLE LABELS filter_$ 'ziekteverzuim1_T3=1 (FILTER)'.
VALUE LABELS filter_$ 0 'Not Selected' 1 'Selected'.
FORMATS filter_$ (f1.0).
FILTER BY filter_$.
EXECUTE.
FREQUENCIES VARIABLES=ziekteverzuim2_T3
  /ORDER=ANALYSIS.
USE ALL.


*** Langer dan 3 mnd ziek ************************************************************************************************************************************************.

* Q59 van string naar date.
STRING  temp1 (A20).
COMPUTE temp1=REPLACE(Q59,'/','-').
EXECUTE.

STRING  temp2 (A20).
COMPUTE temp2=REPLACE(temp1,'_','-').
EXECUTE.

STRING  temp3 (A20).
COMPUTE temp3=REPLACE(temp2,'.','-').
EXECUTE.

STRING  temp4 (A20).
COMPUTE temp4=REPLACE(temp3,'jan','01').
EXECUTE.

STRING  temp5 (A20).
COMPUTE temp5=REPLACE(temp4,'-6','-06').
EXECUTE.

STRING  temp6 (A20).
COMPUTE temp6=REPLACE(temp5,'-3','-03').
EXECUTE.

STRING  temp7 (A20).
COMPUTE temp7=REPLACE(temp6,'1-5','01-05').
EXECUTE.

STRING  temp8 (A20).
COMPUTE temp8=REPLACE(temp7,'16042017','16-04-2017').
EXECUTE.

RENAME VARIABLES (temp8=ziekteverzuim4_T3).
EXECUTE.
VARIABLE LABELS  ziekteverzuim4_T3 'datum ziekmelding T3'.
DELETE VARIABLES  temp1 temp2 temp3 temp4 temp5 temp6 temp7.

ALTER TYPE ziekteverzuim4_T3 (EDATE10).
EXECUTE.
 

* (datum ziekmelding) moet minimaal 3 maanden (12 weken) voor invuldatum liggen.
* Date and Time Wizard: d_datum_ziekmelding_invuldatum.

COMPUTE  d_datum_ziekmelding_invuldatum_T3=DATEDIF( Invuldatum_T3, ziekteverzuim4_T3, "weeks").
EXECUTE.

VARIABLE LABELS  d_datum_ziekmelding_invuldatum_T3 "verschil in weken invuldatum-ziekmelddatum T3".
VARIABLE LEVEL  d_datum_ziekmelding_invuldatum_T3 (SCALE).
FORMATS  d_datum_ziekmelding_invuldatum_T3 (F5.0).
VARIABLE WIDTH  d_datum_ziekmelding_invuldatum_T3(5).
EXECUTE.
FREQUENCIES VARIABLES=d_datum_ziekmelding_invuldatum_T3
  /ORDER=ANALYSIS.

** aanpassingen Minder dan 13 weken langdurig weghalen (geeft zelf ook al kortdurend ziekteverlof).
IF (ID_code=6412) ziekteverzuim3_T3=1.
IF (ID_code=6412) ziekteverzuim4_T3=1.
EXECUTE.

** 6810	langdurig maar geen datum, op T2 niet ziek. Is 1 dag ziek geweest waarschijnlijk niet langdurig weghalen.
IF (ID_code=6810) ziekteverzuim3_T3=1.

* Missing en nvt toevoegen.
DO IF (ziekteverzuim1_T3=1).
RECODE ziekteverzuim2_T3 (SYSMIS=888).
RECODE ziekteverzuim3_T3 (SYSMIS=1).
END IF.
DO IF (ziekteverzuim1_T3=2).
RECODE ziekteverzuim2_T3 (SYSMIS=999).
END IF.
DO IF (ziekteverzuim1_T3=3).
RECODE ziekteverzuim2_T3 (SYSMIS=888).
END IF.
RECODE ziekteverzuim1_T3 (SYSMIS=9).
RECODE ziekteverzuim3_T3 (SYSMIS=9).
DO IF (ziekteverzuim1_T3=9).
RECODE ziekteverzuim2_T3 (SYSMIS=999).
END IF.
EXECUTE.

MISSING VALUES ziekteverzuim1_T3 ziekteverzuim3_T3 (9) ziekteverzuim2_T3 (888,999).


* Ziekteverzuim1_T3 (=afgelopen 3 mnd) hercoderen: 1=nee, 2 =ja , 3=langdurig (dus indien ziekteverzuim3_T3=2).
DO IF ziekteverzuim3_T3=2.
RECODE ziekteverzuim1_T3 (2=3).
END IF.
VALUE LABELS ziekteverzuim1_T3 1 'nee' 2 'ja' 3 'langdurig >3 mnd' .
* Indien ziekteverzuim is langdurig: aantal dagen missing maken (is niet van belang, advies Sylvia).
DO IF ziekteverzuim3_T3=2.
COMPUTE  ziekteverzuim2_T3=$SYSMIS.
END IF.
EXECUTE.


*** Q60 t/m 62: ziek op het werk************************************************************************************************************************************.
RENAME VARIABLES Q60=ziekteverzuim5_T3 / Q61=ziekteverzuim6_T3 / Q62_1=ziekteverzuim7_T3.
VARIABLE LABELS ziekteverzuim5_T3 'ziek op het werk afgelopen 3 maanden T3' ziekteverzuim6_T3 'ziek op werk: aantal dagen T3'
ziekteverzuim7_T3 'ziek op werk: hoeveel werk verricht T3'.
FORMATS ziekteverzuim6_T3 (F3.0).


*Indien ziekteverzuim5 =1 (nee), dan moeten ziekteverzuim6 en 7  leeg zijn.
USE ALL.
COMPUTE filter_$=(ziekteverzuim5_T3=1).
VARIABLE LABELS filter_$ 'ziekteverzuim5_T0=1 (FILTER)'.
VALUE LABELS filter_$ 0 'Not Selected' 1 'Selected'.
FORMATS filter_$ (f1.0).
FILTER BY filter_$.
EXECUTE.
FREQUENCIES VARIABLES=ziekteverzuim6_T3 ziekteverzuim7_T3
  /ORDER=ANALYSIS.
USE ALL.

* =Indien ziekteverzuim3 (langer dan 3 mnd ziek) ja is, kan ziekteverzuim5 niet ja zijn (want ze hebben niet gewerkt).
CROSSTABS
  /TABLES=ziekteverzuim3_T3 BY ziekteverzuim5_T3
  /FORMAT=AVALUE TABLES
  /CELLS=COUNT
  /COUNT ROUND CELL.

* Komt toch voor: in dat geval 'ziek op werk' verwijderen.

DO IF ID_code=4902 or ID_code=3005 or ID_code=3414 or ID_code=3903 or ID_code=4508 or ID_code=1107  
or ID_code=5909  or ID_code=4008  or ID_code=5601  or ID_code=3407.
RECODE ziekteverzuim5_T3 (2=1).
COMPUTE ziekteverzuim6_T3=888.
COMPUTE ziekteverzuim7_T3=888.
END IF.
EXECUTE.

* Indien ziek op werk= ja en aantal dagen=0--> wordt 1 (conservatieve schatting).
DO IF ziekteverzuim5_T3=2.
RECODE ziekteverzuim6_T3 (0=1).
END IF.
EXECUTE.

* Controle ziekteverzuim6 (aantal werkdagen).
FREQUENCIES VARIABLES=ziekteverzuim6_T3
  /ORDER=ANALYSIS.

* ziekteverzuim7_T0 rare codering: {1, ik kon op deze dagen niets doen: 0}...tot '11, ik kon net zoveel doen als normaal: 10.
*Hercoderen.
RECODE ziekteverzuim7_T3 (1=0) (2=1) (3=2) (4=3) (5=4) (6=5) (7=6) (8=7) (9=8) (10=9) (11=10).
EXECUTE.
VALUE LABELS ziekteverzuim7_T3.

** ID 6810.
DO IF ID_code=6810.
RECODE ziekteverzuim7_T3 (5=999).
END IF.
EXECUTE.


* Missing en nvt toevoegen.
DO IF (ziekteverzuim5_T3=1).
RECODE ziekteverzuim6_T3 (SYSMIS=888).
RECODE ziekteverzuim7_T3 (SYSMIS=888).
END IF.
DO IF (ziekteverzuim5_T3=2).
RECODE ziekteverzuim6_T3 (SYSMIS=999).
RECODE ziekteverzuim7_T3 (SYSMIS=999).
END IF.
RECODE ziekteverzuim5_T3 (SYSMIS=9).
DO IF (ziekteverzuim5_T3=9).
RECODE ziekteverzuim6_T3 (SYSMIS=999).
RECODE ziekteverzuim7_T3 (SYSMIS=999).
END IF.
EXECUTE.

MISSING VALUES ziekteverzuim5_T3 (9) ziekteverzuim6_T3 ziekteverzuim7_T3 (888,999).



*** Q62 t/m 65: ziek mbt onbetaald werk************************************************************************************************************************************.
RENAME VARIABLES Q64=ziekteverzuim8_T3 / Q65=ziekteverzuim9_T3 / Q66=ziekteverzuim10_T3.
VARIABLE LABELS ziekteverzuim8_T3 'verzuim onbetaald werk T3' ziekteverzuim9_T3 'verzuim onbetaald aantal dagen T3' ziekteverzuim10_T3 'verzuim onbetaald uren vervanging T3'.
FORMATS ziekteverzuim9_T3 (F3.0).

*Indien ziekteverzuim8 =1 (nee), dan moeten ziekteverzuim9 en 10  leeg zijn.
USE ALL.
COMPUTE filter_$=(ziekteverzuim8_T3=1).
VARIABLE LABELS filter_$ 'ziekteverzuim8_T3=1 (FILTER)'.
VALUE LABELS filter_$ 0 'Not Selected' 1 'Selected'.
FORMATS filter_$ (f1.0).
FILTER BY filter_$.
EXECUTE.
FREQUENCIES VARIABLES=ziekteverzuim9_T3 ziekteverzuim10_T3
  /ORDER=ANALYSIS.
USE ALL.

* Controle ziekteverzuim9_T3 (aantal dagen).
FREQUENCIES VARIABLES=ziekteverzuim9_T3
  /ORDER=ANALYSIS.

** aantal dagen max 90.
RECODE ziekteverzuim9_T3 (100=90).
EXECUTE.

* Controle ziekteverzuim10_T3 (aantal uur). 
FREQUENCIES VARIABLES=ziekteverzuim10_T3
  /ORDER=ANALYSIS.

** indien ja en aantal uur / aantal dagen = 0 of missing ; veranderen in 1 (conservatieve schatting).
DO IF ziekteverzuim8_T3=2.
RECODE ziekteverzuim9_T3 (0=1) (SYSMIS=1).
RECODE ziekteverzuim10_T3 (0=1) (SYSMIS=1).
END IF.
EXECUTE.

* aantal onwaarschijnlijk, aanpassen:.
DO IF ID_Code=6408.
RECODE ziekteverzuim10_T3 (336=8).
END IF.
DO IF ID_Code=3414.
RECODE ziekteverzuim10_T3 (192=8).
END IF.
DO IF ID_Code=5809.
RECODE ziekteverzuim10_T3 (75=0.8).
END IF.
DO IF ID_Code=4803.
RECODE ziekteverzuim10_T3 (65=2.6).
END IF.
DO IF ID_Code=7102.
RECODE ziekteverzuim10_T3 (60=2).
END IF.
DO IF ID_Code=6708.
RECODE ziekteverzuim10_T3 (45=2).
END IF.
DO IF ID_Code=1609.
RECODE ziekteverzuim10_T3 (40=1).
END IF.
DO IF ID_Code=2810.
RECODE ziekteverzuim10_T3 (30=1).
END IF.
DO IF ID_Code=2404.
RECODE ziekteverzuim10_T3 (30=3).
END IF.
DO IF ID_Code=2504.
RECODE ziekteverzuim10_T3 (25=0.5).
END IF.
DO IF ID_Code=5113.
RECODE ziekteverzuim10_T3 (20=1).
END IF.
DO IF ID_Code=3904.
RECODE ziekteverzuim10_T3 (20=1.3).
END IF.
DO IF ID_Code=4304.
RECODE ziekteverzuim10_T3 (20=2).
END IF.
DO IF ID_Code=3910.
RECODE ziekteverzuim10_T3 (18=1).
END IF.
DO IF ID_Code=2403.
RECODE ziekteverzuim10_T3 (15=0.5).
END IF.
DO IF ID_Code=6101.
RECODE ziekteverzuim10_T3 (15=1).
END IF.
DO IF ID_Code=5111.
RECODE ziekteverzuim10_T3 (15=2.2).
END IF.
DO IF ID_Code=5705.
RECODE ziekteverzuim10_T3 (15=5).
END IF.
DO IF ID_Code=3308.
RECODE ziekteverzuim10_T3 (12=0.8).
END IF.
DO IF ID_Code=4105.
RECODE ziekteverzuim10_T3 (12=2).
END IF.
DO IF ID_Code=2608.
RECODE ziekteverzuim10_T3 (10=0.33).
END IF.
EXECUTE.

* Missing en nvt toevoegen.
DO IF (ziekteverzuim8_T3=1).
RECODE ziekteverzuim9_T3 (SYSMIS=888).
RECODE ziekteverzuim10_T3 (SYSMIS=888).
END IF.
DO IF (ziekteverzuim8_T3=2).
RECODE ziekteverzuim9_T3 (SYSMIS=999).
RECODE ziekteverzuim10_T3 (SYSMIS=999).
END IF.
RECODE ziekteverzuim8_T3 (SYSMIS=9).
DO IF (ziekteverzuim8_T3=9).
RECODE ziekteverzuim9_T3 (SYSMIS=999).
RECODE ziekteverzuim10_T3 (SYSMIS=999).
END IF.
EXECUTE.

MISSING VALUES ziekteverzuim8_T3 (9) ziekteverzuim9_T3 ziekteverzuim10_T3 (888,999).
VARIABLE LEVEL ziekteverzuim1_T3 ziekteverzuim3_T3 ziekteverzuim5_T3 ziekteverzuim8_T3 (NOMINAL).
VARIABLE LEVEL ziekteverzuim2_T3 ziekteverzuim4_T3 ziekteverzuim6_T3 ziekteverzuim7_T3  ziekteverzuim9_T3   ziekteverzuim10_T3 (SCALE).

*** Q68_1 t/m _14 ******************************************************************************************************************************************************.
RENAME VARIABLES Q69_1_TEXT=consult1_T3 / Q69_2_TEXT=consult2_T3 /  Q69_3_TEXT=consult3_T3 /  Q69_4_TEXT=consult4_T3 /  Q69_5_TEXT=consult5_T3 /  Q69_6_TEXT=consult6_T3 / 
 Q69_7_TEXT=consult7_T3 /  Q69_8_TEXT=consult8_T3 /  Q69_9_TEXT=consult9_T3 /  Q69_10_TEXT=consult10_T3 /  Q69_11_TEXT=consult11_T3 /  Q69_12_TEXT=consult12_T3 / 
 Q69_13_TEXT=consult13_T3 /  Q69_14_TEXT=consult14_T3 .

VARIABLE LABELS consult1_T3 'consult HA T3' 
consult2_T3 'consult POH T3' 
consult3_T3 'consult maatsch. werker T3' 
consult4_T3 'consult bedrijfsarts T3'
consult5_T3 'consult ergotherapeut T3' 
consult6_T3 'consult dietist T3' 
consult7_T3 'consult stoppen met roken begeleider T3'  
consult8_T3 'consult tandarts T3' 
consult9_T3 'consult logopedist T3' 
consult10_T3 'consult homeopaat etc T3'
consult11_T3 'consult fysio etc T3' 
consult12_T3 'consult psycholoog etc T3'  
consult13_T3 'consult huidtherapeut/mondhygienist T3' 
consult14_T3 'consult manicure/pedicure T3'. 

* van string naar numeriek. Controle.
FREQUENCIES VARIABLES=consult1_T3 consult2_T3 consult3_T3 consult4_T3 consult5_T3 consult6_T3 
    consult7_T3 consult8_T3 consult9_T3 consult10_T3 consult11_T3 consult12_T3 consult13_T3 consult14_T3    
  /ORDER=ANALYSIS.

RECODE consult1_T3 to consult14_T3 ('O'='0').
RECODE consult6_T3 ('0001'='1').
RECODE consult9_T3 ('p'='1').
EXECUTE.

ALTER TYPE consult1_T3 to consult14_T3 (F2.0).

** Als er minimaal 1 is ingevuld en de rest missing, zijn die missings 0 (geen consult).
DO IF (NVALID(consult1_T3,consult2_T3,consult3_T3,consult4_T3,consult5_T3,consult6_T3,consult7_T3,
    consult8_T3,consult9_T3,consult10_T3,consult11_T3,consult12_T3,consult13_T3,consult14_T3)>=1).
RECODE consult1_T3 consult2_T3 consult3_T3 consult4_T3 consult5_T3 consult6_T3 consult7_T3 consult8_T3 consult9_T3 
    consult10_T3 consult11_T3 consult12_T3 consult13_T3 consult14_T3 (SYSMIS=0).
END IF.
EXECUTE.

** Als er helemaal niets is ingevuld, maar de vragenlijst is wel  'gefinished', dan zijn de missings 0 (geen consult).
DO IF (NVALID(consult1_T3,consult2_T3,consult3_T3,consult4_T3,consult5_T3,consult6_T3,consult7_T3,
    consult8_T3,consult9_T3,consult10_T3,consult11_T3,consult12_T3,consult13_T3,consult14_T3)=0 and  Finished=1).
RECODE consult1_T3 consult2_T3 consult3_T3 consult4_T3 consult5_T3 consult6_T3 consult7_T3 consult8_T3 consult9_T3 
    consult10_T3 consult11_T3 consult12_T3 consult13_T3 consult14_T3 (SYSMIS=0).
END IF.
EXECUTE.

** Als er helemaal niets is ingevuld, en de vragenlijst is niet  'gefinished', dan zijn de missings 999 (echt missing).
DO IF (NVALID(consult1_T3,consult2_T3,consult3_T3,consult4_T3,consult5_T3,consult6_T3,consult7_T3,
    consult8_T3,consult9_T3,consult10_T3,consult11_T3,consult12_T3,consult13_T3,consult14_T3)=0 and  Finished=0).
RECODE consult1_T3 consult2_T3 consult3_T3 consult4_T3 consult5_T3 consult6_T3 consult7_T3 consult8_T3 consult9_T3 
    consult10_T3 consult11_T3 consult12_T3 consult13_T3 consult14_T3 (SYSMIS=999).
END IF.
EXECUTE.

**Indien de verkorte vragenlijst is ingevuld , is alleen consult 7 (stoppen met roken begeleider) ingevuld. Rest wordt missing.
DO IF (papier_T3=2).
RECODE consult1_T3 consult2_T3 consult3_T3 consult4_T3 consult5_T3 consult6_T3 consult8_T3 consult9_T3 
    consult10_T3 consult11_T3 consult12_T3 consult13_T3 consult14_T3 (0=999).
END IF.
EXECUTE.


MISSING VALUES consult1_T3 consult2_T3 consult3_T3 consult4_T3 consult5_T3 consult6_T3 consult7_T3 consult8_T3 consult9_T3 
    consult10_T3 consult11_T3 consult12_T3 consult13_T3 consult14_T3 (999).


VARIABLE WIDTH consult1_T3 consult2_T3 consult3_T3 consult4_T3 consult5_T3 consult6_T3 consult7_T3 consult8_T3 consult9_T3 
    consult10_T3 consult11_T3 consult12_T3 consult13_T3 consult14_T3 (6).


*** Q69-Q72 Thuiszorg *******************************************************************************************************************************************************.
RENAME VARIABLES Q70=thuiszorg_T3 / Q71_1=thuiszorg_hh_T3 / Q71_2=thuiszorg_verzorging_T3 / Q71_3=thuiszorg_verpleging_T3 / 
Q72_X1_TEXT=thuiszorg_hh_weken_T3 / Q72_X2_TEXT=thuiszorg_verzorging_weken_T3 / Q72_X3_TEXT=thuiszorg_verpleging_weken_T3 / 
Q73_X1_TEXT=thuiszorg_hh_uur_T3 / Q73_X2_TEXT=thuiszorg_verzorging_uur_T3 / Q73_X3_TEXT=thuiszorg_verpleging_uur_T3. 

VARIABLE LABELS thuiszorg_T3 'thuiszorg ja/nee T3'
thuiszorg_hh_T3 'thuiszorg huishouden ja/nee T3'
thuiszorg_verzorging_T3 'thuiszorg verzorging ja/nee T3'
thuiszorg_verpleging_T3 'thuiszorg verpleging ja/nee T3'
thuiszorg_hh_weken_T3 'thuiszorg huishouden aant weken T3'
thuiszorg_verzorging_weken_T3 'thuiszorg verzorging aant weken T3'
thuiszorg_verpleging_weken_T3  'thuiszorg verpleging aant weken T3'
thuiszorg_hh_uur_T3 'thuiszorg huishouden aant uur/wk T3'
thuiszorg_verzorging_uur_T3 'thuiszorg verzorging aant uur/wk T3'
thuiszorg_verpleging_uur_T3 'thuiszorg verpleging aant uur/wk T3'. 

*Indien thuiszorg_T0 =1 (nee), dan moeten thuiszorg_hh_T0, thuiszorg_verzorging_T0 en thuiszorg_verpleging_T0 sysmis zijn.
USE ALL.
COMPUTE filter_$=( thuiszorg_T3=1).
VARIABLE LABELS filter_$ ' thuiszorg_T3=1 (FILTER)'.
VALUE LABELS filter_$ 0 'Not Selected' 1 'Selected'.
FORMATS filter_$ (f1.0).
FILTER BY filter_$.
EXECUTE.
FREQUENCIES VARIABLES= thuiszorg_hh_T3 thuiszorg_verzorging_T3 thuiszorg_verpleging_T3 
  /ORDER=ANALYSIS.
USE ALL.

* visueel in database nakijken: als thuiszorg_T3 ergens 2 is, dan moet er ook wat staan bij de bijbehorende weken en uren. (descending sorteren op thuiszorg_T0)

* 5206 50 weken hulp: kan max 13 weken zijn.
IF (ID_code=5206) thuiszorg_verpleging_weken_T3='13'.
EXECUTE.

* controle of er geen tekst is ingevuld.
FREQUENCIES VARIABLES=thuiszorg_hh_weken_T3 thuiszorg_verzorging_weken_T3 thuiszorg_verpleging_weken_T3  
thuiszorg_hh_uur_T3 thuiszorg_verzorging_uur_T3 thuiszorg_verpleging_uur_T3 
  /ORDER=ANALYSIS.

* omzetten string naar numeriek.
ALTER TYPE thuiszorg_hh_weken_T3 thuiszorg_verzorging_weken_T3 thuiszorg_verpleging_weken_T3  (F2.0).
ALTER TYPE thuiszorg_hh_uur_T3 thuiszorg_verzorging_uur_T3 thuiszorg_verpleging_uur_T3 (F3.1).

VARIABLE WIDTH thuiszorg_hh_weken_T3 thuiszorg_verzorging_weken_T3 thuiszorg_verpleging_weken_T3  
thuiszorg_hh_uur_T3 thuiszorg_verzorging_uur_T3 thuiszorg_verpleging_uur_T3 (8).

VARIABLE LEVEL  thuiszorg_T3 thuiszorg_hh_T3 thuiszorg_verzorging_T3 thuiszorg_verpleging_T3 (NOMINAL).
VARIABLE LEVEL  thuiszorg_hh_weken_T3 thuiszorg_verzorging_weken_T3 thuiszorg_verpleging_weken_T3  
thuiszorg_hh_uur_T3 thuiszorg_verzorging_uur_T3 thuiszorg_verpleging_uur_T3 (SCALE).


**Indien thuiszorg_T3 =1 (nee), rest hercoderen naar 0.
DO IF thuiszorg_T3=1.
RECODE thuiszorg_hh_weken_T3 thuiszorg_verzorging_weken_T3 thuiszorg_verpleging_weken_T3
 thuiszorg_hh_uur_T3 thuiszorg_verzorging_uur_T3 thuiszorg_verpleging_uur_T3 (SYSMIS=0).
END IF.
DO IF SYSMIS(thuiszorg_hh_T3) =1 and thuiszorg_T3=2.
RECODE thuiszorg_hh_T3 thuiszorg_hh_weken_T3  thuiszorg_hh_uur_T3 (SYSMIS=0).
END IF.
DO IF SYSMIS(thuiszorg_verzorging_T3)=1  and thuiszorg_T3=2.
RECODE thuiszorg_verzorging_T3 thuiszorg_verzorging_weken_T3  thuiszorg_verzorging_uur_T3 (SYSMIS=0).
END IF.
DO IF SYSMIS(thuiszorg_verpleging_T3)=1  and thuiszorg_T3=2.
RECODE thuiszorg_verpleging_T3 thuiszorg_verpleging_weken_T3  thuiszorg_verpleging_uur_T3 (SYSMIS=0).
END IF.
DO IF thuiszorg_T3=1.
RECODE thuiszorg_hh_T3 thuiszorg_verzorging_T3 thuiszorg_verpleging_T3  (SYSMIS=0).
END IF.
EXECUTE. 

** missings toevoegen.
RECODE thuiszorg_T3 (SYSMIS=9).
DO IF (thuiszorg_T3 =9).
RECODE thuiszorg_hh_T3 thuiszorg_verzorging_T3 thuiszorg_verpleging_T3  (SYSMIS=9).
RECODE  thuiszorg_hh_weken_T3 thuiszorg_verzorging_weken_T3 thuiszorg_verpleging_weken_T3
 thuiszorg_hh_uur_T3 thuiszorg_verzorging_uur_T3 thuiszorg_verpleging_uur_T3 (SYSMIS=999).
END IF.
EXECUTE.

MISSING VALUES  thuiszorg_T3 thuiszorg_hh_T3 thuiszorg_verzorging_T3 thuiszorg_verpleging_T3  (9)
thuiszorg_hh_weken_T3 thuiszorg_verzorging_weken_T3 thuiszorg_verpleging_weken_T3
 thuiszorg_hh_uur_T3 thuiszorg_verzorging_uur_T3 thuiszorg_verpleging_uur_T3 (999).

*** Q87: gebruik nicotinevervangers afgelopen 3 mnd ****************************************************************************************************************************.

RENAME VARIABLES Q74=nicotinevervangers_T3 / Q75_1=nicotinepleisters_T3 / Q75_2=nicotinekauwgom_T3 / Q75_3=nicotine_microtabs_T3 / Q75_4=nicotine_zuigtabletten_T3 /
Q75_5=nicotine_mondspray_T3 / Q75_6=nicotine_inhaler_T3 / Q75_7=nicotine_anders_T3 / Q75_7_TEXT=nicotine_anders_nl_T3. 

VARIABLE LABELS nicotinevervangers_T3 'nicotinevervangers: ja/nee' /
nicotinepleisters_T3 'nicotinevervangers: pleister ja/nee' /
nicotinekauwgom_T3 'nicotinevervangers: kauwgom ja/nee' /
nicotine_microtabs_T3 'nicotinevervangers: microtabs ja/nee' /
nicotine_zuigtabletten_T3  'nicotinevervangers: zuigtabletten ja/nee' /
nicotine_mondspray_T3 'nicotinevervangers: mondspray ja/nee' /
nicotine_inhaler_T3 'nicotinevervangers: inhaler ja/nee' /
nicotine_anders_T3 'nicotinevervangers: anders ja/nee' /
nicotine_anders_nl_T3 'nicotinevervangers: anders nl.'.

VALUE LABELS nicotinevervangers_T3 2 'ja' 1 'nee' /nicotinepleisters_T3 nicotinekauwgom_T3 nicotine_microtabs_T3 nicotine_zuigtabletten_T3 
nicotine_mondspray_T3 nicotine_inhaler_T3 nicotine_anders_T3  0 'nee'1 'ja'.

** Nicotinevervangers ja, verder niets ingevuld.
DO IF (ID_code=1513).
RECODE nicotinepleisters_T3 (SYSMIS=9).
RECODE nicotinekauwgom_T3 (SYSMIS=9).
RECODE nicotine_microtabs_T3 (SYSMIS=9).
RECODE nicotine_zuigtabletten_T3 (SYSMIS=9).
RECODE nicotine_mondspray_T3 (SYSMIS=9).
RECODE nicotine_inhaler_T3 (SYSMIS=9).
RECODE nicotine_anders_T3 (SYSMIS=9).
END IF.
EXECUTE.

* Indien nicotinevervangers_T3 niet missing is, moeten de verschillende soorten missings 0 zijn.
DO IF (nicotinevervangers_T3=1 or nicotinevervangers_T3=2).
RECODE nicotinepleisters_T3 nicotinekauwgom_T3 nicotine_microtabs_T3 nicotine_zuigtabletten_T3 nicotine_mondspray_T3 nicotine_inhaler_T3 nicotine_anders_T3 (SYSMIS=0).
END IF.
EXECUTE.

* missing toevoegen (rest van sysmis is missing).
RECODE nicotinevervangers_T3 nicotinepleisters_T3 nicotinekauwgom_T3 nicotine_microtabs_T3 nicotine_zuigtabletten_T3 nicotine_mondspray_T3 nicotine_inhaler_T3 
nicotine_anders_T3 (SYSMIS=9).
MISSING VALUES nicotinevervangers_T3 nicotinepleisters_T3 nicotinekauwgom_T3 nicotine_microtabs_T3 nicotine_zuigtabletten_T3 nicotine_mondspray_T3 nicotine_inhaler_T3 
nicotine_anders_T3 (9).
EXECUTE.

RENAME VARIABLES Q76_x1_TEXT=nicotinepleisters_stuks_T3 / Q76_x2_TEXT=nicotinekauwgom_stuks_T3 / Q76_x3_TEXT=nicotine_microtabs_stuks_T3 / 
Q76_x4_TEXT=nicotine_zuigtabletten_stuks_T3 / Q76_x5_TEXT=nicotine_mondspray_keer_T3 / Q76_x6_TEXT=nicotine_inhaler_keer_T3 / Q76_x7_TEXT=nicotine_anders_stuks_T3 / 
Q77_x1_TEXT=nicotinepleisters_dagen_T3 / Q77_x2_TEXT=nicotinekauwgom_dagen_T3 / Q77_x3_TEXT=nicotine_microtabs_dagen_T3 / 
Q77_x4_TEXT=nicotine_zuigtabletten_dagen_T3 / Q77_x5_TEXT=nicotine_mondspray_dagen_T3 / Q77_x6_TEXT=nicotine_inhaler_dagen_T3 / Q77_x7_TEXT=nicotine_anders_dagen_T3.

VARIABLE LABELS nicotinepleisters_stuks_T3 'nicotinevervangers: pleister aantal stuks/dag' /
nicotinekauwgom_stuks_T3  'nicotinevervangers: kauwgom aantal stuks/dag' /
nicotine_microtabs_stuks_T3 'nicotinevervangers: microtabs aantal stuks/dag' /
nicotine_zuigtabletten_stuks_T3 'nicotinevervangers: zuigtabletten aantal stuks/dag' /
nicotine_mondspray_keer_T3 'nicotinevervangers: mondspray aantal keer/dag' /
nicotine_inhaler_keer_T3 'nicotinevervangers: inhaler aantal keer/dag' /
nicotine_anders_stuks_T3 'nicotinevervangers: anders aantal stuks/dag'.

VARIABLE LABELS nicotinepleisters_dagen_T3  'nicotinevervangers: pleister aantal dagen' /
nicotinekauwgom_dagen_T3 'nicotinevervangers: kauwgom aantal dagen' /
nicotine_microtabs_dagen_T3 'nicotinevervangers: microtabs aantal dagen' /
nicotine_zuigtabletten_dagen_T3 'nicotinevervangers: zuigtabletten aantal dagen' /
nicotine_mondspray_dagen_T3 'nicotinevervangers: mondspray aantal dagen' /
nicotine_inhaler_dagen_T3 'nicotinevervangers: inhaler aantal dagen' /
nicotine_anders_dagen_T3 'nicotinevervangers: anders aantal dagen'.

* aantal stuks en aantal dagen van string naar numeriek.
* controle geen tekst.
FREQUENCIES VARIABLES= nicotinepleisters_stuks_T3 nicotinekauwgom_stuks_T3 nicotine_microtabs_stuks_T3 
    nicotine_zuigtabletten_stuks_T3 nicotine_mondspray_keer_T3 nicotine_inhaler_keer_T3 
    nicotine_anders_stuks_T3 nicotinepleisters_dagen_T3 nicotinekauwgom_dagen_T3 
    nicotine_microtabs_dagen_T3 nicotine_zuigtabletten_dagen_T3 nicotine_mondspray_dagen_T3 
    nicotine_inhaler_dagen_T3 nicotine_anders_dagen_T3
  /ORDER=ANALYSIS.

RECODE nicotine_anders_stuks_T3 ('nvt'='888').
RECODE nicotinekauwgom_dagen_T3 ('Ieder dag'='90').
RECODE nicotinekauwgom_dagen_T3 ('Elke dag'='90').
RECODE nicotine_zuigtabletten_dagen_T3 ('?'='999').
RECODE nicotine_anders_dagen_T3 ('Elke dag'='90').
RECODE nicotine_anders_dagen_T3 ('dagelijks'='90').
RECODE nicotine_anders_dagen_T3 ('Alle'='90').
RECODE nicotine_anders_dagen_T3 ('ca. 14'='14').
EXECUTE.

ALTER TYPE nicotinepleisters_stuks_T3 nicotinekauwgom_stuks_T3 nicotine_microtabs_stuks_T3 
    nicotine_zuigtabletten_stuks_T3 nicotine_mondspray_keer_T3 nicotine_inhaler_keer_T3 
    nicotine_anders_stuks_T3 nicotinepleisters_dagen_T3 nicotinekauwgom_dagen_T3 
    nicotine_microtabs_dagen_T3 nicotine_zuigtabletten_dagen_T3 nicotine_mondspray_dagen_T3 
    nicotine_inhaler_dagen_T3 nicotine_anders_dagen_T3 (F3.0).

* controle reele getallen.
FREQUENCIES VARIABLES= nicotinepleisters_stuks_T3 nicotinekauwgom_stuks_T3 nicotine_microtabs_stuks_T3 
    nicotine_zuigtabletten_stuks_T3 nicotine_mondspray_keer_T3 nicotine_inhaler_keer_T3 
    nicotine_anders_stuks_T3 nicotinepleisters_dagen_T3 nicotinekauwgom_dagen_T3 
    nicotine_microtabs_dagen_T3 nicotine_zuigtabletten_dagen_T3 nicotine_mondspray_dagen_T3 
    nicotine_inhaler_dagen_T3 nicotine_anders_dagen_T3
  /ORDER=ANALYSIS.

** correcties.
* pleisters is altijd 1 per dag.
RECODE nicotinepleisters_stuks_T3 (6=1).
* kauwgom = ja: 0 wordt 1 (conservatieve schatting).
RECODE nicotinekauwgom_stuks_T3 (0=1).
EXECUTE.

** antwoorden in categorie 'anders' gelijk maken.
RECODE nicotine_anders_nl_T3 ('champix'='Champix').
RECODE nicotine_anders_nl_T3 ('esmoker'='E sigaret').
RECODE nicotine_anders_nl_T3 ('Esigaret'='E sigaret').
RECODE nicotine_anders_nl_T3 ('electrische sigaret'='E sigaret').
RECODE nicotine_anders_nl_T3 ('e-sigaret'='E sigaret').
RECODE nicotine_anders_nl_T3 ('E smoker'='E sigaret').
RECODE nicotine_anders_nl_T3 ('E sigaret'='E sigaret').
RECODE nicotine_anders_nl_T3 ('pille'='pillen').
EXECUTE.

*** nvt toevoegen.
DO IF (nicotinepleisters_T3=0).
RECODE nicotinepleisters_stuks_T3 (SYSMIS=888).
RECODE nicotinepleisters_dagen_T3 (SYSMIS=888).
END IF.
EXECUTE.
DO IF (nicotinekauwgom_T3=0).
RECODE nicotinekauwgom_stuks_T3 (SYSMIS=888).
RECODE nicotinekauwgom_dagen_T3 (SYSMIS=888).
END IF.
EXECUTE.
DO IF (nicotine_microtabs_T3=0).
RECODE nicotine_microtabs_stuks_T3 (SYSMIS=888).
RECODE nicotine_microtabs_dagen_T3 (SYSMIS=888).
END IF.
EXECUTE.
DO IF (nicotine_zuigtabletten_T3=0).
RECODE nicotine_zuigtabletten_stuks_T3 (SYSMIS=888).
RECODE nicotine_zuigtabletten_dagen_T3 (SYSMIS=888).
END IF.
EXECUTE.
DO IF (nicotine_mondspray_T3=0).
RECODE nicotine_mondspray_keer_T3 (SYSMIS=888).
RECODE nicotine_mondspray_dagen_T3 (SYSMIS=888).
END IF.
EXECUTE.
DO IF (nicotine_inhaler_T3=0).
RECODE nicotine_inhaler_keer_T3 (SYSMIS=888).
RECODE nicotine_inhaler_dagen_T3 (SYSMIS=888).
END IF.
EXECUTE.
DO IF (nicotine_anders_T3=0).
RECODE nicotine_anders_stuks_T3 (SYSMIS=888).
RECODE nicotine_anders_dagen_T3 (SYSMIS=888).
END IF.
EXECUTE.

** Degene die nu nog sysmis zijn zijn echt missing (worden wel gebruikt maar geen aantal ingevuld).
RECODE nicotinepleisters_stuks_T3 nicotinekauwgom_stuks_T3 nicotine_microtabs_stuks_T3 
    nicotine_zuigtabletten_stuks_T3 nicotine_mondspray_keer_T3 nicotine_inhaler_keer_T3 
    nicotine_anders_stuks_T3 nicotinepleisters_dagen_T3 nicotinekauwgom_dagen_T3 
    nicotine_microtabs_dagen_T3 nicotine_zuigtabletten_dagen_T3 nicotine_mondspray_dagen_T3 
    nicotine_inhaler_dagen_T3 nicotine_anders_dagen_T3 (SYSMIS=999).
EXECUTE.

MISSING VALUES nicotinepleisters_stuks_T3 nicotinekauwgom_stuks_T3 nicotine_microtabs_stuks_T3 
    nicotine_zuigtabletten_stuks_T3 nicotine_mondspray_keer_T3 nicotine_inhaler_keer_T3 
    nicotine_anders_stuks_T3 nicotinepleisters_dagen_T3 nicotinekauwgom_dagen_T3 
    nicotine_microtabs_dagen_T3 nicotine_zuigtabletten_dagen_T3 nicotine_mondspray_dagen_T3 
    nicotine_inhaler_dagen_T3 nicotine_anders_dagen_T3 (888,999) nicotinepleisters_T3 nicotinekauwgom_T3 nicotine_microtabs_T3 
    nicotine_zuigtabletten_T3 nicotine_mondspray_T3 nicotine_inhaler_T3 nicotine_anders_T3 (9).

VARIABLE LEVEL nicotinevervangers_T3 nicotinepleisters_T3 nicotinekauwgom_T3 nicotine_microtabs_T3 
    nicotine_zuigtabletten_T3 nicotine_mondspray_T3 nicotine_inhaler_T3 nicotine_anders_T3 (NOMINAL).
VARIABLE LEVEL nicotinepleisters_stuks_T3 nicotinekauwgom_stuks_T3 nicotine_microtabs_stuks_T3 
    nicotine_zuigtabletten_stuks_T3 nicotine_mondspray_keer_T3 nicotine_inhaler_keer_T3 
    nicotine_anders_stuks_T3 nicotinepleisters_dagen_T3 nicotinekauwgom_dagen_T3 
    nicotine_microtabs_dagen_T3 nicotine_zuigtabletten_dagen_T3 nicotine_mondspray_dagen_T3 
    nicotine_inhaler_dagen_T3 nicotine_anders_dagen_T3 (SCALE).


*** Q89: gebruik electronische sigaretten ****************************************************************************************************************************.
RENAME VARIABLES Q78 =Esigaret_T3 / Q79_1=Esigaret_met_nicotine_T3 / Q79_2=Esigaret_zonder_nicotine_T3.
VARIABLE LABELS Esigaret_T3 'E-sigaret gebruikt: ja/nee'
Esigaret_met_nicotine_T3  'E-sigaret met nicotine: ja/nee' 
Esigaret_zonder_nicotine_T3  'E-sigaret zonder nicotine: ja/nee'.
VALUE LABELS Esigaret_met_nicotine_T3 Esigaret_zonder_nicotine_T3 0 'nee' 1 'ja' .

RENAME VARIABLES Q80_1_x1_1_TEXT= Esigaret_met_nicotine_stuks_T3 / Q80_1_x2_1_TEXT =Esigaret_zonder_nicotine_stuks_T3/
Q80_2_x1_1_TEXT=Esigaret_met_nicotine_dagen_T3 / Q80_2_x2_1_TEXT=Esigaret_zonder_nicotine_dagen_T3.
VARIABLE LABELS  Esigaret_met_nicotine_stuks_T3 'E-sigaret met nicotine: aantal stuks/dag T3' / Esigaret_zonder_nicotine_stuks_T3 'E-sigaret zonder nicotine: aantal stuks/dag T3'.
VARIABLE LABELS Esigaret_met_nicotine_dagen_T3 'E-sigaret met nicotine: aantal dagen T3' / Esigaret_zonder_nicotine_dagen_T3 'E-sigaret zonder nicotine: aantal dagen T3'.

VARIABLE LEVEL Esigaret_T3 Esigaret_met_nicotine_T3 Esigaret_zonder_nicotine_T3 (NOMINAL).

* Indien Esigaret1_T3 Nee is, moet missing  0 zijn.
DO IF (Esigaret_T3=1).
RECODE Esigaret_met_nicotine_T3 Esigaret_zonder_nicotine_T3 (SYSMIS=0).
END IF.
EXECUTE.

* Indien Esigaret1_T0 2 (ja) is, moet Esigaret_met_nicotine_T1 of Esigaret_zonder_nicotine_T1 1 (ja) zijn, indien beide missing: missing. Indien 1 ingevuld en andere missing: andere=0.
DO IF (Esigaret_T3=2) and SYSMIS (Esigaret_met_nicotine_T3 )=1 and SYSMIS (Esigaret_zonder_nicotine_T3 )=1.
RECODE   Esigaret_met_nicotine_T3 Esigaret_zonder_nicotine_T3 (SYSMIS=9).
END IF.
DO IF Esigaret_T3=2.
RECODE   Esigaret_met_nicotine_T3 Esigaret_zonder_nicotine_T3 (SYSMIS=0).
END IF.
MISSING VALUES Esigaret_met_nicotine_T3 Esigaret_zonder_nicotine_T3 (9).
EXECUTE.

** Missing toevoegen (overige sysmis=missing).
RECODE Esigaret_T3 Esigaret_met_nicotine_T3 Esigaret_zonder_nicotine_T3 (SYSMIS=9).
MISSING VALUES Esigaret_T3 Esigaret_met_nicotine_T3 Esigaret_zonder_nicotine_T3 (9).
EXECUTE.

*stuks en dagen wordt voorlopig niet mee gerekend. Als string laten staan.


*** Q80 medicatie *******************************************************************************************************************************************************.
RENAME VARIABLES Q81=medicatie_T3 / Q82_1_TEXT = med1_T3 /  Q82_2_TEXT  = med2_T3 /  Q82_3_TEXT  = med3_T3 /  Q82_4_TEXT  = med4_T3 /  Q82_5_TEXT  = med5_T3 /
 Q82_6_TEXT  = med6_T3 / Q82_7_TEXT  = med7_T3 / Q82_8_TEXT  = med8_T3 /  Q82_9_TEXT  = med9_T3 /  Q82_10_TEXT  = med10_T3. 

VARIABLE LABELS medicatie_T3 'medicatie ja/nee T3' med1_T3 'med naam 1 T3'  med2_T3 'med naam 2 T3'  med3_T3 'med naam 3 T3'  med4_T3 'med naam 4 T3'
 med5_T3 'med naam 5 T3'  med6_T3 'med naam 6 T3'  med7_T3 'med naam 7 T3'  med8_T3 'med naam 8 T3'  med9_T3 'med naam 9 T3'  med10_T3 'med naam 10 T3'.

RENAME VARIABLES Q83_x1_TEXT =med1_dosering_T3 / Q83_x2_TEXT =med2_dosering_T3 / Q83_x3_TEXT =med3_dosering_T3 
/ Q83_x4_TEXT =med4_dosering_T3 / Q83_x5_TEXT =med5_dosering_T3 / Q83_x6_TEXT =med6_dosering_T3 
/ Q83_x7_TEXT =med7_dosering_T3 / Q83_x8_TEXT =med8_dosering_T3 / Q83_x9_TEXT =med9_dosering_T3 / Q83_x10_TEXT =med10_dosering_T3.

VARIABLE LABELS  med1_dosering_T3 / med2_dosering_T3 / med3_dosering_T3 / med4_dosering_T3 / med5_dosering_T3 / med6_dosering_T3 / med7_dosering_T3 / 
    med8_dosering_T3 / med9_dosering_T3 / med10_dosering_T3.

RENAME VARIABLES Q84_x1_TEXT =med1_keerperdag_T3 / Q84_x2_TEXT  =med2_keerperdag_T3 /  Q84_x3_TEXT  =med3_keerperdag_T3 / 
 Q84_x4_TEXT  =med4_keerperdag_T3 /  Q84_x5_TEXT  =med5_keerperdag_T3 /  Q84_x6_TEXT  =med6_keerperdag_T3 / 
 Q84_x7_TEXT  =med7_keerperdag_T3 /  Q84_x8_TEXT  =med8_keerperdag_T3 /  Q84_x9_TEXT  =med9_keerperdag_T3 / 
 Q84_x10_TEXT =med10_keerperdag_T3 .

VARIABLE LABELS  med1_keerperdag_T3 / med2_keerperdag_T3 / med3_keerperdag_T3 / med4_keerperdag_T3 / med5_keerperdag_T3 / 
    med6_keerperdag_T3 / med7_keerperdag_T3 / med8_keerperdag_T3 / med9_keerperdag_T3 / med10_keerperdag_T3.

RENAME VARIABLES Q85_x1_TEXT =med1_aantdagen_T3 / Q85_x2_TEXT =med2_aantdagen_T3 / Q85_x3_TEXT =med3_aantdagen_T3 / 
Q85_x4_TEXT =med4_aantdagen_T3 / Q85_x5_TEXT =med5_aantdagen_T3 / Q85_x6_TEXT =med6_aantdagen_T3 / 
Q85_x7_TEXT =med7_aantdagen_T3 / Q85_x8_TEXT =med8_aantdagen_T3 / Q85_x9_TEXT =med9_aantdagen_T3 /
Q85_x10_TEXT =med10_aantdagen_T3.

VARIABLE LABELS   med1_aantdagen_T3 / med2_aantdagen_T3 / med3_aantdagen_T3  / med4_aantdagen_T3 / med5_aantdagen_T3 /
    med6_aantdagen_T3 / med7_aantdagen_T3 / med8_aantdagen_T3 / med9_aantdagen_T3 / med10_aantdagen_T3.

RENAME VARIABLES  Q86_x1_TEXT =med1_vorm_T3 / Q86_x2_TEXT =med2_vorm_T3 / Q86_x3_TEXT =med3_vorm_T3 / 
Q86_x4_TEXT =med4_vorm_T3 /Q86_x5_TEXT =med5_vorm_T3 /Q86_x6_TEXT =med6_vorm_T3 / 
Q86_x7_TEXT =med7_vorm_T3 / Q86_x8_TEXT =med8_vorm_T3 /Q86_x9_TEXT =med9_vorm_T3 /Q86_x10_TEXT =med10_vorm_T3.

VARIABLE LABELS  med1_vorm_T3 / med2_vorm_T3 / med3_vorm_T3 / med4_vorm_T3 / med5_vorm_T3 / med6_vorm_T3 / med7_vorm_T3 / 
    med8_vorm_T3 / med9_vorm_T3 / med10_vorm_T3.


** als medicatie_T3=1 (nee) of missing: med1_T3 moet leeg zijn.
USE ALL.
COMPUTE filter_$=(medicatie_T3=1 or MISSING(medicatie_T3)=1).
VARIABLE LABELS filter_$ 'medicatie_T3=1 of missing (FILTER)'.
VALUE LABELS filter_$ 0 'Not Selected' 1 'Selected'.
FORMATS filter_$ (f1.0).
FILTER BY filter_$.
EXECUTE.
FREQUENCIES VARIABLES=med1_T3
  /ORDER=ANALYSIS.
USE ALL.

** ID 2702. Med 2 gestopt --> verwijderen.
DO IF ID_Code=2702.
RECODE med2_T3 ('Hoge bloeddruk'='').
RECODE med2_dosering_T3 ('Gestopt!'='').
RECODE med2_keerperdag_T3 ('Sinds twee weken gestopt.'='').
RECODE med2_vorm_T3 ('Pil'='').
END IF.
EXECUTE.

** missing invullen.
RECODE medicatie_T3 (SYSMIS=9).
MISSING VALUES  medicatie_T3 (9).
EXECUTE.

*aantal keer per dag en aantal dagen van string naar numeriek.
* controle op tekst en decimalen moeten met punt.
FREQUENCIES VARIABLES= med1_keerperdag_T3 med2_keerperdag_T3 med3_keerperdag_T3 med4_keerperdag_T3 med5_keerperdag_T3 
    med6_keerperdag_T3 med7_keerperdag_T3 med8_keerperdag_T3 med9_keerperdag_T3 
 /ORDER=ANALYSIS.
FREQUENCIES VARIABLES= med1_aantdagen_T3 med2_aantdagen_T3 med3_aantdagen_T3 med4_aantdagen_T3 med5_aantdagen_T3 
    med6_aantdagen_T3 med7_aantdagen_T3 med8_aantdagen_T3 med9_aantdagen_T3  
 /ORDER=ANALYSIS.

** 1x per week wordt 1/7=0.14 indien aantal dagen volledige periode bestrijkt.
** indien aantal fdagen al is aangepast, wordt het 1.

RECODE med1_keerperdag_T3 ('Zo nodig'='1').
RECODE med1_keerperdag_T3 ('x60'='1').
RECODE med1_keerperdag_T3 ('half'='1').
RECODE med1_keerperdag_T3 ('80 mg'='1').
RECODE med1_keerperdag_T3 ('550IE'='1').
RECODE med1_aantdagen_T3 ('1 injectie werkt +/_ 3 maanden'='1').
RECODE med1_keerperdag_T3 ('4pd'='4').
RECODE med1_keerperdag_T3 ('3 x'='3').
RECODE med1_keerperdag_T3 ('2 per dag'='2').
RECODE med1_keerperdag_T3 ('2x'='2').
RECODE med1_keerperdag_T3 ('1xper week'='1').
RECODE med1_aantdagen_T3 ('M.i.v. 27 mei 75 Mg  51x'='90').
RECODE med1_keerperdag_T3 ('1x per dag afgebouwd'='1').
RECODE med1_keerperdag_T3 ('1x per dag'='1').
RECODE med1_keerperdag_T3 ('1x p 2 dagen'='1').
RECODE med1_keerperdag_T3 ('1x'='1').
RECODE med1_keerperdag_T3 ('1-2'='1').
RECODE med1_keerperdag_T3 ('0.1'='1').
RECODE med1_aantdagen_T3 ('92'='90').
RECODE med1_aantdagen_T3 ('91'='90').
RECODE med1_aantdagen_T3 ('90 dagen'='90').
EXECUTE.

DO IF ID_Code=5006.
RECODE med1_keerperdag_T3 ('0.07'='1').
END IF.

DO IF ID_Code=3505.
RECODE med1_dosering_T3 ('X'='halve tablet').
RECODE med1_keerperdag_T3 ('2x halve tablet per week'='2').
RECODE med1_aantdagen_T3 (''='12').
END IF.
EXECUTE.

RECODE med2_keerperdag_T3 ('zo nodig'='1').
RECODE med2_keerperdag_T3 ('3 per maand'='1').
RECODE med2_keerperdag_T3 ('1x per week'='1').
RECODE med2_keerperdag_T3 ('1 per week'='1').
RECODE med2_keerperdag_T3 ('1 p. wk.'='0.14').
RECODE med2_keerperdag_T3 ('1x'='1').
RECODE med2_keerperdag_T3 ('1pd'='1').
RECODE med2_keerperdag_T3 ('1-2'='1').
RECODE med2_keerperdag_T3 ('1 tot een half'='1').
RECODE med2_aantdagen_T3 ('Venlafaxine 37,5 Mg m.i.v. 3 juli  42 dagen'='').
RECODE med2_aantdagen_T3 ('92'='90').
RECODE med2_aantdagen_T3 ('0'='').

DO IF ID_Code=2416.
RECODE med2_aantdagen_T3 (''='12').
RECODE med2_keerperdag_T3 ('1 p. wk.'='1').
END IF.
EXECUTE.

DO IF ID_Code=1914.
RECODE med2_aantdagen_T3 (''='10').
RECODE med2_keerperdag_T3 ('2x per dag 10 dagen'='2').
END IF.
EXECUTE.

RECODE med3_keerperdag_T3 ('3x'='3').
RECODE med3_keerperdag_T3 ('3 per maand'='1').
RECODE med3_keerperdag_T3 ('1x per dag 2 sprays'='1').
RECODE med3_keerperdag_T3 ('1x p d'='1').
RECODE med3_keerperdag_T3 ('1x'='1').
RECODE med3_keerperdag_T3 ('1pd'='1').
RECODE med3_keerperdag_T3 ('1 per 2 weken'='1').
RECODE med3_aantdagen_T3 ('92'='90').
EXECUTE.

RECODE med4_keerperdag_T3 ('3x'='3').
RECODE med4_keerperdag_T3 ('2x'='2').
RECODE med4_keerperdag_T3 ('1x per 3 maanden'='1').
RECODE med4_keerperdag_T3 ('1x p.d.'='1').
RECODE med4_keerperdag_T3 ('1x'='1').
RECODE med4_keerperdag_T3 ('1 keer per week'='1').
RECODE med4_aantdagen_T3 ('92'='90').
EXECUTE.

DO IF ID_Code=1704.
RECODE med4_aantdagen_T3 (''='90').
RECODE med4_keerperdag_T3 ('1pw'='0.14').
RECODE med5_aantdagen_T3 (''='90').
RECODE med5_keerperdag_T3 ('2pw'='0.28').
END IF.
EXECUTE.

RECODE med5_keerperdag_T3 ('4x2'='8').
RECODE med5_keerperdag_T3 ('3-4'='3').
RECODE med5_keerperdag_T3 ('1x'='1').
RECODE med5_keerperdag_T3 (' 1'='1').
RECODE med5_aantdagen_T3 ('92'='90').
EXECUTE.

DO IF ID_Code=5113.
RECODE med5_keerperdag_T3 ('2x p.w'='0.28').
RECODE med5_aantdagen_T3 ('20'='90').
END IF.

RECODE med6_keerperdag_T3 ('zn'='1').
RECODE med6_aantdagen_T3 ('zn'='1').
RECODE med6_keerperdag_T3 ('2x'='2').
RECODE med6_keerperdag_T3 ('1x pd'='1').
RECODE med6_keerperdag_T3 ('1x'='1').
EXECUTE.

RECODE med7_keerperdag_T3 ('zn'='').
RECODE med7_aantdagen_T3 ('zn'='1').
RECODE med7_keerperdag_T3 ('1x pd'='1').
RECODE med7_keerperdag_T3 ('1x'='1').
RECODE med7_keerperdag_T3 ('1 per week'='1').
EXECUTE.

RECODE med8_keerperdag_T3 ('10'='1').
RECODE med8_keerperdag_T3 ('1x90'='1').
RECODE med8_keerperdag_T3 ('1x pd'='1').
EXECUTE.

RECODE med9_keerperdag_T3 ('1xpd'='1').

RECODE med10_keerperdag_T3 ('1xpd'='1').
EXECUTE.

RECODE med2_aantdagen_T3 ('0'='').
RECODE med3_aantdagen_T3 ('0'='').
RECODE med4_aantdagen_T3 ('0'='').
RECODE med5_aantdagen_T3 ('0'='').
RECODE med6_aantdagen_T3 ('0'='').
RECODE med7_aantdagen_T3 ('0'='').
RECODE med8_aantdagen_T3 ('0'='').
RECODE med9_aantdagen_T3 ('0'='').
RECODE med10_aantdagen_T3 ('0'='').
EXECUTE.

ALTER TYPE med1_keerperdag_T3 med2_keerperdag_T3 med3_keerperdag_T3 med4_keerperdag_T3 med5_keerperdag_T3 
    med6_keerperdag_T3 med7_keerperdag_T3 med8_keerperdag_T3 med9_keerperdag_T3 med10_keerperdag_T3 (F3.2).
VARIABLE WIDTH  med1_keerperdag_T3 med2_keerperdag_T3 med3_keerperdag_T3 med4_keerperdag_T3 med5_keerperdag_T3 
    med6_keerperdag_T3 med7_keerperdag_T3 med8_keerperdag_T3 med9_keerperdag_T3 med10_keerperdag_T3 (7).

ALTER TYPE med1_aantdagen_T3 med2_aantdagen_T3 med3_aantdagen_T3 med4_aantdagen_T3 med5_aantdagen_T3 
    med6_aantdagen_T3 med7_aantdagen_T3 med8_aantdagen_T3 med9_aantdagen_T3  med10_aantdagen_T3 (F3.0).
VARIABLE WIDTH  med1_aantdagen_T3 med2_aantdagen_T3 med3_aantdagen_T3 med4_aantdagen_T3 med5_aantdagen_T3 
    med6_aantdagen_T3 med7_aantdagen_T3 med8_aantdagen_T3 med9_aantdagen_T3  med10_aantdagen_T3 (7).


*** Diverse aanpassingen*****************************************************************************************************************************************************.

*** ID 2206. Als vorige keer.
DO IF ID_Code=2206.
RECODE med1_T3 ('als vorige keer'='Metoprololsuccinaat/Hydrochloorthiazide 95/12,5').
RECODE med1_dosering_T3 ('idem'='95/12,5').
RECODE med1_keerperdag_T3 (SYSMIS=1).
RECODE med1_aantdagen_T3 (SYSMIS=90).
RECODE med2_T3 (' '='Eucreas 50/850').
RECODE med2_dosering_T3 (''='50/850').
RECODE med2_keerperdag_T3 (SYSMIS=1).
RECODE med2_aantdagen_T3 (SYSMIS=90).
RECODE med3_T3 (''='Amplodine 10 mg').
RECODE med3_dosering_T3 (''='10 mg').
RECODE med3_keerperdag_T3 (SYSMIS=1).
RECODE med3_aantdagen_T3 (SYSMIS=90).
RECODE med4_T3 (''='Quinaprikl Aurobindo 10 mg').
RECODE med4_dosering_T3 (''='10 mg').
RECODE med4_keerperdag_T3 (SYSMIS=1).
RECODE med4_aantdagen_T3 (SYSMIS=90).
RECODE med5_T3 (''='Atorvastine Ranbaxy 20 mg').
RECODE med5_dosering_T3 (''='20 mg').
RECODE med5_keerperdag_T3 (SYSMIS=1).
RECODE med5_aantdagen_T3 (SYSMIS=90).
RECODE med6_T3 (''='Champis').
RECODE med6_dosering_T3 (''='1').
RECODE med6_keerperdag_T3 (SYSMIS=1).
RECODE med6_aantdagen_T3 (SYSMIS=90).
RECODE med7_T3 (''='Vitamine B-conmplex').
RECODE med7_dosering_T3 (''='1').
RECODE med7_keerperdag_T3 (SYSMIS=1).
RECODE med7_aantdagen_T3 (SYSMIS=90).
RECODE med8_T3 (''='Paracetamol').
RECODE med8_dosering_T3 (''='').
RECODE med8_keerperdag_T3 (SYSMIS=1).
RECODE med8_aantdagen_T3 (SYSMIS=1).
END IF.
EXECUTE.

** ID 3105	ingevuld: telefonisch toegelicht en verder wat losse dingen-->: missing.
DO IF ID_Code=3105.
RECODE med1_T3 ('paracetamol'='').
RECODE med1_dosering_T3 ('telefonisch toegelicht aan Floor van den Brand op 14-06-2017'='').
RECODE med1_keerperdag_T3 (2=SYSMIS).
RECODE med1_vorm_T3 ('pil'=' ').
RECODE med2_T3 ('telefonisch toegelicht aan Floor van den Brand op 14-06-2017' ='').
RECODE med2_dosering_T3 ('telefonisch toegelicht aan Floor van den Brand op 14-06-2017'='').
RECODE med2_keerperdag_T3 (3=SYSMIS).
RECODE med2_vorm_T3 ('pil'=' ').
END IF.
EXECUTE.

** ID 4601 med 1 en 2 zijn voor epilepsie. Vult bij beide in 6x per dag gedurende 60 dagen. Worden echter 1-2d voorgeschreven. Eerdere lijsten geen med. : 1 keer per dag.
DO IF ID_Code=4601.
RECODE med1_keerperdag_T3 (6=1).
RECODE med2_keerperdag_T3 (6=1).
END IF.
EXECUTE.

*** ID 4903. Vult in bij Med1: zie vorige vragen lijst. Overnemen uit T2:.
DO IF ID_Code=4903.
RECODE med1_T3 ('zie vorige invullijst is hetzelfde'='Nortrilen').
RECODE med1_dosering_T3 (''='10mg').
RECODE med1_keerperdag_T3 (SYSMIS=1).
RECODE med1_aantdagen_T3 (SYSMIS=90).
RECODE med2_T3 (' '='Nortrilen').
RECODE med2_dosering_T3 (''='25 mg').
RECODE med2_keerperdag_T3 (SYSMIS=1).
RECODE med2_aantdagen_T3 (SYSMIS=90).
END IF.
EXECUTE.

*** ID 4308. Vult in bij Med1: Zie vorige lijsten. Overnemen uit T2:.
DO IF ID_Code=4308.
RECODE med1_T3 ('zie vorige lijsten'='atorvastitiene 10 mg').
RECODE med1_dosering_T3 (''='10mg').
RECODE med1_keerperdag_T3 (SYSMIS=1).
RECODE med1_aantdagen_T3 (SYSMIS=90).
RECODE med2_T3 (' '='mono- cedocard 25 mg').
RECODE med2_dosering_T3 (''='25 mg').
RECODE med2_keerperdag_T3 (SYSMIS=1).
RECODE med2_aantdagen_T3 (SYSMIS=90).
RECODE med3_T3 (''='metoprolosuccinaat 100').
RECODE med3_dosering_T3 (''='100 mg').
RECODE med3_keerperdag_T3 (SYSMIS=1).
RECODE med3_aantdagen_T3 (SYSMIS=60).
RECODE med4_T3 (''='enalaprilmaleaat 10 mg').
RECODE med4_dosering_T3 (''='10 mg').
RECODE med4_keerperdag_T3 (SYSMIS=1).
RECODE med4_aantdagen_T3 (SYSMIS=60).
RECODE med5_T3 (''='carbasalaatcalciuum 100').
RECODE med5_dosering_T3 (''='100 mg').
RECODE med5_keerperdag_T3 (SYSMIS=1).
RECODE med5_aantdagen_T3 (SYSMIS=60).
RECODE med6_T3 (''='hydrochloorthiazide  25 mg').
RECODE med6_dosering_T3 (''='25 mg').
RECODE med6_keerperdag_T3 (SYSMIS=1).
RECODE med6_aantdagen_T3 (SYSMIS=60).
END IF.
EXECUTE.

*** ID 1506. Vult in bij Med1: Medicatie ongewijzigd zie vorige vragenlijst. Overnemen uit T2:.
DO IF ID_Code=1506.
RECODE med1_T3 ('Medicatie ongewijzigd zie vorige vragenlijst'='Champix').
RECODE med1_dosering_T3 (''='1 mg').
RECODE med1_keerperdag_T3 (SYSMIS=2).
RECODE med1_aantdagen_T3 (SYSMIS=90).
RECODE med2_T3 (''='Perindopril').
RECODE med2_dosering_T3 (''='20mg').
RECODE med2_keerperdag_T3 (SYSMIS=1).
RECODE med2_aantdagen_T3 (SYSMIS=90).
RECODE med3_T3 (''='Metoprololsuccinaat').
RECODE med3_dosering_T3 (''='100 + 50 mg').
RECODE med3_keerperdag_T3 (SYSMIS=1).
RECODE med3_aantdagen_T3 (SYSMIS=90).
RECODE med4_T3 (''='Pantozol').
RECODE med4_dosering_T3 (''='20 mg').
RECODE med4_keerperdag_T3 (SYSMIS=1).
RECODE med4_aantdagen_T3 (SYSMIS=90).
RECODE med5_T3 (''='Lipitor').
RECODE med5_dosering_T3 (''='80 mg').
RECODE med5_keerperdag_T3 (SYSMIS=1).
RECODE med5_aantdagen_T3 (SYSMIS=90).
RECODE med6_T3 (''='carbasalaatcalcium').
RECODE med6_dosering_T3 (''='100 mg').
RECODE med6_keerperdag_T3 (SYSMIS=1).
RECODE med6_aantdagen_T3 (SYSMIS=90).
END IF.
EXECUTE.

*** ID 4904. Vult in bij Med1: kijk naar vorig formulier er is niks veranderd.. Overnemen uit T2:.
DO IF ID_Code=4904.
RECODE med1_T3 ('kijk naar vorig formulier er is niks veranderd.'='Irbesart/hct').
RECODE med1_dosering_T3 (''='300').
RECODE med1_keerperdag_T3 (SYSMIS=1).
RECODE med1_aantdagen_T3 (SYSMIS=90).
RECODE med2_T3 (' '='Atorvastatine 40').
RECODE med2_dosering_T3 (''='40 mg').
RECODE med2_keerperdag_T3 (SYSMIS=1).
RECODE med2_aantdagen_T3 (SYSMIS=90).
RECODE med3_T3 (''='metoprolosuccinaat').
RECODE med3_dosering_T3 (''='50 mg').
RECODE med3_keerperdag_T3 (SYSMIS=1).
RECODE med3_aantdagen_T3 (SYSMIS=90).
RECODE med4_T3 (''='Champix').
RECODE med4_dosering_T3 (''='1 mg').
RECODE med4_keerperdag_T3 (SYSMIS=1).
RECODE med4_aantdagen_T3 (SYSMIS=60).
END IF.
EXECUTE.


*** ID 7102. Vult in bij Med1: totaal 8 medicijnen. Overnemen uit T0:.
DO IF ID_Code=7102.
RECODE med1_T3 ('totaal 8 medicijnen'='Naproxen').
RECODE med1_dosering_T3 (''='500').
RECODE med1_keerperdag_T3 (SYSMIS=2).
RECODE med1_aantdagen_T3 (SYSMIS=60).
RECODE med2_T3 ('voor hart, vaat problemen'='Aspirine').
RECODE med2_dosering_T3 (''='80').
RECODE med2_keerperdag_T3 (SYSMIS=1).
RECODE med2_aantdagen_T3 (SYSMIS=60).
RECODE med3_T3 ('en pijn bestrijding'='Omeprazol').
RECODE med3_dosering_T3 ('2*500mg naproxen'='20').
RECODE med3_keerperdag_T3 (SYSMIS=1).
RECODE med3_aantdagen_T3 (SYSMIS=60).
RECODE med4_T3 (''='Ocipine').
RECODE med4_dosering_T3 (''='10').
RECODE med4_keerperdag_T3 (SYSMIS=1).
RECODE med4_aantdagen_T3 (SYSMIS=60).
RECODE med5_T3 (''='Bisoprololfumaraat').
RECODE med5_dosering_T3 (''='5').
RECODE med5_keerperdag_T3 (SYSMIS=1).
RECODE med5_aantdagen_T3 (SYSMIS=60).
RECODE med6_T3 (''='promocard').
RECODE med6_dosering_T3 (''='30').
RECODE med6_keerperdag_T3 (SYSMIS=1).
RECODE med6_aantdagen_T3 (SYSMIS=60).
RECODE med7_T3 (''='Citalopram').
RECODE med7_dosering_T3 (''='10').
RECODE med7_keerperdag_T3 (SYSMIS=1).
RECODE med7_aantdagen_T3 (SYSMIS=60).
RECODE med8_T3 (''='Crestor').
RECODE med8_dosering_T3 (''='40').
RECODE med8_keerperdag_T3 (SYSMIS=1).
RECODE med8_aantdagen_T3 (SYSMIS=60).
RECODE med9_T3 (''='Ezetrol').
RECODE med9_dosering_T3 (''='10').
RECODE med9_keerperdag_T3 (SYSMIS=1).
RECODE med9_aantdagen_T3 (SYSMIS=60).
RECODE med10_T3 (''='Isordil').
RECODE med10_dosering_T3 (''='5').
RECODE med10_keerperdag_T3 (SYSMIS=1).
RECODE med10_aantdagen_T3 (SYSMIS=60).
END IF.
EXECUTE.
*** aparte syntaxen ATC code, dosering en kosten runnen. 

* Runnen na syntax ATC>.
* Nicotinevervangers (N07BA01) worden uit de medicatie gehaald. Controle of ze bij vraag over nicotinevervangers worden genoemd. Zo nee, daar aanvullen.
* Nicotinevervangers worden niet genoemd bij medicatie op T3.

*** Q87: EHBO********************************************************************************************************************************************.
RENAME VARIABLES Q87=EHBO_T3 / Q87_TEXT=EHBO_aant_keer_T3.
VARIABLE LABELS EHBO_T3 'EHBO ja/nee T2' EHBO_aant_keer_T3 'EHBO aantal keer T2'.
VALUE LABELS EHBO_T3 1 'nee' 2 'ja'.
* aantal keer van string naar numeriek.
* controle op tekst.
FREQUENCIES VARIABLES=EHBO_aant_keer_T3
  /ORDER=ANALYSIS.

RECODE EHBO_aant_keer_T3 ('1x'='1') ('1 keer'='1') .
EXECUTE.
ALTER TYPE EHBO_aant_keer_T3 (F3.0).

* wel naar EHBO en aant keer missing: conservatieve schatting.
DO IF EHBO_T3=2.
RECODE EHBO_aant_keer_T3 (SYSMIS=1).
END IF.
* wel naar EHBO en aant keer =0: conservatieve schatting.
DO IF EHBO_T3=2.
RECODE EHBO_aant_keer_T3 (0=1).
END IF.
EXECUTE.
* niet naar EHBO: aantal keer =0.
DO IF (EHBO_T3=1).
RECODE EHBO_aant_keer_T3 (SYSMIS=0).
END IF.
EXECUTE.
* missings invullen.
RECODE EHBO_T3 (SYSMIS=9).
EXECUTE.
DO IF (EHBO_T3=9).
RECODE EHBO_aant_keer_T3 (SYSMIS=99).
END IF.
EXECUTE.
MISSING VALUES EHBO_T3 (9) EHBO_aant_keer_T3 (99).
VARIABLE LEVEL  EHBO_T3 (NOMINAL) EHBO_aant_keer_T3 (SCALE).
VARIABLE WIDTH  EHBO_T3 (4) EHBO_aant_keer_T3 (9).

*** Q88: ambulance********************************************************************************************************************************************.
RENAME VARIABLES Q88=ambulance_T3 / Q88_TEXT=ambulance_aant_keer_T3.
VARIABLE LABELS ambulance_T3 'ambulance ja/nee T3' ambulance_aant_keer_T3 'ambulance aantal keer T3'.
VALUE LABELS ambulance_T3 1 'nee' 2 'ja'.

* aantal keer van string naar numeriek.
* controle op tekst.
FREQUENCIES VARIABLES=ambulance_aant_keer_T3
  /ORDER=ANALYSIS.

*ID 5112: ja, maar bij aantal keer 'nee'--> ja veranderen in nee.
DO IF ID_code=5112.
RECODE ambulance_T3 (2=1).
RECODE ambulance_aant_keer_T3 ('nee'='0').
END IF.
EXECUTE.

ALTER TYPE ambulance_aant_keer_T3 (F3.0).

* wel ambulance en aant keer =0: conservatieve schatting.
DO IF ambulance_T3=2.
RECODE ambulance_aant_keer_T3 (0=1).
END IF.
* niet ambulance: aantal dagen =0.
DO IF ambulance_T3=1.
RECODE ambulance_aant_keer_T3 (SYSMIS=0).
END IF.
EXECUTE.
* missings invullen.
MISSING VALUES ambulance_aant_keer_T3 (99).
RECODE ambulance_T3 (SYSMIS=9).
EXECUTE.
DO IF (ambulance_T3=9).
RECODE ambulance_aant_keer_T3 (SYSMIS=99).
END IF.
EXECUTE.
MISSING VALUES ambulance_T3 (9) ambulance_aant_keer_T3 (99).
VARIABLE LEVEL ambulance_T3 (NOMINAL) ambulance_aant_keer_T3 (SCALE).
VARIABLE WIDTH  ambulance_T3 (4) ambulance_aant_keer_T3 (9).

*** Q89: poli********************************************************************************************************************************************.
RENAME VARIABLES Q89=poli_T3.
VARIABLE LABELS poli_T3 'bezoek poli: ja/nee T3'.
VALUE LABELS poli_T3 1 'nee' 2 'ja'.
*missing toevoegen.
RECODE poli_T3 (SYSMIS=9).
MISSING VALUES poli_T3 (9).
EXECUTE.

*Q91_1_1_TEXT t/m 6 is excact hetzelfde als Q91_2_1_TEXT t/m 6 (specialisme, inclusief zelfde spelfouten) --> Q91_2 verwijderen.
DELETE VARIABLES  Q91_2_1_TEXT Q91_2_2_TEXT Q91_2_3_TEXT Q91_2_4_TEXT Q91_2_5_TEXT Q91_2_6_TEXT.
RENAME VARIABLES  Q91_1_1_TEXT=specialisme1_T3 /  Q91_1_2_TEXT=specialisme2_T3 /   Q91_1_3_TEXT=specialisme3_T3 / 
  Q91_1_4_TEXT=specialisme4_T3 /   Q91_1_5_TEXT=specialisme5_T3 /   Q91_1_6_TEXT=specialisme6_T3. 
RENAME VARIABLES  Q91_1_1_1_TEXT=ziekenhuis1_T3 / Q91_1_2_1_TEXT=ziekenhuis2_T3 / Q91_1_3_1_TEXT=ziekenhuis3_T3 / 
Q91_1_4_1_TEXT=ziekenhuis4_T3 / Q91_1_5_1_TEXT=ziekenhuis5_T3 / Q91_1_6_1_TEXT=ziekenhuis6_T3. 
RENAME VARIABLES  Q91_2_1_1_TEXT=spec1_aant_keer_T3 / Q91_2_2_1_TEXT=spec2_aant_keer_T3 / Q91_2_3_1_TEXT=spec3_aant_keer_T3 /
Q91_2_4_1_TEXT=spec4_aant_keer_T3/Q91_2_5_1_TEXT=spec5_aant_keer_T3 /Q91_2_6_1_TEXT=spec6_aant_keer_T3 .

VARIABLE LABELS specialisme1_T3 / specialisme2_T3 / specialisme3_T3 / specialisme4_T3 / specialisme5_T3 / specialisme6_T3. 
VARIABLE LABELS ziekenhuis1_T3 / ziekenhuis2_T3 / ziekenhuis3_T3 / ziekenhuis4_T3 / ziekenhuis5_T3 / ziekenhuis6_T3. 
VARIABLE LABELS  spec1_aant_keer_T3 / spec2_aant_keer_T3 / spec3_aant_keer_T3 /  spec4_aant_keer_T3.

** specialisatie hetzelfde noemen.
FREQUENCIES VARIABLES=specialisme1_T3 specialisme2_T3 specialisme3_T3 specialisme4_T3 specialisme5_T3 specialisme6_T3
  /ORDER=ANALYSIS.

RECODE specialisme1_T3 ('cardioloog'='Cardioloog').
RECODE specialisme1_T3 ('chirug'='Chirurg').
RECODE specialisme1_T3 ('chirurg'='Chirurg').
RECODE specialisme1_T3 ('dieetiste'='Diëtiest').
RECODE specialisme1_T3 ('internist'='Internist').
RECODE specialisme1_T3 ('KNO arts'='KNO').
RECODE specialisme1_T3 ('Kno'='KNO').
RECODE specialisme1_T3 ('kno'='KNO').
RECODE specialisme1_T3 ('MDL (maag-, darm- leverarts'='MDL arts').
RECODE specialisme1_T3 ('MDL'='MDL arts').
RECODE specialisme1_T3 ('neuroloog'='Neuroloog').
RECODE specialisme1_T3 ('oogarts'='Oogarts').
RECODE specialisme1_T3 ('Kam orthopeed'='Orthopeed').
RECODE specialisme1_T3 ('Orthopedie'='Orthopeed').
RECODE specialisme1_T3 ('orthopeed'='Orthopeed').
RECODE specialisme1_T3 ('Ortopeeth'='Orthopeed').
RECODE specialisme1_T3 ('Orthopeet'='Orthopeed').
RECODE specialisme1_T3 ('Ortopeed'='Orthopeed').
RECODE specialisme1_T3 ('reumatoloog'='Reumatoloog').
RECODE specialisme1_T3 ('uroloog'='Uroloog').
RECODE specialisme1_T3 ('vaten chirurg'='Vaatchirurg').
EXECUTE.

RECODE specialisme2_T3 ('uroloog'='Uroloog').
RECODE specialisme2_T3 ('rheumatoloog'='Reumatoloog').
RECODE specialisme2_T3 ('revalidatie arts'='Revalidatie arts').
RECODE specialisme2_T3 ('radiotherapeut'='Radiotherapeut').
RECODE specialisme2_T3 ('oogarts'='Oogarts').
RECODE specialisme2_T3 ('neuroloog'='Neuroloog').
RECODE specialisme2_T3 ('Kno arts'='KNO').
RECODE specialisme2_T3 ('kaakchirurg'='Kaakchirurg').
RECODE specialisme2_T3 ('internist'='Internist').
RECODE specialisme2_T3 ('0'='').
EXECUTE.

RECODE specialisme3_T3 ('Orthopaedie'='Orthopeed').
RECODE specialisme3_T3 ('Orthopeet'='Orthopeed').
RECODE specialisme3_T3 ('oogarts'='Oogarts').
RECODE specialisme3_T3 ('neurloloog'='Neuroloog').
RECODE specialisme3_T3 ('arts assistent chirurgie'='Chirurg').
RECODE specialisme3_T3 ('0'='').
EXECUTE.

RECODE specialisme4_T3 ('cardioloog'='Cardioloog').
RECODE specialisme4_T3 ('0'='').
RECODE specialisme5_T3 ('0'='').
EXECUTE.

** Aanpassingen.
*ID 7014: specialisme=spoedeisende hulp arts. Staat ook bij EHBO hier weg.
DO IF ID_Code=7014.
RECODE ziekenhuis1_T3 ('Gelre ziekenhuis Apeldoorn'='').
RECODE specialisme1_T3 ('spoedeisende hulp arts'='').
RECODE spec1_aant_keer_T3 ('1'='').
END IF.
EXECUTE.

*ID 3304: specialisme=Ehbo. Staat ook bij EHBO hier weg.
DO IF ID_Code=3304.
RECODE ziekenhuis2_T3 ('Maasstad'='').
RECODE specialisme2_T3 ('Ehbo'='').
RECODE spec2_aant_keer_T3 ('1'='').
END IF.
EXECUTE.

* ID 1909: specialisme=rontgen. Hoort bij dagbehandeling  hier weg en bij dagbehandeling toevoegen.
DO IF ID_Code=1909.
RECODE ziekenhuis1_T3 ('bravis roosendaal'='').
RECODE specialisme1_T3 ('rontgen'='').
RECODE spec1_aant_keer_T3 ('1'='').
RECODE poli_T3 (2=1).
RECODE Q92 (1=2).
RECODE Q93_1_TEXT (''='rontgen').
RECODE Q94_x1_TEXT (''='1').
END IF.
EXECUTE.

*ID 5308: specialisme=huisarts en POH. Staat al bij consult HA en POH--> hier weg.
DO IF ID_Code=5308.
RECODE ziekenhuis1_T3 ('Praktijk'='').
RECODE specialisme1_T3 ('Huisarts'='').
RECODE spec1_aant_keer_T3 ('1'='').
RECODE ziekenhuis2_T3 ('Praktijk'='').
RECODE specialisme2_T3 ('Huisarts assistente'='').
RECODE spec2_aant_keer_T3 ('1'='').
END IF.
EXECUTE.

* ID 3219: specialisme=Endoscopie. Staat ook bij dagbehandeling  hier weg.
DO IF ID_Code=3219.
RECODE ziekenhuis1_T3 ('Diakonessenhuis'='').
RECODE specialisme1_T3 ('Endoscopie'='').
RECODE spec1_aant_keer_T3 ('1'='').
RECODE poli_T3 (2=1).
END IF.
EXECUTE.

* ID 1916: specialisme=Echo en scan. Staat ook bij dagbehandeling  hier weg.
DO IF ID_Code=1916.
RECODE ziekenhuis3_T3 ('Bravis'='').
RECODE specialisme3_T3 ('Echo en scan'='').
RECODE spec3_aant_keer_T3 ('2'='').
END IF.
EXECUTE.

* ID 2009: specialisme=Diëtiest. Staat al bij consulten --> hier weg.
DO IF ID_Code=2009.
RECODE ziekenhuis1_T3 ('lelystad'='').
RECODE specialisme1_T3 ('Diëtiest'='').
RECODE spec1_aant_keer_T3 ('2'='').
END IF.
EXECUTE.

** 6 is leeg.
DELETE VARIABLES ziekenhuis6_T3  specialisme6_T3 spec6_aant_keer_T3. 

** ziekenhuizen hetzelfde noemen.

RECODE ziekenhuis1_T3  ('avl'='Antonie van Leeuwenhoek').
RECODE ziekenhuis1_T3  ('azm'='AZM').
RECODE ziekenhuis1_T3  ('Azm'='AZM').
RECODE ziekenhuis1_T3  ('MUMC'='AZM').
RECODE ziekenhuis1_T3  ('UMCM'='AZM').
RECODE ziekenhuis1_T3  ('Academische ziekenhuis Maastricht'='AZM').
RECODE ziekenhuis1_T3  ('academisch ziekenhuis maastricht'='AZM').
RECODE ziekenhuis1_T3  ('maastricht'='AZM').
RECODE ziekenhuis1_T3  ('bravis'='Bravis').
RECODE ziekenhuis1_T3  ('Catherine ziekenhuis'='Catharina').
RECODE ziekenhuis1_T3  ('cwz'='Canisius-Wilhelmina').
RECODE ziekenhuis1_T3  ('CWZ'='Canisius-Wilhelmina').
RECODE ziekenhuis1_T3  ('emmen'='Emmen').
RECODE ziekenhuis1_T3  ('sze'='Emmen').
RECODE ziekenhuis1_T3  ('franciscus rotterdam'='Sint Franciscus Gasthuis').
RECODE ziekenhuis1_T3  ('Geleen/Sittard'='Zuyderland').
RECODE ziekenhuis1_T3  ('Sittard'='Zuyderland').
RECODE ziekenhuis1_T3  ('Ikazia/Erasmus MC'='Erasmus').
RECODE ziekenhuis1_T3  ('isala'='Isala').
RECODE ziekenhuis1_T3  ('Isala kliniek'='Isala').
RECODE ziekenhuis1_T3  ('laurentius'='Laurentius').
RECODE ziekenhuis1_T3  ('Laurentius Roermonf'='Laurentius').
RECODE ziekenhuis1_T3  ('Laurentius Ziekenhuis'='Laurentius').
RECODE ziekenhuis1_T3  ('Lumc'='LUMC').
RECODE ziekenhuis1_T3  ('maasstad'='Maasstad').
RECODE ziekenhuis1_T3  ('Noord west ziekenhuis groep'='Noordwest Ziekenhuisgroep').
RECODE ziekenhuis1_T3  ('overpelt'='Overpelt').
RECODE ziekenhuis1_T3  ('radboud'='Radboud').
RECODE ziekenhuis1_T3  ('Umcn'='Radboud').
RECODE ziekenhuis1_T3  ('reinier de graaf'='Reinier de Graaf').
RECODE ziekenhuis1_T3  ('reinier de graaf delft'='Reinier de Graaf').
RECODE ziekenhuis1_T3  ('roermond'='Laurentius').
RECODE ziekenhuis1_T3  ('Sint maarten kliniek'='Sint Maartens kliniek').
RECODE ziekenhuis1_T3  ('St Maartenskliniek'='Sint Maartens kliniek').
RECODE ziekenhuis1_T3  ('SJG Weert'='Sint Jans Gasthuis').
RECODE ziekenhuis1_T3  ('Sj gasthuis'='Sint Jans Gasthuis').
RECODE ziekenhuis1_T3  ('venlo'='VieCuri').
RECODE ziekenhuis1_T3  ('viecuri'='VieCuri').
RECODE ziekenhuis1_T3  ('Viecuri'='VieCuri').
RECODE ziekenhuis1_T3  ('Viecurie'='VieCuri').
RECODE ziekenhuis1_T3  ('weert'='Sint Jans Gasthuis').
RECODE ziekenhuis1_T3  ('Westfries gasthuis'='Westfriesgasthuis').
RECODE ziekenhuis1_T3  ('westfriess gasthuis'='Westfriesgasthuis').
RECODE ziekenhuis1_T3  ('Zuyderland Heerlen'='Zuyderland').
RECODE ziekenhuis1_T3  ('1'='Onbekend').
EXECUTE.

DO IF ID_code=2411.
RECODE ziekenhuis1_T3  (''='Onbekend').
END IF.

RECODE ziekenhuis2_T3  ('Zuyderland Sittard'='Zuyderland').
RECODE ziekenhuis2_T3  ('Ziekenhuis'='Onbekend').
RECODE ziekenhuis2_T3  ('Viecuri'='VieCuri').
RECODE ziekenhuis2_T3  ('viecuri'='VieCuri').
RECODE ziekenhuis2_T3  ('venlo'='VieCuri').
RECODE ziekenhuis2_T3  ('sze'='Emmen').
RECODE ziekenhuis2_T3  ('emmen'='Emmen').
RECODE ziekenhuis2_T3  ('SJG Weert'='Sint Jans Gasthuis').
RECODE ziekenhuis2_T3  ('reinier de graaf'='Reinier de Graaf').
RECODE ziekenhuis2_T3  ('radboud'='Radboud').
RECODE ziekenhuis2_T3  ('overpelt'='Overpelt').
RECODE ziekenhuis2_T3  ('Lumc'='LUMC').
RECODE ziekenhuis2_T3  ('lelystad / emmeloord'='MC Zuiderzee').
RECODE ziekenhuis2_T3  ('Isala kliniek'='Isala').
RECODE ziekenhuis2_T3  ('isala'='Isala').
RECODE ziekenhuis2_T3  ('Heerlen'='Zuyderland').
RECODE ziekenhuis2_T3  ('Gelre ziekenhuis Apeldoorn'='Gelre').
RECODE ziekenhuis2_T3  ('franciscus rotterdam'='Sint Franciscus Gasthuis').
RECODE ziekenhuis2_T3  ('0'='').
EXECUTE.

RECODE ziekenhuis3_T3  ('Ziekenhuis'='Onbekend').
RECODE ziekenhuis3_T3  ('Viecuri'='VieCuri').
RECODE ziekenhuis3_T3  ('SJG Weert'='Sint Jans Gasthuis').
RECODE ziekenhuis3_T3  ('reinier de graaf'='Reinier de Graaf').
RECODE ziekenhuis3_T3  ('radboud'='Radboud').
RECODE ziekenhuis3_T3  ('overpelt'='Overpelt').
RECODE ziekenhuis3_T3  ('mch westeinde'='HMC Westeinde').
RECODE ziekenhuis3_T3  ('Máxima medisch centrum'='Maxima Medisch Centrum').
RECODE ziekenhuis3_T3  ('Heerlen'='Zuyderland').
RECODE ziekenhuis3_T3  ('Gelre ziekenhuis Apeldoorn'='Gelre').
RECODE ziekenhuis3_T3  ('0'='').
EXECUTE.

RECODE ziekenhuis4_T3  ('reinier de graaf'='Reinier de Graaf').
RECODE ziekenhuis4_T3  ('Heerlen'='Zuyderland').
RECODE ziekenhuis4_T3  ('0'='').
EXECUTE.

RECODE ziekenhuis5_T3  ('Heerlen'='Zuyderland').
RECODE ziekenhuis5_T3  ('0'='').
EXECUTE.

** Ziekenhuis algemeen of academisch. 

RECODE ziekenhuis1_T3 ziekenhuis2_T3 ziekenhuis3_T3 ziekenhuis4_T3 ziekenhuis5_T3 (CONVERT) ('onbekend'=2)
('Aken'=1) ('Alrijne'=2) ('AMC Amsterdam'=1) ('Amphia'=2) ('Anthoniushove'=2) ('Antonie van Leeuwenhoek'=2) 
('ASZ'=2) ('AZM'=1) ('Bernhoven'=2) ('Bravis'=2) ('Canisius-Wilhelmina'=2) 
('Catharina'=2) ('CWZ Nijmegen'=2) ('Dekkerswald'=2) ('Deventer'=2)  ('Diakonessenhuis'=2)  ('Diagnosecentrum Lommel'=2) 
('Elisabeth - TweeSteden Ziekehuis'=2) ('Elkerliek'=2) ('Emmen'=2)   ('Erasmus'=1)  ('Franciscus Rotterdam'=2) ('Gelre'=2) ('Haga'=2) ('Helmond'=2)
('Hoofddorp'=2) ('HMC Westeinde'=2) ('IJsselland'=2) ('Ikazia'=2) ('Isala'=2) ('Kampen'=2)
('Langeland'=2) ('Lange Voorhout kliniek'=2) ('Laurentius'=2) ('Linge polikliniek'=2) ('LUMC'=1) ('Maartenskliniek'=2) ('MeanderMC'=2) ('MMC'=2) ('Medisch centum alkmaar'=2) 
('Maas en Kempen Bree'=2) ('Maasstad'=2)  ('Maastricht UMC'=1)  ('Mariaziekenhuis Overpelt'=2)
('MC Zuiderzee'=2) ('MCL'=2) ('Meander'=2) ('Maxima Medisch Centrum'=2) ('Noordwest Ziekenhuisgroep'=2) ('Onbekend'=2)
('Onze Lieve Vrouwe Gasthuis'=2)  ('Overpelt'=2)
('Polikliniek Kampen'=2) ('Poli kanoën'=2) ('Radboud'=1) ('Reinier de Graaf'=2) ('Reinaart Kliniek'=2)
('Rijnstate'=2) ('Scheper'=2) ('Slotervaart'=2) ('SMT Enschede'=2) ('Sophia'=2) ('Spaarne Gasthuis'=2) 
('Spijkenisse MC'=2) ('Stadskanaal'=2) ('St.jans'=2) ('Sint Jans Gasthuis'=2) ('st Anna Geldrop'=2) ('Sint Lucas Andreas'=2)  ('Sint Maartens kliniek '=2) ('Sint Franciscus Gasthuis'=2)
('SZE'=2) ('UMCG'=1) ('UZ Leuven'=1) ('UMC Utrecht'=1) ('Viasana'=2)  ('VieCuri'=2) ('Waterland'=2)
('Weert'=2) ('Westfriesgasthuis'=2) ('Zuyderland'=2) INTO ZH1_type_T3 ZH2_type_T3 ZH3_type_T3 ZH4_type_T3 ZH5_type_T3.
EXECUTE.

FORMATS ZH1_type_T3 ZH2_type_T3 ZH3_type_T3 ZH4_type_T3 ZH5_type_T3 (F1.0).
VARIABLE WIDTH ZH1_type_T3 ZH2_type_T3 ZH3_type_T3 ZH4_type_T3 ZH5_type_T3 (6).
VALUE LABELS ZH1_type_T3 ZH2_type_T3 ZH3_type_T3 ZH4_type_T3 ZH5_type_T3 1  'academisch' 2 'algemeen'.  

** aantal keer van string naar numeriek.
* controle op tekst.

RECODE spec2_aant_keer_T3  ('0'='').
RECODE spec3_aant_keer_T3  ('0'='').
RECODE spec4_aant_keer_T3  ('0'='').
RECODE spec5_aant_keer_T3  ('0'='').
EXECUTE.

ALTER TYPE spec1_aant_keer_T3 spec2_aant_keer_T3 spec3_aant_keer_T3 spec4_aant_keer_T3 spec5_aant_keer_T3 (F2.0).
VARIABLE WIDTH spec1_aant_keer_T3 spec2_aant_keer_T3 spec3_aant_keer_T3 spec4_aant_keer_T3 spec5_aant_keer_T3 (8).
VARIABLE LEVEL spec1_aant_keer_T3 spec2_aant_keer_T3 spec3_aant_keer_T3 spec4_aant_keer_T3 spec5_aant_keer_T3 (SCALE).

*Als het aantal keer missing is wordt het 1 (conservatieve schatting). Komt hier niet voor.

* 2x ja, verder niets ingevuld.
DO IF (ID_code=4509 or ID_code=6505).
RECODE ZH1_type_T3 (SYSMIS=2).
RECODE ziekenhuis1_T3 (''='Onbekend').
RECODE spec1_aant_keer_T3 (SYSMIS=1).
END IF.
EXECUTE.

VARIABLE LEVEL poli_T3 (NOMINAL).


*** Q92: dagbehandeling ***************************************************************************************************************************************.
RENAME VARIABLES Q92=dagbehandeling_T3.
VARIABLE LABELS dagbehandeling_T3 'Dagbehandeling: ja/nee'.
VARIABLE LEVEL dagbehandeling_T3 (NOMINAL).

RENAME VARIABLES Q93_1_TEXT =Dagbehandeling1_T3 / Q93_2_TEXT =Dagbehandeling2_T3 / Q93_3_TEXT=Dagbehandeling3_T3 / Q93_4_TEXT =Dagbehandeling4_T3 / 
Q93_5_TEXT =Dagbehandeling5_T3 / Q93_6_TEXT=Dagbehandeling6_T3.

RENAME VARIABLES Q94_x1_TEXT=Dagbehandeling1_aant_keer_T3 / Q94_x2_TEXT =Dagbehandeling2_aant_keer_T3 / Q94_x3_TEXT =Dagbehandeling3_aant_keer_T3 / 
Q94_x4_TEXT =Dagbehandeling4_aant_keer_T3 / Q94_x5_TEXT =Dagbehandeling5_aant_keer_T3 / Q94_x6_TEXT =Dagbehandeling6_aant_keer_T3.

** aantal keer van string naar numeriek.
ALTER TYPE Dagbehandeling1_aant_keer_T3 Dagbehandeling2_aant_keer_T3 Dagbehandeling3_aant_keer_T3 
    Dagbehandeling4_aant_keer_T3 Dagbehandeling5_aant_keer_T3 Dagbehandeling6_aant_keer_T3 (F2.0).

* missings.
RECODE dagbehandeling_T3 (SYSMIS=9).
EXECUTE.
MISSING VALUES  dagbehandeling_T3 (9).
VARIABLE LEVEL   dagbehandeling_T3 (NOMINAL).
VARIABLE WIDTH   dagbehandeling_T3 (7).

VARIABLE LABELS Dagbehandeling1_T3 / Dagbehandeling2_T3 / Dagbehandeling3_T3 / Dagbehandeling4_T3 / Dagbehandeling5_T3 / Dagbehandeling6_T3 /
Dagbehandeling1_aant_keer_T3 / Dagbehandeling2_aant_keer_T3 / Dagbehandeling3_aant_keer_T3 / 
Dagbehandeling4_aant_keer_T3 / Dagbehandeling5_aant_keer_T3/  Dagbehandeling6_aant_keer_T3.

VARIABLE WIDTH Dagbehandeling1_aant_keer_T3 Dagbehandeling2_aant_keer_T3 Dagbehandeling3_aant_keer_T3 
    Dagbehandeling4_aant_keer_T3 Dagbehandeling5_aant_keer_T3 Dagbehandeling6_aant_keer_T3 (10).
VARIABLE LEVEL Dagbehandeling1_aant_keer_T3 Dagbehandeling2_aant_keer_T3 Dagbehandeling3_aant_keer_T3 
    Dagbehandeling4_aant_keer_T3 Dagbehandeling5_aant_keer_T3 Dagbehandeling6_aant_keer_T3 (SCALE).

***Q121: opnames************************************************************************************************************************************************************************.
RENAME VARIABLES Q95_1_1=opname_ZH_T3 / Q95_3_1_1_TEXT = opname_ZH_aant_dagen_T3 / Q95_2_1_1_TEXT = opname_ZH_aant_keer_T3. 
RENAME VARIABLES Q95_1_2=opname_rev_T3 / Q95_3_2_1_TEXT = opname_rev_aant_dagen_T3 / Q95_2_2_1_TEXT = opname_rev_aant_keer_T3. 
RENAME VARIABLES Q95_1_3=opname_psy_T3 / Q95_3_3_1_TEXT = opname_psy_aant_dagen_T3 / Q95_2_3_1_TEXT = opname_psy_aant_keer_T3.

VARIABLE LABELS opname_ZH_T3 'opname ziekenhuis: ja/nee T3'  opname_ZH_aant_dagen_T3 'opname ziekenhuis aantal dagen T3' 
opname_ZH_aant_keer_T3 'opname ziekenhuis aantal keer T3'
 opname_rev_T3 'opname revalidatie: ja/nee T3'  opname_rev_aant_dagen_T3 'opname revalidatie aantal dagen T3' 
opname_rev_aant_keer_T3 'opname revalidatie aantal keer T3' 
 opname_psy_T3 'opname psychiatrie: ja/nee T3'  opname_psy_aant_dagen_T3 'opname psychiatrie aantal dagen T3' 
opname_psy_aant_keer_T3 'opname psychiatrie aantal keer T3' .

VARIABLE LEVEL opname_ZH_T3 opname_rev_T3 opname_psy_T3 (NOMINAL).

** aantal dagen en aantal keer van string naar numeriek.
* controle tekst.
FREQUENCIES VARIABLES=opname_ZH_aant_dagen_T3 opname_rev_aant_dagen_T3 opname_psy_aant_dagen_T3 
    opname_ZH_aant_keer_T3 opname_rev_aant_keer_T3 opname_psy_aant_keer_T3
  /ORDER=ANALYSIS.

ALTER TYPE opname_ZH_aant_dagen_T3 opname_rev_aant_dagen_T3 opname_psy_aant_dagen_T3 
    opname_ZH_aant_keer_T3 opname_rev_aant_keer_T3 opname_psy_aant_keer_T3 (F3.0).
VARIABLE WIDTH opname_ZH_aant_dagen_T3 opname_rev_aant_dagen_T3 opname_psy_aant_dagen_T3 
    opname_ZH_aant_keer_T3 opname_rev_aant_keer_T3 opname_psy_aant_keer_T3 (11).

* ID 5802, 3707 en 7103 :Ja ingevuld bij alle drie, aantal keer en dagen overal leeg.
IF (ID_code=5802) opname_ZH_T3=2.
IF (ID_code=5802) opname_rev_T3=2.
IF (ID_code=5802) opname_psy_T3=2.
IF (ID_code=3707) opname_ZH_T3=2.
IF (ID_code=3707) opname_rev_T3=2.
IF (ID_code=3707) opname_psy_T3=2.
IF (ID_code=7103) opname_ZH_T3=2.
IF (ID_code=7103) opname_rev_T3=2.
IF (ID_code=7103) opname_psy_T3=2.
EXECUTE.

* opname ZH aantal dagen is missing --> wordt 1 (conservatieve schatting).
IF (ID_code=5816) opname_ZH_aant_dagen_T3=1.
EXECUTE.

** als opname ziekenhuis=ja en andere twee missing--> missing wordt nee.
DO IF (opname_ZH_T3=1).
RECODE  opname_psy_T3 opname_rev_T3 (SYSMIS=2).
END IF.
EXECUTE.

** Als de vragenlijst ‘gefinished’ is de korte lijst is niet ingevuld (daarop staan geen vragen over opnames) , dan is een niet-ingevulde opname (missing) = geen opname (0).
DO IF ( Finished=1 and papier_T3<>2).
RECODE  opname_ZH_T3  opname_rev_T3 opname_psy_T3 (SYSMIS=2).
END IF.
EXECUTE.

** als opname=nee, dan wordt aantal keer en aantal dagen 0=missing.
DO IF (opname_ZH_T3=2).
RECODE  opname_ZH_aant_dagen_T3  opname_ZH_aant_keer_T3 (0=SYSMIS).
END IF.
DO IF (opname_rev_T3=2).
RECODE  opname_rev_aant_dagen_T3  opname_rev_aant_keer_T3 (0=SYSMIS).
END IF.
DO IF (opname_psy_T3=2).
RECODE  opname_psy_aant_dagen_T3  opname_psy_aant_keer_T3 (0=SYSMIS).
END IF.
EXECUTE.

*ID 5308 heeft bij datum overal 00-00-0000.
IF (ID_code=5308) Q95_4_1_1_TEXT='   '.
IF (ID_code=5308) Q95_4_2_1_TEXT='   '.
IF (ID_code=5308) Q95_4_3_1_TEXT='   '.
EXECUTE.

*** Datum omzetten van string naar date.
RECODE Q95_4_1_1_TEXT ('25-04-2017'= '25042017') ('21/9/17'='21092017') ('27-7-2017'='27072017')  ('19-01-2017'='19012017') ('19-6'='19062017') ('31-05-2017'='21052017')
 ('30-05-2017'='30052017')  ('13/10/2016'='13102016') ('19/05/2017'='19052017')  ('13/09/2017'='13092017') ('12/05/2017'='12052017') ('16/8/2017'='16082017')  ('14/07/2017'='14072017').
RECODE Q95_4_2_1_TEXT ('11-05-2017'= '11052017').
EXECUTE.

* Date and Time Wizard: opname_datum.
COMPUTE opname_ZH_datum_T3=date.dmy(number(substr(ltrim(Q95_4_1_1_TEXT),1,2),f2.0), 
    number(substr(ltrim(Q95_4_1_1_TEXT),3,2),f2.0), number(substr(ltrim(Q95_4_1_1_TEXT),5),f4.0)).
VARIABLE LEVEL   opname_ZH_datum_T3 (SCALE).
FORMATS  opname_ZH_datum_T3 (EDATE10).
VARIABLE WIDTH   opname_ZH_datum_T3(10).
EXECUTE.
* hij geeft foutmeldingen maar doet het wel goed.

* Date and Time Wizard: opname_datum.
COMPUTE opname_rev_datum_T3=date.dmy(number(substr(ltrim(Q95_4_2_1_TEXT),1,2),f2.0), 
    number(substr(ltrim(Q95_4_2_1_TEXT),3,2),f2.0), number(substr(ltrim(Q95_4_2_1_TEXT),5),f4.0)).
VARIABLE LEVEL  opname_rev_datum_T3 (SCALE).
FORMATS opname_rev_datum_T3 (EDATE10).
VARIABLE WIDTH  opname_rev_datum_T3(10).
EXECUTE.
* hij geeft foutmeldingen maar doet het wel goed.

RENAME VARIABLES Q95_4_3_1_TEXT = opname_psy_datum_T3.
VARIABLE LABELS  opname_ZH_datum_T3 'opname ziekenhuis datum T3' opname_rev_datum_T3 'opname revalidatie datum T3' opname_psy_datum_T3 'opname psychiatrie datum T3'.


*** opnamedatum moet maximaal 3 maanden (13 weken) voor invuldatum liggen.
* ZH: Date and Time Wizard: d_opnamedatum_invuldatum.
COMPUTE  d_opnamedatum_invuldatum=DATEDIF(opname_ZH_datum_T3, invuldatum_T3, "weeks").
VARIABLE LABELS  d_opnamedatum_invuldatum "verschil opnamedatum en invuldatum in weken".
VARIABLE LEVEL  d_opnamedatum_invuldatum (SCALE).
FORMATS  d_opnamedatum_invuldatum (F5.0).
VARIABLE WIDTH  d_opnamedatum_invuldatum(5).
EXECUTE.
** Er is 1 opname revalidatie:verschil klopt.

**ID 1212	opname 10 weken verschil, maar wordt ook al op T2 genoemd  hier weg.
DO IF ID_code=1212.
RECODE opname_ZH_T3 (1=2).
RECODE opname_ZH_aant_dagen_T3 (6=SYSMIS).
RECODE opname_ZH_aant_keer_T3 (1=SYSMIS).
COMPUTE  opname_ZH_datum_T3 = $SYSMIS.
COMPUTE d_opnamedatum_invuldatum=$SYSMIS.
END IF.
EXECUTE.

** Missings.
RECODE opname_ZH_T3  opname_rev_T3 opname_psy_T3  (SYSMIS=9).
EXECUTE.
MISSING VALUES opname_ZH_T3  opname_rev_T3 opname_psy_T3 (9).


*Q103 en verder: inkomen ****************************************************************************************************************************************************************.
RENAME VARIABLES Q96=netto_inkomen_T3  / Q97= omvang_huishouden_T3 / Q97_TEXT=huishouden_aant_pers_T3/ Q98 = huishouden_aant_kinderen_T3 
/ Q99 = inkomen_rondkomen_T3.
VALUE LABELS omvang_huishouden_T3 1 'een persoon' 2 'meer dan een persoon'.

VARIABLE LABELS huishouden_aant_pers_T3 'aantal personen in huishouden T3'.
VARIABLE LABELS  huishouden_aant_kinderen_T3 'aantal minderjarigen in huishouden T3'.
VARIABLE LABELS  netto_inkomen_T3 'netto gezinsinkomen T3'.
VARIABLE LABELS omvang_huishouden_T3 'een-of meerpersoons huishouden T3'.
VARIABLE LABELS inkomen_rondkomen_T3 'Hoe goed kunt u rondkomen met uw inkomen? T3'.

**huishouden_aant_pers_T3 en huishouden_aant_kinderen_T3 van string naar numeriek.
* controle op tekst.
FREQUENCIES VARIABLES=huishouden_aant_pers_T3 huishouden_aant_kinderen_T3
  /ORDER=ANALYSIS.
RECODE huishouden_aant_pers_T3 ('2 tot 4'='3').
RECODE huishouden_aant_kinderen_T3 ('geen'='0') ('Geen'='0') ('nvt'='0') .
EXECUTE.
ALTER TYPE huishouden_aant_pers_T3 huishouden_aant_kinderen_T3 (F3.0).

**Als omvang_huishouden=1 , dan is aantal personen dus 1 en aantal kinderen 0 (nu missing).
DO IF (omvang_huishouden_T3=1).
RECODE huishouden_aant_pers_T3 (SYSMIS=1).
RECODE huishouden_aant_kinderen_T3 (SYSMIS=0).
END IF.
EXECUTE.

** Als omvang huishouden= meer dan 1 en aantal=1 --> omvang huishouden veranderen in eenpersoons.
DO IF (huishouden_aant_pers_T3=1).
RECODE omvang_huishouden_T3 (2=1).
END IF.
EXECUTE.

** Als omvang huishouden= meer dan 1 en aantal=0 --> omvang huishouden veranderen in eenpersoons en aantal=1.
DO IF (huishouden_aant_pers_T3=0).
RECODE omvang_huishouden_T3 (2=1).
RECODE huishouden_aant_pers_T3 (0=1).
END IF.
EXECUTE.


* berekenen individueel inkomen.
RECODE netto_inkomen_T3 (1=375) (2=875) (3=1125) (4=1375) (5=1750) (6=2250) (7=2750) (8=3250) (9=3750) (10=4250) (11=4750) (12=5250) (13=5750)
INTO netto_inkomen_continu_T3.
COMPUTE ind_inkomen_T3=netto_inkomen_continu_T3/SQRT(huishouden_aant_pers_T3).
VARIABLE LABELS  ind_inkomen_T3 'individueel inkomen T3'.
EXECUTE.

** Missings.
RECODE netto_inkomen_T3 omvang_huishouden_T3 huishouden_aant_pers_T3 huishouden_aant_kinderen_T3 inkomen_rondkomen_T3 (SYSMIS=99).
RECODE netto_inkomen_continu_T3 ind_inkomen_T3 (SYSMIS=9999).
EXECUTE.

MISSING VALUES netto_inkomen_T3 (14,99) omvang_huishouden_T3 huishouden_aant_pers_T3 huishouden_aant_kinderen_T3 (99) inkomen_rondkomen_T3 (7,99)
netto_inkomen_continu_T3 ind_inkomen_T3 (9999).

VARIABLE LEVEL netto_inkomen_T3 inkomen_rondkomen_T3 (ORDINAL) omvang_huishouden_T3 (NOMINAL).

VARIABLE LEVEL netto_inkomen_T3 omvang_huishouden_T3 inkomen_rondkomen_T3 (NOMINAL).
VARIABLE WIDTH netto_inkomen_T3 ind_inkomen_T3 inkomen_rondkomen_T3 (9).

*** Variabelen verwijderen die omgezet zijn naar numeriek.
DELETE VARIABLES Q20   Q56_1_TEXT Q56_2_TEXT  Q59 Q95_4_1_1_TEXT Q95_4_2_1_TEXT.











