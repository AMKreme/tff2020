%% load data
fid = fopen('exp_solve_pd.csv', 'r');
% read data
formatSpec = '%s %s %s %f %s %f';
data = textscan(fid, formatSpec,...
    'headerlines', 1,...
    'delimiter',',',...
    'TreatAsEmpty','NA'); % lecture du fichier
fclose(fid);

%% define data to be taken
% PERTUBATION
%data{1,1}
% 'beeps' 'bird' 'chirps' 'clicks' 'finger_snaps' 'modulations'
listp={'beeps','bird','chirps','clicks','finger_snaps','modulations'};
% WIDEBAND SIGNALS
%data{1,2}
% 'car' 'train' 'plane'
listw={'car','train','plane'};
% WINDOW
%data{1,3}
win = 'gauss 256'; %ou 'hann 512'
% 1 REGION or P REGIONS
%data{1,4}
%isnan 1 region sinon P region
% DATA TO BE READ
%data{1,5}
% 'is_zero' 'is_interp' 'is_oracle_sdr' 'is_tff'
% NUMERICAL VALUE
%data{1,6} --> les res numeriques

%% generate matlab table
indw=strcmp(data{1,3},win); %window
indnan=isnan(data{1,4}); %1 or P regions

% we read all configurations
tab=[];
for i=listp
    indb=strcmp(data{1,1},i);
    for j=listw
        tabtmp=[];
        indc=strcmp(data{1,2},j);
        for k={'is_zero','is_interp','is_oracle_sdr','is_tff'}
            inds=strcmp(data{1,6},k);
            ind=indw&indb&indc&inds&indnan;
            tabtmp=[tabtmp,data{1,6}(ind)];
        end
        ind=indw&indb&indc&inds&~indnan;
        tabtmp=[tabtmp,data{1,6}(ind)];
        tab=[tab;tabtmp];
    end
end

%% generate latex table
fic='resIS.txt';
fid=fopen(fic,'a+');
l=1;
txt=[];
for i=listp
    for j=listw
        for m=1:5
            txt=[txt,'&',num2str(tab(l,m),'%.1f')];
            if m==5
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
fclose(fid);