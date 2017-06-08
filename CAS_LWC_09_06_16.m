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
king_lwc=netcdf.getVar(b,36);
temp = netcdf.getVar(b,9);
pres = netcdf.getVar(b,10);

%-----Read variables from CAS file-----% Sets limit on particle size
 cas_Nt=netcdf.getVar(ncid,41); % 3 to 50 microns
% cas_limit=10;
% index1=find(cas_Nt<cas_limit);
%% %-----Calculate CAS LWC from CAS size distribution-----%

%-----Put bin concentrations into size distribution matrix-----%
% channels=16;
channels=29;
cas_Nd=zeros(numel(timevec_cas),channels);
 for k=10:38;
% for k=23:38;
     eval(sprintf('cas_Nd(:,%d-9)=netcdf.getVar(ncid,%d);',k,k));
%     eval(sprintf('cas_Nd(:,%d-22)=netcdf.getVar(ncid,%d);',k,k));
end
% cas_Nd(index1,:)=NaN;
binmid=[0.645;0.715;0.785;0.855;0.925;0.995;1.065;1.135;1.21;1.375;1.75;2.25;2.75;3.25;3.75;4.5;5.75;6.85;7.55;9.05;11.35;13.75;17.5;22.5;27.5;32.5;37.5;42.5;47.5];

%  binmid=[0.575;0.645;0.715;0.785;0.855;0.925;0.995;1.065;1.135;1.21;1.375;1.75;2.25;2.75;3.25;3.75;4.5;5.75;6.85;7.55;9.05;11.35;13.75;17.5;22.5;27.5;32.5;37.5;42.5;47.5];
% binmid=[3.25;3.75;4.5;5.75;6.85;7.55;9.05;11.35;13.75;17.5;22.5;27.5;32.5;37.5;42.5;47.5];

%-----CAS LWC calculation-----%
cas_lwc_bin=zeros(numel(timevec_cas),numel(binmid));
cas_lwc=zeros(numel(timevec_cas),numel(binmid));
binmid3=power(binmid,3);

for k=1:numel(timevec_cas);
    for i=1:numel(binmid);
    cas_lwc_bin(k,i)=pi/6.*cas_Nd(k,i).*binmid3(i);
    end
cas_lwc=sum(cas_lwc_bin,2)./1000000;
end

%-----Remove CAS LWC noise-----%

% cas_lwc(cas_lwc<0.05)=NaN;
%% %-----CAS and summary files have different start/end time-----%
if timevec(1)>timevec_cas(1);
    new_cas_start=find(timevec_cas==datenum(datestr(timevec(1))));
    cas_Nt_summary=cas_Nt(new_cas_start:end);
    cas_lwc_summary=cas_lwc(new_cas_start:end);
    altitude_cas=altitude;
    king_lwc_cas=king_lwc;
    temp_cas=temp;
    pres_cas=pres;
    
    if timevec(end)>timevec_cas(end);
        new_summary_end=find(timevec==datenum(datestr(timevec_cas(end))));
        altitude_cas=altitude(1:new_summary_end);
        king_lwc_cas=king_lwc(1:new_summary_end);
        temp_cas=temp(1:new_summary_end);
        pres_cas=pres(1:new_summary_end);
    else
        new_cas_end=find(timevec_cas==datenum(datestr(timevec(end))));
        cas_Nt_summary=cas_Nt(new_cas_start:new_cas_end);
        cas_lwc_summary=cas_lwc(new_cas_start:new_cas_end);
    end
else
    new_summary_start=find(timevec==datenum(datestr(timevec_cas(1))));
    altitude_cas=altitude(new_summary_start:end);
    king_lwc_cas=king_lwc(new_summary_start:end);
    temp_cas=temp(new_summary_start:end);
    pres_cas=pres(new_summary_start:end);
    cas_Nt_summary=cas_Nt;
    cas_lwc_summary=cas_lwc;
    
    if timevec(end)>timevec_cas(end);
        new_summary_end=find(timevec==datenum(datestr(timevec_cas(end))));
        altitude_cas=altitude(new_summary_start:new_summary_end);
        king_lwc_cas=king_lwc(new_summary_start:new_summary_end);
        temp_cas=temp(new_summary_start:new_summary_end);
        pres_cas=pres(new_summary_start:new_summary_end);
    else
        new_cas_end=find(timevec_cas==datenum(datestr(timevec(end))));
        cas_Nt_summary=cas_Nt(1:new_cas_end);
        cas_lwc_summary=cas_lwc(1:new_cas_end);
    end
end




new_summary_start=555;
% %
% % % sawtooth_1_offset=21;
% % % sawtooth_2_offset=22;
% % % sawtooth_3_offset=22;
% % % sawtooth_4_offset=23;
%

sawtooth_1_cas=7532-new_summary_start:8212-new_summary_start;


sawtooth_2_cas=12622-new_summary_start:13292-new_summary_start;


sawtooth_3_cas=15942-new_summary_start:16842-new_summary_start;


sawtooth_4_cas=23662-new_summary_start:24422-new_summary_start;
CASLWC1 = cas_lwc(sawtooth_1_cas);
altitude1 =altitude_cas(sawtooth_1_cas);
timesaw1 =timevec_cas(sawtooth_1_cas);
CASLWC2 = cas_lwc(sawtooth_2_cas);
altitude2 =altitude_cas(sawtooth_2_cas);
timesaw2 =timevec_cas(sawtooth_2_cas);
CASLWC3 = cas_lwc(sawtooth_3_cas);
altitude3 =altitude_cas(sawtooth_3_cas);
timesaw3 =timevec_cas(sawtooth_3_cas);
CASLWC4 = cas_lwc(sawtooth_4_cas);
altitude4 =altitude_cas(sawtooth_4_cas);
timesaw4 =timevec_cas(sawtooth_4_cas);

%  scatter(timesaw1, altitude1,30,CASLWC1,'filled')
% hold all
%   scatter(timesaw2, altitude2,30,CASLWC2,'filled')
% 
% scatter(timesaw3, altitude3,30,CASLWC3,'filled')
% 
 scatter(timesaw4, altitude4,30,CASLWC4,'filled')
 cl = colorbar;
 cl.Label.String = 'CAS LWC (g/m^3)';

ylabel ('Altitude (m)')
xlabel ('Time (UTC)')

 title ('CAS LWC Sawtooth 4 09/06/2016')
datetick('x','HH:MM:SS');
datetick('x','HH:MM:SS','keepticks');


% scatter(timevec_cas, altitude_cas,30,cas_lwc,'filled')
%  cl = colorbar;
%  cl.Label.String = 'CAS LWC (g/m^3)';
% 
% ylabel ('Altitude (m)')
% xlabel ('Time (UTC)')
% 
%  title ('CAS LWC 09/06/2016')
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
% eval(sprintf('sawtooth%d_index1=find(king_lwc_cas>0.1);',k));
% eval(sprintf('index2=intersect(sawtooth%d_index1,sawtooth_%d_cas);',k,k));
% [cloud_top,p1]=max(altitude_cas(index2));
% [cloud_base,p2]=min(altitude_cas(index2));
% cloud_alt=find(altitude_cas<cloud_top & altitude_cas>cloud_base);
% 
% eval(sprintf('scatter(cas_lwc_summary(sawtooth_%da_cas),altitude_cas(sawtooth_%da_cas),20,''Filled'');',k,k));
% eval(sprintf('scatter(cas_lwc_summary(sawtooth_%db_cas),altitude_cas(sawtooth_%db_cas),20,''Filled'');',k,k));
% eval(sprintf('scatter(cas_lwc_summary(sawtooth_%dc_cas),altitude_cas(sawtooth_%dc_cas),20,''Filled'');',k,k));
% eval(sprintf('scatter(cas_lwc_summary(sawtooth_%dd_cas),altitude_cas(sawtooth_%dd_cas),20,''Filled'');',k,k));
% eval(sprintf('scatter(cas_lwc_summary(sawtooth_%de_cas),altitude_cas(sawtooth_%de_cas),20,''Filled'');',k,k));
% 
% eval(sprintf('x1=0:1:length(timevec_cas(sawtooth_%d_cas));',k));
% eval(sprintf('h1=line(''XData'',x1,''YData'',ones(length(timevec_cas(sawtooth_%d_cas))+1,1)*cloud_top);',k));
% eval(sprintf('h2=line(''XData'',x1,''YData'',ones(length(timevec_cas(sawtooth_%d_cas))+1,1)*cloud_base);',k));
% set(h1,'LineStyle','--');
% set(h2,'LineStyle','--');
% set(h1,'Color','b');
% set(h2,'Color','b');
% 
% %-----Plot settings-----%
% eval(sprintf('title(''Sawtooth %d'');',k));
% xlabel('CAS LWC (g/m^3)','FontSize',20);
% ylabel('Altitude (m)','FontSize',20);
% set(gca,'fontsize',20)
% eval(sprintf('legend(''%da'',''%db'',''%dc'',''%dd'',''%de'',''Location'',''SouthEast'')',k,k,k,k,k));
% ylim([0 1200])
% xlim([0 1.2])
% end
% % text(-3,1280,sprintf('CAS Liquid Water Content (CAS: 3-50um > %d/cc) - Sawtooth Comparison - %6s',cas_limit,datestr(timevec_cas(1),2)),'FontSize',20);
% 
% %-----Plot 4 variables-----%
% for k=4;
% eval(sprintf('subplot(1,4,%d)',k));
% hold on
% 
% eval(sprintf('sawtooth%d_index1=find(king_lwc_cas>0.1);',k));
% eval(sprintf('index2=intersect(sawtooth%d_index1,sawtooth_%d_cas);',k,k));
% [cloud_top,p1]=max(altitude_cas(index2));
% [cloud_base,p2]=min(altitude_cas(index2));
% cloud_alt=find(altitude_cas<cloud_top & altitude_cas>cloud_base);
% 
% eval(sprintf('scatter(cas_lwc_summary(sawtooth_%da_cas),altitude_cas(sawtooth_%da_cas),20,''Filled'');',k,k));
% eval(sprintf('scatter(cas_lwc_summary(sawtooth_%db_cas),altitude_cas(sawtooth_%db_cas),20,''Filled'');',k,k));
% eval(sprintf('scatter(cas_lwc_summary(sawtooth_%dc_cas),altitude_cas(sawtooth_%dc_cas),20,''Filled'');',k,k));
% eval(sprintf('scatter(cas_lwc_summary(sawtooth_%dd_cas),altitude_cas(sawtooth_%dd_cas),20,''Filled'');',k,k));
% eval(sprintf('scatter(cas_lwc_summary(sawtooth_%de_cas),altitude_cas(sawtooth_%de_cas),20,''Filled'');',k,k));
% eval(sprintf('scatter(cas_lwc_summary(sawtooth_%df_cas),altitude_cas(sawtooth_%df_cas),20,''Filled'');',k,k));
% 
% eval(sprintf('x1=0:1:length(timevec_cas(sawtooth_%d_cas));',k));
% eval(sprintf('h1=line(''XData'',x1,''YData'',ones(length(timevec_cas(sawtooth_%d_cas))+1,1)*cloud_top);',k));
% eval(sprintf('h2=line(''XData'',x1,''YData'',ones(length(timevec_cas(sawtooth_%d_cas))+1,1)*cloud_base);',k));
% set(h1,'LineStyle','--');
% set(h2,'LineStyle','--');
% set(h1,'Color','b');
% set(h2,'Color','b');
% 
% %-----Plot settings-----%
% eval(sprintf('title(''Sawtooth %d'');',k));
% xlabel('CAS LWC (g/m^3)','FontSize',20);
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
% saveas(gcf,['oracles_' sprintf('%s',datestr(timevec(1),'yyyymmdd')) '_sawtooth1-4_casLWC_altitude.jpeg']);