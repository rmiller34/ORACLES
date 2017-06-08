%-----Read variables from ORACLES Summary file and IWG1 File-----%
ncid=netcdf.open('16_09_06_06_40_17.HVPS3_H.conc.1hz.nc');
b=netcdf.open('16_09_06_06_40_17.Combined.oracles.nc');




%-----Read Unix time and convert to timevec for twods file-----%
base_time_twods=netcdf.getVar(ncid,7);
time_offset_twods=netcdf.getVar(ncid,8);
offset_twods=[0:numel(time_offset_twods)-1]';
base_seconds_twods=offset_twods+double(base_time_twods);
timevec_twods=unix_to_timevec(base_seconds_twods);
% Q = netcdf.getVar(ncid,36); %Ch 26
% R = netcdf.getVar(ncid,37); %Ch 27
% S =netcdf.getVar(ncid,38); %Ch 28
% T= netcdf.getVar(ncid,39); %Ch 29
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

% Channel_26_29= [T];
twods_Nt=netcdf.getVar(ncid,28); % 3 to 50 microns
% twods_limit=10;
% index1=find(twods_Nt<twods_limit);
sawtooth_timesteps_0906;
%% %-----Calculate twods LWC from twods size distribution-----%

%-----Put bin concentrations into size distribution matrix-----%
% channels=16;
channels=28;
TwoDS_Nd=zeros(numel(timevec_twods),channels);
for k=9:36;
    
    eval(sprintf('TwoDS_Nd(:,%d-8)=netcdf.getVar(ncid,%d);',k,k));
    
end

TwoDS_Nd= TwoDS_Nd .*10^-12;
binmid=[300;500;700;900;1100;1300;1500;1700;2000;2400;2800;3200;3600;4000;4400;4800;5500;6500;7500;8500;9500;11000;13000;15000;17000;19000;22500;27500];
bindd =[200;200;200;200;200;200;200;200;400;400;400;400;400;400;400;400;1000;1000;1000;1000;1000;2000;2000;2000;2000;2000;5000;5000;];
%-----twods LWC calculation-----%
% does this work? Who knows...
twods_lwc_bin=zeros(numel(timevec_twods),numel(binmid));
twods_lwc=zeros(numel(timevec_twods),numel(binmid));
binmid3=power(binmid,3);

for k=1:numel(timevec_twods);
    for i=1:numel(binmid);
        
        twods_lwc_bin(k,i)=pi/6.*TwoDS_Nd(k,i).*binmid3(i);
    end
    
    %     twods_lwc=sum(twods_lwc_bin,2)./1000000;
end
for i = 1:numel(bindd)
    twods_lwc_cor(:,i)=bindd(i)*twods_lwc_bin(:,i);   %M(D)
end
twods_lwc_cor=twods_lwc_cor./1000000;

sum_bins= sum(twods_lwc_cor);
twods_lwc_new=(twods_lwc_bin);
% twods_lwc(twods_lwc<0)=NaN;
% twods_lwc(twods_lwc>5)=NaN;

%% %-----twods and summary files have different start/end time-----%
if timevec(1)>timevec_twods(1);
    new_twods_start=find(timevec_twods==datenum(datestr(timevec(1))));
    twods_Nt_summary=twods_Nt(new_twods_start:end);
    twods_lwc_summary=twods_lwc_new(new_twods_start:end);
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
        twods_lwc_summary=twods_lwc_new(new_twods_start:new_twods_end);
    end
else
    new_summary_start=find(timevec==datenum(datestr(timevec_twods(1))));
    altitude_twods=altitude(new_summary_start:end);
    king_lwc_twods=king_lwc(new_summary_start:end);
    temp_twods=temp(new_summary_start:end);
    pres_twods=pres(new_summary_start:end);
    twods_Nt_summary=twods_Nt;
    twods_lwc_summary=twods_lwc_new;
    
    if timevec(end)>timevec_twods(end);
        new_summary_end=find(timevec==datenum(datestr(timevec_twods(end))));
        altitude_twods=altitude(new_summary_start:new_summary_end);
        king_lwc_twods=king_lwc(new_summary_start:new_summary_end);
        temp_twods=temp(new_summary_start:new_summary_end);
        pres_twods=pres(new_summary_start:new_summary_end);
    else
        new_twods_end=find(timevec_twods==datenum(datestr(timevec(end))));
        twods_Nt_summary=twods_Nt(1:new_twods_end);
        twods_lwc_summary=twods_lwc_new(1:new_twods_end);
    end
end




new_twods_start=2;


sawtooth_1_twods=7532+(new_twods_start-1):8212+(new_twods_start-1);


sawtooth_2_twods=12622+(new_twods_start-1):13292+(new_twods_start-1);
sawtooth_2d_twods=13022+(new_twods_start-1):13152+(new_twods_start-1);
firsthighsaw2=12791+(new_twods_start-1):12845+(new_twods_start-1);
secondhighsaw2=13053+(new_twods_start-1):13110+(new_twods_start-1);

sawtooth_3_twods=15942+(new_twods_start-1):16842+(new_twods_start-1);


sawtooth_4_twods=23662+(new_twods_start-1):24422+(new_twods_start-1);
% twods_lwc_bin=twods_lwc_bin(23:end);



%  stairs(binmid,twodsLWC1);



% ylabel ('Altitude (m)')
% xlabel ('Time (UTC)')
%
% title ('Twods LWC Sawtooth 4 09/06/2016')



% scatter(timevec_twods, altitude_twods,30,twods_lwc,'filled')
%  cl = colorbar;
%  cl.Label.String = 'twods LWC (g/m^3)';
%
% ylabel ('Altitude (m)')
% xlabel ('Time (UTC)')
%  title ('twods LWC 09/06/2016')
% datetick('x','HH:MM:SS');
% datetick('x','HH:MM:SS','keepticks');
%% -----Size Distribution -----%%

%%TwoDS_Nd
%
Nsum_Nd_1= nanmean(TwoDS_Nd(sawtooth_1_twods,:));
Nsum_Nd_2= nanmean(TwoDS_Nd(sawtooth_2_twods,:));
Nsum_Nd_3= nanmean(TwoDS_Nd(sawtooth_3_twods,:));
Nsum_Nd_4= nanmean(TwoDS_Nd(sawtooth_4_twods,:));

weirdsaw2d=13056+(new_twods_start-1):13153+(new_twods_start-1);
firsthighsaw2=12791+(new_twods_start-1):12845+(new_twods_start-1);
secondhighsaw2=13053+(new_twods_start-1):13110+(new_twods_start-1);
checkcheck=(TwoDS_Nd(sawtooth_2_twods,:));
first2d= nanmean(TwoDS_Nd(firsthighsaw2,:));
second2d=  nanmean(TwoDS_Nd(secondhighsaw2,:));
% Nsum_Nd_1= nanmean(TwoDS_Nd(sawtooth_2a_twods,:));
% Nsum_Nd_2= nanmean(TwoDS_Nd(sawtooth_2b_twods,:));
% Nsum_Nd_3= nanmean(TwoDS_Nd(sawtooth_2c_twods,:));
% Nsum_Nd_4= nanmean(TwoDS_Nd(sawtooth_2d_twods,:));
% Nsum_Nd_5= nanmean(TwoDS_Nd(sawtooth_2e_twods,:));
Nbin_Nd_3=Nsum_Nd_3./bindd';

%  Nbin_Nd_5=Nsum_Nd_5./bindd';
% %
% %


Nbinweird_1=first2d./bindd';
Nbinweird_2=second2d./bindd';

 stairs(binmid,Nbinweird_1);
 hold on
 stairs(binmid,Nbinweird_2);
 stairs(binmid,Nbin_Nd_3);
%
NSum_Nd_Total_2= (TwoDS_Nd(sawtooth_2_twods,:));
% Nsum_Nd_1= (TwoDS_Nd(sawtooth_2a_twods,:));
% Nsum_Nd_2= (TwoDS_Nd(sawtooth_2b_twods,:));
% Nsum_Nd_3= (TwoDS_Nd(sawtooth_2c_twods,:));
% Nsum_Nd_4= (TwoDS_Nd(sawtooth_2d_twods,:));
% Nsum_Nd_5= (TwoDS_Nd(sawtooth_2e_twods,:));
% 
% for i=1:29
%     newtotal2(:,i)=NSum_Nd_Total_2(:,i)/bindd(i);
% end
% 
% for i=1:29
%     newnew1(:,i) =Nsum_Nd_1(:,i)/bindd(i);
% end
% for i=1:29
%     newnew2(:,i) =Nsum_Nd_2(:,i)/bindd(i);
% end
% for i=1:29
%     newnew3(:,i) =Nsum_Nd_3(:,i)/bindd(i);
% end
% for i=1:29
%     newnew4(:,i) =Nsum_Nd_4(:,i)/bindd(i);
% end
% for i=1:29
%     newnew5(:,i) =Nsum_Nd_5(:,i)/bindd(i);
% end

% Sum_total2=nanmean(newtotal2,2);
% Sum_Nd1 = nanmean(newnew1,2);
% Sum_Nd2 = nanmean(newnew2,2);
% Sum_Nd3 = nanmean(newnew3,2);
% Sum_Nd4 = nanmean(newnew4,2);
% Sum_Nd5 = nanmean(newnew5,2);
AltitudeTotal2= (altitude_twods(sawtooth_2_twods,:));
Altitude1= (altitude_twods(sawtooth_2a_twods,:));
Altitude2= (altitude_twods(sawtooth_2b_twods,:));
Altitude3= (altitude_twods(sawtooth_2c_twods,:));
Altitude4= (altitude_twods(sawtooth_2d_twods,:));
Altitude5= (altitude_twods(sawtooth_2e_twods,:));
%
TimeTotal2=(timevec_twods(sawtooth_2_twods,:));
Time1=(timevec_twods(sawtooth_2a_twods,:));
Time2=(timevec_twods(sawtooth_2b_twods,:));
Time3=(timevec_twods(sawtooth_2c_twods,:));
Time4=(timevec_twods(sawtooth_2d_twods,:));
Time5=(timevec_twods(sawtooth_2e_twods,:));
%
Nbin_Nd_1=Nsum_Nd_1./bindd';
Nbin_Nd_2=Nsum_Nd_2./bindd';
Nbin_Nd_3=Nsum_Nd_3./bindd';
Nbin_Nd_4=Nsum_Nd_4./bindd';
%  Nbin_Nd_5=Nsum_Nd_5./bindd';
% %
% %
% stairs(binmid,Nbin_Nd_1);
% hold all
% stairs(binmid,Nbin_Nd_2);
% stairs(binmid,Nbin_Nd_3);
% stairs(binmid,Nbin_Nd_4);
% stairs(binmid,Nbin_Nd_5);
%
%
% test2d=twods_lwc_cor(sawtooth_2d_twods,:);
% Nsum1=nanmean(twods_lwc_cor(sawtooth_1_twods,:));
% Nsum2=nanmean(twods_lwc_cor(sawtooth_2_twods,:));
% Nsum3=nanmean(twods_lwc_cor(sawtooth_3_twods,:));
% Nsum4=nanmean(twods_lwc_cor(sawtooth_4_twods,:));
% % sum_bins_bins=sum(twods_lwc_cor(sawtooth_2d_twods,:));
% Nsum2a=nanmean(twods_lwc_cor(sawtooth_2a_twods,:));
% Nsum2b=nanmean(twods_lwc_cor(sawtooth_2b_twods,:));
% Nsum2c=nanmean(twods_lwc_cor(sawtooth_2c_twods,:));
% Nsum2d=nanmean(twods_lwc_cor(sawtooth_2d_twods,:));
% Nsum2e=nanmean(twods_lwc_cor(sawtooth_2e_twods,:));
%
% % ------ Cumulative Size Dist----%
dat = cumsum(twods_lwc_cor(sawtooth_2d_twods,:));
datass = dat(end,:);
cumA = cumsum(datass);
cumA = cumA/cumA(end);
%  stairs(binmid,cumA);
%
%
% % -----Number distribution function = Number in each bin/bin width-----%
%
% % Nbin1=Nsum1./bindd';
% % Nbin2=Nsum2./bindd';
% % Nbin3=Nsum3./bindd';
% % Nbin4=Nsum4./bindd';
% Nbin2a=Nsum2a./bindd';
% Nbin2b=Nsum2b./bindd';
% Nbin2c=Nsum2c./bindd';
% Nbin2d=Nsum2d./bindd';
% Nbin2e=Nsum2e./bindd';
%
% %
% % stairs(binmid,Nbin1);
% % hold all
% % stairs(binmid,Nbin2);
% % stairs(binmid,Nbin3);
% % stairs(binmid,Nbin4);
% % stairs(binmid,Nbin2a);
% %   hold all
% % stairs(binmid,Nbin2b);
% % stairs(binmid,Nbin2c);
% % stairs(binmid,Nbin2d);
% % stairs(binmid,Nbin2e);
% %
% % % Channel_26_29= [Q+R+S+T];
% % %  scatter(timevec,altitude_twods,30, sa,'Filled')
% subplot(2,3,1)
%  scatter(TimeTotal2,AltitudeTotal2,30,Sum_total2,'Filled')
% title ('TwoDS Size Distribution Total 09/06/2016')
% cl = colorbar;
% cl.Label.String = 'TwoDS Size Distribution (cm^-3 \mum ^-1)';
% ylabel ('Altitude (m)')
% xlabel ('Time (UTC)')
% % title ('TwoDS Size Distribution 09/06/2016')
% datetick('x','HH:MM:SS');
% datetick('x','HH:MM:SS','keepticks');
% subplot(2,3,2)
%    scatter(Time1,Altitude1,30,Sum_Nd1,'Filled');
% title ('TwoDS Size Distribution 2a 09/06/2016')
% cl = colorbar;
% cl.Label.String = 'TwoDS Size Distribution (cm^-3 \mum ^-1)';
% ylabel ('Altitude (m)')
% xlabel ('Time (UTC)')
% % title ('TwoDS Size Distribution 09/06/2016')
% datetick('x','HH:MM:SS');
% datetick('x','HH:MM:SS','keepticks');
% subplot(2,3,3)
%   scatter(Time2,Altitude2,30,Sum_Nd2,'Filled')
% title ('TwoDS Size Distribution 2b 09/06/2016')
% cl = colorbar;
% cl.Label.String = 'TwoDS Size Distribution (cm^-3 \mum ^-1)';
% ylabel ('Altitude (m)')
% xlabel ('Time (UTC)')
% % title ('TwoDS Size Distribution 09/06/2016')
% datetick('x','HH:MM:SS');
% datetick('x','HH:MM:SS','keepticks');
% subplot(2,3,4)
%     scatter(Time3,Altitude3,30,Sum_Nd3,'Filled')
% title ('TwoDS Size Distribution 2c 09/06/2016')
% cl = colorbar;
% cl.Label.String = 'TwoDS Size Distribution (cm^-3 \mum ^-1)';
% ylabel ('Altitude (m)')
% xlabel ('Time (UTC)')
% % title ('TwoDS Size Distribution 09/06/2016')
% datetick('x','HH:MM:SS');
% datetick('x','HH:MM:SS','keepticks');
% subplot(2,3,5)
%  scatter(Time4,Altitude4,30,Sum_Nd4,'Filled')
% title ('TwoDS Size Distribution 2d 09/06/2016')
% cl = colorbar;
% cl.Label.String = 'TwoDS Size Distribution (cm^-3 \mum ^-1)';
% ylabel ('Altitude (m)')
% xlabel ('Time (UTC)')
% % title ('TwoDS Size Distribution 09/06/2016')
% datetick('x','HH:MM:SS');
% datetick('x','HH:MM:SS','keepticks');
% subplot(2,3,6)
% scatter(Time5,Altitude5,30,Sum_Nd5,'Filled')
% title ('TwoDS Size Distribution 2e 09/06/2016')
% cl = colorbar;
% cl.Label.String = 'TwoDS Size Distribution (cm^-3 \mum ^-1)';
% ylabel ('Altitude (m)')
% xlabel ('Time (UTC)')
% title ('TwoDS Size Distribution 09/06/2016')

% datetick('x','HH:MM:SS');
% datetick('x','HH:MM:SS','keepticks');
% plot(timevec,altitude)
% ylabel ('Altitude (m)')
% hold all
% yyaxis right
% plot(timevec,twods_Nt_summary)
%  ylabel ('Concentration Channel 29 (m^4)')
% 
% xlabel ('Time (UTC)')
% hold all
% plot(timevec_twods,R)
% plot(timevec_twods,S)
% plot(timevec_twods,T)
% datetick('x','HH:MM:SS');
% datetick('x','HH:MM:SS','keepticks');

% %-----Plot Cosmetics-----%
eval(sprintf('title(''HVPS Cloud Droplet Cumulative Mass Distribution - Sawtooth 2d - %6s'');',k,datestr(timevec_twods(1),2)));
xlabel('Diameter (\mum)','FontSize',20);
  ylabel('N(D) (cm^-^3 \mum^-^1)','FontSize',20);
%  ylabel('Mc(D) g \times m^-3)','FontSize',20);
% legend('1st High Value Leg','2nd High Value Leg')
%  legend (' Sawtooth 2a',' Sawtooth 2b',' Sawtooth 2c', ' Sawtooth 2d', ' Sawtooth 2e')
   legend (' Sawtooth 1',' Sawtooth 2',' Sawtooth 3', ' Sawtooth 4')
% %
% %
%
%