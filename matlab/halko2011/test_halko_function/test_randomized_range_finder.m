clc; clear; close all;
% Test de l'algorithme randomized range finder  avec le multiplicteur 
%%  
duration = 1;
fs = 1024;
c= 1; s = 4;
win_type='hann';
approx_win_duration = 0.02;

%% Parametres du signal et de la DGT
signal_params = generate_signal_parameters(fs, duration);
dgt_params = generate_dgt_parameters(signal_params, win_type, approx_win_duration,c ,s);
[direct_stft, adjoint_stft] = get_stft_operators(dgt_params, signal_params);


%% Generation du mask
M = dgt_params.nbins/2 +1; 
N = signal_params.sig_len/ dgt_params.hop; 

T= duration;     
t1= [0.1,0.5];
f1= [32, 100];

mask = generate_maskby_hand(T, fs, t1, f1, M, N); % generation du masque

figure; plotdgtreal(mask, dgt_params.hop, dgt_params.nbins, fs);

%% Le multiplicateur

A = gen_gabmul_operator(direct_stft, adjoint_stft, mask);

%% Determination du rang de la matrice associee a  l'operateur A

x = randn(signal_params.sig_len,1);
Amat = A(x);

disp(sum(Amat~=0));

%%  Construction de la matrice Q
l = sum(Amat~=0);

tic; 
Q = randomized_range_finder(A, signal_params.sig_len, l);
t_Q = toc;
 


%% A t-on norm(Amat - Q*Q'*Amat) <= epsilon ?
I = eye(signal_params.sig_len);
B = A(I-Q*Q');
disp(norm(B,2))
