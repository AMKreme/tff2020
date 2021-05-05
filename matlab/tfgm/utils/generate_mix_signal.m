function signals = generate_mix_signal(x_wb, x_loc, gamma)
%% signals = generate_mix_signal(x_wb, x_loc, gamma)
% function that generates mixtures of two signals 
% Inputs:
%     - x_wb:  signal with wideband spectrogram
%     - x_loc: signal with localized spectrogram
%     - gamma: constant belonging to interval ]0,1[.
%                 allows you to control the percentages of each signal.
% Outputs:
%     - signals: struct containing wideband, localized and mixtures of  two signals.
%
%
% Author : A. Marina KREME
% e-mail : ama-marina.kreme@lis-lab.fr/ama-marina.kreme@univ-amu.fr
% Created: 2020-28-01
%
%%



if length(x_wb)~= length(x_loc)
    error('%s:Arrays are not equal',upper(mfilename));
end

x_wb=  x_wb./norm(x_wb);
x_loc  = x_loc./norm(x_loc);


if  (gamma==0 || gamma==1)
    error('%s: Incorrect gamma value. It must be in ]0,1[. Please check it',upper(mfilename));
else
    x_wb = gamma*x_wb;
    x_loc  = (1-gamma)*x_loc;
    x_mix =  x_wb + x_loc;
end

signals.wideband = x_wb;
signals.localized = x_loc;
signals.mix = x_mix;

end