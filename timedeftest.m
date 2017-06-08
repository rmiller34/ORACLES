%September 6th Flight%
%-----Open ORACLES Summary file and cas File-----%
a=netcdf.open('16_09_06_06_40_17.Combined.conc.cas.1Hz.nc');
b=netcdf.open('16_09_06_06_40_17.Combined.oracles.nc');
d=netcdf.open('16_09_06_06_40_17.2DS_H.conc.1Hz.nc');
out = ncinfo('16_09_06_06_40_17.2DS_H.conc.1Hz.nc');
varnames = cellstr(char(out.Variables.Name));

%-----Read Unix time and convert to time vector (date number) for cas file-----%
base_time_cas=netcdf.getVar(a,7);
time_offset_cas=netcdf.getVar(a,8);
offset_cas=[0:numel(time_offset_cas)-1]';
base_seconds_cas=offset_cas+double(base_time_cas);
timevec_cas=unix_to_timevec(base_seconds_cas);

%-----Read Unix time and convert to time vector (date number) for summary file-----%
base_time=netcdf.getVar(b,7);
time_offset=netcdf.getVar(b,8);
offset=[0:numel(time_offset)-1]';
base_seconds=offset+double(base_time);
timevec=unix_to_timevec(base_seconds);

%-----Read variables from summary file-----%
altitude=netcdf.getVar(b,19)-50; % WGS84 Altitude
king_lwc=netcdf.getVar(b,44);
CIP_LWC=netcdf.getVar(b,51);
Cas_Nt_Cloud= netcdf.getVar(b,36);
Nt_HVPS3H=netcdf.getVar(b,58);
Nt2DSH_all=netcdf.getVar(b,51);
SPP200Total=netcdf.getVar(b,40);
Sys_RollAng=netcdf.getVar(b,24);
SysPitchAng=netcdf.getVar(b,25);

%-----Read variables from cas file-----%

CAS_LWC =netcdf.getVar(a,47); % 3 to 50 microns
CAS_NtAero =netcdf.getVar(a,42);
CASNtCloud =netcdf.getVar(a,41);
CAS_NtConc =netcdf.getVar(a,40);
CAS_Conc =netcdf.getVar(a,39);

CASConcCH24=netcdf.getVar(a,32);
CASConcCH25=netcdf.getVar(a,33);
CASConcCH26=netcdf.getVar(a,34);
CASConcCH27=netcdf.getVar(a,35);
CASConcCH28=netcdf.getVar(a,36);
CASConcCH29=netcdf.getVar(a,37);
CASConcCH30=netcdf.getVar(a,38);



%-----Read variables from 2DS file-----%

TwoDSH_CH2 = netcdf.getVar(d,10);
TwoDSH_CH3 =netcdf.getVar(d,11);
TwoDSH_CH4= netcdf.getVar(d,12);
TwoDSH_CH5=netcdf.getVar(d,13);
%% %-----Summary file and cas file have different start/end time-----%

% Find which file starts first
%CAS Variables
if timevec(1)>timevec_cas(1);
    new_cas_start=find(timevec_cas==timevec(1));
    cas_Nt_summary=cas_Nt(new_cas_start:end);
    CAS_LWC_summary=CAS_LWC(new_cas_start:end);
    CAS_NtAero_summary=CAS_LNtAero (new_cas_start:end);
    CASNtCloud_summary=CASNtCloud(new_cas_start:end);
    CAS_NtConc_summary=CAS_NtConc(new_cas_start:end);
    CAS_Conc_summary=CAS_Conc(new_cas_start:end);
    CASConcCH24_summary=CASConcCH24(new_cas_start:end);
    CASConcCH25_summary=CASConcCH25(new_cas_start:end);
    CASConcCH26_summary=CASConcCH26(new_cas_start:end);
    CASConcCH27_summary=CASConcCH27(new_cas_start:end);
    CASConcCH28_summary=CASConcCH28(new_cas_start:end);
    CASConcCH29_summary=CASConcCH29(new_cas_start:end);
    CASConcCH30_summary=CASConcCH30(new_cas_start:end);
    
    altitude_cas=altitude;
    king_lwc_cas=king_lwc;
    SPP200Total_cas=SPPtotal;
    Sys_RollAng_cas=Sys_RollAng;
    SysPitchAng_cas=SysPitchAng;
    TwoDSH_CH2_cas=TwoDSH_CH2;
    TwoDSH_CH3_cas=TwoDSH_CH3;
    TwoDSH_CH4_cas=TwoDSH_CH4;
    TwoDSH_CH5_cas=TwoDSH_CH5;
    % Find which file ends later
    % Summary File Variables
    if timevec(end)>timevec_cas(end);
        new_summary_end=find(timevec==timevec_cas(end));
        altitude_cas=altitude(1:new_summary_end);
        king_lwc_cas=king_lwc(1:new_summary_end);
        SPP200Total_cas=SPP200Total(1:new_summary_end);
        Sys_RollAng_cas=Sys_RollAng(1:new_summary_end);
        SysPitchAng_cas=SysPitchAng(1:new_summary_end);
         TwoDSH_CH2_cas=TwoDSH_CH2(1:new_summary_end);
    TwoDSH_CH3_cas=TwoDSH_CH3(1:new_summary_end);
    TwoDSH_CH4_cas=TwoDSH_CH4(1:new_summary_end);
    TwoDSH_CH5_cas=TwoDSH_CH5(1:new_summary_end);
    else
        %more cas Vairables
        new_cas_end=find(timevec_cas==timevec(end));
        CAS_LWC_summary=CAS_LWC(new_cas_start:new_cas_end);
        CAS_NtAero_summary=CAS_LNtAero (new_cas_start:new_cas_end);
        CASNtCloud_summary=CASNtCloud(new_cas_start:new_cas_end);
        CAS_NtConc_summary=CAS_NtConc(new_cas_start:new_cas_end);
        CAS_Conc_summary=CAS_Conc(new_cas_start:new_cas_end);
        CASConcCH24_summary=CASConcCH24(new_cas_start:new_cas_end);
        CASConcCH25_summary=CASConcCH25(new_cas_start:new_cas_end);
        CASConcCH26_summary=CASConcCH26(new_cas_start:new_cas_end);
        CASConcCH27_summary=CASConcCH27(new_cas_start:new_cas_end);
        CASConcCH28_summary=CASConcCH28(new_cas_start:new_cas_end);
        CASConcCH29_summary=CASConcCH29(new_cas_start:new_cas_end);
        CASConcCH30_summary=CASConcCH30(new_cas_start:new_cas_end);
        
    end
else
    new_summary_start=find(timevec==timevec_cas(1));
    altitude_cas=altitude(new_summary_start:end);
    king_lwc_cas=king_lwc(new_summary_start:end);
    SPP200Total_cas=SPP200Total(new_summary_start:end);
    Sys_RollAng_cas=Sys_RollAng(new_summary_start:end);
    SysPitchAng_cas=SysPitchAng(new_summary_start:end);
     TwoDSH_CH2_cas=TwoDSH_CH2(new_summary_start:end);
    TwoDSH_CH3_cas=TwoDSH_CH3(new_summary_start:end);
    TwoDSH_CH4_cas=TwoDSH_CH4(new_summary_start:end);
    TwoDSH_CH5_cas=TwoDSH_CH5(new_summary_start:end);
    CAS_LWC_summary=CAS_LWC;
    CAS_NtAero_summary=CAS_NtAero;
    CASNtCloud_summary=CASNtCloud;
    CAS_NtConc_summary=CAS_NtConc;
    CAS_Conc_summary=CAS_Conc;
    CASConcCH24_summary=CASConcCH24;
    CASConcCH25_summary=CASConcCH25;
    CASConcCH26_summary=CASConcCH26;
    CASConcCH27_summary=CASConcCH27;
    CASConcCH28_summary=CASConcCH28;
    CASConcCH29_summary=CASConcCH29;
    CASConcCH30_summary=CASConcCH30;
    
    
    if timevec(end)>timevec_cas(end);
        new_summary_end=find(timevec==timevec_cas(end));
        altitude_cas=altitude(new_summary_start:new_summary_end);
        king_lwc_cas=king_lwc(new_summary_start:new_summary_end);
        SPP200Total_cas=SPP200Total(new_summary_start:new_summary_end);
        Sys_RollAng_cas=Sys_RollAng(new_summary_start:new_summary_end);
        SysPitchAng_cas=SysPitchAng(new_summary_start:new_summary_end);
%     TwoDSH_CH2_cas=TwoDSH_CH2(new_summary_start:new_summary_end);
%     TwoDSH_CH3_cas=TwoDSH_CH3(new_summary_start:new_summary_end);
%     TwoDSH_CH4_cas=TwoDSH_CH4(new_summary_start:new_summary_end);
%     TwoDSH_CH5_cas=TwoDSH_CH5(new_summary_start:new_summary_end);
    else
        new_cas_end=find(timevec_cas==timevec(end));
        CAS_LWC_summary=CAS_LWC(1:new_cas_end);
        CAS_NtAero_summary=CAS_NtAero(1:new_cas_end);
        CASNtCloud_summary=CASNtCloud(1:new_cas_end);
        CAS_NtConc_summary=CAS_NtConc(1:new_cas_end);
        CAS_Conc_summary=CAS_Conc(1:new_cas_end);
        CASConcCH24_summary=CASConcCH24(1:new_cas_end);
        CASConcCH25_summary=CASConcCH25(1:new_cas_end);
        CASConcCH26_summary=CASConcCH26(1:new_cas_end);
        CASConcCH27_summary=CASConcCH27(1:new_cas_end);
        CASConcCH28_summary=CASConcCH28(1:new_cas_end);
        CASConcCH29_summary=CASConcCH29(1:new_cas_end);
        CASConcCH30_summary=CASConcCH30(1:new_cas_end);
        
    end
end
%% For CAS
24*(timevec_cas - round(timevec_cas));


myDateTime = datetime(timevec_cas, 'ConvertFrom', 'datenum');

myDateTime.Format = ('dd-MMM-uuuu HH:mm:ss.SSSSS');

% The difference is indeed in the order of the precision of the serial date number value:

eps(timevec_cas)*24*3600;

%After converting a datenum to a datetime, you can round the datetime to an exact whole number of hours, minutes or seconds using the "dateshift" function:

dateshift(myDateTime, 'start', 'second', 'nearest');

%Or since datenum is basically a double, you could use "eps" function to avoid round off error:

datetime(timevec_cas + eps, 'ConvertFrom', 'datenum');


%% CAS Channels

corrected_CASConcCH24_summary = (CASConcCH24_summary >= -998);
corrected_CASConcCH25_summary = (CASConcCH25_summary >= -998);
corrected_CASConcCH26_summary = (CASConcCH26_summary >= -998);
corrected_CASConcCH27_summary = (CASConcCH27_summary >= -998);
corrected_CASConcCH28_summary = (CASConcCH28_summary >= -998);
corrected_CASConcCH29_summary = (CASConcCH29_summary >= -998);
corrected_CASConcCH30_summary = (CASConcCH30_summary >= -998);
coeffs = ones(1,1)/1; % This is a 10 sec filter to smooth out the noisy shit

ffilter_CASConcCH24_summary = (filter(coeffs,1,CASConcCH24_summary(corrected_CASConcCH24_summary)));
ffilter_CASConcCH25_summary = (filter(coeffs,1,CASConcCH25_summary(corrected_CASConcCH25_summary)));
ffilter_CASConcCH26_summary = (filter(coeffs,1,CASConcCH26_summary(corrected_CASConcCH26_summary)));
ffilter_CASConcCH27_summary = (filter(coeffs,1,CASConcCH27_summary(corrected_CASConcCH27_summary)));
ffilter_CASConcCH28_summary = (filter(coeffs,1,CASConcCH28_summary(corrected_CASConcCH28_summary)));
ffilter_CASConcCH29_summary = (filter(coeffs,1,CASConcCH29_summary(corrected_CASConcCH29_summary)));
ffilter_CASConcCH30_summary = (filter(coeffs,1,CASConcCH30_summary(corrected_CASConcCH30_summary)));

ChannelCas = (((ffilter_CASConcCH24_summary + ffilter_CASConcCH25_summary...
    +ffilter_CASConcCH26_summary + ffilter_CASConcCH27_summary...
    +ffilter_CASConcCH28_summary + ffilter_CASConcCH29_summary...
    +ffilter_CASConcCH30_summary)));

NormCas = (ChannelCas/0.35);
%% 2DS
corrected_TwoDSH_CH2 = (TwoDSH_CH2_cas >= -998);
corrected_TwoDSH_CH3 = (TwoDSH_CH3_cas >= -998);
corrected_TwoDSH_CH4 = (TwoDSH_CH4_cas >= -998);
corrected_TwoDSH_CH5 = (TwoDSH_CH5_cas >= -998);



filter_TwoDSH_CH2 = (filter(coeffs,1,TwoDSH_CH2_cas(corrected_TwoDSH_CH2)));
filter_TwoDSH_CH3= (filter(coeffs,1,TwoDSH_CH3_cas(corrected_TwoDSH_CH3)));
filter_TwoDSH_CH4 = (filter(coeffs,1,TwoDSH_CH4_cas(corrected_TwoDSH_CH4)));
filter_TwoDSH_CH5 = (filter(coeffs,1,TwoDSH_CH5_cas(corrected_TwoDSH_CH5)));

Channel2DS = (filter_TwoDSH_CH2+filter_TwoDSH_CH3+filter_TwoDSH_CH4+filter_TwoDSH_CH5);
%%
newaltitude_cas = altitude_cas(2:end);
newtimevec_cas = timevec_cas(2:end);
newChannel2DS = Channel2DS(1:28171);
%% Plotting
scatter (newtimevec_cas,newaltitude_cas,3,ChannelCas)
c = colorbar;
c.Label.String = 'CAS Number Concentration 15-50 microns (#/cc)';
ylabel (' Altitude (m)')
xlabel ('Time (UTC)')
title ('CAS Number Concentration 15-50 microns 09/06/2016')
datetick('x','HH:MM:SS');
datetick('x','HH:MM:SS','keepticks');
%% Sawtooth for summary I think

sawtooth_1a=7532:7650;
sawtooth_1b=7650:7765;
sawtooth_1c=7765:7945;
sawtooth_1d=7945:8085;
sawtooth_1e=8085:8212;
sawtooth_1=7532:8212;

sawtooth_2a=12622:12752;
sawtooth_2b=12752:12892;
sawtooth_2c=12892:13022;
sawtooth_2d=13022:13152;
sawtooth_2e=13152:13292;
sawtooth_2=12622:13292;

sawtooth_3a=15942:16102;
sawtooth_3b=16102:16292;
sawtooth_3c=16292:16462;
sawtooth_3d=16462:16632;
sawtooth_3e=16632:16842;
sawtooth_3=15942:16842;

sawtooth_4a=23662:23752;
sawtooth_4b=23752:23882;
sawtooth_4c=23882:24022;
sawtooth_4d=24022:24152;
sawtooth_4e=24152:24302;
sawtooth_4f=24302:24422;
sawtooth_4=23662:24422;
%% SAWTOOTH and LevelLegs for CAS

new_summary_start=555;

level_leg_1_cas=6561-new_summary_start:7191-new_summary_start;
level_leg_2_cas=11461-new_summary_start:12186-new_summary_start;
level_leg_3_cas=14611-new_summary_start:15261-new_summary_start;
level_leg_4_cas=22001-new_summary_start:22461-new_summary_start;
level_leg_5_cas=22461-new_summary_start:22686-new_summary_start;


new_summary_start=555;

% sawtooth_1_offset=21;
% sawtooth_2_offset=22;
% sawtooth_3_offset=22;
% sawtooth_4_offset=23;

sawtooth_1a_cas=7532-new_summary_start:7650-new_summary_start;
sawtooth_1b_cas=7650-new_summary_start:7765-new_summary_start;
sawtooth_1c_cas=7765-new_summary_start:7945-new_summary_start;
sawtooth_1d_cas=7945-new_summary_start:8085-new_summary_start;
sawtooth_1e_cas=8085-new_summary_start:8212-new_summary_start;
sawtooth_1_cas=7532-new_summary_start:8212-new_summary_start;

sawtooth_2a_cas=12622-new_summary_start:12752-new_summary_start;
sawtooth_2b_cas=12752-new_summary_start:12892-new_summary_start;
sawtooth_2c_cas=12892-new_summary_start:13022-new_summary_start;
sawtooth_2d_cas=13022-new_summary_start:13152-new_summary_start;
sawtooth_2e_cas=13152-new_summary_start:13292-new_summary_start;
sawtooth_2_cas=12622-new_summary_start:13292-new_summary_start;

sawtooth_3a_cas=15942-new_summary_start:16102-new_summary_start;
sawtooth_3b_cas=16102-new_summary_start:16292-new_summary_start;
sawtooth_3c_cas=16292-new_summary_start:16462-new_summary_start;
sawtooth_3d_cas=16462-new_summary_start:16632-new_summary_start;
sawtooth_3e_cas=16632-new_summary_start:16842-new_summary_start;
sawtooth_3_cas=15942-new_summary_start:16842-new_summary_start;

sawtooth_4a_cas=23662-new_summary_start:23752-new_summary_start;
sawtooth_4b_cas=23752-new_summary_start:23882-new_summary_start;
sawtooth_4c_cas=23882-new_summary_start:24022-new_summary_start;
sawtooth_4d_cas=24022-new_summary_start:24152-new_summary_start;
sawtooth_4e_cas=24152-new_summary_start:24302-new_summary_start;
sawtooth_4f_cas=24302-new_summary_start:24422-new_summary_start;
sawtooth_4_cas=23662-new_summary_start:24422-new_summary_start;
%% LWC
LWC= CAS_LWC(level_leg_1_cas);
altitudeCAS= altitude_cas(level_leg_1_cas);
time=timevec_cas(level_leg_1_cas);
DateNumber=datestr(time);

LWC2= CAS_LWC(level_leg_2_cas);
altitudeCAS2= altitude_cas(level_leg_2_cas);
time2=timevec_cas(level_leg_2_cas);
DateNumber2=datestr(time2);

LWC3= CAS_LWC(level_leg_3_cas);
altitudeCAS3= altitude_cas(level_leg_3_cas);
time3=timevec_cas(level_leg_3_cas);
DateNumber3=datestr(time3);

LWC4= CAS_LWC(level_leg_4_cas);
altitudeCAS4= altitude_cas(level_leg_4_cas);
time4=timevec_cas(level_leg_4_cas);
DateNumber4=datestr(time4);


%% PCASP

new_summary_start=68;

level_leg_1_pcasp=6561-new_summary_start:7191-new_summary_start;
level_leg_2_pcasp=11461-new_summary_start:12186-new_summary_start;
level_leg_3_pcasp=14611-new_summary_start:15261-new_summary_start;
level_leg_4_pcasp=22001-new_summary_start:22461-new_summary_start;
level_leg_5_pcasp=22461-new_summary_start:22686-new_summary_start;

new_summary_start=68;

sawtooth_1a_pcasp=7532-new_summary_start:7650-new_summary_start;
sawtooth_1b_pcasp=7650-new_summary_start:7765-new_summary_start;
sawtooth_1c_pcasp=7765-new_summary_start:7945-new_summary_start;
sawtooth_1d_pcasp=7945-new_summary_start:8085-new_summary_start;
sawtooth_1e_pcasp=8085-new_summary_start:8212-new_summary_start;
sawtooth_1_pcasp=7532-new_summary_start:8212-new_summary_start;

sawtooth_2a_pcasp=12622-new_summary_start:12752-new_summary_start;
sawtooth_2b_pcasp=12752-new_summary_start:12892-new_summary_start;
sawtooth_2c_pcasp=12892-new_summary_start:13022-new_summary_start;
sawtooth_2d_pcasp=13022-new_summary_start:13152-new_summary_start;
sawtooth_2e_pcasp=13152-new_summary_start:13292-new_summary_start;
sawtooth_2_pcasp=12622-new_summary_start:13292-new_summary_start;

sawtooth_3a_pcasp=15942-new_summary_start:16102-new_summary_start;
sawtooth_3b_pcasp=16102-new_summary_start:16292-new_summary_start;
sawtooth_3c_pcasp=16292-new_summary_start:16462-new_summary_start;
sawtooth_3d_pcasp=16462-new_summary_start:16632-new_summary_start;
sawtooth_3e_pcasp=16632-new_summary_start:16842-new_summary_start;
sawtooth_3_pcasp=15942-new_summary_start:16842-new_summary_start;

sawtooth_4a_pcasp=23662-new_summary_start:23752-new_summary_start;
sawtooth_4b_pcasp=23752-new_summary_start:23882-new_summary_start;
sawtooth_4c_pcasp=23882-new_summary_start:24022-new_summary_start;
sawtooth_4d_pcasp=24022-new_summary_start:24152-new_summary_start;
sawtooth_4e_pcasp=24152-new_summary_start:24302-new_summary_start;
sawtooth_4f_pcasp=24302-new_summary_start:24422-new_summary_start;
sawtooth_4_pcasp=23662-new_summary_start:24422-new_summary_start;

%% PCASP
SPPtotlvl1= SPP200Total_cas(level_leg_1_pcasp);
altitudepcasp= altitude_cas(level_leg_1_pcasp);
time_pcasp=timevec_cas(level_leg_1_pcasp);
DateNumber=datestr(time_pcasp);

SPPtotlvl2= SPP200Total_cas(level_leg_2_pcasp);
altitudepcasp2= altitude_cas(level_leg_2_pcasp);
time2_pcasp=timevec_cas(level_leg_2_pcasp);
DateNumber2pcasp=datestr(time2_pcasp);

SPPtotlvl3= SPP200Total_cas(level_leg_3_pcasp);
altitudepcasp3= altitude_cas(level_leg_3_pcasp);
time3_pcasp=timevec_cas(level_leg_3_pcasp);
DateNumber3pcasp=datestr(time3_pcasp);

SPPtotlvl4= SPP200Total_cas(level_leg_4_pcasp);
altitudepcasp4= altitude_cas(level_leg_4_pcasp);
time4_pcasp=timevec_cas(level_leg_4_pcasp);
DateNumber4pcasp=datestr(time4_pcasp);

% sawtooth_1_pcasp
SPPtotsaw1 = SPP200Total_cas(sawtooth_1);
altitudepcaspsaw1 = altitude(sawtooth_1);
timesawpcasp1 =timevec(sawtooth_1);

% sawtooth_2_pcasp
SPPtotsaw2 = SPP200Total_cas(sawtooth_2);
altitudepcaspsaw2 = altitude(sawtooth_2);
timesawpcasp2 =timevec(sawtooth_2);


% sawtooth_3_pcasp
SPPtotsaw3= SPP200Total_cas(sawtooth_3);
altitudepcaspsaw3 = altitude(sawtooth_3);
timesawpcasp3 =timevec(sawtooth_3);


% sawtooth_4_pcasp
SPPtotsaw4= SPP200Total_cas(sawtooth_4);
altitudepcaspsaw4 = altitude_cas(sawtooth_4);
timesawpcasp4 =timevec_cas(sawtooth_4);
%%
24*(time - round(time));


myDateTime = datetime(time, 'ConvertFrom', 'datenum');

myDateTime.Format = ('dd-MMM-uuuu HH:mm:ss.SSSSS');

% The difference is indeed in the order of the precision of the serial date number value:

eps(time)*24*3600;

%After converting a datenum to a datetime, you can round the datetime to an exact whole number of hours, minutes or seconds using the "dateshift" function:

dateshift(myDateTime, 'start', 'second', 'nearest');

%Or since datenum is basically a double, you could use "eps" function to avoid round off error:

datetime(time + eps, 'ConvertFrom', 'datenum');
%%

sawtooth_1_cas
LWCsaw= CAS_LWC_summary(sawtooth_1_cas);
altitudeCASsaw= altitude_cas(sawtooth_1_cas);
timesaw=timevec_cas(sawtooth_1_cas);

CASNtCloud_summary_saw1 = CASNtCloud_summary(sawtooth_1_cas);
altitudeCASsaw1 = altitude_cas(sawtooth_1_cas);
timesaw1 =timevec_cas(sawtooth_1_cas);

sawtooth_2_cas
CASNtCloud_summary_saw2 = CASNtCloud_summary(sawtooth_2_cas);
altitudeCASsaw2 = altitude_cas(sawtooth_2_cas);
timesaw2 =timevec_cas(sawtooth_2_cas);

sawtooth_3_cas
CASNtCloud_summary_saw3 = CASNtCloud_summary(sawtooth_3_cas);
altitudeCASsaw3 = altitude_cas(sawtooth_3_cas);
timesaw3 =timevec_cas(sawtooth_3_cas);

sawtooth_4_cas
CASNtCloud_summary_saw4 = CASNtCloud_summary(sawtooth_4_cas);
altitudeCASsaw4 = altitude_cas(sawtooth_4_cas);
timesaw4 =timevec_cas(sawtooth_4_cas);


coeffs = ones(1,10)/60;
corrected_CAS_LWC_summary=(CAS_LWC_summary >= -998 & CAS_LWC_summary <= 10000);
corrected_CASNtCloud_summary=(CASNtCloud_summary >= -998 & CASNtCloud_summary <= 100000);
corrected_CAS_NtConc_summary=(CAS_NtConc_summary >= -998 & CAS_NtConc_summary <= 100000);
corrected_CAS_Conc_summary=(CAS_Conc_summary >= -998 & CAS_Conc_summary <= 10000);
corrected_SPP200Total_cas =(SPP200Total_cas >= -998 & SPP200Total_cas <= 10000);
filter_CAS_LWC_summary=(filter(coeffs,1,CAS_LWC_summary(corrected_CAS_LWC_summary)));



% pcolor(LWCsaw,altitudeCASsaw,timesaw)
RollAng=double(Sys_RollAng);
PitchAng=double(SysPitchAng);
corrected_RollAng=(RollAng >= -998 & RollAng <= 10000);
corrected_PitchAng=(PitchAng >= -998 & PitchAng <= 10000);

PitchAngle=PitchAng(corrected_PitchAng);
Pitchsaw1 = PitchAngle(sawtooth_1);
Pitchsaw2 = PitchAngle(sawtooth_2);
Pitchsaw3 = PitchAngle(sawtooth_3);
Pitchsaw4 = PitchAngle(sawtooth_4);

RollAngle=RollAng(corrected_RollAng);
Rollsaw1 = RollAngle(sawtooth_1);
Rollsaw2 = RollAngle(sawtooth_2);
Rollsaw3 = RollAngle(sawtooth_3);
Rollsaw4 = RollAngle(sawtooth_4);
% plot(timevec(corrected_RollAng),RollAng(corrected_RollAng));
% datetick('x','HH:MM:SS');
% datetick('x','HH:MM:SS','keepticks');
% ylabel (' degrees')
% xlabel ('Time (UTC)')
% title ('Aircraft Roll Angle 09/06/2016')
% hold on
% scatter (timevec(corrected_PitchAng),altitude(corrected_PitchAng),5,PitchAng(corrected_PitchAng))
% c = colorbar;
% c.Label.String = 'Pitch Angle °';
% % plot(timevec(corrected_PitchAng),RollAng(corrected_PitchAng));
% datetick('x','HH:MM:SS');
% datetick('x','HH:MM:SS','keepticks');
% ylabel (' Altitude(m)')
% xlabel ('Time (UTC)')
% title ('Aircraft Pitch Angle 09/06/2016')
%% Sawtooth 1

% graph with color bar, change limit and size
%  scatter (timesaw,altitudeCASsaw,25,LWCsaw)
% c = colorbar;
% c.Label.String = 'King LWC (g/cm^3)';
%
% datetick('x','HH:MM:SS');
% datetick('x','HH:MM:SS','keepticks');

% scatter (timesaw1,altitudeCASsaw1,300,CASNtCloud_summary_saw1)
% c = colorbar;
% c.Label.String = 'CAS Number Concentration 3-50 microns(#/cc)';
% ylabel (' Altitude (m)')
% xlabel ('Time (UTC)')
% title ('CAS Number Concentration Sawtooth 21 09/06/2016')
% datetick('x','HH:MM:SS');
% datetick('x','HH:MM:SS','keepticks');

%% Sawtooth 2
% scatter (timesaw2,altitudeCASsaw2,25,CASNtCloud_summary_saw2)
% c = colorbar;
% c.Label.String = 'CAS Number Concentration 3-50 microns(#/cc)';
% ylabel (' Altitude (m)')
% xlabel ('Time (UTC)')
% title ('CAS Number Concentration Sawtooth 2 09/06/2016')
% datetick('x','HH:MM:SS');
% datetick('x','HH:MM:SS','keepticks');
%% Sawtooth 3
% scatter (timesaw3,altitudeCASsaw3,300,CASNtCloud_summary_saw3)
% c = colorbar;
% c.Label.String = 'CAS Number Concentration 3-50 microns(#/cc)';
% ylabel (' Altitude (m)')
% xlabel ('Time (UTC)')
% title ('CAS Number Concentration Sawtooth 3 09/06/2016')
% datetick('x','HH:MM:SS');
% datetick('x','HH:MM:SS','keepticks');
%% Sawtooth 4
scatter (timesaw4,altitudeCASsaw4,300,CASNtCloud_summary_saw4)
c = colorbar;
c.Label.String = 'CAS Number Concentration 3-50 microns(#/cc)';
ylabel (' Altitude (m)')
xlabel ('Time (UTC)')
title ('CAS Number Concentration Sawtooth 4 09/06/2016')
datetick('x','HH:MM:SS');
datetick('x','HH:MM:SS','keepticks');

%% PCASP SAWTOOTH 1
% graph with color bar, change limit and size
%  scatter (timesaw,altitudeCASsaw,25,LWCsaw)
% c = colorbar;
% c.Label.String = 'King LWC (g/cm^3)';
%
% datetick('x','HH:MM:SS');
% datetick('x','HH:MM:SS','keepticks');
% hold on
% scatter (timesawpcasp1,altitudepcaspsaw1,300,SPPtotsaw1)
% c = colorbar;
% c.Label.String = 'PCASP Total Concentration(#/cm^3)';
% ylabel (' Altitude (m)')
% xlabel ('Time (UTC)')
% title ('PCASP Number Concentration Sawtooth 1 09/06/2016')
% datetick('x','HH:MM:SS');
% datetick('x','HH:MM:SS','keepticks');

%% PCASP SAWTOOTH 2
% scatter (timesawpcasp2,altitudepcaspsaw2,300,SPPtotsaw2)
% c = colorbar;
% c.Label.String = 'PCASP Total Concentration(#/cm^3)';
% ylabel (' Altitude (m)')
% xlabel ('Time (UTC)')
% title ('PCASP Number Concentration Sawtooth 1 09/06/2016')
% datetick('x','HH:MM:SS');
% datetick('x','HH:MM:SS','keepticks');

%% PCASP SAWTOOTH 3
% scatter (timesawpcasp3,altitudepcaspsaw3,300,SPPtotsaw3)
% c = colorbar;
% c.Label.String = 'PCASP Total Concentration(#/cm^3)';
% ylabel (' Altitude (m)')
% xlabel ('Time (UTC)')
% title ('PCASP Number Concentration Sawtooth 1 09/06/2016')
% datetick('x','HH:MM:SS');
% datetick('x','HH:MM:SS','keepticks');

%% PCASP SAWTOOTH 4
% scatter (timesawpcasp4,altitudepcaspsaw4,300,SPPtotsaw4)
% c = colorbar;
% c.Label.String = 'PCASP Total Concentration(#/cm^3)';
% ylabel (' Altitude (m)')
% xlabel ('Time (UTC)')
% title ('PCASP Number Concentration Sawtooth 1 09/06/2016')
% datetick('x','HH:MM:SS');
% datetick('x','HH:MM:SS','keepticks');

%% PITCH SAWTOOTH1

% scatter (timesawpcasp1,altitudepcaspsaw1,5,Pitchsaw1)
% c = colorbar;
% c.Label.String = 'Pitch Angle °';
%
% datetick('x','HH:MM:SS');
% datetick('x','HH:MM:SS','keepticks');
% ylabel (' Altitude(m)')
% xlabel ('Time (UTC)')
% title ('Aircraft Pitch Angle Sawtooth 1 09/06/2016')

%% PITCH SAWTOOTH 2
% scatter (timesawpcasp2,altitudepcaspsaw2,5,Pitchsaw2)
% c = colorbar;
% c.Label.String = 'Pitch Angle °';
%
% datetick('x','HH:MM:SS');
% datetick('x','HH:MM:SS','keepticks');
% ylabel (' Altitude(m)')
% xlabel ('Time (UTC)')
% title ('Aircraft Pitch Angle Sawtooth 2 09/06/2016')

%% PITCH SAWTOOTH 3
% scatter (timesawpcasp3,altitudepcaspsaw3,5,Pitchsaw3)
% c = colorbar;
% c.Label.String = 'Pitch Angle °';
% 
% datetick('x','HH:MM:SS');
% datetick('x','HH:MM:SS','keepticks');
% ylabel (' Altitude(m)')
% xlabel ('Time (UTC)')
% title ('Aircraft Pitch Angle Sawtooth 3 09/06/2016')

%% PITCH SAWTOOTH 4
% scatter (timesawpcasp4,altitudepcaspsaw4,5,Pitchsaw4)
% c = colorbar;
% c.Label.String = 'Pitch Angle °';
%
% datetick('x','HH:MM:SS');
% datetick('x','HH:MM:SS','keepticks');
% ylabel (' Altitude(m)')
% xlabel ('Time (UTC)')
% title ('Aircraft Pitch Angle Sawtooth 4 09/06/2016')

%% %% Roll SAWTOOTH1
% 
% scatter (timesawpcasp1,altitudepcaspsaw1,5,Rollsaw1)
% c = colorbar;
% c.Label.String = 'Roll Angle °';
% 
% datetick('x','HH:MM:SS');
% datetick('x','HH:MM:SS','keepticks');
% ylabel (' Altitude(m)')
% xlabel ('Time (UTC)')
% title ('Aircraft Roll Angle Sawtooth 1 09/06/2016')

%% Roll SAWTOOTH 2
% scatter (timesawpcasp2,altitudepcaspsaw2,5,Rollsaw2)
% c = colorbar;
% c.Label.String = 'Roll Angle °';
%
% datetick('x','HH:MM:SS');
% datetick('x','HH:MM:SS','keepticks');
% ylabel (' Altitude(m)')
% xlabel ('Time (UTC)')
% title ('Aircraft  Roll Angle Sawtooth 2 09/06/2016')

%% Roll SAWTOOTH 3
% scatter (timesawpcasp3,altitudepcaspsaw3,5,Rollsaw3)
% c = colorbar;
% c.Label.String = 'Roll Angle °';
%
% datetick('x','HH:MM:SS');
% datetick('x','HH:MM:SS','keepticks');
% ylabel (' Altitude(m)')
% xlabel ('Time (UTC)')
% title ('Aircraft Roll Angle Sawtooth 3 09/06/2016')

%% Roll SAWTOOTH 4
% scatter (timesawpcasp4,altitudepcaspsaw4,5,Rollsaw4)
% c = colorbar;
% c.Label.String = 'Roll Angle °';
%
% datetick('x','HH:MM:SS');
% datetick('x','HH:MM:SS','keepticks');
% ylabel (' Altitude(m)')
% xlabel ('Time (UTC)')
% title ('Aircraft Roll Angle Sawtooth 4 09/06/2016')