function plot_mask(mask, hop, nbins, fs)

%% plot_mask(mask, hop, nbins, fs)
% Plot time-frequency mask
%
% Inputs:
%    - mask: Time-frequency mask
%    - hop (int): Hop size
%    - nbins (int):  Number of frequency bins
%    - fs (int): Sampling frequency

% Author : A. Marina KREME
%%

%L = hop*size(mask,2);

plotdgtreal(mask, hop, nbins, fs,'lin');
%title(['Signal length = ' num2str(L)]);
