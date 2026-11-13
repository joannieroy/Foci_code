clear all
close all

%masterFolder='/Users/grazianamodica/Desktop/images';
%masterFolder='/Users/grazianamodica/Biophotonics Dropbox/Graziana Modica/Graziana Data/SpIDAing/SpIDA_Data_Curated/Graziana/Challenge_data_analysis/SpIDA 20012022_53BP1GFP_ZeoChallenge/FociAnalysis';
%masterFolder='/Users/grazianamodica/Biophotonics Dropbox/Graziana Modica/Graziana Data/SpIDAing/SpIDA_Data_Curated/Graziana/SpIDA_St1_07Dec2022/FociAnalysis/Anti53BP1_Alexa546';
%masterFolder='/Users/grazianamodica/Biophotonics Dropbox/Graziana Modica/Graziana Data/SpIDA figures/17May2023 546/foci';
%masterFolder='/Users/grazianamodica/Biophotonics Dropbox/Graziana Modica/Graziana Data/SpIDA figures/17May2023 647/foci analysis';

%masterFolder='/Users/grazianamodica/Biophotonics Dropbox/Graziana Modica/Graziana Data/SpIDAing/SpIDA_Data_Curated/Graziana/Challenge_data_analysis/SpIDA 20012022_53BP1GFP_ZeoChallenge/FociAnalysis';
%masterFolder='/Users/grazianamodica/Biophotonics Dropbox/Graziana Modica/Graziana Data/SpIDAing/SpIDA_Data_Curated/Graziana/Challenge_data_analysis/SpIDA 26092022_53BP1GFP_ZeoChallenge/FociAnalysis/FociAnalysis';
%masterFolder='/Users/grazianamodica/Biophotonics Dropbox/Graziana Modica/Graziana Data/SpIDA figures/siRNA/siRNA 26052023/FociAnalysis';

newDir='GFP_DistributionResults_July_01';
%newDir='Alexa_DistributionResults';
mkdir(fullfile(masterFolder, newDir));

myNumberFile='*tif.mat';

myList=dir(masterFolder);
isub = [myList(:).isdir]; %# returns logical vector
folderNames = {myList(isub).name}';
folderNames(ismember(folderNames,{'.','..'})) = []; 

theseFolders=string(vertcat(char(folderNames)));
regMatches=regexpi(theseFolders, 'Zeo*', 'match');
DataFolderList=find(~cellfun(@isempty, regMatches));
NewFolderNames=folderNames(DataFolderList);

load(fullfile(masterFolder,"GFP_QBResults_July.mat"));
%load(fullfile(masterFolder,"HA_QBResults.mat"));
QB=Results.meanGoodQB;

%QB=4.2180;

for it=1:size(NewFolderNames, 1)
    

    [masterFolder '/' NewFolderNames{it}];
   %thisFolder=[masterFolder '/' NewFolderNames{it} '/' '53BP1GFP_Results' '/' 'Numbers'];

    thisFolder=[masterFolder '/' NewFolderNames{it} '/' 'New53BP1_Results' '/' 'Numbers'];

    %thisFolder=[masterFolder '/' NewFolderNames{it} '/' 'Alexa54653BP1_Results' '/' 'Numbers'];

    %thisFolder=[masterFolder '/' NewFolderNames{it} '/' 'Alexa64753BP1_Results' '/' 'Numbers'];
    
    myFiles=dir(fullfile(thisFolder, myNumberFile));
    myFiles = {myFiles.name};
    
    TotalProtein=[];
    
    NumGood=[];
    NumBad=[];
    NumFoci=[];
    SumOfIntensity=[];
    
    MolGood=[];
    MolBad=[];
    FociFraction=[];

    GoodFpC=[];
    BadFpC=[];
    AllFociNumber=[];
    
    for itFile=1:size(myFiles,2)

       load(fullfile(thisFolder, myFiles{itFile}));

        if fociResults.numCells>0
           TotalProtein=[TotalProtein (fociResults.FocalProteinSumIntensity/QB)];

              if fociResults.numFoci>0 


                Intensity=[fociResults.GoodFociSumIntensity' fociResults.BadFociSumIntensity'];
                SumOfIntensity=[SumOfIntensity Intensity];
                

                GoodFociPerCell= extractfield(fociResults.GoodFociPerCell, 'NumberOfFociPerCell');
                BadFociPerCell= extractfield(fociResults.BadFociPerCell, 'NumberOfFociPerCell');
                NumberofFoci=GoodFociPerCell+BadFociPerCell;
                
                GoodFpC=[GoodFpC GoodFociPerCell];
                BadFpC=[BadFpC BadFociPerCell];
                AllFociNumber=[AllFociNumber NumberofFoci ];

                %GoodFociPerCellMoleules=extractfield(fociResults.GoodFociPerCell, 'MoleculesPerFocus');
                %BadFociPerCellMoleules=extractfield(fociResults.BadFociPerCell, 'MoleculesPerFocus');

                G={fociResults.GoodFociPerCell.MoleculesPerFocus}';
                B={fociResults.BadFociPerCell.MoleculesPerFocus}';
                
                    for c=1:size(G,1)
                        TotG(c,:)=sum(G{c,1})';
                        TotB(c,:)=sum(B{c,1})';
                    end

                MolGood=[MolGood TotG'];
                MolBad=[MolBad TotB'];
                FociFraction=[FociFraction (TotG+TotB)'];
                   %FociFraction=[FociFraction fociResults.PerCellFociSumFociIntensity];
              else 
                   FociFraction=[FociFraction, (fociResults.FocalProteinSumIntensity)*0];
                   MolGood=[MolGood];
                   MolBad=[MolBad];
              end
              G=[];
              B=[];
              TotB=[];
              TotG=[];
              Intensity=[];

%                resultTbl=table( GoodFociPerCell, BadFociPerCell, NumberofFoci, TotG, TotB, FociFraction',BB_R.nVal', 'VariableNames', {'GoodFoci', 'BadFoci', 'Tot', '# MolGodFoci',...
%                    '# Mol Bad Foci', "Molecules Foci Fraction"});
%                writetable(resultTbl,fullfile(masterFolder, 'Table', 'BoxInfo.xls'));


               %MeanSumIntensityTotalProtein(itFile)=mean2(fociResults.FocalProteinSumIntensity);
              
%                if fociResults.numFoci>0
%                    MeanSumIntensityALLFoci(itFile)=mean2(fociResults.PerCellFociSumFociIntensity);
%                    MeanNucleoplasmicProtein(itFile)=mean2(fociResults.FocalProteinSumIntensity-fociResults.PerCellFociSumFociIntensity);
%                else
%                    MeanSumIntensityALLFoci(itFile)=0;
%                    MeanNucleoplasmicProtein(itFile)=mean2(fociResults.FocalProteinSumIntensity)
%                end
        else
            display('no cells  here')
        end

    end

   DistributionResults.Tot=TotalProtein;
   DistributionResults.FociFraction=FociFraction;
   DistributionResults.NucleoplasmicFraction=(TotalProtein - FociFraction);
   DistributionResults.FociNumber=AllFociNumber;
   
   DistributionResults.NormFociFraction=((FociFraction)./TotalProtein);
   DistributionResults.NormNuclFraction=((DistributionResults.NucleoplasmicFraction)./TotalProtein);

   DistributionResults.MeanTot=mean2(DistributionResults.Tot);
   DistributionResults.MeanFociFraction=mean2(DistributionResults.FociFraction);
   DistributionResults.MeanNucleoplasmicFraction=mean2(DistributionResults.NucleoplasmicFraction);
   DistributionResults.SumOfIntensity=SumOfIntensity;

   %DistributionResults.MeanTotalPerImage=MeanSumIntensityTotalProtein;
   %DistributionResults.MeanFociFractionPerImage=MeanSumIntensityALLFoci;
   %DistributionResults.MeanNucleoplasmicProteinPerImage=MeanNucleoplasmicProtein;

   %VariableNames={'GoodFoci', 'BadFoci', 'Tot', '# MolGoodFoci',...
                   %'# Mol Bad Foci', 'Molecules Foci Fraction', 'Nucleoplasmic Fraction', 'TotMolecules'};

   save(fullfile(masterFolder, newDir, [NewFolderNames{it} '_53BP1_Distribution.mat']), 'DistributionResults' );
   resultTbl=table( GoodFpC', BadFpC', AllFociNumber', MolGood', MolBad', FociFraction', DistributionResults.NucleoplasmicFraction', TotalProtein', DistributionResults.NormFociFraction', DistributionResults.NormNuclFraction', 'VariableNames', {'GoodFoci', 'BadFoci', 'Tot', '# MolGoodFoci',...
                   '# Mol Bad Foci', 'Molecules Foci Fraction', 'Nucleoplasmic Fraction', 'TotMolecules', 'NormFociFraction', 'NormNuclFraction'});
   writetable(resultTbl, fullfile(masterFolder, newDir, [NewFolderNames{it} '_DistributionInfo.xls']));
  
   FF=DistributionResults.NormFociFraction;
   NF=DistributionResults.NormNuclFraction;

   resultTbl2=table(FF', NF', 'VariableNames', {'Foci Fraction', 'Nucleoplasmic Fraction'});
   transposed=rows2vars(resultTbl2);
   save(fullfile(masterFolder, newDir, [NewFolderNames{it} '_FocivsNucl.mat']), 'transposed'); 
 
   IntensityPerFocus=nonzeros(SumOfIntensity);
   resultTbl3=table(IntensityPerFocus, 'VariableNames', {'SumOfIntensity'});
   save(fullfile(masterFolder, newDir, [NewFolderNames{it} '_SumofIntensity.mat']), 'resultTbl3'); 
   writetable(resultTbl3, fullfile(masterFolder, newDir, [NewFolderNames{it} '_SumOfIntensity.xls']));
  
   %x=nonzeros(AllFociNumber);
   %y=nonzeros(DistributionResults.NormFociFraction);

   y=nonzeros(AllFociNumber);
   x=nonzeros(DistributionResults.NormFociFraction);


   coeff(it,:)=polyfit(x,y,1);
   y_pred=polyval(coeff(it,:), x);
   SST = sum((y - mean(y)).^2);
   SSE = sum((y - y_pred).^2);
   R2 = 1 - (SSE / SST);
   %save(fullfile(masterFolder, newDir, 'ZeoChallenge_53BP1_Coeff.mat'), 'coeff' );
    
   figure
    plot(x,y, 'o');
    hold on
    plot(x, polyval(coeff(it, :), x), 'r-' )
    
%     xlabel('Number of Foci');
%     ylabel('FociFraction');
%     ylim([0 1]);
%     xlim([0 40]);

    ylabel('Number of Foci');
    xlabel('FociFraction');
    xlim([0 1]);
    ylim([0 40]);


    %text(30, 0.9, ['slope= ' num2str(coeff(it,1)) newline 'R2=' num2str(R2)], 'Color', 'k', 'FontSize', 14);
    text(0.9,30, ['slope= ' num2str(coeff(it,1)) newline 'R2=' num2str(R2)], 'Color', 'k', 'FontSize', 14);
    saveas(gcf, fullfile(masterFolder,newDir, [NewFolderNames{it} '_focifraction vs numbers.jpg']));

end
save(fullfile(masterFolder, newDir, 'ZeoChallenge_53BP1_Coeff.mat'), 'coeff' );


