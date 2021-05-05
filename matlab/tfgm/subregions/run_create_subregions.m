clc; clear; close all;
%%

pwd;
fig_dir ='create_subregions_cuicui';
if ~exist('create_subregions_cuicui','dir')
    mkdir('create_subregions_cuicui');
end
addpath('create_subregions_cuicui')

%%

loc_source='bird';
wideband_src='car';
gamma=0.7;
win_type ='gauss';

[alpha, thres, radius] = set_smooth_mask_params(wideband_src, loc_source, win_type);


win_dur =256/8000;
hop_ratio=1/4;
nbins_ratio=4;


[signals, dgt_params, signal_params, mask, mask_area, dgt,...,
    idgt] = get_mix(loc_source, wideband_src, gamma, win_dur, hop_ratio,...,
    nbins_ratio, win_type, alpha, thres, radius, fig_dir);



%%
tol = 1e-5;
mask_bool = mask;


[mask_labeled, n_areas,t_subregions] = get_nareas(mask_bool, dgt, idgt, dgt_params,...,
    signal_params, fig_dir, tol);



%%
