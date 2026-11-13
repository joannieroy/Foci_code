clear all
close all

masterFolder='C:\Users\joann\OneDrive - Sante et Services sociaux\Christos\Data\DNAdamage_IF\Good_Replicates\2umCW_Laser\20260901_H_2um_4h_H2AX_53PB1\LaserCtl';
myNumberFile='*tif.mat';

myList=dir(masterFolder);
isub = [myList(:).isdir]; %# returns logical vector
folderNames = {myList(isub).name}';
folderNames(ismember(folderNames,{'.','..'})) = [];

theseFolders=string(vertcat(char(folderNames)));
regMatches=regexpi(theseFolders, 'Zeo*', 'match');
DataFolderList=find(~cellfun(@isempty, regMatches));
NewFolderNames=folderNames(DataFolderList);
NewFolderNames=folderNames;
newDir='53BP1GFP_ResultstoGraph';


mkdir(fullfile(masterFolder, newDir));

%QB=Results.meanGoodQB;
QB=11.83; % fake QB. This is inherited from SPIDA. Not needed. 

%for it= 3
for it=1:size(NewFolderNames, 1)
    [masterFolder filesep NewFolderNames{it}]
    ResultsNumber=getTheNumbersSpiDA_reRun([masterFolder filesep NewFolderNames{it} filesep 'resultsResults'], myNumberFile, QB); 
    IntensityPerFocus=nonzeros(ResultsNumber.FociSumIntensityGoodAndBad);
    MoleculesperFocus=nonzeros(ResultsNumber.FociMoleculesPerFocusGoodAndBad);
    resultTbl=table(IntensityPerFocus, MoleculesperFocus, 'VariableNames', {'SumOfIntensity', 'MoleculesPerFocus'});
    writetable(resultTbl, fullfile(masterFolder, newDir, [NewFolderNames{it} '_SumOfIntensity.xls']));
    save(fullfile(masterFolder, newDir, [NewFolderNames{it} '_53bp1GFP_YourNumbersToPlot.mat']), 'ResultsNumber');
end