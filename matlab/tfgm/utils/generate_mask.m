function [mask,varargout] = generate_mask(tf_mat_wideband, tf_mat_loc, alpha, seuil, radius)

%% GENERATE MASK
% [original_mask, mask_after_imclose, mask_after_imopen,...,
%    mask] = generate_mask(tf_mat_wideband, tf_mat_loc, alpha, seuil, radius)

% This function generates a binary mask using math morphology. We used 
% 'disk' structuring element and a radius is given as input.
% 
% Inputs:

%     - tf_mat_wideband:  dgt of target signal
%     - tf_mat_loc : dgt of perturbation signal
%     - alpha: parameter to adjust the size of the mask
%     - radius : it specifies the radius of  morphological structuring element.
%     - seuil: threshold value.
%
% Output:
%     - mask:  binary mask
%
% Author : A. Marina KREME
% e-mail : ama-marina.kreme@lis-lab.fr/ama-marina.kreme@univ-amu.fr
% Created: 2020-28-01
%%


original_mask = or(abs(tf_mat_wideband)<alpha*abs(tf_mat_loc), abs(tf_mat_loc)>seuil);
varargout{1} = original_mask;

%figure('name','mask initial'); imagesc(original_mask)

%%

se = strel('disk',radius);
mask_after_imclose = imclose(original_mask,se);

varargout{2} = mask_after_imclose;
%figure('name','imclose'); imagesc(mask_after_imclose)
%%
mask_after_imopen = imopen(mask_after_imclose,se);
varargout{3} = mask_after_imopen;
%figure('name','mask imopen'); imagesc(mask_after_imopen)
mask =mask_after_imopen;
end

