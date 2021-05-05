function [mask_labeled, n_areas,t_subregions] = get_nareas(mask_bool,dgt, idgt, dgt_params,...,
    signal_params, fig_dir, tol_subregions)

%%  [mask_labeled, n_areas,t_subregions] = get_nareas(mask_bool,dgt, idgt, dgt_params, signal_params, fig_dir, tol_subregions)
%
% This function creates regions
%
% Inputs:
%     - mask_bool:binary mask
%     -dgt, idgt:Gabor transform and its inverse operator
%     -dgt_params:Discrete Gabor Transform parameters(hop, nbins,win, ect..)
%     -signal_params:Signals parameters(sig_len, fs)
%     -fig_dir: figures directory
%     -tol_subregions :tolerance
%
% Outputs:
%     - mask_labeled:mask labeled
%     - n_areas: number of sub regions
%     -t_subregions:time to create sub regions
%
%
% Author: Marina KREME


%%

switch tol_subregions
    case 1e-5
        tic;
        mask_labeled = create_subregions(mask_bool, dgt, idgt, dgt_params,...,
            signal_params, tol_subregions,fig_dir);
        t_subregions = toc;
        n_areas = length(unique(mask_labeled))-1;
    case 0
        
        n_areas =1;
        mask_labeled = mask_bool>0;
        t_subregions=0;
    otherwise
        fprintf("Incorrect value of tolerance\n");
        
end


end


