# tff2020
*tff2020* is a toolkit available in both Matlab and python languages for time-frequency fading using Gabor multipliers based on the work in paper
**Time-frequency fading algorithms based on Gabor multipliers**
by A. Marina Krémé, Valentin Emiya, Caroline Chaux and Bruno Torré́sani, 2020.

For more information please contact ama-marina.kreme@univ-amu.fr/valentin.emiya@lis-lab.fr

#Instruction for Matlab user

## Installation

Download the folder "tff2020" into the directory of your choice. 
Then within MATLAB go to file >> Set path... and add the directory containing
 "tff2020/matlab" to the list (if it isn't already). 


## Dependencies

This toolbox requires *The Large Time Frequency Analysis Toolbox (LTFAT)* 
which can be downloaded  at  https://ltfat.github.io   

## About tff2020
The audio signals are available in the **data** folder.

The provided Matlab code contains the directories we describe below: 
* [halko2011](# halko2011) : contains the functions that implement the random projection methods.
* [tfgm](# tfgm) : is the main directory of time-frequency fading (TFF). It contains the following subdirectories:
   - datasets : contains the functions which make it possible to load the signals, to form the pairs, to generate the parameters of smoothing for the various masks and to generate the mixtures.
 \item \texttt{subregions} : contains the functions which allow to implement the Algorithm \ref{algo:subregions} page \pageref{algo:subregions}.
 \item \texttt{tf\_fading} : contains the various functions which intervene in the Algorithms \ref{algo:tffP} and \ref{algo:tff1}.
 \item \texttt{tf\_tools} : contains the functions which generate the parameters of the Gabor transform, those of the signal, and the Gabor multiplier
 \item \texttt{utils} : contains all the additional functions necessary for the implementation of our algorithms
  \item \texttt{scripts} : contains the scripts which allow to reproduce all the results of chapter 5.

Translated with www.DeepL.com/Translator (free version)



We compared GLI, PCI and PLI to a reference method which consists in replacing the missing phases by random phases (RPI).
Considering the complexity in memory as well as in time, we have 
- a quick and small demonstration on a synthetic signal where we compare GLI , PCI, PLI and RPI. 
To reproduce it, you just have to launch the script *exp_audio_phase_inpainting.m*. 
You can also see the result directly by clicking on the following link http://kreme.perso.math.cnrs.fr/AudiophaseInpainting/index.html



## Usage

See the documentation. 

To reproduce the results of the above mentioned paper, simply run the **script_run_all_experiment.m** and **script_plot_all_exp_results.m**
file located in your current directory. 



## Copyright © 2020-2021

- [Laboratoire d'Informatique et Systèmes](https://www.lis-lab.fr) 
- [Institut de Mathématiques de Marseille](https://www.i2m.univ-amu.fr)
- [Université d'Aix-Marseille](https://www.univ-amu.fr)


## Contributors

- [A. Marina Krémé](ama-marina.kreme@univ-amu.fr)
- [Valentin Emiya](valentin.emiya@lis-lab.fr)



