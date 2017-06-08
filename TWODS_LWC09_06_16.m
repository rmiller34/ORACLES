%-----Read variables from ORACLES Summary file and IWG1 File-----%
ncid=netcdf.open('16_09_06_06_40_17.2DS_H.conc.1Hz.nc');
b=netcdf.open('16_09_06_06_40_17.Combined.oracles.nc');

%-----Read Unix time and convert to timevec for twods file-----%
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
king_lwc=netcdf.getVar(b,36);
temp = netcdf.getVar(b,9);
pres = netcdf.getVar(b,10);

%-----Read variables from twods file-----% Sets limit on particle size
twods_Nt=netcdf.getVar(ncid,40); % 3 to 50 microns
% twods_limit=10;
% index1=find(twods_Nt<twods_limit);
%% %-----Calculate twods LWC from twods size distribution-----%

%-----Put bin concentrations into size distribution matrix-----%
% channels=16;
channels=29;
TwoDS_Nd=zeros(numel(timevec_twods),channels);
for k=9:37;
    
    eval(sprintf('TwoDS_Nd(:,%d-8)=netcdf.getVar(ncid,%d);',k,k));
    
end

TwoDS_Nd= TwoDS_Nd .*10^-12;
binmid=[10;20;30;40;50;60;70;80;90;100;115;135;160;200;250;300;362.5;437.5;512.5;587.5;662.5;750;850;950;1100;1300;1500;1700;1900];

%-----twods LWC calculation-----%
twods_lwc_bin=zeros(numel(timevec_twods),numel(binmid));
twods_lwc=zeros(numel(timevec_twods),numel(binmid));
binmid3=power(binmid,3);

for k=1:numel(timevec_twods);
    for i=1:numel(binmid);
        twods_lwc_bin(k,i)=pi/6.*TwoDS_Nd(k,i).*binmid3(i);
    end
    twods_lwc=sum(twods_lwc_bin,2)./1000000;
end
twods_lwc(twods_lwc<0)=NaN;
% twods_lwc(twods_lwc<0.1)=NaN;
% twods_lwc(twods_lwc>4)=NaN;

%% %-----twods and summary files have different start/end time-----%
if timevec(1)>timevec_twods(1);
    new_twods_start=find(timevec_twods==datenum(datestr(timevec(1))));
    twods_Nt_summary=twods_Nt(new_twods_start:end);
    twods_lwc_summary=twods_lwc(new_twods_start:end);
    altitude_twods=altitude;
    king_lwc_twods=king_lwc;
    temp_twods=temp;
    pres_twods=pres;
    
    if timevec(end)>timevec_twods(end);
        new_summary_end=find(timevec==datenum(datestr(timevec_twods(end))));
        altitude_twods=altitude(1:new_summary_end);
        king_lwc_twods=king_lwc(1:new_summary_end);
        temp_twods=temp(1:new_summary_end);
        pres_twods=pres(1:new_summary_end);
    else
        new_twods_end=find(timevec_twods==datenum(datestr(timevec(end))));
        twods_Nt_summary=twods_Nt(new_twods_start:new_twods_end);
        twods_lwc_summary=twods_lwc(new_twods_start:new_twods_end);
    end
else
    new_summary_start=find(timevec==datenum(datestr(timevec_twods(1))));
    altitude_twods=altitude(new_summary_start:end);
    king_lwc_twods=king_lwc(new_summary_start:end);
    temp_twods=temp(new_summary_start:end);
    pres_twods=pres(new_summary_start:end);
    twods_Nt_summary=twods_Nt;
    twods_lwc_summary=twods_lwc;
    
    if timevec(end)>timevec_twods(end);
        new_summary_end=find(timevec==datenum(datestr(timevec_twods(end))));
        altitude_twods=altitude(new_summary_start:new_summary_end);
        king_lwc_twods=king_lwc(new_summary_start:new_summary_end);
        temp_twods=temp(new_summary_start:new_summary_end);
        pres_twods=pres(new_summary_start:new_summary_end);
    else
        new_twods_end=find(timevec_twods==datenum(datestr(timevec(end))));
        twods_Nt_summary=twods_Nt(1:new_twods_end);
        twods_lwc_summary=twods_lwc(1:new_twods_end);
    end
end

twods_lwc=twods_lwc(23:end);
new_twods_start=2;


sawtooth_1_twods=7532+(new_twods_start-1):8212+(new_twods_start-1);

sawtooth_2a_twods=12622+(new_twods_start-1):12752+(new_twods_start-1);
sawtooth_2b_twods=12752+(new_twods_start-1):12892+(new_twods_start-1);
sawtooth_2c_twods=12892+(new_twods_start-1):13022+(new_twods_start-1);
sawtooth_2d_twods=13022+(new_twods_start-1):13152+(new_twods_start-1);
sawtooth_2e_twods=13152+(new_twods_start-1):13292+(new_twods_start-1);
sawtooth_2_twods=12622+(new_twods_start-1):13292+(new_twods_start-1);


sawtooth_3_twods=15942+(new_twods_start-1):16842+(new_twods_start-1);


sawtooth_4_twods=23662+(new_twods_start-1):24422+(new_twods_start-1);

twodsLWC1 = twods_lwc(sawtooth_1_twods);
altitude1 =altitude_twods(sawtooth_1_twods);
timesaw1 =timevec_twods(sawtooth_1_twods);
twodsLWC2 = twods_lwc(sawtooth_2_twods);
altitude2 =altitude_twods(sawtooth_2_twods);
timesaw2 =timevec_twods(sawtooth_2_twods);
twodsLWC3 = twods_lwc(sawtooth_3_twods);
altitude3 =altitude_twods(sawtooth_3_twods);
timesaw3 =timevec_twods(sawtooth_3_twods);
twodsLWC4 = twods_lwc(sawtooth_4_twods);
altitude4 =altitude_twods(sawtooth_4_twods);
timesaw4 =timevec_twods(sawtooth_4_twods);



%   scatter(timesaw1, altitude1,30,twodsLWC1,'filled')
% hold all
   scatter(timesaw2, altitude2,30,twodsLWC2,'filled')
%
%     scatter(timesaw3, altitude3,30,twodsLWC3,'filled')
%
%   scatter(timesaw4, altitude4,30,twodsLWC4,'filled')
%   scatter(timesaw5, altitude5,30,twodsLWC5,'filled')
%   scatter(timesaw6, altitude6,30,twodsLWC6,'filled')
%   scatter(timesaw7, altitude7,30,twodsLWC7,'filled')
%     scatter(timesaw8, altitude8,30,twodsLWC8,'filled')

%         
cl = colorbar;
cl.Label.String = 'Twods LWC (g/m^3)';

ylabel ('Altitude (m)')
xlabel ('Time (UTC)')

title ('Twods LWC Sawtooth 2 09/06/2016')
datetick('x','HH:MM:SS');
datetick('x','HH:MM:SS','keepticks');


% scatter(timevec, altitude_twods,30,twods_lwc_summary,'filled')
%  cl = colorbar;
%  cl.Label.String = 'twods LWC (g/m^3)';
% 
% ylabel ('Altitude (m)')
% xlabel ('Time (UTC)')
% 
%  title ('twods LWC 09/06/2016')
% datetick('x','HH:MM:SS');
% datetick('x','HH:MM:SS','keepticks');


%% %-----Sawtooth Timesteps (corresponding to IWG1 file)-----%

% eval(sprintf('sawtooth_timesteps_%04d;',str2double(datestr(timevec(1),'mmdd'))));
% %% %-----Plot 1-3 variables-----%
%
% for k=1:3;
% eval(sprintf('subplot(1,4,%d)',k));
% hold on
%
% eval(sprintf('sawtooth%d_index1=find(king_lwc_twods>0.1);',k));
% eval(sprintf('index2=intersect(sawtooth%d_index1,sawtooth_%d_twods);',k,k));
% [cloud_top,p1]=max(altitude_twods(index2));
% [cloud_base,p2]=min(altitude_twods(index2));
% cloud_alt=find(altitude_twods<cloud_top & altitude_twods>cloud_base);
%
% eval(sprintf('scatter(twods_lwc_summary(sawtooth_%da_twods),altitude_twods(sawtooth_%da_twods),20,''Filled'');',k,k));
% eval(sprintf('scatter(twods_lwc_summary(sawtooth_%db_twods),altitude_twods(sawtooth_%db_twods),20,''Filled'');',k,k));
% eval(sprintf('scatter(twods_lwc_summary(sawtooth_%dc_twods),altitude_twods(sawtooth_%dc_twods),20,''Filled'');',k,k));
% eval(sprintf('scatter(twods_lwc_summary(sawtooth_%dd_twods),altitude_twods(sawtooth_%dd_twods),20,''Filled'');',k,k));
% eval(sprintf('scatter(twods_lwc_summary(sawtooth_%de_twods),altitude_twods(sawtooth_%de_twods),20,''Filled'');',k,k));
%
% eval(sprintf('x1=0:1:length(timevec_twods(sawtooth_%d_twods));',k));
% eval(sprintf('h1=line(''XData'',x1,''YData'',ones(length(timevec_twods(sawtooth_%d_twods))+1,1)*cloud_top);',k));
% eval(sprintf('h2=line(''XData'',x1,''YData'',ones(length(timevec_twods(sawtooth_%d_twods))+1,1)*cloud_base);',k));
% set(h1,'LineStyle','--');
% set(h2,'LineStyle','--');
% set(h1,'Color','b');
% set(h2,'Color','b');
%
% %-----Plot settings-----%
% eval(sprintf('title(''Sawtooth %d'');',k));
% xlabel('twods LWC (g/m^3)','FontSize',20);
% ylabel('Altitude (m)','FontSize',20);
% set(gca,'fontsize',20)
% eval(sprintf('legend(''%da'',''%db'',''%dc'',''%dd'',''%de'',''Location'',''SouthEast'')',k,k,k,k,k));
% ylim([0 1200])
% xlim([0 1.2])
% end
% % text(-3,1280,sprintf('twods Liquid Water Content (twods: 3-50um > %d/cc) - Sawtooth Comparison - %6s',twods_limit,datestr(timevec_twods(1),2)),'FontSize',20);
%
% %-----Plot 4 variables-----%
% for k=4;
% eval(sprintf('subplot(1,4,%d)',k));
% hold on
%
% eval(sprintf('sawtooth%d_index1=find(king_lwc_twods>0.1);',k));
% eval(sprintf('index2=intersect(sawtooth%d_index1,sawtooth_%d_twods);',k,k));
% [cloud_top,p1]=max(altitude_twods(index2));
% [cloud_base,p2]=min(altitude_twods(index2));
% cloud_alt=find(altitude_twods<cloud_top & altitude_twods>cloud_base);
%
% eval(sprintf('scatter(twods_lwc_summary(sawtooth_%da_twods),altitude_twods(sawtooth_%da_twods),20,''Filled'');',k,k));
% eval(sprintf('scatter(twods_lwc_summary(sawtooth_%db_twods),altitude_twods(sawtooth_%db_twods),20,''Filled'');',k,k));
% eval(sprintf('scatter(twods_lwc_summary(sawtooth_%dc_twods),altitude_twods(sawtooth_%dc_twods),20,''Filled'');',k,k));
% eval(sprintf('scatter(twods_lwc_summary(sawtooth_%dd_twods),altitude_twods(sawtooth_%dd_twods),20,''Filled'');',k,k));
% eval(sprintf('scatter(twods_lwc_summary(sawtooth_%de_twods),altitude_twods(sawtooth_%de_twods),20,''Filled'');',k,k));
% eval(sprintf('scatter(twods_lwc_summary(sawtooth_%df_twods),altitude_twods(sawtooth_%df_twods),20,''Filled'');',k,k));
%
% eval(sprintf('x1=0:1:length(timevec_twods(sawtooth_%d_twods));',k));
% eval(sprintf('h1=line(''XData'',x1,''YData'',ones(length(timevec_twods(sawtooth_%d_twods))+1,1)*cloud_top);',k));
% eval(sprintf('h2=line(''XData'',x1,''YData'',ones(length(timevec_twods(sawtooth_%d_twods))+1,1)*cloud_base);',k));
% set(h1,'LineStyle','--');
% set(h2,'LineStyle','--');
% set(h1,'Color','b');
% set(h2,'Color','b');
%
% %-----Plot settings-----%
% eval(sprintf('title(''Sawtooth %d'');',k));
% xlabel('twods LWC (g/m^3)','FontSize',20);
% ylabel('Altitude (m)','FontSize',20);
% set(gca,'fontsize',20)
% eval(sprintf('legend(''%da'',''%db'',''%dc'',''%dd'',''%de'',''%df'',''Location'',''NorthEast'')',k,k,k,k,k,k));
% ylim([0 1200])
% xlim([0 1.2])
% end
%
% clearvars sawtooth*

%-----Saving plot-----%
% fig=gcf;
% set(gcf,'PaperUnits','centimeters','PaperPosition',[0 0 60 40])
% saveas(gcf,['oracles_' sprintf('%s',datestr(timevec(1),'yyyymmdd')) '_sawtooth1-4_twodsLWC_altitude.jpeg']);