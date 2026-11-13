clear
close all

%masterFolder='/Users/grazianamodica/Biophotonics Dropbox/Graziana Modica/Graziana Data/siRNA/ForFociAnalysis/siRNA_80pmol_noZeo';

%masterFolder='/Users/grazianamodica/Biophotonics Dropbox/Graziana Modica/Graziana Data/SpIDAing/SpIDA_Data_Curated/SpIDA_St_07032023_hexa/QBAnalysis/mEGFPHA';

%masterFolder='/Users/grazianamodica/Biophotonics Dropbox/Graziana Modica/Graziana Data/SpIDAing/SpIDA_Data_Curated/SpIDA_St1_26012023/53BP1/53BP1GFP/01000';

%masterFolder='/Users/grazianamodica/Biophotonics Dropbox/Graziana Modica/Graziana Data/SpIDAing/SpIDA_Data_Curated/SpIDA_St1_26012023/mEGFPHA/rep4';

%masterFolder='/Users/grazianamodica/Biophotonics Dropbox/Graziana Modica/Graziana Data/SpIDAing/SpIDA_Data_Curated/Graziana/SpIDA_St1_23Dec2022_BRCA1_IR/Foci analysis/3 hours/15GY';

%masterFolder='/Users/grazianamodica/Biophotonics Dropbox/Graziana Modica/Graziana Data/SpIDAing/SpIDA_Data_Curated/Graziana/SpiDA_St1_02Dec2022_BRCA1/FociAnalysis/GFPBRCA1/GFPBRCA1/Zeocin05000';

%masterFolder='/Users/grazianamodica/Biophotonics Dropbox/Graziana Modica/Graziana Data/SpIDAing/SpIDA_Data_Curated/Graziana/SpiDA_St1_09Nov2022/GFPBRCA1_Alexa53BP1/GFPBRCA1/Zeocin05000';

%masterFolder='/Users/grazianamodica/Biophotonics Dropbox/Graziana Modica/Graziana Data/SpIDAing/SpIDA_Data_Curated/Graziana/SpIDA_St1_23Dec2022_BRCA1_IR_647Gain2/Foci analysis/1 hour/15GY';

%masterFolder='/Users/grazianamodica/Biophotonics Dropbox/Graziana Modica/Graziana Data/SpIDAing/SpIDA_Data_Curated/Graziana/SpIDA_St1_17072023_NuMA_GM/foci analysis/Zeo00500_NuMA';
%masterFolder='/Users/grazianamodica/Biophotonics Dropbox/Graziana Modica/Graziana Data/SpIDAing/SpIDA_Data_Curated/SpIDA_St1_02May2023_NuMA/FociAnalysis/Zeo00500_NoNuMA';

%masterFolder='/Users/grazianamodica/Biophotonics Dropbox/Graziana Modica/Graziana Data/SpIDAing/SpIDA_Data_Curated/Graziana/SpIDA_St1_21July2023_siRNA/Foci analysis/Zeo_000_siRNA00';
%masterFolder='/Users/grazianamodica/Biophotonics Dropbox/Graziana Modica/Graziana Data/SpIDAing/SpIDA_Data_Curated/Graziana/SpIDA_St1_21July2023_siRNA/Foci analysis/Zeo_500_siRNA_scr';
%masterFolder='/Users/grazianamodica/Biophotonics Dropbox/Graziana Modica/Graziana Data/SpIDAing/SpIDA_Data_Curated/Graziana/SpIDA_St1_21July2023_siRNA/Foci analysis/Zeo_500_siRNA0pt1';
%masterFolder='/Users/grazianamodica/Biophotonics Dropbox/Graziana Modica/Graziana Data/SpIDAing/SpIDA_Data_Curated/Graziana/SpIDA_St1_21July2023_siRNA/Foci analysis/Zeo_500_siRNA0pt01';
%masterFolder='/Users/grazianamodica/Biophotonics Dropbox/Graziana Modica/Graziana Data/SpIDAing/SpIDA_Data_Curated/Graziana/SpIDA_St1_21July2023_siRNA/Foci analysis/Zeo_500_siRNA01';
%masterFolder='/Users/grazianamodica/Biophotonics Dropbox/Graziana Modica/Graziana Data/SpIDAing/SpIDA_Data_Curated/Graziana/SpIDA_St1_21July2023_siRNA/Foci analysis/Zeo_500_siRNA_05';
%masterFolder='/Users/grazianamodica/Biophotonics Dropbox/Graziana Modica/Graziana Data/SpIDA check these folders/SpIDA_St1_14Aug2023/foci analysis/U2OS_Zeo500';
%masterFolder='/Users/grazianamodica/Biophotonics Dropbox/Graziana Modica/Graziana Data/SpIDA check these folders/foci to run/U2OS_Zeo000';

%masterFolder='/Users/grazianamodica/Biophotonics Dropbox/Graziana Modica/Graziana Data/SpIDA figures/23aug2023/foci analysis/U2OS_75_Zeo500';

%masterFolder='/Users/grazianamodica/Biophotonics Dropbox/Graziana Modica/Graziana Data/SpIDA figures/23aug2023/foci analysis_70/U2OS_70_Zeo500';

%masterFolder='/Users/grazianamodica/Biophotonics Dropbox/Graziana Modica/Graziana Data/SpIDA figures/23aug2023/foci/U2OS_Zeo500';

%masterFolder='/Users/grazianamodica/Biophotonics Dropbox/Graziana Modica/Graziana Data/SpIDA figures/Experiments/SpIDA_St1_28Aug2023/mEGFPHA_5min_30K';

%masterFolder='/Users/grazianamodica/Biophotonics Dropbox/Graziana Modica/Graziana Data/SpIDA figures/Experiments/SpIDA_St1_28Aug2023/foci analysis/U2OS/U2OS_NuMA_Zeo500';
%masterFolder='/Users/grazianamodica/Biophotonics Dropbox/Graziana Modica/Graziana Data/SpIDA figures/Experiments/SpIDA_St1_28Aug2023/NuMA 53BP1GFP/Foci/Zeo500';
%masterFolder='/Users/grazianamodica/Biophotonics Dropbox/Graziana Modica/Graziana Data/SpIDA figures/Experiments/SpIDA_St1_28Aug2023/NuMA 53BP1GFP/Foci/Zeo500_2';
%masterFolder='/Users/grazianamodica/Biophotonics Dropbox/Graziana Modica/Graziana Data/SpIDA figures/Experiments/SpIDA_St1_28Aug2023/NuMA 53BP1GFP/Foci/NuMA_Zeo000/NuMa_Zeo000_3';

%masterFolder='/Users/grazianamodica/Biophotonics Dropbox/Graziana Modica/Graziana Data/SpIDA figures/Experiments/SpIDA_St1_14Sept2023_challenge/foci analysis/53BP1GFP_Zeo500';
%masterFolder='/Users/grazianamodica/Biophotonics Dropbox/Graziana Modica/Graziana Data/SpIDA figures/Experiments/SpIDA_St1_14Sept2023_challenge/53BP1GFP/foci analysis/53BP1GFP_Zeo01000';
%masterFolder='/Users/grazianamodica/Biophotonics Dropbox/Graziana Modica/Graziana Data/SpIDA figures/Experiments/SpIDA_St1_21Sept2023_challenge/foci/53BP1GFP_Zeo00500';
%masterFolder='/Users/grazianamodica/Biophotonics Dropbox/Graziana Modica/Graziana Data/SpIDA figures/Experiments/SpIDA_St1_14Sept2023_Rif/53BP1GFP_Zeo00500';
%masterFolder='/Users/grazianamodica/Biophotonics Dropbox/Graziana Modica/Graziana Data/SpIDA figures/Experiments/SpIDA_St1_03102023_Challenge/foci/53BP1GFP_Zeo00500';

%masterFolder='/Users/grazianamodica/Biophotonics Dropbox/Graziana Modica/Graziana Data/SpIDA figures/Experiments/SpIDA_St1_05Oct2023_555/foci/53BP1GFP_Zeo00500';
%masterFolder='/Users/grazianamodica/Biophotonics Dropbox/Graziana Modica/Graziana Data/SpIDA figures/Experiments/challenge 24112023/Foci/53BP1GFP_Zeo00500';
%masterFolder='/Users/grazianamodica/Biophotonics Dropbox/Graziana Modica/Graziana Data/SpIDA figures/Experiments/Challenge05122023/16bits/zeocin0500';
%masterFolder='/Users/grazianamodica/Biophotonics Dropbox/Graziana Modica/Graziana Data/SpIDA figures/Experiments/SpIDA_St1_29Nov2023_Rif1 maybe/foci/53BP1GFP_Zeo00500';
%masterFolder='/Users/grazianamodica/Biophotonics Dropbox/Graziana Modica/Graziana Data/SpIDA figures/Experiments/14Dec2023/foci/Zeo00500';
%masterFolder='/Users/grazianamodica/Biophotonics Dropbox/Graziana Modica/Graziana Data/SpIDA figures/Experiments/Zeo Challenge/SpIDA_St1_14Dec2023_Challenge/Foci/Zeo_01000';
%masterFolder='/Users/grazianamodica/Biophotonics Dropbox/Graziana Modica/Graziana Data/SpIDA figures/Experiments/SpIDA_St1_19Dec2023_546/Foci/Zeo_500';
%masterFolder='/Users/grazianamodica/Biophotonics Dropbox/Graziana Modica/Graziana Data/SpIDA figures/Experiments/SpIDA_St1_20Dec2023/Foci/Zeo_500';
%masterFolder='/Users/grazianamodica/Biophotonics Dropbox/Graziana Modica/Graziana Data/SpIDA figures/Experiments/SpIDA_St1_19Dec2023_Rif1/Foci/Zeo_500';
%masterFolder='/Users/grazianamodica/Biophotonics Dropbox/Graziana Modica/Graziana Data/SpIDA figures/Experiments/RIF1/SpIDA_St1_19Dec2023_Rif1/Foci/Zeo_000';
%masterFolder='/Users/grazianamodica/Biophotonics Dropbox/Graziana Modica/Graziana Data/SpIDA figures/Experiments/RIF1/SpIDA_St1_21Dec2023_Rif1/Foci/Zeo_500';
%masterFolder='/Users/grazianamodica/Biophotonics Dropbox/Graziana Modica/Graziana Data/SpIDA figures/Experiments/SpIDA_St1_29Nov_2023/Foci/Zeo_500';
%masterFolder='/Users/grazianamodica/Biophotonics Dropbox/Graziana Modica/Graziana Data/SpIDAing/SpIDA_St1_03Jan2024_rif&U2OS/Foci/Zeo_500';
% masterFolder='/Users/grazianamodica/Biophotonics Dropbox/Graziana Modica/Graziana Data/SpIDA figures/Experiments/SpIDA_St1_14Jan2024_clone2/Foci/Zeo_500_4K';
%masterFolder='/Users/grazianamodica/Biophotonics Dropbox/Graziana Modica/Graziana Data/SpIDA figures/SpIDA_St1_11Jan2024_U2OS/U2OS/Rb647_1_500/Foci/Zeo_500_500_800';
%masterFolder='/Users/grazianamodica/Biophotonics Dropbox/Graziana Modica/Graziana Data/SpIDA figures/SpIDA_St1_11Jan2024_U2OS/U2OS/Rb647_1_1000/Foci/Zeo_000_1000_800';
%masterFolder='/Volumes/joannie/SpiDA/Station13/22Jan2024/53BP1_500';
%masterFolder='/Users/grazianamodica/Biophotonics Dropbox/Graziana Modica/Graziana Data/SpIDA figures/St13/Imaged23Jan2024/IF19Jan2024_siRNA_500_eGFPHA/siRNA_UNT/siRNA_UNTSingle Channel';
%masterFolder='/Users/grazianamodica/Biophotonics Dropbox/Graziana Modica/Graziana Data/SpIDA figures/SpIDA_St1_25012024/Foci/Zeo_500';
%masterFolder='/Users/grazianamodica/Biophotonics Dropbox/Graziana Modica/Graziana Data/SpIDA figures/SpIDA_St_1_27Jan2024_siRNA/Foci/siRNA_5nM_Zeo_000';
%masterFolder='/Users/grazianamodica/Biophotonics Dropbox/Graziana Modica/Graziana Data/SpIDA figures/SpIDA_St1_25012024/Foci/Zeo_000';
%masterFolder='/Users/grazianamodica/Biophotonics Dropbox/Graziana Modica/Graziana Data/SpIDA figures/SpIDA_St1_01Feb2024_challenge/Foci/Zeo_000';
%masterFolder='/Users/grazianamodica/Biophotonics Dropbox/Graziana Modica/Graziana Data/SpIDA figures/SpIDA_St1_02Febr2024_rif1_Ab_titr/Foci/Zeo_500_1000';
%masterFolder='/Users/grazianamodica/Biophotonics Dropbox/Graziana Modica/Graziana Data/SpIDA figures/SpIDA_St_1_02Feb2024_challenge_rif1/Foci/Zeo_01000';
%masterFolder='/Users/grazianamodica/Biophotonics Dropbox/Graziana Modica/Graziana Data/SpIDA figures/Experiments/Clone 4K/SpIDA_St1_02Feb2024_siRNA_GFPvsRIf1/Foci/5nM_Zeo_500';
% masterFolder='/Users/grazianamodica/Biophotonics Dropbox/Graziana Modica/Graziana Data/SpIDA figures/Experiments/Clone 4K/SpIDA_St1_09Feb2024_Challenge_53BP1vsRIF1/Foci/Zeo_00250';
%masterFolder='/Users/grazianamodica/Biophotonics Dropbox/Graziana Modica/Graziana Data/SpIDA figures/Experiments/SpIDA_St1_09Feb2024_rif1_Ab_titr/Foci/Rif1_250_Zeo_500';
% masterFolder='/Users/grazianamodica/Biophotonics Dropbox/Graziana Modica/Graziana Data/SpIDA figures/Experiments/Clone 4K/SpiDA_S1_14Feb2023_challenge_53BP1vsRIF1/Foci/Zeo_01000';
%masterFolder='/Users/grazianamodica/Biophotonics Dropbox/Graziana Modica/Graziana Data/SpIDA figures/Experiments/Clone 4K/siRNA/SpIDA_St1_16Febr2024_siRNA_rif1/Foci/scr_Zeo_500';
% masterFolder='/Users/grazianamodica/Biophotonics Dropbox/Graziana Modica/Graziana Data/SpIDA figures/Experiments/Clone 4K/SpIDA_St1_14Feb2024_gfpvs546/Foci/Zeo_000';
% masterFolder='/Users/grazianamodica/Biophotonics Dropbox/Graziana Modica/Graziana Data/SpIDA figures/Experiments/Clone 4K/SpIDA_23Febr2024_Rif1_546vs647/546/Foci/Zeo_500';
% masterFolder='/Users/grazianamodica/Biophotonics Dropbox/Graziana Modica/Graziana Data/SpIDA figures/Experiments/Clone 4K/SpIDA_St1_21Febr2024_Challenge/Foci/Zeo_01000';
% masterFolder='/Users/grazianamodica/Biophotonics Dropbox/Graziana Modica/Graziana Data/SpIDA figures/Experiments/Clone 4K/SpIDA_St1_23Febr2024_53bp1gfpvs546/Foci/Zeo_000';
%masterFolder='/Users/grazianamodica/Biophotonics Dropbox/Graziana Modica/Graziana Data/SpIDA figures/Experiments/Clone 4K/SpIDA_St1_01March2024_Challenge/Foci/Zeo_05000';
% masterFolder='/Users/grazianamodica/Biophotonics Dropbox/Graziana Modica/Graziana Data/SpIDA figures/Experiments/Clone 4K/SpIDA_St1_01March2024_Rif1_546/Foci/Zeo_500';
% masterFolder='/Users/grazianamodica/Biophotonics Dropbox/Graziana Modica/Graziana Data/SpIDA figures/Experiments/Clone 4K/SpIDA_St1_08March2024_Chall_siRNA/Foci/Zeo_00500';

% masterFolder='/Users/grazianamodica/Biophotonics Dropbox/Graziana Modica/Graziana Data/SpIDA figures/Experiments/Clone 4K/SpIDA_St1_08March2024_Chall_siRNA/siRNA_Foci/scr_Zeo_500';
% masterFolder='/Users/grazianamodica/Biophotonics Dropbox/Graziana Modica/Graziana Data/SpIDA figures/Experiments/Clone 4K/SpIDA_St1_08March2024_Chall_siRNA/Foci/Zeo_05000';
% masterFolder='/Users/grazianamodica/Biophotonics Dropbox/Graziana Modica/Graziana Data/SpIDA figures/Experiments/Clone 4K/SpIDA_St1_21March2024_53bp1gfpvs546/Foci/rif1_Zeo_500';

%masterFolder='/Users/grazianamodica/Biophotonics Dropbox/Graziana Modica/Graziana Data/SpIDA figures/Experiments/Clone 4K/SpIDA_St1_01March2024_siRNA/Foci/UN_Zeo_500';

% masterFolder='/Users/grazianamodica/Biophotonics Dropbox/Graziana Modica/Graziana Data/SpIDA figures/Experiments/Clone 4K/SpIDA_St1_01March2024_gfpvs546/Foci/Zeo_500';
% masterFolder='/Users/grazianamodica/Biophotonics Dropbox/Graziana Modica/Graziana Data/SpIDA figures/Experiments/Clone 4K/SpIDA_St1_03Apr2024_647_546/Foci/Zeo_500';
% masterFolder='/Users/grazianamodica/Biophotonics Dropbox/Graziana Modica/Graziana Data/SpIDA figures/Experiments/Clone 4K/SpIDA_St1_11Apr2024_53bp1gfpvs647/Foci/Zeo_500';
% masterFolder='/Users/grazianamodica/Biophotonics Dropbox/Graziana Modica/Graziana Data/SpIDA figures/Experiments/Clone 4K/SpIDA_St1_18April2024_53BP1GFPvs647/Foci/Zeo_500';
% masterFolder='/Users/grazianamodica/Biophotonics Dropbox/Graziana Modica/Graziana Data/SpIDA figures/Experiments/Clone 4K/SpIDA_St1_19April2024_53BP1GFPvs647/Foci/Zeo_500';
% masterFolder='/Users/grazianamodica/Biophotonics Dropbox/Graziana Modica/Graziana Data/SpIDA figures/Experiments/Clone 4K/SpIDA_St1_19April2024_GFPvs546/Foci/Zeo_500';
% masterFolder='/Users/grazianamodica/Biophotonics Dropbox/Graziana Modica/Graziana Data/SpIDA figures/Experiments/Clone 4K/SpIDA_St1_22April2024_53BP1GFPvs647/Foci/Zeo_500'
% masterFolder='/Users/grazianamodica/Biophotonics Dropbox/Graziana Modica/Graziana Data/SpIDA figures/Experiments/Clone 4K/SpIDA_St1_03Apr2024_647_546/Foci/Zeo_000';
% masterFolder='/Users/grazianamodica/Biophotonics Dropbox/Graziana Modica/Graziana Data/SpIDA figures/Experiments/Clone 4K/SpIDA_St1_25Apr2024_53bp1gfpvs647/Foci/Zeo_500';
% masterFolder='/Users/grazianamodica/Biophotonics Dropbox/Graziana Modica/Graziana Data/SpIDA figures/Experiments/Clone 4K/SpIDA_St1_26April2024_gfpvs647_II/Foci/Zeo_500';
% masterFolder='/Users/grazianamodica/Biophotonics Dropbox/Graziana Modica/Graziana Data/SpIDA figures/Experiments/Clone 4K/SpIDA_St1_25Apr2024_53bp1gfpvs647/Foci/Zeo_000';
% masterFolder='/Users/grazianamodica/Biophotonics Dropbox/Graziana Modica/Graziana Data/SpIDA figures/Experiments/Clone 4K/SpIDA_St1_26April2024_gfpvs647_II/Foci/Zeo_000';
% masterFolder='/Users/grazianamodica/Biophotonics Dropbox/Graziana Modica/Graziana Data/SpIDA figures/Experiments/Clone 4K/SpIDA_St1_02Dec2024_53BP1_Rif1_ATMinhib/Foci/Zeo_000';
% masterFolder='/Users/grazianamodica/Biophotonics Dropbox/Graziana Modica/Graziana Data/SpIDA figures/Experiments/Clone 4K/SpIDA_St1_05Dec2024_Gy_Challenge/Foci/GY_0pt5';
% masterFolder='/Users/grazianamodica/Biophotonics Dropbox/Graziana Modica/Graziana Data/SpIDA figures/Experiments/Clone 4K/SpIDA_St1_11Dec2024_Gy_Challenge/Foci/GY_00_1';
% masterFolder='/Users/grazianamodica/Biophotonics Dropbox/Graziana Modica/Graziana Data/SpIDA figures/Experiments/Clone 4K/SpIDA_St1_11Dec2024_GY_0pt5_recovery/Foci/0pt5GY_0HR45min';
% masterFolder='/Users/grazianamodica/Biophotonics Dropbox/Graziana Modica/Graziana Data/SpIDA figures/Experiments/Clone 4K/SpIDA_St1_24Dec2024_ATMinhibitor/Foci/Zeo_500_5uM';
%masterFolder='/Users/grazianamodica/Biophotonics Dropbox/Graziana Modica/Graziana Data/SpIDA figures/Experiments/Clone 4K/SpIDA_St1_03Jan2025_ATMInhibitor/Foci/Zeo_500_10uM';
% masterFolder='/Users/grazianamodica/Biophotonics Dropbox/Graziana Modica/Graziana Data/SpIDA figures/Experiments/Clone 4K/SpIDA_St1_09Jan_2025_GYChallenge/Foci/GY_08';
% masterFolder='/Users/grazianamodica/Biophotonics Dropbox/Graziana Modica/Graziana Data/SpIDA figures/Experiments/Clone 4K/SpIDA_St1_09Jan2025_GY_recovery/Foci/0pt5_GY_3HR';
% masterFolder='/Users/grazianamodica/Biophotonics Dropbox/Graziana Modica/Graziana Data/SpIDA figures/Experiments/Clone 4K/SpIDA_St1_10Jan2025_ATMInhibitor/Foci/Zeo_500_ATM5uM';
% masterFolder='/Users/grazianamodica/Biophotonics Dropbox/Graziana Modica/Graziana Data/SpIDA figures/Experiments/Clone 4K/SpIDA_St1_21Jan2025_RPA/Foci/Zeo_500';
% masterFolder='/Users/grazianamodica/Biophotonics Dropbox/Graziana Modica/Graziana Data/SpIDA figures/Experiments/Clone 4K/SpIDA_St1_21Jan2025_RPA/Foci/Zeo_500_5nM';
% masterFolder='/Users/grazianamodica/Biophotonics Dropbox/Graziana Modica/Graziana Data/SpIDA figures/Experiments/Clone 4K/SpIDA_St1_29Jan2025_ATM/Foci/Zeo_500';
% masterFolder='/Users/grazianamodica/Biophotonics Dropbox/Graziana Modica/Graziana Data/SpIDA figures/Experiments/Clone 4K/SpIDA_St1_06Feb2025_siRNA_RPA/Foci/Zeo_500_scr';
% masterFolder='/Users/grazianamodica/Biophotonics Dropbox/Graziana Modica/Graziana Data/SpIDA figures/Experiments/Clone 4K/SpIDA_St1_12022025_ATMInh/Foci/Zeo_500_ATM10uM';
% masterFolder='/Users/grazianamodica/Biophotonics Dropbox/Graziana Modica/Graziana Data/SpIDA figures/Experiments/Clone 4K/SpIDA_14Febr2025_siRNA_RPA/Foci/Zeo_500_SCR';
% masterFolder='/Users/grazianamodica/Biophotonics Dropbox/Graziana Modica/Graziana Data/SpIDA figures/Experiments/Clone 4K/SpIDA_St1_20Feb2025_siRNA_RPA/Foci/Zeo_500_5nM_2';
masterFolder='/Users/grazianamodica/Biophotonics Dropbox/Graziana Modica/Graziana Data/SpIDA figures/Experiments/Clone 4K/SpIDA_St1_18Feb2025_ATMInh/Foci/Zeo_500_ATM5uM';
%%ST13
% masterFolder='/Users/grazianamodica/Biophotonics Dropbox/Graziana Modica/Graziana Data/SpIDA figures/Experiments/St13_27March2024/QB/Foci/Zeo_500';

%myFiles=dir(fullfile(masterFolder, '*ChanA*.tif'));
%myFiles=dir(fullfile(masterFolder, '*ch00*')); %stellaris

myFilesGreen=dir(fullfile(masterFolder, '*_C2.tif')); % station 1

myFilesRed=dir(fullfile(masterFolder, '*_C3.tif')); % station 1

% myFilesFarRed=dir(fullfile(masterFolder, '*_C4.tif'));

% myFilesGreen=dir(fullfile(masterFolder, '*GFP*.tif')); %station 13
% myFilesRed=dir(fullfile(masterFolder, '*647*.tif')); %station 13


mkdir(fullfile(masterFolder, 'Background noise mask'));




% uiwait(msgbox("Select a background region for each image. Get set, ready and... click click click!","Background Noise","modal"));


for itFile=1:size(myFilesGreen,1)
% for   itFile=8

    thisImageOriginal=imread(fullfile(masterFolder, myFilesGreen(itFile).name));
    bkRegion=roipoly(imadjust(mat2gray(thisImageOriginal))); 
    bkIntensity=mean2(thisImageOriginal(bkRegion));

%     save(fullfile(masterFolder, 'Background noise mask', [myFilesGreen(itFile).name '.bkmask.mat']), 'bkRegion', 'bkIntensity');   
    save(fullfile(masterFolder, 'Background noise mask', [myFilesGreen(itFile).name '.bkmask.mat']), 'bkRegion', 'bkIntensity');     
end
thisImageOriginal=[];
bkRegion=[];
bkIntensity=[];

 for itFile=1:size(myFilesRed,1)
     % for itFile=2
    thisImageOriginal=imread(fullfile(masterFolder, myFilesRed(itFile).name));
    bkRegion=roipoly(imadjust(mat2gray(thisImageOriginal))); 
    bkIntensity=mean2(thisImageOriginal(bkRegion));

%     save(fullfile(masterFolder, 'Background noise mask', [myFilesGreen(itFile).name '.bkmask.mat']), 'bkRegion', 'bkIntensity');   
    save(fullfile(masterFolder, 'Background noise mask', [myFilesRed(itFile).name '.bkmask.mat']), 'bkRegion', 'bkIntensity');     


 end



% %  for itFile=1:size(myFilesFarRed,1)
% %      for itFile=2
% %     thisImageOriginal=imread(fullfile(masterFolder, myFilesFarRed(itFile).name));
% %     bkRegion=roipoly(imadjust(mat2gray(thisImageOriginal))); 
% %     bkIntensity=mean2(thisImageOriginal(bkRegion));
% % 
% %     save(fullfile(masterFolder, 'Background noise mask', [myFilesGreen(itFile).name '.bkmask.mat']), 'bkRegion', 'bkIntensity');   
% %     save(fullfile(masterFolder, 'Background noise mask', [myFilesFarRed(itFile).name '.bkmask.mat']), 'bkRegion', 'bkIntensity');     
% % 
% % 
% % end


% msgbox('You did it. all background noise mask done', 'Background Noise','modal')

close all


% imshow(cat(3, mat2gray(thisImage), imdilate(bwperim(cellsMask), strel('disk',3)), imdilate(bwperim(cellsMask), strel('disk',3))))
%     
%     answer1=questdlg('Happy with the mask?', 'Satisfaction', 'Yes', 'No', 'Yes')
%     if strcmp(answer1,'No')
%         answer2='Draw';
%         cellsMask=false(size(cellsMask));
%         while strcmpi(answer2, 'Draw')
%             thisMask=roipoly(cat(3, mat2gray(thisImage), bwperim(cellsMask), bwperim(cellsMask)));
%             answer2=questdlg('Keep drawing?', 'Satisfaction', 'Draw', 'No', 'Draw');
%             cellsMask=cellsMask|thisMask;
%         end
%     end