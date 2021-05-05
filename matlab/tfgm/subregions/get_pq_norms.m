function pq_norms_val = get_pq_norms(sig_len, dgt, idgt, mask_labeled)

%%  pq_norms_val = get_pq_norms(sig_len, dgt, idgt, mask_labeled)
% This function Compute distance matrix between sub-regions.
%
% Inputs:
%     - sig_len (int): signal length
%     - idgt,dgt (handle): DGT and IDGT . see utils/get_stft_operators.m
%     - mask_labeled: mask with P regions
% Output:
%     - pq_norms_val (nd array) :  Matrix of distances between sub-regions.
%
% Author: Marina KREME
%
%%
dbstack;
n_labels = length(unique(mask_labeled))-1;

pq_norms_val = zeros(n_labels);

for p =1: n_labels
    fprintf('p %f\n',p)
    for q = 1:p
        fprintf('q %f\n',q)
        
        mask_p = (mask_labeled==p);
        mask_q = (mask_labeled==q);
        mul_pq = @(x)idgt(mask_p.*dgt(idgt(mask_q.*dgt(x))));
        pq_norms_val(p,q) = real(eigs(mul_pq, sig_len,1));
        
        
    end
end
end



