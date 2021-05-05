function r = compute_r(m, n, prob)
%% COMPUTE_R: this function calculates a small integer r which is used to equilibrate the
% calculation cost and the reliability of the approximation error of
% |(I-QQ')A| < tol in Halko, 2011.
%
% Input:
%  - m: number of lines in the input matrix
%  - n: number of columns in the input matrix
%  - prob: the probability with which one would like to achieve approximation Q of A.
%
% Output:
%     - r: integer
%
% REFERENCES:
%
%  Nathan Halko, Per-Gunnar Martinsson, Joel A. Tropp, "Finding structure
%  with randomness: Probabilistic algorithms for constructing approximate
%  matrix decompositions", 2011.
%
% Author : A. Marina KREME
% e-mail : ama-marina.kreme@lis-lab.fr/ama-marina.kreme@univ-amu.fr
% Created: 2020-28-01
%%


r = ceil(-(log((1-prob)/min(m,n)))/log(10));

end