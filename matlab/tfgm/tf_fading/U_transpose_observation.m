function ut_x = U_transpose_observation(x_mix, u_mat)

%% ut_x = U_transpose_observation(x_mix, u_mat)
% Function that calculates u_mat'*x_mix
%
% Inputs:
%     -x_mix :mixtures of signals with wideband and localized spectrograms
%     -u_mat:eignevectors matrix
% Outputs:
%     - ut_x: result of calculation
%
%  Author: Marina KREME
%
%%
ut_x = u_mat'*x_mix;

end

