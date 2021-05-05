clc; clear; close all;
%%
% This script executes algorithm 2 (TFF-P: filtering out P TF sub-regions)
% proposed in paper [1] on a single dataset including engine sound and birdsong.
%
%
% [1] Time-frequency fading algorithms based on Gabor multipliers,
% A. Marina Kreme Valentin Emiya, Caroline Chaux, and Bruno Torresani
%%
dbstack;
%%
loc_source='bird';
wideband_src='car';
setting = 6;

if setting == 1
    
    win_type = 'hann';
    win_dur = 128/8000;
    hop_ratio = 1/4;
    nbins_ratio = 4;
    tol_subregions = 1e-5;
    [alpha, seuil, radius] = set_smooth_mask_params(wideband_src, loc_source, win_type);
    
elseif setting == 2
    
    win_type = 'hann';
    win_dur = 256/8000;
    hop_ratio = 1/8;
    nbins_ratio = 2;
    tol_subregions = 1e-5;
    [alpha, seuil, radius] = set_smooth_mask_params(wideband_src, loc_source, win_type);
    
    
elseif setting == 3
    
    win_type = 'hann';
    win_dur = 512/8000;
    hop_ratio = 1/4;
    nbins_ratio = 4;
    tol_subregions = 1e-5;
    [alpha, seuil, radius] = set_smooth_mask_params(wideband_src, loc_source, win_type);
    
            
elseif setting == 4
    win_type = 'hann';
    win_dur = 512/8000;
    hop_ratio = 1/8;
    nbins_ratio = 2;
    tol_subregions = 1e-5;
    [alpha, seuil, radius] = set_smooth_mask_params(wideband_src, loc_source, win_type);
    
    
elseif setting == 5
    
    win_type = 'gauss';
    win_dur = 128 / 8000;
    hop_ratio = 1 / 4;
    nbins_ratio = 4;
    tol_subregions = 1e-5;
    [alpha, seuil, radius] = set_smooth_mask_params(wideband_src, loc_source, win_type);
    
elseif setting == 6
    
    win_type = 'gauss';
    win_dur = 256 / 8000;
    hop_ratio = 1 / 4;
    nbins_ratio = 4;
    tol_subregions = 1e-5;
    [alpha, seuil, radius] = set_smooth_mask_params(wideband_src, loc_source, win_type);
    
elseif setting == 7
    
    win_type = 'gauss';
    win_dur = 256 / 8000;
    hop_ratio = 1 / 8;
    nbins_ratio = 2;
    tol_subregions = 1e-5;
    [alpha, seuil, radius] = set_smooth_mask_params(wideband_src, loc_source, win_type);
    
end

%%

nb_areas ='Paeras';

pwd;
fig_dir =['fig_solve_', nb_areas,'_car_bird_', win_type];
if ~exist(fig_dir,'dir')
    mkdir(fig_dir);
end
addpath(fig_dir);
%%



gamma=0.7;

[signals, dgt_params, signal_params, mask, mask_area, dgt,...,
    idgt] = get_mix(loc_source, wideband_src, gamma, win_dur, hop_ratio,...,
    nbins_ratio, win_type, alpha, seuil, radius, fig_dir);


fprintf('win_len:%.f\n', length(dgt_params.win));
fprintf('hop:%.f\n', dgt_params.hop);
fprintf('n_bins:%.f\n', dgt_params.nbins);
%%
mask_bool = mask;
[mask_labeled, n_areas,t_subregions] = get_nareas(mask_bool,dgt, idgt, dgt_params,...,
    signal_params, fig_dir, tol_subregions);


%%
[gabmul_list, mask_list] = get_P_gabmul(mask_labeled, dgt, idgt);

x_mix = signals.mix;
tolerance_arrf = 1e-3;
proba_arrf = 1 - 1e-4;


[t_arrf,t_evdn, t_ut_x, rank_q, s_vec_list, u_mat_list,...,
    ut_x_list,r] = compute_decomposition(x_mix, mask_list, gabmul_list,...,
    tolerance_arrf, proba_arrf);

%% plot mask

figure('name','mask');
plot_mask(mask, dgt_params.hop,dgt_params.nbins, signal_params.fs);
title(['mask :  mask-area = ',num2str(mask_area)]);
set(gca, 'FontSize', 20, 'fontName','Times');
saveas(gcf,fullfile(fig_dir, 'mask.pdf'));

%% Plot eigenvalues
figure;

for k_area=1:n_areas
    txt = ['sub-region =' num2str(k_area)];
    plot(s_vec_list{k_area},'LineWidth',3, 'DisplayName',txt);
    hold on;
end
xlabel('$k$','Interpreter','latex');
ylabel('$\sigma[k]$','Interpreter','latex');
set(gca,'YScale','log');
grid;
legend show;
set(gca, 'FontSize', 25, 'fontName','Times');
xlabel('$k$','Interpreter','latex');
set(gca, 'FontSize', 25, 'fontName','Times');
saveas(gcf,fullfile(fig_dir, 'gabmul_eigenvalues.pdf'));

%% find optimal lambda (best SDR)
x_wideband = signals.wideband;
x_rec = @(lambda_coef)compute_estimate(lambda_coef, x_mix, s_vec_list,...,
    u_mat_list, ut_x_list);

[lambda_oracle, t_oracle] = compute_lambda_oracle_sdr(n_areas,x_wideband, x_rec);

disp("Running time to tune lambda (oracle): %f \n")
disp(t_oracle);

%% Estimate energy and lambda


[lambda_est, t_lambda_est] = compute_lambda(x_mix, mask_labeled, dgt_params,...,
    signal_params,  dgt,s_vec_list, u_mat_list, ut_x_list,...,
    gabmul_list,fig_dir);

fprintf("Running time to tune lambda (est): \n")
disp(t_lambda_est);



%% Results

x_wideband = signals.wideband;
sdr_wideband = @(lambda_coef)sdr(x_wideband, x_rec(lambda_coef));

sdr_wideband_1area = @(lambda_coef, k_area)sdr_1region(lambda_coef, k_area, x_rec, x_wideband, n_areas);

is_wideband = @(lambda_coef) itakura_saito_dist_spectrum(x_wideband, x_rec(lambda_coef));

is_wideband_1area = @(lambda_coef,k_area)is_spectrum_1region(x_wideband, k_area,lambda_coef, n_areas,x_rec);

%% SDR for each area

l_range = 10.^linspace(-10,10,100);

sdr_engine1area_l = zeros(length(l_range),1);


for k_area =1: n_areas
   figure;
    for k=1:length(l_range)
        sdr_engine1area_l(k) = sdr_wideband_1area(l_range(k), k_area);
    end
    txt = 'SDR';
    plot(l_range, sdr_engine1area_l,'LineWidth',3,'DisplayName',txt)


hold on;

    txt1 = 'TFF-O ';
    plot(lambda_oracle(k_area), sdr_wideband_1area(lambda_oracle(k_area), k_area),...,
        '*','LineWidth',3,'DisplayName',txt1);
    txt2 = 'TFF-P';
    plot(lambda_est(k_area),sdr_wideband_1area(lambda_est(k_area), k_area),...,
        'o','LineWidth',3,'DisplayName',txt2);
    txt3 = 'Zero fill';
    plot(1, sdr_wideband_1area(1, k_area), 'o','LineWidth',3,'DisplayName',txt3);
    

legend show;


xlabel('$\lambda$','Interpreter','latex')
ylabel('SDR(dB)')
title(['SDR sub-region:' num2str(k_area)])
set(gca,'XScale','log');
grid on;
set(gca, 'FontSize', 20, 'fontName','Times');

saveas(gcf,fullfile(fig_dir, ['tuning_lambda_area_',num2str(k_area),'.pdf']));
end

%% Itakura saito for each aera

is_engine1area_l = zeros(length(l_range),1);

for k_area =1: n_areas
    figure;
    for k=1:length(l_range)
        is_engine1area_l(k) = is_wideband_1area(l_range(k), k_area);
    end
    txt ='IS'; 
    plot(l_range, is_engine1area_l,'LineWidth',3,'DisplayName',txt)

hold on;

    
    plot(lambda_oracle(k_area), is_wideband_1area(lambda_oracle(k_area),k_area), 'o','LineWidth',3)
    plot(lambda_est(k_area), is_wideband_1area(lambda_est(k_area),k_area), 'o')
    plot(1, is_wideband_1area(1,k_area), 'o','LineWidth',3)
    
    
xlabel('$\lambda$','Interpreter','latex')
ylabel('IS (dB)')
set(gca,'XScale','log');
title(['IS sub-region:' num2str(k_area)])
grid()
legend('IS','TFF-O','TFF-P','Zero fill')
axis tight;
set(gca, 'FontSize', 20, 'fontName','Times');
saveas(gcf,fullfile(fig_dir, ['tuning_IS_',num2str(k_area),'.pdf']));
end

%% plot both sdr and itakura saito in the same axis
sdr_engine1area_l = zeros(length(l_range),1);
is_engine1area_l = zeros(length(l_range),1);
for k_area =1:n_areas
  figure;
    for k=1:length(l_range)
        sdr_engine1area_l(k) = sdr_wideband_1area(l_range(k), k_area);
        is_engine1area_l(k) = is_wideband_1area(l_range(k), k_area);
    end

txt = ['SDR sub-reg  =' num2str(k_area)];
yyaxis left;
plot(l_range, sdr_engine1area_l, '-','LineWidth',3); hold on;
plot(lambda_oracle(k_area), sdr_wideband_1area(lambda_oracle(k_area), k_area), ...,
    'o','LineWidth',3)
plot(lambda_est(k_area),sdr_wideband_1area(lambda_est(k_area), k_area),...,
    'bo','LineWidth',3)
plot(1, sdr_wideband_1area(1, k_area), 'mo', 'LineWidth',3);
grid on;
xlabel('$\lambda$','Interpreter','latex')
ylabel('SDR (dB)')
set(gca,'XScale','log');


yyaxis right;

plot(l_range,is_engine1area_l,'-','LineWidth',3); hold on;
plot(lambda_oracle(k_area), is_wideband_1area(lambda_oracle(k_area),k_area),...,
    'o','LineWidth',3)
plot(lambda_est(k_area), is_wideband_1area(lambda_est(k_area),k_area), 'bo',...,
    'LineWidth',3)
plot(1, is_wideband_1area(1,k_area), 'mo','LineWidth',3)


legend('SDR','TFF-O','TFF-P','Zero fill','Location','northwest');
xlabel('$\lambda$','Interpreter','latex')
ylabel('IS divergence')
title(['SDR-IS sub-reg:' num2str(k_area)])
set(gca, 'FontSize', 20, 'fontName','Times');


saveas(gcf,fullfile(fig_dir, ['tuning_lambda_SDR_IS',num2str(k_area),'.pdf']));
end
%% Reconstructed signals


x_oracle = x_rec(lambda_oracle);
wav_write('x_oracle.wav', x_oracle, signal_params.fs);

x_est = x_rec(lambda_est);
wav_write('x_est.wav', x_est, signal_params.fs);

x_true_energy = x_rec(lambda_true_energy);
wav_write('x_true_energy.wav', x_true_energy, signal_params.fs);


x_zero = zero_fill_solver(x_mix, mask, dgt, idgt,  dgt_params,...,
    signal_params, fig_dir);
wav_write('x_zero_fill.wav', x_zero, signal_params.fs);

x_interp= interpolation_solver(x_mix, mask, dgt, idgt, dgt_params,...,
    signal_params, fig_dir);
wav_write('x_interp.wav', x_zero, signal_params.fs);


%% Sdr

sdr_oracle = sdr(x_wideband, x_oracle);
sdr_est = sdr(x_wideband, x_est);
sdr_true_energy = sdr(x_wideband, x_true_energy);
sdr_zero = sdr(x_wideband, x_zero);
sdr_interp = sdr(x_wideband, x_interp);
sdr_mix = sdr(x_wideband, x_mix);


%% Itakura saito
is_oracle = itakura_saito_dist_spectrum(x_wideband,x_oracle);
is_est = itakura_saito_dist_spectrum(x_wideband,x_est);
is_true_energy = itakura_saito_dist_spectrum(x_wideband,x_true_energy);
is_zero = itakura_saito_dist_spectrum(x_wideband,x_zero) ;
is_mix=   itakura_saito_dist_spectrum(x_wideband,x_mix) ;
is_interp= itakura_saito_dist_spectrum(x_wideband,x_interp);

%%

fprintf('Oracle lambda: %f\n', lambda_oracle);
fprintf('SDR for oracle lambda: %f dB\n',sdr_oracle);


fprintf('Estimated lambda: %f \n', lambda_est);
fprintf('SDR for estimated lambda: %f dB\n', sdr_est);


fprintf('True-energy lambda: %f \n', lambda_true_energy);
fprintf('SDR for true-energy lambda: %f dB\n', sdr_true_energy);

fprintf('Zero filling SDR: %f dB\n', sdr_zero);
fprintf('Mix SDR: %f dB \n',sdr_mix);
fprintf('Interp + random phases filling SDR: %e dB\n',sdr_interp);

%%

figure;
plot_spectrogram(x_mix, dgt_params, signal_params, dgt);
title(['Mix SDR=' , num2str(sdr_mix,4),'dB  ','IS= ',num2str(is_mix)]);
set(gca, 'FontSize', 20, 'fontName','Times');
axis tight;
saveas(gcf,fullfile(fig_dir, 'mix.pdf'));

figure;
plot_spectrogram(signals.wideband, dgt_params, signal_params, dgt);
title(['True source -', wideband_src])
set(gca, 'FontSize', 20, 'fontName','Times');
saveas(gcf,fullfile(fig_dir,  'spectrogram_true_wb_source.pdf'));


figure;
plot_spectrogram(x_zero, dgt_params, signal_params, dgt)
title(['Zero fill SDR= ', num2str(sdr_zero,4),'dB  ', 'IS=', num2str(is_zero)])
set(gca, 'FontSize', 20, 'fontName','Times');
saveas(gcf,fullfile(fig_dir, 'spectrogram_zero_fill.pdf'));

figure;
plot_spectrogram(x_oracle, dgt_params, signal_params, dgt)
title(['TFF-O SDR= ', num2str(sdr_oracle,4), 'dB  ','IS=', num2str(is_oracle)])
set(gca, 'FontSize', 20, 'fontName','Times');
axis tight;
saveas(gcf,fullfile(fig_dir,'spectrogram_TFF-O.pdf'));

figure;
plot_spectrogram(x_est, dgt_params, signal_params, dgt)
title(['TFF-P - SDR= ',num2str(sdr_est,4),'dB  ','IS=',num2str(is_est)])
set(gca, 'FontSize', 20, 'fontName','Times');
axis tight;
saveas(gcf,fullfile(fig_dir, 'spectrogram_TFF-P.pdf'));

figure;
plot_spectrogram(x_interp, dgt_params, signal_params,dgt)
title(['Interp  SDR= ', num2str(sdr_interp,4),'dB  ','IS=',num2str(is_interp)])
set(gca, 'FontSize', 20, 'fontName','Times');
saveas(gcf,fullfile(fig_dir,'spectrogram_interp.pdf'));
%%
save('exp_tffP_car_bird.mat');
