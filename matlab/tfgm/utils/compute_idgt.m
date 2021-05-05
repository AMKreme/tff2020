function x = compute_idgt(tf_mat, idgt)
%%  x = compute_idgt(tf_mat, idgt)
% Inverse discrete Gabor transform
% This function reconstruct a signal form its  the time-frequency (TF) matrix
%
% Input:
%     - tf_mat (nd array): TF matrix - DGT coefficients
%     - idgt (handle function): inverse of gabor transform operator
%                             (see utils/get_stft_operators.m)
% Output:
%     -x (ndarray): reconstructed signal
%
% Author : A. Marina KREME
% e-mail : ama-marina.kreme@lis-lab.fr/ama-marina.kreme@univ-amu.fr
% Created: 2020-28-01
%%

x = idgt(tf_mat);

end