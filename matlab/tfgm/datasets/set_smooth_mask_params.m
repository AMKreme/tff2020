function [alpha, thres, radius] = set_smooth_mask_params(wideband_src, loc_source, win_type)
% This function allow us to generate parameters for smooth binary mask
% Inputs:
% - wideband_src : signal with wide-bande spectrogram
% - loc_source : signal with localized spectrogram
% - win_type : window - (gauss or hann)
%
%
% Outputs:
% - alpha : real
% - thres :threshold
% - radius : integer
%
% Author: Marina KREME


switch win_type
    case 'gauss'
        
        switch  wideband_src
            case 'car'
                switch loc_source
                    case 'beeps'
                        
                        alpha=9;
                        thres=1e-5;
                        radius=1;
                        
                    case 'bird'
                        alpha=1    ;
                        thres=1e-4;
                        radius=4;
                        
                    case 'chirps'
                        alpha=0.1;
                        thres=0.0001;
                        radius=1;
                        
                    case 'clicks'
                        alpha=1;
                        thres=0.0002;
                        radius=3;
                        
                    case 'finger_snaps'
                        alpha=0.01;
                        thres=0.0001;
                        radius=1;
                        
                    case 'modulations'
                        alpha=1;
                        thres=0.0002;
                        radius=3;
                        
                end
                
            case'plane'
                switch loc_source
                    case 'beeps'
                        
                        alpha=1;
                        thres=0.00002;
                        radius=2;
                        
                    case 'bird'
                        alpha=0.3;
                        thres=0.0001;
                        radius=1;
                        
                    case 'chirps'
                        alpha=0.01;
                        thres=0.0001;
                        radius=1;
                        
                    case 'clicks'
                        alpha=1;
                        thres=0.0003;
                        radius=4;
                        
                    case 'finger_snaps'
                        alpha=0.01;
                        thres=0.0001;
                        radius=1;
                        
                    case 'modulations'
                        alpha=1;
                        thres=0.0002;
                        radius=3;
                        
                        
                end
                
            case 'train'
                switch loc_source
                    case'beeps'
                        
                        alpha=1;
                        thres=0.0001;
                        radius=1;
                        
                    case 'bird'
                        alpha=0.1;
                        thres=0.0001;
                        radius=3;
                    case 'chirps'
                        alpha=0.01;
                        thres=0.001;
                        radius=1;
                        
                    case 'clicks'
                        alpha=1;
                        thres=0.0002;
                        radius=4;
                        
                    case 'finger_snaps'
                        alpha=0.01;
                        thres=0.0001;
                        radius=1;
                        
                    case 'modulations'
                        alpha=1;
                        thres=0.0002;
                        radius=3;
                        
                end
        end
        
        
        
    case 'hann'
        switch  wideband_src
            case 'car'
                switch loc_source
                    case 'beeps'
                        
                        alpha=1;
                        thres=0.00001;
                        radius=1;
                        
                        
                    case 'bird'
                        alpha=1;
                        thres=0.0001;
                        radius=3;
                        
                    case 'chirps'
                        alpha=0.1;
                        thres=0.0001;
                        radius=1;
                        
                    case 'clicks'
                        alpha=1;
                        thres=0.0002;
                        radius=4;
                    case 'finger_snaps'
                        alpha=0.01;
                        thres=0.0001;
                        radius=1;
                    case 'modulations'
                        alpha=1;
                        thres=0.0002;
                        radius=3;
                        
                end
            case 'plane'
                switch loc_source
                    case 'beeps'
                        
                        alpha=1;
                        thres=0.0001;
                        radius=1;
                        
                    case 'bird'
                        alpha=1;
                        thres=0.0002;
                        radius=4;
                        
                    case 'chirps'
                        alpha=0.1;
                        thres=0.0001;
                        radius=1;
                        
                    case 'clicks'
                        alpha=1;
                        thres=0.0002;
                        radius=2;
                        
                    case 'finger_snaps'
                        alpha=0.01;
                        thres=0.0001;
                        radius=1;
                    case 'modulations'
                        alpha=1;
                        thres=0.0002;
                        radius=3;
                        
                end
            case 'train'
                switch loc_source
                    case 'beeps'
                        
                        alpha=1;
                        thres=0.00002;
                        radius=1;
                    case 'bird'
                        alpha=1;
                        thres=0.001;
                        radius=2;
                    case 'chirps'
                        alpha=0.1;
                        thres=0.0001;
                        radius=1;
                    case 'clicks'
                        alpha=1;
                        thres=0.0001;
                        radius=1;
                    case 'finger_snaps'
                        alpha=0.01;
                        thres=0.0001;
                        radius=1;
                    case 'modulations'
                        alpha=1;
                        thres=0.0002;
                        radius=3;
                end
        end
end
fprintf("The parameters for smoothing the mask are: \n")
fprintf("alpha = %f\n", alpha);
fprintf("seuil = %f\n", thres);
fprintf("radius = %f\n", radius);


end
