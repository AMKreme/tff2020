function SNR = snr(x_signal, x_noise)

%% SNR = snr(x_signal, x_noise)
% Compute SIgnal to Noise Ratio. It's used to compare the level
% of a desired signal to the level of background noise.
% 
% Inputs:
%     -x_signal(nd array): target signal
%     - x_noise (nd array): noise signal
%     
% Output:
%     - SNR (float): SNR
% Author: Marina KREME
%%

SNR = db(norm(x_signal)/norm(x_noise));
end

