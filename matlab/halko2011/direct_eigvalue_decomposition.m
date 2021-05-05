function [U, D] = direct_eigvalue_decomposition(A, Q)
%% DIRECT_EIGVALUE_DECOMPOSITION is algo 5.3 of reference below
% svd_result = direct_eigvalue_decomposition(A, Q), computes an approximate
% factorization A=UDU', where D is a nonnegative diagonal matrix,
% and U is an orthonormal.
%
% Inputs:
%    - A: hermitian matrix. Here A is a gabor multiplier operator for which the mask must be
%           a real. So it Hermtian
%    - Q: an orthonormal matrix.
%    
%
% Outputs:
%     - U: n x k matrix in the approximation; the columns of U are orthonormal
%     - D: k x k matrix in the rank-k approximation; the entries of S are
%          all nonnegative.

% References:
%  Nathan Halko, Per-Gunnar Martinsson, Joel A. Tropp, "Finding structure
%  with randomness: Probabilistic algorithms for constructing approximate
%  matrix decompositions", 2011.
%
% Author : A. Marina KREME
% e-mail : ama-marina.kreme@lis-lab.fr/ama-marina.kreme@univ-amu.fr
% Created: 2020-28-01
%%

       
B1 = zeros(size(Q));
for l = 1 : size(Q,2)
    B1(:,l)=A(Q(:,l));
end

%B1 = A(Q);
B = Q'*B1;


B = (B+B')/2;
[V,D] = eigs(B, size(Q,2));
U=Q*V;


end