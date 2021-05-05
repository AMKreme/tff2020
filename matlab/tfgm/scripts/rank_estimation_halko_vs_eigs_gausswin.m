clc; clear; close all;

% The script compares the rank of the Gabor multiplier estimated 
% by rand-evd (see [1]) and eigs (see [2]).

%[1] *Finding structure with randomness: Probabilistic algorithms for`
% constructing approximate matrix decompositions*, by N. Halko, P.-G. Martinsson,
% and J. A. Tropp,
%[2]*A Krylov-Schur Algorithm for Large Eigenproblems*, by Stewart, G.W.

%% figures directory

pwd;
pathname ='fig_rank_randEvd_vs_eigs';
if ~exist(pathname,'dir')
    mkdir(pathname);
end
addpath(pathname)

%%  Signal_params

fs=8000;
sig_len = 16384;

signal_params = generate_signal_parameters(fs, sig_len);


%% Rand-evd params

tolerance = 1e-6; % 
proba = 1-1e-4;
r =  compute_r(sig_len, sig_len, proba);
%%  DGT params and operators

t_lim = [0.4, 0.6];
f_lims = 0.2:0.05:0.6;

win_type = 'gauss';

win_len = 256;
params = get_params(win_len, win_type);

hop = params.hop;
nbins =params.nbins;
dgt_params = generate_dgt_parameters(win_type, win_len, hop, nbins, sig_len);

[dgt, idgt] = get_stft_operators(dgt_params, signal_params);

%%
mask_area_list = zeros(length(f_lims),1);
ranks_arrf = zeros(length(f_lims),1);
ranks_eigs= zeros(length(f_lims),1);
t_arrf = zeros(length(f_lims),1);
t_eigs = zeros(length(f_lims),1);
s_vec_list = cell(length(f_lims),1);


thres = 10^(-14); % using for evd with eigs
%%
for k =1:length(f_lims)
    fprintf("first iteration %.f please wait\n",k);
    % Mask Generation
    
    f_lim =[0.1, f_lims(k)];
    mask = generate_rectangular_mask(dgt_params.nbins,dgt_params.hop, signal_params.sig_len, t_lim, f_lim);
    
    [mask_area, mask_area_ratio] = get_mask_area(mask);
    mask_area_list(k) = mask_area;
    
    fprintf('mask area:%.f\n', mask_area)
    if mask_area>signal_params.sig_len
        fprintf('attention %.f\n',k)
    end
    figure(k);
    plot_mask(mask, dgt_params.nbins, dgt_params.hop, signal_params.fs);
    
    %Gabor multiplier
   gab_mul = gen_gabmul_operator(dgt, idgt, mask);
    
    %rand-evd
    tic;
    q_mat = adaptative_randomized_range_finder(gab_mul, sig_len, tolerance, r);
    t_arrf(k) = toc;
    
    ranks_arrf(k)= size(q_mat,2);
     eigs
    tic;
    [u_mat,s] = eigs(gab_mul, signal_params.sig_len, signal_params.sig_len);
    t_eigs(k) = toc;
    
    s_vec = diag(s);
    s_vec_list{k} = s_vec;
    ranks_eigs(k) = length(s_vec(s_vec > seuil));
end



%% plot figures

figure;
plot(mask_area_list,ranks_arrf,'LineWidth',3); hold on;
plot(mask_area_list,ranks_eigs,'LineWidth',3);
%set(gca,'XScale','log')
xlabel('Mask area')
ylabel('Estimated rank')
grid('on');
legend('Rand-EVD', 'eigs', 'Location','northwest');
set(gca, 'FontSize', 20, 'fontName','Times');
saveas(gcf,fullfile(pathname,'rank_estimation_gauss.png'));
saveas(gcf,fullfile(pathname,'rank_estimation_gauss.fig'));

%%
save('rank_estimation.mat','ranks_arrf','ranks_eigs', 'mask_area_list',...,
    't_arrf','t_eigs', 's_vec_list');
