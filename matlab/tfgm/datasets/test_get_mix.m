clear; clear; close all;

%%
loc_source='bird';
wideband_src='car';
gamma=0.7;
win_type ='gauss';

[alpha, seuil, radius] = set_smooth_mask_params(wideband_src, loc_source, win_type);



%%
win_dur =256/8000;
hop_ratio=1/4;
nbins_ratio=4;
tol_subregions=0;

if tol_subregions==0
    nb_areas ='1aera';
else
    nb_areas='Pareas';
end


fig_dir =['fig_', nb_areas,'_car_bird_', win_type];
if ~exist(fig_dir,'dir')
    mkdir(fig_dir);
end
addpath(fig_dir)


[signals, dgt_params, signal_params, mask, dgt,...,
    idgt] = get_mix(loc_source, wideband_src, gamma, win_dur, hop_ratio,...,
    nbins_ratio, win_type, alpha, seuil, radius, fig_dir);

