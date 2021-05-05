function [U,S] = eigvalue_decomposition_via_nystrom(A,Q)
%% EIGENVALUE_DECOMPOSITION_VIA_NYSTROM 
% [U,S] = eigvalue_decomposition_via_nystrom(A,Q)
% computes an approximate eigenvalue decomposition A \approx USU'.
%
% Inputs:
%     - A: handle-function - Gabor multiplier
%     - Q: basis of range of A
% Outputs:
%     - U: otrthononmal matrix
%     - S: nonnegative and diagonal matrix
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


B1 = zeros(size(Q));
for k=1:size(Q,2)
    B1(:,k) = A(Q(:,k));
end
%B1 = A(Q);


B2 = Q'*B1;
B2 = (B2+B2')/2;
C = chol(B2);
F = B1/C;
[U,D,~] = svd(F,'econ');
S = D.^2;
end