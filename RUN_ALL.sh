#!/bin/bash
# Define resolution
resolution = 'lowres'
# Run all available datasets
python -W ignore .\rbm_train_main.py -d aurum -r resolution -lc True -fc True -wm True # aurum
python -W ignore .\rbm_train_main.py -d iprg -r resolution -lc True -fc True -wm True # iprg
python -W ignore .\rbm_train_main.py -d hspp2a -r resolution -lc True -fc True -wm True # hspp2a
python -W ignore .\rbm_train_main.py -d humvar -r resolution -lc True -fc True -wm True # humvar
python -W ignore .\rbm_train_main.py -d malaria -r resolution -lc True -fc True -wm True # malaria
python -W ignore .\rbm_train_main.py -d yeast -r resolution -lc True -fc True -wm True # yeast

resolution = 'highres'
# Run BoltzMatch using high-res settings
python -W ignore .\rbm_train_main.py -d iprg -r resolution -lc True -fc True -wm True # iprg
python -W ignore .\rbm_train_main.py -d humvar -r resolution -lc True -fc True -wm True # humvar
python -W ignore .\rbm_train_main.py -d malaria -r resolution -lc True -fc True -wm True # malaria
