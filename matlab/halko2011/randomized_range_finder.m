function  Q = randomized_range_finder(A, N, l)
% Q = RANDOMIZED_RANGE_FINDER(A, N, L) is algo 4.1 of the reference below. 
% This algorithm compute an orthonormal matrix Q such that |(I-QQ')A| < tol. 
%
%
% Inputs :
%   - A : Either matrix or matrix operator.
%   - N : the length of the signal 
%   - l :  integer
% Output:   
%    - Q : an Orthonormal matrix. The columns of Q are orthonormal
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
%

Omega = randn(N, l);
Y = A(Omega);
% Y = zeros(N,l);
% for i =1:l
%     Y(:,i) = A(Omega(:,i));
% end

[Q,~] =qr(Y,0); 


end