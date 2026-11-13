clear all
close all

% masterFolder='/Users/grazianamodica/Biophotonics Dropbox/Graziana Modica/Graziana Data/Nuclear biomechanics/experiments/Zeo 10ug 02052025';
% masterFolder='/Users/grazianamodica/Biophotonics Dropbox/Graziana Modica/Graziana Data/Nuclear biomechanics/experiments/Zeo_response 21052025';
% masterFolder='/Users/grazianamodica/Biophotonics Dropbox/Graziana Modica/Graziana Data/Nuclear biomechanics/experiments/Zeo_response_LNCaP_13062025';
% masterFolder='/Users/grazianamodica/Biophotonics Dropbox/Graziana Modica/Graziana Data/Nuclear biomechanics/experiments/PC3/PC3 Zeo challenge 03072025/New Folder With Items';
% masterFolder='/Users/grazianamodica/Biophotonics Dropbox/Graziana Modica/Graziana Data/Nuclear biomechanics/experiments/LNCaP/Zeo_response 24082025';
% masterFolder='/Users/grazianamodica/Biophotonics Dropbox/Graziana Modica/Graziana Data/Nuclear biomechanics/experiments/PC3/Trypsin PC3 SB/Zeo challenge 26082025/done';
% masterFolder='/Users/grazianamodica/Biophotonics Dropbox/Graziana Modica/Graziana Data/Nuclear biomechanics/experiments/LNCaP/Zeo challenge 03092025';
% masterFolder='/Users/grazianamodica/Biophotonics Dropbox/Graziana Modica/Graziana Data/Nuclear biomechanics/experiments/53bp1gfp vs zeoR/19092025'
% masterFolder="/Users/grazianamodica/Biophotonics Dropbox/Graziana Modica/Graziana Data/Nuclear biomechanics/experiments/TFM and Foci With Nicolas/PC3/PC3_TFM_301020225/53BP1_AF488_40X";
% masterFolder='/Users/grazianamodica/Biophotonics Dropbox/Graziana Modica/Graziana Data/Nuclear biomechanics/experiments/LNCaP/Zeo_response 24082025';
% masterFolder='/Users/grazianamodica/Biophotonics Dropbox/Graziana Modica/Graziana Data/Nuclear biomechanics/experiments/PC3/IR/11Dec2025_2GY';
% masterFolder='/Users/grazianamodica/Biophotonics Dropbox/Graziana Modica/Graziana Data/Nuclear biomechanics/experiments/PC3/IR/19Dec2025 dose reponse 2_4_8 GY';
% masterFolder='/Users/grazianamodica/Biophotonics Dropbox/Graziana Modica/Graziana Data/Nuclear biomechanics/experiments/PC3/IR/pc3 19dec2025_confocal/tif';
% masterFolder='/Users/grazianamodica/Biophotonics Dropbox/Graziana Modica/Graziana Data/Nuclear biomechanics/experiments/PC3/PC3 Zeo challenge 03072025';
% masterFolder='/Users/grazianamodica/Biophotonics Dropbox/Graziana Modica/Graziana Data/Nuclear biomechanics/experiments/PC3/PC3 Zeo challenge 03072025/New Folder With Items';
% masterFolder='/Users/grazianamodica/Biophotonics Dropbox/Graziana Modica/Graziana Data/Nuclear biomechanics/experiments/PC3/IR/23Jan2026_0pt5_01_02 GY';
%masterFolder='/Users/grazianamodica/Biophotonics Dropbox/Graziana Modica/Graziana Data/Nuclear biomechanics/experiments/PC3/TFM/PC3 parental vs IR7th_10KPa_2GY_23022026/20260305_121202_536_IF';
% masterFolder='/Users/grazianamodica/Biophotonics Dropbox/Graziana Modica/Graziana Data/Nuclear biomechanics/experiments/PC3/IR/23Jan2026_0pt5_01_02 GY';
%masterFolder='/Users/grazianamodica/Biophotonics Dropbox/Graziana Modica/Graziana Data/Nuclear biomechanics/experiments/PC3/IR/done_26Febr2026_0pt5_01_02_GY';
% masterFolder='/Users/grazianamodica/Biophotonics Dropbox/Graziana Modica/Graziana Data/Nuclear biomechanics/experiments/PC3/IR/18March2026_0pt5_01_02_GY_53BP1vsFK2';

% masterFolder='/Users/grazianamodica/Biophotonics Dropbox/Graziana Modica/Graziana Data/Nuclear biomechanics/experiments/PC3/TFM/PC3 Parental vs ZeoR10th_18022026/20260225_151211_986_40Xfoci';
% masterFolder='/Users/grazianamodica/Biophotonics Dropbox/Graziana Modica/Graziana Data/Nuclear biomechanics/experiments/PC3/IR/31March2026_0pt5_01_02_GY_Xray';
% masterFolder='/Users/grazianamodica/Biophotonics Dropbox/Graziana Modica/Graziana Data/Nuclear biomechanics/NTS_02April2026/new';
% masterFolder='/Users/grazianamodica/Biophotonics Dropbox/Graziana Modica/Graziana Data/Nuclear biomechanics/experiments/PC3/IR/31March2026_0pt5_01_02_GY_Xray';
% masterFolder="/Users/grazianamodica/Biophotonics Dropbox/Graziana Modica/Graziana Data/Nuclear biomechanics/experiments/PC3/IR/31March2026_0pt5_01_02_GY_Xray/test gels";
% masterFolder='/Users/grazianamodica/Biophotonics Dropbox/Graziana Modica/Graziana Data/Nuclear biomechanics/experiments/PC3/IR/24April2026 Hepes effect/HEPES';
% masterFolder='/Users/grazianamodica/Biophotonics Dropbox/Graziana Modica/Graziana Data/Nuclear biomechanics/experiments/PC3/IR/24April2026 Hepes effect/control';
% masterFolder='/Users/grazianamodica/Biophotonics Dropbox/Graziana Modica/Graziana Data/Nuclear biomechanics/experiments/LNCaP/24April2026';
% masterFolder='/Users/grazianamodica/Biophotonics Dropbox/Graziana Modica/Graziana Data/Nuclear biomechanics/experiments/LNCaP/coating test/24April2026';
% masterFolder="/Users/grazianamodica/Biophotonics Dropbox/Graziana Modica/Graziana Data/Nuclear biomechanics/experiments/53BP1-mEGFP sorting test/pre-extraction test 06052026";
% masterFolder="/Users/grazianamodica/Biophotonics Dropbox/Graziana Modica/Graziana Data/Nuclear biomechanics/experiments/LNCaP/MAPK_Inh";
% masterFolder='/Users/grazianamodica/Biophotonics Dropbox/Graziana Modica/Graziana Data/Nuclear biomechanics/experiments/PC3/MAPK_Inh';
% masterFolder="/Users/grazianamodica/Biophotonics Dropbox/Graziana Modica/Graziana Data/Nuclear biomechanics/experiments/TOV21G/Zeo_03July2026";
% masterFolder='/Users/grazianamodica/Biophotonics Dropbox/Graziana Modica/Graziana Data/Nuclear biomechanics/experiments/U2OS/Zeo_response 21052025';
% masterFolder='/Users/grazianamodica/Biophotonics Dropbox/Graziana Modica/Graziana Data/Nuclear biomechanics/experiments/TOV21G/ZeoResponse 10082026';
% masterFolder="/Users/grazianamodica/Biophotonics Dropbox/Graziana Modica/Graziana Data/Nuclear biomechanics/experiments/U2OS/NTS_ROCKInhibitor_24082026";


% masterFolder="/Users/grazianamodica/Biophotonics Dropbox/Graziana Modica/Graziana Data/Nuclear biomechanics/experiments/PC3/Zeo_MAPK4K_10July2026";

% masterFolder='/Users/grazianamodica/Biophotonics Dropbox/Graziana Modica/Graziana Data/Nuclear biomechanics/experiments/TOV21G/Zeo response 02092026';
% masterFolder='/Users/grazianamodica/Biophotonics Dropbox/Graziana Modica/Graziana Data/Nuclear biomechanics/experiments/U2OS/Zeo_Response 04092026';

% masterFolder='/Users/grazianamodica/Biophotonics Dropbox/Graziana Modica/Graziana Data/Nuclear biomechanics/experiments/U2OS/PAA';
masterFolder="/Users/grazianamodica/Biophotonics Dropbox/Graziana Modica/Graziana Data/Nuclear biomechanics/experiments/U2OS/PAA";




% newDir='53BP1_Distribution_10c_2pt5ns_3_again';
% newDir='FK2_Distribution_spotiflow';
newDir='53BP1_Distribution_spotiflow';

mkdir(fullfile(masterFolder, newDir));

myNumberFile='*488.mat';
% myNumberFile='*488.tif.mat';
% myNumberFile='*tifColoc.mat';

myList=dir(masterFolder);
isub = [myList(:).isdir]; %# returns logical vector
folderNames = {myList(isub).name}';
folderNames(ismember(folderNames,{'.','..'})) = []; 

theseFolders=string(vertcat(char(folderNames)));

% regMatches=regexpi(theseFolders, 'Well', 'match');
%regMatches=regexpi(theseFolders, 'siRNA*', 'match');
regMatches=regexpi(theseFolders, 'Zeo', 'match');

DataFolderList=find(~cellfun(@isempty, regMatches));
NewFolderNames=folderNames(DataFolderList);
% NewFolderNames=folderNames;



for it=1:size(NewFolderNames, 1)
    % for it=1
    

    [masterFolder '/' NewFolderNames{it}];
   
   
    % thisFolder=fullfile(masterFolder, NewFolderNames{it},'53bp1_5c_2pt5ns_r3_cbc16Oct2025 Results','Numbers');
    thisFolder=fullfile(masterFolder, NewFolderNames{it}, '53bp1_spotiflow_Results', 'Numbers');
    % thisFolder=fullfile(masterFolder, NewFolderNames{it}, 'FK2_spotiflow_Results', 'Numbers');
    
    myFiles=dir(fullfile(thisFolder, myNumberFile));
    myFiles = {myFiles.name};
        
    NumberOfCell=[];
    AllFociNumber=[];
    NumberofCellMore10=[];
    NumberofCellMore5=[];
    NumberofFoci=[];
    TotProteinIntensity=[];

    for itFile=1:size(myFiles,2)

       load(fullfile(thisFolder, myFiles{itFile}));

       if isfield(fociResults, 'numCells') & fociResults.numCells>0 
           disp('Field numCells exists in the structure fociresults.');
        
           NumberOfCell=[NumberOfCell fociResults.numCells];
           NumberofCellMore10=[NumberofCellMore10 numel(find (fociResults.eachCell>10))];
           NumberofCellMore5=[NumberofCellMore5 numel(find (fociResults.eachCell>5))];
           TotProteinIntensity=[TotProteinIntensity fociResults.FocalProteinSumIntensity];
              
            if fociResults.numFoci>0 

                % GoodFociPerCell= extractfield(fociResults.GoodFociPerCell, 'NumberOfFociPerCell');
                % BadFociPerCell= extractfield(fociResults.BadFociPerCell, 'NumberOfFociPerCell');
                % NumberofFoci=GoodFociPerCell+BadFociPerCell;
                
                % GoodFpC=[GoodFpC GoodFociPerCell];
                % BadFpC=[BadFpC BadFociPerCell];
                AllFociNumber=[AllFociNumber fociResults.eachCell];

              end

        else
            display('no cells  here')
        end

    end
  
   DistributionResults.FociNumber=AllFociNumber;
   DistributionResults.NozerosFociNumber=nonzeros(AllFociNumber);
   A=nonzeros(AllFociNumber);

   DistributionResults.NumberOfCell=NumberOfCell;
   DistributionResults.NumberofCellMore10=NumberofCellMore10;
   DistributionResults.NumberofCellMore5=NumberofCellMore5;
   DistributionResults.NumberofCellMore5PerCent=(sum(NumberofCellMore5, 'all')/sum(NumberOfCell, 'all'))*100;
   DistributionResults.NumberofCellMore10PerCent=(sum(NumberofCellMore10, 'all')/sum(NumberOfCell, 'all'))*100;
   DistributionResults.TotProteinIntensity=TotProteinIntensity;

   save(fullfile(masterFolder, newDir, [NewFolderNames{it} '_53BP1_Distribution.mat']), 'DistributionResults' );
  
   resultTbl=table(A, 'VariableNames', {'Number of foci'});
   writetable(resultTbl, fullfile(masterFolder, newDir, [NewFolderNames{it} '_DistributionInfo.xls']));

   resultTbl2=table(NumberOfCell', 'VariableNames', {'Number of Cell'});
   writetable(resultTbl2, fullfile(masterFolder, newDir, [NewFolderNames{it} '_NumberOfCell.xls']));

   resultTbl3=table(NumberofCellMore10', 'VariableNames', {'Number of Cell >10 foci'});
   writetable(resultTbl3, fullfile(masterFolder, newDir, [NewFolderNames{it} '_NumberOfCellMore10.xls']));

  resultTbl4=table(NumberofCellMore5', 'VariableNames', {'Number of Cell >5 foci'});
   writetable(resultTbl4, fullfile(masterFolder, newDir, [NewFolderNames{it} '_NumberOfCellMore5.xls']));
  
   resultTbl5=table( DistributionResults.NumberofCellMore5PerCent', 'VariableNames', {'% Number of Cell >5 foci'});
   writetable(resultTbl5, fullfile(masterFolder, newDir, [NewFolderNames{it} '_% NumberOfCellMore5.xls']));

   resultTbl6=table(AllFociNumber', 'VariableNames', {'Number of foci'});
   writetable(resultTbl6, fullfile(masterFolder, newDir, [NewFolderNames{it} '_DistributionInfo_withzero.xls']));

   resultTbl7=table( DistributionResults.NumberofCellMore10PerCent', 'VariableNames', {'% Number of Cell >10 foci'});
   writetable(resultTbl7, fullfile(masterFolder, newDir, [NewFolderNames{it} '_% NumberOfCellMore10.xls']));
   
   resultTbl8=table( DistributionResults.TotProteinIntensity', 'VariableNames', {'Tot Protein Intenity'});
   writetable(resultTbl8, fullfile(masterFolder, newDir, [NewFolderNames{it} '_Tot Protein Intenity.xls']));

end


