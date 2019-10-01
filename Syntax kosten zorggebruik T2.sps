* Encoding: UTF-8.



** Kosten consulten eerste lijn*************************************************************************************************************************************.
* tarieven dd 2017.
COMPUTE kosten_consult1_T2=consult1_T2*34.
COMPUTE kosten_consult2_T2=consult2_T2*17.
COMPUTE kosten_consult3_T2=consult3_T2*67.
COMPUTE kosten_consult4_T2=consult4_T2*105.
COMPUTE kosten_consult5_T2=consult5_T2*34.
COMPUTE kosten_consult6_T2=consult6_T2*31.
COMPUTE kosten_consult7_T2=consult7_T2*34.
COMPUTE kosten_consult8_T2=consult8_T2*20.
COMPUTE kosten_consult9_T2=consult9_T2*31.
COMPUTE kosten_consult10_T2=consult10_T2*45.
COMPUTE kosten_consult11_T2=consult11_T2*34.
COMPUTE kosten_consult12_T2=consult12_T2*65.
COMPUTE kosten_consult13_T2=consult13_T2*26.
COMPUTE kosten_consult14_T2=consult14_T2*24.
EXECUTE.

DO IF MISSING (consult1_T2)=1.
RECODE Kosten_consult1_T2 (SYSMIS=99999).
END IF.
DO IF MISSING (consult2_T2)=1.
RECODE Kosten_consult2_T2 (SYSMIS=99999).
END IF.
DO IF MISSING (consult3_T2)=1.
RECODE Kosten_consult3_T2 (SYSMIS=99999).
END IF.
DO IF MISSING (consult4_T2)=1.
RECODE Kosten_consult4_T2 (SYSMIS=99999).
END IF.
DO IF MISSING (consult5_T2)=1.
RECODE Kosten_consult5_T2 (SYSMIS=99999).
END IF.
DO IF MISSING (consult6_T2)=1.
RECODE Kosten_consult6_T2 (SYSMIS=99999).
END IF.
DO IF MISSING (consult7_T2)=1.
RECODE Kosten_consult7_T2 (SYSMIS=99999).
END IF.
DO IF MISSING (consult8_T2)=1.
RECODE Kosten_consult8_T2 (SYSMIS=99999).
END IF.
DO IF MISSING (consult9_T2)=1.
RECODE Kosten_consult9_T2 (SYSMIS=99999).
END IF.
DO IF MISSING (consult10_T2)=1.
RECODE Kosten_consult10_T2 (SYSMIS=99999).
END IF.
DO IF MISSING (consult11_T2)=1.
RECODE Kosten_consult11_T2 (SYSMIS=99999).
END IF.
DO IF MISSING (consult12_T2)=1.
RECODE Kosten_consult12_T2 (SYSMIS=99999).
END IF.
DO IF MISSING (consult13_T2)=1.
RECODE Kosten_consult13_T2 (SYSMIS=99999).
END IF.
DO IF MISSING (consult14_T2)=1.
RECODE Kosten_consult14_T2 (SYSMIS=99999).
END IF.
EXECUTE.
MISSING VALUES kosten_consult1_T2   kosten_consult2_T2  kosten_consult3_T2  kosten_consult4_T2  kosten_consult5_T2  kosten_consult6_T2 
 kosten_consult7_T2  kosten_consult8_T2  kosten_consult9_T2  kosten_consult10_T2  kosten_consult11_T2  kosten_consult12_T2 
 kosten_consult13_T2  kosten_consult14_T2 (99999).

VARIABLE LEVEL  kosten_consult1_T2   kosten_consult2_T2  kosten_consult3_T2  kosten_consult4_T2  kosten_consult5_T2  kosten_consult6_T2 
 kosten_consult7_T2  kosten_consult8_T2  kosten_consult9_T2  kosten_consult10_T2  kosten_consult11_T2  kosten_consult12_T2 
 kosten_consult13_T2  kosten_consult14_T2  (SCALE).
VARIABLE WIDTH  kosten_consult1_T2   kosten_consult2_T2  kosten_consult3_T2  kosten_consult4_T2  kosten_consult5_T2  kosten_consult6_T2 
 kosten_consult7_T2  kosten_consult8_T2  kosten_consult9_T2  kosten_consult10_T2  kosten_consult11_T2  kosten_consult12_T2 
 kosten_consult13_T2  kosten_consult14_T2  (9).

COMPUTE kosten_GP_T2=kosten_consulT2_T2.
COMPUTE kosten_occ_pract_T2=kosten_consult4_T2.
COMPUTE kosten_stop_roken_begl_T2=kosten_consult7_T2.
COMPUTE kosten_other_care_T2=SUM(kosten_consult2_T2,kosten_consult3_T2,kosten_consult5_T2, kosten_consult6_T2, kosten_consult8_T2,  
kosten_consult9_T2, kosten_consulT10_T2,kosten_consulT11_T2,kosten_consulT12_T2,kosten_consulT13_T2, kosten_consulT14_T2).
EXECUTE.

RECODE kosten_GP_T2 kosten_occ_pract_T2 kosten_stop_roken_begl_T2 kosten_other_care_T2 (SYSMIS=99999).
EXECUTE.
MISSING VALUES kosten_GP_T2 kosten_occ_pract_T2 kosten_stop_roken_begl_T2 kosten_other_care_T2 (99999).
VARIABLE WIDTH  kosten_GP_T2 kosten_occ_pract_T2 kosten_stop_roken_begl_T2 kosten_other_care_T2 (10).
VARIABLE LEVEL  kosten_GP_T2 kosten_occ_pract_T2 kosten_stop_roken_begl_T2 kosten_other_care_T2(SCALE).

VARIABLE LABELS kosten_GP_T2 'kosten GP T2' kosten_occ_pract_T2 'kosten occupational practitioner T2' 
kosten_stop_roken_begl_T2 'kosten stoppen met roken begeleiding consulten T2' kosten_other_care_T2 'kosten other care consults T2'.


***Kosten thuiszorg ***********************************************************************************************************************************************.
* dd 2017.
COMPUTE kosten_thuiszorg_hh_T2= thuiszorg_hh_weken_T2 * thuiszorg_hh_uur_T2 * 20.
COMPUTE kosten_thuiszorg_verzorging_T2= thuiszorg_verzorging_weken_T2 * thuiszorg_verzorging_uur_T2 * 51.
COMPUTE kosten_thuiszorg_verpleging_T2= thuiszorg_verpleging_weken_T2 * thuiszorg_verpleging_uur_T2 * 75.
COMPUTE kosten_thuiszorg_tot_T2=SUM (kosten_thuiszorg_HH_T2,kosten_thuiszorg_verzorging_T2,kosten_thuiszorg_verpleging_T2).
EXECUTE.

DO IF MISSING(thuiszorg_T2)=1.
RECODE kosten_thuiszorg_HH_T2,kosten_thuiszorg_verzorging_T2,kosten_thuiszorg_verpleging_T2 kosten_thuiszorg_tot_T2 (SYSMIS=99999).
END IF.
EXECUTE.
MISSING VALUES kosten_thuiszorg_HH_T2,kosten_thuiszorg_verzorging_T2,kosten_thuiszorg_verpleging_T2 kosten_thuiszorg_tot_T2 (99999).
VARIABLE WIDTH kosten_thuiszorg_HH_T2,kosten_thuiszorg_verzorging_T2,kosten_thuiszorg_verpleging_T2 kosten_thuiszorg_tot_T2 (10).
VARIABLE LEVEL kosten_thuiszorg_HH_T2,kosten_thuiszorg_verzorging_T2,kosten_thuiszorg_verpleging_T2 kosten_thuiszorg_tot_T2 (SCALE).

***Kosten medicatie***********************************************************************************************************************************************.
zie aparte syntax.

***Kosten EHBO***********************************************************************************************************************************************.
* dd 2017.
COMPUTE kosten_ehbo_T2=EHBO_T2* EHBO_aant_keer_T2*265.

DO IF MISSING (EHBO_T2)=1.
RECODE Kosten_ehbo_T2 (SYSMIS=99999).
END IF.
EXECUTE.
MISSING VALUES kosten_ehbo_T2 (99999).
VARIABLE LEVEL kosten_ehbo_T2 (SCALE).
VARIABLE WIDTH kosten_ehbo_T2 (7).

***Kosten ambulance***********************************************************************************************************************************************.
* dd 2017.
COMPUTE kosten_ambulance_T2=ambulance_T2* ambulance_aant_keer_T2*527.

DO IF MISSING (ambulance_T2)=1.
RECODE Kosten_ambulance_T2 (SYSMIS=99999).
END IF.
EXECUTE.
MISSING VALUES kosten_ambulance_T2 (99999).
VARIABLE LEVEL kosten_ambulance_T2 (SCALE).
VARIABLE WIDTH kosten_ambulance_T2 (7).
***Kosten polibezoek***********************************************************************************************************************************************.

** aanpassingen van polibezoeken die hier niet worden gemeld maar wel bij dagbehandeling.
DO IF ID_Code=1202.
RECODE Poli_T2 (1=2).
RECODE Ziekenhuis1_T2 (''='onbekend'). 
RECODE ZH1_type_T2 (SYSMIS=2).
RECODE Specialisme1_T2 (''='onbekend').
RECODE Spec1_aant_keer_T2  (SYSMIS=1).
RECODE dagbehandeling_T2 (2=1).
RECODE dagbehandeling1_T2 ('heup'='').
RECODE dagbehandeling1_aant_keer_T2 (1=SYSMIS).
END IF.

DO IF ID_Code=3507.
RECODE Poli_T2 (1=2).
RECODE Ziekenhuis1_T2 (''='onbekend'). 
RECODE ZH1_type_T2 (SYSMIS=2).
RECODE Specialisme1_T2 (''='onbekend').
RECODE Spec1_aant_keer_T2  (SYSMIS=1).
RECODE dagbehandeling_T2 (2=1).
RECODE dagbehandeling1_T2 ('controle sleeveoperatie'='').
RECODE dagbehandeling1_aant_keer_T2 (1=SYSMIS).
END IF.

DO IF ID_Code=1815.
RECODE Poli_T2 (1=2).
RECODE Ziekenhuis1_T2 (''='onbekend'). 
RECODE ZH1_type_T2 (SYSMIS=2).
RECODE Specialisme1_T2 (''='onbekend').
RECODE Spec1_aant_keer_T2  (SYSMIS=1).
RECODE dagbehandeling_T2 (2=1).
RECODE dagbehandeling1_T2 ('Teennagel verwijderen'='').
RECODE dagbehandeling1_aant_keer_T2 (1=SYSMIS).
END IF.
EXECUTE.

DO IF ID_Code=4012.
RECODE Poli_T2 (1=2).
RECODE Ziekenhuis1_T2 (''='onbekend'). 
RECODE ZH1_type_T2 (SYSMIS=2).
RECODE Specialisme1_T2 (''='Chirurgie').
RECODE Spec1_aant_keer_T2  (SYSMIS=3).
RECODE dagbehandeling_T2 (2=1).
RECODE dagbehandeling1_T2 ('Chirurgie'='').
RECODE dagbehandeling1_aant_keer_T2 (3=SYSMIS).
END IF.
EXECUTE.

DO IF ID_Code=5201.
RECODE Poli_T2 (1=2).
RECODE Ziekenhuis1_T2 (''='onbekend'). 
RECODE ZH1_type_T2 (SYSMIS=2).
RECODE Specialisme1_T2 (''='onbekend').
RECODE Spec1_aant_keer_T2  (SYSMIS=4).
RECODE dagbehandeling_T2 (2=1).
RECODE dagbehandeling1_T2 ('Knieprotese'='').
RECODE dagbehandeling1_aant_keer_T2 (4=SYSMIS).
END IF.
EXECUTE.

DO IF ID_Code=5802.
RECODE Poli_T2 (1=2).
RECODE Ziekenhuis1_T2 (''='onbekend'). 
RECODE ZH1_type_T2 (SYSMIS=2).
RECODE Specialisme1_T2 (''='onbekend').
RECODE Spec1_aant_keer_T2  (SYSMIS=3).
RECODE dagbehandeling_T2 (2=1).
RECODE dagbehandeling1_T2 ('ogen'='').
RECODE dagbehandeling1_aant_keer_T2 (3=SYSMIS).
END IF.
EXECUTE.

DO IF ID_Code=3414.
RECODE Spec1_aant_keer_T2  (1=3).
RECODE dagbehandeling_T2 (2=1).
RECODE dagbehandeling1_T2 ('Nek operatie'='').
RECODE dagbehandeling1_aant_keer_T2 (4=SYSMIS).
END IF.
EXECUTE.

* tarieven 2017.
RECODE ZH1_type_T2 ZH2_type_T2 ZH3_type_T2 ZH4_type_T2 (1=167) (2=82) INTO Kosten_per_polibezoek1_temp Kosten_per_polibezoek2_temp 
Kosten_per_polibezoek3_temp Kosten_per_polibezoek4_temp.
EXECUTE.

COMPUTE kosten1_temp=Kosten_per_polibezoek1_temp * spec1_aant_keer_T2.
COMPUTE kosten2_temp=Kosten_per_polibezoek2_temp * spec2_aant_keer_T2.
COMPUTE kosten3_temp=Kosten_per_polibezoek3_temp * spec3_aant_keer_T2.
COMPUTE kosten4_temp=Kosten_per_polibezoek4_temp * spec4_aant_keer_T2.
COMPUTE kosten_poli_T2=SUM(kosten1_temp,kosten2_temp,kosten3_temp,kosten4_temp).
EXECUTE.

VARIABLE WIDTH kosten_poli_T2 (7).

DELETE VARIABLES  kosten_per_polibezoek1_temp kosten_per_polibezoek2_temp 
kosten_per_polibezoek3_temp kosten_per_polibezoek4_temp kosten1_temp kosten2_temp kosten3_temp kosten4_temp.

DO IF MISSING (Poli_T2)=1.
RECODE kosten_poli_T2 (SYSMIS=99999).
END IF.
DO IF Poli_T2=1.
RECODE kosten_poli_T2 (SYSMIS=0).
END IF.
EXECUTE.
MISSING VALUES kosten_poli_T2 (99999).

*** Kosten dagbehandeling********************************************************************************************************************************************.
** omvat ook diagnostiek.

IF  (ID_code=1107 and Dagbehandeling1_T2='MRI van hart') kosten_dagbeh1_T2=315.29.
IF  (ID_code=1107) kosten_dagbeh2_T2=103.05.
IF  (ID_code=1107 and Dagbehandeling3_T2='MRI van Longen') kosten_dagbeh3_T2=873.69.
IF  (ID_code=1107 and Dagbehandeling4_T2='longfunctie') kosten_dagbeh4_T2=60.32.
IF  (ID_code=1107 and Dagbehandeling5_T2='Histaminetest') kosten_dagbeh5_T2=106.22.
IF  (ID_code=1107 and Dagbehandeling6_T2='MRI van knie') kosten_dagbeh6_T2=241.10.
IF  (ID_code=1116 and Dagbehandeling1_T2='breuk/beknelling') kosten_dagbeh1_T2=0.
IF  (ID_code=1510 and Dagbehandeling1_T2='mri scan') kosten_dagbeh1_T2=241.10.
IF  (ID_code=1510 and Dagbehandeling2_T2='darmonderzoek') kosten_dagbeh2_T2=186.66.
IF  (ID_code=1602 and Dagbehandeling1_T2='Schouder scan') kosten_dagbeh1_T2=146.
IF  (ID_code=1605 and Dagbehandeling1_T2='Carpale') kosten_dagbeh1_T2=750.72.
IF  (ID_code=1608) kosten_dagbeh1_T2=112.24.
IF  (ID_code=1813 and Dagbehandeling1_T2='Aambei wegsnijden') kosten_dagbeh1_T2=535.56.
IF  (ID_code=1908 and Dagbehandeling1_T2='Trikkervinger') kosten_dagbeh1_T2=672.90.
IF  (ID_code=1916 and Dagbehandeling1_T2='Echo') kosten_dagbeh1_T2=95.84.
IF  (ID_code=1916 and Dagbehandeling2_T2='Duplex') kosten_dagbeh2_T2=69.57.
IF  (ID_code=2303 and Dagbehandeling1_T2='Katheterisatie') kosten_dagbeh1_T2=606.09.
IF  (ID_code=2304 and Dagbehandeling1_T2='mammografie') kosten_dagbeh1_T2=88.86.
IF  (ID_code=2502 and Dagbehandeling1_T2='hand operatie') kosten_dagbeh1_T2=3508.98.
IF  (ID_code=2503 and Dagbehandeling1_T2='Echo') kosten_dagbeh1_T2=95.84.
IF  (ID_code=2704 and Dagbehandeling1_T2='Snurken') kosten_dagbeh1_T2=167.12.
IF  (ID_code=2808 and Dagbehandeling1_T2='Pijnbestrijding injectie') kosten_dagbeh1_T2=0.
IF  (ID_code=2808 and Dagbehandeling2_T2='Pijnbestrijding PRF') kosten_dagbeh2_T2=563.89.
IF  (ID_code=2808 and Dagbehandeling3_T2='Colposcopie') kosten_dagbeh3_T2=186.66.
IF  (ID_code=2810 and Dagbehandeling1_T2='NACD') kosten_dagbeh1_T2=134.63.
IF  (ID_code=2904 and Dagbehandeling1_T2='Controles ivm chemo') kosten_dagbeh1_T2=0.
IF  (ID_code=2904 and Dagbehandeling2_T2='Mri') kosten_dagbeh2_T2=241.10.
IF  (ID_code=2904 and Dagbehandeling3_T2='Muga') kosten_dagbeh3_T2=221.34.
IF  (ID_code=3808 and Dagbehandeling1_T2='Buik operatie') kosten_dagbeh1_T2=0.
IF  (ID_code=3902 and Dagbehandeling1_T2='Toediening infuus') kosten_dagbeh1_T2=0.
IF  (ID_code=4012 and Dagbehandeling1_T2='Chirurgie') kosten_dagbeh1_T2=0.
IF  (ID_code=4503) kosten_dagbeh1_T2=0.
IF  (ID_code=4508 and Dagbehandeling1_T2='mama operatie') kosten_dagbeh1_T2=0.
IF  (ID_code=4508 and Dagbehandeling2_T2='bestraling') kosten_dagbeh2_T2=1944.14.
IF  (ID_code=4508 and Dagbehandeling2_T2='bestraling') dagbehandeling2_aant_keer_T2=1.
IF  (ID_code=4802 and Dagbehandeling1_T2='MRI van beide kniëen') kosten_dagbeh1_T2=239.23.
IF  (ID_code=4802) kosten_dagbeh2_T2=112.24.
IF  (ID_code=4803 and Dagbehandeling1_T2='botuline injecties') kosten_dagbeh1_T2=0.
IF  (ID_code=4917 and Dagbehandeling1_T2='appendix verwijderen') kosten_dagbeh1_T2=0.
IF  (ID_code=5106 and Dagbehandeling1_T2='littekenbehandeling') kosten_dagbeh1_T2=0.
IF  (ID_code=5206 and Dagbehandeling1_T2='uitslag PET scan') kosten_dagbeh1_T2=0.
IF  (ID_code=5206 and Dagbehandeling2_T2='diabetiscontrole') kosten_dagbeh2_T2=0.
IF  (ID_code=5206 and Dagbehandeling3_T2='bloeduitslagen') kosten_dagbeh3_T2=0.
IF  (ID_code=5308 and Dagbehandeling1_T2='Afspraak neuroloog') kosten_dagbeh1_T2=0.
IF  (ID_code=5805 and Dagbehandeling1_T2='Onwel geworden, stress') kosten_dagbeh1_T2=0.
IF  (ID_code=6015 and Dagbehandeling1_T2='zie voorgaande') kosten_dagbeh1_T2=0.
IF  (ID_code=6111 and Dagbehandeling1_T2='ecg') kosten_dagbeh1_T2=113.82.
IF  (ID_code=6412 and Dagbehandeling1_T2='Nekonderzoek') kosten_dagbeh1_T2=0.
IF  (ID_code=6412 and Dagbehandeling2_T2='Spierreuma') kosten_dagbeh2_T2=0.
EXECUTE.

VARIABLE WIDTH Dagbehandeling1_T2 Dagbehandeling2_T2 Dagbehandeling3_T2 Dagbehandeling4_T2 Dagbehandeling5_T2 Dagbehandeling6_T2 (20).
VARIABLE WIDTH kosten_dagbeh1_T2 kosten_dagbeh2_T2 kosten_dagbeh3_T2 kosten_dagbeh4_T2 kosten_dagbeh5_T2 kosten_dagbeh6_T2 (7).
VARIABLE WIDTH Dagbehandeling1_aant_keer_T2 Dagbehandeling2_aant_keer_T2 Dagbehandeling3_aant_keer_T2 Dagbehandeling4_aant_keer_T2 Dagbehandeling5_aant_keer_T2
Dagbehandeling6_aant_keer_T2 (12).

 * inclusief correctie voor 2018: +1.4%.
COMPUTE kosten_dagbeh1_tot_T2=((kosten_dagbeh1_T2 * Dagbehandeling1_aant_keer_T2)/100)*101.4.
COMPUTE kosten_dagbeh2_tot_T2=((kosten_dagbeh2_T2 * Dagbehandeling2_aant_keer_T2)/100)*101.4.
COMPUTE kosten_dagbeh3_tot_T2=((kosten_dagbeh3_T2 * Dagbehandeling3_aant_keer_T2)/100)*101.4.
COMPUTE kosten_dagbeh4_tot_T2=((kosten_dagbeh4_T2 * Dagbehandeling4_aant_keer_T2)/100)*101.4.
COMPUTE kosten_dagbeh5_tot_T2=((kosten_dagbeh5_T2 * Dagbehandeling5_aant_keer_T2)/100)*101.4.
COMPUTE kosten_dagbeh6_tot_T2=((kosten_dagbeh6_T2 * Dagbehandeling6_aant_keer_T2)/100)*101.4.
EXECUTE.
COMPUTE kosten_dagbeh_tot_T2=SUM(kosten_dagbeh1_tot_T2,kosten_dagbeh2_tot_T2,kosten_dagbeh3_tot_T2,kosten_dagbeh4_tot_T2,kosten_dagbeh5_tot_T2,kosten_dagbeh6_tot_T2).
EXECUTE.
VARIABLE WIDTH kosten_dagbeh_tot_T2 (9).

DO IF MISSING(dagbehandeling_T2)=1.
RECODE kosten_dagbeh_tot_T2 (SYSMIS=99999).
END IF.
EXECUTE.
DO IF dagbehandeling_T2=1.
RECODE kosten_dagbeh_tot_T2 (SYSMIS=0).
END IF.
EXECUTE.
MISSING VALUES kosten_dagbeh_tot_T2 (99999).

DELETE VARIABLES kosten_dagbeh1_tot_T2,kosten_dagbeh2_tot_T2,kosten_dagbeh3_tot_T2,kosten_dagbeh4_tot_T2,kosten_dagbeh5_tot_T2,kosten_dagbeh6_tot_T2.

** Kosten opname**********************************************************************************************************************************************************************

* tarieven 2017.
COMPUTE kosten_opname_ZH_T2=487*opname_ZH_aant_dagen_T2.
COMPUTE kosten_opname_rev_T2=471*opname_rev_aant_dagen_T2.
COMPUTE kosten_opname_psy_T2=309*opname_psy_aant_dagen_T2.
EXECUTE.

DO IF MISSING(opname_ZH_T2)=1.
RECODE kosten_opname_ZH_T2 (SYSMIS=99999).
END IF.
DO IF MISSING(opname_rev_T2)=1.
RECODE kosten_opname_rev_T2 (SYSMIS=99999).
END IF.
DO IF MISSING(opname_psy_T2)=1.
RECODE kosten_opname_psy_T2 (SYSMIS=99999).
END IF.
EXECUTE.

DO IF opname_ZH_T2=2.
RECODE kosten_opname_ZH_T2 (SYSMIS=0).
END IF.
DO IF opname_rev_T2=2.
RECODE kosten_opname_rev_T2 (SYSMIS=0).
END IF.
DO IF opname_psy_T2=2.
RECODE kosten_opname_psy_T2 (SYSMIS=0).
END IF.
EXECUTE.

MISSING VALUES kosten_opname_ZH_T2  kosten_opname_rev_T2  kosten_opname_psy_T2 (99999).
VARIABLE LEVEL kosten_opname_ZH_T2  kosten_opname_rev_T2  kosten_opname_psy_T2 (SCALE).
VARIABLE WIDTH kosten_opname_ZH_T2  kosten_opname_rev_T2  kosten_opname_psy_T2 (11).

COMPUTE kosten_opname_tot_T2=SUM (kosten_opname_ZH_T2,kosten_opname_rev_T2,kosten_opname_psy_T2).
EXECUTE.
RECODE kosten_opname_tot_T2 (SYSMIS=99999).
EXECUTE.

MISSING VALUES kosten_opname_tot_T2 (99999).
VARIABLE LEVEL kosten_opname_tot_T2 (SCALE).
VARIABLE WIDTH kosten_opname_tot_T2 (11).



** reiskosten**************************************************************************************************************************************************************************************.

** HA en POH: 1,1 km per bezoek x 0.19 + 3.07 parkeerkosten.
COMPUTE temp_aant_HA_POH= SUM(consult1_T2, consult2_T2).
COMPUTE reiskosten_HA_POH_T2= (temp_aant_HA_POH * 1.1 * 0.19) + (temp_aant_HA_POH * 3.07).
EXECUTE.
RECODE reiskosten_HA_POH_T2 (SYSMIS=99999).
EXECUTE.
DELETE VARIABLES temp_aant_HA_POH.
VARIABLE LABELS reiskosten_HA_POH_T2 'reiskosten HA en POH'.

** Fysio en overige paramedische consulten: 2,3 km per bezoek x 0.19 + 3.07 parkeerkosten.
COMPUTE temp_aant_param= SUM(consult3_T2, consult4_T2, consult5_T2, consult6_T2, consult7_T2, consult8_T2, consult9_T2, consult10_T2, consult11_T2, consult12_T2, consult13_T2, consult14_T2).
COMPUTE reiskosten_param_T2= (temp_aant_param * 2.2 * 0.19) + (temp_aant_param * 3.07).
EXECUTE.
RECODE reiskosten_param_T2 (SYSMIS=99999).
EXECUTE.
DELETE VARIABLES temp_aant_param.
VARIABLE LABELS reiskosten_param_T2 'reiskosten alle paramediche consulten'.

** Per polibezoek,  per dagbehandeling en per EHBO 7,0 km per bezoek x 0.19 + 3.07 parkeerkosten.
COMPUTE temp_aant_ZH= SUM( EHBO_aant_keer_T2,  spec1_aant_keer_T2,  spec2_aant_keer_T2,  spec3_aant_keer_T2,  spec4_aant_keer_T2,  
Dagbehandeling1_aant_keer_T2,  Dagbehandeling2_aant_keer_T2, Dagbehandeling3_aant_keer_T2, Dagbehandeling4_aant_keer_T2, Dagbehandeling5_aant_keer_T2, Dagbehandeling6_aant_keer_T2).
COMPUTE reiskosten_ZH_T2= (temp_aant_ZH * 7.0 * 0.19) + (temp_aant_ZH * 3.07).
EXECUTE.
RECODE reiskosten_ZH_T2 (SYSMIS=99999).
EXECUTE.
DELETE VARIABLES temp_aant_ZH.
VARIABLE LABELS reiskosten_ZH_T2 'reiskosten EHBO, poli en dagbehandeling'.

* Apotheek: indien medicatie gebruikt: 1 apotheekbezoek per vragenlijst rekenen.
DO IF medicatie_T2=2.
COMPUTE reiskosten_apo_T2= (1.3 * 0.19) + 3.07.
END IF.
DO IF medicatie_T2=1.
COMPUTE reiskosten_apo_T2= 0.
END IF.
RECODE reiskosten_apo_T2 (SYSMIS=99999).
EXECUTE.
VARIABLE LABELS reiskosten_apo_T2 'reiskosten apotheek'.

MISSING VALUES  reiskosten_HA_POH_T2 reiskosten_param_T2 reiskosten_ZH_T2 reiskosten_apo_T2 (99999).

*** Totale reiskosten.
COMPUTE reiskosten_tot_T2 = SUM (reiskosten_HA_POH_T2, reiskosten_param_T2, reiskosten_ZH_T2, reiskosten_apo_T2).
EXECUTE.
RECODE reiskosten_tot_T2 (SYSMIS=99999).
EXECUTE.

** indien verkorte lijst ingevuld: reiskosten zijn missing (soms staan er toch kosten vanwege stoppen met roken begeleiding en medicatie, wat wel gevraagd is).
IF (papier_T2=2) reiskosten_HA_POH_T2=99999.
IF (papier_T2=2) reiskosten_param_T2=99999.
IF (papier_T2=2) reiskosten_ZH_T2=99999.
IF (papier_T2=2) reiskosten_apo_T2=99999.
IF (papier_T2=2) reiskosten_tot_T2=99999.
EXECUTE.


VARIABLE WIDTH reiskosten_HA_POH_T2 reiskosten_param_T2 reiskosten_ZH_T2 reiskosten_apo_T2 reiskosten_tot_T2 (9).
VARIABLE LEVEL reiskosten_HA_POH_T2 reiskosten_param_T2 reiskosten_ZH_T2 reiskosten_apo_T2 reiskosten_tot_T2 (SCALE).
MISSING VALUES reiskosten_tot_T2 (99999).




