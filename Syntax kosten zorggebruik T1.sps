* Encoding: UTF-8.



** Kosten consulten eerste lijn*************************************************************************************************************************************.

** ID 5904. 4 consulten psycholoog gemeld bij dagbehandeling.
DO IF ID_code=5904.
RECODE consult12_T1 (0=4).
RECODE dagbehandeling_T1 (2=1).
RECODE dagbehandeling1_T1 ('psycholoog'='').
RECODE dagbehandeling1_aant_keer_T1 (4=SYSMIS).
END IF.

* tarieven dd 2017.
COMPUTE kosten_consult1_T1=consult1_T1*34.
COMPUTE kosten_consult2_T1=consult2_T1*17.
COMPUTE kosten_consult3_T1=consult3_T1*67.
COMPUTE kosten_consult4_T1=consult4_T1*105.
COMPUTE kosten_consult5_T1=consult5_T1*34.
COMPUTE kosten_consult6_T1=consult6_T1*31.
COMPUTE kosten_consult7_T1=consult7_T1*34.
COMPUTE kosten_consult8_T1=consult8_T1*20.
COMPUTE kosten_consult9_T1=consult9_T1*31.
COMPUTE kosten_consult10_T1=consult10_T1*45.
COMPUTE kosten_consult11_T1=consult11_T1*34.
COMPUTE kosten_consult12_T1=consult12_T1*65.
COMPUTE kosten_consult13_T1=consult13_T1*26.
COMPUTE kosten_consult14_T1=consult14_T1*24.
EXECUTE.

DO IF MISSING (consult1_T1)=1.
RECODE Kosten_consult1_T1 (SYSMIS=99999).
END IF.
DO IF MISSING (consult2_T1)=1.
RECODE Kosten_consult2_T1 (SYSMIS=99999).
END IF.
DO IF MISSING (consult3_T1)=1.
RECODE Kosten_consult3_T1 (SYSMIS=99999).
END IF.
DO IF MISSING (consult4_T1)=1.
RECODE Kosten_consult4_T1 (SYSMIS=99999).
END IF.
DO IF MISSING (consult5_T1)=1.
RECODE Kosten_consult5_T1 (SYSMIS=99999).
END IF.
DO IF MISSING (consult6_T1)=1.
RECODE Kosten_consult6_T1 (SYSMIS=99999).
END IF.
DO IF MISSING (consult7_T1)=1.
RECODE Kosten_consult7_T1 (SYSMIS=99999).
END IF.
DO IF MISSING (consult8_T1)=1.
RECODE Kosten_consult8_T1 (SYSMIS=99999).
END IF.
DO IF MISSING (consult9_T1)=1.
RECODE Kosten_consult9_T1 (SYSMIS=99999).
END IF.
DO IF MISSING (consult10_T1)=1.
RECODE Kosten_consult10_T1 (SYSMIS=99999).
END IF.
DO IF MISSING (consult11_T1)=1.
RECODE Kosten_consult11_T1 (SYSMIS=99999).
END IF.
DO IF MISSING (consult12_T1)=1.
RECODE Kosten_consult12_T1 (SYSMIS=99999).
END IF.
DO IF MISSING (consult13_T1)=1.
RECODE Kosten_consult13_T1 (SYSMIS=99999).
END IF.
DO IF MISSING (consult14_T1)=1.
RECODE Kosten_consult14_T1 (SYSMIS=99999).
END IF.
EXECUTE.
MISSING VALUES kosten_consult1_T1   kosten_consult2_T1  kosten_consult3_T1  kosten_consult4_T1  kosten_consult5_T1  kosten_consult6_T1 
 kosten_consult7_T1  kosten_consult8_T1  kosten_consult9_T1  kosten_consult10_T1  kosten_consult11_T1  kosten_consult12_T1 
 kosten_consult13_T1  kosten_consult14_T1 (99999).

VARIABLE LEVEL  kosten_consult1_T1   kosten_consult2_T1  kosten_consult3_T1  kosten_consult4_T1  kosten_consult5_T1  kosten_consult6_T1 
 kosten_consult7_T1  kosten_consult8_T1  kosten_consult9_T1  kosten_consult10_T1  kosten_consult11_T1  kosten_consult12_T1 
 kosten_consult13_T1  kosten_consult14_T1  (SCALE).

COMPUTE kosten_GP_T1=kosten_consult1_T1.
COMPUTE kosten_occ_pract_T1=kosten_consult4_T1.
COMPUTE kosten_stop_roken_begl_T1=0.
COMPUTE kosten_other_care_T1=SUM(kosten_consult2_T1,kosten_consult3_T1,kosten_consult5_T1, kosten_consult6_T1, kosten_consult8_T1,  
kosten_consult9_T1, kosten_consult10_T1,kosten_consult11_T1,kosten_consult12_T1,kosten_consult13_T1, kosten_consult14_T1).
EXECUTE.

RECODE kosten_GP_T1 kosten_occ_pract_T1 kosten_stop_roken_begl_T1 kosten_other_care_T1 (SYSMIS=99999).
EXECUTE.
MISSING VALUES kosten_GP_T1 kosten_occ_pract_T1 kosten_stop_roken_begl_T1 kosten_other_care_T1 (99999).
VARIABLE WIDTH  kosten_GP_T1 kosten_occ_pract_T1 kosten_stop_roken_begl_T1 kosten_other_care_T1 (10).
VARIABLE LEVEL  kosten_GP_T1 kosten_occ_pract_T1 kosten_stop_roken_begl_T1 kosten_other_care_T1(SCALE).

VARIABLE LABELS kosten_GP_T1 'kosten GP T1' kosten_occ_pract_T1 'kosten occupational practitioner T1' 
kosten_stop_roken_begl_T1 'kosten stoppen met roken begeleiding consulten T1' kosten_other_care_T1 'kosten other care consults T1'.

DELETE VARIABLES kosten_consult1_T1  kosten_consult2_T1  kosten_consult3_T1  kosten_consult4_T1  kosten_consult5_T1  kosten_consult6_T1 
 kosten_consult7_T1  kosten_consult8_T1  kosten_consult9_T1  kosten_consult10_T1  kosten_consult11_T1  kosten_consult12_T1 
 kosten_consult13_T1  kosten_consult14_T1.

***Kosten thuiszorg ***********************************************************************************************************************************************.
* dd 2017.
COMPUTE kosten_thuiszorg_hh_T1= thuiszorg_hh_weken_T1 * thuiszorg_hh_uur_T1 * 20.
COMPUTE kosten_thuiszorg_verzorging_T1= thuiszorg_verzorging_weken_T1 * thuiszorg_verzorging_uur_T1 * 51.
COMPUTE kosten_thuiszorg_verpleging_T1= thuiszorg_verpleging_weken_T1 * thuiszorg_verpleging_uur_T1 * 75.
COMPUTE kosten_thuiszorg_tot_T1=SUM (kosten_thuiszorg_HH_T1,kosten_thuiszorg_verzorging_T1,kosten_thuiszorg_verpleging_T1).
EXECUTE.


DO IF MISSING(thuiszorg_T1)=1.
RECODE kosten_thuiszorg_HH_T1,kosten_thuiszorg_verzorging_T1,kosten_thuiszorg_verpleging_T1 kosten_thuiszorg_tot_T1 (SYSMIS=99999).
END IF.
EXECUTE.
MISSING VALUES kosten_thuiszorg_HH_T1,kosten_thuiszorg_verzorging_T1,kosten_thuiszorg_verpleging_T1 kosten_thuiszorg_tot_T1 (99999).
VARIABLE WIDTH kosten_thuiszorg_HH_T1,kosten_thuiszorg_verzorging_T1,kosten_thuiszorg_verpleging_T1 kosten_thuiszorg_tot_T1 (10).
VARIABLE LEVEL kosten_thuiszorg_HH_T1,kosten_thuiszorg_verzorging_T1,kosten_thuiszorg_verpleging_T1 kosten_thuiszorg_tot_T1 (SCALE).


***Kosten Nicotinevervangers*************************************************************************************************************************************.
COMPUTE kosten_nicotinepleisters_T1=nicotinepleisters_stuks_T1 * nicotinepleisters_dagen_T1 * 3.
IF (nicotinepleisters_T1=0) kosten_nicotinepleisters_T1=0.
IF MISSINGS(nicotinepleisters_T1)=1 kosten_nicotinepleisters_T1=99999.
EXECUTE.
COMPUTE kosten_nicotinekauwgom_T1=nicotinekauwgom_stuks_T1 * nicotinekauwgom_dagen_T1 * 0.24.
IF (nicotinekauwgom_T1=0) kosten_nicotinekauwgom_T1=0.
IF MISSINGS(nicotinekauwgom_T1)=1 kosten_nicotinekauwgom_T1=99999.
EXECUTE.
COMPUTE kosten_nicotine_microtabs_T1=nicotine_microtabs_stuks_T1 * nicotine_microtabs_dagen_T1 * 0.36.
IF (nicotine_microtabs_T1=0) kosten_nicotine_microtabs_T1=0.
IF MISSINGS(nicotine_microtabs_T1)=1 kosten_nicotine_microtabs_T1=99999.
EXECUTE.
COMPUTE kosten_nicotine_zuigtabletten_T1=nicotine_zuigtabletten_stuks_T1 * nicotine_zuigtabletten_dagen_T1 * 0.36.
IF (nicotine_zuigtabletten_T1=0) kosten_nicotine_zuigtabletten_T1=0.
IF MISSINGS(nicotine_zuigtabletten_T1)=1 kosten_nicotine_zuigtabletten_T1=99999.
EXECUTE.
IF (nicotine_mondspray_T1=1) kosten_nicotine_mondspray_T1=28.99.
IF (nicotine_mondspray_T1=0) kosten_nicotine_mondspray_T1=0.
IF MISSINGS(nicotine_mondspray_T1)=1 kosten_nicotine_mondspray_T1=99999.
EXECUTE.
IF (nicotine_inhaler_T1=1) kosten_nicotine_inhaler_T1=28.99.
IF (nicotine_inhaler_T1=0) kosten_nicotine_inhaler_T1=0.
IF MISSINGS(nicotine_inhaler_T1)=1 kosten_nicotine_inhaler_T1=99999.
EXECUTE.

MISSING VALUES  kosten_nicotinepleisters_T1 kosten_nicotinekauwgom_T1 kosten_nicotine_microtabs_T1 kosten_nicotine_zuigtabletten_T1
 kosten_nicotine_mondspray_T1 kosten_nicotine_inhaler_T1 (99999).

COMPUTE kosten_nicotineverv_tot_T1= kosten_nicotinepleisters_T1+ kosten_nicotinekauwgom_T1 + kosten_nicotine_microtabs_T1+ 
 kosten_nicotine_zuigtabletten_T1 + kosten_nicotine_mondspray_T1+ kosten_nicotine_inhaler_T1.
EXECUTE.

RECODE  kosten_nicotineverv_tot_T1 (SYSMIS=99999).
MISSING VALUES kosten_nicotineverv_tot_T1 (99999).

VARIABLE WIDTH kosten_nicotinepleisters_T1 kosten_nicotinekauwgom_T1 kosten_nicotine_microtabs_T1 kosten_nicotine_zuigtabletten_T1
 kosten_nicotine_mondspray_T1 kosten_nicotine_inhaler_T1 kosten_nicotineverv_tot_T1 (10).
VARIABLE LEVEL kosten_nicotinepleisters_T1 kosten_nicotinekauwgom_T1 kosten_nicotine_microtabs_T1 kosten_nicotine_zuigtabletten_T1
 kosten_nicotine_mondspray_T1 kosten_nicotine_inhaler_T1 kosten_nicotineverv_tot_T1 (SCALE).

***Kosten medicatie***********************************************************************************************************************************************.
zie aparte syntax.

***Kosten EHBO***********************************************************************************************************************************************.
* dd 2017.
COMPUTE kosten_ehbo_T1=EHBO_T1* EHBO_aant_keer_T1*265.

DO IF MISSING (EHBO_T1)=1.
RECODE Kosten_ehbo_T1 (SYSMIS=99999).
END IF.
EXECUTE.
MISSING VALUES kosten_ehbo_T1 (99999).
VARIABLE LEVEL kosten_ehbo_T1 (SCALE).
VARIABLE WIDTH kosten_ehbo_T1 (7).

***Kosten ambulance***********************************************************************************************************************************************.
* dd 2017.
COMPUTE kosten_ambulance_T1=ambulance_T1* ambulance_aant_keer_T1*527.

DO IF MISSING (ambulance_T1)=1.
RECODE Kosten_ambulance_T1 (SYSMIS=99999).
END IF.
EXECUTE.
MISSING VALUES kosten_ambulance_T1 (99999).
VARIABLE LEVEL kosten_ambulance_T1 (SCALE).
VARIABLE WIDTH kosten_ambulance_T1 (7).
***Kosten polibezoek***********************************************************************************************************************************************.

** aanpassingen van polibezoeken die hier niet worden gemeld maar wel bij dagbehandeling.
DO IF ID_Code=1915.
RECODE Poli_T1 (1=2).
RECODE Ziekenhuis1_T1 (''='onbekend'). 
RECODE ZH1_type_T1 (SYSMIS=2).
RECODE Specialisme1_T1 (''='Oogarts').
RECODE Spec1_aant_keer_T1  (SYSMIS=4).
RECODE dagbehandeling_T1 (2=1).
RECODE dagbehandeling1_T1 ('Oogarts'='').
RECODE dagbehandeling1_aant_keer_T1 (4=SYSMIS).
END IF.

DO IF ID_Code=3507.
RECODE Poli_T1 (1=2).
RECODE Ziekenhuis1_T1 (''='onbekend'). 
RECODE ZH1_type_T1 (SYSMIS=2).
RECODE Specialisme1_T1 (''='onbekend').
RECODE Spec1_aant_keer_T1  (SYSMIS=1).
RECODE dagbehandeling_T1 (2=1).
RECODE dagbehandeling1_T1 ('controle sleeveoperatie'='').
RECODE dagbehandeling1_aant_keer_T1 (1=SYSMIS).
END IF.

DO IF ID_Code=1815.
RECODE Poli_T1 (1=2).
RECODE Ziekenhuis1_T1 (''='onbekend'). 
RECODE ZH1_type_T1 (SYSMIS=2).
RECODE Specialisme1_T1 (''='onbekend').
RECODE Spec1_aant_keer_T1  (SYSMIS=1).
RECODE dagbehandeling_T1 (2=1).
RECODE dagbehandeling1_T1 ('Teennagel verwijderen'='').
RECODE dagbehandeling1_aant_keer_T1 (1=SYSMIS).
END IF.
EXECUTE.

* dagbehandeling 2 KNO moet polibezoek worden.
IF (ID_code=6302) ziekenhuis2_T1='onbekend'.
IF (ID_code=6302) specialisme2_T1='KNO'.
IF (ID_code=6302) ZH2_type_T1=2.
IF (ID_code=6302) spec2_aant_keer_T1=1.

* bij dagbehandeling 2x kies trekken (=dagbehandeling) en 1x controle (=poli).
IF  (ID_code=3106) spec1_aant_keer_T1=1.

* tarieven 2017.
RECODE ZH1_type_T1 ZH2_type_T1 ZH3_type_T1 ZH4_type_T1 (1=167) (2=82) INTO Kosten_per_polibezoek1_temp Kosten_per_polibezoek2_temp 
Kosten_per_polibezoek3_temp Kosten_per_polibezoek4_temp.
EXECUTE.

COMPUTE kosten1_temp=Kosten_per_polibezoek1_temp * spec1_aant_keer_T1.
COMPUTE kosten2_temp=Kosten_per_polibezoek2_temp * spec2_aant_keer_T1.
COMPUTE kosten3_temp=Kosten_per_polibezoek3_temp * spec3_aant_keer_T1.
COMPUTE kosten4_temp=Kosten_per_polibezoek4_temp * spec4_aant_keer_T1.
COMPUTE kosten_poli_T1=SUM(kosten1_temp,kosten2_temp,kosten3_temp,kosten4_temp).
EXECUTE.

DELETE VARIABLES  kosten_per_polibezoek1_temp Kosten_per_polibezoek2_temp 
Kosten_per_polibezoek3_temp Kosten_per_polibezoek4_temp kosten1_temp kosten2_temp kosten3_temp kosten4_temp.

DO IF MISSING (Poli_T1)=1.
RECODE kosten_poli_T1 (SYSMIS=99999).
END IF.
DO IF Poli_T1=1.
RECODE kosten_poli_T1 (SYSMIS=0).
END IF.
EXECUTE.
MISSING VALUES kosten_poli_T1 (99999).

*** Kosten dagbehandeling********************************************************************************************************************************************.
** omvat ook diagnostiek.

IF  (ID_code=1111 and Dagbehandeling1_T1='maagband bij spuiten') kosten_dagbeh1_T1=276.
IF  (ID_code=1405 and Dagbehandeling1_T1='ontsteking aan de heup') kosten_dagbeh1_T1=0.
IF  (ID_code=1512 and Dagbehandeling1_T1='Doorspreken operatie') kosten_dagbeh1_T1=0.
IF  (ID_code=1602 and Dagbehandeling1_T1='Eeg') kosten_dagbeh1_T1=184.45.
IF  (ID_code=1816 and Dagbehandeling1_T1='gehoortest') kosten_dagbeh1_T1=137.78.
IF  (ID_code=1914 and Dagbehandeling1_T1='echo buik')  kosten_dagbeh1_T1=79.99.
IF  (ID_code=1914 and Dagbehandeling2_T1='CT scan buik')  kosten_dagbeh2_T1=167.63.
IF  (ID_code=1916 and Dagbehandeling1_T1='Wondje aan enkel is ingeswachteld') kosten_dagbeh1_T1=0.
IF  (ID_code=2303 and Dagbehandeling1_T1='katheteriseren') kosten_dagbeh1_T1=606.09.
IF  (ID_code=2411 and Dagbehandeling1_T1='Ct scan') kosten_dagbeh1_T1=139.
IF  (ID_code=2411 and Dagbehandeling2_T1='Mri scan') kosten_dagbeh2_T1=241.10.
IF  (ID_code=2411 and Dagbehandeling3_T1='Gastronomische') kosten_dagbeh3_T1=9999.
IF  (ID_code=2502 and Dagbehandeling1_T1='Controlle') kosten_dagbeh1_T1=0.
IF  (ID_code=2808 and Dagbehandeling1_T1='Pijnbestrijding') kosten_dagbeh1_T1=0.
IF  (ID_code=3106 and Dagbehandeling1_T1='Verstandkiezen links') kosten_dagbeh1_T1=87.45.
IF  (ID_code=3106 and Dagbehandeling2_T1='Verstandskiezen rechts') kosten_dagbeh2_T1=87.45.
IF  (ID_code=3106 and Dagbehandeling3_T1='Controle verstandkiezen') kosten_dagbeh3_T1=0.
IF  (ID_code=3305 and Dagbehandeling1_T1='Kijk behandeling uroloog') kosten_dagbeh1_T1=0.
IF  (ID_code=3305 and Dagbehandeling2_T1='Nabehandeling uroloog') kosten_dagbeh2_T1=0.
IF  (ID_code=3305 and Dagbehandeling3_T1='Fysieke controle neuroloog') kosten_dagbeh3_T1=0.
IF  (ID_code=3902 and Dagbehandeling1_T1='infuus')  kosten_dagbeh1_T1=0.
IF  (ID_code=4305 and Dagbehandeling1_T1='Caroaaltunnelsyndroom')  kosten_dagbeh1_T1=750.72.
IF  (ID_code=4404 and Dagbehandeling1_T1='controle en afstellen ICD') kosten_dagbeh1_T1=207.16.
IF  (ID_code=4501 and Dagbehandeling1_T1='Controle') kosten_dagbeh1_T1=0.
IF  (ID_code=4507 and Dagbehandeling1_T1='Slaaponderzoek') kosten_dagbeh1_T1=167.12.
IF  (ID_code=4507 and Dagbehandeling2_T1='Slaaponderzoek') kosten_dagbeh2_T1=167.12 .
IF  (ID_code=4508 and Dagbehandeling1_T1='mammografie') kosten_dagbeh1_T1=88.86.
IF  (ID_code=4508 and Dagbehandeling2_T1='echo') kosten_dagbeh2_T1=95.84.
IF  (ID_code=4508 and Dagbehandeling3_T1='lymfo scintigrafie') kosten_dagbeh3_T1=241.10.
IF  (ID_code=4508 and Dagbehandeling4_T1='MRI') kosten_dagbeh4_T1=241.10.
IF  (ID_code=4508 and Dagbehandeling5_T1='plaatsen jodiumbron') kosten_dagbeh5_T1=9999.
IF  (ID_code=4508 and Dagbehandeling6_T1='echogeleid mammabiopt') kosten_dagbeh6_T1=134.98.
IF  (ID_code=4808 and Dagbehandeling1_T1='Kijkoperatie') kosten_dagbeh1_T1=908.
IF  (ID_code=4905 and Dagbehandeling1_T1='psioriasich') kosten_dagbeh1_T1=0.
IF  (ID_code=4914 and Dagbehandeling1_T1='gescheurde wenkbrauw') kosten_dagbeh1_T1=0.
IF  (ID_code=4916 and Dagbehandeling1_T1='MDL') kosten_dagbeh1_T1=0.
IF  (ID_code=5106 and Dagbehandeling1_T1='littekens') kosten_dagbeh1_T1=0.
IF  (ID_code=5111 and Dagbehandeling1_T1='knie problemen') kosten_dagbeh1_T1=0.
IF  (ID_code=5111 and Dagbehandeling2_T1='psychische hulp') kosten_dagbeh2_T1=0.
IF  (ID_code=5206 and Dagbehandeling1_T1='PET scan') kosten_dagbeh1_T1=761.98.
IF  (ID_code=5206 and Dagbehandeling2_T1='MR scan') kosten_dagbeh2_T1=241.10.
IF  (ID_code=5206 and Dagbehandeling3_T1='rontgen') kosten_dagbeh3_T1=112.24.
IF  (ID_code=5206 and Dagbehandeling4_T1='Botscan') kosten_dagbeh4_T1=241.10.
IF  (ID_code=5512 and Dagbehandeling1_T1='Operatie') kosten_dagbeh1_T1=276.
IF  (ID_code=5606 and Dagbehandeling1_T1='kappote slijmbeurs knie') kosten_dagbeh1_T1=0.
IF  (ID_code=5802 and Dagbehandeling1_T1='oogtesten') kosten_dagbeh1_T1=0.
IF  (ID_code=6103 and Dagbehandeling1_T1='Gal stenen') kosten_dagbeh1_T1=708.05.
IF  (ID_code=6302 and Dagbehandeling1_T1='longarts') kosten_dagbeh1_T1=0.
IF  (ID_code=6302 and Dagbehandeling2_T1='kno') kosten_dagbeh2_T1=0.
IF  (ID_code=6806 and Dagbehandeling1_T1='Urologie') kosten_dagbeh1_T1=0.
IF  (ID_code=7005 and Dagbehandeling1_T1='Longfoto')  kosten_dagbeh1_T1=103.05.
IF  (ID_code=7005 and Dagbehandeling2_T1='Bloedprikken')  kosten_dagbeh2_T1=0.
IF  (ID_code=7111 and Dagbehandeling1_T1='Longfunctietest')  kosten_dagbeh1_T1=60.32.
EXECUTE.

DO IF ID_Code=5812 or ID_code=7102.
RECODE dagbehandeling_T1 (2=1).
END IF.
EXECUTE.

 * inclusief correctie voor 2018: +1.4%.
COMPUTE kosten_dagbeh1_tot_T1=((kosten_dagbeh1_T1 * Dagbehandeling1_aant_keer_T1)/100)*101.4.
COMPUTE kosten_dagbeh2_tot_T1=((kosten_dagbeh2_T1 * Dagbehandeling2_aant_keer_T1)/100)*101.4.
COMPUTE kosten_dagbeh3_tot_T1=((kosten_dagbeh3_T1 * Dagbehandeling3_aant_keer_T1)/100)*101.4.
COMPUTE kosten_dagbeh4_tot_T1=((kosten_dagbeh4_T1 * Dagbehandeling4_aant_keer_T1)/100)*101.4.
COMPUTE kosten_dagbeh5_tot_T1=((kosten_dagbeh5_T1 * Dagbehandeling5_aant_keer_T1)/100)*101.4.
COMPUTE kosten_dagbeh6_tot_T1=((kosten_dagbeh6_T1 * Dagbehandeling6_aant_keer_T1)/100)*101.4.
EXECUTE.
COMPUTE kosten_dagbeh_tot_T1=SUM(kosten_dagbeh1_tot_T1,kosten_dagbeh2_tot_T1,kosten_dagbeh3_tot_T1,kosten_dagbeh4_tot_T1,kosten_dagbeh5_tot_T1, kosten_dagbeh6_tot_T1).
EXECUTE.

VARIABLE WIDTH kosten_dagbeh1_T1 kosten_dagbeh2_T1 kosten_dagbeh3_T1 kosten_dagbeh4_T1 kosten_dagbeh5_T1 kosten_dagheb6_tot_T1 (7).
VARIABLE WIDTH kosten_dagbeh1_tot_T1 kosten_dagbeh2_tot_T1 kosten_dagbeh3_tot_T1 kosten_dagbeh4_tot_T1 kosten_dagbeh5_tot_T1 kosten_dagbeh6_tot_T1  
kosten_dagbeh_tot_T1 (7).

DO IF MISSING(dagbehandeling_T1)=1.
RECODE kosten_dagbeh_tot_T1 (SYSMIS=99999).
END IF.
EXECUTE.
DO IF dagbehandeling_T1=1.
RECODE kosten_dagbeh_tot_T1 (SYSMIS=0).
END IF.
EXECUTE.
MISSING VALUES kosten_dagbeh_tot_T1 (99999).

DELETE VARIABLES kosten_dagbeh1_tot_T1 kosten_dagbeh2_tot_T1 kosten_dagbeh3_tot_T1 kosten_dagbeh4_tot_T1 kosten_dagbeh5_tot_T1 kosten_dagbeh6_tot_T1 . 


** Kosten opname**********************************************************************************************************************************************************************
* tarieven 2017.
COMPUTE kosten_opname_ZH_T1=487*opname_ZH_aant_dagen_T1.
COMPUTE kosten_opname_rev_T1=471*opname_rev_aant_dagen_T1.
COMPUTE kosten_opname_psy_T1=309*opname_psy_aant_dagen_T1.
EXECUTE.

DO IF MISSING(opname_ZH_T1)=1.
RECODE kosten_opname_ZH_T1 (SYSMIS=99999).
END IF.
DO IF MISSING(opname_rev_T1)=1.
RECODE kosten_opname_rev_T1 (SYSMIS=99999).
END IF.
DO IF MISSING(opname_psy_T1)=1.
RECODE kosten_opname_psy_T1 (SYSMIS=99999).
END IF.
EXECUTE.

DO IF opname_ZH_T1=2.
RECODE kosten_opname_ZH_T1 (SYSMIS=0).
END IF.
DO IF opname_rev_T1=2.
RECODE kosten_opname_rev_T1 (SYSMIS=0).
END IF.
DO IF opname_psy_T1=2.
RECODE kosten_opname_psy_T1 (SYSMIS=0).
END IF.
EXECUTE.

MISSING VALUES kosten_opname_ZH_T1  kosten_opname_rev_T1  kosten_opname_psy_T1 (99999).

COMPUTE kosten_opname_tot_T1=SUM (kosten_opname_ZH_T1,kosten_opname_rev_T1,kosten_opname_psy_T1).
EXECUTE.
RECODE kosten_opname_tot_T1 (SYSMIS=99999).
EXECUTE.
MISSING VALUES kosten_opname_tot_T1 (99999).

VARIABLE LEVEL kosten_opname_ZH_T1  kosten_opname_rev_T1  kosten_opname_psy_T1 kosten_opname_tot_T1(SCALE).
VARIABLE WIDTH kosten_opname_ZH_T1  kosten_opname_rev_T1  kosten_opname_psy_T1  kosten_opname_tot_T1 (11).


** reiskosten**************************************************************************************************************************************************************************************.

** HA en POH: 1,1 km per bezoek x 0.19 + 3.07 parkeerkosten.
COMPUTE temp_aant_HA_POH= SUM(consult1_T1, consult2_T1).
COMPUTE reiskosten_HA_POH_T1= (temp_aant_HA_POH * 1.1 * 0.19) + (temp_aant_HA_POH * 3.07).
EXECUTE.
RECODE reiskosten_HA_POH_T1 (SYSMIS=99999).
EXECUTE.
DELETE VARIABLES temp_aant_HA_POH.
VARIABLE LABELS reiskosten_HA_POH_T1 'reiskosten HA en POH'.

** Fysio en overige paramedische consulten: 2,3 km per bezoek x 0.19 + 3.07 parkeerkosten.
* concult 7 = stoppen met roken begeleiding telt niet mee, omdat we ervan uit gaan dat op T1 alle stoppen met roken begeleiding in kader van interventie was.
COMPUTE temp_aant_param= SUM(consult3_T1, consult4_T1, consult5_T1, consult6_T1, consult8_T1, consult9_T1, consult10_T1, consult11_T1, consult12_T1, consult13_T1, consult14_T1).
COMPUTE reiskosten_param_T1= (temp_aant_param * 2.2 * 0.19) + (temp_aant_param * 3.07).
EXECUTE.
RECODE reiskosten_param_T1 (SYSMIS=99999).
EXECUTE.
DELETE VARIABLES temp_aant_param.
VARIABLE LABELS reiskosten_param_T1 'reiskosten alle paramediche consulten'.

** Per polibezoek,  per dagbehandeling en per EHBO 7,0 km per bezoek x 0.19 + 3.07 parkeerkosten.
COMPUTE temp_aant_ZH= SUM( EHBO_aant_keer_T1,  spec1_aant_keer_T1,  spec2_aant_keer_T1,  spec3_aant_keer_T1,  spec4_aant_keer_T1,  
Dagbehandeling1_aant_keer_T1,  Dagbehandeling2_aant_keer_T1, Dagbehandeling3_aant_keer_T1, Dagbehandeling4_aant_keer_T1, Dagbehandeling5_aant_keer_T1, Dagbehandeling6_aant_keer_T1).
COMPUTE reiskosten_ZH_T1= (temp_aant_ZH * 7.0 * 0.19) + (temp_aant_ZH * 3.07).
EXECUTE.
RECODE reiskosten_ZH_T1 (SYSMIS=99999).
EXECUTE.
DELETE VARIABLES temp_aant_ZH.
VARIABLE LABELS reiskosten_ZH_T1 'reiskosten EHBO, poli en dagbehandeling'.

* Apotheek: indien medicatie gebruikt: 1 apotheekbezoek per vragenlijst rekenen.
DO IF medicatie_T1=2.
COMPUTE reiskosten_apo_T1= (1.3 * 0.19) + 3.07.
END IF.
DO IF medicatie_T1=1.
COMPUTE reiskosten_apo_T1= 0.
END IF.
RECODE reiskosten_apo_T1 (SYSMIS=99999).
EXECUTE.
VARIABLE LABELS reiskosten_apo_T1 'reiskosten apotheek'.

MISSING VALUES  reiskosten_HA_POH_T1 reiskosten_param_T1 reiskosten_ZH_T1 reiskosten_apo_T1 (99999).

*** Totale reiskosten.
COMPUTE reiskosten_tot_T1 = SUM (reiskosten_HA_POH_T1, reiskosten_param_T1, reiskosten_ZH_T1, reiskosten_apo_T1).
EXECUTE.
RECODE reiskosten_tot_T1 (SYSMIS=99999).
EXECUTE.

** indien verkorte lijst ingevuld: reiskosten zijn missing (soms staan er toch kosten vanwege stoppen met roken begeleiding en medicatie, wat wel gevraagd is).
IF (papier_T1=2) reiskosten_HA_POH_T1=99999.
IF (papier_T1=2) reiskosten_param_T1=99999.
IF (papier_T1=2) reiskosten_ZH_T1=99999.
IF (papier_T1=2) reiskosten_tot_T1=99999.
IF (papier_T1=2) reiskosten_apo_T1=99999.
EXECUTE.


VARIABLE WIDTH reiskosten_HA_POH_T1 reiskosten_param_T1 reiskosten_ZH_T1 reiskosten_apo_T1 reiskosten_tot_T1 (9).
VARIABLE LEVEL reiskosten_HA_POH_T1 reiskosten_param_T1 reiskosten_ZH_T1 reiskosten_apo_T1 reiskosten_tot_T1 (SCALE).

MISSING VALUES reiskosten_tot_T1 (99999).
