function [mask_list, mask_labeled, mask_area_list] = make_subregions(mask, dgt_params, signal_params)

%%[mask_list, mask_labeled, mask_area_list] = make_subregions(mask, dgt_params, signal_params)
% This function split the whole regions into P regions
% Inputs:
%     - mask: original mask
%     - dgt_params : Discrete Gabor Transform parameters(hop, nbins,win, ect..)
%     -signal_params: Signals parameters(sig_len, fs)
% Outputs:
%     - mask_list(struct):list contains P masks
%     - mask_labeled: mask labeled
%     - mask_area_list:  mask area for each P region
%
% Author: Marina KREME

%%



[~,n_labels] = bwlabel(mask);

mask_area_list = zeros(n_labels,1);
mask_list = cell(n_labels,1);


for k =1:n_labels
    %%
    
    [mask_labeled,~] = bwlabel(mask);
    
    % on construit chaque mask
    mask_labeled(mask_labeled~=k)= false;
    mask_labeled(mask_labeled==k)=true;
    mask_k =mask_labeled;
    mask_list{k} = mask_k;
    figure(k); plotdgtreal(mask_k, dgt_params.hop, dgt_params.nbins, signal_params.fs);
    title(['k=', num2str(k)])
    
    [mask_area, mask_area_ratio] = get_mask_area(mask_k);
    mask_area_list(k) = mask_area;
    fprintf('mask area = %.f, mask area ratio = %f\n',mask_area, mask_area_ratio);
    
    
end

[mask_labeled,~] = bwlabel(mask);
end






