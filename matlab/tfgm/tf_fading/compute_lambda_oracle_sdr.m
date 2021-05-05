function [lambda_oracle, t_oracle] = compute_lambda_oracle_sdr(n_areas, x_wb, x_rec)

%% [lambda_oracle, t_oracle] = compute_lambda_oracle_sdr(n_areas,x_wb, x_rec)
% Function that calculates the estimated lambda using the true energy. see[1]
% Compute oracle value for hyperparameter $\lambda_k$ from true solution.
%
% If only one region is considered, *fmincon* is used.
% If multiple sub-regions are considered *fminbnd* is used
%
% Inputs:
%     - n_areas: number of regions in mask
%     - x_wb: signal with wideband spectrogram
%     - x_rec: Estimated signal as a function of hyperpparametre lambda.see[1]
%
% Outputs:
%     -lambda_oracle: estimates lambda
%     - t_oracle:time to estimate lambda
%
%  Reference:
%
% [1]Time-frequency fading algorithms based on Gabor multipliers,2020.
%
% Author: Marina KREME
%%
tic;
obj_fun_oracle = @(lambda_coef) norm(x_wb - x_rec(lambda_coef));

if n_areas>1
    lambda_oracle = fmincon(obj_fun_oracle, ones(n_areas,1));
else
    lambda_oracle = fminbnd(obj_fun_oracle, 0, 1);
end
t_oracle = toc;

end


