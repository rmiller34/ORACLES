%-----Read variables from ORACLES Summary file and IWG1 File-----%
ncid=netcdf.open('16_09_06_06_40_17.2DS_H.conc.1Hz.nc');

%-----Read Unix time and convert to timevec for CAS file-----%
base_time_twods=netcdf.getVar(ncid,7);
time_offset_twods=netcdf.getVar(ncid,8);
offset_twods=[0:numel(time_offset_twods)-1]';
base_seconds_twods=offset_twods+double(base_time_twods);
timevec_twods=unix_to_timevec(base_seconds_twods);

%-----Read variables from CAS file-----%
TwoDS_Nt=netcdf.getVar(ncid,41);
%%
TwoDS1=netcdf.getVar(ncid,9);
TwoDS2=netcdf.getVar(ncid,10);
TwoDS3=netcdf.getVar(ncid,11);
TwoDS4=netcdf.getVar(ncid,12);
TwoDS5=netcdf.getVar(ncid,13);
TwoDS6=netcdf.getVar(ncid,14);
TwoDS7=netcdf.getVar(ncid,15);
TwoDS8=netcdf.getVar(ncid,16);
TwoDS9=netcdf.getVar(ncid,17);
TwoDS10=netcdf.getVar(ncid,18);
TwoDS11=netcdf.getVar(ncid,19);
TwoDS12=netcdf.getVar(ncid,20);
TwoDS13=netcdf.getVar(ncid,21);
TwoDS14=netcdf.getVar(ncid,22);
TwoDS15=netcdf.getVar(ncid,23);
TwoDS16=netcdf.getVar(ncid,24);
TwoDS17=netcdf.getVar(ncid,25);
TwoDS18=netcdf.getVar(ncid,26);
TwoDS19=netcdf.getVar(ncid,27);
TwoDS20=netcdf.getVar(ncid,28);
TwoDS21=netcdf.getVar(ncid,29);
TwoDS22=netcdf.getVar(ncid,30);
TwoDS23=netcdf.getVar(ncid,31);
TwoDS24=netcdf.getVar(ncid,32);
TwoDS25=netcdf.getVar(ncid,33);
TwoDS26=netcdf.getVar(ncid,34);
TwoDS27=netcdf.getVar(ncid,35);
TwoDS28=netcdf.getVar(ncid,36);
TwoDS29=netcdf.getVar(ncid,37);

%%
 bin_diameter=[10;10;10;10;10;10;10;10;10;10;20;20;30;50;50;50;75;75;25;75;75;100;100;100;200;200;200;200;200];

AllBinsTwoDS2 = (((TwoDS1+TwoDS2+TwoDS3+TwoDS4+TwoDS5+TwoDS6+TwoDS7+TwoDS8+...
    TwoDS9+TwoDS10+TwoDS11+TwoDS12+TwoDS13+TwoDS14+TwoDS15+TwoDS16+TwoDS17+TwoDS18+...
    TwoDS19+TwoDS20+TwoDS21+TwoDS22+TwoDS23+TwoDS24+TwoDS25+TwoDS26+TwoDS27+TwoDS28+TwoDS29)));
% AllBinsTwoDS2 =(AllBinsTwoDS2*bin_diameter);
%  AllBinsTwoDS2(AllBinsTwoDS2>10000)=NaN;
% TwoDS_Nt=TwoDS_Nt*10^-12;

% TwoDS_Nt(TwoDS_Nt<10000)=NaN;
%  binddiameter=[10;10;10;10;10;10;10;10;10;10;20;20;30;50;50;50;75;75;25;75;75;100;100;100;200;200;200;200;200];
%  TwoDS_Nt=TwoDS_Nt*(10^-12*binddiameter);
sawtooth_timesteps_0906;
%% %-----Calculate 2DS LWC from 2DS size distribution-----%

%-----Put bin concentrations into size distribution matrix-----%
% channels=16;
 channels=29;
% % TwoDS_Nt=zeros(numel(timevec_twods),channels);
 AllChannels=zeros(numel(timevec_twods),channels);
 for k=9:37;
% for k=23:38;
      eval(sprintf('AllChannels(:,%d-8)=netcdf.getVar(ncid,%d);',k,k));
%      eval(sprintf('TwoDS_Nt(:,%d-8)=netcdf.getVar(ncid,%d);',k,k));
end
  AllChannels(AllChannels<0)=NaN;
 Correct2DS=AllChannels*(10^-12);
% TwoDS_Nt(TwoDS_Nt<0)=NaN;
 bin_min=[5;15;25;35;45;55;65;75;85;95;105;125;145;175;225;275;325;400;475;550;625;700;800;900;1000;1200;1400;1600;1800];
 bin_midpoint=[10;20;30;40;50;60;70;80;90;100;115;135;160;200;250;300;362.5;437.5;512.5;587.5;662.5;750;850;950;1100;1300;1500;1700;1900];
 bin_diameter=[10;10;10;10;10;10;10;10;10;10;20;20;30;50;50;50;75;75;25;75;75;100;100;100;200;200;200;200;200];

% TwoDS_Nt=TwoDS_Nt*binddiameter;
%%
%-----Sum of Droplet Number Concentration in each bin over time-----%

Normalsum1=nanmean(Correct2DS(sawtooth_1_twods));
Normalsum2=nanmean(Correct2DS(sawtooth_2_twods));
Normalsum3=nanmean(Correct2DS(sawtooth_3_twods));
Normalsum4=nanmean(Correct2DS(sawtooth_4_twods));




%-----Number distribution function = Number in each bin/bin width-----%

Normalbin1=Normalsum1./bin_min';
Normalbin2=Normalsum2./bin_min';
Normalbin3=Normalsum3./bin_min';
Normalbin4=Normalsum4./bin_min';

stairs(bin_min,Normalbin1);
hold all
stairs(bin_min,Normalbin2);
stairs(bin_min,Normalbin3);
stairs(bin_min,Normalbin4);

set(gca,'YScale','log','FontSize',17); % For sum
set(gca,'XScale','log','FontSize',17); % For sum

%-----Plot Cosmetics-----%
 eval(sprintf('title(''Mean TwoDS Size Distribution - Sawtooth - %6s'');',k,datestr(timevec_twods(1),2)));
xlabel('Diameter (\mum)','FontSize',20);
ylabel('Number Distribution Fuction  (cm^-^3 \mum^-^1)','FontSize',20);

legend('Sawtooth-1','Sawtooth-2', 'Sawtooth-3', 'Sawtooth-4');

