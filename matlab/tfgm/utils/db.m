function x_db = db(x)
%% x_db = db(x)
% Linear to decibel (dB) conversion
% Inputs 
%     - x : scalar or nd-array
%           Values to be converted
% Output        
%        x_db (scalar or nd-array) : conversion of input 'x' in dB.
%
% Author: Marina KREME
%%
x_db = 20*log10(abs(x));
end



