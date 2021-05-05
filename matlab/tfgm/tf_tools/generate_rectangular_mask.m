function mask = generate_rectangular_mask(nbins, hop, sig_len, t_lim, f_lim)
%% GENERATE_RECTANGULAR_MASK
% Generate a rectangular time-frequency mask
% mask = generate_rectangular_mask(nbins, hop, sig_len, t_lim, f_lim)
% Inputs:
%    - nbins: numbers of frequency bins (int)
%    - hop : hop size (int)
%    - sig_len: signal length (int)
%    - t_lim :  time boundaries of the mask
%    - f_lim : frequency boundaries of the mask
%
% Outputs:
%     - mask : the boolean 2D array containing the time-frequency mask (True values)
%
% Author : A. Marina KREME
%%


M = nbins/2 +1;
N = sig_len/hop;

if size(f_lim,2)~=2 || size(t_lim,2)~=2
    error("Incorrect value. f_lim or t_lim  must be an interval")
end

mask = zeros(M,N);
f_lim  = round(f_lim*size(mask,1));
t_lim =round(t_lim*size(mask,2));

mask(f_lim(1):f_lim(2),t_lim(1):t_lim(2))=1;

end
