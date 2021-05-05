function x_est= zero_fill_solver(x, mask, dgt, idgt,  dgt_params,...,
    signal_params, fig_dir)

%% x_est= zero_fill_solver(x, mask, dgt, idgt,  dgt_params,...,
%    signal_params, fig_dir)
% Thid function reconstruct the signal after filling the masked regions by zeros.
% Inputs:
%     - x (nd array): mix signals
%     - mask: time-frequency mask
%     - idgt,dgt (handle): DGT and IDGT . see utils/get_stft_operators.m
%     - dgt_params (struct)  : DGT parameters
%     - signal_params (struct) . :signals parameters
%     - fig_dir : folder where figures are stored
% Outputs:
%     -x_est (nd array): estimated signal
%
%
% Author: Marina KREME

%%
x_tf = dgt(x);
x_tf(mask==1)=0;
x_est = idgt(x_tf);

%%

figure
plot_spectrogram(x_tf, dgt_params,signal_params, dgt);
title('TF matrix filled by zeros in mask')
saveas(gcf,fullfile(fig_dir,'tf_filled_zeros.pdf'));

figure
plot_spectrogram(x_est, dgt_params,signal_params, dgt);
title('Reconstructed signal by zero fill')
saveas(gcf,fullfile(fig_dir,'zero_fill_est.pdf'));

end