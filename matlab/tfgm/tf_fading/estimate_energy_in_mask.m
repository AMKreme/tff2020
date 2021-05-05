function estimated_energy = estimate_energy_in_mask(x_mix, mask, dgt_params, signal_params, dgt,fig_dir)

%%estimated_energy = estimate_energy_in_mask(x_mix, mask, dgt_params, signal_params, dgt,fig_dir)
% Functions that estimates energy in time-frequency mask
%
% Inputs:
%     - x_mix:mixtures of signals with wideband and localized spectrograms
%     - mask:labeled mask
%     - dgt_params : Discrete Gabor Transform parameters(hop, nbins,win, ect..)
%     - signal_params:Signals parameters(sig_len, fs)
%     - dgt: Gabor transform operator
%     - fig_dir: firgures directory
% Outputs:
%     -estimated_energy: Estimated energy in each sub-region.
%
%
% Author: Marina KREME
%%
x_tf_mat = dgt(x_mix);
x_tf_mat(mask>0)= nan;
e_f_mean = nanmean(abs(x_tf_mat).^2, 2);
%%
n_areas = length(unique(mask))-1;
estimated_energy = zeros(n_areas,1);
e_mat = e_f_mean*ones(1, size(x_tf_mat,2));
e_mat(mask==0) = 0;

for k_area = 1:n_areas
    mask_k = (mask==k_area);
    estimated_energy(k_area) = sum(e_mat(:).*mask_k(:));
    
end

%%


dynrange = 100;
c_max = nanmax(db(x_tf_mat(:)));
clim = [c_max - dynrange, c_max];


fs = signal_params.fs;
figure;
plot_spectrogram(x_mix, dgt_params, signal_params, dgt, dynrange, clim)
%plotdgtreal(S_mix, dgt_params.hop, dgt_params.nbins, fs);
title('Mix');
set(gca, 'FontSize', 20, 'fontName','Times');
saveas(gcf,fullfile(fig_dir, 'mix.pdf'));



%
figure;
plotdgtreal(sqrt(e_mat), dgt_params.hop, dgt_params.nbins, fs, 'clim', clim);
title(['Mask filled with average energy (total: ', num2str(estimated_energy,8),')']);
set(gca, 'FontSize', 20, 'fontName','Times');
saveas(gcf,fullfile(fig_dir, 'mask_filled__with_energy.pdf'));


%

x_tf_mat(mask>0) = sqrt(e_mat(mask>0));
figure;
plotdgtreal(x_tf_mat, dgt_params.hop, dgt_params.nbins, fs, 'clim', clim);
title(['Mix filled with average energy (total: ', num2str(estimated_energy,8),')']);
set(gca, 'FontSize', 20, 'fontName','Times');
saveas(gcf,fullfile(fig_dir, 'filled_mix_with_average_energy.pdf'));


%
figure;
plot(db(e_f_mean) / 2,'LineWidth',2);
xlabel('Frequency index')
ylabel('Average energy')
grid on;
title('Average energy per frequency bin in mix');
set(gca, 'FontSize', 20, 'fontName','Times');
saveas(gcf,fullfile(fig_dir, 'average_energy_per_freq_bin.pdf'));


%%
e_f_mean_check = mean(abs(x_tf_mat).^2, 2);
figure;
plot(db(e_f_mean) / 2, 'LineWidth',2); hold on;
plot(db(e_f_mean_check) / 2, '--','LineWidth',2)
xlabel('Frequency index')
ylabel('Average energy')
title('Average energy per frequency bin in mix')
legend('Before filling', 'After filling')
grid on;
set(gca, 'FontSize', 20, 'fontName','Times');
saveas(gcf,fullfile(fig_dir, 'average_energy_per_freq_bin_mix.pdf'));


end
