function [dgt, idgt, varargout] = get_stft_operators(dgt_params, signal_params, phase_conv)
%% GET_STFT_OPERATORS
% [dgt, idgt, pseudoinverse_dgt] = get_stft_operators(dgt_params, signal_params, phase_conv)

% functions that generate the DGT operators.
%
% Inputs:
%     - dgt_params: struct that contains the DGT parameters.
%               see tf_tools/generate_dgt_parameters.m
%     - signal_params: structure which contains the sampling frequency
%                      as well as the signal length
%                      see tf_tools/generate_signal_parameters.m
%     - phase_conv :  the phase convention 'freqinv' or 'timeinv'
%                   Compute a DGT using a frequency-invariant phase.
%       see 'pt' argument in http://ltfat.github.io/doc/gabor/dgtreal.html
%                           
%
% Outputs:
%     - dgt (handle fucntion) : DGT operator
%     - idgt (handle fucntion) : IDGT operator
%     - pseudoinverse_dgt (handle fucntion) : Pseudo-inverse of DGT
%
%
% Author : A. Marina KREME
% e-mail : ama-marina.kreme@lis-lab.fr/ama-marina.kreme@univ-amu.fr
% Created: 2020-28-01
%%


if nargin==2
    phase_conv= 'freqinv';
end


L = signal_params.sig_len;


%%
win = dgt_params.win;
wd = gabdual(win, dgt_params.hop, dgt_params.nbins, L);


dgt =  @(x)dgtreal(x, win, dgt_params.hop, dgt_params.nbins, L, phase_conv);
idgt =  @(x)idgtreal(x, win, dgt_params.hop, dgt_params.nbins, L, phase_conv);

pseudoinverse_dgt = @(x)idgtreal(x, wd, dgt_params.hop, dgt_params.nbins, L, phase_conv);


varargout{1} = pseudoinverse_dgt;


end



