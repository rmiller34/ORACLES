%-----Sawtooth timesteps (According to altitude from IWG1 file)-----%
%-----Then added 827 because that is the start time of the summary file relative to the IWG1 file-----%
%-----Then subtracted 20s because that is the offset between the two files------%

% newsummary_start=827;

%-----Relative to IWG1-----%
% a_1a=6726+(newsummary_start)-sawtooth_1_offset:6851+(newsummary_start)-sawtooth_1_offset;

sawtooth_1=6925:6970;
sawtooth_2=10440:10520;
sawtooth_3=11859:11895;
sawtooth_4=12325:12400;
sawtooth_5=13210:13250;
sawtooth_6=16540:16610;
sawtooth_7=18113:18160;
sawtooth_8=18840:19420;

%% CAS
new_summary_start_cas=3;

sawtooth_1_cas=6925-(new_summary_start_cas-1):6970-(new_summary_start_cas-1);
sawtooth_2_cas=10440-(new_summary_start_cas-1):10520-(new_summary_start_cas-1);
sawtooth_3_cas=11859-(new_summary_start_cas-1):11895-(new_summary_start_cas-1);
sawtooth_4_cas=12325-(new_summary_start_cas-1):12400-(new_summary_start_cas-1);
sawtooth_5_cas=13210-(new_summary_start_cas-1):13250-(new_summary_start_cas-1);
sawtooth_6_cas=16540-(new_summary_start_cas-1):16610-(new_summary_start_cas-1);
sawtooth_7_cas=18113-(new_summary_start_cas-1):18160-(new_summary_start_cas-1);
sawtooth_8_cas=18840-(new_summary_start_cas-1):19420-(new_summary_start_cas-1);

%% PCASP

sawtooth_1_pcasp=6925:6970;
sawtooth_2_pcasp=10440:10520;
sawtooth_3_pcasp=11859:11895;
sawtooth_4_pcasp=12325:12400;
sawtooth_5_pcasp=13210:13250;
sawtooth_6_pcasp=16540:16610;
sawtooth_7_pcasp=18113:18160;
sawtooth_8_pcasp=18840:19420;

%% twods
new_twods_start=2;

sawtooth_1_twods=6925+(new_twods_start-1):6970+(new_twods_start-1);
sawtooth_2_twods=10440+(new_twods_start-1):10520+(new_twods_start-1);
sawtooth_3_twods=11859+(new_twods_start-1):11895+(new_twods_start-1);
sawtooth_4_twods=12325+(new_twods_start-1):12400+(new_twods_start-1);
sawtooth_5_twods=13210+(new_twods_start-1):13250+(new_twods_start-1);
sawtooth_6_twods=16540+(new_twods_start-1):16610+(new_twods_start-1);
sawtooth_7_twods=18113+(new_twods_start-1):18160+(new_twods_start-1);
sawtooth_8_twods=18840+(new_twods_start-1):19420+(new_twods_start-1);

%% AOD
new_summary_start_aod=1045;

sawtooth_1_aod=6925-(new_summary_start_aod-1):6970-(new_summary_start_aod-1);
sawtooth_2_aod=10440-(new_summary_start_aod-1):10520-(new_summary_start_aod-1);
sawtooth_3_aod=11859-(new_summary_start_aod-1):11895-(new_summary_start_aod-1);
sawtooth_4_aod=12325-(new_summary_start_aod-1):12400-(new_summary_start_aod-1);
sawtooth_5_aod=13210-(new_summary_start_aod-1):13250-(new_summary_start_aod-1);
sawtooth_6_aod=16540-(new_summary_start_aod-1):16610-(new_summary_start_aod-1);
sawtooth_7_aod=18113-(new_summary_start_aod-1):18160-(new_summary_start_aod-1);
sawtooth_8_aod=18840-(new_summary_start_aod-1):19420-(new_summary_start_aod-1);