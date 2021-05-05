
clc; clear; close all;

%%

pwd;
fig_dir ='fig_energy_estimation';
if ~exist('fig_energy_estimation','dir')
    mkdir('fig_energy_estimation');
end
addpath('fig_energy_estimation')
%%

loc_source = 'bird';
wideband_src = 'car';


win_type = 'gauss';
win_dur = 256 / 8000;
hop_ratio = 1 / 4;
nbins_ratio = 4;
tol_subregions = 0;
gamma=0.7;

[alpha, thres, radius] = set_smooth_mask_params(wideband_src, loc_source, win_type);

%%
[signals, dgt_params, signal_params, mask, mask_area, dgt,...,
    idgt] = get_mix(loc_source, wideband_src, gamma, win_dur, hop_ratio,...,
    nbins_ratio, win_type, alpha, thres, radius, fig_dir);

%%
x_mix = signals.mix;
e_est = estimate_energy_in_mask(x_mix, mask, dgt_params, signal_params, dgt,fig_dir);
x_wb = signals.wideband;
x_wd_tf_mat = dgt(x_wb);
e_true = norm(mask.*x_wd_tf_mat,'fro').^2;

fprintf('Estimated energy:%f\n', e_est)
fprintf('True energy: %f \n', e_true)

%%


