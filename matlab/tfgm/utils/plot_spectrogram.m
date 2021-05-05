function plot_spectrogram(x, dgt_params, signal_params, dgt, dynrange, clim)
%% plot_spectrogram(x, dgt_params, signal_params, dgt, dynrange, clim)
% Plot spectrogram of a signal
%  Inputs:
%     - x (nd array): signal
%     - dgt_params (struct): dgt parameters (see tf_tools/generate_dgt_parameters.m)
%     - signal_params: signal parameters
%     - dgt (handle) :  DGT operator (see utils/get_stft_operators.m)
%     - dynrange (float) : Dynamic range to be displayed.
%     - clim (sequence): Min and max values for the colorbar. 
%                    If both 'clim' and 'dynrange' are specified, 
%                    then clim takes precedence.
%
%
% Author : A. Marina KREME
%%

if size(x,2)==1
    x = compute_dgt(x,dgt);
end


 if nargin==4
    dynrange=100;
    c_max = max(db(x(:)));
    clim = [c_max - dynrange, c_max];
end

plotdgtreal(x, dgt_params.hop, dgt_params.nbins, signal_params.fs,...,
    'dynrange', dynrange,'clim',clim)
end
