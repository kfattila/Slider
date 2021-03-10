#!/bin/bash

CRUX=/home/attila/crux-toolkit-tailor/src/crux

#FIX_PARAM="--decoy-format none --enzyme custom-enzyme --custom-enzyme [Z]|{Z} --missed-cleavages 0 --overwrite T --peptide-list T"
# FIX_PARAM="--decoy-format protein-reverse --missed-cleavages 2 --overwrite T --peptide-list T"
FIX_PARAM="--decoy-format none --missed-cleavages 2 --digestion partial-digest --overwrite T --peptide-list T"
FOLDER_POST=_IDX

# FASTA=/home/data/Fasta/uniprot-proteome_UP000005640.fasta
# TAXON=UNIPROT_ISOMORF
# PARAM="--max-mods 0 --enzyme trypsin/p --max-length 30 --min-length 7 --max-mass 4600"
# $CRUX tide-index $FIX_PARAM $PARAM --output-dir CRUX/$TAXON$FOLDER_POST $FASTA CRUX/$TAXON$FOLDER_POST


# FASTA=/home/data/Fasta/yeast.target-protrev.fasta 
# TAXON=YEAST
# PARAM="--max-mods 0"
# $CRUX tide-index $FIX_PARAM $PARAM --output-dir CRUX/$TAXON$FOLDER_POST $FASTA CRUX/$TAXON$FOLDER_POST

# FASTA=/home/data/Fasta/ABRF_iPRG_2012.target-protrev.fasta
# TAXON=IPRG
# PARAM="--max-mods 1 --mods-spec 1M+15.9949"
# $CRUX tide-index $FIX_PARAM $PARAM --output-dir CRUX/$TAXON$FOLDER_POST $FASTA CRUX/$TAXON$FOLDER_POST

# FASTA=/home/data/Fasta/plasmo_Pfalciparum3D7_NCBI.target-protrev.fasta
# TAXON=MALARIA
# PARAM="--max-mods 1 --enzyme lys-c --mods-spec K+229.16293,1M+15.9949 --nterm-peptide-mods-spec X+229.16293"
# $CRUX tide-index $FIX_PARAM $PARAM --output-dir CRUX/$TAXON$FOLDER_POST $FASTA CRUX/$TAXON$FOLDER_POST

FASTA=/home/data/Fasta/ipi.HUMAN.v3.87.target-protrev.fasta
TAXON=HUMVAR_SEMI
PARAM="--max-mods 2 --mods-spec 2K+229.16293,2M+15.9949 --nterm-peptide-mods-spec 1X+229.16293"
$CRUX tide-index $FIX_PARAM $PARAM --output-dir CRUX/$TAXON$FOLDER_POST $FASTA CRUX/$TAXON$FOLDER_POST

# FASTA=/home/data/Fasta/ipi.HUMAN.v3.87.target-protrev.fasta
# TAXON=HUMAN
# PARAM="--max-mods 1 --mods-spec 1M+15.9949"
# $CRUX tide-index $FIX_PARAM $PARAM --output-dir CRUX/$TAXON$FOLDER_POST $FASTA CRUX/$TAXON$FOLDER_POST

# FASTA=/home/data/Fasta/ecoli-k12-mc4100.fasta
# TAXON=ECOLI
# PARAM="--max-mods 2 --mods-spec 1M+15.9949,1K+28.0313,1K+32.0564,1K+36.0757 --nterm-peptide-mods-spec 1X+28.0313,1X+32.0564,1X+36.0757"
# $CRUX tide-index $FIX_PARAM $PARAM --output-dir CRUX/$TAXON$FOLDER_POST $FASTA CRUX/$TAXON$FOLDER_POST

# FASTA=/home/data/Fasta/metapeptides_ocean.fasta
# TAXON=OCEAN
# PARAM="--enzyme custom-enzyme --custom-enzyme [Z]|{Z} --max-mods 2 --mods-spec 2M+15.9949"
# $CRUX tide-index $FIX_PARAM $PARAM --output-dir CRUX/$TAXON$FOLDER_POST $FASTA CRUX/$TAXON$FOLDER_POST

# FASTA=/home/data/Fasta/Adrenal_gland.fasta
# TAXON=HUMAN_ADRENAL_GLAND
# PARAM="--max-mods 3 --mods-spec 3M+15.9949 --nterm-peptide-mods-spec 1C+28.0313,1X+32.0564,1X+36.0757"
# $CRUX tide-index $FIX_PARAM $PARAM --output-dir CRUX/$TAXON$FOLDER_POST $FASTA CRUX/$TAXON$FOLDER_POST

