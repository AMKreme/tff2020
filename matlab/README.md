# Matlab code for time-frequency fading (TFF)

# TFF: Time Frequency Fading

TFF is a toolbox written in Matlab that allows to do time-frequency region 
filtering out. More precisely, it is a Matlab implementation of the algorithms 
from *Time-frequency fading algorithms based on Gabor multipliers, by,
A. Marina Krémé, Valentin Emiya, Caroline Chaux, and Bruno Torrésani, 2020*. 

For more information please contact ama-marina.kreme@univ-amu.fr or valentin.emiya@lis-lab.fr

## Installation

Download the folder "tff2020" into the directory of your choice. 
Then within MATLAB go to file >> Set path... and add the directory containing
"tff2020/matlab" to the list (if it isn't already). 


## Dependencies

This toolbox requires *The Large Time Frequency Analysis Toolbox (LTFAT)* 
which can be downloaded  at  https://ltfat.github.io           

## Usage

See the documentation.

To reproduce the aforementioned paper figures:

- Figure 1 and 2 can be reproduced by running 
**tff2020/matlab/tfgm/scripts/exp_gabmul_eigs_properties.m**

- Figure 3 can be reproduced by running
**tff2020/matlab/tfgm/scripts/rank_estimation_halko_vs_eigs_gausswin.m**

- Figure 4 and 5 can be reproduced by running
**tff2020/matlab/tfgm/scripts/exp_tff1_car_bird.m**

You can also run the scripts 
**tff2020/matlab/tfgm/scripts/exp_all_tff1.m** and
**tff2020/matlab/tfgm/scripts/exp_all_tffP.m**
for more experiments 

## Copyright © 2019-2020

- [Laboratoire d'Informatique et Systemes](https://www.lis-lab.fr) 
- [Institut de Mathematiques de Marseille](https://www.i2m.univ-amu.fr)
- [Universite d'Aix-Marseille](https://www.univ-amu.fr)


## Contributors

- [A. Marina Kreme](ama-marina.kreme@univ-amu.fr)
- [Valentin Emiya](valentin.emiya@lis-lab.fr)





