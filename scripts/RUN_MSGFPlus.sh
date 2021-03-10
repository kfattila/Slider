#!/bin/bash

MSGFPlus=../msgfplus2019/MSGFPlus.jar
FIXED_PARAM="-maxMissedCleavages 1 -tda 0 -thread 1 -addFeatures 1 -ignoreMetCleavage 1 -n 1 -ti 0,0 -minLength 6 -maxLength 50 -minCharge 1 -maxCharge 9 -ntt 2"

# # #humvar
# MSFILE=/home/data/mass_spec_data/Linfeng_012511_HapMap39_3_S_adj.mzML
# FASTA=/home/data/Fasta/ipi.HUMAN.v3.87.target-protrev.fasta
# PARAM="-t 50ppm -e 1 "
# OUTFILE=/home/attila/boltzmatch/MSGFPlus/humvar_lr_sadj.mzid
# java -Xmx64G -jar $MSGFPlus -s $MSFILE -d $FASTA $FIXED_PARAM $PARAM -mod ./oxi_tmt_var_mods.txt -o $OUTFILE
# java -cp $MSGFPlus edu.ucsd.msjava.ui.MzIDToTsv -showDecoy 1 -showQValue 1 -i $OUTFILE

# OUTFILE=/home/attila/boltzmatch/MSGFPlus/humvar_hr_sadj.mzid
# java -Xmx64G -jar $MSGFPlus -m 3 -inst 1 -s $MSFILE -d $FASTA $FIXED_PARAM $PARAM -mod ./oxi_tmt_var_mods.txt -o $OUTFILE
# java -cp $MSGFPlus edu.ucsd.msjava.ui.MzIDToTsv -showDecoy 1 -showQValue 1 -i $OUTFILE


# #iprg
# MSFILE=/home/data/mass_spec_data/iPRG_continuous_scan_S_adj.ms2
# FASTA=/home/data/Fasta/ABRF_iPRG_2012.target-protrev.fasta
# PARAM="-t 10ppm -e 1 "
# OUTFILE=/home/attila/boltzmatch/MSGFPlus/iprg_lr.mzid
# java -Xmx64G -jar $MSGFPlus -s $MSFILE -d $FASTA $FIXED_PARAM $PARAM -mod ./oxi_mods.txt -o $OUTFILE
# java -cp $MSGFPlus edu.ucsd.msjava.ui.MzIDToTsv -showDecoy 1 -showQValue 1 -i $OUTFILE

# OUTFILE=/home/attila/boltzmatch/MSGFPlus/iprg_hr.mzid
# java -Xmx64G -jar $MSGFPlus -m 0 -inst 2 -s $MSFILE -d $FASTA $FIXED_PARAM $PARAM -mod ./oxi_mods.txt -o $OUTFILE
# java -cp $MSGFPlus edu.ucsd.msjava.ui.MzIDToTsv -showDecoy 1 -showQValue 1 -i $OUTFILE

# # # #malaria
# MSFILE=/home/data/mass_spec_data/v07548_UofF_malaria_TMT_10_S_adj.ms2
# FASTA=/home/data/Fasta/plasmo_Pfalciparum3D7_NCBI_fixed.target-protrev.fasta
# PARAM="-t 50ppm -e 3"
# OUTFILE=/home/attila/boltzmatch/MSGFPlus/malaria_lr.mzid
# java -Xmx64G -jar $MSGFPlus -inst 0 -s $MSFILE -d $FASTA $FIXED_PARAM $PARAM -mod ./oxi_tmt_mods.txt -o $OUTFILE
# java -cp $MSGFPlus edu.ucsd.msjava.ui.MzIDToTsv -showDecoy 1 -showQValue 1 -i $OUTFILE

# OUTFILE=/home/attila/boltzmatch/MSGFPlus/malaria_hr.mzid
# java -Xmx64G -jar $MSGFPlus -m 0 -inst 1 -s $MSFILE -d $FASTA $FIXED_PARAM $PARAM -mod ./oxi_tmt_mods.txt -o $OUTFILE
# java -cp $MSGFPlus edu.ucsd.msjava.ui.MzIDToTsv -showDecoy 1 -showQValue 1 -i $OUTFILE

# MSFILE=/home/data/mass_spec_data/v07548_UofF_malaria_TMT_10.mzML
# OUTFILE=/home/attila/boltzmatch/MSGFPlus/malaria_mzml.mzid
# java -Xmx64G -jar $MSGFPlus -m 0 -inst 1 -s $MSFILE -d $FASTA $FIXED_PARAM $PARAM -mod ./oxi_tmt_mods.txt -o $OUTFILE
# java -cp $MSGFPlus edu.ucsd.msjava.ui.MzIDToTsv -showDecoy 1 -showQValue 1 -i $OUTFILE
# MSFILE=/home/data/mass_spec_data/v07548_UofF_malaria_TMT_10.ms2
# OUTFILE=/home/attila/boltzmatch/MSGFPlus/malaria_ms2.mzid
# java -Xmx64G -jar $MSGFPlus -m 0 -inst 1 -s $MSFILE -d $FASTA $FIXED_PARAM $PARAM -mod ./oxi_tmt_mods.txt -o $OUTFILE
# java -cp $MSGFPlus edu.ucsd.msjava.ui.MzIDToTsv -showDecoy 1 -showQValue 1 -i $OUTFILE
# MSFILE=/home/data/mass_spec_data/v07548_UofF_malaria_TMT_10.mgf
# OUTFILE=/home/attila/boltzmatch/MSGFPlus/malaria_mgf.mzid
# java -Xmx64G -jar $MSGFPlus -m 0 -inst 1 -s $MSFILE -d $FASTA $FIXED_PARAM $PARAM -mod ./oxi_tmt_mods.txt -o $OUTFILE
# java -cp $MSGFPlus edu.ucsd.msjava.ui.MzIDToTsv -showDecoy 1 -showQValue 1 -i $OUTFILE

# MSFILE=/home/data/mass_spec_data/v07548_UofF_malaria_TMT_10_S_adj.mzML
# OUTFILE=/home/attila/boltzmatch/MSGFPlus/malaria_mzml_s_adjusted.mzid
# java -Xmx64G -jar $MSGFPlus -m 0 -inst 1 -s $MSFILE -d $FASTA $FIXED_PARAM $PARAM -mod ./oxi_tmt_mods.txt -o $OUTFILE
# java -cp $MSGFPlus edu.ucsd.msjava.ui.MzIDToTsv -showDecoy 1 -showQValue 1 -i $OUTFILE

# # OUTFILE=/home/attila/boltzmatch/MSGFPlus/malaria_m0i0.mzid
# java -Xmx64G -jar $MSGFPlus -m 0 -inst 0 -s $MSFILE -d $FASTA $FIXED_PARAM $PARAM -mod ./oxi_tmt_mods.txt -o $OUTFILE
# java -cp $MSGFPlus edu.ucsd.msjava.ui.MzIDToTsv -showDecoy 1 -showQValue 1 -i $OUTFILE
# OUTFILE=/home/attila/boltzmatch/MSGFPlus/malaria_m0i1.mzid
# java -Xmx64G -jar $MSGFPlus -m 0 -inst 1 -s $MSFILE -d $FASTA $FIXED_PARAM $PARAM -mod ./oxi_tmt_mods.txt -o $OUTFILE
# java -cp $MSGFPlus edu.ucsd.msjava.ui.MzIDToTsv -showDecoy 1 -showQValue 1 -i $OUTFILE
# OUTFILE=/home/attila/boltzmatch/MSGFPlus/malaria_m0i2.mzid
# java -Xmx64G -jar $MSGFPlus -m 0 -inst 2 -s $MSFILE -d $FASTA $FIXED_PARAM $PARAM -mod ./oxi_tmt_mods.txt -o $OUTFILE
# java -cp $MSGFPlus edu.ucsd.msjava.ui.MzIDToTsv -showDecoy 1 -showQValue 1 -i $OUTFILE
# OUTFILE=/home/attila/boltzmatch/MSGFPlus/malaria_m0i3.mzid
# java -Xmx64G -jar $MSGFPlus -m 0 -inst 3 -s $MSFILE -d $FASTA $FIXED_PARAM $PARAM -mod ./oxi_tmt_mods.txt -o $OUTFILE
# java -cp $MSGFPlus edu.ucsd.msjava.ui.MzIDToTsv -showDecoy 1 -showQValue 1 -i $OUTFILE
# OUTFILE=/home/attila/boltzmatch/MSGFPlus/malaria_m1i0.mzid
# java -Xmx64G -jar $MSGFPlus -m 1 -inst 0 -s $MSFILE -d $FASTA $FIXED_PARAM $PARAM -mod ./oxi_tmt_mods.txt -o $OUTFILE
# java -cp $MSGFPlus edu.ucsd.msjava.ui.MzIDToTsv -showDecoy 1 -showQValue 1 -i $OUTFILE
# OUTFILE=/home/attila/boltzmatch/MSGFPlus/malaria_m1i1.mzid
# java -Xmx64G -jar $MSGFPlus -m 1 -inst 1 -s $MSFILE -d $FASTA $FIXED_PARAM $PARAM -mod ./oxi_tmt_mods.txt -o $OUTFILE
# java -cp $MSGFPlus edu.ucsd.msjava.ui.MzIDToTsv -showDecoy 1 -showQValue 1 -i $OUTFILE
# OUTFILE=/home/attila/boltzmatch/MSGFPlus/malaria_m1i2.mzid
# java -Xmx64G -jar $MSGFPlus -m 1 -inst 2 -s $MSFILE -d $FASTA $FIXED_PARAM $PARAM -mod ./oxi_tmt_mods.txt -o $OUTFILE
# java -cp $MSGFPlus edu.ucsd.msjava.ui.MzIDToTsv -showDecoy 1 -showQValue 1 -i $OUTFILE
# OUTFILE=/home/attila/boltzmatch/MSGFPlus/malaria_m1i3.mzid
# java -Xmx64G -jar $MSGFPlus -m 1 -inst 3 -s $MSFILE -d $FASTA $FIXED_PARAM $PARAM -mod ./oxi_tmt_mods.txt -o $OUTFILE
# java -cp $MSGFPlus edu.ucsd.msjava.ui.MzIDToTsv -showDecoy 1 -showQValue 1 -i $OUTFILE

# OUTFILE=/home/attila/boltzmatch/MSGFPlus/malaria_m2i0.mzid
# java -Xmx64G -jar $MSGFPlus -m 2 -inst 0 -s $MSFILE -d $FASTA $FIXED_PARAM $PARAM -mod ./oxi_tmt_mods.txt -o $OUTFILE
# java -cp $MSGFPlus edu.ucsd.msjava.ui.MzIDToTsv -showDecoy 1 -showQValue 1 -i $OUTFILE
# OUTFILE=/home/attila/boltzmatch/MSGFPlus/malaria_m2i1.mzid
# java -Xmx64G -jar $MSGFPlus -m 2 -inst 1 -s $MSFILE -d $FASTA $FIXED_PARAM $PARAM -mod ./oxi_tmt_mods.txt -o $OUTFILE
# java -cp $MSGFPlus edu.ucsd.msjava.ui.MzIDToTsv -showDecoy 1 -showQValue 1 -i $OUTFILE
# OUTFILE=/home/attila/boltzmatch/MSGFPlus/malaria_m2i2.mzid
# java -Xmx64G -jar $MSGFPlus -m 2 -inst 2 -s $MSFILE -d $FASTA $FIXED_PARAM $PARAM -mod ./oxi_tmt_mods.txt -o $OUTFILE
# java -cp $MSGFPlus edu.ucsd.msjava.ui.MzIDToTsv -showDecoy 1 -showQValue 1 -i $OUTFILE
# OUTFILE=/home/attila/boltzmatch/MSGFPlus/malaria_m2i3.mzid
# java -Xmx64G -jar $MSGFPlus -m 2 -inst 3 -s $MSFILE -d $FASTA $FIXED_PARAM $PARAM -mod ./oxi_tmt_mods.txt -o $OUTFILE
# java -cp $MSGFPlus edu.ucsd.msjava.ui.MzIDToTsv -showDecoy 1 -showQValue 1 -i $OUTFILE
# OUTFILE=/home/attila/boltzmatch/MSGFPlus/malaria_m3i0.mzid
# java -Xmx64G -jar $MSGFPlus -m 3 -inst 0 -s $MSFILE -d $FASTA $FIXED_PARAM $PARAM -mod ./oxi_tmt_mods.txt -o $OUTFILE
# java -cp $MSGFPlus edu.ucsd.msjava.ui.MzIDToTsv -showDecoy 1 -showQValue 1 -i $OUTFILE
# OUTFILE=/home/attila/boltzmatch/MSGFPlus/malaria_m3i1.mzid
# java -Xmx64G -jar $MSGFPlus -m 3 -inst 1 -s $MSFILE -d $FASTA $FIXED_PARAM $PARAM -mod ./oxi_tmt_mods.txt -o $OUTFILE
# java -cp $MSGFPlus edu.ucsd.msjava.ui.MzIDToTsv -showDecoy 1 -showQValue 1 -i $OUTFILE
# OUTFILE=/home/attila/boltzmatch/MSGFPlus/malaria_m3i2.mzid
# java -Xmx64G -jar $MSGFPlus -m 3 -inst 2 -s $MSFILE -d $FASTA $FIXED_PARAM $PARAM -mod ./oxi_tmt_mods.txt -o $OUTFILE
# java -cp $MSGFPlus edu.ucsd.msjava.ui.MzIDToTsv -showDecoy 1 -showQValue 1 -i $OUTFILE
# OUTFILE=/home/attila/boltzmatch/MSGFPlus/malaria_m3i3.mzid
# java -Xmx64G -jar $MSGFPlus -m 3 -inst 3 -s $MSFILE -d $FASTA $FIXED_PARAM $PARAM -mod ./oxi_tmt_mods.txt -o $OUTFILE
# java -cp $MSGFPlus edu.ucsd.msjava.ui.MzIDToTsv -showDecoy 1 -showQValue 1 -i $OUTFILE

# # # #aurum
# MSFILE=/home/data/mass_spec_data/AurumR151_S_adj.ms2
# OUTFILE=/home/attila/boltzmatch/MSGFPlus/aurum_lr.mzid
# FASTA=/home/data/Fasta/ipi.HUMAN.v3.87.target-protrev.fasta
# PARAM="-t 2Da -e 1"
# java -Xmx64G -jar $MSGFPlus -s $MSFILE -d $FASTA $FIXED_PARAM $PARAM -mod ./oxi_mods.txt -o $OUTFILE
# java -cp $MSGFPlus edu.ucsd.msjava.ui.MzIDToTsv -showDecoy 1 -showQValue 1 -i $OUTFILE
# python3 msgf2tailor.py $OUTFILE -t 1 -l 3

# #hspp2a
# MSFILE=/home/data/mass_spec_data/HSPP2A_S_adj.ms2
# FASTA=/home/data/Fasta/ipi.HUMAN.v3.87.target-protrev.fasta
# OUTFILE=/home/attila/boltzmatch/MSGFPlus/hspp2a_lr.mzid
# PARAM="-t 50ppm -e 1"
# java -Xmx64G -jar $MSGFPlus -s $MSFILE -d $FASTA $FIXED_PARAM $PARAM -mod ./oxi_mods.txt -o $OUTFILE
# java -cp $MSGFPlus edu.ucsd.msjava.ui.MzIDToTsv -showDecoy 1 -showQValue 1 -i $OUTFILE
# python3 msgf2tailor.py $OUTFILE -t 1 -l 3
# #yeast
# MSFILE=/home/data/mass_spec_data/yeast-01_full_S_adj.ms2
# FASTA=/home/data/Fasta/yeast.target-protrev.fasta 
# OUTFILE=/home/attila/boltzmatch/MSGFPlus/yeast_lr.mzid
# PARAM="-t 3Da -e 1"
# java -Xmx64G -jar $MSGFPlus -s $MSFILE -d $FASTA $FIXED_PARAM $PARAM -o $OUTFILE
# java -cp $MSGFPlus edu.ucsd.msjava.ui.MzIDToTsv -showDecoy 1 -showQValue 1 -i $OUTFILE

# # # #ecoli
# # MSFILE=/home/data/mass_spec_data/OR6_19022013_GM_SU_Ecoli_Mix1_DyfgM_fr21.mzML
# # FASTA=/home/data/Fasta/yeast.target-protrev.fasta 
# # OUTFILE=/home/attila/boltzmatch/MSGFPlus/yeast_lr.mzid
# # PARAM="-t 3Da -e 1"
# # java -Xmx64G -jar $MSGFPlus -s $MSFILE -d $FASTA $FIXED_PARAM $PARAM -o $OUTFILE
# # java -cp $MSGFPlus edu.ucsd.msjava.ui.MzIDToTsv -showDecoy 1 -showQValue 1 -i $OUTFILE

# # # #human
# # MSFILE=/home/data/mass_spec_data/2016_Jan_12_QE2_51.mzML
# # FASTA=/home/data/Fasta/yeast.target-protrev.fasta 
# # OUTFILE=/home/attila/boltzmatch/MSGFPlus/yeast_lr.mzid
# # PARAM="-t 3Da -e 1"
# # java -Xmx64G -jar $MSGFPlus -s $MSFILE -d $FASTA $FIXED_PARAM $PARAM -o $OUTFILE
# # java -cp $MSGFPlus edu.ucsd.msjava.ui.MzIDToTsv -showDecoy 1 -showQValue 1 -i $OUTFILE

# # # #ocean
# # MSFILE=/home/data/mass_spec_data/Adult_Adrenalgland_Gel_Elite_49_f01.mzML
# # FASTA=/home/data/Fasta/yeast.target-protrev.fasta 
# # OUTFILE=/home/attila/boltzmatch/MSGFPlus/yeast_lr.mzid
# # PARAM="-t 3Da -e 1"
# # java -Xmx64G -jar $MSGFPlus -s $MSFILE -d $FASTA $FIXED_PARAM $PARAM -o $OUTFILE
# # java -cp $MSGFPlus edu.ucsd.msjava.ui.MzIDToTsv -showDecoy 1 -showQValue 1 -i $OUTFILE



#hela
MSFILE=/hdd/data/HeLa/20150410_QE3_UPLC9_DBJ_SA_46fractions_Rep1_1.mgf
FASTA=/home/data/Fasta/uniprot-proteome_UP000005640.target-protrev.fasta
PARAM="-t 50ppm -e 1 "
OUTFILE=/home/attila/peak_filter/MSGFPlus/hela_lr.mzid
java -Xmx64G -jar $MSGFPlus -s $MSFILE -d $FASTA $FIXED_PARAM $PARAM -o $OUTFILE
java -cp $MSGFPlus edu.ucsd.msjava.ui.MzIDToTsv -showDecoy 1 -showQValue 1 -i $OUTFILE

OUTFILE=/home/attila/peak_filter/MSGFPlus/hela_hr.mzid
java -Xmx64G -jar $MSGFPlus -m 0 -inst 2 -s $MSFILE -d $FASTA $FIXED_PARAM $PARAM -o $OUTFILE
java -cp $MSGFPlus edu.ucsd.msjava.ui.MzIDToTsv -showDecoy 1 -showQValue 1 -i $OUTFILE

#chopin
MSFILE=/hdd/data/Chopin/FL0026_RFI_261114_Deep_High_Trypsin_F13F28_hybridFT_HCD_[Node_10].mgf
FASTA=/home/data/Fasta/uniprot-proteome_UP000005640.target-protrev.fasta
PARAM="-t 20ppm -e 1 "
OUTFILE=/home/attila/peak_filter/MSGFPlus/chopin_lr.mzid
java -Xmx64G -jar $MSGFPlus -s $MSFILE -d $FASTA $FIXED_PARAM $PARAM -o $OUTFILE
java -cp $MSGFPlus edu.ucsd.msjava.ui.MzIDToTsv -showDecoy 1 -showQValue 1 -i $OUTFILE

OUTFILE=/home/attila/peak_filter/MSGFPlus/chopin_hr.mzid
java -Xmx64G -jar $MSGFPlus -m 0 -inst 2 -s $MSFILE -d $FASTA $FIXED_PARAM $PARAM -o $OUTFILE
java -cp $MSGFPlus edu.ucsd.msjava.ui.MzIDToTsv -showDecoy 1 -showQValue 1 -i $OUTFILE
