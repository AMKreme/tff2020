function signal_params = generate_signal_parameters(fs, sig_len)
%% GENERATE_SIGNAL_PARAMETERS
% signal_params = generate_signal_parameters(fs, sig_len)
% Build structure of signals parameter
%
% Inputs:
%       - fs (int): sampling frequency
%       - sig_len(int) :   signal length
% Outputs:
%    - signal_params: structure that contains the signal parameters,
%           - signal_params.('sig_len') : the signal length
%            - signal_params.('fs') : the sampling frequency
%
% Author : A. Marina KREME
% e-mail : ama-marina.kreme@lis-lab.fr/ama-marina.kreme@univ-amu.fr
% Created: 2020-28-01
%%


if mod(sig_len,2)~=0
    sig_len = 2^(round(log2(sig_len)));
end


signal_params.fs=fs;
signal_params.sig_len = sig_len ;


end