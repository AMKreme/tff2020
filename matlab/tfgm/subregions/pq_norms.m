function pq_norms = pq_norms(sig_len, dgt, idgt, mask_list)

%% pq_norms = pq_norms(sig_len, dgt, idgt, mask_list)
% This function compute norm between each p and q regio $p\neq q$ from list
% of mask
%
% Inputs:
%     -sig_len: signal length
%     -dgt, idgt: Discrete Gabor Transform parameters(hop, nbins,win, ect..)
%     -mask_list(struct):list contains P masks
% Outputs:
%     - pq_norms:  array with all norms between all p and q regions
%
% Author: Marina KREME

%%

n_labels = length(mask_list);
pq_norms = zeros(n_labels);


%%

for p =1: n_labels-1
    
    mask_p = mask_list{p};
    for q = p+1:n_labels
        
        mask_q = mask_list{q};
        
        mul_pq = @(x)idgt(mask_p.*dgt(idgt(mask_q.*dgt(x))));
        pq_norms(p,q) = real(eigs(mul_pq, sig_len,1));
        
        
    end
end

end