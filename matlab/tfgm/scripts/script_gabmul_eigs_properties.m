clc; clear; close all; 
%% 

load('evdn_gauss_hann.mat');


pwd;
fig_dir ='fig_localisation_properties_of_gabmul_eigs';
if ~exist(fig_dir,'dir')
    mkdir(fig_dir);
end
addpath(fig_dir)

%%



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


xlabel({'index = $k$'},'Interpreter','latex');
ylabel({' Eigenvalues $\sigma[k]$'},'Interpreter','latex');

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
ylabel('Frequency (kHz)')
set(gca, 'FontSize', 20, 'fontName','Times');
subplot(222);
plot_spectrogram(eigs_gauss(:,100), param_dict.('Gauss256').dgt_params,...,
    param_dict.('Gauss256').signal_params, param_dict.('Gauss256').dgt);
yticks([0,1000,2000,3000,4000]);
yticklabels([0,1,2,3,4]);
ylabel('Frequency (kHz)')
set(gca, 'FontSize', 20, 'fontName','Times');
subplot(223);
plot_spectrogram(eigs_gauss(:,3199), param_dict.('Gauss256').dgt_params,...,
    param_dict.('Gauss256').signal_params, param_dict.('Gauss256').dgt);
yticks([0,1000,2000,3000,4000]);
yticklabels([0,1,2,3,4]);
ylabel('Frequency (kHz)')
set(gca, 'FontSize', 20, 'fontName','Times');
subplot(224);
plot_spectrogram(eigs_gauss(:,3072), param_dict.('Gauss256').dgt_params,...,
    param_dict.('Gauss256').signal_params, param_dict.('Gauss256').dgt);
ylabel('Frequency (kHz)')
yticks([0,1000,2000,3000,4000]);
yticklabels([0,1,2,3,4]);
set(gca, 'FontSize', 20, 'fontName','Times');
saveas(gcf,fullfile(fig_dir, 'eigvectors_prop_illustration.png'));
saveas(gcf,fullfile(fig_dir, 'eigvectors_prop_illustration.fig'));

%% mask
figure;
plot_spectrogram(mask_gauss.mask, param_dict.('Gauss256').dgt_params,...,
    param_dict.('Gauss256').signal_params, param_dict.('Gauss256').dgt);
ylabel('Frequency (kHz)')
yticks([0,1000,2000,3000,4000]);
yticklabels([0,1,2,3,4]);
set(gca, 'FontSize', 20, 'fontName','Times');
saveas(gcf,fullfile(fig_dir, 'mask_gauss.png'));


%%