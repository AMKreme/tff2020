function[mask, pq_norms_val] = merge_subregions(mask, pq_norms_val, i_p, i_q)

%% [mask, pq_norms_val] = merge_subregions(mask, pq_norms_val, i_p, i_q)
% This function merge two sub-regions indexed by *i_p* and *i_q*. See [1]
%
% In the time-frequency mask, the label of the region indexed by *i_p*
%   will be replace by the label of the region indexed by *i_q* and index
%    *i_p* will be used to relabel the region with highest label.
%
%   In the distance matrix, rows and columns will be moved consequently. The
%  distance between the new, merged sub-region and all other sub-regions is
%  not updated; it can be done by calling *update_pq_norms*.

% Inputs:
%     - mask_labeled (nd array): Time-frequency mask with one positive integer
%       for each sub-region and zeros outside sub-regions.
%     - pq_norms_val:  Matrix of distances between sub-regions, updated in-place.
%     - i_p (int):  Index of sub-region that will be removed after merging.
%     - i_q (int): Index of sub-region that will receive the result.
% Outputs:
%     -mask (nd array):updated time-frequency mask with one positive integer
%                       for each sub-region and zeros outside sub-regions.

%     - pq_norms_val (nd array):  Updated distance matrix (except for distance
%                        with the new sub-region).

% Reference:
% [1]Time-frequency fading algorithms based on Gabor multipliers,2020.
%
% Author: Marina KREME
%%
p = i_p + 1;
q = i_q + 1;

n_labels = size(pq_norms_val,1);
mask(mask == p)= q;
mask(mask == n_labels) = p;
pq_norms_val(i_p, 1:i_p - 1)= pq_norms_val(end, 1:i_p - 1);
pq_norms_val(i_p:end, i_p) = pq_norms_val(end, i_p:end);
pq_norms_val = pq_norms_val(1:end-1, 1:end-1);

end




