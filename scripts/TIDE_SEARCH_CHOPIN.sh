#!/bin/bash

# CRUX_ORIGINAL=/home/attila/crux-3.2.8.original/src/crux
CRUX_ORIGINAL=/home/attila/crux-toolkit-tailor/src/crux

FIX_PARAM=" --precursor-window 20 --precursor-window-type ppm --top-match 1 --concat T --overwrite T --num-threads 1 --use-neutral-loss-peaks F --use-flanking-peaks F --min-peaks 10 --max-precursor-charge 7"
DATA_FILE_ORIGINAL=/hdd/data/Chopin/FL0026_RFI_261114_Deep_High_Trypsin_F13F28_hybridFT_HCD_[Node_10].mgf
DATA_FILE_PEAK_FILTERED_LR=/home/attila/peak_filter_learning/Chopin_lowres_filtered_10_xent.ms2
DATA_FILE_PEAK_FILTERED_HR=/home/attila/peak_filter_learning/Chopin_highres_filtered_10_xent.ms2
# INDEX=UNIPROT_ISOMORF_IDX
INDEX=HUMVAR_SEMI_IDX
TAXON=CHOPIN_SEMI
PATH=/home/attila/peak_filter/CRUX/

# RUN Original, RUN THIS IF THE RESULTS ARE MISSING OR THE PARAMETERS CHANGED
FOLDER_POST=_BASELINE_XCORR_LR
PARAM="--exact-p-value F --mz-bin-width 1.0005079 --mz-bin-offset 0.4 --use-tailor-calibration T --cross-corr-penalty T --skip-preprocessing F "
OUTPUT_DIR=$PATH$TAXON$FOLDER_POST
# $CRUX_ORIGINAL tide-search $FIX_PARAM $PARAM --output-dir $OUTPUT_DIR $DATA_FILE_ORIGINAL $PATH$INDEX
$CRUX_ORIGINAL assign-confidence --decoy-prefix DECOY_ --score "xcorr score" --overwrite T --output-dir $OUTPUT_DIR $OUTPUT_DIR/tide-search.txt
$CRUX_ORIGINAL assign-confidence --decoy-prefix DECOY_ --score "tailor score" --overwrite T --output-dir $OUTPUT_DIR $OUTPUT_DIR/tide-search.txt
$CRUX_ORIGINAL percolator --decoy-prefix DECOY_ --overwrite T --feature-file-out T --output-weights T --output-dir $OUTPUT_DIR $OUTPUT_DIR/tide-search.txt

FOLDER_POST=_BASELINE_XCORR_HR
PARAM="--exact-p-value F --mz-bin-width 0.05 --mz-bin-offset 0.0 --use-tailor-calibration T --cross-corr-penalty T --skip-preprocessing F "
OUTPUT_DIR=$PATH$TAXON$FOLDER_POST
# $CRUX_ORIGINAL tide-search $FIX_PARAM $PARAM --output-dir $OUTPUT_DIR $DATA_FILE_ORIGINAL $PATH$INDEX
$CRUX_ORIGINAL assign-confidence --decoy-prefix DECOY_ --score "xcorr score" --overwrite T --output-dir $OUTPUT_DIR $OUTPUT_DIR/tide-search.txt
$CRUX_ORIGINAL assign-confidence --decoy-prefix DECOY_ --score "tailor score" --overwrite T --output-dir $OUTPUT_DIR $OUTPUT_DIR/tide-search.txt
$CRUX_ORIGINAL percolator --decoy-prefix DECOY_ --overwrite T --feature-file-out T --output-weights T --output-dir $OUTPUT_DIR $OUTPUT_DIR/tide-search.txt

FOLDER_POST=_BASELINE_XPV
PARAM="--exact-p-value T --mz-bin-width 1.0005079 --mz-bin-offset 0.4 --use-tailor-calibration F --cross-corr-penalty T --skip-preprocessing F "
OUTPUT_DIR=$PATH$TAXON$FOLDER_POST
# $CRUX_ORIGINAL tide-search $FIX_PARAM $PARAM --output-dir $OUTPUT_DIR $DATA_FILE_ORIGINAL $PATH$INDEX
$CRUX_ORIGINAL assign-confidence --decoy-prefix DECOY_ --overwrite T --output-dir $OUTPUT_DIR $OUTPUT_DIR/tide-search.txt
$CRUX_ORIGINAL percolator --decoy-prefix DECOY_ --overwrite T --feature-file-out T --output-weights T --output-dir $OUTPUT_DIR $OUTPUT_DIR/tide-search.txt

# FOLDER_POST=_RES_EV_PVAL_HR
# PARAM="--mz-bin-width 1.0005079 --mz-bin-offset 0.4 --fragment-tolerance 0.02 --score-function both --exact-p-value T --use-flanking-peaks F" 
# OUTPUT_DIR=$PATH$TAXON$FOLDER_POST
# # $CRUX_ORIGINAL tide-search $FIX_PARAM $PARAM --output-dir $OUTPUT_DIR $DATA_FILE_ORIGINAL $PATH$INDEX
# $CRUX_ORIGINAL assign-confidence --overwrite T --score "combined p-value" --sidak F --output-dir $OUTPUT_DIR $OUTPUT_DIR/tide-search.txt
# $CRUX_ORIGINAL assign-confidence --overwrite T --score "res-ev p-value" --sidak F --output-dir $OUTPUT_DIR $OUTPUT_DIR/tide-search.txt
# $CRUX_ORIGINAL assign-confidence --overwrite T --score "exact p-value" --sidak F --output-dir $OUTPUT_DIR $OUTPUT_DIR/tide-search.txt
# $CRUX_ORIGINAL percolator --overwrite T --feature-file-out T --output-weights T --output-dir $OUTPUT_DIR $OUTPUT_DIR/tide-search.txt

FOLDER_POST=_RES_EV_PVAL_LR
PARAM="--mz-bin-width 1.0005079 --mz-bin-offset 0.4 --fragment-tolerance 0.05 --score-function both --exact-p-value T --cross-corr-penalty T --use-flanking-peaks F" 
OUTPUT_DIR=$PATH$TAXON$FOLDER_POST
# $CRUX_ORIGINAL tide-search $FIX_PARAM $PARAM --output-dir $OUTPUT_DIR $DATA_FILE_ORIGINAL $PATH$INDEX
$CRUX_ORIGINAL assign-confidence --decoy-prefix DECOY_ --overwrite T --score "combined p-value" --sidak F --output-dir $OUTPUT_DIR $OUTPUT_DIR/tide-search.txt
$CRUX_ORIGINAL assign-confidence --decoy-prefix DECOY_ --overwrite T --score "res-ev p-value" --sidak F --output-dir $OUTPUT_DIR $OUTPUT_DIR/tide-search.txt
$CRUX_ORIGINAL assign-confidence --decoy-prefix DECOY_ --overwrite T --score "exact p-value" --sidak F --output-dir $OUTPUT_DIR $OUTPUT_DIR/tide-search.txt
$CRUX_ORIGINAL percolator --decoy-prefix DECOY_ --overwrite T --feature-file-out T --output-weights T --output-dir $OUTPUT_DIR $OUTPUT_DIR/tide-search.txt

# RUN tide-search with peak filtered data
FOLDER_POST=_PF_LR_TAILOR
PARAM="--exact-p-value F --mz-bin-width 1.0005079 --mz-bin-offset 0.4 --use-tailor-calibration T --cross-corr-penalty T --skip-preprocessing T "
OUTPUT_DIR=$PATH$TAXON$FOLDER_POST
# $CRUX_ORIGINAL tide-search $FIX_PARAM $PARAM --output-dir $OUTPUT_DIR $DATA_FILE_PEAK_FILTERED_LR $PATH$INDEX
$CRUX_ORIGINAL assign-confidence --decoy-prefix DECOY_ --score "xcorr score" --overwrite T --output-dir $OUTPUT_DIR $OUTPUT_DIR/tide-search.txt
$CRUX_ORIGINAL assign-confidence --decoy-prefix DECOY_ --score "tailor score" --overwrite T --output-dir $OUTPUT_DIR $OUTPUT_DIR/tide-search.txt
$CRUX_ORIGINAL percolator --decoy-prefix DECOY_ --overwrite T --feature-file-out T --output-weights T --output-dir $OUTPUT_DIR $OUTPUT_DIR/tide-search.txt

FOLDER_POST=_PF_LR_XPV
PARAM="--exact-p-value T --mz-bin-width 1.0005079 --mz-bin-offset 0.4 --use-tailor-calibration F --cross-corr-penalty T --skip-preprocessing T "
OUTPUT_DIR=$PATH$TAXON$FOLDER_POST
# $CRUX_ORIGINAL tide-search $FIX_PARAM $PARAM --output-dir $OUTPUT_DIR $DATA_FILE_PEAK_FILTERED_LR $PATH$INDEX
$CRUX_ORIGINAL assign-confidence --decoy-prefix DECOY_ --overwrite T --output-dir $OUTPUT_DIR $OUTPUT_DIR/tide-search.txt
$CRUX_ORIGINAL assign-confidence --decoy-prefix DECOY_ --score "tailor score" --overwrite T --output-dir $OUTPUT_DIR $OUTPUT_DIR/tide-search.txt
$CRUX_ORIGINAL percolator --decoy-prefix DECOY_ --overwrite T --feature-file-out T --output-weights T --output-dir $OUTPUT_DIR $OUTPUT_DIR/tide-search.txt

FOLDER_POST=_PF_HR_TAILOR
PARAM="--exact-p-value F --mz-bin-width 0.05 --mz-bin-offset 0.0 --use-tailor-calibration T --cross-corr-penalty T --skip-preprocessing T "
OUTPUT_DIR=$PATH$TAXON$FOLDER_POST
# $CRUX_ORIGINAL tide-search $FIX_PARAM $PARAM --output-dir $OUTPUT_DIR $DATA_FILE_PEAK_FILTERED_HR $PATH$INDEX
$CRUX_ORIGINAL assign-confidence --decoy-prefix DECOY_ --score "xcorr score" --overwrite T --output-dir $OUTPUT_DIR $OUTPUT_DIR/tide-search.txt
$CRUX_ORIGINAL assign-confidence --decoy-prefix DECOY_ --score "tailor score" --overwrite T --output-dir $OUTPUT_DIR $OUTPUT_DIR/tide-search.txt
$CRUX_ORIGINAL percolator --decoy-prefix DECOY_ --overwrite T --feature-file-out T --output-weights T --output-dir $OUTPUT_DIR $OUTPUT_DIR/tide-search.txt

# # RUN exact-pvalue calculation, with RAW BOLTZMATCH
# CRUX=/home/attila/crux-3.2-8.pmass/src/crux_boltzmatch
# CRUX_TAILOR_BOLTZMATCH=/home/attila/crux-toolkit-tailor-boltzmatch/src/crux
# FOLDER_POST=_BOLZMATCH_US_XPV
# PARAM="--exact-p-value T --mz-bin-width 1.0005079"
# OUTPUT_DIR=$PATH$TAXON$FOLDER_POST
# $CRUX_TAILOR_BOLTZMATCH tide-search $FIX_PARAM $PARAM --output-dir $OUTPUT_DIR $DATA_FILE_BOLTZMATCH_RAW_LR $INDEX
# $CRUX_TAILOR_BOLTZMATCH assign-confidence --overwrite T --output-dir $OUTPUT_DIR $OUTPUT_DIR/tide-search.txt

# FOLDER_POST=_BOLZMATCH_US_LR
# PARAM="--exact-p-value F --mz-bin-width 1.0005079 --use-tailor-calibration T"
# OUTPUT_DIR=$PATH$TAXON$FOLDER_POST
# $CRUX_TAILOR_BOLTZMATCH tide-search $FIX_PARAM $PARAM --output-dir $OUTPUT_DIR $DATA_FILE_BOLTZMATCH_RAW_LR $INDEX
# $CRUX_TAILOR_BOLTZMATCH assign-confidence --score "xcorr score" --overwrite T --output-dir $OUTPUT_DIR $OUTPUT_DIR/tide-search.txt
# $CRUX_TAILOR_BOLTZMATCH assign-confidence --score "tailor score" --overwrite T --output-dir $OUTPUT_DIR $OUTPUT_DIR/tide-search.txt

# FOLDER_POST=_BOLZMATCH_US_HR
# PARAM="--exact-p-value F --mz-bin-width 0.05 --use-tailor-calibration T"
# OUTPUT_DIR=$PATH$TAXON$FOLDER_POST
# $CRUX_TAILOR_BOLTZMATCH tide-search $FIX_PARAM $PARAM --output-dir $OUTPUT_DIR $DATA_FILE_BOLTZMATCH_RAW_HR $INDEX
# $CRUX_TAILOR_BOLTZMATCH assign-confidence --score "xcorr score" --overwrite T --output-dir $OUTPUT_DIR $OUTPUT_DIR/tide-search.txt
# $CRUX_TAILOR_BOLTZMATCH assign-confidence --score "tailor score" --overwrite T --output-dir $OUTPUT_DIR $OUTPUT_DIR/tide-search.txt

# # ## RUN exact-pvalue calculation, with TAILOR BOLTZMATCH, WEAK SUPERVISION
# CRUX_ORIGINAL=/home/attila/crux-toolkit-tailor-boltzmatch/src/crux


# FOLDER_POST=_BOLTZMATCH_WS_XPV
# PARAM="--exact-p-value T --mz-bin-width 1.0005079"
# OUTPUT_DIR=$PATH$TAXON$FOLDER_POST
# # $CRUX_ORIGINAL tide-search $FIX_PARAM $PARAM --output-dir $OUTPUT_DIR $DATA_FILE_BOLTZMATCH_TAILOR_LR $PATH$INDEX
# $CRUX_ORIGINAL assign-confidence --score "xcorr score" --overwrite T --output-dir $OUTPUT_DIR $OUTPUT_DIR/tide-search.txt
# $CRUX_ORIGINAL assign-confidence --score "tailor score" --overwrite T --output-dir $OUTPUT_DIR $OUTPUT_DIR/tide-search.txt
# $CRUX_ORIGINAL percolator --overwrite T --feature-file-out T --output-weights T --output-dir $OUTPUT_DIR $OUTPUT_DIR/tide-search.txt

# FOLDER_POST=_BOLTZMATCH_WS_LR
# PARAM="--exact-p-value F --mz-bin-width 1.0005079 --use-tailor-calibration T"
# OUTPUT_DIR=$PATH$TAXON$FOLDER_POST
# # $CRUX_ORIGINAL tide-search $FIX_PARAM $PARAM --output-dir $OUTPUT_DIR $DATA_FILE_BOLTZMATCH_TAILOR_LR $PATH$INDEX
# $CRUX_ORIGINAL assign-confidence --score "xcorr score" --overwrite T --output-dir $OUTPUT_DIR $OUTPUT_DIR/tide-search.txt
# $CRUX_ORIGINAL assign-confidence --score "tailor score" --overwrite T --output-dir $OUTPUT_DIR $OUTPUT_DIR/tide-search.txt
# $CRUX_ORIGINAL percolator --overwrite T --feature-file-out T --output-weights T --output-dir $OUTPUT_DIR $OUTPUT_DIR/tide-search.txt

# FOLDER_POST=_BOLTZMATCH_WS_HR
# PARAM="--exact-p-value F --mz-bin-width 0.05 --use-tailor-calibration T"
# OUTPUT_DIR=$PATH$TAXON$FOLDER_POST
# # $CRUX_ORIGINAL tide-search $FIX_PARAM $PARAM --output-dir $OUTPUT_DIR $DATA_FILE_BOLTZMATCH_TAILOR_HR $PATH$INDEX
# $CRUX_ORIGINAL assign-confidence --score "xcorr score" --overwrite T --output-dir $OUTPUT_DIR $OUTPUT_DIR/tide-search.txt
# $CRUX_ORIGINAL assign-confidence --score "tailor score" --overwrite T --output-dir $OUTPUT_DIR $OUTPUT_DIR/tide-search.txt
# $CRUX_ORIGINAL percolator --overwrite T --feature-file-out T --output-weights T --output-dir $OUTPUT_DIR $OUTPUT_DIR/tide-search.txt
