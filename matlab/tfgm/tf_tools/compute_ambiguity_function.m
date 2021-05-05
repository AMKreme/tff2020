function w = compute_ambiguity_function(w, dgt, apply_fftshift)
%% x = compute_ambiguity_function(x, dgt ,fftshift_)
% Compute the ambiguity function of the window
%
% Inputs:
%     - w (nd array): vector
%     - dgt (handle): DGT operator. see utils/get_stft_operators.m
%     -apply_fftshift: Boolean If true, shift the window in time before 
%                       computing its DGT.
%
%Author: Marina KREME
%%
apply_fftshift = [upper(apply_fftshift(1)),apply_fftshift(2:end)];
switch apply_fftshift
    
    case 'True'
        w = dgt(fftshift(w));
        
    case 'False'
        w = dgt(w);
    otherwise
        fprintf('Incorrect value fftshift_\n')
        
end



