#!/bin/bash

# MSGFPlus=../msgfplus2019/MSGFPlus.jar
# FIXED_PARAM="-maxMissedCleavages 1 -tda 0 -thread 1 -addFeatures 1 -ignoreMetCleavage 1 -n 1 -ti 0,0 -minLength 6 -maxLength 50 -minCharge 1 -maxCharge 9 -ntt 2"

# # # #humvar
# # MSFILE=/home/data/mass_spec_data/Linfeng_012511_HapMap39_3_S_adj.mzML
# # FASTA=/home/data/Fasta/ipi.HUMAN.v3.87.target-protrev.fasta
# # PARAM="-t 50ppm -e 1 "
# # OUTFILE=/home/attila/boltzmatch/MSGFPlus/humvar_lr_sadj.mzid
# # java -Xmx64G -jar $MSGFPlus -s $MSFILE -d $FASTA $FIXED_PARAM $PARAM -mod ./oxi_tmt_var_mods.txt -o $OUTFILE
# # java -cp $MSGFPlus edu.ucsd.msjava.ui.MzIDToTsv -showDecoy 1 -showQValue 1 -i $OUTFILE

# # OUTFILE=/home/attila/boltzmatch/MSGFPlus/humvar_hr_sadj.mzid
# # java -Xmx64G -jar $MSGFPlus -m 3 -inst 1 -s $MSFILE -d $FASTA $FIXED_PARAM $PARAM -mod ./oxi_tmt_var_mods.txt -o $OUTFILE
# # java -cp $MSGFPlus edu.ucsd.msjava.ui.MzIDToTsv -showDecoy 1 -showQValue 1 -i $OUTFILE

# #yeast
# MSFILE=/home/data/mass_spec_data/yeast-01_full_S_adj.mgf
# FASTA=/home/data/Fasta/yeast.target-protrev.fasta 
# OUTFILE=/home/attila/boltzmatch/MSGFPlus/yeast_lr.mzid
# PARAM="-t 3Da -e 1"
# java -Xmx64G -jar $MSGFPlus -s $MSFILE -d $FASTA $FIXED_PARAM $PARAM -o $OUTFILE
# java -cp $MSGFPlus edu.ucsd.msjava.ui.MzIDToTsv -showDecoy 1 -showQValue 1 -i $OUTFILE



# # # #!/bin/bash

OMSSA=../omssa-2.1.9.linux/omssacl
BLAST=../ncbi-blast-2.9.0+/bin/makeblastdb 
$BLAST -in /home/data/Fasta/uniprot-proteome_UP000005640.target-protrev.fasta -out OMSSA/uniprot -dbtype prot >/dev/null 

OUTPUT=/home/attila/peak_filter/OMSSA/hela_lr.csv
$OMSSA -d OMSSA/uniprot -fm /hdd/data/HeLa/20150410_QE3_UPLC9_DBJ_SA_46fractions_Rep1_1.mgf -te 50 -teppm -to 1.0005079 -i 1,4 -oc $OUTPUT -nt 10 -mnm -mf 3 -e 10 -he 99999999 -hl 1 -zcc 1 -tem 0 -tom 0 -tez 1 -zh 9 -v 0 -hm 1
python3 omssa2tailor.py $OUTPUT -t 1 -l 3 &

OUTPUT=/home/attila/peak_filter/OMSSA/hela_hr.csv
$OMSSA -d OMSSA/uniprot -fm /hdd/data/HeLa/20150410_QE3_UPLC9_DBJ_SA_46fractions_Rep1_1.mgf -te 50 -teppm -to 0.05 -i 1,4 -oc $OUTPUT -nt 10 -mnm -mf 3 -e 10 -he 99999999 -hl 1 -zcc 1 -tem 0 -tom 0 -tez 1 -zh 9 -v 0 -hm 1
python3 omssa2tailor.py $OUTPUT -t 1 -l 3 &

OUTPUT=/home/attila/peak_filter/OMSSA/chopin_lr.csv
$OMSSA -d OMSSA/uniprot -fm /hdd/data/Chopin/FL0026_RFI_261114_Deep_High_Trypsin_F13F28_hybridFT_HCD_[Node_10].mgf -te 20 -teppm -to 1.0005079 -i 1,4 -oc $OUTPUT -nt 10 -mnm -mf 3 -e 10 -he 99999999 -hl 1 -zcc 1 -tem 0 -tom 0 -tez 1 -zh 9 -v 0 -hm 1
python3 omssa2tailor.py $OUTPUT -t 1 -l 3 &

OUTPUT=/home/attila/peak_filter/OMSSA/chopin_hr.csv
$OMSSA -d OMSSA/uniprot -fm /hdd/data/Chopin/FL0026_RFI_261114_Deep_High_Trypsin_F13F28_hybridFT_HCD_[Node_10].mgf -te 20 -teppm -to 0.05 -i 1,4 -oc $OUTPUT -nt 10 -mnm -mf 3 -e 10 -he 99999999 -hl 1 -zcc 1 -tem 0 -tom 0 -tez 1 -zh 9 -v 0 -hm 1
python3 omssa2tailor.py $OUTPUT -t 1 -l 3 &




# # # # $BLAST -in /home/data/Fasta/ipi.HUMAN.v3.87.target-protrev.fasta -out OMSSA/human -dbtype prot >/dev/null 
# # # # $BLAST -in /home/data/Fasta/ABRF_iPRG_2012.target-protrev.fasta -out OMSSA/iprg -dbtype prot >/dev/null 
# # # # $BLAST -in /home/data/Fasta/plasmo_Pfalciparum3D7_NCBI.target-protrev.fasta -out OMSSA/malaria -dbtype prot >/dev/null 
# # # # $BLAST -in /home/data/Fasta/yeast.target-protrev.fasta  -out OMSSA/yeast -dbtype prot >/dev/null 

# # # # OUTPUT=/home/attila/boltzmatch/OMSSA/humvar_lr.csv
# # # # python3 omssa2tailor.py $OUTPUT -t 1 -l 3 &
# # # # $OMSSA -d OMSSA/human -fm /home/data/mass_spec_data/Linfeng_012511_HapMap39_3.mgf -te 50 -teppm -to 1.0005079 -i 1,4 -oc $OUTPUT -nt 10 -mnm -mf 3 -mv 1,198,199 -e 0 -he 99999999 -hl 1 -zcc 1 -tem 0 -tom 0 -tez 1 -zh 9 -v 0 -hm 1

# # # # OUTPUT=/home/attila/boltzmatch/OMSSA/humvar_hr.csv
# # # # $OMSSA -d OMSSA/human -fm /home/data/mass_spec_data/Linfeng_012511_HapMap39_3.mgf -te 50 -teppm -to 0.05 -i 1,4 -oc $OUTPUT -nt 10 -mnm -mf 3 -mv 1,198,199 -e 0 -he 99999999 -hl 1 -zcc 1 -tem 0 -tom 0 -tez 1 -zh 9 -v 0 -hm 1
# # # # python3 omssa2tailor.py $OUTPUT -t 1 -l 3

# # # OUTPUT=/home/attila/boltzmatch/OMSSA/malaria_lr.csv
# # # $OMSSA -d OMSSA/malaria -fm /home/data/mass_spec_data/v07548_UofF_malaria_TMT_10_S_adj.mgf -te 50 -teppm -to 1.0005079 -i 1,4 -oc $OUTPUT -nt 10 -mnm -mf 3,198,199 -mv 1 -e 5 -he 99999999 -hl 1 -zcc 1 -tem 0 -tom 0 -tez 1 -zh 9 -v 0 -hm 1
# # # python3 omssa2tailor.py $OUTPUT -t 1 -l 3 &

# # # OUTPUT=/home/attila/boltzmatch/OMSSA/malaria_hr.csv
# # # $OMSSA -d OMSSA/malaria -fm /home/data/mass_spec_data/v07548_UofF_malaria_TMT_10_S_adj.mgf -te 50 -teppm -to 0.05 -i 1,4 -oc $OUTPUT -nt 10 -mnm -mf 3,198,199 -mv 1 -e 5 -he 99999999 -hl 1 -zcc 1 -tem 0 -tom 0 -tez 1 -zh 9 -v 0 -hm 1
# # # python3 omssa2tailor.py $OUTPUT -t 1 -l 3 &

# # # # OUTPUT=/home/attila/boltzmatch/OMSSA/yeast_lr.csv
# # # # $OMSSA -d OMSSA/yeast -fm /home/data/mass_spec_data/yeast-01_full.mgf -te 3  -to 1.0005079 -i 1,4 -oc $OUTPUT -nt 10 -mnm -mf 3 -e 0 -he 99999999 -hl 1 -zcc 1 -tem 0 -tom 0 -tez 1 -zh 9 -v 0
# # # # python3 omssa2tailor.py $OUTPUT -t 1 -l 3 &

# # # # OUTPUT=/home/attila/boltzmatch/OMSSA/iprg_hr.csv
# # # # $OMSSA -d OMSSA/iprg -fm /home/data/mass_spec_data/iPRG2012_full_estimated_z.mgf -te 10 -teppm -to 0.05 -i 1,4 -oc $OUTPUT -nt 10 -mnm -mf 3 -mv 1 -e 0 -he 99999999 -hl 1 -zcc 1 -tem 0 -tom 0 -tez 1 -zh 9 -v 0 -hm 1
# # # # python3 omssa2tailor.py $OUTPUT -t 1 -l 3 &

# # # # OUTPUT=/home/attila/boltzmatch/OMSSA/iprg_lr.csv
# # # # $OMSSA -d OMSSA/iprg -fm /home/data/mass_spec_data/iPRG2012_full_estimated_z.mgf -te 10 -teppm -to 1.0005079 -i 1,4 -oc $OUTPUT -nt 10 -mnm -mf 3 -mv 1 -e 0 -he 99999999 -hl 1 -zcc 1 -tem 0 -tom 0 -tez 1 -zh 9 -v 0 -hm 1 
# # # # python3 omssa2tailor.py $OUTPUT -t 1 -l 3 &

# # # # OUTPUT=/home/attila/boltzmatch/OMSSA/aurum_lr.csv
# # # # $OMSSA -d OMSSA/human -fm /home/data/mass_spec_data/AurumR151.mgf -te 2 -to 1.0005079 -i 1,4 -oc $OUTPUT -nt 10 -mnm -mf 3 -mv 1 -e 0 -he 99999999 -hl 1 -zcc 1 -tem 0 -tom 0 -tez 1 -zh 9 -v 0 -hm 1
# # # # python3 omssa2tailor.py $OUTPUT -t 1 -l 3 &

# # # # OUTPUT=/home/attila/boltzmatch/OMSSA/hspp2a_lr.csv
# # # # $OMSSA -d OMSSA/human -fm /home/data/mass_spec_data/HSPP2A.mgf -te 50 -teppm -to 1.0005079 -i 1,4 -oc $OUTPUT -nt 10 -mnm -mf 3 -mv 1 -e 0 -he 99999999 -hl 1 -zcc 1 -tem 0 -tom 0 -tez 1 -zh 9 -v 0 -hm 1
# # # # python3 omssa2tailor.py $OUTPUT -t 1 -l 3 &
