#!/bin/bash

# Define resolution
resolution='lowres'
gpu_id='-1'

# Perform a smoke test to see all components and modules are installed well.
python -W ignore ./run.py ups1 $resolution $gpu_id

