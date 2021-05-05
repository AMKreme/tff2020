function  params = get_params(win_len, win_type)
% Function that generates input data for the function that generates dgt parameters
% Inputs:
%     -win_len(int): analysis window length
%     -win_type(str): analysis window type (hann/gauss)
% Outputs:
%     -hop(int): hop size
%     -nbins(int): frequency bins
%     -win_type, win_len
% 
% Author : Marina KREME
%%

switch win_type
    case 'gauss'
        hop = win_len/4;
        nbins = win_len*4;
    case 'hann'
        
        hop = win_len/8;
        nbins = win_len*2;
end

params.win_type = win_type;
params.win_len = win_len;
params.hop = hop;
params.nbins = nbins;

end