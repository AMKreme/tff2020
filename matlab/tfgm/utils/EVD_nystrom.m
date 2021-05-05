function svd_res = EVD_nystrom(mul, Q)
%% SVD_RES = EVD_HALKO(MUL, Q)
% this function is used to perform the spectral value decomposition 
% by pre-estimating the rank of the matrix to be diagonalized. 
% It uses the function "eigenvalue decomposition via nystrom[1]" for diagonalization.
% 
% 
% Inputs:
%     - mul : operator to be diagonalized (Gabor multiplier )
%     - Q : orthonormal matrix
%     
%  Outputs:
%  
%     - U :orthononmal matrix
%     - D : nonnegative and diagonal matrix
% 
% 
% REFERENCES:
% 
%  Nathan Halko, Per-Gunnar Martinsson, Joel A. Tropp, "Finding structure
%  with randomness: Probabilistic algorithms for constructing approximate
%  matrix decompositions", 2011.    
%     
%     
% Created: 2020-04-01
%% 

[U,D] = eigvalue_decomposition_via_nystrom(mul, Q);
svd_res.U = U;
svd_res.D =D;

 
end
