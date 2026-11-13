clear all


masterFolder='/Users/grazianamodica/Biophotonics Dropbox/Graziana Modica/Graziana Data/Nuclear biomechanics/experiments/Zeo 10ug 02052025';
myNumberFile='*tif.mat';

%myNumberFile='*tifColoc.mat';


myList=dir(masterFolder);
isub = [myList(:).isdir]; %# returns logical vector
folderNames = {myList(isub).name}';
folderNames(ismember(folderNames,{'.','..'})) = [];

theseFolders=string(vertcat(char(folderNames)));
% regMatches=regexpi(theseFolders, '00*', 'match');
% regMatches=regexpi(theseFolders, 'GY_*', 'match');
% DataFolderList=find(~cellfun(@isempty, regMatches));
% NewFolderNames=folderNames(DataFolderList);

NewFolderNames=folderNames;
% newDir='RNF168and53BP1_ResultstoGraph_July';
% newDir='BRCA1GFP_ResultstoGraph';
%newDir='Alexa53bp1_ResultstoGraph_July';
%newDir='Alexa53BP1_ResultstoGraph_July';
newDir='53BP1_Distribution_1';
% newDir='Alexa54653BP1_DistributionResults';
% newDir='Alexa53BP1_ResultstoGraph';
% newDir='AlexaRiF_ResultstoGraph';

mkdir(fullfile(masterFolder, newDir));
QB=1;

%for it= 1
for it=1:size(NewFolderNames, 1)
    [masterFolder filesep NewFolderNames{it}]

ResultsNumber=getTheNumbersSpiDA([masterFolder filesep NewFolderNames{it} filesep '53bp1_Results'], myNumberFile, QB);
 
end