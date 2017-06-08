%-----Sawtooth timesteps (According to altitude from IWG1 file)-----%
%-----Then added 827 because that is the start time of the summary file relative to the IWG1 file-----%
%-----Then subtracted 20s because that is the offset between the two files------%

newsummary_start=827;

% sawtooth_1_offset=21;
% sawtooth_2_offset=22;
% sawtooth_3_offset=22;
% sawtooth_4_offset=23;
% 
% %-----Relative to IWG1-----%
% a_1a=6726+(newsummary_start)-sawtooth_1_offset:6851+(newsummary_start)-sawtooth_1_offset;

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
%% CAS
new_summary_start_cas=555;

sawtooth_1a_cas=7532-(new_summary_start_cas-1):7650-(new_summary_start_cas-1);
sawtooth_1b_cas=7650-(new_summary_start_cas-1):7765-(new_summary_start_cas-1);
sawtooth_1c_cas=7765-(new_summary_start_cas-1):7945-(new_summary_start_cas-1);
sawtooth_1d_cas=7945-(new_summary_start_cas-1):8085-(new_summary_start_cas-1);
sawtooth_1e_cas=8085-(new_summary_start_cas-1):8212-(new_summary_start_cas-1);
sawtooth_1_cas=7532-(new_summary_start_cas-1):8212-(new_summary_start_cas-1);

sawtooth_2a_cas=12622-(new_summary_start_cas-1):12752-(new_summary_start_cas-1);
sawtooth_2b_cas=12752-(new_summary_start_cas-1):12892-(new_summary_start_cas-1);
sawtooth_2c_cas=12892-(new_summary_start_cas-1):13022-(new_summary_start_cas-1);
sawtooth_2d_cas=13022-(new_summary_start_cas-1):13152-(new_summary_start_cas-1);
sawtooth_2e_cas=13152-(new_summary_start_cas-1):13292-(new_summary_start_cas-1);
sawtooth_2_cas=12622-(new_summary_start_cas-1):13292-(new_summary_start_cas-1);

sawtooth_3a_cas=15942-(new_summary_start_cas-1):16102-(new_summary_start_cas-1);
sawtooth_3b_cas=16102-(new_summary_start_cas-1):16292-(new_summary_start_cas-1);
sawtooth_3c_cas=16292-(new_summary_start_cas-1):16462-(new_summary_start_cas-1);
sawtooth_3d_cas=16462-(new_summary_start_cas-1):16632-(new_summary_start_cas-1);
sawtooth_3e_cas=16632-(new_summary_start_cas-1):16842-(new_summary_start_cas-1);
sawtooth_3_cas=15942-(new_summary_start_cas-1):16842-(new_summary_start_cas-1);

sawtooth_4a_cas=23662-(new_summary_start_cas-1):23752-(new_summary_start_cas-1);
sawtooth_4b_cas=23752-(new_summary_start_cas-1):23882-(new_summary_start_cas-1);
sawtooth_4c_cas=23882-(new_summary_start_cas-1):24022-(new_summary_start_cas-1);
sawtooth_4d_cas=24022-(new_summary_start_cas-1):24152-(new_summary_start_cas-1);
sawtooth_4e_cas=24152-(new_summary_start_cas-1):24302-(new_summary_start_cas-1);
sawtooth_4f_cas=24302-(new_summary_start_cas-1):24422-(new_summary_start_cas-1);
sawtooth_4_cas=23662-(new_summary_start_cas-1):24422-(new_summary_start_cas-1);
%% PCASP
new_summary_start_pcasp=68;

sawtooth_1a_pcasp=7532-(new_summary_start_pcasp-1):7650-(new_summary_start_pcasp-1);
sawtooth_1b_pcasp=7650-(new_summary_start_pcasp-1):7765-(new_summary_start_pcasp-1);
sawtooth_1c_pcasp=7765-(new_summary_start_pcasp-1):7945-(new_summary_start_pcasp-1);
sawtooth_1d_pcasp=7945-(new_summary_start_pcasp-1):8085-(new_summary_start_pcasp-1);
sawtooth_1e_pcasp=8085-(new_summary_start_pcasp-1):8212-(new_summary_start_pcasp-1);
sawtooth_1_pcasp=7532-(new_summary_start_pcasp-1):8212-(new_summary_start_pcasp-1);

sawtooth_2a_pcasp=12622-(new_summary_start_pcasp-1):12752-(new_summary_start_pcasp-1);
sawtooth_2b_pcasp=12752-(new_summary_start_pcasp-1):12892-(new_summary_start_pcasp-1);
sawtooth_2c_pcasp=12892-(new_summary_start_pcasp-1):13022-(new_summary_start_pcasp-1);
sawtooth_2d_pcasp=13022-(new_summary_start_pcasp-1):13152-(new_summary_start_pcasp-1);
sawtooth_2e_pcasp=13152-(new_summary_start_pcasp-1):13292-(new_summary_start_pcasp-1);
sawtooth_2_pcasp=12622-(new_summary_start_pcasp-1):13292-(new_summary_start_pcasp-1);

sawtooth_3a_pcasp=15942-(new_summary_start_pcasp-1):16102-(new_summary_start_pcasp-1);
sawtooth_3b_pcasp=16102-(new_summary_start_pcasp-1):16292-(new_summary_start_pcasp-1);
sawtooth_3c_pcasp=16292-(new_summary_start_pcasp-1):16462-(new_summary_start_pcasp-1);
sawtooth_3d_pcasp=16462-(new_summary_start_pcasp-1):16632-(new_summary_start_pcasp-1);
sawtooth_3e_pcasp=16632-(new_summary_start_pcasp-1):16842-(new_summary_start_pcasp-1);
sawtooth_3_pcasp=15942-(new_summary_start_pcasp-1):16842-(new_summary_start_pcasp-1);

sawtooth_4a_pcasp=23662-(new_summary_start_pcasp-1):23752-(new_summary_start_pcasp-1);
sawtooth_4b_pcasp=23752-(new_summary_start_pcasp-1):23882-(new_summary_start_pcasp-1);
sawtooth_4c_pcasp=23882-(new_summary_start_pcasp-1):24022-(new_summary_start_pcasp-1);
sawtooth_4d_pcasp=24022-(new_summary_start_pcasp-1):24152-(new_summary_start_pcasp-1);
sawtooth_4e_pcasp=24152-(new_summary_start_pcasp-1):24302-(new_summary_start_pcasp-1);
sawtooth_4f_pcasp=24302-(new_summary_start_pcasp-1):24422-(new_summary_start_pcasp-1);
sawtooth_4_pcasp=23662-(new_summary_start_pcasp-1):24422-(new_summary_start_pcasp-1);
%% twods
new_twods_start=2;

sawtooth_1a_twods=7532+(new_twods_start-1):7650+(new_twods_start-1);
sawtooth_1b_twods=7650+(new_twods_start-1):7765+(new_twods_start-1);
sawtooth_1c_twods=7765+(new_twods_start-1):7945+(new_twods_start-1);
sawtooth_1d_twods=7945+(new_twods_start-1):8085+(new_twods_start-1);
sawtooth_1e_twods=8085+(new_twods_start-1):8212+(new_twods_start-1);
sawtooth_1_twods=7532+(new_twods_start-1):8212+(new_twods_start-1);

sawtooth_2a_twods=12622+(new_twods_start-1):12752+(new_twods_start-1);
sawtooth_2b_twods=12752+(new_twods_start-1):12892+(new_twods_start-1);
sawtooth_2c_twods=12892+(new_twods_start-1):13022+(new_twods_start-1);
sawtooth_2d_twods=13022+(new_twods_start-1):13152+(new_twods_start-1);
sawtooth_2e_twods=13152+(new_twods_start-1):13292+(new_twods_start-1);
sawtooth_2_twods=12622+(new_twods_start-1):13292+(new_twods_start-1);

sawtooth_3a_twods=15942+(new_twods_start-1):16102+(new_twods_start-1);
sawtooth_3b_twods=16102+(new_twods_start-1):16292+(new_twods_start-1);
sawtooth_3c_twods=16292+(new_twods_start-1):16462+(new_twods_start-1);
sawtooth_3d_twods=16462+(new_twods_start-1):16632+(new_twods_start-1);
sawtooth_3e_twods=16632+(new_twods_start-1):16842+(new_twods_start-1);
sawtooth_3_twods=15942+(new_twods_start-1):16842+(new_twods_start-1);

sawtooth_4a_twods=23662+(new_twods_start-1):23752+(new_twods_start-1);
sawtooth_4b_twods=23752+(new_twods_start-1):23882+(new_twods_start-1);
sawtooth_4c_twods=23882+(new_twods_start-1):24022+(new_twods_start-1);
sawtooth_4d_twods=24022+(new_twods_start-1):24152+(new_twods_start-1);
sawtooth_4e_twods=24152+(new_twods_start-1):24302+(new_twods_start-1);
sawtooth_4f_twods=24302+(new_twods_start-1):24422+(new_twods_start-1);
sawtooth_4_twods=23662+(new_twods_start-1):24422+(new_twods_start-1);
%% AOD
new_summary_start_aod=812;

sawtooth_1a_aod=7532-(new_summary_start_aod-1):7650-(new_summary_start_aod-1);
sawtooth_1b_aod=7650-(new_summary_start_aod-1):7765-(new_summary_start_aod-1);
sawtooth_1c_aod=7765-(new_summary_start_aod-1):7945-(new_summary_start_aod-1);
sawtooth_1d_aod=7945-(new_summary_start_aod-1):8085-(new_summary_start_aod-1);
sawtooth_1e_aod=8085-(new_summary_start_aod-1):8212-(new_summary_start_aod-1);
sawtooth_1_aod=7532-(new_summary_start_aod-1):8212-(new_summary_start_aod-1);

sawtooth_2a_aod=12622-(new_summary_start_aod-1):12752-(new_summary_start_aod-1);
sawtooth_2b_aod=12752-(new_summary_start_aod-1):12892-(new_summary_start_aod-1);
sawtooth_2c_aod=12892-(new_summary_start_aod-1):13022-(new_summary_start_aod-1);
sawtooth_2d_aod=13022-(new_summary_start_aod-1):13152-(new_summary_start_aod-1);
sawtooth_2e_aod=13152-(new_summary_start_aod-1):13292-(new_summary_start_aod-1);
sawtooth_2_aod=12622-(new_summary_start_aod-1):13292-(new_summary_start_aod-1);

sawtooth_3a_aod=15942-(new_summary_start_aod-1):16102-(new_summary_start_aod-1);
sawtooth_3b_aod=16102-(new_summary_start_aod-1):16292-(new_summary_start_aod-1);
sawtooth_3c_aod=16292-(new_summary_start_aod-1):16462-(new_summary_start_aod-1);
sawtooth_3d_aod=16462-(new_summary_start_aod-1):16632-(new_summary_start_aod-1);
sawtooth_3e_aod=16632-(new_summary_start_aod-1):16842-(new_summary_start_aod-1);
sawtooth_3_aod=15942-(new_summary_start_aod-1):16842-(new_summary_start_aod-1);

sawtooth_4a_aod=23662-(new_summary_start_aod-1):23752-(new_summary_start_aod-1);
sawtooth_4b_aod=23752-(new_summary_start_aod-1):23882-(new_summary_start_aod-1);
sawtooth_4c_aod=23882-(new_summary_start_aod-1):24022-(new_summary_start_aod-1);
sawtooth_4d_aod=24022-(new_summary_start_aod-1):24152-(new_summary_start_aod-1);
sawtooth_4e_aod=24152-(new_summary_start_aod-1):24302-(new_summary_start_aod-1);
sawtooth_4f_aod=24302-(new_summary_start_aod-1):24422-(new_summary_start_aod-1);
sawtooth_4_aod=23662-(new_summary_start_aod-1):24422-(new_summary_start_aod-1);