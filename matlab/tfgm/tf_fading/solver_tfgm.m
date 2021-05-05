function x_est= solver_tfgm(x_mix, u_mat, s_vec, ut_x)
%% x_est= solver_tfgm(x_mix, u_mat, s_vec, ut_x)
% function that returns the solution of the problem below
%
% $x = \argmin ||Vx-Vx0||^{2}_{\bar{\Omega}}$ + \lambda*||V_g x||^{2}_{\Omega}$
%     with M_{Omega} = V_g^{*}1_{Omega}V_g : Gabor multiplier
%
% where \Omega is the hole area,V_g is discrete Gabor transform  and x0
% observations
%
% Inputs :
%   - x_mix :  mixtures of signals with wideband and localized  spectrograms.
%   - u_mat : matrix of eigenvectors
%   - s_vec : eigenvalues vec
%   - ut_x : matrix obtained by performing u_mat'*x_mix
% 
% Output:
%   - x_est: estimated signal
%
% Author : A. Marina KREME
% e-mail : ama-marina.kreme@lis-lab.fr/ama-marina.kreme@univ-amu.fr
%
%%

gamma_vec = compute_gamma(s_vec);
x_est = @(x) x_mix - u_mat* (gamma_vec(x).*ut_x) ;

end

