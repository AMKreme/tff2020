function IS_spectrum= itakura_saito_dist_spectrum(x_ref,x_est)

%% IS_spectrum= itakura_saito_dist_spectrum(x_ref,x_est)
% The Itakura Saito distance (or Itakura Saito divergence).It's measure
% of the difference between an original spectrum  and an approximation. see [1]
% Inputs:
%     - x_ref : Reference signal
%     - x_est :  Estimation of the reference signal
% Output:
%     -IS: Itakura SAito measurement.
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


x_spectre = abs(fft(x_ref));
y_spectre = abs(fft(x_est));
IS_spectrum =itakura_saito_dist(x_spectre,y_spectre);

end




