* Encoding: UTF-8.

** Aantal dagen lang verzuim: indien ziekteverzuim=3 (langdurig) dan aantal dagen langdurig verzuim = alle dagen van die periode.

DO IF  (ziekteverzuim1_T0=3).
RECODE ziekteverzuim2_T0 (888=90) INTO dagenlangverzuimT0.
END IF.
EXECUTE.

DO IF  (ziekteverzuim1_T1=3).
RECODE ziekteverzuim2_T1 (888=60) INTO dagenlangverzuimT1.
END IF.
EXECUTE.

DO IF  (ziekteverzuim1_T2=3).
RECODE ziekteverzuim2_T2 (888=90) INTO dagenlangverzuimT2.
END IF.
EXECUTE.

DO IF  (ziekteverzuim1_T3=3).
RECODE ziekteverzuim2_T3 (888=90) INTO dagenlangverzuimT3.
END IF.
EXECUTE.

DO IF  (ziekteverzuim1_T4=3).
RECODE ziekteverzuim2_T4 (888=180) INTO dagenlangverzuimT4.
END IF.
EXECUTE.

** Aantal dagen kort verzuim.
IF  (ziekteverzuim1_T1=2) dagenlosverzuimT0=ziekteverzuim2_T0.
IF  (ziekteverzuim1_T1=2) dagenlosverzuimT1=ziekteverzuim2_T1.
IF  (ziekteverzuim1_T2=2) dagenlosverzuimT2=ziekteverzuim2_T2.
IF  (ziekteverzuim1_T3=2) dagenlosverzuimT3=ziekteverzuim2_T3.
IF  (ziekteverzuim1_T4=2) dagenlosverzuimT4=ziekteverzuim2_T4.
EXECUTE.

VARIABLE WIDTH dagenlangverzuimT0 dagenlangverzuimT1 dagenlangverzuimT2 dagenlangverzuimT3 dagenlangverzuimT4 
dagenlosverzuimT0 dagenlosverzuimT1 dagenlosverzuimT2 dagenlosverzuimT3 dagenlosverzuimT4 (10).
VARIABLE LEVEL dagenlangverzuimT0 dagenlangverzuimT1 dagenlangverzuimT2 dagenlangverzuimT3 dagenlangverzuimT4 
dagenlosverzuimT0 dagenlosverzuimT1 dagenlosverzuimT2 dagenlosverzuimT3 dagenlosverzuimT4 (SCALE).


** individuele aanpassingen indien een kort verzuim achteraf bleek te horen bij langdurig verzuim op de volgende vragenlijst.


* ID 1107
T2 38 dagen ziek
T3 langdurig sinds 18-6-16=voor T0 (18-8-16)  de 38 dagen bij T0  is dus al de start van het langdurig verlof. 
IF (ID_code=1107) dagenlangverzuimT2=38.
IF (ID_code=1107) dagenlosverzuimT2=0.
EXECUTE.

* ID 1901	
T1 20 dagen ziek
T2 langdurig sinds 28-10-16. Zou dus ook op T1 moeten staan (13-12-16)  de 20 dagen bij T1  is dus al de start van het langdurig verlof
T3 5 dagen ziek (= eind langdurig).
IF (ID_code=1901) dagenlangverzuimT1=20.
IF (ID_code=1901) dagenlosverzuimT1=0.
EXECUTE.
IF (ID_code=1901) dagenlangverzuimT3=5.
IF (ID_code=1901) dagenlosverzuimT3=0.
EXECUTE.

* ID 2303	
T1 40 dagen ziek
T2 langdurig sinds 1-10-16. Zou dus ook op T1 moeten staan (30-11-16)  de 40 dagen bij T0  is dus al de start van het langdurig verlof. 
IF (ID_code=2303) dagenlangverzuimT1=40.
IF (ID_code=2303) dagenlosverzuimT1=0.
EXECUTE.

* ID 2705
T0 15 dagen ziek
T1 langdurig sinds 1-10-16 =voor T0  de 15 dagen bij T0  is dus al de start van het langdurig verlof). 
IF (ID_code=2705) dagenlangverzuimT0=15.
IF (ID_code=2705) dagenlosverzuimT0=0.
EXECUTE.

* ID 3005
T1 16 dagen ziek
T2 langdurig sinds 8-11-16. Zou dus ook op T1 moeten staan (21-12-16 de 16 dagen bij T1  is dus al de start van het langdurig verlof). 
IF (ID_code=3005) dagenlangverzuimT1=16.
IF (ID_code=3005) dagenlosverzuimT1=0.
EXECUTE.

* ID 3106
T3 40 dagen
T4 langdurig sinds 17-3-17 = voor T3 (17-6-17).  de 40 dagen bij T3  is dus al de start van het langdurig verlof. 
IF (ID_code=3106) dagenlangverzuimT3=40.
IF (ID_code=3106) dagenlosverzuimT3=0.
EXECUTE.

* ID 3219
T2 20 dagen ziek
T3 langdurig sinds 13-2-17= voor T2 (20-3-17),  7 dagen bij T2 is dus al de start van het langdurig verlof, rest 13 dagen ‘los’
T4 langdurig sinds 13-2-17.
IF (ID_code=3219) dagenlangverzuimT2=7.
EXECUTE.
IF (ID_code=3219) dagenlosverzuimT2=13.
EXECUTE.

* ID 3305
T0 langdurig sinds 3-5-2016 (voor T0)
T1 kortdurend 16 dagen wordt hele periode want op T2 weer ziek sinds 3-5-16
T2 langdurig sinds 3-5-2016 (voor T0)
T3 kortdurend 12 dagen
T4 kortdurend 14 dagen.
IF (ID_code=3305) dagenlangverzuimT1=60.
IF (ID_code=3305) dagenlosverzuimT1=0.
EXECUTE.

* ID 3407
T0 4 dagen ziek
T1 niet ziek
T2 40 dagen ziek
T3 langdurig sinds 16-4-17 = 16 dagen voor T2 (2-5-17). 16 dagen van T2 hoort bij langdurig, 24 los 
T4 70 dagen ziek, hoort nog bij langdurig.
IF (ID_code=3407) dagenlangverzuimT2=16.
IF (ID_code=3407) dagenlosverzuimT2=24.
EXECUTE.
IF (ID_code=3407) dagenlangverzuimT4=70.
IF (ID_code=3407) dagenlosverzuimT4=0.
EXECUTE.

* ID 3414	
T0 niet ziek
T1 30 dagen ziek
T2 langdurig sinds 23-1-17. Zou dus ook op T1 moeten staan (2-3-17). Heeft op T1 wel 30 dagen verzuim, is dus 	10 dagen start langdurig verlof en 20 dagen ‘los’ verlof
T3 langdurig
T4 niet ziek.
IF (ID_code=3414) dagenlangverzuimT1=10.
IF (ID_code=3414) dagenlosverzuimT1=20.
EXECUTE.

* ID 3604	
T1 30 dagen ziek
T2 langdurig sinds 6-2-17 = voor T1 (15-3-17). T0  de 30 dagen bij T1 is dus al de start van het langdurig verlof). 
IF (ID_code=3604) dagenlangverzuimT1=30.
IF (ID_code=3604) dagenlosverzuimT1=0.
EXECUTE.

* ID 3903
T2 21 dagen ziek
T3 langdurig sinds 5-5-17 = voor T2 (25-5-17),  de 21 dagen bij T2 is dus al de start van het langdurig verlof. 
IF (ID_code=3903) dagenlangverzuimT2=21.
IF (ID_code=3903) dagenlosverzuimT2=0.
EXECUTE.

* ID 4508
T0 niet ziek
T1 5 dagen ziek
T2 49 dagen ziek
T3 langdurig sinds 28-4-17 = voor T1 (dd 6-5-17)  de 5 dagen van T1 en 49 van T2 horen bij het langdurig verzuim
T4 langdurig sinds 28-4-17.
IF (ID_code=4508) dagenlangverzuimT1=5.
IF (ID_code=4508) dagenlosverzuimT1=0.
IF (ID_code=4508) dagenlangverzuimT2=49.
IF (ID_code=4508) dagenlosverzuimT2=0.
EXECUTE.

* ID 4607
T0 1 dag ziek
T1 niet ziek
T2 15 dagen ziek
T3 langdurig sinds 13-4-17 = voor T2 (5-5-17)  de 15 dagen bij T2 is dus al de start van het langdurig verlof. 
IF (ID_code=4607) dagenlangverzuimT2=15.
IF (ID_code=4607) dagenlosverzuimT2=0.
EXECUTE.

* ID 4802
T3 46 dagen ziek 
T4 langdurig sinds 20-7-17 = voor T3 (21-9-17)  de 46 dagen bij T3 is dus al de start van het langdurig verlof. 
IF (ID_code=4802) dagenlangverzuimT3=46.
IF (ID_code=4802) dagenlosverzuimT3=0.
EXECUTE.

* ID 4808
T3 30 dagen ziek 
T4 langdurig sinds 30-8-17 = voor T3 (26-9-17)  de 30 dagen bij T3 is dus al de start van het langdurig verlof. 
IF (ID_code=4808) dagenlangverzuimT3=30.
IF (ID_code=4808) dagenlosverzuimT3=0.
EXECUTE.

* ID 4902	
T0 10 dagen ziek
T1 20 dagen ziek
T2 langdurig sinds 18-3-17 = voor T1 (5-4-17),  de 20 dagen bij T1 is dus al de start van het langdurig verlof. 
IF (ID_code=4902) dagenlangverzuimT1=20.
IF (ID_code=4902) dagenlosverzuimT1=0.
EXECUTE.

* 5206
T0 35 dagen ziek
T1 langdurig sinds 16-12-16 (=voor T0)  de 35 dagen bij T0  is dus al de start van het langdurig verlof) 
T2+T3 langdurig sinds 16-12-16.
IF (ID_code=5206) dagenlangverzuimT0=35.
IF (ID_code=5206) dagenlosverzuimT0=0.
EXECUTE.

* ID 6412
T3 45 dagen
T4 langdurig sinds 28-8-17 = voor T3 (14-11-17)  de 45 dagen bij T3  is dus al de start van het langdurig verlof). 
IF (ID_code=6412) dagenlangverzuimT3=45.
IF (ID_code=6412) dagenlosverzuimT3=0.
EXECUTE.

** Indien geen verzuim: aantal dagen =0.

DO IF ziekteverzuim1_T0=1.
RECODE dagenlosverzuimT0 dagenlangverzuimT0  (SYSMIS=0).
END IF.
DO IF ziekteverzuim1_T0=2.
RECODE dagenlangverzuimT0  (SYSMIS=0).
END IF.
DO IF ziekteverzuim1_T0=3.
RECODE dagenlosverzuimT0  (SYSMIS=0).
END IF.
EXECUTE.

DO IF ziekteverzuim1_T1=1.
RECODE dagenlosverzuimT1 dagenlangverzuimT1  (SYSMIS=0).
END IF.
DO IF ziekteverzuim1_T1=2.
RECODE dagenlangverzuimT1  (SYSMIS=0).
END IF.
DO IF ziekteverzuim1_T1=3.
RECODE dagenlosverzuimT1  (SYSMIS=0).
END IF.
EXECUTE.

DO IF ziekteverzuim1_T2=1.
RECODE dagenlosverzuimT2 dagenlangverzuimT2  (SYSMIS=0).
END IF.
DO IF ziekteverzuim1_T2=2.
RECODE dagenlangverzuimT2  (SYSMIS=0).
END IF.
DO IF ziekteverzuim1_T2=3.
RECODE dagenlosverzuimT2  (SYSMIS=0).
END IF.
EXECUTE.

DO IF ziekteverzuim1_T3=1.
RECODE dagenlosverzuimT3 dagenlangverzuimT3  (SYSMIS=0).
END IF.
DO IF ziekteverzuim1_T3=2.
RECODE dagenlangverzuimT3  (SYSMIS=0).
END IF.
DO IF ziekteverzuim1_T3=3.
RECODE dagenlosverzuimT3  (SYSMIS=0).
END IF.
EXECUTE.

DO IF ziekteverzuim1_T4=1.
RECODE dagenlosverzuimT4 dagenlangverzuimT4  (SYSMIS=0).
END IF.
DO IF ziekteverzuim1_T4=2.
RECODE dagenlangverzuimT4  (SYSMIS=0).
END IF.
DO IF ziekteverzuim1_T4=3.
RECODE dagenlosverzuimT4  (SYSMIS=0).
END IF.
EXECUTE.

'*******************************************************************************************************************************************************************************************************************.
'*** Kosten T1-T4 **********************************************************************************************************************************************************************************************.
'*******************************************************************************************************************************************************************************************************************.

*******************************************************************************************************************************************************************************************************************.
** Absenteisme************************************************************************************************************************************************************************************************.
*******************************************************************************************************************************************************************************************************************.


***** Langdurig verzuim *******************************************************************************************************************************************************************.
** totaal aantal dagen lang verzuim:
Bij langdurig verzuim is er een onderscheid tussen langer of korter dan 85 kalenderdagen
Er zijn 4 gevallen waarbij het totaal aantal dagen langdurig kleiner is dan 85, nl 60 (alleen vragenlijst T1). 2 cases hebben op de andere lijsten geen missings
Bij 1 mist T2 en bij 1 missen T2 en T3. Dit laten we zo, dus 60 dagen rekenen (conservatieve schatting)
-->Imputeren bij langdurig is niet nodig.

** voor berekening is aantal werkdagen per week en uur per dag nodig. Dit kan variëren over de vragenlijsten--> gemiddelde over de 4 lijsten gebruiken.
COMPUTE werkdagen_gem=MEAN(werktijd2_T1,werktijd2_T2,werktijd2_T3,werktijd2_T4).
COMPUTE werkuur_per_dag_gem=MEAN(werkuur_per_dag_T1,werkuur_per_dag_T2,werkuur_per_dag_T3,werkuur_per_dag_T4).
EXECUTE.
VARIABLE WIDTH werkdagen_gem  werkuur_per_dag_gem (13).

COMPUTE dagenlangdurig_T1_T4=SUM (dagenlangverzuimT1,dagenlangverzuimT2,dagenlangverzuimT3,dagenlangverzuimT4).
EXECUTE.
VARIABLE WIDTH dagenlangdurig_T1_T4 (12).
VARIABLE LEVEL dagenlangdurig_T1_T4 (SCALE).

** kosten langdurig verzuim.

DO IF dagenlangdurig_T1_T4<=85.
COMPUTE Kosten_langdurig_T1_T4= (dagenlangdurig_T1_T4/7) * werkdagen_gem * werkuur_per_dag_gem * 35.55.
END IF.
DO IF dagenlangdurig_T1_T4>85.
COMPUTE Kosten_langdurig_T1_T4= (85/7) * werkdagen_gem * werkuur_per_dag_gem * 35.55.
END IF.
EXECUTE.
VARIABLE LABELS Kosten_langdurig_T1_T4 'kosten absenteïsme langdurig (imputeren niet nodig)'.

*ID 2904: Is hele periode (van voor T0) langdurig ziek, maar T1 is missing waardoor de periode van T2 ten onrechte in rekening wordt gebracht (frictieperiode is al voorbij op T1) kosten worden 0.
IF (ID_code=2904) Kosten_langdurig_T1_T4=0.
EXECUTE.


*****Kortdurend verzuim***************************************************************************************************************************************************************.

* Op T4 (over 6 maanden) komt het 4x voor dat er kortdurend verzuim is van meer dan 85 dagen (frictieperiode). Dit wordt bijgesteld naar 85 dagen.
DO IF ziekteverzuim2_T4>85.
COMPUTE dagenlosverzuimT4=85.
END IF.
EXECUTE.

* Kosten per vragenlijst.
COMPUTE kosten_kort_T1= dagenlosverzuimT1 * werkuur_per_dag_T1 * 35.55.
COMPUTE kosten_kort_T2= dagenlosverzuimT2 * werkuur_per_dag_T2 * 35.55.
COMPUTE kosten_kort_T3= dagenlosverzuimT3 * werkuur_per_dag_T3 * 35.55.
COMPUTE kosten_kort_T4= dagenlosverzuimT4 * werkuur_per_dag_T4 * 35.55.
EXECUTE.
VARIABLE WIDTH kosten_kort_T1 kosten_kort_T2 kosten_kort_T3 kosten_kort_T4 (10).

**Missings imputeren.

** Kosten per maand berekenen.
COMPUTE kosten_kort_T1_mnd=kosten_kort_T1/2.
COMPUTE kosten_kort_T2_mnd=kosten_kort_T2/3.
COMPUTE kosten_kort_T3_mnd=kosten_kort_T3/3.
COMPUTE kosten_kort_T4_mnd=kosten_kort_T4/6.
EXECUTE.

IF  (MISSING(kosten_kort_T1)=1) kosten_kort_T1_imp= 2 * MEAN(kosten_kort_T2_mnd,kosten_kort_T3_mnd,kosten_kort_T4_mnd).
IF  (MISSING(kosten_kort_T1)=0) kosten_kort_T1_imp=kosten_kort_T1.
IF  (MISSING(kosten_kort_T2)=1) kosten_kort_T2_imp= 3 * MEAN(kosten_kort_T1_mnd,kosten_kort_T3_mnd,kosten_kort_T4_mnd).
IF  (MISSING(kosten_kort_T2)=0) kosten_kort_T2_imp=kosten_kort_T2.
IF  (MISSING(kosten_kort_T3)=1) kosten_kort_T3_imp= 3 * MEAN(kosten_kort_T1_mnd,kosten_kort_T2_mnd,kosten_kort_T4_mnd).
IF  (MISSING(kosten_kort_T3)=0) kosten_kort_T3_imp=kosten_kort_T3.
IF  (MISSING(kosten_kort_T4)=1) kosten_kort_T4_imp= 6 * MEAN(kosten_kort_T1_mnd,kosten_kort_T2_mnd,kosten_kort_T3_mnd).
IF  (MISSING(kosten_kort_T4)=0) kosten_kort_T4_imp=kosten_kort_T4.
EXECUTE.
VARIABLE WIDTH kosten_kort_T1_imp kosten_kort_T2_imp kosten_kort_T3_imp kosten_kort_T4_imp (10).
VARIABLE LEVEL kosten_kort_T1_imp kosten_kort_T2_imp kosten_kort_T3_imp kosten_kort_T4_imp (SCALE).

DELETE VARIABLES kosten_kort_T1_mnd kosten_kort_T2_mnd kosten_kort_T3_mnd kosten_kort_T4_mnd.

COMPUTE Kosten_kort_T1_T4_imp= SUM (kosten_kort_T1_imp, kosten_kort_T2_imp, kosten_kort_T3_imp, kosten_kort_T4_imp).
COMPUTE Kosten_kort_T1_T4= SUM (kosten_kort_T1, kosten_kort_T2, kosten_kort_T3, kosten_kort_T4).
EXECUTE.
VARIABLE WIDTH kosten_kort_T1_T4_imp Kosten_kort_T1_T4 (10).
VARIABLE LEVEL kosten_kort_T1_T4_imp Kosten_kort_T1_T4 (SCALE).
VARIABLE LABELS kosten_kort_T1_T4_imp 'kosten absenteïsme kortdurend geïmputeerd' Kosten_kort_T1_T4 'kosten absenteïsme kortdurend met missings (dus missing=0)'.

** totale kosten absenteisme**************************************************************************************************************************************************************************..

COMPUTE Kosten_absenteism_T1_T4= SUM (kosten_kort_T1_T4, kosten_langdurig_T1_T4).
COMPUTE Kosten_absenteism_T1_T4_imp= SUM (kosten_kort_T1_T4_imp, kosten_langdurig_T1_T4).
EXECUTE.
VARIABLE WIDTH Kosten_absenteism_T1_T4_imp kosten_absenteism_T1_T4 (10).
VARIABLE LEVEL Kosten_absenteism_T1_T4_imp kosten_absenteism_T1_T4 (SCALE).
VARIABLE LABELS Kosten_absenteism_T1_T4 'tot kosten absenteïsme kort en lang met missings (dus missing=0)' Kosten_absenteism_T1_T4_imp 'tot kosten absenteïsme kort en lang geïmputeerd'.

** descripives.

DESCRIPTIVES VARIABLES=Kosten_absenteism_T1_T4 kosten_absenteism_T1_T4_imp
  /STATISTICS=MEAN STDDEV MIN MAX.

** outliers.
EXAMINE VARIABLES=Kosten_absenteism_T1_T4 kosten_absenteism_T1_T4_imp
  /COMPARE VARIABLE
  /PLOT=BOXPLOT
  /STATISTICS=NONE
  /NOTOTAL
  /ID=ID_code
  /MISSING=LISTWISE.

*** absenteisme: imputatie met gemiddelde van interventie cq controle groep.
T-TEST GROUPS=conditie(1 2)
  /MISSING=ANALYSIS
  /VARIABLES=kosten_absenteism_T1_T4_imp
  /CRITERIA=CI(.95).
* --> interventiegroep: 3461.44; controlegroep: 2474.54.
DO IF (conditie =1 and in_kostenanalyse=1).
RECODE kosten_absenteism_T1_T4_imp  (SYSMIS=3461.44).
END IF.
DO IF (conditie =2  and in_kostenanalyse=1).
RECODE kosten_absenteism_T1_T4_imp (SYSMIS=2474.54).
END IF.
EXECUTE.


*******************************************************************************************************************************************************************************************************************.
** Presenteisme************************************************************************************************************************************************************************************************.
*******************************************************************************************************************************************************************************************************************.

*Ziekteverzuim7 omcoderen naar vermenigvuldigingsfactor (% geen werk verricht):
*1 = 10% werk verricht = 90 % ziek = factor: 0.9 etc.

RECODE ziekteverzuim7_T1 ziekteverzuim7_T2 ziekteverzuim7_T3 ziekteverzuim7_T4 (0=1) (1=0.9) (2=0.8) (3=0.7) (4=0.6) (5=0.5) (6=0.4) (7=0.3) (8=0.2) (9=0.1) (10=0) into perc_geenwerk_T1  perc_geenwerk_T2  perc_geenwerk_T3  perc_geenwerk_T4. 
EXECUTE.

* Kosten per vragenlijst = (aant dagen x werkuren per dag x 35.55) x vermenigvuldigingsfactor.
* indien werkuren per dag voor betreffende vragenlijst missing is: gemiddelde gebruiken.
IF (ziekteverzuim5_T1=2) kosten_presenteism_T1=ziekteverzuim6_T1 * werkuur_per_dag_T1 * 35.55 * perc_geenwerk_T1.
IF (ziekteverzuim5_T1=1) kosten_presenteism_T1=0.
IF (ziekteverzuim5_T1=2 and SYSMIS(werkuur_per_dag_T1)=1) kosten_presenteisme_T1=ziekteverzuim6_T1 * werkuur_per_dag_gem * 35.55 * perc_geenwerk_T1.
EXECUTE.
IF (ziekteverzuim5_T2=2) kosten_presenteism_T2=ziekteverzuim6_T2 * werkuur_per_dag_T2 * 35.55 * perc_geenwerk_T2.
IF (ziekteverzuim5_T2=1) kosten_presenteism_T2=0.
IF (ziekteverzuim5_T2=2 and SYSMIS(werkuur_per_dag_T2)=1) kosten_presenteisme_T2=ziekteverzuim6_T2 * werkuur_per_dag_gem * 35.55 * perc_geenwerk_T2.
EXECUTE.
IF (ziekteverzuim5_T3=2) kosten_presenteism_T3=ziekteverzuim6_T3 * werkuur_per_dag_T3 * 35.55 * perc_geenwerk_T3.
IF (ziekteverzuim5_T3=1) kosten_presenteism_T3=0.
IF (ziekteverzuim5_T3=2 and SYSMIS(werkuur_per_dag_T3)=1) kosten_presenteisme_T3=ziekteverzuim6_T3 * werkuur_per_dag_gem * 35.55 * perc_geenwerk_T3.
EXECUTE.
IF (ziekteverzuim5_T4=2) kosten_presenteism_T4=ziekteverzuim6_T4 * werkuur_per_dag_T4 * 35.55 * perc_geenwerk_T4.
IF (ziekteverzuim5_T4=1) kosten_presenteism_T4=0.
IF (ziekteverzuim5_T4=2 and SYSMIS(werkuur_per_dag_T4)=1) kosten_presenteisme_T4=ziekteverzuim6_T4 * werkuur_per_dag_gem * 35.55 * perc_geenwerk_T4.
EXECUTE.
VARIABLE WIDTH kosten_presenteism_T1 kosten_presenteism_T2 kosten_presenteism_T3 kosten_presenteism_T4 (15).


**Missings imputeren.

** Kosten per maand berekenen.
COMPUTE kosten_presenteism_T1_mnd=kosten_presenteism_T1/2.
COMPUTE kosten_presenteism_T2_mnd=kosten_presenteism_T2/3.
COMPUTE kosten_presenteism_T3_mnd=kosten_presenteism_T3/3.
COMPUTE kosten_presenteism_T4_mnd=kosten_presenteism_T4/6.
EXECUTE.

IF  (MISSING(kosten_presenteism_T1)=1) kosten_presenteism_T1_imp= 2 * MEAN(kosten_presenteism_T2_mnd,kosten_presenteism_T3_mnd,kosten_presenteism_T4_mnd).
IF  (MISSING(kosten_presenteism_T1)=0) kosten_presenteism_T1_imp=kosten_presenteism_T1.
IF  (MISSING(kosten_presenteism_T2)=1) kosten_presenteism_T2_imp= 3 * MEAN(kosten_presenteism_T1_mnd,kosten_presenteism_T3_mnd,kosten_presenteism_T4_mnd).
IF  (MISSING(kosten_presenteism_T2)=0) kosten_presenteism_T2_imp=kosten_presenteism_T2.
IF  (MISSING(kosten_presenteism_T3)=1) kosten_presenteism_T3_imp= 3 * MEAN(kosten_presenteism_T1_mnd,kosten_presenteism_T2_mnd,kosten_presenteism_T4_mnd).
IF  (MISSING(kosten_presenteism_T3)=0) kosten_presenteism_T3_imp=kosten_presenteism_T3.
IF  (MISSING(kosten_presenteism_T4)=1) kosten_presenteism_T4_imp= 6 * MEAN(kosten_presenteism_T1_mnd,kosten_presenteism_T2_mnd,kosten_presenteism_T3_mnd).
IF  (MISSING(kosten_presenteism_T4)=0) kosten_presenteism_T4_imp=kosten_presenteism_T4.
EXECUTE.
VARIABLE WIDTH kosten_presenteism_T1_imp kosten_presenteism_T2_imp kosten_presenteism_T3_imp kosten_presenteism_T4_imp (10).
VARIABLE LEVEL kosten_presenteism_T1_imp kosten_presenteism_T2_imp kosten_presenteism_T3_imp kosten_presenteism_T4_imp (SCALE).

DELETE VARIABLES  perc_geenwerk_T1 perc_geenwerk_T2 perc_geenwerk_T3 perc_geenwerk_T4 kosten_presenteisme_T1_mnd kosten_presenteisme_T2_mnd kosten_presenteisme_T3_mnd 
    kosten_presenteisme_T4_mnd.


** totale kosten presenteisme T1-T4.

COMPUTE Kosten_presenteism_T1_T4=  SUM (kosten_presenteism_T1, kosten_presenteism_T2, kosten_presenteism_T3 ,kosten_presenteism_T4).
COMPUTE Kosten_presenteism_T1_T4_imp= SUM (kosten_presenteism_T1_imp, kosten_presenteism_T2_imp, kosten_presenteism_T3_imp , kosten_presenteism_T4_imp).
EXECUTE.
VARIABLE WIDTH Kosten_presenteism_T1_T4_imp Kosten_presenteism_T1_T4 (10).
VARIABLE LEVEL Kosten_presenteism_T1_T4_imp Kosten_presenteism_T1_T4 (SCALE).
VARIABLE LABELS Kosten_presenteism_T1_T4_imp 'tot kosten presenteïsme geïmputeerd' Kosten_presenteism_T1_T4 'tot kosten presenteïme met missings (dus missing=0)'.

** descripives.
DESCRIPTIVES VARIABLES=Kosten_presenteism_T1_T4 Kosten_presenteism_T1_T4_imp
  /STATISTICS=MEAN STDDEV MIN MAX.

** outliers.
EXAMINE VARIABLES=Kosten_presenteism_T1_T4 Kosten_presenteism_T1_T4_imp
  /COMPARE VARIABLE
  /PLOT=BOXPLOT
  /STATISTICS=NONE
  /NOTOTAL
  /ID=ID_code
  /MISSING=LISTWISE.


*** presenteisme: imputatie met gemiddelde van interventie cq controle groep.
T-TEST GROUPS=conditie(1 2)
  /MISSING=ANALYSIS
  /VARIABLES=Kosten_presenteism_T1_T4_imp
  /CRITERIA=CI(.95).
* --> interventiegroep: 1490.66; controlegroep: 1304.80.
DO IF (conditie =1 and in_kostenanalyse=1).
RECODE Kosten_presenteism_T1_T4_imp  (SYSMIS=1490.66).
END IF.
DO IF (conditie =2  and in_kostenanalyse=1).
RECODE Kosten_presenteism_T1_T4_imp (SYSMIS=1304.80).
END IF.
EXECUTE.


*******************************************************************************************************************************************************************************************************************.
** Onbetaald werk************************************************************************************************************************************************************************************************.
*******************************************************************************************************************************************************************************************************************.

*Kosten per vragenlijst = (aant dagen x aant uur per dag x 14.32).

IF (ziekteverzuim8_T1=2) kosten_onbetaald_T1=ziekteverzuim9_T1 * ziekteverzuim10_T1 * 14.32.
IF (ziekteverzuim8_T1=1) kosten_onbetaald_T1=0.
IF (ziekteverzuim8_T2=2) kosten_onbetaald_T2=ziekteverzuim9_T2 * ziekteverzuim10_T2 * 14.32.
IF (ziekteverzuim8_T2=1) kosten_onbetaald_T2=0.
IF (ziekteverzuim8_T3=2) kosten_onbetaald_T3=ziekteverzuim9_T3 * ziekteverzuim10_T3 * 14.32.
IF (ziekteverzuim8_T3=1) kosten_onbetaald_T3=0.
IF (ziekteverzuim8_T4=2) kosten_onbetaald_T4=ziekteverzuim9_T4 * ziekteverzuim10_T4 * 14.32.
IF (ziekteverzuim8_T4=1) kosten_onbetaald_T4=0.
EXECUTE.

VARIABLE WIDTH kosten_onbetaald_T1 kosten_onbetaald_T2 kosten_onbetaald_T3 kosten_onbetaald_T4 (13).


**Missings imputeren.

** Kosten per maand berekenen.
COMPUTE kosten_onbetaald_T1_mnd=kosten_onbetaald_T1/2.
COMPUTE kosten_onbetaald_T2_mnd=kosten_onbetaald_T2/3.
COMPUTE kosten_onbetaald_T3_mnd=kosten_onbetaald_T3/3.
COMPUTE kosten_onbetaald_T4_mnd=kosten_onbetaald_T4/6.
EXECUTE.

IF  (MISSING(kosten_onbetaald_T1)=1) kosten_onbetaald_T1_imp= 2 * MEAN(kosten_onbetaald_T2_mnd,kosten_onbetaald_T3_mnd,kosten_onbetaald_T4_mnd).
IF  (MISSING(kosten_onbetaald_T1)=0) kosten_onbetaald_T1_imp=kosten_onbetaald_T1.
IF  (MISSING(kosten_onbetaald_T2)=1) kosten_onbetaald_T2_imp= 3 * MEAN(kosten_onbetaald_T1_mnd,kosten_onbetaald_T3_mnd,kosten_onbetaald_T4_mnd).
IF  (MISSING(kosten_onbetaald_T2)=0) kosten_onbetaald_T2_imp=kosten_onbetaald_T2.
IF  (MISSING(kosten_onbetaald_T3)=1) kosten_onbetaald_T3_imp= 3 * MEAN(kosten_onbetaald_T1_mnd,kosten_onbetaald_T2_mnd,kosten_onbetaald_T4_mnd).
IF  (MISSING(kosten_onbetaald_T3)=0) kosten_onbetaald_T3_imp=kosten_onbetaald_T3.
IF  (MISSING(kosten_onbetaald_T4)=1) kosten_onbetaald_T4_imp= 6 * MEAN(kosten_onbetaald_T1_mnd,kosten_onbetaald_T2_mnd,kosten_onbetaald_T3_mnd).
IF  (MISSING(kosten_onbetaald_T4)=0) kosten_onbetaald_T4_imp=kosten_onbetaald_T4.
EXECUTE.
VARIABLE WIDTH kosten_onbetaald_T1_imp kosten_onbetaald_T2_imp kosten_onbetaald_T3_imp kosten_onbetaald_T4_imp (10).
VARIABLE LEVEL kosten_onbetaald_T1_imp kosten_onbetaald_T2_imp kosten_onbetaald_T3_imp kosten_onbetaald_T4_imp (SCALE).

DELETE VARIABLES kosten_onbetaald_T1_mnd kosten_onbetaald_T2_mnd kosten_onbetaald_T3_mnd kosten_onbetaald_T4_mnd.


** totale kosten onbetaald werk T1-T4.

COMPUTE Kosten_onbetaald_T1_T4=SUM (kosten_onbetaald_T1, kosten_onbetaald_T2, kosten_onbetaald_T3, kosten_onbetaald_T4).
COMPUTE Kosten_onbetaald_T1_T4_imp= SUM (kosten_onbetaald_T1_imp, kosten_onbetaald_T2_imp, kosten_onbetaald_T3_imp, kosten_onbetaald_T4_imp).
EXECUTE.
VARIABLE WIDTH kosten_onbetaald_T1_T4_imp kosten_onbetaald_T1_T4 (10).
VARIABLE LEVEL kosten_onbetaald_T1_T4_imp kosten_onbetaald_T1_T4 (SCALE).
VARIABLE LABELS Kosten_onbetaald_T1_T4_imp 'tot kosten onbetaald werk geïmputeerd' kosten_onbetaald_T1_T4  'tot kosten onbetaald werk met missings (dus missing=0)'.

** descripives.
DESCRIPTIVES VARIABLES=Kosten_onbetaald_T1_T4 Kosten_onbetaald_T1_T4_imp
  /STATISTICS=MEAN STDDEV MIN MAX.

** outliers.
EXAMINE VARIABLES=Kosten_onbetaald_T1_T4 Kosten_onbetaald_T1_T4_imp
  /COMPARE VARIABLE
  /PLOT=BOXPLOT
  /STATISTICS=NONE
  /NOTOTAL
  /ID=ID_code
  /MISSING=LISTWISE.

*** onbetaald: imputatie met gemiddelde van interventie cq controle groep.
T-TEST GROUPS=conditie(1 2)
  /MISSING=ANALYSIS
  /VARIABLES=Kosten_onbetaald_T1_T4_imp
  /CRITERIA=CI(.95).
* --> interventiegroep: 762.32; controlegroep: 491.54.
DO IF (conditie =1 and in_kostenanalyse=1).
RECODE Kosten_onbetaald_T1_T4_imp  (SYSMIS=762.32).
END IF.
DO IF (conditie =2  and in_kostenanalyse=1).
RECODE Kosten_onbetaald_T1_T4_imp (SYSMIS=491.54).
END IF.
EXECUTE.



***************************************************************************************************************************************************************************************************************************.
** Pauze ***************************************************************************************************************************************************************************************************************.
***************************************************************************************************************************************************************************************************************************.

* Pauzetijd berekenen in uren = aant minuten/60 + aant uren.

COMPUTE pauze_perdag_T1=(pauzes_minuten_T1/60)+pauzes_uren_T1.
COMPUTE pauze_perdag_T2=(pauzes_minuten_T2/60)+pauzes_uren_T2.
COMPUTE pauze_perdag_T3=(pauzes_minuten_T3/60)+pauzes_uren_T3.
COMPUTE pauze_perdag_T4=(pauzes_minuten_T4/60)+pauzes_uren_T4.
EXECUTE.

VARIABLE LABELS pauze_perdag_T1 'pauze in uren per dag T1' pauze_perdag_T2 'pauze in uren per dag T2' pauze_perdag_T3 'pauze in uren per dag T3' pauze_perdag_T4 'pauze in uren per dag T4' .

** kosten = pauze per dag (in uren) x aantal werkdagen per week x aantal weken in die periode x 35.55.

IF (SYSMIS(werktijd2_T1)=0) kosten_pauze_T1_temp=pauze_perdag_T1 * werktijd2_T1 * 8 * 35.55.
IF (SYSMIS(werktijd2_T1)=1) kosten_pauze_T1_temp=pauze_perdag_T1 * werkdagen_gem * 8 * 35.55.
IF (SYSMIS(werktijd2_T2)=0) kosten_pauze_T2_temp=pauze_perdag_T2 * werktijd2_T2 * 13 * 35.55.
IF (SYSMIS(werktijd2_T2)=1) kosten_pauze_T2_temp=pauze_perdag_T2 * werkdagen_gem * 13 * 35.55.
IF (SYSMIS(werktijd2_T3)=0) kosten_pauze_T3_temp=pauze_perdag_T3 * werktijd2_T3 * 13 * 35.55.
IF (SYSMIS(werktijd2_T3)=1) kosten_pauze_T3_temp=pauze_perdag_T3 * werkdagen_gem * 13 * 35.55.
IF (SYSMIS(werktijd2_T4)=0) kosten_pauze_T4_temp=pauze_perdag_T4 * werktijd2_T4 * 26 * 35.55.
IF (SYSMIS(werktijd2_T4)=1) kosten_pauze_T4_temp=pauze_perdag_T4 * werkdagen_gem * 26 * 35.55.
EXECUTE.

** pauzes tijdens verzuim tellen niet mee.
** kort verzuim:.
IF (dagenlosverzuimT1>0) kosten_pauze_tijdens_verzuim_T1=(dagenlosverzuimT1 * pauze_perdag_T1 * 35.55). 
IF (dagenlosverzuimT2>0) kosten_pauze_tijdens_verzuim_T2=(dagenlosverzuimT1 * pauze_perdag_T2 * 35.55). 
IF (dagenlosverzuimT3>0) kosten_pauze_tijdens_verzuim_T3=(dagenlosverzuimT1 * pauze_perdag_T3 * 35.55). 
IF (dagenlosverzuimT4>0) kosten_pauze_tijdens_verzuim_T4=(dagenlosverzuimT1 * pauze_perdag_T4 * 35.55). 
EXECUTE. 
VARIABLE WIDTH kosten_pauze_tijdens_verzuim_T1 kosten_pauze_tijdens_verzuim_T2 kosten_pauze_tijdens_verzuim_T3 kosten_pauze_tijdens_verzuim_T4 (16).


COMPUTE kosten_pauze_T1=kosten_pauze_T1_temp - kosten_pauze_tijdens_verzuim_T1.
COMPUTE kosten_pauze_T2=kosten_pauze_T2_temp - kosten_pauze_tijdens_verzuim_T2.
COMPUTE kosten_pauze_T3=kosten_pauze_T3_temp - kosten_pauze_tijdens_verzuim_T3.
COMPUTE kosten_pauze_T4=kosten_pauze_T4_temp - kosten_pauze_tijdens_verzuim_T4.
EXECUTE.

** indien iemand ziek is geweest heeft hij geen pauze: pauzes op ziektedagen eraf trekken.
** langdurig verzuim: geen pauzekosten.
IF (ziekteverzuim3_T1=2) kosten_pauze_T1=0.
IF (ziekteverzuim3_T2=2) kosten_pauze_T2=0.
IF (ziekteverzuim3_T3=2) kosten_pauze_T3=0.
IF (ziekteverzuim3_T4=2) kosten_pauze_T4=0.
EXECUTE.

** indien iemand niet ziek is geweest: pauzekosten blijven wat ze zijn. 
IF (ziekteverzuim1_T1=1) kosten_pauze_T1=kosten_pauze_T1_temp.
IF (ziekteverzuim1_T2=1) kosten_pauze_T2=kosten_pauze_T2_temp.
IF (ziekteverzuim1_T3=1) kosten_pauze_T3=kosten_pauze_T3_temp.
IF (ziekteverzuim1_T4=1) kosten_pauze_T4=kosten_pauze_T4_temp.
EXECUTE.

DELETE VARIABLES kosten_pauze_tijdens_verzuim_T1 kosten_pauze_tijdens_verzuim_T2 kosten_pauze_tijdens_verzuim_T3 kosten_pauze_tijdens_verzuim_T4
kosten_pauze_T1_temp kosten_pauze_T2_temp kosten_pauze_T3_temp kosten_pauze_T4_temp.

** Kosten per maand berekenen.
COMPUTE kosten_pauze_T1_mnd=kosten_pauze_T1/2.
COMPUTE kosten_pauze_T2_mnd=kosten_pauze_T2/3.
COMPUTE kosten_pauze_T3_mnd=kosten_pauze_T3/3.
COMPUTE kosten_pauze_T4_mnd=kosten_pauze_T4/6.
EXECUTE.

** missings imputeren.
IF  (MISSING(kosten_pauze_T1)=1) kosten_pauze_T1_imp= 2 * MEAN(kosten_pauze_T2_mnd,kosten_pauze_T3_mnd,kosten_pauze_T4_mnd).
IF  (MISSING(kosten_pauze_T1)=0) kosten_pauze_T1_imp=kosten_pauze_T1.
IF  (MISSING(kosten_pauze_T2)=1) kosten_pauze_T2_imp= 3 * MEAN(kosten_pauze_T1_mnd,kosten_pauze_T3_mnd,kosten_pauze_T4_mnd).
IF  (MISSING(kosten_pauze_T2)=0) kosten_pauze_T2_imp=kosten_pauze_T2.
IF  (MISSING(kosten_pauze_T3)=1) kosten_pauze_T3_imp= 3 * MEAN(kosten_pauze_T1_mnd,kosten_pauze_T2_mnd,kosten_pauze_T4_mnd).
IF  (MISSING(kosten_pauze_T3)=0) kosten_pauze_T3_imp=kosten_pauze_T3.
IF  (MISSING(kosten_pauze_T4)=1) kosten_pauze_T4_imp= 6 * MEAN(kosten_pauze_T1_mnd,kosten_pauze_T2_mnd,kosten_pauze_T3_mnd).
IF  (MISSING(kosten_pauze_T4)=0) kosten_pauze_T4_imp=kosten_pauze_T4.
EXECUTE.
VARIABLE WIDTH kosten_pauze_T1 kosten_pauze_T2 kosten_pauze_T3 kosten_pauze_T4 (14).

** totaal kosten.
COMPUTE Kosten_pauze_T1_T4_imp = SUM ( kosten_pauze_T1_imp, kosten_pauze_T2_imp, kosten_pauze_T3_imp, kosten_pauze_T4_imp).
COMPUTE Kosten_pauze_T1_T4 = SUM ( kosten_pauze_T1, kosten_pauze_T2, kosten_pauze_T3, kosten_pauze_T4).
EXECUTE.
VARIABLE LABELS  Kosten_pauze_T1_T4 'tot kosten pauzes met missings (dus missing=0)'  Kosten_pauze_T1_T4_imp  'tot kosten pauzes geïmputeerd'.
VARIABLE WIDTH Kosten_pauze_T1_T4_imp  Kosten_pauze_T1_T4  (11).

** descripives.
DESCRIPTIVES VARIABLES=kosten_pauze_T1_T4 kosten_pauze_T1_T4_imp
  /STATISTICS=MEAN STDDEV MIN MAX.

** outliers.
EXAMINE VARIABLES=kosten_pauze_T1_T4 kosten_pauze_T1_T4_imp
  /COMPARE VARIABLE
  /PLOT=BOXPLOT
  /STATISTICS=NONE
  /NOTOTAL
  /ID=ID_code
  /MISSING=LISTWISE.

*** onbetaald: imputatie met gemiddelde van interventie cq controle groep.
T-TEST GROUPS=conditie(1 2)
  /MISSING=ANALYSIS
  /VARIABLES=kosten_pauze_T1_T4_imp
  /CRITERIA=CI(.95).
* --> interventiegroep: 7139.69; controlegroep: 7324.80.
DO IF (conditie =1 and in_kostenanalyse=1).
RECODE kosten_pauze_T1_T4_imp  (SYSMIS=7139.69).
END IF.
DO IF (conditie =2  and in_kostenanalyse=1).
RECODE kosten_pauze_T1_T4_imp (SYSMIS=7324.80).
END IF.
EXECUTE.


***************************************************************************************************************************************************************************************************************************.
** Productiviteit totaal ***************************************************************************************************************************************************************************************************************.
***************************************************************************************************************************************************************************************************************************.

COMPUTE Kosten_productiviteit_tot_T1_T4=SUM( Kosten_absenteism_T1_T4, Kosten_presenteism_T1_T4, kosten_pauze_T1_T4).
COMPUTE Kosten_productiviteit_tot_T1_T4_imp=SUM( Kosten_absenteism_T1_T4_imp, Kosten_presenteism_T1_T4_imp, kosten_pauze_T1_T4_imp).
EXECUTE.
VARIABLE WIDTH Kosten_productiviteit_tot_T1_T4  Kosten_productiviteit_tot_T1_T4_imp (11).
VARIABLE LABELS Kosten_productiviteit_tot_T1_T4 'totale kosten productiviteit (absenteisme, presentisme, en pauzes) met missings'  
Kosten_productiviteit_tot__T1_T4_imp 'totale kosten productiviteit geimputeerd (absenteisme, presentisme, en pauzes)' . 


'*******************************************************************************************************************************************************************************************************************.
'*** Kosten T0 **********************************************************************************************************************************************************************************************.
'*******************************************************************************************************************************************************************************************************************.

**** Langdurig: 6 personen zijn op T0 langdurig ziek. Allen al langer dan 85 kalender dagen: kosten zijn 0.

**** Kortdurend = kosten absenteime.
*(ontbrekende werkuren bij mensen met verzuim komt  niet voor).

COMPUTE Kosten_absenteisme_T0= ziekteverzuim2_T0 * werkuur_per_dag_T0 * 35.55.
EXECUTE.
* indien geen verzuim of langdurig verzuim: kosten=0.
IF (ziekteverzuim1_T0=1 or ziekteverzuim1_T0=3) Kosten_absenteisme_T0=0.
EXECUTE. 

**** Presenteisme.

*Ziekteverzuim7 omcoderen naar vermenigvuldigingsfactor (% geen werk verricht):
*1 = 10% werk verricht = 90 % ziek = factor: 0.9 etc.

RECODE ziekteverzuim7_T0 (0=1) (1=0.9) (2=0.8) (3=0.7) (4=0.6) (5=0.5) (6=0.4) (7=0.3) (8=0.2) (9=0.1) (10=0) into perc_geenwerk_T0.
EXECUTE.

* Kosten per vragenlijst = (aant dagen x werkuren per dag x 35.55) x vermenigvuldigingsfactor.

IF (ziekteverzuim5_T0=2) kosten_presenteism_T0=ziekteverzuim6_T0 * werkuur_per_dag_T0 * 35.55 * perc_geenwerk_T0.
IF (ziekteverzuim5_T0=1) kosten_presenteism_T0=0.
EXECUTE.

**** Onbetaald werk.
*Kosten= (aant dagen x aant uur per dag x 14.32).
IF (ziekteverzuim8_T0=2) kosten_onbetaald_T0=ziekteverzuim9_T0 * ziekteverzuim10_T0 * 14.32.
IF (ziekteverzuim8_T0=1) kosten_onbetaald_T0=0.
EXECUTE.

*** Pauze.
* Pauzetijd berekenen in uren = aant minuten/60 + aant uren.
COMPUTE pauze_perdag_T0=(pauzes_minuten_T0/60)+pauzes_uren_T0.
VARIABLE LABELS pauze_perdag_T0 'pauze in uren per dag T0' .
EXECUTE.

** kosten = pauze per dag (in uren) x aantal werkdagen per week x aantal weken in die periode x 35.55.
IF (SYSMIS(werktijd2_T0)=0) kosten_pauze_T0_temp=pauze_perdag_T0 * werktijd2_T0 *13 * 35.55.
EXECUTE.

** pauzes tijdens verzuim tellen niet mee.
** kort verzuim:.
IF (ziekteverzuim2_T0>0) kosten_pauze_tijdens_verzuim_T0=(ziekteverzuim2_T0 * pauze_perdag_T0 * 35.55). 
EXECUTE. 
VARIABLE WIDTH kosten_pauze_tijdens_verzuim_T0  (16).


COMPUTE kosten_pauze_T0=kosten_pauze_T0_temp - kosten_pauze_tijdens_verzuim_T0.
EXECUTE.

** indien iemand ziek is geweest heeft hij geen pauze: pauzes op ziektedagen eraf trekken.
** langdurig verzuim: geen pauzekosten.
IF (ziekteverzuim3_T0=2) kosten_pauze_T0=0.
EXECUTE.

** indien iemand niet ziek is geweest: pauzekosten blijven wat ze zijn. 
IF (ziekteverzuim1_T0=1) kosten_pauze_T0=kosten_pauze_T0_temp.
EXECUTE.

DELETE VARIABLES kosten_pauze_T0_temp.



*** totaal.

COMPUTE Kosten_productiviteit_tot_T0_inclmissing=SUM( Kosten_absenteisme_T0, Kosten_presenteism_T0, kosten_pauze_T0).
COMPUTE Kosten_productiviteit_tot_T0_exclmissing= Kosten_absenteisme_T0 + Kosten_presenteism_T0 + kosten_pauze_T0.
EXECUTE.
VARIABLE WIDTH Kosten_productiviteit_tot_T0_inclmissing Kosten_productiviteit_tot_T0_exclmissing (11).
VARIABLE LABELS Kosten_productiviteit_tot_T0_inclmissing 'totale kosten productiviteit T0 (absenteisme, presentisme, en pauzes) incl missing=0' 
Kosten_productiviteit_tot_T0_exclmissing 'totale kosten productiviteit T0 (absenteisme, presentisme, en pauzes) geen missings'.

