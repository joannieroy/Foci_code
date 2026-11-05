clear all 
close all


masterFolder='/Users/grazianamodica/Biophotonics Dropbox/Graziana Modica/Graziana Data/SpIDAing/SpIDA_Data_Curated/Graziana/SpIDA 20012022_53BP1GFP_ZeoChallenge/FociAnalysis';
myList=dir(masterFolder);
isub = [myList(:).isdir]; %# returns logical vector
folderNames = {myList(isub).name}';
folderNames(ismember(folderNames,{'.','..'})) = [];


theseFolders=string(vertcat(char(folderNames)));
regMatches=regexpi(theseFolders, 'Zeo*', 'match');
DataFolderList=find(~cellfun(@isempty, regMatches));
NewFoldernames=folderNames(DataFolderList);
       

myNumberFile='*tif.mat';
newDirName='MoreResults';
proteinName='53BP1GFP';
mkdir(masterFolder,newDirName);

for itFolder=1:size(NewFoldernames)

    myFolder=fullfile(masterFolder, NewFoldernames{itFolder});
    thisFolder=fullfile(myFolder, '53BP1_Results', 'Numbers');
    
    myFiles=dir(fullfile(thisFolder, myNumberFile));
    myFiles = {myFiles.name};
    
    NumberofFociPerCell=[];
    NumberofCellMore10=[];
    NumberofCellMore5=[];
    FociMeanIntensity=[];
    FocalProteinIntensity=[];
    FociSumIntensity=[];

        for itFile=1:size(myFiles)
            load(fullfile(thisFolder, myFiles{itFile}));

                if fociResults.cellWithFoci
                    NumberofFociPerCell=[NumberofFociPerCell, fociResults.eachCell];
                    NumberofCellMore10=[NumberofCellMore10 (find (fociResults.eachCell>10))];
                    NumberofCellMore5=[NumberofCellMore5 (find (fociResults.eachCell>5))];
                    FocalProteinIntensity=[FocalProteinIntensity fociResults.FocalProteinSumIntensity];
                    FociSumIntensity=[FociSumIntensity fociResults.fociSumOfIntensity];
                    FociMeanIntensity=[FociMeanIntensity fociResults.fociIndividualMeanIntensity];
                else
                    disp 'Nothing Niente Nada Rien'
                end
        
                if size(myFiles,2)>0 && sum(NumberofFociPerCell>0)
                    ResultsNumber.NumberofFociPerCell=NumberofFociPerCell';
                    ResultsNumber.MoreThan10= NumberofCellMore10;
                    ResultsNumber.MoreThan5= NumberofCellMore5;
                    
                    ResultsNumber.FociMeanIntensity= FociMeanIntensity;
                    ResultsNumber.FociSumIntensity= FociSumIntensity;
                    ResultsNumber.FocalProteinIntensity = FocalProteinIntensity';
                else
                    ResultsNumber = [];
                end
        end
    save(fullfile(masterFolder, newDirName, [NewFoldernames{itFolder} '_' proteinName '_MoreNumbers.mat']), 'ResultsNumber' );


end



