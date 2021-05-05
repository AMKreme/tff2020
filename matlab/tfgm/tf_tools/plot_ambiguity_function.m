function plot_ambiguity_function(x, dgt , dgt_params, signal_params,...,
    dynrange, apply_fftshift)

%% plot_ambiguity_function(x, dgt , dgt_params, signal_params, dynrange)
%
% This function compute and plot ambiguity function for a given vector
%
% Inputs:
%     - x: signal
%     -dgt: Gabor transform operator
%     - dgt_params: Signals parameters(sig_len, fs)
%     - signal_params: Discrete Gabor Transform parameters(hop, nbins,win, ect..)
%     - dynrange : dynamic range (optional)
%
% Author: Marina KREME
%%s

apply_fftshift = [upper(apply_fftshift(1)),apply_fftshift(2:end)];
if nargin==4
    dynrange = 100;
    apply_fftshift='True';
end
if nargin==5
    apply_fftshift='True';
end

x = compute_ambiguity_function(x, dgt ,apply_fftshift);
plotdgtreal(x, dgt_params.hop, dgt_params.nbins, signal_params.fs,'dynrange', dynrange)


end
