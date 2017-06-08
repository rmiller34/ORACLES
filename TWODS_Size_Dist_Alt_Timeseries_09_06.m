%-----Read variables from ORACLES Summary file and IWG1 File-----%
ncid=netcdf.open('16_09_06_06_40_17.2DS_H.conc.1Hz.nc');
b=netcdf.open('16_09_06_06_40_17.Combined.oracles.nc');

%-----Read Unix time and convert to timevec for CAS file-----%
base_time_twods=netcdf.getVar(ncid,7);
time_offset_twods=netcdf.getVar(ncid,8);
offset_twods=[0:numel(time_offset_twods)-1]';
base_seconds_twods=offset_twods+double(base_time_twods);
timevec_twods=unix_to_timevec(base_seconds_twods);

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
Twods_Nt=netcdf.getVar(ncid,41); % 3 to 50 microns
% cas_Nt(cas_Nt>10000)=NaN;
% cas_limit=10;
% index1=find(cas_Nt<cas_limit);
%% %-----Calculate TWODS LWC from CAS size distribution-----%

%-----Put bin concentrations into size distribution matrix-----%

channels=29;
Twods_Nd=zeros(numel(timevec_twods),channels);
 for k=9:37;

     eval(sprintf('Twods_Nd(:,%d-8)=netcdf.getVar(ncid,%d);',k,k));

end
Twods_Nd(Twods_Nd<0)=NaN;
Twods_Nd= Twods_Nd .*10^-12;
Twods_Ndtot= sum(Twods_Nd,2);
binmid=[10;20;30;40;50;60;70;80;90;100;115;135;160;200;250;300;362.5;437.5;512.5;587.5;662.5;750;850;950;1100;1300;1500;1700;1900];
bindd =[10;10;10;10;10;10;10;10;10;10;20;20;30;50;50;50;75;75;75;75;75;100;100;100;200;200;200;200;200];
binmin=[5;15;25;35;45;55;65;75;85;95;105;125;145;175;225;275;325;400;475;550;625;700;800;900;1000;1200;1400;1600;1800];
binmax=[15;25;35;45;55;65;75;85;95;105;125;145;175;225;275;325;400;475;550;625;700;800;900;1000;1200;1400;1600;1800;2000];
 
% binmid=[10;20;30;40;50;60;70;80;90;100;115;135;160;200;250;300;362.5;437.5;512.5;587.5;662.5;750;850;950;1100;1300;1500;1700;1900];
% bindd =[10;10;10;10;10;10;10;10;10;10;20;20;30;50;50;50;75;75;75;75;75;100;100;100;200;200;200;200;200];
% binmin=[5;15;25;35;45;55;65;75;85;95;105;125;145;175;225;275;325;400;475;550;625;700;800;900;1000;1200;1400;1600;1800];
% binmax=[15;25;35;45;55;65;75;85;95;105;125;145;175;225;275;325;400;475;550;625;700;800;900;1000;1200;1400;1600;1800;2000];
 


%% %-----TwoDS and summary files have different start/end time-----%
if timevec(1)>timevec_twods(1);
    new_twods_start=find(timevec_twods==timevec(1));
    Twods_Nt_summary=Twods_Nt(new_twods_start:end);
    Twods_Ndtot_summary=Twods_Ndtot(new_twods_start:end);
    altitude_twods=altitude;
    latitude_twods=latitude;
    
    if timevec(end)>timevec_twods(end);
        new_summary_end=find(timevec==timevec_twods(end));
        altitude_twods=altitude(1:new_summary_end);
        latitude_twods=latitude(1:new_summary_end);
    else
        new_twods_end=find(timevec_twods==timevec(end));
        Twods_Nt_summary=Twods_Nt(new_twods_start:new_twods_end);
        Twods_Ndtot_summary=Twods_Ndtot(new_twods_start:new_twods_end);
    end
else
    new_summary_start=find(timevec==timevec_twods(1));
    altitude_twods=altitude(new_summary_start:end);
    latitude_twods=latitude(new_summary_start:end);
    Twods_Nt_summary=Twods_Nt;
    Twods_Ndtot_summary=Twods_Ndtot;
    
    if timevec(end)>timevec_twods(end);
        new_summary_end=find(timevec==timevec_twods(end));
        altitude_twods=altitude(new_summary_start:new_summary_end);
        latitude_twods=latitude(new_summary_start:new_summary_end);
    else
        new_twods_end=find(timevec_twods==timevec(end));
        Twods_Nt_summary=Twods_Nt(1:new_twods_end);
        Twods_Ndtot_summary=Twods_Ndtot(1:new_twods_end);
    end
end
%% %-----Sawtooth Timesteps (corresponding to IWG1 file)-----%

%-----Sawtooth Timesteps (corresponding to summary file)-----%
eval(sprintf('sawtooth_timesteps_%04d;',str2double(datestr(timevec(1),'mmdd'))));
%% %-----Plot variables-----%


Twods_Nd=Twods_Nd(23:end,:);
Twods_Ndtot_summary=Twods_Ndtot_summary(23:end);
% timevec=timevec(23:end);
% altitude_twods=altitude_twods(23:end);
for k=2;
    figure;
     subplot(1,3,1:2);
eval(sprintf('index=sawtooth_%d_twods;',k));
binwidth=repmat(bindd',length(Twods_Nd),1);
Twods_Ndf=Twods_Nd./binwidth;

% scatter(timevec(index),altitude_twods(index),30,Twods_Ndtot_summary(index),'Filled');
%  plot(timevec(index),altitude_cas(index));
h1=pcolor(binmin,altitude_twods(index),log10(Twods_Ndf(index,:)));

% h1=surf(binmin,latitude_cas(index),cas_Ndf(index,:));
colormap;
set(h1, 'EdgeColor', 'k');
h=colorbar;
% caxis([0 2]);
xlim([5 2000]);
set(gca,'XScale','log');
% ylim([500 1200]);
h.Label.String='log_{10}N(D) (cm^-3 \mum^-1)';
h.Label.FontSize=20;

%-----Plot Cosmetics-----%
 eval(sprintf('title(''TwoDS Droplet Size Distribution - Sawtooth %d Leg 2d - %6s'');',k,datestr(timevec_twods(1),2)));
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