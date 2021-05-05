function x_est= interpolation_solver(x, mask, dgt, idgt, dgt_params,...,
    signal_params, fig_dir)
%% x_est= interpolation_solver(x, mask, dgt, idgt, dgt_params,...,
%    signal_params, fig_dir)
% Time-frequency fading solver using linear interpolation and random phases
% This function apply a linear interpolation along
% the frequency axis of the magnitude of observation time-frequency matrix
% and  draws the related phase uniformly at random.
%
% Inputs:
%     - x (nd array):  mix signal
%     - mask (nd- array): time-frequency mask
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
x_abs = abs(x_tf);
x_ang = angle(x_tf);

mask_copy = mask;

%%
y_tf = x_abs.*(1-mask_copy);

figure;
plotdgtreal(y_tf,dgt_params.('hop'), dgt_params.('nbins'), signal_params.('fs'));
title('Mask Before Interpolated TF matrix')
saveas(gcf,fullfile(fig_dir,'interp_mask.pdf'));


%%
z_tf = (y_tf==0);
y_tf(z_tf) = interp1(find(~z_tf),y_tf(~z_tf), find(z_tf),'linear');


figure
plotdgtreal(y_tf,dgt_params.('hop'), dgt_params.('nbins'), signal_params.('fs'));
title('Interpolated TF matrix')
saveas(gcf,fullfile(fig_dir,'interp_tf_est.pdf'));

%%

x_ang(mask==1) = 2*pi*rand(sum(mask(:)),1);
x_est = abs(y_tf).*exp(1i.*x_ang);
x_est = idgt(x_est);

figure;
plot_spectrogram(x_est, dgt_params,signal_params, dgt);
title('Reconstructed signal by interp')
saveas(gcf,fullfile(fig_dir,'interp_sig_est.pdf'));

end