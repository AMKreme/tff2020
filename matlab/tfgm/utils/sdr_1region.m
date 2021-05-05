function sdr_1region =sdr_1region(lambda_coef, k_area, x_rec, x_engine, n_areas)

lambda_vec = ones(n_areas,1);
lambda_vec(k_area) = lambda_coef;


sdr_1region = sdr(x_engine, x_rec(lambda_vec));


end


