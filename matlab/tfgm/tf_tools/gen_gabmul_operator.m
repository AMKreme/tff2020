function [gabmul_op, varargout] = gen_gabmul_operator(dgt, idgt, mask)
%% GEN_GABMUL_OPERATOR computes a Gabor multiplier
% [gabmul_op, varargout] = gen_gabmul_operator(dgt, idgt, mask)
%
% Inputs:
%     - dgt: Gabor transform operator - handle
%     - idgt: inverse Gabor  transform operator -handle
%     - mask: Time-frequency mask
%   see utils/generate_stft_operators.m for 'dgt' and 'idgt' operators
% Outputs:
%     - gabmul_op: gabor multiplier- handle function
%
% Author : A. Marina KREME
% e-mail : ama-marina.kreme@lis-lab.fr/ama-marina.kreme@univ-amu.fr
% Created: 2020-28-01
%%

 

gabmul_op = @(x)idgt(mask.*dgt(x));
varargout{1} = mask;


end