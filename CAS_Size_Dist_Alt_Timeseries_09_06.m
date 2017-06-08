%-----Read variables from ORACLES Summary file and IWG1 File-----%
ncid=netcdf.open('16_09_06_06_40_17.Combined.conc.cas.1Hz.nc');
b=netcdf.open('16_09_06_06_40_17.Combined.oracles.nc');

%-----Read Unix time and convert to timevec for CAS file-----%
base_time_cas=netcdf.getVar(ncid,7);
time_offset_cas=netcdf.getVar(ncid,8);
offset_cas=[0:numel(time_offset_cas)-1]';
base_seconds_cas=offset_cas+double(base_time_cas);
timevec_cas=unix_to_timevec(base_seconds_cas);

%-----Read Unix time and convert to time vector for summary file-----%
base_time=netcdf.getVar(b,7);
time_offset=netcdf.getVar(b,8);
offset=[0:numel(time_offset)-1]';
base_seconds=offset+double(base_time);
timevec=unix_to_timevec(base_seconds);

%-----Read variables from summary file-----%
altitude=netcdf.getVar(b,19)-50; % WGS84 Altitude
latitude=netcdf.getVar(b,28);

%-----Read variables from CAS file-----%
latitude(latitude<-90)=NaN;
cas_Nt=netcdf.getVar(ncid,41); % 3 to 50 microns
king_lwc=netcdf.getVar(b,36); %'Liquid Water Content based on King Probe measurement adjusted (cloud threshold =  5.1 [#/cm^3], cloud interval = 30.0 [s] and adjustment slope = 1.000) for the baseline offset [g/m^3]''#/cm^3'

% index1=find(cas_Nt<cas_limit);
%% %-----Calculate CAS LWC from CAS size distribution-----%

%-----Put bin concentrations into size distribution matrix-----%
% channels=16;
channels=30;
cas_Nd=zeros(numel(timevec_cas),channels);
 for k=9:38;
% for k=23:38;
     eval(sprintf('cas_Nd(:,%d-8)=netcdf.getVar(ncid,%d);',k,k));
%     eval(sprintf('cas_Nd(:,%d-22)=netcdf.getVar(ncid,%d);',k,k));
end
% cas_Nd(cas_Nd<0)=NaN;
% cas_Nd(index1,:)=NaN;
Castot=sum(cas_Nd,2);
 binmid=[0.575;0.645;0.715;0.785;0.855;0.925;0.995;1.065;1.135;1.21;1.375;1.75;2.25;2.75;3.25;3.75;4.5;5.75;6.85;7.55;9.05;11.35;13.75;17.5;22.5;27.5;32.5;37.5;42.5;47.5];
 bindd=[0.07;0.07;0.07;0.07;0.07;0.14;0.07;0.07;0.07;0.08;0.25;0.5;0.5;0.5;0.5;0.5;1;1.5;0.7;0.7;2.3;2.3;2.5;5;5;5;5;5;5;5];
 binmin=[0.54;0.61;0.68;0.75;0.82;0.89;0.96;1.03;1.10;1.17;1.25;1.5;2.0;2.5;3;3.5;4;5;6.5;7.2;7.9;10.2;12.5;15;20;25;30;35;40;45];
 binmax=[0.61;0.68;0.75;0.82;0.89;0.96;1.03;1.10;1.17;1.25;1.5;2.0;2.5;3.0;3.5;4;5;6.5;7.2;7.9;10.2;12.5;15;20;25;30;35;40;45;50];
% binmin=[3;3.5;4;5;6.5;7.2;7.9;10.2;12.5;15;20;25;30;35;40;45];
% binmid=[3.25;3.75;4.5;5.75;6.85;7.55;9.05;11.35;13.75;17.5;22.5;27.5;32.5;37.5;42.5;47.5];
% binmax=[3.5;4;5;6.5;7.2;7.9;10.2;12.5;15;20;25;30;35;40;45;50];
% bindd=[0.5;0.5;1;1.5;0.7;0.7;2.3;2.3;2.5;5;5;5;5;5;5;5];

%% %-----CAS and summary files have different start/end time-----%
if timevec(1)>timevec_cas(1);
    new_cas_start=find(timevec_cas==timevec(1));
    cas_Nt_summary=cas_Nt(new_cas_start:end);
    altitude_cas=altitude;
    latitude_cas=latitude;
    king_lwc_cas=king_lwc;
    
    if timevec(end)>timevec_cas(end);
        new_summary_end=find(timevec==timevec_cas(end));
        altitude_cas=altitude(1:new_summary_end);
        latitude_cas=latitude(1:new_summary_end);
        king_lwc_cas=king_lwc(1:new_summary_end);
    else
        new_cas_end=find(timevec_cas==timevec(end));
        cas_Nt_summary=cas_Nt(new_cas_start:new_cas_end);
    end
else
    new_summary_start=find(timevec==timevec_cas(1));
    altitude_cas=altitude(new_summary_start:end);
    latitude_cas=latitude(new_summary_start:end);
    king_lwc_cas=king_lwc(new_summary_start:end);
    cas_Nt_summary=cas_Nt;
    
    if timevec(end)>timevec_cas(end);
        new_summary_end=find(timevec==timevec_cas(end));
        altitude_cas=altitude(new_summary_start:new_summary_end);
        latitude_cas=latitude(new_summary_start:new_summary_end);
        king_lwc_cas=king_lwc(new_summary_start:new_summary_end);
    else
        new_cas_end=find(timevec_cas==timevec(end));
        cas_Nt_summary=cas_Nt(1:new_cas_end);
    end
end
%% %-----Sawtooth Timesteps (corresponding to IWG1 file)-----%

%-----Sawtooth Timesteps (corresponding to summary file)-----%
eval(sprintf('sawtooth_timesteps_%04d;',str2double(datestr(timevec(1),'mmdd'))));
%% %-----Plot variables-----%


for k=2;
    figure;
    subplot(1,3,1:2);
eval(sprintf('index=sawtooth_%d_cas;',k));
binwidth=repmat(bindd',length(cas_Nd),1);
cas_Ndf=cas_Nd./binwidth;

%  scatter(timevec_cas(index),altitude_cas(index),30,cas_Nt_summary(index),'Filled');
 hold all
% scatter(timevec_cas(index),altitude_cas(index),30,Castot(index),'Filled');
% cas_Ndf(cas_Ndf<10)=NaN;

% h=contourf(binmid,altitude_cas(6979:7095),cas_Ndf(6979:7095,:));
h1=pcolor(binmin,altitude_cas(index),log10(cas_Ndf(index,:)));
 
% h1=surf(binmin,latitude_cas(index),cas_Ndf(index,:));
colormap;
set(h1, 'EdgeColor', 'k');
h=colorbar;
% caxis([0 2]);
xlim([0.54 50]);
set(gca,'XScale','log');
%  ylim([500 1200]);
h.Label.String='log_{10}N(D) (cm^-3 \mum^-1)';
h.Label.FontSize=20;

%-----Plot Cosmetics-----%
 eval(sprintf('title(''CAS Droplet Size Distribution - Sawtooth %d Leg 2d - %6s'');',k,datestr(timevec_cas(1),2)));
xlabel('Diameter (\mum)','FontSize',20);
ylabel('Altitude (m)','FontSize',20);
set(gca,'FontSize',20);
% ylim([500 900]);
end

% clearvars sawtooth* level*

%-----Saving plot-----%
% fig=gcf;
% set(gcf,'PaperUnits','centimeters','PaperPosition',[0 0 60 40])
% saveas(gcf,['oracles_' sprintf('%s',datestr(timevec(1),'yyyymmdd')) '_sawtooth2d_casNd_altitude_3.jpeg']);