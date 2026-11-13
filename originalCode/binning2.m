function  [BinningResults] =binning2(fociResults, data, QB, binEdges, numBins)

%clear all 
%close all

% load ('/Users/grazianamodica/Biophotonics Dropbox/Graziana Modica/Graziana Data/SpIDA figures/Experiments/SpIDA_St1_26May2023_siRNA/FociAnalysis/GFP_DistributionResults_July_t/Untreated_Zeocin00500_53BP1_Distribution.mat');
% data=DistributionResults.Tot;
% numBins=3;
% [histogram, binEdges] = histcounts(data, numBins);

% Initialize a cell array to store indices for each bin
% binIndices = cell(1, numBins);
% 
% load('/Users/grazianamodica/Biophotonics Dropbox/Graziana Modica/Graziana Data/SpIDA figures/Experiments/SpIDA_St1_26May2023_siRNA/FociAnalysis/Untreated_Zeocin00500/53BP1GFP_Results/Numbers/53BP1GFP_004_C2.tif.mat');
% 
% %load(fullfile(masterFolder,"GFP_QBResults.mat"));
% %load(fullfile(masterFolder,"HA_QBResults.mat"));
% %QB=Results.meanGoodQB;
% QB=18.8249;
%numBins=3;
%[histogram, binEdges] = histcounts(data, numBins);

%  L=prctile(data, 25);
%  H=prctile(data, 75);
%  Max=max(data);
%  binEdges=[0, L, H, Max];
 
indicesInBin=[];
binIndices=[];

        if fociResults.numFoci>0 

            All=fociResults.FocalProteinSumIntensity/QB;
            binIndices = cell(1, numBins);
           
                for binIdx = 1:numBins
                     indicesInBin = find(All >binEdges(binIdx) & All <= binEdges(binIdx + 1));
                     binIndices{binIdx} = indicesInBin;
                end

                GoodFociPerCell= extractfield(fociResults.GoodFociPerCell, 'NumberOfFociPerCell');
                BadFociPerCell= extractfield(fociResults.BadFociPerCell, 'NumberOfFociPerCell');
                G={fociResults.GoodFociPerCell.MoleculesPerFocus};
                B={fociResults.BadFociPerCell.MoleculesPerFocus};

for k=1: size(binIndices,2)

 L=[];
 MGood=[];
 MBad=[];
 M_TotG=[];
 M_TotB=[];
 M_GoodPerCell={};
 M_BadPerCell={};
 L_FociFraction=[];
 NoF=[];
 TotProtein=[];

    for L=1:numel(binIndices{k})
        M_GoodPerCell(L)=G(binIndices{k}(L));
        M_BadPerCell(L)=B(binIndices{k}(L));
        NoF(L)=GoodFociPerCell(binIndices{k}(L))+BadFociPerCell(binIndices{k}(L));
        TotProtein(L)=fociResults.FocalProteinSumIntensity(binIndices{k}(L));
    end
                    for c=1:size(M_GoodPerCell,2)
                        M_TotG(c,:)=sum(M_GoodPerCell{1,c})';
                        M_TotB(c,:)=sum(M_BadPerCell{1,c})';
                        MGood=[MGood; M_GoodPerCell{1,c}];
                        MBad=[MBad; M_BadPerCell{1,c}];   

                    end

        L_FociFraction=(M_TotG+M_TotB);
                    

        Results.FociFraction=L_FociFraction;
        Results.MoleculesPerFocusPerCell=[M_GoodPerCell M_BadPerCell];
        Results.MoleculesPerFocus=[MGood; MBad];
        Results.TotProtein=TotProtein/QB;
        Results.FociNumber=NoF;
        BinningResults{k}=Results; 
        Results=[];

end

% Low=BinningResults{1};
% Med=BinningResults{2};
% High=BinningResults{3};
        GoodFociPerCell=[];
        G=[];
        B=[];
        MGood=[];
        MBad=[];
        Results=[];

        else
            disp('Nothing to calculate here')
        end

        
      
     
        

end

                
                
            
            

