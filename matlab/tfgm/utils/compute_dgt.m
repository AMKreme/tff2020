function  tf_mat = compute_dgt(x, dgt)
%%  tf_mat = compute_dgt(x, dgt)
% This function computes the time-frequency (TF) Discrete Gabor transform
%  (DGT) of a signal
%
% Input:
%     - x (nd array): Input signal. must be a vector
%     - dgt(handle function) :gabor transform operator
%                            (see utils/get_stft_operators.m)
% Output:
%   -tf_mat: TF matrix - DGT coefficients
%
% Author : A. Marina KREME
% e-mail : ama-marina.kreme@lis-lab.fr/ama-marina.kreme@univ-amu.fr
% Created: 2020-28-01
%%
if size(x,2)~=1
    error('Input signal must be a vector of a column:%s',upper(mfilename))
end
tf_mat = dgt(x);
end