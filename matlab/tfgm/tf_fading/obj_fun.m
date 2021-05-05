function f_lambda = obj_fun(lambda_coef, x_mix, s_vec_list, ...,
    u_mat_list, ut_x_list, mask, gab_mul, dgt, e_target)

%%  f_lambda = obj_fun(lambda_coef, x_mix, s_vec_list, ...,
%    u_mat_list, ut_x_list, mask, gab_mul, dgt, e_target)
%
% Objecitve function for finding optimal lambda value in algorithms
% proppsed in [1]
%
% Inputs:
%     -lambda_coef: hyperparameters
%     - x_mix: mixtures of signals with wideband and localized spectrograms
%     - s_vec_list:list of nonnegative and diagonal matrix obtained after diagonalization
%     - u_mat_list: list of orthononmal matrix obtained after diagonalization
%     - ut_x_list: list of each u_mat'*x_mix
%     - mask: mask
%     - gab_mul:Gabor multiplier
%     - dgt: Gabor transform operator
%     - e_target: estimated energy in Omega region
%
% Output:
%     - f_lambda: objective function
%
%
%
% Reference:
% [1]Time-frequency fading algorithms based on Gabor multipliers,2020.
%
%
% Author: Marina KREME
%%
x =compute_estimate(lambda_coef, x_mix, s_vec_list, u_mat_list, ut_x_list);

x_tf_masked = mask.*dgt(gab_mul(x));
e_mask = norm(x_tf_masked, 'fro').^2;
f_lambda = abs(e_target - e_mask);

end
