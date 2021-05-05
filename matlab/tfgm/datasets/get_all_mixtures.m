
clc; clear; close all;
%%
% This script allows to generate all the possible mixtures as well as
% the parameters for the corresponding masks for each window.
%%

pathname ='fig_spectro_all_mixtures';
if ~exist(pathname,'dir')
    mkdir(pathname);
end
addpath(pathname)

%%
dataset = get_dataset();
dbstack;
%%
wins_params = struct('Gauss256', struct('win_type','gauss','win_len', 256),...,
    'Hann512', struct('win_type','hann','win_len', 512));

gamma=0.7;
fs = 8000;
sig_len =16384;
signal_params = generate_signal_parameters(fs, sig_len);

%%
wideband_name ={'car','plane','train'};
localized_name = {'beeps','bird','chirps','clicks','finger_snaps','modulations'};


%% DGT parameters
keys = fieldnames(wins_params);
for win_param = 1: length(keys)
    
    
    win_len = wins_params.(keys{win_param}).win_len;
    win_type = wins_params.(keys{win_param}).win_type;
    params = get_params(win_len, win_type);
    
    fprintf("window  %s:\n\n",win_type);
    
    % DGT parameters
    dgt_params = generate_dgt_parameters(win_type, win_len, params.hop,...,
        params.nbins, sig_len);
    
    %DGT operators
    [dgt, idgt] = get_stft_operators(dgt_params, signal_params);
    
    for wb = 1:length(wideband_name)
        wideband_src =wideband_name{wb};
        
        for loc = 1:length(localized_name)
            loc_source = localized_name{loc};
            
            
            [x_loc, fs_loc]= audioread(dataset.localized.(loc_source));
            [x_wb, fs_wb]= audioread(dataset.wideband.(wideband_src));
            
            if  length(x_loc)~=length(x_wb)
                warning('Arrays are not equal');
            end
            
            if fs_loc~=fs_wb
                error('The sampling frequencies must be the same.')
            end
            signals = generate_mix_signal(x_wb, x_loc, gamma);
            
            tf_mat_wb = dgt(signals.wideband);
            tf_mat_loc = dgt(signals.localized);
            tf_mat_mix = dgt(signals.mix);
            
            [alpha,  thres, radius] = set_smooth_mask_params(wideband_src,...,
                loc_source, win_type);
            
            [mask] = generate_mask(tf_mat_wb, tf_mat_loc, alpha, thres, radius);
            
            figure ;
            subplot(221)
            plot_spectrogram(tf_mat_wb, dgt_params, signal_params, dgt );
            title('wideband')
            subplot(222)
            plot_spectrogram(tf_mat_loc, dgt_params, signal_params, dgt );
            title('localized')
            subplot(223)
            plot_spectrogram(tf_mat_mix, dgt_params, signal_params, dgt );
            title('mix')
            subplot(224)
            plot_spectrogram(mask, dgt_params, signal_params, dgt );
            title('mask')
            
            
        end
        
    end
end


