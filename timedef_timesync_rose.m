
%-----Open files-----%
a=netcdf.open('16_09_06_06_40_17.Combined.conc.spp200.1Hz.nc');
b=netcdf.open('16_09_06_06_40_17.Combined.oracles.nc');
c=netcdf.open('16_09_06_06_40_17.Combined.conc.cas.1Hz.nc');
out = ncinfo('16_09_06_06_40_17.Combined.conc.cas.1Hz.nc');
varnames = cellstr(char(out.Variables.Name));


%-----Read Unix time and convert to time vector (date number) for PCASP file-----%
base_time_pcasp=netcdf.getVar(a,7);
time_offset_pcasp=netcdf.getVar(a,8);
offset_pcasp=[0:numel(time_offset_pcasp)-1]';
base_seconds_pcasp=offset_pcasp+double(base_time_pcasp);
timevec_pcasp=unix_to_timevec(base_seconds_pcasp);

%-----Read Unix time and convert to time vector (date number) for summary file-----%
base_time=netcdf.getVar(b,7);
time_offset=netcdf.getVar(b,8);
offset=[0:numel(time_offset)-1]';
base_seconds=offset+double(base_time);
timevec=unix_to_timevec(base_seconds);

%----- Read Unix time and convert to time vector (date number) for CAS file
base_time_CAS=netcdf.getVar(c,7);
time_offset_CAS=netcdf.getVar(c,8);
offset_CAS=[0:numel(time_offset_CAS)-1]';
base_seconds_CAS=offset_CAS+double(base_time_CAS);
timevec_CAS=unix_to_timevec(base_seconds_CAS);

%-----Read variables from summary file-----%
altitude=netcdf.getVar(b,19)-50; % WGS84 Altitude
king_lwc=netcdf.getVar(b,44);
CIP_LWC=netcdf.getVar(b,51);
Cas_Nt_Cloud= netcdf.getVar(b,36);
Nt_HVPS3H=netcdf.getVar(b,58);
Nt2DSH_all=netcdf.getVar(b,51);

%-----Read variables from PCASP file-----%
pcasp_Nt=netcdf.getVar(a,39); % 3 to 50 microns
SPP200_CH18=netcdf.getVar(a,26);
SPP200_CH30=netcdf.getVar(a,38);

%-----Read variables from CAS file-----%
CAS_LWC =netcdf.getVar(c,47);
CAS_NtAero =netcdf.getVar(c,42);
CASNtCloud =netcdf.getVar(c,41);
CAS_NtConc =netcdf.getVar(c,40);
CAS_Conc =netcdf.getVar(c,39);
CASConcCH2=netcdf.getVar(c,10);
CASConcCH14=netcdf.getVar(c,22);

%% %-----Summary file and PCASP file have different start/end time-----%

% Find which file starts first
if timevec(1)>timevec_pcasp(1);
    new_pcasp_start=find(timevec_pcasp==timevec(1));
    pcasp_Nt_summary=pcasp_Nt(new_pcasp_start:end);
    SPP200_CH18_pcasp=SPP200_CH18(new_pcasp_start:end);
    SPP200_CH30_pcasp=SPP200_CH30(new_pcasp_start:end);
    altitude_pcasp=altitude;
    king_lwc_pcasp=king_lwc;
    Cas_Nt_Cloud_pcasp=Cas_Nt_Cloud;
    CIP_LWC_pcasp=CIP_LWC;
    Nt_HVPS3H_psap=Nt_HVPS3H;
    Nt2DSH_all_pscap=Nt2DSH-all;
    % Find which file ends later
    if timevec(end)>timevec_pcasp(end);
        new_summary_end=find(timevec==timevec_pcasp(end));
        altitude_pcasp=altitude(1:new_summary_end);
        king_lwc_pcasp=king_lwc(1:new_summary_end);
        Cas_Nt_Cloud_pcasp=Cas_Nt_Cloud(1:new_summary_end);
        CIP_LWC_pcasp=CIP_LWC(1:new_summary_end);
        Nt_HVPS3H_pcasp=Nt_HVPS3H(1:new_summary_end);
        Nt2DSH_all_pcasp=Nt2DSH_all(1:new_summary-end);
    else
        new_pcasp_end=find(timevec_pcasp==timevec(end));
        pcasp_Nt_summary=pcasp_Nt(new_pcasp_start:new_pcasp_end);
        SPP200_CH18_pcasp=SPP200_CH18(new_pcasp_start:new_pcasp_end);
        SPP200_CH30_pcasp=SPP200_CH30(new_pcasp_start:new_pcasp_end);
    end
else
    new_summary_start=find(timevec==timevec_pcasp(1));
    altitude_pcasp=altitude(new_summary_start:end);
    king_lwc_pcasp=king_lwc(new_summary_start:end);
    Cas_Nt_Cloud_pcasp=Cas_Nt_Cloud(new_summary_start:end);
    CIP_LWC_pcasp=CIP_LWC(new_summary_start:end);
    Nt_HVPS3H_pcasp=Nt_HVPS3H(new_summary_start:end);
    Nt2DSH_all_pcasp=Nt2DSH_all(new_summary_start:end);
    pcasp_Nt_summary=pcasp_Nt;
    SPP200_CH30_pcasp=SPP200_CH30;
    SPP200_CH18_pcasp=SPP200_CH18;
    if timevec(end)>timevec_pcasp(end);
        new_summary_end=find(timevec==timevec_pcasp(end));
        altitude_pcasp=altitude(new_summary_start:new_summary_end);
        king_lwc_pcasp=king_lwc(new_summary_start:new_summary_end);
        Cas_Nt_Cloud_pcasp=Cas_Nt_Cloud(new_summary_start:new_summary_end);
        CIP_LWC_pcasp=CIP_LWC(new_summary_start:new_summary_end);
        Nt_HVPS3H_pcasp=Nt_HVPS3H(new_summary_start:new_summary_end);
        Nt2DSH_all_pcasp=Nt2DSH_all(new_summary_start:new_summary_end);
        
    else
        new_pcasp_end=find(timevec_pcasp==timevec(end));
        pcasp_Nt_summary=pcasp_Nt(1:new_pcasp_end);
        SPP200_CH18_pcasp=SPP200_CH18(1:new_pcasp_end);
        SPP200_CH30_pcasp=SPP200_CH30(1:new_pcasp_end);
    end
end
%%
if timevec(1)>timevec_CAS(1);
    new_CAS_start=find(timevec_CAS==timevec(1));
    CAS_Nt_summary=CAS_Nt(new_CAS_start:end);
    altitude_CAS=altitude;
    king_lwc_CAS=king_lwc;
    CAS_LWC_CAS = CAS_LWC;
    CASConcCH2_CAS=CASConcCH1;
    CASConcCH14_CAS=CASConcCH14;
    CAS_NtAero_CAS = CAS_NtAero;
    CASNtCloud_CAS = CASNtCloud;
    CAS_NtConc_CAS = CAS_NtConc;
    CAS_Conc_CAS = CAS_Conc;
    % Find which file ends later
    if timevec(end)>timevec_CAS(end);
        new_summary_end=find(timevec==timevec_CAS(end));
        altitude_CAS=altitude(1:new_summary_end);
        king_lwc_CAS=king_lwc(1:new_summary_end);
        CAS_LWC_CAS = CAS_LWC (1:new_summary_end);
        CAS_NtAero_CAS = CAS_NtAero(1:new_summary_end);
        CASNtCloud_CAS = CASNtCloud(1:new_summary_end);
        CAS_NtConc_CAS = CAS_NtConc(1:new_summary_end);
        CAS_Conc_CAS = CAS_Conc(1:new_summary_end);
        CASConcCH2_CAS=CASConcCH2(1:new_summary_end);
        CASConcCH14_CAS=CASConcCH14(1:new_summary_end);
    else
        new_CAS_end=find(timevec_CAS==timevec(end));
        CAS_Nt_summary=CAS_Nt(new_CAS_start:new_CAS_end);
    end
else
    new_summary_start=find(timevec==timevec_CAS(1));
    altitude_CAS=altitude(new_summary_start:end);
    king_lwc_CAS=king_lwc(new_summary_start:end);
    CAS_LWC_CAS = CAS_LWC (new_summary_start:end);
    CAS_NtAero_CAS = CAS_NtAero(new_summary_start:end);
    CASNtCloud_CAS = CASNtCloud(new_summary_start:end);
    CAS_NtConc_CAS = CAS_NtConc(new_summary_start:end);
    CAS_Conc_CAS = CAS_Conc(new_summary_start:end);
    CASConcCH2_CAS=CASConcCH2(new_summary_start:end);
    CASConcCH14_CAS=CASConcCH14(new_summary_start:end);
    
    if timevec(end)>timevec_CAS(end);
        new_summary_end=find(timevec==timevec_CAS(end));
        altitude_CAS=altitude(new_summary_start:new_summary_end);
        king_lwc_CAS=king_lwc(new_summary_start:new_summary_end);
        %         CAS_LWC_CAS = CAS_LWC(new_summary_start:new_summary_end);
        %         CAS_NtAero_CAS = CAS_NtAero(new_summary_start:new_summary_end);
        %         CASNtCloud_CAS = CASNtCloud(new_summary_start:new_summary_end);
        %         CAS_NtConc_CAS = CAS_NtConc(new_summary_start:new_summary_end);
        %         CAS_Conc_CAS = CAS_Conc(new_summary_start:new_summary_end);
        
        
    else
        new_CAS_end=find(timevec_CAS==timevec(end));
        CAS_Nt_summary=CAS_Nt(1:new_CAS_end);
    end
end
%% DateTime
24*(timevec - round(timevec));


myDateTime = datetime(timevec, 'ConvertFrom', 'datenum');

myDateTime.Format = ('dd-MMM-uuuu HH:mm:ss.SSSSS');

% The difference is indeed in the order of the precision of the serial date number value:

eps(timevec)*24*3600;

%After converting a datenum to a datetime, you can round the datetime to an exact whole number of hours, minutes or seconds using the "dateshift" function:

dateshift(myDateTime, 'start', 'second', 'nearest');

%Or since datenum is basically a double, you could use "eps" function to avoid round off error:

datetime(timevec + eps, 'ConvertFrom', 'datenum');

24*(timevec_CAS - round(timevec_CAS));


myDateTime_CAS = datetime(timevec_CAS, 'ConvertFrom', 'datenum');

myDateTime.Format = ('dd-MMM-uuuu HH:mm:ss.SSSSS');

% The difference is indeed in the order of the precision of the serial date number value:

eps(timevec_CAS)*24*3600;

%After converting a datenum to a datetime, you can round the datetime to an exact whole number of hours, minutes or seconds using the "dateshift" function:

dateshift(myDateTime, 'start', 'second', 'nearest');

%Or since datenum is basically a double, you could use "eps" function to avoid round off error:

datetime(timevec_CAS + eps, 'ConvertFrom', 'datenum');
%% Removing the bad guys King LWC

corrected_king_lwc = (king_lwc_pcasp >= 0); %This takes away the bad values. King 0.05-0.3g/m^3

corrected_altitude = (altitude >=0); % Not too sure how to remove bad altitude data


coeffs = ones(1,10)/10; % This is a 1-min filter to smooth out the noisy shit
coeffesalt =ones(1,1)/1;
filter_king_lwc = filter(coeffs,1,king_lwc_pcasp(corrected_king_lwc));
newaltitude =filter(coeffesalt,1,altitude(corrected_altitude));

% plot (myDateTime(altitude),altitude(corrected_altitude))
%  plot( newaltitude,filter_king_lwc)
% title ('Flight Time vs. Altitude')
% xlabel('Time (UTC + 01:00)')
% ylabel('Altitude (m)')

short_newaltitude = newaltitude(186:end);
% scatter(filter_king_lwc,short_newaltitude)
%  title ('King LWC vs. Altitude ')
%  xlabel('Liquid Water Content ((g/m^3))')
%  ylabel('Altitude (m)')
%For non-filtered data
% plot (myDateTime(corrected_king_lwc),king_lwc(corrected_king_lwc))
%For Filtered Data

% Plot time vs. King LWC
% plot(myDateTime(corrected_king_lwc),filter_king_lwc)
hold on

% title ('Flight Time vs. King LWC ')
% xlabel('Time (UTC + 01:00)')
% ylabel('King LWC (g/m^3)')
%% PCASP_Nt-Summary 'Total number concentration of particles based on the PCASP-SPP200'



corrected_pcasp_Nt_summary = (pcasp_Nt_summary >= -998); %This takes away the bad values. King 0.05-0.3g/m^3
corrected_altitude = (altitude >=0); % Not too sure how to remove bad altitude data


coeffs = ones(1,10)/10; % This is a 10 sec filter to smooth out the noisy shit
filter_pcasp_Nt_summary = filter(coeffs,1,pcasp_Nt_summary(corrected_pcasp_Nt_summary));



%For non-filtered data
% plot (myDateTime(corrected_king_lwc),king_lwc(corrected_king_lwc))
%For Filtered Data

%Plot time vs. pcasp_Nt_summary
%  plot(myDateTime(corrected_pcasp_Nt_summary),filter_pcasp_Nt_summary)
% title ('Flight Time vs. pcaspNtsummary ')
% xlabel('Time (UTC + 01:00)')
%  ylabel('Concentration (#/cm^3)')

%% CAS Nt Cloud 'CAS Number Concentration of Cloud Droplets (3 to 50 microns)

corrected_Cas_Nt_Cloud_pcasp = (Cas_Nt_Cloud_pcasp >= -998); %This takes away the bad values. King 0.05-0.3g/m^3
corrected_altitude = (altitude >=0); % Not too sure how to remove bad altitude data


coeffs = ones(1,10)/10; % This is a 10 sec filter to smooth out the noisy shit
filter_Cas_Nt_Cloud_pcasp = filter(coeffs,1,Cas_Nt_Cloud_pcasp(corrected_Cas_Nt_Cloud_pcasp));



%For non-filtered data
% plot (myDateTime(corrected_king_lwc),king_lwc(corrected_king_lwc))
%For Filtered Data

%Plot time vs. Cas_Nt_Cloud_pcasp
%  plot(myDateTime(corrected_Cas_Nt_Cloud_pcasp),filter_Cas_Nt_Cloud_pcasp)
% hold on
% plot(myDateTime(corrected_pcasp_Nt_summary),filter_pcasp_Nt_summary)
% title ('Flight Time vs. Cas_Nt_Cloud_pcasp')
% xlabel('Time (UTC + 01:00)')
% ylabel('Concentration (#/cm^3)')
%% CIP LWC to compare with King LWC


corrected_CIP_LWC = (CIP_LWC_pcasp >= -998); %This takes away the bad values. King 0.05-0.3g/m^3
corrected_altitude = (altitude >=0); % Not too sure how to remove bad altitude data


coeffs = ones(1,10)/10; % This is a 1-min filter to smooth out the noisy shit
filter_CIP_LWC = filter(coeffs,1,CIP_LWC_pcasp(corrected_CIP_LWC));




%For non-filtered data
% plot (myDateTime(corrected_king_lwc),king_lwc(corrected_king_lwc))
%For Filtered Data

%Plot time vs. King LWC
%plot(myDateTime(corrected_CIP_LWC),filter_CIP_LWC)
hold on
% plot(myDateTime(corrected_king_lwc),filter_king_lwc)
%  title ('Flight Time vs. King LWC ')
% xlabel('Time (UTC + 01:00)')
%  ylabel('King LWC (g/m^3)')
%% HVPS

corrected_Nt_HVPS3H = (Nt_HVPS3H_pcasp >= -998); %This takes away the bad values. King 0.05-0.3g/m^3
corrected_altitude = (altitude >=0); % Not too sure how to remove bad altitude data


coeffs = ones(1,10)/10; % This is a 1-min filter to smooth out the noisy shit
filter_Nt_HVPS3H = filter(coeffs,1,Nt_HVPS3H_pcasp(corrected_Nt_HVPS3H));




%For non-filtered data
% plot (myDateTime(corrected_king_lwc),king_lwc(corrected_king_lwc))
%For Filtered Data

%Plot time vs. King LWC
%  plot(myDateTime(corrected_Nt_HVPS3H),filter_Nt_HVPS3H)
% hold on
% %
%  title ('Flight Time vs. King LWC ')
%  xlabel('Time (UTC + 01:00)')
%  ylabel('King LWC (g/m^3)')
%% CAS

corrected_CAS_Conc = (CAS_Conc_CAS >= -998 & CAS_Conc_CAS <= 10000); %This takes away the bad values. King 0.05-0.3g/m^3
corrected_CAS_NtConc = (CAS_NtConc_CAS >= -998 & CAS_NtConc_CAS <= 10000);
corrected_CASNtCloud = (CASNtCloud_CAS >= -998 & CASNtCloud_CAS <= 10000);
corrected_CAS_NtAero = (CAS_NtAero_CAS >= -998 & CAS_NtAero_CAS <= 10000);
corrected_CAS_LWC = (CAS_LWC_CAS >= -998 & CAS_LWC_CAS <= 10000);

corrected_altitude = (altitude >=0); % Not too sure how to remove bad altitude data


coeffs = ones(1,10)/10; % This is a 1-min filter to smooth out the noisy shit
filter_CAS_LWC = filter(coeffs,1,CAS_LWC_CAS(corrected_CAS_LWC));
filter_CAS_NtAero = filter(coeffs,1,CAS_NtAero_CAS(corrected_CAS_NtAero));
filter_CASNtCloud = filter(coeffs,1,CASNtCloud_CAS(corrected_CASNtCloud));
filter_CAS_NtConc = filter(coeffs,1,CAS_NtConc_CAS(corrected_CAS_NtConc));
filter_CAS_Conc = filter(coeffs,1,CAS_Conc_CAS(corrected_CAS_Conc));

%For non-filtered data
%  plot (myDateTime(corrected_CAS_LWC),CAS_LWC_CAS(corrected_CAS_LWC))
% hold on
%   plot(myDateTime(corrected_CAS_LWCtest), CAS_LWC(corrected_CAS_LWCtest))
%For Filtered Data


% plot(myDateTime(corrected_pcasp_Nt_summary),filter_pcasp_Nt_summary,'.')
hold on
% plot(myDateTime_CAS(corrected_CAS_NtConc),filter_CAS_NtConc,'.')
%Plot time vs. King LWC
%  plot(myDateTime_CAS(corrected_CAS_LWC),filter_CAS_LWC,'.')
hold on
%  plot(myDateTime(corrected_king_lwc),filter_king_lwc,'.')
% title ('Total Pcasp vs CAS Concentrations ')
% xlabel('Time (UTC)')
% ylabel('Concentration ((#/cm^3))')

%%
corrected_SPP200_CH18_pcasp = (SPP200_CH18_pcasp >= -998); %This takes away the bad values. King 0.05-0.3g/m^3
corrected_SPP200_CH30_pcasp = (SPP200_CH30_pcasp >= -998); % Not too sure how to remove bad altitude data
corrected_CASConcCH2_CAS = (CASConcCH2_CAS >= -998);
corrected_CASConcCH14_CAS = (CASConcCH14_CAS >= -998);

coeffs = ones(1,10)/10; % This is a 10 sec filter to smooth out the noisy shit
filter_SPP200_CH18_pcasp = (filter(coeffs,1,SPP200_CH18_pcasp(corrected_SPP200_CH18_pcasp))/15);
filter_SPP200_CH30_pcasp = (filter(coeffs,1,SPP200_CH30_pcasp(corrected_SPP200_CH30_pcasp))/2);
filter_CASConcCH2_CAS = (filter(coeffs,1,CASConcCH2_CAS(corrected_CASConcCH2_CAS))/7);
filter_CASConcCH14_CAS = (filter(coeffs,1,CASConcCH14_CAS(corrected_CASConcCH14_CAS))/5);


%CAS 2 0.61-0.68um
%CAS14 2.5-3um
%PCASP30 2.9-3.1um
%PCASP180.55-.70um 
%For non-filtered data
% plot (myDateTime(corrected_king_lwc),king_lwc(corrected_king_lwc))

%For Filtered Data

%Plot time vs. concentration

plot(myDateTime(corrected_SPP200_CH30_pcasp),filter_SPP200_CH30_pcasp)
hold on
% 
plot(myDateTime(corrected_CASConcCH14_CAS),filter_CASConcCH14_CAS)
title ('Flight Time vs. PCASP 0.55-0.70um')
xlabel('Time (UTC')
ylabel('Concentration (#/cm^3)')

% hold on

%  plot(myDateTime(corrected_CASConcCH2_CAS),filter_CASConcCH2_CAS)
% hold on
% plot(myDateTime(corrected_CASConcCH14_CAS),filter_CASConcCH14_CAS)
% title ('Flight Time vs. CAS 0.54-0.61um')
% xlabel('Time (UTC')
% ylabel('Concentration (#/cc)')

