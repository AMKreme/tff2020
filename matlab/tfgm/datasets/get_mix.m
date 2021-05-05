function [signals, dgt_params, signal_params, mask, mask_area, dgt,...,
    idgt] = get_mix(loc_source, wideband_src, gamma, win_dur, hop_ratio,...,
    nbins_ratio, win_type, alpha, thres, radius, fig_dir)

%%
%  Build the mix two sounds and the related time-frequency boolean mask.
%
%
% Inputs:
%   - loc_source(str): signal with localized spectrogram
%   - wideband_src(str):  signal with wideband spectrogram
%     - gamma:  integer (belong to ]0,1[)
%     - win_dur: window duration (must be between 12 and 20 ms)
%     - hop_ratio (float): Ratio of the window length that will be set as hop size for the DGT.
%     - nbins_ratio: Factor that will be applied to the window length to compute the
%                        number of bins in the DGT.
%
%     - win_type (str): analysis window (hann or gauss)
%     - alpha, thres, radius(real): smoothing parameter for the mask
%     -fig_dir: directory - folder where figures are stored
%
% Outputs:
%     -signals(struct): contains wideband, localized and mixtures signals
%     - dgt_params (struct): contains dgt parameters (hop, n_bins, win_type, win_len, win)
%     - signal_params (struct): contains the length of signal and sampling frequency
%     - mask : Time-frequency binary mask
%     - mask_area: binary  mask area
%     - dgt, idgt (handle): Operator of DGT transform and its inverse
%
%  Author : Marina KREME

%%
dataset = get_dataset();

[x_loc, fs_loc]= audioread(dataset.localized.(loc_source));
[x_wb, fs_wb]= audioread(dataset.wideband.(wideband_src));

if  length(x_loc)~=length(x_wb)
    warning('Arrays are not equal');
    
end

if fs_loc~=fs_wb
    error('The sampling frequencies must be the same.')
end

fs= fs_loc;
sig_len = length(x_loc);
signal_params = generate_signal_parameters(fs, sig_len);

%%  build mix signals
signals = generate_mix_signal(x_wb, x_loc, gamma);

%% Build dgt

approx_win_len = 2.^round(log2(win_dur*fs));
hop =  approx_win_len* hop_ratio;
nbins = approx_win_len * nbins_ratio;

dgt_params = generate_dgt_parameters(win_type, approx_win_len, hop,...,
                nbins, sig_len);


%%  generate binary mask
[dgt, idgt] = get_stft_operators(dgt_params, signal_params);

tf_mat_wb = dgt(signals.wideband);
tf_mat_loc = dgt(signals.localized);

[mask, original_mask, mask_after_imclose, mask_after_imopen,...,
    ] = generate_mask(tf_mat_wb, tf_mat_loc, alpha, thres, radius);
mask_area = get_mask_area(mask);
%%

figure;
plot_mask(mask, hop, nbins, fs);
title(['Mask Mix :  mask-area = ',num2str(mask_area)]);
set(gca, 'FontSize', 20, 'fontName','Times');
saveas(gcf,fullfile(fig_dir, 'mask_mix.pdf'));

%%

figure;
plot_spectrogram(signals.wideband, dgt_params, signal_params, dgt)
title(['Wideband source - ', wideband_src]);
set(gca, 'FontSize', 20, 'fontName','Times');
saveas(gcf,fullfile(fig_dir, 'mix_spectro_mask.pdf'));

figure;
plot_spectrogram(signals.localized, dgt_params, signal_params, dgt)
title(['Localized source - ',loc_source]);
set(gca, 'FontSize', 20, 'fontName','Times');
saveas(gcf,fullfile(fig_dir, 'loc_source.pdf'));

figure;
plot_spectrogram(signals.mix, dgt_params, signal_params, dgt)
title('Mix');
set(gca, 'FontSize', 20, 'fontName','Times');
saveas(gcf,fullfile(fig_dir, 'mix_spectrogram.pdf'));


figure; 
plot_mask(original_mask, hop, nbins, fs);
title('Original mask');
set(gca, 'FontSize', 20, 'fontName','Times');
saveas(gcf,fullfile(fig_dir, 'raw_mask.pdf'));

figure;
plot_mask(mask_after_imclose, hop, nbins, fs);
title('Smooth mask- after imclose');
set(gca, 'FontSize', 20, 'fontName','Times');
saveas(gcf,fullfile(fig_dir, 'mask_after_imclose.pdf'));

figure;
plot_mask(mask_after_imopen, hop, nbins, fs);
title('Smooth and final mask - after impoen');
set(gca, 'FontSize', 20, 'fontName','Times');
saveas(gcf,fullfile(fig_dir, 'mask_after_imopen.pdf'));


figure;
m = ~mask;
gabmul = gen_gabmul_operator(dgt, idgt,m);
x_est = gabmul(signals.wideband);

plot_spectrogram(x_est, dgt_params, signal_params, dgt)
title('Filtered wb')
set(gca, 'FontSize', 20, 'fontName','Times');
saveas(gcf,fullfile(fig_dir, 'zerofill_spectrogram.pdf'));


end