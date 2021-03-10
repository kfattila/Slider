#!/bin/bash

CRUX=/home/attila/crux-toolkit-tailor/src/crux

FIX_PARAM="--mz-bin-offset 0.4 --precursor-window 50 --use-z-line T --precursor-window-type ppm --top-match 1 --concat T --overwrite T --num-threads 1 --use-neutral-loss-peaks F --use-flanking-peaks F --min-peaks 10 --max-precursor-charge 25"
DATA_FILE_ORIGINAL=/home/data/mass_spec_data/OR6_19022013_GM_SU_Ecoli_Mix1_DyfgM_fr21.mzML
INDEX=ECOLI_IDX
TAXON=ECOLI
PATH=/home/attila/peak_filter/CRUX/
DECOY_PREFIX=decoy_
# RUN Original, RUN THIS IF THE RESULTS ARE MISSING OR THE PARAMETERS CHANGED
FOLDER_POST=_BASELINE_XCORR_LR
PARAM="--exact-p-value F --mz-bin-width 1.0005079 --use-tailor-calibration T"
# OUTPUT_DIR=$PATH$TAXON$FOLDER_POST
# # $CRUX tide-search $FIX_PARAM $PARAM --output-dir $OUTPUT_DIR $DATA_FILE_ORIGINAL $PATH$INDEX
# $CRUX assign-confidence --score "xcorr score" --decoy-prefix $DECOY_PREFIX --overwrite T --output-dir $OUTPUT_DIR $OUTPUT_DIR/tide-search.txt
# $CRUX assign-confidence --score "tailor score" --decoy-prefix $DECOY_PREFIX --overwrite T --output-dir $OUTPUT_DIR $OUTPUT_DIR/tide-search.txt
# $CRUX percolator --overwrite T --feature-file-out T --decoy-prefix $DECOY_PREFIX --output-weights T --output-dir $OUTPUT_DIR $OUTPUT_DIR/tide-search.txt

# FOLDER_POST=_BASELINE_XCORR_HR
# PARAM="--exact-p-value F --mz-bin-width 0.02 --use-tailor-calibration T"
# OUTPUT_DIR=$PATH$TAXON$FOLDER_POST
# # $CRUX tide-search $FIX_PARAM $PARAM --output-dir $OUTPUT_DIR $DATA_FILE_ORIGINAL $PATH$INDEX
# $CRUX assign-confidence --score "xcorr score" --decoy-prefix $DECOY_PREFIX --overwrite T --output-dir $OUTPUT_DIR $OUTPUT_DIR/tide-search.txt
# $CRUX assign-confidence --score "tailor score" --decoy-prefix $DECOY_PREFIX --overwrite T --output-dir $OUTPUT_DIR $OUTPUT_DIR/tide-search.txt
# $CRUX percolator --overwrite T --feature-file-out T --decoy-prefix $DECOY_PREFIX --output-weights T --output-dir $OUTPUT_DIR $OUTPUT_DIR/tide-search.txt

# FOLDER_POST=_BASELINE_XPV
# PARAM="--exact-p-value T --mz-bin-width 1.0005079 "
# OUTPUT_DIR=$PATH$TAXON$FOLDER_POST
# $CRUX tide-search $FIX_PARAM $PARAM --output-dir $OUTPUT_DIR $DATA_FILE_ORIGINAL $PATH$INDEX
# $CRUX assign-confidence --overwrite T --decoy-prefix $DECOY_PREFIX --output-dir $OUTPUT_DIR $OUTPUT_DIR/tide-search.txt
# $CRUX percolator --overwrite T --feature-file-out T --decoy-prefix $DECOY_PREFIX --output-weights T --output-dir $OUTPUT_DIR $OUTPUT_DIR/tide-search.txt

FOLDER_POST=_RES_EV_PVAL_HR
PARAM="--mz-bin-width 1.0005079 --mz-bin-offset 0.4 --fragment-tolerance 0.02 --score-function both --exact-p-value T --use-flanking-peaks F" 
OUTPUT_DIR=$PATH$TAXON$FOLDER_POST
$CRUX tide-search $FIX_PARAM $PARAM --output-dir $OUTPUT_DIR $DATA_FILE_ORIGINAL $PATH$INDEX
$CRUX assign-confidence --overwrite T --score "combined p-value" --sidak F --decoy-prefix $DECOY_PREFIX --output-dir $OUTPUT_DIR $OUTPUT_DIR/tide-search.txt
$CRUX assign-confidence --overwrite T --score "res-ev p-value" --sidak F --decoy-prefix $DECOY_PREFIX --output-dir $OUTPUT_DIR $OUTPUT_DIR/tide-search.txt
$CRUX assign-confidence --overwrite T --score "exact p-value" --sidak F --decoy-prefix $DECOY_PREFIX --output-dir $OUTPUT_DIR $OUTPUT_DIR/tide-search.txt
$CRUX percolator --overwrite T --feature-file-out T --output-weights T --decoy-prefix $DECOY_PREFIX --output-dir $OUTPUT_DIR $OUTPUT_DIR/tide-search.txt

FOLDER_POST=_RES_EV_PVAL_LR
PARAM="--mz-bin-width 1.0005079 --mz-bin-offset 0.4 --fragment-tolerance 0.05 --score-function both --exact-p-value T --use-flanking-peaks F" 
OUTPUT_DIR=$PATH$TAXON$FOLDER_POST
$CRUX tide-search $FIX_PARAM $PARAM --output-dir $OUTPUT_DIR $DATA_FILE_ORIGINAL $PATH$INDEX
$CRUX assign-confidence --overwrite T --score "combined p-value" --sidak F --decoy-prefix $DECOY_PREFIX --output-dir $OUTPUT_DIR $OUTPUT_DIR/tide-search.txt
$CRUX assign-confidence --overwrite T --score "res-ev p-value" --sidak F --decoy-prefix $DECOY_PREFIX --output-dir $OUTPUT_DIR $OUTPUT_DIR/tide-search.txt
$CRUX assign-confidence --overwrite T --score "exact p-value" --sidak F --decoy-prefix $DECOY_PREFIX --output-dir $OUTPUT_DIR $OUTPUT_DIR/tide-search.txt
$CRUX percolator --overwrite T --feature-file-out T --output-weights T --decoy-prefix $DECOY_PREFIX --output-dir $OUTPUT_DIR $OUTPUT_DIR/tide-search.txt

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

# FOLDER_POST=_BOLZMATCH_WS_XPV
# PARAM="--exact-p-value T --mz-bin-width 1.0005079"
# OUTPUT_DIR=$PATH$TAXON$FOLDER_POST
# $CRUX_TAILOR_BOLTZMATCH tide-search $FIX_PARAM $PARAM --output-dir $OUTPUT_DIR $DATA_FILE_BOLTZMATCH_TAILOR_LR $INDEX
# $CRUX_TAILOR_BOLTZMATCH assign-confidence --overwrite T --output-dir $OUTPUT_DIR $OUTPUT_DIR/tide-search.txt

# FOLDER_POST=_BOLZMATCH_WS_LR
# PARAM="--exact-p-value F --mz-bin-width 1.0005079 --use-tailor-calibration T"
# OUTPUT_DIR=$PATH$TAXON$FOLDER_POST
# $CRUX_TAILOR_BOLTZMATCH tide-search $FIX_PARAM $PARAM --output-dir $OUTPUT_DIR $DATA_FILE_BOLTZMATCH_TAILOR_LR $INDEX
# $CRUX_TAILOR_BOLTZMATCH assign-confidence --score "xcorr score" --overwrite T --output-dir $OUTPUT_DIR $OUTPUT_DIR/tide-search.txt
# $CRUX_TAILOR_BOLTZMATCH assign-confidence --score "tailor score" --overwrite T --output-dir $OUTPUT_DIR $OUTPUT_DIR/tide-search.txt

# FOLDER_POST=_BOLZMATCH_WS_HR
# PARAM="--exact-p-value F --mz-bin-width 0.05 --use-tailor-calibration T"
# OUTPUT_DIR=$PATH$TAXON$FOLDER_POST
# $CRUX_TAILOR_BOLTZMATCH tide-search $FIX_PARAM $PARAM --output-dir $OUTPUT_DIR $DATA_FILE_BOLTZMATCH_TAILOR_HR $INDEX
# $CRUX_TAILOR_BOLTZMATCH assign-confidence --score "xcorr score" --overwrite T --output-dir $OUTPUT_DIR $OUTPUT_DIR/tide-search.txt
# $CRUX_TAILOR_BOLTZMATCH assign-confidence --score "tailor score" --overwrite T --output-dir $OUTPUT_DIR $OUTPUT_DIR/tide-search.txt
