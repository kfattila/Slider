#!/bin/bash
# Define resolution
resolution = 'lowres'
gpu_id='-1'  # uses CPU by default
# Run all available datasets

python -W ignore ./run.py chopin $resolution $gpu_id
python -W ignore ./run.py hela $resolution $gpu_id
python -W ignore ./run.py iprg $resolution $gpu_id
python -W ignore ./run.py humvar $resolution $gpu_id
python -W ignore ./run.py malaria $resolution $gpu_id

resolution = 'highres'
# Run all available datasets

python -W ignore ./run.py chopin $resolution $gpu_id
python -W ignore ./run.py hela $resolution $gpu_id
python -W ignore ./run.py iprg $resolution $gpu_id
python -W ignore ./run.py humvar $resolution $gpu_id
python -W ignore ./run.py malaria $resolution $gpu_id
