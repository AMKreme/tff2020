clc; clear; close all;


%% load data
fid = fopen('exp_tffP_mod.csv', 'r');
% read data
formatSpec = '%s %s %s %f %f %f %f';
data1 = textscan(fid, formatSpec,...
    'headerlines', 1,...
    'delimiter',',',...
    'TreatAsEmpty','NA'); % lecture du fichier
fclose(fid);
%%
%% define data to be taken
% PERTUBATION
%data{1,1}
% 'beeps' 'bird' 'chirps' 'clicks' 'finger_snaps' 'modulations'
listp={'beeps','bird','chirps','clicks','finger_snaps','modulations'};
%listp = {'beeps','bird'};
% WIDEBAND SIGNALS
%data{1,2}
% 'car' 'train' 'plane'
listw={'car','train','plane'};
%listw ={'car','plane'};
% WINDOW
%data{1,3}
win = 'gauss'; %ou 'hann 512'
% 1 REGION or P REGIONS
%data{1,4}
%isnan 1 region sinon P region
% DATA TO BE READ
%data{1,5}
% 'sdr_zero' 'sdr_interp' 'sdr_tff' 'sdr_oracle_sdr'
% NUMERICAL VALUE
%data{1,6} --> les res numeriques

%% generate matlab table

for l =2:2%length(data{1,1})
line = data{1,1}{l};    

end

%%
indw=strcmp(data1{1,1},win); %window
%indnan=isnan(data{1,4}); %1 or P regions

% we read all configurations
%tab=[];
for i=listp
    indb=strcmp(data1{1,2},i);
    for j=listw
        %tabtmp=[];
        %indc=strcmp(data1{1,3},j);
        %for k={'SDR interp+rpi','SDR interp+ gli','IS interp+rpi','iS interp+ gli'}
            %inds=strcmp(data{1,5},k);
            %ind=indw&indb&indc ;%&inds %&indnan;
            tabtmp=[data1{1,4},data1{1,5},data1{1,6},data1{1,7}];
        %end
        %ind=indw&indb&indc&inds&~indnan;
        %tabtmp=[tabtmp,data{1,6}( ind)];
        %tab=[tab;tabtmp];
    end
end

%%
%% generate latex table
fic='resSDR1.txt';
fid=fopen(fic,'a+');
l=1;
txt=[];
tab=tabtmp;
for i=listp
    for j=listw
%         for m=1:3
%             txt=[txt,'&',num2str(tab(l,m),'%.1f')];
%             if m==2
%                 txt=[txt,'\\'];
%             end
%         end
        text=[i{1},'&',j{1},txt];
        fprintf(fid,'%s\n',text);
        l=l+1;
        txt=[];
    end
    fprintf(fid,'%s\n','\hline');
end
fclose(fid);