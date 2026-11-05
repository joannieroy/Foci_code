clear all
close all
%masterFolder='/Users/grazianamodica/Dropbox (Biophotonics)/Graziana Data/Focus in number/SpIDA Foci/SpIDA 09122021/to analyse';

%masterFolder='/Users/grazianamodica/Biophotonics Dropbox/Graziana Modica/Graziana Data/SpIDAing/SpIDA_Data_Curated/SpiDA_St1_09Nov2022/FociAnalysis/53BP1GFP/53BP1GFP';

%masterFolder='/Users/grazianamodica/Biophotonics Dropbox/Graziana Modica/Graziana Data/SpIDAing/SpIDA_Data_Curated/SpiDA_St1_09Nov2022/FociAnalysis/53BP1GFP/Anti53BP1_Alexa647';
%masterFolder='/Users/grazianamodica/Desktop/GFPBRCA1_53BP1/GFPBRCA1/GFPBRCA1';

%masterFolder='/Users/grazianamodica/Biophotonics Dropbox/Graziana Modica/Graziana Data/SpIDAing/SpIDA_Data_Curated/Graziana/SpIDA_St1_07Dec2022/FociAnalysis/53BP1GFP';


%masterFolder='/Users/grazianamodica/Biophotonics Dropbox/Graziana Modica/Graziana Data/SpIDAing/SpIDA_Data_Curated/Graziana/SpIDA 26092022_53BP1GFP_ZeoChallenge/FociAnalysis/FociAnalysis';
%masterFolder='/Users/grazianamodica/Biophotonics Dropbox/Graziana Modica/Graziana Data/SpIDAing/SpIDA_Data_Curated/Graziana/SpIDA 20012022_53BP1GFP_ZeoChallenge/FociAnalysis';
%masterFolder='/Users/grazianamodica/Biophotonics Dropbox/Graziana Modica/Graziana Data/SpIDAing/SpIDA_Data_Curated/Joannie/SpIDA 23122021_53BP1GFP_ZeoChallenge/FociAnalysis';

%masterFolder='/Users/grazianamodica/Biophotonics Dropbox/Graziana Modica/Graziana Data/SpIDAing/SpIDA_Data_Curated/Graziana/SpIDA_St1_07Dec2022/FociAnalysis/Anti53BP1_Alexa546';

%masterFolder='/Users/grazianamodica/Biophotonics Dropbox/Graziana Modica/Graziana Data/SpIDAing/SpIDA_Data_Curated/Graziana/53BP1 GFP vs Alexa/09Nov2022/Anti53BP1_Alexa647';
%masterFolder='/Users/grazianamodica/Biophotonics Dropbox/Graziana Modica/Graziana Data/SpIDAing/SpIDA_Data_Curated/Graziana/Challenge_data_analysis/SpIDA 20012022_53BP1GFP_ZeoChallenge/FociAnalysis';

%masterFolder='/Users/grazianamodica/Biophotonics Dropbox/Graziana Modica/Graziana Data/SpIDAing/SpIDA_Data_Curated/Graziana/09Nov2022/GFPBRACA1/GFPBRCA1/condition';

%masterFolder='/Users/grazianamodica/Biophotonics Dropbox/Graziana Modica/Graziana Data/SpIDAing/SpIDA_Data_Curated/Graziana/Challenge_data_analysis/SpIDA 20012022_53BP1GFP_ZeoChallenge/FociAnalysis';

%masterFolder='/Users/grazianamodica/Biophotonics Dropbox/Graziana Modica/Graziana Data/SpIDAing/SpIDA_Data_Curated/Graziana/Challenge_data_analysis/SpIDA 26092022_53BP1GFP_ZeoChallenge/FociAnalysis/FociAnalysis';
%masterFolder='/Users/grazianamodica/Biophotonics Dropbox/Graziana Modica/Graziana Data/SpIDAing/SpIDA_Data_Curated/Graziana/SpIDA_siRNA_10Feb2022/ForFociAnalysis';

%masterFolder='/Users/grazianamodica/Biophotonics Dropbox/Graziana Modica/Graziana Data/SpIDAing/SpIDA_Data_Curated/SpIDA_St1_26052023_siRNA/FociAnalysis';

%masterFolder='/Users/grazianamodica/Biophotonics Dropbox/Graziana Modica/Graziana Data/SpIDAing/SpIDA_Data_Curated/SpIDA_St1_26012023_Challenge_GFPvs647/53BP1/anti53BP1Alx647';
%masterFolder='/Users/grazianamodica/Biophotonics Dropbox/Graziana Modica/Graziana Data/SpIDAing/SpIDA_Data_Curated/SpIDA 23122021_challenge/FociAnalysis';
masterFolder='/Users/grazianamodica/Biophotonics Dropbox/Graziana Modica/Graziana Data/SpIDA figures/Experiments/14Dec2023/foci';
myNumberFile='*tif.mat';

%myNumberFile='*tifColoc.mat';



myList=dir(masterFolder);
isub = [myList(:).isdir]; %# returns logical vector
folderNames = {myList(isub).name}';
folderNames(ismember(folderNames,{'.','..'})) = [];

theseFolders=string(vertcat(char(folderNames)));
regMatches=regexpi(theseFolders, 'Zeo*', 'match');
DataFolderList=find(~cellfun(@isempty, regMatches));
NewFolderNames=folderNames(DataFolderList);

NewFolderNames=folderNames;

%newDir='BRCA1_ResultstoGraph01_1';
newDir='53BP1GFP_ResultstoGraph';
%newDir='53BP1647_ResultstoGraph';

mkdir(fullfile(masterFolder, newDir));
%load(fullfile(masterFolder,'GFP_QBResults.mat' ));

%load(fullfile(masterFolder,'HA_QBResults.mat' ));
%QB=Results.meanGoodQB;
QB=11.83;

%for it= 3
for it=1:size(NewFolderNames, 1)
    [masterFolder filesep NewFolderNames{it}]
    %ResultsNumber=getTheNumbersSpiDA([masterFolder filesep folderNames{it} filesep '53BP1_Results'], myNumberFile);
    %ResultsNumber=getTheNumbersSpiDA([masterFolder filesep folderNames{it} filesep 'BRCA1_Results'], myNumberFile);
    
    %ResultsNumber=getTheNumbersSpiDA_reRun([masterFolder filesep NewFolderNames{it} filesep 'New53BP1_Results'], myNumberFile, QB);
    ResultsNumber=getTheNumbersSpiDA_reRun([masterFolder filesep NewFolderNames{it} filesep '53BP1GFP_Results'], myNumberFile, QB); 

    %ResultsNumber=getTheNumbersSpiDA_reRun([masterFolder filesep NewFolderNames{it} filesep 'BRCA1_Results'], myNumberFile, QB);


    %ResultsNumber=getTheNumbersSpiDA_reRun([masterFolder filesep NewFolderNames{it} filesep '53BP1GFP_Results'], myNumberFile, QB);
    
    %ResultsNumber=getTheNumbersSpiDA_reRun([masterFolder filesep NewFolderNames{it} filesep 'anti53BP1Alx647_Results'], myNumberFile, QB);
  
    IntensityPerFocus=nonzeros(ResultsNumber.FociSumIntensityGoodAndBad);
    MoleculesperFocus=nonzeros(ResultsNumber.FociMoleculesPerFocusGoodAndBad);
    resultTbl=table(IntensityPerFocus, MoleculesperFocus, 'VariableNames', {'SumOfIntensity', 'MoleculesPerFocus'});
    
    
    
    %save(fullfile(masterFolder, NewFolderNames{it}, [folderNames{it} '_Alexa53bp1_YourNumbersToPlot.mat']), 'ResultsNumber' );
    %save(fullfile(masterFolder, NewFolderNames{it}, [NewFolderNames{it} '_BRCA1_YourNumbersToPlot.mat']), 'ResultsNumber' );
   
    %save(fullfile(masterFolder, newDir, [NewFolderNames{it} '_BRCA1_YourNumbersToPlot.mat']), 'ResultsNumber' );
    writetable(resultTbl, fullfile(masterFolder, newDir, [NewFolderNames{it} '_SumOfIntensity.xls']));
    save(fullfile(masterFolder, newDir, [NewFolderNames{it} '_53bp1GFP_YourNumbersToPlot.mat']), 'ResultsNumber');
    %save(fullfile(masterFolder, newDir, [NewFolderNames{it} '_53bp1647_YourNumbersToPlot.mat']), 'ResultsNumber');
end