function IS = itakura_saito_dist(x_ref,x_est)
%% IS = itakura_saito_dist(x_ref,x_est)
% The Itakura Saito distance (or Itakura Saito divergence).It's measure
% of the difference between an original signal x_ref  and an approximation
% x_est. see [1]
% Inputs:
%     - x_ref : Reference signal
%     - x_est : Estimation of the reference signal
% Output:
%     -IS: Itakura Saito measurement.
%
%
% Reference:
%
% [1] Itakura,F.,& Saito,S. (1968). Analysis synthesis telephony based
% on the maximum likelihood method.
%
%
% Author: Marina KREME
%%
z = x_ref./x_est;

IS = sum(z - log(z)) - length(z);
end



