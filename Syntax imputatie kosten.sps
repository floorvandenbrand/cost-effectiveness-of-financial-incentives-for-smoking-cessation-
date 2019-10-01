* Encoding: UTF-8.


*** aantal ingevulde lijsten met kostendata bepalen.

RECODE  ingevuld_T1 ingevuld_T2 ingevuld_T3 ingevuld_T4 (3=0) (2=1) (ELSE=COPY) into kosten_ingevuld_T1 kosten_ingevuld_T2  kosten_ingevuld_T3  kosten_ingevuld_T4 .
FORMATS kosten_ingevuld_T1 kosten_ingevuld_T2  kosten_ingevuld_T3  kosten_ingevuld_T4 (F1.0).
VARIABLE LEVEL kosten_ingevuld_T1 kosten_ingevuld_T2  kosten_ingevuld_T3  kosten_ingevuld_T4 (NOMINAL).
VARIABLE WIDTH kosten_ingevuld_T1 kosten_ingevuld_T2  kosten_ingevuld_T3  kosten_ingevuld_T4 (8).


*Sommige deelnemers hebben de lijst weliswaar digitaal 'ingevuld', maar hebben alle kostenvragen overgeslagen.
DO IF (ID_code=2507 or ID_code=2609 or ID_code=2908 or ID_code=5104 or ID_code=7006 or ID_code=2114  or ID_code=6705 or ID_code=3602).
COMPUTE  kosten_ingevuld_T1 = 0.
END IF.
EXECUTE.

DO IF (ID_code=2507 or ID_code=2609 or ID_code=2908 or ID_code=5104 or ID_code=7006 or ID_code=2114  or ID_code=6705 or ID_code=5909 or ID_code=6702 or ID_code=1913).
COMPUTE  kosten_ingevuld_T2 = 0.
END IF.
EXECUTE.

DO IF (ID_code=2507 or ID_code=2609 or ID_code=2908 or ID_code=5104 or ID_code=7006 or ID_code=2114  or ID_code=6705 or ID_code=5204 or ID_code=5908 or ID_code=3209 or ID_code=3805
or ID_code=6204 or ID_code=7114).
COMPUTE  kosten_ingevuld_T3 = 0.
END IF.
EXECUTE.

DO IF (ID_code=2507 or ID_code=2609 or ID_code=2908 or ID_code=5104 or ID_code=7006 or ID_code=2114  or ID_code=6705 or ID_code=3805 or ID_code=6803 or ID_code=6705 or ID_code=3703
 or ID_code=2507 or ID_code=5104).
COMPUTE  kosten_ingevuld_T4 = 0.
END IF.
EXECUTE.

COMPUTE aant_kosten_T1_T4 =  SUM (kosten_ingevuld_T1, kosten_ingevuld_T2 , kosten_ingevuld_T3 , kosten_ingevuld_T4).
EXECUTE.
FORMATS aant_kosten_T1_T4 (F1.0).
VARIABLE WIDTH  aant_kosten_T1_T4 (10).
VARIABLE LEVEL aant_kosten_T1_T4 (SCALE).


* in kostenanalyse indien minimaal 1 kostenlijst is ingevuld.

RECODE aant_kosten_T1_T4 (0=0) (1 thru Highest=1) INTO in_kostenanalyse.
VARIABLE LABELS  in_kostenanalyse 'deelnemer in kostenanalyse (min 1 lijst)'.
VALUE LABELS in_kostenanalyse 0 'niet in kostenanalyse' 1 'in kostenanalyse'.
VARIABLE WIDTH in_kostenanalyse (8).
FORMATS in_kostenanalyse (F1.0).
EXECUTE.

USE ALL.
COMPUTE filter_$=(in_kostenanalyse=1).
VARIABLE LABELS filter_$ 'in_kostenanalyse=1 (FILTER)'.
VALUE LABELS filter_$ 0 'Not Selected' 1 'Selected'.
FORMATS filter_$ (f1.0).
FILTER BY filter_$.
EXECUTE.


** GP ******************************************************************************************************************************************************************************************************.

** aantal missings.
COMPUTE Nmiss_GP_T1_T4=NMISS(kosten_GP_T1,kosten_GP_T2,kosten_GP_T3,kosten_GP_T4).
EXECUTE.
VARIABLE LABELS Nmiss_GP_T1_T4 'aantal missings kosten GP T1-T4'.
VARIABLE LEVEL Nmiss_GP_T1_T4 (SCALE). 
FORMATS Nmiss_GP_T1_T4 (F1.0). 
VARIABLE WIDTH Nmiss_GP_T1_T4 (10). 

FREQUENCIES VARIABLES=Nmiss_GP_T1_T4
  /ORDER=ANALYSIS.

** Kosten per maand berekenen.
COMPUTE kosten_GP_T1_mnd=kosten_GP_T1/2.
COMPUTE kosten_GP_T2_mnd=kosten_GP_T2/3.
COMPUTE kosten_GP_T3_mnd=kosten_GP_T3/3.
COMPUTE kosten_GP_T4_mnd=kosten_GP_T4/6.
EXECUTE.

* imputeren kosten.
IF  (MISSING(kosten_GP_T1)=1) kosten_GP_T1_imp= 2 * MEAN(kosten_GP_T2_mnd,kosten_GP_T3_mnd,kosten_GP_T4_mnd).
IF  (MISSING(kosten_GP_T1)=0) kosten_GP_T1_imp=kosten_GP_T1.
IF  (MISSING(kosten_GP_T2)=1) kosten_GP_T2_imp= 3 * MEAN(kosten_GP_T1_mnd,kosten_GP_T3_mnd,kosten_GP_T4_mnd).
IF  (MISSING(kosten_GP_T2)=0) kosten_GP_T2_imp=kosten_GP_T2.
IF  (MISSING(kosten_GP_T3)=1) kosten_GP_T3_imp= 3 * MEAN(kosten_GP_T1_mnd,kosten_GP_T2_mnd,kosten_GP_T4_mnd).
IF  (MISSING(kosten_GP_T3)=0) kosten_GP_T3_imp=kosten_GP_T3.
IF  (MISSING(kosten_GP_T4)=1) kosten_GP_T4_imp= 6 * MEAN(kosten_GP_T1_mnd,kosten_GP_T2_mnd,kosten_GP_T3_mnd).
IF  (MISSING(kosten_GP_T4)=0) kosten_GP_T4_imp=kosten_GP_T4.
EXECUTE.
VARIABLE WIDTH kosten_GP_T1_imp kosten_GP_T2_imp kosten_GP_T3_imp kosten_GP_T4_imp (10).
VARIABLE LEVEL kosten_GP_T1_imp kosten_GP_T2_imp kosten_GP_T3_imp kosten_GP_T4_imp (SCALE).

DELETE VARIABLES kosten_GP_T1_mnd kosten_GP_T2_mnd kosten_GP_T3_mnd kosten_GP_T4_mnd.

COMPUTE Kosten_GP_T1_T4=SUM(kosten_GP_T1,kosten_GP_T2,kosten_GP_T3,kosten_GP_T4).
COMPUTE Kosten_GP_T1_T4_imp=SUM(kosten_GP_T1_imp, kosten_GP_T2_imp, kosten_GP_T3_imp, kosten_GP_T4_imp).
EXECUTE.
VARIABLE WIDTH Kosten_GP_T1_T4 Kosten_GP_T1_T4_imp (10).
VARIABLE LEVEL Kosten_GP_T1_T4 Kosten_GP_T1_T4_imp (SCALE).
VARIABLE LABELS Kosten_GP_T1_T4 'tot kosten GP met missings (dus missing=0)' Kosten_GP_T1_T4_imp 'tot kosten GP geïmputeerd'.

FREQUENCIES VARIABLES=Nmiss_GP_T1_T4
  /ORDER=ANALYSIS.
DESCRIPTIVES VARIABLES=Kosten_GP_T1_T4 Kosten_GP_T1_T4_imp
  /STATISTICS=MEAN STDDEV MIN MAX.

** outliers.
EXAMINE VARIABLES=Kosten_GP_T1_T4 Kosten_GP_T1_T4_imp 
  /COMPARE VARIABLE
  /PLOT=BOXPLOT
  /STATISTICS=NONE
  /NOTOTAL
  /ID=ID_code
  /MISSING=LISTWISE.

** Occupational practitioner ******************************************************************************************************************************************************************************************************.

** aantal missings.
COMPUTE Nmiss_occ_pract_T1_T4=NMISS(kosten_occ_pract_T1,kosten_occ_pract_T2,kosten_occ_pract_T3,kosten_occ_pract_T4).
EXECUTE.
VARIABLE LABELS Nmiss_occ_pract_T1_T4 'aantal missings kosten occ pract T1-T4'.
VARIABLE LEVEL Nmiss_occ_pract_T1_T4 (SCALE). 
FORMATS Nmiss_occ_pract_T1_T4 (F1.0). 
VARIABLE WIDTH Nmiss_occ_pract_T1_T4 (10). 

FREQUENCIES VARIABLES=Nmiss_occ_pract_T1_T4
  /ORDER=ANALYSIS.

** Kosten per maand berekenen.
COMPUTE kosten_occ_pract_T1_mnd=kosten_occ_pract_T1/2.
COMPUTE kosten_occ_pract_T2_mnd=kosten_occ_pract_T2/3.
COMPUTE kosten_occ_pract_T3_mnd=kosten_occ_pract_T3/3.
COMPUTE kosten_occ_pract_T4_mnd=kosten_occ_pract_T4/6.
EXECUTE.

* imputeren kosten.
IF  (MISSING(kosten_occ_pract_T1)=1) kosten_occ_pract_T1_imp= 2 * MEAN(kosten_occ_pract_T2_mnd,kosten_occ_pract_T3_mnd,kosten_occ_pract_T4_mnd).
IF  (MISSING(kosten_occ_pract_T1)=0) kosten_occ_pract_T1_imp=kosten_occ_pract_T1.
IF  (MISSING(kosten_occ_pract_T2)=1) kosten_occ_pract_T2_imp= 3 * MEAN(kosten_occ_pract_T1_mnd,kosten_occ_pract_T3_mnd,kosten_occ_pract_T4_mnd).
IF  (MISSING(kosten_occ_pract_T2)=0) kosten_occ_pract_T2_imp=kosten_occ_pract_T2.
IF  (MISSING(kosten_occ_pract_T3)=1) kosten_occ_pract_T3_imp= 3 * MEAN(kosten_occ_pract_T1_mnd,kosten_occ_pract_T2_mnd,kosten_occ_pract_T4_mnd).
IF  (MISSING(kosten_occ_pract_T3)=0) kosten_occ_pract_T3_imp=kosten_occ_pract_T3.
IF  (MISSING(kosten_occ_pract_T4)=1) kosten_occ_pract_T4_imp= 6 * MEAN(kosten_occ_pract_T1_mnd,kosten_occ_pract_T2_mnd,kosten_occ_pract_T3_mnd).
IF  (MISSING(kosten_occ_pract_T4)=0) kosten_occ_pract_T4_imp=kosten_occ_pract_T4.
EXECUTE.
VARIABLE WIDTH kosten_occ_pract_T1_imp kosten_occ_pract_T2_imp kosten_occ_pract_T3_imp kosten_occ_pract_T4_imp (10).
VARIABLE LEVEL kosten_occ_pract_T1_imp kosten_occ_pract_T2_imp kosten_occ_pract_T3_imp kosten_occ_pract_T4_imp (SCALE).

DELETE VARIABLES kosten_occ_pract_T1_mnd kosten_occ_pract_T2_mnd kosten_occ_pract_T3_mnd kosten_occ_pract_T4_mnd.

COMPUTE Kosten_occ_pract_T1_T4=SUM(kosten_occ_pract_T1,kosten_occ_pract_T2,kosten_occ_pract_T3,kosten_occ_pract_T4).
COMPUTE Kosten_occ_pract_T1_T4_imp=SUM(kosten_occ_pract_T1_imp, kosten_occ_pract_T2_imp, kosten_occ_pract_T3_imp, kosten_occ_pract_T4_imp).
EXECUTE.
VARIABLE WIDTH Kosten_occ_pract_T1_T4 Kosten_occ_pract_T1_T4_imp (10).
VARIABLE LEVEL Kosten_occ_pract_T1_T4 Kosten_occ_pract_T1_T4_imp (SCALE).
VARIABLE LABELS Kosten_occ_pract_T1_T4 'tot kosten occ pract met missings (dus missing=0)' Kosten_occ_pract_T1_T4_imp 'tot kosten occ pract geïmputeerd'.

FREQUENCIES VARIABLES=Nmiss_occ_pract_T1_T4
  /ORDER=ANALYSIS.
DESCRIPTIVES VARIABLES=Kosten_occ_pract_T1_T4 Kosten_occ_pract_T1_T4_imp
  /STATISTICS=MEAN STDDEV MIN MAX.

** outliers.
EXAMINE VARIABLES=Kosten_occ_pract_T1_T4 Kosten_occ_pract_T1_T4_imp 
  /COMPARE VARIABLE
  /PLOT=BOXPLOT
  /STATISTICS=NONE
  /NOTOTAL
  /ID=ID_code
  /MISSING=LISTWISE.


** stoppen met roken begeleider ******************************************************************************************************************************************************************************************.
** De kosten op T1 betreffen de interventie en worden hier op 0 gesteld. T1 telt ook niet mee voor imputatie en de totale kosten.

** aantal missings.
COMPUTE Nmiss_stop_roken_begl_T1_T4=NMISS(kosten_stop_roken_begl_T1,kosten_stop_roken_begl_T2,kosten_stop_roken_begl_T3,kosten_stop_roken_begl_T4).
EXECUTE.
VARIABLE LABELS Nmiss_stop_roken_begl_T1_T4 'aantal missings kosten stoppen met roken begeleiding T1-T4'.
VARIABLE LEVEL Nmiss_stop_roken_begl_T1_T4 (SCALE). 
FORMATS Nmiss_stop_roken_begl_T1_T4 (F1.0). 
VARIABLE WIDTH Nmiss_stop_roken_begl_T1_T4 (10). 

** Kosten per maand berekenen.
COMPUTE kosten_stop_roken_begl_T2_mnd=kosten_stop_roken_begl_T2/3.
COMPUTE kosten_stop_roken_begl_T3_mnd=kosten_stop_roken_begl_T3/3.
COMPUTE kosten_stop_roken_begl_T4_mnd=kosten_stop_roken_begl_T4/6.
EXECUTE.

* imputeren kosten.
IF  (MISSING(kosten_stop_roken_begl_T2)=1) kosten_stop_roken_begl_T2_imp= 3 * MEAN(kosten_stop_roken_begl_T3_mnd,kosten_stop_roken_begl_T4_mnd).
IF  (MISSING(kosten_stop_roken_begl_T2)=0) kosten_stop_roken_begl_T2_imp=kosten_stop_roken_begl_T2.
IF  (MISSING(kosten_stop_roken_begl_T3)=1) kosten_stop_roken_begl_T3_imp= 3 * MEAN(kosten_stop_roken_begl_T2_mnd,kosten_stop_roken_begl_T4_mnd).
IF  (MISSING(kosten_stop_roken_begl_T3)=0) kosten_stop_roken_begl_T3_imp=kosten_stop_roken_begl_T3.
IF  (MISSING(kosten_stop_roken_begl_T4)=1) kosten_stop_roken_begl_T4_imp= 6 * MEAN(kosten_stop_roken_begl_T2_mnd,kosten_stop_roken_begl_T3_mnd).
IF  (MISSING(kosten_stop_roken_begl_T4)=0) kosten_stop_roken_begl_T4_imp=kosten_stop_roken_begl_T4.
EXECUTE.
VARIABLE WIDTH kosten_stop_roken_begl_T1_imp kosten_stop_roken_begl_T2_imp kosten_stop_roken_begl_T3_imp kosten_stop_roken_begl_T4_imp (10).
VARIABLE LEVEL kosten_stop_roken_begl_T1_imp kosten_stop_roken_begl_T2_imp kosten_stop_roken_begl_T3_imp kosten_stop_roken_begl_T4_imp (SCALE).

DELETE VARIABLES kosten_stop_roken_begl_T2_mnd kosten_stop_roken_begl_T3_mnd kosten_stop_roken_begl_T4_mnd.

COMPUTE Kosten_stop_roken_begl_T2_T4=SUM(kosten_stop_roken_begl_T2,kosten_stop_roken_begl_T3,kosten_stop_roken_begl_T4).
COMPUTE Kosten_stop_roken_begl_T2_T4_imp=SUM(kosten_stop_roken_begl_T2_imp, kosten_stop_roken_begl_T3_imp, kosten_stop_roken_begl_T4_imp).
EXECUTE.
VARIABLE WIDTH Kosten_stop_roken_begl_T2_T4 Kosten_stop_roken_begl_T2_T4_imp (10).
VARIABLE LEVEL Kosten_stop_roken_begl_T2_T4 Kosten_stop_roken_begl_T2_T4_imp (SCALE).
VARIABLE LABELS Kosten_stop_roken_begl_T2_T4 'tot kosten stop roken begl met missings (dus missing=0)' Kosten_stop_roken_begl_T2_T4_imp 'tot kosten stop roken begl geïmputeerd'.

FREQUENCIES VARIABLES=Nmiss_stop_roken_begl_T1_T4
  /ORDER=ANALYSIS.
DESCRIPTIVES VARIABLES=Kosten_stop_roken_begl_T2_T4 Kosten_stop_roken_begl_T2_T4_imp
  /STATISTICS=MEAN STDDEV MIN MAX.

** outliers.
EXAMINE VARIABLES=Kosten_stop_roken_begl_T2_T4 Kosten_stop_roken_begl_T2_T4_imp 
  /COMPARE VARIABLE
  /PLOT=BOXPLOT
  /STATISTICS=NONE
  /NOTOTAL
  /ID=ID_code
  /MISSING=LISTWISE.


*** imputatie met gemiddelde van interventie cq controle groep.
T-TEST GROUPS=conditie (1 2)
  /MISSING=ANALYSIS
  /VARIABLES=Kosten_stop_roken_begl_T2_T4_imp
  /CRITERIA=CI(.95).
* --> interventiegroep: 103.93; controlegroep: 114.30.
DO IF (conditie =1 and in_kostenanalyse=1).
RECODE Kosten_stop_roken_begl_T2_T4_imp (SYSMIS=103.93).
END IF.
DO IF (conditie =2  and in_kostenanalyse=1).
RECODE Kosten_stop_roken_begl_T2_T4_imp (SYSMIS=114.30).
END IF.


** Other care  ******************************************************************************************************************************************************************************************************.
** alle consulten muv HA, bedrijfsarts en stoppen met roken begeleiding.

** aantal missings.
COMPUTE Nmiss_other_care_T1_T4=NMISS(kosten_other_care_T1,kosten_other_care_T2,kosten_other_care_T3,kosten_other_care_T4).
EXECUTE.
VARIABLE LABELS Nmiss_other_care_T1_T4 'aantal missings kosten other care T1-T4'.
VARIABLE LEVEL Nmiss_other_care_T1_T4 (SCALE). 
FORMATS Nmiss_other_care_T1_T4 (F1.0). 
VARIABLE WIDTH Nmiss_other_care_T1_T4 (10). 

FREQUENCIES VARIABLES=Nmiss_other_care_T1_T4
  /ORDER=ANALYSIS.

** Kosten per maand berekenen.
COMPUTE kosten_other_care_T1_mnd=kosten_other_care_T1/2.
COMPUTE kosten_other_care_T2_mnd=kosten_other_care_T2/3.
COMPUTE kosten_other_care_T3_mnd=kosten_other_care_T3/3.
COMPUTE kosten_other_care_T4_mnd=kosten_other_care_T4/6.
EXECUTE.

* imputeren kosten.
IF  (MISSING(kosten_other_care_T1)=1) kosten_other_care_T1_imp= 2 * MEAN(kosten_other_care_T2_mnd,kosten_other_care_T3_mnd,kosten_other_care_T4_mnd).
IF  (MISSING(kosten_other_care_T1)=0) kosten_other_care_T1_imp=kosten_other_care_T1.
IF  (MISSING(kosten_other_care_T2)=1) kosten_other_care_T2_imp= 3 * MEAN(kosten_other_care_T1_mnd,kosten_other_care_T3_mnd,kosten_other_care_T4_mnd).
IF  (MISSING(kosten_other_care_T2)=0) kosten_other_care_T2_imp=kosten_other_care_T2.
IF  (MISSING(kosten_other_care_T3)=1) kosten_other_care_T3_imp= 3 * MEAN(kosten_other_care_T1_mnd,kosten_other_care_T2_mnd,kosten_other_care_T4_mnd).
IF  (MISSING(kosten_other_care_T3)=0) kosten_other_care_T3_imp=kosten_other_care_T3.
IF  (MISSING(kosten_other_care_T4)=1) kosten_other_care_T4_imp= 6 * MEAN(kosten_other_care_T1_mnd,kosten_other_care_T2_mnd,kosten_other_care_T3_mnd).
IF  (MISSING(kosten_other_care_T4)=0) kosten_other_care_T4_imp=kosten_other_care_T4.
EXECUTE.
VARIABLE WIDTH kosten_other_care_T1_imp kosten_other_care_T2_imp kosten_other_care_T3_imp kosten_other_care_T4_imp (10).
VARIABLE LEVEL kosten_other_care_T1_imp kosten_other_care_T2_imp kosten_other_care_T3_imp kosten_other_care_T4_imp (SCALE).

DELETE VARIABLES kosten_other_care_T1_mnd kosten_other_care_T2_mnd kosten_other_care_T3_mnd kosten_other_care_T4_mnd.

COMPUTE Kosten_other_care_T1_T4=SUM(kosten_other_care_T1,kosten_other_care_T2,kosten_other_care_T3,kosten_other_care_T4).
COMPUTE Kosten_other_care_T1_T4_imp=SUM(kosten_other_care_T1_imp, kosten_other_care_T2_imp, kosten_other_care_T3_imp, kosten_other_care_T4_imp).
EXECUTE.
VARIABLE WIDTH Kosten_other_care_T1_T4 Kosten_other_care_T1_T4_imp (10).
VARIABLE LEVEL Kosten_other_care_T1_T4 Kosten_other_care_T1_T4_imp (SCALE).
VARIABLE LABELS Kosten_other_care_T1_T4 'tot kosten other care met missings (dus missing=0)' Kosten_other_care_T1_T4_imp 'tot kosten other care geïmputeerd'.

FREQUENCIES VARIABLES=Nmiss_other_care_T1_T4
  /ORDER=ANALYSIS.
DESCRIPTIVES VARIABLES=Kosten_other_care_T1_T4 Kosten_other_care_T1_T4_imp
  /STATISTICS=MEAN STDDEV MIN MAX.

** outliers.
EXAMINE VARIABLES=Kosten_other_care_T1_T4 Kosten_other_care_T1_T4_imp 
  /COMPARE VARIABLE
  /PLOT=BOXPLOT
  /STATISTICS=NONE
  /NOTOTAL
  /ID=ID_code
  /MISSING=LISTWISE.

** Poli***********************************************************************************************************. 

** aantal missings.
COMPUTE Nmiss_poli_T1_T4=NMISS(kosten_poli_T1,kosten_poli_T2,kosten_poli_T3,kosten_poli_T4).
EXECUTE.
VARIABLE LABELS Nmiss_poli_T1_T4 'aantal missings kosten polibezoek T1-T4'.
VARIABLE LEVEL Nmiss_poli_T1_T4 (SCALE). 
FORMATS Nmiss_poli_T1_T4 (F1.0). 
VARIABLE WIDTH Nmiss_poli_T1_T4 (10). 

FREQUENCIES VARIABLES=Nmiss_poli_T1_T4
  /ORDER=ANALYSIS.

** Kosten per maand berekenen.
COMPUTE kosten_poli_T1_mnd=kosten_poli_T1/2.
COMPUTE kosten_poli_T2_mnd=kosten_poli_T2/3.
COMPUTE kosten_poli_T3_mnd=kosten_poli_T3/3.
COMPUTE kosten_poli_T4_mnd=kosten_poli_T4/6.
EXECUTE.

* imputeren kosten.
IF  (MISSING(kosten_poli_T1)=1) kosten_poli_T1_imp= 2 * MEAN(kosten_poli_T2_mnd,kosten_poli_T3_mnd,kosten_poli_T4_mnd).
IF  (MISSING(kosten_poli_T1)=0) kosten_poli_T1_imp=kosten_poli_T1.
IF  (MISSING(kosten_poli_T2)=1) kosten_poli_T2_imp= 3 * MEAN(kosten_poli_T1_mnd,kosten_poli_T3_mnd,kosten_poli_T4_mnd).
IF  (MISSING(kosten_poli_T2)=0) kosten_poli_T2_imp=kosten_poli_T2.
IF  (MISSING(kosten_poli_T3)=1) kosten_poli_T3_imp= 3 * MEAN(kosten_poli_T1_mnd,kosten_poli_T2_mnd,kosten_poli_T4_mnd).
IF  (MISSING(kosten_poli_T3)=0) kosten_poli_T3_imp=kosten_poli_T3.
IF  (MISSING(kosten_poli_T4)=1) kosten_poli_T4_imp= 6 * MEAN(kosten_poli_T1_mnd,kosten_poli_T2_mnd,kosten_poli_T3_mnd).
IF  (MISSING(kosten_poli_T4)=0) kosten_poli_T4_imp=kosten_poli_T4.
EXECUTE.
VARIABLE WIDTH kosten_poli_T1_imp kosten_poli_T2_imp kosten_poli_T3_imp kosten_poli_T4_imp (10).
VARIABLE LEVEL kosten_poli_T1_imp kosten_poli_T2_imp kosten_poli_T3_imp kosten_poli_T4_imp (SCALE).

DELETE VARIABLES kosten_poli_T1_mnd kosten_poli_T2_mnd kosten_poli_T3_mnd kosten_poli_T4_mnd.

COMPUTE Kosten_poli_T1_T4=SUM(kosten_poli_T1,kosten_poli_T2,kosten_poli_T3,kosten_poli_T4).
COMPUTE Kosten_poli_T1_T4_imp=SUM(kosten_poli_T1_imp, kosten_poli_T2_imp, kosten_poli_T3_imp, kosten_poli_T4_imp).
EXECUTE.
VARIABLE WIDTH Kosten_poli_T1_T4 Kosten_poli_T1_T4_imp (10).
VARIABLE LEVEL Kosten_poli_T1_T4 Kosten_poli_T1_T4_imp (SCALE).
VARIABLE LABELS Kosten_poli_T1_T4 'tot kosten poli met missings (dus missing=0)' Kosten_poli_T1_T4_imp 'tot kosten poli geïmputeerd'.

FREQUENCIES VARIABLES=Nmiss_poli_T1_T4
  /ORDER=ANALYSIS.
DESCRIPTIVES VARIABLES=Kosten_poli_T1_T4 Kosten_poli_T1_T4_imp
  /STATISTICS=MEAN STDDEV MIN MAX.

** outliers.
EXAMINE VARIABLES=Kosten_poli_T1_T4 Kosten_poli_T1_T4_imp 
  /COMPARE VARIABLE
  /PLOT=BOXPLOT
  /STATISTICS=NONE
  /NOTOTAL
  /ID=ID_code
  /MISSING=LISTWISE.

*** imputatie met gemiddelde van interventie cq controle groep.
T-TEST GROUPS=conditie(1 2)
  /MISSING=ANALYSIS
  /VARIABLES=Kosten_poli_T1_T4_imp
  /CRITERIA=CI(.95).
* --> interventiegroep: 169.24; controlegroep: 173.37.
DO IF (conditie =1 and in_kostenanalyse=1).
RECODE Kosten_poli_T1_T4_imp (SYSMIS=169.24).
END IF.
DO IF (conditie =2  and in_kostenanalyse=1).
RECODE Kosten_poli_T1_T4_imp (SYSMIS=173.37).
END IF.


** Dagbehandeling***********************************************************************************************************. 

** aantal missings.
COMPUTE Nmiss_dagbeh_tot_T1_T4=NMISS(kosten_dagbeh_tot_T1,kosten_dagbeh_tot_T2,kosten_dagbeh_tot_T3,kosten_dagbeh_tot_T4).
EXECUTE.
VARIABLE LABELS Nmiss_dagbeh_tot_T1_T4 'aantal missings kosten polibezoek T1-T4'.
VARIABLE LEVEL Nmiss_dagbeh_tot_T1_T4 (SCALE). 
FORMATS Nmiss_dagbeh_tot_T1_T4 (F1.0). 
VARIABLE WIDTH Nmiss_dagbeh_tot_T1_T4 (10). 

FREQUENCIES VARIABLES=Nmiss_dagbeh_tot_T1_T4
  /ORDER=ANALYSIS.

** Kosten per maand berekenen.
COMPUTE kosten_dagbeh_tot_T1_mnd=kosten_dagbeh_tot_T1/2.
COMPUTE kosten_dagbeh_tot_T2_mnd=kosten_dagbeh_tot_T2/3.
COMPUTE kosten_dagbeh_tot_T3_mnd=kosten_dagbeh_tot_T3/3.
COMPUTE kosten_dagbeh_tot_T4_mnd=kosten_dagbeh_tot_T4/6.
EXECUTE.

* imputeren kosten.
IF  (MISSING(kosten_dagbeh_tot_T1)=1) kosten_dagbeh_tot_T1_imp= 2 * MEAN(kosten_dagbeh_tot_T2_mnd,kosten_dagbeh_tot_T3_mnd,kosten_dagbeh_tot_T4_mnd).
IF  (MISSING(kosten_dagbeh_tot_T1)=0) kosten_dagbeh_tot_T1_imp=kosten_dagbeh_tot_T1.
IF  (MISSING(kosten_dagbeh_tot_T2)=1) kosten_dagbeh_tot_T2_imp= 3 * MEAN(kosten_dagbeh_tot_T1_mnd,kosten_dagbeh_tot_T3_mnd,kosten_dagbeh_tot_T4_mnd).
IF  (MISSING(kosten_dagbeh_tot_T2)=0) kosten_dagbeh_tot_T2_imp=kosten_dagbeh_tot_T2.
IF  (MISSING(kosten_dagbeh_tot_T3)=1) kosten_dagbeh_tot_T3_imp= 3 * MEAN(kosten_dagbeh_tot_T1_mnd,kosten_dagbeh_tot_T2_mnd,kosten_dagbeh_tot_T4_mnd).
IF  (MISSING(kosten_dagbeh_tot_T3)=0) kosten_dagbeh_tot_T3_imp=kosten_dagbeh_tot_T3.
IF  (MISSING(kosten_dagbeh_tot_T4)=1) kosten_dagbeh_tot_T4_imp= 6 * MEAN(kosten_dagbeh_tot_T1_mnd,kosten_dagbeh_tot_T2_mnd,kosten_dagbeh_tot_T3_mnd).
IF  (MISSING(kosten_dagbeh_tot_T4)=0) kosten_dagbeh_tot_T4_imp=kosten_dagbeh_tot_T4.
EXECUTE.
VARIABLE WIDTH kosten_dagbeh_tot_T1_imp kosten_dagbeh_tot_T2_imp kosten_dagbeh_tot_T3_imp kosten_dagbeh_tot_T4_imp (10).
VARIABLE LEVEL kosten_dagbeh_tot_T1_imp kosten_dagbeh_tot_T2_imp kosten_dagbeh_tot_T3_imp kosten_dagbeh_tot_T4_imp (SCALE).

DELETE VARIABLES kosten_dagbeh_tot_T1_mnd kosten_dagbeh_tot_T2_mnd kosten_dagbeh_tot_T3_mnd kosten_dagbeh_tot_T4_mnd.

COMPUTE Kosten_dagbeh_tot_T1_T4=SUM(kosten_dagbeh_tot_T1,kosten_dagbeh_tot_T2,kosten_dagbeh_tot_T3,kosten_dagbeh_tot_T4).
COMPUTE Kosten_dagbeh_tot_T1_T4_imp=SUM(kosten_dagbeh_tot_T1_imp, kosten_dagbeh_tot_T2_imp, kosten_dagbeh_tot_T3_imp, kosten_dagbeh_tot_T4_imp).
EXECUTE.
VARIABLE WIDTH Kosten_dagbeh_tot_T1_T4 Kosten_dagbeh_tot_T1_T4_imp (10).
VARIABLE LEVEL Kosten_dagbeh_tot_T1_T4 Kosten_dagbeh_tot_T1_T4_imp (SCALE).
VARIABLE LABELS Kosten_dagbeh_tot_T1_T4 'tot kosten dagbehandeling met missings (dus missing=0)' Kosten_dagbeh_tot_T1_T4_imp 'tot kosten dagbehandeling geïmputeerd'.

FREQUENCIES VARIABLES=Nmiss_dagbeh_tot_T1_T4
  /ORDER=ANALYSIS.
DESCRIPTIVES VARIABLES=Kosten_dagbeh_tot_T1_T4 Kosten_dagbeh_tot_T1_T4_imp
  /STATISTICS=MEAN STDDEV MIN MAX.

** outliers.
EXAMINE VARIABLES=Kosten_dagbeh_tot_T1_T4 Kosten_dagbeh_tot_T1_T4_imp 
  /COMPARE VARIABLE
  /PLOT=BOXPLOT
  /STATISTICS=NONE
  /NOTOTAL
  /ID=ID_code
  /MISSING=LISTWISE.

*** imputatie met gemiddelde van interventie cq controle groep.
T-TEST GROUPS=conditie(1 2)
  /MISSING=ANALYSIS
  /VARIABLES=Kosten_dagbeh_tot_T1_T4_imp 
  /CRITERIA=CI(.95).
* --> interventiegroep: 255.59; controlegroep: 157.81.
DO IF (conditie =1 and in_kostenanalyse=1).
RECODE Kosten_dagbeh_tot_T1_T4_imp  (SYSMIS=255.59).
END IF.
DO IF (conditie =2  and in_kostenanalyse=1).
RECODE Kosten_dagbeh_tot_T1_T4_imp  (SYSMIS=157.81).
END IF.
EXECUTE.


** Opname***********************************************************************************************************. 

** aantal missings.
COMPUTE Nmiss_opname_tot_T1_T4=NMISS(kosten_opname_tot_T1,kosten_opname_tot_T2,kosten_opname_tot_T3,kosten_opname_tot_T4).
EXECUTE.
VARIABLE LABELS Nmiss_opname_tot_T1_T4 'aantal missings kosten opnames T1-T4'.
VARIABLE LEVEL Nmiss_opname_tot_T1_T4 (SCALE). 
FORMATS Nmiss_opname_tot_T1_T4 (F1.0). 
VARIABLE WIDTH Nmiss_opname_tot_T1_T4 (10). 

FREQUENCIES VARIABLES=Nmiss_opname_tot_T1_T4
  /ORDER=ANALYSIS.

** Kosten per maand berekenen.
COMPUTE kosten_opname_tot_T1_mnd=kosten_opname_tot_T1/2.
COMPUTE kosten_opname_tot_T2_mnd=kosten_opname_tot_T2/3.
COMPUTE kosten_opname_tot_T3_mnd=kosten_opname_tot_T3/3.
COMPUTE kosten_opname_tot_T4_mnd=kosten_opname_tot_T4/6.
EXECUTE.

* imputeren kosten.
IF  (MISSING(kosten_opname_tot_T1)=1) kosten_opname_tot_T1_imp= 2 * MEAN(kosten_opname_tot_T2_mnd,kosten_opname_tot_T3_mnd,kosten_opname_tot_T4_mnd).
IF  (MISSING(kosten_opname_tot_T1)=0) kosten_opname_tot_T1_imp=kosten_opname_tot_T1.
IF  (MISSING(kosten_opname_tot_T2)=1) kosten_opname_tot_T2_imp= 3 * MEAN(kosten_opname_tot_T1_mnd,kosten_opname_tot_T3_mnd,kosten_opname_tot_T4_mnd).
IF  (MISSING(kosten_opname_tot_T2)=0) kosten_opname_tot_T2_imp=kosten_opname_tot_T2.
IF  (MISSING(kosten_opname_tot_T3)=1) kosten_opname_tot_T3_imp= 3 * MEAN(kosten_opname_tot_T1_mnd,kosten_opname_tot_T2_mnd,kosten_opname_tot_T4_mnd).
IF  (MISSING(kosten_opname_tot_T3)=0) kosten_opname_tot_T3_imp=kosten_opname_tot_T3.
IF  (MISSING(kosten_opname_tot_T4)=1) kosten_opname_tot_T4_imp= 6 * MEAN(kosten_opname_tot_T1_mnd,kosten_opname_tot_T2_mnd,kosten_opname_tot_T3_mnd).
IF  (MISSING(kosten_opname_tot_T4)=0) kosten_opname_tot_T4_imp=kosten_opname_tot_T4.
EXECUTE.
VARIABLE WIDTH kosten_opname_tot_T1_imp kosten_opname_tot_T2_imp kosten_opname_tot_T3_imp kosten_opname_tot_T4_imp (10).
VARIABLE LEVEL kosten_opname_tot_T1_imp kosten_opname_tot_T2_imp kosten_opname_tot_T3_imp kosten_opname_tot_T4_imp (SCALE).

DELETE VARIABLES kosten_opname_tot_T1_mnd kosten_opname_tot_T2_mnd kosten_opname_tot_T3_mnd kosten_opname_tot_T4_mnd.

COMPUTE Kosten_opname_tot_T1_T4=SUM(kosten_opname_tot_T1,kosten_opname_tot_T2,kosten_opname_tot_T3,kosten_opname_tot_T4).
COMPUTE Kosten_opname_tot_T1_T4_imp=SUM(kosten_opname_tot_T1_imp ,kosten_opname_tot_T2_imp, kosten_opname_tot_T3_imp, kosten_opname_tot_T4_imp).
EXECUTE.
VARIABLE WIDTH Kosten_opname_tot_T1_T4 Kosten_opname_tot_T1_T4_imp (10).
VARIABLE LEVEL Kosten_opname_tot_T1_T4 Kosten_opname_tot_T1_T4_imp (SCALE).
VARIABLE LABELS Kosten_opname_tot_T1_T4 'tot kosten opname met missings (dus missing=0)' Kosten_opname_tot_T1_T4_imp 'tot kosten opname geïmputeerd'.

FREQUENCIES VARIABLES=Nmiss_opname_tot_T1_T4
  /ORDER=ANALYSIS.
DESCRIPTIVES VARIABLES=Kosten_opname_tot_T1_T4 Kosten_opname_tot_T1_T4_imp
  /STATISTICS=MEAN STDDEV MIN MAX.

** outliers.
EXAMINE VARIABLES=Kosten_opname_tot_T1_T4 Kosten_opname_tot_T1_T4_imp 
  /COMPARE VARIABLE
  /PLOT=BOXPLOT
  /STATISTICS=NONE
  /NOTOTAL
  /ID=ID_code
  /MISSING=LISTWISE.

*** imputatie met gemiddelde van interventie cq controle groep.
T-TEST GROUPS=conditie(1 2)
  /MISSING=ANALYSIS
  /VARIABLES=Kosten_opname_tot_T1_T4_imp 
  /CRITERIA=CI(.95).
* --> interventiegroep: 308.62; controlegroep: 102.20.
DO IF (conditie =1 and in_kostenanalyse=1).
RECODE Kosten_opname_tot_T1_T4_imp   (SYSMIS=308.62).
END IF.
DO IF (conditie =2  and in_kostenanalyse=1).
RECODE Kosten_opname_tot_T1_T4_imp  (SYSMIS=102.20).
END IF.
EXECUTE.


** EHBO***********************************************************************************************************. 

** aantal missings.
COMPUTE Nmiss_ehbo_T1_T4=NMISS(kosten_ehbo_T1,kosten_ehbo_T2,kosten_ehbo_T3,kosten_ehbo_T4).
EXECUTE.
VARIABLE LABELS Nmiss_ehbo_T1_T4 'aantal missings kosten EHBO T1-T4'.
VARIABLE LEVEL Nmiss_ehbo_T1_T4 (SCALE). 
FORMATS Nmiss_ehbo_T1_T4 (F1.0). 
VARIABLE WIDTH Nmiss_ehbo_T1_T4 (10). 

FREQUENCIES VARIABLES=Nmiss_ehbo_T1_T4
  /ORDER=ANALYSIS.

** Kosten per maand berekenen.
COMPUTE kosten_ehbo_T1_mnd=kosten_ehbo_T1/2.
COMPUTE kosten_ehbo_T2_mnd=kosten_ehbo_T2/3.
COMPUTE kosten_ehbo_T3_mnd=kosten_ehbo_T3/3.
COMPUTE kosten_ehbo_T4_mnd=kosten_ehbo_T4/6.
EXECUTE.

* imputeren kosten.
IF  (MISSING(kosten_ehbo_T1)=1) kosten_ehbo_T1_imp= 2 * MEAN(kosten_ehbo_T2_mnd,kosten_ehbo_T3_mnd,kosten_ehbo_T4_mnd).
IF  (MISSING(kosten_ehbo_T1)=0) kosten_ehbo_T1_imp=kosten_ehbo_T1.
IF  (MISSING(kosten_ehbo_T2)=1) kosten_ehbo_T2_imp= 3 * MEAN(kosten_ehbo_T1_mnd,kosten_ehbo_T3_mnd,kosten_ehbo_T4_mnd).
IF  (MISSING(kosten_ehbo_T2)=0) kosten_ehbo_T2_imp=kosten_ehbo_T2.
IF  (MISSING(kosten_ehbo_T3)=1) kosten_ehbo_T3_imp= 3 * MEAN(kosten_ehbo_T1_mnd,kosten_ehbo_T2_mnd,kosten_ehbo_T4_mnd).
IF  (MISSING(kosten_ehbo_T3)=0) kosten_ehbo_T3_imp=kosten_ehbo_T3.
IF  (MISSING(kosten_ehbo_T4)=1) kosten_ehbo_T4_imp= 6 * MEAN(kosten_ehbo_T1_mnd,kosten_ehbo_T2_mnd,kosten_ehbo_T3_mnd).
IF  (MISSING(kosten_ehbo_T4)=0) kosten_ehbo_T4_imp=kosten_ehbo_T4.
EXECUTE.
VARIABLE WIDTH kosten_ehbo_T1_imp kosten_ehbo_T2_imp kosten_ehbo_T3_imp kosten_ehbo_T4_imp (10).
VARIABLE LEVEL kosten_ehbo_T1_imp kosten_ehbo_T2_imp kosten_ehbo_T3_imp kosten_ehbo_T4_imp (SCALE).

DELETE VARIABLES kosten_ehbo_T1_mnd kosten_ehbo_T2_mnd kosten_ehbo_T3_mnd kosten_ehbo_T4_mnd.

COMPUTE Kosten_ehbo_T1_T4=SUM (kosten_ehbo_T1,kosten_ehbo_T2,kosten_ehbo_T3,kosten_ehbo_T4).
COMPUTE Kosten_ehbo_T1_T4_imp=SUM(kosten_ehbo_T1_imp, kosten_ehbo_T2_imp, kosten_ehbo_T3_imp, kosten_ehbo_T4_imp).
EXECUTE.
VARIABLE WIDTH Kosten_ehbo_T1_T4 Kosten_ehbo_T1_T4_imp (10).
VARIABLE LEVEL Kosten_ehbo_T1_T4 Kosten_ehbo_T1_T4_imp (SCALE).
VARIABLE LABELS Kosten_ehbo_T1_T4 'tot kosten EHBO met missings (dus missing=0)' Kosten_ehbo_T1_T4_imp 'tot kosten EHBO geïmputeerd'.

FREQUENCIES VARIABLES=Nmiss_ehbo_T1_T4
  /ORDER=ANALYSIS.
DESCRIPTIVES VARIABLES=Kosten_ehbo_T1_T4 Kosten_ehbo_T1_T4_imp
  /STATISTICS=MEAN STDDEV MIN MAX.

** outliers.
EXAMINE VARIABLES=Kosten_ehbo_T1_T4 Kosten_ehbo_T1_T4_imp 
  /COMPARE VARIABLE
  /PLOT=BOXPLOT
  /STATISTICS=NONE
  /NOTOTAL
  /ID=ID_code
  /MISSING=LISTWISE.

*** imputatie met gemiddelde van interventie cq controle groep.
T-TEST GROUPS=conditie(1 2)
  /MISSING=ANALYSIS
  /VARIABLES=Kosten_ehbo_T1_T4_imp 
  /CRITERIA=CI(.95).
* --> interventiegroep: 122.63; controlegroep: 114.10.
DO IF (conditie =1 and in_kostenanalyse=1).
RECODE Kosten_ehbo_T1_T4_imp  (SYSMIS=122.63).
END IF.
DO IF (conditie =2  and in_kostenanalyse=1).
RECODE Kosten_ehbo_T1_T4_imp   (SYSMIS=114.10).
END IF.
EXECUTE.

** Ambulance***********************************************************************************************************. 

** aantal missings.
COMPUTE Nmiss_ambulance_T1_T4=NMISS(kosten_ambulance_T1,kosten_ambulance_T2,kosten_ambulance_T3,kosten_ambulance_T4).
EXECUTE.
VARIABLE LABELS Nmiss_ambulance_T1_T4 'aantal missings kosten ambulance T1-T4'.
VARIABLE LEVEL Nmiss_ambulance_T1_T4 (SCALE). 
FORMATS Nmiss_ambulance_T1_T4 (F1.0). 
VARIABLE WIDTH Nmiss_ambulance_T1_T4 (10). 

FREQUENCIES VARIABLES=Nmiss_ambulance_T1_T4
  /ORDER=ANALYSIS.

** Kosten per maand berekenen.
COMPUTE kosten_ambulance_T1_mnd=kosten_ambulance_T1/2.
COMPUTE kosten_ambulance_T2_mnd=kosten_ambulance_T2/3.
COMPUTE kosten_ambulance_T3_mnd=kosten_ambulance_T3/3.
COMPUTE kosten_ambulance_T4_mnd=kosten_ambulance_T4/6.
EXECUTE.

* imputeren kosten.
IF  (MISSING(kosten_ambulance_T1)=1) kosten_ambulance_T1_imp= 2 * MEAN(kosten_ambulance_T2_mnd,kosten_ambulance_T3_mnd,kosten_ambulance_T4_mnd).
IF  (MISSING(kosten_ambulance_T1)=0) kosten_ambulance_T1_imp=kosten_ambulance_T1.
IF  (MISSING(kosten_ambulance_T2)=1) kosten_ambulance_T2_imp= 3 * MEAN(kosten_ambulance_T1_mnd,kosten_ambulance_T3_mnd,kosten_ambulance_T4_mnd).
IF  (MISSING(kosten_ambulance_T2)=0) kosten_ambulance_T2_imp=kosten_ambulance_T2.
IF  (MISSING(kosten_ambulance_T3)=1) kosten_ambulance_T3_imp= 3 * MEAN(kosten_ambulance_T1_mnd,kosten_ambulance_T2_mnd,kosten_ambulance_T4_mnd).
IF  (MISSING(kosten_ambulance_T3)=0) kosten_ambulance_T3_imp=kosten_ambulance_T3.
IF  (MISSING(kosten_ambulance_T4)=1) kosten_ambulance_T4_imp= 6 * MEAN(kosten_ambulance_T1_mnd,kosten_ambulance_T2_mnd,kosten_ambulance_T3_mnd).
IF  (MISSING(kosten_ambulance_T4)=0) kosten_ambulance_T4_imp=kosten_ambulance_T4.
EXECUTE.
VARIABLE WIDTH kosten_ambulance_T1_imp kosten_ambulance_T2_imp kosten_ambulance_T3_imp kosten_ambulance_T4_imp (10).
VARIABLE LEVEL kosten_ambulance_T1_imp kosten_ambulance_T2_imp kosten_ambulance_T3_imp kosten_ambulance_T4_imp (SCALE).

DELETE VARIABLES kosten_ambulance_T1_mnd kosten_ambulance_T2_mnd kosten_ambulance_T3_mnd kosten_ambulance_T4_mnd.

COMPUTE Kosten_ambulance_T1_T4=SUM (kosten_ambulance_T1,kosten_ambulance_T2,kosten_ambulance_T3,kosten_ambulance_T4).
COMPUTE Kosten_ambulance_T1_T4_imp=SUM(kosten_ambulance_T1_imp, kosten_ambulance_T2_imp, kosten_ambulance_T3_imp, kosten_ambulance_T4_imp).
EXECUTE.
VARIABLE WIDTH Kosten_ambulance_T1_T4 Kosten_ambulance_T1_T4_imp (10).
VARIABLE LEVEL Kosten_ambulance_T1_T4 Kosten_ambulance_T1_T4_imp (SCALE).
VARIABLE LABELS Kosten_ambulance_T1_T4 'tot kosten ambulance met missings (dus missing=0)' Kosten_ambulance_T1_T4_imp 'tot kosten ambulance geïmputeerd'.

FREQUENCIES VARIABLES=Nmiss_ambulance_T1_T4
  /ORDER=ANALYSIS.
DESCRIPTIVES VARIABLES=Kosten_ambulance_T1_T4 Kosten_ambulance_T1_T4_imp
  /STATISTICS=MEAN STDDEV MIN MAX.

** outliers.
EXAMINE VARIABLES=Kosten_ambulance_T1_T4 Kosten_ambulance_T1_T4_imp 
  /COMPARE VARIABLE
  /PLOT=BOXPLOT
  /STATISTICS=NONE
  /NOTOTAL
  /ID=ID_code
  /MISSING=LISTWISE.

*** imputatie met gemiddelde van interventie cq controle groep.
T-TEST GROUPS=conditie(1 2)
  /MISSING=ANALYSIS
  /VARIABLES=Kosten_ambulance_T1_T4_imp 
  /CRITERIA=CI(.95).
* --> interventiegroep: 75.81; controlegroep: 53.60.
DO IF (conditie =1 and in_kostenanalyse=1).
RECODE Kosten_ambulance_T1_T4_imp  (SYSMIS=75.81).
END IF.
DO IF (conditie =2  and in_kostenanalyse=1).
RECODE Kosten_ambulance_T1_T4_imp    (SYSMIS=53.60).
END IF.
EXECUTE.


** Medicatie**********************************************************************************************************************************************************************************************.

** aantal missings.
COMPUTE Nmiss_med_tot_T1_T4=NMISS(kosten_med_tot_T1,kosten_med_tot_T2,kosten_med_tot_T3,kosten_med_tot_T4).
EXECUTE.
VARIABLE LABELS Nmiss_med_tot_T1_T4 'aantal missings kosten medicatie T1-T4'.
VARIABLE LEVEL Nmiss_med_tot_T1_T4 (SCALE). 
FORMATS Nmiss_med_tot_T1_T4 (F1.0). 
VARIABLE WIDTH kosten_med_tot_T1 kosten_med_tot_T2 kosten_med_tot_T3 kosten_med_tot_T4 Nmiss_med_tot_T1_T4 (10). 

FREQUENCIES VARIABLES=Nmiss_med_tot_T1_T4
  /ORDER=ANALYSIS.

** Kosten per maand berekenen.
COMPUTE kosten_med_tot_T1_mnd=kosten_med_tot_T1/2.
COMPUTE kosten_med_tot_T2_mnd=kosten_med_tot_T2/3.
COMPUTE kosten_med_tot_T3_mnd=kosten_med_tot_T3/3.
COMPUTE kosten_med_tot_T4_mnd=kosten_med_tot_T4/6.
EXECUTE.

* imputeren kosten.
IF  (MISSING(kosten_med_tot_T1)=1) kosten_med_tot_T1_imp= 2 * MEAN(kosten_med_tot_T2_mnd,kosten_med_tot_T3_mnd,kosten_med_tot_T4_mnd).
IF  (MISSING(kosten_med_tot_T1)=0) kosten_med_tot_T1_imp=kosten_med_tot_T1.
IF  (MISSING(kosten_med_tot_T2)=1) kosten_med_tot_T2_imp= 3 * MEAN(kosten_med_tot_T1_mnd,kosten_med_tot_T3_mnd,kosten_med_tot_T4_mnd).
IF  (MISSING(kosten_med_tot_T2)=0) kosten_med_tot_T2_imp=kosten_med_tot_T2.
IF  (MISSING(kosten_med_tot_T3)=1) kosten_med_tot_T3_imp= 3 * MEAN(kosten_med_tot_T1_mnd,kosten_med_tot_T2_mnd,kosten_med_tot_T4_mnd).
IF  (MISSING(kosten_med_tot_T3)=0) kosten_med_tot_T3_imp=kosten_med_tot_T3.
IF  (MISSING(kosten_med_tot_T4)=1) kosten_med_tot_T4_imp= 6 * MEAN(kosten_med_tot_T1_mnd,kosten_med_tot_T2_mnd,kosten_med_tot_T3_mnd).
IF  (MISSING(kosten_med_tot_T4)=0) kosten_med_tot_T4_imp=kosten_med_tot_T4.
EXECUTE.
VARIABLE WIDTH kosten_med_tot_T1_imp kosten_med_tot_T2_imp kosten_med_tot_T3_imp kosten_med_tot_T4_imp (10).
VARIABLE LEVEL kosten_med_tot_T1_imp kosten_med_tot_T2_imp kosten_med_tot_T3_imp kosten_med_tot_T4_imp (SCALE).

DELETE VARIABLES kosten_med_tot_T1_mnd kosten_med_tot_T2_mnd kosten_med_tot_T3_mnd kosten_med_tot_T4_mnd.

COMPUTE Kosten_med_tot_T1_T4=SUM(kosten_med_tot_T1, kosten_med_tot_T2, kosten_med_tot_T3, kosten_med_tot_T4).
COMPUTE Kosten_med_tot_T1_T4_imp=SUM(kosten_med_tot_T1_imp , kosten_med_tot_T2_imp, kosten_med_tot_T3_imp, kosten_med_tot_T4_imp).
EXECUTE.
VARIABLE WIDTH Kosten_med_tot_T1_T4 Kosten_med_tot_T1_T4_imp (10).
VARIABLE LEVEL Kosten_med_tot_T1_T4 Kosten_med_tot_T1_T4_imp (SCALE).
VARIABLE LABELS Kosten_med_tot_T1_T4 'tot kosten medicatie met missings (dus missing=0)' Kosten_med_tot_T1_T4_imp 'tot kosten medicatie geïmputeerd'.

FREQUENCIES VARIABLES=Nmiss_med_tot_T1_T4
  /ORDER=ANALYSIS.
DESCRIPTIVES VARIABLES=Kosten_med_tot_T1_T4 Kosten_med_tot_T1_T4_imp
  /STATISTICS=MEAN STDDEV MIN MAX.

** outliers.
EXAMINE VARIABLES=Kosten_med_tot_T1_T4 Kosten_med_tot_T1_T4_imp 
  /COMPARE VARIABLE
  /PLOT=BOXPLOT
  /STATISTICS=NONE
  /NOTOTAL
  /ID=ID_code
  /MISSING=LISTWISE.

*** imputatie met gemiddelde van interventie cq controle groep.
T-TEST GROUPS=conditie(1 2)
  /MISSING=ANALYSIS
  /VARIABLES=Kosten_med_tot_T1_T4_imp 
  /CRITERIA=CI(.95).
* --> interventiegroep: 159.68; controlegroep: 272.95.
DO IF (conditie =1 and in_kostenanalyse=1).
RECODE Kosten_med_tot_T1_T4_imp   (SYSMIS=159.68).
END IF.
DO IF (conditie =2  and in_kostenanalyse=1).
RECODE Kosten_med_tot_T1_T4_imp  (SYSMIS=272.95).
END IF.
EXECUTE.

** Medicatie roken**********************************************************************************************************************************************************************************************.

** aantal missings.
COMPUTE Nmiss_med_roken_T1_T4=NMISS(kosten_med_roken_T1,kosten_med_roken_T2,kosten_med_roken_T3,kosten_med_roken_T4).
EXECUTE.
VARIABLE LABELS Nmiss_med_roken_T1_T4 'aantal missings kosten roken medicatie T1-T4'.
VARIABLE LEVEL Nmiss_med_roken_T1_T4 (SCALE). 
FORMATS Nmiss_med_roken_T1_T4 (F1.0). 
VARIABLE WIDTH Nmiss_med_roken_T1_T4  kosten_med_roken_T1  kosten_med_roken_T2  kosten_med_roken_T3  kosten_med_roken_T4 (10). 

FREQUENCIES VARIABLES=Nmiss_med_roken_T1_T4
  /ORDER=ANALYSIS.

** Kosten per maand berekenen.
COMPUTE kosten_med_roken_T1_mnd=kosten_med_roken_T1/2.
COMPUTE kosten_med_roken_T2_mnd=kosten_med_roken_T2/3.
COMPUTE kosten_med_roken_T3_mnd=kosten_med_roken_T3/3.
COMPUTE kosten_med_roken_T4_mnd=kosten_med_roken_T4/6.
EXECUTE.

* imputeren kosten.
IF  (MISSING(kosten_med_roken_T1)=1) kosten_med_roken_T1_imp= 2 * MEAN(kosten_med_roken_T2_mnd,kosten_med_roken_T3_mnd,kosten_med_roken_T4_mnd).
IF  (MISSING(kosten_med_roken_T1)=0) kosten_med_roken_T1_imp=kosten_med_roken_T1.
IF  (MISSING(kosten_med_roken_T2)=1) kosten_med_roken_T2_imp= 3 * MEAN(kosten_med_roken_T1_mnd,kosten_med_roken_T3_mnd,kosten_med_roken_T4_mnd).
IF  (MISSING(kosten_med_roken_T2)=0) kosten_med_roken_T2_imp=kosten_med_roken_T2.
IF  (MISSING(kosten_med_roken_T3)=1) kosten_med_roken_T3_imp= 3 * MEAN(kosten_med_roken_T1_mnd,kosten_med_roken_T2_mnd,kosten_med_roken_T4_mnd).
IF  (MISSING(kosten_med_roken_T3)=0) kosten_med_roken_T3_imp=kosten_med_roken_T3.
IF  (MISSING(kosten_med_roken_T4)=1) kosten_med_roken_T4_imp= 6 * MEAN(kosten_med_roken_T1_mnd,kosten_med_roken_T2_mnd,kosten_med_roken_T3_mnd).
IF  (MISSING(kosten_med_roken_T4)=0) kosten_med_roken_T4_imp=kosten_med_roken_T4.
EXECUTE.
VARIABLE WIDTH kosten_med_roken_T1_imp kosten_med_roken_T2_imp kosten_med_roken_T3_imp kosten_med_roken_T4_imp (10).
VARIABLE LEVEL kosten_med_roken_T1_imp kosten_med_roken_T2_imp kosten_med_roken_T3_imp kosten_med_roken_T4_imp (SCALE).

DELETE VARIABLES kosten_med_roken_T1_mnd kosten_med_roken_T2_mnd kosten_med_roken_T3_mnd kosten_med_roken_T4_mnd.

COMPUTE Kosten_med_roken_T1_T4=SUM(kosten_med_roken_T1, kosten_med_roken_T2, kosten_med_roken_T3, kosten_med_roken_T4).
COMPUTE Kosten_med_roken_T1_T4_imp=SUM(kosten_med_roken_T1_imp ,kosten_med_roken_T2_imp, kosten_med_roken_T3_imp, kosten_med_roken_T4_imp).
EXECUTE.
VARIABLE WIDTH Kosten_med_roken_T1_T4 Kosten_med_roken_T1_T4_imp (10).
VARIABLE LEVEL Kosten_med_roken_T1_T4 Kosten_med_roken_T1_T4_imp (SCALE).
VARIABLE LABELS Kosten_med_roken_T1_T4 'tot kosten rokenmedicatie met missings (dusmissing=0) ' Kosten_med_roken_T1_T4_imp 'tot kosten rokenmedicatie geïmputeerd'.

FREQUENCIES VARIABLES=Nmiss_med_roken_T1_T4
  /ORDER=ANALYSIS.
DESCRIPTIVES VARIABLES=Kosten_med_roken_T1_T4 Kosten_med_roken_T1_T4_imp
  /STATISTICS=MEAN STDDEV MIN MAX.

** outliers.
EXAMINE VARIABLES=Kosten_med_roken_T1_T4 Kosten_med_roken_T1_T4_imp 
  /COMPARE VARIABLE
  /PLOT=BOXPLOT
  /STATISTICS=NONE
  /NOTOTAL
  /ID=ID_code
  /MISSING=LISTWISE.

*** imputatie met gemiddelde van interventie cq controle groep.
T-TEST GROUPS=conditie(1 2)
  /MISSING=ANALYSIS
  /VARIABLES=Kosten_med_roken_T1_T4_imp
  /CRITERIA=CI(.95).
* --> interventiegroep: 76.13; controlegroep: 49.51.
DO IF (conditie =1 and in_kostenanalyse=1).
RECODE Kosten_med_roken_T1_T4_imp  (SYSMIS=76.13).
END IF.
DO IF (conditie =2  and in_kostenanalyse=1).
RECODE Kosten_med_roken_T1_T4_imp (SYSMIS=49.51).
END IF.
EXECUTE.


** Thuiszorg***********************************************************************************************************. 

** aantal missings.
COMPUTE Nmiss_thuiszorg_tot_T1_T4=NMISS(kosten_thuiszorg_tot_T1,kosten_thuiszorg_tot_T2,kosten_thuiszorg_tot_T3,kosten_thuiszorg_tot_T4).
EXECUTE.
VARIABLE LABELS Nmiss_thuiszorg_tot_T1_T4 'aantal missings kosten thuiszorg T1-T4'.
VARIABLE LEVEL Nmiss_thuiszorg_tot_T1_T4 (SCALE). 
FORMATS Nmiss_thuiszorg_tot_T1_T4 (F1.0). 
VARIABLE WIDTH Nmiss_thuiszorg_tot_T1_T4 (10). 

FREQUENCIES VARIABLES=Nmiss_thuiszorg_tot_T1_T4
  /ORDER=ANALYSIS.

** Kosten per maand berekenen.
COMPUTE kosten_thuiszorg_tot_T1_mnd=kosten_thuiszorg_tot_T1/2.
COMPUTE kosten_thuiszorg_tot_T2_mnd=kosten_thuiszorg_tot_T2/3.
COMPUTE kosten_thuiszorg_tot_T3_mnd=kosten_thuiszorg_tot_T3/3.
COMPUTE kosten_thuiszorg_tot_T4_mnd=kosten_thuiszorg_tot_T4/6.
EXECUTE.

* imputeren kosten.
IF  (MISSING(kosten_thuiszorg_tot_T1)=1) kosten_thuiszorg_tot_T1_imp= 2 * MEAN(kosten_thuiszorg_tot_T2_mnd,kosten_thuiszorg_tot_T3_mnd,kosten_thuiszorg_tot_T4_mnd).
IF  (MISSING(kosten_thuiszorg_tot_T1)=0) kosten_thuiszorg_tot_T1_imp=kosten_thuiszorg_tot_T1.
IF  (MISSING(kosten_thuiszorg_tot_T2)=1) kosten_thuiszorg_tot_T2_imp= 3 * MEAN(kosten_thuiszorg_tot_T1_mnd,kosten_thuiszorg_tot_T3_mnd,kosten_thuiszorg_tot_T4_mnd).
IF  (MISSING(kosten_thuiszorg_tot_T2)=0) kosten_thuiszorg_tot_T2_imp=kosten_thuiszorg_tot_T2.
IF  (MISSING(kosten_thuiszorg_tot_T3)=1) kosten_thuiszorg_tot_T3_imp= 3 * MEAN(kosten_thuiszorg_tot_T1_mnd,kosten_thuiszorg_tot_T2_mnd,kosten_thuiszorg_tot_T4_mnd).
IF  (MISSING(kosten_thuiszorg_tot_T3)=0) kosten_thuiszorg_tot_T3_imp=kosten_thuiszorg_tot_T3.
IF  (MISSING(kosten_thuiszorg_tot_T4)=1) kosten_thuiszorg_tot_T4_imp= 6 * MEAN(kosten_thuiszorg_tot_T1_mnd,kosten_thuiszorg_tot_T2_mnd,kosten_thuiszorg_tot_T3_mnd).
IF  (MISSING(kosten_thuiszorg_tot_T4)=0) kosten_thuiszorg_tot_T4_imp=kosten_thuiszorg_tot_T4.
EXECUTE.
VARIABLE WIDTH kosten_thuiszorg_tot_T1_imp kosten_thuiszorg_tot_T2_imp kosten_thuiszorg_tot_T3_imp kosten_thuiszorg_tot_T4_imp (10).
VARIABLE LEVEL kosten_thuiszorg_tot_T1_imp kosten_thuiszorg_tot_T2_imp kosten_thuiszorg_tot_T3_imp kosten_thuiszorg_tot_T4_imp (SCALE).

DELETE VARIABLES kosten_thuiszorg_tot_T1_mnd kosten_thuiszorg_tot_T2_mnd kosten_thuiszorg_tot_T3_mnd kosten_thuiszorg_tot_T4_mnd.

COMPUTE Kosten_thuiszorg_tot_T1_T4=SUM(kosten_thuiszorg_tot_T1, kosten_thuiszorg_tot_T2, kosten_thuiszorg_tot_T3, kosten_thuiszorg_tot_T4).
COMPUTE Kosten_thuiszorg_tot_T1_T4_imp=SUM(kosten_thuiszorg_tot_T1_imp, kosten_thuiszorg_tot_T2_imp, kosten_thuiszorg_tot_T3_imp, kosten_thuiszorg_tot_T4_imp).
EXECUTE.
VARIABLE WIDTH Kosten_thuiszorg_tot_T1_T4 Kosten_thuiszorg_tot_T1_T4_imp (10).
VARIABLE LEVEL Kosten_thuiszorg_tot_T1_T4 Kosten_thuiszorg_tot_T1_T4_imp (SCALE).
VARIABLE LABELS Kosten_thuiszorg_tot_T1_T4 'tot kosten thuiszorg met missings (dus missing=0)' Kosten_thuiszorg_tot_T1_T4_imp 'tot kosten thuiszorg geïmputeerd'.

FREQUENCIES VARIABLES=Nmiss_thuiszorg_tot_T1_T4
  /ORDER=ANALYSIS.
DESCRIPTIVES VARIABLES=Kosten_thuiszorg_tot_T1_T4 Kosten_thuiszorg_tot_T1_T4_imp
  /STATISTICS=MEAN STDDEV MIN MAX.

** outliers.
EXAMINE VARIABLES=Kosten_thuiszorg_tot_T1_T4 Kosten_thuiszorg_tot_T1_T4_imp 
  /COMPARE VARIABLE
  /PLOT=BOXPLOT
  /STATISTICS=NONE
  /NOTOTAL
  /ID=ID_code
  /MISSING=LISTWISE.

*** imputatie met gemiddelde van interventie cq controle groep.
T-TEST GROUPS=conditie(1 2)
  /MISSING=ANALYSIS
  /VARIABLES=Kosten_thuiszorg_tot_T1_T4_imp 
  /CRITERIA=CI(.95).
* --> interventiegroep: 174.40; controlegroep: 15.95.
DO IF (conditie =1 and in_kostenanalyse=1).
RECODE Kosten_thuiszorg_tot_T1_T4_imp   (SYSMIS=174.40).
END IF.
DO IF (conditie =2  and in_kostenanalyse=1).
RECODE Kosten_thuiszorg_tot_T1_T4_imp  (SYSMIS=15.95).
END IF.
EXECUTE.

** reiskosten***********************************************************************************************************. 

** aantal missings.
COMPUTE Nmiss_reiskosten_tot_T1_T4=NMISS(reiskosten_tot_T1,reiskosten_tot_T2,reiskosten_tot_T3,reiskosten_tot_T4).
EXECUTE.
VARIABLE LABELS Nmiss_reiskosten_tot_T1_T4 'aantal missings reiskosten T1-T4'.
VARIABLE LEVEL Nmiss_reiskosten_tot_T1_T4 (SCALE). 
FORMATS Nmiss_reiskosten_tot_T1_T4 (F1.0). 
VARIABLE WIDTH Nmiss_reiskosten_tot_T1_T4 (10). 

FREQUENCIES VARIABLES=Nmiss_reiskosten_tot_T1_T4
  /ORDER=ANALYSIS.

** Kosten per maand berekenen.
COMPUTE reiskosten_tot_T1_mnd=reiskosten_tot_T1/2.
COMPUTE reiskosten_tot_T2_mnd=reiskosten_tot_T2/3.
COMPUTE reiskosten_tot_T3_mnd=reiskosten_tot_T3/3.
COMPUTE reiskosten_tot_T4_mnd=reiskosten_tot_T4/6.
EXECUTE.

* imputeren kosten.
IF  (MISSING(reiskosten_tot_T1)=1) reiskosten_tot_T1_imp= 2 * MEAN(reiskosten_tot_T2_mnd,reiskosten_tot_T3_mnd,reiskosten_tot_T4_mnd).
IF  (MISSING(reiskosten_tot_T1)=0) reiskosten_tot_T1_imp=reiskosten_tot_T1.
IF  (MISSING(reiskosten_tot_T2)=1) reiskosten_tot_T2_imp= 3 * MEAN(reiskosten_tot_T1_mnd,reiskosten_tot_T3_mnd,reiskosten_tot_T4_mnd).
IF  (MISSING(reiskosten_tot_T2)=0) reiskosten_tot_T2_imp=reiskosten_tot_T2.
IF  (MISSING(reiskosten_tot_T3)=1) reiskosten_tot_T3_imp= 3 * MEAN(reiskosten_tot_T1_mnd,reiskosten_tot_T2_mnd,reiskosten_tot_T4_mnd).
IF  (MISSING(reiskosten_tot_T3)=0) reiskosten_tot_T3_imp=reiskosten_tot_T3.
IF  (MISSING(reiskosten_tot_T4)=1) reiskosten_tot_T4_imp= 6 * MEAN(reiskosten_tot_T1_mnd,reiskosten_tot_T2_mnd,reiskosten_tot_T3_mnd).
IF  (MISSING(reiskosten_tot_T4)=0) reiskosten_tot_T4_imp=reiskosten_tot_T4.
EXECUTE.
VARIABLE WIDTH reiskosten_tot_T1_imp reiskosten_tot_T2_imp reiskosten_tot_T3_imp reiskosten_tot_T4_imp (10).
VARIABLE LEVEL reiskosten_tot_T1_imp reiskosten_tot_T2_imp reiskosten_tot_T3_imp reiskosten_tot_T4_imp (SCALE).

DELETE VARIABLES reiskosten_tot_T1_mnd reiskosten_tot_T2_mnd reiskosten_tot_T3_mnd reiskosten_tot_T4_mnd.

COMPUTE reiskosten_tot_T1_T4=SUM(reiskosten_tot_T1, reiskosten_tot_T2, reiskosten_tot_T3, reiskosten_tot_T4).
COMPUTE reiskosten_tot_T1_T4_imp=SUM(reiskosten_tot_T1_imp , reiskosten_tot_T2_imp , reiskosten_tot_T3_imp , reiskosten_tot_T4_imp).
EXECUTE.
VARIABLE WIDTH reiskosten_tot_T1_T4 reiskosten_tot_T1_T4_imp (10).
VARIABLE LEVEL reiskosten_tot_T1_T4 reiskosten_tot_T1_T4_imp (SCALE).
VARIABLE LABELS reiskosten_tot_T1_T4 'tot reiskosten met missings (dus missing=0)' reiskosten_tot_T1_T4_imp 'tot reiskosten geïmputeerd'.


FREQUENCIES VARIABLES=Nmiss_reiskosten_tot_T1_T4
  /ORDER=ANALYSIS.
DESCRIPTIVES VARIABLES=reiskosten_tot_T1_T4 reiskosten_tot_T1_T4_imp
  /STATISTICS=MEAN STDDEV MIN MAX.

** outliers.
EXAMINE VARIABLES=reiskosten_tot_T1_T4 reiskosten_tot_T1_T4_imp 
  /COMPARE VARIABLE
  /PLOT=BOXPLOT
  /STATISTICS=NONE
  /NOTOTAL
  /ID=ID_code
  /MISSING=LISTWISE.


** KOSTEN PRODUCTIVITEIT********************************************************************************************************************************************************************************.

*** zie syntax 'kosten productiviteit'.

** KOSTEN INTERVENTIE ***********************************************************************************************************************************************************************************.

* kosten groepstraining.
COMPUTE Kosten_groepstraining=420.57.
EXECUTE.
VARIABLE LABELS Kosten_groepstraining 'kosten groepstraining incl reiskosten'.
VARIABLE WIDTH Kosten_groepstraining (11).

* kosten cadeaubonnen.
* verschilt per deelnemer, zijn gemerged uit ander bestand.

** kosten tijd interventie.
** = 7x90 min bijeenkomsten en 3x10 min CO2 meting = 660 min.
** Indien werktijd/vrije tijd.
COMPUTE Kosten_tijd_interventie_werktijd=660/60 * 35.33.
COMPUTE Kosten_tijd_interventie_vrijetijd=660/60 * 14.32.
EXECUTE.
VARIABLE WIDTH Kosten_tijd_interventie_werktijd Kosten_tijd_interventie_vrijetijd (9).
VARIABLE LABELS Kosten_tijd_interventie_werktijd 'kosten tijd besteed aan interventie indien in werktijd' Kosten_tijd_interventie_vrijetijd 'kosten tijd besteed aan interventie indien vrije tijd'.

COMPUTE Kosten_intervention_total_T1_T4=SUM(Kosten_groepstraining, kosten_cadeaubonnen,Kosten_tijd_interventie_werktijd).
EXECUTE.
VARIABLE LABELS Kosten_intervention_total_T1_T4 'kosten groepstraining, cadeaubonnen en tijd'.

** TOTALE KOSTEN T1_T4 ***********************************************************************************************************************************************************************************.


** Kosten hospital.
**(poli, dagbehandeling, opnames (ziekenhuis, revalidatie, psychiatrie), EHBO, ambulance). 

COMPUTE Kosten_hospital_T1_T4=SUM(Kosten_poli_T1_T4, Kosten_dagbeh_tot_T1_T4, Kosten_opname_tot_T1_T4, Kosten_ehbo_T1_T4, Kosten_ambulance_T1_T4).
COMPUTE Kosten_hospital_T1_T4_imp=SUM(Kosten_poli_T1_T4_imp, Kosten_dagbeh_tot_T1_T4_imp, Kosten_opname_tot_T1_T4_imp, Kosten_ehbo_T1_T4_imp, Kosten_ambulance_T1_T4_imp).
EXECUTE.
VARIABLE LABELS Kosten_hospital_T1_T4 'tot kosten hospital met missings (dus missing=0)' kosten_hospital_T1_T4_imp 'tot kosten hospital geïmputeerd'.
VARIABLE WIDTH Kosten_hospital_T1_T4 Kosten_hospital_T1_T4_imp (12).

** kosten respondents .
** (reiskosten en kosten onbetaald werk).

COMPUTE kosten_respondents_tot_T1_T4= SUM (reiskosten_tot_T1_T4, Kosten_onbetaald_T1_T4).
COMPUTE kosten_respondents_tot_T1_T4_imp= SUM (reiskosten_tot_T1_T4_imp, Kosten_onbetaald_T1_T4_imp).
EXECUTE.
VARIABLE LABELS kosten_respondents_tot_T1_T4_imp 'kosten respondenten (reiskosten en ziekte mbt unpaid work)' 
kosten_respondents_tot_T1_T4 'kosten respondenten (reiskosten en ziekte mbt unpaid work) met misisngs'.
VARIABLE WIDTH kosten_respondents_tot_T1_T4 kosten_respondents_tot_T1_T4_imp (15).


** kosten health care.

COMPUTE Kosten_healthcare_total_T1_T4=SUM(Kosten_GP_T1_T4, Kosten_occ_pract_T1_T4, Kosten_stop_roken_begl_T2_T4, Kosten_other_care_T1_T4,
    Kosten_hospital_T1_T4, Kosten_thuiszorg_tot_T1_T4, Kosten_med_tot_T1_T4, Kosten_med_roken_T1_T4).
COMPUTE Kosten_healthcare_total_T1_T4_imp=SUM(Kosten_GP_T1_T4_imp,Kosten_occ_pract_T1_T4_imp,  Kosten_stop_roken_begl_T2_T4_imp, Kosten_other_care_T1_T4_imp,
    Kosten_hospital_T1_T4_imp,  Kosten_thuiszorg_tot_T1_T4_imp, Kosten_med_tot_T1_T4_imp,Kosten_med_roken_T1_T4_imp).
EXECUTE.
VARIABLE LABELS Kosten_healthcare_total_T1_T4_imp 'tot kosten healthcare (GP, occ pract, stoppen roken begl, other care, hospital, med, med roken) geïmputeerd'
Kosten_healthcare_total_T1_T4 'tot kosten healthcare (GP, occ pract, stoppen roken begl, other care, hospital, med, med roken) met missings'.
VARIABLE WIDTH Kosten_healthcare_total_T1_T4_imp Kosten_healthcare_total_T1_T4 (18).

** overall costs.

COMPUTE Kosten_total_overall_costs_T1_T4=SUM(kosten_intervention_total_T1_T4, Kosten_healthcare_total_T1_T4, kosten_respondents_tot_T1_T4,Kosten_productiviteit_tot_T1_T4).
COMPUTE Kosten_total_overall_costs_T1_T4_imp=SUM(kosten_intervention_total_T1_T4, Kosten_healthcare_total_T1_T4_imp, kosten_respondents_tot_T1_T4_imp,Kosten_productiviteit_tot_T1_T4_imp).
EXECUTE.
VARIABLE LABELS Kosten_total_overall_costs_T1_T4_imp 'tot kosten (healtcare, intervention, respondents, productiviteit) geïmputeerd'
Kosten_total_overall_costs_T1_T4 'tot kosten (healtcare, intervention, respondents, productiviteit) met missings'. 
VARIABLE WIDTH Kosten_total_overall_costs_T1_T4_imp Kosten_total_overall_costs_T1_T4 (20).

'********************************************************************************************************************************************************************************************************************.
'** T0**************************************************************************************************************************************************************************************************************.

RECODE ingevuld_T0 (0=0) (1=1) (2=1) INTO in_kostenanalyse_T0.
EXECUTE.

*Sommige deelnemers hebben de lijst weliswaar digitaal 'ingevuld', maar hebben alle kostenvragen overgeslagen.
* (sommige kosten zijn wel 0 omdat in de syntax er van uit wordt gegaan dat missing 0 is als de lijst wel gefinished is).
DO IF (ID_code=2611 or ID_code=3703 or ID_code=4703 or ID_code=3606 or ID_code=3506 or ID_code=5304 or ID_code=3704 or ID_code=3708 or ID_code=5708 or ID_code=5306).
COMPUTE  in_kostenanalyse_T0 = 0.
END IF.
EXECUTE.

VALUE LABELS in_kostenanalyse_T0 0 'kostenvragen T0 niet ingevuld' 1 'kostenvragen T0 wel ingevuld'.
FORMATS in_kostenanalyse_T0 (F1.0).
VARIABLE WIDTH in_kostenanalyse_T0 (11).

** TOTALE KOSTEN T0 ****************************************************************************************************************************************************************************************.

* Kosten op T0 worden niet geimputeerd. Somkosten vallen dus lager uit indien er missings zijn (missing=0).

** Kosten hospital.
**(poli, dagbehandeling, opnames (ziekenhuis, revalidatie, psychiatrie), EHBO, ambulance). 
COMPUTE Kosten_hospital_T0=SUM(Kosten_poli_T0, Kosten_dagbeh_tot_T0, Kosten_opname_tot_T0, Kosten_ehbo_T0, Kosten_ambulance_T0).
EXECUTE.
VARIABLE LABELS Kosten_hospital_T0 'tot kosten hospital met missings (dus missing=0)' .
VARIABLE WIDTH Kosten_hospital_T0 (12).

** kosten health care.
COMPUTE Kosten_healthcare_total_T0=SUM(Kosten_GP_T0, Kosten_occ_pract_T0, Kosten_stop_roken_begl_T0, Kosten_other_care_T0,
    Kosten_hospital_T0,  Kosten_thuiszorg_tot_T0, Kosten_med_tot_T0,Kosten_med_roken_T0).
EXECUTE.
VARIABLE LABELS Kosten_healthcare_total_T0 'tot kosten healthcare T0 (GP, occ pract, stoppen roken begl, other care, hospital, med, med roken) geïmputeerd'.
VARIABLE WIDTH Kosten_healthcare_total_T0 (12).

** kosten productiviteit tot .
DO IF (in_kostenanalyse_T0)=1.
COMPUTE Kosten_productiviteit_total_T0=SUM( Kosten_absenteisme_T0, kosten_presenteism_T0, kosten_pauze_T0).
END IF.
EXECUTE.
VARIABLE LABELS Kosten_productiviteit_total_T0 'tot kosten productiviteit (absenteisme, presenteisme en pauze)'.
VARIABLE WIDTH Kosten_productiviteit_total_T0 (12).

** kosten respondents .
** (reiskosten en kosten onbetaald werk).
COMPUTE kosten_respondents_total_T0= SUM (reiskosten_tot_T0, Kosten_onbetaald_T0).
EXECUTE.
VARIABLE LABELS kosten_respondents_total_T0 'tot kosten respondenten (reiskosten en ziekte mbt unpaid work)'.
VARIABLE WIDTH kosten_respondents_total_T0 (15).

** overall costs.
COMPUTE Kosten_total_overall_costs_T0=SUM(Kosten_healthcare_total_T0, kosten_respondents_total_T0, Kosten_productiviteit_tot_T0).
EXECUTE.
VARIABLE LABELS Kosten_total_overall_costs_T0 'tot kosten T0 (healtcare, intervention, reiskosten, productiviteit)'.













