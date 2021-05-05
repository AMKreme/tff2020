function  [t_rrf,t_evdn, t_ut_x, s_vec_list, u_mat_list,...,
    ut_x_list]=compute_decomposition_fixed_rank(x_mix, mask_list, gabmul_list, rank)

%%  [t_rrf,t_evdn, t_ut_x, s_vec_list, u_mat_list,ut_x_list]=compute_decomposition_fixed_rank(x_mix, mask_list, gabmul_list, rank)

% This fucntion computes the eigenvalues decomposition fixed rank with (EVD) using
% random projection algorithms. see[1]
%
% Inputs:
%     - x_mix: mixtures of signals with wideband and localized spectrograms
%     -mask_list: cell of time-frequency mask
%     -gabmul_list: cell of Gabor multiplier associated to each mask
%     - rank : matrix rank see [1]
% Outputs:
%     -t_rrf:  time for randomized range finder(rrf)
%     -t_evdn: time for eigenvalue decomposition via Nyström (evdn)
%     -t_ut_x: time for U^{T}*x_mix
%     -rank_q: array contains list of rank estimated by arrf
%     -s_vec_list: list of nonnegative and diagonal matrix obtained  by evdn
%     - u_mat_list list of orthononmal matrix obtained  by evdn
%     - ut_x_list: list of U^{T}*x_mix
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


%%
n_areas = length(mask_list);

sig_len = length(x_mix);
%%

t_rrf = zeros(n_areas,1);
t_evdn = zeros(n_areas,1);
t_ut_x = zeros(n_areas,1);


s_vec_list = cell(n_areas,1);
u_mat_list = cell(n_areas,1);
ut_x_list = cell(n_areas,1);

%%


for k =1: n_areas
    mask_p = mask_list{k};
    fprintf('Random EVD of Gabor multiplier nummber %.f\n',k);
    
    [mask_area, mask_area_ratio] = get_mask_area(mask_p);
    fprintf('#coefs in mask: %f \n',mask_area);
    fprintf('#ratio of coefs in mask: %f %%\n',mask_area_ratio);
    
    
    tic;
    q_mat = randomized_range_finder(gabmul_list{k}, sig_len, rank);
    t_rrf(k) = toc;
    
    fprintf('Q size: %.f %.f\n', size(q_mat,1),size(q_mat,2));
    
    tic;
    evdn = EVD_nystrom(gabmul_list{k}, q_mat);
    t_evdn(k) = toc;
    
    s_vec_list{k} = diag(evdn.D);
    u_mat_list{k} = evdn.U;
    
    
    fprintf('Running times:\n')
    fprintf('- randomized_range_finder: %f s\n',t_rrf(k));
    fprintf('- evd_nystrom: %f s \n\n', t_evdn(k));
    
    
    tic;
    ut_x_list{k} = u_mat_list{k}'* x_mix;
    t_ut_x(k) = toc;
    
end

