function ResultsNumber=getTheNumbersSpiDA(varargin)

if nargin==2
    myFolder=varargin{1};
    myNumberFile=varargin{2};

else
    myFolder='/Users/grazianamodica/Desktop/GFPBRCA1_53BP1/Zeo_500/53BP1_ColocResults_Coloc';
    myNumberFile='*Coloc.mat';
end



masterFolder=fullfile(myFolder, 'Numbers');

myFiles=dir(fullfile(masterFolder, myNumberFile));
myFiles = {myFiles.name};

NumberofFociPerCell=[];
NumberofFociPerCellGoodAndBad=[];
fociIndividualMeanIntensity=[];
NumberofFoci=[];
cellWithFoci=[];
fociPeakIntensity=[];
FocalProteinIntensity=[];

GoodFociPerCell=[];
GoodFociMeanIntensity=[];
GoodFociSumIntensity=[];
GoodFociMoleculesPerFocus=[];

BadFociPerCell=[];
BadFociMeanIntensity=[];
BadFociSumIntensity=[];
BadFociMoleculesPerFocus=[];


for itFile=1:size(myFiles,2)
    
    disp(['...' masterFolder filesep myFiles{itFile}]);
    load(fullfile(masterFolder, myFiles{itFile}));
    %The coloc analysis calls the ResultsFile ColocFociResults so I need a line
    %here
        fociResults=ColocFociResults;
    
    if fociResults.cellWithFoci
%            NumberofFociPerCell= [NumberofFociPerCell fociResults.fociPerCell]; 
    NumberofFociPerCell= [NumberofFociPerCell fociResults.eachCell];
    
    %GoodFociPerCellIt       = extractfield(fociResults.GoodFociPerCell, 'NumberOfFociPerCell');
    %BadFociPerCellIt        = extractfield(fociResults.BadFociPerCell, 'NumberOfFociPerCell');
    %NumberofFociPerCellIt   = GoodFociPerCellIt+BadFociPerCellIt;
    %NumberofFociPerCellGoodAndBad = [NumberofFociPerCellGoodAndBad NumberofFociPerCellIt];
    
    fociPeakIntensity= [fociPeakIntensity fociResults.peakIntensities'];
    NumberofFoci=[NumberofFoci fociResults.numFoci];
    cellWithFoci=[cellWithFoci fociResults.cellWithFoci];
    %fociIndividualMeanIntensity=[fociIndividualMeanIntensity fociResults.fociIndividualMeanIntensity];

    NumberofCellMore10=[NumberofCellMore10 (find (fociResults.eachCell>10))];
    NumberofCellMore5=[NumberofCellMore5 (find (fociResults.eachCell>5))];



    FocalProteinIntensity=[FocalProteinIntensity fociResults.FocalProteinSumIntensity];

            if isfield(fociResults, 'GoodFociMeanIntensity')
                
                GoodFociMeanIntensity=[GoodFociMeanIntensity fociResults.GoodFociMeanIntensity'];
                GoodFociSumIntensity=[GoodFociSumIntensity fociResults.GoodFociSumIntensity'];
                GoodFociMoleculesPerFocus=[GoodFociMoleculesPerFocus fociResults.GoodFociMolPerFocus'];
                GoodFociPerCell=[GoodFociPerCell extractfield(fociResults.GoodFociPerCell, 'NumberOfFociPerCell')];

                BadFociMeanIntensity=[BadFociMeanIntensity fociResults.BadFociMeanIntensity'];
                BadFociSumIntensity=[BadFociSumIntensity fociResults.BadFociSumIntensity'];
                BadFociMoleculesPerFocus=[BadFociMoleculesPerFocus fociResults.BadFociMolPerFocus'];
                BadFociPerCell=[BadFociPerCell extractfield(fociResults.BadFociPerCell, 'NumberOfFociPerCell')];
            else
                FociMeanIntensity=[FociMeanIntensity fociResults.FociMeanIntensity];
                FociSumIntensity=[FociSumIntensity fociResults.FociSumIntensity];
                FociMoleculesPerFocus=[FociMoleculesPerFocus fociResults.FociMolPerFocus];
            end

            FociMeanIntensityGoodAndBad     = [GoodFociMeanIntensity BadFociMeanIntensity]; 
            FociSumIntensityGoodAndBad      = [GoodFociSumIntensity  BadFociSumIntensity];
            FociMoleculesPerFocusGoodAndBad = [GoodFociMoleculesPerFocus BadFociMoleculesPerFocus];
    else
        disp('No cell here')
    end
 
end

if size(myFiles,2)>0
    ResultsNumber.NumberofFoci=NumberofFoci';
    ResultsNumber.CellwithFoci=cellWithFoci';
    ResultsNumber.NumberofFociPerCell=NumberofFociPerCell';
    ResultsNumber.NumberofFociPerCellGoodAndBad=NumberofFociPerCellGoodAndBad';
    ResultsNumber.FociMeanIntensityGoodAndBad = FociMeanIntensityGoodAndBad';
    ResultsNumber.FociSumIntensityGoodAndBad  = FociSumIntensityGoodAndBad';
    ResultsNumber.FociMoleculesPerFocusGoodAndBad = FociMoleculesPerFocusGoodAndBad';
    ResultsNumber.FocalProteinIntensity = FocalProteinIntensity';
    ResultsNumber.NumberofCellMore10=NumberofCellMore10';
    ResultsNumber.NumberofCellMore5=NumberofCellMore5';
else
    ResultsNumber = [];
end

 if exist('GoodFociMeanIntensity')
     ResultsNumber.GoodFociMeanIntensity=GoodFociMeanIntensity';
     ResultsNumber.GoodFociSumIntensity= GoodFociSumIntensity';
     ResultsNumber.GoodFociMoleculesPerFocus=GoodFociMoleculesPerFocus';
     ResultsNumber.GoodFociPerCell=GoodFociPerCell';
     ResultsNumber.BadFociMeanIntensity=BadFociMeanIntensity';
     ResultsNumber.BadFociSumIntensity= BadFociSumIntensity';
     ResultsNumber.BadFociMoleculesPerFocus=BadFociMoleculesPerFocus';
     ResultsNumber.BadFociPerCell=BadFociPerCell';
 else
    ResultsNumber.FociMeanIntensity=FociMeanIntensity';
    ResultsNumber.FociSumIntensity= FociSumIntensity';
    ResultsNumber.FociMoleculesPerFocus=FociMoleculesPerFocus';
 end
%ResultsNumber.fociPeakIntensity=fociPeakIntensity';
%ResultsNumber.FociIndividualMeanIntensity=fociIndividualMeanIntensity';
%ResultsNumber.DAPITotIntensity= DAPITotIntensity';
%ResultsNumber.DAPIAverageIntensity= DAPIAverageIntensity';
%ResultsNumber.fociSumIndividualIntensity=fociSumIndividualIntensity';


%ResultsNumber.FocalProteinIntensity=FocalProteinIntensity';

% save('/Users/grazianamodica/Dropbox (Biophotonics)/Foci project/U2OS HW zeocine dose response 53bp1 rad51/100X/Zeocin_0pt1ug _53BP1_ResultstoPlot_NumberofFoci.mat', 'NumberofFoci');
% save('/Users/grazianamodica/Dropbox (Biophotonics)/Foci project/U2OS HW zeocine dose response 53bp1 rad51/100X/Zeocin_0pt1ug _53BP1_ResultstoPlot_NumberofFociPerCell.mat', 'NumberofFociPerCell' );
% save('/Users/grazianamodica/Dropbox (Biophotonics)/Foci project/U2OS HW zeocine dose response 53bp1 rad51/100X/Zeocin_0pt1ug _53BP1_ResultstoPlot_CellWithFoci.mat', 'cellWithFoci');
% save('/Users/grazianamodica/Dropbox (Biophotonics)/Foci project/U2OS HW zeocine dose response 53bp1 rad51/100X/Zeocin_0pt1ug _53BP1_ResultstoPlot_fociPeakIntensity.mat', 'fociPeakIntensity');
% save('/Users/grazianamodica/Dropbox (Biophotonics)/Foci project/U2OS HW zeocine dose response 53bp1 rad51/100XZeocin_0pt1ug _53BP1_ResultstoPlot_DAPITotIntensity.mat', 'DAPITotIntensity');

% save('/Users/grazianamodica/Dropbox (Biophotonics)/Foci project/zeocin dose response/Plot/Zeocin_100ug _ResultstoPlot.mat', 'NumberofFoci', 'fociPeakIntensity', 'NumberofFociPerCell', 'cellWithFoci'  );

 %save(fullfile(myFolder, 'FolderResultsH2AX.mat'), 'ResultsNumber');
end
 
 
 
 
 
 
