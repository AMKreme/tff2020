function svd_res = EVD_eigs(mul, sig_len, r)
%% SVD_RES = EVD_eigs(MUL, SIG_LEN, R)
% this function is used to perform the spectral value decomposition 
% by pre-estimating the rank of the matrix to be diagonalized. 
% It uses the  MATLAB's "eigs" function for diagonalization. 
% 
% Inputs:
%     - mul : operator to be diagonalized (Gabor multiplier )
%     - sig_len : signal length
%     - r :  integer - number of eigenvalues to keep 
%     
%  Outputs:
%  
%     - U :orthonormal matrix
%     - D : nonnegative and diagonal matrix
%  
% Created: 2020-04-01
%% 

[U,D] = eigs(mul, sig_len, r);
svd_res.U = U;
svd_res.D =D;
end