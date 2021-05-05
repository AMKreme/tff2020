function [lambda_est, t_est] = compute_lambda(x_mix, mask, dgt_params,...,
    signal_params,  dgt, s_vec_list, u_mat_list, ut_x_list,...,
    gabmul_list, fig_dir, e_target)

%% [lambda_est, t_est] = compute_lambda(x_mix, mask, dgt_params,...,
%    signal_params,  dgt, s_vec_list, u_mat_list, ut_x_list,...,
%    gabmul_list, fig_dir, e_target)
% This function  estimates the hyperparameters $\lambda$ from target energy
% in each sub-region as we proposed in [1].
%
% Inputs:
%     -x_mix:mixtures of signals with wideband and localized spectrograms
%     -mask: labeled mask
%     -dgt_params : Discrete Gabor Transform parameters(hop, nbins,win, ect..)
%     -signal_params:Signals parameters(sig_len, fs)
%     -dgt: Gabor transform operator
%     -s_vec_list:list of nonnegative and diagonal matrix
%     - u_mat_list: list of orthononmal matrix
%     - ut_x_list: list of u_mat^{T}*x_mix
%     -gabmul_list: list of Gabor multiplier associated to each mask
%     -fig_dir: figures directory
%     -e_target: estimated energy  in another region. see [1]
% Outputs:
%     - lambda_est: lambda estimated
%     - t_est: time to estimate lambda
%
%  Reference:
%
% [1]Time-frequency fading algorithms based on Gabor multipliers,2020.
%
% Author: Marina KREME
%%

%%
if nargin<=10
    e_target = estimate_energy_in_mask(x_mix, mask, dgt_params, ...,
        signal_params, dgt,fig_dir);
    
end
%%
n_areas = length(u_mat_list);
t_est = zeros(n_areas,1);
lambda_est = zeros(n_areas,1);

for k_area = 1:n_areas
   
    mask_k = (mask==k_area);
    
    gab_mul = gabmul_list{k_area};
    e_target_k = e_target(k_area);
    
    
    obj_fun_est = @(lambda_coef)obj_fun(lambda_coef, x_mix, s_vec_list, ...,
        u_mat_list, ut_x_list, mask_k, gab_mul, dgt, e_target_k);
    
    tic;
    sol_est = fminbnd(obj_fun_est, 0,1);
    t_est(k_area) = toc;
    lambda_est(k_area) = sol_est;
end
end



