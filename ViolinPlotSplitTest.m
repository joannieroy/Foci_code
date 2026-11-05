clear all

% 07 FEb 2023 GM. 
% to make split violin plots. It needs to load to files
% (one for each side of the graph) with the lists to plot


%% Figure 4 - Molecule per focus 
% this list excludes abberant zeros added to the list each time a cell has
% no focus for both good and bad focus 
matFolder='/Users/grazianamodica/Biophotonics Dropbox/Graziana Modica/Graziana Data/SpIDAing/SpIDA_Data_Curated/SpiDA_St1_09Nov2022/FociAnalysis';
%load('/Users/grazianamodica/Biophotonics Dropbox/Graziana Modica/Graziana Data/SpIDAing/SpIDA_Data_Curated/SpiDA_St1_09Nov2022/FociAnalysis/53BP1GFP/Anti53BP1_Alexa647/ResultstoGraphs_Alexa53BP1/GFP53BP1_graphs_230207_204041/AlexagraphNumbers.mat');
%load('/Users/grazianamodica/Biophotonics Dropbox/Graziana Modica/Graziana Data/SpIDAing/SpIDA_Data_Curated/SpiDA_St1_09Nov2022/FociAnalysis/53BP1GFP/53BP1GFP/ResultsToGraphs_GFP53BP1/GFP53BP1_graphs_230207_202016/graphNumbers.mat');


load('/Users/grazianamodica/Desktop/GFPBRCA1_53BP1/53bp1/ResultsToGraph_Col53BP1GFP/Coloc_53BP1_graphs_230208_152316/Coloc_graphNumbers.mat');
load('/Users/grazianamodica/Desktop/GFPBRCA1_53BP1/53bp1/ResultsToGraph_NotCol53BP1GFP/NotColoc_53BP1_graphs_230208_152125/NotColoc_graphNumbers.mat');

NewListMolPerF=Coloc_53bp1_PlotResults.NewListMolPerF;
AlexaNewListMolPerF=NotColoc_53bp1_PlotResults.NewListMolPerF;

NewListSumIntensity=Coloc_53bp1_PlotResults.NewListSumIntensity;
AlexaNewListSumIntensity=NotColoc_53bp1_PlotResults.NewListSumIntensity;

figure(),
h = al_goodplot(NewListMolPerF(NewListMolPerF(:,2)==1,1),1,[],[1 0 0],'left',[],[],[]);
h = al_goodplot(AlexaNewListMolPerF(AlexaNewListMolPerF(:,2)==1,1),1,[],[0	0	1],'right',[],[],[]);
h = al_goodplot(NewListMolPerF(NewListMolPerF(:,2)==2,1),2,[],[1 0 0],'left',[],[],[]);
h = al_goodplot(AlexaNewListMolPerF(AlexaNewListMolPerF(:,2)==2,1),2,[],[0	0	1],'right',[],[],[]);
% h = al_goodplot(NewListMolPerF(NewListMolPerF(:,2)==3,1),3,[],[0 1 0],'left',[],[],[]);
% h = al_goodplot(AlexaNewListMolPerF(AlexaNewListMolPerF(:,2)==3,1),3,[],[1 0 1],'right',[],[],[]);

hold on
xticks([1 2])
%xticks([1 2 3])

%yticks([1:10:30])
%set(gca, 'XtickLabel', {'0', '500', '5000'}, 'FontSize', 18); 
set(gca, 'XtickLabel', {'0', '500'}, 'FontSize', 14); 
%set(gca,'XTickLabelRotation',45)

%title('Number of molecules per focus')
ax = gca;
%ax.YLim = [0 5000]; %20012022
ax.YLim = [0 5000]; %23122021
%xlabel('Zeocin (ug/mL)');
%ylabel('Molecules Per Focus', 'FontSize', 18);
legend('Coloc','Not Coloc', 'Location','northeast');
saveas(gcf, fullfile(matFolder, 'ViolinBoxplot 53pb1 NumberOfMolPerFocusN'));
print(gcf, fullfile(matFolder, 'ViolinBoxplot 53pb1 NumberOfMolPerFocusN'),'-djpeg','-r0');



%% Figure 2 Sum of intensities 

figure(),

h = al_goodplot(NewListSumIntensity(NewListSumIntensity(:,2)==1,1),1,[],[1 0 0],'left',[],[],[]);
h = al_goodplot(AlexaNewListSumIntensity(AlexaNewListSumIntensity(:,2)==1,1),1,[],[0	0	1],'right',[],[],[]);
h = al_goodplot(NewListSumIntensity(NewListSumIntensity(:,2)==2,1),2,[],[1 0 0],'left',[],[],[]);
h = al_goodplot(AlexaNewListSumIntensity(AlexaNewListSumIntensity(:,2)==2,1),2,[],[0	0	1],'right',[],[],[]);
%h = al_goodplot(NewListSumIntensity(NewListSumIntensity(:,2)==3,1),3,[],[0 1 0],'left',[],[],[]);
%h = al_goodplot(AlexaNewListSumIntensity(AlexaNewListSumIntensity(:,2)==3,1),3,[],[1 0 1],'right',[],[],[]);

%al_goodplot(x, pos, boxw, col, type, bw, p, jitw)

hold on
xticks([1 2])
%xticks([1 2 3])


%set(gca, 'XtickLabel', {'0', '500', '5000'}, 'FontSize', 18); 
set(gca, 'XtickLabel', {'0', '500'}, 'FontSize', 18); 
%set(gca,'XTickLabelRotation',45)

%title('Sum of intensity per focus')
ax = gca;
%ax.YLim = [0 5000]; %20012022
ax.YLim = [0 100000]; %23122021
%xlabel('Zeocin (ug/mL)');
%ylabel('Intensity Per Focus', 'FontSize', 18);
legend('Coloc','Not Coloc', 'Location','northeast');
saveas(gcf, fullfile(matFolder, 'ViolinBoxplot  SumOfIntensityPerFocusN'));
print(gcf, fullfile(matFolder, 'ViolinBoxplot  SumOfIntensityPerFocusN'),'-djpeg','-r0');
