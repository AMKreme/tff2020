function pq_norms_val = update_pq_norms(mask_labeled, pq_norms_val, i_p, signal_params, dgt, idgt)

%% pq_norms_val = update_pq_norms(mask_labeled, pq_norms_val, i_p, signal_params, dgt, idgt)
%
% Update (in-place) distance between one particular sub-region and all
% sub-regions in distance matrix.
%
%  This is an improvement of the function get_pq_norms.m
%
% Inputs:
%     - mask_labeled (nd array): Time-frequency mask with one positive integer
%       for each sub-region and zeros outside sub-regions.
%     - pq_norms_val:  Matrix of distances between sub-regions, updated in-place.
%     - i_p (int):  Index of sub-region to be updated
%     - signal_params (struct): Signals parameters
%    - idgt,dgt (handle): DGT and IDGT . see utils/get_stft_operators.m
% Output:
%     - pq_norms_val :  Matrix of distances between sub-regions.
%
% Author: Marina KREME

%%


sig_len = signal_params.sig_len;
n_labels = size(pq_norms_val,1);

mask_p = (mask_labeled==i_p);
gabmul_p = gen_gabmul_operator(dgt, idgt, mask_p);

for i_q =1:n_labels
%     if i_p == i_q
%         continue
%     end
    mask_q = (mask_labeled==i_q);
    gabmul_q = gen_gabmul_operator(dgt, idgt, mask_q);
    
    gabmul_pq =@(x)gabmul_p(gabmul_q(x));
    gabmul_pq_norm =  real(eigs(gabmul_pq, sig_len,1));
end
if i_q < i_p
    pq_norms_val(i_p, i_q) = gabmul_pq_norm;
else
    pq_norms_val(i_q, i_p) = gabmul_pq_norm;
end


end

