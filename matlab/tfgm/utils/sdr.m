function SDR = sdr(x_ref, x_est)

%% SDR = sdr(x_ref, x_est)
% Compute Signal to Distorsion Ratio (SDR) between target signal
% and estimated signal
%
% Inputs:
%    - x_ref (nd array): Reference  signal
%    - x_est (nd array): Estimation of the reference signal
% Output:
%    -SDR: Signal to Distorsion Ratio in dB
%
% Author: Marina KREME
%%
SDR= 20*log10(norm(x_ref,2)/norm(x_ref-x_est,2));

end