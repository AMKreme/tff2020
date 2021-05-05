clc; clear; close all;
%%
% This script generates figures 1 and 2 of the paper.
% The mask used for figure 1 is the one that has been computed with
% the time-frequency parameters generated with a Gauss window of 256 time samples.

%% Load time-frequency mask from .mat file

mask_gauss = load('mask.mat');

%% directory for figures

fig_dir ='fig_localisation_properties_of_gabmul_eigs';
if ~exist(fig_dir,'dir')
    mkdir(fig_dir);
end
addpath(fig_dir)

%% structure containing the parameters for each of the windows

param_dict = struct('Gauss256', struct('win_type', 'gauss', 'win_dur',256/8000,...
    'hop_ratio', 1/4, 'nbins_ratio',4),...
    'Hann512', struct('win_type','hann', 'win_dur',512/8000,...,
    'hop_ratio',1/8, 'nbins_ratio',2));



%% structure of signals parameters
signal_params = struct('fs',8000,'sig_len', 16384);

%%
for k_param= 1 :length(fieldnames(param_dict))
    keys = fieldnames(param_dict);
    param = param_dict.(keys{k_param});
    
    win_type=param.('win_type');
    win_dur=param.('win_dur');
    fs = signal_params.fs;
    hop_ratio=param.('hop_ratio');
    nbins_ratio=param.('nbins_ratio');
    
    approx_win_len = 2.^round(log2(win_dur*fs));
    hop =  approx_win_len* hop_ratio;
    nbins = approx_win_len * nbins_ratio;
    
    sig_len = signal_params.sig_len;
    
    dgt_params = generate_dgt_parameters(win_type, approx_win_len, hop,...,
        nbins, sig_len);
    
    [dgt, idgt] = get_stft_operators(dgt_params, signal_params);
    
    
    param_dict.(keys{k_param}).('signal_params') = signal_params;
    param_dict.(keys{k_param}).('dgt_params') = dgt_params;
    param_dict.(keys{k_param}).('dgt') = dgt;
    param_dict.(keys{k_param}).('idgt') = idgt;
    
end


%% Compute the evd of the multiplier by using the DGT and IDGT
% generated from the Gauss window
%%

nb_eigvalues=4000;

sig_len = param_dict.Gauss256.signal_params.sig_len; % signal length

gab_mul = gen_gabmul_operator(param_dict.('Gauss256').dgt, ...,
    param_dict.('Gauss256').idgt, mask_gauss.mask);
tic;
q_mat = randomized_range_finder(gab_mul, sig_len, nb_eigvalues);
t1= toc;
fprintf(" runtimes for Q: %f\n", t1);

tic;
evdn_gauss = EVD_nystrom(gab_mul, q_mat);
t2 = toc;

fprintf(" runtimes for nystrom - gauss: %f\n", t2);


%% Compute the evd of the multiplier by using the DGT and IDGT
% generated from the Hann window. The calculation of the evd is
% done with the Gauss mask
%%
% gabor multiplier

gab_mul = gen_gabmul_operator(param_dict.('Hann512').dgt, ...,
    param_dict.('Hann512').idgt,  mask_gauss.mask);
%rand-evd
tic;
q_mat = randomized_range_finder(gab_mul, sig_len, nb_eigvalues); %rand-evd
t1= toc;
fprintf(" runtimes for Q: %f\n", t1);
tic;
evdn_hann = EVD_nystrom(gab_mul, q_mat);
t2 = toc;


fprintf(" runtimes for nystrom-hann: %f\n", t2);



%% eigenvalues


figure;
D1 = diag(evdn_hann.D);
D2= diag(evdn_gauss.D);

semilogy(D2,'b', 'Linewidth',4);
hold on;
semilogy(D1, 'r','Linewidth',4);
semilogy(D2(1),'bo', 'Linewidth', 15,'MarkerSize',10)
semilogy(D1(1),'r^','Linewidth', 15,'MarkerSize',10)
semilogy(3199,D2(3199),'bo','Linewidth', 15,'MarkerSize',10)
semilogy(3072,D1(3072),'r^','Linewidth', 15,'MarkerSize',10)
grid on;


xlabel({'Indices $k$'},'Interpreter','latex');
ylabel({'Vecteurs propres $\sigma[k]$'},'Interpreter','latex');

set(gca, 'FontSize', 20, 'fontName','Times');

l = legend('Gauss','Hann',...,
    '$\sigma[1]$ = 1, $\sigma[3072] = 3.914 \times 10^{-4}$',...,
    '$\sigma[1]$ =1, $\sigma[3199] = 3.865 \times 10^{-4}$',...,
    'Location','southwest');

set(l, 'interpreter', 'latex')
saveas(gcf,fullfile(fig_dir, 'eigenvalues_gauss_hann.fig'));
saveas(gcf,fullfile(fig_dir, 'eigenvalues_gauss_hann.png'));

%% eigenvectors

eigs_gauss = evdn_gauss.U;


figure;
set(gcf,'position',[1, 1 1000 800]);
subplot(221);
plot_spectrogram(eigs_gauss(:,1), param_dict.('Gauss256').dgt_params,...,
    param_dict.('Gauss256').signal_params, param_dict.('Gauss256').dgt);
yticks([0,1000,2000,3000,4000]);
yticklabels([0,1,2,3,4]);
%ylabel('Frequency (kHz)')
ylabel('Fréquence (kHz)')
xlabel('Temps(s)')
set(gca, 'FontSize', 20, 'fontName','Times');
subplot(222);
plot_spectrogram(eigs_gauss(:,100), param_dict.('Gauss256').dgt_params,...,
    param_dict.('Gauss256').signal_params, param_dict.('Gauss256').dgt);
yticks([0,1000,2000,3000,4000]);
yticklabels([0,1,2,3,4]);
%ylabel('Frequency (kHz)')
ylabel('Fréquence (kHz)')
xlabel('Temps(s)')
set(gca, 'FontSize', 20, 'fontName','Times');
subplot(223);
plot_spectrogram(eigs_gauss(:,3199), param_dict.('Gauss256').dgt_params,...,
    param_dict.('Gauss256').signal_params, param_dict.('Gauss256').dgt);
yticks([0,1000,2000,3000,4000]);
yticklabels([0,1,2,3,4]);
%ylabel('Frequency (kHz)')
ylabel('Fréquence (kHz)')
xlabel('Temps(s)')
set(gca, 'FontSize', 20, 'fontName','Times');
subplot(224);
plot_spectrogram(eigs_gauss(:,3072), param_dict.('Gauss256').dgt_params,...,
    param_dict.('Gauss256').signal_params, param_dict.('Gauss256').dgt);
%ylabel('Frequency (kHz)')
ylabel('Fréquence (kHz)')
xlabel('Temps(s)')
yticks([0,1000,2000,3000,4000]);
yticklabels([0,1,2,3,4]);
set(gca, 'FontSize', 20, 'fontName','Times');
saveas(gcf,fullfile(fig_dir, 'eigvectors_prop_illustration.png'));
%saveas(gcf,fullfile(fig_dir, 'eigvectors_prop_illustration.fig'));

%% mask
figure;
plot_spectrogram(mask_gauss.mask, param_dict.('Gauss256').dgt_params,...,
    param_dict.('Gauss256').signal_params, param_dict.('Gauss256').dgt);
%ylabel('Frequency (kHz)')
ylabel('Fréquence (kHz)')
xlabel('Temps(s)')
yticks([0,1000,2000,3000,4000]);
yticklabels([0,1,2,3,4]);
set(gca, 'FontSize', 20, 'fontName','Times');
%saveas(gcf,fullfile(fig_dir, 'mask_gauss.fig'));
saveas(gcf,fullfile(fig_dir, 'mask_gauss.png'));

%%
save('evdn_gauss_hann.mat','evdn_hann','evdn_gauss','param_dict','mask_gauss');





