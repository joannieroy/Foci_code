% Statistical test 

clear
close all

%% Setting Folders

%matFolder='/Users/grazianamodica/Dropbox (Biophotonics)/Graziana Data/Focus in number/SpIDA Foci/zeo challenge 20012022/Results Number/ResultswithNumberofMolecules';
%matFolder='C:\Users\joann\Dropbox (Biophotonics)\ResultatsProjets\SpIDA 23122021\ResultswithNumberofMolecules_21Jan2022_bb24';
%matFolder='C:\Users\joann\Dropbox (Biophotonics)\ResultatsProjets\SpIDA 23122021\ResultsToGraph\Results_30mar22_11avr22';
matFolder='C:\Users\joann\Dropbox (Biophotonics)\SpiDA 20012022\ResultsToGraph\Results_30mar22';
%matFolder='C:\Users\joann\Dropbox (Biophotonics)\SpIDA siRNA 10022022\ImagingFromJoannie\ResultsToGraph\Results_13avr22';

myFiles=dir(fullfile(matFolder, '*.mat'));
newDirName=['53bp1_stats_' datestr(now, 'yymmdd_HHMMSS')];
mkdir(fullfile(matFolder, newDirName));

%% Setting Parameters

fociNumberList=[];
proteinIntensityList=[];
AllFociSumofIntensityList=[];
AllFociMoleculesPerFocusList=[];

GoodfociIntensityList =[];
%GoodfociNumberList    =[];

BadfociIntensityList  =[];
%BadfociNumberList     =[];

FociMeanIntensityGoodAndBadList     = [];
FociSumIntensityGoodAndBadList      = [];
FociMoleculesPerFocusGoodAndBadList = [];

TotalProteinIntensity = [];

%% Loop to Extract Data
%load the mat file from every file

for k=1:size(myFiles, 1)
    load(fullfile(matFolder, myFiles(k).name));
   
    %fociNumberList=[fociNumberList; ResultsNumber.NumberofFociPerCell ones(numel(ResultsNumber.NumberofFociPerCell), 1)*k];
    %medianNumberOfFoci(k)=median(ResultsNumber.NumberofFociPerCell);
     
    %GoodfociNumberList = [GoodfociNumberList; ResultsNumber.GoodFociPerCell ones(numel(ResultsNumber.GoodFociPerCell), 1)*k];
    %BadfociNumberList  = [BadfociNumberList; ResultsNumber.BadFociPerCell ones(numel(ResultsNumber.BadFociPerCell), 1)*k];

    fociNumberList=[fociNumberList; ResultsNumber.NumberofFociPerCellGoodAndBad ones(numel(ResultsNumber.NumberofFociPerCellGoodAndBad), 1)*k];
    medianNumberOfFoci(k)=median(ResultsNumber.NumberofFociPerCellGoodAndBad);

    FociMeanIntensityGoodAndBadList = [FociMeanIntensityGoodAndBadList; ResultsNumber.FociMeanIntensityGoodAndBad ones(numel(ResultsNumber.FociMeanIntensityGoodAndBad), 1)*k] ; 
    medianFociMeanIntensityGoodAndBadList(k) = median(ResultsNumber.FociMeanIntensityGoodAndBad);
  
    FociSumIntensityGoodAndBadList      = [FociSumIntensityGoodAndBadList; ResultsNumber.FociSumIntensityGoodAndBad ones(numel(ResultsNumber.FociSumIntensityGoodAndBad), 1)*k] ; 
    FociMoleculesPerFocusGoodAndBadList = [FociMoleculesPerFocusGoodAndBadList; ResultsNumber.FociMoleculesPerFocusGoodAndBad ones(numel(ResultsNumber.FociMoleculesPerFocusGoodAndBad), 1)*k] ; 

    TotalProteinIntensity = [TotalProteinIntensity; ResultsNumber.FocalProteinIntensity ones(numel(ResultsNumber.FocalProteinIntensity), 1)*k]

    %GoodfociNumberList=[GoodfociNumberList; ResultsNumber.GoodFociPerCell ones(numel(ResultsNumber.GoodFociPerCell), 1)*k];
    %medianNumberOfGoodFoci(k)=median(ResultsNumber.GoodFociPerCell);
end

%% Removing Abberrant Zeros in the Number of Molecules per Focus
% a zero was added up previous in both good and bad foci list each time a
% cell has no focus. They shouldn't be taken into account. 

NewListMolPerF = []; 
for it = 1:size(FociMoleculesPerFocusGoodAndBadList,1)
if FociMoleculesPerFocusGoodAndBadList(it,1) > 0
   NewListMolPerF =  [NewListMolPerF; FociMoleculesPerFocusGoodAndBadList(it,1),FociMoleculesPerFocusGoodAndBadList(it,2)];
end
end

%% Caculating - Foci Fraction over Nucleoplasmic Fraction

FociFrac = [];
TotaFrac = [];
NucleoplFr = [];
ToPlot = [];

for it = 1:k
FociFrac = [FociFrac sum(FociSumIntensityGoodAndBadList(FociMeanIntensityGoodAndBadList(:,2)==it))];
TotaFrac = [TotaFrac sum(TotalProteinIntensity(TotalProteinIntensity(:,2)==it))];
NucleoplFr = TotaFrac-FociFrac; %nucleoplasmic fraction
end

% with condition 5000ug/ml
%FociFrac = [FociFrac(1)+FociFrac(2) FociFrac(3) FociFrac(4) FociFrac(5) FociFrac(6) FociFrac(7) FociFrac(8) FociFrac(9)]; % combines the two untreated conditions
%TotaFrac = [TotaFrac(1)+TotaFrac(2) TotaFrac(3) TotaFrac(4) TotaFrac(5) TotaFrac(6) TotaFrac(7) TotaFrac(8) TotaFrac(9)] ;% combines the two untreated conditions

% without condition 5000ug/ml
FociFrac = [FociFrac(1)+FociFrac(2) FociFrac(3) FociFrac(4) FociFrac(5) FociFrac(6) FociFrac(7) FociFrac(8) ]; % combines the two untreated conditions
TotaFrac = [TotaFrac(1)+TotaFrac(2) TotaFrac(3) TotaFrac(4) TotaFrac(5) TotaFrac(6) TotaFrac(7) TotaFrac(8) ] ;% combines the two untreated conditions

% siRNA 
%FociFrac = [FociFrac(1) FociFrac(2) FociFrac(3) FociFrac(4) FociFrac(5) FociFrac(6) FociFrac(7) FociFrac(8) FociFrac(9) FociFrac(10) FociFrac(11) ]; % combines the two untreated conditions
%TotaFrac = [TotaFrac(1) TotaFrac(2) TotaFrac(3) TotaFrac(4) TotaFrac(5) TotaFrac(6) TotaFrac(7) TotaFrac(8) TotaFrac(9) TotaFrac(10) TotaFrac(11)] ;% combines the two untreated conditions

NucleoplFr = TotaFrac-FociFrac;

ToPlot = [NucleoplFr'./TotaFrac', FociFrac'./TotaFrac'];

%% Stats - Number of foci per cell.

%fociNumberList
y = fociNumberList(:,1)';
group = fociNumberList(:,2)';
[p,tbl,stats] = anova1(y,group);
stats

results = multcompare(stats);
tbl = array2table(results,"VariableNames", ...
    ["Group A","Group B","Lower Limit","A-B","Upper Limit","P-value"])

pKK1 = kruskalwallis(y,group,'off')

%% Stats - Total protein

y = TotalProteinIntensity(:,1)';
group = TotalProteinIntensity(:,2)';
[p,tbl,stats] = anova1(y,group);
stats

results = multcompare(stats);
tbl = array2table(results,"VariableNames", ...
    ["Group A","Group B","Lower Limit","A-B","Upper Limit","P-value"])

pKK2 = kruskalwallis(y,group,'off')

%% Stats - Number of Molecules per focus

y = NewListMolPerF(:,1)';
group = NewListMolPerF(:,2)';
[p,tbl,stats] = anova1(y,group);
stats

results = multcompare(stats);
tbl = array2table(results,"VariableNames", ...
    ["Group A","Group B","Lower Limit","A-B","Upper Limit","P-value"])

pKK3 = kruskalwallis(y,group,'off')
