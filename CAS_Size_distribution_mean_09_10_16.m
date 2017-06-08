%-----Read variables from ORACLES Summary file and IWG1 File-----%
ncid=netcdf.open('16_09_10_07_14_00.Combined.conc.cas.1Hz.nc');

%-----Read Unix time and convert to timevec for CAS file-----%
base_time_cas=netcdf.getVar(ncid,7);
time_offset_cas=netcdf.getVar(ncid,8);
offset_cas=[0:numel(time_offset_cas)-1]';
base_seconds_cas=offset_cas+double(base_time_cas);
timevec_cas=unix_to_timevec(base_seconds_cas);

%-----Read variables from CAS file-----%
cas_Nt=netcdf.getVar(ncid,39); % 3 to 50 microns
cas_Nt(cas_Nt>10000)=NaN;
cas_limit=10;
index1=find(cas_Nt<cas_limit);
sawtooth_timesteps_0910;
%% %-----Calculate CAS LWC from CAS size distribution-----%

%-----Put bin concentrations into size distribution matrix-----%
% channels=16;
channels=29;
cas_Nd=zeros(numel(timevec_cas),channels);
  for k=9:38;
% for k=23:38;
      eval(sprintf('cas_Nd(:,%d-8)=netcdf.getVar(ncid,%d);',k,k));
%      eval(sprintf('cas_Nd(:,%d-22)=netcdf.getVar(ncid,%d);',k,k));
end
cas_Nd(cas_Nd<0)=NaN;
cas_Nd(index1,:)=NaN;

 binmid=[0.575;0.645;0.715;0.785;0.855;0.925;0.995;1.065;1.135;1.21;1.375;1.75;2.25;2.75;3.25;3.75;4.5;5.75;6.85;7.55;9.05;11.35;13.75;17.5;22.5;27.5;32.5;37.5;42.5;47.5];
 bindd=[0.07;0.07;0.07;0.07;0.07;0.14;0.07;0.07;0.07;0.08;0.25;0.5;0.5;0.5;0.5;0.5;1;1.5;0.7;0.7;2.3;2.3;2.5;5;5;5;5;5;5;5];
%----Diameter of 3.25-47.5----%
% binmid=[3.25;3.75;4.5;5.75;6.85;7.55;9.05;11.35;13.75;17.5;22.5;27.5;32.5;37.5;42.5;47.5];
% bindd=[0.5;0.5;1;1.5;0.7;0.7;2.3;2.3;2.5;5;5;5;5;5;5;5];

%%
%-----Sum of Droplet Number Concentration in each bin over time-----%

Nsum1=nanmean(cas_Nd(sawtooth_1_cas,:));
Nsum2=nanmean(cas_Nd(sawtooth_2_cas,:));
Nsum3=nanmean(cas_Nd(sawtooth_3_cas,:));
Nsum4=nanmean(cas_Nd(sawtooth_4_cas,:));
Nsum5=nanmean(cas_Nd(sawtooth_5_cas,:));
Nsum6=nanmean(cas_Nd(sawtooth_6_cas,:));
Nsum7=nanmean(cas_Nd(sawtooth_7_cas,:));
Nsum8=nanmean(cas_Nd(sawtooth_8_cas,:));
% NSum=Nsum';

%-----Number distribution function = Number in each bin/bin width-----%

Nbin1=Nsum1./bindd';
Nbin2=Nsum2./bindd';
Nbin3=Nsum3./bindd';
Nbin4=Nsum4./bindd';
Nbin5=Nsum5./bindd';
Nbin6=Nsum6./bindd';
Nbin7=Nsum7./bindd';
Nbin8=Nsum8./bindd';

% for i=sawtooth_1_cas
% Nbin1(i,:)=cas_Nd(i,:)./bindd';
% end

% %-----Sum of Total Droplet Number Concentration over time-----%
% Nsum_2=sum(N);
% NSum_2=Nsum_2';

% %-----Number distribution function = Total Number/No. of bins x bin width-----%
% Nbin_2=NSum_2./(binlength.*bindd);
% xmarkers=binmid;
% ymarkers=Nbin_2;

%-----Total concentration divided into bins by binlength and width-----%
% stairs(binmid,Nbin_2);
%-----Total concentration in each bin divided by width-----%

% for i=sawtooth_1_cas
%     hold on
%     stairs(binmid,Nbin1(i,:),'r');
% end

stairs(binmid,Nbin1);
hold all
stairs(binmid,Nbin2);
stairs(binmid,Nbin3);
stairs(binmid,Nbin4);
stairs(binmid,Nbin5);
stairs(binmid,Nbin6);
stairs(binmid,Nbin7);
stairs(binmid,Nbin8);


set(gca,'YScale','log','FontSize',17); % For sum
% set(gca,'FontSize',17); % For mean
%-----For 0-50um bins-----%
% ylim([1 10000]);
%-----For 0-900um bins-----%
% xlim([0 900]);

%-----Plot Cosmetics-----%
eval(sprintf('title(''Mean CAS Size Distribution- %10s'');',k,datestr(timevec_cas(1),2)));
xlabel('Diameter (\mum)','FontSize',20);
ylabel('Number Distribution Fuction [N_d] (cm^-^3 \mum^-^1)','FontSize',20);
legend('Sawtooth-1','Sawtooth-2', 'Sawtooth-3', 'Sawtooth-4','Sawtooth-5','Sawtooth-6', 'Sawtooth-7', 'Sawtooth-8');
clearvars sawtooth*

%-----Saving plot-----%
% fig=gcf;
% set(gcf,'PaperUnits','centimeters','PaperPosition',[0 0 60 40])
% saveas(gcf,['oracles_' sprintf('%s',datestr(timevec_cas(1),'yyyymmdd')) '_sawtooth1-4_casNd_mean.jpeg']);

