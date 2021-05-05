function [t_arrf,t_evdn, t_ut_x, rank_q, s_vec_list, u_mat_list,...,
    ut_x_list,r] = compute_decomposition(x_mix, mask_list, gabmul_list,...,
    tolerance_arrf, proba_arrf)

%% [t_arrf,t_evdn,t_ut_x, rank_q, s_vec_list, u_mat_list, ut_x_list,r] = compute_decomposition(x_mix, mask_list, gabmul_list,tolerance_arrf, proba_arrf)

% This fucntion computes the eigenvalues decomposition (EVD) using
% random projection algorithms. see[1]
%
% Inputs:
%     - x_mix: mixtures of signals with wideband and localized spectrograms
%     -mask_list: cell of time -frequency mask
%     -gabmul_list: cell of Gabor multiplier associated to each mask
%     - tolerance_arrf: tolearance. see [1]
%     - proba_arrf: probability of success. see[1]
% Outputs:
%     -t_arrf:  time for adaptativerandomized range finder(arrf)
%     -t_evdn: time for eigenvalue decomposition via Nyström (evdn)
%     -t_ut_x: time for U^{T}*x_mix
%     -rank_q: array contains list of rank estimated by arrf
%     -s_vec_list: list of nonnegative and diagonal matrix obtained  by evdn
%     - u_mat_list list of orthononmal matrix obtained  by evdn
%     - r: parameter for arrf.
%
%
% Reference:
%
% [1] Nathan Halko, Per-Gunnar Martinsson, Joel A. Tropp, "Finding structure
%  with randomness: Probabilistic algorithms for constructing approximate
%  matrix decompositions", 2011.
%
%  Author: Marina KREME
%%

sig_len = length(x_mix);

n_areas = length(mask_list);
r =  compute_r(sig_len, sig_len, proba_arrf);

%%

t_arrf = zeros(n_areas,1);
t_evdn = zeros(n_areas,1);
t_ut_x = zeros(n_areas,1);
rank_q = zeros(n_areas,1);

s_vec_list = cell(n_areas,1);
u_mat_list = cell(n_areas,1);
ut_x_list = cell(n_areas,1);

%%


for k =1: n_areas
    %%
    
    mask_p = mask_list{k};
    fprintf('Random EVD of Gabor multiplier number %.f\n',k);
    
    [mask_area, mask_area_ratio] = get_mask_area(mask_p);
   
    
    fprintf('#coefs in mask: %f \n',mask_area);
    fprintf('#ratio of coefs in mask: %f %%\n',mask_area_ratio);
    
    
    tic;
    q_mat = adaptative_randomized_range_finder(gabmul_list{k}, sig_len, tolerance_arrf, r);
    t_arrf(k) = toc;
    rank_q(k) = size(q_mat,2);
    fprintf('Q size: %.f %.f\n', size(q_mat,1),size(q_mat,2));
    
    tic;
    evdn = EVD_nystrom(gabmul_list{k}, q_mat);
    t_evdn(k) = toc;
    
    s_vec_list{k} = sort(diag(evdn.D),'descend');
    u_mat_list{k} = evdn.U;
    
    
    fprintf('Running times:\n')
    fprintf('- adaptive_randomized_range_finder: %f s\n',t_arrf(k));
    fprintf('- evd_nystrom: %f s \n\n', t_evdn(k));
    
    
    tic;
    ut_x_list{k} = u_mat_list{k}'* x_mix;
    t_ut_x(k) = toc;
    
end

end