function is_1region = is_spectrum_1region(x_engine, k_area,lambda_coef, n_areas,x_rec)


lambda_vec = ones(n_areas,1);
lambda_vec(k_area) = lambda_coef;

is_1region =  itakura_saito_dist_spectrum(x_engine, x_rec(lambda_vec))  ;



end