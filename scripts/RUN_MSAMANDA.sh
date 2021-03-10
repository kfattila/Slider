#!/bin/bash

MSAMANDA=/home/attila/MSAmanda/MSAmanda.exe

# mono $MSAMANDA -s /home/data/mass_spec_data/AurumR151_S_adj.mgf -d /home/data/Fasta/ipi.HUMAN.v3.87.target-protrev.fasta -e msamanda_settings_aurum_lr.xml -f 1 -o msamanda/msamanda_out_aurum_lr.csv &
# mono $MSAMANDA -s /home/data/mass_spec_data/HSPP2A_S_adj.mgf -d /home/data/Fasta/ipi.HUMAN.v3.87.target-protrev.fasta -e msamanda_settings_hspp2a_lr.xml -f 1 -o msamanda/msamanda_out_hspp2a_lr.csv &
# mono $MSAMANDA -s /home/data/mass_spec_data/yeast-01_full_S_adj.mgf -d /home/data/Fasta/yeast.target-protrev.fasta -e msamanda_settings_yeast_lr.xml -f 1 -o msamanda/msamanda_out_yeast_lr.csv &
# mono $MSAMANDA -s /home/data/mass_spec_data/iPRG_continuous_scan_S_adj.mgf -d /home/data/Fasta/ABRF_iPRG_2012.target-protrev.fasta -e msamanda_settings_iprg_lr.xml -f 1 -o msamanda/msamanda_out_iprg_lr.csv
# mono $MSAMANDA -s /home/data/mass_spec_data/iPRG_continuous_scan_S_adj.mgf -d /home/data/Fasta/ABRF_iPRG_2012.target-protrev.fasta -e msamanda_settings_iprg_hr.xml -f 1 -o msamanda/msamanda_out_iprg_hr.csv
# mono $MSAMANDA -s /home/data/mass_spec_data/Linfeng_012511_HapMap39_3_S_adj.mgf -d /home/data/Fasta/ipi.HUMAN.v3.87.target-protrev.fasta -e msamanda_settings_humvar_lr.xml -f 1 -o msamanda/msamanda_out_humvar_lr.csv &
# mono $MSAMANDA -s /home/data/mass_spec_data/Linfeng_012511_HapMap39_3_S_adj.mgf -d /home/data/Fasta/ipi.HUMAN.v3.87.target-protrev.fasta -e msamanda_settings_humvar_hr.xml -f 1 -o msamanda/msamanda_out_humvar_hr.csv &
# mono $MSAMANDA -s /home/data/mass_spec_data/v07548_UofF_malaria_TMT_10_S_adj.mgf -d /home/data/Fasta/plasmo_Pfalciparum3D7_NCBI.target-protrev.fasta -e msamanda_settings_malaria_hr.xml -f 1 -o msamanda/msamanda_out_malaria_hr.csv &
# mono $MSAMANDA -s /home/data/mass_spec_data/v07548_UofF_malaria_TMT_10_S_adj.mgf -d /home/data/Fasta/plasmo_Pfalciparum3D7_NCBI.target-protrev.fasta -e msamanda_settings_malaria_lr.xml -f 1 -o msamanda/msamanda_out_malaria_lr.csv &

mono $MSAMANDA -s /hdd/data/HeLa/20150410_QE3_UPLC9_DBJ_SA_46fractions_Rep1_1.mgf -d /home/data/Fasta/uniprot-proteome_UP000005640.target-protrev.fasta -e msamanda_settings_hela_lr.xml -f 1 -o msamanda/msamanda_out_hela_lr.csv&
mono $MSAMANDA -s /hdd/data/HeLa/20150410_QE3_UPLC9_DBJ_SA_46fractions_Rep1_1.mgf -d /home/data/Fasta/uniprot-proteome_UP000005640.target-protrev.fasta -e msamanda_settings_hela_hr.xml -f 1 -o msamanda/msamanda_out_hela_hr.csv&
mono $MSAMANDA -s /hdd/data/Chopin/FL0026_RFI_261114_Deep_High_Trypsin_F13F28_hybridFT_HCD_[Node_10].mgf -d /home/data/Fasta/uniprot-proteome_UP000005640.target-protrev.fasta -e msamanda_settings_chopin_lr.xml -f 1 -o msamanda/msamanda_out_chopin_lr.csv &
mono $MSAMANDA -s /hdd/data/Chopin/FL0026_RFI_261114_Deep_High_Trypsin_F13F28_hybridFT_HCD_[Node_10].mgf -d /home/data/Fasta/uniprot-proteome_UP000005640.target-protrev.fasta -e msamanda_settings_chopin_hr.xml -f 1 -o msamanda/msamanda_out_chopin_hr.csv &
