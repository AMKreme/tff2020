# tff2020
*tff2020* is a toolkit available in both Matlab and python languages for time-frequency fading using Gabor multipliers based on the work in paper
**Time-frequency fading algorithms based on Gabor multipliers**
by A. Marina Krémé, Valentin Emiya, Caroline Chaux and Bruno Torrésani, 2020.

For more information please contact ama-marina.kreme@univ-amu.fr/ valentin.emiya@lis-lab.fr

#Instruction for Matlab user

## Installation

Download the folder *tff2020*into the directory of your choice. 
Then within MATLAB go to file :
```
>> cd ../tff2020/matlab 
>> addpath matlab
```

## Dependencies

*tff2020* requires *The Large Time Frequency Analysis Toolbox (LTFAT)* 
which can be downloaded  at  https://ltfat.github.io   

## About tff2020
The audio signals are available in the **data** folder.

The provided Matlab code contains the directories we describe below: 
* [halko2011](#halko2011): contains the functions that implement the random projection methods.
* [tfgm](#tfgm): is the main directory of time-frequency fading (TFF). It contains the following subdirectories:
    - datasets: contains the functions which make it possible to load the signals, to form the pairs, to generate the parameters of smoothing for the various masks and to generate the mixtures.
   - subregions: contains the functions which allow to implement the Algorithm 3 of the paper.
   - tf_fading: contains the various functions which are used in in the Algorithm 1 and 2.
   - tf_tools: contains the functions which generate the parameters of the Gabor transform, those of the signal, and the Gabor multiplier
   - utils : contains all the additional functions necessary for the implementation of our algorithms
   - scripts: contains the scripts which allow to reproduce all the results of paper.

To reproduce the figures in paper, simply run the scripts shown below: 

- Figure 1 can be reproduced by executing *tff2020/matlab/tfgm/datasets/test_get_mix.m*
- Figures 1 and 2  can be reproduced by executing *tff2020/matlab/tfgm/scripts/exp\_gabmul\_eigs\_properties.m*
- Figure 3 can be reproduced by excecuting \texttt{tff2020/matlab/tfgm/scripts/rank\_estimation\_halko\_vs\_eigs_gausswin.m}
- Figures 4 and 5  can be reproduced by executing *tff2020/matlab/tfgm/scripts/exp\_tff1\_car\_bird.m* and 
 *tff2020/matlab/tfgm/scripts/exp\_tffP\_car\_bird.m*
- Tables I and II can be reproduced by running the full experiment from *tff2020/matlab/tfgm/scripts/exp_all_tff1.m* and
*tff2020/matlab/tfgm/scripts/exp\_all\_tffP.m*


#Instruction for Python user

The python code is available on the platform \href{https://pypi.org/project/tffpy/}{PyPI}. 

## Setup

To run it, install it locally as follow. First make sure you have Python >=3.6 
tffpy requires the following packages, 

 - python >= 3.6
 - numpy >= 1.13
 - scipy
 - matplotlib
 - pandas
 - xarray
 - ltfatpy
 - skpomade
 - yafe
 - madarrays
which will be automatically installed with tffpy using pip:

```
$ cd ../your directory
$ pip install tffpy
```

The main experiments of paper are available by running the following scripts 
 
 - Figure 4 can be reproduced in Python by executing the specific tasks 12 and 13 of *tffpy.scripts.script_exp_solve_tff.py*
 - Figure 5 can be reproduced in Python by executing the specific tasks 12 and 13 of *tffpy.scripts.script_exp_solve_tff.py*
 - Tables I and II can be reproduced in Python by running the complete experiment of *tffpy.scripts.script_exp_solve_tff.py*
 and *tffpy.scripts.script\_exp\_solve\_tff.py*
 - Table II can be reproduced in Python by running the full experiment from tffpy.scripts.script_exp_solve_tff.py.

## Usage

See the documentation. 


## Copyright © 2020-2021

- [Laboratoire d'Informatique et Systèmes](https://www.lis-lab.fr) 
- [Institut de Mathématiques de Marseille](https://www.i2m.univ-amu.fr)
- [Université d'Aix-Marseille](https://www.univ-amu.fr)


## Contributors

- [A. Marina Krémé](ama-marina.kreme@univ-amu.fr)
- [Valentin Emiya](valentin.emiya@lis-lab.fr)



