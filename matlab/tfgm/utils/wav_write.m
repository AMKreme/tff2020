function  wav_write(filename, y, fs)
%% WAV_WRITE
% Function that writes an audio data file $y$ from a sampling frequency $fs$to a 
% file called a $filename$.The filename entry also specifies the format 
% of the output file.
%
% Author : A. Marina KREME
% e-mail : ama-marina.kreme@lis-lab.fr/ama-marina.kreme@univ-amu.fr
% Created: 2020-28-01
%%

x= y/max(abs(y));
audiowrite(filename,x,fs);
end 