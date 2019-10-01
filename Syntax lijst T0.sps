* Encoding: UTF-8.

* Om te zorgen dat decimalen met een punt worden geschreven (van belang bij omzetten string naar numeriek).
SET LOCALE = 'en_US'.

***RecordedDate************************************************************************************************************************************************************.
FORMATS RecordedDate (DATE11).
RENAME VARIABLES RecordedDate = Invuldatum_T0.
VARIABLE LABELS Invuldatum_T0.

***ID code******************************************************************************************************************************************************************.
RENAME VARIABLES RecipientFirstName=ID_code.
ALTER TYPE ID_code (F4.0).
VARIABLE LABELS ID_Code.

** Controleren op dubbele ID codes*****************************************************************************************************************************************.

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

*Handmatig dubbele cases controleren adhv geboortedatum, geslacht, gewicht, lengte. Indien inderdaad dubbel, de eerste en meest compleet ingevuld bewaren.
*Indien het niet dezelfde persoon is, checken bij Floor en aanpassen.

FILTER OFF.
USE ALL.
SELECT IF (ResponseId ~= 'R_RQV8e9280l5nys9' and ResponseId ~= 'R_R9be9Gr6iJ79hFn' and ResponseId ~= 'R_3Mu6zcK78F2DUWY'
and ResponseId ~= 'R_Oj6WL3EAj6fd6nv' and ResponseId ~= 'R_10VOUY2Z8vjyDD5' and ResponseId ~= 'R_2DZyWUw3YzI6M6p'  and ResponseId ~= 'R_3CJYRcfZd2ihmEY' 
and ResponseId ~= 'R_XpPyttHv5l7Ug5b' and ResponseId ~= 'R_pgAFfAPzTYfjGPT'  and ResponseId ~= 'R_57QY6nrbwBfGhTX'  and ResponseId ~= 'R_1LnD5KZLM2LJmgC'
and ResponseId ~= 'R_xDGMJ0GgZNcICxX' and ResponseId ~= 'R_31mCUi56kqlD6eB'  and ResponseId ~= 'R_55yQ41IdIT0d7sR'   and ResponseId ~= 'R_cCnRukNdGSflvdD' 
and ResponseId ~= 'R_8wwSlm80WTkUmk1'  and ResponseId ~= 'R_C1BWHNN06F3Tt05' and ResponseId ~= 'R_2chbzs7WygBxq42' and ResponseId ~= 'R_1hLLnqQKgU3Vgvp'
and ResponseId ~= 'R_3RdWTvIxwh2V4lY' and ResponseId ~= 'R_2VqKvnj0bomlKky' and ResponseId ~= 'R_XKUxgJJLhiMtOkp' and ResponseId ~= 'R_PZFCmCOIOnTSVFv' 
and ResponseId ~= 'R_33v8pODKKJPzD8K' and ResponseId ~= 'R_1ptgzVAcVOjl7IZ' and ResponseId ~='R_1osTuc9ue1fxEvD' ).
EXECUTE.

DO IF (ResponseId='R_3ORJBQOdooisZUd').
RECODE ID_code (3414=3701).
END IF.
EXECUTE.
DO IF (ResponseId='R_3shLjYdF4Zrvv2y').
RECODE ID_code (5504=5516).
END IF.
EXECUTE.

** 1 lege anonieme case.
FILTER OFF.
USE ALL.
SELECT IF (ResponseId ~= 'R_3OCcr0fcUry2X3L').
EXECUTE.

** 11 cases zijn helemaal leeg, deze verwijderen.
FILTER OFF.
USE ALL.
SELECT IF (ID_code~=1115 and ID_code~=2107 and ID_code~=3204 and ID_code~=3412 and ID_code~=3710 and ID_code~=4806 and ID_code~=4908 and  
ID_code~=5112 and ID_code~=5515 and ID_code~=5913 and ID_code~=6310).
EXECUTE.  

DELETE VARIABLES PrimaryLast.

*** Toevoegen variabele die aangeeft of vragenlijst op papier is ingevuld.
IF  (ID_code=1503 or ID_code = 2013 or ID_code= 2103 or ID_code=2109
or ID_code= 2114 or ID_code=2202 or ID_code=2207 or ID_code=2807
or ID_code=2908 or ID_code=3110 or ID_code= 3201 or ID_code=3301
or ID_code= 3310 or ID_code=3606 or ID_code=3806 or ID_code=4911
or ID_code=4912 or ID_code=4913 or ID_code=4915 or ID_code=4917
or ID_code=4918 or ID_code=4919 or ID_code=4920 or ID_code=5005
or ID_code=5304 or ID_code=5306 or ID_code=7006 or ID_code=7016) papier=1.
EXECUTE.
RECODE papier (SYSMIS=0).
EXECUTE.
FORMATS papier (F1.0).
VALUE LABELS papier 0  'digitaal ingevuld' 1 'op papier ingevuld'.
VARIABLE LABELS papier 'lijst is op papier ingevuld' .

** bij invullen op papier wordt automatisch als invuldatum de datum van invoeren op HAG gegenereerd. Dit corrigeren met datum op vragenlijst.

IF (ID_Code=1503) Invuldatum_T0=Date.dmy(29,09,2016).
IF (ID_Code=2013) Invuldatum_T0=Date.dmy(05,10,2016).
IF (ID_Code=2103) Invuldatum_T0=Date.dmy(18,10,2016).
IF (ID_Code=2109) Invuldatum_T0=Date.dmy(16,10,2016).
IF (ID_Code=2114) Invuldatum_T0=Date.dmy(18,10,2016).
IF (ID_Code=2202) Invuldatum_T0=Date.dmy(15,10,2016).
IF (ID_Code=2207) Invuldatum_T0=Date.dmy(25,10,2016).
IF (ID_Code=2807) Invuldatum_T0=Date.dmy(03,11,2016).
IF (ID_Code=2908) Invuldatum_T0=Date.dmy(02,11,2016).
IF (ID_Code=3110) Invuldatum_T0=Date.dmy(10,11,2016).
IF (ID_Code=3201) Invuldatum_T0=Date.dmy(12,12,2016).
IF (ID_Code=3301) Invuldatum_T0=Date.dmy(9,11,2016).
IF (ID_Code=3310) Invuldatum_T0=Date.dmy(9,11,2016).
IF (ID_Code=3606) Invuldatum_T0=Date.dmy(16,12,2016).
IF (ID_Code=3806) Invuldatum_T0=Date.dmy(10,01,2017).
IF (ID_Code=4911) Invuldatum_T0=Date.dmy(07,03,2017).
IF (ID_Code=4912) Invuldatum_T0=Date.dmy(09,02,2017).
IF (ID_Code=4913) Invuldatum_T0=Date.dmy(01,03,2017).
IF (ID_Code=4915) Invuldatum_T0=Date.dmy(06,03,2017).
IF (ID_Code=4917) Invuldatum_T0=Date.dmy(08,03,2017).
IF (ID_Code=4918) Invuldatum_T0=Date.dmy(01,02,2017).
IF (ID_Code=4919) Invuldatum_T0=Date.dmy(06,02,2017).
IF (ID_Code=4920) Invuldatum_T0=Date.dmy(06,03,2017).
IF (ID_Code=5005) Invuldatum_T0=Date.dmy(14,01,2017).
IF (ID_Code=5304) Invuldatum_T0=Date.dmy(21,03,2017).
IF (ID_Code=5306) Invuldatum_T0=Date.dmy(17,03,2017).
IF (ID_Code=7006) Invuldatum_T0=Date.dmy(21,04,2017).
* 7016 heeft invuldatum niet ingevuld, maar is als laatste ingevoerd, is dus ookals laatste binnen gekomen. Invuldatum zo laten staan.
EXECUTE.



DELETE VARIABLES  StartDate EndDate Status Progress Duration__in_seconds_ ResponseId ExternalReference LocationLatitude LocationLongitude DistributionChannel.

*** ontbrekende variabelen aanvullen ****************************************************************************************************************************************.
* Run syntax lijst 1lege doktersvelden aanvullen vanuit ander file.



*** Deelnemers in analyse selecteren.
*** Bestand mergen met 'deelnemers analyse.sav. Optie 0ne-to-many, Selected look up table = in analyse.sav.
FILTER OFF.
USE ALL.
SELECT IF (in_analyse=1).
EXECUTE.



*** geslacht *****************************************************************************************************************************************************************.
RENAME VARIABLES Q3=geslacht.
FORMATS geslacht (F1.0).

** Missende aanvullen uit persoonsinformatie bestand.
IF  (ID_code=1604) geslacht=1.
IF  (ID_code=3215) geslacht=1.
IF  (ID_code=3302) geslacht=1.
IF  (ID_code=4107) geslacht=1.
IF  (ID_code=6102) geslacht=1.
IF  (ID_code=7112) geslacht=2.
EXECUTE.

** ID 1911 geslacht klopt niet.
IF  (ID_code=1911) geslacht=2.
EXECUTE.


*** Q122: Geboortedatum van string naar date*******************************************************************************************************************************.

* streepjes etc verwijderen met als resultaat bv 01012001.
STRING temp1 (A20).
COMPUTE temp1=REPLACE(Q122,'-','').
EXECUTE.

STRING  temp2 (A20).
COMPUTE temp2=REPLACE(temp1,'/','').
EXECUTE.

STRING  temp3 (A20).
COMPUTE temp3=REPLACE(temp2,'.','').
EXECUTE.

STRING  temp4 (A20).
COMPUTE temp4=REPLACE(temp3,' ','').
EXECUTE.

STRING  temp5 (A20).
COMPUTE temp5=REPLACE(temp4,'o','0').
EXECUTE.

STRING  temp6 (A20).
COMPUTE temp6=REPLACE(temp5,'april','04').
EXECUTE.

STRING  temp7 (A20).
COMPUTE temp7=REPLACE(temp6,'_','').
EXECUTE.

STRING  temp8 (A20).
COMPUTE temp8=REPLACE(temp7,'\','').
EXECUTE.

COMPUTE aantalplaatsen=LENGTH(temp8).
EXECUTE.
FORMATS aantalplaatsen (F1.0).

DO IF aantalplaatsen=8.
* Date and Time Wizard: geboortedat.
COMPUTE geboortedatum=date.dmy(number(substr(ltrim(temp8),1,2),f2.0), 
    number(substr(ltrim(temp8),3,2),f2.0), number(substr(ltrim(temp8),5),f4.0)).
VARIABLE LABELS geboortedatum ''.
VARIABLE LEVEL  geboortedatum (SCALE).
FORMATS geboortedatum (DATE11).
VARIABLE WIDTH  geboortedatum(11).
END IF.
EXECUTE.

** hij geeft een foutmelding, negeren.
** Als het aantal plaatsen niet 8 is, handmatig (in syntax zetten) geboortedatum invullen.

IF (ID_Code=1508) geboortedatum=Date.dmy(23,11,1975).
IF (ID_Code=1513) geboortedatum=Date.dmy(20,07,1963).
IF (ID_Code=1607) geboortedatum=Date.dmy(12,10,1971).
IF (ID_Code=2106) geboortedatum=Date.dmy(23,07,1960).
IF (ID_Code=2307) geboortedatum=Date.dmy(22,05,1969).
IF (ID_Code=2709) geboortedatum=Date.dmy(01,08,1969).
IF (ID_Code=2908) geboortedatum=Date.dmy(07,09,1975).
IF (ID_Code=4406) geboortedatum=Date.dmy(22,02,1970).
IF (ID_Code=4703) geboortedatum=Date.dmy(09,07,1971).
IF (ID_Code=4903) geboortedatum=Date.dmy(04,07,1952).
IF (ID_Code=4914) geboortedatum=Date.dmy(18,08,1963).
IF (ID_Code=4915) geboortedatum=Date.dmy(18,08,1969).
IF (ID_Code=4918) geboortedatum=Date.dmy(29,06,1956).
IF (ID_Code=5201) geboortedatum=Date.dmy(05,09,1969).
IF (ID_Code=5208) geboortedatum=Date.dmy(24,03,1989).
IF (ID_Code=5301) geboortedatum=Date.dmy(07,07,1965).
IF (ID_Code=5306) geboortedatum=Date.dmy(04,10,1971).
IF (ID_Code=5803) geboortedatum=Date.dmy(25,02,1970).
IF (ID_Code=5902) geboortedatum=Date.dmy(30,08,1966).
IF (ID_Code=5908) geboortedatum=Date.dmy(01,09,1978).
IF (ID_Code=4705) geboortedatum=Date.dmy(28,10,1967).
IF (ID_Code=1403) geboortedatum=Date.dmy(02,11,1960).
IF (ID_Code=2111) geboortedatum=Date.dmy(12,11,1967).
IF (ID_Code=5309) geboortedatum=Date.dmy(23,11,1972).
EXECUTE.

** Missende aanvullen uit persoonsinformatie bestand.
IF (ID_Code=3215) geboortedatum=Date.dmy(16,03,1970).
IF (ID_Code=3302) geboortedatum=Date.dmy(24,06,1958).
IF (ID_Code=6102) geboortedatum=Date.dmy(17,09,1971).
IF (ID_Code=2510) geboortedatum=Date.dmy(14,06,1961).

** Missende waarvoor gebeld.
IF (ID_Code=4107) geboortedatum=Date.dmy(22,12,1965).
IF (ID_Code=7112) geboortedatum=Date.dmy(14,12,1964).

*Controle.
FREQUENCIES VARIABLES=geboortedatum
  /ORDER=ANALYSIS.
* er blijft 1 missing (pp doet niet mee, niet nagebeld).

DELETE VARIABLES temp1 temp2 temp3 temp4 temp5 temp6 temp7 temp8 aantalplaatsen.

** leeftijd.
COMPUTE leeftijd = trunc((CTIME.DAYS(Invuldatum_T0)-CTIME.DAYS(geboortedatum))/365.25) .
EXECUTE.
FORMATS leeftijd (F2.0).
* controle.
FREQUENCIES VARIABLES=leeftijd
  /ORDER=ANALYSIS.


*** Q4: lengte van string naar numeriek************************************************************************************************************************************************.
* punten, komma's en tekst verwijderen.
STRING temp1 (A20).
COMPUTE temp1=REPLACE(Q4,'.','').
EXECUTE.

STRING temp2 (A20).
COMPUTE temp2=REPLACE(temp1,',','').
EXECUTE.

STRING temp3 (A20).
COMPUTE temp3=REPLACE(temp2,'m','').
EXECUTE.

STRING temp4 (A20).
COMPUTE temp4=REPLACE(temp3,'o','0').
EXECUTE.

STRING temp5 (A20).
COMPUTE temp5=REPLACE(temp4,':','').
EXECUTE.

*controle.
FREQUENCIES VARIABLES=temp5
  /ORDER=ANALYSIS.

STRING  lengte (A8).
COMPUTE lengte=CHAR.SUBSTR(temp5,1,3).
EXECUTE.
ALTER TYPE lengte (F3.0).

*controle.
FREQUENCIES VARIABLES=lengte
  /ORDER=ANALYSIS.

* lengte 700 cm kan niet--> missing.
RECODE lengte (700=SYSMIS).
EXECUTE.

DELETE VARIABLES temp1 temp2 temp3 temp4 temp5.

*** Q5: gewicht van string naar numeriek************************************************************************************************************************************************.
* tekst verwijderen, decimaal met komma.
STRING temp1 (A20).
COMPUTE temp1=REPLACE(Q5,'kg','').
EXECUTE.

STRING temp2 (A20).
COMPUTE temp2=REPLACE(temp1,'kilo','').
EXECUTE.

STRING temp3 (A20).
COMPUTE temp3=REPLACE(temp2,'o','0').
EXECUTE.

STRING temp4 (A20).
COMPUTE temp4=REPLACE(temp3,',','.').
EXECUTE.

STRING temp5 (A20).
COMPUTE temp5=REPLACE(temp4,'sch0mmelt r0nd de 70','70').
EXECUTE.

STRING temp6 (A20).
COMPUTE temp6=REPLACE(temp5,'?',' ').
EXECUTE.

*controle.
FREQUENCIES VARIABLES=temp6
  /ORDER=ANALYSIS.

RENAME VARIABLES temp6=gewicht_T0.
ALTER TYPE gewicht_T0 (F3.1).
FREQUENCIES VARIABLES=gewicht_T0
  /ORDER=ANALYSIS.

* aanpassingen.
* 3109: 14 kg, op T1 140 kg.
IF (ID_Code=3109) gewicht_T0=140.
* 1604: Veel te zwaar kamp daar al sinds mijn jeugd mee --> missing.
IF (ID_Code=1604) gewicht_T0=$SYSMIS.
* 1116: 176 kg, op T1 84 kg --> T0 missing.
IF (ID_Code=1116) gewicht_T0=$SYSMIS.
EXECUTE.

DELETE VARIABLES temp1 temp2 temp3 temp4 temp5.

** missings.
RECODE lengte gewicht_T0 (SYSMIS=999).
EXECUTE.
MISSING VALUES lengte gewicht_T0 (999).
VARIABLE WIDTH  lengte gewicht_T0 (9).
VARIABLE LEVEL  lengte gewicht_T0 (SCALE).

*** Q6: burgelijke staat***********************************************************************************************************************************************************.
* Controle of slechts 1 optie is ingevuld:.
COMPUTE tempQ6=SUM (Q6_1,Q6_2,Q6_3,Q6_4).
EXECUTE.
FREQUENCIES VARIABLES=tempQ6
  /ORDER=ANALYSIS.

* indien dit >1 is:.
*5601: alleenstaand en vaste partner, niet samenwonend
1102: alleenstaand en gehuwd/samenwonend
5609: alleenstaand en gehuwd/samenwonend
6410: alleenstaand en gehuwd/samenwonend
6012: alleenstaand en gehuwd/samenwonend
Geven allemaal bij Q49 (rookt uw partner) ook aan een partner te hebben: .

IF (ID_Code=5601) Q6_1=$SYSMIS.
IF (ID_Code=1102) Q6_1=$SYSMIS.
IF (ID_Code=5609) Q6_1=$SYSMIS.
IF (ID_Code=6410) Q6_1=$SYSMIS.
IF (ID_Code=6012) Q6_1=$SYSMIS.
EXECUTE.

*7113: vaste partner/niet samenwonend en gehuwd/samenwonend. Wordt vaste partner/niet samenwonend.
IF (ID_Code=7113) Q6_3=$SYSMIS.

IF  (Q6_1=1) burgelijke_staat=1.
IF  (Q6_2=1) burgelijke_staat=2.
IF  (Q6_3=1) burgelijke_staat=3.
IF  (Q6_4=1) burgelijke_staat=4.
EXECUTE.
VALUE LABELS burgelijke_staat 1 'alleenstaand' 2 'vaste partner, niet samenwonend' 3 'gehuwd/samenwonend' 4 'weduwe/weduwnaar'.
FORMATS burgelijke_staat (F1.0).
DELETE VARIABLES tempQ6.

** missings.
RECODE burgelijke_staat (SYSMIS=9).
EXECUTE.
MISSING VALUES burgelijke_staat (9).
VARIABLE WIDTH burgelijke_staat (10).


*** Q63: opleiding********************************************************************************************************************************************************************.
RENAME VARIABLES Q63=opleiding.
RENAME VARIABLES Q63_9_TEXT=opleiding_anders.
FORMATS opleiding (F2.0).
VARIABLE LABELS opleiding 'hoogst afgemaakte opleiding'.
VARIABLE LABELS opleiding_anders.

FREQUENCIES VARIABLES=opleiding_anders
  /ORDER=ANALYSIS.
DO IF opleiding_anders='Financieel planner (hbo)'.
RECODE opleiding (9=7).
END IF.
DO IF opleiding_anders='Kappersschool'.
RECODE opleiding (9=5).
END IF.
DO IF opleiding_anders='vapro'.
RECODE opleiding (9=5).
END IF.
DO IF opleiding_anders='Voedingsassistente'.
RECODE opleiding (9=5).
END IF.
DO IF opleiding_anders='Mas'.
RECODE opleiding (9=5).
END IF.
DO IF opleiding_anders='Msc.'.
RECODE opleiding (9=8).
END IF.
DO IF opleiding_anders='Beveiliging'.
RECODE opleiding (9=5).
END IF.
DO IF opleiding_anders='ECABO'.
RECODE opleiding (9=5).
END IF.
DO IF opleiding_anders='mbo'.
RECODE opleiding (9=5).
END IF.
DO IF opleiding_anders='MHBO Middle Management'.
RECODE opleiding (9=5).
END IF.
DO IF opleiding_anders='Landbouw school'.
RECODE opleiding (9=5).
END IF.
DO IF opleiding_anders='VWO aangevuld met een groot scala aan vakgerelateerde opleidingen'.
RECODE opleiding (9=6).
END IF.
DO IF opleiding_anders='Universiteit, kandidaats'.
RECODE opleiding (9=6).
END IF.
DO IF opleiding_anders='Universiteit ( Marokko )'.
RECODE opleiding (9=6).
END IF.
DO IF opleiding_anders='Propedeuse Rechten'.
RECODE opleiding (9=6).
END IF.
DO IF ID_Code=3802.
RECODE opleiding (9=SYSMIS).
END IF.
DO IF opleiding_anders='HBO INformatica Propedeuse'.
RECODE opleiding (9=6).
END IF.
DO IF opleiding_anders='Ben bezig HBO lerarenopleiding'.
RECODE opleiding (9=6).
END IF.
EXECUTE.

** missings.
RECODE opleiding (SYSMIS=99).
EXECUTE.
MISSING VALUES opleiding (99).
VARIABLE WIDTH opleiding (9).
VARIABLE LEVEL opleiding (NOMINAL).

*** Q123: Uit dienst *******************************************************************************************************************************.
** controle als Q123=2: Q123_1_TEXT moet leeg zijn.
** datum uit dienst blijft voorlopig string.
RENAME VARIABLES Q123=uit_dienst/ Q123_1_TEXT =datum_uit_dienst.
VARIABLE LABELS uit_dienst 'binnen een jaar uit dienst' / datum_uit_dienst.
VALUE LABELS uit_dienst 1 'ja' 2 'nee'.
RECODE uit_dienst (SYSMIS=9).
EXECUTE.
MISSING VALUES uit_dienst (9).
VARIABLE WIDTH uit_dienst (6) datum_uit_dienst (11).
VARIABLE LEVEL uit_dienst (NOMINAL).

*** Q113/114: andere stoppen met roken programma's******************************************************************************************************************************.
RENAME VARIABLES Q113=bezig_stoppoging/  Q114 =ander_programma/  Q114_1_TEXT =ander_programma_nl. 
VARIABLE LABELS bezig_stoppoging 'al bezig met stoppoging' / ander_programma  'volgt ander programma '  / ander_programma_nl.
* als antwoord ja is en welk programma ‘nee’?  Ja wordt nee.
DO IF ander_programma=1 and ander_programma_nl='Nee'.
RECODE ander_programma (1=2).
RECODE ander_programma_nl ('Nee'='').
END IF.

RECODE bezig_stoppoging ander_programma (SYSMIS=9).
EXECUTE.
MISSING VALUES bezig_stoppoging ander_programma (9).
VARIABLE WIDTH bezig_stoppoging ander_programma (7).
VARIABLE LEVEL bezig_stoppoging ander_programma (NOMINAL).

*** Q9: startleeftijd roken**********************************************************************************************************************************************************.
RENAME VARIABLES Q9=startlft_roken.
VARIABLE LABELS startlft_roken 'leeftijd gestart met roken'.
FORMATS startlft_roken (F2.0).
FREQUENCIES VARIABLES=startlft_roken
  /ORDER=ANALYSIS.
*4907: 72, uit leeftijd en aantal rookjaren kan worden afgeleid dat dit 12 moet zijn.
IF (ID_Code=4907) startlft_roken=12.
*5911: missing, uit leeftijd en aantal rookjaren kan worden afgeleid dat dit 19 moet zijn.
IF (ID_Code=5911) startlft_roken=19.
*3809: 1, uit leeftijd en aantal rookjaren kan worden afgeleid dat dit 17 moet zijn.
IF (ID_Code=3809) startlft_roken=17.
*3802: 1, uit leeftijd en aantal rookjaren kan worden afgeleid dat dit 15 moet zijn.
IF (ID_Code=3802) startlft_roken=17.
EXECUTE.

RECODE startlft_roken (SYSMIS=999).
EXECUTE.
MISSING VALUES startlft_roken (999).
VARIABLE WIDTH startlft_roken (8).
VARIABLE LEVEL startlft_roken (SCALE).


*** Q10: Pakjaren*****************************************************************************************************************************************************************.
** controle of er geen tekst in staat.

FREQUENCIES VARIABLES=Q10_1_1_1 Q10_1_2_1 Q10_1_3_1 Q10_1_4_1 Q10_1_5_1 Q10_2_1_1 Q10_2_2_1 Q10_2_3_1 Q10_2_4_1 Q10_2_5_1
  /ORDER=ANALYSIS.
*Alle decimalen met , (punt) vervangen door . (punt).

RECODE Q10_1_2_1 ('12,'='12').
RECODE Q10_1_2_1 ('1,5'='1.5').
RECODE Q10_1_2_1 ('0,5'='0.5').
RECODE Q10_1_3_1 ('1,5'='1.5').
RECODE Q10_1_3_1 ('7,5'='7.5').
RECODE Q10_2_2_1 ('0,5'='0.5').
EXECUTE.

ALTER TYPE Q10_1_1_1 Q10_1_2_1 Q10_1_3_1 Q10_1_4_1 Q10_1_5_1 Q10_2_1_1 Q10_2_2_1 Q10_2_3_1 Q10_2_4_1 Q10_2_5_1 (F4.1).

** Indien ipv aantal jaar jaartallen zijn ingevuld, aanpassen indien mogelijk.
IF (ID_Code=1913) Q10_1_1_1=2.
IF (ID_Code=1913) Q10_1_2_1=12.
IF (ID_Code=1913) Q10_1_3_1=5.
IF (ID_Code=1913) Q10_1_4_1=13.
IF (ID_Code=1913) Q10_1_5_1=1.
IF (ID_Code=2414) Q10_1_1_1=5.
IF (ID_Code=2414) Q10_1_2_1=12.
IF (ID_Code=2414) Q10_1_3_1=7.
IF (ID_Code=2414) Q10_1_4_1=14.
IF (ID_Code=2414) Q10_1_5_1=1.
IF (ID_Code=2414) Q10_2_4_1=25.
IF (ID_Code=2414) Q10_2_5_1=25.
EXECUTE.
IF (ID_Code=2011) Q10_1_1_1=5.
IF (ID_Code=2011) Q10_1_2_1=10.
IF (ID_Code=2011) Q10_1_3_1=10.
IF (ID_Code=2011) Q10_1_4_1=15.
IF (ID_Code=2011) Q10_1_5_1=1.
EXECUTE.

** controle of aantal rookjaren klopt: uitrekenen leeftijd uit rookjaren (leeft start roken + aant jaar diverse periode moet gelijk zijn aan leeftijd).
COMPUTE lft_uit_rookjaren=SUM(startlft_roken,Q10_1_1_1,Q10_1_2_1,Q10_1_3_1,Q10_1_4_1,Q10_1_5_1).
EXECUTE.
FORMATS lft_uit_rookjaren (F2.0).

COMPUTE versch_leeft_rookjaren=leeftijd - lft_uit_rookjaren.
EXECUTE.

** adh hiervan correcties die logisch zijn, rest navragen.
IF (ID_Code=4915) Q10_1_2_1=$SYSMIS.
IF (ID_Code=4915) Q10_1_3_1=$SYSMIS.
IF (ID_Code=4915) Q10_1_4_1=$SYSMIS.
IF (ID_Code=4915) Q10_1_5_1=$SYSMIS.
IF (ID_Code=4915) Q10_2_2_1=$SYSMIS.
IF (ID_Code=4915) Q10_2_3_1=$SYSMIS.
IF (ID_Code=4915) Q10_2_4_1=$SYSMIS.
IF (ID_Code=4915) Q10_2_5_1=$SYSMIS.
EXECUTE.
IF (ID_Code=6803) Q10_1_2_1=$SYSMIS.
IF (ID_Code=6803) Q10_1_3_1=$SYSMIS.
IF (ID_Code=6803) Q10_1_4_1=$SYSMIS.
IF (ID_Code=6803) Q10_1_5_1=$SYSMIS.
IF (ID_Code=6803) Q10_2_2_1=$SYSMIS.
IF (ID_Code=6803) Q10_2_3_1=$SYSMIS.
IF (ID_Code=6803) Q10_2_4_1=$SYSMIS.
IF (ID_Code=6803) Q10_2_5_1=$SYSMIS.
EXECUTE.
IF (ID_Code=6009) Q10_1_3_1=$SYSMIS.
IF (ID_Code=6009) Q10_1_4_1=$SYSMIS.
IF (ID_Code=6009) Q10_1_5_1=$SYSMIS.
IF (ID_Code=6009) Q10_2_3_1=$SYSMIS.
IF (ID_Code=6009) Q10_2_4_1=$SYSMIS.
IF (ID_Code=6009) Q10_2_5_1=$SYSMIS.
EXECUTE.
IF (ID_Code=5606) Q10_1_3_1=$SYSMIS.
IF (ID_Code=5606) Q10_1_4_1=$SYSMIS.
IF (ID_Code=5606) Q10_2_3_1=$SYSMIS.
IF (ID_Code=5606) Q10_2_4_1=$SYSMIS.
EXECUTE.
IF (ID_Code=4917) Q10_1_2_1=$SYSMIS.
IF (ID_Code=4917) Q10_1_3_1=$SYSMIS.
IF (ID_Code=4917) Q10_1_4_1=$SYSMIS.
IF (ID_Code=4917) Q10_1_5_1=$SYSMIS.
IF (ID_Code=4917) Q10_2_2_1=$SYSMIS.
IF (ID_Code=4917) Q10_2_3_1=$SYSMIS.
IF (ID_Code=4917) Q10_2_4_1=$SYSMIS.
IF (ID_Code=4917) Q10_2_5_1=$SYSMIS.
EXECUTE.
IF (ID_Code=1711) Q10_1_5_1=$SYSMIS.
IF (ID_Code=1711) Q10_2_5_1=$SYSMIS.
EXECUTE.
IF (ID_Code=3914) Q10_1_5_1=$SYSMIS.
IF (ID_Code=3914) Q10_2_5_1=$SYSMIS.
EXECUTE.
IF (ID_Code=4910) Q10_1_3_1=$SYSMIS.
IF (ID_Code=4910) Q10_2_3_1=$SYSMIS.
EXECUTE.

RENAME VARIABLES Q10_1_1_1=roken_aantal_jaar_per1 /  Q10_1_2_1=roken_aantal_jaar_per2 /  Q10_1_3_1=roken_aantal_jaar_per3 /  Q10_1_4_1=roken_aantal_jaar_per4 /
 Q10_1_5_1=roken_aantal_jaar_per5.
RENAME VARIABLES Q10_2_1_1=roken_aantal_sig_per1 /  Q10_2_2_1=roken_aantal_sig_per2 /  Q10_2_3_1=roken_aantal_sig_per3 /  Q10_2_4_1=roken_aantal_sig_per4 /
 Q10_2_5_1=roken_aantal_sig_per5.
VARIABLE LABELS roken_aantal_jaar_per1/ roken_aantal_jaar_per2/roken_aantal_jaar_per3/ roken_aantal_jaar_per4/ roken_aantal_jaar_per5. 
VARIABLE LABELS roken_aantal_sig_per1 /roken_aantal_sig_per2 /roken_aantal_sig_per3 /roken_aantal_sig_per4 /roken_aantal_sig_per5.
* (hij geeft foutmelding, maar doet het wel goed: negeren).

** Indien verschil > of < 10 jaar is: logisch aanpassen indien mogelijk:.
**ID 1507: 10 jaar te weinig. 4 periodes, per 1 en2 +1 jaar, per 3 en 4 + 4 jaar.
DO IF (ID_code=1507).
RECODE roken_aantal_jaar_per1 (4=5).
RECODE roken_aantal_jaar_per2 (4=5).
RECODE roken_aantal_jaar_per3 (10=14).
RECODE roken_aantal_jaar_per4 (18=22).
END IF.
EXECUTE.
**ID 1606: 11 jaar te veel. 5 periodes, allen-2 en laatste -3.
DO IF (ID_code=1606).
RECODE roken_aantal_jaar_per1 (5=3).
RECODE roken_aantal_jaar_per2 (5=3).
RECODE roken_aantal_jaar_per3 (10=8).
RECODE roken_aantal_jaar_per4 (10=8).
RECODE roken_aantal_jaar_per5 (26=23).
END IF.
EXECUTE.
** ID 1607:	10 jaar te veel. Per 1: 3 minder, per 2: 7 minder.
DO IF (ID_code=1607).
RECODE roken_aantal_jaar_per1 (12=9).
RECODE roken_aantal_jaar_per2 (26=19).
END IF.
EXECUTE.
** ID 2009: 16 jaar te weinig, 2 per 2 jaar en 10 jaar: 10 wordt 26 jaar.
DO IF (ID_code=2009).
RECODE roken_aantal_jaar_per5 (10=26).
END IF.
EXECUTE.
** ID 2111:	16 jaar te veel. Per 1: -2, per 2: -4, per 3: -10.
DO IF (ID_code=2111).
RECODE roken_aantal_jaar_per1 (6=4).
RECODE roken_aantal_jaar_per2 (10=6).
RECODE roken_aantal_jaar_per3 (33=23).
END IF.
EXECUTE.
** ID 2206:	11 jaar te veel. Per 4 -2 en per 5 – 9.
DO IF (ID_code=2206).
RECODE roken_aantal_jaar_per4 (10=8).
RECODE roken_aantal_jaar_per5 (40=31).
END IF.
EXECUTE.
** ID 2307:	43 jaar te veel. Rookt gehele periode gem 12 sig (periodes met 10-12 en 15).--> uitgaan van 
	47 (leeftijd) – 8 (startleeftijd) = 39 jaar, 12 sig.
DO IF (ID_code=2307).
RECODE roken_aantal_jaar_per1 (15=39).
COMPUTE roken_aantal_jaar_per2=$SYSMIS.
COMPUTE roken_aantal_jaar_per3=$SYSMIS.
COMPUTE roken_aantal_jaar_per4=$SYSMIS.
COMPUTE roken_aantal_jaar_per5=$SYSMIS.
COMPUTE roken_aantal_sig_per2=$SYSMIS.
COMPUTE roken_aantal_sig_per3=$SYSMIS.
COMPUTE roken_aantal_sig_per4=$SYSMIS.
COMPUTE roken_aantal_sig_per5=$SYSMIS.
END IF.
EXECUTE.
**ID 2901:	14 jaar te weinig. 5 periodes van 5 jaar: elk 3 jaar erbij (eerste 2 jaar erbij).
DO IF (ID_code=2901).
RECODE roken_aantal_jaar_per1 (5=7).
RECODE roken_aantal_jaar_per2 (5=8).
RECODE roken_aantal_jaar_per3 (5=8).
RECODE roken_aantal_jaar_per4 (5=8).
RECODE roken_aantal_jaar_per5 (5=8).
END IF.
EXECUTE.
** ID 3302	12 jaar te weinig. Per 1: +5, per 2: +7.
DO IF (ID_code=3302).
RECODE roken_aantal_jaar_per1 (13=18).
RECODE roken_aantal_jaar_per2 (18=25).
END IF.
EXECUTE.
**ID 3507:	10 jaar te weinig. Een periode: +10.
DO IF (ID_code=3507).
RECODE roken_aantal_jaar_per1 (31=41).
END IF.
EXECUTE.
**ID 4105:	12 jaar te weinig. 2 periodes, per 2 wordt +12.
DO IF (ID_code=4105).
RECODE roken_aantal_jaar_per2 (32=44).
END IF.
EXECUTE.
** ID 4508: 16 jaar te veel. 5 periodes, per 1 blijft, per 2-5 elk 4 jaar minder.
DO IF (ID_code=4508).
RECODE roken_aantal_jaar_per2 (12=8).
RECODE roken_aantal_jaar_per3 (15=11).
RECODE roken_aantal_jaar_per4 (13=9).
RECODE roken_aantal_jaar_per5 (12=8).
END IF.
EXECUTE.
** ID 4601:	11 jaar te veel. per 1:-3, per 2 en 3: -4.
DO IF (ID_code=4601).
RECODE roken_aantal_jaar_per1 (5=2).
RECODE roken_aantal_jaar_per2 (15=11).
RECODE roken_aantal_jaar_per3 (20=16).
END IF.
EXECUTE.
** ID 4704:	11 jaar te weinig. Per 1 en 2: +4, per 3:+3.
DO IF (ID_code=4704).
RECODE roken_aantal_jaar_per1 (10=14).
RECODE roken_aantal_jaar_per2 (10=14).
RECODE roken_aantal_jaar_per3 (5=8).
END IF.
EXECUTE.
** ID 4905:	10 jaar te weinig. 1 periode +10.
DO IF (ID_code=4905).
RECODE roken_aantal_jaar_per1 (30=40).
END IF.
EXECUTE.
** ID 5006:	13 jaar te weinig. Per 1: +4, per 2: +9.
DO IF (ID_code=5006).
RECODE roken_aantal_jaar_per1 (5=9).
RECODE roken_aantal_jaar_per2 (15=24).
END IF.
EXECUTE.
** ID 5107:	17 jaar te weinig. 2 periodes met 10 en 12 sig. Extra periode 17 jaar, 11 sig.
DO IF (ID_code=5107).
COMPUTE roken_aantal_jaar_per3=17.
COMPUTE roken_aantal_sig_per3=11.
END IF.
EXECUTE.
** ID 5403:	17 jaar te weinig. 5 periodes van 5 jaar. 3 periodes +3 en 2 periodes +4. 
DO IF (ID_code=5403).
RECODE roken_aantal_jaar_per1 (5=8).
RECODE roken_aantal_jaar_per2 (5=8).
RECODE roken_aantal_jaar_per3 (5=8).
RECODE roken_aantal_jaar_per4 (5=9).
RECODE roken_aantal_jaar_per5 (5=9).
END IF.
EXECUTE.
** ID 5113:  5 periodes opgegeven 10 jaar te weinig. In elke periode 2 jaar erbij:.
DO IF (ID_code=5113).
RECODE roken_aantal_jaar_per1 (2=4).
RECODE roken_aantal_jaar_per2 (3=5).
RECODE roken_aantal_jaar_per3 (10=12).
RECODE roken_aantal_jaar_per4 (10=12).
RECODE roken_aantal_jaar_per5 (10=12).
END IF.
EXECUTE.
**ID 5512:	11 jaar te weinig. Maar 1 periode--> +11.
DO IF (ID_code=5512).
RECODE roken_aantal_jaar_per1 (4=15).
END IF.
EXECUTE.
** ID 5611:	18 jaar te veel. Per 1 t/m 4: -3 en per 5: -6.
DO IF (ID_code=5611).
RECODE roken_aantal_jaar_per1 (10=7).
RECODE roken_aantal_jaar_per2 (10=7).
RECODE roken_aantal_jaar_per3 (10=7).
RECODE roken_aantal_jaar_per4 (10=7).
RECODE roken_aantal_jaar_per5 (20=14).
END IF.
EXECUTE.
** ID 5803	10 jaar te weinig. 2 periodes, beide +5.
DO IF (ID_code=5803).
RECODE roken_aantal_jaar_per1 (10=15).
RECODE roken_aantal_jaar_per2 (10=15).
END IF.
EXECUTE.
** ID 6411	15 jaar te weinig. Per 1 en 2 3 jaar erbij, per 3 9 jaar erbij.
DO IF (ID_code=6411).
RECODE roken_aantal_jaar_per1 (5=8).
RECODE roken_aantal_jaar_per2 (5=8).
RECODE roken_aantal_jaar_per3 (16=25).
END IF.
EXECUTE.
** ID 7015:	15 jaar te veel. Per 1:-3, per 2: -4 en per 3:-8.
DO IF (ID_code=7015).
RECODE roken_aantal_jaar_per1 (7=4).
RECODE roken_aantal_jaar_per2 (13=9).
RECODE roken_aantal_jaar_per3 (25=17).
END IF.
EXECUTE.


** adhv aantal dagen gestopt (variabele verderop in database) kan in sommige gevallen het verschil tussen leeftijd en leeftijd_uit_rookjaren verklaard worden: er is een periode  niet gerookt.
*Correctie:.
IF (ID_Code=4902) roken_aantal_jaar_per3=25.
IF (ID_Code=4902) roken_aantal_sig_per3=0.
IF (ID_Code=5808) roken_aantal_jaar_per2=20.
IF (ID_Code=5808) roken_aantal_sig_per2=0.
IF (ID_Code=4007) roken_aantal_jaar_per3=15.
IF (ID_Code=4007) roken_aantal_sig_per3=0.
IF (ID_Code=2701) roken_aantal_jaar_per3=15.
IF (ID_Code=2701) roken_aantal_sig_per3=0.
IF (ID_Code=5502) roken_aantal_jaar_per4=10.
IF (ID_Code=5502) roken_aantal_sig_per4=0.
IF (ID_Code=4705) roken_aantal_jaar_per2=10.
IF (ID_Code=4705) roken_aantal_sig_per2=0.
IF (ID_Code=6306) roken_aantal_jaar_per4=9.
IF (ID_Code=6306) roken_aantal_sig_per4=0.
IF (ID_Code=2508) roken_aantal_jaar_per3=9.
IF (ID_Code=2508) roken_aantal_sig_per3=0.
IF (ID_Code=5801) roken_aantal_jaar_per3=8.
IF (ID_Code=5801) roken_aantal_sig_per3=0.
IF (ID_Code=2806) roken_aantal_jaar_per3=7.
IF (ID_Code=2806) roken_aantal_sig_per3=0.
IF (ID_Code=6402) roken_aantal_jaar_per3=5.
IF (ID_Code=6402) roken_aantal_sig_per3=0.
IF (ID_Code=6002) roken_aantal_jaar_per3=5.
IF (ID_Code=6002) roken_aantal_sig_per3=0.
IF (ID_Code=2303) roken_aantal_jaar_per2=5.
IF (ID_Code=2303) roken_aantal_sig_per2=0.

** Ontbrekende gegevens aanvullen waarvoor is nagebeld.
DO IF (ID_code=1116).
RECODE roken_aantal_jaar_per1 (SYSMIS=5).
RECODE roken_aantal_sig_per1 (SYSMIS=12).
RECODE roken_aantal_jaar_per2 (SYSMIS=2).
RECODE roken_aantal_sig_per2 (SYSMIS=55).
RECODE roken_aantal_jaar_per3 (SYSMIS=1).
RECODE roken_aantal_sig_per3 (SYSMIS=0).
RECODE roken_aantal_jaar_per4 (SYSMIS=21).
RECODE roken_aantal_sig_per4 (SYSMIS=25).
END IF.
EXECUTE.

DO IF (ID_code=1508).
RECODE roken_aantal_jaar_per1 (SYSMIS=34).
RECODE roken_aantal_sig_per1 (SYSMIS=29).
END IF.
EXECUTE.

DO IF (ID_code=1512).
RECODE roken_aantal_jaar_per1 (SYSMIS=26).
RECODE roken_aantal_sig_per1 (SYSMIS=5).
RECODE roken_aantal_jaar_per2 (SYSMIS=20).
RECODE roken_aantal_sig_per2 (SYSMIS=0).
END IF.
EXECUTE.

DO IF (ID_code=1513).
RECODE roken_aantal_jaar_per1 (SYSMIS=27).
RECODE roken_aantal_sig_per1 (SYSMIS=13).
END IF.
EXECUTE.

DO IF (ID_code=1604).
RECODE startlft_roken (SYSMIS=20).
RECODE roken_aantal_jaar_per1 (SYSMIS=5).
RECODE roken_aantal_sig_per1 (SYSMIS=9).
RECODE roken_aantal_jaar_per2 (SYSMIS=8).
RECODE roken_aantal_sig_per2 (SYSMIS=35).
END IF.
EXECUTE.

DO IF (ID_code=1610).
RECODE roken_aantal_jaar_per1 (SYSMIS=3).
RECODE roken_aantal_sig_per1 (SYSMIS=3).
RECODE roken_aantal_jaar_per2 (SYSMIS=6).
RECODE roken_aantal_sig_per2 (SYSMIS=6).
RECODE roken_aantal_jaar_per3 (SYSMIS=12).
RECODE roken_aantal_sig_per3 (SYSMIS=13).
END IF.

DO IF (ID_code=2502).
RECODE roken_aantal_jaar_per1 (2015=20).
RECODE roken_aantal_sig_per1 (5=6).
RECODE roken_aantal_jaar_per2 (SYSMIS=21).
RECODE roken_aantal_sig_per2 (SYSMIS=0).
END IF.

DO IF (ID_code=2507).
RECODE roken_aantal_jaar_per1 (SYSMIS=28).
RECODE roken_aantal_sig_per1 (SYSMIS=21).
END IF.

DO IF (ID_code=2706).
RECODE startlft_roken (14=17).
RECODE roken_aantal_jaar_per1 (SYSMIS=35).
RECODE roken_aantal_sig_per1 (SYSMIS=10).
END IF.
EXECUTE.

DO IF (ID_code=2708).
RECODE startlft_roken (16=18).
RECODE roken_aantal_jaar_per1 (SYSMIS=12).
RECODE roken_aantal_sig_per1 (SYSMIS=10).
RECODE roken_aantal_jaar_per2 (SYSMIS=22).
RECODE roken_aantal_sig_per2 (SYSMIS=17).
END IF.

DO IF (ID_code=3005).
RECODE roken_aantal_jaar_per1 (SYSMIS=40).
RECODE roken_aantal_sig_per1 (SYSMIS=19).
RECODE roken_aantal_jaar_per2 (SYSMIS=5).
RECODE roken_aantal_sig_per2 (SYSMIS=3).
END IF.

DO IF (ID_code=3701).
RECODE roken_aantal_jaar_per1 (SYSMIS=33).
RECODE roken_aantal_sig_per1 (SYSMIS=15).
END IF.

DO IF (ID_code=3606).
RECODE roken_aantal_jaar_per1 (5=3).
RECODE roken_aantal_sig_per1 (5=2).
RECODE roken_aantal_jaar_per2 (SYSMIS=20).
RECODE roken_aantal_sig_per2 (SYSMIS=15).
RECODE roken_aantal_jaar_per3 (SYSMIS=15).
RECODE roken_aantal_sig_per3 (SYSMIS=0).
END IF.

DO IF (ID_code=3607).
RECODE roken_aantal_jaar_per1 (SYSMIS=42).
RECODE roken_aantal_sig_per1 (SYSMIS=20).
END IF.

DO IF (ID_code=3801).
RECODE startlft_roken (SYSMIS=16).
RECODE roken_aantal_jaar_per1 (SYSMIS=40).
RECODE roken_aantal_sig_per1 (SYSMIS=9).
END IF.

DO IF (ID_code=3807).
RECODE roken_aantal_jaar_per1 (SYSMIS=27).
RECODE roken_aantal_sig_per1 (19=15).
END IF.

DO IF (ID_code=3915).
RECODE roken_aantal_jaar_per1 (SYSMIS=18).
RECODE roken_aantal_sig_per1 (SYSMIS=10).
RECODE roken_aantal_jaar_per2 (SYSMIS=2).
RECODE roken_aantal_sig_per2 (SYSMIS=3).
END IF.

DO IF (ID_code=4303).
RECODE startlft_roken (14=12).
RECODE roken_aantal_jaar_per1 (SYSMIS=10).
RECODE roken_aantal_sig_per1 (SYSMIS=17).
RECODE roken_aantal_jaar_per2 (SYSMIS=25).
RECODE roken_aantal_sig_per2 (SYSMIS=7).
END IF.

DO IF (ID_code=4402).
RECODE roken_aantal_jaar_per1 (SYSMIS=12).
RECODE roken_aantal_sig_per1 (SYSMIS=25).
RECODE roken_aantal_jaar_per2 (SYSMIS=5).
RECODE roken_aantal_sig_per2 (SYSMIS=5).
END IF.

DO IF (ID_code=4703).
RECODE startlft_roken (SYSMIS=15).
RECODE roken_aantal_jaar_per1 (SYSMIS=31).
RECODE roken_aantal_sig_per1 (SYSMIS=7).
END IF.

DO IF (ID_code=4901).
RECODE roken_aantal_jaar_per1 (SYSMIS=31).
RECODE roken_aantal_sig_per1 (SYSMIS=17).
RECODE roken_aantal_jaar_per2 (SYSMIS=4).
RECODE roken_aantal_sig_per2 (SYSMIS=0).
END IF.

DO IF (ID_code=4915).
RECODE startlft_roken (15=20).
RECODE roken_aantal_jaar_per1 (10=26).
RECODE roken_aantal_sig_per1 (20=40).
RECODE roken_aantal_jaar_per2 (SYSMIS=2).
RECODE roken_aantal_sig_per2 (SYSMIS=10).
END IF. 

DO IF (ID_code=5408).
RECODE roken_aantal_jaar_per1 (SYSMIS=5).
RECODE roken_aantal_sig_per1 (SYSMIS=15).
RECODE roken_aantal_jaar_per2 (SYSMIS=4).
RECODE roken_aantal_sig_per2 (SYSMIS=2).
END IF.

DO IF (ID_code=5506).
RECODE startlft_roken (17=14).
RECODE roken_aantal_jaar_per1 (SYSMIS=33).
RECODE roken_aantal_sig_per1 (SYSMIS=17).
RECODE roken_aantal_jaar_per2 (SYSMIS=3).
RECODE roken_aantal_sig_per2 (SYSMIS=0).
END IF. 

DO IF (ID_code=5601).
RECODE startlft_roken (16=20).
RECODE roken_aantal_jaar_per1 (5=32).
RECODE roken_aantal_sig_per1 (2=5).
RECODE roken_aantal_jaar_per2 (5=SYSMIS).
RECODE roken_aantal_sig_per2 (6=SYSMIS).
RECODE roken_aantal_jaar_per5 (6=SYSMIS).
RECODE roken_aantal_sig_per5 (8=SYSMIS).
END IF.

DO IF (ID_code=5702).
RECODE roken_aantal_jaar_per1 (SYSMIS=10).
RECODE roken_aantal_sig_per1 (10=5).
RECODE roken_aantal_jaar_per2 (SYSMIS=30).
RECODE roken_aantal_sig_per2 (SYSMIS=10).
RECODE roken_aantal_jaar_per3 (SYSMIS=5).
RECODE roken_aantal_sig_per3 (10=0).
RECODE roken_aantal_sig_per4 (10=SYSMIS).
RECODE roken_aantal_sig_per5 (10=SYSMIS).
END IF.

DO IF (ID_code=5805).
RECODE roken_aantal_jaar_per1 (SYSMIS=5).
RECODE roken_aantal_sig_per1 (SYSMIS=1).
RECODE roken_aantal_jaar_per2 (SYSMIS=10).
RECODE roken_aantal_sig_per2 (SYSMIS=10).
RECODE roken_aantal_jaar_per3 (SYSMIS=5).
RECODE roken_aantal_sig_per3 (SYSMIS=15).
END IF.

DO IF (ID_code=6807).
RECODE roken_aantal_jaar_per1 (365=18).
RECODE roken_aantal_sig_per1 (10=10).
RECODE roken_aantal_jaar_per2 (180=4).
RECODE roken_aantal_sig_per2 (5=6).
RECODE roken_aantal_jaar_per3 (500=1).
RECODE roken_aantal_sig_per3 (15=16).
END IF.

DO IF (ID_code=7012).
RECODE roken_aantal_jaar_per1 (SYSMIS=17).
RECODE roken_aantal_sig_per1 (SYSMIS=20).
END IF.

DO IF (ID_code=7103).
RECODE roken_aantal_jaar_per1 (SYSMIS=20).
RECODE roken_aantal_sig_per1 (SYSMIS=20).
RECODE roken_aantal_jaar_per2 (SYSMIS=12).
RECODE roken_aantal_sig_per2 (SYSMIS=0).
END IF.

DO IF (ID_code=7104).
RECODE roken_aantal_jaar_per1 (SYSMIS=9).
RECODE roken_aantal_sig_per1 (SYSMIS=4).
RECODE roken_aantal_jaar_per2 (SYSMIS=10).
RECODE roken_aantal_sig_per2 (SYSMIS=10).
RECODE roken_aantal_jaar_per3 (SYSMIS=14).
RECODE roken_aantal_sig_per3 (SYSMIS=15).
END IF.

DO IF (ID_code=7108).
RECODE roken_aantal_jaar_per1 (SYSMIS=7).
RECODE roken_aantal_sig_per1 (SYSMIS=3).
RECODE roken_aantal_jaar_per2 (SYSMIS=13).
RECODE roken_aantal_sig_per2 (SYSMIS=20).
RECODE roken_aantal_jaar_per3 (SYSMIS=20).
RECODE roken_aantal_sig_per3 (SYSMIS=25).
END IF.

* ID 4106 (3650 jaar,10 sig)  niet kunnen bereiken. Uitgaan van aantal jaar sinds startleeftijd.
DO IF (ID_code=4106).
RECODE roken_aantal_jaar_per1 (3650=35).
END IF.

* ID 3207 (geen aantal jaar, wel 5x aantal sigaretten) niet kunnen bereiken. Jaren verdelen over 5 periodes.
DO IF (ID_code=3207).
RECODE roken_aantal_jaar_per1 (SYSMIS=4).
RECODE roken_aantal_jaar_per2 (SYSMIS=3).
RECODE roken_aantal_jaar_per3 (SYSMIS=3).
RECODE roken_aantal_jaar_per4 (SYSMIS=3).
RECODE roken_aantal_jaar_per5 (SYSMIS=3).
END IF.

* ID 3103 (geen aantal jaar, wel 1x aantal sigaretten) niet kunnen bereiken. Uitgaan van aantal jaar sinds startleeftijd.
DO IF (ID_code=3103).
RECODE roken_aantal_jaar_per1 (SYSMIS=24).
END IF.

* ID 6005 (geen aantal jaar, wel 1x aantal sigaretten) niet kunnen bereiken. Uitgaan van aantal jaar sinds startleeftijd.
DO IF (ID_code=6005).
RECODE roken_aantal_jaar_per1 (SYSMIS=24).
END IF.

* ID 1902 (geen aantal jaar, wel 5x aantal sigaretten) niet kunnen bereiken. Jaren verdelen over 5 periodes.
DO IF (ID_code=1902).
RECODE roken_aantal_jaar_per1 (SYSMIS=2).
RECODE roken_aantal_jaar_per2 (SYSMIS=3).
RECODE roken_aantal_jaar_per3 (SYSMIS=3).
RECODE roken_aantal_jaar_per4 (SYSMIS=3).
RECODE roken_aantal_jaar_per5 (SYSMIS=3).
END IF.

* ID 2404	25 jaar te weinig. Te groot verschil, niet te pakken gekregen. Missing maken.
DO IF (ID_code=2404).
RECODE roken_aantal_jaar_per1 (7=SYSMIS).
RECODE roken_aantal_jaar_per2 (6=SYSMIS).
RECODE roken_aantal_sig_per1 (25=SYSMIS).
RECODE roken_aantal_sig_per2 (18=SYSMIS).
END IF.

* ID 3915	met gecorrigeerde gegevens nog 21 jaar verschil. Missing maken.
DO IF (ID_code=3915).
RECODE roken_aantal_jaar_per1 (18=SYSMIS).
RECODE roken_aantal_jaar_per2 (2=SYSMIS).
RECODE roken_aantal_sig_per1 (10=SYSMIS).
RECODE roken_aantal_sig_per2 (3=SYSMIS).
END IF.

* ID 6810	20 jaar te weinig, niet te pakken gekregen. Missing maken.
DO IF (ID_code=6810).
RECODE roken_aantal_jaar_per1 (5=SYSMIS).
RECODE roken_aantal_sig_per1 (15=SYSMIS).
END IF.

* ID 3908	20 jaar te weinig, niet te pakken gekregen. Missing maken.
DO IF (ID_code=3908).
RECODE roken_aantal_jaar_per5 (15=SYSMIS).
RECODE roken_aantal_sig_per5 (30=SYSMIS).
END IF.

*ID 1113	13 jaar te weinig, 1 sig p/d, niet te pakken gekregen. Missing maken.
DO IF (ID_code=1113).
RECODE roken_aantal_jaar_per1 (7=SYSMIS).
RECODE roken_aantal_sig_per1 (1=SYSMIS).
END IF.

* ID 1513	met gecorrigeerde gegevens nog 11 jaar te weinig. Stopperiode van 4 maanden. Aantal jaar corrigeren naar leeftijd-startleeftijd? Ja, 11 jaar erbij.
DO IF (ID_code=1513).
RECODE roken_aantal_jaar_per1 (27=38).
END IF.

* ID 3807	met gecorrigeerde gegevens nog 11 jaar te weinig. 11 jaar erbij. Stopperiode van 240 maanden=20 jaar.--> missing.
DO IF (ID_code=3807).
RECODE roken_aantal_jaar_per1 (27=38).
END IF.

** opnieuw controle of aantal rookjaren klopt: uitrekenen leeftijd uit rookjaren (leeft start roken + aant jaar diverse periode moet gelijk zijn aan leeftijd).
COMPUTE lft_uit_rookjaren2=SUM(startlft_roken, roken_aantal_jaar_per1, roken_aantal_jaar_per2, roken_aantal_jaar_per3, roken_aantal_jaar_per4, roken_aantal_jaar_per5).
EXECUTE.
FORMATS lft_uit_rookjaren2 (F2.0).
VARIABLE LABELS lft_uit_rookjaren2  'leeftijd uit rookjaren na correcties'.
COMPUTE versch_leeft_rookjaren2=leeftijd - lft_uit_rookjaren2.
EXECUTE.

** Pakjaren berekenen.
COMPUTE packyears_per1=(roken_aantal_jaar_per1 * roken_aantal_sig_per1)/20.
COMPUTE packyears_per2=(roken_aantal_jaar_per2 * roken_aantal_sig_per2)/20.
COMPUTE packyears_per3=(roken_aantal_jaar_per3 * roken_aantal_sig_per3)/20.
COMPUTE packyears_per4=(roken_aantal_jaar_per4 * roken_aantal_sig_per4)/20.
COMPUTE packyears_per5=(roken_aantal_jaar_per5 * roken_aantal_sig_per5)/20.
COMPUTE packyears= SUM (packyears_per1, packyears_per2, packyears_per3, packyears_per4, packyears_per5).
EXECUTE.

DELETE VARIABLES packyears_per1 packyears_per2 packyears_per3 packyears_per4 packyears_per5. 

* Q11,12,13,14,15,16,28: vragen over roken***********************************************************************************************************************************.
RENAME VARIABLES Q11= roken1_T0/ Q12=roken2_T0 / Q13=roken3_T0 / Q14=roken4_T0 / Q15=roken5_T0 / Q16=roken6_T0 / Q28=roken7_T0.
RECODE roken1_T0 roken2_T0 roken3_T0 roken4_T0 roken5_T0 roken6_T0 roken6_T0 roken7_T0 (SYSMIS=9).
EXECUTE.
MISSING VALUES roken1_T0 roken2_T0 roken3_T0 roken4_T0 roken5_T0 roken6_T0 roken6_T0 roken7_T0 (9).
VARIABLE LEVEL roken1_T0 roken2_T0 roken3_T0 roken4_T0 roken5_T0 roken6_T0 roken6_T0 roken7_T0 (NOMINAL).
VARIABLE WIDTH roken1_T0 roken2_T0 roken3_T0 roken4_T0 roken5_T0 roken6_T0 roken6_T0 roken7_T0 (5).

RECODE roken1_T0 (1=3) (2=2) (3=1) (4=0) into fagerstrom1_T0.
RECODE roken2_T0 (1=1) (2=0)  into fagerstrom2_T0.
RECODE roken3_T0 (1=1) (2=0)  into fagerstrom3_T0.
RECODE roken4_T0 (1=0) (2=1) (3=2) (4=3) into fagerstrom4_T0.
RECODE roken5_T0 (1=1) (2=0)  into fagerstrom5_T0.
RECODE roken6_T0 (1=1) (2=0)  into fagerstrom6_T0.
EXECUTE.

COMPUTE fagerstromscore=fagerstrom1_T0 +fagerstrom2_T0 +fagerstrom3_T0+fagerstrom4_T0+ fagerstrom5_T0+fagerstrom6_T0.
EXECUTE.


** Q19 - Q27: stoppen met roken *************************************************************************************************************************************************.
RENAME VARIABLES Q19=stoppen_T0 / Q20_1=stoppen_maanden_T0 / Q20_2=stoppen_weken_T0 / Q20_3=stoppen_dagen_T0 .
VARIABLE LABELS stoppen_maanden_T0 'stoppoging aantal maanden' /  stoppen_weken_T0 'stoppoging aantal weken' /  stoppen_dagen_T0 'stoppoging aantal dagen'.
FORMATS stoppen_maanden_T0 stoppen_weken_T0 stoppen_dagen_T0  (F4.0).
VARIABLE LEVEL stoppen_T0 (NOMINAL).

* controle ingevulde aantal maanden/weken/dagen.
* aantal weken/4 kan niet groter zijn dan aantal maanden.
IF  ((stoppen_maanden_T0 >0) and (stoppen_weken_T0 / 4 >= stoppen_maanden_T0)) klopt_niet=1.
EXECUTE.
* aantal dagen/7 kan niet groter zijn dan aantal weken.
IF  ((stoppen_weken_T0 >0) and (stoppen_dagen_T0 / 7 >= stoppen_weken_T0)) klopt_niet=1.
EXECUTE.
* 4 weken of veelvoud is raar (=nl 1 maand).
IF (stoppen_weken_T0=4  or stoppen_weken_T0=8  or stoppen_weken_T0=12 or stoppen_weken_T0=16 or stoppen_weken_T0=20 or stoppen_weken_T0=24 or stoppen_weken_T0=28 or 
stoppen_weken_T0=32 or stoppen_weken_T0=36 or stoppen_weken_T0=40 or stoppen_weken_T0=44 or stoppen_weken_T0=48 or stoppen_weken_T0=52) klopt_niet=1.
EXECUTE. 
* 7 weken of veelvoud is raar (=nl 1 week).
IF (stoppen_dagen_T0=7 or stoppen_dagen_T0=14 or stoppen_dagen_T0=21) klopt_niet=1.
EXECUTE.

** Cases met 'klopt_niet'=1 beoordelen en evt aanpassen.
IF (ID_Code=1606) stoppen_dagen_T0=0.
IF (ID_Code=1606) stoppen_weken_T0=0.
IF (ID_Code=2001) stoppen_weken_T0=0.
IF (ID_Code=2402) stoppen_dagen_T0=0.
IF (ID_Code=2402) stoppen_weken_T0=0.
IF (ID_Code=2708) stoppen_dagen_T0=0.
IF (ID_Code=2708) stoppen_weken_T0=0.
IF (ID_Code=2901) stoppen_dagen_T0=0.
IF (ID_Code=3202) stoppen_dagen_T0=0.
IF (ID_Code=3904) stoppen_dagen_T0=0.
IF (ID_Code=3904) stoppen_weken_T0=0.
IF (ID_Code=6605) stoppen_dagen_T0=0.
IF (ID_Code=6605) stoppen_weken_T0=0.
DO IF (ID_Code=1606 or ID_Code=2001 or ID_Code=2402 or ID_Code=2708 or ID_Code=2901 or ID_Code=3202 or ID_Code=3904 or ID_Code=6605).
RECODE  klopt_niet (1=SYSMIS).
END IF.

** Cases met 'klopt_niet' die wel kunnen kloppen.
DO IF (ID_Code=2911 or ID_Code=3707 or  ID_Code=7005 or ID_Code=2505 or ID_Code=6801 or ID_Code=5509 or ID_Code=5707 or ID_Code=7113
 or ID_Code=1402  or ID_Code=6309  or ID_Code=4907  or ID_Code=2304).
RECODE  klopt_niet (1=SYSMIS).
END IF.

** Nog 15 cases 'klopt_niet', blijven zo staan, behalve 3x extreme waardes die niet kunnen kloppen (gezien rookgeschiedenis), die worden misisng:.
IF (ID_Code=4504) stoppen_dagen_T0=999.
IF (ID_Code=4504) stoppen_weken_T0=999.
IF (ID_Code=4504) stoppen_maanden_T0=999.
IF (ID_Code=4509) stoppen_dagen_T0=999.
IF (ID_Code=4509) stoppen_weken_T0=999.
IF (ID_Code=4509) stoppen_maanden_T0=999.
IF (ID_Code=3807) stoppen_dagen_T0=999.
IF (ID_Code=3807) stoppen_weken_T0=999.
IF (ID_Code=3807) stoppen_maanden_T0=999.

*** Indien een van de drie is ingevuld en rest missing: missing wordt 0.
DO IF (NVALID(stoppen_maanden_T0,stoppen_weken_T0,stoppen_dagen_T0)>=1).
RECODE stoppen_maanden_T0 stoppen_weken_T0 stoppen_dagen_T0 (SYSMIS=0).
END IF.
EXECUTE.

** totaal aantal dagen berekenen.
COMPUTE  stoppen_totdagen_T0=(stoppen_maanden_T0*30) + (stoppen_weken_T0*7) + stoppen_dagen_T0.
EXECUTE.
FORMATS stoppen_totdagen_T0 (F4.0).
VARIABLE LABELS stoppen_totdagen_T0 'totaal aantal dagen gestopt'.

DELETE VARIABLES klopt_niet.

** missings.
RECODE stoppen_T0 (SYSMIS=9).

*** Indien stoppen=nee en rest is sysmis: sysmis wordt 888 (nvt).
DO IF (stoppen_T0=2).
RECODE stoppen_dagen_T0 stoppen_weken_T0 stoppen_maanden_T0 (SYSMIS=888).
RECODE stoppen_totdagen_T0 (SYSMIS=8888).
END IF.
*** Indien stoppen=ja of missing en rest is sysmis: sysmis wordt 999.
DO IF (stoppen_T0=1 or stoppen_T0=9).
RECODE stoppen_dagen_T0 stoppen_weken_T0 stoppen_maanden_T0 (SYSMIS=999).
RECODE stoppen_totdagen_T0 (SYSMIS=9999).
END IF.
EXECUTE.
MISSING VALUES stoppen_T0 (9) stoppen_dagen_T0 stoppen_weken_T0 stoppen_maanden_T0 (888,999) stoppen_totdagen_T0 (8888,9999).

***Q21 hulpmiddelen**************************************************************************************************************************************.

RENAME VARIABLES Q21_1=hulpmiddel1_T0 / Q21_2=hulpmiddel2_T0 / Q21_3=hulpmiddel3_T0 / Q21_4=hulpmiddel4_T0 / 
Q21_5=hulpmiddel5_T0 / Q21_6=hulpmiddel6_T0 / Q21_7=hulpmiddel7_T0 / Q21_8=hulpmiddel8_T0 / Q21_9=hulpmiddel9_T0 / Q21_10=hulpmiddel10_T0.

VARIABLE LABELS hulpmiddel1_T0 'hulpmiddel: nicotinevervangers' hulpmiddel2_T0 'hulpmiddel: medicijnen' hulpmiddel3_T0 'hulpmiddel: gedragsmatige ondersteuning' 
hulpmiddel4_T0 'hulpmiddel: elektronische sigaretten' hulpmiddel5_T0 'hulpmiddel: boeken' hulpmiddel6_T0 'hulpmiddel: websites' hulpmiddel7_T0 'hulpmiddel: apps' 
hulpmiddel8_T0 'hulpmiddel: andere hulpmiddelen' hulpmiddel9_T0 'hulpmiddel: geen' hulpmiddel10_T0 'hulpmiddel: weet het niet meer'.

VALUE LABELS hulpmiddel1_T0 hulpmiddel2_T0 hulpmiddel3_T0 hulpmiddel4_T0 hulpmiddel5_T0 hulpmiddel6_T0 hulpmiddel7_T0 hulpmiddel8_T0 hulpmiddel9_T0 hulpmiddel10_T0
 0 'nee'1 'ja'.

VARIABLE LEVEL  hulpmiddel1_T0 hulpmiddel2_T0 hulpmiddel3_T0 hulpmiddel4_T0 hulpmiddel5_T0 hulpmiddel6_T0 hulpmiddel7_T0 hulpmiddel8_T0 hulpmiddel9_T0 hulpmiddel10_T0
(NOMINAL).
VARIABLE WIDTH  hulpmiddel1_T0 hulpmiddel2_T0 hulpmiddel3_T0 hulpmiddel4_T0 hulpmiddel5_T0 hulpmiddel6_T0 hulpmiddel7_T0 hulpmiddel8_T0 hulpmiddel9_T0 hulpmiddel10_T0
(5).

* als er minimaal 1 is ingevuld en de rest sysmis, dan is sysmis 0 (hulpmiddel wordt niet gebruikt).
COMPUTE temp_aant_missings_hulpmiddelen=NMISS(hulpmiddel1_T0,hulpmiddel2_T0,hulpmiddel3_T0,hulpmiddel4_T0,hulpmiddel5_T0,
hulpmiddel6_T0,hulpmiddel7_T0,hulpmiddel8_T0,hulpmiddel9_T0,hulpmiddel10_T0).
EXECUTE.
DO IF (temp_aant_missings_hulpmiddelen < 10).
RECODE hulpmiddel1_T0 hulpmiddel2_T0 hulpmiddel3_T0 hulpmiddel4_T0 hulpmiddel5_T0 hulpmiddel6_T0 
    hulpmiddel7_T0 hulpmiddel8_T0 hulpmiddel9_T0 hulpmiddel10_T0 (SYSMIS=0).
END IF.
EXECUTE.

DELETE VARIABLES temp_aant_missings_hulpmiddelen.

*Van de 626 ‘gefinishde’ vragenlijsten zijn er 109 volledig missing op deze variabelen.
*Als de vraag daarna (Q22) wel is ingevuld en Finished=1, wordt ervan uit gegaan dat deze mensen geen hulpmiddelen hebben gebruikt 
en optie _9 ‘Geen hulpmiddelen of methoden’ niet hebben gezien en dus nergens wat hebben aangekruist.
*Dan wordt gehercodeerd naar 0 (en _9 naar 1).

DO IF (Finished=1 and SYSMIS(Q22)=0).
RECODE hulpmiddel1_T0 hulpmiddel2_T0 hulpmiddel3_T0 hulpmiddel4_T0 hulpmiddel5_T0 hulpmiddel6_T0 
    hulpmiddel7_T0 hulpmiddel8_T0 hulpmiddel10_T0 (SYSMIS=0).
RECODE hulpmiddel9_T0 (SYSMIS=1).
END IF.
EXECUTE.

* Geen hulpmiddelen is 20x aangekruisd, maar daarnaast is in 17 gevallen ook nog wat anders aangekruisd.
* In die gevallen 'geen hulpmiddelen' hercoderen naar 0.
DO IF (hulpmiddel1_T0=1 or hulpmiddel2_T0=1 or hulpmiddel3_T0=1 or hulpmiddel4_T0=1 or 
    hulpmiddel5_T0=1 or hulpmiddel6_T0=1 or hulpmiddel7_T0=1 or hulpmiddel8_T0=1).
RECODE hulpmiddel9_T0 (1=0).
END IF.
EXECUTE.

* Rest is echt missing.
RECODE hulpmiddel1_T0 hulpmiddel2_T0 hulpmiddel3_T0 hulpmiddel4_T0 hulpmiddel5_T0 hulpmiddel6_T0 
    hulpmiddel7_T0 hulpmiddel8_T0 hulpmiddel9_T0 hulpmiddel10_T0 (SYSMIS=9).
EXECUTE.
MISSING VALUES  hulpmiddel1_T0 hulpmiddel2_T0 hulpmiddel3_T0 hulpmiddel4_T0 hulpmiddel5_T0 hulpmiddel6_T0 
    hulpmiddel7_T0 hulpmiddel8_T0 hulpmiddel9_T0 hulpmiddel10_T0 (9).

*** Q22-27: stopppen *************************************************************************************************************************************************************************.
RENAME VARIABLES Q22=stoppen1_T0 / Q23=stoppen2_T0 / Q24=stoppen3_T0 / Q25=stoppen4_T0 / Q26=stoppen5_T0 / Q27=stoppen6_T0.

*Indien stoppen4 =1 (nooit), dan moet stoppen5 missing zijn.

USE ALL.
COMPUTE filter_$=(stoppen4_T0=1).
VARIABLE LABELS filter_$ 'stoppen4_T0=1 (FILTER)'.
VALUE LABELS filter_$ 0 'Not Selected' 1 'Selected'.
FORMATS filter_$ (f1.0).
FILTER BY filter_$.
EXECUTE.
FREQUENCIES VARIABLES=stoppen5_T0
  /ORDER=ANALYSIS.
USE ALL.

** deze missing wordt nvt (nieuwe code).
IF  (stoppen4_T0=1) stoppen5_T0=8.
EXECUTE.
VALUE LABELS stoppen5_T0 1 '(bijna) allemaal positief' 2 'meestal positief'  3 'even vaak positief als negatief' 4 'meestal negatief' 5 '(bijna) allemaal negatief' 8 'nvt'. 

** missings.
RECODE stoppen1_T0 stoppen2_T0 stoppen3_T0 stoppen4_T0 stoppen5_T0 stoppen6_T0 (SYSMIS=9).
EXECUTE.
MISSING VALUES stoppen1_T0 stoppen2_T0 stoppen3_T0 stoppen4_T0 stoppen5_T0 stoppen6_T0 (8,9).
VARIABLE LEVEL stoppen1_T0 stoppen2_T0 stoppen3_T0 stoppen4_T0 stoppen5_T0 stoppen6_T0 (ORDINAL).


*** Q30/Q36: EQ5D **************************************************************************************************************************************************************************.
RENAME VARIABLES Q30=EQ5D_1_T0 / Q31=EQ5D_2_T0 / Q32=EQ5D_3_T0 / Q33=EQ5D_4_T0 / Q34=EQ5D_5_T0.
VARIABLE LABELS EQ5D_1_T0 'EQ5D mobiliteit T0' EQ5D_2_T0 'EQ5D zelfzorg T0' 
EQ5D_3_T0 'EQ5D ADL T0' EQ5D_4_T0 'EQ5D pijn/ongemak T0' EQ5D_5_T0 'EQ5D angst/somberheid T0'.

RENAME VARIABLES Q36=EQ5D_VAS_T0.
VARIABLE LABELS EQ5D_VAS_T0 'EQ5D gezondheid T0'.
FORMATS EQ5D_VAS_T0 (F3.0).

*** totaalscore EQ.
* Based on the following publication: Versteegh, M. M., Vermeulen, K. M., Evers, S. M., de Wit, G. A., Prenger, R., & Stolk, E. A. (2016) 
Dutch Tariff for the Five-Level Version of EQ-5D. Value in Health, 2016. doi:10.1016/j.jval.2016.01.003 .

COMPUTE EQ5D_T0 = 1.
DO IF (NVALID(EQ5D_1_T0, EQ5D_2_T0, EQ5D_3_T0, EQ5D_4_T0, EQ5D_5_T0) < 5).
RECODE EQ5D_T0 (1 = SYSMIS).
END IF.
IF (max(EQ5D_1_T0, EQ5D_2_T0, EQ5D_3_T0, EQ5D_4_T0, EQ5D_5_T0)>1)EQ5D_T0 = EQ5D_T0 - .0469233.
IF (EQ5D_1_T0 = 2) EQ5D_T0 = EQ5D_T0 - .0354544.
IF (EQ5D_1_T0 = 3) EQ5D_T0 = EQ5D_T0 - .0565962.
IF (EQ5D_1_T0 = 4) EQ5D_T0 = EQ5D_T0 - .166003.
IF (EQ5D_1_T0 = 5) EQ5D_T0 = EQ5D_T0 - .2032975.

IF (EQ5D_2_T0 = 2) EQ5D_T0 = EQ5D_T0 - .0381079.
IF (EQ5D_2_T0 = 3) EQ5D_T0 = EQ5D_T0 - .0605347.
IF (EQ5D_2_T0 = 4) EQ5D_T0 = EQ5D_T0 - .1677852.
IF (EQ5D_2_T0 = 5) EQ5D_T0 = EQ5D_T0 - .1677852.

IF (EQ5D_3_T0 = 2) EQ5D_T0 = EQ5D_T0 - .0391539.
IF (EQ5D_3_T0 = 3) EQ5D_T0 = EQ5D_T0 - .0867559.
IF (EQ5D_3_T0 = 4) EQ5D_T0 = EQ5D_T0 - .1924631.
IF (EQ5D_3_T0 = 5) EQ5D_T0 = EQ5D_T0 - .1924631.

IF (EQ5D_4_T0 = 2) EQ5D_T0 = EQ5D_T0 - .0658959.
IF (EQ5D_4_T0 = 3) EQ5D_T0 = EQ5D_T0 - .0919619.
IF (EQ5D_4_T0 = 4) EQ5D_T0 = EQ5D_T0 - .35993.
IF (EQ5D_4_T0 = 5) EQ5D_T0 = EQ5D_T0 - .4152142.

IF (EQ5D_5_T0 = 2) EQ5D_T0 = EQ5D_T0 - .069622.
IF (EQ5D_5_T0 = 3) EQ5D_T0 = EQ5D_T0 - .1445222.
IF (EQ5D_5_T0 = 4) EQ5D_T0 = EQ5D_T0 - .3563913.
IF (EQ5D_5_T0 = 5) EQ5D_T0 = EQ5D_T0 - .4206361.

EXECUTE.

* missings.
RECODE EQ5D_1_T0 EQ5D_2_T0 EQ5D_3_T0 EQ5D_4_T0 EQ5D_5_T0 EQ5D_T0  (SYSMIS=99).
RECODE EQ5D_VAS_T0  (SYSMIS=999).
EXECUTE.
MISSING VALUES EQ5D_1_T0 EQ5D_2_T0 EQ5D_3_T0 EQ5D_4_T0 EQ5D_5_T0 EQ5D_T0 (99) EQ5D_VAS_T0 (999).
VARIABLE LABELS EQ5D_T0 'EQ5D tot score T0'.
VARIABLE LEVEL  EQ5D_1_T0 EQ5D_2_T0 EQ5D_3_T0 EQ5D_4_T0 EQ5D_5_T0 (ORDINAL).
VARIABLE WIDTH  EQ5D_1_T0 EQ5D_2_T0 EQ5D_3_T0 EQ5D_4_T0 EQ5D_5_T0 (5).

** Q38/39/40: CCQ***************************************************************************************************************************************************************.
RENAME VARIABLES Q38_1=CCQ1_T0 / Q38_2=CCQ2_T0 / Q38_3=CCQ3_T0 / Q38_4=CCQ4_T0 / Q39_1=CCQ5_T0 / Q39_2=CCQ6_T0 / 
Q40_1=CCQ7_T0 / Q40_2=CCQ8_T0 / Q40_3=CCQ9_T0 / Q40_4=CCQ10_T0.
VARIABLE LABELS CCQ1_T0 'CCQ kortademig rust T0' CCQ2_T0 'CCQ kortademig lich inspanning T0' CCQ3_T0 'CCQ angstig/bezorgd T0' CCQ4_T0 'CCQ neerslachtig T0' 
CCQ5_T0 'CCQ gehoest T0' CCQ6_T0 'CCQ slijm opgehoest T0' CCQ7_T0 'CCQ beperkt bij zware lich activiteit T0' CCQ8_T0 'CCQ beperkt bij matige lich activiteit T0' 
CCQ9_T0 'CCQ beperkt bij dagelijkse activiteiten T0' CCQ10_T0 'CCQ beperkt bij sociale activiteiten T0'. 

*** CCQ totaalscores.
*minimum aantal missings??.
COMPUTE CCQ_tot_T0=MEAN(CCQ1_T0,CCQ2_T0,CCQ3_T0,CCQ4_T0,CCQ5_T0,CCQ6_T0,CCQ7_T0,CCQ8_T0,CCQ9_T0, CCQ10_T0).
COMPUTE CCQ_klachten_T0=MEAN(CCQ1_T0,CCQ2_T0,CCQ5_T0,CCQ6_T0).
COMPUTE CCQ_emoties_T0=MEAN(CCQ3_T0,CCQ4_T0).
COMPUTE CCQ_conditie_T0=MEAN(CCQ7_T0,CCQ8_T0,CCQ9_T0, CCQ10_T0).
EXECUTE.

** missings.
RECODE CCQ1_T0 CCQ2_T0 CCQ3_T0 CCQ4_T0 CCQ5_T0 CCQ6_T0 CCQ7_T0 CCQ8_T0 CCQ9_T0 CCQ10_T0 (SYSMIS=99).
RECODE CCQ_tot_T0 CCQ_klachten_T0 CCQ_emoties_T0 CCQ_conditie_T0 (SYSMIS=99).
EXECUTE.
MISSING VALUES CCQ1_T0 CCQ2_T0 CCQ3_T0 CCQ4_T0 CCQ5_T0 CCQ6_T0 CCQ7_T0 CCQ8_T0 CCQ9_T0 CCQ10_T0
 CCQ_tot_T0 CCQ_klachten_T0 CCQ_emoties_T0 CCQ_conditie_T0 (99).
VARIABLE LEVEL CCQ1_T0 CCQ2_T0 CCQ3_T0 CCQ4_T0 CCQ5_T0 CCQ6_T0 CCQ7_T0 CCQ8_T0 CCQ9_T0 CCQ10_T0 (ORDINAL).
VARIABLE WIDTH CCQ1_T0 CCQ2_T0 CCQ3_T0 CCQ4_T0 CCQ5_T0 CCQ6_T0 CCQ7_T0 CCQ8_T0 CCQ9_T0 CCQ10_T0 (4).
VARIABLE WIDTH CCQ_tot_T0 CCQ_klachten_T0 CCQ_emoties_T0 CCQ_conditie_T0 (9).

*** Q42/43/44: aan roken gerelateerde ziektes************************************************************************************************************************************.
RENAME VARIABLES Q42=rokersziektes1_T0 / Q43=rokersziektes2_T0 / Q44=rokersziektes3_T0 .

** missings.
RECODE rokersziektes1_T0 rokersziektes2_T0 rokersziektes3_T0 (SYSMIS=99).
MISSING VALUES rokersziektes1_T0 rokersziektes2_T0 rokersziektes3_T0 (99).
EXECUTE.
VARIABLE WIDTH  rokersziektes1_T0 rokersziektes2_T0 rokersziektes3_T0 (5).
VARIABLE LEVEL  rokersziektes1_T0 rokersziektes2_T0 rokersziektes3_T0 (ORDINAL).

***Q46: stress********************************************************************************************************************************************************************.
RENAME VARIABLES Q46_1=stress1_T0 / Q46_2=stress2_T0 / Q46_3=stress3_T0 / Q46_4=stress4_T0 / Q46_5=stress5_T0.
VARIABLE LABELS stress1_T0 'Hoe vaak heeft u het gevoel gehad dat u geen controle had over de belangrijke dingen in uw leven? T0'
stress2_T0 'Hoe vaak heeft u zich er zeker van gevoeld dat u in staat was om persoonlijke problemen aan te kunnen? T0'
stress3_T0 'Hoe vaak heeft u het gevoel gehad dat alles liep zoals u wilde? T0'
stress4_T0 'Hoe vaak heeft u het gevoel gehad dat de problemen zich zo hoog opstapelden dat u ze niet kon overwinnen? T0'
stress5_T0 'Hoe vaak bent u aangeslagen geweest door gebeurtenissen in de wereld? T0'.

** missings.
RECODE stress1_T0 stress2_T0 stress3_T0 stress4_T0 stress5_T0  (SYSMIS=99).
MISSING VALUES stress1_T0 stress2_T0 stress3_T0 stress4_T0 stress5_T0 (99).
EXECUTE.
VARIABLE WIDTH  stress1_T0 stress2_T0 stress3_T0 stress4_T0 stress5_T0 (5).
VARIABLE LEVEL   stress1_T0 stress2_T0 stress3_T0 stress4_T0 stress5_T0 (ORDINAL).

***Q47: motivatie****************************************************************************************************************************************************************.
RENAME VARIABLES Q47_1=motivatie1_T0 / Q47_2=motivatie2_T0 / Q47_3=motivatie3_T0 / Q47_4=motivatie4_T0 / Q47_5=motivatie5_T0.
VARIABLE LABELS motivatie1_T0 'Als ik iets goed doe, wil ik er graag mee doorgaan T0' 
motivatie2_T0 'Als ik krijg wat ik wil, voel ik me opgewonden en energiek T0'
motivatie3_T0 'Als ik een buitenkansje zie dan word ik meteen enthousiast T0'
motivatie4_T0 'Als ik iets leuks meemaak heeft dat duidelijk invloed op me T0'
motivatie5_T0 'Als ik een wedstrijd zou winnen, zou ik erg enthousiast zijn T0'.

** missings.
RECODE motivatie1_T0 motivatie2_T0 motivatie3_T0 motivatie4_T0 motivatie5_T0  (SYSMIS=99).
MISSING VALUES motivatie1_T0 motivatie2_T0 motivatie3_T0 motivatie4_T0 motivatie5_T0 (99).
EXECUTE.
VARIABLE WIDTH  motivatie1_T0 motivatie2_T0 motivatie3_T0 motivatie4_T0 motivatie5_T0 (6).
VARIABLE LEVEL   motivatie1_T0 motivatie2_T0 motivatie3_T0 motivatie4_T0 motivatie5_T0 (ORDINAL).


***Q49/50/51/52/119/120: sociale omgeving*************************************************************************************************************************************.
RENAME VARIABLES Q49=soc_omgeving1_T0 /  Q50=soc_omgeving2_T0 /  Q51=soc_omgeving3_T0 /  Q52=soc_omgeving4_T0 /  Q119=soc_omgeving5_T0 
/  Q120=soc_omgeving6_T0.

* soc_omgeving3 heeft onlogische codering: hercoderen.
RECODE soc_omgeving3_T0 (2=1) (3=2)  (4=3)  (6=4).
EXECUTE.
VALUE LABELS soc_omgeving3_T0 1 'veel steun' 2 'niet veel/niet weinig steun' 3 'weinig steun' 4 'weet niet'.

VARIABLE LABELS soc_omgeving1_T0  'Rookt uw partner? T0' /
soc_omgeving2_T0 'Is uw partner in de afgelopen 12 maanden succesvol gestopt met roken? T0' /
soc_omgeving3_T0 'Hoeveel steun verwacht u van uw partner als u stopt met roken? T0'/
soc_omgeving4_T0 'Hoeveel van de vijf meest nabije vrienden, bekenden of collegas waar u regelmatig tijd mee doorbrengt zijn roker? T0'/
soc_omgeving5_T0 'Hoeveel steun verwacht u van uw vrienden en familieleden als u stopt met roken? T0'/
soc_omgeving6_T0 'Hoeveel steun verwacht u van uw collegas als u stopt met roken? T0'.

* missings. 
RECODE soc_omgeving1_T0 soc_omgeving2_T0 soc_omgeving3_T0 soc_omgeving4_T0 soc_omgeving5_T0 soc_omgeving6_T0 (SYSMIS=99).
EXECUTE.
MISSING VALUES soc_omgeving1_T0 soc_omgeving2_T0 soc_omgeving3_T0 soc_omgeving4_T0 soc_omgeving5_T0 soc_omgeving6_T0 (99).
VARIABLE WIDTH soc_omgeving1_T0 soc_omgeving2_T0 soc_omgeving3_T0 soc_omgeving4_T0 soc_omgeving5_T0 soc_omgeving6_T0 (5).
VARIABLE LEVEL soc_omgeving1_T0 soc_omgeving2_T0 soc_omgeving3_T0 soc_omgeving4_T0 soc_omgeving5_T0 soc_omgeving6_T0 (NOMINAL).
  
***Q55/Q60: roken op werk******************************************************************************************************************************************************.
RENAME VARIABLES Q55_1=roken_op_werk1_T0 /  Q55_4=roken_op_werk2_T0 / Q55_2=roken_op_werk3_T0 / Q55_7=roken_op_werk4_T0 /
Q56=roken_op_werk5_T0 / Q57=roken_op_werk6_T0 / Q58=roken_op_werk7_T0 / Q60_1=roken_op_werk8_T0 / Q60_3=roken_op_werk9_T0.
VARIABLE LABELS roken_op_werk1_T0 'Is het toegestaan om te roken op het werk? T0' 
roken_op_werk2_T0 'Bent u vrij om rookpauzes te nemen wanneer u wilt? T0' 
roken_op_werk3_T0 'Zijn er op het werk speciale rookplekken binnen? T0'
roken_op_werk4_T0 'Zijn er op het werk speciale rookplekken buiten? T0'
roken_op_werk5_T0 'Roken wordt ontmoedigd op het werk T0'
roken_op_werk6_T0 'Op het werk wordt het normaal gevonden dat er collegas roken T0'
roken_op_werk7_T0 'Heeft u wel eens negatieve reacties gehad van collegas over uw roken? T0'
roken_op_werk8_T0 'Hoe vaak hebben mensen op uw werk u in de afgelopen 3 maanden verteld dat ze last hebben van uw sigarettenrook? T0'
roken_op_werk9_T0 'Hoe vaak heeft u uzelf in de afgelopen 3 maanden op werk verborgen of uit het zicht gehouden terwijl u rookte zodat anderen u niet zouden bekritiseren? T0' .

* roken_op_werk heeft onlogische codering: hercoderen.
RECODE roken_op_werk7_T0 (1=1) (2=2) (4=3) (5=4) (6=5).
VALUE LABELS roken_op_werk7_T0 1 'nooit' 2  'bijna nooit' 3 'redelijk vaak' 4  'erg vaak'  5  'weet niet' . 

* missings.
RECODE roken_op_werk1_T0 roken_op_werk2_T0 roken_op_werk3_T0 roken_op_werk4_T0 roken_op_werk5_T0 roken_op_werk6_T0 roken_op_werk7_T0 
roken_op_werk8_T0 roken_op_werk9_T0 (SYSMIS=99).
EXECUTE.
MISSING VALUES roken_op_werk1_T0 roken_op_werk2_T0 roken_op_werk3_T0 roken_op_werk4_T0  roken_op_werk8_T0 roken_op_werk9_T0 (99) 
roken_op_werk5_T0 roken_op_werk6_T0 roken_op_werk7_T0 (6,99).
VARIABLE LEVEL roken_op_werk1_T0 roken_op_werk2_T0 roken_op_werk3_T0 roken_op_werk4_T0 (NOMINAL) 
roken_op_werk5_T0  roken_op_werk6_T0 roken_op_werk7_T0 roken_op_werk8_T0 roken_op_werk9_T0 (ORDINAL).
VARIABLE WIDTH roken_op_werk1_T0 roken_op_werk2_T0 roken_op_werk3_T0 roken_op_werk4_T0 roken_op_werk5_T0 roken_op_werk6_T0 roken_op_werk7_T0 
roken_op_werk8_T0 roken_op_werk9_T0(7).


*** Q64/65: werkuren*************************************************************************************************************************************************************.
RENAME VARIABLES Q64=werktijd1_T0/ Q65= werktijd2_T0.
VARIABLE LABELS werktijd1_T0 'aantal werkuren per week T0' / werktijd2_T0 'aantal werkdagen per week T0'.

FREQUENCIES VARIABLES=werktijd1_T0 werktijd2_T0
  /ORDER=ANALYSIS.

**Aanpassingen.

** ID 5911 werkt 28 uur/dag. Aanpassen naar 48 uur tot (=24 per dag) (Brandweer).
DO IF (ID_Code=5911).
RECODE werktijd1_T0 (56=48).
END IF.
EXECUTE.

** enkele personen geven uur per dag op ipv tot aantal uur. Aanpassen.
* bij 5 dagen.
DO IF (ID_Code=5301 or ID_Code=6703 or ID_Code=3211 or ID_Code=1301  or ID_Code=6103 or ID_code=2106 or ID_code=3703).
RECODE werktijd1_T0 (8=40) (9=45).
END IF.
EXECUTE.

*bij 4 dagen.
DO IF (ID_Code=6103 or ID_code=2108).
RECODE werktijd1_T0 (9=36) (8=32).
END IF.
EXECUTE.

* dagen en uren omgedraaid.
DO IF (ID_Code=7114).
RECODE werktijd1_T0 (1=5).
RECODE werktijd2_T0 (5=1).
END IF.
EXECUTE.

* ID 1914	1 uur, 1 dag	Op T1 16 uur, 2 dagen  hier ook .
DO IF (ID_Code=1914).
RECODE werktijd1_T0 (1=16).
RECODE werktijd2_T0 (1=2).
END IF.
EXECUTE.

* ID 2904	1 uur, 1 dag	Op T3 24 uur, 3 dagen  hier ook .
DO IF (ID_Code=2904).
RECODE werktijd1_T0 (1=24).
RECODE werktijd2_T0 (1=3).
END IF.
EXECUTE.

**Aantal werkuur per dag berekenen.
COMPUTE werkuur_per_dag_T0=werktijd1_T0 / werktijd2_T0.
EXECUTE.
** missings.

RECODE werktijd1_T0 werktijd2_T0 werkuur_per_dag_T0 (SYSMIS=999).
EXECUTE.
MISSING VALUES werktijd1_T0 werktijd2_T0 werkuur_per_dag_T0 (999).

VARIABLE WIDTH werktijd1_T0  werktijd2_T0 werkuur_per_dag_T0 (8).
VARIABLE LEVEL werktijd1_T0  werktijd2_T0 werkuur_per_dag_T0 (SCALE).

*Q67/Q68: pauze******************************************************************************************************************************************************************.
RENAME VARIABLES Q67=pauzes_aantal_T0 / Q68_2.0=pauzes_uren_T0 / Q68_1.0=pauzes_minuten_T0.
VARIABLE LABELS pauzes_aantal_T0 'aantal pauzes op meest recente werkdag T0' pauzes_minuten_T0 'aantal min pauze T0' pauzes_uren_T0 'aantal uur pauze T0'.
FORMATS pauzes_aantal_T0 (F2.0).

*pauzes_minuten: van string naar numeriek .
FREQUENCIES VARIABLES=pauzes_minuten_T0
  /ORDER=ANALYSIS.
*.
RECODE pauzes_minuten_T0 ('o'='0') ('Nvt'=' ') ('45min'='45') ('15 minuten'='15') ('15/30/15'='60') ('45 mn'='45') ('50 minuten'='50') ('05'='5').
EXECUTE.
FREQUENCIES VARIABLES=pauzes_minuten_T0
  /ORDER=ANALYSIS.
ALTER TYPE pauzes_minuten_T0 (F3.0).

*pauzes_uren: van string naar numeriek.
FREQUENCIES VARIABLES=pauzes_uren_T0
  /ORDER=ANALYSIS.
*.
RECODE pauzes_uren_T0 ('-'=' ') ('Nvt'=' ') ('0.45'='0.75') ('0.25'='0.25') ('1.15'='1.25') ('1/2'='0.5') ('25min'='0.42') ('30 minuten'='0.5') ('half uur'='0.5') ('0,5'='0.5')
('1uur'='1') ('20 minuten'= '0.33') ('1,5'= '1.5').
EXECUTE.
FREQUENCIES VARIABLES=pauzes_uren_T0
  /ORDER=ANALYSIS.
ALTER TYPE pauzes_uren_T0 (F3.2).

** als aantal pauzes 0 is, worden missende uren en minuten ook 0.
DO IF (pauzes_aantal_T0=0).
RECODE pauzes_minuten_T0 pauzes_uren_T0 (SYSMIS=0).
END IF.
EXECUTE.
** als aantal pauzes>0 en aantal minuten is ingevuld en aantal uren niet, dan is aantal uren 0.
DO IF (pauzes_aantal_T0>0 and pauzes_minuten_T0>0).
RECODE pauzes_uren_T0 (SYSMIS=0).
END IF.
EXECUTE.
** als aantal pauzes>0 en aantal uren is ingevuld en aantal min niet, dan is aantal min 0.
DO IF (pauzes_aantal_T0>0 and pauzes_uren_T0>0).
RECODE pauzes_minuten_T0 (SYSMIS=0).
END IF.
EXECUTE.


*** CONTROLE: enkele zeer onwaarschijnlijke aantal uren en minuten!!!.
*correcties.

DO IF (pauzes_minuten_T0=75).
RECODE pauzes_uren_T0 (1.15=0).
END IF.
DO IF (pauzes_minuten_T0=75).
RECODE pauzes_uren_T0 (1.25=0).
END IF.
DO IF (pauzes_minuten_T0=60).
RECODE pauzes_uren_T0 (1=0).
END IF.
DO IF (pauzes_minuten_T0=30).
RECODE pauzes_uren_T0 (0.5=0).
END IF.
EXECUTE.

* soms geven deelnemers meerdere pauzes aan met een totale tijd van 5 minuten. Er wordt vanuit gegaan dat ze 5 minuten per pauze bedoelen:.
DO IF (ID_Code=6103). 
RECODE pauzes_minuten_T0 (5=30).
END IF.
DO IF (ID_Code=3503). 
RECODE pauzes_minuten_T0 (5=15).
END IF.
DO IF (ID_Code=4204). 
RECODE pauzes_minuten_T0 (5=20).
END IF.
DO IF (ID_Code=2001). 
RECODE pauzes_minuten_T0 (5=20).
END IF.
DO IF (ID_Code=1108). 
RECODE pauzes_minuten_T0 (5=20).
END IF.
DO IF (ID_Code=1807). 
RECODE pauzes_minuten_T0 (5=30).
END IF.
DO IF (ID_Code=3103). 
RECODE pauzes_minuten_T0 (5=20).
END IF.
DO IF (ID_Code=5703). 
RECODE pauzes_minuten_T0 (5=40).
END IF.
DO IF (ID_Code=1711). 
RECODE pauzes_minuten_T0 (5=40).
END IF.
DO IF (ID_Code=1102). 
RECODE pauzes_minuten_T0 (5=20).
END IF.
DO IF (ID_Code=5911). 
RECODE pauzes_minuten_T0 (5=25).
END IF.
DO IF (ID_Code=3904). 
RECODE pauzes_minuten_T0 (5=25).
END IF.
DO IF (ID_Code=4705). 
RECODE pauzes_minuten_T0 (5=15).
END IF.
DO IF (ID_Code=4205). 
RECODE pauzes_minuten_T0 (5=15).
END IF.
DO IF (ID_Code=4011). 
RECODE pauzes_minuten_T0 (5=20).
END IF.
EXECUTE.

** uren en minuten waarschijnlijk omgedraaid.
DO IF (ID_Code=6307). 
RECODE pauzes_uren_T0 (10=1).
RECODE pauzes_minuten_T0 (1=10).
END IF.
DO IF (ID_Code=6904). 
RECODE pauzes_uren_T0 (10=1).
RECODE pauzes_minuten_T0 (1=10).
END IF.
DO IF (ID_Code=3302). 
RECODE pauzes_uren_T0 (20=1).
RECODE pauzes_minuten_T0 (1=20).
END IF.
DO IF (ID_Code=3804). 
RECODE pauzes_uren_T0 (45=1).
RECODE pauzes_minuten_T0 (1=45).
END IF.
DO IF (ID_Code=5501). 
RECODE pauzes_uren_T0 (60=0).
RECODE pauzes_minuten_T0 (0=60).
END IF.
EXECUTE.

** Individuele aanpassingen.
*ID 2511. 15 pauzes, tot 300 min (=5 uur), heeft 5 werkdagen, wellicht pauzes per week ingevuld?
 -> 3 pauzes van totaal 1 uur.Dit heeft hij ook op T1 ingevuld.
DO IF (ID_Code=2511). 
RECODE pauzes_aantal_T0 (15=3).
RECODE pauzes_minuten_T0 (300=60).
END IF.
* ID 5308	10 pauzes, 5 uur  10 pauzes van 5 min=50 min.
DO IF (ID_Code=5308). 
RECODE pauzes_uren_T0 (5=0).
RECODE pauzes_minuten_T0 (0=50).
END IF.
EXECUTE.

** extreme waarden worden missing.
DO IF (ID_Code=1118). 
RECODE pauzes_uren_T0 (40=999).
RECODE pauzes_minuten_T0 (5=999).
END IF.
DO IF (ID_Code=1903). 
RECODE pauzes_uren_T0 (60=999).
RECODE pauzes_minuten_T0 (5=999).
END IF.
DO IF (ID_Code=5406). 
RECODE pauzes_uren_T0 (5=999).
RECODE pauzes_minuten_T0 (15=999).
END IF.
DO IF (ID_Code=5611). 
RECODE pauzes_uren_T0 (30=999).
RECODE pauzes_minuten_T0 (15=999).
END IF.
DO IF (ID_Code=4905). 
RECODE pauzes_uren_T0 (8=999).
RECODE pauzes_minuten_T0 (55=999).
END IF.
DO IF (ID_Code=1609). 
RECODE pauzes_uren_T0 (15=999).
RECODE pauzes_minuten_T0 (60=999).
END IF.
DO IF (ID_Code=7014). 
RECODE pauzes_uren_T0 (8=999).
RECODE pauzes_minuten_T0 (30=999).
END IF.
DO IF (ID_Code=4305). 
RECODE pauzes_uren_T0 (0=999).
RECODE pauzes_minuten_T0 (200=999).
END IF.
DO IF (ID_Code=2302). 
RECODE pauzes_uren_T0 (1=999).
RECODE pauzes_minuten_T0 (80=999).
END IF.
DO IF (ID_Code=1816). 
RECODE pauzes_uren_T0 (1=999).
RECODE pauzes_minuten_T0 (75=999).
END IF.
DO IF (ID_Code=3307). 
RECODE pauzes_uren_T0 (0=999).
RECODE pauzes_minuten_T0 (3=999).
END IF.
DO IF (ID_Code=3702). 
RECODE pauzes_uren_T0 (0=999).
RECODE pauzes_minuten_T0 (1=999).
END IF.
EXECUTE.

** missings.
RECODE pauzes_aantal_T0 (SYSMIS=99).
RECODE pauzes_uren_T0 pauzes_minuten_T0 (SYSMIS=999).
EXECUTE.
MISSING VALUES pauzes_aantal_T0 (99) pauzes_uren_T0 pauzes_minuten_T0 (999).
VARIABLE LEVEL pauzes_aantal_T0 pauzes_uren_T0 pauzes_minuten_T0 (SCALE).
VARIABLE WIDTH  pauzes_aantal_T0 pauzes_uren_T0 pauzes_minuten_T0 (10).

** Q69 - Q78: ziekteverzuim**************************************************************************************************************************************************************************.
RENAME VARIABLES Q69=ziekteverzuim1_T0 / Q69_2_TEXT=ziekteverzuim2_T0 / Q70=ziekteverzuim3_T0.
VARIABLE LABELS ziekteverzuim1_T0 'verlof wegens ziekte afgelopen 3 mnd T0' ziekteverzuim2_T0  'aantal dagen verzuim T0' 
ziekteverzuim3_T0 'langer dan 3 maanden verlof wegens ziekte T0'  .

*Indien ziekteverzuim1 =1 (nee), dan moet ziekteverzuim2 leeg zijn.
USE ALL.
COMPUTE filter_$=(ziekteverzuim1_T0=1).
VARIABLE LABELS filter_$ 'ziekteverzuim1_T0=1 (FILTER)'.
VALUE LABELS filter_$ 0 'Not Selected' 1 'Selected'.
FORMATS filter_$ (f1.0).
FILTER BY filter_$.
EXECUTE.
FREQUENCIES VARIABLES=ziekteverzuim2_T0
  /ORDER=ANALYSIS.
USE ALL.

* Q71 van string naar date.
STRING temp1 (A20).
COMPUTE temp1=REPLACE(Q71,'-','').
EXECUTE.

STRING  temp2 (A20).
COMPUTE temp2=REPLACE(temp1,'/','').
EXECUTE.

FREQUENCIES VARIABLES=temp2
  /ORDER=ANALYSIS.

COMPUTE aantalplaatsen=LENGTH(temp2).
EXECUTE.
FORMATS aantalplaatsen (F1.0).

DO IF aantalplaatsen=8.
* Date and Time Wizard:.
COMPUTE  ziekteverzuim4_T0=date.dmy(number(substr(ltrim(temp2),1,2),f2.0), number(substr(ltrim(temp2),3,2),f2.0), number(substr(ltrim(temp2),5),f4.0)).
VARIABLE LEVEL   ziekteverzuim4_T0 (SCALE).
FORMATS  ziekteverzuim4_T0 (DATE11).
VARIABLE WIDTH   ziekteverzuim4_T0(11).
END IF.
EXECUTE.

VARIABLE LABELS  ziekteverzuim4_T0 'datum ziekmelding T0'.
DELETE VARIABLES  temp1 temp2 aantalplaatsen.

*Q71 (datum ziekmelding) moet minimaal 3 maanden (13 weken) voor invuldatum liggen.
* Date and Time Wizard: d_datum_ziekmelding_invuldatum.
COMPUTE  d_datum_ziekmelding_invuldatum_T0=DATEDIF( ziekteverzuim4_T0, Invuldatum_T0, "weeks").
VARIABLE LABELS  d_datum_ziekmelding_invuldatum_T0 "verschil in weken invuldatum-ziekmelddatum T0".
VARIABLE LEVEL  d_datum_ziekmelding_invuldatum_T0 (SCALE).
FORMATS  d_datum_ziekmelding_invuldatum_T0 (F5.0).
VARIABLE WIDTH  d_datum_ziekmelding_invuldatum_T0(5).
EXECUTE.
FREQUENCIES VARIABLES=d_datum_ziekmelding_invuldatum_T0
  /ORDER=ANALYSIS.

** aanpassingen.
** ID 4914:	4 werkdagen, langdurig sinds 1 week voor invullen vragenlijst -> is op moment van invullen 1 week ziek. Op T1 geen verzuim 
Geeft ook aan 10 dagen ziek op het werk te zijn geweest.--> 	Gegevens langdurig weghalen, 4 dagen ziek.
DO IF ID_code=4914.
RECODE ziekteverzuim3_T0 (2=1).
RECODE Q71 ('17-01-2017'=' ').
COMPUTE ziekteverzuim4_T0=$SYSMIS.
COMPUTE d_datum_ziekmelding_invuldatum_T0=$SYSMIS.
END IF.
** ID 2104:	ziek, aantal dagen: ’nee’. Langdurig sinds 1 week voor invullen vragenlijst. Geen T1 -> van ‘nee’ 4 dagen maken (werkt 4 dagen per week) en langdurig weghalen. 
DO IF ID_code=2104.
RECODE ziekteverzuim2_T0 ('nee'='4').
RECODE ziekteverzuim3_T0 (2=1).
RECODE Q71 ('25/09/2016'=' ').
COMPUTE ziekteverzuim4_T0=$SYSMIS.
COMPUTE d_datum_ziekmelding_invuldatum_T0=$SYSMIS.
END IF.
** ID 2704:	4 werkdagen ziek, langdurig sinds 6 weken voor invullen vragenlijst = 30 werkdagen (werkt 5 dagen/week). Op T1 geen verzuim
 aantal dagen aanpassen en langdurig weghalen.
DO IF ID_code=2704.
RECODE ziekteverzuim2_T0 ('4'='30').
RECODE ziekteverzuim3_T0 (2=1).
RECODE Q71 ('01-09-2016'=' ').
COMPUTE ziekteverzuim4_T0=$SYSMIS.
COMPUTE d_datum_ziekmelding_invuldatum_T0=$SYSMIS.
END IF.
** ID 7013:	50%  -> is ziekgemeld sinds ruim 1 jaar, blijkbaar 50%. Hij werkt 24 uur per week, dus 12 uur per week ziek (1,5 dag=18 dagen in 3 maanden)? (geen T1)  ja
Maar heeft ook code ‘langdurig ziek’  langdurig weg laten vallen.
DO IF ID_code=7013.
RECODE ziekteverzuim2_T0 ('50%'='18').
RECODE ziekteverzuim3_T0 (2=1).
RECODE Q71 ('17/01/2016'=' ').
COMPUTE ziekteverzuim4_T0=$SYSMIS.
COMPUTE d_datum_ziekmelding_invuldatum_T0=$SYSMIS.
END IF.

* Ziekteverzuim1_T0 (=afgelopen 3 mnd) hercoderen: 1=nee, 2 =ja , 3=langdurig (dus indien ziekteverzuim3_T0=2).
DO IF ziekteverzuim3_T0=2.
RECODE ziekteverzuim1_T0 (2=3).
END IF.
VALUE LABELS ziekteverzuim1_T0 1 'nee' 2 'ja' 3 'langdurig >3 mnd' .
* Indien ziekteverzuim is langdurig: aantal dagen missing maken (is niet van belang, advies Sylvia).
DO IF ziekteverzuim3_T0=2.
COMPUTE  ziekteverzuim2_T0=''.
END IF.
EXECUTE.

* ziekteverzuim2_T0 (aantal dagen) numeriek maken.
FREQUENCIES VARIABLES= ziekteverzuim2_T0
  /ORDER=ANALYSIS.

** aanpassingen.
*ID 4406	Aantal dagen: Geen. Ook niet langdurig, op T1 geen verzuim  verzuim ja veranderen in nee.
DO IF ID_Code=4406.
RECODE ziekteverzuim1_T0 (2=1).
RECODE ziekteverzuim2_T0 ('Geen'='').
END IF.
*ID 5611	Aantal dagen: Nee. Ook niet langdurig  verzuim ja veranderen in nee.
DO IF ID_Code=5611.
RECODE ziekteverzuim1_T0 (2=1).
RECODE ziekteverzuim2_T0 ('nee'='').
END IF.
* ID 5109:	4 uur per dag. (geen T1) Hij werkt 40 uur, 5 dagen = 8 uur per dag. Is dus 50% ziek. Niet langdurig ziek. Veranderen in 13x2,5 dagen= 32,5 dagen ziek.
DO IF ID_Code=5109.
RECODE ziekteverzuim2_T0 ('ziek 4 uur per dag'='32.5').
END IF.
* indien aant dagenniet ingevuld: 1 (conservatieve schatting).
RECODE ziekteverzuim2_T0 ('???'='1') ('1 dag'='1') ('3 dagen'='3') ('5 dagen'='5') ('5 dagen griep'='5') ('15 dagen'='15') ('hernia'='1') (ELSE=COPY).
EXECUTE.
FREQUENCIES VARIABLES= ziekteverzuim2_T0
  /ORDER=ANALYSIS.
ALTER TYPE ziekteverzuim2_T0 (F3.0).

* Missing en nvt toevoegen.
DO IF (ziekteverzuim1_T0=1).
RECODE ziekteverzuim2_T0 (SYSMIS=888).
RECODE ziekteverzuim3_T0 (SYSMIS=1).
END IF.
DO IF (ziekteverzuim1_T0=2).
RECODE ziekteverzuim2_T0 (SYSMIS=999).
END IF.
DO IF (ziekteverzuim1_T0=3).
RECODE ziekteverzuim2_T0 (SYSMIS=888).
END IF.
RECODE ziekteverzuim1_T0 (SYSMIS=9).
RECODE ziekteverzuim3_T0 (SYSMIS=9).
DO IF (ziekteverzuim1_T0=9).
RECODE ziekteverzuim2_T0 (SYSMIS=999).
END IF.
EXECUTE.

MISSING VALUES ziekteverzuim1_T0 ziekteverzuim3_T0 (9) ziekteverzuim2_T0 (888,999).
VARIABLE LEVEL ziekteverzuim1_T0 ziekteverzuim3_T0 (NOMINAL) ziekteverzuim2_T0 (SCALE).

*Als afwezig=ja en aantal dagen =0.  Aantal dagen wordt 1 (conservatieve schatting).
DO IF ziekteverzuim1_T0=2.
RECODE ziekteverzuim2_T0 (0=1).
END IF.
EXECUTE.

*** Q72 t/m 74: ziek op het werk************************************************************************************************************************************.
RENAME VARIABLES Q72=ziekteverzuim5_T0 / Q73=ziekteverzuim6_T0 / Q74_1=ziekteverzuim7_T0.
VARIABLE LABELS ziekteverzuim5_T0 'ziek op het werk afgelopen 3 maanden T0' ziekteverzuim6_T0 'ziek op werk: aantal dagen T0'
ziekteverzuim7_T0 'ziek op werk: hoeveel werk verricht T0'.
FORMATS ziekteverzuim6_T0 (F3.0).

*Indien ziekteverzuim5 =1 (nee), dan moeten ziekteverzuim6 en 7  leeg zijn.
USE ALL.
COMPUTE filter_$=(ziekteverzuim5_T0=1).
VARIABLE LABELS filter_$ 'ziekteverzuim5_T0=1 (FILTER)'.
VALUE LABELS filter_$ 0 'Not Selected' 1 'Selected'.
FORMATS filter_$ (f1.0).
FILTER BY filter_$.
EXECUTE.
FREQUENCIES VARIABLES=ziekteverzuim6_T0 ziekteverzuim7_T0
  /ORDER=ANALYSIS.
USE ALL.

* =Indien ziekteverzuim3 (langer dan 3 mnd ziek) ja is, kan ziekteverzuim5 niet ja zijn (want ze hebben niet gewerkt).
CROSSTABS
  /TABLES=ziekteverzuim3_T0 BY ziekteverzuim5_T0
  /FORMAT=AVALUE TABLES
  /CELLS=COUNT
  /COUNT ROUND CELL.

* Komt toch voor: in dat geval 'ziek op werk' verwijderen.
DO IF ID_code=6007 or ID_code=5105 or ID_code=6505 or ID_code=3305 or ID_code=2703 or ID_code=6705	or ID_code=5101.
RECODE ziekteverzuim5_T0 (2=1).
COMPUTE ziekteverzuim6_T0=888.
COMPUTE ziekteverzuim7_T0=888.
END IF.

* Controle ziekteverzuim6 (aantal werkdagen).
FREQUENCIES VARIABLES=ziekteverzuim6_T0
  /ORDER=ANALYSIS.
*Als aantal dagen 0 is --> wordt 1 (conservatieve schatting).
DO IF ziekteverzuim5_T0=2.
RECODE ziekteverzuim6_T0 (0=1).
END IF.

*Aantal dagen > 90 wordt 91. (3 maanden).
RECODE ziekteverzuim6_T0 (100=91).

* Indien wel ziek op werk, maar aantal dagen is missing: 1 (conservatieve schatting).
* Indien wel ziek op werk maar hoeveelheid werk missing: 9 (conservatieve schatting).
DO IF ziekteverzuim5_T0=2.
RECODE ziekteverzuim6_T0 (MISSING=1).
RECODE ziekteverzuim7_T0 (MISSING=9).
END IF.
EXECUTE.

* ziekteverzuim7_T0 rare codering: {1, ik kon op deze dagen niets doen: 0}...tot '11, ik kon net zoveel doen als normaal: 10.
*Hercoderen.
RECODE ziekteverzuim7_T0 (1=0) (2=1) (3=2) (4=3) (5=4) (6=5) (7=6) (8=7) (9=8) (10=9) (11=10).
EXECUTE.
VALUE LABELS ziekteverzuim7_T0.

* Missing en nvt toevoegen.
DO IF (ziekteverzuim5_T0=1).
RECODE ziekteverzuim6_T0 (SYSMIS=888).
RECODE ziekteverzuim7_T0 (SYSMIS=888).
END IF.
DO IF (ziekteverzuim5_T0=2).
RECODE ziekteverzuim6_T0 (SYSMIS=999).
RECODE ziekteverzuim7_T0 (SYSMIS=999).
END IF.
RECODE ziekteverzuim5_T0 (SYSMIS=9).
DO IF (ziekteverzuim5_T0=9).
RECODE ziekteverzuim6_T0 (SYSMIS=999).
RECODE ziekteverzuim7_T0 (SYSMIS=999).
END IF.
EXECUTE.

MISSING VALUES ziekteverzuim5_T0 (9) ziekteverzuim6_T0 ziekteverzuim7_T0 (888,999).
VARIABLE LEVEL ziekteverzuim5_T0 (NOMINAL) ziekteverzuim6_T0 ziekteverzuim7_T0 (SCALE).

*** Q76 t/m 78: ziek mbt onbetaald werk************************************************************************************************************************************.
RENAME VARIABLES Q76=ziekteverzuim8_T0 / Q77=ziekteverzuim9_T0 / Q78=ziekteverzuim10_T0.
VARIABLE LABELS ziekteverzuim8_T0 'verzuim onbetaald werk T0' ziekteverzuim9_T0 'verzuim onbetaald aantal dagen T0' ziekteverzuim10_T0 'verzuim onbetaald uren vervanging T0'.
FORMATS ziekteverzuim9_T0 (F3.0).

*Indien ziekteverzuim8 =1 (nee), dan moeten ziekteverzuim9 en 10  leeg zijn.
USE ALL.
COMPUTE filter_$=(ziekteverzuim8_T0=1).
VARIABLE LABELS filter_$ 'ziekteverzuim8_T0=1 (FILTER)'.
VALUE LABELS filter_$ 0 'Not Selected' 1 'Selected'.
FORMATS filter_$ (f1.0).
FILTER BY filter_$.
EXECUTE.
FREQUENCIES VARIABLES=ziekteverzuim9_T0 ziekteverzuim10_T0
  /ORDER=ANALYSIS.
USE ALL.

* Controle ziekteverzuim9_T0 (aantal dagen). Kan max 91 zijn (3 maanden), en 0 wordt 1 (conservatieve schatting).
FREQUENCIES VARIABLES=ziekteverzuim9_T0
  /ORDER=ANALYSIS.
RECODE ziekteverzuim9_T0 (100=91) (101=91) (0=1).

* Controle ziekteverzuim10_T0 (aantal uur). 
FREQUENCIES VARIABLES=ziekteverzuim10_T0
  /ORDER=ANALYSIS.
* aantal onwaarschijnlijk, aanpassen:.
DO IF ID_Code=1301.
RECODE ziekteverzuim10_T0 (36=3).
END IF.
DO IF ID_Code=1602.
RECODE ziekteverzuim10_T0 (8=2.6).
END IF.
EXECUTE.
DO IF ID_Code=1913.
RECODE ziekteverzuim10_T0 (8=1).
END IF.
DO IF ID_Code=2010.
RECODE ziekteverzuim10_T0 (50=2.1).
END IF.
DO IF ID_Code=2510.
RECODE ziekteverzuim10_T0 (32=5.3).
END IF.
DO IF ID_Code=2809.
RECODE ziekteverzuim10_T0 (16=8).
END IF.
DO IF ID_Code=2901.
RECODE ziekteverzuim10_T0 (10=1.7).
END IF.
DO IF ID_Code=3007.
RECODE ziekteverzuim10_T0 (20=4).
END IF.
DO IF ID_Code=3306.
RECODE ziekteverzuim10_T0 (150=1).
END IF.
DO IF ID_Code=3807.
RECODE ziekteverzuim10_T0 (10=0.7).
END IF.
DO IF ID_Code=3904.
RECODE ziekteverzuim10_T0 (20=2).
END IF.
DO IF ID_Code=3908.
RECODE ziekteverzuim10_T0 (10=1).
END IF.
DO IF ID_Code=3916.
RECODE ziekteverzuim10_T0 (65=3.8).
END IF.
DO IF ID_Code=4108.
RECODE ziekteverzuim10_T0 (10=1).
END IF.
DO IF ID_Code=4803.
RECODE ziekteverzuim10_T0 (40=2.7).
END IF.
DO IF ID_Code=5105.
RECODE ziekteverzuim10_T0 (60=2).
END IF.
DO IF ID_Code=5111.
RECODE ziekteverzuim10_T0 (28=2).
END IF.
DO IF ID_Code=5506.
RECODE ziekteverzuim10_T0 (96=1).
END IF.
DO IF ID_Code=5811.
RECODE ziekteverzuim10_T0 (8=1).
END IF.
DO IF ID_Code=5910.
RECODE ziekteverzuim10_T0 (10=1).
END IF.
DO IF ID_Code=6009.
RECODE ziekteverzuim10_T0 (20=2).
END IF.
DO IF ID_Code=7102.
RECODE ziekteverzuim10_T0 (8=1).
END IF.
DO IF ID_Code=7114.
RECODE ziekteverzuim10_T0 (20=2.1).
END IF.
EXECUTE.

* indien ja en aantal uur = 0; veranderenin 1 (conservatieve schatting).
DO IF ziekteverzuim8_T0=2.
RECODE ziekteverzuim10_T0 (0=1).
END IF.
EXECUTE.

* Indien ja, maar aantal dagen is missing: 1 (conservatieve schatting)
* Indien ja, maar aantal uur is missing: 1 (conservatieve schatting)

DO IF ziekteverzuim8_T0=2.
RECODE ziekteverzuim9_T0 (MISSING=1).
RECODE ziekteverzuim10_T0 (MISSING=1).
END IF.
EXECUTE.

* Missing en nvt toevoegen.
DO IF (ziekteverzuim8_T0=1).
RECODE ziekteverzuim9_T0 (SYSMIS=888).
RECODE ziekteverzuim10_T0 (SYSMIS=888).
END IF.
DO IF (ziekteverzuim8_T0=2).
RECODE ziekteverzuim9_T0 (SYSMIS=999).
RECODE ziekteverzuim10_T0 (SYSMIS=999).
END IF.
RECODE ziekteverzuim8_T0 (SYSMIS=9).
DO IF (ziekteverzuim8_T0=9).
RECODE ziekteverzuim9_T0 (SYSMIS=999).
RECODE ziekteverzuim10_T0 (SYSMIS=999).
END IF.
EXECUTE.

MISSING VALUES ziekteverzuim8_T0 (9) ziekteverzuim9_T0 ziekteverzuim10_T0 (888,999).
VARIABLE LEVEL ziekteverzuim8_T0 (NOMINAL) ziekteverzuim9_T0 ziekteverzuim10_T0 (SCALE).

*** Q82_1 t/m _14 Consulten ******************************************************************************************************************************************************.
RENAME VARIABLES Q82_1=consult1_T0 / Q82_2=consult2_T0 /  Q82_3=consult3_T0 /  Q82_4=consult4_T0 /  Q82_5=consult5_T0 /  Q82_6=consult6_T0 / 
 Q82_7=consult7_T0 /  Q82_8=consult8_T0 /  Q82_9=consult9_T0 /  Q82_10=consult10_T0 /  Q82_11=consult11_T0 /  Q82_12=consult12_T0 / 
 Q82_13=consult13_T0 /  Q82_14=consult14_T0 .

VARIABLE LABELS consult1_T0 'consult HA T0' 
consult2_T0 'consult POH T0' 
consult3_T0 'consult maatsch. werker T0' 
consult4_T0 'consult bedrijfsarts T0'
consult5_T0 'consult ergotherapeut T0' 
consult6_T0 'consult diëtist T0' 
consult7_T0 'consult stoppen met roken begeleider T0'  
consult8_T0 'consult tandarts T0' 
consult9_T0 'consult logopedist T0' 
consult10_T0 'consult homeopaat etc T0'
consult11_T0 'consult fysio etc T0' 
consult12_T0 'consult psycholoog etc T0'  
consult13_T0 'consult huidtherapeut/mondhygienist T0' 
consult14_T0 'consult manicure/pedicure T0'. 
FORMATS  consult1_T0 to consult14_T0 (F2.0).

** Als er minimaal 1 is ingevuld en de rest missing, zijn die missings 0 (geen consult).
DO IF (NVALID(consult1_T0,consult2_T0,consult3_T0,consult4_T0,consult5_T0,consult6_T0,consult7_T0,
    consult8_T0,consult9_T0,consult10_T0,consult11_T0,consult12_T0,consult13_T0,consult14_T0)>=1).
RECODE consult1_T0 consult2_T0 consult3_T0 consult4_T0 consult5_T0 consult6_T0 consult7_T0 consult8_T0 consult9_T0 
    consult10_T0 consult11_T0 consult12_T0 consult13_T0 consult14_T0 (SYSMIS=0).
END IF.
EXECUTE.

** Als er helemaal niets is ingevuld, maar de vragenlijst is wel  'gefinished', dan zijn de missings 0 (geen consult).
DO IF (NVALID(consult1_T0,consult2_T0,consult3_T0,consult4_T0,consult5_T0,consult6_T0,consult7_T0,
    consult8_T0,consult9_T0,consult10_T0,consult11_T0,consult12_T0,consult13_T0,consult14_T0)=0 and  Finished=1).
RECODE consult1_T0 consult2_T0 consult3_T0 consult4_T0 consult5_T0 consult6_T0 consult7_T0 consult8_T0 consult9_T0 
    consult10_T0 consult11_T0 consult12_T0 consult13_T0 consult14_T0 (SYSMIS=0).
END IF.
EXECUTE.

** Als er helemaal niets is ingevuld, en de vragenlijst is niet  'gefinished', dan zijn de missings 999 (echt missing).
DO IF (NVALID(consult1_T0,consult2_T0,consult3_T0,consult4_T0,consult5_T0,consult6_T0,consult7_T0,
    consult8_T0,consult9_T0,consult10_T0,consult11_T0,consult12_T0,consult13_T0,consult14_T0)=0 and  Finished=0).
RECODE consult1_T0 consult2_T0 consult3_T0 consult4_T0 consult5_T0 consult6_T0 consult7_T0 consult8_T0 consult9_T0 
    consult10_T0 consult11_T0 consult12_T0 consult13_T0 consult14_T0 (SYSMIS=999).
END IF.
EXECUTE.
MISSING VALUES consult1_T0 consult2_T0 consult3_T0 consult4_T0 consult5_T0 consult6_T0 consult7_T0 consult8_T0 consult9_T0 
    consult10_T0 consult11_T0 consult12_T0 consult13_T0 consult14_T0 (999).


*** Q83 Thuiszorg *******************************************************************************************************************************************************.
RENAME VARIABLES Q83=thuiszorg_T0 / Q84_1=thuiszorg_hh_T0 / Q84_2=thuiszorg_verzorging_T0 / Q84_3=thuiszorg_verpleging_T0 / 
Q106_X1=thuiszorg_hh_weken_T0 / Q106_X2=thuiszorg_verzorging_weken_T0 / Q106_X3=thuiszorg_verpleging_weken_T0 / 
Q86_X1.0=thuiszorg_hh_uur_T0 / Q86_X2.0=thuiszorg_verzorging_uur_T0 / Q86_X3.0=thuiszorg_verpleging_uur_T0. 

VARIABLE LABELS thuiszorg_T0 'thuiszorg ja/nee T0'
thuiszorg_hh_T0 'thuiszorg huishouden ja/nee T0'
thuiszorg_verzorging_T0 'thuiszorg verzorging ja/nee T0'
thuiszorg_verpleging_T0 'thuiszorg verpleging ja/nee T0'
thuiszorg_hh_weken_T0 'thuiszorg huishouden aant weken T0'
thuiszorg_verzorging_weken_T0 'thuiszorg verzorging aant weken T0'
thuiszorg_verpleging_weken_T0  'thuiszorg verpleging aant weken T0'
thuiszorg_hh_uur_T0 'thuiszorg huishouden aant uur/wk T0'
thuiszorg_verzorging_uur_T0 'thuiszorg verzorging aant uur/wk T0'
thuiszorg_verpleging_uur_T0 'thuiszorg verpleging aant uur/wk T0'. 

*Indien thuiszorg_T0 =1 (nee), dan moeten thuiszorg_hh_T0, thuiszorg_verzorging_T0 en thuiszorg_verpleging_T0 leeg zijn.
USE ALL.
COMPUTE filter_$=( thuiszorg_T0=1).
VARIABLE LABELS filter_$ ' thuiszorg_T0=1 (FILTER)'.
VALUE LABELS filter_$ 0 'Not Selected' 1 'Selected'.
FORMATS filter_$ (f1.0).
FILTER BY filter_$.
EXECUTE.
FREQUENCIES VARIABLES= thuiszorg_hh_T0 thuiszorg_verzorging_T0 thuiszorg_verpleging_T0 
  /ORDER=ANALYSIS.
USE ALL.

* visueel in database nakijken: als thuiszorg_T0 ergens 1 is, dan moet er ook wat staan bij de bijbehorende weken en uren. (descending sorteren op thuiszorg_T0)

*aantal weken kan max 13 zijn.
* controle of er geen tekst is ingevuld.
FREQUENCIES VARIABLES=thuiszorg_hh_weken_T0 thuiszorg_verzorging_weken_T0 thuiszorg_verpleging_weken_T0  
thuiszorg_hh_uur_T0 thuiszorg_verzorging_uur_T0 thuiszorg_verpleging_uur_T0 
  /ORDER=ANALYSIS.

* omzetten string naar numeriek.
ALTER TYPE thuiszorg_hh_weken_T0 thuiszorg_verzorging_weken_T0 thuiszorg_verpleging_weken_T0  (F2.0).
ALTER TYPE thuiszorg_hh_uur_T0 thuiszorg_verzorging_uur_T0 thuiszorg_verpleging_uur_T0 (F3.1).

* *Indien thuiszorg_T0 =1 (nee), rest hercoderen naar 0.
DO IF thuiszorg_T0=1.
RECODE thuiszorg_hh_weken_T0 thuiszorg_verzorging_weken_T0 thuiszorg_verpleging_weken_T0
 thuiszorg_hh_uur_T0 thuiszorg_verzorging_uur_T0 thuiszorg_verpleging_uur_T0 (SYSMIS=0).
END IF.
DO IF SYSMIS(thuiszorg_hh_T0) =1 and thuiszorg_T0=2.
RECODE thuiszorg_hh_weken_T0  thuiszorg_hh_uur_T0 (SYSMIS=0).
END IF.
DO IF SYSMIS(thuiszorg_verzorging_T0)=1  and thuiszorg_T0=2.
RECODE thuiszorg_verzorging_weken_T0  thuiszorg_verzorging_uur_T0 (SYSMIS=0).
END IF.
DO IF SYSMIS(thuiszorg_verpleging_T0)=1  and thuiszorg_T0=2.
RECODE thuiszorg_verpleging_weken_T0  thuiszorg_verpleging_uur_T0 (SYSMIS=0).
END IF.
DO IF thuiszorg_T0=1.
RECODE thuiszorg_hh_T0 thuiszorg_verzorging_T0 thuiszorg_verpleging_T0  (SYSMIS=0).
END IF.
EXECUTE. 

** missings toevoegen.
RECODE thuiszorg_T0 (SYSMIS=9).
DO IF (thuiszorg_T0 =9).
RECODE thuiszorg_hh_T0 thuiszorg_verzorging_T0 thuiszorg_verpleging_T0  (SYSMIS=9).
RECODE  thuiszorg_hh_weken_T0 thuiszorg_verzorging_weken_T0 thuiszorg_verpleging_weken_T0
 thuiszorg_hh_uur_T0 thuiszorg_verzorging_uur_T0 thuiszorg_verpleging_uur_T0 (SYSMIS=999).
END IF.

MISSING VALUES  thuiszorg_T0 thuiszorg_hh_T0 thuiszorg_verzorging_T0 thuiszorg_verpleging_T0  (9)
thuiszorg_hh_weken_T0 thuiszorg_verzorging_weken_T0 thuiszorg_verpleging_weken_T0
 thuiszorg_hh_uur_T0 thuiszorg_verzorging_uur_T0 thuiszorg_verpleging_uur_T0 (999).

*** Q87: gebruik nicotinevervangers afgelopen 3 mnd ****************************************************************************************************************************.

RENAME VARIABLES Q87=nicotinevervangers_T0 / Q88_1=nicotinepleisters_T0 / Q88_2=nicotinekauwgom_T0 / Q88_3=nicotine_microtabs_T0 / Q88_4=nicotine_zuigtabletten_T0 /
Q88_5=nicotine_mondspray_T0 / Q88_6=nicotine_inhaler_T0 / Q88_7=nicotine_anders_T0 / Q88_7_TEXT=nicotine_anders_nl. 

VARIABLE LABELS nicotinevervangers_T0 'nicotinevervangers: ja/nee' /
nicotinepleisters_T0 'nicotinevervangers: pleister ja/nee' /
nicotinekauwgom_T0 'nicotinevervangers: kauwgom ja/nee' /
nicotine_microtabs_T0 'nicotinevervangers: microtabs ja/nee' /
nicotine_zuigtabletten_T0  'nicotinevervangers: zuigtabletten ja/nee' /
nicotine_mondspray_T0 'nicotinevervangers: mondspray ja/nee' /
nicotine_inhaler_T0 'nicotinevervangers: inhaler ja/nee' /
nicotine_anders_T0 'nicotinevervangers: anders ja/nee' /
nicotine_anders_nl 'nicotinevervangers: anders nl.'.

VALUE LABELS nicotinevervangers_T0 1 'nee'  2  'ja' / nicotinepleisters_T0 nicotinekauwgom_T0 nicotine_microtabs_T0 nicotine_zuigtabletten_T0 
nicotine_mondspray_T0 nicotine_inhaler_T0 nicotine_anders_T0  0 'nee'1 'ja'.

* Indien nicotinevervangers_T0 niet missing is, moeten de verschillende soorten missings 0 zijn.
DO IF (nicotinevervangers_T0=1 or nicotinevervangers_T0=2).
RECODE nicotinepleisters_T0 nicotinekauwgom_T0 nicotine_microtabs_T0 nicotine_zuigtabletten_T0 nicotine_mondspray_T0 nicotine_inhaler_T0 nicotine_anders_T0 (SYSMIS=0).
END IF.
EXECUTE.

* missing toevoegen (rest van sysmis is missing).
RECODE nicotinevervangers_T0 nicotinepleisters_T0 nicotinekauwgom_T0 nicotine_microtabs_T0 nicotine_zuigtabletten_T0 nicotine_mondspray_T0 nicotine_inhaler_T0 
nicotine_anders_T0 (SYSMIS=9).
MISSING VALUES nicotinevervangers_T0 nicotinepleisters_T0 nicotinekauwgom_T0 nicotine_microtabs_T0 nicotine_zuigtabletten_T0 nicotine_mondspray_T0 nicotine_inhaler_T0 
nicotine_anders_T0 (9).
EXECUTE.

RENAME VARIABLES Q106_X1.0=nicotinepleisters_stuks_T0 / Q106_X2.0=nicotinekauwgom_stuks_T0 / Q106_X3.0=nicotine_microtabs_stuks_T0 / 
Q106_X4=nicotine_zuigtabletten_stuks_T0 / Q106_X5=nicotine_mondspray_keer_T0 / Q106_X6=nicotine_inhaler_keer_T0 / Q106_X7=nicotine_anders_stuks_T0 / 
Q107_X1=nicotinepleisters_dagen_T0 / Q107_X2=nicotinekauwgom_dagen_T0 / Q107_X3=nicotine_microtabs_dagen_T0 / 
Q107_X4=nicotine_zuigtabletten_dagen_T0 / Q107_X5=nicotine_mondspray_dagen_T0 / Q107_X6=nicotine_inhaler_dagen_T0 / Q107_X7=nicotine_anders_dagen_T0.

VARIABLE LABELS nicotinepleisters_stuks_T0 'nicotinevervangers: pleister aantal stuks/dag' /
nicotinekauwgom_stuks_T0  'nicotinevervangers: kauwgom aantal stuks/dag' /
nicotine_microtabs_stuks_T0 'nicotinevervangers: microtabs aantal stuks/dag' /
nicotine_zuigtabletten_stuks_T0 'nicotinevervangers: zuigtabletten aantal stuks/dag' /
nicotine_mondspray_keer_T0 'nicotinevervangers: mondspray aantal keer/dag' /
nicotine_inhaler_keer_T0 'nicotinevervangers: inhaler aantal keer/dag' /
nicotine_anders_stuks_T0 'nicotinevervangers: anders aantal stuks/dag'.

VARIABLE LABELS nicotinepleisters_dagen_T0  'nicotinevervangers: pleister aantal dagen' /
nicotinekauwgom_dagen_T0 'nicotinevervangers: kauwgom aantal dagen' /
nicotine_microtabs_dagen_T0 'nicotinevervangers: microtabs aantal dagen' /
nicotine_zuigtabletten_dagen_T0 'nicotinevervangers: zuigtabletten aantal dagen' /
nicotine_mondspray_dagen_T0 'nicotinevervangers: mondspray aantal dagen' /
nicotine_inhaler_dagen_T0 'nicotinevervangers: inhaler aantal dagen' /
nicotine_anders_dagen_T0 'nicotinevervangers: anders aantal dagen'.

* aantal stuks en aantal dagen van string naar numeriek.
* controle geen tekst.
FREQUENCIES VARIABLES= nicotinepleisters_stuks_T0 nicotinekauwgom_stuks_T0 nicotine_microtabs_stuks_T0 
    nicotine_zuigtabletten_stuks_T0 nicotine_mondspray_keer_T0 nicotine_inhaler_keer_T0 
    nicotine_anders_stuks_T0 nicotinepleisters_dagen_T0 nicotinekauwgom_dagen_T0 
    nicotine_microtabs_dagen_T0 nicotine_zuigtabletten_dagen_T0 nicotine_mondspray_dagen_T0 
    nicotine_inhaler_dagen_T0 nicotine_anders_dagen_T0
  /ORDER=ANALYSIS.

ALTER TYPE nicotinepleisters_stuks_T0 nicotinekauwgom_stuks_T0 nicotine_microtabs_stuks_T0 
    nicotine_zuigtabletten_stuks_T0 nicotine_mondspray_keer_T0 nicotine_inhaler_keer_T0 
    nicotine_anders_stuks_T0 nicotinepleisters_dagen_T0 nicotinekauwgom_dagen_T0 
    nicotine_microtabs_dagen_T0 nicotine_zuigtabletten_dagen_T0 nicotine_mondspray_dagen_T0 
    nicotine_inhaler_dagen_T0 nicotine_anders_dagen_T0 (F3.0).

* controle reele getallen.
FREQUENCIES VARIABLES=nicotinepleisters_stuks_T0 nicotinekauwgom_stuks_T0 nicotine_microtabs_stuks_T0 
    nicotine_zuigtabletten_stuks_T0 nicotine_mondspray_keer_T0 nicotine_inhaler_keer_T0 
    nicotine_anders_stuks_T0 nicotinepleisters_dagen_T0 nicotinekauwgom_dagen_T0 
    nicotine_microtabs_dagen_T0 nicotine_zuigtabletten_dagen_T0 nicotine_mondspray_dagen_T0 
    nicotine_inhaler_dagen_T0 nicotine_anders_dagen_T0
  /ORDER=ANALYSIS.

*** nvt toevoegen.
DO IF (nicotinepleisters_T0=0).
RECODE nicotinepleisters_stuks_T0 (SYSMIS=888).
RECODE nicotinepleisters_dagen_T0 (SYSMIS=888).
END IF.
DO IF (nicotinekauwgom_T0=0).
RECODE nicotinekauwgom_stuks_T0 (SYSMIS=888).
RECODE nicotinekauwgom_dagen_T0 (SYSMIS=888).
END IF.
DO IF (nicotine_microtabs_T0=0).
RECODE nicotine_microtabs_stuks_T0 (SYSMIS=888).
RECODE nicotine_microtabs_dagen_T0 (SYSMIS=888).
END IF.
DO IF (nicotine_zuigtabletten_T0=0).
RECODE nicotine_zuigtabletten_stuks_T0 (SYSMIS=888).
RECODE nicotine_zuigtabletten_dagen_T0 (SYSMIS=888).
END IF.
EXECUTE.
DO IF (nicotine_mondspray_T0=0).
RECODE nicotine_mondspray_keer_T0 (SYSMIS=888).
RECODE nicotine_mondspray_dagen_T0 (SYSMIS=888).
END IF.
EXECUTE.
DO IF (nicotine_inhaler_T0=0).
RECODE nicotine_inhaler_keer_T0 (SYSMIS=888).
RECODE nicotine_inhaler_dagen_T0 (SYSMIS=888).
END IF.
DO IF (nicotine_anders_T0=0).
RECODE nicotine_anders_stuks_T0 (SYSMIS=888).
RECODE nicotine_anders_dagen_T0 (SYSMIS=888).
END IF.
EXECUTE.

** Degene die nu nog sysmis zijn zijn echt missing (worden wel gebruikt maar geen aantal ingevuld).
RECODE nicotinepleisters_stuks_T0 nicotinekauwgom_stuks_T0 nicotine_microtabs_stuks_T0 
    nicotine_zuigtabletten_stuks_T0 nicotine_mondspray_keer_T0 nicotine_inhaler_keer_T0 
    nicotine_anders_stuks_T0 nicotinepleisters_dagen_T0 nicotinekauwgom_dagen_T0 
    nicotine_microtabs_dagen_T0 nicotine_zuigtabletten_dagen_T0 nicotine_mondspray_dagen_T0 
    nicotine_inhaler_dagen_T0 nicotine_anders_dagen_T0 (SYSMIS=999).
EXECUTE.

MISSING VALUES nicotinepleisters_stuks_T0 nicotinekauwgom_stuks_T0 nicotine_microtabs_stuks_T0 
    nicotine_zuigtabletten_stuks_T0 nicotine_mondspray_keer_T0 nicotine_inhaler_keer_T0 
    nicotine_anders_stuks_T0 nicotinepleisters_dagen_T0 nicotinekauwgom_dagen_T0 
    nicotine_microtabs_dagen_T0 nicotine_zuigtabletten_dagen_T0 nicotine_mondspray_dagen_T0 
    nicotine_inhaler_dagen_T0 nicotine_anders_dagen_T0 (888,  999) nicotinepleisters_T0 nicotinekauwgom_T0 nicotine_microtabs_T0 
    nicotine_zuigtabletten_T0 nicotine_mondspray_T0 nicotine_inhaler_T0 nicotine_anders_T0 (9).

VARIABLE LEVEL nicotinevervangers_T0 nicotinepleisters_T0 nicotinekauwgom_T0 nicotine_microtabs_T0 
    nicotine_zuigtabletten_T0 nicotine_mondspray_T0 nicotine_inhaler_T0 nicotine_anders_T0 (NOMINAL).
VARIABLE LEVEL nicotinepleisters_stuks_T0 nicotinekauwgom_stuks_T0 nicotine_microtabs_stuks_T0 
    nicotine_zuigtabletten_stuks_T0 nicotine_mondspray_keer_T0 nicotine_inhaler_keer_T0 
    nicotine_anders_stuks_T0 nicotinepleisters_dagen_T0 nicotinekauwgom_dagen_T0 
    nicotine_microtabs_dagen_T0 nicotine_zuigtabletten_dagen_T0 nicotine_mondspray_dagen_T0 
    nicotine_inhaler_dagen_T0 nicotine_anders_dagen_T0 (SCALE).

** antwoorden in categorie 'anders' gelijk maken.
RECODE nicotine_anders_nl ('electronisch roken'='E sigaret').
RECODE nicotine_anders_nl ('e-sigaret'='E sigaret').
RECODE nicotine_anders_nl ('e-sigaret'='E sigaret').
RECODE nicotine_anders_nl ('e sigaret'='E sigaret').
RECODE nicotine_anders_nl ('champix'='Champix').

** Er wordt eerder naar nicotinevervangers gevraagd: hulpmiddel1_T0 (heeft u wel eens gebruik gemaakt van nicotinevervangers?).
*Als nicotinevervangers_T0 (afgelopen 3 maanden gebruik gemaakt) ja is, moet eerder vraag (ooit gebruikt) ook ja zijn.

CROSSTABS
  /TABLES=hulpmiddel1_T0 BY nicotinevervangers_T0
  /FORMAT=AVALUE TABLES
  /CELLS=COUNT
  /COUNT ROUND CELL.

** hulpmiddel1_T0 aanpassen adhv antwoord op nicotinevervangers_T0.
DO IF nicotinevervangers_T0=2.
RECODE hulpmiddel1_T0 (0=1) (SYSMIS=1).
RECODE hulpmiddel9_T0 (1=0) (SYSMIS=0).
END IF.

** Conservatieve schatting indien bij stuks of aantal 0 is ingevuld:.
DO IF (nicotinepleisters_T0=1).
RECODE nicotinepleisters_stuks_T0 (0=1).
RECODE nicotinepleisters_dagen_T0 (0=1).
END IF.
DO IF (nicotinekauwgom_T0=1).
RECODE nicotinekauwgom_stuks_T0 (0=1).
RECODE nicotinekauwgom_dagen_T0 (0=1).
END IF.
DO IF (nicotine_microtabs_T0=1).
RECODE nicotine_microtabs_stuks_T0 (0=1).
RECODE nicotine_microtabs_dagen_T0 (0=1).
END IF.
DO IF (nicotine_zuigtabletten_T0=1).
RECODE nicotine_zuigtabletten_stuks_T0 (0=1).
RECODE nicotine_zuigtabletten_dagen_T0 (0=1)..
END IF.
EXECUTE.
DO IF (nicotine_mondspray_T0=1).
RECODE nicotine_mondspray_keer_T0 (0=1).
RECODE nicotine_mondspray_dagen_T0 (0=1).
END IF.
EXECUTE.
DO IF (nicotine_inhaler_T0=1).
RECODE nicotine_inhaler_keer_T0 (0=1).
RECODE nicotine_inhaler_dagen_T0 (0=1).
END IF.
DO IF (nicotine_anders_T0=1).
RECODE nicotine_anders_stuks_T0 (0=1).
RECODE nicotine_anders_dagen_T0 (0=1).
END IF.
EXECUTE.


*** Q89: gebruik electronische sigaretten ****************************************************************************************************************************.
RENAME VARIABLES Q89 =Esigaret_T0 / Q90_1=Esigaret_met_nicotine_T0 / Q90_2=Esigaret_zonder_nicotine_T0.
VARIABLE LABELS Esigaret_T0 'E-sigaret gebruikt: ja/nee'
Esigaret_met_nicotine_T0  'E-sigaret met nicotine: ja/nee' 
Esigaret_zonder_nicotine_T0  'E-sigaret zonder nicotine: ja/nee'.
VALUE LABELS Esigaret_met_nicotine_T0 Esigaret_zonder_nicotine_T0 0 'nee'1 'ja' .

* Indien Esigaret_T0 missing is, moeten de verschillende soorten dat ook zijn (zijn default 0).
DO IF (SYSMIS(Esigaret_T0)=0).
RECODE Esigaret_met_nicotine_T0 Esigaret_zonder_nicotine_T0 (SYSMIS=0).
END IF.
EXECUTE.

** Er wordt eerder naar e-sigaretten gevraagd: hulpmiddel4_T0 (heeft u wel eens gebruik gemaakt van electronische sigaretten?).
*Als Esigaret_T0 ja is, moet eerder vraag (ooit gebruikt) ook ja zijn.

CROSSTABS
  /TABLES=hulpmiddel4_T0 BY Esigaret_T0   
  /FORMAT=AVALUE TABLES
  /CELLS=COUNT
  /COUNT ROUND CELL.

*klopt 162 x niet.
* hulpmiddel4_T0 aanpassen adhv antwoord op Esigaret_T0. 
DO IF Esigaret_T0 =2.
RECODE hulpmiddel4_T0 (0=1) (SYSMIS=1).
RECODE hulpmiddel9_T0 (1=0) (SYSMIS=0).
END IF.

RENAME VARIABLES Q108_1_x1_1= Esigaret_met_nicotine_stuks_T0 / Q108_1_x2_1 =Esigaret_zonder_nicotine_stuks_T0/
Q108_2_x1_1=Esigaret_met_nicotine_dagen_T0 / Q108_2_x2_1=Esigaret_zonder_nicotine_dagen_T0.
VARIABLE LABELS  Esigaret_met_nicotine_stuks_T0 'E-sigaret met nicotine: aantal stuks/dag' / Esigaret_zonder_nicotine_stuks_T0 'E-sigaret zonder nicotine: aantal stuks/dag'.
VARIABLE LABELS Esigaret_met_nicotine_dagen_T0 'E-sigaret met nicotine: aantal dagen' / Esigaret_zonder_nicotine_dagen_T0 'E-sigaret zonder nicotine: aantal dagen'.

*stuks en dagen van string naar numeriek.

* controle geen tekst.
FREQUENCIES VARIABLES=  Esigaret_met_nicotine_stuks_T0 Esigaret_zonder_nicotine_stuks_T0 Esigaret_met_nicotine_dagen_T0 Esigaret_zonder_nicotine_dagen_T0
  /ORDER=ANALYSIS.

ALTER TYPE Esigaret_met_nicotine_stuks_T0 Esigaret_zonder_nicotine_stuks_T0 Esigaret_met_nicotine_dagen_T0 Esigaret_zonder_nicotine_dagen_T0 (F4.0).

* controle reele getallen.
FREQUENCIES VARIABLES=Esigaret_met_nicotine_stuks_T0 Esigaret_zonder_nicotine_stuks_T0 Esigaret_met_nicotine_dagen_T0 Esigaret_zonder_nicotine_dagen_T0
  /ORDER=ANALYSIS.
* ID 4915 aantal stuks=9999 --> missing maken.
DO IF ID_code=4915.
RECODE Esigaret_met_nicotine_stuks_T0 Esigaret_zonder_nicotine_stuks_T0 (9999=999).
END IF.


* Als Esigaret=2 (ja) en met-zonder nicotine zijn beiden 0?  missing maken.
DO IF Esigaret_T0=2 and Esigaret_met_nicotine_T0=0 and Esigaret_zonder_nicotine_T0=0 .
RECODE Esigaret_met_nicotine_T0 Esigaret_zonder_nicotine_T0 (0=9).
END IF.

* Als een van de middelen ja is, en aantal stuks en/of aantal dagen =0  conservatieve schatting van 1. 
DO IF (Esigaret_met_nicotine_T0=1).
RECODE Esigaret_met_nicotine_stuks_T0 (0=1).
RECODE Esigaret_met_nicotine_dagen_T0 (0=1).
END IF.
DO IF (Esigaret_zonder_nicotine_T0=1).
RECODE Esigaret_zonder_nicotine_stuks_T0 (0=1).
RECODE Esigaret_zonder_nicotine_dagen_T0 (0=1).
END IF.

*Aantal dagen (kan max 91 zijn).
RECODE Esigaret_met_nicotine_dagen_T0 Esigaret_zonder_nicotine_dagen_T0 (280=91) (180=91).

*** missing en  nvt toevoegen.
RECODE Esigaret_T0 Esigaret_met_nicotine_T0 Esigaret_zonder_nicotine_T0 (SYSMIS=9).
DO IF (Esigaret_met_nicotine_T0=0).
RECODE Esigaret_met_nicotine_stuks_T0 (SYSMIS=888).
RECODE Esigaret_met_nicotine_dagen_T0 (SYSMIS=888).
END IF.
DO IF (Esigaret_zonder_nicotine_T0=0).
RECODE Esigaret_zonder_nicotine_stuks_T0 (SYSMIS=888).
RECODE Esigaret_zonder_nicotine_dagen_T0 (SYSMIS=888).
END IF.
DO IF (Esigaret_met_nicotine_T0=1).
RECODE Esigaret_met_nicotine_stuks_T0 (SYSMIS=999).
RECODE Esigaret_met_nicotine_dagen_T0 (SYSMIS=999).
END IF.
DO IF (Esigaret_zonder_nicotine_T0=1).
RECODE Esigaret_zonder_nicotine_stuks_T0 (SYSMIS=999).
RECODE Esigaret_zonder_nicotine_dagen_T0 (SYSMIS=999).
END IF.
DO IF (Esigaret_met_nicotine_T0=9).
RECODE Esigaret_met_nicotine_stuks_T0 (SYSMIS=999).
RECODE Esigaret_met_nicotine_dagen_T0 (SYSMIS=999).
END IF.
DO IF (Esigaret_zonder_nicotine_T0=9).
RECODE Esigaret_zonder_nicotine_stuks_T0 (SYSMIS=999).
RECODE Esigaret_zonder_nicotine_dagen_T0 (SYSMIS=999).
END IF.
EXECUTE.

MISSING VALUES  Esigaret_T0 Esigaret_met_nicotine_T0 Esigaret_zonder_nicotine_T0 (9)
Esigaret_met_nicotine_stuks_T0 Esigaret_zonder_nicotine_stuks_T0 Esigaret_met_nicotine_dagen_T0 Esigaret_zonder_nicotine_dagen_T0 (888,999).

*** Q91 medicatie *******************************************************************************************************************************************************.
RENAME VARIABLES Q91=medicatie_T0 / Q112_1.0 = med1_T0 / Q112_2.0 = med2_T0 /Q112_3.0 = med3_T0 /Q112_4.0 = med4_T0 /Q112_5.0 = med5_T0 /
Q112_6.0 = med6_T0 /Q112_7.0 = med7_T0 /Q112_8.0 = med8_T0 /Q112_9.0 = med9_T0 /Q112_10.0 = med10_T0. 

VARIABLE LABELS medicatie_T0 'medicatie ja/nee T0' med1_T0 'med naam 1 T0'  med2_T0 'med naam 2 T0'  med3_T0 'med naam 3 T0'  med4_T0 'med naam 4 T0'
 med5_T0 'med naam 5 T0'  med6_T0 'med naam 6 T0'  med7_T0 'med naam 7 T0'  med8_T0 'med naam 8 T0'  med9_T0 'med naam 9 T0'  med10_T0 'med naam 10 T0'.

** als medicatie_T0=1 (nee) of missing: med1_T0 moet leeg zijn.
USE ALL.
COMPUTE filter_$=(medicatie_T0=1 or MISSING(medicatie_T0)=1).
VARIABLE LABELS filter_$ 'medicatie_T0=1 of missing (FILTER)'.
VALUE LABELS filter_$ 0 'Not Selected' 1 'Selected'.
FORMATS filter_$ (f1.0).
FILTER BY filter_$.
EXECUTE.
FREQUENCIES VARIABLES=med1_T0
  /ORDER=ANALYSIS.
USE ALL.



** 2x wel Med1 maar medicatie_T0 is missing: hercoderen.
IF (ID_code=1913 or ID_code=5909) medicatie_T0=2.

** ID 6004: heeft bij medicatie 'narcose' ingevuld (heeft idd een operatie gehad).
IF (ID_code=6004) med1_T0=''.
IF (ID_code=6004) Q113_x1=''.
IF (ID_code=6004) Q114_x1=''.
IF (ID_code=6004) Q115_x1=''.
IF (ID_code=6004) Q116_x1=''.
EXECUTE.

RENAME VARIABLES Q113_x1=med1_dosering_T0 / Q113_x2=med2_dosering_T0 / Q113_x3=med3_dosering_T0 / Q113_x4=med4_dosering_T0 / Q113_x5=med5_dosering_T0 /
Q113_x6=med6_dosering_T0 / Q113_x7=med7_dosering_T0 / Q113_x8=med8_dosering_T0 / Q113_x9=med9_dosering_T0 / Q113_x10=med10_dosering_T0.

VARIABLE LABELS  med1_dosering_T0 / med2_dosering_T0 / med3_dosering_T0 / med4_dosering_T0 / med5_dosering_T0 / med6_dosering_T0 / med7_dosering_T0 / 
    med8_dosering_T0 / med9_dosering_T0 / med10_dosering_T0.

RENAME VARIABLES Q114_x1=med1_keerperdag_T0 / Q114_x2=med2_keerperdag_T0 / Q114_x3=med3_keerperdag_T0 / Q114_x4=med4_keerperdag_T0 / 
Q114_x5=med5_keerperdag_T0 / Q114_x6=med6_keerperdag_T0 / Q114_x7=med7_keerperdag_T0 / Q114_x8=med8_keerperdag_T0 / Q114_x9=med9_keerperdag_T0 / 
Q114_x10=med10_keerperdag_T0 .

VARIABLE LABELS  med1_keerperdag_T0 / med2_keerperdag_T0 / med3_keerperdag_T0 / med4_keerperdag_T0 / med5_keerperdag_T0 / 
    med6_keerperdag_T0 / med7_keerperdag_T0 / med8_keerperdag_T0 / med9_keerperdag_T0 / med10_keerperdag_T0.

RENAME VARIABLES Q115_x1=med1_aantdagen_T0 / Q115_x2=med2_aantdagen_T0 / Q115_x3=med3_aantdagen_T0 / Q115_x4=med4_aantdagen_T0 / 
Q115_x5=med5_aantdagen_T0 / Q115_x6=med6_aantdagen_T0 / Q115_x7=med7_aantdagen_T0 / Q115_x8=med8_aantdagen_T0 / Q115_x9=med9_aantdagen_T0 /
Q115_x10=med10_aantdagen_T0.

VARIABLE LABELS   med1_aantdagen_T0 / med2_aantdagen_T0 / med3_aantdagen_T0  / med4_aantdagen_T0 / med5_aantdagen_T0 /
    med6_aantdagen_T0 / med7_aantdagen_T0 / med8_aantdagen_T0 / med9_aantdagen_T0 / med10_aantdagen_T0.

RENAME VARIABLES Q116_x1=med1_vorm_T0 / Q116_x2=med2_vorm_T0 / Q116_x3=med3_vorm_T0 / Q116_x4=med4_vorm_T0 / Q116_x5=med5_vorm_T0 / 
Q116_x6=med6_vorm_T0 / Q116_x7=med7_vorm_T0 / Q116_x8=med8_vorm_T0 / Q116_x9=med9_vorm_T0 / Q116_x10=med10_vorm_T0.

VARIABLE LABELS  med1_vorm_T0 / med2_vorm_T0 / med3_vorm_T0 / med4_vorm_T0 / med5_vorm_T0 / med6_vorm_T0 / med7_vorm_T0 / 
    med8_vorm_T0 / med9_vorm_T0 / med10_vorm_T0.

*aantal keer per dag van string naar numeriek.
* controle op tekst en decimalen moeten met komma.
FREQUENCIES VARIABLES= med1_keerperdag_T0 med2_keerperdag_T0 med3_keerperdag_T0 med4_keerperdag_T0 med5_keerperdag_T0 
    med6_keerperdag_T0 med7_keerperdag_T0 med8_keerperdag_T0 med9_keerperdag_T0 med10_keerperdag_T0
  /ORDER=ANALYSIS.

RECODE med3_keerperdag_T0 ('0,3'='0.3').
RECODE med3_keerperdag_T0 ('0,5'='0.5').
RECODE med3_keerperdag_T0 ('13.8'='13,8').
RECODE med4_keerperdag_T0 ('0,3'='0.3').
EXECUTE.
ALTER TYPE med1_keerperdag_T0 med2_keerperdag_T0 med3_keerperdag_T0 med4_keerperdag_T0 med5_keerperdag_T0 
    med6_keerperdag_T0 med7_keerperdag_T0 med8_keerperdag_T0 med9_keerperdag_T0 med10_keerperdag_T0 (F3.1).

* controle reele getallen.
FREQUENCIES VARIABLES=med1_keerperdag_T0 med2_keerperdag_T0 med3_keerperdag_T0 med4_keerperdag_T0 med5_keerperdag_T0 
    med6_keerperdag_T0 med7_keerperdag_T0 med8_keerperdag_T0 med9_keerperdag_T0 med10_keerperdag_T0
  /ORDER=ANALYSIS.



*Q115 (aantal dagen) van string naar numeriek.
* controle op tekst en decimalen moeten met komma.
FREQUENCIES VARIABLES= med1_aantdagen_T0 med2_aantdagen_T0 med3_aantdagen_T0 med4_aantdagen_T0 med5_aantdagen_T0 
    med6_aantdagen_T0 med7_aantdagen_T0 med8_aantdagen_T0 med9_aantdagen_T0 med10_aantdagen_T0 
 /ORDER=ANALYSIS.

ALTER TYPE med1_aantdagen_T0 med2_aantdagen_T0 med3_aantdagen_T0 med4_aantdagen_T0 med5_aantdagen_T0 
    med6_aantdagen_T0 med7_aantdagen_T0 med8_aantdagen_T0 med9_aantdagen_T0 med10_aantdagen_T0  (F3.0).

* controle reele getallen.
FREQUENCIES VARIABLES=med1_aantdagen_T0 med2_aantdagen_T0 med3_aantdagen_T0 med4_aantdagen_T0 med5_aantdagen_T0 
    med6_aantdagen_T0 med7_aantdagen_T0 med8_aantdagen_T0 med9_aantdagen_T0 med10_aantdagen_T0 
  /ORDER=ANALYSIS.


** ID 4909 heeft medicatie=ja en vervolgens overal 0.Hercoderen naar missing.
DO IF (ID_code=4909).
RECODE medicatie_T0 (2=1).
RECODE  med1_T0 to med10_T0 ('0' =' ').
RECODE  med1_dosering_T0 to med10_dosering_T0 ('0' =' ').
RECODE  med1_vorm_T0 to med10_vorm_T0 ('0' =' ').
RECODE  med4_vorm_T0 ('0.' =' ').
RECODE  med1_keerperdag_T0 to med10_keerperdag_T0 (0 =SYSMIS).
RECODE  med1_aantdagen_T0 to med10_aantdagen_T0 (0 =SYSMIS).
END IF.

** ID 5202 heeft medicatie=ja en vervolgens bij namen 0.Hercoderen naar missing.
DO IF (ID_code=5202).
RECODE medicatie_T0 (2=1).
RECODE  med1_T0 to med10_T0 ('0' =' ').
END IF.


** ID 3111	med 1: homeopatische; med 2: middelen; med3: please!  alles missing.
DO IF (ID_code=3111).
RECODE medicatie_T0 (2=1).
RECODE  med1_T0 ('homeopatische' =' ').
RECODE  med1_dosering_T0 ('200mg' =' ').
RECODE  med1_keerperdag_T0 (6 =SYSMIS).
RECODE  med1_aantdagen_T0 (30 =SYSMIS).
RECODE  med2_T0 ('middelen' =' ').
RECODE  med2_dosering_T0 ('please!' =' ').
RECODE  med2_keerperdag_T0 (3 =SYSMIS).
RECODE  med2_aantdagen_T0 (60 =SYSMIS).
END IF.

** ID 5702	med2: 9/1 gestopt, dat is 5 weken voor invullen vragenlijst. Hele medicijn verwijderen.
DO IF (ID_code=5702).
RECODE  med2_T0 ('Metoprololsuccinaat' =' ').
RECODE  med2_dosering_T0 ('9/1 gestopt' =' ').
RECODE  med2_keerperdag_T0 (1 =SYSMIS).
RECODE  med2_aantdagen_T0 (69 =SYSMIS).
RECODE  med2_vorm_T0 ('tablet' ='').
END IF.
EXECUTE. 

** missing invullen.
RECODE medicatie_T0 (SYSMIS=9).
MISSING VALUES  medicatie_T0 (9).
EXECUTE.

*** Vorm hetzelfde noemen.
FREQUENCIES VARIABLES=med1_vorm_T0 med2_vorm_T0 med3_vorm_T0 med4_vorm_T0 med5_vorm_T0 med6_vorm_T0 
    med7_vorm_T0 med8_vorm_T0 med9_vorm_T0 med10_vorm_T0
  /ORDER=ANALYSIS.

RECODE med1_vorm_T0 ('Bruistablet'='bruistablet').
RECODE med1_vorm_T0 ('bruis'='bruistablet').
RECODE med1_vorm_T0 ('Bruis'='bruistablet').
RECODE med1_vorm_T0 ('pi'='tablet').
RECODE med1_vorm_T0 ('PIL'='tablet').
RECODE med1_vorm_T0 ('p'='tablet').
RECODE med1_vorm_T0 ('pil'='tablet').
RECODE med1_vorm_T0 ('Pil'='tablet').
RECODE med1_vorm_T0 ('pillen'='tablet').
RECODE med1_vorm_T0 ('Pillen'='tablet').
RECODE med1_vorm_T0 ('Pillen (capsules)'='tablet').
RECODE med1_vorm_T0 ('Pilletje'='tablet').
RECODE med1_vorm_T0 ('capsules'='tablet').
RECODE med1_vorm_T0 ('Capsules'='tablet').
RECODE med1_vorm_T0 ('Tablet'='tablet').
RECODE med1_vorm_T0 ('Tabl'='tablet').
RECODE med1_vorm_T0 ('inhaler'='inhalator').
RECODE med1_vorm_T0 ('inhalatie'='inhalator').
RECODE med1_vorm_T0 ('puffer'='inhalator').
RECODE med1_vorm_T0 ('pufjes'='inhalator').
RECODE med1_vorm_T0 ('pufje'='inhalator').
RECODE med1_vorm_T0 ('Injectie'='injectie').
RECODE med1_vorm_T0 ('Poeder'='poeder').
RECODE med1_vorm_T0 ('Pleister'='pleister').
RECODE med1_vorm_T0 ('Vloeistof'='vloeistof').
RECODE med1_vorm_T0 ('verstuiving'='verstuiver').
RECODE med1_vorm_T0 ('Zalf'='zalf').

RECODE med2_vorm_T0 ('pil'='tablet').
RECODE med2_vorm_T0 ('Pil'='tablet').
RECODE med2_vorm_T0 ('p'='tablet').
RECODE med2_vorm_T0 ('pillen'='tablet').
RECODE med2_vorm_T0 ('PIL'='tablet').
RECODE med2_vorm_T0 ('pillenb'='tablet').
RECODE med2_vorm_T0 ('Pillen'='tablet').
RECODE med2_vorm_T0 ('pilletje'='tablet').
RECODE med2_vorm_T0 ('Pilletje'='tablet').
RECODE med2_vorm_T0 ('Tabletten'='tablet').
RECODE med2_vorm_T0 ('Tablet'='tablet').
RECODE med2_vorm_T0 ('Tabl'='tablet').
RECODE med2_vorm_T0 ('zuigtablet'='tablet').
RECODE med2_vorm_T0 ('capsule'='tablet').
RECODE med2_vorm_T0 ('caps'='tablet').
RECODE med2_vorm_T0 ('Zetpil'='zetpil').
RECODE med2_vorm_T0 ('verstuiver pompje'='verstuiver').
RECODE med2_vorm_T0 ('inhaleren'='inhalator').
RECODE med2_vorm_T0 ('Inhaler'='inhalator').
RECODE med2_vorm_T0 ('inhalatie'='inhalator').
RECODE med2_vorm_T0 ('inhalor'='inhalator').
RECODE med2_vorm_T0 ('pufjes'='inhalator').
RECODE med2_vorm_T0 ('Pufje'='inhalator').
RECODE med2_vorm_T0 ('Puf'='inhalator').
RECODE med2_vorm_T0 ('puf'='inhalator').
RECODE med2_vorm_T0 ('pompje'='inhalator').
RECODE med2_vorm_T0 ('Poeder'='poeder').
RECODE med2_vorm_T0 ('poedervorm'='poeder').

RECODE med3_vorm_T0 ('pil'='tablet').
RECODE med3_vorm_T0 ('pillen'='tablet').
RECODE med3_vorm_T0 ('Pillen'='tablet').
RECODE med3_vorm_T0 ('pil'='tablet').
RECODE med3_vorm_T0 ('Pil'='tablet').
RECODE med3_vorm_T0 ('pilletje'='tablet').
RECODE med3_vorm_T0 ('Pilletje'='tablet').
RECODE med3_vorm_T0 ('piul'='tablet').
RECODE med3_vorm_T0 ('p'='tablet').
RECODE med3_vorm_T0 ('smelttablet'='tablet').
RECODE med3_vorm_T0 ('Smelttablet'='tablet').
RECODE med3_vorm_T0 ('Tabl'='tablet').
RECODE med3_vorm_T0 ('capsule'='tablet').
RECODE med3_vorm_T0 ('Inhalator'='inhalator').
RECODE med3_vorm_T0 ('Innalatie'='inhalator').
RECODE med3_vorm_T0 ('inhalinging'='inhalator').
RECODE med3_vorm_T0 ('inhalatie'='inhalator').
RECODE med3_vorm_T0 ('inhalor'='inhalator').
RECODE med3_vorm_T0 ('puffer'='inhalator').
RECODE med3_vorm_T0 ('puf'='inhalator').
RECODE med3_vorm_T0 ('pompje'='inhalator').
RECODE med3_vorm_T0 ('Pleister'='pleister').
RECODE med3_vorm_T0 ('Poeder'='poeder').
RECODE med3_vorm_T0 ('snuif'='verstuiver').
RECODE med3_vorm_T0 ('Injectie'='injectie').
RECODE med3_vorm_T0 ('intraveneus'='injectie').
RECODE med3_vorm_T0 ('Druppels'='druppels').
RECODE med3_vorm_T0 ('droppels'='druppels').
RECODE med3_vorm_T0 ('Vloeistof'='vloeistof').

RECODE med4_vorm_T0 ('pil'='tablet').
RECODE med4_vorm_T0 ('pillen'='tablet').
RECODE med4_vorm_T0 ('Pilletje'='tablet').
RECODE med4_vorm_T0 ('Pillen'='tablet').
RECODE med4_vorm_T0 ('Pil'='tablet').
RECODE med4_vorm_T0 ('capsule'='tablet').
RECODE med4_vorm_T0 ('Zetpil'='zetpil').
RECODE med4_vorm_T0 ('Inhalator'='inhalator').
RECODE med4_vorm_T0 ('Poeder'='poeder').

RECODE med5_vorm_T0 ('pil'='tablet').
RECODE med5_vorm_T0 ('Pil'='tablet').
RECODE med5_vorm_T0 ('pillen'='tablet').
RECODE med5_vorm_T0 ('zuig tablet'='tablet').
RECODE med5_vorm_T0 ('pil en pleisters'='tablet en pleister').
RECODE med5_vorm_T0 ('pufje'='inhalator').
RECODE med5_vorm_T0 ('Poeder'='poeder').
RECODE med5_vorm_T0 ('Pillen'='tablet').
RECODE med5_vorm_T0 ('Capsule'='tablet').
RECODE med5_vorm_T0 ('Spray'='verstuiver').

RECODE med6_vorm_T0 ('inhaler'='inhalator').
RECODE med6_vorm_T0 ('Inhaler'='inhalator').
RECODE med6_vorm_T0 ('Pil'='tablet').
RECODE med6_vorm_T0 ('pil'='tablet').
RECODE med6_vorm_T0 ('pillen'='tablet').
RECODE med6_vorm_T0 ('Poeder'='poeder').

RECODE med7_vorm_T0 ('pil'='tablet').
RECODE med7_vorm_T0 ('Pil'='tablet').
RECODE med7_vorm_T0 ('capsule'='tablet').
RECODE med7_vorm_T0 ('pillen'='tablet').
RECODE med7_vorm_T0 ('spuit'='injectie').
RECODE med7_vorm_T0 ('Pillen'='tablet').
RECODE med7_vorm_T0 ('Neusspray'='verstuiver').

RECODE med8_vorm_T0 ('pil'='tablet').
RECODE med8_vorm_T0 ('pillen'='tablet').
RECODE med8_vorm_T0 ('spuit'='injectie').
RECODE med8_vorm_T0 ('Inhaler'='inhalator').

RECODE med9_vorm_T0 ('pil'='tablet').
RECODE med9_vorm_T0 ('pillen'='tablet').
EXECUTE.

RECODE med10_vorm_T0 ('tablet/0'='tablet').
EXECUTE.


FREQUENCIES VARIABLES=med1_vorm_T0 med2_vorm_T0 med3_vorm_T0 med4_vorm_T0 med5_vorm_T0 med6_vorm_T0 
    med7_vorm_T0 med8_vorm_T0 med9_vorm_T0 med10_vorm_T0
  /ORDER=ANALYSIS.

*** aparte syntaxen ATC code, dosering en kosten runnen. 


** Na runnen ATC>.

* Nicotinevervangers (N07BA01) worden uit de medicatie gehaald. Controle of ze bij vraag over nicotinevervangers worden genoemd. Zo nee, daar aanvullen.
DO IF atc2_T0='N07BA01'.
COMPUTE med2_T0=' '.
COMPUTE med2_dosering_T0=' '.
COMPUTE med2_keerperdag_T0=$SYSMIS.
COMPUTE med2_aantdagen_T0=$SYSMIS.
COMPUTE med2_vorm_T0=' '.
END IF.
RECODE atc2_T0 ('N07BA01'=' ').
EXECUTE.

DO IF atc3_T0='N07BA01'.
COMPUTE med3_T0=' '.
COMPUTE med3_dosering_T0=' '.
COMPUTE med3_keerperdag_T0=$SYSMIS.
COMPUTE med3_aantdagen_T0=$SYSMIS.
COMPUTE med3_vorm_T0=' '.
END IF.
RECODE atc3_T0 ('N07BA01'=' ').
EXECUTE.

DO IF atc5_T0='N07BA01'.
COMPUTE med5_T0=' '.
COMPUTE med5_dosering_T0=' '.
COMPUTE med5_keerperdag_T0=$SYSMIS.
COMPUTE med5_aantdagen_T0=$SYSMIS.
COMPUTE med5_vorm_T0=' '.
END IF.
RECODE atc5_T0 ('N07BA01'=' ').
EXECUTE.


*** Q93: EHBO********************************************************************************************************************************************.
RENAME VARIABLES Q93=EHBO_T0 / Q93_2_TEXT=EHBO_aant_keer_T0.
VARIABLE LABELS EHBO_T0 'EHBO ja/nee T0' EHBO_aant_keer_T0 'EHBO aantal keer T0'.
VALUE LABELS EHBO_T0 1 'nee' 2 'ja'.
* aantal keer van string naar numeriek.
* controle op tekst.
FREQUENCIES VARIABLES=EHBO_aant_keer_T0
  /ORDER=ANALYSIS.
RECODE EHBO_aant_keer_T0 ('1x ivm erycipelas'='1').
ALTER TYPE EHBO_aant_keer_T0 (F3.0).

* wel naar EHBO en aant keer missing: conservatieve schatting.
DO IF EHBO_T0=2.
RECODE EHBO_aant_keer_T0 (SYSMIS=1).
END IF.
* niet naar EHBO: aantal dagen =0.
DO IF (EHBO_T0=1).
RECODE EHBO_aant_keer_T0 (SYSMIS=0).
END IF.
RECODE EHBO_T0 (SYSMIS=9).
EXECUTE.
DO IF (EHBO_T0=9).
RECODE EHBO_aant_keer_T0 (SYSMIS=99).
END IF.
EXECUTE.
MISSING VALUES EHBO_T0 (9) EHBO_aant_keer_T0 (99).

*** Q94: ambulance********************************************************************************************************************************************.
RENAME VARIABLES Q94=ambulance_T0 / Q94_2_TEXT=ambulance_aant_keer_T0.
VARIABLE LABELS ambulance_T0 'ambulance ja/nee T0' ambulance_aant_keer_T0 'ambulance aantal keer T0'.
VALUE LABELS ambulance_T0 1 'nee' 2 'ja'.

* aantal keer van string naar numeriek.
* controle op tekst.
FREQUENCIES VARIABLES=ambulance_aant_keer_T0
  /ORDER=ANALYSIS.
ALTER TYPE ambulance_aant_keer_T0 (F3.0).

DO IF ambulance_T0=2.
RECODE ambulance_aant_keer_T0 (SYSMIS=1).
END IF.
DO IF ambulance_T0=1.
RECODE ambulance_aant_keer_T0 (SYSMIS=0).
END IF.
EXECUTE.
MISSING VALUES ambulance_aant_keer_T0 (99).
RECODE ambulance_T0 (SYSMIS=9).
EXECUTE.
DO IF (ambulance_T0=9).
RECODE ambulance_aant_keer_T0 (SYSMIS=99).
END IF.
EXECUTE.
MISSING VALUES ambulance_T0 (9) ambulance_aant_keer_T0 (99).

*** Q95: poli********************************************************************************************************************************************.
RENAME VARIABLES Q95=poli_T0.
VARIABLE LABELS poli_T0 'bezoek poli: ja/nee T0'.
VALUE LABELS poli_T0 1 'nee' 2 'ja'.

RECODE poli_T0 (SYSMIS=9).
EXECUTE.
MISSING VALUES poli_T0 (9).

*Q96_1_1_TEXT t/m 6 is excact hetzelfde als Q96_2_1_TEXT t/m 6 (specialisme, inclusief zelfde spelfouten) --> Q96_2 verwijderen.
DELETE VARIABLES  Q96_2_1_TEXT Q96_2_1_TEXT Q96_2_2_TEXT Q96_2_3_TEXT Q96_2_4_TEXT.

RENAME VARIABLES  Q96_1_1_TEXT=specialisme1_T0 /  Q96_1_2_TEXT=specialisme2_T0 /   Q96_1_3_TEXT=specialisme3_T0 / 
  Q96_1_4_TEXT=specialisme4_T0 . 

RENAME VARIABLES  Q96_1_1_1_TEXT=ziekenhuis1_T0 / Q96_1_2_1_TEXT=ziekenhuis2_T0 / Q96_1_3_1_TEXT=ziekenhuis3_T0 / 
Q96_1_4_1_TEXT=ziekenhuis4_T0 . 

RENAME VARIABLES  Q96_2_1_1_TEXT=spec1_aant_keer_T0 / Q96_2_2_1_TEXT=spec2_aant_keer_T0 / Q96_2_3_1_TEXT=spec3_aant_keer_T0 /
Q96_2_4_1_TEXT=spec4_aant_keer_T0 .

** 5 en 6 zijn leeg: verwijderen.
DELETE VARIABLES  Q96_1_5_1_TEXT Q96_1_5_TEXT Q96_1_6_1_TEXT Q96_1_6_TEXT Q96_2_5_1_TEXT Q96_2_5_TEXT 
 Q96_2_6_1_TEXT Q96_2_6_TEXT .

VARIABLE LABELS specialisme1_T0 / specialisme2_T0 / specialisme3_T0 / specialisme4_T0 . 
VARIABLE LABELS ziekenhuis1_T0 / ziekenhuis2_T0 / ziekenhuis3_T0 / ziekenhuis4_T0 . 
VARIABLE LABELS  spec1_aant_keer_T0 / spec2_aant_keer_T0 / spec3_aant_keer_T0 /  spec4_aant_keer_T0 .

** specialisatie hetzelfde noemen.
FREQUENCIES VARIABLES=specialisme1_T0 specialisme2_T0 specialisme3_T0 specialisme4_T0 
  /ORDER=ANALYSIS.

DO IF poli_T0=2.
RECODE specialisme1_T0 (' '='onbekend').
END IF.
RECODE specialisme1_T0 ('cardioloog'='Cardioloog').
RECODE specialisme1_T0 ('chirurg'='Chirurg').
RECODE specialisme1_T0 ('chirurgie'='Chirurg').
RECODE specialisme1_T0 ('Chirurig'='Chirurg').
RECODE specialisme1_T0 ('chirurg'='Chirurg').
RECODE specialisme1_T0 ('polikliniek chiurgie'='Chirurg').
RECODE specialisme1_T0 ('endocrinoloog'='Endocrinoloog').
RECODE specialisme1_T0 ('dermatoloog'='Dermatoloog').
RECODE specialisme1_T0 ('gyn'='Gynaecoloog').
RECODE specialisme1_T0 ('Gyn'='Gynaecoloog').
RECODE specialisme1_T0 ('Gynacoloog'='Gynaecoloog').
RECODE specialisme1_T0 ('hart en vaat'='Hart en vaatcentrum').
RECODE specialisme1_T0 ('Heelkunde arts'='Chirurg').
RECODE specialisme1_T0 ('internist'='Internist').
RECODE specialisme1_T0 ('kaakchirurg'='Kaakchirurg').
RECODE specialisme1_T0 ('longarts'='Longarts').
RECODE specialisme1_T0 ('maag/darm/lever specialist'='MDL arts').
RECODE specialisme1_T0 ('neuroloog'='Neuroloog').
RECODE specialisme1_T0 ('A.J. Timmermans Hoofd oncologie Hoofd Hals'='Oncoloog').
RECODE specialisme1_T0 ('oncologie'='Oncoloog').
RECODE specialisme1_T0 ('oncoloog'='Oncoloog').
RECODE specialisme1_T0 ('oogarts'='Oogarts').
RECODE specialisme1_T0 ('orthopeed'='Orthopeed').
RECODE specialisme1_T0 ('orthopeet'='Orthopeed').
RECODE specialisme1_T0 ('ortopheed'='Orthopeed').
RECODE specialisme1_T0 ('Orthopaed'='Orthopeed').
RECODE specialisme1_T0 ('orthopedisch oncoloog'='Orthopedisch oncoloog').
RECODE specialisme1_T0 ('plastisch chirurg'='Plastisch chirurg').
RECODE specialisme1_T0 ('reumatoloog'='Reumatoloog').
RECODE specialisme1_T0 ('rheumatoloog'='Reumatoloog').
RECODE specialisme1_T0 ('Urologie'='Uroloog').
RECODE specialisme1_T0 ('uroloog'='Uroloog').
RECODE specialisme1_T0 ('Euroloog'='Uroloog').
RECODE specialisme1_T0 ('vaatchirurg'='Vaatchirurg').
RECODE specialisme1_T0 ('Hans'='onbekend').
EXECUTE.

RECODE specialisme2_T0 ('cardioloog'='Cardioloog').
RECODE specialisme2_T0 ('dermatoloog'='Dermatoloog').
RECODE specialisme2_T0 ('handchirurg'='Handchirurg').
*huisarts staat al vermeld bij HA consult.
RECODE specialisme2_T0 ('Huisarts'='').
RECODE specialisme2_T0 ('internist'='Internist').
RECODE specialisme2_T0 ('kaakchirurg'='Kaakchirurg').
RECODE specialisme2_T0 ('Knf'='Klinische neurofysioloog').
RECODE specialisme2_T0 ('KNO'='KNO arts').
RECODE specialisme2_T0 ('oncoloog'='Oncoloog').
RECODE specialisme2_T0 ('reumatoloog'='Reumatoloog').
RECODE specialisme2_T0 ('uroloog'='Uroloog').
RECODE specialisme2_T0 ('Vaat specialist'='Vaatspecialist').
EXECUTE.

*dagbehandeling staat al vermeld bij variabele dagbehandeling.
DO IF ID_Code=1208.
RECODE specialisme2_T0 ('dagbehandeling'='').
RECODE ziekenhuis2_T0 ('scheper'='').
END IF.

RECODE specialisme3_T0 ('oogarts'='Oogarts').
RECODE specialisme3_T0 ('longarts'='Longarts').
EXECUTE.

RECODE specialisme4_T0 ('neuroloog'='Neuroloog').
EXECUTE.

** ziekenhuizen hetzelfde noemen.
FREQUENCIES VARIABLES= ziekenhuis1_T0  ziekenhuis2_T0  ziekenhuis3_T0  ziekenhuis4_T0
  /ORDER=ANALYSIS.

RECODE ziekenhuis1_T0  ('Alrijne/leiderdorp'='Alrijne').
RECODE ziekenhuis1_T0  ('amphia Breda'='Amphia Breda').
RECODE ziekenhuis1_T0  ('asz dordwijk'='ASZ').
RECODE ziekenhuis1_T0  ('Bravis bergen op zoom'='Bravis').
RECODE ziekenhuis1_T0  ('bravis'='Bravis').
RECODE ziekenhuis1_T0  ('azm'='AZM').
RECODE ziekenhuis1_T0  ('Maastricht'='AZM').
RECODE ziekenhuis1_T0  ('Academische ziekenhuis Maastricht'='AZM').
RECODE ziekenhuis1_T0  ('academisch ziekenhuis maastricht'='AZM').
RECODE ziekenhuis1_T0  ('elkerliek'='Elkerliek').
RECODE ziekenhuis1_T0  ('elkerliek deurne'='Elkerliek').
RECODE ziekenhuis1_T0  ('ETZ'='Elisabeth - TweeSteden Ziekehuis').
RECODE ziekenhuis1_T0  ('gele ziekenhuis'='Gelre').
RECODE ziekenhuis1_T0  ('Isala'='Isala Zwolle').
RECODE ziekenhuis1_T0  ('kliniek de lange voorhout'='Kliniek Lange VoorhouT').
RECODE ziekenhuis1_T0  ('laurentius'='Laurentius').
RECODE ziekenhuis1_T0  ('Linge polie'='Linge polikliniek').
RECODE ziekenhuis1_T0  ('Lelystad'='MC Zuiderzee').
RECODE ziekenhuis1_T0  ('maasstad'='Maasstad').
RECODE ziekenhuis1_T0  ('Maxima eindhoven'='MMC Veldhoven').
RECODE ziekenhuis1_T0  ('MMC'='MMC Veldhoven').
RECODE ziekenhuis1_T0  ('poli kampen'='Polikliniek Kampen').
RECODE ziekenhuis1_T0  ('radboud Nijmegen'='Radboud').
RECODE ziekenhuis1_T0  ('radboud'='Radboud').
RECODE ziekenhuis1_T0  ('radbout'='Radboud').
** Marfan-poli is alleen in het Radbout, niet in CWZ Nijmegen:.
RECODE ziekenhuis1_T0  ('Nijmegen'='Radboud').
RECODE ziekenhuis1_T0  ('rddg'='Reinier de Graaf').
RECODE ziekenhuis1_T0  ('Reiniger de graaf'='Reinier de Graaf').
RECODE ziekenhuis1_T0  ('rijnstate'='Rijnstate').
RECODE ziekenhuis1_T0  ('scheper'='Scheper').
RECODE ziekenhuis1_T0  ('SZE'='Scheper').
RECODE ziekenhuis1_T0  ('umcg'='UMCG').
RECODE ziekenhuis1_T0  ('venlo'='Viecurie').
RECODE ziekenhuis1_T0  ('Vicurie'='Viecurie').
RECODE ziekenhuis1_T0  ('viecuri'='Viecurie').
RECODE ziekenhuis1_T0  ('VieCuri'='Viecurie').
RECODE ziekenhuis1_T0  ('Viecuri venray'='Viecurie').
RECODE ziekenhuis1_T0  ('weert'='Weert').
RECODE ziekenhuis1_T0  ('hoorn'='Westfries Gasthuis').
RECODE ziekenhuis1_T0  ('Zuiderland'='Zuyderland').
RECODE ziekenhuis1_T0  ('Heerlen'='Zuyderland').
RECODE ziekenhuis1_T0  ('Zuyderland Heerlen'='Zuyderland').
EXECUTE.

RECODE ziekenhuis2_T0 ('amphia Breda'='Amphia Breda').
RECODE ziekenhuis2_T0 ('ETZ'='Elisabeth - TweeSteden Ziekehuis').
RECODE ziekenhuis2_T0 ('Isala'='Isala Zwolle').
RECODE ziekenhuis2_T0 ('mariaziekenhuis Overpelt'='Mariaziekenhuis Overpelt').
RECODE ziekenhuis2_T0 ('Bravis bergen op zoom'='Bravis').
RECODE ziekenhuis2_T0 ('Radboud UMC'='Radboud').
RECODE ziekenhuis2_T0 ('rddg'='Reinier de Graaf').
RECODE ziekenhuis2_T0 ('rijnstate'='Rijnstate').
RECODE ziekenhuis2_T0 ('scheper'='Scheper').
RECODE ziekenhuis2_T0 ('viecuri'='Viecurie').
RECODE ziekenhuis2_T0 ('viecurie'='Viecurie').
RECODE ziekenhuis2_T0 ('weert'='Weert').
EXECUTE.

RECODE ziekenhuis3_T0  ('rddg'='Reinier de Graaf').
RECODE  ziekenhuis3_T0 ('viecuri'='Viecurie').
EXECUTE.

DO IF poli_T0=2.
RECODE ziekenhuis1_T0 ziekenhuis1_T0 ziekenhuis1_T0 ziekenhuis1_T0 (''='onbekend').
END IF.
EXECUTE.

FREQUENCIES VARIABLES= ziekenhuis1_T0  ziekenhuis2_T0  ziekenhuis3_T0  ziekenhuis4_T0 
  /ORDER=ANALYSIS.

** Ziekenhuis algemeen of academisch. 

RECODE ziekenhuis1_T0 ziekenhuis2_T0 ziekenhuis3_T0 ziekenhuis4_T0 (CONVERT) ('onbekend'=2)
('Aken'=1) ('Alrijne'=2) ('AMC Amsterdam'=1) ('Amphia Breda'=2) ('Anthoniushove'=2) ('Antonie van Leeuwenhoek'=2) 
('ASZ'=2) ('AZM'=1) ('Bernhoven'=2) ('Bravis'=2) ('Catharina'=2) ('CWZ Nijmegen'=2) ('Dekkerswald'=2) ('Deventer'=2) ('Elisabeth - TweeSteden Ziekehuis'=2)
('Elkerliek'=2) ('Erasmus'=1) ('Gelre'=2) ('Hoofddorp'=2) ('Ijsselland'=2) ('Ikazia'=2) ('Isala Zwolle'=2) ('Kliniek Lange VoorhouT'=2)
('Langeland'=2) ('Laurentius'=2) ('Linge polikliniek'=2) ('LUMC'=1) ('Maartenskliniek'=2) ('Maasstad'=2) ('Mariaziekenhuis Overpelt'=2)
('MC Zuiderzee'=2) ('MCL Leeuwarden'=2) ('Meander'=2) ('MMC Veldhoven'=2) ('Polikliniek Kampen'=2) ('Radboud'=1) ('Reinier de Graaf'=2)
('Rijnstate'=2) ('Scheper'=2) ('Slotervaart'=2) ('SMT Enschede'=2) ('Spijkenisse MC'=2) ('St.jans'=2) ('SZE'=2) ('UMCG'=1) ('Viecurie'=2) 
('Weert'=2) ('Westfries Gasthuis'=2) ('Zuyderland'=2) INTO ZH1_type_T0 ZH2_type_T0 ZH3_type_T0 ZH4_type_T0.
EXECUTE.

FORMATS ZH1_type_T0 ZH2_type_T0 ZH3_type_T0 ZH4_type_T0 (F1.0).
VALUE LABELS ZH1_type_T0 ZH2_type_T0 ZH3_type_T0 ZH4_type_T0 1  'academisch' 2 'algemeen'.  

** aantal keer van string naar numeriek.
* controle op tekst.
FREQUENCIES VARIABLES=spec1_aant_keer_T0 spec2_aant_keer_T0 spec3_aant_keer_T0 spec4_aant_keer_T0 
  /ORDER=ANALYSIS.
ALTER TYPE spec1_aant_keer_T0 spec2_aant_keer_T0 spec3_aant_keer_T0 spec4_aant_keer_T0  (F2.0).

** aantal keer=0: veranderen in 1 (conservatieve schatting).
DO IF ID_Code=4902.
RECODE spec1_aant_keer_T0 (0=1).
END IF.
** aantal keer=missing: veranderen in 1 (conservatieve schatting).
DO IF (specialisme1_T0 ~= '').
RECODE spec1_aant_keer_T0 (SYSMIS=1).
END IF.
DO IF (specialisme2_T0 ~= '').
RECODE spec2_aant_keer_T0 (SYSMIS=1).
END IF.
DO IF (specialisme3_T0 ~= '').
RECODE spec3_aant_keer_T0 (SYSMIS=1).
END IF.
DO IF (specialisme4_T0 ~= '').
RECODE spec4_aant_keer_T0 (SYSMIS=1).
END IF.

* bloedprikken is geen polibezoek.
DO IF ID_Code=2012.
RECODE poli_T0 (2=1).
RECODE specialisme1_T0 ('bloedprikken'='').
RECODE ziekenhuis1_T0 ('MC Zuiderzee'='').
RECODE ZH1_type_T0 (2=SYSMIS).
RECODE spec1_aant_keer_T0 (3=SYSMIS).
END IF.
EXECUTE.

*** Q97: dagbehandeling ***************************************************************************************************************************************.
RENAME VARIABLES Q97=dagbehandeling_T0.
VARIABLE LABELS dagbehandeling_T0 'Dagbehandeling: ja/nee'.

RENAME VARIABLES Q98_1.0 =Dagbehandeling1_T0 / Q98_2.0 =Dagbehandeling2_T0 / Q98_3.0 =Dagbehandeling3_T0 / Q98_4.0 =Dagbehandeling4_T0 / 
Q98_5.0 =Dagbehandeling5_T0 / Q98_6.0 =Dagbehandeling6_T0.

FREQUENCIES VARIABLES= Dagbehandeling1_T0  Dagbehandeling2_T0  Dagbehandeling3_T0  Dagbehandeling4_T0  Dagbehandeling5_T0  Dagbehandeling6_T0
  /ORDER=ANALYSIS.

* teksten verwijderen die niets zijn.
RECODE Dagbehandeling2_T0  ('o'='').
RECODE Dagbehandeling2_T0 ('0'='').
RECODE Dagbehandeling2_T0  ('-'='').
RECODE Dagbehandeling2_T0 ('Nvt'='').
RECODE Dagbehandeling3_T0 ('0'='').
RECODE Dagbehandeling3_T0 ('-'='').
RECODE Dagbehandeling3_T0 ('nvt'='').
RECODE Dagbehandeling3_T0 ('Nvt'='').
RECODE Dagbehandeling4_T0 ('0'='').
RECODE Dagbehandeling4_T0 ('-'='').
RECODE Dagbehandeling4_T0 ('nvt'='').
RECODE Dagbehandeling4_T0 ('Nvt'='').
RECODE Dagbehandeling5_T0 ('0'='').
RECODE Dagbehandeling5_T0 ('-'='').
RECODE Dagbehandeling5_T0 ('nvt'='').
RECODE Dagbehandeling5_T0 ('Nvt'='').
RECODE Dagbehandeling6_T0 ('0'='').
RECODE Dagbehandeling6_T0 ('-'='').
RECODE Dagbehandeling6_T0 ('nvt'='').
RECODE Dagbehandeling6_T0 ('Nvt'='').
EXECUTE.

RENAME VARIABLES Q99_x1.0=Dagbehandeling1_aant_keer_T0 / Q99_x2.0 =Dagbehandeling2_aant_keer_T0 / Q99_x3.0 =Dagbehandeling3_aant_keer_T0 / 
Q99_x4.0 =Dagbehandeling4_aant_keer_T0 / Q99_x5.0 =Dagbehandeling5_aant_keer_T0 / Q99_x6.0 =Dagbehandeling6_aant_keer_T0.


* Q99 aantal keer van string naar numeriek.
*controle op tekst.
FREQUENCIES VARIABLES  Dagbehandeling1_aant_keer_T0 Dagbehandeling2_aant_keer_T0 Dagbehandeling3_aant_keer_T0 
    Dagbehandeling4_aant_keer_T0 Dagbehandeling5_aant_keer_T0 Dagbehandeling6_aant_keer_T0
  /ORDER=ANALYSIS.
ALTER TYPE Dagbehandeling1_aant_keer_T0 Dagbehandeling2_aant_keer_T0 Dagbehandeling3_aant_keer_T0 
    Dagbehandeling4_aant_keer_T0 Dagbehandeling5_aant_keer_T0 Dagbehandeling6_aant_keer_T0 (F2.0).

* Als niets is ingevuld bij dagbehandeling, moet aantal keer missing zijn (0 wordt missing).

DO IF (Dagbehandeling1_T0=' ').
RECODE Dagbehandeling1_aant_keer_T0 (0=SYSMIS).
END IF.
DO IF (Dagbehandeling2_T0=' ').
RECODE Dagbehandeling2_aant_keer_T0 (0=SYSMIS).
END IF.
DO IF (Dagbehandeling3_T0=' ').
RECODE Dagbehandeling3_aant_keer_T0 (0=SYSMIS).
END IF.
DO IF (Dagbehandeling4_T0=' ').
RECODE Dagbehandeling4_aant_keer_T0 (0=SYSMIS).
END IF.
DO IF (Dagbehandeling5_T0=' ').
RECODE Dagbehandeling5_aant_keer_T0 (0=SYSMIS).
END IF.
EXECUTE.


* Als ja en dagbehandeling1_T0 is niet ingevuld: onbekend.
DO IF dagbehandeling_T0=2.
RECODE dagbehandeling1_T0 (''='onbekend').
END IF.
EXECUTE.

* Als ja en aantal keer=0 of missing?  1 (conservatieve schatting).
DO IF (dagbehandeling1_T0 ~= '').
RECODE dagbehandeling1_aant_keer_T0 (SYSMIS=1) (0=1).
END IF.
DO IF (dagbehandeling2_T0 ~= '').
RECODE dagbehandeling2_aant_keer_T0 (SYSMIS=1) (0=1).
END IF.
DO IF (dagbehandeling3_T0 ~= '').
RECODE dagbehandeling3_aant_keer_T0 (SYSMIS=1) (0=1).
END IF.
DO IF (dagbehandeling4_T0 ~= '').
RECODE dagbehandeling4_aant_keer_T0 (SYSMIS=1) (0=1).
END IF.
EXECUTE.

**dagbehandeling6 is leeg.
DELETE VARIABLES Dagbehandeling6_T0 Dagbehandeling6_aant_keer_T0.

VARIABLE LABELS Dagbehandeling1_T0 / Dagbehandeling2_T0 / Dagbehandeling3_T0 / Dagbehandeling4_T0 / Dagbehandeling5_T0 / 
Dagbehandeling1_aant_keer_T0 / Dagbehandeling2_aant_keer_T0 / Dagbehandeling3_aant_keer_T0 / 
Dagbehandeling4_aant_keer_T0 / Dagbehandeling5_aant_keer_T0. 

** MIssing.
RECODE Dagbehandeling_T0 (SYSMIS=9).
EXECUTE.
MISSING VALUES Dagbehandeling_T0 (9).

***Q121: opnames************************************************************************************************************************************************************************.

** de variabelen aantal dagen en aantal keer zijn omgekeerd.
RENAME VARIABLES Q121_3_1=opname_ZH_T0 / Q121_1_1_1_TEXT = opname_ZH_aant_keer_T0 / Q121_2_1_1_TEXT = opname_ZH_aant_dagen_T0. 
RENAME VARIABLES Q121_3_2=opname_rev_T0 / Q121_1_2_1_TEXT = opname_rev_aant_keer_T0 / Q121_2_2_1_TEXT = opname_rev_aant_dagen_T0. 
RENAME VARIABLES Q121_3_3=opname_psy_T0 / Q121_1_3_1_TEXT = opname_psy_aant_keer_T0 / Q121_2_3_1_TEXT = opname_psy_aant_dagen_T0.

VARIABLE LABELS opname_ZH_T0 'opname ziekenhuis: ja/nee T0'  opname_ZH_aant_dagen_T0 'opname ziekenhuis aantal dagen T0' 
opname_ZH_aant_keer_T0 'opname ziekenhuis aantal keer T0'
 opname_rev_T0 'opname revalidatie: ja/nee T0'  opname_rev_aant_dagen_T0 'opname revalidatie aantal dagen T0' 
opname_rev_aant_keer_T0 'opname revalidatie aantal keer T0' 
 opname_psy_T0 'opname psychiatrie: ja/nee T0'  opname_psy_aant_dagen_T0 'opname psychiatrie aantal dagen T0' 
opname_psy_aant_keer_T0 'opname psychiatrie aantal keer T0' .

** aantal dagen en aantal keer van string naar numeriek.
* controle tekst.
FREQUENCIES VARIABLES=opname_ZH_aant_dagen_T0 opname_rev_aant_dagen_T0 opname_psy_aant_dagen_T0 
    opname_ZH_aant_keer_T0 opname_rev_aant_keer_T0 opname_psy_aant_keer_T0
  /ORDER=ANALYSIS.

ALTER TYPE opname_ZH_aant_dagen_T0 opname_rev_aant_dagen_T0 opname_psy_aant_dagen_T0 
    opname_ZH_aant_keer_T0 opname_rev_aant_keer_T0 opname_psy_aant_keer_T0 (F3.0).

** Als de vragenlijst ‘gefinished’ is, dan is een niet-ingevulde opname (missing) = geen opname (0).
DO IF ( Finished=1).
RECODE  opname_ZH_T0  opname_rev_T0 opname_psy_T0 (SYSMIS=2).
END IF.
EXECUTE.

** als opname=nee, dan wordt aantal keer en aantal dagen 0=missing.
DO IF (opname_ZH_T0=2).
RECODE  opname_ZH_aant_dagen_T0  opname_ZH_aant_keer_T0 (0=SYSMIS).
END IF.
DO IF (opname_rev_T0=2).
RECODE  opname_rev_aant_dagen_T0  opname_rev_aant_keer_T0 (0=SYSMIS).
END IF.
DO IF (opname_psy_T0=2).
RECODE  opname_psy_aant_dagen_T0  opname_psy_aant_keer_T0 (0=SYSMIS).
END IF.
EXECUTE.

** als opname=ja en aantal keer en dagen is niet ingevuld: conservatieve schatting: 1 dag.
DO IF (opname_ZH_T0=1).
RECODE  opname_ZH_aant_dagen_T0  opname_ZH_aant_keer_T0 (SYSMIS=1).
END IF.
EXECUTE.

** ID 5308 heeft overal nee, maar wel overal datum 01-01-2017. Deze verwijderen.
DO IF (ID_code=5308).
RECODE Q121_4_1_1_TEXT Q121_4_2_1_TEXT Q121_4_3_1_TEXT ('01-01-2017'='  ').
END IF.
EXECUTE.

*** Datum omzetten van string naar date.
* streepjes etc verwijderen met als resultaat bv 01012001. Voorlopig alleen voor ziekenhuisopname, de rest komt niet voor.
STRING temp1 (A20).
COMPUTE temp1=REPLACE(Q121_4_1_1_TEXT,'-','').
EXECUTE.

STRING  temp2 (A20).
COMPUTE temp2=REPLACE(temp1,'/','').
EXECUTE.

COMPUTE aantalplaatsen=LENGTH(temp2).
EXECUTE.
FORMATS aantalplaatsen (F1.0).

DO IF aantalplaatsen=8.
* Date and Time Wizard: geboortedat.
COMPUTE opname_ZH_datum_T0=date.dmy(number(substr(ltrim(temp2),1,2),f2.0), 
    number(substr(ltrim(temp2),3,2),f2.0), number(substr(ltrim(temp2),5),f4.0)).
VARIABLE LEVEL  opname_ZH_datum_T0 (SCALE).
FORMATS opname_ZH_datum_T0 (DATE11).
VARIABLE WIDTH  opname_ZH_datum_T0(11).
END IF.
EXECUTE.
DELETE VARIABLES temp1 temp2 aantalplaatsen.

RENAME VARIABLES Q121_4_2_1_TEXT = opname_rev_datum_T0 /  Q121_4_3_1_TEXT = opname_psy_datum_T0. 
VARIABLE LABELS  opname_ZH_datum_T0 'opname ziekenhuis datum T0' opname_rev_datum_T0 'opname revalidatie datum T0' opname_psy_datum_T0 'opname psychiatrie datum T0'.


*** opnamedatum moet maximaal 3 maanden voor invuldatum liggen.
* Date and Time Wizard: d_opnamedatum_invuldatum.
COMPUTE  d_opnamedatum_invuldatum=DATEDIF(opname_ZH_datum_T0, Invuldatum_T0, "weeks").
VARIABLE LABELS  d_opnamedatum_invuldatum "verschil opnamedatum en invuldatum in weken".
VARIABLE LEVEL  d_opnamedatum_invuldatum (SCALE).
FORMATS  d_opnamedatum_invuldatum (F5.0).
VARIABLE WIDTH  d_opnamedatum_invuldatum(5). 
EXECUTE.

* ID 2104 geeft opname in 2002, heeft verder ook geen polibezoek, dagbehandeling of medicatie:
Opname telt niet mee.
DO IF (ID_code=2104).
RECODE opname_ZH_T0 (1=2).
COMPUTE opname_ZH_aant_dagen_T0 =$SYSMIS.
COMPUTE opname_ZH_aant_keer_T0 =$SYSMIS.
COMPUTE opname_ZH_datum_T0=$SYSMIS.
END IF.
EXECUTE.

* ID 1913: Nee ingevuld bij alle drie, aantal keer psychiatrische instelling 1-> verwijderen.
DO IF (ID_code=1913).
RECODE opname_psy_aant_keer_T0 (1=SYSMIS).
END IF.
EXECUTE.

** ID 1804 Ja ingevuld bij alle drie, aantal keer en dagen overal leeg
Verder geen medicatie, poli, dagbehandeling etc.  van ja nee maken.
DO IF (ID_code=1804).
RECODE opname_ZH_T0  opname_rev_T0 opname_psy_T0 (1=2).
END IF.
EXECUTE.

DELETE VARIABLES  d_opnamedatum_invuldatum.

** MIssings.
RECODE opname_ZH_T0  opname_rev_T0 opname_psy_T0  (SYSMIS=9).
EXECUTE.
MISSING VALUES opname_ZH_T0  opname_rev_T0 opname_psy_T0 (9).

*Q103 en verder: inkomen ****************************************************************************************************************************************************************.
RENAME VARIABLES Q103=netto_inkomen_T0  / Q104= omvang_huishouden_T0 / Q107=huishouden_aant_kinderen_T0/ Q105 = inkomen_rondkomen_T0.
VALUE LABELS omvang_huishouden 1 'één persoon' 2 'meer dan één persoon'.
**Q104_2_TEXT van string naar numeriek.
* controle op tekst.
FREQUENCIES VARIABLES=Q104_2_TEXT
  /ORDER=ANALYSIS.
RECODE Q104_2_TEXT ('met 2 kinderen'= '3').
RECODE Q104_2_TEXT ('2.5'= '3').
DO IF (ID_code=3805).
RECODE omvang_huishouden_T0 (2=1).
RECODE Q104_2_TEXT ('Ik woon nog thuis bij mijn ouders. want ik ben aan het sparen voor een huis en ik ben 21 jaar oud'= ' ').
END IF.
EXECUTE.

STRING huishouden_aant_pers_T0 (A8).
COMPUTE huishouden_aant_pers=Q104_2_TEXT. 
ALTER TYPE huishouden_aant_pers_T0 (F3.0).

**Als omvang_huishouden=1 , dan is aantal personen dus 1 en aantal kinderen 0 (nu missing).
DO IF (omvang_huishouden_T0=1).
RECODE huishouden_aant_pers_T0 (SYSMIS=1).
RECODE huishouden_aant_kinderen_T0 (SYSMIS=0).
END IF.
EXECUTE.

** Als omvang huishouden= meer dan 1 en aantal=1 --> omvang huishouden veranderen in eenpersoons.
DO IF (huishouden_aant_pers_T0=1).
RECODE omvang_huishouden_T0 (2=1).
END IF.
EXECUTE.

VARIABLE LABELS huishouden_aant_pers 'aantal personen in huishouden T0'.
VARIABLE LABELS  huishouden_aant_kinderen 'aantal minderjarigen in huishouden T0'.
VARIABLE LABELS  netto_inkomen 'netto gezinsinkomen T0'.
VARIABLE LABELS omvang_huishouden 'een-of meerpersoons huishouden T0'.
FORMATS huishouden_aant_kinderen_T0 (F2.0).

** berekenen individueel inkomen.
RECODE netto_inkomen (1=375) (2=875) (3=1125) (4=1375) (5=1750) (6=2250) (7=2750) (8=3250) (9=3750) (10=4250) (11=4750) (12=5250) (13=5750) INTO netto_inkomen_continu.
COMPUTE ind_inkomen=netto_inkomen_continu/SQRT(huishouden_aant_pers).
VARIABLE LABELS  ind_inkomen 'individueel inkomen_T0'.
EXECUTE.

** Missings.
RECODE netto_inkomen_T0 omvang_huishouden_T0 huishouden_aant_pers_T0 huishouden_aant_kinderen_T0 inkomen_rondkomen_T0 (SYSMIS=99).
RECODE netto_inkomen_continu_T0 ind_inkomen_T0 (SYSMIS=9999).
EXECUTE.

MISSING VALUES netto_inkomen_T0 (14,99) omvang_huishouden_T0 huishouden_aant_pers_T0 huishouden_aant_kinderen_T0 (99) inkomen_rondkomen_T0 (7,99)
netto_inkomen_continu_T0 ind_inkomen_T0 (9999).

VARIABLE LEVEL netto_inkomen_T0 inkomen_rondkomen_T0 (ORDINAL) omvang_huishouden_T0 (NOMINAL).


*** Variabelen verwijderen die omgezet zijn naar numeriek.
DELETE VARIABLES Q122.
DELETE VARIABLES  Q4 Q5.
DELETE VARIABLES Q6_1 Q6_2 Q6_3 Q6_4. 
DELETE VARIABLES  Q71.
DELETE VARIABLES  Q121_4_1_1_TEXT.
DELETE VARIABLES Q104_2_TEXT . 
DELETE VARIABLES Q112_5___Topics.















