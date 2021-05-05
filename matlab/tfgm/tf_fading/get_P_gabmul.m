function [gabmul_list, mask_list] = get_P_gabmul(final_mask_labeled, dgt, idgt)

%% [gabmul_list, mask_list] = get_P_gabmul(final_mask_labeled, dgt, idgt)
%
% This function create Gabor multiplier associated to eack mask
% Inputs:
%     - final_mask_labeled: labeling mask with merging of certain regions
%     -dgt, idgt : Gabor tranform and its inverse operator
% Outputs:
%     - gabmul_list: list of Gabor multipliers
%     - mask_list: list of mask corresponding to each region
%
%
% Author: Marina KREME
%
%%
n_labels = length(unique(final_mask_labeled))-1;
gabmul_list = cell(n_labels,1);
mask_list = cell(n_labels,1);

for k=1:n_labels
    mask_k = (final_mask_labeled==k);
    gabmul_k =  gen_gabmul_operator(dgt, idgt, mask_k);
    
    gabmul_list{k} = gabmul_k;
    mask_list{k} = mask_k;
end


end




