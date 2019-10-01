* Encoding: UTF-8.

** Kosten consulten eerste lijn*************************************************************************************************************************************.

** ID 5904. 4 consulten psycholoog gemeld bij dagbehandeling.
DO IF ID_code=5904.
RECODE consult12_T0 (0=4).
RECODE dagbehandeling_T0 (2=1).
RECODE dagbehandeling1_T0 ('psycholoog'='').
RECODE dagbehandeling1_aant_keer_T0 (4=SYSMIS).
END IF.
EXECUTE.
* tarieven dd 2017.
COMPUTE kosten_consult1_T0=consult1_T0*34.
COMPUTE kosten_consult2_T0=consult2_T0*17.
COMPUTE kosten_consult3_T0=consult3_T0*67.
COMPUTE kosten_consult4_T0=consult4_T0*105.
COMPUTE kosten_consult5_T0=consult5_T0*34.
COMPUTE kosten_consult6_T0=consult6_T0*31.
COMPUTE kosten_consult7_T0=consult7_T0*34.
COMPUTE kosten_consult8_T0=consult8_T0*20.
COMPUTE kosten_consult9_T0=consult9_T0*31.
COMPUTE kosten_consult10_T0=consult10_T0*45.
COMPUTE kosten_consult11_T0=consult11_T0*34.
COMPUTE kosten_consult12_T0=consult12_T0*65.
COMPUTE kosten_consult13_T0=consult13_T0*26.
COMPUTE kosten_consult14_T0=consult14_T0*24.
EXECUTE.

DO IF MISSING (consult1_T0)=1.
RECODE Kosten_consult1_T0 (SYSMIS=99999).
END IF.
DO IF MISSING (consult2_T0)=1.
RECODE Kosten_consult2_T0 (SYSMIS=99999).
END IF.
DO IF MISSING (consult3_T0)=1.
RECODE Kosten_consult3_T0 (SYSMIS=99999).
END IF.
DO IF MISSING (consult4_T0)=1.
RECODE Kosten_consult4_T0 (SYSMIS=99999).
END IF.
DO IF MISSING (consult5_T0)=1.
RECODE Kosten_consult5_T0 (SYSMIS=99999).
END IF.
DO IF MISSING (consult6_T0)=1.
RECODE Kosten_consult6_T0 (SYSMIS=99999).
END IF.
DO IF MISSING (consult7_T0)=1.
RECODE Kosten_consult7_T0 (SYSMIS=99999).
END IF.
DO IF MISSING (consult8_T0)=1.
RECODE Kosten_consult8_T0 (SYSMIS=99999).
END IF.
DO IF MISSING (consult9_T0)=1.
RECODE Kosten_consult9_T0 (SYSMIS=99999).
END IF.
DO IF MISSING (consult10_T0)=1.
RECODE Kosten_consult10_T0 (SYSMIS=99999).
END IF.
DO IF MISSING (consult11_T0)=1.
RECODE Kosten_consult11_T0 (SYSMIS=99999).
END IF.
DO IF MISSING (consult12_T0)=1.
RECODE Kosten_consult12_T0 (SYSMIS=99999).
END IF.
DO IF MISSING (consult13_T0)=1.
RECODE Kosten_consult13_T0 (SYSMIS=99999).
END IF.
DO IF MISSING (consult14_T0)=1.
RECODE Kosten_consult14_T0 (SYSMIS=99999).
END IF.
EXECUTE.
MISSING VALUES kosten_consult1_T0   kosten_consult2_T0  kosten_consult3_T0  kosten_consult4_T0  kosten_consult5_T0  kosten_consult6_T0 
 kosten_consult7_T0  kosten_consult8_T0  kosten_consult9_T0  kosten_consult10_T0  kosten_consult11_T0  kosten_consult12_T0 
 kosten_consult13_T0  kosten_consult14_T0 (99999).
VARIABLE WIDTH kosten_consult1_T0   kosten_consult2_T0  kosten_consult3_T0  kosten_consult4_T0  kosten_consult5_T0  kosten_consult6_T0 
 kosten_consult7_T0  kosten_consult8_T0  kosten_consult9_T0  kosten_consult10_T0  kosten_consult11_T0  kosten_consult12_T0 
 kosten_consult13_T0  kosten_consult14_T0 (7).
VARIABLE LEVEL kosten_consult1_T0   kosten_consult2_T0  kosten_consult3_T0  kosten_consult4_T0  kosten_consult5_T0  kosten_consult6_T0 
 kosten_consult7_T0  kosten_consult8_T0  kosten_consult9_T0  kosten_consult10_T0  kosten_consult11_T0  kosten_consult12_T0 
 kosten_consult13_T0  kosten_consult14_T0 (SCALE).

COMPUTE kosten_GP_T0=kosten_consult1_T0.
COMPUTE kosten_occ_pract_T0=kosten_consult4_T0.
COMPUTE kosten_stop_roken_begl_T0=kosten_consult7_T0.
COMPUTE kosten_other_care_T0=SUM(kosten_consult2_T0,kosten_consult3_T0,kosten_consult5_T0, kosten_consult6_T0, kosten_consult8_T0,  
kosten_consult9_T0, kosten_consult10_T0,kosten_consult11_T0,kosten_consult12_T0,kosten_consult13_T0, kosten_consult14_T0).
EXECUTE.

RECODE kosten_GP_T0 kosten_occ_pract_T0 kosten_stop_roken_begl_T0 kosten_other_care_T0 (SYSMIS=99999).
EXECUTE.
MISSING VALUES kosten_GP_T0 kosten_occ_pract_T0 kosten_stop_roken_begl_T0 kosten_other_care_T0 (99999).
VARIABLE WIDTH  kosten_GP_T0 kosten_occ_pract_T0 kosten_stop_roken_begl_T0 kosten_other_care_T0 (10).
VARIABLE LEVEL  kosten_GP_T0 kosten_occ_pract_T0 kosten_stop_roken_begl_T0 kosten_other_care_T0(SCALE).

VARIABLE LABELS kosten_GP_T0 'kosten GP T0' kosten_occ_pract_T0 'kosten occupational practitioner T0' 
kosten_stop_roken_begl_T0 'kosten stoppen met roken begeleiding consulten T0' kosten_other_care_T0 'kosten other care consults T0'.

***Kosten thuiszorg ***********************************************************************************************************************************************.
* dd 2017.
COMPUTE kosten_thuiszorg_hh_T0= thuiszorg_hh_weken_T0 * thuiszorg_hh_uur_T0 * 20.
COMPUTE kosten_thuiszorg_verzorging_T0= thuiszorg_verzorging_weken_T0 * thuiszorg_verzorging_uur_T0 * 51.
COMPUTE kosten_thuiszorg_verpleging_T0= thuiszorg_verpleging_weken_T0 * thuiszorg_verpleging_uur_T0 * 75.
COMPUTE kosten_thuiszorg_tot_T0=SUM (kosten_thuiszorg_HH_T0,kosten_thuiszorg_verzorging_T0,kosten_thuiszorg_verpleging_T0).
EXECUTE.

DO IF MISSING(thuiszorg_T0)=1.
RECODE kosten_thuiszorg_HH_T0,kosten_thuiszorg_verzorging_T0,kosten_thuiszorg_verpleging_T0 kosten_thuiszorg_tot_T0 (SYSMIS=99999).
END IF.
EXECUTE.
MISSING VALUES kosten_thuiszorg_HH_T0,kosten_thuiszorg_verzorging_T0,kosten_thuiszorg_verpleging_T0 kosten_thuiszorg_tot_T0 (99999).
VARIABLE WIDTH kosten_thuiszorg_HH_T0,kosten_thuiszorg_verzorging_T0,kosten_thuiszorg_verpleging_T0 kosten_thuiszorg_tot_T0 (10).
VARIABLE LEVEL kosten_thuiszorg_HH_T0,kosten_thuiszorg_verzorging_T0,kosten_thuiszorg_verpleging_T0 kosten_thuiszorg_tot_T0 (SCALE).



***Kosten medicatie***********************************************************************************************************************************************.
zie aparte syntax.

***Kosten EHBO***********************************************************************************************************************************************.
*dd 2017.
COMPUTE kosten_ehbo_T0=EHBO_T0* EHBO_aant_keer_T0*265.

DO IF MISSING (EHBO_T0)=1.
RECODE Kosten_ehbo_T0 (SYSMIS=99999).
END IF.
EXECUTE.
MISSING VALUES kosten_ehbo_T0 (99999).
VARIABLE LEVEL kosten_ehbo_T0 (SCALE).
VARIABLE WIDTH kosten_ehbo_T0 (7).

***Kosten ambulance***********************************************************************************************************************************************.
*dd 2017.
COMPUTE kosten_ambulance_T0=ambulance_T0* ambulance_aant_keer_T0*527.

DO IF MISSING (ambulance_T0)=1.
RECODE Kosten_ambulance_T0 (SYSMIS=99999).
END IF.
EXECUTE.
MISSING VALUES kosten_ambulance_T0 (99999).
VARIABLE LEVEL kosten_ambulance_T0 (SCALE).
VARIABLE WIDTH kosten_ambulance_T0 (7).

***Kosten polibezoek***********************************************************************************************************************************************.

** aanpassingen van polibezoeken die hier niet worden gemeld maar wel bij dagbehandeling.
DO IF ID_Code=1915.
RECODE Poli_T0 (1=2).
RECODE Ziekenhuis1_T0 (''='onbekend'). 
RECODE ZH1_type_T0 (SYSMIS=2).
RECODE Specialisme1_T0 (''='Oogarts').
RECODE Spec1_aant_keer_T0  (SYSMIS=4).
RECODE dagbehandeling_T0 (2=1).
RECODE dagbehandeling1_T0 ('Oogarts'='').
RECODE dagbehandeling1_aant_keer_T0 (4=SYSMIS).
END IF.

DO IF ID_Code=3507.
RECODE Poli_T0 (1=2).
RECODE Ziekenhuis1_T0 (''='onbekend'). 
RECODE ZH1_type_T0 (SYSMIS=2).
RECODE Specialisme1_T0 (''='onbekend').
RECODE Spec1_aant_keer_T0  (SYSMIS=1).
RECODE dagbehandeling_T0 (2=1).
RECODE dagbehandeling1_T0 ('controle sleeveoperatie'='').
RECODE dagbehandeling1_aant_keer_T0 (1=SYSMIS).
END IF.

DO IF ID_Code=1815.
RECODE Poli_T0 (1=2).
RECODE Ziekenhuis1_T0 (''='onbekend'). 
RECODE ZH1_type_T0 (SYSMIS=2).
RECODE Specialisme1_T0 (''='onbekend').
RECODE Spec1_aant_keer_T0  (SYSMIS=1).
RECODE dagbehandeling_T0 (2=1).
RECODE dagbehandeling1_T0 ('Teennagel verwijderen'='').
RECODE dagbehandeling1_aant_keer_T0 (1=SYSMIS).
END IF.

* tarieven 2017.
RECODE ZH1_type_T0 ZH2_type_T0 ZH3_type_T0 ZH4_type_T0 (1=167) (2=82) INTO Kosten_per_polibezoek1_temp Kosten_per_polibezoek2_temp 
Kosten_per_polibezoek3_temp Kosten_per_polibezoek4_temp.
EXECUTE.

COMPUTE kosten1_temp=Kosten_per_polibezoek1_temp * spec1_aant_keer_T0.
COMPUTE kosten2_temp=Kosten_per_polibezoek2_temp * spec2_aant_keer_T0.
COMPUTE kosten3_temp=Kosten_per_polibezoek3_temp * spec3_aant_keer_T0.
COMPUTE kosten4_temp=Kosten_per_polibezoek4_temp * spec4_aant_keer_T0.
COMPUTE kosten_poli_T0=SUM (kosten1_temp,kosten2_temp,kosten3_temp,kosten4_temp).
EXECUTE.

DELETE VARIABLES  Kosten_per_polibezoek1_temp Kosten_per_polibezoek2_temp 
Kosten_per_polibezoek3_temp Kosten_per_polibezoek4_temp kosten1_temp kosten2_temp kosten3_temp kosten4_temp.

DO IF MISSING (Poli_T0)=1.
RECODE kosten_poli_T0 (SYSMIS=99999).
END IF.
DO IF Poli_T0=1.
RECODE kosten_poli_T0 (SYSMIS=0).
END IF.
EXECUTE.
MISSING VALUES kosten_poli_T0 (99999).

VARIABLE WIDTH kosten_poli_T0 (7).

*** Kosten dagbehandeling********************************************************************************************************************************************.
** omvat ook diagnostiek.
** dit zijn tarieven 2016. Wordt onderaan syntax gecorrigeerd.
IF  (ID_code=1117 and Dagbehandeling1_T0='Echoscopie') kosten_dagbeh1_T0=95.84.
IF  (ID_code=1202 and Dagbehandeling1_T0='cô diabetes') kosten_dagbeh1_T0=0.
IF  (ID_code=1202 and Dagbehandeling2_T0='mri scan') kosten_dagbeh2_T0=241.10.
IF  (ID_code=1204 and Dagbehandeling1_T0='operatie pols en vinger') kosten_dagbeh1_T0=276.
IF  (ID_code=1204 and Dagbehandeling2_T0='behandeling rls') kosten_dagbeh2_T0=276.
IF  (ID_code=1208 and Dagbehandeling1_T0='zometa infuus') kosten_dagbeh1_T0=0.
IF  (ID_code=1208 and Dagbehandeling2_T0='controle borstkanker')  kosten_dagbeh2_T0=0.
IF  (ID_code=1303 and Dagbehandeling1_T0='Longfunkunctie') kosten_dagbeh1_T0=60.32.
IF  (ID_code=1303 and Dagbehandeling2_T0='Slaap apneu') kosten_dagbeh2_T0=167.12.
IF  (ID_code=1303 and Dagbehandeling3_T0='Schouderklachten') kosten_dagbeh3_T0=48.74.
IF  (ID_code=1509 and Dagbehandeling1_T0='MRI') kosten_dagbeh1_T0=241.10.
IF  (ID_code=1510 and Dagbehandeling1_T0='dikke darm onderzoek') kosten_dagbeh1_T0=186.66.
IF  (ID_code=1606 and Dagbehandeling1_T0='blindedarm')  kosten_dagbeh1_T0=0.
IF  (ID_code=1606 and Dagbehandeling2_T0='appendix')  kosten_dagbeh2_T0=0.
IF  (ID_code=1708 and Dagbehandeling1_T0='Echografie') kosten_dagbeh1_T0=95.84.
IF  (ID_code=1813 and Dagbehandeling1_T0='Barron ligatie') kosten_dagbeh1_T0=535.56.
IF  (ID_code=1904 and Dagbehandeling1_T0='ooglaseren') kosten_dagbeh1_T0=0.
IF  (ID_code=1911 and Dagbehandeling1_T0='onbekend') kosten_dagbeh1_T0=276.
IF  (ID_code=1911 and Dagbehandeling1_T0='onbekend') Dagbehandeling1_aant_keer_T0=1.
IF  (ID_code=2010 and Dagbehandeling1_T0='rontgenfoto') kosten_dagbeh1_T0=112.24.
IF  (ID_code=2010 and Dagbehandeling2_T0='kaakchirurg') kosten_dagbeh2_T0=87.45.
IF  (ID_code=2011 and Dagbehandeling1_T0='ZIEKENHUIS') kosten_dagbeh1_T0=0.
IF  (ID_code=2011 and Dagbehandeling2_T0='CONTROLE') kosten_dagbeh2_T0=0.
IF  (ID_code=2011 and Dagbehandeling3_T0='CONTROLE') kosten_dagbeh3_T0=0.
IF  (ID_code=2011 and Dagbehandeling4_T0='CONTROLE') kosten_dagbeh4_T0=0.
IF  (ID_code=2011 and Dagbehandeling5_T0='UITSLAG') kosten_dagbeh5_T0=0.
IF  (ID_code=2303 and CHAR.INDEX(Dagbehandeling1_T0,'hart')>0 ) kosten_dagbeh1_T0=113.82.
IF  (ID_code=2303 and Dagbehandeling2_T0='inspanningstest') kosten_dagbeh2_T0=112.88.
IF  (ID_code=2403 and Dagbehandeling1_T0='endoscopie') kosten_dagbeh1_T0=261.45.
IF  (ID_code=2404 and Dagbehandeling1_T0='MRI') kosten_dagbeh1_T0=241.10.
IF  (ID_code=2405 and Dagbehandeling1_T0='chirurgische ingreep kaakchirurg') kosten_dagbeh1_T0=87.45.
IF  (ID_code=2502 and Dagbehandeling1_T0='Lik doorn verwijdere') kosten_dagbeh1_T0=91.84.
IF  (ID_code=2502 and Dagbehandeling2_T0='Pijnlijke hand') kosten_dagbeh2_T0=0.
IF  (ID_code=2602 and Dagbehandeling1_T0='gebroken voet')  kosten_dagbeh1_T0=0.
IF  (ID_code=2707 and Dagbehandeling1_T0='CAG') kosten_dagbeh1_T0=606.
IF  (ID_code=2707 and Dagbehandeling2_T0='Echo Cor') kosten_dagbeh2_T0=113.82.
IF  (ID_code=2707 and Dagbehandeling3_T0='Holter') kosten_dagbeh3_T0=128.50.
IF  (ID_code=2805 and Dagbehandeling1_T0='Brongoscopie') kosten_dagbeh1_T0=150.59.
IF  (ID_code=2808 and Dagbehandeling1_T0='apneu test') kosten_dagbeh1_T0=142.22.
IF  (ID_code=2904 and Dagbehandeling1_T0='Chemo') kosten_dagbeh1_T0=112.24.
IF  (ID_code=3305 and Dagbehandeling1_T0='Kijk onderzoek') kosten_dagbeh1_T0=276.
IF  (ID_code=3404 and Dagbehandeling1_T0='Oor schoonmaken') kosten_dagbeh1_T0=0.
IF  (ID_code=3404 and Dagbehandeling2_T0='Controle oor') kosten_dagbeh2_T0=0.
IF  (ID_code=3409 and Dagbehandeling1_T0='rontgenfoto') kosten_dagbeh1_T0=112.24.
IF  (ID_code=3409 and Dagbehandeling2_T0='mri') kosten_dagbeh2_T0=241.10.
IF  (ID_code=3414 and Dagbehandeling1_T0='gesprek')  kosten_dagbeh1_T0=0.
IF  (ID_code=3902 and Dagbehandeling1_T0='toediening medicatie via infuus') kosten_dagbeh1_T0=0.
IF  (ID_code=3903 and Dagbehandeling1_T0='Controle')  kosten_dagbeh1_T0=0.
IF  (ID_code=3903 and Dagbehandeling2_T0='Onderzoeken en operatie') kosten_dagbeh2_T0=276.
IF  (ID_code=4206 and Dagbehandeling1_T0='erisypelas')  kosten_dagbeh1_T0=0.
IF  (ID_code=4305 and Dagbehandeling1_T0='gesprek')  kosten_dagbeh1_T0=0.
IF  (ID_code=4305 and Dagbehandeling2_T0='onderzoek')  kosten_dagbeh2_T0=0.
IF  (ID_code=4305 and Dagbehandeling3_T0='carpaal tunnel syndroom operatie') kosten_dagbeh3_T0=750.72.
IF  (ID_code=4803 and Dagbehandeling1_T0='botuline injectie') kosten_dagbeh1_T0=0.
IF  (ID_code=4903 and Dagbehandeling1_T0='onbekend') kosten_dagbeh1_T0=276.
IF  (ID_code=4903 and Dagbehandeling1_T0='onbekend') Dagbehandeling1_aant_keer_T0=1.
IF  (ID_code=4905 and Dagbehandeling1_T0='Psioriases') kosten_dagbeh1_T0=0.
IF  (ID_code=4905 and Dagbehandeling2_T0='Botontkalking') kosten_dagbeh2_T0=0.
IF  (ID_code=5103 and Dagbehandeling1_T0='Kies trekken') kosten_dagbeh1_T0=87.45.
IF  (ID_code=5105 and Dagbehandeling1_T0='onbekend') kosten_dagbeh1_T0=276.
IF  (ID_code=5105 and Dagbehandeling1_T0='onbekend') Dagbehandeling1_aant_keer_T0=1.
IF  (ID_code=5107 and Dagbehandeling1_T0='huidaandoening') kosten_dagbeh1_T0=0.
IF  (ID_code=5206 and Dagbehandeling1_T0='controle pancresakanker') kosten_dagbeh1_T0=0.
IF  (ID_code=5206 and Dagbehandeling2_T0='controle diabetici') kosten_dagbeh2_T0=0.
IF  (ID_code=5206 and Dagbehandeling3_T0='hypo suiker') kosten_dagbeh3_T0=0.
IF  (ID_code=5605 and Dagbehandeling1_T0='Controle Longarts') kosten_dagbeh1_T0=0.
IF  (ID_code=5605 and Dagbehandeling2_T0='1e afspraak KNO arts') kosten_dagbeh2_T0=0.
IF  (ID_code=5305 and Dagbehandeling1_T0='sterilisatie') kosten_dagbeh1_T0=434.84.
IF  (ID_code=5812 and Dagbehandeling1_T0='onbekend') kosten_dagbeh1_T0=276.
IF  (ID_code=5812 and Dagbehandeling1_T0='onbekend') Dagbehandeling1_aant_keer_T0=1.
IF  (ID_code=5906 and Dagbehandeling1_T0='hartritmestoornis') kosten_dagbeh1_T0=0.
IF  (ID_code=6004 and Dagbehandeling1_T0='ongedaan maken van sterilisatie') kosten_dagbeh1_T0=3529.65.
IF  (ID_code=6006 and Dagbehandeling1_T0='rontgenfoto') kosten_dagbeh1_T0=112.24.
IF  (ID_code=6006 and Dagbehandeling2_T0='Botscan') kosten_dagbeh2_T0=241.10.
IF  (ID_code=6006 and Dagbehandeling3_T0='uitslag en gips') kosten_dagbeh3_T0=0.
IF  (ID_code=6302 and Dagbehandeling1_T0='slaapapneu') kosten_dagbeh1_T0=142.22.
IF  (ID_code=6505 and Dagbehandeling1_T0='Prostaat') kosten_dagbeh1_T0=0.
IF  (ID_code=6505 and Dagbehandeling2_T0='Catheter') kosten_dagbeh2_T0=0.
IF  (ID_code=6605 and Dagbehandeling1_T0='Röntgen foto') kosten_dagbeh1_T0=112.24.
IF  (ID_code=6904 and Dagbehandeling1_T0='Hand gebroken') kosten_dagbeh1_T0=0.
IF  (ID_code=7002 and Dagbehandeling1_T0='galstenen') kosten_dagbeh1_T0=0.
IF  (ID_code=7002 and Dagbehandeling2_T0='gedotterd') kosten_dagbeh2_T0=0.
IF  (ID_code=7016 and Dagbehandeling1_T0='Beenbreuk') kosten_dagbeh1_T0=0.
IF  (ID_code=7114 and Dagbehandeling1_T0='hersenschudding') kosten_dagbeh1_T0=0.
IF  (ID_code=7114 and Dagbehandeling2_T0='collumpijn na val') kosten_dagbeh2_T0=0.
EXECUTE.
VARIABLE WIDTH kosten_dagbeh1_T0 kosten_dagbeh2_T0 kosten_dagbeh3_T0 kosten_dagbeh4_T0 kosten_dagbeh5_T0 (9).
VARIABLE LEVEL kosten_dagbeh1_T0 kosten_dagbeh2_T0 kosten_dagbeh3_T0 kosten_dagbeh4_T0 kosten_dagbeh5_T0 (SCALE).

 * inclusief correctie voor 2018: +1.4%.
COMPUTE kosten_dagbeh1_tot_T0=((kosten_dagbeh1_T0 * Dagbehandeling1_aant_keer_T0)/100)*101.4.
COMPUTE kosten_dagbeh2_tot_T0=((kosten_dagbeh2_T0 * Dagbehandeling2_aant_keer_T0)/100)*101.4.
COMPUTE kosten_dagbeh3_tot_T0=((kosten_dagbeh3_T0 * Dagbehandeling3_aant_keer_T0)/100)*101.4.
COMPUTE kosten_dagbeh4_tot_T0=((kosten_dagbeh4_T0 * Dagbehandeling4_aant_keer_T0)/100)*101.4.
COMPUTE kosten_dagbeh5_tot_T0=((kosten_dagbeh5_T0 * Dagbehandeling5_aant_keer_T0)/100)*101.4.
EXECUTE.
COMPUTE kosten_dagbeh_tot_T0=SUM(kosten_dagbeh1_tot_T0,kosten_dagbeh2_tot_T0,kosten_dagbeh3_tot_T0,kosten_dagbeh4_tot_T0,kosten_dagbeh5_tot_T0).
EXECUTE.

DELETE VARIABLES kosten_dagbeh1_tot_T0,kosten_dagbeh2_tot_T0,kosten_dagbeh3_tot_T0,kosten_dagbeh4_tot_T0,kosten_dagbeh5_tot_T0.

DO IF MISSING(dagbehandeling_T0)=1.
RECODE kosten_dagbeh_tot_T0 (SYSMIS=99999).
END IF.
EXECUTE.
DO IF dagbehandeling_T0=1.
RECODE kosten_dagbeh_tot_T0 (SYSMIS=0).
END IF.
EXECUTE.
MISSING VALUES kosten_dagbeh_tot_T0 (99999).
VARIABLE WIDTH kosten_dagbeh_tot_T0 (9).
VARIABLE LEVEL kosten_dagbeh_tot_T0 (SCALE).

** Kosten opname**********************************************************************************************************************************************************************
*tarieven 2017.
COMPUTE kosten_opname_ZH_T0=487*opname_ZH_aant_dagen_T0.
COMPUTE kosten_opname_rev_T0=471*opname_rev_aant_dagen_T0.
COMPUTE kosten_opname_psy_T0=309*opname_psy_aant_dagen_T0.
EXECUTE.

DO IF MISSING(opname_ZH_T0)=1.
RECODE kosten_opname_ZH_T0 (SYSMIS=99999).
END IF.
DO IF MISSING(opname_rev_T0)=1.
RECODE kosten_opname_rev_T0 (SYSMIS=99999).
END IF.
DO IF MISSING(opname_psy_T0)=1.
RECODE kosten_opname_psy_T0 (SYSMIS=99999).
END IF.
EXECUTE.

DO IF opname_ZH_T0=2.
RECODE kosten_opname_ZH_T0 (SYSMIS=0).
END IF.
DO IF opname_rev_T0=2.
RECODE kosten_opname_rev_T0 (SYSMIS=0).
END IF.
DO IF opname_psy_T0=2.
RECODE kosten_opname_psy_T0 (SYSMIS=0).
END IF.
EXECUTE.

MISSING VALUES kosten_opname_ZH_T0  kosten_opname_rev_T0  kosten_opname_psy_T0 (99999).

COMPUTE kosten_opname_tot_T0=SUM (kosten_opname_ZH_T0,kosten_opname_rev_T0,kosten_opname_psy_T0).
EXECUTE.
RECODE kosten_opname_tot_T0 (SYSMIS=99999).
EXECUTE.
MISSING VALUES kosten_opname_tot_T0 (99999).
VARIABLE LEVEL kosten_opname_ZH_T0,kosten_opname_rev_T0,kosten_opname_psy_T0 kosten_opname_tot_T0 (SCALE).
VARIABLE WIDTH kosten_opname_ZH_T0,kosten_opname_rev_T0,kosten_opname_psy_T0 kosten_opname_tot_T0 (12).

** reiskosten**************************************************************************************************************************************************************************************.

** HA en POH: 1,1 km per bezoek x 0.19 + 3.07 parkeerkosten.
COMPUTE temp_aant_HA_POH= SUM(consult1_T0, consult2_T0).
COMPUTE reiskosten_HA_POH_T0= (temp_aant_HA_POH * 1.1 * 0.19) + (temp_aant_HA_POH * 3.07).
EXECUTE.
RECODE reiskosten_HA_POH_T0 (SYSMIS=99999).
EXECUTE.
DELETE VARIABLES temp_aant_HA_POH.
VARIABLE LABELS reiskosten_HA_POH_T0 'reiskosten HA en POH'.

** Fysio en overige paramedische consulten: 2,3 km per bezoek x 0.19 + 3.07 parkeerkosten.
COMPUTE temp_aant_param= SUM(consult3_T0, consult4_T0, consult5_T0, consult6_T0, consult7_T0, consult8_T0, consult9_T0, consult10_T0, consult11_T0, consult12_T0, consult13_T0, consult14_T0).
COMPUTE reiskosten_param_T0= (temp_aant_param * 2.2 * 0.19) + (temp_aant_param * 3.07).
EXECUTE.
RECODE reiskosten_param_T0 (SYSMIS=99999).
EXECUTE.
DELETE VARIABLES temp_aant_param.
VARIABLE LABELS reiskosten_param_T0 'reiskosten alle paramediche consulten'.

** Per polibezoek,  per dagbehandeling en per EHBO 7,0 km per bezoek x 0.19 + 3.02 parkeerkosten.
COMPUTE temp_aant_ZH= SUM( EHBO_aant_keer_T0,  spec1_aant_keer_T0,  spec2_aant_keer_T0,  spec3_aant_keer_T0,  spec4_aant_keer_T0,  
Dagbehandeling1_aant_keer_T0,  Dagbehandeling2_aant_keer_T0, Dagbehandeling3_aant_keer_T0, Dagbehandeling4_aant_keer_T0, Dagbehandeling5_aant_keer_T0).
COMPUTE reiskosten_ZH_T0= (temp_aant_ZH * 7.0 * 0.19) + (temp_aant_ZH * 3.07).
EXECUTE.
RECODE reiskosten_ZH_T0 (SYSMIS=99999).
EXECUTE.
DELETE VARIABLES temp_aant_ZH.
VARIABLE LABELS reiskosten_ZH_T0 'reiskosten EHBO, poli en dagbehandeling'.

* Apotheek: indien medicatie gebruikt: 1 apotheekbezoek per vragenlijst rekenen.
DO IF medicatie_T0=2.
COMPUTE reiskosten_apo_T0= (1.3 * 0.19) + 3.07.
END IF.
DO IF medicatie_T0=1.
COMPUTE reiskosten_apo_T0= 0.
END IF.
RECODE reiskosten_apo_T0 (SYSMIS=99999).
EXECUTE.
VARIABLE LABELS reiskosten_apo_T0 'reiskosten apotheek'.

MISSING VALUES  reiskosten_HA_POH_T0 reiskosten_param_T0 reiskosten_ZH_T0 reiskosten_apo_T0 (99999).

*** Totale reiskosten.
COMPUTE reiskosten_tot_T0 = reiskosten_HA_POH_T0 + reiskosten_param_T0 + reiskosten_ZH_T0 + reiskosten_apo_T0.
EXECUTE.
RECODE reiskosten_tot_T0 (SYSMIS=99999).
EXECUTE.

VARIABLE WIDTH reiskosten_HA_POH_T0 reiskosten_param_T0 reiskosten_ZH_T0 reiskosten_apo_T0 reiskosten_tot_T0 (9).
VARIABLE LEVEL reiskosten_HA_POH_T0 reiskosten_param_T0 reiskosten_ZH_T0 reiskosten_apo_T0 reiskosten_tot_T0 (SCALE).

MISSING VALUES reiskosten_tot_T0 (99999).



