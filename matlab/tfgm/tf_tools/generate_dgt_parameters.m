function dgt_params = generate_dgt_parameters(win_type, approx_win_len, hop, nbins, sig_len)
%% dgt_params = generate_dgt_parameters(win_type, approx_win_len, hop, nbins, sig_len)
%
%  Build structure of DGT parameter.The functions used for
% the DGT are those of ltfat and not those of Matlab
%  http://ltfat.github.io/doc/gabor

%     Inputs:
%      - win_type (str) : It can be either a hanning (hann) or gauss window.
%      - approx_win_len (int):  window length
%      - hop (int):  length of time shift.
%      - nbins (int): number of channels.
%      -sig_len (int): length of input signal.
%
%   Outputs: dgt_params -  struct containing dgt parameters
%      - dgt_params.('win_type'): the window type (str)
%      - dgt_params.('win'): the window array (nd-array)
%      - dgt_params.('hop'): the hop size (int)
%      - dgt_params.('n_bins'): the number of frequency bins (int)
%      -dgt_params.('win_len'): the effective window length
%                 (input window length rounded to the nearest power of two).
%      -dgt_params.('info'): The structure info provides some information
%                        about the compute window.
%                       see  http://ltfat.github.io/doc/gabor/gabwin.html


%
% Author : A. Marina KREME
% e-mail : ama-marina.kreme@lis-lab.fr/ama-marina.kreme@univ-amu.fr
% Created: 2020-28-01
%%



%%
win_type = lower(win_type);

if ~ischar(win_type)
    error('%s: The window type must be a string',upper(mfilename));
end


ch1= strcmp('hann', win_type);
ch2 = strcmp('gauss', win_type);

if ch1==0 && ch2==0
    error('%s: Incorrect window type. Please choose hann or gauss.',upper(mfilename));
end
%%



input_win_len = 2^(round(log2(approx_win_len)));

if input_win_len ~= approx_win_len
    warning('Input window length %.2f has been changed to %.2f.',approx_win_len, input_win_len);
end

win_len = input_win_len;

%%

L = sig_len;

switch win_type
    case 'hann'
        [win, info]= gabwin({'tight',{win_type, win_len}}, hop, nbins, L);
        
    case  'gauss'
        tfr = (pi*win_len^2)/(4*sig_len*log(2));
        [win, info]= gabwin({'tight',{win_type, tfr}}, hop, nbins,L);
        
end

%%

dgt_params.win_len = win_len;
dgt_params.hop = hop;
dgt_params.nbins= nbins;
dgt_params.win_type = win_type;
dgt_params.win = win;
dgt_params.info = info;


end

