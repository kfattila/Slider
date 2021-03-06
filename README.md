Slider is machine-learning-based peptide-spectrum-matching scoring method for spectrum identification in tandem mass spectrometry, shotgun proteomics.

Authors:
Polina Kudriavtseva, Matvey Kashkinov, and Attila Kertesz-Farkas from 
HSE University, Moscow, Russia


## INSTALLATION
Download the code. 


## PREREQUISITES
Slider was tested with 
Python (3.7 )
Pytorch (1.5.1)
Matplotlib (2.0)
pyteomics (3.4)
BioPython (1.75)

and other standard python toolboxes such as:
argparse, time, numpy, seaborn, pandas, etc.

## SMOKE TEST
To see whether all components are installed properly, first unzip the test data.zip file in the ./data folder locally.

Then run:

$./RUN_TEST.sh

This script runs Slider on a small data. It should run not longer than 1-2 minutes.
If this terminates without error, you are all set.

The python scripts will produce a transformed spectrum data file in .ms2 format. You can use standard database searching methods to search the transformed .ms2 data file.

## PARAMETERS

The ./source/parameters.py file contains all the parameters, including to the path to the data files. You need to modify the path to your data files in own system.

## Contact:

akerteszfarkas at hse . r u







