* Encoding: UTF-8.



** Kosten consulten eerste lijn*************************************************************************************************************************************.

* tarieven dd 2017.
COMPUTE kosten_consult1_T4=consult1_T4*34.
COMPUTE kosten_consult2_T4=consult2_T4*17.
COMPUTE kosten_consult3_T4=consult3_T4*67.
COMPUTE kosten_consult4_T4=consult4_T4*105.
COMPUTE kosten_consult5_T4=consult5_T4*34.
COMPUTE kosten_consult6_T4=consult6_T4*31.
COMPUTE kosten_consult7_T4=consult7_T4*34.
COMPUTE kosten_consult8_T4=consult8_T4*20.
COMPUTE kosten_consult9_T4=consult9_T4*31.
COMPUTE kosten_consult10_T4=consult10_T4*45.
COMPUTE kosten_consult11_T4=consult11_T4*34.
COMPUTE kosten_consult12_T4=consult12_T4*65.
COMPUTE kosten_consult13_T4=consult13_T4*26.
COMPUTE kosten_consult14_T4=consult14_T4*24.
EXECUTE.

DO IF MISSING (consult1_T4)=1.
RECODE Kosten_consult1_T4 (SYSMIS=99999).
END IF.
DO IF MISSING (consult2_T4)=1.
RECODE Kosten_consult2_T4 (SYSMIS=99999).
END IF.
DO IF MISSING (consult3_T4)=1.
RECODE Kosten_consult3_T4 (SYSMIS=99999).
END IF.
DO IF MISSING (consult4_T4)=1.
RECODE Kosten_consult4_T4 (SYSMIS=99999).
END IF.
DO IF MISSING (consult5_T4)=1.
RECODE Kosten_consult5_T4 (SYSMIS=99999).
END IF.
DO IF MISSING (consult6_T4)=1.
RECODE Kosten_consult6_T4 (SYSMIS=99999).
END IF.
DO IF MISSING (consult7_T4)=1.
RECODE Kosten_consult7_T4 (SYSMIS=99999).
END IF.
DO IF MISSING (consult8_T4)=1.
RECODE Kosten_consult8_T4 (SYSMIS=99999).
END IF.
DO IF MISSING (consult9_T4)=1.
RECODE Kosten_consult9_T4 (SYSMIS=99999).
END IF.
DO IF MISSING (consult10_T4)=1.
RECODE Kosten_consult10_T4 (SYSMIS=99999).
END IF.
DO IF MISSING (consult11_T4)=1.
RECODE Kosten_consult11_T4 (SYSMIS=99999).
END IF.
DO IF MISSING (consult12_T4)=1.
RECODE Kosten_consult12_T4 (SYSMIS=99999).
END IF.
DO IF MISSING (consult13_T4)=1.
RECODE Kosten_consult13_T4 (SYSMIS=99999).
END IF.
DO IF MISSING (consult14_T4)=1.
RECODE Kosten_consult14_T4 (SYSMIS=99999).
END IF.
EXECUTE.
MISSING VALUES kosten_consult1_T4   kosten_consult2_T4  kosten_consult3_T4  kosten_consult4_T4  kosten_consult5_T4  kosten_consult6_T4 
 kosten_consult7_T4  kosten_consult8_T4  kosten_consult9_T4  kosten_consult10_T4  kosten_consult11_T4  kosten_consult12_T4 
 kosten_consult13_T4  kosten_consult14_T4 (99999).

VARIABLE LEVEL  kosten_consult1_T4   kosten_consult2_T4  kosten_consult3_T4  kosten_consult4_T4  kosten_consult5_T4  kosten_consult6_T4 
 kosten_consult7_T4  kosten_consult8_T4  kosten_consult9_T4  kosten_consult10_T4  kosten_consult11_T4  kosten_consult12_T4 
 kosten_consult13_T4  kosten_consult14_T4  (SCALE).
VARIABLE WIDTH  kosten_consult1_T4   kosten_consult2_T4  kosten_consult3_T4  kosten_consult4_T4  kosten_consult5_T4  kosten_consult6_T4 
 kosten_consult7_T4  kosten_consult8_T4  kosten_consult9_T4  kosten_consult10_T4  kosten_consult11_T4  kosten_consult12_T4 
 kosten_consult13_T4  kosten_consult14_T4  (9).


COMPUTE kosten_GP_T4=kosten_consulT4_T4.
COMPUTE kosten_occ_pract_T4=kosten_consult4_T4.
COMPUTE kosten_stop_roken_begl_T4=kosten_consult7_T4.
COMPUTE kosten_other_care_T4=SUM(kosten_consult2_T4,kosten_consulT4_T4,kosten_consult5_T4, kosten_consult6_T4, kosten_consult8_T4,  
kosten_consult9_T4, kosten_consult10_T4,kosten_consult11_T4,kosten_consult12_T4,kosten_consult13_T4, kosten_consult14_T4).
EXECUTE.

RECODE kosten_GP_T4 kosten_occ_pract_T4 kosten_stop_roken_begl_T4 kosten_other_care_T4 (SYSMIS=99999).
EXECUTE.
MISSING VALUES kosten_GP_T4 kosten_occ_pract_T4 kosten_stop_roken_begl_T4 kosten_other_care_T4 (99999).
VARIABLE WIDTH  kosten_GP_T4 kosten_occ_pract_T4 kosten_stop_roken_begl_T4 kosten_other_care_T4 (10).
VARIABLE LEVEL  kosten_GP_T4 kosten_occ_pract_T4 kosten_stop_roken_begl_T4 kosten_other_care_T4(SCALE).

VARIABLE LABELS kosten_GP_T4 'kosten GP T4' kosten_occ_pract_T4 'kosten occupational practitioner T4' 
kosten_stop_roken_begl_T4 'kosten stoppen met roken begeleiding consulten T4' kosten_other_care_T4 'kosten other care consults T4'.

***Kosten thuiszorg ***********************************************************************************************************************************************.
* dd 2017.
COMPUTE kosten_thuiszorg_hh_T4= thuiszorg_hh_weken_T4 * thuiszorg_hh_uur_T4 * 20.
COMPUTE kosten_thuiszorg_verzorging_T4= thuiszorg_verzorging_weken_T4 * thuiszorg_verzorging_uur_T4 * 51.
COMPUTE kosten_thuiszorg_verpleging_T4= thuiszorg_verpleging_weken_T4 * thuiszorg_verpleging_uur_T4 * 75.
COMPUTE kosten_thuiszorg_tot_T4=SUM (kosten_thuiszorg_HH_T4,kosten_thuiszorg_verzorging_T4,kosten_thuiszorg_verpleging_T4).
EXECUTE.

DO IF MISSING(thuiszorg_T4)=1.
RECODE kosten_thuiszorg_HH_T4,kosten_thuiszorg_verzorging_T4,kosten_thuiszorg_verpleging_T4 kosten_thuiszorg_tot_T4 (SYSMIS=99999).
END IF.
EXECUTE.
MISSING VALUES kosten_thuiszorg_HH_T4,kosten_thuiszorg_verzorging_T4,kosten_thuiszorg_verpleging_T4 kosten_thuiszorg_tot_T4 (99999).
VARIABLE WIDTH kosten_thuiszorg_HH_T4,kosten_thuiszorg_verzorging_T4,kosten_thuiszorg_verpleging_T4 kosten_thuiszorg_tot_T4 (10).
VARIABLE LEVEL kosten_thuiszorg_HH_T4,kosten_thuiszorg_verzorging_T4,kosten_thuiszorg_verpleging_T4 kosten_thuiszorg_tot_T4 (SCALE).

***Kosten medicatie***********************************************************************************************************************************************.
zie aparte syntax.

***Kosten EHBO***********************************************************************************************************************************************.

** ID 3910 geeft bij dagbehandeling 2x ehbo. Aanpassen.
DO IF ID_Code=3910.
RECODE EHBO_aant_keer_T4 (1=2).
END IF.
EXECUTE.

* dd 2017.
COMPUTE kosten_ehbo_T4=EHBO_T4* EHBO_aant_keer_T4*265.

DO IF MISSING (EHBO_T4)=1.
RECODE Kosten_ehbo_T4 (SYSMIS=99999).
END IF.
EXECUTE.
MISSING VALUES kosten_ehbo_T4 (99999).
VARIABLE WIDTH kosten_ehbo_T4 (7).
VARIABLE LEVEL kosten_ehbo_T4 (SCALE).

***Kosten ambulance***********************************************************************************************************************************************.
* dd 2017.
COMPUTE kosten_ambulance_T4=ambulance_T4* ambulance_aant_keer_T4*527.

DO IF MISSING (ambulance_T4)=1.
RECODE Kosten_ambulance_T4 (SYSMIS=99999).
END IF.
EXECUTE.
MISSING VALUES kosten_ambulance_T4 (99999).
VARIABLE WIDTH kosten_ambulance_T4 (7).
VARIABLE LEVEL kosten_ambulance_T4 (SCALE).

***Kosten polibezoek***********************************************************************************************************************************************.

** aanpassingen van polibezoeken die hier niet worden gemeld maar wel bij dagbehandeling.
DO IF ID_Code=1202.
RECODE Poli_T4 (1=2).
RECODE Ziekenhuis1_T4 (''='onbekend'). 
RECODE ZH1_type_T4 (SYSMIS=2).
RECODE Specialisme1_T4 (''='onbekend').
RECODE Spec1_aant_keer_T4  (SYSMIS=2).
RECODE dagbehandeling_T4 (2=1).
RECODE dagbehandeling1_T4 ('rug/heup'='').
RECODE dagbehandeling1_aant_keer_T4 (2=SYSMIS).
END IF.

DO IF ID_Code=1816.
RECODE Poli_T4 (1=2).
RECODE Ziekenhuis1_T4 (''='onbekend'). 
RECODE ZH1_type_T4 (SYSMIS=2).
RECODE Specialisme1_T4 (''='KNO').
RECODE Spec1_aant_keer_T4  (SYSMIS=1).
RECODE dagbehandeling_T4 (2=1).
RECODE dagbehandeling1_T4 ('KNO arts'='').
RECODE dagbehandeling1_aant_keer_T4 (1=SYSMIS).
END IF.

DO IF ID_Code=3110.
RECODE Poli_T4 (1=2).
RECODE Ziekenhuis1_T4 (''='onbekend'). 
RECODE ZH1_type_T4 (SYSMIS=2).
RECODE Specialisme1_T4 (''='onbekend').
RECODE Spec1_aant_keer_T4  (SYSMIS=2).
RECODE dagbehandeling_T4 (2=1).
RECODE dagbehandeling1_T4 ('nekhernia'='').
RECODE dagbehandeling1_aant_keer_T4 (2=SYSMIS).
END IF.
EXECUTE.

DO IF ID_Code=4008.
RECODE Poli_T4 (1=2).
RECODE Ziekenhuis1_T4 (''='onbekend'). 
RECODE ZH1_type_T4 (SYSMIS=2).
RECODE Specialisme1_T4 (''='Oogarts').
RECODE Spec1_aant_keer_T4  (SYSMIS=3).
RECODE dagbehandeling_T4 (2=1).
RECODE dagbehandeling1_T4 ('oogonsteking'='').
RECODE dagbehandeling1_aant_keer_T4 (3=SYSMIS).
END IF.
EXECUTE.

DO IF ID_Code=5114.
RECODE Poli_T4 (1=2).
RECODE Ziekenhuis1_T4 (''='onbekend'). 
RECODE ZH1_type_T4 (SYSMIS=2).
RECODE Specialisme1_T4 (''='onbekend').
RECODE Spec1_aant_keer_T4  (SYSMIS=2).
RECODE dagbehandeling_T4 (2=1).
RECODE dagbehandeling1_T4 ('hernia'='').
RECODE dagbehandeling1_aant_keer_T4 (2=SYSMIS).
END IF.
EXECUTE.

DO IF ID_Code=7002.
RECODE Poli_T4 (1=2).
RECODE Ziekenhuis1_T4 (''='onbekend'). 
RECODE ZH1_type_T4 (SYSMIS=2).
RECODE Specialisme1_T4 (''='onbekend').
RECODE Spec1_aant_keer_T4  (SYSMIS=3).
RECODE dagbehandeling_T4 (2=1).
RECODE dagbehandeling1_T4 ('LUPUS'='').
RECODE dagbehandeling1_aant_keer_T4 (3=SYSMIS).
END IF.
EXECUTE.

DO IF ID_Code=5703.
RECODE Poli_T4 (1=2).
RECODE Ziekenhuis1_T4 (''='onbekend'). 
RECODE ZH1_type_T4 (SYSMIS=2).
RECODE Specialisme1_T4 (''='Psychiatrie').
RECODE Spec1_aant_keer_T4  (SYSMIS=1).
RECODE dagbehandeling_T4 (2=1).
RECODE dagbehandeling1_T4 ('Psychiatrisch'='').
RECODE dagbehandeling1_aant_keer_T4 (1=SYSMIS).
END IF.
EXECUTE.

* tarieven 2017.
RECODE ZH1_type_T4 ZH2_type_T4 ZH3_type_T4 ZH4_type_T4 ZH5_type_T4 (1=167) (2=82) INTO Kosten_per_polibezoek1_temp Kosten_per_polibezoek2_temp 
Kosten_per_polibezoek3_temp Kosten_per_polibezoek4_temp Kosten_per_polibezoek5_temp.
EXECUTE.

COMPUTE kosten1_temp=Kosten_per_polibezoek1_temp * spec1_aant_keer_T4.
COMPUTE kosten2_temp=Kosten_per_polibezoek2_temp * spec2_aant_keer_T4.
COMPUTE kosten3_temp=Kosten_per_polibezoek3_temp * spec3_aant_keer_T4.
COMPUTE kosten4_temp=Kosten_per_polibezoek4_temp * spec4_aant_keer_T4.
COMPUTE kosten5_temp=Kosten_per_polibezoek5_temp * spec5_aant_keer_T4.
COMPUTE kosten_poli_T4=SUM(kosten1_temp,kosten2_temp,kosten3_temp,kosten4_temp,kosten5_temp).
EXECUTE.

DELETE VARIABLES  Kosten_per_polibezoek1_temp Kosten_per_polibezoek2_temp Kosten_per_polibezoek3_temp Kosten_per_polibezoek4_temp Kosten_per_polibezoek5_temp 
kosten1_temp kosten2_temp kosten3_temp kosten4_temp kosten5_temp.

DO IF MISSING (Poli_T4)=1.
RECODE kosten_poli_T4 (SYSMIS=99999).
END IF.
DO IF Poli_T4=1.
RECODE kosten_poli_T4 (SYSMIS=0).
END IF.
EXECUTE.
MISSING VALUES kosten_poli_T4 (99999).
VARIABLE WIDTH kosten_poli_T4 (7).

*** Kosten dagbehandeling********************************************************************************************************************************************.
** omvat ook diagnostiek.

IF  (ID_code=1111 and Dagbehandeling1_T4='maagband verwijderen') kosten_dagbeh1_T4=0.
IF  (ID_code=1503 and Dagbehandeling1_T4='Verwijderen granuloma annulare') kosten_dagbeh1_T4=395.12.
IF  (ID_code=1512 and Dagbehandeling1_T4='injectie tegen pijn') kosten_dagbeh1_T4=563.89.
IF  (ID_code=1813 and Dagbehandeling1_T4='Sarcoïdose') kosten_dagbeh1_T4=0.
IF  (ID_code=1909 and Dagbehandeling1_T4='verwijderen knobbeltje borst') kosten_dagbeh1_T4=717.94.
IF  (ID_code=2205 and Dagbehandeling1_T4='echo') kosten_dagbeh1_T4=95.84.
IF  (ID_code=2410 and Dagbehandeling1_T4='Verwijdering kies') kosten_dagbeh1_T4=87.45.
IF  (ID_code=2502 and Dagbehandeling1_T4='mitella') kosten_dagbeh1_T4=167.01.
IF  (ID_code=2504 and Dagbehandeling1_T4='Gynaecolisch') kosten_dagbeh1_T4=0.
IF  (ID_code=2605 and Dagbehandeling1_T4='Staar operatie') kosten_dagbeh1_T4=1377.05.
IF  (ID_code=2605 and Dagbehandeling2_T4='Glasvochtoperatie') kosten_dagbeh2_T4=2363.90.
IF  (ID_code=2709 and Dagbehandeling1_T4='foto') kosten_dagbeh1_T4=112.24.
IF  (ID_code=2709 and Dagbehandeling2_T4='echo') kosten_dagbeh2_T4=95.84.
IF  (ID_code=2808 and Dagbehandeling1_T4='Prolotherapie') kosten_dagbeh1_T4=56.
IF  (ID_code=2808 and Dagbehandeling2_T4='Pijnbestrijding') kosten_dagbeh2_T4=563.89.
IF  (ID_code=3003 and Dagbehandeling1_T4='vasectomie') kosten_dagbeh1_T4=434.84.
IF  (ID_code=3201 and Dagbehandeling1_T4='admen') kosten_dagbeh1_T4=0.
IF  (ID_code=3205 and Dagbehandeling1_T4='Liesbreuk') kosten_dagbeh1_T4=406.06.
IF  (ID_code=3305 and Dagbehandeling1_T4='Plaatsing Neurostimulator') kosten_dagbeh1_T4=23527.78.
IF  (ID_code=3305 and Dagbehandeling2_T4='Scopie') kosten_dagbeh2_T4=165.69.
IF  (ID_code=3305 and Dagbehandeling3_T4='Verwijdering neurostimulator') kosten_dagbeh3_T4=4389.77.
IF  (ID_code=3305 and Dagbehandeling4_T4='Urodynamisch onderzoek') kosten_dagbeh4_T4=149.75.
IF  (ID_code=3308 and Dagbehandeling1_T4='Vatenscan') kosten_dagbeh1_T4=1274.49.
IF  (ID_code=3505 and Dagbehandeling1_T4='Hartfilmpje') kosten_dagbeh1_T4=113.82.
IF  (ID_code=3607 and Dagbehandeling1_T4='Borstontsteking') kosten_dagbeh1_T4=0.
IF  (ID_code=3609 and Dagbehandeling1_T4='weghalen trichoepitheliomen') kosten_dagbeh1_T4=395.12.
IF  (ID_code=3801 and Dagbehandeling1_T4='katheter verwijderen' ) kosten_dagbeh1_T4=91.84.
IF  (ID_code=3902 and Dagbehandeling1_T4='Toediening infuus') kosten_dagbeh1_T4=0.
IF  (ID_code=3910 and Dagbehandeling1_T4='Ehbo') kosten_dagbeh1_T4=0.
IF  (ID_code=4305 and Dagbehandeling1_T4='neusoperatie') kosten_dagbeh1_T4=276.00.
IF  (ID_code=4701 and Dagbehandeling1_T4='darmonderzoek') kosten_dagbeh1_T4=206.780.
IF  (ID_code=4801 and Dagbehandeling1_T4='scopie maag') kosten_dagbeh1_T4=246.42.
IF  (ID_code=4803 and Dagbehandeling1_T4='botuline injecties') kosten_dagbeh1_T4=0.
IF  (ID_code=4804 and Dagbehandeling1_T4='Wondbehandeling') kosten_dagbeh1_T4=0.
IF  (ID_code=5106 and Dagbehandeling1_T4='overmatige littekenvorming') kosten_dagbeh1_T4=0.
IF  (ID_code=5204 and Dagbehandeling1_T4='Plaatsen spiraaltje') kosten_dagbeh1_T4=363.24.
IF  (ID_code=5308 and Dagbehandeling1_T4='Afspraak') kosten_dagbeh1_T4=0.
IF  (ID_code=5309 and Dagbehandeling1_T4='Controle  cardioloog') kosten_dagbeh1_T4=0.
IF  (ID_code=5309 and Dagbehandeling2_T4='Controle revalidatie arts') kosten_dagbeh2_T4=0.
IF  (ID_code=5309 and Dagbehandeling3_T4='Controle neuroloog') kosten_dagbeh3_T4=0.
IF  (ID_code=5802 and Dagbehandeling1_T4='spuitje') kosten_dagbeh1_T4=33.
IF  (ID_code=5802 and Dagbehandeling2_T4='spuitje') kosten_dagbeh2_T4=33.
IF  (ID_code=5802 and Dagbehandeling3_T4='spuitje') kosten_dagbeh3_T4=33.
IF  (ID_code=5902 and Dagbehandeling1_T4='Endoscopie') kosten_dagbeh1_T4=261.45.
IF  (ID_code=5902 and Dagbehandeling2_T4='Scan') kosten_dagbeh2_T4=241.10.
IF  (ID_code=5904 and Dagbehandeling1_T4='Operatie neus en bijholte') kosten_dagbeh1_T4=276.00.
IF  (ID_code=6108 and Dagbehandeling1_T4='Slokdarm en maag onderzoek') kosten_dagbeh1_T4=261.45.
IF  (ID_code=6210 and Dagbehandeling1_T4='Foto gebroken ribben') kosten_dagbeh1_T4=112.24.
IF  (ID_code=6404 and Dagbehandeling1_T4='onderzoek vergeetpoli') kosten_dagbeh1_T4=0.
IF  (ID_code=6404 and Dagbehandeling2_T4='MRi-scan') kosten_dagbeh2_T4=241.10.
IF  (ID_code=6404 and Dagbehandeling3_T4='psychologische test') kosten_dagbeh3_T4=0.
IF  (ID_code=6404 and Dagbehandeling4_T4='apneu-onderzoek') kosten_dagbeh4_T4=167.12.
IF  (ID_code=6408 and Dagbehandeling1_T4='darmonderzoek') kosten_dagbeh1_T4=206.78.
IF  (ID_code=6412 and Dagbehandeling1_T4='Ct scan') kosten_dagbeh1_T4=139.
IF  (ID_code=6412 and Dagbehandeling2_T4='Echo') kosten_dagbeh2_T4=95.84.
IF  (ID_code=6809 and Dagbehandeling1_T4='Sterilisatie') kosten_dagbeh1_T4=434.84.
IF  (ID_code=6810 and Dagbehandeling1_T4='Chirurgie (Navelbreuk)') kosten_dagbeh1_T4=583.14.
IF  (ID_code=6902 and Dagbehandeling1_T4='Endoscopie') kosten_dagbeh1_T4=261.45.
IF  (ID_code=7003 and Dagbehandeling1_T4='kaakchirurg') kosten_dagbeh1_T4=87.45.
IF  (ID_code=7013 and Dagbehandeling1_T4='Zometa infuus') kosten_dagbeh1_T4=167.01.
IF  (ID_code=7014 and Dagbehandeling1_T4='controle') kosten_dagbeh1_T4=0.
IF  (ID_code=7105 and Dagbehandeling1_T4='kaakchirurg') kosten_dagbeh1_T4=87.45.
EXECUTE.

* Indien dagbehandeling=ja maar verder (soort dagbehandeling en aantal keer) niets ingevuld --> laagste kosten berekenen = 56.
IF (dagbehandeling_T4=2 and dagbehandeling1_T4=' ') kosten_dagbeh1_T4=56.
IF (dagbehandeling_T4=2 and dagbehandeling1_T4=' ') Dagbehandeling1_aant_keer_T4=1.
EXECUTE.

VARIABLE WIDTH Dagbehandeling1_T4 Dagbehandeling2_T4 Dagbehandeling3_T4 Dagbehandeling4_T4 (20).
VARIABLE WIDTH kosten_dagbeh1_T4 kosten_dagbeh2_T4 kosten_dagbeh3_T4 kosten_dagbeh4_T4  (7).
VARIABLE WIDTH Dagbehandeling1_aant_keer_T4 Dagbehandeling2_aant_keer_T4 Dagbehandeling3_aant_keer_T4 Dagbehandeling4_aant_keer_T4 (13). 
 * inclusief correctie voor 2018: +1.4%.
COMPUTE kosten_dagheb1_tot_T4=((kosten_dagbeh1_T4 * Dagbehandeling1_aant_keer_T4)/100)*101.4.
COMPUTE kosten_dagheb2_tot_T4=((kosten_dagbeh2_T4 * Dagbehandeling2_aant_keer_T4)/100)*101.4.
COMPUTE kosten_dagheb3_tot_T4=((kosten_dagbeh3_T4 * Dagbehandeling3_aant_keer_T4)/100)*101.4.
COMPUTE kosten_dagheb4_tot_T4=((kosten_dagbeh4_T4 * Dagbehandeling4_aant_keer_T4)/100)*101.4.
EXECUTE.
COMPUTE kosten_dagbeh_tot_T4=SUM(kosten_dagheb1_tot_T4,kosten_dagheb2_tot_T4,kosten_dagheb3_tot_T4,kosten_dagheb4_tot_T4).
EXECUTE.

DO IF MISSING(dagbehandeling_T4)=1.
RECODE kosten_dagbeh_tot_T4 (SYSMIS=99999).
END IF.
EXECUTE.
DO IF dagbehandeling_T4=1.
RECODE kosten_dagbeh_tot_T4 (SYSMIS=0).
END IF.
EXECUTE.
MISSING VALUES kosten_dagbeh_tot_T4 (99999).
VARIABLE WIDTH kosten_dagbeh_tot_T4 (9).
DELETE VARIABLES kosten_dagheb1_tot_T4 kosten_dagheb2_tot_T4 kosten_dagheb3_tot_T4 kosten_dagheb4_tot_T4.

** Kosten opname**********************************************************************************************************************************************************************

*Indien opname ja en aantal dagen missing-->aantal dagen=1.
DO IF opname_ZH_T4=1.
RECODE opname_ZH_aant_dagen_T4 (SYSMIS=1).
END IF.
EXECUTE.

* tarieven 2017.
COMPUTE kosten_opname_ZH_T4=487*opname_ZH_aant_dagen_T4.
COMPUTE kosten_opname_rev_T4=471*opname_rev_aant_dagen_T4.
COMPUTE kosten_opname_psy_T4=309*opname_psy_aant_dagen_T4.
EXECUTE.

DO IF MISSING(opname_ZH_T4)=1.
RECODE kosten_opname_ZH_T4 (SYSMIS=99999).
END IF.
DO IF MISSING(opname_rev_T4)=1.
RECODE kosten_opname_rev_T4 (SYSMIS=99999).
END IF.
DO IF MISSING(opname_psy_T4)=1.
RECODE kosten_opname_psy_T4 (SYSMIS=99999).
END IF.
EXECUTE.

DO IF opname_ZH_T4=2.
RECODE kosten_opname_ZH_T4 (SYSMIS=0).
END IF.
DO IF opname_rev_T4=2.
RECODE kosten_opname_rev_T4 (SYSMIS=0).
END IF.
DO IF opname_psy_T4=2.
RECODE kosten_opname_psy_T4 (SYSMIS=0).
END IF.
EXECUTE.

MISSING VALUES kosten_opname_ZH_T4  kosten_opname_rev_T4  kosten_opname_psy_T4 (99999).
VARIABLE LEVEL kosten_opname_ZH_T4  kosten_opname_rev_T4  kosten_opname_psy_T4 (SCALE).
VARIABLE WIDTH kosten_opname_ZH_T4  kosten_opname_rev_T4  kosten_opname_psy_T4 (11).

COMPUTE kosten_opname_tot_T4=SUM (kosten_opname_ZH_T4,kosten_opname_rev_T4,kosten_opname_psy_T4).
EXECUTE.
RECODE kosten_opname_tot_T4 (SYSMIS=99999).
EXECUTE.

MISSING VALUES kosten_opname_tot_T4 (99999).
VARIABLE LEVEL kosten_opname_tot_T4 (SCALE).
VARIABLE WIDTH kosten_opname_tot_T4 (11).


** reiskosten**************************************************************************************************************************************************************************************.

** HA en POH: 1,1 km per bezoek x 0.19 + 3.07 parkeerkosten.
COMPUTE temp_aant_HA_POH= SUM(consult1_T4, consult2_T4).
COMPUTE reiskosten_HA_POH_T4= (temp_aant_HA_POH * 1.1 * 0.19) + (temp_aant_HA_POH * 3.07).
EXECUTE.
RECODE reiskosten_HA_POH_T4 (SYSMIS=99999).
EXECUTE.
DELETE VARIABLES temp_aant_HA_POH.
VARIABLE LABELS reiskosten_HA_POH_T4 'reiskosten HA en POH'.

** Fysio en overige paramedische consulten: 2,3 km per bezoek x 0.19 + 3.07 parkeerkosten.
COMPUTE temp_aant_param= SUM(consult3_T4, consult4_T4, consult5_T4, consult6_T4, consult7_T4, consult8_T4, consult9_T4, consult10_T4, consult11_T4, consult12_T4, consult13_T4, consult14_T4).
COMPUTE reiskosten_param_T4= (temp_aant_param * 2.2 * 0.19) + (temp_aant_param * 3.07).
EXECUTE.
RECODE reiskosten_param_T4 (SYSMIS=99999).
EXECUTE.
DELETE VARIABLES temp_aant_param.
VARIABLE LABELS reiskosten_param_T4 'reiskosten alle paramedische consulten'.

** Per polibezoek,  per dagbehandeling en per EHBO 7,0 km per bezoek x 0.19 + 3.07 parkeerkosten.
COMPUTE temp_aant_ZH= SUM( EHBO_aant_keer_T4,  spec1_aant_keer_T4,  spec2_aant_keer_T4,  spec3_aant_keer_T4,  spec4_aant_keer_T4,  spec5_aant_keer_T4, 
Dagbehandeling1_aant_keer_T4,  Dagbehandeling2_aant_keer_T4, Dagbehandeling3_aant_keer_T4, Dagbehandeling4_aant_keer_T4).
COMPUTE reiskosten_ZH_T4= (temp_aant_ZH * 7.0 * 0.19) + (temp_aant_ZH * 3.07).
EXECUTE.
RECODE reiskosten_ZH_T4 (SYSMIS=99999).
EXECUTE.
DELETE VARIABLES temp_aant_ZH.
VARIABLE LABELS reiskosten_ZH_T4 'reiskosten EHBO, poli en dagbehandeling'.

* Apotheek: indien medicatie gebruikt: 1 apotheekbezoek per vragenlijst rekenen.
DO IF medicatie_T4=2.
COMPUTE reiskosten_apo_T4= (1.3 * 0.19) + 3.07.
END IF.
DO IF medicatie_T4=1.
COMPUTE reiskosten_apo_T4= 0.
END IF.
RECODE reiskosten_apo_T4 (SYSMIS=99999).
EXECUTE.
VARIABLE LABELS reiskosten_apo_T4 'reiskosten apotheek'.

MISSING VALUES  reiskosten_HA_POH_T4 reiskosten_param_T4 reiskosten_ZH_T4 reiskosten_apo_T4 (99999).

*** Totale reiskosten.
COMPUTE reiskosten_tot_T4 = SUM (reiskosten_HA_POH_T4, reiskosten_param_T4, reiskosten_ZH_T4, reiskosten_apo_T4).
EXECUTE.
RECODE reiskosten_tot_T4 (SYSMIS=99999).
EXECUTE.


** indien verkorte lijst ingevuld: reiskosten zijn missing (soms staan er toch kosten vanwege stoppen met roken begeleiding en medicatie, wat wel gevraagd is).
IF (papier_T4=2) reiskosten_HA_POH_T4=99999.
IF (papier_T4=2) reiskosten_param_T4=99999.
IF (papier_T4=2) reiskosten_ZH_T4=99999.
IF (papier_T4=2) reiskosten_apo_T4=99999.
IF (papier_T4=2) reiskosten_tot_T4=99999.
EXECUTE.


VARIABLE WIDTH reiskosten_HA_POH_T4 reiskosten_param_T4 reiskosten_ZH_T4 reiskosten_apo_T4 reiskosten_tot_T4 (9).
VARIABLE LEVEL reiskosten_HA_POH_T4 reiskosten_param_T4 reiskosten_ZH_T4 reiskosten_apo_T4 reiskosten_tot_T4 (SCALE).
MISSING VALUES reiskosten_tot_T4 (99999).



