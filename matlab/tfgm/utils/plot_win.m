function plot_win(win, fs, sig_len, win_type)
%% plot_win(win, fs, sig_len, win_type)
% Plot window
%
% Inputs:
%      - win (nd array): analysis window
%      - fs (int): sampling frequency
%      - sig_len (int):  signal length
%      - win_type (str): window type
%
% Author: Marina KREME
%%

x_range = fftshift((1:length(win))./fs);
x_range(x_range > x_range(end)) = x_range(x_range > x_range(end)) - length(x_range)/fs;

if nargin==3
    plot(x_range, fftshift(win),'LineWidth',2.5);
elseif ~ischar(win_type)
    error('%s: The window type must be a string',upper(mfilename));
else
    plot(x_range, fftshift(win), 'LineWidth',2.5)
    legend(win_type)
    
end
xlabel('Time (s)')
grid('on')
title(['Signal length = ' num2str(sig_len)]);





