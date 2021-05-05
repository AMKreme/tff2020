function  x=compute_estimate(lambda_coef, x_mix, s_vec_list, u_mat_list, ut_x_list)

%% x=compute_estimate(lambda_coef, x_mix, s_vec_list, u_mat_list, ut_x_list)
% This function computes the signal estimated by the algorithms proposed in [1]
%
% Inputs:
%     - lambda_coef: hyperparameters
%     - x_mix: mixtures of signals with wideband and localized spectrograms
%     - s_vec_list:list of nonnegative and diagonal matrix
%     - u_mat_list: list of orthononmal matrix
%     - ut_x_list: list of u_mat^{T}*x_mix
%
% Output:
%     x : estimated signal
%
% Reference:
%
% [1]Time-frequency fading algorithms based on Gabor multipliers,2020.
%
%
% Author: Marina KREME


%%


n_areas = length(s_vec_list);

n = length(lambda_coef);
if n>1
    assert(n==n_areas);
else
    lambda_coef = lambda_coef*ones(n_areas,1);
end

x = x_mix;
for  k= 1:n_areas
    gamma_vec = lambda_coef(k)*s_vec_list{k}./(1-(1-lambda_coef(k)).*s_vec_list{k});
    x =x-u_mat_list{k}*(gamma_vec.*ut_x_list{k});
end


end


