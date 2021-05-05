function dataset = get_dataset()

% Get dataset for isolated wideband and localized sources before mixing.

% dataset : struct
%         dataset.('wideband').(sounds names)is a dictionary
%         containing the path of all the wideband and localized sounds.
% 
% Author: Marina KREME

wide_dir = './data/data_8000Hz_16384samples/wide_band_sources/';
loc_dir = './data/data_8000Hz_16384samples/localized_sources/';

n_wide_dir = dir([wide_dir, '*.wav']);
n_loc_dir = dir([loc_dir, '*.wav']);
dataset = struct('wideband',struct(),'localized',struct());


for x =1:length(n_wide_dir)
    
    wideband_file = [n_wide_dir(x).folder, filesep,n_wide_dir(x).name];
    wideband_name = n_wide_dir(x).name(1:end-4);
    
    dataset.wideband.(wideband_name)=wideband_file;
    
end


for x =1: length(n_loc_dir)
    
    localized_file = [n_loc_dir(x).folder, filesep,n_loc_dir(x).name];
    localized_file_name = n_loc_dir(x).name(1:end-4);
    
    dataset.localized.(localized_file_name)=localized_file; 
    
end




