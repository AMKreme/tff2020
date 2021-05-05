%% load data
fid = fopen('exp_tff1.csv','r');
% read data
formatSpec = '%s %s %s %f %f %f %f %d %.3f %.3f %.3f %.3f %.3f %.3f %.3f %.3f %.3f %.3f %.3f';
data = textscan(fid, formatSpec,...
    'headerlines', 1);%...
    %'delimiter',' ',...
   % 'TreatAsEmpty','NA'); % lecture du fichier
fclose(fid);

%% define data to be taken
% PERTUBATION
%data{1,1}
% 'beeps' 'bird' 'chirps' 'clicks' 'finger_snaps' 'modulations'
listp={'beeps','bird','chirps'};%,'clicks','finger_snaps','modulations'};

% WIDEBAND SIGNALS
%data{1,2}
% 'car' 'train' 'plane'
listw={'car','plane','train'};
% WINDOW
%data{1,3}
win = 'gauss'; %256'; %ou 'hann 512'
% 1 REGION or P REGIONS
%data{1,4}
%isnan 1 region sinon P region
% DATA TO BE READ
%data{1,5}
% 'sdr_zero' 'sdr_interp' 'sdr_tff' 'sdr_oracle_sdr'
% NUMERICAL VALUE
%data{1,6} --> les res numeriques

%% generate matlab table
indw=strcmp(data{1,3},win); %window
indnan=isnan(data{1,4}); %1 or P regions
%%
% we read all configurations
tab=[];
 i= listp;
indb=strcmp(data{1,2},i');

j=listw;
tabtmp=[];
jj = listw{1};
indc=strcmp(data{1,1},jj);

k = {'sdr_interp','sdr_zero','sdr_est','sdr_oracle'};
tabtmp=[data{1,11},data{1,12},data{1,13},data{1,14}];
%%


%%
tab=[];
for i= listp
   
    indb=strcmp(data{1,2},i);
    for j=listw
        tabtmp=[];
        indc=strcmp(data{1,5},j);
        for k={'sdr_interp','sdr_zero','sdr_est','sdr_oracle'}
            inds=strcmp(data{1,1},k);
            ind=indw&indb&indc&inds&indnan;
            tabtmp=[tabtmp,data{1,6}(ind)];
        end
        ind=indw&indb&indc&inds&~indnan;
        tabtmp=[tabtmp,data{1,6}(ind)];
        tab=[tab;tabtmp];
    end
   
end

%% generate latex table
fic='resultatSDR.txt';
fid=fopen(fic,'a+');
l=1;
txt=[];
tab=tabtmp;
for i=listp
 
    for j= listw
       
       
        for m=1:4
            txt=[txt,'&',num2str(tab(l,m),'%.1f')];
            if m==3
                txt=[txt,'\\'];
            end
        end
        text=[i{1},'&',j{1},txt];
        fprintf(fid,'%s\n',text);
        l=l+1;
        
        txt=[];
    end
   
    fprintf(fid,'%s\n','\hline');
end
 l=l+1;
fclose(fid);