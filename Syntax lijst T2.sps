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
RENAME VARIABLES V8= Invuldatum_T2.
VARIABLE LABELS Invuldatum_T2.

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
SELECT IF (V1 ~= 'R_3ecYvMWIMHnOD1H' and V1 ~= 'R_27NmUvUfaDTd29a' and V1 ~= 'R_sZjAU49OJUQUxBn').
EXECUTE.

 *** Toevoegen variabele die aangeeft of vragenlijst op papier is ingevuld.
IF  (ID_code=1508 or ID_code=2010 or ID_code=2012 or ID_code=2013
or ID_code=2103 or ID_code= 2105 or ID_code=2108 or ID_code=2906
or ID_code=3201 or ID_code=3206) papier_T2=2.
IF (ID_code= 2901  or ID_code=2907 or ID_code=3306 or ID_code=3502 or ID_code=3606
or ID_code=4603  or ID_code=4903 or ID_code=4907 or ID_code=4908  or ID_code=4909
or ID_code=4912 or ID_code=4917 or ID_code=4919 or ID_code=6810) papier_T2=1.
EXECUTE.
RECODE papier_T2 (SYSMIS=0).
EXECUTE.
FORMATS papier_T2 (F1.0).
VALUE LABELS papier_T2 0  'digitaal ingevuld' 1 'volledige lijst op papier' 2 'verkorte lijst op papier'.
VARIABLE LABELS papier_T2 'lijst is op papier ingevuld T2' .

** bij invullen op papier wordt automatisch als invuldatum de datum van invoeren op HAG gegenereerd. Dit corrigeren met datum op vragenlijst.

IF (ID_Code=1508) Invuldatum_T2=Date.dmy(14,02,2017).
IF (ID_Code=2010) Invuldatum_T2=Date.dmy(28,02,2017).
IF (ID_Code=2012) Invuldatum_T2=Date.dmy(28,02,2017).
IF (ID_Code=2013) Invuldatum_T2=Date.dmy(28,02,2017).
IF (ID_Code=2103) Invuldatum_T2=Date.dmy(14,03,2017).
IF (ID_Code=2105) Invuldatum_T2=Date.dmy(14,03,2017).
IF (ID_Code=2108) Invuldatum_T2=Date.dmy(20,03,2017).
IF (ID_Code=2901) Invuldatum_T2=Date.dmy(14,03,2017).
IF (ID_Code=2906) Invuldatum_T2=Date.dmy(14,03,2017).
IF (ID_Code=2907) Invuldatum_T2=Date.dmy(14,03,2017).
IF (ID_Code=3201) Invuldatum_T2=Date.dmy(20,04,2017).
IF (ID_Code=3206) Invuldatum_T2=Date.dmy(22,04,2017).
IF (ID_Code=3306) Invuldatum_T2=Date.dmy(16,03,2017).
IF (ID_Code=3502) Invuldatum_T2=Date.dmy(15,05,2017).
IF (ID_Code=3606) Invuldatum_T2=Date.dmy(14,05,2017).
* 4603 datum niet ingevuld: gem van bedrijf 46 aanhouden.
IF (ID_Code=4603) Invuldatum_T2=Date.dmy(10,05,2017).
IF (ID_Code=4903) Invuldatum_T2=Date.dmy(28,06,2017).
IF (ID_Code=4907) Invuldatum_T2=Date.dmy(05,07,2017).
IF (ID_Code=4908) Invuldatum_T2=Date.dmy(05,07,2017).
IF (ID_Code=4909) Invuldatum_T2=Date.dmy(11,07,2017).
IF (ID_Code=4912) Invuldatum_T2=Date.dmy(26,06,2017).
IF (ID_Code=4917) Invuldatum_T2=Date.dmy(05,07,2017).
IF (ID_Code=4919) Invuldatum_T2=Date.dmy(05,07,2017).
* 6810 datum niet ingevuld: gem van bedrijf 68 aanhouden.
IF (ID_Code=6810) Invuldatum_T2=Date.dmy(15,07,2017).
EXECUTE.


** een code is niet volledig ingevuld: 610 moet zijn 6103.
RECODE ID_code (610=6103).
EXECUTE.

** 2 codes zijn verwisseld (echtpaar met zelfde email adres).
RECODE ID_code (2903=2904).
EXECUTE.

*3 lege records: deze verwijderen.
USE ALL.
SELECT IF (ID_Code ne 3008 and  ID_Code ne 3404 and ID_Code ne 7104).
EXECUTE.

*ID 1115: veel rare antwoorden, is voor gebeld, blijkt maar wat te hebben ingevuld.  lijst verwijderen.
USE ALL.
SELECT IF (ID_Code ne 1115).
EXECUTE.

** Enkele variabelen zijn alleen toelichting (voor iedereen 1).
DELETE VARIABLES Q1 Q2 Q20 Q26 Q28 Q32 Q39 Q45 Q51 Q62 Q66 Q67 Q89 Q99.

RENAME VARIABLES V10=Finished.
VARIABLE LEVEL Finished (NOMINAL).

DELETE VARIABLES V1 V2 V7 V9.


*** Deelnemers in analyse selecteren.
*** Bestand mergen met 'deelnemers analyse.sav. Optie 0ne-to-many, Selected look up table = in analyse.sav.
FILTER OFF.
USE ALL.
SELECT IF (in_analyse=1).
EXECUTE.


****************************************************************************************************************************************************************************



*** roken*******************************************************************************************************************************************************************.
RENAME VARIABLES  Q3=gerookt_T2 / Q3_TEXT=gerookt_aant_sig_T2.
VARIABLE LABELS gerookt_T2 'gerookt afgelopen 3 mnd' gerookt_aant_sig_T2 'aant sig gerookt afgelopen 3 mnd'.
VARIABLE LEVEL gerookt_T2 (NOMINAL).

** aant sigaretten van string naar numeriek.
** controle tekst.
FREQUENCIES VARIABLES=gerookt_aant_sig_T2
  /ORDER=ANALYSIS.

** omzetten naar numeriek, eerst div aanpassingen.
RECODE gerookt_aant_sig_T2 ('?'='999').
RECODE gerookt_aant_sig_T2 ('?, alleen op feestjes, en heb net gerookt ivm vakantie en opname van schoonvaders.'='999').
RECODE gerookt_aant_sig_T2 ('te veel'='999').
RECODE gerookt_aant_sig_T2 ('Te veel'='999').
RECODE gerookt_aant_sig_T2 ('10 per dag'='900').
RECODE gerookt_aant_sig_T2 ('15,20'='20').
RECODE gerookt_aant_sig_T2 ('15 p dag'='1350').
RECODE gerookt_aant_sig_T2 ('15 per dag'='1350').
RECODE gerookt_aant_sig_T2 ('15 per dag ongeveer'='1350').
RECODE gerookt_aant_sig_T2 ('10 per dag laatste 2 maanden'='600').
RECODE gerookt_aant_sig_T2 ('1sigaret'='1').
RECODE gerookt_aant_sig_T2 ('? 50'='50').
RECODE gerookt_aant_sig_T2 ('2 per dag'='180').
RECODE gerookt_aant_sig_T2 ('20 per dag / 5 weken'='700').
RECODE gerookt_aant_sig_T2 ('20 per dag'='1800').
RECODE gerookt_aant_sig_T2 ('20 per dag sinds begin juli'='980').
RECODE gerookt_aant_sig_T2 ('3 per dag'='270').
RECODE gerookt_aant_sig_T2 ('4 per dag'='360').
RECODE gerookt_aant_sig_T2 ('4 trekjes van 1 sigaret'='1').
RECODE gerookt_aant_sig_T2 ('40 per dag'='3600').
RECODE gerookt_aant_sig_T2 ('5 per dag'='450').
RECODE gerookt_aant_sig_T2 ('6 per dag'='540').
RECODE gerookt_aant_sig_T2 ('8 per dag'='720').
RECODE gerookt_aant_sig_T2 ('dagelijks ongeveer 10'='900').
RECODE gerookt_aant_sig_T2 ('denk totaal 3 sigaretten'='3').
RECODE gerookt_aant_sig_T2 ('pakje per dag'='1800').
RECODE gerookt_aant_sig_T2 ('1 trekje'='1').
RECODE gerookt_aant_sig_T2 ('dagelijks 10-15'='1080').
RECODE gerookt_aant_sig_T2 ('elke dag'='999').
RECODE gerookt_aant_sig_T2 ('vrijwel dagelijks'='999').
RECODE gerookt_aant_sig_T2 ('Meerdere pakjes'='999').
RECODE gerookt_aant_sig_T2 ('Ongeveer 2 weken een terugval gehad waarbij ik 6 cigaretten heb gerookt'='6').
RECODE gerookt_aant_sig_T2 ('mei 5 sigaretten, vanaf half juni 7 sigartetten ong per dag'='308'). 
RECODE gerookt_aant_sig_T2 ('normaal'='30').
RECODE gerookt_aant_sig_T2 ('terug op het oude niveau'='30').
EXECUTE.

*indien gerookt is ja en aantal sig is niet ingevuld.
DO IF gerookt_T2=2.
RECODE gerookt_aant_sig_T2 (''='99999').
END IF.
EXECUTE.

ALTER TYPE gerookt_aant_sig_T2 (F5.0).

MISSING VALUES gerookt_aant_sig_T2 (99999).
VARIABLE LEVEL gerookt_aant_sig_T2 (SCALE).

RENAME VARIABLES Q4=stoppoging_T2/ Q5=gerookt_7d_T2/ Q6=stoppen_T2.
VARIABLE LABELS stoppoging_T2 'afgelopen 3 mnd stoppoging gedaan T2'.
VARIABLE LABELS gerookt_7d_T2 'afgelopen 7 dagen gerookt T2'.
VARIABLE LABELS stoppen_T2 'voornemen te stoppen T2'.
** stoppoging onlogische codering: hercoderen.
RECODE stoppoging_T2 (4=1) (5=2).
EXECUTE.
VALUE LABELS stoppoging_T2 1 'ja' 2 'nee' 6 'nvt'.
VALUE LABELS gerookt_T2 1 'nee' 2 'ja' 6 'nvt'.

RECODE stoppen_T2 (4=1) (5=2) (6=3) (7=4) (8=5).
EXECUTE.
VALUE LABELS stoppen_T2 1 'binnen nu en een maand' 2 'binnen 6 maanden'  3 'in de toekomst maar niet binnen 6 maanden' 4 'nee,nooit' 5 'weet niet'  6 'nvt'.
VARIABLE LEVEL stoppoging_T2 gerookt_7d_T2 stoppen_T2 (NOMINAL).

* Indien gerookt_7d_T2 nee is, moet  stoppen_T2 (van plan te stoppen) en stoppoging_T2 nvt zijn.
* Nieuwe code 6 �nvt�. 
DO IF  gerookt_7d_T2=2.
RECODE stoppen_T2 (SYSMIS=6).
RECODE stoppoging_T2 (SYSMIS=6).
END IF.
EXECUTE.

RENAME VARIABLES Q7=roken7_T2 / Q8=stoppen1a_T2 / Q9=stoppen2a_T2 / Q10=stoppen3a_T2 / Q11=stoppen1b_T2 / Q12=stoppen2b_T2 / Q13=stoppen3b_T2.
VARIABLE LEVEL roken7_T2 (NOMINAL).

** stoppen1a en b en 3 a en b zijn onlogisch gecodeerd (anders dan bij T0).

RECODE stoppen1b_T2 stoppen2b_T2 stoppen3b_T2 (4=1) (5=2) (6=3) (7=4) (8=5).
EXECUTE.


** Indien afgelopen dagen gerookt (gerookt_7d_T1)=nee de vragen ‘blijvend’ aanhouden, indien afgelopen dagen gerookt=ja de vragen ‘binnen 3 maanden’ aanhouden, 
deze combineren tot 1 variabele.

DO IF gerookt_7d_T2=2.
COMPUTE stoppen1_T2=stoppen1a_T2.
COMPUTE stoppen2_T2=stoppen2a_T2.
COMPUTE stoppen3_T2=stoppen3a_T2.
END IF.
DO IF gerookt_7d_T2=1.
COMPUTE stoppen1_T2=stoppen1b_T2.
COMPUTE stoppen2_T2=stoppen2b_T2.
COMPUTE stoppen3_T2=stoppen3b_T2.
END IF.
EXECUTE.

VALUE LABELS stoppen1_T2  1 'zeer verstandig' 2 'verstandig' 3 'niet verstandig, maar ook niet onverstandig' 4 'onverstandig' 5 'zeer onverstandig'.
VALUE LABELS stoppen2_T2  1 'zeer plezierig' 2 'plezierig' 3 'niet plezierig, maar ook niet onplezierig' 4 'onplezierig' 5 'zeer onplezierig'.
VALUE LABELS stoppen3_T2  1 'zeer positief' 2 'positief' 3 'niet positief, maar ook niet negatief' 4 'negatief' 5 'zeer negatief'.
VARIABLE LABELS stoppen1_T2 'Als u blijvend niet rookt/binnen 3 mnd stopt, is dat verstandig/onverstandig'.
VARIABLE LABELS stoppen2_T2 'Als u blijvend niet rookt/binnen 3 mnd stopt, is dat plezierig/onplezierig'.
VARIABLE LABELS stoppen3_T2 'Als u blijvend niet rookt/binnen 3 mnd stopt, is dat positief/negatief'.
FORMATS stoppen1_T2 stoppen2_T2 stoppen3_T2 (F1.0).
VARIABLE WIDTH stoppen1_T2 stoppen2_T2 stoppen3_T2 (6).

DELETE VARIABLES stoppen1a_T2 stoppen1b_T2 stoppen2a_T2 stoppen2b_T2 stoppen3a_T2 stoppen3b_T2.

RENAME VARIABLES Q14=stoppen4_T2 / Q15=stoppen5_T2 / Q16=stoppen6_T2.
VARIABLE WIDTH stoppen4_T2 stoppen5_T2 stoppen6_T2 (6).

*Indien stoppen4 =1 (nooit), dan moet stoppen5 missing zijn.

USE ALL.
COMPUTE filter_$=(stoppen4_T2=1).
VARIABLE LABELS filter_$ 'stoppen4_T2=1 (FILTER)'.
VALUE LABELS filter_$ 0 'Not Selected' 1 'Selected'.
FORMATS filter_$ (f1.0).
FILTER BY filter_$.
EXECUTE.
FREQUENCIES VARIABLES=stoppen5_T2
  /ORDER=ANALYSIS.
USE ALL.

** deze missing wordt nvt (nieuwe code).
IF  (stoppen4_T2=1) stoppen5_T2=6.
EXECUTE.
VALUE LABELS stoppen5_T2 1 '(bijna) allemaal positief' 2 'meestal positief'  3 'even vaak positief als negatief' 4 'meestal negatief' 5 '(bijna) allemaal negatief' 6 'nvt'. 

RENAME VARIABLES Q17_1=stoppen7a1_T2 /  Q17_2=stoppen7b1_T2 /  Q17_3=stoppen7c1_T2 / Q17_4=stoppen7d1_T2 / Q17_5=stoppen7e1_T2 /
Q18_1=stoppen7a2_T2 /  Q18_2=stoppen7b2_T2 /  Q18_3=stoppen7c2_T2 / Q18_4=stoppen7d2_T2 / Q18_5=stoppen7e2_T2. 


*** Q19: gewicht van string naar numeriek************************************************************************************************************************************************.
* tekst verwijderen, decimaal met komma.
STRING temp1 (A20).
COMPUTE temp1=REPLACE(Q19, 'kg','').
EXECUTE.

STRING temp2 (A20).
COMPUTE temp2=REPLACE(temp1, 'kilogram','').
EXECUTE.

STRING temp3 (A20).
COMPUTE temp3=REPLACE(temp2,'kilo','').
EXECUTE.

STRING temp4 (A20).
COMPUTE temp4=REPLACE(temp3,'?','').
EXECUTE.

STRING temp5 (A20).
COMPUTE temp5=REPLACE(temp4,'plus','').
EXECUTE.

STRING temp6 (A20).
COMPUTE temp6=REPLACE(temp5,'m','').
EXECUTE.

STRING temp7 (A20).
COMPUTE temp7=REPLACE(temp6,'&gt;','').
EXECUTE.

STRING temp8 (A20).
COMPUTE temp8=REPLACE(temp7,'D58','58').
EXECUTE.

STRING temp9 (A20).
COMPUTE temp9=REPLACE(temp8,'geen idee, te zwaar','').
EXECUTE.

STRING temp10 (A20).
COMPUTE temp10=REPLACE(temp9,',','.').
EXECUTE.

*controle.
FREQUENCIES VARIABLES=temp10
  /ORDER=ANALYSIS.

RENAME VARIABLES temp10=gewicht_T2.
ALTER TYPE gewicht_T2 (F3.2).

DELETE VARIABLES temp1 temp2 temp3 temp4 temp5 temp6 temp7 temp8 temp9.

* Controle reeele getallen.
FREQUENCIES gewicht_T2.

** ID2607 7900 kg. Op T1: 80.
DO IF ID_Code=2607 .
RECODE gewicht_T2 (7900=79).
END IF.

** ID 5402 3,5 kg	op T1 82  hier  .
DO IF ID_Code=5402 .
RECODE gewicht_T2 (3.5=9999).
END IF.
EXECUTE.

RECODE gewicht_T2 (SYSMIS=9999).
EXECUTE.
MISSING VALUES gewicht_T2 (9999).
VARIABLE WIDTH gewicht_T2 (7).
VARIABLE LEVEL gewicht_T2 (SCALE).

*** Q21/Q25: EQ5D **************************************************************************************************************************************************************************.
RENAME VARIABLES Q21=EQ5D_1_T2 / Q22=EQ5D_2_T2 / Q23=EQ5D_3_T2 / Q24=EQ5D_4_T2 / Q25=EQ5D_5_T2.
VARIABLE LABELS EQ5D_1_T2 'EQ5D mobiliteit T2' EQ5D_2_T2 'EQ5D zelfzorg T2' 
EQ5D_3_T2 'EQ5D ADL T2' EQ5D_4_T2 'EQ5D pijn/ongemak T2' EQ5D_5_T2 'EQ5D angst/somberheid T2'.

RENAME VARIABLES Q27=EQ5D_VAS_T2.
VARIABLE LABELS EQ5D_VAS_T2 'EQ5D gezondheid T2'.
FORMATS EQ5D_VAS_T2 (F3.0).

* Dutch tariff for EQ-5D-
* Based on the following publication: Versteegh, M. M., Vermeulen, K. M., Evers, S. M., de Wit, G. A., Prenger, R., & Stolk, E. A. (2016). Dutch Tariff for the Five-Level Version of EQ-5D. Value in Health, 2016. doi:10.1016/j.jval.2016.01.003 

COMPUTE EQ5D_T2 = 1.

DO IF (nvalid(EQ5D_1_T2, EQ5D_2_T2, EQ5D_3_T2, EQ5D_4_T2, EQ5D_5_T2) < 5).
RECODE EQ5D_T2 (1 = SYSMIS).
END IF.

IF (max(EQ5D_1_T2, EQ5D_2_T2, EQ5D_3_T2, EQ5D_4_T2, EQ5D_5_T2)>1)EQ5D_T2 = EQ5D_T2 - .0469233.
IF (EQ5D_1_T2 = 2) EQ5D_T2 = EQ5D_T2 - .0354544.
IF (EQ5D_1_T2 = 3) EQ5D_T2 = EQ5D_T2 - .0565962.
IF (EQ5D_1_T2 = 4) EQ5D_T2 = EQ5D_T2 - .166003.
IF (EQ5D_1_T2 = 5) EQ5D_T2 = EQ5D_T2 - .2032975.

IF (EQ5D_2_T2 = 2) EQ5D_T2 = EQ5D_T2 - .0381079.
IF (EQ5D_2_T2 = 3) EQ5D_T2 = EQ5D_T2 - .0605347.
IF (EQ5D_2_T2 = 4) EQ5D_T2 = EQ5D_T2 - .1677852.
IF (EQ5D_2_T2 = 5) EQ5D_T2 = EQ5D_T2 - .1677852.

IF (EQ5D_3_T2 = 2) EQ5D_T2 = EQ5D_T2 - .0391539.
IF (EQ5D_3_T2 = 3) EQ5D_T2 = EQ5D_T2 - .0867559.
IF (EQ5D_3_T2 = 4) EQ5D_T2 = EQ5D_T2 - .1924631.
IF (EQ5D_3_T2 = 5) EQ5D_T2 = EQ5D_T2 - .1924631.

IF (EQ5D_4_T2 = 2) EQ5D_T2 = EQ5D_T2 - .0658959.
IF (EQ5D_4_T2 = 3) EQ5D_T2 = EQ5D_T2 - .0919619.
IF (EQ5D_4_T2 = 4) EQ5D_T2 = EQ5D_T2 - .35993.
IF (EQ5D_4_T2 = 5) EQ5D_T2 = EQ5D_T2 - .4152142.

IF (EQ5D_5_T2 = 2) EQ5D_T2 = EQ5D_T2 - .069622.
IF (EQ5D_5_T2 = 3) EQ5D_T2 = EQ5D_T2 - .1445222.
IF (EQ5D_5_T2 = 4) EQ5D_T2 = EQ5D_T2 - .3563913.
IF (EQ5D_5_T2 = 5) EQ5D_T2 = EQ5D_T2 - .4206361.
EXECUTE.

* missings.
RECODE EQ5D_1_T2 EQ5D_2_T2 EQ5D_3_T2 EQ5D_4_T2 EQ5D_5_T2 EQ5D_T2  (SYSMIS=99).
RECODE EQ5D_VAS_T2  (SYSMIS=999).
EXECUTE.
MISSING VALUES EQ5D_1_T2 EQ5D_2_T2 EQ5D_3_T2 EQ5D_4_T2 EQ5D_5_T2 EQ5D_T2 (99) EQ5D_VAS_T2 (999).
VARIABLE LABELS EQ5D_T2 'EQ5D tot score T2'.
VARIABLE LEVEL  EQ5D_1_T2 EQ5D_2_T2 EQ5D_3_T2 EQ5D_4_T2 EQ5D_5_T2 (ORDINAL).
VARIABLE WIDTH  EQ5D_1_T2 EQ5D_2_T2 EQ5D_3_T2 EQ5D_4_T2 EQ5D_5_T2 (5).

** Q29/30/31: CCQ***************************************************************************************************************************************************************.
RENAME VARIABLES Q29_1=CCQ1_T2 / Q29_2=CCQ2_T2 / Q29_3=CCQ3_T2 / Q29_4=CCQ4_T2 / Q30_1=CCQ5_T2 / Q30_2=CCQ6_T2 / 
Q31_1=CCQ7_T2 / Q31_2=CCQ8_T2 / Q31_3=CCQ9_T2 / Q31_4=CCQ10_T2.
VARIABLE LABELS CCQ1_T2 'CCQ kortademig rust T2' CCQ2_T2 'CCQ kortademig lich inspanning T2' CCQ3_T2 'CCQ angstig/bezorgd T2' CCQ4_T2 'CCQ neerslachtig T2' 
CCQ5_T2 'CCQ gehoest T2' CCQ6_T2 'CCQ slijm opgehoest T2' CCQ7_T2 'CCQ beperkt bij zware lich activiteit T2' CCQ8_T2 'CCQ beperkt bij matige lich activiteit T2' 
CCQ9_T2 'CCQ beperkt bij dagelijkse activiteiten T2' CCQ10_T2 'CCQ beperkt bij sociale activiteiten T2'. 

*** CCQ totaalscores.
'minimum aantal missings??.
COMPUTE CCQ_tot_T2=MEAN(CCQ1_T2,CCQ2_T2,CCQ3_T2,CCQ4_T2,CCQ5_T2,CCQ6_T2,CCQ7_T2,CCQ8_T2,CCQ9_T2, CCQ10_T2).
COMPUTE CCQ_klachten_T2=MEAN(CCQ1_T2,CCQ2_T2,CCQ5_T2,CCQ6_T2).
COMPUTE CCQ_emoties_T2=MEAN(CCQ3_T2,CCQ4_T2).
COMPUTE CCQ_conditie_T2=MEAN(CCQ7_T2,CCQ8_T2,CCQ9_T2, CCQ10_T2).
EXECUTE.

** missings.
RECODE CCQ1_T2 CCQ2_T2 CCQ3_T2 CCQ4_T2 CCQ5_T2 CCQ6_T2 CCQ7_T2 CCQ8_T2 CCQ9_T2 CCQ10_T2 (SYSMIS=99).
RECODE CCQ_tot_T2 CCQ_klachten_T2 CCQ_emoties_T2 CCQ_conditie_T2 (SYSMIS=99).
EXECUTE.
MISSING VALUES CCQ1_T2 CCQ2_T2 CCQ3_T2 CCQ4_T2 CCQ5_T2 CCQ6_T2 CCQ7_T2 CCQ8_T2 CCQ9_T2 CCQ10_T2
 CCQ_tot_T2 CCQ_klachten_T2 CCQ_emoties_T2 CCQ_conditie_T2 (99).
VARIABLE LEVEL CCQ1_T2 CCQ2_T2 CCQ3_T2 CCQ4_T2 CCQ5_T2 CCQ6_T2 CCQ7_T2 CCQ8_T2 CCQ9_T2 CCQ10_T2 (ORDINAL).
VARIABLE WIDTH CCQ1_T2 CCQ2_T2 CCQ3_T2 CCQ4_T2 CCQ5_T2 CCQ6_T2 CCQ7_T2 CCQ8_T2 CCQ9_T2 CCQ10_T2 (4).
VARIABLE WIDTH CCQ_tot_T2 CCQ_klachten_T2 CCQ_emoties_T2 CCQ_conditie_T2 (9).

*** Q33-Q37: aan roken gerelateerde ziektes************************************************************************************************************************************.
RENAME VARIABLES Q33=rokersziektes1a_T2 / Q34=rokersziekte1b_T2 / Q35=rokersziektes2a_T2 /Q36=rokersziekte2b_T2 / Q37=rokersziektes3_T2.
* In de papieren versie staat steeds 1 vraag over ‘blijf roken of weer ga roken’.
*In de elektronische versie is deze opgesplitst naar 2 vragen.
*Samenvoegen naar 1 variabele.
RENAME VARIABLES rokersziektes1a_T2=rokersziektes1_T2.
DO IF SYSMIS(rokersziektes1_T2)=1.
COMPUTE rokersziektes1_T2=rokersziekte1b_T2.
END IF.
RENAME VARIABLES rokersziektes2a_T2=rokersziektes2_T2.
DO IF SYSMIS(rokersziektes2_T2)=1.
COMPUTE rokersziektes2_T2=rokersziekte2b_T2.
END IF.
EXECUTE.
DELETE VARIABLES rokersziekte1b_T2 rokersziekte2b_T2.
VARIABLE LABELS rokersziektes1_T2 'Als ik blijf roken/weer ga roken dan is de kans dat ik hierdoor op een bepaald punt in mijn leven een ziekte krijg T2'/
rokersziektes2_T2 'Als ik blijf roken/weer ga roken ben ik bang om hierdoor op een bepaald punt in mijn leven een ziekte te krijgen T2'/
rokersziektes3_T2 'Ten opzichte van andere ziektes zijn de gevolgen van roken-gerelateerde ziektes:T2 '.

** missings.
RECODE rokersziektes1_T2 rokersziektes2_T2 rokersziektes3_T2 (SYSMIS=99).
MISSING VALUES  rokersziektes1_T2 rokersziektes2_T2 rokersziektes3_T2 (99).
EXECUTE.
VARIABLE WIDTH rokersziektes1_T2 rokersziektes2_T2 rokersziektes3_T2 (5).
VARIABLE LEVEL  rokersziektes1_T2 rokersziektes2_T2 rokersziektes3_T2 (ORDINAL).

***Q38: stress********************************************************************************************************************************************************************.
RENAME VARIABLES Q38_1=stress1_T2 / Q38_2=stress2_T2 / Q38_3=stress3_T2 / Q38_4=stress4_T2 / Q38_5=stress5_T2.
VARIABLE LABELS stress1_T2 'Hoe vaak heeft u het gevoel gehad dat u geen controle had over de belangrijke dingen in uw leven? T2'
stress2_T2 'Hoe vaak heeft u zich er zeker van gevoeld dat u in staat was om persoonlijke problemen aan te kunnen? T2'
stress3_T2 'Hoe vaak heeft u het gevoel gehad dat alles liep zoals u wilde? T2'
stress4_T2 'Hoe vaak heeft u het gevoel gehad dat de problemen zich zo hoog opstapelden dat u ze niet kon overwinnen? T2'
stress5_T2 'Hoe vaak bent u aangeslagen geweest door gebeurtenissen in de wereld? T2'.

** missings.
RECODE stress1_T2 stress2_T2 stress3_T2 stress4_T2 stress5_T2  (SYSMIS=99).
MISSING VALUES stress1_T2 stress2_T2 stress3_T2 stress4_T2 stress5_T2 (99).
EXECUTE.
VARIABLE WIDTH  stress1_T2 stress2_T2 stress3_T2 stress4_T2 stress5_T2 (5).
VARIABLE LEVEL  stress1_T2 stress2_T2 stress3_T2 stress4_T2 stress5_T2 (ORDINAL).

***Q40-Q44: sociale omgeving*************************************************************************************************************************************.
RENAME VARIABLES Q40=soc_omgeving1_T2 /  Q41=soc_omgeving2_T2 /  Q42=soc_omgeving3_T2 /  Q43=soc_omgeving4_T2 /  Q44=soc_omgeving5_T2 . 
** soc_omgeving3 is onlogisch gecodeerd (anders dan bij T1).
RECODE soc_omgeving3_T2 (2=1) (3=2) (4=3) (6=4).
VALUE LABELS soc_omgeving3_T2 1 'veel steun' 2 'niet veel/niet weinig steun' 3 'weinig steun' 4 'weet niet'.
** soc_omgeving5 is onlogisch gecodeerd (anders dan bij T1).
RECODE soc_omgeving5_T2 (4=1) (6=2) (7=3) (10=4).
VALUE LABELS soc_omgeving5_T2 1 'veel steun' 2 'niet veel/niet weinig steun' 3 'weinig steun' 4 'weet niet'.
EXECUTE.

VARIABLE LABELS soc_omgeving1_T2  'Rookt uw partner? T2' /
soc_omgeving2_T2 'Is uw partner in de afgelopen 2 maanden succesvol gestopt met roken? T2' /
soc_omgeving3_T2 'Hoeveel steun heeft u gekregen van uw partner bij het (proberen te) stoppen met roken T2'/
soc_omgeving4_T2 'Hoeveel van de vijf meest nabije vrienden, bekenden of collegas waar u regelmatig tijd mee doorbrengt zijn roker? T2'/
soc_omgeving5_T2 'Hoeveel steun heeft u gekregen van uw vrienden en familieleden bij het (proberen te) stoppen met roken T2'.

RECODE soc_omgeving1_T2 soc_omgeving2_T2 soc_omgeving3_T2 soc_omgeving4_T2 soc_omgeving5_T2 (SYSMIS=99).
EXECUTE.
MISSING VALUES soc_omgeving1_T2 soc_omgeving2_T2 soc_omgeving3_T2 soc_omgeving4_T2 soc_omgeving5_T2 (99).
VARIABLE WIDTH soc_omgeving1_T2 soc_omgeving2_T2 soc_omgeving3_T2 soc_omgeving4_T2 soc_omgeving5_T2 (5).
VARIABLE LEVEL soc_omgeving1_T2 soc_omgeving2_T2 soc_omgeving3_T2 soc_omgeving4_T2 soc_omgeving5_T2 (NOMINAL).

***Q46/Q50: roken op werk******************************************************************************************************************************************************.
RENAME VARIABLES Q46_1=roken_op_werk1_T2 /  Q46_2=roken_op_werk2_T2 / Q46_4=roken_op_werk3_T2 / Q46_5=roken_op_werk4_T2 /
Q47=roken_op_werk5_T2 / Q48=roken_op_werk6_T2 / Q49=soc_omgeving6a_T2 / Q50=soc_omgeving6b_T2.
VARIABLE LABELS roken_op_werk1_T2 'Is het toegestaan om te roken op het werk? T2' 
roken_op_werk2_T2 'Bent u vrij om rookpauzes te nemen wanneer u wilt? T2' 
roken_op_werk3_T2 'Zijn er op het werk speciale rookplekken binnen? T2'
roken_op_werk4_T2 'Zijn er op het werk speciale rookplekken buiten? T2'
roken_op_werk5_T2 'Roken wordt ontmoedigd op het werk T2'
roken_op_werk6_T2 'Op het werk wordt het normaal gevonden dat er collegas roken T2'
soc_omgeving6a_T2 'Hoeveel steun heeft u gekregen van uw collegas die niet meededen aan de stoppen-met-rokencursus T2'
soc_omgeving6b_T2 'Hoeveel steun heeft u gekregen van uw collegas die wel meededen aan de stoppen-met-rokencursus T2'.

* roken_op_werk5_T2 heeft onlogische codering: hercoderen.
RECODE roken_op_werk5_T2 (1=1) (2=2) (3=3) (4=4) (5=5) (7=6).
VALUE LABELS roken_op_werk5_T2 1 'Helemaal mee oneens' 2  'Mee oneens' 3 'Niet mee oneens, niet mee eens' 4  'Mee eens'  5  'Helemaal mee eens' 6 'Weet niet'. 
* soc_omgeving6a_T2 en 6b_T2 heeft onlogische codering: hercoderen.
RECODE  soc_omgeving6a_T2 (2=1) (3=2) (4=3) (6=4).
RECODE  soc_omgeving6b_T2 (2=1) (3=2) (4=3) (6=4).
VALUE LABELS soc_omgeving6a_T2 soc_omgeving6b_T2 1 'veel steun' 2  'niet veel/niet weing steun' 3 'weinig steun' 4  'weet niet' . 
EXECUTE.


* missings.
RECODE roken_op_werk1_T2 roken_op_werk2_T2 roken_op_werk3_T2 roken_op_werk4_T2 roken_op_werk5_T2 roken_op_werk6_T2 soc_omgeving6a_T2 soc_omgeving6b_T2 (SYSMIS=99).
EXECUTE.
MISSING VALUES roken_op_werk1_T2 roken_op_werk2_T2 roken_op_werk3_T2 roken_op_werk4_T2  (99) roken_op_werk5_T2 roken_op_werk6_T2 (6,99)  
soc_omgeving6a_T2 soc_omgeving6b_T2 (4,99).
VARIABLE LEVEL roken_op_werk1_T2 roken_op_werk2_T2 roken_op_werk3_T2 roken_op_werk4_T2  (NOMINAL). 
VARIABLE LEVEL roken_op_werk5_T2 roken_op_werk6_T2 soc_omgeving6a_T2 soc_omgeving6b_T2 (ORDINAL).
VARIABLE WIDTH roken_op_werk1_T2 roken_op_werk2_T2 roken_op_werk3_T2 roken_op_werk4_T2 roken_op_werk5_T2 roken_op_werk6_T2  soc_omgeving6a_T2 soc_omgeving6b_T2 (7).



*** Q52: werkuren*************************************************************************************************************************************************************.
* van string naar numeriek.
FREQUENCIES VARIABLES=Q52
  /ORDER=ANALYSIS.

STRING temp1 (A20).
COMPUTE temp1=REPLACE(Q52, 'uur','').
EXECUTE.

STRING temp2 (A20).
COMPUTE temp2=REPLACE(temp1,'36/40','38').
EXECUTE.

STRING temp3 (A20).
COMPUTE temp3=REPLACE(temp2,'60-70','65').
EXECUTE.

STRING temp4 (A20).
COMPUTE temp4=REPLACE(temp3,',','.').
EXECUTE.

STRING temp5 (A20).
COMPUTE temp5=REPLACE(temp4,'4p','40').
EXECUTE.

*controle.
FREQUENCIES VARIABLES=temp5
  /ORDER=ANALYSIS.

RENAME VARIABLES temp5=werktijd1_T2.
ALTER TYPE werktijd1_T2 (F3.1).

DELETE VARIABLES temp1 temp2 temp3 temp4.

** enkele keren 0 uur ingevuld--> 0 wordt missing.
RECODE werktijd1_T2 (0=SYSMIS).
EXECUTE.

** missings.
RECODE werktijd1_T2 (SYSMIS=999).
EXECUTE.
MISSING VALUES werktijd1_T2 (999).

VARIABLE WIDTH werktijd1_T2 (5).
VARIABLE LEVEL werktijd1_T2 (SCALE).

*** Q53: werkdagen*************************************************************************************************************************************************************.
* van string naar numeriek.
FREQUENCIES VARIABLES=Q53
  /ORDER=ANALYSIS.

RENAME VARIABLES Q53=werktijd2_T2.
ALTER TYPE werktijd2_T2 (F3.1).

VARIABLE LABELS werktijd1_T2 'aantal werkuren per week T2' / werktijd2_T2 'aantal werkdagen per week T2'.

**Aantal werkuur per dag berekenen.

** 7 personen geven uur per dag op ipv tot aantal uur. Aanpassen.
*bij 5 dagen.
DO IF (ID_Code=2605 or ID_Code=2407).
RECODE werktijd1_T2 (8=40) (9=45).
END IF.
* bij 3 dagen.
DO IF (ID_Code=4705).
RECODE werktijd1_T2 (8=24).
END IF.
EXECUTE.

** aanpassingen.
*ID 1914: uur is missing, wordt 16 (zie T1).
DO IF ID_code=1914.
RECODE  werktijd1_T2 (SYSMIS=16).
END IF.
*ID 2904: uur is missing, dagen=1, wordt 24 uur, 3 dagen  (zie T3).
DO IF ID_code=2904.
RECODE  werktijd1_T2 (SYSMIS=24).
RECODE  werktijd2_T2 (1=3).
END IF.
*ID 3508: uur is missing, dagen=1, wordt 35 uur, 5 dagen  (zie T0 en 1).
DO IF ID_code=3508.
RECODE  werktijd1_T2 (SYSMIS=35).
RECODE  werktijd2_T2 (1=5).
END IF.
*ID 4009: uur=1, dagen=1, wordt 38 uur, 3 dagen  (zie T0 en 1).
DO IF ID_code=4009.
RECODE  werktijd1_T2 (1=38).
RECODE  werktijd2_T2 (1=3).
END IF.
*ID 5206: uur=missing, dagen=1, wordt 36 uur, 5 dagen  (zie T0 en 1).
DO IF ID_code=5206.
RECODE  werktijd1_T2 (MISSING=36).
RECODE  werktijd2_T2 (1=5).
END IF.
*ID 5905: uur=1, dagen=1, wordt 32 uur, 4 dagen  (zie T0 en 1).
DO IF ID_code=5905.
RECODE  werktijd1_T2 (1=32).
RECODE  werktijd2_T2 (1=4).
END IF.
*ID 7109: uur=missing, dagen=6, wordt 48 uur (zie T1).
DO IF ID_code=7109.
RECODE  werktijd1_T2 (MISSING=48).
END IF.
EXECUTE.

** missings.
RECODE werktijd2_T2 (SYSMIS=999).
EXECUTE.
MISSING VALUES werktijd2_T2 (999).

COMPUTE werkuur_per_dag_T2=werktijd1_T2 / werktijd2_T2.
EXECUTE.

RECODE werkuur_per_dag_T2 (SYSMIS=999).
EXECUTE.
MISSING VALUES werkuur_per_dag_T2 (999).

VARIABLE WIDTH werktijd1_T2  werktijd2_T2 werkuur_per_dag_T2 (8).
VARIABLE LEVEL werktijd1_T2  werktijd2_T2 werkuur_per_dag_T2 (SCALE).



*Q54/Q55: pauze******************************************************************************************************************************************************************.
*Q54 (aantal pauzes) van string naar numeriek.

FREQUENCIES VARIABLES=Q54
  /ORDER=ANALYSIS.

RENAME VARIABLES Q54=pauzes_aantal_T2.
ALTER TYPE pauzes_aantal_T2 (F3.0).

*Q55_1_TEXT (aant min pauze) van string naar numeriek.
STRING temp1 (A20).
COMPUTE temp1=REPLACE(Q55_1_TEXT,'min','').
EXECUTE.
STRING temp2 (A20).
COMPUTE temp2=REPLACE(temp1,'Nvt','').
EXECUTE.
STRING temp3 (A20).
COMPUTE temp3=REPLACE(temp2,'nvt','').
EXECUTE.
*controle.
FREQUENCIES VARIABLES=temp3
  /ORDER=ANALYSIS.
RENAME VARIABLES temp3=pauzes_minuten_T2.
ALTER TYPE pauzes_minuten_T2 (F3.0).
DELETE VARIABLES temp1 temp2.

*Q55_2_TEXT (aant uren pauze) van string naar numeriek.
STRING temp1 (A20).
COMPUTE temp1=REPLACE(Q55_2_TEXT,',','.').
EXECUTE.
STRING temp2 (A20).
COMPUTE temp2=REPLACE(temp1,'Nvt','').
EXECUTE.
STRING temp3 (A20).
COMPUTE temp3=REPLACE(temp2,'nvt','').
EXECUTE.
string temp4 (A20).
COMPUTE temp4=REPLACE(temp3,'5 uur','5').
EXECUTE.
string temp5 (A20).
COMPUTE temp5=REPLACE(temp4,'half','0.5').
EXECUTE.
string temp6 (A20).
COMPUTE temp6=REPLACE(temp5,'0.5 uur','0.5').
EXECUTE.
string temp7 (A20).
COMPUTE temp7=REPLACE(temp6,'1/2','0.5').
EXECUTE.
string temp8 (A20).
COMPUTE temp8=REPLACE(temp7,'-','0').
EXECUTE.

*controle.
FREQUENCIES VARIABLES=temp8
  /ORDER=ANALYSIS.
RENAME VARIABLES temp8=pauzes_uren_T2.
ALTER TYPE pauzes_uren_T2 (F3.0).
DELETE VARIABLES temp1 temp2 temp3 temp4 temp5 temp6 temp7.

VARIABLE LABELS pauzes_aantal_T2 'aantal pauzes op meest recente werkdag T2' pauzes_minuten_T2 'aantal min pauze T2' pauzes_uren_T2 'aantal uur pauze T2'.
VARIABLE WIDTH pauzes_aantal_T2 pauzes_minuten_T2 pauzes_uren_T2 (5).

** Als wel aantal uur en/of minuten is ingevuld, maar niet aantal keer, dan is aantal keer missing (99).
DO IF  SYSMIS(pauzes_minuten_T2)=0 or SYSMIS(pauzes_uren_T2)=0.
RECODE pauzes_aantal_T2 (SYSMIS=99).
END IF.
EXECUTE.

** als aantal pauzes>0 en aantal minuten is ingevuld en aantal uren niet, dan is aantal uren 0.
DO IF (pauzes_aantal_T2>0 and pauzes_minuten_T2>0).
RECODE pauzes_uren_T2 (SYSMIS=0).
END IF.
EXECUTE.
** als aantal pauzes>0 en aantal uren is ingevuld en aantal min niet, dan is aantal min 0.
DO IF (pauzes_aantal_T2>0 and pauzes_uren_T2>0).
RECODE pauzes_minuten_T2 (SYSMIS=0).
END IF.
EXECUTE.

*CONTROLE: enkele zeer onwaarschijnlijke aantal uren en minuten!!!.

DO IF (pauzes_minuten_T2=90).
RECODE pauzes_uren_T2 (1.5=0).
END IF.
DO IF (pauzes_minuten_T2=60).
RECODE pauzes_uren_T2 (1=0).
END IF.
DO IF (pauzes_minuten_T2=30).
RECODE pauzes_uren_T2 (0.5=0).
END IF.
DO IF (pauzes_minuten_T2=45).
RECODE pauzes_uren_T2 (0.75=0).
END IF.
EXECUTE.

* soms geven deelnemers meerdere pauzes aan met een totale tijd van 5 minuten. Er wordt vanuit gegaan dat ze 5 minuten per pauze bedoelen:.
IF (pauzes_uren_T2=0 and pauzes_minuten_T2=5) pauzes_minuten_T2=(pauzes_minuten_T2*pauzes_aantal_T2).
EXECUTE.

* ingevuld 0 uur, 1 minuten. Is waarschijnlijk andersom.
DO IF (ID_Code=5508 or ID_Code=6007). 
RECODE pauzes_minuten_T2 (1=0).
RECODE pauzes_uren_T2 (0=1).
END IF.
EXECUTE.

* ingevuld 0 uur, 45 minuten. Is waarschijnlijk andersom.
DO IF (ID_Code=6506). 
RECODE pauzes_minuten_T2 (0=45).
RECODE pauzes_uren_T2 (45=0).
END IF.
EXECUTE.

* ingevuld 45 uur, 1 minuten. Is waarschijnlijk andersom.
DO IF (ID_Code=2414). 
RECODE pauzes_minuten_T2 (1=45).
RECODE pauzes_uren_T2 (45=1).
END IF.
EXECUTE.

* ingevuld 5 uur, 1 minuten. Is waarschijnlijk andersom.
DO IF (ID_Code=4607). 
RECODE pauzes_minuten_T2 (1=5).
RECODE pauzes_uren_T2 (5=1).
END IF.
EXECUTE.

* ingevuld 30 min en 30 uur--> wordt 0 uur.
DO IF (ID_Code=4915). 
RECODE pauzes_uren_T2 (30=0).
END IF.
EXECUTE.

* ingevuld 15 uur, 1 minuten. Is waarschijnlijk andersom.
DO IF (ID_Code=7109). 
RECODE pauzes_minuten_T2 (1=15).
RECODE pauzes_uren_T2 (15=1).
END IF.
EXECUTE.

* ingevuld 3012 min, bedoelt 30 min (ook op T0 enT1).
DO IF (ID_Code=2502). 
RECODE pauzes_minuten_T2 (3012=30).
END IF.
EXECUTE.

* ingevuld 20 pauzes--> wordt 2 uur (op T1 3 pauzes).
DO IF (ID_Code=3807). 
RECODE pauzes_aantal_T2 (20=2).
END IF.
EXECUTE.

* ingevuld 25 pauzes-op T1 2 pauzes 20 min  15 wordt 1.
DO IF (ID_Code=1602). 
RECODE pauzes_aantal_T2 (15=1).
END IF.
EXECUTE.

* ingevuld 3 uur, 45 minuten --> missing.
DO IF (ID_Code=2206). 
RECODE pauzes_minuten_T2 (45=SYSMIS).
RECODE pauzes_uren_T2 (3=SYSMIS).
END IF.
EXECUTE.

* ingevuld 5 uur, 30 minuten --> op T1 2 uur 30 min op T0 60 min  tijd missing.
DO IF (ID_Code=2204). 
RECODE pauzes_minuten_T2 (30=SYSMIS).
RECODE pauzes_uren_T2 (5=SYSMIS).
END IF.
EXECUTE.

* ingevuld 5 uur, 30 minuten --> tijd missing.
DO IF (ID_Code=3911). 
RECODE pauzes_minuten_T2 (30=SYSMIS).
RECODE pauzes_uren_T2 (5=SYSMIS).
END IF.
EXECUTE.

* ingevuld 50 uur, 5 minuten --> tijd missing.
DO IF (ID_Code=1907). 
RECODE pauzes_minuten_T2 (5=SYSMIS).
RECODE pauzes_uren_T2 (50=SYSMIS).
END IF.
EXECUTE.

* ingevuld 5 uur, 2 minuten --> op T0 15 min, op T1 30 min  5 uur wordt 0.
DO IF (ID_Code=4808). 
RECODE pauzes_uren_T2 (5=0).
END IF.
EXECUTE.

* ingevuld 1 pauze, 0 uur, 0 minuten --> tijd missing.
DO IF (ID_Code=2904). 
RECODE pauzes_minuten_T2 (0=SYSMIS).
RECODE pauzes_uren_T2 (0=SYSMIS).
END IF.
EXECUTE.

** missings.
RECODE pauzes_aantal_T2 (SYSMIS=99).
RECODE pauzes_uren_T2 pauzes_minuten_T2 (SYSMIS=999).
EXECUTE.
MISSING VALUES pauzes_aantal_T2 (99) pauzes_uren_T2 pauzes_minuten_T2 (999).
VARIABLE LEVEL pauzes_aantal_T2 pauzes_uren_T2 pauzes_minuten_T2 (SCALE).
VARIABLE WIDTH  pauzes_aantal_T2 pauzes_uren_T2 pauzes_minuten_T2 (10).

** Q56 - Q65: ziekteverzuim**************************************************************************************************************************************************************************.

RENAME VARIABLES Q56=ziekteverzuim1_T2 / Q56_TEXT=ziekteverzuim2_T2 / Q57=ziekteverzuim3_T2.
VARIABLE LABELS ziekteverzuim1_T2 'verlof wegens ziekte afgelopen 3 mnd T2' ziekteverzuim2_T2  'aantal dagen verzuim T2' 
ziekteverzuim3_T2 'langer dan 3 maanden verlof wegens ziekte T2'.
VALUE LABELS ziekteverzuim1_T2 1 'nee' 2 'ja'.
VARIABLE WIDTH ziekteverzuim1_T2 ziekteverzuim2_T2 ziekteverzuim3_T2 (9).

* ziekteverzuim2_T2 (aantal dagen) numeriek maken.
FREQUENCIES VARIABLES= ziekteverzuim2_T2
  /ORDER=ANALYSIS.

RECODE ziekteverzuim2_T2 ('1 werkdag'='1') ('24 uur'= '3') ('20?'='20') ('Alle dagen afwezig'='90') ('geen'='1') ('nee'='1') ('0'='1') ('1,5'='1.5') ('vanaf 28-04 100% ziek'='49') 
 ('Ja, ik gen sinds 9 januari niet meer op het werk geweest fanwege een operatie. Komende maandag ga ik weer voor halve dagen aan de slag'='32') 
('90 (3 uur/dag reintegr)'='90') ('100'='90') (ELSE=COPY).
EXECUTE.

ALTER TYPE ziekteverzuim2_T2 (F3.1).

FREQUENCIES VARIABLES= ziekteverzuim2_T2
  /ORDER=ANALYSIS.


*Indien ziekteverzuim1 =1 (nee), dan moet ziekteverzuim2 leeg zijn.
USE ALL.
COMPUTE filter_$=(ziekteverzuim1_T2=1).
VARIABLE LABELS filter_$ 'ziekteverzuim1_T2=1 (FILTER)'.
VALUE LABELS filter_$ 0 'Not Selected' 1 'Selected'.
FORMATS filter_$ (f1.0).
FILTER BY filter_$.
EXECUTE.
FREQUENCIES VARIABLES=ziekteverzuim2_T2
  /ORDER=ANALYSIS.
USE ALL.


*** Langer dan 3 mnd ziek ************************************************************************************************************************************************.

* Q71 van string naar date.
STRING temp1 (A20).
COMPUTE temp1=REPLACE(Q58,'Week5','').
EXECUTE.

STRING  temp2 (A20).
COMPUTE temp2=REPLACE(temp1,'/','-').
EXECUTE.

STRING  temp3 (A20).
COMPUTE temp3=REPLACE(temp2,'.?','').
EXECUTE.

STRING  temp4 (A20).
COMPUTE temp4=REPLACE(temp3,'jan','01').
EXECUTE.

STRING  temp5 (A20).
COMPUTE temp5=REPLACE(temp4,'-5','-05').
EXECUTE.

STRING  temp6 (A20).
COMPUTE temp6=REPLACE(temp5,'3-05','03-05').
EXECUTE.

RENAME VARIABLES (temp6=ziekteverzuim4_T2).
EXECUTE.
VARIABLE LABELS  ziekteverzuim4_T2 'datum ziekmelding T2'.
DELETE VARIABLES  temp1 temp2 temp3 temp4 temp5.

ALTER TYPE ziekteverzuim4_T2 (EDATE10).
EXECUTE.
 

* (datum ziekmelding) moet minimaal 3 maanden (12 weken) voor invuldatum liggen.
* Date and Time Wizard: d_datum_ziekmelding_invuldatum.

COMPUTE  d_datum_ziekmelding_invuldatum_T2=DATEDIF( Invuldatum_T2, ziekteverzuim4_T2, "weeks").
EXECUTE.

VARIABLE LABELS  d_datum_ziekmelding_invuldatum_T2 "verschil in weken invuldatum-ziekmelddatum T2".
VARIABLE LEVEL  d_datum_ziekmelding_invuldatum_T2 (SCALE).
FORMATS  d_datum_ziekmelding_invuldatum_T2 (F5.0).
VARIABLE WIDTH  d_datum_ziekmelding_invuldatum_T2 (5).
EXECUTE.
FREQUENCIES VARIABLES=d_datum_ziekmelding_invuldatum_T2
  /ORDER=ANALYSIS.

** aanpassingen Minder dan 13 weken langdurig weghalen.
IF (ID_code=4508 or ID_code=1107 or ID_code=3808 or ID_code=5110) ziekteverzuim3_T2=1.
IF (ID_code=4508 or ID_code=1107 or ID_code=3808 or ID_code=5110) ziekteverzuim4_T2='   '.
IF (ID_code=4508 or ID_code=1107 or ID_code=3808 or ID_code=5110) d_datum_ziekmelding_invuldatum_T2=$SYSMIS.
EXECUTE.

** 3209	langdurig maar geen datum, op T1 niet ziek. Is 14 dagen ziek geweest, werkt 5 dagen/week waarschijnlijk niet langdurig weghalen.
IF (ID_code=3209) ziekteverzuim3_T2=1.
** 1913	langdurig maar geen datum, op T1 5 d ziek. Is 15 dagen ziek geweest, werkt 5 dagen/week waarschijnlijk niet langdurig weghalen.
IF (ID_code=1913) ziekteverzuim3_T2=1.

* Missing en nvt toevoegen.
DO IF (ziekteverzuim1_T2=1).
RECODE ziekteverzuim2_T2 (SYSMIS=888).
RECODE ziekteverzuim3_T2 (SYSMIS=1).
END IF.
DO IF (ziekteverzuim1_T2=2).
RECODE ziekteverzuim2_T2 (SYSMIS=999).
END IF.
DO IF (ziekteverzuim1_T2=3).
RECODE ziekteverzuim2_T2 (SYSMIS=888).
END IF.
RECODE ziekteverzuim1_T2 (SYSMIS=9).
RECODE ziekteverzuim3_T2 (SYSMIS=9).
DO IF (ziekteverzuim1_T2=9).
RECODE ziekteverzuim2_T2 (SYSMIS=999).
END IF.
EXECUTE.

MISSING VALUES ziekteverzuim1_T2 ziekteverzuim3_T2 (9) ziekteverzuim2_T2 (888,999).
VARIABLE LEVEL ziekteverzuim1_T2 ziekteverzuim3_T2 (NOMINAL) ziekteverzuim2_T2 (SCALE).

* Ziekteverzuim1_T2 (=afgelopen 3 mnd) hercoderen: 1=nee, 2 =ja , 3=langdurig (dus indien ziekteverzuim3_T2=2).
DO IF ziekteverzuim3_T2=2.
RECODE ziekteverzuim1_T2 (2=3).
END IF.
VALUE LABELS ziekteverzuim1_T2 1 'nee' 2 'ja' 3 'langdurig >3 mnd' .
* Indien ziekteverzuim is langdurig: aantal dagen missing maken (is niet van belang, advies Sylvia).
DO IF ziekteverzuim3_T2=2.
COMPUTE  ziekteverzuim2_T2=$SYSMIS.
END IF.
EXECUTE.

*Als afwezig=ja en aantal dagen =0.  Aantal dagen wordt 1 (conservatieve schatting).
DO IF ziekteverzuim1_T2=2.
RECODE ziekteverzuim2_T2 (0=1).
END IF.
EXECUTE.


*** Q59 t/m 61: ziek op het werk************************************************************************************************************************************.
RENAME VARIABLES Q59=ziekteverzuim5_T2 / Q60=ziekteverzuim6_T2 / Q61_1=ziekteverzuim7_T2.
VARIABLE LABELS ziekteverzuim5_T2 'ziek op het werk afgelopen 3 maanden T2' ziekteverzuim6_T2 'ziek op werk: aantal dagen T2'
ziekteverzuim7_T2 'ziek op werk: hoeveel werk verricht T2'.
FORMATS ziekteverzuim6_T2 (F3.0).


*Indien ziekteverzuim5 =1 (nee), dan moeten ziekteverzuim6 en 7  leeg zijn.
USE ALL.
COMPUTE filter_$=(ziekteverzuim5_T2=1).
VARIABLE LABELS filter_$ 'ziekteverzuim5_T0=1 (FILTER)'.
VALUE LABELS filter_$ 0 'Not Selected' 1 'Selected'.
FORMATS filter_$ (f1.0).
FILTER BY filter_$.
EXECUTE.
FREQUENCIES VARIABLES=ziekteverzuim6_T2 ziekteverzuim7_T2
  /ORDER=ANALYSIS.
USE ALL.

* =Indien ziekteverzuim3 (langer dan 3 mnd ziek) ja is, kan ziekteverzuim5 niet ja zijn (want ze hebben niet gewerkt).
CROSSTABS
  /TABLES=ziekteverzuim3_T2 BY ziekteverzuim5_T2
  /FORMAT=AVALUE TABLES
  /CELLS=COUNT
  /COUNT ROUND CELL.

* Komt toch voor: in dat geval 'ziek op werk' verwijderen.

DO IF ID_code=4902 or ID_code=3005 or ID_code=3414 or ID_code=1901 or ID_code=3604.
RECODE ziekteverzuim5_T2 (2=1).
COMPUTE ziekteverzuim6_T2=888.
COMPUTE ziekteverzuim7_T2=888.
END IF.
EXECUTE.

* Indien ziek op werk= ja en aantal dagen=0--> wordt 1 (conservatieve schatting).
DO IF ziekteverzuim5_T2=2.
RECODE ziekteverzuim6_T2 (0=1).
END IF.
EXECUTE.

* 3220: ziek op werk is ja, dagen is missing, werk verricht is 10. Ziek op werk wordt nee.
DO IF  ID_code=3220.
RECODE ziekteverzuim5_T2 (2=1).
RECODE ziekteverzuim7_T2 (11=SYSMIS).
END IF.
EXECUTE.

*1604: ziek op werk is missing, aantal dagen ziek op werk is 0, werk verricht=6? Alles missing.
IF (ID_code=1604) ziekteverzuim6_T2=999.
IF (ID_code=1604) ziekteverzuim7_T2=999.
EXECUTE.

* Controle ziekteverzuim6 (aantal werkdagen).
FREQUENCIES VARIABLES=ziekteverzuim6_T2
  /ORDER=ANALYSIS.

* ziekteverzuim7_T0 rare codering: {1, ik kon op deze dagen niets doen: 0}...tot '11, ik kon net zoveel doen als normaal: 10.
*Hercoderen.
RECODE ziekteverzuim7_T2 (1=0) (2=1) (3=2) (4=3) (5=4) (6=5) (7=6) (8=7) (9=8) (10=9) (11=10).
EXECUTE.
VALUE LABELS ziekteverzuim7_T2.

* Missing en nvt toevoegen.
DO IF (ziekteverzuim5_T2=1).
RECODE ziekteverzuim6_T2 (SYSMIS=888).
RECODE ziekteverzuim7_T2 (SYSMIS=888).
END IF.
DO IF (ziekteverzuim5_T2=2).
RECODE ziekteverzuim6_T2 (SYSMIS=999).
RECODE ziekteverzuim7_T2 (SYSMIS=999).
END IF.
RECODE ziekteverzuim5_T2 (SYSMIS=9).
DO IF (ziekteverzuim5_T2=9).
RECODE ziekteverzuim6_T2 (SYSMIS=999).
RECODE ziekteverzuim7_T2 (SYSMIS=999).
END IF.
EXECUTE.

MISSING VALUES ziekteverzuim5_T2 (9) ziekteverzuim6_T2 ziekteverzuim7_T2 (888,999).



*** Q63 t/m 65: ziek mbt onbetaald werk************************************************************************************************************************************.
RENAME VARIABLES Q63=ziekteverzuim8_T2 / Q64=ziekteverzuim9_T2 / Q65=ziekteverzuim10_T2.
VARIABLE LABELS ziekteverzuim8_T2 'verzuim onbetaald werk T2' ziekteverzuim9_T2 'verzuim onbetaald aantal dagen T2' ziekteverzuim10_T2 'verzuim onbetaald uren vervanging T2'.
FORMATS ziekteverzuim9_T2 (F3.0).

*Indien ziekteverzuim8 =1 (nee), dan moeten ziekteverzuim9 en 10  leeg zijn.
USE ALL.
COMPUTE filter_$=(ziekteverzuim8_T2=1).
VARIABLE LABELS filter_$ 'ziekteverzuim8_T2=1 (FILTER)'.
VALUE LABELS filter_$ 0 'Not Selected' 1 'Selected'.
FORMATS filter_$ (f1.0).
FILTER BY filter_$.
EXECUTE.
FREQUENCIES VARIABLES=ziekteverzuim9_T2 ziekteverzuim10_T2
  /ORDER=ANALYSIS.
USE ALL.

* Controle ziekteverzuim9_T2 (aantal dagen).
FREQUENCIES VARIABLES=ziekteverzuim9_T2
  /ORDER=ANALYSIS.

* Controle ziekteverzuim10_T2 (aantal uur). 
FREQUENCIES VARIABLES=ziekteverzuim10_T2
  /ORDER=ANALYSIS.


** indien ja en aantal uur of aantal dagen = 0 of missing ; veranderen in 1 (conservatieve schatting).
DO IF ziekteverzuim8_T2=2.
RECODE ziekteverzuim9_T2 ziekteverzuim10_T2 (0=1) (SYSMIS=1).
END IF.
EXECUTE.

* aantal onwaarschijnlijk, aanpassen:.
DO IF ID_Code=1107.
RECODE ziekteverzuim10_T2 (340=4).
END IF.
DO IF ID_Code=5105.
RECODE ziekteverzuim10_T2 (120=2).
END IF.
DO IF ID_Code=5802.
RECODE ziekteverzuim10_T2 (80=2).
END IF.
DO IF ID_Code=1306.
RECODE ziekteverzuim10_T2 (75=3).
END IF.
DO IF ID_Code=7102.
RECODE ziekteverzuim10_T2 (60=1).
END IF.
DO IF ID_Code=6404.
RECODE ziekteverzuim10_T2 (60=999).
END IF.
DO IF ID_Code=1512.
RECODE ziekteverzuim10_T2 (52=2).
END IF.
DO IF ID_Code=2512.
RECODE ziekteverzuim10_T2 (50=5).
END IF.
DO IF ID_Code=1116.
RECODE ziekteverzuim10_T2 (40=1.3).
END IF.
DO IF ID_Code=7008.
RECODE ziekteverzuim10_T2 (40=3).
END IF.
DO IF ID_Code=7005.
RECODE ziekteverzuim10_T2 (40=4).
END IF.
DO IF ID_Code=4105.
RECODE ziekteverzuim10_T2 (36=4.5).
END IF.
DO IF ID_Code=6108.
RECODE ziekteverzuim10_T2 (30=2).
END IF.
DO IF ID_Code=5403.
RECODE ziekteverzuim10_T2 (28=2).
END IF.
DO IF ID_Code=5308.
RECODE ziekteverzuim10_T2 (24=0.5).
END IF.
DO IF ID_Code=1901.
RECODE ziekteverzuim10_T2 (20=0.2).
RECODE ziekteverzuim9_T2 (100=90).
END IF.
DO IF ID_Code=6015.
RECODE ziekteverzuim10_T2 (20=0.7).
END IF.
DO IF ID_Code=2504.
RECODE ziekteverzuim10_T2 (20=1.3).
END IF.
DO IF ID_Code=4202.
RECODE ziekteverzuim10_T2 (20=2).
END IF.
DO IF ID_Code=3916.
RECODE ziekteverzuim10_T2 (20=2).
END IF.
DO IF ID_Code=5501.
RECODE ziekteverzuim10_T2 (16=4).
END IF.
DO IF ID_Code=7007.
RECODE ziekteverzuim10_T2 (15=3).
END IF.
DO IF ID_Code=4403.
RECODE ziekteverzuim10_T2 (12=1.2).
END IF.
DO IF ID_Code=3502.
RECODE ziekteverzuim10_T2 (10=0.7).
END IF.
DO IF ID_Code=5312.
RECODE ziekteverzuim10_T2 (10=1).
END IF.
DO IF ID_Code=6411.
RECODE ziekteverzuim10_T2 (10=1).
END IF.
DO IF ID_Code=6009.
RECODE ziekteverzuim10_T2 (10=2).
END IF.
EXECUTE.

* Missing en nvt toevoegen.
DO IF (ziekteverzuim8_T2=1).
RECODE ziekteverzuim9_T2 (SYSMIS=888).
RECODE ziekteverzuim10_T2 (SYSMIS=888).
END IF.
DO IF (ziekteverzuim8_T2=2).
RECODE ziekteverzuim9_T2 (SYSMIS=999).
RECODE ziekteverzuim10_T2 (SYSMIS=999).
END IF.
RECODE ziekteverzuim8_T2 (SYSMIS=9).
DO IF (ziekteverzuim8_T2=9).
RECODE ziekteverzuim9_T2 (SYSMIS=999).
RECODE ziekteverzuim10_T2 (SYSMIS=999).
END IF.
EXECUTE.

MISSING VALUES ziekteverzuim8_T2 (9) ziekteverzuim9_T2 ziekteverzuim10_T2 (888,999).
VARIABLE LEVEL ziekteverzuim1_T2 ziekteverzuim3_T2 ziekteverzuim5_T2 ziekteverzuim8_T2 (NOMINAL).
VARIABLE LEVEL ziekteverzuim2_T2 ziekteverzuim4_T2 ziekteverzuim6_T2 ziekteverzuim7_T2  ziekteverzuim9_T2   ziekteverzuim10_T2 (SCALE).

*** Q68_1 t/m _14 ******************************************************************************************************************************************************.
RENAME VARIABLES Q68_1_TEXT=consult1_T2 / Q68_2_TEXT=consult2_T2 /  Q68_3_TEXT=consult3_T2 /  Q68_4_TEXT=consult4_T2 /  Q68_5_TEXT=consult5_T2 /  Q68_6_TEXT=consult6_T2 / 
 Q68_7_TEXT=consult7_T2 /  Q68_8_TEXT=consult8_T2 /  Q68_9_TEXT=consult9_T2 /  Q68_10_TEXT=consult10_T2 /  Q68_11_TEXT=consult11_T2 /  Q68_12_TEXT=consult12_T2 / 
 Q68_13_TEXT=consult13_T2 /  Q68_14_TEXT=consult14_T2 .

VARIABLE LABELS consult1_T2 'consult HA T2' 
consult2_T2 'consult POH T2' 
consult3_T2 'consult maatsch. werker T2' 
consult4_T2 'consult bedrijfsarts T2'
consult5_T2 'consult ergotherapeut T2' 
consult6_T2 'consult dietist T2' 
consult7_T2 'consult stoppen met roken begeleider T2'  
consult8_T2 'consult tandarts T2' 
consult9_T2 'consult logopedist T2' 
consult10_T2 'consult homeopaat etc T2'
consult11_T2 'consult fysio etc T2' 
consult12_T2 'consult psycholoog etc T2'  
consult13_T2 'consult huidtherapeut/mondhygienist T2' 
consult14_T2 'consult manicure/pedicure T2'. 

* van string naar numeriek. Controle.
FREQUENCIES VARIABLES=consult1_T2 consult2_T2 consult3_T2 consult4_T2 consult5_T2 consult6_T2 
    consult7_T2 consult8_T2 consult9_T2 consult10_T2 consult11_T2 consult12_T2 consult13_T2 consult14_T2    
  /ORDER=ANALYSIS.

RECODE consult7_T2 ('?'='1') ('01'='1') ('6?'='6') ('8?'='8').
EXECUTE.

ALTER TYPE consult1_T2 to consult14_T2 (F2.0).

** Als er minimaal 1 is ingevuld en de rest missing, zijn die missings 0 (geen consult).
DO IF (NVALID(consult1_T2,consult2_T2,consult3_T2,consult4_T2,consult5_T2,consult6_T2,consult7_T2,
    consult8_T2,consult9_T2,consult10_T2,consult11_T2,consult12_T2,consult13_T2,consult14_T2)>=1).
RECODE consult1_T2 consult2_T2 consult3_T2 consult4_T2 consult5_T2 consult6_T2 consult7_T2 consult8_T2 consult9_T2 
    consult10_T2 consult11_T2 consult12_T2 consult13_T2 consult14_T2 (SYSMIS=0).
END IF.
EXECUTE.

** Als er helemaal niets is ingevuld, maar de vragenlijst is wel  'gefinished', dan zijn de missings 0 (geen consult).
DO IF (NVALID(consult1_T2,consult2_T2,consult3_T2,consult4_T2,consult5_T2,consult6_T2,consult7_T2,
    consult8_T2,consult9_T2,consult10_T2,consult11_T2,consult12_T2,consult13_T2,consult14_T2)=0 and  Finished=1).
RECODE consult1_T2 consult2_T2 consult3_T2 consult4_T2 consult5_T2 consult6_T2 consult7_T2 consult8_T2 consult9_T2 
    consult10_T2 consult11_T2 consult12_T2 consult13_T2 consult14_T2 (SYSMIS=0).
END IF.
EXECUTE.

** Als er helemaal niets is ingevuld, en de vragenlijst is niet  'gefinished', dan zijn de missings 999 (echt missing).
DO IF (NVALID(consult1_T2,consult2_T2,consult3_T2,consult4_T2,consult5_T2,consult6_T2,consult7_T2,
    consult8_T2,consult9_T2,consult10_T2,consult11_T2,consult12_T2,consult13_T2,consult14_T2)=0 and  Finished=0).
RECODE consult1_T2 consult2_T2 consult3_T2 consult4_T2 consult5_T2 consult6_T2 consult7_T2 consult8_T2 consult9_T2 
    consult10_T2 consult11_T2 consult12_T2 consult13_T2 consult14_T2 (SYSMIS=999).
END IF.
EXECUTE.

**Indien de verkorte vragenlijst is ingevuld , is alleen consult 7 (stoppen met roken begeleider) ingevuld. Rest wordt missing.
DO IF (papier_T2=2).
RECODE consult1_T2 consult2_T2 consult3_T2 consult4_T2 consult5_T2 consult6_T2 consult8_T2 consult9_T2 
    consult10_T2 consult11_T2 consult12_T2 consult13_T2 consult14_T2 (0=999).
END IF.
EXECUTE.

MISSING VALUES consult1_T2 consult2_T2 consult3_T2 consult4_T2 consult5_T2 consult6_T2 consult7_T2 consult8_T2 consult9_T2 
    consult10_T2 consult11_T2 consult12_T2 consult13_T2 consult14_T2 (999).

VARIABLE WIDTH consult1_T2 consult2_T2 consult3_T2 consult4_T2 consult5_T2 consult6_T2 consult7_T2 consult8_T2 consult9_T2 
    consult10_T2 consult11_T2 consult12_T2 consult13_T2 consult14_T2 (6).


*** Q69-Q72 Thuiszorg *******************************************************************************************************************************************************.
RENAME VARIABLES Q69=thuiszorg_T2 / Q70_1=thuiszorg_hh_T2 / Q70_2=thuiszorg_verzorging_T2 / Q70_3=thuiszorg_verpleging_T2 / 
Q71_X1_TEXT=thuiszorg_hh_weken_T2 / Q71_X2_TEXT=thuiszorg_verzorging_weken_T2 / Q71_X3_TEXT=thuiszorg_verpleging_weken_T2 / 
Q72_X1_TEXT=thuiszorg_hh_uur_T2 / Q72_X2_TEXT=thuiszorg_verzorging_uur_T2 / Q72_X3_TEXT=thuiszorg_verpleging_uur_T2. 

VARIABLE LABELS thuiszorg_T2 'thuiszorg ja/nee T2'
thuiszorg_hh_T2 'thuiszorg huishouden ja/nee T2'
thuiszorg_verzorging_T2 'thuiszorg verzorging ja/nee T2'
thuiszorg_verpleging_T2 'thuiszorg verpleging ja/nee T2'
thuiszorg_hh_weken_T2 'thuiszorg huishouden aant weken T2'
thuiszorg_verzorging_weken_T2 'thuiszorg verzorging aant weken T2'
thuiszorg_verpleging_weken_T2  'thuiszorg verpleging aant weken T2'
thuiszorg_hh_uur_T2 'thuiszorg huishouden aant uur/wk T2'
thuiszorg_verzorging_uur_T2 'thuiszorg verzorging aant uur/wk T2'
thuiszorg_verpleging_uur_T2 'thuiszorg verpleging aant uur/wk T2'. 

*Indien thuiszorg_T0 =1 (nee), dan moeten thuiszorg_hh_T0, thuiszorg_verzorging_T0 en thuiszorg_verpleging_T0 sysmis zijn.
USE ALL.
COMPUTE filter_$=( thuiszorg_T2=1).
VARIABLE LABELS filter_$ ' thuiszorg_T2=1 (FILTER)'.
VALUE LABELS filter_$ 0 'Not Selected' 1 'Selected'.
FORMATS filter_$ (f1.0).
FILTER BY filter_$.
EXECUTE.
FREQUENCIES VARIABLES= thuiszorg_hh_T2 thuiszorg_verzorging_T2 thuiszorg_verpleging_T2 
  /ORDER=ANALYSIS.
USE ALL.

** ID 2013 en 2105 hebben korte lijst ingevuld, dus geen vragenover thuiszorg. Invoerfout: thuiszorg ja/nee is ingevoerd als nee, moet sysmis zijn.
DO IF ID_code=2013 or ID_code=2105.
RECODE thuiszorg_T2 (1=SYSMIS).
END IF.

* visueel in database nakijken: als thuiszorg_T2 ergens 2 is, dan moet er ook wat staan bij de bijbehorende weken en uren. (descending sorteren op thuiszorg_T0)
*4305: thuiszorg=ja, geen vorm en geen uren ingevuld? = niet ziek geweest, thuiszorg_T2 wordt nee.
IF (ID_code=4305) thuiszorg_T2=1.
EXECUTE.

* 2904 52 weken hulp: kan max 13 weken zijn.
IF (ID_code=2904) thuiszorg_hh_weken_T2='13'.
EXECUTE.

* controle of er geen tekst is ingevuld.
FREQUENCIES VARIABLES=thuiszorg_hh_weken_T2 thuiszorg_verzorging_weken_T2 thuiszorg_verpleging_weken_T2  
thuiszorg_hh_uur_T2 thuiszorg_verzorging_uur_T2 thuiszorg_verpleging_uur_T2 
  /ORDER=ANALYSIS.

* omzetten string naar numeriek.
ALTER TYPE thuiszorg_hh_weken_T2 thuiszorg_verzorging_weken_T2 thuiszorg_verpleging_weken_T2  (F2.0).
ALTER TYPE thuiszorg_hh_uur_T2 thuiszorg_verzorging_uur_T2 thuiszorg_verpleging_uur_T2 (F3.1).

VARIABLE WIDTH thuiszorg_hh_weken_T2 thuiszorg_verzorging_weken_T2 thuiszorg_verpleging_weken_T2  
thuiszorg_hh_uur_T2 thuiszorg_verzorging_uur_T2 thuiszorg_verpleging_uur_T2 (8).

VARIABLE LEVEL  thuiszorg_T2 thuiszorg_hh_T2 thuiszorg_verzorging_T2 thuiszorg_verpleging_T2 (NOMINAL).
VARIABLE LEVEL  thuiszorg_hh_weken_T2 thuiszorg_verzorging_weken_T2 thuiszorg_verpleging_weken_T2  
thuiszorg_hh_uur_T2 thuiszorg_verzorging_uur_T2 thuiszorg_verpleging_uur_T2 (SCALE).


**Indien thuiszorg_T2 =1 (nee), rest hercoderen naar 0.
DO IF thuiszorg_T2=1.
RECODE thuiszorg_hh_weken_T2 thuiszorg_verzorging_weken_T2 thuiszorg_verpleging_weken_T2
 thuiszorg_hh_uur_T2 thuiszorg_verzorging_uur_T2 thuiszorg_verpleging_uur_T2 (SYSMIS=0).
END IF.
DO IF SYSMIS(thuiszorg_hh_T2) =1 and thuiszorg_T2=2.
RECODE thuiszorg_hh_T2 thuiszorg_hh_weken_T2  thuiszorg_hh_uur_T2 (SYSMIS=0).
END IF.
DO IF SYSMIS(thuiszorg_verzorging_T2)=1  and thuiszorg_T2=2.
RECODE thuiszorg_verzorging_T2 thuiszorg_verzorging_weken_T2  thuiszorg_verzorging_uur_T2 (SYSMIS=0).
END IF.
DO IF SYSMIS(thuiszorg_verpleging_T2)=1  and thuiszorg_T2=2.
RECODE thuiszorg_verpleging_T2 thuiszorg_verpleging_weken_T2  thuiszorg_verpleging_uur_T2 (SYSMIS=0).
END IF.
DO IF thuiszorg_T2=1.
RECODE thuiszorg_hh_T2 thuiszorg_verzorging_T2 thuiszorg_verpleging_T2  (SYSMIS=0).
END IF.
EXECUTE. 

** missings toevoegen.
RECODE thuiszorg_T2 (SYSMIS=9).
DO IF (thuiszorg_T2 =9).
RECODE thuiszorg_hh_T2 thuiszorg_verzorging_T2 thuiszorg_verpleging_T2  (SYSMIS=9).
RECODE  thuiszorg_hh_weken_T2 thuiszorg_verzorging_weken_T2 thuiszorg_verpleging_weken_T2
 thuiszorg_hh_uur_T2 thuiszorg_verzorging_uur_T2 thuiszorg_verpleging_uur_T2 (SYSMIS=999).
END IF.
EXECUTE.

MISSING VALUES  thuiszorg_T2 thuiszorg_hh_T2 thuiszorg_verzorging_T2 thuiszorg_verpleging_T2  (9)
thuiszorg_hh_weken_T2 thuiszorg_verzorging_weken_T2 thuiszorg_verpleging_weken_T2
 thuiszorg_hh_uur_T2 thuiszorg_verzorging_uur_T2 thuiszorg_verpleging_uur_T2 (999).

*** Q87: gebruik nicotinevervangers afgelopen 3 mnd ****************************************************************************************************************************.

RENAME VARIABLES Q73=nicotinevervangers_T2 / Q74_1=nicotinepleisters_T2 / Q74_2=nicotinekauwgom_T2 / Q74_3=nicotine_microtabs_T2 / Q74_4=nicotine_zuigtabletten_T2 /
Q74_5=nicotine_mondspray_T2 / Q74_6=nicotine_inhaler_T2 / Q74_7=nicotine_anders_T2 / Q74_7_TEXT=nicotine_anders_nl_T2. 

VARIABLE LABELS nicotinevervangers_T2 'nicotinevervangers: ja/nee T2' /
nicotinepleisters_T2 'nicotinevervangers: pleister ja/nee T2' /
nicotinekauwgom_T2 'nicotinevervangers: kauwgom ja/nee T2' /
nicotine_microtabs_T2 'nicotinevervangers: microtabs ja/nee T2' /
nicotine_zuigtabletten_T2  'nicotinevervangers: zuigtabletten ja/nee T2' /
nicotine_mondspray_T2 'nicotinevervangers: mondspray ja/nee T2' /
nicotine_inhaler_T2 'nicotinevervangers: inhaler ja/nee T2' /
nicotine_anders_T2 'nicotinevervangers: anders ja/nee T2' /
nicotine_anders_nl_T2 'nicotinevervangers: anders nl. T2'.

VALUE LABELS nicotinevervangers_T2 2 'ja' 1 'nee' /nicotinepleisters_T2 nicotinekauwgom_T2 nicotine_microtabs_T2 nicotine_zuigtabletten_T2 
nicotine_mondspray_T2 nicotine_inhaler_T2 nicotine_anders_T2  0 'nee'1 'ja'.

** Nicotinevervangers ja, verder niets ingevuld.
DO IF (ID_code=4917).
RECODE nicotinepleisters_T2 (SYSMIS=9).
RECODE nicotinekauwgom_T2 (SYSMIS=9).
RECODE nicotine_microtabs_T2 (SYSMIS=9).
RECODE nicotine_zuigtabletten_T2 (SYSMIS=9).
RECODE nicotine_mondspray_T2 (SYSMIS=9).
RECODE nicotine_inhaler_T2 (SYSMIS=9).
RECODE nicotine_anders_T2 (SYSMIS=9).
END IF.
EXECUTE.

* Indien nicotinevervangers_T2 niet missing is, moeten de verschillende soorten missings 0 zijn.
DO IF (nicotinevervangers_T2=1 or nicotinevervangers_T2=2).
RECODE nicotinepleisters_T2 nicotinekauwgom_T2 nicotine_microtabs_T2 nicotine_zuigtabletten_T2 nicotine_mondspray_T2 nicotine_inhaler_T2 nicotine_anders_T2 (SYSMIS=0).
END IF.
EXECUTE.

* missing toevoegen (rest van sysmis is missing).
RECODE nicotinevervangers_T2 nicotinepleisters_T2 nicotinekauwgom_T2 nicotine_microtabs_T2 nicotine_zuigtabletten_T2 nicotine_mondspray_T2 nicotine_inhaler_T2 
nicotine_anders_T2 (SYSMIS=9).
MISSING VALUES nicotinevervangers_T2 nicotinepleisters_T2 nicotinekauwgom_T2 nicotine_microtabs_T2 nicotine_zuigtabletten_T2 nicotine_mondspray_T2 nicotine_inhaler_T2 
nicotine_anders_T2 (9).
EXECUTE.

RENAME VARIABLES Q75_x1_TEXT=nicotinepleisters_stuks_T2 / Q75_x2_TEXT=nicotinekauwgom_stuks_T2 / Q75_x3_TEXT=nicotine_microtabs_stuks_T2 / 
Q75_x4_TEXT=nicotine_zuigtabletten_stuks_T2 / Q75_x5_TEXT=nicotine_mondspray_keer_T2 / Q75_x6_TEXT=nicotine_inhaler_keer_T2 / Q75_x7_TEXT=nicotine_anders_stuks_T2 / 
Q76_x1_TEXT=nicotinepleisters_dagen_T2 / Q76_x2_TEXT=nicotinekauwgom_dagen_T2 / Q76_x3_TEXT=nicotine_microtabs_dagen_T2 / 
Q76_x4_TEXT=nicotine_zuigtabletten_dagen_T2 / Q76_x5_TEXT=nicotine_mondspray_dagen_T2 / Q76_x6_TEXT=nicotine_inhaler_dagen_T2 / Q76_x7_TEXT=nicotine_anders_dagen_T2.

VARIABLE LABELS nicotinepleisters_stuks_T2 'nicotinevervangers: pleister aantal stuks/dag T2' /
nicotinekauwgom_stuks_T2  'nicotinevervangers: kauwgom aantal stuks/dag T2' /
nicotine_microtabs_stuks_T2 'nicotinevervangers: microtabs aantal stuks/dag T2' /
nicotine_zuigtabletten_stuks_T2 'nicotinevervangers: zuigtabletten aantal stuks/dag T2' /
nicotine_mondspray_keer_T2 'nicotinevervangers: mondspray aantal keer/dag T2' /
nicotine_inhaler_keer_T2 'nicotinevervangers: inhaler aantal keer/dag T2' /
nicotine_anders_stuks_T2 'nicotinevervangers: anders aantal stuks/dag T2'.

VARIABLE LABELS nicotinepleisters_dagen_T2  'nicotinevervangers: pleister aantal dagen T2' /
nicotinekauwgom_dagen_T2 'nicotinevervangers: kauwgom aantal dagen T2' /
nicotine_microtabs_dagen_T2 'nicotinevervangers: microtabs aantal dagen T2' /
nicotine_zuigtabletten_dagen_T2 'nicotinevervangers: zuigtabletten aantal dagen T2' /
nicotine_mondspray_dagen_T2 'nicotinevervangers: mondspray aantal dagen T2' /
nicotine_inhaler_dagen_T2 'nicotinevervangers: inhaler aantal dagen T2' /
nicotine_anders_dagen_T2 'nicotinevervangers: anders aantal dagen T2'.

* aantal stuks en aantal dagen van string naar numeriek.
* controle geen tekst.
FREQUENCIES VARIABLES= nicotinepleisters_stuks_T2 nicotinekauwgom_stuks_T2 nicotine_microtabs_stuks_T2 
    nicotine_zuigtabletten_stuks_T2 nicotine_mondspray_keer_T2 nicotine_inhaler_keer_T2 
    nicotine_anders_stuks_T2 nicotinepleisters_dagen_T2 nicotinekauwgom_dagen_T2 
    nicotine_microtabs_dagen_T2 nicotine_zuigtabletten_dagen_T2 nicotine_mondspray_dagen_T2 
    nicotine_inhaler_dagen_T2 nicotine_anders_dagen_T2
  /ORDER=ANALYSIS.

RECODE nicotinepleisters_stuks_T2 ('1 per dag'='1').
RECODE nicotinekauwgom_stuks_T2 ('0,1'='0.1').
RECODE nicotinepleisters_dagen_T2 ('21 dagen'='21').
RECODE nicotinepleisters_dagen_T2 ('30/31'='31').
RECODE nicotinepleisters_dagen_T2 ('70 dsgen'='70').
RECODE nicotinepleisters_dagen_T2 ('Alle'='90').
RECODE nicotinepleisters_dagen_T2 ('80%'='72').
RECODE nicotinepleisters_dagen_T2 ('kuur afgemaakt'='56').
RECODE nicotinekauwgom_dagen_T2 ('Elke dag'='90').
RECODE nicotinekauwgom_dagen_T2 ('bijna iedere dag'='90').
RECODE nicotine_zuigtabletten_dagen_T2 ('99'='90').
RECODE nicotine_anders_dagen_T2 ('120'='90').
RECODE nicotine_anders_dagen_T2 ('2 maanden'='60').
RECODE nicotine_anders_dagen_T2 ('3 maanden'='90').
RECODE nicotine_anders_dagen_T2 ('2,5 maand'='75').
RECODE nicotine_anders_dagen_T2 ('3mnd'='90').
RECODE nicotine_anders_dagen_T2 ('Alle dagen'='90').
RECODE nicotine_anders_dagen_T2 ('Iedere dag'='90').
EXECUTE.

ALTER TYPE nicotinepleisters_stuks_T2 nicotinekauwgom_stuks_T2 nicotine_microtabs_stuks_T2 
    nicotine_zuigtabletten_stuks_T2 nicotine_mondspray_keer_T2 nicotine_inhaler_keer_T2 
    nicotine_anders_stuks_T2 nicotinepleisters_dagen_T2 nicotinekauwgom_dagen_T2 
    nicotine_microtabs_dagen_T2 nicotine_zuigtabletten_dagen_T2 nicotine_mondspray_dagen_T2 
    nicotine_inhaler_dagen_T2 nicotine_anders_dagen_T2 (F3.0).

* controle reele getallen.
FREQUENCIES VARIABLES= nicotinepleisters_stuks_T2 nicotinekauwgom_stuks_T2 nicotine_microtabs_stuks_T2 
    nicotine_zuigtabletten_stuks_T2 nicotine_mondspray_keer_T2 nicotine_inhaler_keer_T2 
    nicotine_anders_stuks_T2 nicotinepleisters_dagen_T2 nicotinekauwgom_dagen_T2 
    nicotine_microtabs_dagen_T2 nicotine_zuigtabletten_dagen_T2 nicotine_mondspray_dagen_T2 
    nicotine_inhaler_dagen_T2 nicotine_anders_dagen_T2
  /ORDER=ANALYSIS.

** correcties.
* pleisters is altijd 1 per dag.
RECODE nicotinepleisters_stuks_T2 (6=1) (4=1).
* kauwgom = ja: 0 wordt 1 (conservatieve schatting).
RECODE nicotinekauwgom_stuks_T2 (0=1).
RECODE nicotinepleisters_dagen_T2 (112=90).
RECODE nicotine_mondspray_dagen_T2 (0=1).
EXECUTE.

*** nvt toevoegen.
DO IF (nicotinepleisters_T2=0).
RECODE nicotinepleisters_stuks_T2 (SYSMIS=888).
RECODE nicotinepleisters_dagen_T2 (SYSMIS=888).
END IF.
EXECUTE.
DO IF (nicotinekauwgom_T2=0).
RECODE nicotinekauwgom_stuks_T2 (SYSMIS=888).
RECODE nicotinekauwgom_dagen_T2 (SYSMIS=888).
END IF.
EXECUTE.
DO IF (nicotine_microtabs_T2=0).
RECODE nicotine_microtabs_stuks_T2 (SYSMIS=888).
RECODE nicotine_microtabs_dagen_T2 (SYSMIS=888).
END IF.
EXECUTE.
DO IF (nicotine_zuigtabletten_T2=0).
RECODE nicotine_zuigtabletten_stuks_T2 (SYSMIS=888).
RECODE nicotine_zuigtabletten_dagen_T2 (SYSMIS=888).
END IF.
EXECUTE.
DO IF (nicotine_mondspray_T2=0).
RECODE nicotine_mondspray_keer_T2 (SYSMIS=888).
RECODE nicotine_mondspray_dagen_T2 (SYSMIS=888).
END IF.
EXECUTE.
DO IF (nicotine_inhaler_T2=0).
RECODE nicotine_inhaler_keer_T2 (SYSMIS=888).
RECODE nicotine_inhaler_dagen_T2 (SYSMIS=888).
END IF.
EXECUTE.
DO IF (nicotine_anders_T2=0).
RECODE nicotine_anders_stuks_T2 (SYSMIS=888).
RECODE nicotine_anders_dagen_T2 (SYSMIS=888).
END IF.
EXECUTE.

** Degene die nu nog sysmis zijn zijn echt missing (worden wel gebruikt maar geen aantal ingevuld).
RECODE nicotinepleisters_stuks_T2 nicotinekauwgom_stuks_T2 nicotine_microtabs_stuks_T2 
    nicotine_zuigtabletten_stuks_T2 nicotine_mondspray_keer_T2 nicotine_inhaler_keer_T2 
    nicotine_anders_stuks_T2 nicotinepleisters_dagen_T2 nicotinekauwgom_dagen_T2 
    nicotine_microtabs_dagen_T2 nicotine_zuigtabletten_dagen_T2 nicotine_mondspray_dagen_T2 
    nicotine_inhaler_dagen_T2 nicotine_anders_dagen_T2 (SYSMIS=999).
EXECUTE.

MISSING VALUES nicotinepleisters_stuks_T2 nicotinekauwgom_stuks_T2 nicotine_microtabs_stuks_T2 
    nicotine_zuigtabletten_stuks_T2 nicotine_mondspray_keer_T2 nicotine_inhaler_keer_T2 
    nicotine_anders_stuks_T2 nicotinepleisters_dagen_T2 nicotinekauwgom_dagen_T2 
    nicotine_microtabs_dagen_T2 nicotine_zuigtabletten_dagen_T2 nicotine_mondspray_dagen_T2 
    nicotine_inhaler_dagen_T2 nicotine_anders_dagen_T2 (888, 999) nicotinepleisters_T2 nicotinekauwgom_T2 nicotine_microtabs_T2 
    nicotine_zuigtabletten_T2 nicotine_mondspray_T2 nicotine_inhaler_T2 nicotine_anders_T2 (9).

VARIABLE LEVEL nicotinevervangers_T2 nicotinepleisters_T2 nicotinekauwgom_T2 nicotine_microtabs_T2 
    nicotine_zuigtabletten_T2 nicotine_mondspray_T2 nicotine_inhaler_T2 nicotine_anders_T2 (NOMINAL).
VARIABLE LEVEL nicotinepleisters_stuks_T2 nicotinekauwgom_stuks_T2 nicotine_microtabs_stuks_T2 
    nicotine_zuigtabletten_stuks_T2 nicotine_mondspray_keer_T2 nicotine_inhaler_keer_T2 
    nicotine_anders_stuks_T2 nicotinepleisters_dagen_T2 nicotinekauwgom_dagen_T2 
    nicotine_microtabs_dagen_T2 nicotine_zuigtabletten_dagen_T2 nicotine_mondspray_dagen_T2 
    nicotine_inhaler_dagen_T2 nicotine_anders_dagen_T2 (SCALE).


*** Q77: gebruik electronische sigaretten ****************************************************************************************************************************.
RENAME VARIABLES Q77 =Esigaret_T2 / Q78_1=Esigaret_met_nicotine_T2 / Q78_2=Esigaret_zonder_nicotine_T2.
VARIABLE LABELS Esigaret_T2 'E-sigaret gebruikt: ja/nee T2'
Esigaret_met_nicotine_T2  'E-sigaret met nicotine: ja/nee T2' 
Esigaret_zonder_nicotine_T2  'E-sigaret zonder nicotine: ja/nee T2'.
VALUE LABELS Esigaret_met_nicotine_T2 Esigaret_zonder_nicotine_T2 0 'nee' 1 'ja' .

RENAME VARIABLES Q79_1_x1_1_TEXT= Esigaret_met_nicotine_stuks_T2 / Q79_1_x2_1_TEXT =Esigaret_zonder_nicotine_stuks_T2/
Q79_2_x1_1_TEXT=Esigaret_met_nicotine_dagen_T2 / Q79_2_x2_1_TEXT=Esigaret_zonder_nicotine_dagen_T2.
VARIABLE LABELS  Esigaret_met_nicotine_stuks_T2 'E-sigaret met nicotine: aantal stuks/dag T2' / Esigaret_zonder_nicotine_stuks_T2 'E-sigaret zonder nicotine: aantal stuks/dag T2'.
VARIABLE LABELS Esigaret_met_nicotine_dagen_T2 'E-sigaret met nicotine: aantal dagen T2' / Esigaret_zonder_nicotine_dagen_T2 'E-sigaret zonder nicotine: aantal dagen T2'.

VARIABLE LEVEL Esigaret_T2 Esigaret_met_nicotine_T2 Esigaret_zonder_nicotine_T2 (NOMINAL).

* Indien Esigaret1_T2 Nee is, moet missing  0 zijn.
DO IF (Esigaret_T2=1).
RECODE Esigaret_met_nicotine_T2 Esigaret_zonder_nicotine_T2 (SYSMIS=0).
END IF.
EXECUTE.

* Indien Esigaret1_T0 2 (ja) is, moet Esigaret_met_nicotine_T1 of Esigaret_zonder_nicotine_T1 1 (ja) zijn, indien beide missing: missing. Indien 1 ingevuld en andere missing: andere=0.
DO IF (Esigaret_T2=2) and SYSMIS (Esigaret_met_nicotine_T2 )=1 and SYSMIS (Esigaret_zonder_nicotine_T2 )=1.
RECODE   Esigaret_met_nicotine_T2 Esigaret_zonder_nicotine_T2 (SYSMIS=9).
END IF.
DO IF Esigaret_T2=2.
RECODE   Esigaret_met_nicotine_T2 Esigaret_zonder_nicotine_T2 (SYSMIS=0).
END IF.
MISSING VALUES Esigaret_met_nicotine_T2 Esigaret_zonder_nicotine_T2 (9).
EXECUTE.

** Missing toevoegen (overige sysmis=missing).
RECODE Esigaret_T2 Esigaret_met_nicotine_T2 Esigaret_zonder_nicotine_T2 (SYSMIS=9).
MISSING VALUES Esigaret_T2 Esigaret_met_nicotine_T2 Esigaret_zonder_nicotine_T2 (9).
EXECUTE.

*stuks en dagen wordt voorlopig niet mee gerekend. Als string laten staan.


*** Q80 medicatie *******************************************************************************************************************************************************.
RENAME VARIABLES Q80=medicatie_T2 / Q81_1_TEXT = med1_T2 / Q81_2_TEXT = med2_T2 / Q81_3_TEXT = med3_T2 / Q81_4_TEXT = med4_T2 / Q81_5_TEXT = med5_T2 /
Q81_6_TEXT = med6_T2 /Q81_7_TEXT = med7_T2 /Q81_8_TEXT = med8_T2 / Q81_9_TEXT = med9_T2 / Q81_10_TEXT = med10_T2. 

VARIABLE LABELS medicatie_T2 'medicatie ja/nee T2' med1_T2 'med naam 1 T2'  med2_T2 'med naam 2 T2'  med3_T2 'med naam 3 T2'  med4_T2 'med naam 4 T2'
 med5_T2 'med naam 5 T2'  med6_T2 'med naam 6 T2'  med7_T2 'med naam 7 T2'  med8_T2 'med naam 8 T2'  med9_T2 'med naam 9 T2'  med10_T2 'med naam 10 T2'.

RENAME VARIABLES Q82_x1_TEXT =med1_dosering_T2 / Q82_x2_TEXT =med2_dosering_T2 / Q82_x3_TEXT =med3_dosering_T2 
/ Q82_x4_TEXT =med4_dosering_T2 / Q82_x5_TEXT =med5_dosering_T2 / Q82_x6_TEXT =med6_dosering_T2 
/ Q82_x7_TEXT =med7_dosering_T2 / Q82_x8_TEXT =med8_dosering_T2 / Q82_x9_TEXT =med9_dosering_T2 / Q82_x10_TEXT =med10_dosering_T2.

VARIABLE LABELS  med1_dosering_T2 / med2_dosering_T2 / med3_dosering_T2 / med4_dosering_T2 / med5_dosering_T2 / med6_dosering_T2 / med7_dosering_T2 / 
    med8_dosering_T2 / med9_dosering_T2 / med10_dosering_T2.

RENAME VARIABLES Q83_x1_TEXT =med1_keerperdag_T2 /  Q83_x2_TEXT =med2_keerperdag_T2 /  Q83_x3_TEXT =med3_keerperdag_T2 / 
 Q83_x4_TEXT =med4_keerperdag_T2 /  Q83_x5_TEXT =med5_keerperdag_T2 /  Q83_x6_TEXT =med6_keerperdag_T2 / 
 Q83_x7_TEXT =med7_keerperdag_T2 /  Q83_x8_TEXT =med8_keerperdag_T2 /  Q83_x9_TEXT =med9_keerperdag_T2 / 
 Q83_x10_TEXT =med10_keerperdag_T2 .

VARIABLE LABELS  med1_keerperdag_T2 / med2_keerperdag_T2 / med3_keerperdag_T2 / med4_keerperdag_T2 / med5_keerperdag_T2 / 
    med6_keerperdag_T2 / med7_keerperdag_T2 / med8_keerperdag_T2 / med9_keerperdag_T2 / med10_keerperdag_T2.

RENAME VARIABLES Q84_x1_TEXT =med1_aantdagen_T2 / Q84_x2_TEXT =med2_aantdagen_T2 / Q84_x3_TEXT =med3_aantdagen_T2 / 
Q84_x4_TEXT =med4_aantdagen_T2 / Q84_x5_TEXT =med5_aantdagen_T2 / Q84_x6_TEXT =med6_aantdagen_T2 / 
Q84_x7_TEXT =med7_aantdagen_T2 / Q84_x8_TEXT =med8_aantdagen_T2 / Q84_x9_TEXT =med9_aantdagen_T2 /
Q84_x10_TEXT =med10_aantdagen_T2.

VARIABLE LABELS   med1_aantdagen_T2 / med2_aantdagen_T2 / med3_aantdagen_T2  / med4_aantdagen_T2 / med5_aantdagen_T2 /
    med6_aantdagen_T2 / med7_aantdagen_T2 / med8_aantdagen_T2 / med9_aantdagen_T2 / med10_aantdagen_T2.

RENAME VARIABLES  Q85_x1_TEXT =med1_vorm_T2 / Q85_x2_TEXT =med2_vorm_T2 / Q85_x3_TEXT =med3_vorm_T2 / 
Q85_x4_TEXT =med4_vorm_T2 / Q85_x5_TEXT =med5_vorm_T2 /Q85_x6_TEXT =med6_vorm_T2 / 
Q85_x7_TEXT =med7_vorm_T2 / Q85_x8_TEXT =med8_vorm_T2 / Q85_x9_TEXT =med9_vorm_T2 / Q85_x10_TEXT =med10_vorm_T2.

VARIABLE LABELS  med1_vorm_T2 / med2_vorm_T2 / med3_vorm_T2 / med4_vorm_T2 / med5_vorm_T2 / med6_vorm_T2 / med7_vorm_T2 / 
    med8_vorm_T2 / med9_vorm_T2 / med10_vorm_T2.

*Med 10 is leeg:.
DELETE VARIABLES  med10_T2 med10_dosering_T2 med10_keerperdag_T2 med10_aantdagen_T2 med10_vorm_T2.

** als medicatie_T2=1 (nee) of missing: med1_T2 moet leeg zijn.
USE ALL.
COMPUTE filter_$=(medicatie_T2=1 or MISSING(medicatie_T2)=1).
VARIABLE LABELS filter_$ 'medicatie_T2=1 of missing (FILTER)'.
VALUE LABELS filter_$ 0 'Not Selected' 1 'Selected'.
FORMATS filter_$ (f1.0).
FILTER BY filter_$.
EXECUTE.
FREQUENCIES VARIABLES=med1_T2
  /ORDER=ANALYSIS.
USE ALL.

*aantal keer per dag van string naar numeriek.
* controle op tekst en decimalen moeten met punt.
FREQUENCIES VARIABLES= med1_keerperdag_T2 med2_keerperdag_T2 med3_keerperdag_T2 med4_keerperdag_T2 med5_keerperdag_T2 
    med6_keerperdag_T2 med7_keerperdag_T2 med8_keerperdag_T2 med9_keerperdag_T2 
 /ORDER=ANALYSIS.
** 1x per week wordt 1/7=0.14

RECODE med1_keerperdag_T2 ('x'='').
RECODE med1_keerperdag_T2 ('Verschillend'='').
RECODE med1_keerperdag_T2 ('Nb'='').
RECODE med1_keerperdag_T2 ('geen idee'='').
RECODE med1_keerperdag_T2 ('Dagelijkse dosering'='').
RECODE med1_keerperdag_T2 ('bij (rug)pijn'='').
RECODE med1_keerperdag_T2 ('3x'='3').
RECODE med1_keerperdag_T2 ('2x per dag'='2').
RECODE med1_keerperdag_T2 ('2x'='2').
RECODE med1_keerperdag_T2 ('1xdaags'='1').
RECODE med1_keerperdag_T2 ('1x1.2'='1').
RECODE med1_keerperdag_T2 ('1 per dag'='1').
RECODE med1_keerperdag_T2 ('1x per dag'='1').
RECODE med1_keerperdag_T2 ('1 x per dag'='1').
RECODE med1_keerperdag_T2 ('1x'='1').
RECODE med1_keerperdag_T2 ('1 x p/d'='1').
RECODE med1_keerperdag_T2 ('1 x 3'='1').
* aantal dagen is al aangepast.
RECODE med1_keerperdag_T2 ('2x per week'='1').
RECODE med1_keerperdag_T2 ('1x per week'='1').
EXECUTE.

* keerperdag=1x3.
DO IF ID_Code=2706.
RECODE med1_dosering_T2 ('25 mg'='3x25 mg').
END IF.
EXECUTE.

* 75 x per dag, bedoelt waarschijnlijk 75 dagen (staat daar ook ingevuld) --> hier 1x per dag.
DO IF ID_Code=5305.
RECODE med1_keerperdag_T2 ('75'='1').
END IF.
EXECUTE.

* antibiotica 37x per dag. bedoelt waarschijnlijk 3x.
DO IF ID_Code=5309.
RECODE med1_keerperdag_T2 ('37'='3').
END IF.
EXECUTE.

* 25 x per dag, bedoelt waarschijnlijk 25 dagen (staat daar ook ingevuld) --> hier 1x per dag.
DO IF ID_Code=3215.
RECODE med1_keerperdag_T2 ('25'='1').
END IF.
EXECUTE.

* keerperdag missing, maar is infuus, 1x (geeft ook al aan gedurende 1 dag).
DO IF ID_Code=3902.
RECODE med1_keerperdag_T2 (''='1').
END IF.
EXECUTE.


RECODE med2_keerperdag_T2 ('Nb'='').
RECODE med2_keerperdag_T2 ('?'='').
RECODE med2_keerperdag_T2 ('geen idee'='').
RECODE med2_keerperdag_T2 ('Dagelijkse dosering'='').
RECODE med2_keerperdag_T2 ('bij (rug)pijn'='').
RECODE med2_keerperdag_T2 ('2x per dag'='2').
RECODE med2_keerperdag_T2 ('2 per dag'='2').
RECODE med2_keerperdag_T2 ('2x'='2').
RECODE med2_keerperdag_T2 ('1x per dag'='1').
* aant dagen is al aangepast.
RECODE med2_keerperdag_T2 ('1x p/w'='1').
RECODE med2_keerperdag_T2 ('1x'='1').
RECODE med2_keerperdag_T2 ('1maal daags'='1').
RECODE med2_keerperdag_T2 ('0,05'='1').
EXECUTE.

RECODE med3_keerperdag_T2 ('Zonodig'='').
RECODE med3_keerperdag_T2 ('zo nodig'='').
RECODE med3_keerperdag_T2 ('geen idee'='').
RECODE med3_keerperdag_T2 ('Dagelijkse dosering'='').
RECODE med3_keerperdag_T2 ('bij migraine'='').
*aant dagen is al aangepast.
RECODE med3_keerperdag_T2 ('4 x p/w'='1').
RECODE med3_keerperdag_T2 ('3x'='3').
RECODE med3_keerperdag_T2 ('2x daags'='2').
RECODE med3_keerperdag_T2 ('2x'='2').
RECODE med3_keerperdag_T2 ('1x'='1').
RECODE med3_keerperdag_T2 ('1 daags'='1').

* neusdruppels 230x per dag? wordt missing (kostenberekening is toch per flesje).
DO IF ID_Code=4109.
RECODE med3_keerperdag_T2 ('230'='').
END IF.
EXECUTE.

* Vit B12 injectie, 1x per 4 maanden. Geeft ook al aan gedurende 1 dag, dus hier 1xper dag.
DO IF ID_Code=3609.
RECODE med3_keerperdag_T2 ('1 keer per 4 maanden'='1').
END IF.
EXECUTE.

RECODE med4_keerperdag_T2 ('Zonodig'='').
RECODE med4_keerperdag_T2 ('geen idee'='').
RECODE med4_keerperdag_T2 ('4x'='4').
RECODE med4_keerperdag_T2 ('2x'='2').
RECODE med4_keerperdag_T2 ('1x p/d'='1').
RECODE med4_keerperdag_T2 ('1x daags'='1').
RECODE med4_keerperdag_T2 ('1x'='1').
*aant dagen is al aangepast.
RECODE med4_keerperdag_T2 ('1 keer per week'='1').
EXECUTE.

RECODE med5_keerperdag_T2 ('geen idee'='').
RECODE med5_keerperdag_T2 ('zn'='').
RECODE med5_keerperdag_T2 ('3x'='3').
RECODE med5_keerperdag_T2 ('1xdaags'='1').
RECODE med5_keerperdag_T2 ('1x'='1').
RECODE med5_keerperdag_T2 ('1 x p/d'='1').
** geeft ook 1 dag aan:.
RECODE med5_keerperdag_T2 ('1x na beet'='1').
** bloedverdunner 19x, bedoelt waarschijnlijk 1.
RECODE med5_keerperdag_T2 ('19'='1').
EXECUTE.

RECODE med6_keerperdag_T2 ('0-1'='1').
RECODE med6_keerperdag_T2 ('2x'='2').
RECODE med6_keerperdag_T2 ('1xdaags'='1').
RECODE med6_keerperdag_T2 ('1x'='1').
RECODE med6_keerperdag_T2 ('1-2'='1').
RECODE med6_keerperdag_T2 ('1 x p/d'='1').
EXECUTE.

RECODE med7_keerperdag_T2 ('zo nodig'='1').
RECODE med7_keerperdag_T2 ('1 x p/d'='1').
EXECUTE.

RECODE med8_keerperdag_T2 ('incidenteel'='').
RECODE med8_keerperdag_T2 ('2x daags'='2').
RECODE med8_keerperdag_T2 ('1 x p/d'='1').
EXECUTE.

* aantal dagen is al aangepast.
RECODE med9_keerperdag_T2 ('2x per week'='1').
RECODE med9_keerperdag_T2 ('2 x p/w'='1').
EXECUTE.

ALTER TYPE med1_keerperdag_T2 med2_keerperdag_T2 med3_keerperdag_T2 med4_keerperdag_T2 med5_keerperdag_T2 
    med6_keerperdag_T2 med7_keerperdag_T2 med8_keerperdag_T2 med9_keerperdag_T2 (F3.2).
VARIABLE WIDTH  med1_keerperdag_T2 med2_keerperdag_T2 med3_keerperdag_T2 med4_keerperdag_T2 med5_keerperdag_T2 
    med6_keerperdag_T2 med7_keerperdag_T2 med8_keerperdag_T2 med9_keerperdag_T2 (7).

*Q115 (aantal dagen) van string naar numeriek.
* controle op tekst en decimalen moeten met komma.
FREQUENCIES VARIABLES= med1_aantdagen_T2 med2_aantdagen_T2 med3_aantdagen_T2 med4_aantdagen_T2 med5_aantdagen_T2 
    med6_aantdagen_T2 med7_aantdagen_T2 med8_aantdagen_T2 med9_aantdagen_T2  
 /ORDER=ANALYSIS.

RECODE med1_aantdagen_T2 ('alle'='90').
RECODE med1_aantdagen_T2 ('elke dag'='90').
RECODE med1_aantdagen_T2 ('Iedere dag'='90').
RECODE med1_aantdagen_T2 ('iedere dag'='90').
RECODE med1_aantdagen_T2 ('180'='90').
RECODE med1_aantdagen_T2 ('120'='90').
RECODE med1_aantdagen_T2 ('110'='90').
RECODE med1_aantdagen_T2 ('30 dgn'='30').
RECODE med2_aantdagen_T2 ('bijna iedere dag'='90').
RECODE med2_aantdagen_T2 ('elke dag'='90').
RECODE med2_aantdagen_T2 ('180'='90').
RECODE med2_aantdagen_T2 ('120'='90').
RECODE med2_aantdagen_T2 ('I'='1').
RECODE med3_aantdagen_T2 ('Hele zomer'='90').
RECODE med3_aantdagen_T2 ('120'='90').
RECODE med4_aantdagen_T2 ('120'='90').
RECODE med8_aantdagen_T2 ('120'='90').
RECODE med8_aantdagen_T2 ('incidenteel'='').
EXECUTE.

ALTER TYPE med1_aantdagen_T2 med2_aantdagen_T2 med3_aantdagen_T2 med4_aantdagen_T2 med5_aantdagen_T2 
    med6_aantdagen_T2 med7_aantdagen_T2 med8_aantdagen_T2 med9_aantdagen_T2  (F3.0).
VARIABLE WIDTH  med1_aantdagen_T2 med2_aantdagen_T2 med3_aantdagen_T2 med4_aantdagen_T2 med5_aantdagen_T2 
    med6_aantdagen_T2 med7_aantdagen_T2 med8_aantdagen_T2 med9_aantdagen_T2  (7).

** missing invullen.
RECODE medicatie_T2 (SYSMIS=9).
MISSING VALUES  medicatie_T2 (9).
EXECUTE.

*** Vorm hetzelfde noemen.
FREQUENCIES VARIABLES=med1_vorm_T2 med2_vorm_T2 med3_vorm_T2 med4_vorm_T2 med5_vorm_T2 med6_vorm_T2 
    med7_vorm_T2 med8_vorm_T2 med9_vorm_T2   /ORDER=ANALYSIS.

RECODE med1_vorm_T2 ('1'='tablet').
RECODE med1_vorm_T2 ('pi'='tablet').
RECODE med1_vorm_T2 ('p'='tablet').
RECODE med1_vorm_T2 ('pil'='tablet').
RECODE med1_vorm_T2 ('Pil'='tablet').
RECODE med1_vorm_T2 ('pillen'='tablet').
RECODE med1_vorm_T2 ('Pillen'='tablet').
RECODE med1_vorm_T2 ('pi'='tablet').
RECODE med1_vorm_T2 ('PIL'='tablet').
RECODE med1_vorm_T2 ('Pilletje'='tablet').
RECODE med1_vorm_T2 ('capsules'='tablet').
RECODE med1_vorm_T2 ('capsule'='tablet').
RECODE med1_vorm_T2 ('Capsules'='tablet').
RECODE med1_vorm_T2 ('Tablet'='tablet').
RECODE med1_vorm_T2 ('Tabl'='tablet').
RECODE med1_vorm_T2 ('bruis'='tablet').
RECODE med1_vorm_T2 ('Bruistablet'='bruistablet').
RECODE med1_vorm_T2 ('bruis'='bruistablet').
RECODE med1_vorm_T2 ('Bruis'='bruistablet').
RECODE med1_vorm_T2 ('inhaler'='inhalator').
RECODE med1_vorm_T2 ('Inhaler'='inhalator').
RECODE med1_vorm_T2 ('Inhalator'='inhalator').
RECODE med1_vorm_T2 ('inhalatie'='inhalator').
RECODE med1_vorm_T2 ('puffer'='inhalator').
RECODE med1_vorm_T2 ('Puffer'='inhalator').
RECODE med1_vorm_T2 ('pufjes'='inhalator').
RECODE med1_vorm_T2 ('pufje'='inhalator').
RECODE med1_vorm_T2 ('Injectie'='injectie').
RECODE med1_vorm_T2 ('Poedervorm'='poeder').
RECODE med1_vorm_T2 ('Poeder voor vloeistof'='poeder').
RECODE med1_vorm_T2 ('Poeder'='poeder').
RECODE med1_vorm_T2 ('Inhalatiepoeder'='poeder').
RECODE med1_vorm_T2 ('Pleister'='pleister').
RECODE med1_vorm_T2 ('pleiser'='pleister').
RECODE med1_vorm_T2 ('Vloeistof'='vloeistof').
RECODE med1_vorm_T2 ('Vloestof'='vloeistof').
RECODE med1_vorm_T2 ('Zalf'='zalf').

RECODE med2_vorm_T2 ('1'='tablet').
RECODE med2_vorm_T2 ('pil'='tablet').
RECODE med2_vorm_T2 ('Pil'='tablet').
RECODE med2_vorm_T2 ('p'='tablet').
RECODE med2_vorm_T2 ('pillen'='tablet').
RECODE med2_vorm_T2 ('PIL'='tablet').
RECODE med2_vorm_T2 ('pillenb'='tablet').
RECODE med2_vorm_T2 ('Pillen'='tablet').
RECODE med2_vorm_T2 ('pilletje'='tablet').
RECODE med2_vorm_T2 ('Pilletje'='tablet').
RECODE med2_vorm_T2 ('Tabletten'='tablet').
RECODE med2_vorm_T2 ('Tablet'='tablet').
RECODE med2_vorm_T2 ('TABLET'='tablet').
RECODE med2_vorm_T2 ('Tabl'='tablet').
RECODE med2_vorm_T2 ('zuigtablet'='tablet').
RECODE med2_vorm_T2 ('capsule'='tablet').
RECODE med2_vorm_T2 ('caps'='tablet').
RECODE med2_vorm_T2 ('Zetpil'='zetpil').
RECODE med2_vorm_T2 ('verstuiver pompje'='verstuiver').
RECODE med2_vorm_T2 ('inhaleren'='inhalator').
RECODE med2_vorm_T2 ('Inhaler'='inhalator').
RECODE med2_vorm_T2 ('inhalatie'='inhalator').
RECODE med2_vorm_T2 ('inhalor'='inhalator').
RECODE med2_vorm_T2 ('pufjes'='inhalator').
RECODE med2_vorm_T2 ('Pufje'='inhalator').
RECODE med2_vorm_T2 ('Puf'='inhalator').
RECODE med2_vorm_T2 ('Puffer'='inhalator').
RECODE med2_vorm_T2 ('puf'='inhalator').
RECODE med2_vorm_T2 ('pompje'='inhalator').
RECODE med2_vorm_T2 ('Poeder'='poeder').
RECODE med2_vorm_T2 ('poedervorm'='poeder').
RECODE med2_vorm_T2 ('Pleister'='pleister').
RECODE med2_vorm_T2 ('Druppels'='druppels').
RECODE med2_vorm_T2 ('Vloeistof'='vloeistof').

RECODE med3_vorm_T2 ('1'='').
RECODE med3_vorm_T2 ('pil'='tablet').
RECODE med3_vorm_T2 ('pillen'='tablet').
RECODE med3_vorm_T2 ('Pillen'='tablet').
RECODE med3_vorm_T2 ('pil'='tablet').
RECODE med3_vorm_T2 ('Pil'='tablet').
RECODE med3_vorm_T2 ('pilletje'='tablet').
RECODE med3_vorm_T2 ('Pilletje'='tablet').
RECODE med3_vorm_T2 ('piul'='tablet').
RECODE med3_vorm_T2 ('p'='tablet').
RECODE med3_vorm_T2 ('smelttablet'='tablet').
RECODE med3_vorm_T2 ('Smelttablet'='tablet').
RECODE med3_vorm_T2 ('Tabl'='tablet').
RECODE med3_vorm_T2 ('capsule'='tablet').
RECODE med3_vorm_T2 ('Capsule'='tablet').
RECODE med3_vorm_T2 ('capcule'='tablet').
RECODE med3_vorm_T2 ('Inhalator'='inhalator').
RECODE med3_vorm_T2 ('Innalatie'='inhalator').
RECODE med3_vorm_T2 ('inhalinging'='inhalator').
RECODE med3_vorm_T2 ('inhalatie'='inhalator').
RECODE med3_vorm_T2 ('inhalor'='inhalator').
RECODE med3_vorm_T2 ('Inhaler'='inhalator').
RECODE med3_vorm_T2 ('puffer'='inhalator').
RECODE med3_vorm_T2 ('puf'='inhalator').
RECODE med3_vorm_T2 ('Puf'='inhalator').
RECODE med3_vorm_T2 ('pompje'='inhalator').
RECODE med3_vorm_T2 ('Pleister'='pleister').
RECODE med3_vorm_T2 ('Poeder'='poeder').
RECODE med3_vorm_T2 ('Poedet'='poeder').
RECODE med3_vorm_T2 ('snuif'='verstuiver').
RECODE med3_vorm_T2 ('Injectie'='injectie').
RECODE med3_vorm_T2 ('intraveneus'='injectie').
RECODE med3_vorm_T2 ('inj.'='injectie').
RECODE med3_vorm_T2 ('Druppels'='druppels').
RECODE med3_vorm_T2 ('droppels'='druppels').
RECODE med3_vorm_T2 ('Vloeistof'='vloeistof').
RECODE med3_vorm_T2 ('Zetpil'='zetpil').

RECODE med4_vorm_T2 ('1'='').
RECODE med4_vorm_T2 ('pil'='tablet').
RECODE med4_vorm_T2 ('pillen'='tablet').
RECODE med4_vorm_T2 ('Pilletje'='tablet').
RECODE med4_vorm_T2 ('Pillen'='tablet').
RECODE med4_vorm_T2 ('Pil'='tablet').
RECODE med4_vorm_T2 ('capsule'='tablet').
RECODE med4_vorm_T2 ('Zetpil'='zetpil').
RECODE med4_vorm_T2 ('Inhalator'='inhalator').
RECODE med4_vorm_T2 ('Poeder'='poeder').
RECODE med4_vorm_T2 ('Vloeistof'='vloeistof').

RECODE med5_vorm_T2 ('1'='').
RECODE med5_vorm_T2 ('Pil'='tablet').
RECODE med5_vorm_T2 ('pil'='tablet').
RECODE med5_vorm_T2 ('puffertje'='inhalator').
RECODE med5_vorm_T2 ('Poeder'='poeder').

RECODE med6_vorm_T2 ('1'='').
RECODE med6_vorm_T2 ('puf'='inhalator').
RECODE med6_vorm_T2 ('Pil'='tablet').
RECODE med6_vorm_T2 ('pil'='tablet').

RECODE med7_vorm_T2 ('pil'='tablet').
RECODE med7_vorm_T2 ('Pil'='tablet').
RECODE med7_vorm_T2 ('capsule'='tablet').
RECODE med7_vorm_T2 ('pillen'='tablet').
RECODE med7_vorm_T2 ('spuit'='injectie').
RECODE med7_vorm_T2 ('Pillen'='tablet').
RECODE med7_vorm_T2 ('Neusspray'='verstuiver').

RECODE med8_vorm_T2 ('pil'='tablet').
RECODE med8_vorm_T2 ('Pil'='tablet').
RECODE med8_vorm_T2 ('Capsule'='tablet').

RECODE med9_vorm_T2 ('pil'='tablet').
EXECUTE.

*** Diverse aanpassingen*****************************************************************************************************************************************************.

*** ID 4903. Vult in bij Med1: zie vorige vragen lijst. Overnemen uit T1:.
DO IF ID_Code=4903.
RECODE med1_T2 ('zie vorige invullijst is hetzelfde'='Nortrilen').
RECODE med1_dosering_T2 (''='10mg').
RECODE med1_keerperdag_T2 (SYSMIS=1).
RECODE med1_aantdagen_T2 (SYSMIS=90).
RECODE med2_T2 (' '='Nortrilen').
RECODE med2_dosering_T2 (''='25 mg').
RECODE med2_keerperdag_T2 (SYSMIS=1).
RECODE med2_aantdagen_T2 (SYSMIS=90).
RECODE med3_T2 (''='praluent').
RECODE med3_dosering_T2 (''='75 mg/ml').
RECODE med3_keerperdag_T2 (SYSMIS=0.14).
RECODE med3_aantdagen_T2 (SYSMIS=90).
RECODE med3_vorm_T2 ('' ='injectie').
RECODE med4_T2 (''='legendal').
RECODE med4_dosering_T2 (''='12 g').
RECODE med4_keerperdag_T2 (SYSMIS=1).
RECODE med4_aantdagen_T2 (SYSMIS=90).
RECODE med4_vorm_T2 (' '='granulaat').
RECODE med5_T2 (''='quinapril').
RECODE med5_dosering_T2 (''='10 mg').
RECODE med5_keerperdag_T2 (SYSMIS=1).
RECODE med5_aantdagen_T2 (SYSMIS=90).
RECODE med6_T2 (''='atorvastatine').
RECODE med6_dosering_T2 (''='40 mg').
RECODE med6_keerperdag_T2 (SYSMIS=1).
RECODE med6_aantdagen_T2 (SYSMIS=90).
RECODE med7_T2 (''='ezetrol').
RECODE med7_dosering_T2 (''='10 mg').
RECODE med7_keerperdag_T2 (SYSMIS=1).
RECODE med7_aantdagen_T2 (SYSMIS=90).
RECODE med8_T2 (''='clopidogrel').
RECODE med8_dosering_T2 (''='75 mg').
RECODE med8_keerperdag_T2 (SYSMIS=1).
RECODE med8_aantdagen_T2 (SYSMIS=90).
END IF.
EXECUTE.


*** ID 4308. Vult in bij Med1: zelfde als vorige x voor mijn bloeddruk. Overnemen uit T1:.
DO IF ID_Code=4308.
RECODE med1_T2 ('zelfde als vorige x voor mijn bloeddruk'='atorvastitiene 10 mg').
RECODE med1_dosering_T2 (''='10mg').
RECODE med1_keerperdag_T2 (SYSMIS=1).
RECODE med1_aantdagen_T2 (SYSMIS=90).
RECODE med2_T2 (' '='mono- cedocard 25 mg').
RECODE med2_dosering_T2 (''='25 mg').
RECODE med2_keerperdag_T2 (SYSMIS=1).
RECODE med2_aantdagen_T2 (SYSMIS=90).
RECODE med3_T2 (''='metoprolosuccinaat 100').
RECODE med3_dosering_T2 (''='100 mg').
RECODE med3_keerperdag_T2 (SYSMIS=1).
RECODE med3_aantdagen_T2 (SYSMIS=60).
RECODE med4_T2 (''='enalaprilmaleaat 10 mg').
RECODE med4_dosering_T2 (''='10 mg').
RECODE med4_keerperdag_T2 (SYSMIS=1).
RECODE med4_aantdagen_T2 (SYSMIS=60).
RECODE med5_T2 (''='carbasalaatcalciuum 100').
RECODE med5_dosering_T2 (''='100 mg').
RECODE med5_keerperdag_T2 (SYSMIS=1).
RECODE med5_aantdagen_T2 (SYSMIS=60).
RECODE med6_T2 (''='hydrochloorthiazide  25 mg').
RECODE med6_dosering_T2 (''='25 mg').
RECODE med6_keerperdag_T2 (SYSMIS=1).
RECODE med6_aantdagen_T2 (SYSMIS=60).
END IF.

*** ID 1506. Vult in bij Med1: Nog steeds dezelfde medicatie als voorheen. Overnemen uit T1:.
DO IF ID_Code=1506.
RECODE med1_T2 ('Nog steeds dezelfde medicatie als voorheen'='Champix').
RECODE med1_dosering_T2 (''='1 mg').
RECODE med1_keerperdag_T2 (SYSMIS=2).
RECODE med1_aantdagen_T2 (SYSMIS=90).
RECODE med2_T2 (''='Perindopril').
RECODE med2_dosering_T2 (''='20mg').
RECODE med2_keerperdag_T2 (SYSMIS=1).
RECODE med2_aantdagen_T2 (SYSMIS=60).
RECODE med3_T2 (''='Metoprololsuccinaat').
RECODE med3_dosering_T2 (''='100 + 50 mg').
RECODE med3_keerperdag_T2 (SYSMIS=1).
RECODE med3_aantdagen_T2 (SYSMIS=60).
RECODE med4_T2 (''='Pantozol').
RECODE med4_dosering_T2 (''='20 mg').
RECODE med4_keerperdag_T2 (SYSMIS=1).
RECODE med4_aantdagen_T2 (SYSMIS=60).
RECODE med5_T2 (''='Lipitor').
RECODE med5_dosering_T2 (''='80 mg').
RECODE med5_keerperdag_T2 (SYSMIS=1).
RECODE med5_aantdagen_T2 (SYSMIS=60).
RECODE med6_T2 (''='carbasalaatcalcium').
RECODE med6_dosering_T2 (''='100 mg').
RECODE med6_keerperdag_T2 (SYSMIS=1).
RECODE med6_aantdagen_T2 (SYSMIS=60).
END IF.
EXECUTE.


*** ID 7102. Ja, verder leeg. Overnemen uit T0:.
DO IF ID_Code=7102.
RECODE med1_T2 (''='Naproxen').
RECODE med1_dosering_T2 ('idem'='500').
RECODE med1_keerperdag_T2 (SYSMIS=2).
RECODE med1_aantdagen_T2 (SYSMIS=60).
RECODE med2_T2 (' '='Aspirine').
RECODE med2_dosering_T2 (''='80').
RECODE med2_keerperdag_T2 (SYSMIS=1).
RECODE med2_aantdagen_T2 (SYSMIS=60).
RECODE med3_T2 (''='Omeprazol').
RECODE med3_dosering_T2 (''='20').
RECODE med3_keerperdag_T2 (SYSMIS=1).
RECODE med3_aantdagen_T2 (SYSMIS=60).
RECODE med4_T2 (''='Ocipine').
RECODE med4_dosering_T2 (''='10').
RECODE med4_keerperdag_T2 (SYSMIS=1).
RECODE med4_aantdagen_T2 (SYSMIS=60).
RECODE med5_T2 (''='Bisoprololfumaraat').
RECODE med5_dosering_T2 (''='5').
RECODE med5_keerperdag_T2 (SYSMIS=1).
RECODE med5_aantdagen_T2 (SYSMIS=60).
RECODE med6_T2 (''='promocard').
RECODE med6_dosering_T2 (''='30').
RECODE med6_keerperdag_T2 (SYSMIS=1).
RECODE med6_aantdagen_T2 (SYSMIS=60).
RECODE med7_T2 (''='Citalopram').
RECODE med7_dosering_T2 (''='10').
RECODE med7_keerperdag_T2 (SYSMIS=1).
RECODE med7_aantdagen_T2 (SYSMIS=60).
RECODE med8_T2 (''='Crestor').
RECODE med8_dosering_T2 (''='40').
RECODE med8_keerperdag_T2 (SYSMIS=1).
RECODE med8_aantdagen_T2 (SYSMIS=60).
RECODE med9_T2 (''='Ezetrol').
RECODE med9_dosering_T2 (''='10').
RECODE med9_keerperdag_T2 (SYSMIS=1).
RECODE med9_aantdagen_T2 (SYSMIS=60).
END IF.
EXECUTE.
*** aparte syntaxen ATC code, dosering en kosten runnen. 


* Nicotinevervangers (N07BA01) worden uit de medicatie gehaald. Controle of ze bij vraag over nicotinevervangers worden genoemd. Zo nee, daar aanvullen.
DO IF atc1_T2='N07BA01'.
COMPUTE med1_T2=' '.
COMPUTE med1_dosering_T2=' '.
COMPUTE med1_keerperdag_T2=$SYSMIS.
COMPUTE med1_aantdagen_T2=$SYSMIS.
COMPUTE med1_vorm_T2=' '.
END IF.
RECODE atc1_T2 ('N07BA01'=' ').
EXECUTE.

DO IF atc2_T2='N07BA01'.
COMPUTE med2_T2=' '.
COMPUTE med2_dosering_T2=' '.
COMPUTE med2_keerperdag_T2=$SYSMIS.
COMPUTE med2_aantdagen_T2=$SYSMIS.
COMPUTE med2_vorm_T2=' '.
END IF.
RECODE atc2_T2 ('N07BA01'=' ').
EXECUTE.

DO IF atc3_T2='N07BA01'.
COMPUTE med3_T2=' '.
COMPUTE med3_dosering_T2=' '.
COMPUTE med3_keerperdag_T2=$SYSMIS.
COMPUTE med3_aantdagen_T2=$SYSMIS.
COMPUTE med3_vorm_T2=' '.
END IF.
RECODE atc3_T2 ('N07BA01'=' ').
EXECUTE.

DO IF atc4_T2='N07BA01'.
COMPUTE med4_T2=' '.
COMPUTE med4_dosering_T2=' '.
COMPUTE med4_keerperdag_T2=$SYSMIS.
COMPUTE med4_aantdagen_T2=$SYSMIS.
COMPUTE med4_vorm_T2=' '.
END IF.
RECODE atc4_T2 ('N07BA01'=' ').
EXECUTE.

DO IF atc5_T2='N07BA01'.
COMPUTE med5_T2=' '.
COMPUTE med5_dosering_T2=' '.
COMPUTE med5_keerperdag_T2=$SYSMIS.
COMPUTE med5_aantdagen_T2=$SYSMIS.
COMPUTE med5_vorm_T2=' '.
END IF.
RECODE atc5_T2 ('N07BA01'=' ').
EXECUTE.

DO IF atc7_T2='N07BA01'.
COMPUTE med7_T2=' '.
COMPUTE med7_dosering_T2=' '.
COMPUTE med7_keerperdag_T2=$SYSMIS.
COMPUTE med7_aantdagen_T2=$SYSMIS.
COMPUTE med7_vorm_T2=' '.
END IF.
RECODE atc7_T2 ('N07BA01'=' ').
EXECUTE.

DO IF atc8_T2='N07BA01'.
COMPUTE med8_T2=' '.
COMPUTE med8_dosering_T2=' '.
COMPUTE med8_keerperdag_T2=$SYSMIS.
COMPUTE med8_aantdagen_T2=$SYSMIS.
COMPUTE med8_vorm_T2=' '.
END IF.
RECODE atc8_T2 ('N07BA01'=' ').
EXECUTE.



*** Q86: EHBO********************************************************************************************************************************************.
RENAME VARIABLES Q86=EHBO_T2 / Q86_TEXT=EHBO_aant_keer_T2.
VARIABLE LABELS EHBO_T2 'EHBO ja/nee T2' EHBO_aant_keer_T2 'EHBO aantal keer T2'.
VALUE LABELS EHBO_T2 1 'nee' 2 'ja'.
* aantal keer van string naar numeriek.
* controle op tekst.
FREQUENCIES VARIABLES=EHBO_aant_keer_T2
  /ORDER=ANALYSIS.

** ID 3808: Dag opname.
IF (ID_Code=3808) EHBO_aant_keer_T2='1'.
EXECUTE.

** ID 4503: 1x ivm breuk in humeruskop (schouder) na ongeluk. Dit is ook de reden dat ik arts,seh,thuishulp krijg en medicatie tegen pijn gebruik.
IF (ID_Code=4503) EHBO_aant_keer_T2='1'.
EXECUTE.

ALTER TYPE EHBO_aant_keer_T2 (F3.0).

* wel naar EHBO en aant keer missing: conservatieve schatting.
DO IF EHBO_T2=2.
RECODE EHBO_aant_keer_T2 (SYSMIS=1).
END IF.
* wel naar EHBO en aant keer =0: conservatieve schatting.
DO IF EHBO_T2=2.
RECODE EHBO_aant_keer_T2 (0=1).
END IF.
EXECUTE.
* niet naar EHBO: aantal dagen =0.
DO IF (EHBO_T2=1).
RECODE EHBO_aant_keer_T2 (SYSMIS=0).
END IF.
* missings invullen.
RECODE EHBO_T2 (SYSMIS=9).
EXECUTE.
DO IF (EHBO_T2=9).
RECODE EHBO_aant_keer_T2 (SYSMIS=99).
END IF.
EXECUTE.
MISSING VALUES EHBO_T2 (9) EHBO_aant_keer_T2 (99).
VARIABLE LEVEL  EHBO_T2 (NOMINAL) EHBO_aant_keer_T2 (SCALE).
VARIABLE WIDTH  EHBO_T2 (4) EHBO_aant_keer_T2 (9).



*** Q87: ambulance********************************************************************************************************************************************.
RENAME VARIABLES Q87=ambulance_T2 / Q87_TEXT=ambulance_aant_keer_T2.
VARIABLE LABELS ambulance_T2 'ambulance ja/nee T2' ambulance_aant_keer_T2 'ambulance aantal keer T2'.
VALUE LABELS ambulance_T2 1 'nee' 2 'ja'.

* aantal keer van string naar numeriek.
* controle op tekst.
FREQUENCIES VARIABLES=ambulance_aant_keer_T2
  /ORDER=ANALYSIS.

ALTER TYPE ambulance_aant_keer_T2 (F3.0).

* wel ambulance en aant keer =0: conservatieve schatting.
DO IF ambulance_T2=2.
RECODE ambulance_aant_keer_T2 (0=1).
END IF.
* niet ambulance: aantal dagen =0.
DO IF ambulance_T2=1.
RECODE ambulance_aant_keer_T2 (SYSMIS=0).
END IF.
EXECUTE.
* missings invullen.
MISSING VALUES ambulance_aant_keer_T2 (99).
RECODE ambulance_T2 (SYSMIS=9).
EXECUTE.
DO IF (ambulance_T2=9).
RECODE ambulance_aant_keer_T2 (SYSMIS=99).
END IF.
EXECUTE.
MISSING VALUES ambulance_T2 (9) ambulance_aant_keer_T2 (99).
VARIABLE LEVEL ambulance_T2 (NOMINAL) ambulance_aant_keer_T2 (SCALE).
VARIABLE WIDTH  ambulance_T2 (4) ambulance_aant_keer_T2 (9).

*** Q88: poli********************************************************************************************************************************************.
RENAME VARIABLES Q88=poli_T2.
VARIABLE LABELS poli_T2 'bezoek poli: ja/nee T2'.
VALUE LABELS poli_T2 1 'nee' 2 'ja'.

*missing toevoegen.
RECODE poli_T2 (SYSMIS=9).
MISSING VALUES poli_T2 (9).
EXECUTE.

*Q90_1_1_TEXT t/m 6 is excact hetzelfde als Q90_2_1_TEXT t/m 6 (specialisme, inclusief zelfde spelfouten) --> Q90_2 verwijderen.
DELETE VARIABLES  Q90_2_1_TEXT Q90_2_2_TEXT Q90_2_3_TEXT Q90_2_4_TEXT Q90_2_5_TEXT Q90_2_6_TEXT.
RENAME VARIABLES  Q90_1_1_TEXT=specialisme1_T2 /  Q90_1_2_TEXT=specialisme2_T2 /   Q90_1_3_TEXT=specialisme3_T2 / 
  Q90_1_4_TEXT=specialisme4_T2 /   Q90_1_5_TEXT=specialisme5_T2 /   Q90_1_6_TEXT=specialisme6_T2. 
RENAME VARIABLES  Q90_1_1_1_TEXT=ziekenhuis1_T2 / Q90_1_2_1_TEXT=ziekenhuis2_T2 / Q90_1_3_1_TEXT=ziekenhuis3_T2 / 
Q90_1_4_1_TEXT=ziekenhuis4_T2 / Q90_1_5_1_TEXT=ziekenhuis5_T2 / Q90_1_6_1_TEXT=ziekenhuis6_T2. 
RENAME VARIABLES  Q90_2_1_1_TEXT=spec1_aant_keer_T2 / Q90_2_2_1_TEXT=spec2_aant_keer_T2 / Q90_2_3_1_TEXT=spec3_aant_keer_T2 /
Q90_2_4_1_TEXT=spec4_aant_keer_T2/Q90_2_5_1_TEXT=spec5_aant_keer_T2 /Q90_2_6_1_TEXT=spec6_aant_keer_T2 .

VARIABLE LABELS specialisme1_T2 / specialisme2_T2 / specialisme3_T2 / specialisme4_T2 / specialisme5_T2 / specialisme6_T2. 
VARIABLE LABELS ziekenhuis1_T2 / ziekenhuis2_T2 / ziekenhuis3_T2 / ziekenhuis4_T2 / ziekenhuis5_T2 / ziekenhuis6_T2. 
VARIABLE LABELS  spec1_aant_keer_T2 / spec2_aant_keer_T2 / spec3_aant_keer_T2 /  spec4_aant_keer_T2.

** specialisatie hetzelfde noemen.
FREQUENCIES VARIABLES=specialisme1_T2 specialisme2_T2 specialisme3_T2 specialisme4_T2 specialisme5_T2 specialisme6_T2
  /ORDER=ANALYSIS.

RECODE specialisme1_T2 ('cardioloog'='Cardioloog').
RECODE specialisme1_T2 ('chirurg'='Chirurg').
RECODE specialisme1_T2 ('chirurgie'='Chirurg').
RECODE specialisme1_T2 ('Chirurig'='Chirurg').
RECODE specialisme1_T2 ('chirurg'='Chirurg').
RECODE specialisme1_T2 ('dermatoloog'='Dermatoloog').
RECODE specialisme1_T2 ('reumatoloog'='Reumatoloog').
RECODE specialisme1_T2 ('Reumatolog'='Reumatoloog').
RECODE specialisme1_T2 ('Lonarts'='Longarts').
RECODE specialisme1_T2 ('Kno'='KNO').
RECODE specialisme1_T2 ('Heelkunde arts'='Chirurg').
RECODE specialisme1_T2 ('internist'='Internist').
RECODE specialisme1_T2 ('kaakchirurg'='Kaakchirurg').
RECODE specialisme1_T2 ('longarts'='Longarts').
RECODE specialisme1_T2 ('interne MLD'='MDL arts').
RECODE specialisme1_T2 ('MDL'='MDL arts').
RECODE specialisme1_T2 ('Maag/Darm/Lever specialist'='MDL arts').
RECODE specialisme1_T2 ('neuroloog'='Neuroloog').
RECODE specialisme1_T2 ('oncologie'='Oncoloog').
RECODE specialisme1_T2 ('oncologe'='Oncoloog').
RECODE specialisme1_T2 ('oncoloog'='Oncoloog').
RECODE specialisme1_T2 ('orthopeed'='Orthopeed').
RECODE specialisme1_T2 ('orthopeet'='Orthopeed').
RECODE specialisme1_T2 ('oogarts'='Oogarts').
RECODE specialisme1_T2 ('radiologie'='Radioloog').
RECODE specialisme1_T2 ('revalidatie arts'='Revalidatie arts').
RECODE specialisme1_T2 ('pijnbestrijding'='Pijnbestrijding').
RECODE specialisme1_T2 ('Orthopeet'='Orthopeed').
RECODE specialisme1_T2 ('?'='Onbekend').
RECODE specialisme1_T2 ('MDL-arts'='MDL arts').
RECODE specialisme1_T2 ('Gyneacoloog'='Gynaecoloog').
RECODE specialisme1_T2 ('Orthopedisch chirurg'='Orthopeed').
RECODE specialisme1_T2 ('plastisch chir'='Plastisch chirurg').
EXECUTE.

RECODE specialisme2_T2 ('uroloog'='Uroloog').
RECODE specialisme2_T2 ('reumatoloog'='Reumatoloog').
RECODE specialisme2_T2 ('kaakchirurg'='Kaakchirurg').
RECODE specialisme2_T2 ('internist'='Internist').
RECODE specialisme2_T2 ('Duplex'='Onbekend').
RECODE specialisme2_T2 ('Othopedie'='Orthopeed').
RECODE specialisme2_T2 ('KNO arts'='KNO').
RECODE specialisme2_T2 ('Knop arts'='KNO').
RECODE specialisme2_T2 ('Gyn'='Gynaecoloog').
RECODE specialisme2_T2 ('neuroloog'='Neuroloog').
RECODE specialisme2_T2 ('Chirurg totte'='Chirurg').
RECODE specialisme2_T2 ('endocrinoloog'='Endocrinoloog').
RECODE specialisme2_T2 ('internist oncoloog'='Oncoloog').
RECODE specialisme2_T2 ('Seh arts op seh'='SEH').
EXECUTE.

RECODE specialisme3_T2 ('longarts'='Longarts').
RECODE specialisme3_T2 ('Internis'='Internist').
RECODE specialisme3_T2 ('oogarts'='Oogarts').
RECODE specialisme3_T2 ('radio therapeut'='Radio therapeut').
RECODE specialisme3_T2 ('revalidatiearts'='Revalidatie arts').
EXECUTE.

RECODE specialisme4_T2 ('chirurg'='Chirurg').
EXECUTE.

** Aanpassingen.
*ID 1916: specialisme=echo. Staat ook bij dagbehandeling hier weg.
DO IF ID_Code=1916.
RECODE ziekenhuis1_T2 ('Bravis Bergen op Zoom'='').
RECODE specialisme1_T2 ('Echo'='').
RECODE spec1_aant_keer_T2 ('1'='').
END IF.
EXECUTE.

* ID 4503: specialisme=SEH. Staat ook bij EHBO  hier weg.
DO IF ID_Code=4503.
RECODE ziekenhuis2_T2 ('Isala'='').
RECODE specialisme2_T2 ('SEH'='').
RECODE spec2_aant_keer_T2 ('1'='').
END IF.
EXECUTE.

* ID 2705: specialisme=SEH. Staat ook bij EHBO  hier weg.
DO IF ID_Code=2705.
RECODE ziekenhuis2_T2 ('Bleuland'='').
RECODE specialisme2_T2 ('SEH'='').
RECODE spec2_aant_keer_T2 ('1'='').
END IF.
EXECUTE.

* ID 1212: specialisme3=fysio. Hier weg en bij consult fysio toevoegen.
DO IF ID_Code=1212.
RECODE ziekenhuis3_T2 ('Mcl'='').
RECODE specialisme3_T2 ('Fysio'='').
RECODE spec3_aant_keer_T2 ('1'='').
RECODE consult11_T2 (0=1).
END IF.
EXECUTE.

*ID 5206: specialisme=huisarts. Staat al bij consult HA --> hier weg.
DO IF ID_Code=5206.
RECODE ziekenhuis3_T2 ('Hamont'='').
RECODE specialisme3_T2 ('huisarts'='').
RECODE spec3_aant_keer_T2 ('3'='').
END IF.
EXECUTE.

** 5 en 6 zijn leeg.
DELETE VARIABLES ziekenhuis5_T2 specialisme5_T2 ziekenhuis6_T2 specialisme6_T2 spec5_aant_keer_T2  spec6_aant_keer_T2. 

** ziekenhuizen hetzelfde noemen.

RECODE ziekenhuis1_T2  ('azm'='AZM').
RECODE ziekenhuis1_T2  ('Azm'='AZM').
RECODE ziekenhuis1_T2  ('Academische ziekenhuis Maastricht'='AZM').
RECODE ziekenhuis1_T2  ('academisch ziekenhuis maastricht'='AZM').
RECODE ziekenhuis1_T2  ('maastricht'='AZM').
RECODE ziekenhuis1_T2  ('asz dordwijk'='ASZ').
RECODE ziekenhuis1_T2  ('Alrijeziekenhuis'='Alrijne').
RECODE ziekenhuis1_T2  ('Alrijneziekenhuis'='Alrijne').
RECODE ziekenhuis1_T2  ('Atrium Heerlen'='Zuyderland').
RECODE ziekenhuis1_T2  ('Heerlen'='Zuyderland').
RECODE ziekenhuis1_T2  ('bravis'='Bravis').
RECODE ziekenhuis1_T2  ('bravo'='Bravis').
RECODE ziekenhuis1_T2  ('Bravis Bergen op Zoom'='Bravis').
RECODE ziekenhuis1_T2  ('Bravis Bergen op zoom'='Bravis').
RECODE ziekenhuis1_T2  ('bravis bergen op zoom'='Bravis').
RECODE ziekenhuis1_T2  ('Bravis bergen op zoom'='Bravis').
RECODE ziekenhuis1_T2  ('Bravis bergen op Zoom'='Bravis').
RECODE ziekenhuis1_T2  ('Bergen op Zoom'='Bravis').
RECODE ziekenhuis1_T2  ('bravis'='Bravis').
RECODE ziekenhuis1_T2  ('n op Zoom'='Bravis').
RECODE ziekenhuis1_T2  ('cwz nijmegen'='Canisius-Wilhelmina').
RECODE ziekenhuis1_T2  ('CWZ Nijmegen'='Canisius-Wilhelmina').
RECODE ziekenhuis1_T2  ('CZE'='Catharina').
RECODE ziekenhuis1_T2  ('elkerliek deurne'='Elkerliek').
RECODE ziekenhuis1_T2  ('Elkerliek Helmond'='Elkerliek').
RECODE ziekenhuis1_T2  ('ijselland ziekenhuis'='IJsselland').
RECODE ziekenhuis1_T2  ('hoorn'='Westfriesgasthuis').
RECODE ziekenhuis1_T2  ('laurentius'='Laurentius').
RECODE ziekenhuis1_T2  ('Laurentius Ziekenhuis Roermond'='Laurentius').
RECODE ziekenhuis1_T2  ('leuven'='Leuven').
RECODE ziekenhuis1_T2  ('Lumc'='LUMC').
RECODE ziekenhuis1_T2  ('Maxima medisch centrum'='Maxima Medisch Centrum').
RECODE ziekenhuis1_T2  ('laurentius'='Laurentius').
RECODE ziekenhuis1_T2  ('MC Hoorn'='Westfriesgasthuis').
RECODE ziekenhuis1_T2  ('Westfries Gasthuis'='Westfriesgasthuis').
RECODE ziekenhuis1_T2  ('Westfries gasthuis'='Westfriesgasthuis').
RECODE ziekenhuis1_T2  ('mca'='Noordwest Ziekenhuisgroep').
RECODE ziekenhuis1_T2  ('Mcl'='MCL').
RECODE ziekenhuis1_T2  ('Medisch Centrum Leeuwarden'='MCL').
RECODE ziekenhuis1_T2  ('Mumc'='AZM').
RECODE ziekenhuis1_T2  ('olvg'='Onze Lieve Vrouwe Gasthuis').
RECODE ziekenhuis1_T2  ('rddg'='Reinier de Graaf').
RECODE ziekenhuis1_T2  ('Roermond'='Laurentius').
RECODE ziekenhuis1_T2  ('Sfg'='Sint Franciscus Gasthuis').
RECODE ziekenhuis1_T2  ('Sint Maarten kliniek nijmegen'='Sint Maartens kliniek').
RECODE ziekenhuis1_T2  ('SJG Weert'='Sint Jans Gasthuis').
RECODE ziekenhuis1_T2  ('Spaarne'='Spaarten Gasthuis').
RECODE ziekenhuis1_T2  ('Spaarten Gasthuis'='Spaarne Gasthuis').
RECODE ziekenhuis1_T2  ('UMCM'='AZM').
RECODE ziekenhuis1_T2  ('venlo'='VieCuri').
RECODE ziekenhuis1_T2  ('viecurie'='VieCuri').
RECODE ziekenhuis1_T2  ('zevenaar'='Rijnstate').
RECODE ziekenhuis1_T2  ('weert'='Sint Jans Gasthuis').
RECODE ziekenhuis1_T2  ('Weert'='Sint Jans Gasthuis').
RECODE ziekenhuis1_T2  ('Viecurie'='VieCuri').
RECODE ziekenhuis1_T2  ('maasstadziekenhuis'='Maasstad').
RECODE ziekenhuis1_T2  ('Isala Zwolle'='Isala').
RECODE ziekenhuis1_T2  ('zuyderland'='Zuyderland').
RECODE ziekenhuis1_T2  ('Zuyderland hrl'='Zuyderland').
RECODE ziekenhuis1_T2  ('Westfriesgasthuis'='Westfriesgasthuis').
RECODE ziekenhuis1_T2  ('Leuven'='UZ Leuven').
EXECUTE.


RECODE ziekenhuis2_T2  ('bravis'='Bravis').
RECODE ziekenhuis2_T2  ('Bravis Bergen op Zoom'='Bravis').
RECODE  ziekenhuis2_T2 ('Bravis Bergen op zoom'='Bravis').
RECODE ziekenhuis2_T2  ('CZE'='Catharina').
RECODE ziekenhuis2_T2  ('Catharina Ziekenhuis'='Catharina').
RECODE ziekenhuis2_T2  ('Elkerliek Helmond'='Elkerliek').
RECODE ziekenhuis2_T2  ('Lumc'='LUMC').
RECODE ziekenhuis2_T2  ('Heerlen'='Zuyderland').
RECODE ziekenhuis2_T2  ('Sittard'='Zuyderland').
RECODE ziekenhuis2_T2  ('Spaarne'='Spaarne Gasthuis').
RECODE ziekenhuis2_T2  ('Westfries Gasthuis'='Westfriesgasthuis').
RECODE  ziekenhuis2_T2 ('viecuri'='VieCuri').
RECODE ziekenhuis2_T2  ('venlo'='VieCuri').
RECODE ziekenhuis2_T2  ('bree'='Maas en Kempen Bree').
RECODE ziekenhuis2_T2  ('isala'='Isala').
RECODE ziekenhuis2_T2  ('rddg'='Reinier de Graaf').
RECODE ziekenhuis2_T2  ('Mcl'='MCL').
RECODE ziekenhuis2_T2  ('weert'='Sint Jans Gasthuis').
RECODE ziekenhuis2_T2  ('weert'='Sint Jans Gasthuis').
RECODE ziekenhuis2_T2  ('SJG Weert'='Sint Jans Gasthuis').
EXECUTE.

RECODE ziekenhuis3_T2  ('isala'='Isala').
RECODE ziekenhuis3_T2  ('Spaarne'='Spaarne Gasthuis').
RECODE ziekenhuis3_T2  ('SJG Weert'='Sint Jans Gasthuis').
RECODE ziekenhuis3_T2  ('rddg'='Reinier de Graaf').
EXECUTE.

RECODE ziekenhuis4_T2  ('Spaarne'='Spaarne Gasthuis').
EXECUTE.

FREQUENCIES VARIABLES= ziekenhuis1_T2  ziekenhuis2_T2  ziekenhuis3_T2  ziekenhuis4_T2  ziekenhuis5_T2  ziekenhuis6_T2
  /ORDER=ANALYSIS.


** Ziekenhuis algemeen of academisch. 

RECODE ziekenhuis1_T2 ziekenhuis2_T2 ziekenhuis3_T2 ziekenhuis4_T2 (CONVERT) ('onbekend'=2)
('Aken'=1) ('Alrijne'=2) ('AMC Amsterdam'=1) ('Amphia'=2) ('Anthoniushove'=2) ('Antonie van Leeuwenhoek'=2) 
('ASZ'=2) ('AZM'=1) ('Bernhoven'=2) ('Bravis'=2) ('Canisius-Wilhelmina'=2) 
('Catharina'=2) ('CWZ Nijmegen'=2) ('Dekkerswald'=2) ('Deventer'=2)  ('Diakonessenhuis'=2)  ('Diagnosecentrum Lommel'=2) 
('Elisabeth - TweeSteden Ziekehuis'=2) ('Elkerliek'=2) ('Erasmus'=1)  ('Franciscus Rotterdam'=2) ('Gelre'=2) ('Haga'=2) ('Helmond'=2)
('Hoofddorp'=2) ('IJsselland'=2) ('Ikazia'=2) ('Isala'=2) 
('Langeland'=2) ('Laurentius'=2) ('Linge polikliniek'=2) ('LUMC'=1) ('Maartenskliniek'=2) ('MeanderMC'=2) ('MMC'=2) ('Medisch centum alkmaar'=2) 
('Maas en Kempen Bree'=2) ('Maasstad'=2)  ('Maastricht UMC'=1)  ('Mariaziekenhuis Overpelt'=2)
('MC Zuiderzee'=2) ('MCL'=2) ('Meander'=2) ('Maxima Medisch Centrum'=2) ('Noordwest Ziekenhuisgroep'=2) ('Onze Lieve Vrouwe Gasthuis'=2) 
('Polikliniek Kampen'=2) ('Poli kanoën'=2) ('Radboud'=1) ('Reinier de Graaf'=2) ('Reinaart Kliniek'=2)
('Rijnstate'=2) ('Scheper'=2) ('Slotervaart'=2) ('SMT Enschede'=2) ('Sophia'=2) ('Spaarne Gasthuis'=2) 
('Spijkenisse MC'=2) ('Stadskanaal'=2) ('St.jans'=2) ('Sint Jans Gasthuis'=2) ('st Anna Geldrop'=2) ('Sint Lucas Andreas'=2)  ('Sint Maartens kliniek '=2) ('Sint Franciscus Gasthuis'=2)
('SZE'=2) ('UMCG'=1) ('UZ Leuven'=1) ('UMC Utrecht'=1) ('Viasana'=2)  ('VieCuri'=2) 
('Weert'=2) ('Westfriesgasthuis'=2) ('Zuyderland'=2) INTO ZH1_type_T2 ZH2_type_T2 ZH3_type_T2 ZH4_type_T2.
EXECUTE.

FORMATS ZH1_type_T2 ZH2_type_T2 ZH3_type_T2 ZH4_type_T2 (F1.0).
VARIABLE WIDTH ZH1_type_T2 ZH2_type_T2 ZH3_type_T2 ZH4_type_T2 (6).
VALUE LABELS ZH1_type_T2 ZH2_type_T2 ZH3_type_T2 ZH4_type_T2 1  'academisch' 2 'algemeen'.  

** aantal keer van string naar numeriek.
* controle op tekst.

RECODE spec1_aant_keer_T2  ('1 keer'='1').
RECODE spec1_aant_keer_T2  ('1x'='1').
EXECUTE.

FREQUENCIES VARIABLES=spec1_aant_keer_T2 spec2_aant_keer_T2 spec3_aant_keer_T2 spec4_aant_keer_T2
  /ORDER=ANALYSIS.
ALTER TYPE spec1_aant_keer_T2 spec2_aant_keer_T2 spec3_aant_keer_T2 spec4_aant_keer_T2  (F2.0).

*Als het aantal keer missing is wordt het 1 (conservatieve schatting).
DO IF ziekenhuis1_T2 ~=' ' .
RECODE spec1_aant_keer_T2 (SYSMIS=1).
END IF.
EXECUTE.

* 4x ja, verder niets ingevuld.
DO IF (ID_code=1813 or ID_code=2901 or ID_code=6211 or ID_code=6806).
RECODE ZH1_type_T2 (SYSMIS=2).
RECODE spec1_aant_keer_T2 (SYSMIS=1).
END IF.
EXECUTE.

VARIABLE LEVEL poli_T2 (NOMINAL).


*** Q97: dagbehandeling ***************************************************************************************************************************************.
RENAME VARIABLES Q91=dagbehandeling_T2.
VARIABLE LABELS dagbehandeling_T2 'Dagbehandeling: ja/nee'.
VARIABLE LEVEL dagbehandeling_T2 (NOMINAL).

RENAME VARIABLES Q92_1_TEXT =Dagbehandeling1_T2 / Q92_2_TEXT =Dagbehandeling2_T2 / Q92_3_TEXT=Dagbehandeling3_T2 / Q92_4_TEXT =Dagbehandeling4_T2 / 
Q92_5_TEXT =Dagbehandeling5_T2 / Q92_6_TEXT=Dagbehandeling6_T2.

RENAME VARIABLES Q93_x1_TEXT=Dagbehandeling1_aant_keer_T2 / Q93_x2_TEXT =Dagbehandeling2_aant_keer_T2 / Q93_x3_TEXT =Dagbehandeling3_aant_keer_T2 / 
Q93_x4_TEXT =Dagbehandeling4_aant_keer_T2 / Q93_x5_TEXT =Dagbehandeling5_aant_keer_T2 / Q93_x6_TEXT =Dagbehandeling6_aant_keer_T2.

** aantal keer van string naar numeriek.
RECODE Dagbehandeling1_aant_keer_T2 ('4 keer'='4') ('2x'='2').

ALTER TYPE Dagbehandeling1_aant_keer_T2 Dagbehandeling2_aant_keer_T2 Dagbehandeling3_aant_keer_T2 
    Dagbehandeling4_aant_keer_T2 Dagbehandeling5_aant_keer_T2 Dagbehandeling6_aant_keer_T2 (F2.0).

* missings.
RECODE dagbehandeling_T2 (SYSMIS=9).
EXECUTE.
MISSING VALUES  dagbehandeling_T2 (9).
VARIABLE LEVEL   dagbehandeling_T2 (NOMINAL).
VARIABLE WIDTH   dagbehandeling_T2 (7).

VARIABLE LABELS Dagbehandeling1_T2 / Dagbehandeling2_T2 / Dagbehandeling3_T2 / Dagbehandeling4_T2 / Dagbehandeling5_T2 / Dagbehandeling6_T2 /
Dagbehandeling1_aant_keer_T2 / Dagbehandeling2_aant_keer_T2 / Dagbehandeling3_aant_keer_T2 / 
Dagbehandeling4_aant_keer_T2 / Dagbehandeling5_aant_keer_T2/  Dagbehandeling6_aant_keer_T2.

***Q121: opnames************************************************************************************************************************************************************************.
RENAME VARIABLES Q94_1_1=opname_ZH_T2 / Q94_3_1_1_TEXT = opname_ZH_aant_dagen_T2 / Q94_2_1_1_TEXT = opname_ZH_aant_keer_T2. 
RENAME VARIABLES Q94_1_2=opname_rev_T2 / Q94_3_2_1_TEXT = opname_rev_aant_dagen_T2 / Q94_2_2_1_TEXT = opname_rev_aant_keer_T2. 
RENAME VARIABLES Q94_1_3=opname_psy_T2 / Q94_3_3_1_TEXT = opname_psy_aant_dagen_T2 / Q94_2_3_1_TEXT = opname_psy_aant_keer_T2.

VARIABLE LABELS opname_ZH_T2 'opname ziekenhuis: ja/nee T2'  opname_ZH_aant_dagen_T2 'opname ziekenhuis aantal dagen T2' 
opname_ZH_aant_keer_T2 'opname ziekenhuis aantal keer T2'
 opname_rev_T2 'opname revalidatie: ja/nee T2'  opname_rev_aant_dagen_T2 'opname revalidatie aantal dagen T2' 
opname_rev_aant_keer_T2 'opname revalidatie aantal keer T2' 
 opname_psy_T2 'opname psychiatrie: ja/nee T2'  opname_psy_aant_dagen_T2 'opname psychiatrie aantal dagen T2' 
opname_psy_aant_keer_T2 'opname psychiatrie aantal keer T2' .

VARIABLE LEVEL opname_ZH_T2 opname_rev_T2 opname_psy_T2 (NOMINAL).

** aantal dagen en aantal keer van string naar numeriek.
* controle tekst.
FREQUENCIES VARIABLES=opname_ZH_aant_dagen_T2 opname_rev_aant_dagen_T2 opname_psy_aant_dagen_T2 
    opname_ZH_aant_keer_T2 opname_rev_aant_keer_T2 opname_psy_aant_keer_T2
  /ORDER=ANALYSIS.

ALTER TYPE opname_ZH_aant_dagen_T2 opname_rev_aant_dagen_T2 opname_psy_aant_dagen_T2 
    opname_ZH_aant_keer_T2 opname_rev_aant_keer_T2 opname_psy_aant_keer_T2 (F3.0).

* ID 3205, 1803 en 1101 :Ja ingevuld bij alle drie, aantal keer en dagen overal leeg.
IF (ID_code=3205) opname_ZH_T2=2.
IF (ID_code=3205) opname_rev_T2=2.
IF (ID_code=3205) opname_psy_T2=2.
IF (ID_code=1803) opname_ZH_T2=2.
IF (ID_code=1803) opname_rev_T2=2.
IF (ID_code=1803) opname_psy_T2=2.
IF (ID_code=1101) opname_ZH_T2=2.
IF (ID_code=1101) opname_rev_T2=2.
IF (ID_code=1101) opname_psy_T2=2.
EXECUTE.
* alleen bij opname psychiatrie ja ingevuld, verder niets.
IF (ID_code=6001) opname_psy_T2=$SYSMIS.
* opname ZH aantal dagen is missing --> wordt 1 (conservatieve schatting).
IF (ID_code=3414) opname_ZH_aant_dagen_T2=1.
EXECUTE.

*ID 4917 heeft aantal keer en aantal dagen ongewisseld.
DO IF ID_Code=4917.
RECODE opname_ZH_aant_keer_T2 (5=1).
RECODE opname_ZH_aant_dagen_T2  (1=5).
END IF.
EXECUTE.

** als opname ziekenhuis=ja en andere twee missing--> missing wordt nee.
DO IF (opname_ZH_T2=1).
RECODE  opname_psy_T2 opname_rev_T2 (SYSMIS=2).
END IF.
EXECUTE.

** Als de vragenlijst ‘gefinished’ is de korte lijst is niet ingevuld (daarop staan geen vragen over opnames) , dan is een niet-ingevulde opname (missing) = geen opname (0).
DO IF ( Finished=1 and papier_T2<>2).
RECODE  opname_ZH_T2  opname_rev_T2 opname_psy_T2 (SYSMIS=2).
END IF.
EXECUTE.


** als opname=nee, dan wordt aantal keer en aantal dagen 0=missing.
DO IF (opname_ZH_T2=2).
RECODE  opname_ZH_aant_dagen_T2  opname_ZH_aant_keer_T2 (0=SYSMIS).
END IF.
DO IF (opname_rev_T2=2).
RECODE  opname_rev_aant_dagen_T2  opname_rev_aant_keer_T2 (0=SYSMIS).
END IF.
DO IF (opname_psy_T2=2).
RECODE  opname_psy_aant_dagen_T2  opname_psy_aant_keer_T2 (0=SYSMIS).
END IF.
EXECUTE.

*ID 5308 heeft bij datum overal 00-00-0000.
IF (ID_code=5308) Q94_4_1_1_TEXT='   '.
IF (ID_code=5308) Q94_4_2_1_TEXT='   '.
IF (ID_code=5308) Q94_4_3_1_TEXT='   '.
EXECUTE.

*** Datum omzetten van string naar date.
RECODE Q94_4_1_1_TEXT ('31-10-2016'= '31102016') ('28-04-2017'='28042017') ('26-04-2017'='26042017')  ('24-02-2017'='24022017') ('18-1-2017'='18012017') 
 ('16-04-2017'='16042017')  ('15-5-2017'='15052017') ('13/10/2016'='13102016')  ('13-04-2017'='13042017') ('10/01/2017'='10012017') ('03-07-2017'='03072017').
RECODE Q94_4_3_1_TEXT ('31-06-2016'= '31062016').

* Date and Time Wizard: opname_datum.
COMPUTE opname_ZH_datum_T2=date.dmy(number(substr(ltrim(Q94_4_1_1_TEXT),1,2),f2.0), 
    number(substr(ltrim(Q94_4_1_1_TEXT),3,2),f2.0), number(substr(ltrim(Q94_4_1_1_TEXT),5),f4.0)).
VARIABLE LEVEL   opname_ZH_datum_T2 (SCALE).
FORMATS  opname_ZH_datum_T2 (EDATE10).
VARIABLE WIDTH   opname_ZH_datum_T2(10).
EXECUTE.
* hij geeft foutmeldingen maar doet het wel goed.

* Date and Time Wizard: opname_datum.
COMPUTE opname_psy_datum_T2=date.dmy(number(substr(ltrim(Q94_4_3_1_TEXT),1,2),f2.0), 
    number(substr(ltrim(Q94_4_3_1_TEXT),3,2),f2.0), number(substr(ltrim(Q94_4_3_1_TEXT),5),f4.0)).
VARIABLE LEVEL  opname_psy_datum_T2 (SCALE).
FORMATS opname_psy_datum_T2 (EDATE10).
VARIABLE WIDTH  opname_psy_datum_T2(10).
EXECUTE.
* hij geeft foutmeldingen maar doet het wel goed.

RENAME VARIABLES Q94_4_2_1_TEXT = opname_rev_datum_T2.
VARIABLE LABELS  opname_ZH_datum_T2 'opname ziekenhuis datum T2' opname_rev_datum_T2 'opname revalidatie datum T2' opname_psy_datum_T2 'opname psychiatrie datum T2'.

** ID 4917: invuldatum klopt niet (= hier ingevoerd van papier, echte invuldatum stond op papier).
DO IF		(ID_code=4917).
COMPUTE 	invuldatum_T2 = date.dmy(05,07,2017).
END IF.
EXECUTE.

*** opnamedatum moet maximaal 3 maanden (13 weken) voor invuldatum liggen.
* ZH: Date and Time Wizard: d_opnamedatum_invuldatum.
COMPUTE  d_opnamedatum_invuldatum=DATEDIF(opname_ZH_datum_T2, invuldatum_T2, "weeks").
VARIABLE LABELS  d_opnamedatum_invuldatum "verschil opnamedatum en invuldatum in weken".
VARIABLE LEVEL  d_opnamedatum_invuldatum (SCALE).
FORMATS  d_opnamedatum_invuldatum (F5.0).
VARIABLE WIDTH  d_opnamedatum_invuldatum(5).
EXECUTE.
** Er is 1 opname psychiatrie: 8 weken verschil, dus klopt.

**ID 1602:	Opname is al vermeld op T1, hier verwijderen.
DO IF ID_code=1602.
RECODE opname_ZH_T2 (1=2).
RECODE opname_ZH_aant_dagen_T2 (2=SYSMIS).
RECODE opname_ZH_aant_keer_T2 (1=SYSMIS).
COMPUTE  opname_ZH_datum_T2 = $SYSMIS.
COMPUTE d_opnamedatum_invuldatum=$SYSMIS.
END IF.
EXECUTE.

** ID 4508	opname 28-4-2017 staat ook al vermeld op T1  hier weg.
DO IF ID_Code=4508.
RECODE  opname_ZH_T2 (1=2).
RECODE opname_ZH_aant_dagen_T2  (2=SYSMIS).
RECODE opname_ZH_aant_keer_T2 (1=SYSMIS).
COMPUTE opname_ZH_datum_T2=$SYSMIS.
END IF.


** Missings.
RECODE opname_ZH_T2  opname_rev_T2 opname_psy_T2  (SYSMIS=9).
EXECUTE.
MISSING VALUES opname_ZH_T2  opname_rev_T2 opname_psy_T2 (9).





*Q103 en verder: inkomen ****************************************************************************************************************************************************************.
RENAME VARIABLES Q95=netto_inkomen_T2  / Q96= omvang_huishouden_T2 / Q96_TEXT=huishouden_aant_pers_T2/ Q97 = huishouden_aant_kinderen_T2 
/ Q98 = inkomen_rondkomen_T2.
VALUE LABELS omvang_huishouden_T2 1 'een persoon' 2 'meer dan een persoon'.

VARIABLE LABELS huishouden_aant_pers_T2 'aantal personen in huishouden T2'.
VARIABLE LABELS  huishouden_aant_kinderen_T2 'aantal minderjarigen in huishouden T2'.
VARIABLE LABELS  netto_inkomen_T2 'netto gezinsinkomen T2'.
VARIABLE LABELS omvang_huishouden_T2 'een-of meerpersoons huishouden T2'.
VARIABLE LABELS inkomen_rondkomen_T2 'Hoe goed kunt u rondkomen met uw inkomen? T2'.

**huishouden_aant_pers_T2 en huishouden_aant_kinderen_T2 van string naar numeriek.
* controle op tekst.
FREQUENCIES VARIABLES=huishouden_aant_pers_T2 huishouden_aant_kinderen_T2
  /ORDER=ANALYSIS.
RECODE huishouden_aant_pers_T2 ('3 personen'='3') ('336'='').
RECODE huishouden_aant_kinderen_T2 ('geen'='0').
EXECUTE.
ALTER TYPE huishouden_aant_pers_T2 huishouden_aant_kinderen_T2 (F3.0).

**Als omvang_huishouden=1 , dan is aantal personen dus 1 en aantal kinderen 0 (nu missing).
DO IF (omvang_huishouden_T2=1).
RECODE huishouden_aant_pers_T2 (SYSMIS=1).
RECODE huishouden_aant_kinderen_T2 (SYSMIS=0).
END IF.
EXECUTE.

** Als omvang huishouden= meer dan 1 en aantal=1 --> omvang huishouden veranderen in eenpersoons.
DO IF (huishouden_aant_pers_T2=1).
RECODE omvang_huishouden_T2 (2=1).
END IF.
EXECUTE.

** Als omvang huishouden= meer dan 1 en aantal=0 --> omvang huishouden veranderen in eenpersoons en aantal=1.
DO IF (huishouden_aant_pers_T2=0).
RECODE omvang_huishouden_T2 (2=1).
RECODE huishouden_aant_pers_T2 (0=1).
END IF.
EXECUTE.


*ID 6209: 2 personen en 3 kinderen:.
IF (ID_code=6209)  huishouden_aant_pers_T2=5. 
EXECUTE.

* ID 4808	336 personen, kinderen niet ingevuld. Op T1 4 personen 1 kind. Overnemen van T1.
IF (ID_code=4808)  huishouden_aant_pers_T2=4. 
IF (ID_code=4808)  huishouden_aant_kinderen_T2=1. 
EXECUTE.

* ID 5902	>1, Aantal missing, T1 3 pers, 0 kinderen: overnemen van T1.
IF (ID_code=5902)  huishouden_aant_pers_T2=3. 
IF (ID_code=5902)  huishouden_aant_kinderen_T2=0. 
EXECUTE.

* ID 4907	>1, Aantal missing, T1 2 pers, 0 kinderen: overnemen van T1.
IF (ID_code=4907)  huishouden_aant_pers_T2=2. 
IF (ID_code=4907)  huishouden_aant_kinderen_T2=0. 
EXECUTE.

* berekenen individueel inkomen.
RECODE netto_inkomen_T2 (1=375) (2=875) (3=1125) (4=1375) (5=1750) (6=2250) (7=2750) (8=3250) (9=3750) (10=4250) (11=4750) (12=5250) (13=5750)
INTO netto_inkomen_continu_T2.
COMPUTE ind_inkomen_T2=netto_inkomen_continu_T2/SQRT(huishouden_aant_pers_T2).
VARIABLE LABELS  ind_inkomen_T2 'individueel inkomen T2'.
EXECUTE.

VARIABLE LEVEL netto_inkomen_T2 omvang_huishouden_T2 inkomen_rondkomen_T2 (NOMINAL).

** Missings.
RECODE netto_inkomen_T2 omvang_huishouden_T2 huishouden_aant_pers_T2 huishouden_aant_kinderen_T2 inkomen_rondkomen_T2 (SYSMIS=99).
RECODE netto_inkomen_continu_T2 ind_inkomen_T2 (SYSMIS=9999).
EXECUTE.

MISSING VALUES netto_inkomen_T2 (14,99) omvang_huishouden_T2 huishouden_aant_pers_T2 huishouden_aant_kinderen_T2 (99) inkomen_rondkomen_T2 (7,99)
netto_inkomen_continu_T2 ind_inkomen_T2 (9999).

VARIABLE LEVEL netto_inkomen_T2 inkomen_rondkomen_T2 (ORDINAL) omvang_huishouden_T2 (NOMINAL).


*** Variabelen verwijderen die omgezet zijn naar numeriek.
DELETE VARIABLES Q19 Q52  Q55_1_TEXT Q55_2_TEXT  Q58 Q94_4_1_1_TEXT Q94_4_3_1_TEXT
.







