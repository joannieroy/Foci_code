 clear 'all'
 close 'all'

%% loop through folders and do the full analysis
%masterFolder='/Users/grazianamodica/Biophotonics Dropbox/Graziana Modica/Graziana Data/Nuclear biomechanics/experiments/PC3/IR/11Dec2025_2GY';
%masterFolder='C:\Users\joann\OneDrive - Sante et Services sociaux\Christos\Data\DNAdamage_IF\Good_Replicates\532nmPulsed_Laser\20260722_H_532nm_24h\analysis\647_H2AX_trialRun';
masterFolder='C:\Users\joann\OneDrive - Sante et Services sociaux\Christos\Data\DNAdamage_IF\Good_Replicates\2umCW_Laser\20260901_H_2um_4h_H2AX_53PB1\Printed';

myList=dir(masterFolder);
isub = [myList(:).isdir]; %# returns logical vector
folderNames = {myList(isub).name}';
folderNames(ismember(folderNames,{'.','..'})) = [];

QB=1;

theseFolders=string(vertcat(char(folderNames)));

% regMatches=regexpi(theseFolders, 'Zeo', 'match');
%regMatches=regexpi(theseFolders, 'IR', 'match');
regMatches=regexpi(theseFolders, 'tiff_export', 'match');


DataFolderList=find(~cellfun(@isempty, regMatches));
NewFolderNames=folderNames(DataFolderList);
% NewFolderNames=folderNames;

    fociSettings.pixelSizeUm = 0.1;    
    fociSettings.contrast=5; % how many times birighther than the sorrounding after the bandpass filter
    %fociSettings.radius=3; %for the 60X images
    fociSettings.radius=round(1.04/fociSettings.pixelSizeUm);
    %fociSettings.noiseSize=2.5; %for the 60X images
    fociSettings.noiseSize=(0.13/fociSettings.pixelSizeUm);
    fociSettings.saveImages=true;
    fociSettings.insideCells=true; % only count foci inside nuclei?
    fociSettings.discardBigCells=true;
    fociSettings.FolderName='results';
    
    fociSettings.oneMultiColor=false;
    fociSettings.dapiChannel=4;
    fociSettings.fociChannel=1;
    fociSettings.dapiRegExp='*T4.tif';
    fociSettings.fociRegExp='*T1.tif';
    fociSettings.imageRegExp='*.tif';
    fociSettings.hasDapi=false;
    fociSettings.deadPixels=true;
    fociSettings.saturationfilter=true;
    fociSettings.maxsaturation=0.1 ;

    fociSettings.fociFit=true;
    fociSettings.fitRegionFactor=3; %gaussian fits are made on ROIs x times larger than the radius
    fociSettings.fitSaturationTh=.2; %max percentage of pixels of the fitting ROI that can be saturated
    fociSettings.fitMinRSquare=.9;
    fociSettings.finMinInclusionRSquare=0.6;

    dapiSettings.pixelSizeUm = 0.1; % um/px (Zeiss CB)
    dapiSettings.oneMultiColor = false; % this must be true if cells will be segmented based on the foci image, with not dapi
    dapiSettings.hasDapi=false; 
    dapiSettings.discardBigCells=true;
    dapiSettings.isYeast=false;
    dapiSettings.estimatedSize=round(2000/dapiSettings.pixelSizeUm); %estimated size of a typical cell in pixels
    dapiSettings.minSolidity=.7; %objects with solidity lower than this get discarded
    dapiSettings.minIntensityFactor=3; % n times the STD of the backround. This gets rid of weird objects from large empty zones found with dapative thrshohold.
    dapiSettings.adaptive=false;
    dapiSettings.active=true;
    dapiSettings.maxGluedCells=15; %if an object is larger than maxGluedCells*cellArea it is simply discarded. This number is not in pixel. 



for it=1:size(NewFolderNames, 1)
% for it=1
    [masterFolder filesep NewFolderNames{it}]
    analyzeThisFolder([masterFolder filesep NewFolderNames{it}], fociSettings, QB, dapiSettings);

end

%masterFolder);

disp 'Finally over! Time to check the results'