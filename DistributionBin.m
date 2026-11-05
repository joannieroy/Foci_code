clear all
close all

%masterFolder='/Users/grazianamodica/Biophotonics Dropbox/Graziana Modica/Graziana Data/SpIDA figures/Experiments/Challenge_data_analysis/SpIDA 20012022_53BP1GFP_ZeoChallenge/FociAnalysis';
%masterFolder='/Users/grazianamodica/Biophotonics Dropbox/Graziana Modica/Graziana Data/SpIDA figures/Experiments/Challenge_data_analysis/SpIDA 26092022_53BP1GFP_ZeoChallenge/FociAnalysis/FociAnalysis';
%masterFolder='/Users/grazianamodica/Biophotonics Dropbox/Graziana Modica/Graziana Data/SpIDA figures/Experiments/Challenge_data_analysis/SpIDA_St1_14Sept2023_challenge/53BP1GFP/foci analysis';
%masterFolder='/Users/grazianamodica/Biophotonics Dropbox/Graziana Modica/Graziana Data/SpIDA figures/Experiments/SpIDA_St1_21July2023_siRNA/Foci analysis';
%masterFolder='/Users/grazianamodica/Biophotonics Dropbox/Graziana Modica/Graziana Data/SpIDA figures/Experiments/SpIDA_St1_26May2023_siRNA/FociAnalysis';
%masterFolder='/Users/grazianamodica/Biophotonics Dropbox/Graziana Modica/Graziana Data/SpIDA figures/Experiments/SpIDA_siRNA_10Feb2022/ForFociAnalysis';
masterFolder='/Users/grazianamodica/Biophotonics Dropbox/Graziana Modica/Graziana Data/SpIDA figures/Experiments/siRNA/SpIDA_St1_03July2023_siRNA/Foci Analysis';

%newDir='Alexa_DistributionResults_July_t';
%newDir='Alexa53BP1_DistributionResults_August';
%newDir='BRCA1_DistributionResults'
%newDir='53BP1_Distribution_August';
%newDir='53BP1_Distribution_August';
%newDir='NuMA53BP1_ResultstoGraph_September';

newDir='BinningTest_1';



myNumberFile='*tif.mat';

myList=dir(masterFolder);
isub = [myList(:).isdir]; %# returns logical vector
folderNames = {myList(isub).name}';
folderNames(ismember(folderNames,{'.','..'})) = []; 

theseFolders=string(vertcat(char(folderNames)));
regMatches=regexpi(theseFolders, 'siRNA*', 'match');
%regMatches=regexpi(theseFolders, 'siRNA*', 'match');
DataFolderList=find(~cellfun(@isempty, regMatches));
NewFolderNames=folderNames(DataFolderList);
%NewFolderNames=folderNames;

load(fullfile(masterFolder,"GFP_QBResults.mat"));
%load(fullfile(masterFolder,"HA_QBResults.mat"));
QB=Results.meanGoodQB;

%QB=4.2180;

for it=1:size(NewFolderNames, 1)
    %for it=6
    

    [masterFolder '/' NewFolderNames{it}];

   thisFolder=[masterFolder '/' NewFolderNames{it} '/' '53BP1GFP_Results' '/' 'Numbers'];

   %thisFolder=[masterFolder '/' NewFolderNames{it} '/' 'New53BP109_Results' '/' 'Numbers'];
   
   %thisFolder=[masterFolder '/' NewFolderNames{it} '/' 'NewBRCA1_Results' '/' 'Numbers'];
   
    %thisFolder=[masterFolder '/' NewFolderNames{it} '/' 'New53BP1_Results' '/' 'Numbers'];

    %thisFolder=[masterFolder '/' NewFolderNames{it} '/' 'Alexa54653BP1_Results' '/' 'Numbers'];

    %thisFolder=[masterFolder '/' NewFolderNames{it} '/' 'Alexa54653BP1_Results' '/' 'Numbers'];

    %thisFolder=[masterFolder '/' NewFolderNames{it} '/' 'NuMA_53BP1GFPResults' '/' 'Numbers'];

    mkdir(fullfile(masterFolder, NewFolderNames{it}, newDir))
    
    myFiles=dir(fullfile(thisFolder, myNumberFile));
    myFiles = {myFiles.name};
    
    TotalProtein=[];

    for itFile=1:size(myFiles,2)

       load(fullfile(thisFolder, myFiles{itFile}));

        if fociResults.numCells>0
           TotalProtein=[TotalProtein (fociResults.FocalProteinSumIntensity/QB)];
        else
            disp('no cells  here')
        end

    end

    itFile=[];

%% find the 25th and 75th percentile and define bin edges

 numBins=3;

%[histogram, binEdges] = histcounts(data, numBins);
 data=TotalProtein;

 L=prctile(data, 25);
 H=prctile(data, 75);
 Max=max(data);
 binEdges=[0, L, H, Max];
 


   mkdir(fullfile(masterFolder, NewFolderNames{it}, newDir, 'Low'));
   mkdir(fullfile(masterFolder, NewFolderNames{it}, newDir, 'Medium'));
   mkdir(fullfile(masterFolder, NewFolderNames{it}, newDir, 'High'));
            
     for itFile=1:size(myFiles,2)

       load(fullfile(thisFolder, myFiles{itFile}));

        if fociResults.numCells>0
       
          BinningResults=binning2(fociResults,data, QB, binEdges, numBins);
          Low=BinningResults{1};
          Med=BinningResults{2};
          High=BinningResults{3};

          save(fullfile(masterFolder, NewFolderNames{it}, newDir, [myFiles{itFile} '_53BP1_Binning.mat']), 'BinningResults' );
          save(fullfile(masterFolder, NewFolderNames{it}, newDir, 'Low', [myFiles{itFile} '_53BP1_Low_Binning.mat']), 'Low' );
          save(fullfile(masterFolder, NewFolderNames{it}, newDir, 'Medium', [myFiles{itFile} '_53BP1_Med_Binning.mat']), 'Med' );
          save(fullfile(masterFolder, NewFolderNames{it}, newDir, 'High', [myFiles{itFile} '_53BP1_High_Binning.mat']), 'High' );

        else
            disp('no cells  here')
        end
     %save(fullfile(masterFolder, NewFolderNames{it}, thisFolder, newDir, [myFiles{itFile} '_53BP1_Binning.mat']), 'BinningResults' );
   
     end
     
     newDir2='BinningResultsPerCondition';
     mkdir(fullfile(masterFolder, newDir2));
     myFiles=[];
     thisFolder=[];
     itFile=[];
     myNumberFile2='*Binning.mat';
  
         for l=1:size(NewFolderNames, 1)
    
            thisFolder=[masterFolder '/' NewFolderNames{l} '/' newDir '/' 'Low']; 
            myFiles=dir(fullfile(thisFolder, myNumberFile2));
            myFiles = {myFiles.name};
        
            TotalProtein=[];
            MoleculesPerFocus=[];
            NumberofFoci=[];
            FociFraction=[];
    
                 for itFile=1:size(myFiles,2)
    
                    load(fullfile(thisFolder, myFiles{itFile}));
                    MoleculesPerFocus=[MoleculesPerFocus Low.MoleculesPerFocus'];
                    NumberofFoci=[NumberofFoci Low.FociNumber];
                    TotalProtein=[TotalProtein Low.TotProtein];
                    FociFraction=[FociFraction Low.FociFraction'];
                 end
           
            LowResults.MoleculesPerFocus=MoleculesPerFocus';
            LowResults.NumberofFoci=NumberofFoci';
            LowResults.TotalProtein=TotalProtein';
            LowResults.FociFraction=FociFraction';
            LowResults.NormFociFraction=(FociFraction./TotalProtein)';
            Low_MoleculesperFocus=nonzeros(MoleculesPerFocus);

            resultTbl1=table(Low_MoleculesperFocus, 'VariableNames', {'MoleculesPerFocus'});
            writetable(resultTbl1, fullfile(masterFolder, newDir2, [NewFolderNames{l} '_LowMolPerFocus.xls']));


            resultTbl4=table(LowResults.FociFraction, LowResults.TotalProtein,  LowResults.NormFociFraction, LowResults.NumberofFoci, 'VariableNames', {'FociFraction', 'TotProtein', 'NormFociFraction', 'Number of Foci'});
            writetable(resultTbl4, fullfile(masterFolder, newDir2, [NewFolderNames{l} '_LowBinningDistribution.xls']));
    
        end
    
     itFile=[];
     myFiles=[];
     thisFolder=[];
  
         for m=1:size(NewFolderNames, 1)
    
            thisFolder=[masterFolder '/' NewFolderNames{m} '/' newDir '/' 'Medium']; 
            myFiles=dir(fullfile(thisFolder, myNumberFile2));
            myFiles = {myFiles.name};
        
            TotalProtein=[];
            MoleculesPerFocus=[];
            NumberofFoci=[];
            FociFraction=[];
    
                 for itFile=1:size(myFiles,2)
    
                    load(fullfile(thisFolder, myFiles{itFile}));
                    MoleculesPerFocus=[MoleculesPerFocus Med.MoleculesPerFocus'];
                    NumberofFoci=[NumberofFoci Med.FociNumber];
                    TotalProtein=[TotalProtein Med.TotProtein];
                    FociFraction=[FociFraction Med.FociFraction'];
                 end
           
            MedResults.MoleculesPerFocus=MoleculesPerFocus';
            MedResults.NumberofFoci=NumberofFoci';
            MedResults.TotalProtein=TotalProtein';
            MedResults.FociFraction=FociFraction';
            MedResults.NormFociFraction=(FociFraction./TotalProtein)';
            
            Med_MoleculesperFocus=nonzeros(MoleculesPerFocus);
            resultTbl2=table(Med_MoleculesperFocus, 'VariableNames', {'MoleculesPerFocus'});
            writetable(resultTbl2, fullfile(masterFolder, newDir2,  [NewFolderNames{m} '_MedMolPerFocus.xls']));

            resultTbl5=table(MedResults.FociFraction, MedResults.TotalProtein,  MedResults.NormFociFraction, MedResults.NumberofFoci, 'VariableNames', {'FociFraction', 'TotProtein', 'NormFociFraction', 'Number of Foci'});
            writetable(resultTbl5, fullfile(masterFolder, newDir2, [NewFolderNames{m} '_MedBinningDistribution.xls']));
    
        end

     itFile=[];
     myFiles=[];
     thisFolder=[];
  
         for h=1:size(NewFolderNames, 1)
    
            thisFolder=[masterFolder '/' NewFolderNames{h} '/' newDir '/' 'High']; 
            myFiles=dir(fullfile(thisFolder, myNumberFile2));
            myFiles = {myFiles.name};
        
            TotalProtein=[];
            MoleculesPerFocus=[];
            NumberofFoci=[];
            FociFraction=[];
    
                 for itFile=1:size(myFiles,2)
    
                    load(fullfile(thisFolder, myFiles{itFile}));
                    MoleculesPerFocus=[MoleculesPerFocus High.MoleculesPerFocus'];
                    NumberofFoci=[NumberofFoci High.FociNumber];
                    TotalProtein=[TotalProtein High.TotProtein];
                    FociFraction=[FociFraction High.FociFraction'];
                 end
           
            HighResults.MoleculesPerFocus=MoleculesPerFocus';
            HighResults.NumberofFoci=NumberofFoci';
            HighResults.TotalProtein=TotalProtein';
            HighResults.FociFraction=FociFraction';
            HighResults.NormFociFraction=(FociFraction./TotalProtein)';
            
            High_MoleculesperFocus=nonzeros(MoleculesPerFocus);
            resultTbl3=table(High_MoleculesperFocus, 'VariableNames', {'MoleculesPerFocus'});
            writetable(resultTbl3, fullfile(masterFolder, newDir2,  [NewFolderNames{h} '_HighMolPerFocus.xls']));

            resultTbl6=table(HighResults.FociFraction, HighResults.TotalProtein,  HighResults.NormFociFraction, HighResults.NumberofFoci, 'VariableNames', {'FociFraction', 'TotProtein', 'NormFociFraction', 'Number of Foci'});
            writetable(resultTbl6, fullfile(masterFolder, newDir2, [NewFolderNames{h} '_HighBinningDistribution.xls']));
    
        end
  end


 
                  




