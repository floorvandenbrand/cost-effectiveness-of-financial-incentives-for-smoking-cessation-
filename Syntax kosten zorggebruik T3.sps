* Encoding: UTF-8.



** Kosten consulten eerste lijn*************************************************************************************************************************************.
* tarieven dd 2017.
COMPUTE kosten_consult1_T3=consult1_T3*34.
COMPUTE kosten_consult2_T3=consult2_T3*17.
COMPUTE kosten_consult3_T3=consult3_T3*67.
COMPUTE kosten_consult4_T3=consult4_T3*105.
COMPUTE kosten_consult5_T3=consult5_T3*34.
COMPUTE kosten_consult6_T3=consult6_T3*31.
COMPUTE kosten_consult7_T3=consult7_T3*34.
COMPUTE kosten_consult8_T3=consult8_T3*20.
COMPUTE kosten_consult9_T3=consult9_T3*31.
COMPUTE kosten_consult10_T3=consult10_T3*45.
COMPUTE kosten_consult11_T3=consult11_T3*34.
COMPUTE kosten_consult12_T3=consult12_T3*65.
COMPUTE kosten_consult13_T3=consult13_T3*26.
COMPUTE kosten_consult14_T3=consult14_T3*24.
EXECUTE.

DO IF MISSING (consult1_T3)=1.
RECODE Kosten_consult1_T3 (SYSMIS=99999).
END IF.
DO IF MISSING (consult2_T3)=1.
RECODE Kosten_consult2_T3 (SYSMIS=99999).
END IF.
DO IF MISSING (consult3_T3)=1.
RECODE Kosten_consult3_T3 (SYSMIS=99999).
END IF.
DO IF MISSING (consult4_T3)=1.
RECODE Kosten_consult4_T3 (SYSMIS=99999).
END IF.
DO IF MISSING (consult5_T3)=1.
RECODE Kosten_consult5_T3 (SYSMIS=99999).
END IF.
DO IF MISSING (consult6_T3)=1.
RECODE Kosten_consult6_T3 (SYSMIS=99999).
END IF.
DO IF MISSING (consult7_T3)=1.
RECODE Kosten_consult7_T3 (SYSMIS=99999).
END IF.
DO IF MISSING (consult8_T3)=1.
RECODE Kosten_consult8_T3 (SYSMIS=99999).
END IF.
DO IF MISSING (consult9_T3)=1.
RECODE Kosten_consult9_T3 (SYSMIS=99999).
END IF.
DO IF MISSING (consult10_T3)=1.
RECODE Kosten_consult10_T3 (SYSMIS=99999).
END IF.
DO IF MISSING (consult11_T3)=1.
RECODE Kosten_consult11_T3 (SYSMIS=99999).
END IF.
DO IF MISSING (consult12_T3)=1.
RECODE Kosten_consult12_T3 (SYSMIS=99999).
END IF.
DO IF MISSING (consult13_T3)=1.
RECODE Kosten_consult13_T3 (SYSMIS=99999).
END IF.
DO IF MISSING (consult14_T3)=1.
RECODE Kosten_consult14_T3 (SYSMIS=99999).
END IF.
EXECUTE.
MISSING VALUES kosten_consult1_T3   kosten_consult2_T3  kosten_consult3_T3  kosten_consult4_T3  kosten_consult5_T3  kosten_consult6_T3 
 kosten_consult7_T3  kosten_consult8_T3  kosten_consult9_T3  kosten_consult10_T3  kosten_consult11_T3  kosten_consult12_T3 
 kosten_consult13_T3  kosten_consult14_T3 (99999).

VARIABLE LEVEL  kosten_consult1_T3   kosten_consult2_T3  kosten_consult3_T3  kosten_consult4_T3  kosten_consult5_T3  kosten_consult6_T3 
 kosten_consult7_T3  kosten_consult8_T3  kosten_consult9_T3  kosten_consult10_T3  kosten_consult11_T3  kosten_consult12_T3 
 kosten_consult13_T3  kosten_consult14_T3  (SCALE).
VARIABLE WIDTH  kosten_consult1_T3   kosten_consult2_T3  kosten_consult3_T3  kosten_consult4_T3  kosten_consult5_T3  kosten_consult6_T3 
 kosten_consult7_T3  kosten_consult8_T3  kosten_consult9_T3  kosten_consult10_T3  kosten_consult11_T3  kosten_consult12_T3 
 kosten_consult13_T3  kosten_consult14_T3  (9).


COMPUTE kosten_GP_T3=kosten_consulT3_T3.
COMPUTE kosten_occ_pract_T3=kosten_consult4_T3.
COMPUTE kosten_stop_roken_begl_T3=kosten_consult7_T3.
COMPUTE kosten_other_care_T3=SUM(kosten_consult2_T3,kosten_consult3_T3,kosten_consult5_T3, kosten_consult6_T3, kosten_consult8_T3,  
kosten_consult9_T3, kosten_consult10_T3,kosten_consult11_T3,kosten_consult12_T3,kosten_consult13_T3, kosten_consult14_T3).
EXECUTE.

RECODE kosten_GP_T3 kosten_occ_pract_T3 kosten_stop_roken_begl_T3 kosten_other_care_T3 (SYSMIS=99999).
EXECUTE.
MISSING VALUES kosten_GP_T3 kosten_occ_pract_T3 kosten_stop_roken_begl_T3 kosten_other_care_T3 (99999).
VARIABLE WIDTH  kosten_GP_T3 kosten_occ_pract_T3 kosten_stop_roken_begl_T3 kosten_other_care_T3 (10).
VARIABLE LEVEL  kosten_GP_T3 kosten_occ_pract_T3 kosten_stop_roken_begl_T3 kosten_other_care_T3(SCALE).

VARIABLE LABELS kosten_GP_T3 'kosten GP T3' kosten_occ_pract_T3 'kosten occupational practitioner T3' 
kosten_stop_roken_begl_T3 'kosten stoppen met roken begeleiding consulten T3' kosten_other_care_T3 'kosten other care consults T3'.

***Kosten thuiszorg ***********************************************************************************************************************************************.
* dd 2017.
COMPUTE kosten_thuiszorg_hh_T3= thuiszorg_hh_weken_T3 * thuiszorg_hh_uur_T3 * 20.
COMPUTE kosten_thuiszorg_verzorging_T3= thuiszorg_verzorging_weken_T3 * thuiszorg_verzorging_uur_T3 * 51.
COMPUTE kosten_thuiszorg_verpleging_T3= thuiszorg_verpleging_weken_T3 * thuiszorg_verpleging_uur_T3 * 75.
COMPUTE kosten_thuiszorg_tot_T3=SUM (kosten_thuiszorg_HH_T3,kosten_thuiszorg_verzorging_T3,kosten_thuiszorg_verpleging_T3).
EXECUTE.

DO IF MISSING(thuiszorg_T3)=1.
RECODE kosten_thuiszorg_HH_T3,kosten_thuiszorg_verzorging_T3,kosten_thuiszorg_verpleging_T3 kosten_thuiszorg_tot_T3 (SYSMIS=99999).
END IF.
EXECUTE.
MISSING VALUES kosten_thuiszorg_HH_T3,kosten_thuiszorg_verzorging_T3,kosten_thuiszorg_verpleging_T3 kosten_thuiszorg_tot_T3 (99999).
VARIABLE WIDTH kosten_thuiszorg_HH_T3,kosten_thuiszorg_verzorging_T3,kosten_thuiszorg_verpleging_T3 kosten_thuiszorg_tot_T3 (10).
VARIABLE LEVEL kosten_thuiszorg_HH_T3,kosten_thuiszorg_verzorging_T3,kosten_thuiszorg_verpleging_T3 kosten_thuiszorg_tot_T3 (SCALE).

***Kosten medicatie***********************************************************************************************************************************************.
zie aparte syntax.

***Kosten EHBO***********************************************************************************************************************************************.
* dd 2017.
COMPUTE kosten_ehbo_T3=EHBO_T3* EHBO_aant_keer_T3*265.

DO IF MISSING (EHBO_T3)=1.
RECODE Kosten_ehbo_T3 (SYSMIS=99999).
END IF.
EXECUTE.
MISSING VALUES kosten_ehbo_T3 (99999).
VARIABLE LEVEL kosten_ehbo_T3 (SCALE).
VARIABLE WIDTH kosten_ehbo_T3 (7).

***Kosten ambulance***********************************************************************************************************************************************.
* 2017.
COMPUTE kosten_ambulance_T3=ambulance_T3* ambulance_aant_keer_T3*527.

DO IF MISSING (ambulance_T3)=1.
RECODE Kosten_ambulance_T3 (SYSMIS=99999).
END IF.
EXECUTE.
MISSING VALUES kosten_ambulance_T3 (99999).
VARIABLE LEVEL kosten_ambulance_T3 (SCALE).
VARIABLE WIDTH kosten_ambulance_T3 (7).

***Kosten polibezoek***********************************************************************************************************************************************.

** aanpassingen van polibezoeken die hier niet worden gemeld maar wel bij dagbehandeling.
DO IF ID_Code=1202.
RECODE Poli_T3 (1=2).
RECODE Ziekenhuis1_T3 (''='onbekend'). 
RECODE ZH1_type_T3 (SYSMIS=2).
RECODE Specialisme1_T3 (''='onbekend').
RECODE Spec1_aant_keer_T3  (SYSMIS=2).
RECODE dagbehandeling_T3 (2=1).
RECODE dagbehandeling1_T3 ('rug/heup'='').
RECODE dagbehandeling1_aant_keer_T3 (2=SYSMIS).
END IF.

DO IF ID_Code=1816.
RECODE Poli_T3 (1=2).
RECODE Ziekenhuis1_T3 (''='onbekend'). 
RECODE ZH1_type_T3 (SYSMIS=2).
RECODE Specialisme1_T3 (''='KNO').
RECODE Spec1_aant_keer_T3  (SYSMIS=1).
RECODE dagbehandeling_T3 (2=1).
RECODE dagbehandeling1_T3 ('KNO arts'='').
RECODE dagbehandeling1_aant_keer_T3 (1=SYSMIS).
END IF.

DO IF ID_Code=3110.
RECODE Poli_T3 (1=2).
RECODE Ziekenhuis1_T3 (''='onbekend'). 
RECODE ZH1_type_T3 (SYSMIS=2).
RECODE Specialisme1_T3 (''='onbekend').
RECODE Spec1_aant_keer_T3  (SYSMIS=2).
RECODE dagbehandeling_T3 (2=1).
RECODE dagbehandeling1_T3 ('nekhernia'='').
RECODE dagbehandeling1_aant_keer_T3 (2=SYSMIS).
END IF.
EXECUTE.

DO IF ID_Code=4008.
RECODE Poli_T3 (1=2).
RECODE Ziekenhuis1_T3 (''='onbekend'). 
RECODE ZH1_type_T3 (SYSMIS=2).
RECODE Specialisme1_T3 (''='Oogarts').
RECODE Spec1_aant_keer_T3  (SYSMIS=3).
RECODE dagbehandeling_T3 (2=1).
RECODE dagbehandeling1_T3 ('oogonsteking'='').
RECODE dagbehandeling1_aant_keer_T3 (3=SYSMIS).
END IF.
EXECUTE.

DO IF ID_Code=5114.
RECODE Poli_T3 (1=2).
RECODE Ziekenhuis1_T3 (''='onbekend'). 
RECODE ZH1_type_T3 (SYSMIS=2).
RECODE Specialisme1_T3 (''='onbekend').
RECODE Spec1_aant_keer_T3  (SYSMIS=2).
RECODE dagbehandeling_T3 (2=1).
RECODE dagbehandeling1_T3 ('hernia'='').
RECODE dagbehandeling1_aant_keer_T3 (2=SYSMIS).
END IF.
EXECUTE.

DO IF ID_Code=7002.
RECODE Poli_T3 (1=2).
RECODE Ziekenhuis1_T3 (''='onbekend'). 
RECODE ZH1_type_T3 (SYSMIS=2).
RECODE Specialisme1_T3 (''='onbekend').
RECODE Spec1_aant_keer_T3  (SYSMIS=3).
RECODE dagbehandeling_T3 (2=1).
RECODE dagbehandeling1_T3 ('LUPUS'='').
RECODE dagbehandeling1_aant_keer_T3 (3=SYSMIS).
END IF.
EXECUTE.

* tarieven 2017.
RECODE ZH1_type_T3 ZH2_type_T3 ZH3_type_T3 ZH4_type_T3 (1=167) (2=82) INTO Kosten_per_polibezoek1_temp Kosten_per_polibezoek2_temp 
Kosten_per_polibezoek3_temp Kosten_per_polibezoek4_temp.
EXECUTE.

COMPUTE kosten1_temp=Kosten_per_polibezoek1_temp * spec1_aant_keer_T3.
COMPUTE kosten2_temp=Kosten_per_polibezoek2_temp * spec2_aant_keer_T3.
COMPUTE kosten3_temp=Kosten_per_polibezoek3_temp * spec3_aant_keer_T3.
COMPUTE kosten4_temp=Kosten_per_polibezoek4_temp * spec4_aant_keer_T3.
COMPUTE kosten_poli_T3=SUM(kosten1_temp,kosten2_temp,kosten3_temp,kosten4_temp).
EXECUTE.

DELETE VARIABLES  Kosten_per_polibezoek1_temp Kosten_per_polibezoek2_temp 
Kosten_per_polibezoek3_temp Kosten_per_polibezoek4_temp kosten1_temp kosten2_temp kosten3_temp kosten4_temp.

DO IF MISSING (Poli_T3)=1.
RECODE kosten_poli_T3 (SYSMIS=99999).
END IF.
DO IF Poli_T3=1.
RECODE kosten_poli_T3 (SYSMIS=0).
END IF.
EXECUTE.
MISSING VALUES kosten_poli_T3 (99999).
VARIABLE WIDTH kosten_poli_T3 (7).

*** Kosten dagbehandeling********************************************************************************************************************************************.
** omvat ook diagnostiek.

IF  (ID_code=1107 and Dagbehandeling1_T3='MRI Hart') kosten_dagbeh1_T3=0.
IF  (ID_code=1107 and Dagbehandeling2_T3='MRI Longen') kosten_dagbeh2_T3=0.
IF  (ID_code=1107 and Dagbehandeling3_T3='Longtest') kosten_dagbeh3_T3=0.
IF  (ID_code=1107 and Dagbehandeling4_T3='Histamietest') kosten_dagbeh4_T3=0.
IF  (ID_code=1107 and Dagbehandeling5_T3='Slaapapneu') kosten_dagbeh5_T3=167.12.
IF  (ID_code=1107 and Dagbehandeling6_T3='Knieoperatie') kosten_dagbeh6_T3=2590.59.
IF  (ID_code=1110 and Dagbehandeling1_T3='Rontgenfoto + echo li pols peesontsteking') kosten_dagbeh1_T3=208.08.
IF  (ID_code=1208 and Dagbehandeling1_T3='zometa infuus') kosten_dagbeh1_T3=167.01.
IF  (ID_code=1508 and Dagbehandeling1_T3='tegen cluster hoofdpijn') kosten_dagbeh1_T3=1019.65.
IF  (ID_code=1909 and Dagbehandeling1_T3='rontgen') kosten_dagbeh1_T3=112.24.
IF  (ID_code=1914 and Dagbehandeling1_T3='Longfoto') kosten_dagbeh1_T3=103.05.
IF  (ID_code=1916 and Dagbehandeling1_T3='Echo') kosten_dagbeh1_T3=95.84.
IF  (ID_code=1916 and Dagbehandeling2_T3='Scan') kosten_dagbeh2_T3=139.00.
IF  (ID_code=2302 and Dagbehandeling1_T3='Kneuzing') kosten_dagbeh1_T3=0.
IF  (ID_code=2502 and Dagbehandeling1_T3='Operatie') kosten_dagbeh1_T3=0.
IF  (ID_code=2504 and Dagbehandeling1_T3='Mri bijholte') kosten_dagbeh1_T3=241.10.
IF  (ID_code=2504 and Dagbehandeling2_T3='Onderzoek biiholte') kosten_dagbeh2_T3=0.
IF  (ID_code=2904 and Dagbehandeling1_T3='Orthopedie') kosten_dagbeh1_T3=0.
IF  (ID_code=3008 and Dagbehandeling1_T3='snijden van stuk huid') kosten_dagbeh1_T3=450.60.
IF  (ID_code=3105 and Dagbehandeling1_T3='wondbehandeling') kosten_dagbeh1_T3=0.
IF  (ID_code=3105 and Dagbehandeling2_T3='controle heup breuk') kosten_dagbeh2_T3=0.
IF  (ID_code=3105 and Dagbehandeling3_T3='Controle dystrofie') kosten_dagbeh3_T3=0.
IF  (ID_code=3110 and Dagbehandeling1_T3='nekhernia') kosten_dagbeh1_T3=0.
IF  (ID_code=3219 and Dagbehandeling1_T3='Endoscopie onderzoek') kosten_dagbeh1_T3=261.45.
IF  (ID_code=3305 and Dagbehandeling1_T3='Consult') kosten_dagbeh1_T3=0.
IF  (ID_code=3308 and Dagbehandeling1_T3='vaten in kuit') kosten_dagbeh1_T3=0.
IF  (ID_code=4802 and Dagbehandeling1_T3='korte slaaponderzoek') kosten_dagbeh1_T3=167.12.
IF  (ID_code=4802 and Dagbehandeling2_T3='Barbotage schouders') kosten_dagbeh2_T3=134.63.
IF  (ID_code=4802 and Dagbehandeling3_T3='MRI - knieen') kosten_dagbeh1_T3=239.23.
IF  (ID_code=4802 and Dagbehandeling4_T3='echo van de schouders') kosten_dagbeh4_T3=80.33.
IF  (ID_code=4803 and Dagbehandeling1_T3='botuline injectie') kosten_dagbeh1_T3=0.
IF  (ID_code=5106 and Dagbehandeling1_T3='Keloid') kosten_dagbeh1_T3=0.
IF  (ID_code=5206 and Dagbehandeling1_T3='lichamelijke checque up') kosten_dagbeh1_T3=0.
IF  (ID_code=5606 and Dagbehandeling1_T3='controle') kosten_dagbeh1_T3=0.
IF  (ID_code=5816) kosten_dagbeh1_T3=112.24.
IF  (ID_code=6209 and Dagbehandeling1_T3='liscexisie') kosten_dagbeh1_T3=1218.38.
IF  (ID_code=6302 and Dagbehandeling1_T3='slaapapneu') kosten_dagbeh1_T3=167.12.
IF  (ID_code=6404 and Dagbehandeling1_T3='Kijkje in de blaas') kosten_dagbeh1_T3=600.
IF  (ID_code=6408 and Dagbehandeling1_T3='hernia') kosten_dagbeh1_T3=0.
IF  (ID_code=6412 and Dagbehandeling1_T3='Scan met vloeistof') kosten_dagbeh1_T3=241.10.
IF  (ID_code=6501 and Dagbehandeling1_T3='Foto') kosten_dagbeh1_T3=112.24.
IF  (ID_code=6501 and Dagbehandeling2_T3='Mri scan') kosten_dagbeh2_T3=241.10.
IF  (ID_code=7007 and Dagbehandeling1_T3='Orthopeed') kosten_dagbeh1_T3=0.
EXECUTE.

VARIABLE WIDTH Dagbehandeling1_T3 Dagbehandeling2_T3 Dagbehandeling3_T3 Dagbehandeling4_T3 Dagbehandeling5_T3 Dagbehandeling6_T3 (20).
VARIABLE WIDTH kosten_dagbeh1_T3 kosten_dagbeh2_T3 kosten_dagbeh3_T3 kosten_dagbeh4_T3 kosten_dagbeh5_T3 kosten_dagbeh6_T3 (7).
VARIABLE WIDTH Dagbehandeling1_aant_keer_T3 Dagbehandeling2_aant_keer_T3 Dagbehandeling3_aant_keer_T3 Dagbehandeling4_aant_keer_T3 Dagbehandeling5_aant_keer_T3
Dagbehandeling6_aant_keer_T3 (12).

 * inclusief correctie voor 2018: +1.4%.
COMPUTE kosten_dagbeh1_tot_T3=((kosten_dagbeh1_T3 * Dagbehandeling1_aant_keer_T3)/100)*101.4.
COMPUTE kosten_dagbeh2_tot_T3=((kosten_dagbeh2_T3 * Dagbehandeling2_aant_keer_T3)/100)*101.4.
COMPUTE kosten_dagbeh3_tot_T3=((kosten_dagbeh3_T3 * Dagbehandeling3_aant_keer_T3)/100)*101.4.
COMPUTE kosten_dagbeh4_tot_T3=((kosten_dagbeh4_T3 * Dagbehandeling4_aant_keer_T3)/100)*101.4.
COMPUTE kosten_dagbeh5_tot_T3=((kosten_dagbeh5_T3 * Dagbehandeling5_aant_keer_T3)/100)*101.4.
COMPUTE kosten_dagbeh6_tot_T3=((kosten_dagbeh6_T3 * Dagbehandeling6_aant_keer_T3)/100)*101.4.
EXECUTE.
COMPUTE kosten_dagbeh_tot_T3=SUM(kosten_dagbeh1_tot_T3,kosten_dagbeh2_tot_T3,kosten_dagbeh3_tot_T3,kosten_dagbeh4_tot_T3,kosten_dagbeh5_tot_T3,kosten_dagbeh6_tot_T3).
EXECUTE.

DO IF MISSING(dagbehandeling_T3)=1.
RECODE kosten_dagbeh_tot_T3 (SYSMIS=99999).
END IF.
EXECUTE.
DO IF dagbehandeling_T3=1.
RECODE kosten_dagbeh_tot_T3 (SYSMIS=0).
END IF.
EXECUTE.
MISSING VALUES kosten_dagbeh_tot_T3 (99999).
VARIABLE WIDTH kosten_dagbeh_tot_T3 (9).

DELETE VARIABLES kosten_dagbeh1_tot_T3,kosten_dagbeh2_tot_T3,kosten_dagbeh3_tot_T3,kosten_dagbeh4_tot_T3,kosten_dagbeh5_tot_T3,kosten_dagbeh6_tot_T3.

** Kosten opname**********************************************************************************************************************************************************************


* tarieven 2017.
COMPUTE kosten_opname_ZH_T3=487*opname_ZH_aant_dagen_T3.
COMPUTE kosten_opname_rev_T3=471*opname_rev_aant_dagen_T3.
COMPUTE kosten_opname_psy_T3=309*opname_psy_aant_dagen_T3.
EXECUTE.

DO IF MISSING(opname_ZH_T3)=1.
RECODE kosten_opname_ZH_T3 (SYSMIS=99999).
END IF.
DO IF MISSING(opname_rev_T3)=1.
RECODE kosten_opname_rev_T3 (SYSMIS=99999).
END IF.
DO IF MISSING(opname_psy_T3)=1.
RECODE kosten_opname_psy_T3 (SYSMIS=99999).
END IF.
EXECUTE.

DO IF opname_ZH_T3=2.
RECODE kosten_opname_ZH_T3 (SYSMIS=0).
END IF.
DO IF opname_rev_T3=2.
RECODE kosten_opname_rev_T3 (SYSMIS=0).
END IF.
DO IF opname_psy_T3=2.
RECODE kosten_opname_psy_T3 (SYSMIS=0).
END IF.
EXECUTE.

MISSING VALUES kosten_opname_ZH_T3  kosten_opname_rev_T3  kosten_opname_psy_T3 (99999).
VARIABLE LEVEL kosten_opname_ZH_T3  kosten_opname_rev_T3  kosten_opname_psy_T3 (SCALE).
VARIABLE WIDTH kosten_opname_ZH_T3  kosten_opname_rev_T3  kosten_opname_psy_T3 (11).

COMPUTE kosten_opname_tot_T3=SUM (kosten_opname_ZH_T3,kosten_opname_rev_T3,kosten_opname_psy_T3).
EXECUTE.
RECODE kosten_opname_tot_T3 (SYSMIS=99999).
EXECUTE.

MISSING VALUES kosten_opname_tot_T3 (99999).
VARIABLE LEVEL kosten_opname_tot_T3 (SCALE).
VARIABLE WIDTH kosten_opname_tot_T3 (11).


** reiskosten**************************************************************************************************************************************************************************************.

** HA en POH: 1,1 km per bezoek x 0.19 + 3.07 parkeerkosten.
COMPUTE temp_aant_HA_POH= SUM(consult1_T3, consult2_T3).
COMPUTE reiskosten_HA_POH_T3= (temp_aant_HA_POH * 1.1 * 0.19) + (temp_aant_HA_POH * 3.07).
EXECUTE.
RECODE reiskosten_HA_POH_T3 (SYSMIS=99999).
EXECUTE.
DELETE VARIABLES temp_aant_HA_POH.
VARIABLE LABELS reiskosten_HA_POH_T3 'reiskosten HA en POH'.

** Fysio en overige paramedische consulten: 2,3 km per bezoek x 0.19 + 3.07 parkeerkosten.
COMPUTE temp_aant_param= SUM(consult3_T3, consult4_T3, consult5_T3, consult6_T3, consult7_T3, consult8_T3, consult9_T3, consult10_T3, consult11_T3, consult12_T3, consult13_T3, consult14_T3).
COMPUTE reiskosten_param_T3= (temp_aant_param * 2.2 * 0.19) + (temp_aant_param * 3.07).
EXECUTE.
RECODE reiskosten_param_T3 (SYSMIS=99999).
EXECUTE.
DELETE VARIABLES temp_aant_param.
VARIABLE LABELS reiskosten_param_T3 'reiskosten alle paramediche consulten'.

** Per polibezoek,  per dagbehandeling en per EHBO 7,0 km per bezoek x 0.19 + 3.07 parkeerkosten.
COMPUTE temp_aant_ZH= SUM( EHBO_aant_keer_T3,  spec1_aant_keer_T3,  spec2_aant_keer_T3,  spec3_aant_keer_T3,  spec4_aant_keer_T3,  spec5_aant_keer_T3,
Dagbehandeling1_aant_keer_T3,  Dagbehandeling2_aant_keer_T3, Dagbehandeling3_aant_keer_T3, Dagbehandeling4_aant_keer_T3, Dagbehandeling5_aant_keer_T3, Dagbehandeling6_aant_keer_T3).
COMPUTE reiskosten_ZH_T3= (temp_aant_ZH * 7.0 * 0.19) + (temp_aant_ZH * 3.07).
EXECUTE.
RECODE reiskosten_ZH_T3 (SYSMIS=99999).
EXECUTE.
DELETE VARIABLES temp_aant_ZH.
VARIABLE LABELS reiskosten_ZH_T3 'reiskosten EHBO, poli en dagbehandeling'.

* Apotheek: indien medicatie gebruikt: 1 apotheekbezoek per vragenlijst rekenen.
DO IF medicatie_T3=2.
COMPUTE reiskosten_apo_T3= (1.3 * 0.19) + 3.07.
END IF.
DO IF medicatie_T3=1.
COMPUTE reiskosten_apo_T3= 0.
END IF.
RECODE reiskosten_apo_T3 (SYSMIS=99999).
EXECUTE.
VARIABLE LABELS reiskosten_apo_T3 'reiskosten apotheek'.

MISSING VALUES  reiskosten_HA_POH_T3 reiskosten_param_T3 reiskosten_ZH_T3 reiskosten_apo_T3 (99999).

*** Totale reiskosten.
COMPUTE reiskosten_tot_T3 = SUM (reiskosten_HA_POH_T3, reiskosten_param_T3, reiskosten_ZH_T3, reiskosten_apo_T3).
EXECUTE.
RECODE reiskosten_tot_T3 (SYSMIS=99999).
EXECUTE.

** indien verkorte lijst ingevuld: reiskosten zijn missing (soms staan er toch kosten vanwege stoppen met roken begeleiding en medicatie, wat wel gevraagd is).
IF (papier_T3=2) reiskosten_HA_POH_T3=99999.
IF (papier_T3=2) reiskosten_param_T3=99999.
IF (papier_T3=2) reiskosten_ZH_T3=99999.
IF (papier_T3=2) reiskosten_apo_T3=99999.
IF (papier_T3=2) reiskosten_tot_T3=99999.
EXECUTE.


VARIABLE WIDTH reiskosten_HA_POH_T3 reiskosten_param_T3 reiskosten_ZH_T3 reiskosten_apo_T3 reiskosten_tot_T3 (9).
VARIABLE LEVEL reiskosten_HA_POH_T3 reiskosten_param_T3 reiskosten_ZH_T3 reiskosten_apo_T3 reiskosten_tot_T3 (SCALE).
MISSING VALUES reiskosten_tot_T3 (99999).


