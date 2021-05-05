function  [mask_labeled, varargout] = create_subregions(mask, dgt, idgt, ...,
    dgt_params, signal_params, tol, fig_dir)

%% [mask_labeled, varargout] = create_subregions(mask, dgt, idgt, ...,
%    dgt_params, signal_params, tol, fig_dir)
% See Algorithm 3 *Finding sub-regions for TFF-P* in the reference paper[1].
%
% Inputs:
%      - mask: Time-frequency boolean mask
%      - idgt,dgt (handle): DGT and IDGT . see utils/get_stft_operators.m
% Outputs:
%      - dgt_params (struct): DGT parameters
%      - signal_params (struct): Signals parameters
%      - tol: Tolerance on sub-region distance (spectral norm of the composition
%        of the Gabor multipliers related to two candidate sub-regions).see [1]
%      - fig_dir :  Figures directory
%
% Outputs:
%     - mask_labeled: Time-frequency mask with one positive integer for
%         each sub-region and zeros outside sub-regions.

%     -pq_norms_val:  Matrix of distances between sub-regions.
%
%
% Reference:
% [1]Time-frequency fading algorithms based on Gabor multipliers,2020.
%
%
% Author: Marina KREME
%%
mask_bool = boolean(mask);
[mask_labeled, n_labels] = bwlabel(mask_bool);
sig_len = signal_params.sig_len;
pq_norms_val = get_pq_norms(sig_len, dgt, idgt, mask_labeled);

%%
figure;
plot_mask(mask_labeled, dgt_params.hop, dgt_params.nbins, signal_params.fs)
title('Initial subregions')
saveas(gcf,fullfile(fig_dir, 'initial_subregions.fig'));

figure;
imagesc(real(log10(pq_norms_val+pq_norms_val.')))
ylabel('Sub-region index')
xlabel('Sub-region index')
colorbar()
title('Initial norms of Gabor multiplier composition')
saveas(gcf,fullfile(fig_dir, 'initial_norms.fig'));

n_labels_max = n_labels;

%%

while max(pq_norms_val(:))>tol
    %Merge each pair (p, q), q < p, such that pq_norms[p, q] > tol
    to_be_updated = boolean(zeros(n_labels,1));
    
    while max(pq_norms_val(:))>tol
        [i_p, i_q] =  find(pq_norms_val == max(pq_norms_val(:)));
        
        
        mask = mask_labeled;
        [mask_labeled, pq_norms_val] = merge_subregions(mask, pq_norms_val, i_p, i_q);
        
        to_be_updated(i_q)= true;
        to_be_updated(i_p) = to_be_updated(end);
        to_be_updated = to_be_updated(1:end-1);
        n_labels =n_labels- 1;
    end
    
    for i_p =1:n_labels
        if to_be_updated(i_p)==true
            pq_norms_val = update_pq_norms(mask_labeled, pq_norms_val, i_p, signal_params, dgt, idgt);
        end
    end
    
    
    
    
    
    figure;
    plot_mask(mask_labeled, dgt_params.hop, dgt_params.nbins, signal_params.fs)
    title('subregions ')
    saveas(gcf,fullfile(fig_dir, ['subregions_i_', num2str(n_labels_max-n_labels),'.fig']));
    
    
    figure;
    imagesc(real(log10(pq_norms_val+pq_norms_val.')))
    ylabel('Sub-region index')
    xlabel('Sub-region index')
    colorbar()
    title('norms of Gabor multiplier composition')
    saveas(gcf,fullfile(fig_dir, ['norms_i', num2str(n_labels_max-n_labels),'.fig']));
    
    
end


%%



figure;
plot_mask(mask_labeled, dgt_params.hop, dgt_params.nbins, signal_params.fs)
title('Final subregions')
saveas(gcf,fullfile(fig_dir,'final_subregions.fig'));


figure;
imagesc(real(log10(pq_norms_val+pq_norms_val.')))
ylabel('Sub-region index')
xlabel('Sub-region index')
colorbar()
title('Final norms of Gabor multiplier composition')
saveas(gcf,fullfile(fig_dir, 'final_norms.fig'));

varargout{1} = pq_norms_val;

end




